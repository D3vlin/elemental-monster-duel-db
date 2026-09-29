INSERT INTO public.whats_new_entry (slug, published_at) VALUES
    ('launch',              '2026-09-25T00:00:00Z'),
    ('theme-and-language',  '2026-09-27T00:00:00Z')
ON CONFLICT (slug) DO UPDATE SET published_at = EXCLUDED.published_at;
