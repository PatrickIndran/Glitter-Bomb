#!/bin/bash

clear

# 🎨 Color Palette
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 🧭 Determine script directory dynamically
script_dir=$(dirname "$(realpath "$0")")

# 🕰️ Timestamp & Directories
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
base_dir="$script_dir/assets"
snapshot_dir="$base_dir/snapshots/$timestamp"
mkdir -p "$snapshot_dir"

# 📝 Log File
log_file="$snapshot_dir/glitter_log.txt"

# 💀 ASCII Art Banner
echo -e "${CYAN}"
cat << "EOF"
   ____ _ _ _   _              ____                  _     _ _ 
  / ___| (_) |_| |_ ___ _ __  | __ )  ___  _ __ ___ | |__ | | |
 | |  _| | | __| __/ _ \ '__| |  _ \ / _ \| '_ ` _ \| '_ \| | |
 | |_| | | | |_| ||  __/ |    | |_) | (_) | | | | | | |_) |_|_|
  \____|_|_|\__|\__\___|_|    |____/ \___/|_| |_| |_|_.__/(_|_)

       ✨ Glitter Bomb Info Extracter — Crafted with mischief by Patrick Indran ✨
EOF
echo -e "${NC}"

# 🤖 User Interaction
echo -e "${YELLOW}👋 Greetings, ${CYAN}$(whoami)${YELLOW}! Ready to unleash the Glitter Bomb? (y/n)${NC}"
read -rp "> " answer

if [[ "$answer" == [Yy]* ]]; then
    echo -e "\n${CYAN}✨ Initiating extraction...${NC}\n"

    # 🌐 Public IP & Geolocation
    public_ip=$(curl -s https://ifconfig.me)
    geo_json=$(curl -s https://ipapi.co/json/)
    city=$(echo "$geo_json" | grep -Po '"city": *"\K[^"]+')
    region=$(echo "$geo_json" | grep -Po '"region": *"\K[^"]+')
    country=$(echo "$geo_json" | grep -Po '"country_name": *"\K[^"]+')

    # 🔋 System Information
    battery_level=$(acpi 2>/dev/null || echo "Not available")
    cpu=$(grep -m 1 'model name' /proc/cpuinfo | cut -d ':' -f2- | sed 's/^ *//')
    ram=$(free -h)
    wifi_info=$(nmcli device wifi show-password 2>/dev/null || echo "Not available")

    # 📝 Log Information
    {
        echo "=== Glitter Bomb Info Log ==="
        echo "Timestamp: $timestamp"
        echo "User: $(whoami)"
        echo ""
        echo "🌐 Public IP: $public_ip"
        echo "📍 Approx Location: $city, $region, $country"
        echo ""
        echo "🔋 Battery: $battery_level"
        echo "🧠 CPU: $cpu"
        echo "💾 RAM:"
        echo "$ram"
        echo ""
        echo "📶 Wi‑Fi PW: $wifi_info"
    } | tee "$log_file"

    # 🖼️ Webcam Capture
    echo -e "\n${GREEN}📸 Capturing webcam photo...${NC}"
    sleep 1
    echo -e "\n${CYAN}Mwahaha... Your image is now mine!${NC}"
    sleep 2

    webcam_img="$snapshot_dir/webcam.jpg"
    webcam_log="$snapshot_dir/webcam_capture.log"
    if fswebcam --log "$webcam_log" -d /dev/video1 "$webcam_img"; then
        if kitten icat "$webcam_img" 2>/dev/null; then
            echo -e "${GREEN}[✓] Webcam displayed.${NC}"
        else
            echo -e "${YELLOW}[!] View webcam here:${NC} $webcam_img"
        fi
    else
        echo -e "${RED}[X] Webcam failed.${NC}"
    fi

    # 🖥️ Screenshot Capture
    echo -e "\n${YELLOW}🖼️ Capturing screenshot...${NC}"
    sleep 2
    screenshot_img="$snapshot_dir/screenshot.jpg"

    # Detect session type and choose screenshot method
    if [[ $XDG_SESSION_TYPE == "x11" ]]; then
        if import -window root "$screenshot_img"; then
            screenshot_success=true
        else
            screenshot_success=false
        fi
    elif [[ $XDG_SESSION_TYPE == "wayland" ]]; then
        if grim "$screenshot_img"; then
            screenshot_success=true
        else
            screenshot_success=false
        fi
    else
        echo -e "${RED}[X] Unsupported session type: $XDG_SESSION_TYPE${NC}"
        screenshot_success=false
    fi

    if $screenshot_success; then
        if kitten icat "$screenshot_img" 2>/dev/null; then
            echo -e "${GREEN}[✓] Screenshot displayed.${NC}"
        else
            echo -e "${YELLOW}[!] View screenshot here:${NC} $screenshot_img"
        fi
    else
        echo -e "${RED}[X] Screenshot failed.${NC}"
    fi

    echo -e "\n${GREEN}✅ Glitter Bomb deployed!${NC}"
    echo -e "${CYAN}📂 All files saved in: $snapshot_dir${NC}"
else
    echo -e "\n${RED}❌ Glitter Bomb defused. Until next time...${NC}"
fi
