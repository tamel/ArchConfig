#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<'END_ASCII'
    _    __  __ ____  
   / \  |  \/  |  _ \ 
  / _ \ | |\/| | | | |
 / ___ \| |  | | |_| |
/_/   \_\_|  |_|____/ 
END_ASCII

check_continue "installing amd drivers"

sudo pacman -Syy
sudo pacman -S --noconfirm mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader

yay -S amdgpu_top
