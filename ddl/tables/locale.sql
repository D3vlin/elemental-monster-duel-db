CREATE TABLE IF NOT EXISTS public.locale (
    id   bigserial   PRIMARY KEY,
    code varchar(5)  NOT NULL UNIQUE
);

ALTER TABLE public.locale ENABLE ROW LEVEL SECURITY;
