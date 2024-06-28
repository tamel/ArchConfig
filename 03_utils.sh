#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<'END_ASCII'
 _   _ _____ ___ _     ____  
| | | |_   _|_ _| |   / ___| 
| | | | | |  | || |   \___ \ 
| |_| | | |  | || |___ ___) |
 \___/  |_| |___|_____|____/ 
END_ASCII

check_continue "installing some utils and setting correct time"


sudo pacman -Syy
sudo pacman -S --noconfirm ntp kitty alacritty wget figlet btop xdg-user-dirs code dolphin chezmoi neovim fzf lazygit

yay -S ttf-meslo-nerd-font-powerlevel10k

sudo timedatectl set-local-rtc 1
sudo timedatectl set-ntp true

sudo systemctl enable ntpd
sudo systemctl start ntpd

cat <<EOF
enable multilib support!
uncomment the following lines:

#[multilib]
#Include = /etc/pacman.d/mirrorlist

EOF

check_continue "opening /etc/pacman.conf"
sudo vim /etc/pacman.conf

xdg-user-dirs-update
