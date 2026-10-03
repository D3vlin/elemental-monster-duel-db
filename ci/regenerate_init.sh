set -euo pipefail
cd "$(dirname "$0")/.."
source ci/lib_init_sync.sh

tmp_ddl=$(mktemp)
topo_order ddl/tables | generate ddl/tables 'CREATE SCHEMA IF NOT EXISTS public;' > "$tmp_ddl"
mv "$tmp_ddl" init/ddl/DDL_INIT_SCRIPT.sql

tmp_dml=$(mktemp)
topo_order ddl/tables dml/tables | generate dml/tables > "$tmp_dml"
mv "$tmp_dml" init/dml/DML_INIT_SCRIPT.sql

echo "Regenerated init/ddl/DDL_INIT_SCRIPT.sql and init/dml/DML_INIT_SCRIPT.sql"
