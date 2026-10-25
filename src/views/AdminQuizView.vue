<template>
  <header class="app-header">
    <b>Simulador CAS · Administración</b>
    <div style="display:flex;gap:10px;align-items:center">
      <button class="btn sec sm" @click="$router.push('/admin')">← Volver</button>
      <button class="btn sec sm" @click="doLogout">Cerrar sesión</button>
    </div>
  </header>

  <div class="main">
    <!-- Quiz form -->
    <div class="card" style="margin-bottom:16px">
      <div style="display:flex;align-items:center;gap:10px;margin-bottom:14px">
        <h2 style="font-size:18px;margin:0">{{ isNew ? 'Nuevo quiz' : 'Editar quiz' }}</h2>
        <span class="badge" :class="quiz.published ? 'ok' : 'dr'">
          {{ quiz.published ? 'Publicado' : 'Borrador' }}
        </span>
      </div>

      <div class="form-grid">
        <div class="span2">
          <label for="f1">Título</label>
          <input id="f1" v-model="quiz.title" />
          <p v-if="formErr.title" class="err">{{ formErr.title }}</p>
        </div>
        <div class="span2">
          <label for="f2">Entidad / convocatoria</label>
          <input id="f2" v-model="quiz.entity" />
        </div>
        <div>
          <label for="f3">Tiempo (min)</label>
          <input id="f3" type="number" min="1" max="240" v-model.number="quiz.timeLimitMinutes" />
          <p v-if="formErr.time" class="err">{{ formErr.time }}</p>
        </div>
        <div>
          <label for="f6">Preguntas por examen</label>
          <input id="f6" type="number" min="1" max="500" v-model.number="quiz.questionsPerExam" />
          <p v-if="formErr.n" class="err">{{ formErr.n }}</p>
        </div>
        <div>
          <label for="f4">Puntos por pregunta</label>
          <input id="f4" type="number" min="1" max="100" v-model.number="quiz.pointsPerQuestion" />
        </div>
        <div>
          <label for="f5">Puntaje mínimo para aprobar</label>
          <input id="f5" type="number" min="1" v-model.number="quiz.passingScore" />
          <p v-if="formErr.pass" class="err">{{ formErr.pass }}</p>
        </div>
      </div>

      <p class="mu" style="margin-top:10px">
        Banco: <b>{{ quiz.questions.length }}</b> · Cada examen: <b>{{ quiz.questionsPerExam }}</b> ×
        {{ quiz.pointsPerQuestion }} pts = máximo <b>{{ quiz.questionsPerExam * quiz.pointsPerQuestion }}</b> ·
        Fijas o con posición: <b>{{ reservedCount }}</b>
      </p>
      <p v-if="poolWarning" class="err">{{ poolWarning }}</p>

      <div style="display:flex;justify-content:flex-end;margin-top:14px">
        <button class="btn" @click="saveQuiz">Guardar quiz</button>
      </div>
    </div>

    <!-- Question bank -->
    <div class="card">
      <div class="row">
        <h2 style="font-size:16px;margin:0">Banco de preguntas ({{ quiz.questions.length }})</h2>
        <div class="acts">
          <button class="btn sec sm" @click="runPreview" :disabled="!quiz.questions.length">Probar sorteo</button>
          <button class="btn sm" @click="openQuestion(null)" :disabled="isNew">
            + Agregar pregunta
          </button>
        </div>
      </div>

      <div v-if="isNew" class="mu" style="text-align:center;padding:20px">
        Guarda el quiz primero para agregar preguntas.
      </div>

      <template v-else>
        <!-- Bulk upload bar -->
        <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;margin-bottom:14px;padding-bottom:14px;border-bottom:1px solid var(--bd)">
          <span class="mu" style="font-size:13px">Carga masiva:</span>
          <button class="btn sec sm" @click="downloadTemplate">↓ Descargar plantilla</button>
          <label class="btn sec sm" style="cursor:pointer;font-weight:600">
            ↑ Importar Excel
            <input type="file" accept=".xlsx,.xls" style="display:none" @change="handleFile" />
          </label>
        </div>

        <div class="row" style="justify-content:flex-start;margin-bottom:10px">
          <div style="flex:1;min-width:200px">
            <input v-model="qSearch" placeholder="Buscar en enunciados y opciones…" aria-label="Buscar pregunta" />
          </div>
          <div style="width:200px">
            <select v-model="qFilter" aria-label="Filtro">
              <option value="all">Todas</option>
              <option value="pin">Fijas</option>
              <option value="ord">Con posición</option>
              <option value="none">Solo aleatorias</option>
            </select>
          </div>
        </div>

        <div v-if="pagedQuestions.length" class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>Enunciado</th>
                <th>Correcta</th>
                <th>Fija</th>
                <th>Posición</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in pagedQuestions" :key="item.q.id">
                <td>{{ item.i + 1 }}</td>
                <td>
                  {{ item.q.prompt.slice(0, 80) }}{{ item.q.prompt.length > 80 ? '…' : '' }}
                  <div class="mu">{{ item.q.options.length }} opciones</div>
                </td>
                <td style="color:var(--ok)">
                  {{ item.q.options.find(o => o.isCorrect)?.label ?? '—' }}
                </td>
                <td>
                  <span v-if="item.q.isPinned || item.q.fixedPosition !== null" class="badge ok">Fija</span>
                  <span v-else>—</span>
                </td>
                <td>
                  <span v-if="item.q.fixedPosition !== null" class="badge dr">N.º {{ item.q.fixedPosition }}</span>
                  <span v-else>—</span>
                </td>
                <td>
                  <div class="acts">
                    <button class="btn sec sm" @click="openQuestion(item.q.id)">Editar</button>
                    <button class="btn dg sm" @click="confirmDeleteQ(item.q.id, item.q.prompt)">Eliminar</button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
          <div class="pagination">
            <span class="mu">Mostrando {{ pageStart + 1 }}–{{ pageEnd }} de {{ filteredQuestions.length }}</span>
            <div class="acts">
              <button class="btn sec sm" :disabled="qPage <= 1" @click="qPage--">← Anterior</button>
              <span class="mu">Pág. {{ qPage }}/{{ totalPages }}</span>
              <button class="btn sec sm" :disabled="qPage >= totalPages" @click="qPage++">Siguiente →</button>
            </div>
          </div>
        </div>
        <p v-else class="mu" style="text-align:center;padding:20px">
          Ninguna pregunta coincide con la búsqueda o el filtro.
        </p>
      </template>
    </div>
  </div>

  <!-- Question modal -->
  <div v-if="qModal.open" class="modal" style="align-items:flex-start;overflow:auto;padding:20px">
    <div class="card" style="max-width:620px;width:100%;margin:0">
      <h2 style="margin-bottom:14px">{{ qModal.id === null ? 'Nueva pregunta' : 'Editar pregunta' }}</h2>

      <label for="qp">Enunciado</label>
      <textarea id="qp" v-model="qModal.prompt"></textarea>
      <p v-if="qErr.prompt" class="err">{{ qErr.prompt }}</p>
      <div v-if="duplicateWarning" style="background:#fff3cd;border:1px solid #ffc107;border-radius:8px;padding:8px 12px;font-size:13px;margin-top:4px;color:#856404">
        ⚠️ Enunciado similar ({{ Math.round(duplicateWarning.score * 100) }}%) a una pregunta existente:<br>
        <em>"{{ duplicateWarning.prompt.slice(0, 90) }}{{ duplicateWarning.prompt.length > 90 ? '…' : '' }}"</em>
        <br><span style="font-weight:400">Podés guardar de todos modos si es una pregunta distinta.</span>
      </div>

      <label style="margin-top:14px">Opciones (marca la correcta)</label>
      <div v-for="(opt, i) in qModal.options" :key="i" style="display:flex;gap:8px;align-items:center;margin-bottom:8px">
        <input type="radio" name="correct" :value="i" v-model="qModal.correctIndex" :aria-label="'Correcta ' + 'ABCDE'[i]" />
        <b style="width:20px;color:var(--mu)">{{ 'ABCDE'[i] }}</b>
        <input v-model="opt.label" :aria-label="'Opción ' + 'ABCDE'[i]" />
        <button class="btn dg sm" :disabled="qModal.options.length <= 2" @click="removeOpt(i)" aria-label="Quitar opción">✕</button>
      </div>
      <p v-if="qErr.options" class="err">{{ qErr.options }}</p>
      <button class="btn sec sm" :disabled="qModal.options.length >= 5" @click="addOpt" style="margin-top:4px">
        + Agregar opción
      </button>

      <div class="form-grid" style="margin-top:16px">
        <div>
          <label for="qpos">Posición en el examen (opcional)</label>
          <select id="qpos" v-model="qModal.fixedPosition">
            <option :value="null">Sin posición</option>
            <option
              v-for="p in quiz.questionsPerExam"
              :key="p"
              :value="p"
              :disabled="isPositionTaken(p)"
            >{{ p }}{{ isPositionTaken(p) ? ' (ocupada)' : '' }}</option>
          </select>
        </div>
        <div>
          <label>Prioridad</label>
          <label style="display:flex;gap:8px;align-items:center;font-weight:400;margin-top:8px">
            <input
              type="checkbox"
              v-model="qModal.isPinned"
              :disabled="qModal.fixedPosition !== null"
            />
            Fija: siempre entra al examen
          </label>
        </div>
      </div>
      <p v-if="qErr.pinned" class="err">{{ qErr.pinned }}</p>

      <label for="qx" style="margin-top:14px">Explicación (opcional)</label>
      <textarea id="qx" v-model="qModal.explanation" style="min-height:60px"></textarea>

      <div class="acts" style="justify-content:flex-end;margin-top:16px">
        <button class="btn sec" @click="qModal.open = false">Cancelar</button>
        <button class="btn" @click="saveQuestion">Guardar pregunta</button>
      </div>
    </div>
  </div>

  <!-- Delete question confirm -->
  <div v-if="deleteQTarget" class="modal">
    <div class="card" style="max-width:380px;width:100%">
      <h2>¿Eliminar esta pregunta?</h2>
      <p class="mu" style="margin-top:6px">{{ deleteQTarget.prompt.slice(0, 100) }}</p>
      <div class="acts" style="justify-content:flex-end;margin-top:16px">
        <button class="btn sec" @click="deleteQTarget = null">Cancelar</button>
        <button class="btn dg" @click="doDeleteQ">Eliminar</button>
      </div>
    </div>
  </div>

  <!-- Sorteo preview -->
  <div v-if="showPreview" class="modal" style="align-items:flex-start;overflow:auto;padding:20px">
    <div class="card" style="max-width:540px;width:100%;margin:0">
      <h2>Simulación de un examen ({{ quiz.questionsPerExam }} preguntas)</h2>
      <p class="mu" style="margin-top:4px">Así se armaría el examen para un postulante. Cada intento sortea distinto.</p>
      <div v-for="(slot, i) in preview" :key="i" style="display:flex;gap:10px;align-items:flex-start;padding:10px 0;border-bottom:1px solid var(--bd)">
        <div style="width:28px;height:28px;border-radius:8px;background:var(--gr);display:grid;place-items:center;font-weight:700;font-size:13px;flex:none">{{ i + 1 }}</div>
        <div style="flex:1">
          <span v-if="slot">{{ slot.prompt }}</span>
          <span v-else class="err">Faltan preguntas en el banco</span>
        </div>
        <span v-if="slot" class="badge" :class="slot.fixedPosition !== null ? 'dr' : slot.isPinned ? 'ok' : 'dr'" style="font-size:11px">
          {{ slot.fixedPosition !== null ? 'Con posición' : slot.isPinned ? 'Fija' : 'Aleatoria' }}
        </span>
      </div>
      <div class="acts" style="justify-content:flex-end;margin-top:14px">
        <button class="btn sec" @click="runPreview">Volver a sortear</button>
        <button class="btn" @click="showPreview = false">Cerrar</button>
      </div>
    </div>
  </div>

  <!-- Import modal -->
  <div v-if="importState.open" class="modal" style="align-items:flex-start;overflow:auto;padding:20px">
    <div class="card" style="max-width:720px;width:100%;margin:0">
      <h2>Importar preguntas desde Excel</h2>
      <p class="mu" style="margin-top:4px">
        {{ importState.rows.length }} fila(s) procesada(s) ·
        <span style="color:var(--ok)">{{ importState.valid.length }} válida(s)</span> ·
        <span style="color:var(--ko)">{{ importState.rows.length - importState.valid.length }} con error(es)</span>
      </p>
      <div class="table-wrap" style="max-height:360px;overflow:auto;margin-top:12px">
        <table>
          <thead>
            <tr><th>Fila</th><th>Enunciado</th><th>Opciones</th><th>Estado</th></tr>
          </thead>
          <tbody>
            <tr v-for="row in importState.rows" :key="row.rowNum">
              <td>{{ row.rowNum }}</td>
              <td style="max-width:260px">{{ row.prompt.slice(0, 80) }}{{ row.prompt.length > 80 ? '…' : '' }}</td>
              <td class="mu" style="font-size:12px">{{ row.options.map((o,i) => 'ABCDE'[i]+') '+o).join(' · ') }}</td>
              <td>
                <span v-if="row.errors.length === 0 && !row.duplicate" class="badge ok">OK</span>
                <span v-else-if="row.errors.length === 0 && row.duplicate" class="badge" style="background:#fff3cd;color:#856404">Similar</span>
                <span v-else class="badge ko" :title="row.errors.join(' | ')">{{ row.errors[0] }}</span>
                <div v-if="row.duplicate" class="mu" style="font-size:11px;margin-top:2px">⚠️ Similar a: "{{ row.duplicate }}…"</div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <p v-if="importState.valid.some(r => r.duplicate)" class="mu" style="margin-top:8px;font-size:13px">
        Las filas marcadas como "Similar" también se importarán si no tienen errores.
      </p>
      <div class="acts" style="justify-content:flex-end;margin-top:16px">
        <button class="btn sec" @click="importState.open = false">Cancelar</button>
        <button class="btn" :disabled="importState.valid.length === 0" @click="confirmImport">
          Importar {{ importState.valid.length }} pregunta(s)
        </button>
      </div>
    </div>
  </div>

  <div v-if="toast" class="toast">{{ toast }}</div>
