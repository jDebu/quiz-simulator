import { defineStore } from 'pinia'
import { ref } from 'vue'
import { SEED_QUIZZES } from './data'
export type { Option, Question, Quiz, AttemptResult, Attempt } from './types'
import type { Question, Quiz, AttemptResult, Attempt } from './types'

let _nextId = 9000
export function newId() { return ++_nextId }

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
  const pinned = shuffle(quiz.questions.filter(q => q.fixedPosition === null && q.isPinned))
  const random = shuffle(quiz.questions.filter(q => q.fixedPosition === null && !q.isPinned))
  const slots: (Question | null)[] = Array(n).fill(null)
  for (const q of ordered) slots[(q.fixedPosition ?? 1) - 1] = q
  const pool = [...pinned, ...random]
  for (let i = 0; i < n; i++) {
    if (!slots[i]) slots[i] = pool.shift() ?? null
  }
  return slots.filter(Boolean) as Question[]
}

const SEED_VERSION = '2'

function loadQuizzes(): Quiz[] {
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

function persist(quizzes: Quiz[]) {
  localStorage.setItem('qs_quizzes', JSON.stringify(quizzes))
}

export const useAppStore = defineStore('app', () => {
  const quizzes = ref<Quiz[]>(loadQuizzes())
  const currentUser = ref<string | null>(null)
  const isAdmin = ref(false)
  const attempt = ref<Attempt | null>(null)

  function login(username: string, admin: boolean) {
    currentUser.value = username
    isAdmin.value = admin
  }

  function logout() {
    currentUser.value = null
    isAdmin.value = false
    attempt.value = null
  }

  function publishedQuizzes() {
    return quizzes.value.filter(q => q.published)
  }

  function startAttempt(quiz: Quiz) {
    const questions = drawQuestions(quiz)
    const now = Date.now()
    attempt.value = {
      quizId: quiz.id,
      quiz: JSON.parse(JSON.stringify(quiz)) as Quiz,
      questions,
      answers: Object.fromEntries(questions.map(q => [q.id, null])),
      startedAt: now,
      expiresAt: now + quiz.timeLimitMinutes * 60 * 1000,
    }
  }

  function setAnswer(questionId: number, optionId: number) {
    if (attempt.value) attempt.value.answers[questionId] = optionId
  }

  function submitAttempt(reason: 'manual' | 'time_expired'): AttemptResult {
    const a = attempt.value!
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

  // Admin CRUD
  function upsertQuiz(data: Omit<Quiz, 'questions' | 'published' | 'id'> & { id?: number; published?: boolean }): number {
    if (data.id) {
      const idx = quizzes.value.findIndex(q => q.id === data.id)
      if (idx >= 0) {
        quizzes.value[idx] = { ...quizzes.value[idx], ...data }
        persist(quizzes.value)
        return data.id
      }
    }
    const id = newId()
    quizzes.value.push({ ...data, id, questions: [], published: false })
    persist(quizzes.value)
    return id
  }

  function removeQuiz(id: number) {
    quizzes.value = quizzes.value.filter(q => q.id !== id)
    persist(quizzes.value)
  }

  function canPublish(quiz: Quiz): string | null {
    const reserved = quiz.questions.filter(q => q.isPinned || q.fixedPosition !== null).length
    if (quiz.questions.length < quiz.questionsPerExam) return `El banco tiene ${quiz.questions.length} preguntas y el examen pide ${quiz.questionsPerExam}.`
    if (reserved > quiz.questionsPerExam) return `Hay ${reserved} fijas/con posición, pero el examen solo lleva ${quiz.questionsPerExam}.`
    if (quiz.passingScore > quiz.questionsPerExam * quiz.pointsPerQuestion) return 'El mínimo supera el puntaje máximo.'
    return null
  }

  function togglePublish(id: number): string | null {
    const quiz = quizzes.value.find(q => q.id === id)
    if (!quiz) return 'Quiz no encontrado.'
    if (!quiz.published) {
      const err = canPublish(quiz)
      if (err) return err
    }
    quiz.published = !quiz.published
    persist(quizzes.value)
    return null
  }

  function addQuestion(quizId: number, q: Omit<Question, 'id'>): Question {
    const quiz = quizzes.value.find(x => x.id === quizId)!
    const question: Question = { ...q, id: newId() }
    quiz.questions.push(question)
    persist(quizzes.value)
    return question
  }

  function updateQuestion(quizId: number, questionId: number, data: Partial<Omit<Question, 'id'>>) {
    const quiz = quizzes.value.find(x => x.id === quizId)!
    const idx = quiz.questions.findIndex(q => q.id === questionId)
    if (idx >= 0) {
      quiz.questions[idx] = { ...quiz.questions[idx], ...data }
      persist(quizzes.value)
    }
  }

  function removeQuestion(quizId: number, questionId: number) {
    const quiz = quizzes.value.find(x => x.id === quizId)!
    quiz.questions = quiz.questions.filter(q => q.id !== questionId)
    if (quiz.published && quiz.questions.length < quiz.questionsPerExam) {
      quiz.published = false
    }
    persist(quizzes.value)
  }

  return {
    quizzes,
    currentUser,
    isAdmin,
    attempt,
    login,
    logout,
    publishedQuizzes,
    startAttempt,
    setAnswer,
    submitAttempt,
    upsertQuiz,
    removeQuiz,
    canPublish,
    togglePublish,
    addQuestion,
    updateQuestion,
    removeQuestion,
  }
})
