#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<'END_ASCII'
 ____  _    _   _ _____ _____ ___   ___ _____ _   _ 
| __ )| |  | | | | ____|_   _/ _ \ / _ \_   _| | | |
|  _ \| |  | | | |  _|   | || | | | | | || | | |_| |
| |_) | |__| |_| | |___  | || |_| | |_| || | |  _  |
|____/|_____\___/|_____| |_| \___/ \___/ |_| |_| |_|
END_ASCII

check_continue "installing bluetooth drivers"

sudo pacman -Syy
sudo pacman -S bluez bluez-utils

sudo systemctl enable bluetooth
sudo systemctl start bluetooth
