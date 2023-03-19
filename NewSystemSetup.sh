#!/bin/bash

#Backup default FSTAB drive mapping
sudo cp /etc/fstab /etc/fstab.vanilla

#Set Up BTRFS Swap file
sudo btrfs filesystem mkswapfile --size 8g /swap
sudo swapon /swap
sudo su -c "echo '/swap none swap defaults 0 0' >> /etc/fstab"

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

#run initial package update
sudo pacman -Syu --noconfirm

#update drivers & install programs
sudo pacman -S --noconfirm xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau base-devel mpv zsh firefox tldr curl steam lutris flatpak linux-zen grub-btrfs qbittorrent yt-dlp corectrl pipewire lib32-pipewire xdg-desktop-portal xdg-desktop-portal-kde qpwgraph filezilla plasma-wayland-session colord colord-kde noto-fonts-cjk noto-fonts-emoji gamemode mpd discover byobu bluez bluez-utils wireguard-tools


#set up chaotic AUR



#install yay for AUR access
git clone https://aur.archlinux.org/yay.git
cd yay  && makepkg -si
cd ../ && rm -fr yay

#disable propriertary AMD Drivers
sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /etc/environment"
sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /etc/profile"

##install proprietary driver stub for OBS Hardware Encoding
#cd ~
#mkdir amftemp && cd amftemp
#git clone https://github.com/Frogging-Family/amdgpu-pro-vulkan-only
#cd amdgpu-pro-vulkan-only
#makepkg -si
#sleep 5
#cd ~
#rm -fr ./amftemp

#set yay settings for autoconfirms

#install AUR packages
yay -S --sudoloop heroic-games-launcher-bin
yay -S --sudoloop discord-canary
yay -S --sudoloop gamescope-git
yay -S --sudoloop sddm-git
yay -S --sudoloop raze
yay -S --sudoloop ckb-next
yay -S --sudoloop ttf-symbola
yay -S --sudoloop mullvad-vpn-bin
yay -S --sudoloop vopono
yay -S --sudoloop mpdevil
yay -S --sudoloop obs-studio-amf
yay -S --sudoloop obs-vkcapture
yay -S --sudoloop lib32-obs-vkcapture
yay -S --sudoloop preload

#install and enable BTRFS snapshotting
yay -S --sudoloop timeshift
yay -S --sudoloop timeshift-autosnap
yay -S --sudoloop update-grub
sudo systemctl enable grub-btrfs.path

#clear yay settings

#blacklist ryzen watchdog for less annoyance at reboots
sudo su -c "echo 'blacklist sp5100_tco' > /etc/modprobe.d/disable-sp5100-watchdog.conf"

#make edits to grub
sudo sed -i 's/GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=true/' /etc/default/grub
sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="/&amdgpu.ppfeaturemask=0xffffffff /' /etc/default/grub

#enable preload service
sudo systemctl start preload.service
sudo systemctl enable preload.service

#enable HRTF for openal
echo "hrtf = true" > ~/.alsoftrc

#enable SSH Server and bluetootth
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

#enable byobu multiplexer by default
byobu-enable

#setup corectrl
sudo cp /usr/share/applications/org.corectrl.corectrl.desktop ~/.config/autostart/org.corectrl.corectrl.desktop

sudo su -c "echo 'polkit.addRule(function(action, subject) {
    if ((action.id == "org.corectrl.helper.init" ||
         action.id == "org.corectrl.helperkiller.init") &&
        subject.local == true &&
        subject.active == true &&
        subject.isInGroup("your-user-group")) {
            return polkit.Result.YES;
    }
});
' >> /etc/polkit-1/rules.d/90-corectrl.rules"

#copy monitor profile into colord folder
sudo cp /mnt/Documents/Media/Documents/BenQXL2420Z120hz.icm usr/share/color/icc/colord/

#change shell to zsh


#run installer for oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
