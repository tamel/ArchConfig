#!/bin/bash
clear

cd $(dirname $0)
source check_continue
source config

# for some reason EOF won't work here, probably because of the \ on the last line (from the R)
cat <<'END_ASCII'
 ____  _____ _____ _     _____ ____ _____ ___  ____  
|  _ \| ____|  ___| |   | ____/ ___|_   _/ _ \|  _ \ 
| |_) |  _| | |_  | |   |  _|| |     | || | | | |_) |
|  _ <| |___|  _| | |___| |__| |___  | || |_| |  _ < 
|_| \_\_____|_|   |_____|_____\____| |_| \___/|_| \_\
END_ASCII

check_continue "Setting up reflector"

sudo pacman -Syy --noconfirm reflector
sudo cat <<EOF > /etc/xdg/reflector/reflector.conf
--save /etc/pacman.d/mirrorlist
--country ${reflectorCountries}
--protocol https
--latest 5
EOF

sudo systemctl enable reflector
sudo systemctl start reflector 
