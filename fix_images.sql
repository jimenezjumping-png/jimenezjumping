-- Ejecuta esto en Supabase → SQL Editor → New Query → Run
-- Reemplaza las imágenes incorrectas por las URLs reales de tu Cloudinary

UPDATE services SET
  img    = 'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781738709/WhatsApp_Image_2026-06-17_at_7.22.48_PM_atnoph.jpg',
  photos = '["https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781738709/WhatsApp_Image_2026-06-17_at_7.22.48_PM_atnoph.jpg","https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781738703/WhatsApp_Image_2026-06-17_at_7.22.48_PM_1_kykpax.jpg","https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781738700/WhatsApp_Image_2026-06-17_at_7.22.48_PM_3_ggvz1p.jpg"]'
WHERE id = 1;

UPDATE services SET
  img    = 'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781739769/EAST-POINT-SPORTS_GIANT-CONNECT4_TI_2023-1_gpevr1.webp',
  photos = '["https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781739769/EAST-POINT-SPORTS_GIANT-CONNECT4_TI_2023-1_gpevr1.webp"]'
WHERE id = 2;

UPDATE services SET
  img    = 'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781739007/image6-carpa_mjagul.jpg',
  photos = '["https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781739007/image6-carpa_mjagul.jpg"]'
WHERE id = 3;

UPDATE services SET
  img    = 'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781739006/image5-popcorn_ggnzjh.jpg',
  photos = '["https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781739006/image5-popcorn_ggnzjh.jpg"]'
WHERE id = 4;

UPDATE services SET
  img    = 'https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781739004/image4-algodon_svp0qb.jpg',
  photos = '["https://res.cloudinary.com/dtw3qx4qq/image/upload/q_auto/f_auto/v1781739004/image4-algodon_svp0qb.jpg"]'
WHERE id = 5;
