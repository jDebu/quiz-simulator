<template>
  <header class="app-header">
    <b>Simulador CAS · Administración</b>
    <span>/admin/login</span>
  </header>

  <div class="main">
    <div class="login-wrap">
      <div class="card">
        <h1>Acceso administrador</h1>
        <p class="mu" style="margin-top:4px">
          Aquí no se elige tipo de examen. El sistema detecta tu rol y te lleva al panel.
        </p>

        <label for="lu">Usuario</label>
        <input id="lu" v-model="username" autocomplete="username" />
        <p v-if="errors.username" class="err">{{ errors.username }}</p>

        <label for="lp">Contraseña</label>
        <input id="lp" v-model="password" type="password" autocomplete="current-password" />
        <p v-if="errors.password" class="err">{{ errors.password }}</p>

        <p v-if="errors.general" class="err" style="margin-top:10px">{{ errors.general }}</p>

        <button class="btn full" @click="submit">Ingresar</button>

        <p class="mu" style="margin-top:14px;text-align:center">
          Demo: usuario <b>admin</b> con cualquier contraseña.
        </p>
        <p class="mu" style="text-align:center">
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

const store = useAppStore()
const router = useRouter()

const username = ref('')
const password = ref('')
const errors = ref<Record<string, string>>({})

function submit() {
  const e: Record<string, string> = {}
  if (!username.value.trim()) e.username = 'Ingresa tu usuario.'
  if (!password.value) e.password = 'Ingresa tu contraseña.'
  errors.value = e
  if (Object.keys(e).length) return

  if (username.value.trim().toLowerCase() !== 'admin') {
    errors.value = { general: 'Tu cuenta no tiene rol de administrador. Los postulantes ingresan desde la pantalla de examen.' }
    return
  }

  store.login('admin', true)
  router.push('/admin')
}
</script>
