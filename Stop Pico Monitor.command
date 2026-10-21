#!/bin/bash
cd "$(dirname "$0")" || exit 1
echo "Stopping Pico monitor (your data is kept)..."
docker compose down
echo "Stopped. Double-click 'Start Pico Monitor' to run it again."
read -r -p "Press Enter to close..."
