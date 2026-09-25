CREATE TABLE IF NOT EXISTS public.element_translation (
    element varchar(16) NOT NULL,
    locale  varchar(5)  NOT NULL,
    label   varchar(40) NOT NULL,

    CONSTRAINT pk_element_translation PRIMARY KEY (element, locale),
    CONSTRAINT fk_element_translation_element FOREIGN KEY (element) REFERENCES public.element (code),
    CONSTRAINT fk_element_translation_locale FOREIGN KEY (locale) REFERENCES public.locale (code)
);

ALTER TABLE public.element_translation ENABLE ROW LEVEL SECURITY;
