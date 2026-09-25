INSERT INTO public.locale (code) VALUES
    ('es'), ('en')
ON CONFLICT (code) DO NOTHING;
