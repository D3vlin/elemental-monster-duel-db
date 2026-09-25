CREATE TABLE IF NOT EXISTS public.locale (
    code varchar(5) PRIMARY KEY
);

ALTER TABLE public.locale ENABLE ROW LEVEL SECURITY;
