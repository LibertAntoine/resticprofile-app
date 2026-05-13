#!/bin/sh
set -e

RESTICPROFILE_CONFIG =${RESTICPROFILE_CONFIG :-/resticprofile/profiles.yaml}

echo "[entrypoint] Registering schedules..."
resticprofile -c "$RESTICPROFILE_CONFIG" schedule --all

echo "[entrypoint] Starting supercronic..."
exec supercronic /resticprofile/crontab
