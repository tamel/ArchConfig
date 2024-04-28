#!/bin/bash

sudo pacman -Syy
sudo pacman -S --noconfirm sddm xfce4

cat <<EOF | sudo tee /usr/share/sddm/scripts/Xsetup > /dev/null
#!/bin/sh

xrandr --output DP-1-0 --auto --primary
EOF

sudo systemctl enable sddm
sudo systemctl start sddm
