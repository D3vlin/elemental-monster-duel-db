CREATE TABLE IF NOT EXISTS public.power_rank (
    code varchar(32) PRIMARY KEY
);

ALTER TABLE public.power_rank ENABLE ROW LEVEL SECURITY;
