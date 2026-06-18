-- ============================================================
--  JIMÉNEZ JUMPING — SUPABASE SETUP COMPLETO
--  Ejecuta este archivo UNA SOLA VEZ en el SQL Editor de Supabase
--  Proyecto → SQL Editor → New Query → pega y corre
-- ============================================================

-- Habilitar extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";


-- ============================================================
-- 1. CATEGORÍAS
-- ============================================================
CREATE TABLE IF NOT EXISTS categories (
  id          TEXT PRIMARY KEY,
  name        TEXT NOT NULL,
  description TEXT,
  color       TEXT DEFAULT '#0047AB'
);

INSERT INTO categories (id, name, description, color) VALUES
  ('CAT-1', 'Inflables',  'Casas de brinco y atracciones inflables',       '#0047AB'),
  ('CAT-2', 'Snacks',     'Maquinas y consumibles para fiestas',            '#FFD700'),
  ('CAT-3', 'Carpas',     'Cobertura y proteccion para eventos',            '#E60000'),
  ('CAT-4', 'Juegos',     'Juegos gigantes y entretenimiento adicional',    '#9400D3'),
  ('CAT-5', 'Mobiliario', 'Mesas, sillas y equipamiento de eventos',        '#FF8C00'),
  ('CAT-6', 'Equipo',     'Equipos adicionales para eventos',               '#32CD32')
ON CONFLICT (id) DO NOTHING;


