CREATE TABLE IF NOT EXISTS public.duel_result_counter (
    total          integer NOT NULL DEFAULT 0,
    wins           integer NOT NULL DEFAULT 0,
    losses         integer NOT NULL DEFAULT 0,
    draws_abandons integer NOT NULL DEFAULT 0
);

ALTER TABLE public.duel_result_counter ENABLE ROW LEVEL SECURITY;
