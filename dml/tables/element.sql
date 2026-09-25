INSERT INTO public.element (code) VALUES
    ('EARTH'), ('WATER'), ('AIR'), ('ETHER'), ('VOID'), ('PLASMA'),
    ('FIRE'), ('SULFUR'), ('FLESH'), ('BLOOD'), ('FUNGI'), ('CARBON')
ON CONFLICT (code) DO NOTHING;
