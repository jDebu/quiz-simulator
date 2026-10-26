-- ============================================================
-- SEED: Proceso CAS N° 036-2026-PCM-OGRH (2da Convocatoria)
-- Vacante: Conductor Vehicular - Oficina de Abastecimiento
-- 100 preguntas • Examen: 20 pgs (15 específicas + 5 transversales)
-- Puntuación: 1.5 pts/pg • Puntaje máx: 30 • Mínimo aprobatorio: 21
-- Ejecutar DESPUÉS de aplicar la migración 0001_initial.sql
-- ============================================================

BEGIN;

-- 1. QUIZ ─────────────────────────────────────────────────────
INSERT INTO quizzes (id, title, entity, time_limit_minutes, questions_per_exam,
                     points_per_question, passing_score, published)
VALUES (
  '00000000-0036-4000-8000-000000000001',
  'Simulador CAS N° 036-2026-PCM-OGRH — Conductor Vehicular (2da. Conv.)',
  'Presidencia del Consejo de Ministros — Oficina de Abastecimiento',
  40,   -- 40 minutos
  20,   -- 20 preguntas por examen
  2,    -- 2 pts por pregunta (aprox.; ajustar si se usa escala 1.5)
  21,   -- Puntaje mínimo aprobatorio
  false -- cambiar a true cuando esté listo para publicar
)  ON CONFLICT (id) DO NOTHING;

