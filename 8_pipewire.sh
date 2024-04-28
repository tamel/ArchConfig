#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<EOF
 ____ ___ ____  _______        _____ ____  _____      _   _   _ ____ ___ ___  
|  _ \_ _|  _ \| ____\ \      / /_ _|  _ \| ____|    / \ | | | |  _ \_ _/ _ \ 
| |_) | || |_) |  _|  \ \ /\ / / | || |_) |  _|     / _ \| | | | | | | | | | |
|  __/| ||  __/| |___  \ V  V /  | ||  _ <| |___   / ___ \ |_| | |_| | | |_| |
|_|  |___|_|   |_____|  \_/\_/  |___|_| \_\_____| /_/   \_\___/|____/___\___/ 
EOF


check_continue "setting up pipewire audio"

sudo pacman -Syy
sudo pacman -S --noconfirm pipewire pipewire-audio pipewire-alsa pipewire-pulse wireplumber alsa-utils

echo
echo "maybe a reboot is required"
