#!/bin/sh
set -eu

mkdir -p /opt/rathena/conf/import

if [ "${RATHENA_RENDER_CONFIGS:-no}" = "yes" ]; then
    for template in /opt/rathena/templates/import/*.tpl; do
        target="/opt/rathena/conf/import/$(basename "$template" .tpl)"
        envsubst < "$template" > "$target"
    done
fi

exec "$@"
