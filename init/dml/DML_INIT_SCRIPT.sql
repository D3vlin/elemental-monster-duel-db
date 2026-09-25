-- dml/tables/locale.sql
INSERT INTO public.locale (code) VALUES
    ('es'), ('en')
ON CONFLICT (code) DO NOTHING;

-- dml/tables/element.sql
INSERT INTO public.element (code) VALUES
    ('EARTH'), ('WATER'), ('AIR'), ('ETHER'), ('VOID'), ('PLASMA'),
    ('FIRE'), ('SULFUR'), ('FLESH'), ('BLOOD'), ('FUNGI'), ('CARBON')
ON CONFLICT (code) DO NOTHING;

-- dml/tables/power_rank.sql
INSERT INTO public.power_rank (code) VALUES
    ('SPAWN'), ('HUNTER'), ('ABOMINATION'), ('SUPREME_ANCESTRAL')
ON CONFLICT (code) DO NOTHING;

-- dml/tables/element_translation.sql
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

-- dml/tables/power_rank_translation.sql
INSERT INTO public.power_rank_translation (power_rank, locale_id, label)
SELECT v.power_rank, l.id, v.label
FROM (VALUES
    ('SPAWN',             'es', 'Engendro'),          ('SPAWN',             'en', 'Spawn'),
    ('HUNTER',            'es', 'Cazador'),           ('HUNTER',            'en', 'Hunter'),
    ('ABOMINATION',       'es', 'Abominación'),       ('ABOMINATION',       'en', 'Abomination'),
    ('SUPREME_ANCESTRAL', 'es', 'Ancestral Supremo'), ('SUPREME_ANCESTRAL', 'en', 'Supreme Ancestral')
) AS v(power_rank, locale, label)
JOIN public.locale l ON l.code = v.locale
ON CONFLICT (power_rank, locale_id) DO UPDATE SET label = EXCLUDED.label;
