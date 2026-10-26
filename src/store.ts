import { defineStore } from 'pinia'
import { ref } from 'vue'
import { SEED_QUIZZES } from './data'
import { supabase, SUPABASE_ENABLED } from './lib/supabase'
export type { Option, Question, Quiz, AttemptResult, Attempt } from './types'
import type { Option, Question, Quiz, AttemptResult, Attempt } from './types'

export function newId(): string {
  return crypto.randomUUID()
}

function shuffle<T>(arr: T[]): T[] {
  const a = [...arr]
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]]
  }
  return a
}

export function drawQuestions(quiz: Quiz): Question[] {
  const n = quiz.questionsPerExam
  const ordered = quiz.questions
    .filter(q => q.fixedPosition !== null && q.fixedPosition <= n)
    .sort((a, b) => (a.fixedPosition ?? 0) - (b.fixedPosition ?? 0))
  const pinned  = shuffle(quiz.questions.filter(q => q.fixedPosition === null && q.isPinned))
  const random  = shuffle(quiz.questions.filter(q => q.fixedPosition === null && !q.isPinned))
  const slots: (Question | null)[] = Array(n).fill(null)
  for (const q of ordered) slots[(q.fixedPosition ?? 1) - 1] = q
  const pool = [...pinned, ...random]
  for (let i = 0; i < n; i++) {
    if (!slots[i]) slots[i] = pool.shift() ?? null
  }
  return slots.filter(Boolean) as Question[]
}

// ── Local / localStorage fallback ──────────────────────────
const SEED_VERSION = '2'

function localLoad(): Quiz[] {
  try {
    if (localStorage.getItem('qs_seed_v') !== SEED_VERSION) {
      localStorage.removeItem('qs_quizzes')
      localStorage.setItem('qs_seed_v', SEED_VERSION)
    }
    const raw = localStorage.getItem('qs_quizzes')
    if (raw) return JSON.parse(raw) as Quiz[]
  } catch { /* ignore */ }
  return JSON.parse(JSON.stringify(SEED_QUIZZES)) as Quiz[]
}

function localPersist(list: Quiz[]) {
  localStorage.setItem('qs_quizzes', JSON.stringify(list))
}

// ── Supabase row mappers (snake_case → camelCase) ───────────
type DbRow = Record<string, unknown>

function mapOption(r: DbRow): Option {
  return { id: r.id as string, label: r.label as string, isCorrect: (r.is_correct as boolean) ?? false }
}

function mapQuestion(r: DbRow): Question {
  return {
    id: r.id as string,
    prompt: r.prompt as string,
    explanation: (r.explanation as string) ?? '',
    isPinned: (r.is_pinned as boolean) ?? false,
    fixedPosition: (r.fixed_position as number | null) ?? null,
    options: ((r.options as DbRow[]) ?? []).map(mapOption),
  }
}

function mapQuiz(r: DbRow): Quiz {
  return {
    id: r.id as string,
    title: r.title as string,
    entity: (r.entity as string) ?? '',
    timeLimitMinutes: (r.time_limit_minutes as number) ?? 15,
    questionsPerExam: (r.questions_per_exam as number) ?? 10,
    pointsPerQuestion: (r.points_per_question as number) ?? 1,
    passingScore: (r.passing_score as number) ?? 1,
    published: (r.published as boolean) ?? false,
    questions: ((r.questions as DbRow[]) ?? []).map(mapQuestion),
  }
}

