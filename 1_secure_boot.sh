#!/bin/bash
clear

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
pacman -S --noconfirm sbctl

sbctl status
check_continue "make sure that setup mode is enabled. If not, enable it in the BIOS"

sbctl create-keys
sbctl enroll-keys -m
sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
sbctl sign -s /boot/vmlinuz-linux
sbctl sign -s /boot/EFI/Shell/shellx64.efi
bootctl install
sbctl verify
check_continue "all boot files should be signed"

echo "please enable secure boot in the BIOS"
check_continue "will reboot to BIOS now"
systemctl reboot --firmware-setup
