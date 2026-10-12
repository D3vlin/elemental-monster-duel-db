# Elemental Monster Duel — DB

## 📌 Overview

**Elemental Monster Duel DB** es uno de los 6 repos de la arquitectura distribuida
de Elemental Monster Duel. Contiene el esquema real de PostgreSQL — DDL, datos
semilla y los scripts de inicialización, que el resto de los módulos consume.

---

## 🎯 Purpose

Este repo existe para:

- Ser la única fuente de verdad del esquema (tablas, constraints, RLS, policies)
- Versionar la estructura (`ddl/`) separada de los datos semilla (`dml/`)
- Automatizar la creación de una base nueva desde cero (`init/`), para desarrollo
  local y para el Postgres de Docker
- Garantizar, vía CI, que los scripts de init nunca se desincronicen de las
  tablas fuente

---

## 🧱 Project Architecture Context

Este repo es uno de 6 dentro del ecosistema Elemental Monster Duel, cada uno
versionado y mantenido por separado:

| Módulo | Responsabilidad | Repositorio |
|---|---|---|
| `db` | Esquema de base de datos | Este |
| `entity` | Mapeo JPA | https://github.com/D3vlin/elemental-monster-duel-entity |
| `dto` | Contratos de transporte | https://github.com/D3vlin/elemental-monster-duel-dto |
| `mapper` | Entity ↔ DTO | https://github.com/D3vlin/elemental-monster-duel-mapper |
| `api` | Interfaz REST | https://github.com/D3vlin/elemental-monster-duel-api |
| `ui` | Frontend | https://github.com/D3vlin/elemental-monster-duel-ui |

---

## 🚀 ¿Por qué un módulo de DB dedicado?

- Un solo lugar de verdad para el esquema, en vez de que cada módulo Java
  infiera su propia versión.
- CI propio que verifica que `init/` nunca se desincronice de `ddl/`/`dml/`.

---

## Cómo está organizado

- `ddl/tables/` — un archivo por tabla: estructura, constraints, FKs, RLS, policies.
- `dml/tables/` — datos semilla por tabla.
- `init/ddl/DDL_INIT_SCRIPT.sql` / `init/dml/DML_INIT_SCRIPT.sql` — generados
  automáticamente desde `ddl/`/`dml/`, en el orden topológico que marcan las
  propias `REFERENCES` de cada tabla, vía `ci/regenerate_init.sh`. **No se
  editan a mano.**

`init/` existe para automatizar la creación de una base nueva — corré primero
el DDL y después el DML. `ci/verify_init_sync.sh` (`.github/workflows/ci.yml`)
corre en cada PR para garantizar que no se desincronicen.

## Licencia

Sin licencia — todos los derechos reservados.