-- 2. PREGUNTAS Y OPCIONES ─────────────────────────────────────
-- Pregunta 1
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('b0f5122e-dfc3-5350-af1a-22a9cea96626', '00000000-0036-4000-8000-000000000001',
  $$Según el Reglamento Nacional de Tránsito, ¿cuál es la velocidad máxima permitida en zonas escolares durante el horario de ingreso y salida de alumnos?$$,
  $$El RNT establece 20 km/h como límite en zonas escolares en horario de ingreso/salida.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('57d7901d-265d-59c9-b104-fd979575adc2', 'b0f5122e-dfc3-5350-af1a-22a9cea96626', $$30 km/h$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f859c34c-9a0a-5670-a959-a0e1f1034542', 'b0f5122e-dfc3-5350-af1a-22a9cea96626', $$20 km/h$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ac8a3dce-636d-52c7-b26b-32bdf9982d8b', 'b0f5122e-dfc3-5350-af1a-22a9cea96626', $$25 km/h$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('839415eb-2d51-54dc-8e5e-23b29ce4d665', 'b0f5122e-dfc3-5350-af1a-22a9cea96626', $$15 km/h$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 2
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('cb36e9c3-a4d0-52d9-9f3f-76066e58642e', '00000000-0036-4000-8000-000000000001',
  $$Al aproximarse a una intersección sin semáforo ni señal vertical, ¿a qué vehículo debe ceder el paso?$$,
  $$El RNT otorga prioridad al vehículo que proviene de la derecha en intersecciones sin señalización.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e62dce03-6c37-5819-8bdc-0afceca100f3', 'cb36e9c3-a4d0-52d9-9f3f-76066e58642e', $$Al que viene de frente$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('519aefbd-07a5-575e-abb3-5cfeec3bc0b7', 'cb36e9c3-a4d0-52d9-9f3f-76066e58642e', $$Al que viene por la derecha$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('25fcdc7f-c0ce-53ba-be19-7745ae917e0b', 'cb36e9c3-a4d0-52d9-9f3f-76066e58642e', $$Al vehículo más grande$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bbc57574-bb74-59b5-9144-1a9aca5e8a33', 'cb36e9c3-a4d0-52d9-9f3f-76066e58642e', $$Al que circula más rápido$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 3
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('72ab3efb-b849-58cd-8696-54fe065b6c48', '00000000-0036-4000-8000-000000000001',
  $$¿Qué indica una línea amarilla continua doble en el eje de la calzada?$$,
  $$La doble línea amarilla continua prohíbe absolutamente el adelantamiento en ambos sentidos.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('16378f0e-2ac8-59cf-8d3a-ac41f82d4d43', '72ab3efb-b849-58cd-8696-54fe065b6c48', $$Prohibido adelantar en ambos sentidos$$, true, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ef938686-bf86-5435-8cfa-145f74a0a059', '72ab3efb-b849-58cd-8696-54fe065b6c48', $$Se puede adelantar con precaución$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('93900009-4790-5e31-a0c5-293747b1ed75', '72ab3efb-b849-58cd-8696-54fe065b6c48', $$Solo se permite girar a la izquierda$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1aac6730-c1c9-5099-8a60-24bc3a68591d', '72ab3efb-b849-58cd-8696-54fe065b6c48', $$Zona de velocidad reducida$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 4
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('b5f1454e-d6ee-51f6-b303-f78040d9ff8e', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es la distancia mínima de seguridad respecto al vehículo precedente en vía urbana?$$,
  $$El RNT exige la distancia suficiente para detenerse ante un frenado brusco del vehículo delantero.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bc0545d6-1784-5486-b003-b42937183fbe', 'b5f1454e-d6ee-51f6-b303-f78040d9ff8e', $$3 metros$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c3142b2f-dc6e-5b60-b845-2a56eb6ad6a4', 'b5f1454e-d6ee-51f6-b303-f78040d9ff8e', $$La necesaria para frenar ante parada brusca del vehículo delantero$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('631499eb-2d6e-5903-8daf-90556c08bb87', 'b5f1454e-d6ee-51f6-b303-f78040d9ff8e', $$5 metros$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f7e38788-60a3-5bf0-9a83-ea843f72afe8', 'b5f1454e-d6ee-51f6-b303-f78040d9ff8e', $$2 metros$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 5
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('2f056f61-e960-508c-bb20-497ec431a810', '00000000-0036-4000-8000-000000000001',
  $$Si un semáforo está inoperativo, el conductor debe:$$,
  $$Ante semáforo inoperativo se aplica el procedimiento PARE: detención total y avance con precaución.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('43047e10-99c9-501c-a977-cf41112ecd18', '2f056f61-e960-508c-bb20-497ec431a810', $$Cruzar a velocidad reducida$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('62642d6a-f047-5f6a-98c5-39cb1f385056', '2f056f61-e960-508c-bb20-497ec431a810', $$Tratarlo como señal CEDA EL PASO$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4f74f1aa-ec43-5ed0-8ea2-bcaddf406a7a', '2f056f61-e960-508c-bb20-497ec431a810', $$Tratarlo como señal PARE y avanzar con precaución$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('47ba1003-04e2-5ab6-a83a-373909dd15da', '2f056f61-e960-508c-bb20-497ec431a810', $$Tocar el claxon y continuar$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 6
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('6b533bb5-f947-50f9-b5cc-1a1181c4e066', '00000000-0036-4000-8000-000000000001',
  $$¿En qué carril debe circular preferentemente un vehículo en una vía de tres carriles por sentido?$$,
  $$El carril derecho es el de circulación normal; los demás son para adelantamiento.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('154b7371-3e17-5e5b-b2d3-7f7c921d61ae', '6b533bb5-f947-50f9-b5cc-1a1181c4e066', $$Carril central$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('161b8c92-788c-59b3-acd0-e8b871690456', '6b533bb5-f947-50f9-b5cc-1a1181c4e066', $$Carril derecho$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('fe40739b-2bcf-5060-b050-35a10bcbffde', '6b533bb5-f947-50f9-b5cc-1a1181c4e066', $$Carril izquierdo$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f6009eb1-a8c6-5938-a3d7-9009a969b911', '6b533bb5-f947-50f9-b5cc-1a1181c4e066', $$Cualquier carril$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 7
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('40bc49b9-300a-5e8c-b4e6-83059ad8b37f', '00000000-0036-4000-8000-000000000001',
  $$¿Cuándo se permite el uso de luces altas en vía urbana?$$,
  $$Las luces altas en zona urbana solo se usan cuando el alumbrado público es insuficiente; se bajan al cruzarse con otro vehículo.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4b5c1d2d-9ba4-5235-9a40-bd930c4ffa6b', '40bc49b9-300a-5e8c-b4e6-83059ad8b37f', $$Siempre de noche$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3db370a9-0023-5d9d-b68d-fd672dab3d4a', '40bc49b9-300a-5e8c-b4e6-83059ad8b37f', $$Nunca en zona urbana$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8614fd7d-8e8f-5ee9-9e2b-1585fe997938', '40bc49b9-300a-5e8c-b4e6-83059ad8b37f', $$Solo cuando no haya alumbrado público suficiente$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d043fa20-f66e-5205-8d63-344d32254c5a', '40bc49b9-300a-5e8c-b4e6-83059ad8b37f', $$Solo para alertar peatones$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 8
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('1003eb5e-3626-5f14-809c-b02ae4563935', '00000000-0036-4000-8000-000000000001',
  $$Un conductor oficial se acerca a un paso de cebra donde un peatón espera cruzar. ¿Qué debe hacer?$$,
  $$El conductor siempre debe ceder el paso al peatón en el paso de cebra.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e51c2e89-6409-5679-bf51-fe1806e1f65c', '1003eb5e-3626-5f14-809c-b02ae4563935', $$Tocar bocina para avisar que pasará$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9d007cb0-53bb-5338-8139-0eb9e40c3310', '1003eb5e-3626-5f14-809c-b02ae4563935', $$Reducir velocidad y ceder el paso al peatón$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('79c32fad-31e7-51fa-9d22-fe990e4e26ce', '1003eb5e-3626-5f14-809c-b02ae4563935', $$Acelerar antes de que el peatón inicie el cruce$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('6c0594eb-e4fb-5df8-a2e0-c09a74d21d1a', '1003eb5e-3626-5f14-809c-b02ae4563935', $$Mantener la velocidad$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 9
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('502ce624-8c00-5be4-8c6a-83ce4fc770bb', '00000000-0036-4000-8000-000000000001',
  $$¿Qué señal vertical de forma triangular con vértice hacia abajo indica?$$,
  $$El triángulo con vértice hacia abajo es la señal internacional de CEDA EL PASO.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c9199f65-18aa-5146-bcc6-afd0441a0cc9', '502ce624-8c00-5be4-8c6a-83ce4fc770bb', $$PARE obligatorio$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('94d81a5b-693b-5927-81a5-8c043549d24f', '502ce624-8c00-5be4-8c6a-83ce4fc770bb', $$CEDA EL PASO$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bd970963-1e3c-5c06-accb-fdcc86669846', '502ce624-8c00-5be4-8c6a-83ce4fc770bb', $$Zona de peligro$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c7f5cbae-fa2b-531f-8454-157e9b70813c', '502ce624-8c00-5be4-8c6a-83ce4fc770bb', $$Límite de velocidad$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 10
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('b348d99a-280d-5478-bc18-bba141a14ad4', '00000000-0036-4000-8000-000000000001',
  $$Conducir un vehículo del Estado con alcoholemia superior al límite legal implica:$$,
  $$Conducir con alcoholemia superior al límite genera multa, cancelación de licencia e inhabilitación definitiva.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b4a8b609-6916-5b51-9950-01d9a98e0b36', 'b348d99a-280d-5478-bc18-bba141a14ad4', $$Solo amonestación verbal$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('99230ad0-c6e8-5c4a-a950-146079c9e200', 'b348d99a-280d-5478-bc18-bba141a14ad4', $$Multa y suspensión temporal$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('44f54ac2-a665-5356-b09b-92672e12a931', 'b348d99a-280d-5478-bc18-bba141a14ad4', $$Multa, cancelación de licencia e inhabilitación definitiva$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4491f942-e2ee-56fb-ad14-f2a6ec9bc974', 'b348d99a-280d-5478-bc18-bba141a14ad4', $$Solo pérdida del trabajo$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 11
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('22696b0b-5ad9-5f7e-82cc-3bd3fc69a53c', '00000000-0036-4000-8000-000000000001',
  $$¿En qué caso se puede adelantar a otro vehículo en vía de doble sentido?$$,
  $$El adelantamiento es válido solo cuando la línea central es discontinua y hay visibilidad suficiente.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('012243de-03c1-5c44-8504-8a0f1dce0c7e', '22696b0b-5ad9-5f7e-82cc-3bd3fc69a53c', $$Siempre que el carril opuesto esté libre$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0f2ccc3d-8100-5f78-859f-bbdcc2dae617', '22696b0b-5ad9-5f7e-82cc-3bd3fc69a53c', $$Solo cuando la línea central sea discontinua y el carril opuesto esté despejado$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ab749262-7536-51e3-b248-59c1fc2b9b0d', '22696b0b-5ad9-5f7e-82cc-3bd3fc69a53c', $$Está prohibido siempre$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1bdd80cc-d5cd-5441-b763-8a4ba4726ca3', '22696b0b-5ad9-5f7e-82cc-3bd3fc69a53c', $$Solo en vías de alta velocidad$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 12
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('15c562dc-3698-5816-a849-32136e08822d', '00000000-0036-4000-8000-000000000001',
  $$¿Qué debe hacer el conductor al escuchar la sirena de un vehículo de emergencia?$$,
  $$Ante vehículos de emergencia con sirena: ceder el paso inmediato acercándose al borde derecho.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c0f76fd1-53df-5f2c-a5fb-ca78a5775332', '15c562dc-3698-5816-a849-32136e08822d', $$Acelerar para salir de su paso$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f7031660-52f1-5356-b717-1fead5c2d61e', '15c562dc-3698-5816-a849-32136e08822d', $$Detenerse o desplazarse al borde derecho para dejarlo pasar$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b3692c5b-c791-576d-b940-95cbb318f9c6', '15c562dc-3698-5816-a849-32136e08822d', $$Tocar bocina para alertar a otros$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bd59f4a8-440f-5579-8de7-6a485ee4a0a9', '15c562dc-3698-5816-a849-32136e08822d', $$Seguirlo de cerca$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 13
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('477d137c-a3dc-5c24-bc1e-d0922b1f1924', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es la velocidad máxima en autopistas urbanas (vías expresas) para vehículos ligeros en Perú?$$,
  $$En autopistas urbanas el límite es 100 km/h para vehículos ligeros según el RNT.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('928f8eb7-33dc-57a9-b39e-f414590d6174', '477d137c-a3dc-5c24-bc1e-d0922b1f1924', $$80 km/h$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('54605ac5-5631-59ba-8c41-863d1d549a5d', '477d137c-a3dc-5c24-bc1e-d0922b1f1924', $$100 km/h$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('fd4f66a3-30ed-5870-bec8-87154a344a01', '477d137c-a3dc-5c24-bc1e-d0922b1f1924', $$120 km/h$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('292151f2-008a-5228-bc7c-d7589be27c7d', '477d137c-a3dc-5c24-bc1e-d0922b1f1924', $$60 km/h$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 14
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('0f3d6f28-cf7f-59fe-bf73-fbb0fd41e435', '00000000-0036-4000-8000-000000000001',
  $$¿Qué significa una línea blanca continua al borde derecho de la calzada?$$,
  $$La línea blanca continua al borde derecho delimita el límite de la calzada.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('02e05e32-594f-5ce0-8508-abde97be81c0', '0f3d6f28-cf7f-59fe-bf73-fbb0fd41e435', $$Prohibición de estacionar$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f2d65aa5-e6db-5475-9630-24505b1c7364', '0f3d6f28-cf7f-59fe-bf73-fbb0fd41e435', $$Límite de la calzada; no cruzar$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('60fd38b0-a90f-5183-bfdb-73fac3c41428', '0f3d6f28-cf7f-59fe-bf73-fbb0fd41e435', $$Carril exclusivo de buses$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7dfc6b3d-e212-5099-91e8-bee8bb0bb3d0', '0f3d6f28-cf7f-59fe-bf73-fbb0fd41e435', $$Zona de carga y descarga$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 15
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('46f8b2c4-2234-56b3-889d-6ffda8e85e0f', '00000000-0036-4000-8000-000000000001',
  $$Al conducir por zona de neblina densa, el conductor debe:$$,
  $$Con neblina: luces de emergencia o antiniebla (no altas), velocidad reducida y mayor distancia.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('202f5f11-5a7b-55e8-98d4-b31ef691dd9d', '46f8b2c4-2234-56b3-889d-6ffda8e85e0f', $$Activar luces altas para mayor visibilidad$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d2a52534-85c2-5749-b198-385eb031d3df', '46f8b2c4-2234-56b3-889d-6ffda8e85e0f', $$Activar luces de emergencia y reducir velocidad manteniendo distancia segura$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8b81caf7-5236-5e4b-ad23-5389a171a3cc', '46f8b2c4-2234-56b3-889d-6ffda8e85e0f', $$Detener el vehículo en medio de la pista$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2f099630-3009-505e-8083-09751699d11f', '46f8b2c4-2234-56b3-889d-6ffda8e85e0f', $$Acelerar para salir rápido de la zona$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 16
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('270ac69b-169b-5b95-85e3-3a4b4f6e9ae9', '00000000-0036-4000-8000-000000000001',
  $$¿Cuándo puede realizar un giro en U el conductor?$$,
  $$El giro en U solo está permitido donde la señalización lo autorice.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('df186988-543c-513b-ba71-6fd5aeab8764', '270ac69b-169b-5b95-85e3-3a4b4f6e9ae9', $$En cualquier intersección libre$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4984037c-ebc8-55bf-94f2-e661aef44d9d', '270ac69b-169b-5b95-85e3-3a4b4f6e9ae9', $$Solo donde esté expresamente permitido y sin interferir el tráfico$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('88c528b8-6623-5f11-83a5-7f49763c199d', '270ac69b-169b-5b95-85e3-3a4b4f6e9ae9', $$Siempre que el giro sea rápido$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7f1f3ccc-9240-5d58-8b88-5c5b6a7d68ff', '270ac69b-169b-5b95-85e3-3a4b4f6e9ae9', $$En vías de un solo sentido$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 17
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('60990dbc-e0c7-576b-9577-daa4c21b9aa7', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es la función de las luces de estacionamiento (posición)?$$,
  $$Las luces de posición indican el ancho y presencia del vehículo en condiciones de poca visibilidad.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4ffaa9fe-3366-570a-8799-906fd0490014', '60990dbc-e0c7-576b-9577-daa4c21b9aa7', $$Iluminar la carretera de noche$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4e4f9f59-c8a2-50dd-ac70-8292fdb8aa13', '60990dbc-e0c7-576b-9577-daa4c21b9aa7', $$Indicar las dimensiones del vehículo cuando está detenido o en movimiento lento$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0f9b5e04-12e6-5a4c-b733-46270f6760c0', '60990dbc-e0c7-576b-9577-daa4c21b9aa7', $$Señalizar que va a girar$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f1e5a964-536d-5195-b070-4423beddd219', '60990dbc-e0c7-576b-9577-daa4c21b9aa7', $$Avisar que tiene problemas mecánicos$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 18
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('d71cf56e-a130-5bc7-a05d-793b7b5901c0', '00000000-0036-4000-8000-000000000001',
  $$Antes de abandonar el vehículo oficial estacionado, ¿cuál es la acción correcta?$$,
  $$Al dejar el vehículo: apagar motor, retirar llave, cerrar ventanas y verificar estacionamiento correcto.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('593de06a-0a1f-599b-ad07-85f6a1c0cc78', 'd71cf56e-a130-5bc7-a05d-793b7b5901c0', $$Dejar el motor encendido para el aire acondicionado$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0f942550-f95d-5b35-997a-f71bf809a5c8', 'd71cf56e-a130-5bc7-a05d-793b7b5901c0', $$Apagar el motor, retirar la llave, subir vidrios y verificar estacionamiento correcto$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('fe704cb0-0ada-5283-9720-eceadaaaeab7', 'd71cf56e-a130-5bc7-a05d-793b7b5901c0', $$Solo apagar el motor y bajar$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bbc4e0cc-aa29-530f-8387-5e0cd4f0e5b3', 'd71cf56e-a130-5bc7-a05d-793b7b5901c0', $$Dejar las luces bajas encendidas$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 19
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('d8d40a36-d6c8-5de4-aa8d-ae1535cadff5', '00000000-0036-4000-8000-000000000001',
  $$¿Qué indica una señal con fondo azul y símbolo de flecha curva hacia arriba?$$,
  $$Las señales con fondo azul y flecha indican dirección obligatoria de circulación.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4a5f3317-f159-5c5a-bcf2-fa170e8aae8d', 'd8d40a36-d6c8-5de4-aa8d-ae1535cadff5', $$Dirección obligatoria de circulación$$, true, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('521ef3e0-560d-59ae-9032-f62a9e08edd3', 'd8d40a36-d6c8-5de4-aa8d-ae1535cadff5', $$Zona de curva peligrosa$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7d701c2c-7650-5d0f-9ff5-4a6cfb90f982', 'd8d40a36-d6c8-5de4-aa8d-ae1535cadff5', $$Permitido girar en U$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('26a9e199-ef5f-56e7-9da9-834bc445d0be', 'd8d40a36-d6c8-5de4-aa8d-ae1535cadff5', $$Zona de descanso$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 20
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('01178d16-d110-5a10-b088-f6c631323f24', '00000000-0036-4000-8000-000000000001',
  $$En una rotonda o glorieta, ¿quién tiene preferencia de paso?$$,
  $$En rotondas, los vehículos que circulan dentro tienen preferencia sobre los que ingresan.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9495417c-ff3b-53a6-8a76-6164523afec0', '01178d16-d110-5a10-b088-f6c631323f24', $$El vehículo que ingresa a la rotonda$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('fdb59abe-949a-54ab-88b4-89f0f98a5123', '01178d16-d110-5a10-b088-f6c631323f24', $$El vehículo que ya circula dentro de la rotonda$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3d8ff638-f9c8-505f-b634-2359f08bacee', '01178d16-d110-5a10-b088-f6c631323f24', $$El vehículo más grande$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('03c128f9-16fd-57db-bc57-87ad3ab94d6e', '01178d16-d110-5a10-b088-f6c631323f24', $$El primero que llegó$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 21
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('efc87294-9020-5452-b80a-718c8da7129e', '00000000-0036-4000-8000-000000000001',
  $$¿Cuándo es obligatorio el cinturón de seguridad en un vehículo oficial?$$,
  $$El cinturón es obligatorio para conductor y pasajeros en todo tipo de vía.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0c753351-bed4-5373-a081-ab57244c8c06', 'efc87294-9020-5452-b80a-718c8da7129e', $$Solo en carretera$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c03f9dd6-e243-52b1-95c8-f1be006538c4', 'efc87294-9020-5452-b80a-718c8da7129e', $$Solo el conductor$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('013af12d-f3d9-5f2f-96c2-1407a3ee13d3', 'efc87294-9020-5452-b80a-718c8da7129e', $$Conductor y todos los pasajeros en todo momento$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9ce1f11b-3ce1-532d-8bab-6b65f87990fb', 'efc87294-9020-5452-b80a-718c8da7129e', $$Solo si supera 60 km/h$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 22
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('7e3d8c6c-005c-57a7-91e0-a233258c260d', '00000000-0036-4000-8000-000000000001',
  $$¿Qué debe hacer el conductor si los frenos fallan completamente?$$,
  $$Ante falla total de frenos: freno de mano suavemente, reducir marchas y buscar zona segura.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0935fcba-16de-5414-a1aa-5524de027cba', '7e3d8c6c-005c-57a7-91e0-a233258c260d', $$Saltar del vehículo$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('86a49417-0a3f-524f-80c3-5324b6869729', '7e3d8c6c-005c-57a7-91e0-a233258c260d', $$Usar el freno de mano gradualmente, reducir marchas y buscar salida segura$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('fb7469cf-a23b-5b96-9a16-016239d2a61b', '7e3d8c6c-005c-57a7-91e0-a233258c260d', $$Acelerar para llegar a un taller$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7f4a33a0-4374-575e-97f9-7027e152d7be', '7e3d8c6c-005c-57a7-91e0-a233258c260d', $$Tocar el claxon y esperar$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 23
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('451dca98-6f46-5b66-9ee1-202935f4907d', '00000000-0036-4000-8000-000000000001',
  $$¿Qué indica la luz ámbar intermitente de un semáforo?$$,
  $$Luz ámbar intermitente: precaución, reducir velocidad y prepararse para detenerse.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c90dc763-d8a7-5119-92ae-9273f5c116c1', '451dca98-6f46-5b66-9ee1-202935f4907d', $$Alto total obligatorio$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('09d00ea9-0c34-5725-802a-b068f2a7f2c0', '451dca98-6f46-5b66-9ee1-202935f4907d', $$Precaución: reducir velocidad y estar listo para detenerse$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('cb31bd87-31e8-5e1b-aedd-b57a04793d91', '451dca98-6f46-5b66-9ee1-202935f4907d', $$Paso libre como verde$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('60004ab0-c415-53c8-aa1b-bc615c1acb89', '451dca98-6f46-5b66-9ee1-202935f4907d', $$Falla del semáforo$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 24
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('03b4dd41-f07b-5d04-bd7b-a5f5a1a2d20e', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es la sanción por no respetar la señal de PARE?$$,
  $$No respetar el PARE genera papeleta con multa y descuento de puntos en la licencia.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('5c343a3f-bf75-50ac-a6c2-c18673dc346d', '03b4dd41-f07b-5d04-bd7b-a5f5a1a2d20e', $$Amonestación verbal$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('207e11de-4f0e-5487-bc55-e3e4441f11b7', '03b4dd41-f07b-5d04-bd7b-a5f5a1a2d20e', $$Papeleta con multa y descuento de puntos de la licencia$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8e09310f-18f9-5a08-b650-60dca765c4a5', '03b4dd41-f07b-5d04-bd7b-a5f5a1a2d20e', $$Solo multa económica$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('310abe27-5a2e-53c1-bd85-60410fb45c74', '03b4dd41-f07b-5d04-bd7b-a5f5a1a2d20e', $$Ninguna si no hay accidente$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 25
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('b4c10f29-c190-5a6c-89af-bacd03cf80d3', '00000000-0036-4000-8000-000000000001',
  $$En una vía con carril central de giro a la izquierda, ¿puede el conductor usar ese carril para adelantar?$$,
  $$El carril central de giro es exclusivo para girar; usarlo para adelantar es infracción.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bb1c6a49-39ce-50d8-a2e8-3ed3053d4ae1', 'b4c10f29-c190-5a6c-89af-bacd03cf80d3', $$Sí, si el tráfico contrario está lejos$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('33df75c2-4d2a-50fb-83a2-782054bb9119', 'b4c10f29-c190-5a6c-89af-bacd03cf80d3', $$No, es exclusivo para maniobras de giro a la izquierda$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8e08fcfd-6414-58c5-bfc2-44b136053ea0', 'b4c10f29-c190-5a6c-89af-bacd03cf80d3', $$Sí, si la maniobra es rápida$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7cad9958-d28f-5be0-994e-be8d0ee2b893', 'b4c10f29-c190-5a6c-89af-bacd03cf80d3', $$Solo en horas de poco tráfico$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 26
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('877fd499-b494-5cd7-9695-33ea3420b79a', '00000000-0036-4000-8000-000000000001',
  $$Al inicio de jornada el conductor nota el nivel de aceite del motor por debajo del mínimo. ¿Qué hace?$$,
  $$El nivel de aceite se completa con el lubricante especificado y se reporta para evaluar posibles fugas.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b39701dc-e43a-5065-bafc-3c27ad83fd6c', '877fd499-b494-5cd7-9695-33ea3420b79a', $$Agrega agua destilada$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('67521f3d-70a3-5eb8-8fa5-9074bb174e5c', '877fd499-b494-5cd7-9695-33ea3420b79a', $$Completa con el aceite recomendado por el fabricante y reporta al área de transportes$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8b6bf8a3-10d3-57fd-8b16-f0df613d527e', '877fd499-b494-5cd7-9695-33ea3420b79a', $$Conduce normal, no es urgente$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b085341e-e6ee-5681-92d2-3cf34d8c6359', '877fd499-b494-5cd7-9695-33ea3420b79a', $$Agrega cualquier aceite disponible$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 27
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('667630b7-1931-51c1-9fa1-6e9fc17bcf61', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es el síntoma más común de falla en la dirección hidráulica?$$,
  $$La dirección hidráulica con fallas presenta resistencia al girar y ruido de bomba por falta de fluido.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('29da89b1-d11b-5fd8-9ab8-04011c07d77f', '667630b7-1931-51c1-9fa1-6e9fc17bcf61', $$Ruido en los frenos$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4fe391dc-8d62-5dbf-9ad6-2f64c9cedddc', '667630b7-1931-51c1-9fa1-6e9fc17bcf61', $$Dificultad al girar el volante y posible ruido de bomba$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('190d9d95-ce6a-5d3f-bde9-297ce676319e', '667630b7-1931-51c1-9fa1-6e9fc17bcf61', $$Vibración en los asientos$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a8cc2e50-f148-5cc9-a75e-b4022a9fc229', '667630b7-1931-51c1-9fa1-6e9fc17bcf61', $$Humo por el escape$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 28
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('2536c198-7c26-571c-a834-f51bb3545f67', '00000000-0036-4000-8000-000000000001',
  $$¿Con qué frecuencia mínima debe verificarse la presión de los neumáticos de un vehículo oficial?$$,
  $$La presión de neumáticos se revisa semanalmente o antes de viajes largos.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4e340b6d-7374-532f-a000-30bd3329348f', '2536c198-7c26-571c-a834-f51bb3545f67', $$Una vez al mes$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7eb42bea-c16a-53a6-8b5d-72b22275cf13', '2536c198-7c26-571c-a834-f51bb3545f67', $$Semanalmente o antes de cada comisión larga$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c3f34942-7f12-5e2d-888b-28e7befe9452', '2536c198-7c26-571c-a834-f51bb3545f67', $$Solo cuando el vehículo lo indique con alarma$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f96f9c43-89a3-5cb5-a865-1af8a25fb232', '2536c198-7c26-571c-a834-f51bb3545f67', $$Una vez al año$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 29
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('1f1edbab-4356-5532-8a9c-70251101d7c1', '00000000-0036-4000-8000-000000000001',
  $$El termómetro del motor sube a la zona roja del tablero. La acción inmediata correcta es:$$,
  $$Ante sobrecalentamiento: zona segura, apagar motor, esperar y nunca abrir el radiador en caliente.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b8ffb4a0-3eff-57f6-9b96-234195da765b', '1f1edbab-4356-5532-8a9c-70251101d7c1', $$Apagar el motor de golpe y abrir el capó$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ce2c0e84-21ee-5818-9e84-18d944bea201', '1f1edbab-4356-5532-8a9c-70251101d7c1', $$Estacionar en zona segura, apagar motor, esperar enfriamiento y reportar la incidencia$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('754710f3-94d3-5b39-a47f-8f9820a4c05e', '1f1edbab-4356-5532-8a9c-70251101d7c1', $$Continuar a menor velocidad$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('874d347f-1a99-5305-b0a8-2183fb7acb60', '1f1edbab-4356-5532-8a9c-70251101d7c1', $$Abrir el capó mientras conduce$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 30
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('0eb008d9-f180-5ece-900a-a90866f99cf2', '00000000-0036-4000-8000-000000000001',
  $$¿Qué función cumple el líquido refrigerante en el motor?$$,
  $$El refrigerante circula absorbiendo calor del motor y disipándolo en el radiador.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('6c1e4dd2-041c-5ae4-a8e8-181e993eb2bc', '0eb008d9-f180-5ece-900a-a90866f99cf2', $$Lubricar las partes móviles$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9c9d7a10-a285-5c20-af7e-ee88947ac93e', '0eb008d9-f180-5ece-900a-a90866f99cf2', $$Absorber y disipar el calor generado por la combustión$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4946988a-7e9e-578d-a3ea-28f4db6ce507', '0eb008d9-f180-5ece-900a-a90866f99cf2', $$Limpiar el sistema de combustible$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('6fefb8a8-5043-506b-8e36-78519cc849cc', '0eb008d9-f180-5ece-900a-a90866f99cf2', $$Reducir el consumo de gasolina$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 31
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('b0abc96c-8615-5469-9b1a-608d54182436', '00000000-0036-4000-8000-000000000001',
  $$El pedal de embrague se siente muy duro. La causa más probable es:$$,
  $$El embrague duro indica problema en el sistema hidráulico o disco de embrague desgastado.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('89f75d13-6ed8-577f-92b7-bad163c0f6f9', 'b0abc96c-8615-5469-9b1a-608d54182436', $$Desgaste de pastillas de freno$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e1103e38-1df3-5303-aad1-ccd2c10998fe', 'b0abc96c-8615-5469-9b1a-608d54182436', $$Falla en el sistema hidráulico del embrague o desgaste del disco$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1d494aae-c987-521b-9af6-30c349274ad5', 'b0abc96c-8615-5469-9b1a-608d54182436', $$Neumáticos desinflados$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('39d1a67e-0211-53a4-ae14-a22ef6b1436a', 'b0abc96c-8615-5469-9b1a-608d54182436', $$Batería descargada$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 32
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('e056391f-a2ba-5c4f-ad0c-3c8874d1b629', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es el propósito de la alineación y balanceo de neumáticos?$$,
  $$Alineación corrige dirección y balanceo elimina vibraciones, ambos alargan la vida de neumáticos.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d9f39f5c-0c24-5acd-88f7-df24a9267679', 'e056391f-a2ba-5c4f-ad0c-3c8874d1b629', $$Aumentar el consumo de combustible$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7a368eaa-d453-53e4-9d12-19d92cbf5448', 'e056391f-a2ba-5c4f-ad0c-3c8874d1b629', $$Garantizar que el vehículo ruede recto y sin vibraciones, alargando la vida útil de los neumáticos$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3aca54a5-02db-5453-8f16-ed65c0aaeb55', 'e056391f-a2ba-5c4f-ad0c-3c8874d1b629', $$Mejorar la potencia del motor$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3a7bd3ce-cc4f-54c4-bc05-a31246b6c56d', 'e056391f-a2ba-5c4f-ad0c-3c8874d1b629', $$Reducir el ruido del motor$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 33
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('f0cba31e-da4a-5da5-a057-19f55dd8fd9d', '00000000-0036-4000-8000-000000000001',
  $$La luz de batería se enciende en el tablero mientras conduce. ¿Qué indica?$$,
  $$Luz de batería encendida indica falla del alternador; el vehículo podría quedarse sin energía.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b9c3a725-49f7-5616-ace3-bdd017fb0917', 'f0cba31e-da4a-5da5-a057-19f55dd8fd9d', $$Batería con carga completa$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('372d0ac3-aba8-5394-b411-cd135fad3e8d', 'f0cba31e-da4a-5da5-a057-19f55dd8fd9d', $$El alternador no está cargando la batería correctamente$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2502586c-8162-563f-8574-98f18099b115', 'f0cba31e-da4a-5da5-a057-19f55dd8fd9d', $$Las luces están encendidas$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b55f28a4-dcb5-5bd9-b125-1c8611399aa7', 'f0cba31e-da4a-5da5-a057-19f55dd8fd9d', $$El motor está frío$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 34
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('eb0d2866-fd84-5bae-9e58-39bd55a0a96b', '00000000-0036-4000-8000-000000000001',
  $$¿Qué verificación debe realizar el conductor antes de una comisión larga (más de 2 horas)?$$,
  $$Antes de comisiones largas: inspección completa de fluidos, neumáticos, luces y documentación.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b63835c1-3bd5-5623-903d-548109c44d9a', 'eb0d2866-fd84-5bae-9e58-39bd55a0a96b', $$Solo revisar el nivel de gasolina$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ab26f3cf-59e1-5853-8d0a-71fe3527e9fd', 'eb0d2866-fd84-5bae-9e58-39bd55a0a96b', $$Revisar aceite, agua, líquido de frenos, presión de neumáticos, luces y combustible$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2bf372ba-e80b-5ad0-9320-ad6b322c14a7', 'eb0d2866-fd84-5bae-9e58-39bd55a0a96b', $$Solo revisar las llantas$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d0c5246d-7089-52d6-8b1c-90ea5592bf40', 'eb0d2866-fd84-5bae-9e58-39bd55a0a96b', $$Solo limpiar el parabrisas$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 35
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('255d974a-2b14-58f7-a772-b8e9bbb9f9a3', '00000000-0036-4000-8000-000000000001',
  $$¿Cuándo debe reemplazarse el filtro de aire del motor?$$,
  $$El filtro de aire se reemplaza según el manual del fabricante o cuando está sucio u obstruido.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8ef17657-8fd0-579f-a529-d0211b62da1a', '255d974a-2b14-58f7-a772-b8e9bbb9f9a3', $$Cada 1,000 km$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('055503b2-773b-5e47-9d7e-91e38e0d16c2', '255d974a-2b14-58f7-a772-b8e9bbb9f9a3', $$Según el intervalo del fabricante o cuando esté visiblemente obstruido$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e66490ce-edea-509d-93cd-ca38ec496261', '255d974a-2b14-58f7-a772-b8e9bbb9f9a3', $$Solo cuando el vehículo pierde potencia notoriamente$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('149d0b91-2639-5c15-9b31-a2425e658bff', '255d974a-2b14-58f7-a772-b8e9bbb9f9a3', $$Nunca, es de por vida$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 36
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('8d92d3cb-67a1-5f06-9e4a-6ce49c780d85', '00000000-0036-4000-8000-000000000001',
  $$La luz CHECK ENGINE se enciende en el tablero. ¿Qué hace el conductor?$$,
  $$CHECK ENGINE indica falla electrónica; debe diagnosticarse con escáner para evitar daños mayores.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('36d3b3fb-ba67-5cde-810e-e8e1fb757a17', '8d92d3cb-67a1-5f06-9e4a-6ce49c780d85', $$La ignora si el vehículo funciona normal$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('17de4401-873e-50ac-afb5-adcd16b1064a', '8d92d3cb-67a1-5f06-9e4a-6ce49c780d85', $$Reporta al área de mantenimiento para diagnóstico y evita viajes largos hasta revisión$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('159fe6a2-41d3-533f-9846-b7b409f24aa2', '8d92d3cb-67a1-5f06-9e4a-6ce49c780d85', $$Apaga y enciende el motor$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b613f458-67d2-5f1c-ab7c-089205e23212', '8d92d3cb-67a1-5f06-9e4a-6ce49c780d85', $$Solo anota en el cuaderno de ruta$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 37
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('0b275122-bf16-5da8-b539-11091f58bd9a', '00000000-0036-4000-8000-000000000001',
  $$¿Qué indica el desgaste excesivo en el centro del neumático (más desgastado en el centro que en los bordes)?$$,
  $$El desgaste en el centro indica sobreinflado: el neumático apoya solo en la banda central.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('6705679c-93e7-57e6-8915-452083fdcb5b', '0b275122-bf16-5da8-b539-11091f58bd9a', $$Presión insuficiente (desinflado)$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('054673a5-0017-5497-b29d-46af86bdb043', '0b275122-bf16-5da8-b539-11091f58bd9a', $$Presión excesiva (sobreinflado)$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('791d9515-02e5-50bf-9c80-705266de5f60', '0b275122-bf16-5da8-b539-11091f58bd9a', $$Falta de alineación$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('dbd4672e-0a3b-5a97-b9ce-5855bfee0d19', '0b275122-bf16-5da8-b539-11091f58bd9a', $$Desgaste normal$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 38
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('ca43e3c9-ae37-5792-9e4b-ada9f6fe84f9', '00000000-0036-4000-8000-000000000001',
  $$¿Qué se debe usar para limpiar el parabrisas del vehículo oficial sin rayaduras?$$,
  $$Se usa el sistema limpiaparabrisas con líquido adecuado para evitar rayaduras que afecten la visibilidad.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ea561fa7-183f-539e-8f5a-beaf5e40d380', 'ca43e3c9-ae37-5792-9e4b-ada9f6fe84f9', $$Periódico y agua$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('48b42275-ec07-5460-922b-e292b4061c00', 'ca43e3c9-ae37-5792-9e4b-ada9f6fe84f9', $$El limpiaparabrisas del vehículo con líquido apropiado$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('528bcd8f-c52d-5def-929b-65b0ee04c21d', 'ca43e3c9-ae37-5792-9e4b-ada9f6fe84f9', $$Arena húmeda$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e4733f8b-167a-595a-8641-b034e4fe7d2f', 'ca43e3c9-ae37-5792-9e4b-ada9f6fe84f9', $$Cualquier trapo disponible$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 39
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('02db4f5b-1d34-56f8-b5f2-bc23184ac374', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es el riesgo de conducir con pastillas de freno excesivamente desgastadas?$$,
  $$Las pastillas desgastadas reducen drásticamente la capacidad de frenado.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9f10c916-bbc8-599d-a3cf-2cdddc906f86', '02db4f5b-1d34-56f8-b5f2-bc23184ac374', $$Mayor consumo de combustible$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('034b5a44-590a-5214-9c92-317802f7ef16', '02db4f5b-1d34-56f8-b5f2-bc23184ac374', $$Pérdida de eficiencia del frenado: riesgo de no poder detener el vehículo a tiempo$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('68649b48-1316-5670-be34-3651954311a9', '02db4f5b-1d34-56f8-b5f2-bc23184ac374', $$Vibración del volante$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('29ab0b99-3930-556d-8a6a-8ef02b7de7e1', '02db4f5b-1d34-56f8-b5f2-bc23184ac374', $$Dificultad para girar$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 40
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('6be65063-e41e-584a-ab43-85c0fde8ba59', '00000000-0036-4000-8000-000000000001',
  $$Al frenar, el vehículo 'jala' hacia un lado. La causa más probable es:$$,
  $$El jalón al frenar suele indicar neumático desinflado o pinza de freno atascada.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d9b7f529-de5a-5d76-bced-c92a0e9daa80', '6be65063-e41e-584a-ab43-85c0fde8ba59', $$Presión de neumáticos desigual o pinza de freno atascada$$, true, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ec4f811b-05f4-5119-805e-580447af0f35', '6be65063-e41e-584a-ab43-85c0fde8ba59', $$Falta de aceite$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('82c5a5ff-73f7-5aa7-b78d-362dd2b8ce5c', '6be65063-e41e-584a-ab43-85c0fde8ba59', $$Problema de transmisión$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d6d5597e-3142-5232-958f-8fcf29e6633a', '6be65063-e41e-584a-ab43-85c0fde8ba59', $$Batería descargada$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 41
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('5ba97496-d272-5722-ad69-75f60fb54ae2', '00000000-0036-4000-8000-000000000001',
  $$¿Qué indica el símbolo de un volante con signo de exclamación en el tablero?$$,
  $$El volante con exclamación indica falla en la dirección asistida eléctrica (EPS).$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('839c256e-30b8-56ee-b74c-7acfc9f8cc49', '5ba97496-d272-5722-ad69-75f60fb54ae2', $$Falla en el sistema de dirección asistida eléctrica$$, true, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a4998b9c-4c32-5b47-a297-0c95aa11d852', '5ba97496-d272-5722-ad69-75f60fb54ae2', $$Problema con el cinturón$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e977de0d-03c3-52e2-9549-33ad4ab874bf', '5ba97496-d272-5722-ad69-75f60fb54ae2', $$Falla del motor$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('24474dc3-8b9b-5589-96a7-1c59caf0f6ea', '5ba97496-d272-5722-ad69-75f60fb54ae2', $$Nivel bajo de combustible$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 42
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('753e85cb-c846-5402-844d-38e2d81c4014', '00000000-0036-4000-8000-000000000001',
  $$¿Con qué frecuencia se cambia el aceite de motor en un vehículo oficial en condiciones normales?$$,
  $$El intervalo de cambio de aceite depende del tipo de aceite y las indicaciones del fabricante.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('cc0d3b42-98b2-5916-8334-9316eefb61b3', '753e85cb-c846-5402-844d-38e2d81c4014', $$Cada 500 km$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8317e1d5-1995-5a71-ac41-7f0a86276535', '753e85cb-c846-5402-844d-38e2d81c4014', $$Según el tipo de aceite y el manual del fabricante (generalmente cada 5,000-10,000 km)$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c3bd427f-b406-507c-b863-09e0a546bf70', '753e85cb-c846-5402-844d-38e2d81c4014', $$Cada 50,000 km$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7eb7f84d-ce15-547c-b709-5e4a4d765978', '753e85cb-c846-5402-844d-38e2d81c4014', $$Solo cuando el aceite se vea negro$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 43
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('aa53500f-9e4f-567d-896b-e0b761faffec', '00000000-0036-4000-8000-000000000001',
  $$Si un neumático explota mientras conduce, ¿cuál es la maniobra correcta?$$,
  $$Ante un reventón: sujetar volante firmemente, no frenar bruscamente y dejar frenar solo antes de orillarse.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a38cf9b5-11cd-5758-8b99-0f469062ad22', 'aa53500f-9e4f-567d-896b-e0b761faffec', $$Frenar bruscamente de inmediato$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b9ef1370-14fb-5b52-bd06-70f398d9c8cf', 'aa53500f-9e4f-567d-896b-e0b761faffec', $$Mantener el volante firme, no frenar bruscamente, dejar desacelerar y orillarse$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c98d56b4-f8d5-5ef2-8792-06972c42a9b3', 'aa53500f-9e4f-567d-896b-e0b761faffec', $$Girar el volante bruscamente hacia el lado contrario$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('59b83823-3220-5d56-90c8-3fa47ca9644c', 'aa53500f-9e4f-567d-896b-e0b761faffec', $$Acelerar para mantener el control$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 44
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('7e1e1bfb-067d-5a5f-9c9c-f7d7c8d48a24', '00000000-0036-4000-8000-000000000001',
  $$¿Qué función adicional tiene el freno de estacionamiento (freno de mano)?$$,
  $$El freno de mano puede usarse como emergencia ante falla de frenos principales, aplicándolo gradualmente.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e1f6d2ff-7578-5863-a268-5c9a9b3137bb', '7e1e1bfb-067d-5a5f-9c9c-f7d7c8d48a24', $$Enfriar los frenos principales$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('424b9df3-2322-5cc7-8e3e-e2d29b8ce2b9', '7e1e1bfb-067d-5a5f-9c9c-f7d7c8d48a24', $$Actuar como freno de emergencia ante falla total de los frenos principales$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0e1f9173-fb26-53c5-acda-e3abb62e3c26', '7e1e1bfb-067d-5a5f-9c9c-f7d7c8d48a24', $$Mejorar la dirección$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('768f8510-b5af-5123-bb20-d1cc15ed008c', '7e1e1bfb-067d-5a5f-9c9c-f7d7c8d48a24', $$Estabilizar la suspensión$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 45
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('cac222e8-23f5-5316-ba3d-9d3dc43779bd', '00000000-0036-4000-8000-000000000001',
  $$¿Qué documento acredita que un vehículo pasó la revisión técnica vehicular obligatoria en Perú?$$,
  $$La ITV es la certificación obligatoria que evalúa las condiciones técnicas y de seguridad del vehículo.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('dc25388e-d7a6-514a-9e65-f8b760cf41f1', 'cac222e8-23f5-5316-ba3d-9d3dc43779bd', $$La tarjeta de propiedad$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e565f13c-902c-55fb-83e9-768515953c86', 'cac222e8-23f5-5316-ba3d-9d3dc43779bd', $$El certificado de Inspección Técnica Vehicular (ITV) emitido por planta autorizada$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('dbad5cfb-8879-526c-a858-9eeb8beb2df3', 'cac222e8-23f5-5316-ba3d-9d3dc43779bd', $$La SOAT vigente$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ef9212b6-0635-5f85-872f-c8955e0f38ee', 'cac222e8-23f5-5316-ba3d-9d3dc43779bd', $$El seguro vehicular$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 46
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('3fad5767-a8d6-5556-824a-3868e65c13c0', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es el orden correcto del protocolo PAS en un accidente de tránsito?$$,
  $$PAS: 1. Proteger la zona, 2. Avisar a emergencias, 3. Socorrer a los heridos.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('6b936ade-c1e0-58ad-9254-6e628cd171d5', '3fad5767-a8d6-5556-824a-3868e65c13c0', $$Socorrer, Avisar, Proteger$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('856b57f6-5391-5936-92f6-a2cf8b9aa886', '3fad5767-a8d6-5556-824a-3868e65c13c0', $$Proteger, Avisar, Socorrer$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d28cadc0-a8f2-55d9-bbd5-7ad05de3a938', '3fad5767-a8d6-5556-824a-3868e65c13c0', $$Avisar, Socorrer, Proteger$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ad2ea7c3-7a25-59c0-a40a-ebca865c6de0', '3fad5767-a8d6-5556-824a-3868e65c13c0', $$Proteger, Socorrer, Avisar$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 47
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('724edf3d-56ba-5ad7-b844-8d0ff554bca9', '00000000-0036-4000-8000-000000000001',
  $$¿Cuándo debe mover a un herido inconsciente en un accidente?$$,
  $$Mover a un herido inconsciente puede agravar lesiones medulares. Solo se mueve ante peligro inmediato.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9df132e3-fdc5-5de0-a052-aa1476c6e6bb', '724edf3d-56ba-5ad7-b844-8d0ff554bca9', $$Siempre de inmediato$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e98d72cb-81e3-5017-8577-b57c15406292', '724edf3d-56ba-5ad7-b844-8d0ff554bca9', $$Solo si existe peligro inminente (incendio, derrumbe) y no puede esperar a paramédicos$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('505c1d86-4165-5cd3-b76d-5566def846f9', '724edf3d-56ba-5ad7-b844-8d0ff554bca9', $$Cuando empiece a moverse solo$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('247b7ed0-b8be-5076-8bc3-f1cce9aeb532', '724edf3d-56ba-5ad7-b844-8d0ff554bca9', $$Después de 15 minutos de espera$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 48
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('51ee5876-48a8-5c42-a983-27e73b16491c', '00000000-0036-4000-8000-000000000001',
  $$¿Qué es lo primero al llegar a la escena de un accidente con heridos?$$,
  $$Primera acción: proteger la zona con triángulos y luces de emergencia para evitar un segundo accidente.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0f229dd7-dda4-5ff2-a1ab-5d5fb9335a30', '51ee5876-48a8-5c42-a983-27e73b16491c', $$Tomar fotos para el informe$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e1ba2ad9-1497-5028-99eb-234ba52a1ab5', '51ee5876-48a8-5c42-a983-27e73b16491c', $$Proteger la zona señalizando para evitar nuevos accidentes$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9c7f1735-6eef-5b1b-8e23-5c1bf2a44f5c', '51ee5876-48a8-5c42-a983-27e73b16491c', $$Revisar los daños del vehículo accidentado$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('993ed3d8-306d-53b2-a65e-c7b60baad6fa', '51ee5876-48a8-5c42-a983-27e73b16491c', $$Llamar a los familiares del herido$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 49
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('b32b27b7-b673-5dea-9d3d-a64473730f05', '00000000-0036-4000-8000-000000000001',
  $$¿Cómo se detiene una hemorragia externa mientras espera la ambulancia?$$,
  $$La presión directa es el método inicial de control de hemorragias. El torniquete solo en masivas de extremidades.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f2f88e0f-08fe-5944-9f75-044a5a8ad032', 'b32b27b7-b673-5dea-9d3d-a64473730f05', $$Lavar con alcohol y aplicar hielo$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('561f4f30-ddca-579a-be66-a7a1606ba0ea', 'b32b27b7-b673-5dea-9d3d-a64473730f05', $$Aplicar presión directa y constante con paño limpio sobre la herida$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3d18fc96-aa91-54fe-b201-aae9829007c5', 'b32b27b7-b673-5dea-9d3d-a64473730f05', $$Elevar el miembro y no tocarlo$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ee3fa37c-2bf6-500b-87b1-9ac99673bf2a', 'b32b27b7-b673-5dea-9d3d-a64473730f05', $$Aplicar torniquete en todos los casos$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 50
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('a33323d2-4151-5598-a8cc-782ef35428e8', '00000000-0036-4000-8000-000000000001',
  $$Un funcionario que viajaba pierde el conocimiento repentinamente. ¿Cuál es su primera acción?$$,
  $$Ante pérdida de consciencia: zona segura, verificar pulso/respiración, activar SAMU (117).$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3bd2c5e5-edbf-5eaf-b156-147f1160986f', 'a33323d2-4151-5598-a8cc-782ef35428e8', $$Darle agua para que se recupere$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d58e6a64-faf9-5720-b270-effd129b0115', 'a33323d2-4151-5598-a8cc-782ef35428e8', $$Detener el vehículo en forma segura, verificar respiración y llamar al SAMU (117)$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c2583fc2-520f-5ede-874c-cd3cd2e84ad5', 'a33323d2-4151-5598-a8cc-782ef35428e8', $$Continuar hacia el destino y avisar al llegar$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8f6b1ac2-5b9d-5566-92f1-dabde31d41f5', 'a33323d2-4151-5598-a8cc-782ef35428e8', $$Abrir ventanas y esperar$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 51
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('f906bf86-f021-587f-81d3-3cc4231b9aab', '00000000-0036-4000-8000-000000000001',
  $$¿Cuáles son los números de emergencia médica y policial en Lima, Perú?$$,
  $$En Lima: SAMU 117, Bomberos 116, Policía Nacional 105.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0ee15665-a570-5e71-834c-326341b34c67', 'f906bf86-f021-587f-81d3-3cc4231b9aab', $$118 y 105$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('64733d30-5c4b-5d36-a9ce-f81153a31be9', 'f906bf86-f021-587f-81d3-3cc4231b9aab', $$117 (SAMU), 116 (Bomberos) y 105 (PNP)$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('dbdec207-efcb-5e4c-9e76-4de7d1cff4d6', 'f906bf86-f021-587f-81d3-3cc4231b9aab', $$911 y 112$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('08250f1f-f27c-5ca7-8667-1e9375d87318', 'f906bf86-f021-587f-81d3-3cc4231b9aab', $$119 y 106$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 52
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('f4a919fa-0bb2-5412-bcc6-bf4ec62b57be', '00000000-0036-4000-8000-000000000001',
  $$Al encontrar a una persona que no respira y está inconsciente, ¿qué debe aplicar?$$,
  $$Ante paro cardiorrespiratorio: activar emergencias y aplicar RCP (30:2) hasta llegar los paramédicos.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0fc3d85f-57eb-52f8-a921-85537c5d1ea0', 'f4a919fa-0bb2-5412-bcc6-bf4ec62b57be', $$Darle agua$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0548535a-9516-520a-ab87-0ad6908321a0', 'f4a919fa-0bb2-5412-bcc6-bf4ec62b57be', $$RCP: 30 compresiones torácicas por 2 respiraciones de rescate$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4056d0a6-2e47-5f52-8c36-4b6fdf63576e', 'f4a919fa-0bb2-5412-bcc6-bf4ec62b57be', $$Solo respiración boca a boca$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bbd883b5-dc09-525e-9bc0-5f12c65b5119', 'f4a919fa-0bb2-5412-bcc6-bf4ec62b57be', $$Sacudirla fuertemente$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 53
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('dbe7ba39-c8ba-5d33-9878-f2df0fd60505', '00000000-0036-4000-8000-000000000001',
  $$¿Cómo actuar ante víctima con sospecha de lesión de columna vertebral?$$,
  $$Ante sospecha de lesión cervical: inmovilizar en posición neutra. Solo mover en bloque si hay peligro inmediato.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c3fc3673-6833-58e8-b05e-0820e3b2f39a', 'dbe7ba39-c8ba-5d33-9878-f2df0fd60505', $$Sentarla para que descanse$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('70def887-c721-55b3-9f71-89f595d296d5', 'dbe7ba39-c8ba-5d33-9878-f2df0fd60505', $$Inmovilizar cabeza y cuello en posición neutra y esperar a los paramédicos$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1b9a9835-d69f-5231-a4f8-c2e1117584b9', 'dbe7ba39-c8ba-5d33-9878-f2df0fd60505', $$Doblar el cuello para abrir la vía aérea$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('eaeee001-c33a-5dd9-bcb7-7225fabe1b4c', 'dbe7ba39-c8ba-5d33-9878-f2df0fd60505', $$Girarla sobre un costado$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 54
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('a5423f60-53fe-5c39-8ca3-0d2187a57451', '00000000-0036-4000-8000-000000000001',
  $$Si el vehículo oficial se incendia mientras circula, ¿cuál es la prioridad?$$,
  $$Ante incendio vehicular: evacuación inmediata de personas. Extintor solo si el fuego es pequeño y controlable.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2e2731b6-5ead-5d94-b29c-f6743716a48b', 'a5423f60-53fe-5c39-8ca3-0d2187a57451', $$Apagar el fuego con la ropa$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d8d4a5aa-a416-59dd-8f16-32f6e6c1c6ad', 'a5423f60-53fe-5c39-8ca3-0d2187a57451', $$Detener el vehículo, apagar motor, evacuar ocupantes y alejarse antes de llamar a bomberos$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('33c9dca8-c27b-58a5-948b-243d638dbc41', 'a5423f60-53fe-5c39-8ca3-0d2187a57451', $$Continuar hasta encontrar un extintor$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2629c7f4-5470-5964-ba1b-326a47dc2e00', 'a5423f60-53fe-5c39-8ca3-0d2187a57451', $$Abrir el capó para revisar el fuego$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 55
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('392f4286-636a-551b-8eaf-13db9c2b00f2', '00000000-0036-4000-8000-000000000001',
  $$¿Qué tipo de extintor es adecuado para incendios de origen eléctrico en un vehículo?$$,
  $$Para incendios eléctricos: CO2 o PQS (no conducen electricidad, a diferencia del agua).$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7d4a5ad8-14f7-5e1b-bf0b-9d5fedb227b1', '392f4286-636a-551b-8eaf-13db9c2b00f2', $$Extintor de agua$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e883e8a8-d3f3-551b-9291-afa9de27b924', '392f4286-636a-551b-8eaf-13db9c2b00f2', $$Extintor de CO2 o polvo seco (PQS)$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2d894d61-f0e1-56ba-bcc7-4ec265f93bf3', '392f4286-636a-551b-8eaf-13db9c2b00f2', $$Extintor de espuma$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c5b3db5d-d056-524b-8a4c-bfe7a8d37f43', '392f4286-636a-551b-8eaf-13db9c2b00f2', $$Arena húmeda$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 56
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('1c331a3d-5ab2-59f8-af28-9d421ca87b37', '00000000-0036-4000-8000-000000000001',
  $$Un peatón es atropellado frente al vehículo oficial. Aplicando PAS, ¿qué hace primero?$$,
  $$Siempre primero PROTEGER la zona antes de acercarse al herido.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('672163a7-c2f6-54c5-b3e6-e08fff52719e', '1c331a3d-5ab2-59f8-af28-9d421ca87b37', $$Bajar a socorrer al herido directamente$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('5127a110-9088-5cd6-8d53-74baf9fd6896', '1c331a3d-5ab2-59f8-af28-9d421ca87b37', $$Proteger la zona: luces de emergencia, triángulos y detener el tráfico para evitar nuevos impactos$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('16b53d42-1dcc-5047-ad74-e98f64deac36', '1c331a3d-5ab2-59f8-af28-9d421ca87b37', $$Llamar a los medios de comunicación$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4a26f2ac-b532-5dd4-acea-ce6e379de961', '1c331a3d-5ab2-59f8-af28-9d421ca87b37', $$Tomar fotos y alejarse$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 57
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('3a229aa6-0692-5f02-a8a3-caab3dfa670f', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es el procedimiento si un pasajero sufre una crisis convulsiva?$$,
  $$En convulsiones: despejar entorno, posición lateral, nunca sujetar con fuerza ni meter objetos en la boca.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('796e5fe3-4b70-5c9d-91f5-86c69d8687f8', '3a229aa6-0692-5f02-a8a3-caab3dfa670f', $$Sujetarlo con fuerza$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('100119ad-246f-548b-a681-c3ca2f908b3a', '3a229aa6-0692-5f02-a8a3-caab3dfa670f', $$Retirar objetos peligrosos, colocarlo de lado y no introducir nada en su boca$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('80f84555-1adb-5a96-b3f7-df7ac5650319', '3a229aa6-0692-5f02-a8a3-caab3dfa670f', $$Darle agua con azúcar$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e34a6e18-cd40-51d2-ad84-d8fbffc3a81f', '3a229aa6-0692-5f02-a8a3-caab3dfa670f', $$Presionar la lengua hacia abajo$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 58
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('d9538136-7b53-5510-ab6f-c08d63911321', '00000000-0036-4000-8000-000000000001',
  $$¿Qué es la posición lateral de seguridad (PLS) y cuándo se aplica?$$,
  $$La PLS protege la vía aérea de inconscientes que respiran, evitando aspiración de vómito o secreciones.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('6f8e5fa6-0f31-5372-8eee-dae6f149e64b', 'd9538136-7b53-5510-ab6f-c08d63911321', $$Postura de ataque ante agresión$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('71f5f443-f6be-50f7-ba40-c9a1313a8995', 'd9538136-7b53-5510-ab6f-c08d63911321', $$Colocar de lado a persona inconsciente que respira para evitar aspirar vómito$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d1763222-ebcd-5f2e-9a67-23567b2f004d', 'd9538136-7b53-5510-ab6f-c08d63911321', $$Postura de pie con manos al frente$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1e2bf3fa-6ebd-5f7e-842d-a7d2422510de', 'd9538136-7b53-5510-ab6f-c08d63911321', $$Solo en personas conscientes$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 59
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('32fe2cb9-05e9-52ea-bedc-217986e247a2', '00000000-0036-4000-8000-000000000001',
  $$¿Qué debe llevar en el maletero un vehículo oficial correctamente equipado?$$,
  $$Equipamiento mínimo: botiquín, extintor, triángulos, linterna, herramientas y llanta de repuesto.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('156cac3a-a8a6-5941-a954-37769f501766', '32fe2cb9-05e9-52ea-bedc-217986e247a2', $$Solo la rueda de repuesto$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('fd8baef9-cb30-5468-86ec-a0bea92c585f', '32fe2cb9-05e9-52ea-bedc-217986e247a2', $$Kit de primeros auxilios, extintor vigente, triángulos de seguridad, linterna, herramientas y rueda de repuesto$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ae257d57-917f-5802-95fd-0db346fae620', '32fe2cb9-05e9-52ea-bedc-217986e247a2', $$Solo botiquín básico$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b6490199-d40d-5089-9d82-2f734921a9bc', '32fe2cb9-05e9-52ea-bedc-217986e247a2', $$Extintor y cuerda$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 60
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('988ca4e8-d9d7-596e-b21c-75ea23080da2', '00000000-0036-4000-8000-000000000001',
  $$Ante quemadura química en un pasajero, ¿cuál es la acción de primeros auxilios?$$,
  $$Quemaduras químicas: agua abundante por mínimo 15-20 min para diluir el agente causante.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('25b175e0-00e7-50a1-83e7-1624410ee2aa', '988ca4e8-d9d7-596e-b21c-75ea23080da2', $$Aplicar crema o mantequilla$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b1a1dfda-5476-5bf2-8e2d-179ed4fd3f49', '988ca4e8-d9d7-596e-b21c-75ea23080da2', $$Enjuagar abundantemente con agua limpia por 15-20 min y retirar ropa contaminada$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('44176e72-7572-5e9c-971a-6c2a6145991b', '988ca4e8-d9d7-596e-b21c-75ea23080da2', $$Cubrir con vendas y no tocar$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('dbc793c8-94d8-5f19-8a1e-ffb567014512', '988ca4e8-d9d7-596e-b21c-75ea23080da2', $$Aplicar hielo directamente$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 61
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('56a72070-603e-567e-93c9-c233c6bae00f', '00000000-0036-4000-8000-000000000001',
  $$Un director de la PCM le pide usar el vehículo oficial para llevar a su familia a un restaurante. ¿Cómo actúa?$$,
  $$Usar bienes del Estado para fines privados es falta grave y puede configurar peculado de uso.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d686b8c4-b86d-5df4-8332-1b2c99b01831', '56a72070-603e-567e-93c9-c233c6bae00f', $$Acepta porque es su superior$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a41bc57f-c0ae-58f8-95bd-432464a77db5', '56a72070-603e-567e-93c9-c233c6bae00f', $$Acepta si el viaje es corto$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3ad99fd8-1504-53ec-9ebb-3486a0ef0d29', '56a72070-603e-567e-93c9-c233c6bae00f', $$Declina cortésmente explicando que el vehículo es de uso exclusivo institucional$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c1576a0d-172d-535d-b2a8-30e72d6b9fd7', '56a72070-603e-567e-93c9-c233c6bae00f', $$Acepta y no lo registra en la bitácora$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 62
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('bd5e7d9a-1a7e-56a2-876d-ab82f03ba2b0', '00000000-0036-4000-8000-000000000001',
  $$Al llegar al destino de comisión, no hay parqueo y el acompañante indica estacionar en zona amarilla 'solo 5 minutos'. ¿Qué hace?$$,
  $$El conductor es responsable de la correcta operación. Una multa por estacionamiento afecta a la institución.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e530b268-cd15-525e-858c-0f6e0a479fe1', 'bd5e7d9a-1a7e-56a2-876d-ab82f03ba2b0', $$Estaciona porque 5 minutos no es infracción$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b88b9710-3386-52fc-8b67-0e1332fe2a7b', 'bd5e7d9a-1a7e-56a2-876d-ab82f03ba2b0', $$Estaciona con luces de emergencia encendidas$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('5fcc4660-d6f0-5ba8-8e07-1518d596d720', 'bd5e7d9a-1a7e-56a2-876d-ab82f03ba2b0', $$Busca el estacionamiento permitido más cercano$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('063a2c04-7f10-5c8c-8600-ec1945254598', 'bd5e7d9a-1a7e-56a2-876d-ab82f03ba2b0', $$Estaciona con luces bajas encendidas$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 63
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('d1bf7297-d173-5682-9a86-c66fa5398353', '00000000-0036-4000-8000-000000000001',
  $$Un compañero usa el vehículo oficial para realizar servicios privados de taxi los fines de semana. ¿Qué debe hacer?$$,
  $$El deber de probidad obliga a denunciar actos contrarios a los intereses del Estado.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('06349690-9e88-5925-acf0-658bf1d76971', 'd1bf7297-d173-5682-9a86-c66fa5398353', $$Ignorarlo, no es su problema$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('29108745-bb63-5de5-b446-93a563d9aa9d', 'd1bf7297-d173-5682-9a86-c66fa5398353', $$Participar si le dan parte de las ganancias$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7b3de104-9f1e-590d-8441-57f0ebe19588', 'd1bf7297-d173-5682-9a86-c66fa5398353', $$Reportar el hecho a su jefe directo o a la Oficina de Integridad Institucional$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f438bc60-8ab7-5224-aa2b-4b40a47483a5', 'd1bf7297-d173-5682-9a86-c66fa5398353', $$Hablar con el compañero para que lo incluya$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 64
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('8904218b-fb08-5b0f-9c9a-488495b51866', '00000000-0036-4000-8000-000000000001',
  $$El vehículo oficial sufre un rayón en un estacionamiento mientras realizaba diligencias institucionales. ¿Qué hace?$$,
  $$Todo daño al vehículo del Estado debe reportarse inmediatamente; ocultarlo agrava la responsabilidad.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('563c0c63-900b-5c61-9dc3-585d2e305385', '8904218b-fb08-5b0f-9c9a-488495b51866', $$No decir nada esperando que no lo noten$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a67119d9-b1b1-5a03-a6a5-6b1b9680bc04', '8904218b-fb08-5b0f-9c9a-488495b51866', $$Reportar de inmediato el incidente al área de transportes y elaborar el parte correspondiente$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('93abb069-1b23-5d65-9ce0-937ac21b71e3', '8904218b-fb08-5b0f-9c9a-488495b51866', $$Arreglarlo por su cuenta$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('dc67d49e-a5ea-57de-b8a0-89ab496c2aba', '8904218b-fb08-5b0f-9c9a-488495b51866', $$Culpar a otro conductor$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 65
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('abbd4c21-2428-5eae-b819-2982b7fec782', '00000000-0036-4000-8000-000000000001',
  $$Un funcionario solicita una comisión fuera del horario sin la orden de comisión firmada. ¿Qué hace el conductor?$$,
  $$Toda comisión requiere documentación formal previa; sin ella el conductor asume responsabilidades.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('62e2d810-a7ec-559a-a251-5f7b9306759d', 'abbd4c21-2428-5eae-b819-2982b7fec782', $$Realiza la comisión por confianza$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9ebdb69a-c97c-54c5-89fe-b6dc75b623b6', 'abbd4c21-2428-5eae-b819-2982b7fec782', $$Realiza la comisión y firma la orden después$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0379f2d0-3f6b-5ec1-9dca-96eacdd660de', 'abbd4c21-2428-5eae-b819-2982b7fec782', $$Solicita la documentación formal antes de proceder$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9ee61f00-5346-57e1-82be-d133e8917e56', 'abbd4c21-2428-5eae-b819-2982b7fec782', $$Se niega y no informa a nadie$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 66
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('ad5d3850-b09c-5ffe-89fa-fa304cb386c3', '00000000-0036-4000-8000-000000000001',
  $$¿Qué debe hacer el conductor con el combustible sobrante de una comisión?$$,
  $$El combustible es bien del Estado: registrar nivel al inicio y fin de cada comisión.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('dce61714-34c8-50e1-9aa2-f42f4b6a1e01', 'ad5d3850-b09c-5ffe-89fa-fa304cb386c3', $$Guardarlo para uso personal$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e96ae18f-9bd3-5aeb-a5c0-2440e16fab98', 'ad5d3850-b09c-5ffe-89fa-fa304cb386c3', $$Registrarlo en la bitácora y reportar el nivel al área de transportes$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('03262f2a-af5b-5d86-a364-fca2f592cc69', 'ad5d3850-b09c-5ffe-89fa-fa304cb386c3', $$Compartirlo con compañeros$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2ef3ceb8-8d5d-5608-bd61-c2dcfe1541bd', 'ad5d3850-b09c-5ffe-89fa-fa304cb386c3', $$Completarlo de su bolsillo$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 67
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('197ab576-05c4-500e-abe4-32b1267447cf', '00000000-0036-4000-8000-000000000001',
  $$Un proveedor ofrece una 'propina' al conductor por acelerar una entrega de documentos. ¿Cómo reacciona?$$,
  $$El Código de Ética prohíbe aceptar dádivas. Debe rechazar y reportar como posible intento de corrupción.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7a1fcb55-a9f3-5a2b-9526-0513f3e266d7', '197ab576-05c4-500e-abe4-32b1267447cf', $$Acepta si el monto es pequeño$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('99fbfd13-2f53-564a-a5e2-1e47d86006f6', '197ab576-05c4-500e-abe4-32b1267447cf', $$Acepta y hace la entrega rápido$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('55c33e0b-dc13-55b2-b6f6-abaa203635db', '197ab576-05c4-500e-abe4-32b1267447cf', $$Rechaza y reporta el ofrecimiento a su jefe directo$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('35e8c970-d969-512f-80b5-15b490c48dbe', '197ab576-05c4-500e-abe4-32b1267447cf', $$Acepta y no informa$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 68
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('6ff7b6c1-2d30-583d-b672-f01f2fce0165', '00000000-0036-4000-8000-000000000001',
  $$Si debe transportar documentos confidenciales de la PCM, ¿qué precaución toma?$$,
  $$Los documentos confidenciales requieren discreción y cadena de custodia correcta.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('643f8372-7d21-5537-9034-030b6dfae9e5', '6ff7b6c1-2d30-583d-b672-f01f2fce0165', $$Los deja en el asiento trasero sin preocupaciones$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('eb4c4fe2-5677-5a7c-a4fc-aaf9c410b21e', '6ff7b6c1-2d30-583d-b672-f01f2fce0165', $$No comenta el contenido, mantiene el vehículo cerrado y entrega solo a la persona autorizada$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e3a3258b-a682-5abe-8ae5-38aee817cad2', '6ff7b6c1-2d30-583d-b672-f01f2fce0165', $$Los fotografía por si se pierden$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('715255d5-c31e-574f-b4b0-3d83a2cd41b7', '6ff7b6c1-2d30-583d-b672-f01f2fce0165', $$Los comenta con compañeros para mayor seguridad$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 69
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('aa656b4d-a59e-5fae-b55e-1ccb8b3ea677', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es la disposición correcta de residuos generados en el vehículo oficial durante una comisión?$$,
  $$Arrojar basura desde el vehículo es infracción ambiental además de no cuidar el bien del Estado.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('064af732-65bb-50e9-90c1-6c2c9d02175b', 'aa656b4d-a59e-5fae-b55e-1ccb8b3ea677', $$Arrojarlos por la ventana$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c94942f0-34c7-5e3d-a680-ba49607eb1cc', 'aa656b4d-a59e-5fae-b55e-1ccb8b3ea677', $$Acumularlos en el piso$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0d97ddec-1551-5d74-9f39-14b42203bc4f', 'aa656b4d-a59e-5fae-b55e-1ccb8b3ea677', $$Depositarlos en recipientes de basura al llegar a la institución o en punto de acopio$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bf566326-618d-5e76-86ed-d20febe28970', 'aa656b4d-a59e-5fae-b55e-1ccb8b3ea677', $$Dejarlos en el maletero indefinidamente$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 70
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('0ccf2f3f-385f-595a-832c-4fda85002db9', '00000000-0036-4000-8000-000000000001',
  $$El conductor recibe una llamada personal larga mientras conduce el vehículo oficial. ¿Qué hace?$$,
  $$Usar el teléfono con la mano mientras conduce es infracción grave; se debe usar manos libres o detenerse.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1a2f2822-a67b-5563-a928-7f782965ab71', '0ccf2f3f-385f-595a-832c-4fda85002db9', $$Continúa hablando con el teléfono en la oreja$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f3415cef-d84c-5f2f-aee1-57f7d1143be8', '0ccf2f3f-385f-595a-832c-4fda85002db9', $$Usa manos libres o se detiene en lugar seguro para atender la llamada$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('298d10dd-ec05-5663-a627-072f536cf94a', '0ccf2f3f-385f-595a-832c-4fda85002db9', $$Ignora la llamada siempre$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e41f8304-3a54-5f18-b970-4ca0e9539ca7', '0ccf2f3f-385f-595a-832c-4fda85002db9', $$Pasa el teléfono al pasajero$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 71
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('208f22bc-420d-57b4-a966-c89af759b803', '00000000-0036-4000-8000-000000000001',
  $$Un colega pide prestado el vehículo oficial afirmando que su jefe lo aprobó verbalmente. ¿Cuál es su respuesta?$$,
  $$Ningún vehículo del Estado puede prestarse sin autorización escrita formal.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d09f3f5e-9c64-52fa-b247-2a78a464ce58', '208f22bc-420d-57b4-a966-c89af759b803', $$Lo presta si confía en el colega$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8f8f51d2-e98a-52fd-9bfc-c136bc2c205a', '208f22bc-420d-57b4-a966-c89af759b803', $$Lo presta solo una hora$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('32862d3d-51bd-5214-82c4-16048c8a4173', '208f22bc-420d-57b4-a966-c89af759b803', $$Solicita autorización escrita; sin documento no puede prestar el vehículo$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('835c7a8f-047c-586a-bb37-43e8dabef960', '208f22bc-420d-57b4-a966-c89af759b803', $$Lo presta y anota el incidente después$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 72
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('739b5e5a-6d6e-504f-8b90-640c8b9a1d29', '00000000-0036-4000-8000-000000000001',
  $$Las placas del vehículo oficial están próximas a vencer la revisión técnica. ¿A quién corresponde gestionar la renovación?$$,
  $$La gestión de documentos vehiculares (SOAT, ITV) corresponde al área de transportes/logística.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2dd639bc-5012-570d-bb47-322cda29473d', '739b5e5a-6d6e-504f-8b90-640c8b9a1d29', $$Al conductor por cuenta propia$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b3c3cf5a-f5fd-5207-9d4e-0ac9c7e1c026', '739b5e5a-6d6e-504f-8b90-640c8b9a1d29', $$Al área de transportes/logística de la entidad, que gestiona las inspecciones del parque vehicular$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('fb54eb7d-25eb-519c-8893-8ed95956f95c', '739b5e5a-6d6e-504f-8b90-640c8b9a1d29', $$Al conductor pagando y solicitando reembolso$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b0a2ccc9-5564-55be-9193-ebf176b10a67', '739b5e5a-6d6e-504f-8b90-640c8b9a1d29', $$A cualquier funcionario de la PCM$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 73
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('e1c2e979-433d-59c8-83df-8801436c29e9', '00000000-0036-4000-8000-000000000001',
  $$El conductor recibe por error una factura de combustible en blanco. ¿Cuál es su obligación?$$,
  $$Los documentos contables deben gestionarse con transparencia; usar facturas en blanco puede ser fraude.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('13378812-51d0-53de-93b1-d665d6c92fc4', 'e1c2e979-433d-59c8-83df-8801436c29e9', $$Guardarla para usarla en emergencia$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7e365abb-0fbb-5311-8894-ea5649c2dea1', 'e1c2e979-433d-59c8-83df-8801436c29e9', $$Completarla con datos falsos$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('00ec7014-ff31-5277-a230-ec7e6f10ff28', 'e1c2e979-433d-59c8-83df-8801436c29e9', $$Informar al área de administración sobre el error y devolver el documento$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c319f645-3bc3-5a29-93a2-7f2f1e31e90e', 'e1c2e979-433d-59c8-83df-8801436c29e9', $$Desecharla inmediatamente$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 74
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('885f1d12-9448-554f-b79a-7f47689eba4f', '00000000-0036-4000-8000-000000000001',
  $$Un conductor CAS lleva 9 horas continuas de manejo en comisiones programadas. ¿Qué debe hacer?$$,
  $$La fatiga al volante causa accidentes. Reportar el exceso de horas aunque implique demora en la comisión.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('6635ca38-9f45-5cb6-9586-75faa994c40d', '885f1d12-9448-554f-b79a-7f47689eba4f', $$Continuar ya que tiene contrato CAS$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3d7fee4a-df29-59f6-aea6-be24fd0d3de1', '885f1d12-9448-554f-b79a-7f47689eba4f', $$Tomar bebidas energizantes para seguir despierto$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('34345924-4286-5ba9-ba5a-42dd76b3b728', '885f1d12-9448-554f-b79a-7f47689eba4f', $$Comunicar al área de transportes que superó el límite recomendado y solicitar relevo o pausa$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('df4ed272-00f4-59e5-b496-c6e42c86ae98', '885f1d12-9448-554f-b79a-7f47689eba4f', $$Acelerar para terminar rápido$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 75
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('9d6c57c6-0257-5f87-b5d1-41636f024efd', '00000000-0036-4000-8000-000000000001',
  $$¿Qué debe hacer el conductor al detectar que el vehículo oficial tiene documentos vencidos (SOAT o ITV)?$$,
  $$Conducir con SOAT o ITV vencido genera multa y responsabilidad para el conductor. Debe negarse y reportar.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a9e33d31-f6ca-5648-82f0-47d5ce22e4da', '9d6c57c6-0257-5f87-b5d1-41636f024efd', $$Conducirlo igual porque la responsabilidad es de la institución$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1bf38928-21bf-5c0e-a243-c7c3d1591788', '9d6c57c6-0257-5f87-b5d1-41636f024efd', $$No conducirlo y reportar de inmediato al área de transportes para su regularización$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('41373ef5-12c1-58b4-b1a4-9ded7dcf63a4', '9d6c57c6-0257-5f87-b5d1-41636f024efd', $$Tramitar los documentos él mismo$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7c6d3ef3-6be7-56db-9ef4-5806c9947033', '9d6c57c6-0257-5f87-b5d1-41636f024efd', $$Conducirlo solo en emergencias$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 76
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('f063efc8-747d-52aa-8bf0-9e7f3a134ea2', '00000000-0036-4000-8000-000000000001',
  $$Según la Ley N° 27815, ¿cuáles son los principios que rigen la conducta del servidor público?$$,
  $$La Ley del Código de Ética establece ocho principios para todos los servidores del Estado.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4cc270a0-878f-5021-a235-7d537ef62b30', 'f063efc8-747d-52aa-8bf0-9e7f3a134ea2', $$Eficiencia, rentabilidad y productividad$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('fa5a5c72-84fa-5006-88f5-f43b2cbef943', 'f063efc8-747d-52aa-8bf0-9e7f3a134ea2', $$Respeto, probidad, eficiencia, idoneidad, veracidad, lealtad, justicia y equidad$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('5b498e0a-c5cb-52cf-834a-e4b4cf932244', 'f063efc8-747d-52aa-8bf0-9e7f3a134ea2', $$Obediencia, jerarquía y disciplina$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('24cad1e0-2030-5e5e-9637-38d55c469767', 'f063efc8-747d-52aa-8bf0-9e7f3a134ea2', $$Competencia, utilidad y beneficio$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 77
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('2ae3af43-0602-588a-949d-122a89c8c25f', '00000000-0036-4000-8000-000000000001',
  $$¿Qué conducta configura una falta ética grave para un conductor del Estado según la Ley N° 27815?$$,
  $$Usar bienes del Estado en beneficio propio viola la probidad e idoneidad, constituyendo falta grave.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f93fd667-c630-5397-afdf-07d0900c634b', '2ae3af43-0602-588a-949d-122a89c8c25f', $$Llegar 5 minutos tarde ocasionalmente$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('9027f0a5-3d47-5ac4-a94f-b147a1af33f7', '2ae3af43-0602-588a-949d-122a89c8c25f', $$Realizar servicios particulares con el vehículo oficial en beneficio propio$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f18d4e06-9036-5cff-94be-07d055cee55f', '2ae3af43-0602-588a-949d-122a89c8c25f', $$Pedir permiso para una cita médica$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d7e71c19-1de8-589c-b9cf-8082796ac858', '2ae3af43-0602-588a-949d-122a89c8c25f', $$Comentar las rutas de comisión con un compañero$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 78
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('6139f8be-aecf-5275-89a9-1e7d91ffa297', '00000000-0036-4000-8000-000000000001',
  $$El principio de PROBIDAD en el Código de Ética significa:$$,
  $$Probidad: actuar con integridad moral, priorizando el interés público sobre el privado.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f59f154a-ef00-595d-a956-6d85ee6cc28b', '6139f8be-aecf-5275-89a9-1e7d91ffa297', $$Trabajar muchas horas extras$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('bab1c3d6-d31f-553c-a88d-d06700b1f462', '6139f8be-aecf-5275-89a9-1e7d91ffa297', $$Actuar con rectitud, honradez y honestidad, buscando el bien general del Estado sobre el interés particular$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a134c41e-daee-5ca6-a9a5-b0c83e0aa419', '6139f8be-aecf-5275-89a9-1e7d91ffa297', $$Obedecer todas las órdenes sin cuestionarlas$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2b2994be-abad-5027-a3be-4c5f23194e44', '6139f8be-aecf-5275-89a9-1e7d91ffa297', $$Ser eficiente solamente$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 79
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('74edb28e-db07-5ec7-ad85-738484691d6d', '00000000-0036-4000-8000-000000000001',
  $$¿Qué debe hacer un conductor CAS que recibe una orden de un superior que considera ilegal?$$,
  $$El servidor puede dejar constancia escrita de su discrepancia y reportar al órgano de control si hay ilegalidad.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c4293ee7-5f42-5393-a97d-8ab5c7844ddc', '74edb28e-db07-5ec7-ad85-738484691d6d', $$Ejecutarla de inmediato por respeto jerárquico$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4502ecb4-cc92-5fad-9ef4-256a0bc87615', '74edb28e-db07-5ec7-ad85-738484691d6d', $$Desobedecerla sin informar a nadie$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('dafed63d-00e5-5358-91ab-eea354fb9570', '74edb28e-db07-5ec7-ad85-738484691d6d', $$Ejecutarla bajo protesta dejando constancia escrita y reportarlo al órgano de integridad$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('54cf3fcc-c519-588e-bf02-8aaa1c6448f5', '74edb28e-db07-5ec7-ad85-738484691d6d', $$Renunciar al puesto$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 80
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('2297138b-b37c-5fdb-b595-858a702edbc0', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es el deber de LEALTAD Y OBEDIENCIA en el Código de Ética?$$,
  $$La lealtad es hacia la Constitución y las leyes; el servidor debe negarse a actos contrarios a la legalidad.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('25c4665d-6689-521c-8def-337d63b76b99', '2297138b-b37c-5fdb-b595-858a702edbc0', $$Obedecer sin límites a cualquier superior$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('34f52a41-a385-58ff-b4aa-cdfb3d7b5564', '2297138b-b37c-5fdb-b595-858a702edbc0', $$Actuar con fidelidad a la Constitución y las leyes, incluso cuando los superiores emitan órdenes contrarias$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('651568ae-df26-5745-9b4e-296c8ce330d2', '2297138b-b37c-5fdb-b595-858a702edbc0', $$Ser leal al partido político del jefe$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('5f062755-b053-5eb5-816d-e6371fc254e5', '2297138b-b37c-5fdb-b595-858a702edbc0', $$Obedecer solo las órdenes escritas$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 81
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('71548f80-0c6c-5555-b54c-4adef8dbb966', '00000000-0036-4000-8000-000000000001',
  $$Según el Código de Ética, ¿qué es una 'dádiva'?$$,
  $$Dádiva es cualquier beneficio entregado para influir en las decisiones del servidor. Aceptarla es corrupción.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a3e6cba5-96a5-5836-b0f1-3de2010af634', '71548f80-0c6c-5555-b54c-4adef8dbb966', $$Un salario adicional por buen desempeño$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f86fd78f-7cc3-56db-834d-c8af2861016d', '71548f80-0c6c-5555-b54c-4adef8dbb966', $$Un bien, dinero, favor, promesa o ventaja que un servidor recibe para actuar a favor de quien la da$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d58f0dcd-41f0-5a89-9667-6756b6c3d7db', '71548f80-0c6c-5555-b54c-4adef8dbb966', $$Un bono por productividad aprobado$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('436e58cc-3193-50d4-8ad5-91bc806df843', '71548f80-0c6c-5555-b54c-4adef8dbb966', $$Una felicitación formal$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 82
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('25947697-470c-5429-a741-5d3262a124da', '00000000-0036-4000-8000-000000000001',
  $$¿Qué prohibición específica establece la Ley N° 27815 respecto al patrimonio del servidor?$$,
  $$El servidor no puede tener intereses que generen conflictos con su función pública.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('14669afc-b979-50ad-9c74-30e2b10ba3ad', '25947697-470c-5429-a741-5d3262a124da', $$Prohibido tener propiedades en el extranjero$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('42dffd85-0361-5c2c-806f-6e8a8167c673', '25947697-470c-5429-a741-5d3262a124da', $$Prohibido ingresos mayores a la remuneración estatal$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b4dd24a7-dd01-5e07-ac87-2e7880555a3a', '25947697-470c-5429-a741-5d3262a124da', $$Prohibido mantener intereses que puedan comprometer su función o inducir decisiones parcializadas$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('df791425-3bd1-5b93-a235-33d2ed7f00e8', '25947697-470c-5429-a741-5d3262a124da', $$Prohibido ahorrar en bancos privados$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 83
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('70b556b2-aba6-5101-86cf-b76d1486ea97', '00000000-0036-4000-8000-000000000001',
  $$El principio de EFICIENCIA en el Código de Ética implica:$$,
  $$La eficiencia exige optimizar los recursos públicos obteniendo los mejores resultados posibles.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8eb0b0fc-396a-5801-bba7-97e616ffc97b', '70b556b2-aba6-5101-86cf-b76d1486ea97', $$Hacer el mínimo esfuerzo$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('54a01681-5cb0-560d-9a2b-10e60f42568e', '70b556b2-aba6-5101-86cf-b76d1486ea97', $$Brindar calidad en cada tarea, minimizando recursos del Estado y maximizando resultados$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('53982c0c-7860-5948-bddf-b4093f163ac8', '70b556b2-aba6-5101-86cf-b76d1486ea97', $$Trabajar sin descanso$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('5a107dc4-f7c7-5411-866f-ddb0e48814c0', '70b556b2-aba6-5101-86cf-b76d1486ea97', $$Solo cumplir el horario$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 84
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('e419a804-4407-5c78-9f4f-2585254fe723', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es la sanción máxima para un servidor CAS que viola gravemente el Código de Ética?$$,
  $$Las faltas éticas graves pueden llegar a la resolución del contrato e inhabilitación para el servicio público.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c0638b0c-2f09-5d9a-968d-d036622e8293', 'e419a804-4407-5c78-9f4f-2585254fe723', $$Solo amonestación verbal$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('710314f5-0dde-5505-8bac-15b2e67a16f9', 'e419a804-4407-5c78-9f4f-2585254fe723', $$Solo reducción de sueldo$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0f06cb9c-827d-59eb-aaa3-b883d7668335', 'e419a804-4407-5c78-9f4f-2585254fe723', $$Resolución del contrato CAS e inhabilitación para ejercer la función pública$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('95267b69-4213-5b0d-b867-7d6a5efb7302', 'e419a804-4407-5c78-9f4f-2585254fe723', $$Solo llamada de atención escrita$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 85
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('1e5189bd-8677-5042-8268-c611ffe5b952', '00000000-0036-4000-8000-000000000001',
  $$¿A quién puede recurrir un servidor CAS de la PCM si es testigo de un acto de corrupción?$$,
  $$El servidor puede reportar a la Oficina de Integridad, Contraloría o Ministerio Público.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c42cd38d-fa1a-5649-8fd9-9a2ad89f3d8f', '1e5189bd-8677-5042-8268-c611ffe5b952', $$Al sindicato del sector$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f9cd90b7-6c36-5884-96ac-e1a6f849e749', '1e5189bd-8677-5042-8268-c611ffe5b952', $$Solo a su jefe directo$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d34b207f-2503-5ab6-b369-93cc413d0e56', '1e5189bd-8677-5042-8268-c611ffe5b952', $$A la Oficina de Integridad Institucional de la PCM, la Contraloría General o la Fiscalía$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('042c0489-9def-5fb0-9989-c585a417d3dc', '1e5189bd-8677-5042-8268-c611ffe5b952', $$Solo a los medios de comunicación$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 86
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('acd4fb85-4ecc-5f6c-80ad-ffc75277b65e', '00000000-0036-4000-8000-000000000001',
  $$Según la Ley N° 27444, ¿qué principio exige que los actos administrativos se dicten dentro de plazos establecidos, evitando demoras?$$,
  $$El principio de celeridad exige tramitar los procedimientos administrativos con rapidez y sin dilaciones.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('db8a6e4d-1977-5c14-84c8-98a1ab1fa142', 'acd4fb85-4ecc-5f6c-80ad-ffc75277b65e', $$Principio de legalidad$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('14f768d1-5510-5a23-b8a3-e16194be5eaa', 'acd4fb85-4ecc-5f6c-80ad-ffc75277b65e', $$Principio de celeridad$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('e84f1b31-941e-5a2b-bba0-240144379064', 'acd4fb85-4ecc-5f6c-80ad-ffc75277b65e', $$Principio de razonabilidad$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('923d341a-db0d-5fb4-bfb4-90498c6c04c7', 'acd4fb85-4ecc-5f6c-80ad-ffc75277b65e', $$Principio de informalismo$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 87
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('a4845e2c-a6e9-5c98-9da6-336cb5a4b7c8', '00000000-0036-4000-8000-000000000001',
  $$El principio de PRESUNCIÓN DE VERACIDAD de la Ley N° 27444 implica:$$,
  $$La presunción de veracidad agiliza trámites asumiendo buena fe, con responsabilidad penal si hay falsedad.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('76d19e90-7eff-59d2-99e1-d94f99e75ac5', 'a4845e2c-a6e9-5c98-9da6-336cb5a4b7c8', $$La entidad no puede verificar los documentos$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ff30a6f5-9335-53b5-8c2f-6bee6006e8b4', 'a4845e2c-a6e9-5c98-9da6-336cb5a4b7c8', $$La entidad asume que los documentos presentados son verdaderos, sujeto a fiscalización posterior$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c6b39662-ec88-509a-aed3-2a04ff385659', 'a4845e2c-a6e9-5c98-9da6-336cb5a4b7c8', $$El ciudadano siempre tiene razón$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('031fc1b3-1636-5212-a937-e885718856ab', 'a4845e2c-a6e9-5c98-9da6-336cb5a4b7c8', $$Las declaraciones falsas no tienen sanción$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 88
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('7863be93-f0dc-5760-b603-582ad63b55cb', '00000000-0036-4000-8000-000000000001',
  $$¿Qué establece el principio de LEGALIDAD en la Ley N° 27444?$$,
  $$La legalidad limita la actuación estatal: las entidades no pueden actuar fuera de sus competencias.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b89c0d7b-9d3c-547c-abac-0280c6709dc2', '7863be93-f0dc-5760-b603-582ad63b55cb', $$Los funcionarios pueden hacer todo lo no prohibido$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('a5966001-c33e-5ccf-869b-979a9b7f521d', '7863be93-f0dc-5760-b603-582ad63b55cb', $$Las entidades del Estado solo pueden actuar en base a lo que la ley expresamente las faculta$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1db4e7d4-ef09-5d1d-aec8-fd139f536d40', '7863be93-f0dc-5760-b603-582ad63b55cb', $$Los ciudadanos deben cumplir todas las leyes$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b9db059c-cb8e-5570-973c-7038d57887c4', '7863be93-f0dc-5760-b603-582ad63b55cb', $$La ley siempre está por encima de la Constitución$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 89
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('902c0694-bf4e-5553-9694-999163db25c3', '00000000-0036-4000-8000-000000000001',
  $$Si una entidad pública niega un trámite sin explicación, ¿qué principio de la Ley N° 27444 viola?$$,
  $$El debido procedimiento garantiza que el ciudadano sea informado de las razones de cualquier decisión.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('5d9bc2ec-ec93-55e2-b48d-68f6c7cc4515', '902c0694-bf4e-5553-9694-999163db25c3', $$Principio de eficacia$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4b5c1a9d-b9bd-5a66-af65-22fccde5f421', '902c0694-bf4e-5553-9694-999163db25c3', $$Principio de celeridad$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('787ef041-36eb-5b9f-a945-3ac2cd505fa8', '902c0694-bf4e-5553-9694-999163db25c3', $$Principio del debido procedimiento$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b70b927b-6b2a-51cb-8589-274744709558', '902c0694-bf4e-5553-9694-999163db25c3', $$Principio de simplicidad$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 90
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('18cbae49-7e01-56f9-b9f2-cf566bc27b99', '00000000-0036-4000-8000-000000000001',
  $$¿Qué es el 'silencio administrativo positivo' en la Ley N° 27444?$$,
  $$El silencio administrativo positivo convierte el incumplimiento de plazos en aprobación automática.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4f610e19-3279-5e55-a9cd-f13437ac8a3c', '18cbae49-7e01-56f9-b9f2-cf566bc27b99', $$La institución no responde porque aprobó internamente$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('96ff945f-55d3-53e6-981a-2d6de4f24352', '18cbae49-7e01-56f9-b9f2-cf566bc27b99', $$Si la entidad no responde en el plazo, la solicitud se considera aprobada por ministerio de la ley$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0e3c6e5b-7635-53e5-aa83-7e0c4c62ac36', '18cbae49-7e01-56f9-b9f2-cf566bc27b99', $$El ciudadano puede insistir indefinidamente$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d69ec129-76d9-5586-a724-2627960b39f9', '18cbae49-7e01-56f9-b9f2-cf566bc27b99', $$El silencio implica rechazo$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 91
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('2b48f7ca-d0ae-5f6c-9335-720dfd72dee4', '00000000-0036-4000-8000-000000000001',
  $$¿Qué norma crea el Régimen Especial de Contratación Administrativa de Servicios (CAS)?$$,
  $$El D.Leg. 1057 crea el régimen CAS como modalidad especial de vinculación laboral en el Estado.$$,
  true, 1
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f5dc71fb-4671-5b7a-b557-11282e3d348c', '2b48f7ca-d0ae-5f6c-9335-720dfd72dee4', $$Ley N° 30057$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3fecb4ed-003a-5d8f-8d89-8090d9ac8997', '2b48f7ca-d0ae-5f6c-9335-720dfd72dee4', $$Decreto Legislativo N° 1057$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8a8dcd6a-3c5e-59ff-bbb2-cb33329e5847', '2b48f7ca-d0ae-5f6c-9335-720dfd72dee4', $$Decreto Legislativo N° 728$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ffd23bb8-ef80-579d-acb4-df664a22d9d4', '2b48f7ca-d0ae-5f6c-9335-720dfd72dee4', $$Ley N° 27444$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 92
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('9ea52b03-b24e-5b55-9984-fbdce7aa8045', '00000000-0036-4000-8000-000000000001',
  $$¿Cuántas horas de trabajo semanal corresponden a un servidor CAS según el D.Leg. N° 1057?$$,
  $$El régimen CAS fija un máximo de 8 horas diarias y 48 horas semanales.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ee2cd823-21a0-5f1f-b3f8-ecc1f60f0070', '9ea52b03-b24e-5b55-9984-fbdce7aa8045', $$40 horas semanales$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b3d3da6a-c819-5960-9ba2-c067f03fe137', '9ea52b03-b24e-5b55-9984-fbdce7aa8045', $$48 horas semanales$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3b0052f5-fd2d-54eb-8476-b5fe54fa7e13', '9ea52b03-b24e-5b55-9984-fbdce7aa8045', $$No más de 8 horas diarias ni 48 semanales$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('d050b777-8634-545d-97ef-3c08fcd44c1e', '9ea52b03-b24e-5b55-9984-fbdce7aa8045', $$Sin límite de horas$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 93
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('59b91060-0c4f-5b2e-ac91-308b9d473582', '00000000-0036-4000-8000-000000000001',
  $$¿A cuántos días de vacaciones anuales tiene derecho un trabajador CAS?$$,
  $$El trabajador CAS tiene derecho a 30 días calendario de vacaciones remuneradas por año.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b179adff-0592-5f4a-84f0-98900d1687d3', '59b91060-0c4f-5b2e-ac91-308b9d473582', $$15 días hábiles$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f3c60803-18ab-5d45-b632-bf97a17cbf6b', '59b91060-0c4f-5b2e-ac91-308b9d473582', $$30 días calendario$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('8d787e92-29c9-543c-8fd5-3705a0492285', '59b91060-0c4f-5b2e-ac91-308b9d473582', $$21 días hábiles$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('cfd7a4f9-6af6-5c3c-9727-337fa8f6408a', '59b91060-0c4f-5b2e-ac91-308b9d473582', $$7 días hábiles$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 94
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('609ace17-61a1-5d28-b970-cda0e6c43283', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es una obligación del servidor CAS al iniciar sus funciones?$$,
  $$El servidor CAS debe registrar asistencia, cumplir horario y respetar el reglamento interno.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ec832c9e-4434-50dc-b1b7-90ad381ca102', '609ace17-61a1-5d28-b970-cda0e6c43283', $$Firmar un contrato indefinido$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('33cab574-cd50-5f14-bbed-89d0ec785937', '609ace17-61a1-5d28-b970-cda0e6c43283', $$Registrar su ingreso y salida en el sistema de control de asistencia$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('ca728a20-f7e8-57a8-a9b2-4e657dbab4c4', '609ace17-61a1-5d28-b970-cda0e6c43283', $$No declarar ingresos de otras actividades$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('74a62913-b0fa-58ff-b03f-909c84f675d4', '609ace17-61a1-5d28-b970-cda0e6c43283', $$Solo cumplir las tareas que le gusten$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 95
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('a4a52ee2-ed98-5a28-a41c-4e18c4c5b9dd', '00000000-0036-4000-8000-000000000001',
  $$Según la Ley N° 32563 (modificatoria del D.Leg. 1057), ¿qué derecho fue incorporado para los servidores CAS?$$,
  $$La Ley 32563 reconoce estabilidad relativa y derechos sindicales para los servidores CAS.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('c10810bc-c74f-5b6c-8c19-0ecc4b6940f5', 'a4a52ee2-ed98-5a28-a41c-4e18c4c5b9dd', $$Beneficios de CTS y gratificaciones$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('4f04113f-9682-5690-840b-0d506609017b', 'a4a52ee2-ed98-5a28-a41c-4e18c4c5b9dd', $$Voto en elecciones sindicales$$, false, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('6dc7bf91-f3c2-5b73-a652-f807cce5f25e', 'a4a52ee2-ed98-5a28-a41c-4e18c4c5b9dd', $$Estabilidad laboral relativa y afiliación sindical$$, true, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f976a4fa-dcfa-5a3e-bfab-c73ff7b38061', 'a4a52ee2-ed98-5a28-a41c-4e18c4c5b9dd', $$Jubilación anticipada$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 96
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('fc26689b-b8c2-5cdb-b63c-c96f0dc8da43', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es la función principal de la Presidencia del Consejo de Ministros (PCM)?$$,
  $$La PCM coordina el gabinete ministerial y es rector de la modernización del Estado.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('33cad231-376a-5060-9b08-fc72688a1d96', 'fc26689b-b8c2-5cdb-b63c-c96f0dc8da43', $$Administrar los tributos del Estado$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('041b13de-9886-5067-a23b-55ddf98c1cdf', 'fc26689b-b8c2-5cdb-b63c-c96f0dc8da43', $$Coordinar las políticas nacionales del Poder Ejecutivo y ejercer la rectoría en modernización del Estado$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('28468cc7-33d2-5ee3-868a-889faf48090f', 'fc26689b-b8c2-5cdb-b63c-c96f0dc8da43', $$Aprobar el presupuesto nacional$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('67d0871d-4b5d-5ca0-9c35-cd8cf1451420', 'fc26689b-b8c2-5cdb-b63c-c96f0dc8da43', $$Supervisar al Poder Judicial$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 97
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('b68a3347-8c50-5720-939b-72adb1ef0ce9', '00000000-0036-4000-8000-000000000001',
  $$¿Qué es SERVIR y cuál es su rol?$$,
  $$SERVIR es el organismo rector del sistema de gestión de recursos humanos del Estado peruano.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('06984b06-0129-523f-9dae-5290914bbd9d', 'b68a3347-8c50-5720-939b-72adb1ef0ce9', $$Empresa del Estado de servicios de limpieza$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('69104ea8-bf54-54bc-aeb2-0aea890321f7', 'b68a3347-8c50-5720-939b-72adb1ef0ce9', $$La Autoridad Nacional del Servicio Civil que regula la gestión de recursos humanos del Estado$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('3b99827f-0a75-50ac-9221-442a53acfb48', 'b68a3347-8c50-5720-939b-72adb1ef0ce9', $$Un sindicato de trabajadores del Estado$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('1aa0636e-3dcb-5c4f-8a5d-1e32b55f8c52', 'b68a3347-8c50-5720-939b-72adb1ef0ce9', $$Una unidad de la Contraloría$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 98
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('4766f97c-6067-5d7f-8fa2-34994a43b52d', '00000000-0036-4000-8000-000000000001',
  $$En el marco de la Modernización del Estado, ¿qué significa 'orientación al ciudadano'?$$,
  $$La orientación al ciudadano es pilar de la modernización: servicios diseñados pensando en las necesidades reales.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('f4c776c7-05a3-5822-aff1-6617b3628500', '4766f97c-6067-5d7f-8fa2-34994a43b52d', $$El Estado puede ignorar necesidades ciudadanas$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('2ae88ad9-1db6-5186-8af8-5b7a6a0db359', '4766f97c-6067-5d7f-8fa2-34994a43b52d', $$Todas las acciones del Estado deben enfocarse en satisfacer las necesidades del ciudadano con calidad$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('0ec75234-1852-5bd2-af9d-0572913fedd0', '4766f97c-6067-5d7f-8fa2-34994a43b52d', $$Solo algunos ciudadanos reciben servicios del Estado$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('eb123c95-a5a6-5ec6-bcc4-6864479836b8', '4766f97c-6067-5d7f-8fa2-34994a43b52d', $$El ciudadano debe orientarse por sí mismo$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 99
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('0240dd16-8241-58cb-8b35-5506495c5540', '00000000-0036-4000-8000-000000000001',
  $$¿Cuál es el rol de la Oficina de Abastecimiento dentro de la Oficina General de Administración de la PCM?$$,
  $$La Oficina de Abastecimiento gestiona logística institucional, incluyendo el parque automotor.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('7d8ebb5c-f108-5745-a993-fa77c3cab4fc', '0240dd16-8241-58cb-8b35-5506495c5540', $$Gestionar los recursos humanos$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('590a4455-6d21-5d1a-8e88-df654b8e6157', '0240dd16-8241-58cb-8b35-5506495c5540', $$Administrar los procesos de contratación pública, adquisición de bienes y control del parque vehicular$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('afb007ca-7733-589c-b17d-2495e9ee38fa', '0240dd16-8241-58cb-8b35-5506495c5540', $$Controlar el presupuesto anual$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('72fbb743-48fd-56fe-a824-7d276337b5c2', '0240dd16-8241-58cb-8b35-5506495c5540', $$Supervisar los sistemas de información$$, false, 3)
ON CONFLICT (id) DO NOTHING;

-- Pregunta 100
INSERT INTO questions (id, quiz_id, prompt, explanation, is_pinned, fixed_position)
VALUES ('66293b3b-b391-5df2-81de-73764121dd7b', '00000000-0036-4000-8000-000000000001',
  $$¿Qué principio establece que los recursos del Estado deben usarse optimizando resultados con el mínimo gasto?$$,
  $$La eficiencia en el uso de recursos es mandato constitucional: lograr más con menos, sin derrochar.$$,
  false, NULL
) ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('04f3faee-36f0-5dd6-bcd8-e4198059f304', '66293b3b-b391-5df2-81de-73764121dd7b', $$Principio de legalidad$$, false, 0)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('b5bb0676-67fe-5e66-a7b5-e76d42257e15', '66293b3b-b391-5df2-81de-73764121dd7b', $$Principio de eficiencia en el uso de los recursos públicos$$, true, 1)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('5acac6cc-4911-5400-a6d7-aeefd56f95eb', '66293b3b-b391-5df2-81de-73764121dd7b', $$Principio de transparencia$$, false, 2)
ON CONFLICT (id) DO NOTHING;
INSERT INTO options (id, question_id, label, is_correct, position)
VALUES ('21d70e0c-f8e4-530e-8240-3cd1bd6d98fa', '66293b3b-b391-5df2-81de-73764121dd7b', $$Principio de subsidiariedad$$, false, 3)
ON CONFLICT (id) DO NOTHING;

COMMIT;

-- Para verificar:
-- SELECT COUNT(*) FROM questions WHERE quiz_id = '00000000-0036-4000-8000-000000000001';
-- SELECT COUNT(*) FROM options  WHERE question_id IN (SELECT id FROM questions WHERE quiz_id = '00000000-0036-4000-8000-000000000001');