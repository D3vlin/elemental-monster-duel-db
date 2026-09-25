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