-- ============================================================
-- 2. SERVICIOS / INVENTARIO
-- ============================================================
CREATE TABLE IF NOT EXISTS services (
  id          SERIAL PRIMARY KEY,
  name        TEXT    NOT NULL,
  category    TEXT    NOT NULL,
  description TEXT,
  price       NUMERIC(10,2) NOT NULL DEFAULT 0,
  img         TEXT,
  color       TEXT    DEFAULT 'var(--brand-blue)',
  meta        JSONB   DEFAULT '[]',       -- array de strings: ["Todo el día", "Desde $60"]
  stock       INTEGER DEFAULT 1,
  in_use      INTEGER DEFAULT 0,
  capacity    INTEGER DEFAULT 0,          -- personas
  max_weight  INTEGER DEFAULT 0,          -- libras
  photos      JSONB   DEFAULT '[]',       -- URLs de fotos extra
  video_id    TEXT    DEFAULT '',
  active      BOOLEAN DEFAULT TRUE,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO services (id, name, category, description, price, img, color, meta, stock, in_use, capacity, max_weight, photos, video_id, active) VALUES
(1, 'Casa de Brinco',              'Inflables', 'La favorita de las fiestas infantiles, con montaje seguro y mucha diversión para los pequeños.',                     80,  'https://res.cloudinary.com/dkfk7odob/image/upload/v1747524792/WhatsApp_Image_2025-05-13_at_8.23.25_AM_1_xecq3c.jpg', 'var(--brand-blue)',   '["Desde $80"]',           4, 2, 8, 250, '["https://res.cloudinary.com/dkfk7odob/image/upload/v1747524792/WhatsApp_Image_2025-05-13_at_8.23.25_AM_1_xecq3c.jpg"]', '', true),
(2, 'Connect 4 Gigante',           'Juegos',    'Juego gigante perfecto para niños, jóvenes y adultos. Disponible durante todo el día.',                               60,  'https://res.cloudinary.com/dkfk7odob/image/upload/v1781739769/EAST-POINT-SPORTS_GIANT-CONNECT4_TI_2023-1_gpevr1.webp', 'var(--brand-purple)', '["Todo el día","Desde $60"]', 6, 1, 4, 180, '[]', '', true),
(3, 'Carpa',                       'Carpas',    'Cobertura para sol o lluvia que ayuda a mantener tu actividad cómoda y lista para cualquier clima.',                  120, 'https://res.cloudinary.com/dkfk7odob/image/upload/v1747524957/WhatsApp_Image_2025-05-13_at_8.23.26_AM_hq5kgz.jpg', 'var(--brand-red)',    '["Desde $120"]',          6, 1, 0, 0,   '[]', '', true),
(4, 'Máquina de Pop-Corn',         'Snacks',    'Palomitas recién hechas para darle ese toque clásico y delicioso a tu celebración.',                                  50,  'https://res.cloudinary.com/dkfk7odob/image/upload/v1747525170/WhatsApp_Image_2025-05-13_at_8.23.26_AM_1_ylqjrr.jpg', 'var(--brand-yellow)', '["Desde $50"]',           6, 1, 0, 0,   '[]', '', true),
(5, 'Máquina de Algodón de Azúcar','Snacks',    'Un detalle dulce y vistoso que encanta en cumpleaños, escuelas y actividades familiares.',                            50,  'https://res.cloudinary.com/dkfk7odob/image/upload/v1747525267/WhatsApp_Image_2025-05-13_at_8.23.27_AM_o5sgyp.jpg', 'var(--brand-orange)', '["Desde $50"]',           6, 1, 0, 0,   '[]', '', true)
ON CONFLICT (id) DO NOTHING;

-- Resetear secuencia para que el próximo INSERT empiece desde 6
SELECT setval('services_id_seq', (SELECT MAX(id) FROM services));


-- ============================================================
-- 3. COMBOS
-- ============================================================
CREATE TABLE IF NOT EXISTS combos (
  id          TEXT PRIMARY KEY,
  name        TEXT NOT NULL,
  description TEXT,
  price       NUMERIC(10,2) NOT NULL DEFAULT 0,
  img         TEXT,
  color       TEXT DEFAULT 'var(--brand-orange)',
  items       JSONB DEFAULT '[]',        -- nombres de servicios incluidos
  active      BOOLEAN DEFAULT TRUE,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO combos (id, name, description, price, img, color, items, active) VALUES
('familiar',   'Combo Familiar',   'Casa de brinco + 1 mesa + 10 sillas.',                    135, 'https://res.cloudinary.com/dkfk7odob/image/upload/v1747524792/WhatsApp_Image_2025-05-13_at_8.23.25_AM_1_xecq3c.jpg', 'var(--brand-orange)', '["Casa de brinco","1 mesa","10 sillas"]',                           true),
('explosivo',  'Combo Explosivo',  'Casa de brinco + Máquina de Pop-Corn + Algodón de Azúcar.',200, 'https://res.cloudinary.com/dkfk7odob/image/upload/v1747525170/WhatsApp_Image_2025-05-13_at_8.23.26_AM_1_ylqjrr.jpg', 'var(--brand-red)',    '["Casa de brinco","Máquina de Pop-Corn","Máquina de Algodón de Azúcar"]', true),
('tres-casas', '3 Casas Especial', 'Ideal para actividades grandes, escuelas o eventos con muchos niños.', 300, 'https://res.cloudinary.com/dkfk7odob/image/upload/v1747524792/WhatsApp_Image_2025-05-13_at_8.23.25_AM_1_xecq3c.jpg', 'var(--brand-blue)', '["3 casas de brinco"]', true),
('escolar',    'Promo Escolar',    'Casa de brinco disponible de lunes a jueves para actividades escolares.', 85, 'https://res.cloudinary.com/dkfk7odob/image/upload/v1747524792/WhatsApp_Image_2025-05-13_at_8.23.25_AM_1_xecq3c.jpg', 'var(--brand-green)', '["Casa de brinco"]', true)
ON CONFLICT (id) DO NOTHING;


-- ============================================================
-- 4. COTIZACIONES / ÓRDENES
-- ============================================================
CREATE TABLE IF NOT EXISTS quotes (
  id          TEXT PRIMARY KEY DEFAULT ('QT-' || to_char(NOW(), 'YYYYMMDD') || '-' || substr(gen_random_uuid()::text, 1, 6)),
  client      TEXT NOT NULL,
  phone       TEXT NOT NULL,
  alt_phone   TEXT DEFAULT '',
  town        TEXT NOT NULL,
  event_date  DATE,
  address     TEXT DEFAULT '',
  items       JSONB NOT NULL DEFAULT '[]',  -- [{id, name, price, qty}]
  total       NUMERIC(10,2) DEFAULT 0,
  status      TEXT DEFAULT 'Pendiente',     -- Pendiente | Aprobada | Rechazada | Completada
  notes       TEXT DEFAULT '',
  created_at  TIMESTAMPTZ DEFAULT NOW()
);


-- ============================================================
-- 5. CLIENTES
-- ============================================================
CREATE TABLE IF NOT EXISTS customers (
  id          TEXT PRIMARY KEY DEFAULT ('CUS-' || substr(gen_random_uuid()::text, 1, 8)),
  name        TEXT NOT NULL,
  phone       TEXT DEFAULT '',
  alt_phone   TEXT DEFAULT '',
  town        TEXT DEFAULT '',
  address     TEXT DEFAULT '',
  email       TEXT DEFAULT '',
  status      TEXT DEFAULT 'Prospecto',    -- Prospecto | Activo | Inactivo
  created_at  TIMESTAMPTZ DEFAULT NOW()
);


-- ============================================================
-- 6. RESEÑAS
-- ============================================================
CREATE TABLE IF NOT EXISTS reviews (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL,
  stars       INTEGER NOT NULL CHECK (stars BETWEEN 1 AND 5),
  comment     TEXT NOT NULL,
  status      TEXT DEFAULT 'Pendiente',    -- Pendiente | Aprobada | Rechazada
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Reseñas de ejemplo (aprobadas)
INSERT INTO reviews (name, stars, comment, status) VALUES
  ('María González',   5, '¡Excelente servicio! La casa de brinco llegó puntual y los niños disfrutaron muchísimo. 100% recomendado.',    'Aprobada'),
  ('Carlos Rodríguez', 5, 'Muy profesionales. El equipo llegó temprano, montaron todo rápido y el servicio fue impecable.',              'Aprobada'),
  ('Ana Martínez',     5, 'Usé el Combo Familiar para el cumpleaños de mi hijo y quedé encantada. Los volveré a contratar.',              'Aprobada')
ON CONFLICT DO NOTHING;


-- ============================================================
-- 7. PROVEEDORES
-- ============================================================
CREATE TABLE IF NOT EXISTS suppliers (
  id              TEXT PRIMARY KEY,
  name            TEXT NOT NULL,
  category        TEXT,
  contact         TEXT,
  total_supplied  NUMERIC(10,2) DEFAULT 0,
  status          TEXT DEFAULT 'Activo'   -- Activo | Inactivo
);

INSERT INTO suppliers (id, name, category, contact, total_supplied, status) VALUES
  ('SUP-1', 'Inflables Boricua', 'Inflables', '787-301-2201', 4200, 'Activo'),
  ('SUP-2', 'Eventos Caribe',    'Carpas',    '787-998-1144', 3100, 'Activo'),
  ('SUP-3', 'Snacks Express PR', 'Snacks',    '939-220-8822', 1850, 'Activo')
ON CONFLICT (id) DO NOTHING;


-- ============================================================
-- 8. ÓRDENES DE COMPRA / GASTOS
-- ============================================================
CREATE TABLE IF NOT EXISTS purchases (
  id          TEXT PRIMARY KEY,
  supplier    TEXT NOT NULL,
  date        DATE NOT NULL,
  concept     TEXT,
  total       NUMERIC(10,2) DEFAULT 0,
  status      TEXT DEFAULT 'En proceso',  -- En proceso | Recibida | Cancelada
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO purchases (id, supplier, date, concept, total, status) VALUES
  ('PO-1001', 'Inflables Boricua', '2026-05-02', 'Mantenimiento inflables',      420, 'Recibida'),
  ('PO-1002', 'Eventos Caribe',    '2026-05-12', 'Refuerzo carpas y amarres',    280, 'Recibida'),
  ('PO-1003', 'Snacks Express PR', '2026-05-20', 'Consumibles y azucar',         165, 'En proceso')
ON CONFLICT (id) DO NOTHING;


-- ============================================================
-- 9. CONFIGURACIÓN / SETTINGS
-- ============================================================
CREATE TABLE IF NOT EXISTS settings (
  label  TEXT PRIMARY KEY,
  title  TEXT NOT NULL,
  value  TEXT DEFAULT '',
  hint   TEXT DEFAULT ''
);

INSERT INTO settings (label, title, value, hint) VALUES
  ('hero_titulo',    'Título Principal (Hero)',    '¡Diversión asegurada para tu evento!',                              'Texto grande del banner de inicio'),
  ('hero_subtitulo', 'Subtítulo Hero',             'Casas de brinco, máquinas de snacks y carpas en todo Puerto Rico.','Descripción debajo del título principal'),
  ('whatsapp',       'Número WhatsApp',            '19392645915',                                                       'Número completo con código de país, sin + ni espacios'),
  ('nombre_negocio', 'Nombre del Negocio',         'Jiménez Jumping',                                                   'Nombre que aparece en la página y documentos'),
  ('base_operativa', 'Base Operativa / Dirección', 'Barranquitas, Puerto Rico',                                         'Municipio o dirección de origen'),
  ('email',          'Email de Contacto',          '',                                                                  'Correo electrónico visible al público'),
  ('facebook',       'Facebook (URL completa)',     '',                                                                  'Ej: https://facebook.com/tu-pagina'),
  ('instagram',      'Instagram (@usuario)',        '',                                                                  'Ej: @jimenes_jumping')
ON CONFLICT (label) DO NOTHING;


-- ============================================================
-- 10. USUARIOS ADMIN
--     La contraseña se guarda con bcrypt via pgcrypto.
--     Contraseña inicial: admin123
-- ============================================================
CREATE TABLE IF NOT EXISTS admin_users (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  username      TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role          TEXT DEFAULT 'admin',   -- admin | editor
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO admin_users (username, password_hash, role)
VALUES ('admin', crypt('admin123', gen_salt('bf')), 'admin')
ON CONFLICT (username) DO NOTHING;


-- ============================================================
-- 11. FUNCIÓN: validar login del admin
--     Uso desde el JS: SELECT * FROM validate_admin_login('admin','admin123')
-- ============================================================
CREATE OR REPLACE FUNCTION validate_admin_login(p_username TEXT, p_password TEXT)
RETURNS TABLE(id UUID, username TEXT, role TEXT) AS $$
BEGIN
  RETURN QUERY
  SELECT u.id, u.username, u.role
  FROM admin_users u
  WHERE u.username = p_username
    AND u.password_hash = crypt(p_password, u.password_hash);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- ============================================================
-- 12. ROW LEVEL SECURITY (RLS)
-- ============================================================

-- Habilitar RLS en todas las tablas
ALTER TABLE categories    ENABLE ROW LEVEL SECURITY;
ALTER TABLE services      ENABLE ROW LEVEL SECURITY;
ALTER TABLE combos        ENABLE ROW LEVEL SECURITY;
ALTER TABLE quotes        ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers     ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews       ENABLE ROW LEVEL SECURITY;
ALTER TABLE suppliers     ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchases     ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings      ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_users   ENABLE ROW LEVEL SECURITY;

-- ── Datos PÚBLICOS (lectura libre para el sitio público) ──────────────────

CREATE POLICY "public_read_categories" ON categories
  FOR SELECT USING (true);

CREATE POLICY "public_read_services" ON services
  FOR SELECT USING (active = true);

CREATE POLICY "public_read_combos" ON combos
  FOR SELECT USING (active = true);

-- Sólo reseñas aprobadas son visibles al público
CREATE POLICY "public_read_approved_reviews" ON reviews
  FOR SELECT USING (status = 'Aprobada');

-- Settings: lectura pública (el sitio los necesita para mostrarse)
CREATE POLICY "public_read_settings" ON settings
  FOR SELECT USING (true);

-- ── COTIZACIONES: cualquiera puede insertar (formulario público) ──────────

CREATE POLICY "public_insert_quotes" ON quotes
  FOR INSERT WITH CHECK (true);

-- ── RESEÑAS: cualquiera puede insertar ───────────────────────────────────

CREATE POLICY "public_insert_reviews" ON reviews
  FOR INSERT WITH CHECK (true);

-- ── Todo lo demás requiere la service_role key (panel admin) ─────────────
-- El panel admin usa la SERVICE ROLE KEY → bypasses RLS automáticamente.
-- No necesitas políticas extra para el admin si usas service_role key.
-- Si prefieres usar la anon key para todo, descomenta las siguientes líneas:

-- CREATE POLICY "anon_all_quotes"     ON quotes     FOR ALL USING (true) WITH CHECK (true);
-- CREATE POLICY "anon_all_customers"  ON customers  FOR ALL USING (true) WITH CHECK (true);
-- CREATE POLICY "anon_all_reviews"    ON reviews    FOR ALL USING (true) WITH CHECK (true);
-- CREATE POLICY "anon_all_suppliers"  ON suppliers  FOR ALL USING (true) WITH CHECK (true);
-- CREATE POLICY "anon_all_purchases"  ON purchases  FOR ALL USING (true) WITH CHECK (true);
-- CREATE POLICY "anon_all_settings"   ON settings   FOR ALL USING (true) WITH CHECK (true);
-- CREATE POLICY "anon_all_services"   ON services   FOR ALL USING (true) WITH CHECK (true);
-- CREATE POLICY "anon_all_combos"     ON combos     FOR ALL USING (true) WITH CHECK (true);
-- CREATE POLICY "anon_all_categories" ON categories FOR ALL USING (true) WITH CHECK (true);


-- ============================================================
-- 13. ÍNDICES para rendimiento
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_quotes_status      ON quotes(status);
CREATE INDEX IF NOT EXISTS idx_quotes_created     ON quotes(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_reviews_status     ON reviews(status);
CREATE INDEX IF NOT EXISTS idx_services_category  ON services(category);
CREATE INDEX IF NOT EXISTS idx_services_active    ON services(active);
CREATE INDEX IF NOT EXISTS idx_customers_phone    ON customers(phone);


-- ============================================================
-- ✅ LISTO
-- ============================================================
-- Tablas creadas:
--   categories, services, combos, quotes, customers,
--   reviews, suppliers, purchases, settings, admin_users
--
-- Función de login: validate_admin_login(username, password)
--
-- PRÓXIMOS PASOS:
--   1. Copia tu SUPABASE_URL y SUPABASE_ANON_KEY desde:
--      Supabase → Settings → API
--   2. Para el panel admin usa la SERVICE_ROLE_KEY (nunca la expongas en front-end sin proteger)
--      O activa las políticas anon comentadas arriba para un setup más simple.
--   3. Para cambiar la contraseña del admin ejecuta:
--      UPDATE admin_users
--        SET password_hash = crypt('nueva_contraseña', gen_salt('bf'))
--      WHERE username = 'admin';
-- ============================================================
