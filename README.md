# Simarine Pico Monitor

See your Simarine **Pico2**'s battery, solar, tanks and temperatures as live graphs on your own
laptop — including a **"really full"** indicator (based on charge tail-current, far more reliable
than the percentage) and an estimated **time to really full**.

It reads your Pico via the internet, so your phone and the Simarine app don't need to
be involved. Your data stays on your laptop.

> The Simarine app only shows **point-in-time** readings. **Bampico** adds **ongoing metrics and
> graphing** for your devices, straight from the Simarine Pico hardware.

---

## What you need
1. A **Simarine Pico Rev. 2** with **remote (Wi-Fi) mode** enabled — see the one-time setup below.
   If the Simarine app can see your Pico when you're away from the boat/van, you're good.
2. Your **Pico2 serial number** — a number shown in the Simarine app / on the device.
3. **Docker** — Docker Desktop on Mac/Windows, or Docker Engine on Linux.

## Enable remote (Wi-Fi) mode on your Pico2 — one time
Bampico needs your Pico online to Simarine's cloud. This is Simarine's own **remote monitoring**
feature (Pico **Rev. 2** only):

1. **In the Simarine app:** turn on **experimental features**, then enable **remote monitoring**.
2. **On the Pico itself:** long-press the **right/menu button (bottom-right, ~5 s)** to open the menu,
   then go to **MENU → WIFI → MODE** and change it from **AP** to **REMOTE**. Select your
   internet-connected Wi-Fi (home, marina, or RV/van router) and enter its password.
3. Make sure **your phone also has internet**, open the Simarine app, and wait for it to sync — a
   **green globe icon** appears at the top when the Pico is online to the cloud. That's when Bampico
   can reach it.

**Pico buttons** (capacitive, below the screen): ◀ left/up · ▼ down / switch screen ·
▲ up / switch screen · ▶ **menu** (long-press 5 s to open/close the menu; short-press = select).

## Install — pick your system
- 🍎 **macOS:** [INSTALL-mac.md](INSTALL-mac.md)
- 🪟 **Windows:** [INSTALL-windows.md](INSTALL-windows.md)
- 🐧 **Linux / server / NAS:** [INSTALL-linux.md](INSTALL-linux.md)

In short: install Docker, double-click **Start Pico Monitor** (Mac/Windows) or run `./start.sh`
(Linux), enter your **Pico2 serial**, and the dashboard opens at **http://localhost:3000**
(user `admin`, password `changeme` — change it, see *Passwords*). The first run **pulls a small
prebuilt program** and **auto-detects your Pico's devices** (a few minutes); nothing is compiled.
Stop with **Stop Pico Monitor** / `./stop.sh` — your history is kept.

## What you'll see
- **Overview** and **Quick Glance** dashboards (in the "Pico" folder).
- Battery state of charge, voltage, current, remaining Ah.
- **BATTERY REALLY FULL?** — green only when the pack has truly topped off (charge current has
  tapered to a trickle), not just when it reads 100%.
- **Time to really full** while charging.
- Solar input, shunt currents, tank levels, temperatures — whatever your Pico has.

The graphs fill in over the first few minutes and build history as it runs. **Note:** a laptop only
collects while it's awake and online, so expect gaps when it's closed/asleep.

## Passwords
Open the `.env` file (plain text) next to this README and change `GRAFANA_PASSWORD` and
`INFLUX_PASSWORD` (the InfluxDB one must be at least 8 characters). Then run **Start** again.

## Phone/desktop alerts (optional)
There are built-in alerts for **really full**, **battery low**, and **charging stalled**. To receive
them, create a **Slack incoming webhook** and paste its URL into `PICO_SLACK_WEBHOOK` in `.env`, then
run **Start** again. Without it, the alerts still show inside the dashboard app.

## If something's wrong
- **"No data" everywhere / discovery failed:** your Pico2 must be online to Simarine's cloud (remote
  access on, and it has internet). Open the Simarine app once to wake it, then run **Start** again.
- **Port already in use (3000):** change `GRAFANA_PORT` in `.env` to e.g. `3001` and run **Start** again.
- **Solar graph empty:** after the first run, open Docker Desktop → the `pico-collector` logs show your
  device names; set `SOLAR_DEVICE` in `.env` to your solar shunt's name.

## Honest notes
- This is an **unofficial** tool that reads your own device via Simarine's cloud. A future Simarine
  update could change things and break it. No warranty.
- It never changes anything on your Pico — it only reads.

## First-launch security prompt (one time)
Because this is a small downloaded script, your computer may warn the first time:
- **Mac:** right-click (or Control-click) **`Start Pico Monitor.command`** → **Open** → **Open**. After once, double-click works.
- **Windows:** if "Windows protected your PC" appears, click **More info** → **Run anyway**.
