-- ============================================================
--  JIMÉNEZ JUMPING — Tabla de Promociones
--  Ejecuta en Supabase → SQL Editor → New Query → Run
-- ============================================================

CREATE TABLE IF NOT EXISTS promotions (
    id          TEXT PRIMARY KEY,
    title       TEXT NOT NULL,
    description TEXT DEFAULT '',
    discount    TEXT DEFAULT '',
    status      TEXT DEFAULT 'Activa',
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE promotions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_all_promotions" ON promotions;
CREATE POLICY "anon_all_promotions" ON promotions FOR ALL USING (true) WITH CHECK (true);
