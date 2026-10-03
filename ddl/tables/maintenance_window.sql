CREATE TABLE IF NOT EXISTS public.maintenance_window (
    id        bigserial   PRIMARY KEY,
    active    boolean     NOT NULL DEFAULT false,
    starts_at timestamptz NOT NULL,
    ends_at   timestamptz NOT NULL
);

CREATE UNIQUE INDEX uq_maintenance_window_one_active
    ON public.maintenance_window (active)
    WHERE active;

ALTER TABLE public.maintenance_window ENABLE ROW LEVEL SECURITY;

CREATE POLICY maintenance_window_select_anon
    ON public.maintenance_window
    FOR SELECT
    TO anon
    USING (active);
