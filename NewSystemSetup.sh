#!/bin/bash
#update base packages
sudo pacman -Syu

#enable SSH Server
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

#Backup default FSTAB drive mapping
sudo cp /etc/fstab /etc/fstab.vanilla

##Add drives to fstab
sudo echo "" >> /etc/fstab
sudo echo "" >> /etc/fstab

sudo echo "" >> /etc/fstab
sudo echo "" >> /etc/fstab
sudo echo "" >> /etc/fstab
sudo echo "" >> /etc/fstab
sudo echo "" >> /etc/fstab
sudo echo "" >> /etc/fstab

sudo echo "" >> /etc/fstab
sudo echo "" >> /etc/fstab

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
sudo pacman -Sy base-devel mpv yay zsh firefox tldr curl steam lutris flatpak discover linux-zen grub-btrfs qbittorrent yt-dlp corectrl pipewire lib32-pipewire xdg-desktop-portal xdg-desktop-portal-kde qpwgraph lollypop filezilla


#install AUR packages
yay -Sy heroic-games-launcher-bin
yay -Sy discord-canary
yay -Sy gamescope-git
yay -Sy sddm-git
yay -Sy raze
yay -Sy ckb-next

#install flatpak packages
flatpak install flathub net.davidotek.pupgui2
flatpak install flathub com.visualstudio.code
flatpak install flathub com.usebottles.bottles
flatpak install flathub us.zoom.Zoom
flatpak install flathub org.chromium.Chromium
flatpak install flathub com.anydesk.Anydesk
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub org.signal.Signal
flatpak install flathub org.onlyoffice.desktopeditors
flatpak install flathub com.github.Matoking.protontricks
flatpak install flathub org.libretro.RetroArch
flatpak install flathub org.DolphinEmu.dolphin-emu
flatpak install flathub net.rpcs3.RPCS3
flatpak install flathub io.github.shiiion.primehack
flatpak install flathub dev.goats.xivlauncher
flatpak install flathub io.github.am2r_community_developers.AM2RLauncher
flatpak install flathub org.yuzu_emu.yuzu
flatpak install flathub org.ryujinx.Ryujinx
flatpak install flathub org.duckstation.DuckStation
flatpak install flathub tv.plex.PlexDesktop
flatpak install flathub io.gitlab.jstest_gtk.jstest_gtk



#install and enable BTRFS snapshotting
yay -Sy timeshift
yay -Sy timeshift-autosnap
yay -Sy update-grub
update-grub
sudo systemctl enable grub-btrfs.path

#enable HRTF for openal
echo "hrtf = true" >> ~/.alsoftrc

#run installer for oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Rebooting in 10 Seconds!"

sleep 10
reboot