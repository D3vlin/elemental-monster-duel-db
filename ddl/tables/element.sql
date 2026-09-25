CREATE TABLE IF NOT EXISTS public.element (
    code varchar(16) PRIMARY KEY
);

ALTER TABLE public.element ENABLE ROW LEVEL SECURITY;
