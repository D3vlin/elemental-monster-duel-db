CREATE SCHEMA IF NOT EXISTS public;

-- ddl/tables/duel_result_counter.sql
CREATE TABLE IF NOT EXISTS public.duel_result_counter (
    total    integer NOT NULL DEFAULT 0,
    wins     integer NOT NULL DEFAULT 0,
    losses   integer NOT NULL DEFAULT 0,
    draws    integer NOT NULL DEFAULT 0,
    abandons integer NOT NULL DEFAULT 0
);

ALTER TABLE public.duel_result_counter ENABLE ROW LEVEL SECURITY;

-- ddl/tables/element.sql
CREATE TABLE IF NOT EXISTS public.element (
    code varchar(16) PRIMARY KEY
);

ALTER TABLE public.element ENABLE ROW LEVEL SECURITY;

-- ddl/tables/locale.sql
CREATE TABLE IF NOT EXISTS public.locale (
    id   bigserial   PRIMARY KEY,
    code varchar(5)  NOT NULL UNIQUE
);

ALTER TABLE public.locale ENABLE ROW LEVEL SECURITY;

-- ddl/tables/maintenance_window.sql
CREATE TABLE IF NOT EXISTS public.maintenance_window (
    id        bigserial   PRIMARY KEY,
    active    boolean     NOT NULL DEFAULT false,
    starts_at timestamptz NOT NULL,
    ends_at   timestamptz NOT NULL
);

CREATE UNIQUE INDEX uq_maintenance_window_one_active
    ON public.maintenance_window (active)
    WHERE active;

ALTER TABLE public.maintenance_window ENABLE ROW LEVEL SECURITY;

CREATE POLICY maintenance_window_select_anon
    ON public.maintenance_window
    FOR SELECT
    TO anon
    USING (active);

-- ddl/tables/power_rank.sql
CREATE TABLE IF NOT EXISTS public.power_rank (
    code varchar(32) PRIMARY KEY
);

ALTER TABLE public.power_rank ENABLE ROW LEVEL SECURITY;

-- ddl/tables/whats_new_entry.sql
CREATE TABLE IF NOT EXISTS public.whats_new_entry (
    id           bigserial   PRIMARY KEY,
    slug         varchar(60) NOT NULL UNIQUE,
    published_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.whats_new_entry ENABLE ROW LEVEL SECURITY;

-- ddl/tables/card.sql
CREATE TABLE IF NOT EXISTS public.card (
    id         bigserial    PRIMARY KEY,
    element    varchar(16)  NOT NULL,
    power_rank varchar(32)  NOT NULL,
    atk        integer      NOT NULL,
    armor      integer      NOT NULL,
    life       integer      NOT NULL,
    seal       integer      NOT NULL,

    CONSTRAINT fk_card_element FOREIGN KEY (element) REFERENCES public.element (code),
    CONSTRAINT fk_card_power_rank FOREIGN KEY (power_rank) REFERENCES public.power_rank (code),
    CONSTRAINT ck_card_atk_positive     CHECK (atk > 0),
    CONSTRAINT ck_card_armor_positive   CHECK (armor > 0),
    CONSTRAINT ck_card_life_positive    CHECK (life > 0),
    CONSTRAINT ck_card_seal_non_negative CHECK (seal >= 0),

    CONSTRAINT uq_card_element_power_rank UNIQUE (element, power_rank)
);

ALTER TABLE public.card ENABLE ROW LEVEL SECURITY;

-- ddl/tables/element_translation.sql
CREATE TABLE IF NOT EXISTS public.element_translation (
    element   varchar(16) NOT NULL,
    locale_id bigint      NOT NULL,
    label     varchar(40) NOT NULL,

    CONSTRAINT pk_element_translation PRIMARY KEY (element, locale_id),
    CONSTRAINT fk_element_translation_element FOREIGN KEY (element) REFERENCES public.element (code),
    CONSTRAINT fk_element_translation_locale FOREIGN KEY (locale_id) REFERENCES public.locale (id)
);

ALTER TABLE public.element_translation ENABLE ROW LEVEL SECURITY;

-- ddl/tables/maintenance_window_translation.sql
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

-- ddl/tables/power_rank_translation.sql
CREATE TABLE IF NOT EXISTS public.power_rank_translation (
    power_rank varchar(32) NOT NULL,
    locale_id  bigint      NOT NULL,
    label      varchar(40) NOT NULL,

    CONSTRAINT pk_power_rank_translation PRIMARY KEY (power_rank, locale_id),
    CONSTRAINT fk_power_rank_translation_power_rank FOREIGN KEY (power_rank) REFERENCES public.power_rank (code),
    CONSTRAINT fk_power_rank_translation_locale FOREIGN KEY (locale_id) REFERENCES public.locale (id)
);

ALTER TABLE public.power_rank_translation ENABLE ROW LEVEL SECURITY;

-- ddl/tables/whats_new_entry_translation.sql
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

-- ddl/tables/card_translation.sql
CREATE TABLE IF NOT EXISTS public.card_translation (
    card_id   bigint       NOT NULL,
    locale_id bigint       NOT NULL,
    lore      varchar(300) NOT NULL,

    CONSTRAINT pk_card_translation PRIMARY KEY (card_id, locale_id),
    CONSTRAINT fk_card_translation_card FOREIGN KEY (card_id) REFERENCES public.card (id),
    CONSTRAINT fk_card_translation_locale FOREIGN KEY (locale_id) REFERENCES public.locale (id)
);

ALTER TABLE public.card_translation ENABLE ROW LEVEL SECURITY;
