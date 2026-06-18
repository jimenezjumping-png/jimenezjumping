-- ============================================================
--  JIMÉNEZ JUMPING — Fix RLS (permisos de escritura)
--  Ejecuta en Supabase → SQL Editor → New Query → Run
-- ============================================================

-- Servicios
DROP POLICY IF EXISTS "public_read_services" ON services;
DROP POLICY IF EXISTS "anon_all_services"    ON services;
CREATE POLICY "anon_all_services"   ON services   FOR ALL USING (true) WITH CHECK (true);

-- Cotizaciones
DROP POLICY IF EXISTS "public_insert_quotes" ON quotes;
DROP POLICY IF EXISTS "anon_all_quotes"      ON quotes;
CREATE POLICY "anon_all_quotes"     ON quotes     FOR ALL USING (true) WITH CHECK (true);

-- Clientes
DROP POLICY IF EXISTS "anon_all_customers"   ON customers;
CREATE POLICY "anon_all_customers"  ON customers  FOR ALL USING (true) WITH CHECK (true);

-- Reseñas
DROP POLICY IF EXISTS "public_read_approved_reviews" ON reviews;
DROP POLICY IF EXISTS "public_insert_reviews"        ON reviews;
DROP POLICY IF EXISTS "anon_all_reviews"             ON reviews;
CREATE POLICY "anon_all_reviews"    ON reviews    FOR ALL USING (true) WITH CHECK (true);

-- Categorías
DROP POLICY IF EXISTS "public_read_categories" ON categories;
DROP POLICY IF EXISTS "anon_all_categories"    ON categories;
CREATE POLICY "anon_all_categories" ON categories FOR ALL USING (true) WITH CHECK (true);

-- Proveedores
DROP POLICY IF EXISTS "anon_all_suppliers"   ON suppliers;
CREATE POLICY "anon_all_suppliers"  ON suppliers  FOR ALL USING (true) WITH CHECK (true);

-- Compras
DROP POLICY IF EXISTS "anon_all_purchases"   ON purchases;
CREATE POLICY "anon_all_purchases"  ON purchases  FOR ALL USING (true) WITH CHECK (true);

-- Configuración
DROP POLICY IF EXISTS "public_read_settings" ON settings;
DROP POLICY IF EXISTS "anon_all_settings"    ON settings;
CREATE POLICY "anon_all_settings"   ON settings   FOR ALL USING (true) WITH CHECK (true);

-- Combos
DROP POLICY IF EXISTS "anon_all_combos"      ON combos;
CREATE POLICY "anon_all_combos"     ON combos     FOR ALL USING (true) WITH CHECK (true);
