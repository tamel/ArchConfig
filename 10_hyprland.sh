#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<EOF
 _   ___   ______  ____  _        _    _   _ ____  
| | | \ \ / /  _ \|  _ \| |      / \  | \ | |  _ \ 
| |_| |\ V /| |_) | |_) | |     / _ \ |  \| | | | |
|  _  | | | |  __/|  _ <| |___ / ___ \| |\  | |_| |
|_| |_| |_| |_|   |_| \_\_____/_/   \_\_| \_|____/ 
EOF

sudo pacman -S hyprland libva-nvidia-driver
sudo systemctl enable nvidia-suspend nvidia-hibernate nvidia-resume dunst qt6-wayland xdg-desktop-portal-hyprland waybar rofi-wayland
