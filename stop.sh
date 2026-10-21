#!/usr/bin/env bash
cd "$(dirname "$0")" || exit 1
docker compose down
echo "Stopped (data kept)."
