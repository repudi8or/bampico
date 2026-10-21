#!/bin/bash
# Double-click to start the Pico monitor (macOS). First run sets you up.
cd "$(dirname "$0")" || exit 1
clear
echo "=== Simarine Pico Monitor ==="
echo

# 1. Docker Desktop must be running
if ! docker info >/dev/null 2>&1; then
  echo "Docker Desktop is not running. Opening it now..."
  open -a Docker 2>/dev/null
  echo "Please wait for Docker Desktop to finish starting (its whale icon stops animating),"
  echo "then double-click this file again."
  read -r -p "Press Enter to close..."; exit 1
fi

# 2. First-run setup: create .env, random token, ask for the serial
if [ ! -f .env ]; then
  cp .env.example .env
  TOKEN=$(openssl rand -hex 32 2>/dev/null || (date; echo $RANDOM) | shasum | cut -c1-48)
  sed -i '' "s|^INFLUX_TOKEN=.*|INFLUX_TOKEN=$TOKEN|" .env
  echo "First-time setup."
  echo
  while :; do
    read -r -p "Enter your Simarine Pico2 serial number: " SERIAL
    [ -n "$SERIAL" ] && case "$SERIAL" in (*[!0-9]*) echo "Numbers only, please.";; (*) break;; esac
  done
  sed -i '' "s|^PICO_SERIAL=.*|PICO_SERIAL=$SERIAL|" .env
  echo "Saved. (Tip: change the passwords in the .env file when you get a chance.)"
  echo
fi

# 3. Start (first run downloads the image + auto-discovers your devices — a few minutes)
echo "Starting... the first run downloads the collector image and discovers your Pico's"
echo "devices automatically. This can take 3-5 minutes. Please wait."
docker compose up -d || { echo "Something went wrong above."; read -r -p "Press Enter..."; exit 1; }

PORT=$(grep -E '^GRAFANA_PORT=' .env | cut -d= -f2); PORT=${PORT:-3000}
echo
echo "Waiting for the dashboard to come online..."
for _ in $(seq 1 90); do
  curl -s "http://localhost:${PORT}/api/health" 2>/dev/null | grep -q '"database"' && break
  sleep 3
done
open "http://localhost:${PORT}"
echo
echo "Done!  Dashboard: http://localhost:${PORT}"
echo "Your battery/power graphs will fill in over the next few minutes."
echo "(Leave Docker Desktop running. To stop: use 'Stop Pico Monitor'.)"
read -r -p "Press Enter to close this window..."
