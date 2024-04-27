#!/bin/bash
clear

set -euo pipefail

cd $(dirname $0)
source check_continue
source config

cat <<EOF
__   __ _ __   __
\ \ / // \\ \ / /
 \ V // _ \\ V / 
  | |/ ___ \| |  
  |_/_/   \_\_|  
EOF

check_continue "Installing yay package manager"

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
