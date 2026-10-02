# Elemental Monster Duel — DB

Esta es la base de datos de Elemental Monster Duel.

## Distribución

Este es uno de 6 repos del proyecto:

- [`api`](https://github.com/D3vlin/elemental-monster-duel-api) — Backend
- [`ui`](https://github.com/D3vlin/elemental-monster-duel-ui) — Frontend
- [`entity`](https://github.com/D3vlin/elemental-monster-duel-entity) — Entidades
- [`dto`](https://github.com/D3vlin/elemental-monster-duel-dto) — DTO
- [`mapper`](https://github.com/D3vlin/elemental-monster-duel-mapper) — Mapeo entity ↔ dto
- `db` — este

## Cómo está organizado

- ddl/ # Estructura de los objetos en la base de datos.
- dml/ # Seed de los datos en la base de datos.
- init/
  - ddl/ # Levantar el schema.
  - dml/ # Insertar seed de una

`init/` existe para automatizar la creación de una base nueva. — Corré primero el DDL y después el DML.

## Licencia

Sin licencia — todos los derechos reservados.
