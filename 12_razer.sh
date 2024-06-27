#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<'END_ASCII'
 ____      _     _________  _____ ____  
|  _ \    / \   |__  /  _ \| ____|  _ \ 
| |_) |  / _ \    / /| |_) |  _| | |_) |
|  _ <  / ___ \  / /_|  _ <| |___|  _ < 
|_| \_\/_/   \_\/____|_| \_\_____|_| \_\

END_ASCII

check_continue "Installing openrazer" 


sudo pacman -Syy
sudo pacman -S openrazer-daemon

sudo gpasswd -a $username plugdev

yay -S polychromatic

