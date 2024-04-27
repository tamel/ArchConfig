#!/bin/bash
clear

set -euo pipefail

cd $(dirname $0)
source check_continue
source config

cat <<'END_ASCII'
 _   ___     _____ ____ ___    _    
| \ | \ \   / /_ _|  _ \_ _|  / \   
|  \| |\ \ / / | || | | | |  / _ \  
| |\  | \ V /  | || |_| | | / ___ \ 
|_| \_|  \_/  |___|____/___/_/   \_\
END_ASCII

check_continue "installing nvidia drivers"

sudo pacman -Syy
sudo pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils

loopState="running"

while [ "$loopState" == "running" ];
do
  echo "here is your mkinitcpio.conf:"
  cat /etc/mkinitcpio.conf
  echo
  echo "make sure that:"
  echo "- kms is removed from the HOOKS array (this will prevent initramfs from containing the nouveau driver)"
  echo "- add the following modules to the MODULES array: nvidia nvidia_modeset nvidia_uvm nvidia_drm"

  read -p "please choose: (e)open mkinitcpio or (c)continue: " mkinitSelection

  case $mkinitSelection in
    e)
      sudo vim /etc/mkinitcpio.conf
      ;;
    c)
      loopState="done"
      ;;
    *)
      echo "invalid selection"
      ;;
  esac
done

echo "updating bootload entry to enable nvidia_drm.modeset"
sudo gawk -i inplace '$1 == "options" {print $0 " nvidia_drm.modeset=1"; next} {print}' /boot/loader/entries/69-arch.conf

echo "enabling auto rebuild of initramfs after updateting nvidia drivers"

cat <<EOF | sudo tee /etc/pacman.d/hooks/nvidia.hook > /dev/null
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
# Uncomment the installed NVIDIA package
Target=nvidia
#Target=nvidia-open
#Target=nvidia-lts
# If running a different kernel, modify below to match
Target=linux

[Action]
Description=Updating NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOF
