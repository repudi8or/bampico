#!/usr/bin/env bash
# Linux: start the Pico monitor. Needs Docker Engine + the compose plugin.
cd "$(dirname "$0")" || exit 1
command -v docker >/dev/null || { echo "Docker is not installed. See INSTALL-linux.md."; exit 1; }
docker info >/dev/null 2>&1 || { echo "Cannot talk to Docker. Is the daemon running / are you in the 'docker' group?"; exit 1; }
if [ ! -f .env ]; then
  cp .env.example .env
  TOKEN=$(openssl rand -hex 32 2>/dev/null || head -c32 /dev/urandom | od -An -tx1 | tr -d ' \n')
  sed -i "s|^INFLUX_TOKEN=.*|INFLUX_TOKEN=$TOKEN|" .env
  read -r -p "Enter your Simarine Pico2 serial number: " SERIAL
  sed -i "s|^PICO_SERIAL=.*|PICO_SERIAL=$SERIAL|" .env
  echo "Saved .env (change the passwords in it when you like)."
fi
echo "Starting (first run pulls the image + auto-discovers your devices)..."
docker compose up -d
PORT=$(grep -E '^GRAFANA_PORT=' .env | cut -d= -f2); PORT=${PORT:-3000}
echo "Dashboard: http://localhost:${PORT}  (give it a few minutes to fill in)"
