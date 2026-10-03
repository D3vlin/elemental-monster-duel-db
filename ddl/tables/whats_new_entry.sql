CREATE TABLE IF NOT EXISTS public.whats_new_entry (
    id           bigserial   PRIMARY KEY,
    slug         varchar(60) NOT NULL UNIQUE,
    published_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.whats_new_entry ENABLE ROW LEVEL SECURITY;
