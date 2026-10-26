<template>
  <div v-if="store.loading" style="display:grid;place-items:center;height:100vh;font-size:15px;color:var(--mu)">
    Cargando…
  </div>
  <div v-else-if="store.dbError" style="display:grid;place-items:center;height:100vh;text-align:center;padding:20px">
    <div>
      <p style="color:var(--ko);font-weight:600;margin-bottom:8px">⚠️ No se pudo conectar a Supabase</p>
      <p style="color:var(--mu);font-size:14px;margin-bottom:16px">Corriendo en modo local (localStorage).</p>
      <button class="btn sec sm" @click="store.dbError = null">Continuar en modo local</button>
    </div>
  </div>
  <router-view v-else />
</template>

<script setup lang="ts">
import { useAppStore } from './store'
const store = useAppStore()
</script>