</template>

<script setup lang="ts">
import { ref, computed, reactive, watch, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useAppStore, drawQuestions, newId } from '../store'
import type { Quiz, Question, Option } from '../store'
import * as XLSX from 'xlsx'

const store = useAppStore()
const router = useRouter()
const route = useRoute()

const quizId = computed(() => route.params.id as string)
const isNew = computed(() => quizId.value === 'new')

const quiz = reactive<Quiz>({
  id: 0,
  title: '',
  entity: '',
  timeLimitMinutes: 15,
  questionsPerExam: 10,
  pointsPerQuestion: 3,
  passingScore: 21,
  published: false,
  questions: [],
})

onMounted(() => {
  if (!isNew.value) {
    const found = store.quizzes.find(q => q.id === Number(quizId.value))
    if (!found) { router.push('/admin'); return }
    Object.assign(quiz, JSON.parse(JSON.stringify(found)))
  }
})

const reservedCount = computed(() =>
  quiz.questions.filter(q => q.isPinned || q.fixedPosition !== null).length
)

const poolWarning = computed(() => {
  const max = quiz.questionsPerExam * quiz.pointsPerQuestion
  if (quiz.passingScore > max) return `El mínimo (${quiz.passingScore}) supera el puntaje máximo (${max}).`
  if (reservedCount.value > quiz.questionsPerExam) return `Hay ${reservedCount.value} fijas/con posición, pero el examen solo lleva ${quiz.questionsPerExam}.`
  return ''
})

