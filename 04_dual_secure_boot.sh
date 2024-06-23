#!/bin/bash
clear

set -euo pipefail

cd "$(dirname "$0")" || exit
source check_continue
source config

cat <<END_ASCII
 ____  _   _   _    _         ____  _____ ____ _   _ ____  _____ 
|  _ \| | | | / \  | |       / ___|| ____/ ___| | | |  _ \| ____|
| | | | | | |/ _ \ | |   ____\___ \|  _|| |   | | | | |_) |  _|  
| |_| | |_| / ___ \| |__|_____|__) | |__| |___| |_| |  _ <| |___ 
|____/ \___/_/   \_\_____|   |____/|_____\____|\___/|_| \_\_____|
                                                                 
 ____   ___   ___ _____ 
| __ ) / _ \ / _ \_   _|
|  _ \| | | | | | || |  
| |_) | |_| | |_| || |  
|____/ \___/ \___/ |_|  
END_ASCII
 
check_continue "setting up secure boot"
sudo pacman -Syy --noconfirm sbctl efibootmgr refind
sudo refind-install

sudo sbctl status
check_continue "make sure that setup mode is enabled. If not, enable it in the BIOS"

sudo sbctl create-keys
sudo sbctl enroll-keys -m
sudo sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
sudo sbctl sign -s /boot/EFI/refind/refind_x64.efi
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
sudo sbctl sign -s /boot/vmlinuz-linux

sudo bootctl install
sudo sbctl verify
check_continue "all boot files should be signed"

echo "please enable secure boot in the BIOS"
check_continue "will reboot to BIOS now"
sudo systemctl reboot --firmware-setup
