#!/usr/bin/env bash
# =============================================================
# scripts/setup-supabase.sh
# Crea proyecto Supabase, aplica la migración y actualiza .env.local
#
# USO:
#   1. Genera un token en: https://supabase.com/dashboard/account/tokens
#   2. export SUPABASE_ACCESS_TOKEN='sb_...'
#   3. bash scripts/setup-supabase.sh
# =============================================================
set -euo pipefail

# ── Colores ──────────────────────────────────────────────────
G='\033[0;32m'; Y='\033[1;33m'; R='\033[0;31m'; B='\033[0;34m'; NC='\033[0m'
info()    { echo -e "${B}ℹ  $*${NC}"; }
success() { echo -e "${G}✓  $*${NC}"; }
warn()    { echo -e "${Y}⚠  $*${NC}"; }
err()     { echo -e "${R}✗  $*${NC}" >&2; exit 1; }

# ── Config ───────────────────────────────────────────────────
ORG_ID="josfenfbqpdwfdakkpgt"
PROJECT_NAME="quiz-simulator-cas"
REGION="sa-east-1"   # São Paulo — el más cercano a Lima
DB_PASS="$(openssl rand -hex 24)"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SUPA="npx --yes supabase@latest"

# ── Verificar token ──────────────────────────────────────────
[ -z "${SUPABASE_ACCESS_TOKEN:-}" ] && err "Falta SUPABASE_ACCESS_TOKEN.

  Pasos:
  1. Ir a:   https://supabase.com/dashboard/account/tokens
  2. Crear token con todos los scopes
  3. export SUPABASE_ACCESS_TOKEN='tu_token'
  4. Volver a correr este script"

echo ""
echo -e "${G}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${G}  Configurando Supabase — CAS Quiz Simulator${NC}"
echo -e "${G}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# ── 1. Crear proyecto ────────────────────────────────────────
info "Creando proyecto '$PROJECT_NAME' (org: $ORG_ID, región: $REGION)…"
CREATE_OUT=$($SUPA projects create "$PROJECT_NAME" \
  --org-id  "$ORG_ID"  \
  --db-password "$DB_PASS" \
  --region  "$REGION"  \
  --output-format json 2>&1)

# Extraer project ref (campo "id" del JSON devuelto)
PROJECT_REF=$(python3 -c "
import sys, json
try:
    d = json.loads('''$CREATE_OUT''')
    print(d.get('id', d.get('ref','')))
except:
    pass
" 2>/dev/null || true)

# Fallback: grep por 20 chars minúsculas
[ -z "$PROJECT_REF" ] && \
  PROJECT_REF=$(echo "$CREATE_OUT" | grep -oE '"id"\s*:\s*"[a-z]{20}"' \
    | grep -oE '[a-z]{20}' | head -1 || true)

[ -z "$PROJECT_REF" ] && { echo "$CREATE_OUT"; err "No se obtuvo el project ref."; }
success "Proyecto creado → ref: $PROJECT_REF"

# Guardar contraseña DB (no commitear)
echo "$DB_PASS" > "$ROOT/.db_password"
grep -qF ".db_password" "$ROOT/.gitignore" 2>/dev/null || \
  echo ".db_password" >> "$ROOT/.gitignore"
info "Contraseña DB guardada en .db_password (ya en .gitignore)"

# ── 2. Esperar que el proyecto esté activo ───────────────────
info "Esperando que el proyecto inicie (max ~80s)…"
for i in $(seq 1 8); do
  sleep 10
  KEYS_TEST=$($SUPA projects api-keys \
    --project-ref "$PROJECT_REF" \
    --output-format json 2>/dev/null || echo "[]")
  READY=$(python3 -c "
import sys, json
try:
    raw = json.loads('''$KEYS_TEST''')
    keys = raw.get('keys', raw) if isinstance(raw, dict) else raw
    print('yes' if isinstance(keys, list) and len(keys) > 0 else 'no')
except:
    print('no')
" 2>/dev/null || echo "no")
  [ "$READY" = "yes" ] && { success "Proyecto activo"; break; }
  info "  Intento $i/8 — aún iniciando…"
done

# ── 3. Obtener API keys ──────────────────────────────────────
info "Obteniendo API keys…"
KEYS_JSON=$($SUPA projects api-keys \
  --project-ref "$PROJECT_REF" \
  --output-format json 2>&1)

ANON_KEY=$(python3 -c "
import sys, json
try:
    raw = json.loads('''$KEYS_JSON''')
    keys = raw.get('keys', raw) if isinstance(raw, dict) else raw
    for k in keys:
        if k.get('id') == 'anon' or k.get('name') == 'anon':
            print(k.get('api_key', ''))
            break
except:
    pass
" 2>/dev/null || true)

[ -z "$ANON_KEY" ] && { echo "$KEYS_JSON"; err "No se obtuvo la anon key."; }
success "Anon key obtenida: ${ANON_KEY:0:40}…"

SUPABASE_URL="https://$PROJECT_REF.supabase.co"

# ── 4. Escribir .env.local ───────────────────────────────────
info "Escribiendo .env.local…"
cat > "$ROOT/.env.local" <<EOF
VITE_SUPABASE_URL=$SUPABASE_URL
VITE_SUPABASE_ANON_KEY=$ANON_KEY
EOF
success ".env.local actualizado"

# ── 5. Aplicar migración SQL ─────────────────────────────────
info "Aplicando migración SQL al proyecto remoto…"
$SUPA db push \
  --project-ref "$PROJECT_REF" \
  --password    "$DB_PASS"     \
  --include-all                \
  --yes                        \
  --workdir "$ROOT" && \
  success "Migración aplicada exitosamente" || \
  warn "db push tuvo un error — ver salida arriba"

# ── 6. Aplicar seed data (si existe) ─────────────────────────
SEED_FILE="$ROOT/supabase/seeds"
if ls "$SEED_FILE"/*.sql &>/dev/null; then
  info "Aplicando seed data…"
  for f in "$SEED_FILE"/*.sql; do
    info "  → $(basename $f)"
    $SUPA db query \
      --project-ref "$PROJECT_REF" \
      --linked \
      -f "$f" \
      --workdir "$ROOT" && \
      success "  Seed aplicado: $(basename $f)" || \
      warn "  Error en seed: $(basename $f)"
  done
fi

# ── Resumen final ────────────────────────────────────────────
echo ""
echo -e "${G}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${G}  ✨  ¡Listo! Configuración completa${NC}"
echo -e "${G}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
printf "  %-12s %s\n" "Proyecto:" "$PROJECT_REF"
printf "  %-12s %s\n" "URL:"      "$SUPABASE_URL"
printf "  %-12s %s\n" "Dashboard:" "https://supabase.com/dashboard/project/$PROJECT_REF"
echo ""
echo -e "${Y}Paso siguiente — crear el usuario admin:${NC}"
echo ""
echo "  1. Ir a: https://supabase.com/dashboard/project/$PROJECT_REF/auth/users"
echo "     → 'Add user' → email + contraseña → crear"
echo ""
echo "  2. Correr en el SQL Editor del dashboard:"
echo "     https://supabase.com/dashboard/project/$PROJECT_REF/sql"
echo ""
echo "     INSERT INTO profiles (id, username, role)"
echo "     SELECT id, email, 'admin'"
echo "     FROM auth.users"
echo "     WHERE email = 'tu-email@ejemplo.com';"
echo ""
echo "  3. Reiniciar dev server:"
echo "     npm run dev"
echo ""
