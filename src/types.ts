export interface Option {
  id: number
  label: string
  isCorrect: boolean
}

export interface Question {
  id: number
  prompt: string
  options: Option[]
  explanation: string
  isPinned: boolean
  fixedPosition: number | null
}

export interface Quiz {
  id: number
  title: string
  entity: string
  timeLimitMinutes: number
  questionsPerExam: number
  pointsPerQuestion: number
  passingScore: number
  published: boolean
  questions: Question[]
}

export interface AttemptResult {
  score: number
  maxScore: number
  passingScore: number
  passed: boolean
  correctCount: number
  incorrectCount: number
  unansweredCount: number
  submittedAt: number
  reason: 'manual' | 'time_expired'
}

export interface Attempt {
  quizId: number
  quiz: Quiz
  questions: Question[]
  answers: Record<number, number | null>
  startedAt: number
  expiresAt: number
  result?: AttemptResult
}
