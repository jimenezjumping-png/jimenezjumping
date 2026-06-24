-- ============================================================
--  JIMÉNEZ JUMPING — Corregir imágenes de combos
--  Ejecuta en Supabase → SQL Editor → New Query → Run
-- ============================================================

-- Asegurarse de que la tabla tiene RLS permisivo
ALTER TABLE combos ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "anon_all_combos" ON combos;
CREATE POLICY "anon_all_combos" ON combos FOR ALL USING (true) WITH CHECK (true);

-- Actualizar combos con imágenes correctas y datos actualizados
INSERT INTO combos (id, name, description, price, img, color, items, active)
VALUES
  ('familiar',   'Combo Familiar',
   'Perfecto para reuniones familiares y cumpleaños en casa.',
   135,
   'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781738709/WhatsApp_Image_2026-06-17_at_7.22.48_PM_atnoph.jpg',
   'var(--brand-orange)',
   '["Casa de brinco","1 mesa","10 sillas"]',
   true),
  ('explosivo',  'Combo Explosivo',
   'Una mezcla completa de brincos y snacks para subir la emoción.',
   200,
   'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781738703/WhatsApp_Image_2026-06-17_at_7.22.48_PM_1_kykpax.jpg',
   'var(--brand-red)',
   '["Casa de brinco","Máquina de Pop-Corn","Máquina de Algodón de Azúcar"]',
   true),
  ('tres-casas', '3 Casas Especial',
   'Ideal para actividades grandes, escuelas o eventos con muchos niños.',
   300,
   'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781738700/WhatsApp_Image_2026-06-17_at_7.22.48_PM_3_ggvz1p.jpg',
   'var(--brand-blue)',
   '["3 casas de brinco"]',
   true),
  ('escolar',    'Promo Escolar',
   'Disponible de lunes a jueves para actividades escolares.',
   85,
   'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781738709/WhatsApp_Image_2026-06-17_at_7.22.48_PM_atnoph.jpg',
   'var(--brand-green)',
   '["Casa de brinco","Válido lunes a jueves"]',
   true)
ON CONFLICT (id) DO UPDATE SET
  name        = EXCLUDED.name,
  description = EXCLUDED.description,
  price       = EXCLUDED.price,
  img         = EXCLUDED.img,
  color       = EXCLUDED.color,
  items       = EXCLUDED.items,
  active      = EXCLUDED.active;
