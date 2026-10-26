<template>
  <header class="app-header">
    <b>Simulador CAS</b>
    <span>{{ store.currentUser }}</span>
  </header>

  <div class="main" v-if="attempt">
    <!-- 3-minute warning banner (non-blocking, above question/sidebar columns) -->
    <div v-if="showWarning" class="time-warning">
      <span>⚠️ ¡Quedan 3 minutos! Responde las preguntas restantes antes de que se acabe el tiempo.</span>
      <button @click="showWarning = false" aria-label="Cerrar aviso">✕</button>
    </div>

    <div class="exam-layout">
      <!-- Questions column -->
      <section class="card">
        <div class="mu">
          Pregunta {{ currentIndex + 1 }} de {{ questions.length }} · Respondidas {{ answeredCount }}
        </div>
        <div class="progress-bar">
          <i :style="{ width: progress + '%' }"></i>
        </div>

        <p class="question-text">{{ currentQ.prompt }}</p>

        <button
          v-for="(opt, i) in currentQ.options"
          :key="opt.id"
          class="option-btn"
          :class="{ selected: attempt.answers[currentQ.id] === opt.id }"
          @click="selectAnswer(opt.id)"
        >
          <b>{{ 'ABCDE'[i] }}</b>
          {{ opt.label }}
        </button>

        <div class="nav">
          <button class="btn sec" :disabled="currentIndex === 0" @click="currentIndex--">← Anterior</button>
          <button
            v-if="currentIndex < questions.length - 1"
            class="btn sec"
            @click="currentIndex++"
          >Siguiente →</button>
          <button
            v-else
            class="btn"
            :disabled="!allAnswered"
            @click="submit('manual')"
          >Finalizar examen</button>
        </div>

        <p v-if="currentIndex === questions.length - 1 && !allAnswered" class="err" style="margin-top:8px">
          Te faltan {{ unansweredCount }} pregunta(s). Usa los números para volver a ellas.
        </p>

        <div class="nav-dots">
          <button
            v-for="(q, i) in questions"
            :key="q.id"
            :class="{ answered: attempt.answers[q.id] !== null, current: i === currentIndex }"
            @click="currentIndex = i"
            :aria-label="'Ir a pregunta ' + (i + 1)"
          >{{ i + 1 }}</button>
        </div>
      </section>

      <!-- Sidebar -->
      <aside class="exam-sidebar">
        <div class="card">
          <div class="mu" style="text-align:center">Tiempo restante</div>
          <div
            class="timer"
            :class="{ warning: remaining <= 180 && remaining > 60, danger: remaining <= 60 }"
          >{{ formatTime(remaining) }}</div>
        </div>

        <div class="card">
          <h2 style="font-size:15px;margin-bottom:8px">Indicaciones</h2>
          <ul>
            <li>Responde antes de que termine el tiempo.</li>
            <li>Al marcar una opción pasas a la siguiente pregunta.</li>
            <li>Puedes volver y editar respuestas anteriores.</li>
            <li>Debes responder todas las preguntas para finalizar.</li>
          </ul>
        </div>

        <div class="card warn">
          <h2 style="font-size:15px;margin-bottom:8px">Prohibiciones</h2>
          <ul>
            <li>Mantén la cámara encendida durante todo el examen.</li>
            <li>No uses IA (ChatGPT, Copilot, etc.) para resolver.</li>
            <li>No consultes apuntes ni sitios web.</li>
            <li>No cambies de pestaña ni de ventana.</li>
          </ul>
        </div>
      </aside>
    </div>
  </div>

  <!-- Result modal -->
  <div v-if="result" class="modal">
    <div class="card modal-card">
      <template v-if="result.reason === 'time_expired'">
        <div style="font-size:44px">⏰</div>
        <h1 style="color:var(--ko);font-size:22px;margin:6px 0">¡Se acabó el tiempo!</h1>
        <p class="mu">Tu examen se envió automáticamente con las respuestas que alcanzaste a marcar.</p>
      </template>
      <p v-else class="mu">Examen finalizado</p>

      <div class="score">{{ result.score }} / {{ result.maxScore }}</div>
      <span class="badge" :class="result.passed ? 'ok' : 'ko'">
        {{ result.passed ? 'APROBADO' : 'NO APROBADO' }}
      </span>

      <p class="mu" style="margin-top:14px">
        Correctas: <b>{{ result.correctCount }}</b> ·
        Incorrectas: <b>{{ result.incorrectCount }}</b> ·
        Sin responder: <b>{{ result.unansweredCount }}</b><br>
        Puntaje mínimo para aprobar: {{ result.passingScore }}
      </p>

      <p class="mu" style="margin-top:10px">
        Cierre de sesión automático en <b>{{ closeCountdown }}</b> s
      </p>

      <button class="btn full" @click="doLogout">Cerrar sesión</button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAppStore } from '../store'
