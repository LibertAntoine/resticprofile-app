#!/bin/sh
set -e

CONFIG_FILE=${CONFIG_FILE:-/resticprofile/profiles.yaml}

echo "[entrypoint] Registering schedules..."
resticprofile -c "$CONFIG_FILE" schedule --all

echo "[entrypoint] Starting supercronic..."
exec supercronic /resticprofile/crontab
