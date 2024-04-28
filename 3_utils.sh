#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<EOF
 _   _ _____ ___ _     ____  
| | | |_   _|_ _| |   / ___| 
| | | | | |  | || |   \___ \ 
| |_| | | |  | || |___ ___) |
 \___/  |_| |___|_____|____/ 
EOF

check_continue "installing some utils and setting correct time"

sudo pacman -Syy
sudo pacman -S --noconfirm ntp bat gcc make ripgrep fzf lazygit zoxide zsh tmux bat git-delta eza tldr thefuck neovim
yay -S --answerdiff None --answerclean None --mflags "--noconfirm" google-chrome

sudo timedatectl set-local-rtc 1
sudo timedatectl set-ntp true

sudo systemctl enable ntpd
sudo systemctl start ntpd
