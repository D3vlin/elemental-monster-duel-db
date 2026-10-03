topo_order() {
  local source_dir="$1" filter_dir="${2:-}"
  local table dep file
  local -a nodes=() order=()
  local -A node_deps=() resolved=()

  while IFS= read -r -d '' file; do
    table=$(basename "$file" .sql)
    if [ -n "$filter_dir" ] && [ ! -f "${filter_dir}/${table}.sql" ]; then
      continue
    fi
    nodes+=("$table")
  done < <(find "$source_dir" -maxdepth 1 -name '*.sql' -print0 | sort -z)

  for table in "${nodes[@]}"; do
    node_deps["$table"]=$(
      sed -n "s/.*REFERENCES[[:space:]]\+public\.\([A-Za-z0-9_]\+\).*/\1/p" "${source_dir}/${table}.sql" \
        | sort -u \
        | while IFS= read -r dep; do
            [ -z "$dep" ] && continue
            [ "$dep" = "$table" ] && continue
            [ -f "${source_dir}/${dep}.sql" ] || continue
            if [ -n "$filter_dir" ] && [ ! -f "${filter_dir}/${dep}.sql" ]; then continue; fi
            printf '%s ' "$dep"
          done
    )
  done

  local pending=("${nodes[@]}")
  while [ "${#pending[@]}" -gt 0 ]; do
    local -a ready=() still_pending=()
    for table in "${pending[@]}"; do
      local all_resolved=1
      for dep in ${node_deps[$table]}; do
        [ -n "${resolved[$dep]:-}" ] || { all_resolved=0; break; }
      done
      if [ "$all_resolved" -eq 1 ]; then
        ready+=("$table")
      else
        still_pending+=("$table")
      fi
    done

    if [ "${#ready[@]}" -eq 0 ]; then
      echo "::error::circular foreign key dependency detected among: ${pending[*]}" >&2
      exit 1
    fi

    order+=("${ready[@]}")
    for table in "${ready[@]}"; do
      resolved["$table"]=1
    done
    pending=("${still_pending[@]}")
  done

  printf '%s\n' "${order[@]}"
}

generate() {
  local source_dir="$1" header="${2:-}"
  local first=1 table

  if [ -n "$header" ]; then
    printf '%s\n' "$header"
    first=0
  fi

  while IFS= read -r table; do
    [ -z "$table" ] && continue
    if [ "$first" -eq 1 ]; then
      printf -- '-- %s/%s.sql\n' "$source_dir" "$table"
      first=0
    else
      printf -- '\n-- %s/%s.sql\n' "$source_dir" "$table"
    fi
    cat "${source_dir}/${table}.sql"
  done
}
