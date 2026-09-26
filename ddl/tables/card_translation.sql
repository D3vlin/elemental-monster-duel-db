CREATE TABLE IF NOT EXISTS public.card_translation (
    card_id   bigint       NOT NULL,
    locale_id bigint       NOT NULL,
    lore      varchar(300) NOT NULL,

    CONSTRAINT pk_card_translation PRIMARY KEY (card_id, locale_id),
    CONSTRAINT fk_card_translation_card FOREIGN KEY (card_id) REFERENCES public.card (id),
    CONSTRAINT fk_card_translation_locale FOREIGN KEY (locale_id) REFERENCES public.locale (id)
);

ALTER TABLE public.card_translation ENABLE ROW LEVEL SECURITY;
