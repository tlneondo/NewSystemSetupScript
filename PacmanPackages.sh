sudo pacman -S --noconfirm base-devel mpv git zsh firefox tldr curl steam lutris flatpak yt-dlp gamemode discover bluez-utils wireguard-tools

git clone https://aur.archlinux.org/yay.git
cd yay  && makepkg -si
cd ../ && rm -fr yay

cd ~
