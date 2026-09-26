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
