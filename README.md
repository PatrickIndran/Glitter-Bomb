
Glitter Bomb Project

✨ Glitter Bomb — A playful, powerful Linux info and system control toolkit by Patrick Indran.
Overview

Glitter Bomb is a set of bash scripts designed to extract system info, capture webcam and screen snapshots, and (for the daring) even “nuke” your bootloader. It includes:

    Glitter Bomb Launcher: Simple, colorful interface to select and run available scripts.

    Info Extraction Script: Collects system stats, IP/geolocation, webcam photo, and screenshots.

    Nuke Script: Detects distro and bootloader, then safely removes the bootloader after multiple confirmations (EXTREMELY DANGEROUS — use responsibly!).

    Modular, clean bash scripts with built-in colors and fun messages to brighten your terminal.

Features

    Detects Linux distro and bootloader type.

    Collects CPU, RAM, battery, Wi-Fi info.

    Captures webcam image (with a cheeky “Mwahaha!” message).

    Takes full-screen screenshots (supports both Wayland and X11).

    Supports graceful fallbacks and displays image paths if inline display isn’t available.

    Self-destructing nuke script with 5-step confirmation.

    Uses absolute paths so you can move scripts without breaking them.

Installation

    Clone or copy the Glitter Bomb folder anywhere on your Linux system.

    Make sure dependencies are installed (e.g., curl, fswebcam, grim or scrot, nmcli).

    Give execute permission to scripts:

    chmod +x Glitter-Bomb.sh
    chmod +x scripts/fetch/fetch.sh
    chmod +x scripts/nuke/nuke.sh

Usage
Launch the interface:

./Glitter-Bomb.sh

    Select a script by entering the corresponding number.

    Follow on-screen prompts.

Scripts included:
#	Name	Description
1	📄 Fetch Info	Gathers and logs system info and snapshots.
2	📸 Webcam Snapshot	Captures a photo from your webcam.
3	🖼️ Screen Capture	Takes a screenshot of your current session.
4	💣 Nuke Bootloader	Dangerous! Removes your bootloader after multiple confirmations.
Dependencies

    bash (duh)

    curl (for IP & geolocation)

    fswebcam (webcam capture)

    grim or scrot (Wayland/X11 screenshots)

    nmcli (Wi-Fi info)

    kitten icat (optional, for inline images in some terminals)

Warning

The nuke script will break your system’s ability to boot if confirmed. Use only if you know what you’re doing.
Disclaimer

Use at your own risk.
The author, Patrick Indran, is not responsible for any damages, data loss, or system failures caused by the use of these scripts. Especially the Nuke Bootloader script can permanently break your system’s ability to boot. Make sure you fully understand what you are doing before running any script from this project.

Do NOT use these scripts on other people’s devices without their explicit consent. Unauthorized use may be illegal and unethical.
License

[Your preferred license here]
Author

Patrick Indran — making Linux a little more sparkly since forever ✨
