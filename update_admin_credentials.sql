-- ============================================================
--  JIMÉNEZ JUMPING — Actualizar credenciales de administrador
--  Ejecuta en Supabase → SQL Editor → New Query → Run
--
--  La contraseña queda guardada como hash bcrypt (no en texto).
--  Nadie puede leerla directamente desde la base de datos.
-- ============================================================

-- Asegurarse de que pgcrypto está activo
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Eliminar usuario anterior (admin por defecto)
DELETE FROM admin_users WHERE username = 'admin';

-- Crear usuario Yomar con contraseña hasheada (bcrypt, costo 12)
INSERT INTO admin_users (username, password_hash, role)
VALUES (
    'Yomar',
    crypt('Jimenez1234$', gen_salt('bf', 12)),
    'admin'
)
ON CONFLICT (username) DO UPDATE SET
    password_hash = crypt('Jimenez1234$', gen_salt('bf', 12)),
    role          = 'admin';
