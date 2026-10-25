# Simulador CAS

Simulador de exámenes de convocatoria CAS construido con Vue 3 + TypeScript + Vite + Pinia.  
Persistencia local en `localStorage` — sin backend requerido para correr localmente.

## Stack

- **Frontend:** Vue 3 + TypeScript + Vite
- **Estado:** Pinia
- **Router:** Vue Router (hash history)
- **Datos:** localStorage (seed inicial con preguntas de ejemplo)

## Setup local

```bash
npm install
npm run dev
```

Abre http://localhost:5173

## Credenciales de demo

| Rol | Usuario | Contraseña |
|---|---|---|
| Postulante | cualquiera | cualquiera |
| Admin | `admin` | cualquiera |

## Pantallas

### Postulante
- **`/`** — Login: selector de tipo de examen (con buscador), usuario, contraseña
- **`/exam`** — Examen: preguntas una a una, navegación, contador, alerta a 3 min, sidebar con indicaciones
- Modal de resultado: puntaje, aprobado/no aprobado, cierre automático en 60 s

### Administración
- **`/admin/login`** — Login de admin (sin selector de examen)
- **`/admin`** — Lista de quizzes con buscador, filtro y acciones
- **`/admin/quiz/:id`** — Editor de quiz + banco de preguntas (agregar, editar, eliminar, sorteo de prueba)

## Comandos

```bash
npm run dev        # desarrollo en http://localhost:5173
npm run build      # build de producción en dist/
npm run preview    # preview del build
npm run typecheck  # verificar tipos TypeScript
```

## Próximos pasos (con Supabase)

1. Crear tablas en Supabase: `quizzes`, `questions`, `options`, `users`, `attempts`, `answers`
2. Reemplazar `localStorage` en `store.ts` por llamadas a Supabase
3. Implementar RLS para que postulantes nunca vean `is_correct`
4. Agregar autenticación real (Supabase Auth)

