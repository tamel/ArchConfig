#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<'END_ASCII'
 _   ___   ______  ____  _        _    _   _ ____  
| | | \ \ / /  _ \|  _ \| |      / \  | \ | |  _ \ 
| |_| |\ V /| |_) | |_) | |     / _ \ |  \| | | | |
|  _  | | | |  __/|  _ <| |___ / ___ \| |\  | |_| |
|_| |_| |_| |_|   |_| \_\_____/_/   \_\_| \_|____/ 
END_ASCII

sudo pacman -S hyprland dunst qt6-wayland xdg-desktop-portal-hyprland waybar rofi-wayland hyprcursor xdg-desktop-portal-gtk hypridle hyprlock hyprpaper hyprcursor wl-clipboard cliphist dunst waybar polkit-kde-agent

yay -S rose-pine-hyprcursor rose-pine-cursor

