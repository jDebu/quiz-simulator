<template>
  <header class="app-header">
    <b>Simulador CAS · Administración</b>
    <span>/admin/login</span>
  </header>

  <div class="main">
    <div class="login-wrap">
      <div class="card">
        <h1>Acceso administrador</h1>

        <label for="lu">{{ supabaseEnabled ? 'Correo electrónico' : 'Usuario' }}</label>
        <input id="lu" v-model="email"
          :type="supabaseEnabled ? 'email' : 'text'"
          :autocomplete="supabaseEnabled ? 'email' : 'username'" />
        <p v-if="errors.email" class="err">{{ errors.email }}</p>

        <label for="lp">Contraseña</label>
        <input id="lp" v-model="password" type="password" autocomplete="current-password" />
        <p v-if="errors.password" class="err">{{ errors.password }}</p>

        <p v-if="errors.general" class="err" style="margin-top:10px">{{ errors.general }}</p>

        <button class="btn full" :disabled="submitting" @click="submit">
          {{ submitting ? 'Verificando…' : 'Ingresar' }}
        </button>

        <p v-if="!supabaseEnabled" class="mu" style="margin-top:14px;text-align:center">
          Demo: usuario <b>admin</b> con cualquier contraseña.
        </p>
        <p class="mu" style="text-align:center;margin-top:10px">
          <a href="#" @click.prevent="$router.push('/')" style="color:var(--pr)">← Volver al login de postulante</a>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAppStore } from '../store'
import { SUPABASE_ENABLED } from '../lib/supabase'

const store = useAppStore()
const router = useRouter()

const supabaseEnabled = SUPABASE_ENABLED
const email = ref('')
const password = ref('')
const errors = ref<Record<string, string>>({})
const submitting = ref(false)

async function submit() {
  const e: Record<string, string> = {}
  if (!email.value.trim()) e.email = `Ingresa tu ${supabaseEnabled ? 'correo' : 'usuario'}.`
  if (!password.value) e.password = 'Ingresa tu contraseña.'
  errors.value = e
  if (Object.keys(e).length) return

  submitting.value = true
  try {
    const err = await store.adminLogin(email.value.trim(), password.value)
    if (err) { errors.value = { general: err }; return }
    router.push('/admin')
  } finally {
    submitting.value = false
  }
}
</script>
