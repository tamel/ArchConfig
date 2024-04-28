#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<EOF
 ____  ____  ____  __  __          __  _______ ____ _____ 
/ ___||  _ \|  _ \|  \/  |    _    \ \/ /  ___/ ___| ____|
\___ \| | | | | | | |\/| |  _| |_   \  /| |_ | |   |  _|  
 ___) | |_| | |_| | |  | | |_   _|  /  \|  _|| |___| |___ 
|____/|____/|____/|_|  |_|   |_|   /_/\_\_|   \____|_____|
EOF

check_continue "installing sddm and xfce4"
sudo pacman -Syy
sudo pacman -S --noconfirm sddm xfce4 xorg-xrandr

cat <<EOF | sudo tee /usr/share/sddm/scripts/Xsetup > /dev/null
#!/bin/sh

xrandr --output DP-1-0 --auto --primary
xrandr --output eDP-1 --off
EOF

sudo mkdir -p /etc/sddm.conf.d
cat <<EOF | sudo tee /etc/sddm.conf.d/activate-numlock.conf > /dev/null
[General]
Numlock=on
EOF

sudo localectl set-x11-keymap de

sudo systemctl enable sddm
sudo systemctl start sdd
