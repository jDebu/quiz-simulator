import { createRouter, createWebHashHistory } from 'vue-router'
import { useAppStore } from './store'

const router = createRouter({
  history: createWebHashHistory(),
  routes: [
    { path: '/', component: () => import('./views/LoginView.vue') },
    {
      path: '/exam',
      component: () => import('./views/ExamView.vue'),
      meta: { requiresAttempt: true },
    },
    { path: '/admin/login', component: () => import('./views/AdminLoginView.vue') },
    {
      path: '/admin',
      component: () => import('./views/AdminListView.vue'),
      meta: { requiresAdmin: true },
    },
    {
      path: '/admin/quiz/:id',
      component: () => import('./views/AdminQuizView.vue'),
      meta: { requiresAdmin: true },
    },
    { path: '/:pathMatch(.*)*', redirect: '/' },
  ],
})

router.beforeEach((to) => {
  const store = useAppStore()
  if (to.meta.requiresAttempt && !store.attempt) return '/'
  if (to.meta.requiresAdmin && !store.isAdmin) return '/admin/login'
})

export default router
