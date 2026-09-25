CREATE TABLE IF NOT EXISTS public.power_rank_translation (
    power_rank varchar(32) NOT NULL,
    locale     varchar(5)  NOT NULL,
    label      varchar(40) NOT NULL,

    CONSTRAINT pk_power_rank_translation PRIMARY KEY (power_rank, locale),
    CONSTRAINT fk_power_rank_translation_power_rank FOREIGN KEY (power_rank) REFERENCES public.power_rank (code),
    CONSTRAINT fk_power_rank_translation_locale FOREIGN KEY (locale) REFERENCES public.locale (code)
);

ALTER TABLE public.power_rank_translation ENABLE ROW LEVEL SECURITY;
