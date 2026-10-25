<template>
  <header class="app-header">
    <b>Simulador CAS · Administración</b>
    <div style="display:flex;gap:10px;align-items:center">
      <span class="mu">Rol: admin</span>
      <button class="btn sec sm" @click="doLogout">Cerrar sesión</button>
    </div>
  </header>

  <div class="main">
    <div class="row">
      <div>
        <h1 style="font-size:21px">Quizzes</h1>
        <p class="mu">Cada examen sortea N preguntas del banco del quiz.</p>
      </div>
      <button class="btn" @click="$router.push('/admin/quiz/new')">+ Nuevo quiz</button>
    </div>

    <div class="card">
      <div class="row" style="justify-content:flex-start">
        <div style="flex:1;min-width:200px">
          <input v-model="search" placeholder="Buscar por título o entidad…" aria-label="Buscar" />
        </div>
        <div style="width:180px">
          <select v-model="statusFilter" aria-label="Estado">
            <option value="all">Todos</option>
            <option value="pub">Publicados</option>
            <option value="dr">Borradores</option>
          </select>
        </div>
      </div>

      <div class="table-wrap" style="margin-top:10px">
        <table v-if="filtered.length">
          <thead>
            <tr>
              <th>Quiz</th>
              <th>Examen / banco</th>
              <th>Tiempo</th>
              <th>Mínimo</th>
              <th>Estado</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="q in filtered" :key="q.id">
              <td>
                <b>{{ q.title }}</b>
                <div class="mu">{{ q.entity }}</div>
              </td>
              <td>{{ q.questionsPerExam }} de {{ q.questions.length }}</td>
              <td>{{ q.timeLimitMinutes }} min</td>
              <td>{{ q.passingScore }}/{{ q.questionsPerExam * q.pointsPerQuestion }}</td>
              <td>
                <span class="badge" :class="q.published ? 'ok' : 'dr'">
                  {{ q.published ? 'Publicado' : 'Borrador' }}
                </span>
              </td>
              <td>
                <div class="acts">
                  <button class="btn sec sm" @click="$router.push('/admin/quiz/' + q.id)">Editar</button>
                  <button class="btn sec sm" @click="togglePub(q.id)">
                    {{ q.published ? 'Despublicar' : 'Publicar' }}
                  </button>
                  <button class="btn dg sm" @click="confirmDelete(q.id, q.title)">Eliminar</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <p v-else class="mu" style="text-align:center;padding:24px">
          No hay quizzes que coincidan. Crea uno con "+ Nuevo quiz".
        </p>
      </div>
    </div>
  </div>

  <!-- Confirm delete dialog -->
  <div v-if="deleteTarget" class="modal">
    <div class="card" style="max-width:380px;width:100%">
      <h2>¿Eliminar "{{ deleteTarget.title }}"?</h2>
      <p class="mu" style="margin-top:6px">Esta acción eliminará el quiz y su banco de preguntas. No se puede deshacer.</p>
      <div class="acts" style="justify-content:flex-end;margin-top:16px">
        <button class="btn sec" @click="deleteTarget = null">Cancelar</button>
        <button class="btn dg" @click="doDelete">Eliminar</button>
      </div>
    </div>
  </div>

  <div v-if="toast" class="toast">{{ toast }}</div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAppStore } from '../store'

const store = useAppStore()
const router = useRouter()

const search = ref('')
const statusFilter = ref('all')
const toast = ref('')
const deleteTarget = ref<{ id: number; title: string } | null>(null)

const filtered = computed(() => {
  const q = search.value.toLowerCase()
  return store.quizzes.filter(z =>
    (z.title + z.entity).toLowerCase().includes(q) &&
    (statusFilter.value === 'all' || (statusFilter.value === 'pub') === z.published)
  )
})

function togglePub(id: number) {
  const err = store.togglePublish(id)
  if (err) { showToast(err); return }
  const quiz = store.quizzes.find(q => q.id === id)
  showToast(quiz?.published ? 'Quiz publicado' : 'Quiz despublicado')
}

function confirmDelete(id: number, title: string) {
  deleteTarget.value = { id, title }
}

function doDelete() {
  if (!deleteTarget.value) return
  store.removeQuiz(deleteTarget.value.id)
  deleteTarget.value = null
  showToast('Quiz eliminado')
}

function doLogout() {
  store.logout()
  router.push('/admin/login')
}

let toastTimer: ReturnType<typeof setTimeout> | null = null
function showToast(msg: string) {
  toast.value = msg
  if (toastTimer) clearTimeout(toastTimer)
  toastTimer = setTimeout(() => { toast.value = '' }, 2500)
}
</script>
