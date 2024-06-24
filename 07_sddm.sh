#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<'END_ASCII'
 ____  ____  ____  __  __ 
/ ___||  _ \|  _ \|  \/  |
\___ \| | | | | | | |\/| |
 ___) | |_| | |_| | |  | |
|____/|____/|____/|_|  |_|
END_ASCII

check_continue "installing sddm"
sudo pacman -Syy
sudo pacman -S --noconfirm sddm


sudo mkdir -p /etc/sddm.conf.d
cat <<EOF | sudo tee /etc/sddm.conf.d/activate-numlock.conf > /dev/null
[General]
Numlock=on
EOF

sudo localectl set-x11-keymap de
sudo gtk-update-icon-cache --force /usr/share/icons/hicolor

sudo systemctl enable sddm
sudo systemctl start sddm
