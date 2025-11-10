#!/bin/bash

#run initial package update
sudo pacman -Syu --noconfirm

#update drivers & install programs

bash ./PacmanPackages.sh

bash ./InstallOhMyZsh.sh

bash ./AUR.sh

bash ./Flatpaks.sh

#make edits to grub
sudo sed -i 's/GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=true/' /etc/default/grub

#enable HRTF for openal
echo "hrtf = true" > ~/.alsoftrc

#enable SSH Server, bluetooth
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

#set vmmax map count options for better wine perf / tweak from steamos
sudo su -c "echo 'vm.max_map_count = 2147483642' > /etc/sysctl.d/99-sysctl.conf"

#change shell to zsh
chsh -s /usr/bin/zsh icyjiub
