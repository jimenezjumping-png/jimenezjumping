-- ============================================================
--  JIMÉNEZ JUMPING — Foto obligatoria en reseñas
--  Ejecuta en Supabase → SQL Editor → New Query → Run
-- ============================================================

-- 1. Agregar columna foto a la tabla reviews
ALTER TABLE reviews ADD COLUMN IF NOT EXISTS photo_url TEXT DEFAULT '';

-- 2. Crear bucket público para las fotos de reseñas
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'review-photos',
  'review-photos',
  true,
  1073741824,   -- 1 GB máximo
  ARRAY['image/jpeg','image/jpg','image/png','image/webp']
)
ON CONFLICT (id) DO NOTHING;

-- 3. Permitir que cualquiera suba fotos al bucket
DROP POLICY IF EXISTS "public_upload_review_photos" ON storage.objects;
CREATE POLICY "public_upload_review_photos"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'review-photos');

-- 4. Permitir que cualquiera lea las fotos
DROP POLICY IF EXISTS "public_read_review_photos" ON storage.objects;
CREATE POLICY "public_read_review_photos"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'review-photos');
