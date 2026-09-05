CREATE TABLE IF NOT EXISTS public.card (
    id         bigserial    PRIMARY KEY,
    element    varchar(16)  NOT NULL,
    power_rank varchar(32)  NOT NULL,
    atk        integer      NOT NULL,
    armor      integer      NOT NULL,
    life       integer      NOT NULL,
    seal       integer      NOT NULL,
    lore       varchar(300) NOT NULL,

    CONSTRAINT ck_card_element CHECK (
        (element)::text = ANY (ARRAY[
            'TIERRA', 'AGUA', 'AIRE', 'ETER', 'VACIO', 'PLASMA',
            'FUEGO', 'AZUFRE', 'CARNE', 'SANGRE', 'HONGOS', 'CARBONO'
        ]::text[])
    ),
    CONSTRAINT ck_card_power_rank CHECK (
        (power_rank)::text = ANY (ARRAY[
            'ENGENDRO', 'CAZADOR', 'ABOMINACION', 'ANCESTRAL_SUPREMO'
        ]::text[])
    ),
    CONSTRAINT ck_card_atk_positive     CHECK (atk > 0),
    CONSTRAINT ck_card_armor_positive   CHECK (armor > 0),
    CONSTRAINT ck_card_life_positive    CHECK (life > 0),
    CONSTRAINT ck_card_seal_non_negative CHECK (seal >= 0),

    CONSTRAINT uq_card_element_power_rank UNIQUE (element, power_rank)
);

ALTER TABLE public.card ENABLE ROW LEVEL SECURITY;
