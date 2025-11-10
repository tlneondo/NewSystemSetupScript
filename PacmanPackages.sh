sudo pacman -S --noconfirm base-devel mpv git make cmake kate automake zsh python3-pip firefox wget tldr curl steam lutris flatpak yt-dlp gamemode discover bluez-utils wireguard-tools

git clone https://aur.archlinux.org/yay.git
cd yay  && makepkg -si
cd ../ && rm -fr yay

cd ~



#if cachyos

sudo pacman -S --noconfirm cachyos-gaming-meta obs-studio-browser