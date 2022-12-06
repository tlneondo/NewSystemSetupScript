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
sudo pacman -Sy mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

#disable propriertary AMD Drivers
sudo echo "AMD_VULKAN_ICD=RADV" >> /etc/environment

#install lutris dependencies
sudo pacman -Sy --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

#install prefered packages
sudo pacman -Sy base-devel mpv yay zsh firefox tldr curl steam lutris flatpak discover linux-zen grub-btrfs qbittorrent yt-dlp corectrl pipewire lib32-pipewire xdg-desktop-portal xdg-desktop-portal-kde qpwgraph lollypop filezilla plasma-wayland-session colord colord-kde noto-fonts-cjk noto-fonts-emoji gamemode


#install AUR packages
yay -Sy heroic-games-launcher-bin
yay -Sy discord-canary
yay -Sy gamescope-git
yay -Sy sddm-git
yay -Sy raze
yay -Sy ckb-next
yay -Sy ttf-symbola
yay -Sy mullvad-vpn-bin
yay -Sy vopono
yay -Sy latte-dock


#install flatpak packages
flatpak install -y --noninteractive flathub net.davidotek.pupgui2
flatpak install -y --noninteractive flathub com.visualstudio.code
flatpak install -y --noninteractive flathub com.usebottles.bottles
flatpak install -y --noninteractive flathub us.zoom.Zoom
flatpak install -y --noninteractive flathub org.chromium.Chromium
flatpak install -y --noninteractive flathub com.anydesk.Anydesk
flatpak install -y --noninteractive flathub com.github.tchx84.Flatseal
flatpak install -y --noninteractive flathub org.signal.Signal
flatpak install -y --noninteractive flathub org.onlyoffice.desktopeditors
flatpak install -y --noninteractive flathub com.github.Matoking.protontricks
flatpak install -y --noninteractive flathub org.libretro.RetroArch
flatpak install -y --noninteractive flathub org.DolphinEmu.dolphin-emu
flatpak install -y --noninteractive flathub net.rpcs3.RPCS3
flatpak install -y --noninteractive flathub io.github.shiiion.primehack
flatpak install -y --noninteractive flathub dev.goats.xivlauncher
flatpak install -y --noninteractive flathub io.github.am2r_community_developers.AM2RLauncher
flatpak install -y --noninteractive flathub org.yuzu_emu.yuzu
flatpak install -y --noninteractive flathub org.ryujinx.Ryujinx
flatpak install -y --noninteractive flathub org.duckstation.DuckStation
flatpak install -y --noninteractive flathub tv.plex.PlexDesktop
flatpak install -y --noninteractive flathub io.gitlab.jstest_gtk.jstest_gtk



#install and enable BTRFS snapshotting
yay -Sy timeshift
yay -Sy timeshift-autosnap
yay -Sy update-grub
update-grub
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
