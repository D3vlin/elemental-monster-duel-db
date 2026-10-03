set -euo pipefail
cd "$(dirname "$0")/.."
source ci/lib_init_sync.sh

status=0

if ! diff -u <(topo_order ddl/tables | generate ddl/tables 'CREATE SCHEMA IF NOT EXISTS public;') init/ddl/DDL_INIT_SCRIPT.sql; then
  echo "::error::init/ddl/DDL_INIT_SCRIPT.sql is out of date — run ci/regenerate_init.sh and commit the result"
  status=1
fi

if ! diff -u <(topo_order ddl/tables dml/tables | generate dml/tables) init/dml/DML_INIT_SCRIPT.sql; then
  echo "::error::init/dml/DML_INIT_SCRIPT.sql is out of date — run ci/regenerate_init.sh and commit the result"
  status=1
fi

exit "$status"
