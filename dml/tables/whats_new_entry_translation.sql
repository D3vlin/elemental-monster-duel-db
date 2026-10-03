INSERT INTO public.whats_new_entry_translation (whats_new_entry_id, locale_id, title, body)
SELECT e.id, l.id, v.title, v.body
FROM (VALUES
    ('launch', 'es', '¡Bienvenido a Elemental Monster Duel!',
        'Empieza la aventura. Este es el primer paso de un juego que va a seguir creciendo.'),
    ('launch', 'en', 'Welcome to Elemental Monster Duel!',
        'The adventure begins. This is the first step of a game that''s going to keep growing.'),

    ('theme-and-language', 'es', 'Modo claro/oscuro y selector de idioma',
        'Ahora podés cambiar entre modo claro y oscuro, y elegir entre español e inglés, desde cualquier pantalla.'),
    ('theme-and-language', 'en', 'Dark/light mode and language switch',
        'You can now switch between light and dark mode, and choose between Spanish and English, from any screen.')
) AS v(slug, locale, title, body)
JOIN public.whats_new_entry e ON e.slug = v.slug
JOIN public.locale l ON l.code = v.locale
ON CONFLICT (whats_new_entry_id, locale_id) DO UPDATE SET title = EXCLUDED.title, body = EXCLUDED.body;
