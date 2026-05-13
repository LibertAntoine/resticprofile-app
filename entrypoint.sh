#!/bin/sh
set -eu

RESTICPROFILE_CONFIG=${RESTICPROFILE_CONFIG:-/resticprofile/profiles.yaml}
CRONTAB_PATH="${CRONTAB_PATH:-/resticprofile/crontab}"

if [ ! -f "$RESTICPROFILE_CONFIG" ]; then
  echo "[entrypoint] ERROR: config file not found at $RESTICPROFILE_CONFIG" >&2
  exit 1
fi

echo "[entrypoint] Using config: $RESTICPROFILE_CONFIG"
echo "[entrypoint] Registering schedules..."
resticprofile -c "$RESTICPROFILE_CONFIG" schedule --all

echo "[entrypoint] Generated crontab:"
cat "$CRONTAB_PATH"

echo "[entrypoint] Starting supercronic..."
exec supercronic "$CRONTAB_PATH"