const formErr = ref<Record<string, string>>({})

function saveQuiz() {
  const e: Record<string, string> = {}
  if (!quiz.title.trim()) e.title = 'El título es obligatorio.'
  if (!(quiz.timeLimitMinutes >= 1 && quiz.timeLimitMinutes <= 240)) e.time = 'Entre 1 y 240 minutos.'
  if (!(quiz.questionsPerExam >= 1)) e.n = 'Mínimo 1 pregunta.'
  if (quiz.passingScore < 1) e.pass = 'Debe ser mayor que 0.'
  else if (quiz.passingScore > quiz.questionsPerExam * quiz.pointsPerQuestion) e.pass = `No puede superar el puntaje máximo (${quiz.questionsPerExam * quiz.pointsPerQuestion}).`
  formErr.value = e
  if (Object.keys(e).length) return

  if (isNew.value) {
    const id = store.upsertQuiz({
      title: quiz.title,
      entity: quiz.entity,
      timeLimitMinutes: quiz.timeLimitMinutes,
      questionsPerExam: quiz.questionsPerExam,
      pointsPerQuestion: quiz.pointsPerQuestion,
      passingScore: quiz.passingScore,
    })
    showToast('Quiz guardado')
    router.replace(`/admin/quiz/${id}`)
  } else {
    store.upsertQuiz({
      id: quiz.id,
      title: quiz.title,
      entity: quiz.entity,
      timeLimitMinutes: quiz.timeLimitMinutes,
      questionsPerExam: quiz.questionsPerExam,
      pointsPerQuestion: quiz.pointsPerQuestion,
      passingScore: quiz.passingScore,
      published: quiz.published,
    })
    // sync questions from store
    const found = store.quizzes.find(q => q.id === quiz.id)
    if (found) quiz.questions = found.questions
    showToast('Quiz guardado')
  }
}

