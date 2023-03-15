#!/bin/bash
#update base packages
sudo pacman -Syu

#Backup default FSTAB drive mapping
sudo cp /etc/fstab /etc/fstab.vanilla

##Add drives to fstab

sudo su -c "echo 'UUID=90dfd5d0-475b-4d01-b2fe-5eb31aed37fc /mnt/SSD0         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=90194eb1-6fe7-4da5-b6ad-36c32112f4ca /mnt/SSD1         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=ed43e4f3-64d3-40d9-a929-11354bf8c339 /mnt/SSD2         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=ab7ffd5c-1cb6-4e20-9168-3f9d3b26393e /mnt/Documents    btrfs   defaults,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=c658b823-655d-4e67-8a9a-1c4d87313200 /mnt/Storage      btrfs   defaults,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=606CE9366CE9081C                     /mnt/Windows      ntfs    defaults 0 0' >> /etc/fstab"

#make mount points
cd /mnt
sudo mkdir Windows Storage SSD0 SSD1 SSD2 Documents
cd ~

#reload fstab
sudo mount -a

sleep 5

#Take ownership of drives - recursive
sudo chown -R icyjiub:icyjiub /mnt/Windows
sudo chown -R icyjiub:icyjiub /mnt/Storage
sudo chown -R icyjiub:icyjiub /mnt/SSD0
sudo chown -R icyjiub:icyjiub /mnt/SSD1
sudo chown -R icyjiub:icyjiub /mnt/SSD2
sudo chown -R icyjiub:icyjiub /mnt/Documents

#Remove folders in Home
rm -r Documents/ Videos/ Pictures/ Downloads/ Music/

#symbolically link folders on separate drives to links in home folder
ln -s /mnt/Documents/Media/Documents/ /home/icyjiub/
ln -s /mnt/Documents/Media/Videos/ /home/icyjiub/
ln -s /mnt/Documents/Media/Pictures/ /home/icyjiub/
ln -s /mnt/Documents/Media/Downloads/ /home/icyjiub/
ln -s /mnt/Storage/Media/Music/ /home/icyjiub/

#update drivers
sudo pacman -Syu mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau base-devel mpv yay zsh firefox tldr curl steam lutris flatpak  linux-zen grub-btrfs qbittorrent yt-dlp corectrl pipewire lib32-pipewire xdg-desktop-portal xdg-desktop-portal-kde qpwgraph filezilla plasma-wayland-session colord colord-kde noto-fonts-cjk noto-fonts-emoji gamemode mpd discover


#disable propriertary AMD Drivers
sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /etc/environment"

#install AUR packages
yay -Sy --sudoloop --noconfirm heroic-games-launcher-bin
yay -Sy --sudoloop --noconfirm discord-canary
yay -Sy --sudoloop --noconfirm gamescope-git
yay -Sy --sudoloop --noconfirm sddm-git
yay -Sy --sudoloop --noconfirm raze
yay -Sy --sudoloop --noconfirm ckb-next
yay -Sy --sudoloop --noconfirm ttf-symbola
yay -Sy --sudoloop --noconfirm mullvad-vpn-bin
yay -Sy --sudoloop --noconfirm vopono

#install and enable BTRFS snapshotting
yay -Sy --sudoloop --noconfirm timeshift
yay -Sy --sudoloop --noconfirm timeshift-autosnap
yay -Sy --sudoloop --noconfirm update-grub
sudo update-grub
sudo systemctl enable grub-btrfs.path

#enable HRTF for openal
echo "hrtf = true" >> ~/.alsoftrc

#enable SSH Server and bluetootth
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

#run installer for oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
