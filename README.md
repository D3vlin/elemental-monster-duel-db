# Elemental Monster Duel — DB

## 📌 Overview

**Elemental Monster Duel DB** is one of 6 repositories in the distributed
architecture of Elemental Monster Duel. It holds the real PostgreSQL schema —
DDL, seed data, and the initialization scripts — that the other modules
consume.

---

## 🎯 Purpose

This repo exists to:

- Be the single source of truth for the schema (tables, constraints, RLS, policies)
- Version the structure (`ddl/`) separately from the seed data (`dml/`)
- Automate creating a new database from scratch (`init/`), for local
  development and for the Docker Postgres
- Guarantee, via CI, that the init scripts never drift from the source tables

---

## 🧱 Project Architecture Context

This repo is one of 6 in the Elemental Monster Duel ecosystem, each
independently versioned and maintained:

| Module | Responsibility | Repository |
|---|---|---|
| `db` | Database schema | This one |
| `entity` | JPA mapping | https://github.com/D3vlin/elemental-monster-duel-entity |
| `dto` | Data transport | https://github.com/D3vlin/elemental-monster-duel-dto |
| `mapper` | Entity ↔ DTO | https://github.com/D3vlin/elemental-monster-duel-mapper |
| `api` | REST interface | https://github.com/D3vlin/elemental-monster-duel-api |
| `ui` | Frontend | https://github.com/D3vlin/elemental-monster-duel-ui |

---

## 🚀 Why a Dedicated DB Module?

- One single source of truth for the schema, instead of each Java module
  inferring its own version.
- Its own CI that verifies `init/` never drifts from `ddl/`/`dml/`.

---

## How it's organized

- `ddl/tables/` — one file per table: structure, constraints, FKs, RLS, policies.
- `dml/tables/` — seed data per table.
- `init/ddl/DDL_INIT_SCRIPT.sql` / `init/dml/DML_INIT_SCRIPT.sql` — generated
  automatically from `ddl/`/`dml/`, in the topological order given by each
  table's own `REFERENCES`, via `ci/regenerate_init.sh`. **Not edited by hand.**

`init/` exists to automate creating a new database — run the DDL first, then
the DML.

## License

No license — all rights reserved.