// Questions
const qSearch = ref('')
const qFilter = ref('all')
const qPage = ref(1)
const PAGE_SIZE = 10

const filteredQuestions = computed(() => {
  const t = qSearch.value.toLowerCase()
  return quiz.questions
    .map((q, i) => ({ q, i }))
    .filter(({ q }) => {
      const matchText = (q.prompt + ' ' + q.options.map((o: Option) => o.label).join(' ')).toLowerCase().includes(t)
      const matchFilter =
        qFilter.value === 'all' ||
        (qFilter.value === 'pin' && q.isPinned) ||
        (qFilter.value === 'ord' && q.fixedPosition !== null) ||
        (qFilter.value === 'none' && !q.isPinned && q.fixedPosition === null)
      return matchText && matchFilter
    })
})

watch([qSearch, qFilter], () => { qPage.value = 1 })

const totalPages = computed(() => Math.max(1, Math.ceil(filteredQuestions.value.length / PAGE_SIZE)))
const pageStart = computed(() => (qPage.value - 1) * PAGE_SIZE)
const pageEnd = computed(() => Math.min(pageStart.value + PAGE_SIZE, filteredQuestions.value.length))
const pagedQuestions = computed(() => filteredQuestions.value.slice(pageStart.value, pageEnd.value))

// Question modal
interface QModal {
  open: boolean
  id: number | null
  prompt: string
  options: { label: string }[]
  correctIndex: number
  isPinned: boolean
  fixedPosition: number | null
  explanation: string
}