// ── Store ───────────────────────────────────────────────────
export const useAppStore = defineStore('app', () => {
  const quizzes     = ref<Quiz[]>([])
  const currentUser = ref<string | null>(null)
  const isAdmin     = ref(false)
  const attempt     = ref<Attempt | null>(null)
  const loading     = ref(false)
  const dbError     = ref<string | null>(null)

  async function reloadQuizzes() {
    const { data, error } = await supabase.from('quizzes').select(`
      id, title, entity, time_limit_minutes, questions_per_exam,
      points_per_question, passing_score, published,
      questions:questions (
        id, prompt, explanation, is_pinned, fixed_position,
        options:options (id, label, is_correct, position)
      )
    `).order('created_at')
    if (error) throw error
    quizzes.value = (data ?? []).map(r => mapQuiz(r as DbRow))
  }

  // Called once in main.ts
  async function init() {
    if (SUPABASE_ENABLED) {
      loading.value = true
      dbError.value = null
      try {
        // Restore previous session (admin refreshed the page)
        const { data: { session } } = await supabase.auth.getSession()
        if (session) {
          const { data: profile } = await supabase
            .from('profiles').select('role, username').eq('id', session.user.id).single()
          if (profile?.role === 'admin') {
            currentUser.value = (profile.username as string) || session.user.email || 'Admin'
            isAdmin.value = true
          }
        }
        await reloadQuizzes()
      } catch (e) {
        dbError.value = String(e)
        quizzes.value = localLoad()
      } finally {
        loading.value = false
      }
    } else {
      quizzes.value = localLoad()
    }
  }

  function login(username: string, admin: boolean) {
    currentUser.value = username
    isAdmin.value = admin
  }

  async function adminLogin(emailOrUser: string, password: string): Promise<string | null> {
    if (!SUPABASE_ENABLED) {
      if (emailOrUser.toLowerCase() !== 'admin') return 'Tu cuenta no tiene rol de administrador.'
      login(emailOrUser, true)
      return null
    }
    const { data, error } = await supabase.auth.signInWithPassword({ email: emailOrUser, password })
    if (error) return error.message
    const { data: profile } = await supabase
      .from('profiles').select('role, username').eq('id', data.user.id).single()
    if (!profile || (profile.role as string) !== 'admin') {
      await supabase.auth.signOut()
      return 'Tu cuenta no tiene rol de administrador. Contacta al administrador del sistema.'
    }
    currentUser.value = (profile.username as string) || emailOrUser
    isAdmin.value = true
    try { await reloadQuizzes() } catch { /* keeps whatever is already loaded */ }
    return null
  }

  async function logout() {
    if (SUPABASE_ENABLED) await supabase.auth.signOut().catch(() => null)
    currentUser.value = null
    isAdmin.value = false
    attempt.value = null
  }

  function publishedQuizzes() {
    return quizzes.value.filter(q => q.published)
  }

  // ── Exam attempt ────────────────────────────────────────
  async function startAttempt(quiz: Quiz) {
    const now = Date.now()

    if (SUPABASE_ENABLED) {
      // Fetch via RPC so is_correct is NEVER sent to the browser
      const { data: safe, error } = await supabase.rpc('get_quiz_for_exam', { p_quiz_id: quiz.id })
      if (error || !safe) throw new Error(error?.message ?? 'Quiz no disponible')
      const safeQuiz = mapQuiz(safe as DbRow)
      const questions = drawQuestions(safeQuiz)
      const snapshot = {
        questionsPerExam: safeQuiz.questionsPerExam,
        pointsPerQuestion: safeQuiz.pointsPerQuestion,
        passingScore: safeQuiz.passingScore,
        maxScore: safeQuiz.questionsPerExam * safeQuiz.pointsPerQuestion,
      }
      const { data: row, error: err2 } = await supabase.from('attempts').insert({
        quiz_id: safeQuiz.id,
        user_name: currentUser.value ?? 'anon',
        expires_at: new Date(now + safeQuiz.timeLimitMinutes * 60_000).toISOString(),
        quiz_snapshot: snapshot,
      }).select('id').single()
      if (err2) throw new Error(err2.message)
      attempt.value = {
        id: row.id as string,
        quizId: safeQuiz.id,
        quiz: safeQuiz,
        questions,
        answers: Object.fromEntries(questions.map(q => [q.id, null])),
        startedAt: now,
        expiresAt: now + safeQuiz.timeLimitMinutes * 60_000,
      }
    } else {
      const safeQuiz: Quiz = JSON.parse(JSON.stringify(quiz))
      const questions = drawQuestions(safeQuiz)
      attempt.value = {
        quizId: safeQuiz.id,
        quiz: safeQuiz,
        questions,
        answers: Object.fromEntries(questions.map(q => [q.id, null])),
        startedAt: now,
        expiresAt: now + safeQuiz.timeLimitMinutes * 60_000,
      }
    }
  }

  function setAnswer(questionId: string, optionId: string) {
    if (!attempt.value) return
    attempt.value.answers[questionId] = optionId
    if (SUPABASE_ENABLED && attempt.value.id) {
      supabase.from('answers').upsert({
        attempt_id: attempt.value.id,
        question_id: questionId,
        selected_option_id: optionId,
      }, { onConflict: 'attempt_id,question_id' }).then(() => null)
    }
  }

  async function submitAttempt(reason: 'manual' | 'time_expired'): Promise<AttemptResult> {
    const a = attempt.value!

    if (SUPABASE_ENABLED && a.id) {
      const { data, error } = await supabase.rpc('submit_attempt', {
        p_attempt_id: a.id,
        p_reason: reason,
      })
      if (error) throw new Error(error.message)
      const result = data as AttemptResult
      a.result = result
      return result
    }

    // Local mode: client-side scoring
    let correct = 0, incorrect = 0, unanswered = 0
    for (const q of a.questions) {
      const optId = a.answers[q.id]
      if (optId === null) { unanswered++; continue }
      q.options.find(o => o.id === optId)?.isCorrect ? correct++ : incorrect++
    }
    const result: AttemptResult = {
      score: correct * a.quiz.pointsPerQuestion,
      maxScore: a.quiz.questionsPerExam * a.quiz.pointsPerQuestion,
      passingScore: a.quiz.passingScore,
      passed: correct * a.quiz.pointsPerQuestion >= a.quiz.passingScore,
      correctCount: correct,
      incorrectCount: incorrect,
      unansweredCount: unanswered,
      submittedAt: Date.now(),
      reason,
    }
    a.result = result
    return result
  }

  // ── Admin CRUD ──────────────────────────────────────────
  function canPublish(quiz: Quiz): string | null {
    const reserved = quiz.questions.filter(q => q.isPinned || q.fixedPosition !== null).length
    if (quiz.questions.length < quiz.questionsPerExam)
      return `El banco tiene ${quiz.questions.length} preguntas y el examen pide ${quiz.questionsPerExam}.`
    if (reserved > quiz.questionsPerExam)
      return `Hay ${reserved} fijas/con posición, pero el examen solo lleva ${quiz.questionsPerExam}.`
    if (quiz.passingScore > quiz.questionsPerExam * quiz.pointsPerQuestion)
      return 'El mínimo supera el puntaje máximo.'
    return null
  }

  async function upsertQuiz(data: Omit<Quiz, 'questions' | 'published' | 'id'> & { id?: string; published?: boolean }): Promise<string> {
    if (SUPABASE_ENABLED) {
      const row = {
        title: data.title, entity: data.entity,
        time_limit_minutes: data.timeLimitMinutes,
        questions_per_exam: data.questionsPerExam,
        points_per_question: data.pointsPerQuestion,
        passing_score: data.passingScore,
        ...(data.published !== undefined ? { published: data.published } : {}),
      }
      if (data.id) {
        const { error } = await supabase.from('quizzes').update(row).eq('id', data.id)
        if (error) throw new Error(error.message)
        const idx = quizzes.value.findIndex(q => q.id === data.id)
        if (idx >= 0) quizzes.value[idx] = { ...quizzes.value[idx], ...data, id: data.id }
        return data.id
      } else {
        const { data: row2, error } = await supabase.from('quizzes').insert(row).select('id').single()
        if (error) throw new Error(error.message)
        const newId = row2.id as string
        quizzes.value.push({ ...data, id: newId, questions: [], published: false })
        return newId
      }
    } else {
      if (data.id) {
        const idx = quizzes.value.findIndex(q => q.id === data.id)
        if (idx >= 0) { quizzes.value[idx] = { ...quizzes.value[idx], ...data, id: data.id }; localPersist(quizzes.value) }
        return data.id
      }
      const id = newId()
      quizzes.value.push({ ...data, id, questions: [], published: data.published ?? false })
      localPersist(quizzes.value)
      return id
    }
  }

  async function removeQuiz(id: string) {
    if (SUPABASE_ENABLED) {
      const { error } = await supabase.from('quizzes').delete().eq('id', id)
      if (error) throw new Error(error.message)
    }
    quizzes.value = quizzes.value.filter(q => q.id !== id)
    if (!SUPABASE_ENABLED) localPersist(quizzes.value)
  }

  async function togglePublish(id: string): Promise<string | null> {
    const quiz = quizzes.value.find(q => q.id === id)
    if (!quiz) return 'Quiz no encontrado.'
    if (!quiz.published) {
      const err = canPublish(quiz)
      if (err) return err
    }
    const next = !quiz.published
    if (SUPABASE_ENABLED) {
      const { error } = await supabase.from('quizzes').update({ published: next }).eq('id', id)
      if (error) return error.message
    }
    quiz.published = next
    if (!SUPABASE_ENABLED) localPersist(quizzes.value)
    return null
  }

  async function addQuestion(quizId: string, q: Omit<Question, 'id'>): Promise<Question> {
    if (SUPABASE_ENABLED) {
      const { data: qRow, error } = await supabase.from('questions').insert({
        quiz_id: quizId, prompt: q.prompt, explanation: q.explanation,
        is_pinned: q.isPinned, fixed_position: q.fixedPosition,
      }).select('id').single()
      if (error) throw new Error(error.message)
      const qId = qRow.id as string
      const opts = await Promise.all(q.options.map((o, i) =>
        supabase.from('options').insert({ question_id: qId, label: o.label, is_correct: o.isCorrect, position: i }).select('id').single()
          .then(({ data }) => ({ ...o, id: data?.id as string }))
      ))
      const question: Question = { ...q, id: qId, options: opts }
      const quiz = quizzes.value.find(x => x.id === quizId)
      if (quiz) quiz.questions.push(question)
      return question
    } else {
      const question: Question = { ...q, id: newId(), options: q.options.map(o => ({ ...o, id: newId() })) }
      const quiz = quizzes.value.find(x => x.id === quizId)!
      quiz.questions.push(question)
      localPersist(quizzes.value)
      return question
    }
  }

  async function updateQuestion(quizId: string, questionId: string, data: Partial<Omit<Question, 'id'>>) {
    if (SUPABASE_ENABLED) {
      const { error } = await supabase.from('questions').update({
        prompt: data.prompt, explanation: data.explanation,
        is_pinned: data.isPinned, fixed_position: data.fixedPosition,
      }).eq('id', questionId)
      if (error) throw new Error(error.message)
      if (data.options) {
        await supabase.from('options').delete().eq('question_id', questionId)
        await Promise.all(data.options.map((o, i) =>
          supabase.from('options').insert({ question_id: questionId, label: o.label, is_correct: o.isCorrect, position: i })
        ))
      }
    }
    const quiz = quizzes.value.find(x => x.id === quizId)
    if (quiz) {
      const idx = quiz.questions.findIndex(q => q.id === questionId)
      if (idx >= 0) quiz.questions[idx] = { ...quiz.questions[idx], ...data }
    }
    if (!SUPABASE_ENABLED) localPersist(quizzes.value)
  }

  async function removeQuestion(quizId: string, questionId: string) {
    if (SUPABASE_ENABLED) {
      const { error } = await supabase.from('questions').delete().eq('id', questionId)
      if (error) throw new Error(error.message)
    }
    const quiz = quizzes.value.find(x => x.id === quizId)
    if (quiz) {
      quiz.questions = quiz.questions.filter(q => q.id !== questionId)
      if (quiz.published && quiz.questions.length < quiz.questionsPerExam) quiz.published = false
    }
    if (!SUPABASE_ENABLED) localPersist(quizzes.value)
  }

  return {
    quizzes, currentUser, isAdmin, attempt, loading, dbError,
    init, login, adminLogin, logout, reloadQuizzes, publishedQuizzes,
    startAttempt, setAnswer, submitAttempt,
    upsertQuiz, removeQuiz, canPublish, togglePublish,
    addQuestion, updateQuestion, removeQuestion,
  }
})
