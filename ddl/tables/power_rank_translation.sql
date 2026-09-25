CREATE TABLE IF NOT EXISTS public.power_rank_translation (
    power_rank varchar(32) NOT NULL,
    locale_id  bigint      NOT NULL,
    label      varchar(40) NOT NULL,

    CONSTRAINT pk_power_rank_translation PRIMARY KEY (power_rank, locale_id),
    CONSTRAINT fk_power_rank_translation_power_rank FOREIGN KEY (power_rank) REFERENCES public.power_rank (code),
    CONSTRAINT fk_power_rank_translation_locale FOREIGN KEY (locale_id) REFERENCES public.locale (id)
);

ALTER TABLE public.power_rank_translation ENABLE ROW LEVEL SECURITY;
