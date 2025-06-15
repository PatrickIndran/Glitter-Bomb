#!/bin/bash

# Get the absolute path to the directory where this script is located
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ==== Script Menu ====
scripts=(
  "$BASE_DIR/scripts/fetch/fetch.sh"
  "$BASE_DIR/scripts/webcam.sh"
  "$BASE_DIR/scripts/screenshot.sh"
)

names=(
  "📄 Fetch Info"
  "📸 Webcam Snapshot"
  "🖼️ Screen Capture"
)

# ==== Show Menu ====
echo "✨ Glitter Bomb Launcher ✨"
echo "Select a script to run:"

for i in "${!scripts[@]}"; do
  echo "  [$((i+1))] ${names[$i]}"
done

# ==== User Input ====
read -rp "> " choice

# ==== Validate & Execute ====
if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#scripts[@]} ]; then
  selected_script="${scripts[$((choice-1))]}"
  echo "▶️ Running: ${names[$((choice-1))]}"
  bash "$selected_script"
else
  echo "❌ Invalid selection"
  exit 1
fi
