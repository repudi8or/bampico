# Install on Linux

For a laptop or a server/NAS. No Docker Desktop — just Docker Engine + the Compose plugin.

## 1. Install Docker Engine + Compose plugin (once)
Follow the official guide for your distro: https://docs.docker.com/engine/install/
It includes the `docker compose` plugin. Then allow your user to run Docker without sudo:
```bash
sudo usermod -aG docker "$USER"
# log out and back in (or: newgrp docker) so the group takes effect
docker run --rm hello-world     # should succeed without sudo
```

## 2. Get the folder
Unzip the `bampico` folder, e.g. `~/bampico`, and `cd` into it.

## 3. Start it
Easiest:
```bash
./start.sh        # asks for your Pico2 serial on first run, then starts everything
```
Or do it manually:
```bash
cp .env.example .env
# edit .env: set PICO_SERIAL, change the passwords, set INFLUX_TOKEN (e.g. `openssl rand -hex 32`)
docker compose up -d
docker compose logs -f collector     # watch it discover your devices + write points
```
Open the dashboard at **http://localhost:3000** (user `admin`, your `GRAFANA_PASSWORD`).

## Stop / update
```bash
./stop.sh                  # or: docker compose down   (history kept)
docker compose pull && docker compose up -d   # update to the latest collector image
```

## Notes
- Needs your Pico2 online to the internet (remote mode on).
- To re-discover after adding/renaming devices in the Simarine app:
  `docker compose down && docker volume rm bampico_pico-model-data && docker compose up -d`.
- Running on an always-on server/NAS avoids the gaps you'd get from a laptop sleeping.
