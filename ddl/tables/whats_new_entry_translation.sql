CREATE TABLE IF NOT EXISTS public.whats_new_entry_translation (
    whats_new_entry_id bigint       NOT NULL,
    locale_id          bigint       NOT NULL,
    title              varchar(120) NOT NULL,
    body               varchar(500) NOT NULL,

    CONSTRAINT pk_whats_new_entry_translation PRIMARY KEY (whats_new_entry_id, locale_id),
    CONSTRAINT fk_whats_new_entry_translation_entry FOREIGN KEY (whats_new_entry_id) REFERENCES public.whats_new_entry (id),
    CONSTRAINT fk_whats_new_entry_translation_locale FOREIGN KEY (locale_id) REFERENCES public.locale (id)
);

ALTER TABLE public.whats_new_entry_translation ENABLE ROW LEVEL SECURITY;
