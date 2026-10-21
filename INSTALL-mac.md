# Install on macOS

## 1. Install Docker Desktop (once)
Download from https://www.docker.com/products/docker-desktop/, install it, and **open it**.
Wait until the whale icon in the menu bar stops animating (that means Docker is running).

## 2. Get the folder
Unzip the `bampico` folder somewhere handy (e.g. your Documents).

## 3. Start it
Double-click **`Start Pico Monitor.command`**.

> **First time only:** macOS may say it "cannot be opened because it is from an unidentified
> developer." If so, **right-click (or Control-click) the file → Open → Open**. After that, a normal
> double-click works.

A Terminal window opens and asks for your **Pico2 serial number** — type it and press Enter.
It then pulls the programs and **auto-detects your Pico's devices** (a few minutes the first time).
Your browser opens the dashboard at **http://localhost:3000**.

## 4. Log in
User `admin`, password `changeme`. To change it, open the `.env` file (plain text, in the same
folder), edit `GRAFANA_PASSWORD` / `INFLUX_PASSWORD` (the InfluxDB one needs 8+ characters), and run
**Start Pico Monitor** again.

## Stop / start again
- Stop: double-click **`Stop Pico Monitor.command`** (your history is kept).
- Start again: double-click **`Start Pico Monitor.command`**.
Leave Docker Desktop running while you want data collected.

## Trouble
- **"No data" / discovery failed:** make sure your Pico2 has **remote mode** on
  and internet. Open the Simarine app once to wake it, then Start again.
- **Port 3000 busy:** edit `GRAFANA_PORT` in `.env` (e.g. `3001`) and Start again.