import type { AttemptResult } from '../store'

const store = useAppStore()
const router = useRouter()
const attempt = computed(() => store.attempt)
const questions = computed(() => store.attempt?.questions ?? [])

const currentIndex = ref(0)
const currentQ = computed(() => questions.value[currentIndex.value])
const remaining = ref(0)
const showWarning = ref(false)
const warned = ref(false)
const result = ref<AttemptResult | null>(null)
const closeCountdown = ref(60)

const answeredCount = computed(() =>
  questions.value.filter(q => (attempt.value?.answers[q.id] ?? null) !== null).length
)
const unansweredCount = computed(() => questions.value.length - answeredCount.value)
const allAnswered = computed(() => unansweredCount.value === 0)
const progress = computed(() => ((currentIndex.value + 1) / Math.max(questions.value.length, 1)) * 100)

let examTimer: ReturnType<typeof setInterval> | null = null
let closeTimer: ReturnType<typeof setInterval> | null = null

function formatTime(s: number): string {
  const m = Math.floor(s / 60)
  const sec = s % 60
  return `${String(m).padStart(2, '0')}:${String(sec).padStart(2, '0')}`
}

function selectAnswer(optionId: string) {
  if (!store.attempt || result.value) return
  store.setAnswer(currentQ.value.id, optionId)
  if (currentIndex.value < questions.value.length - 1) {
    setTimeout(() => { currentIndex.value++ }, 220)
  }
}

async function submit(reason: 'manual' | 'time_expired') {
  if (examTimer) { clearInterval(examTimer); examTimer = null }
  try {
    result.value = await store.submitAttempt(reason)
  } catch (err) {
    console.error('Error al enviar examen:', err)
    result.value = {
      score: 0, maxScore: 0, passingScore: 0, passed: false,
      correctCount: 0, incorrectCount: 0, unansweredCount: 0,
      submittedAt: Date.now(), reason,
    }
  }
  startCloseTimer()
}

function startCloseTimer() {
  closeCountdown.value = 60
  closeTimer = setInterval(() => {
    closeCountdown.value--
    if (closeCountdown.value <= 0) doLogout()
  }, 1000)
}

async function doLogout() {
  if (closeTimer) { clearInterval(closeTimer); closeTimer = null }
  await store.logout()
  router.push('/')
}

onMounted(() => {
  if (!store.attempt) { router.push('/'); return }
  remaining.value = Math.max(0, Math.floor((store.attempt.expiresAt - Date.now()) / 1000))

  examTimer = setInterval(() => {
    if (!store.attempt) return
    remaining.value = Math.max(0, Math.floor((store.attempt.expiresAt - Date.now()) / 1000))

    if (remaining.value <= 180 && !warned.value) {
      warned.value = true
      showWarning.value = true
    }
    if (remaining.value <= 0) {
      clearInterval(examTimer!)
      examTimer = null
      submit('time_expired')
    }
  }, 1000)
})

onUnmounted(() => {
  if (examTimer) clearInterval(examTimer)
  if (closeTimer) clearInterval(closeTimer)
})
</script>
