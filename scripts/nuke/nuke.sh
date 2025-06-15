#!/bin/bash

set -e

# Colors for emphasis
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Initial big warning prompt
echo -e "${RED}⚠️ WARNING: This script will REMOVE your bootloader and can BRICK your device! ⚠️${NC}"
read -rp "Are you absolutely sure? Type YES to continue: " initial_confirm
if [[ "$initial_confirm" != "YES" ]]; then
  echo -e "${YELLOW}Aborted by user.${NC}"
  exit 1
fi

echo -e "${YELLOW}🔎 Detecting distro and bootloader...${NC}"

# Detect distro
if [ -f /etc/os-release ]; then
  . /etc/os-release
  distro=$ID
else
  distro="unknown"
fi
echo -e "${GREEN}Detected distro:${NC} $distro"

# Detect bootloader
bootloader="unknown"
if [ -d /boot/grub ] || [ -f /boot/grub/grub.cfg ]; then
  bootloader="grub"
elif [ -d /boot/loader ] || [ -f /boot/loader/loader.conf ]; then
  bootloader="systemd-boot"
else
  bootloader="not found"
fi
echo -e "${GREEN}Detected bootloader:${NC} $bootloader"

# Confirmation prompts
echo -e "${RED}WARNING: This script will REMOVE your bootloader and may make your system unbootable!${NC}"
for i in {1..5}; do
  read -rp "Type YES to confirm (${i}/5): " confirm
  if [[ "$confirm" != "YES" ]]; then
    echo -e "${YELLOW}Aborted by user at confirmation $i.${NC}"
    exit 1
  fi
done

echo -e "${RED}Proceeding with bootloader removal...${NC}"

case "$bootloader" in
  grub)
    echo "Removing GRUB bootloader files..."
    # DANGEROUS: uncomment the next line to actually remove grub files
     sudo rm -rf /boot/grub
    ;;
  systemd-boot)
    echo "Removing systemd-boot files..."
    # DANGEROUS: uncomment the next line to actually remove systemd-boot files
     sudo rm -rf /boot/loader
    ;;
  *)
    echo "No supported bootloader found to remove."
    ;;
esac

echo -e "${RED}Bootloader removal complete. Script will now self-destruct.${NC}"

# Self-destruct
rm -- "$0"
