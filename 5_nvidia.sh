#!/bin/bash
clear

cd $(dirname $0)
source check_continue
source config

cat <<EOF
 _   ___     _____ ____ ___    _    
| \ | \ \   / /_ _|  _ \_ _|  / \   
|  \| |\ \ / / | || | | | |  / _ \  
| |\  | \ V /  | || |_| | | / ___ \ 
|_| \_|  \_/  |___|____/___/_/   \_\
EOF

check_continue "installing nvidia drivers"

# sudo pacman -Syy
# sudo pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils

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
