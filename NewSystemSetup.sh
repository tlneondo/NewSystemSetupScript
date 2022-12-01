sudo pacman -Syu

sudo pacman -Sy mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau

sudo pacman -Sy mpv yay zsh firefox chromium tldr curl base-devel steam lutris flatpak discover linux-zen grub-btrfs qbittorrent yt-dlp corectrl

sudo pacman -Sy --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

sudo systemctl enable sshd.service
sudo systemctl start sshd.service

sudo cp /etc/fstab /etc/fstab.vanilla

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


cd /mnt
sudo mkdir Windows Storage SSD0 SSD1 SSD2 Documents

sudo chown -R icyjiub:icyjiub /mnt/Windows
sudo chown -R icyjiub:icyjiub /mnt/Storage
sudo chown -R icyjiub:icyjiub /mnt/SSD0
sudo chown -R icyjiub:icyjiub /mnt/SSD1
sudo chown -R icyjiub:icyjiub /mnt/SSD2
sudo chown -R icyjiub:icyjiub /mnt/Documents

cd ~

rm -r Documents/ Videos/ Pictures/ Downloads/ Music/

ln -s /mnt/Documents/Media/Documents/ /home/icyjiub/
ln -s /mnt/Documents/Media/Videos/ /home/icyjiub/
ln -s /mnt/Documents/Media/Pictures/ /home/icyjiub/
ln -s /mnt/Documents/Media/Downloads/ /home/icyjiub/
ln -s /mnt/Storage/Media/Music/ /home/icyjiub/

cd ~

echo "hrtf = true" >> ~/.alsoftrc

yay -Sy heroic-games-launcher-bin
yay -Sy discord-canary
yay -Sy gamescope-git
yay -Sy sddm-git
yay -Sy raze
yay -Sy ckb-next


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

yay -S timeshift

yay -S timeshift-autosnap

yay -S update-grub

update-grub

sudo systemctl enable grub-btrfs.path


sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"