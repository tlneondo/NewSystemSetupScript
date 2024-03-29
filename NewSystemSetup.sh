#!/bin/bash

isGamingDesktop=0
isBTRFSsystem=0
isAMDGPU=0
isRyzen=0

echo "Is this your desktop? y or n - 1 or 0"

if $(hostname) == "icyjiub-desktop"; 
    then isGamingDesktop=1
fi

echo "Is root a btrfs partition? y or n - 1 or 0"

if df / --print-type | grep -q "btrfs";
    then isBTRFSsystem=1
fi

echo "Does this use an AMD GPU? y or n - 1 or 0"
read isAMDGPU

echo "Does this use a Ryzen CPU? y or n - 1 or 0"
read isRyzen


#Backup default FSTAB drive mapping
sudo cp /etc/fstab /etc/fstab.vanilla

if(isBTRFSsystem)
then
    #Set Up BTRFS Swap file
    sudo btrfs filesystem mkswapfile --size 8g /swap
    sudo swapon /swap
    sudo su -c "echo '/swap none swap defaults 0 0' >> /etc/fstab"
fi


if(isGamingDesktop)
then
    ##Add drives to fstab
    sudo su -c "echo 'UUID=90dfd5d0-475b-4d01-b2fe-5eb31aed37fc /mnt/SSD0         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
    sudo su -c "echo 'UUID=90194eb1-6fe7-4da5-b6ad-36c32112f4ca /mnt/SSD1         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
    sudo su -c "echo 'UUID=ed43e4f3-64d3-40d9-a929-11354bf8c339 /mnt/SSD2         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
    sudo su -c "echo 'UUID=ab7ffd5c-1cb6-4e20-9168-3f9d3b26393e /mnt/Documents    btrfs   defaults,compress=zstd 0 0' >> /etc/fstab"
    sudo su -c "echo 'UUID=c658b823-655d-4e67-8a9a-1c4d87313200 /mnt/Storage      btrfs   defaults,compress=zstd 0 0' >> /etc/fstab"
    sudo su -c "echo 'UUID=606CE9366CE9081C                     /mnt/Windows      ntfs    defaults 0 0' >> /etc/fstab"

    #make mount points
    cd /mnt
    sudo mkdir Windows Storage SSD0 SSD1 SSD2 Documents NVME1
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
    sudo chown -R icyjiub:icyjiub /mnt/NVME1

    #Remove folders in Home
    rm -r Documents/ Videos/ Pictures/ Downloads/ Music/

    #symbolically link folders on separate drives to links in home folder
    ln -s /mnt/NVME1/Media/Documents/ /home/icyjiub/
    ln -s /mnt/NVME1/Media/Videos/ /home/icyjiub/
    ln -s /mnt/NVME1/Media/Pictures/ /home/icyjiub/
    ln -s /mnt/NVME1/Media/Downloads/ /home/icyjiub/
    ln -s /mnt/Storage/Media/Music/ /home/icyjiub/
fi

#set up chaotic AUR

sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo su -c "echo '[chaotic-aur]' >> /etc/pacman.conf"
sudo su -c "echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"

#run initial package update
sudo pacman -Syu --noconfirm

#update drivers & install programs

sudo pacman -S --noconfirm base-devel mpv zsh firefox tldr curl steam lutris flatpak linux-zen qbittorrent yt-dlp pipewire lib32-pipewire xdg-desktop-portal xdg-desktop-portal-kde qpwgraph filezilla plasma-wayland-session colord colord-kde noto-fonts-cjk noto-fonts-emoji gamemode mpd discover byobu bluez bluez-utils wireguard-tools git-lfs


if(isAMDGPU)
then
    sudo pacman -S --noconfirm mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver lib32-libva-mesa-driver mesa-vdpau lib32-mesa-vdpau corectrl
fi

if(isBTRFSsystem)
then
    sudo pacman -S --noconfirm grub-btrfs
fi

#install yay for AUR access
git clone https://aur.archlinux.org/yay.git
cd yay  && makepkg -si
cd ../ && rm -fr yay

#set yay settings for autoconfirms
yay --save --answerdiff None --answerclean None --removemake

if(isAMDGPU)
then
    #install proprietary amd driver and set environment variables so it is unused except for obs
    yay -S --sudoloop vulkan-amdgpu-pro
    yay -S --sudoloop lib32-vulkan-amdgpu-pro
    yay -S --sudoloop amf-amdgpu-pro
    sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /etc/environment"
    sudo su -c "echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> /etc/environment"
    sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /etc/profile"
    sudo su -c "echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> /etc/profile"
    sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /home/icyjiub/.profile"
    sudo su -c "echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> /home/icyjiub/.profile"
    sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /home/icyjiub/.zshrc"
    sudo su -c "echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> /home/icyjiub/.zshrc"