const qModal = reactive<QModal>({
  open: false,
  id: null,
  prompt: '',
  options: [{ label: '' }, { label: '' }],
  correctIndex: 0,
  isPinned: false,
  fixedPosition: null,
  explanation: '',
})

const qErr = ref<Record<string, string>>({})

function openQuestion(id: number | null) {
  qErr.value = {}
  if (id === null) {
    Object.assign(qModal, {
      open: true, id: null, prompt: '', options: [{ label: '' }, { label: '' }],
      correctIndex: 0, isPinned: false, fixedPosition: null, explanation: '',
    })
  } else {
    const q = quiz.questions.find(q => q.id === id)!
    Object.assign(qModal, {
      open: true, id: q.id,
      prompt: q.prompt,
      options: q.options.map((o: Option) => ({ label: o.label })),
      correctIndex: q.options.findIndex((o: Option) => o.isCorrect),
      isPinned: q.isPinned,
      fixedPosition: q.fixedPosition,
      explanation: q.explanation,
    })
  }
}

function addOpt() { qModal.options.push({ label: '' }) }
function removeOpt(i: number) {
  qModal.options.splice(i, 1)
  if (qModal.correctIndex >= qModal.options.length) qModal.correctIndex = 0
}

function isPositionTaken(pos: number): boolean {
  return quiz.questions.some(q => q.fixedPosition === pos && q.id !== qModal.id)
}

