INSERT INTO public.element_translation (element, locale_id, label)
SELECT v.element, l.id, v.label
FROM (VALUES
    ('EARTH',  'es', 'Tierra'),  ('EARTH',  'en', 'Earth'),
    ('WATER',  'es', 'Agua'),    ('WATER',  'en', 'Water'),
    ('AIR',    'es', 'Aire'),    ('AIR',    'en', 'Air'),
    ('ETHER',  'es', 'Éter'),    ('ETHER',  'en', 'Ether'),
    ('VOID',   'es', 'Vacío'),   ('VOID',   'en', 'Void'),
    ('PLASMA', 'es', 'Plasma'),  ('PLASMA', 'en', 'Plasma'),
    ('FIRE',   'es', 'Fuego'),   ('FIRE',   'en', 'Fire'),
    ('SULFUR', 'es', 'Azufre'),  ('SULFUR', 'en', 'Sulfur'),
    ('FLESH',  'es', 'Carne'),   ('FLESH',  'en', 'Flesh'),
    ('BLOOD',  'es', 'Sangre'),  ('BLOOD',  'en', 'Blood'),
    ('FUNGI',  'es', 'Hongos'),  ('FUNGI',  'en', 'Fungi'),
    ('CARBON', 'es', 'Carbono'), ('CARBON', 'en', 'Carbon')
) AS v(element, locale, label)
JOIN public.locale l ON l.code = v.locale
ON CONFLICT (element, locale_id) DO UPDATE SET label = EXCLUDED.label;