fi

#install AUR packages
yay -S --sudoloop heroic-games-launcher-bin
yay -S --sudoloop discord-canary-electron-bin
yay -S --sudoloop gamescope-git
yay -S --sudoloop sddm-git
yay -S --sudoloop raze
yay -S --sudoloop gzdoom
yay -S --sudoloop ckb-next
yay -S --sudoloop ttf-symbola
yay -S --sudoloop mullvad-vpn-bin
yay -S --sudoloop vopono
yay -S --sudoloop mpdevil
yay -S --sudoloop preload
yay -S --sudoloop ananicy
yay -S --sudoloop visual-studio-code-bin
yay -S --sudoloop discord-canary-update-skip-git

if(isAMDGPU)
then
    yay -S --sudoloop obs-studio-amf
else
    yay -S --sudoloop obs-studio
fi

yay -S --sudoloop obs-vkcapture
yay -S --sudoloop lib32-obs-vkcapture
yay -S --sudoloop obs-pipewire-audio-capture-bin


#discord canary update skip
discord-canary-update-skip

if(isBTRFSsystem)
then
    #install and enable BTRFS snapshotting
    yay -S --sudoloop timeshift
    yay -S --sudoloop timeshift-autosnap
    yay -S --sudoloop update-grubhttps://github.com/dotaxis/7H-SteamDeck-Fix
    sudo systemctl enable grub-btrfs.path
fi

#clear yay settings
rm ~/.config/yay/config.json

if(isRyzen)
then
    #blacklist ryzen watchdog for less annoyance at reboots
    sudo su -c "echo 'blacklist sp5100_tco' > /etc/modprobe.d/disable-sp5100-watchdog.conf"
fi

#make edits to grub
sudo sed -i 's/GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=true/' /etc/default/grub

if(isAMDGPU)
then
    #not working yet
    #sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="/&amdgpu.ppfeaturemask=0xffffffff /' /etc/default/grub
    echo ""
fi

#enable preload service
sudo systemctl start preload.service
sudo systemctl enable preload.service

#enable HRTF for openal
echo "hrtf = true" > ~/.alsoftrc

#enable SSH Server, bluetooth, preload, ananicy
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

sudo systemctl enable preload.service
sudo systemctl start preload.service

sudo systemctl enable ananicy
sudo systemctl start ananicy

if(isAMDGPU)
then
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
fi

#set vmmax map count options for better wine perf / tweak from steamos
sudo su -c "echo 'vm.max_map_count = 2147483642' > /etc/sysctl.d/99-sysctl.conf"

if(isGamingDesktop)
then
    #copy monitor profile into colord folder
    sudo cp /mnt/Documents/Media/Documents/BenQXL2420Z120hz.icm /usr/share/color/icc/colord/
fi

#change shell to zsh
chsh -s /usr/bin/zsh icyjiub


#install flatpak packages

flatpak update --noninteractive

flatpak install -y --noninteractive flathub net.davidotek.pupgui2
flatpak install -y --noninteractive flathub com.usebottles.bottles
flatpak install -y --noninteractive flathub us.zoom.Zoom
flatpak install -y --noninteractive flathub org.chromium.Chromium
flatpak install -y --noninteractive flathub com.anydesk.Anydesk
flatpak install -y --noninteractive flathub com.github.tchx84.Flatseal
flatpak install -y --noninteractive flathub org.signal.Signal
flatpak install -y --noninteractive flathub org.onlyoffice.desktopeditors
flatpak install -y --noninteractive flathub com.github.Matoking.protontricks
flatpak install -y --noninteractive flathub tv.plex.PlexDesktop

if(isGamingDesktop)
then
    #gaming related flatpaks
    flatpak install -y --noninteractive flathub org.yuzu_emu.yuzu
    flatpak install -y --noninteractive flathub org.ryujinx.Ryujinx
    flatpak install -y --noninteractive flathub org.duckstation.DuckStation
    flatpak install -y --noninteractive flathub io.gitlab.jstest_gtk.jstest_gtk
    flatpak install -y --noninteractive flathub org.libretro.RetroArch
    flatpak install -y --noninteractive flathub org.DolphinEmu.dolphin-emu
    flatpak install -y --noninteractive flathub net.rpcs3.RPCS3
    flatpak install -y --noninteractive flathub io.github.shiiion.primehack
    flatpak install -y --noninteractive flathub dev.goats.xivlauncher
    flatpak install -y --noninteractive flathub io.github.am2r_community_developers.AM2RLauncher
fi

#enable byobu multiplexer by default
#byobu-enable

#enable pulseaudio autoswitch
#pactl load-module module-switch-on-connect


#run installer for oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"