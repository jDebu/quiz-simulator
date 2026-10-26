-- ============================================================
-- Simulador CAS — Schema inicial
-- Ejecutar en: Supabase Dashboard > SQL Editor
-- O con CLI: supabase db push
-- ============================================================

-- ------------------------------------------------------------
-- TABLAS
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS quizzes (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title       text NOT NULL,
  entity      text NOT NULL DEFAULT '',
  time_limit_minutes    int  NOT NULL DEFAULT 15,
  questions_per_exam    int  NOT NULL DEFAULT 10,
  points_per_question   int  NOT NULL DEFAULT 3,
  passing_score         int  NOT NULL DEFAULT 21,
  published   boolean  NOT NULL DEFAULT false,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS questions (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_id       uuid NOT NULL REFERENCES quizzes(id) ON DELETE CASCADE,
  prompt        text NOT NULL,
  explanation   text NOT NULL DEFAULT '',
  is_pinned     boolean NOT NULL DEFAULT false,
  fixed_position int,
  created_at    timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS options (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id  uuid NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  label        text NOT NULL,
  is_correct   boolean NOT NULL DEFAULT false,
  position     int NOT NULL DEFAULT 0
);

-- Profiles vincula auth.users con un rol (student | admin)
CREATE TABLE IF NOT EXISTS profiles (
  id        uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username  text NOT NULL,
  role      text NOT NULL DEFAULT 'student' CHECK (role IN ('student', 'admin')),
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS attempts (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_id         uuid NOT NULL REFERENCES quizzes(id),
  user_name       text NOT NULL,
  started_at      timestamptz NOT NULL DEFAULT now(),
  expires_at      timestamptz NOT NULL,
  submitted_at    timestamptz,
  score           int,
  max_score       int,
  passed          boolean,
  reason          text CHECK (reason IN ('manual', 'time_expired')),
  -- Snapshot de configuración al momento del intento
  quiz_snapshot   jsonb NOT NULL DEFAULT '{}'::jsonb
);

CREATE TABLE IF NOT EXISTS answers (
  id                 uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id         uuid NOT NULL REFERENCES attempts(id) ON DELETE CASCADE,
  question_id        uuid NOT NULL,
  selected_option_id uuid,
  UNIQUE (attempt_id, question_id)
);

-- ------------------------------------------------------------
-- FUNCIONES RPC (SECURITY DEFINER = pueden leer is_correct)
-- ------------------------------------------------------------

-- get_quiz_for_exam: devuelve quiz + preguntas + opciones SIN is_correct
-- Los postulantes usan esta función; nunca ven la clave de respuestas.
CREATE OR REPLACE FUNCTION get_quiz_for_exam(p_quiz_id uuid)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public
AS $$
DECLARE
  v_result json;
BEGIN
  SELECT row_to_json(t) INTO v_result FROM (
    SELECT
      q.id, q.title, q.entity,
      q.time_limit_minutes, q.questions_per_exam,
      q.points_per_question, q.passing_score, q.published,
      (
        SELECT json_agg(json_build_object(
          'id', qu.id,
          'prompt', qu.prompt,
          'explanation', qu.explanation,
          'isPinned', qu.is_pinned,
          'fixedPosition', qu.fixed_position,
          'options', (
            SELECT json_agg(json_build_object(
              'id', o.id,
              'label', o.label,
              'position', o.position
              -- is_correct NO se incluye aquí
            ) ORDER BY o.position)
            FROM options o WHERE o.question_id = qu.id
          )
        ) ORDER BY qu.created_at)
        FROM questions qu WHERE qu.quiz_id = q.id
      ) AS questions
    FROM quizzes q WHERE q.id = p_quiz_id AND q.published = true
  ) t;
  RETURN v_result;
END;
$$;

-- submit_attempt: calcula el puntaje en el servidor leyendo is_correct
-- El cliente nunca recibe is_correct; el puntaje llega ya calculado.
CREATE OR REPLACE FUNCTION submit_attempt(
  p_attempt_id uuid,
  p_reason     text
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_attempt   attempts%ROWTYPE;
  v_correct   int := 0;
  v_incorrect int := 0;
  v_unanswered int := 0;
  v_score     int;
  v_max_score int;
  v_passing   int;
  v_passed    boolean;
  v_pts       int;
  v_rec       RECORD;
BEGIN
  SELECT * INTO v_attempt FROM attempts WHERE id = p_attempt_id;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Intento no encontrado: %', p_attempt_id;
  END IF;
  IF v_attempt.submitted_at IS NOT NULL THEN
    RAISE EXCEPTION 'El intento ya fue enviado';
  END IF;

  v_pts     := COALESCE((v_attempt.quiz_snapshot->>'pointsPerQuestion')::int, 1);
  v_max_score := COALESCE((v_attempt.quiz_snapshot->>'maxScore')::int,
                           (v_attempt.quiz_snapshot->>'questionsPerExam')::int * v_pts);
  v_passing := COALESCE((v_attempt.quiz_snapshot->>'passingScore')::int, 0);

  FOR v_rec IN
    SELECT a.selected_option_id, o.is_correct
    FROM   answers a
    LEFT JOIN options o ON o.id = a.selected_option_id
    WHERE  a.attempt_id = p_attempt_id
  LOOP
    IF v_rec.selected_option_id IS NULL THEN
      v_unanswered := v_unanswered + 1;
    ELSIF v_rec.is_correct THEN
      v_correct := v_correct + 1;
    ELSE
      v_incorrect := v_incorrect + 1;
    END IF;
  END LOOP;

  v_score  := v_correct * v_pts;
  v_passed := v_score >= v_passing;

  UPDATE attempts SET
    submitted_at = now(),
    score        = v_score,
    max_score    = v_max_score,
    passed       = v_passed,
    reason       = p_reason
  WHERE id = p_attempt_id;

  RETURN json_build_object(
    'score',           v_score,
    'maxScore',        v_max_score,
    'passingScore',    v_passing,
    'passed',          v_passed,
    'correctCount',    v_correct,
    'incorrectCount',  v_incorrect,
    'unansweredCount', v_unanswered,
    'submittedAt',     extract(epoch from now()) * 1000,
    'reason',          p_reason
  );
END;
$$;

-- ------------------------------------------------------------
-- ROW LEVEL SECURITY
-- ------------------------------------------------------------

ALTER TABLE quizzes   ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE options   ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles  ENABLE ROW LEVEL SECURITY;
ALTER TABLE attempts  ENABLE ROW LEVEL SECURITY;
ALTER TABLE answers   ENABLE ROW LEVEL SECURITY;

-- Helper: es admin el usuario actual?
CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin'
  );
$$;

-- quizzes: público lee publicados; admin lee/escribe todo
CREATE POLICY "quizzes_public_read"  ON quizzes FOR SELECT USING (published = true);
CREATE POLICY "quizzes_admin_all"    ON quizzes USING (is_admin()) WITH CHECK (is_admin());

-- questions: público lee (quiz publicado); admin gestiona
CREATE POLICY "questions_public_read" ON questions FOR SELECT USING (
  EXISTS (SELECT 1 FROM quizzes WHERE id = quiz_id AND published = true)
);
CREATE POLICY "questions_admin_all"   ON questions USING (is_admin()) WITH CHECK (is_admin());

-- options: público lee (is_correct queda oculto vía get_quiz_for_exam); admin gestiona
CREATE POLICY "options_public_read"  ON options FOR SELECT USING (
  EXISTS (
    SELECT 1 FROM questions q JOIN quizzes qz ON qz.id = q.quiz_id
    WHERE q.id = question_id AND qz.published = true
  )
);
CREATE POLICY "options_admin_all"    ON options USING (is_admin()) WITH CHECK (is_admin());

-- profiles: cada usuario ve/edita su propio perfil
CREATE POLICY "profiles_own"         ON profiles USING (auth.uid() = id) WITH CHECK (auth.uid() = id);
CREATE POLICY "profiles_admin_read"  ON profiles FOR SELECT USING (is_admin());

-- attempts: cualquiera crea; creador lee/actualiza
CREATE POLICY "attempts_insert"      ON attempts FOR INSERT WITH CHECK (true);
CREATE POLICY "attempts_read"        ON attempts FOR SELECT USING (true);
CREATE POLICY "attempts_update"      ON attempts FOR UPDATE USING (true);

-- answers: cualquiera inserta/actualiza (limitado por RLS de attempts)
CREATE POLICY "answers_insert"       ON answers FOR INSERT WITH CHECK (true);
CREATE POLICY "answers_read"         ON answers FOR SELECT USING (true);
CREATE POLICY "answers_upsert"       ON answers FOR UPDATE USING (true);

-- ------------------------------------------------------------
-- TRIGGER: crear perfil al registrar usuario
-- ------------------------------------------------------------

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, username, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'username', NEW.email),
    COALESCE(NEW.raw_user_meta_data->>'role', 'student')
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();
