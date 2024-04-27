#!/bin/bash
clear

cd $(dirname $0) 
source check_continue
source config

cat <<EOF
 ____  _____ ____ _   _ ____  _____   ____   ___   ___ _____ 
/ ___|| ____/ ___| | | |  _ \| ____| | __ ) / _ \ / _ \_   _|
\___ \|  _|| |   | | | | |_) |  _|   |  _ \| | | | | | || |  
 ___) | |__| |___| |_| |  _ <| |___  | |_) | |_| | |_| || |  
|____/|_____\____|\___/|_| \_\_____| |____/ \___/ \___/ |_|  
EOF
 
check_continue "setting up secure boot"
sudo pacman -Syy --noconfirm sbctl

sudo sbctl status
check_continue "make sure that setup mode is enabled. If not, enable it in the BIOS"

sudo sbctl create-keys
sudo sbctl enroll-keys -m
sudo sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
sudo sbctl sign -s /boot/vmlinuz-linux
sudo sbctl sign -s /boot/EFI/Shell/shellx64.efi
sudo bootctl install
sudo sbctl verify
check_continue "all boot files should be signed"

echo "please enable secure boot in the BIOS"
check_continue "will reboot to BIOS now"
sudo systemctl reboot --firmware-setup