function saveQuestion() {
  const e: Record<string, string> = {}
  const opts = qModal.options.map(o => o.label.trim())
  if (!qModal.prompt.trim()) e.prompt = 'El enunciado es obligatorio.'
  if (opts.some(l => !l)) e.options = 'Completa todas las opciones o quita las vacías.'
  else if (new Set(opts.map(l => l.toLowerCase())).size < opts.length) e.options = 'Hay opciones repetidas.'
  const isPinned = qModal.isPinned || qModal.fixedPosition !== null
  const others = quiz.questions.filter(q => q.id !== qModal.id && (q.isPinned || q.fixedPosition !== null)).length
  if (isPinned && others + 1 > quiz.questionsPerExam) e.pinned = `El examen lleva ${quiz.questionsPerExam} preguntas y ya hay ${others} fijas o con posición.`
  qErr.value = e
  if (Object.keys(e).length) return

  const options: Option[] = opts.map((label, i) => ({
    id: newId(),
    label,
    isCorrect: i === qModal.correctIndex,
  }))

  const qData: Omit<Question, 'id'> = {
    prompt: qModal.prompt.trim(),
    options,
    explanation: qModal.explanation.trim(),
    isPinned,
    fixedPosition: qModal.fixedPosition,
  }

  if (qModal.id === null) {
    store.addQuestion(quiz.id, qData)
  } else {
    store.updateQuestion(quiz.id, qModal.id, qData)
  }

  // sync
  const found = store.quizzes.find(q => q.id === quiz.id)
  if (found) quiz.questions = found.questions

  qModal.open = false
  showToast('Pregunta guardada')
}

// Delete question
const deleteQTarget = ref<{ id: number; prompt: string } | null>(null)

function confirmDeleteQ(id: number, prompt: string) {
  deleteQTarget.value = { id, prompt }
}

function doDeleteQ() {
  if (!deleteQTarget.value) return
  store.removeQuestion(quiz.id, deleteQTarget.value.id)
  const found = store.quizzes.find(q => q.id === quiz.id)
  if (found) quiz.questions = found.questions
  deleteQTarget.value = null
  showToast('Pregunta eliminada')
}

// Sorteo preview
const preview = ref<(Question | null)[]>([])
const showPreview = ref(false)

function runPreview() {
  preview.value = drawQuestions(quiz as Quiz)
  if (preview.value.length < quiz.questionsPerExam) {
    const slots: (Question | null)[] = Array(quiz.questionsPerExam).fill(null)
    preview.value.forEach((q, i) => { slots[i] = q })
    preview.value = slots
  }
  showPreview.value = true
}

// Duplicate detection
function promptSimilarity(a: string, b: string): number {
  const words = (s: string) =>
    new Set(s.toLowerCase().replace(/[^\wáéíóúüñ\s]/gi, '').split(/\s+/).filter(w => w.length > 2))
  const sa = words(a)
  const sb = words(b)
  const inter = [...sa].filter(w => sb.has(w)).length
  const union = new Set([...sa, ...sb]).size
  return union === 0 ? 0 : inter / union
}

const duplicateWarning = computed<{ score: number; prompt: string } | null>(() => {
  const p = qModal.prompt.trim()
  if (p.length < 20) return null
  for (const q of quiz.questions) {
    if (q.id === qModal.id) continue
    const score = promptSimilarity(p, q.prompt)
    if (score >= 0.65) return { score, prompt: q.prompt }
  }
  return null
})

// Excel import / export
interface ImportRow {
  rowNum: number
  prompt: string
  options: string[]
  correctIndex: number
  isPinned: boolean
  fixedPosition: number | null
  explanation: string
  errors: string[]
  duplicate: string
}

const importState = reactive({
  open: false,
  rows: [] as ImportRow[],
  valid: [] as ImportRow[],
})

