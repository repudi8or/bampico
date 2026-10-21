# Install on Windows

## 1. Install Docker Desktop (once)
Download from https://www.docker.com/products/docker-desktop/ and install it. When it asks, let it
enable **WSL2** (it may prompt you to install a Windows update and restart). Then **open Docker
Desktop** and wait until it says "Engine running".

## 2. Get the folder
Unzip the `bampico` folder somewhere handy (e.g. Documents). Keep all the files together.

## 3. Start it
Double-click **`Start Pico Monitor.bat`**.

> **First time only:** if "Windows protected your PC" (SmartScreen) appears, click
> **More info → Run anyway**.

A console window opens and asks for your **Pico2 serial number** — type it and press Enter. It pulls
the programs and **auto-detects your Pico's devices** (a few minutes the first time), then your
browser opens the dashboard at **http://localhost:3000**.

## 4. Log in
User `admin`, password `changeme`. To change it, open the `.env` file (right-click → open with
Notepad), edit `GRAFANA_PASSWORD` / `INFLUX_PASSWORD` (the InfluxDB one needs 8+ characters), save,
and run **Start Pico Monitor.bat** again.

## Stop / start again
- Stop: double-click **`Stop Pico Monitor.bat`** (history is kept).
- Start again: double-click **`Start Pico Monitor.bat`**.
Keep Docker Desktop running while you want data collected.

## Trouble
- **"No data" / discovery failed:** ensure your Pico2 has **Remote access** on (Simarine app) and
  internet. Open the Simarine app once to wake it, then Start again.
- **Port 3000 busy:** edit `GRAFANA_PORT` in `.env` (e.g. `3001`) and Start again.
