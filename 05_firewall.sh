#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<'END_ASCII'
 _____ ___ ____  _______        ___    _     _     
|  ___|_ _|  _ \| ____\ \      / / \  | |   | |    
| |_   | || |_) |  _|  \ \ /\ / / _ \ | |   | |    
|  _|  | ||  _ <| |___  \ V  V / ___ \| |___| |___ 
|_|   |___|_| \_\_____|  \_/\_/_/   \_\_____|_____|
END_ASCII

check_continue "Setting up firewall"

sudo pacman -Syy --noconfirm firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld

read -r -p "Enter WIFI name so add it to the home zone: " wifiName
sudo nmcli connection modify "${wifiName}" connection.zone home