function downloadTemplate() {
  const headers = ['Enunciado', 'Opción A', 'Opción B', 'Opción C', 'Opción D', 'Opción E', 'Correcta', 'Fija', 'Posición', 'Explicación']
  const example = [
    '¿Cuál es la señal de tránsito que obliga a detenerse completamente?',
    'Círculo amarillo',
    'Octágono rojo (PARE)',
    'Triángulo invertido',
    '', '',
    'B', 'NO', '',
    'La señal PARE es octagonal y de color rojo.',
  ]
  const ws = XLSX.utils.aoa_to_sheet([headers, example])
  ws['!cols'] = [60, 30, 30, 30, 30, 30, 10, 8, 10, 40].map(wch => ({ wch }))
  const wb = XLSX.utils.book_new()
  XLSX.utils.book_append_sheet(wb, ws, 'Preguntas')
  XLSX.writeFile(wb, 'plantilla_preguntas.xlsx')
}

async function handleFile(ev: Event) {
  const file = (ev.target as HTMLInputElement).files?.[0]
  if (!file) return
  ;(ev.target as HTMLInputElement).value = ''
  const buf = await file.arrayBuffer()
  const wb = XLSX.read(buf, { type: 'array' })
  const ws = wb.Sheets[wb.SheetNames[0]]
  const raw = XLSX.utils.sheet_to_json<(string | number | undefined)[]>(ws, { header: 1, defval: '' })
  const rows: ImportRow[] = []
  const valid: ImportRow[] = []
  for (let i = 1; i < raw.length; i++) {
    const r = (raw[i] as (string | number | undefined)[]).map(c => String(c ?? '').trim())
    const prompt = r[0] ?? ''
    const opts = [r[1], r[2], r[3], r[4], r[5]].filter(Boolean)
    const correcta = (r[6] ?? '').toUpperCase()
    const fija = (r[7] ?? '').toUpperCase()
    const rawPos = r[8] ? parseInt(r[8]) : NaN
    const fixedPosition = !isNaN(rawPos) && rawPos >= 1 ? rawPos : null
    const explanation = r[9] ?? ''
    const errors: string[] = []
    if (!prompt) errors.push('Enunciado vacío')
    if (opts.length < 2) errors.push('Mínimo 2 opciones')
    const ci = 'ABCDE'.indexOf(correcta)
    if (ci < 0 || ci >= opts.length) errors.push(`Correcta debe ser letra de opción disponible (${opts.map((_, j) => 'ABCDE'[j]).join(', ')})`)
    if (new Set(opts.map(o => o.toLowerCase())).size < opts.length) errors.push('Opciones repetidas')
    if (!isNaN(rawPos) && rawPos > quiz.questionsPerExam) errors.push(`Posición ${rawPos} supera preguntas por examen (${quiz.questionsPerExam})`)
    let dup = ''
    if (errors.length === 0) {
      for (const q of quiz.questions) {
        if (promptSimilarity(prompt, q.prompt) >= 0.65) { dup = q.prompt.slice(0, 60); break }
      }
    }
    const row: ImportRow = { rowNum: i + 1, prompt, options: opts, correctIndex: Math.max(0, ci), isPinned: ['SI','SÍ','S','1','TRUE'].includes(fija), fixedPosition, explanation, errors, duplicate: dup }
    rows.push(row)
    if (errors.length === 0) valid.push(row)
  }
  importState.rows = rows
  importState.valid = valid
  importState.open = true
}

function confirmImport() {
  for (const row of importState.valid) {
    const options: Option[] = row.options.map((label, i) => ({ id: newId(), label, isCorrect: i === row.correctIndex }))
    store.addQuestion(quiz.id, { prompt: row.prompt, options, explanation: row.explanation, isPinned: row.isPinned || row.fixedPosition !== null, fixedPosition: row.fixedPosition })
  }
  const found = store.quizzes.find(q => q.id === quiz.id)
  if (found) quiz.questions = found.questions
  importState.open = false
  showToast(`${importState.valid.length} pregunta(s) importadas`)
}

// Logout
function doLogout() {
  store.logout()
  router.push('/admin/login')
}

// Toast
const toast = ref('')
let toastTimer: ReturnType<typeof setTimeout> | null = null
function showToast(msg: string) {
  toast.value = msg
  if (toastTimer) clearTimeout(toastTimer)
  toastTimer = setTimeout(() => { toast.value = '' }, 2500)
}
</script>
