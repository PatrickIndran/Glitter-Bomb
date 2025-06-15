#!/bin/bash
set -e

# List of dependencies
deps=(curl fswebcam grim scrot nmcli kitty)

# Check if any dependencies are missing
need_install=false
for dep in "${deps[@]}"; do
  if ! command -v "$dep" &>/dev/null; then
    need_install=true
    break
  fi
done

# If dependencies are missing, attempt to install them using yay
if $need_install; then
  echo "Installing missing dependencies..."
  
  # Check if yay is installed
  if command -v yay &>/dev/null; then
    yay -S --needed "${deps[@]}"
  else
    echo "yay is not installed. Please install yay first."
    exit 1
  fi
else
  echo "All dependencies are already installed."
fi

clear

echo -e "\
 ____  _   _   _              ____                  _     _ _ \n\
/ ___| (_) |_| |_ ___ _ __  | __ )  ___  _ __ ___ | |__ | | |\n\
| |  _| | | __| __/ _ \ '__| |  _ \ / _ \| '_ \` _ \| '_ \| | |\n\
| |_| | | | |_| ||  __/ |    | |_) | (_) | | | | | | |_) |_|_|\n\
 \\____|_|_|\\__|\\__\\___|_|    |____/ \\___/|_| |_| |_|_.__/(_|_)\n\
                                                                "

                                                    
# Launch menu



BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
scripts=(
  "$BASE_DIR/scripts/fetch/fetch.sh"
  "$BASE_DIR/scripts/nuke/nuke.sh"
)
names=(
  "📄 Fetch Info"
  "💣 Nuke The System"
)

echo "✨ Glitter Bomb Launcher ✨"
for i in "${!scripts[@]}"; do
  echo "  [$((i+1))] ${names[$i]}"
done

read -rp "> " choice
if [[ $choice =~ ^[1-9]$ ]] && [ "$choice" -le ${#scripts[@]} ]; then
  echo "Running: ${names[$((choice-1))]}"
  bash "${scripts[$((choice-1))]}"
else
  echo "Invalid selection."
  exit 1
fi
