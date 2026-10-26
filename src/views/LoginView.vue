<template>
  <header class="app-header">
    <b>Simulador CAS</b>
    <span>Ingresa tus datos para comenzar</span>
  </header>

  <div class="main">
    <div class="login-wrap">
      <div class="card">
        <h1>Simulador de examen CAS</h1>
        <p class="mu" style="margin-top:4px">Elige el tipo de examen e inicia sesión.</p>

        <label for="ex">Tipo de examen</label>
        <div class="combo">
          <input
            id="ex"
            v-model="examQuery"
            autocomplete="off"
            placeholder="Buscar por cargo o entidad…"
            @input="selectedExam = null"
            @focus="showList = true"
            @blur="hideList"
            :class="{ 'err-border': errors.exam }"
          />
          <ul v-if="showList && filteredExams.length" class="combo-list">
            <li v-for="e in filteredExams" :key="e.id" @mousedown.prevent="pickExam(e)">
              {{ e.title }}
              <small>{{ e.entity }}</small>
            </li>
          </ul>
          <ul v-else-if="showList && examQuery.length > 0" class="combo-list">
            <li class="mu">Sin resultados</li>
          </ul>
        </div>
        <div v-if="selectedExam" class="mu" style="margin-top:6px">
          {{ selectedExam.questionsPerExam }} preguntas · {{ selectedExam.timeLimitMinutes }} min ·
          {{ selectedExam.pointsPerQuestion }} pts c/u · mínimo {{ selectedExam.passingScore }} pts
        </div>
        <p v-if="errors.exam" class="err">{{ errors.exam }}</p>

        <label for="us">Usuario</label>
        <input id="us" v-model="username" autocomplete="username" :class="{ 'err-border': errors.username }" />
        <p v-if="errors.username" class="err">{{ errors.username }}</p>

        <label for="pw">Contraseña</label>
        <input id="pw" v-model="password" type="password" autocomplete="current-password" :class="{ 'err-border': errors.password }" />
        <p v-if="errors.password" class="err">{{ errors.password }}</p>

        <p v-if="errors.general" class="err" style="margin-top:10px">{{ errors.general }}</p>

        <button class="btn full" @click="submit" :disabled="submitting">
          {{ submitting ? 'Iniciando…' : 'Iniciar simulación' }}
        </button>

        <p class="mu" style="margin-top:14px;text-align:center">
          ¿Eres administrador?
          <a href="#" @click.prevent="$router.push('/admin/login')" style="color:var(--pr)">Acceso admin</a>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAppStore } from '../store'
import type { Quiz } from '../store'

const store = useAppStore()
const router = useRouter()

const examQuery = ref('')
const selectedExam = ref<Quiz | null>(null)
const username = ref('')
const password = ref('')
const showList = ref(false)
const errors = ref<Record<string, string>>({})

const filteredExams = computed(() =>
  store.publishedQuizzes().filter(q =>
    (q.title + q.entity).toLowerCase().includes(examQuery.value.toLowerCase())
  )
)

function pickExam(e: Quiz) {
  selectedExam.value = e
  examQuery.value = e.title
  showList.value = false
}

function hideList() {
  setTimeout(() => { showList.value = false }, 150)
}

const submitting = ref(false)

async function submit() {
  const e: Record<string, string> = {}
  if (!selectedExam.value) e.exam = 'Selecciona un tipo de examen.'
  if (!username.value.trim()) e.username = 'Ingresa tu usuario.'
  if (!password.value) e.password = 'Ingresa tu contraseña.'
  errors.value = e
  if (Object.keys(e).length) return

  // Admin redirect via student login
  if (username.value.trim().toLowerCase() === 'admin') {
    store.login('admin', true)
    router.push('/admin')
    return
  }

  submitting.value = true
  try {
    store.login(username.value.trim(), false)
    await store.startAttempt(selectedExam.value!)
    router.push('/exam')
  } catch (err) {
    errors.value = { general: 'No se pudo iniciar el examen. Intenta de nuevo.' }
    console.error(err)
  } finally {
    submitting.value = false
  }
}
</script>

<style scoped>
.err-border { border-color: var(--ko); }
</style>
