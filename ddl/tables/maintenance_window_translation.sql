CREATE TABLE IF NOT EXISTS public.maintenance_window_translation (
    maintenance_window_id bigint       NOT NULL,
    locale_id             bigint       NOT NULL,
    title                 varchar(120) NOT NULL,
    message               varchar(500) NOT NULL,
    note                  varchar(300),

    CONSTRAINT pk_maintenance_window_translation PRIMARY KEY (maintenance_window_id, locale_id),
    CONSTRAINT fk_maintenance_window_translation_window FOREIGN KEY (maintenance_window_id) REFERENCES public.maintenance_window (id),
    CONSTRAINT fk_maintenance_window_translation_locale FOREIGN KEY (locale_id) REFERENCES public.locale (id)
);

ALTER TABLE public.maintenance_window_translation ENABLE ROW LEVEL SECURITY;

CREATE POLICY maintenance_window_translation_select_anon
    ON public.maintenance_window_translation
    FOR SELECT
    TO anon
    USING (
        EXISTS (
            SELECT 1
            FROM public.maintenance_window w
            WHERE w.id = maintenance_window_translation.maintenance_window_id
              AND w.active
        )
    );
