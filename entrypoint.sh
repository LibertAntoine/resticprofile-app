#!/bin/sh
set -eu

RESTICPROFILE_CONFIG=${RESTICPROFILE_CONFIG:-/resticprofile/profiles.yaml}

if [ ! -f "$RESTICPROFILE_CONFIG" ]; then
  echo "[entrypoint] ERROR: config file not found at $RESTICPROFILE_CONFIG" >&2
  exit 1
fi

echo "[entrypoint] Using config: $RESTICPROFILE_CONFIG"
echo "[entrypoint] Registering schedules..."
resticprofile -c "$RESTICPROFILE_CONFIG" schedule --all

echo "[entrypoint] Installed crontab:"
crontab -l 2>/dev/null || echo "(no crontab found)"

echo "[entrypoint] Starting crond..."
exec crond -f -d 8
