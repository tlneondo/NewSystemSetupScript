#Free
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
#NonFree
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#14
sudo dnf copr enable rankyn/xivlauncher
#cachyos kernel
#sudo dnf copr enable bieszczaders/kernel-cachyos
#cachy addonssudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
#sudo dnf copr enable bieszczaders/kernel-cachyos-addons
#fedora vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
#mullad vpn
#sudo dnf config-manager --add-repo https://repository.mullvad.net/rpm/stable/mullvad.repo

sudo dnf copr enable atim/heroic-games-launcher

#sunshine
#sudo dnf copr enable matte-schwartz/sunshine 

sudo dnf check-update
sudo dnf update


sudo dnf install mpv git wget zsh chntpw python3-pip firefox tldr curl steam lutris flatpak qbittorrent yt-dlp filezilla gamemode corectrl syncthing ckb-next obs-studio XIVLauncher-RB make automake gcc gcc-c++ kernel-devel cmake git kate heroic-games-launcher-bin

#install python based bluetooth syncsudo dnf config-manager --add-repo https://repository.mullvad.net/rpm/stable/mullvad.repo
sudo pip install bt-dualboot


#update grub due to install of new kernel
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

#install ohmyzsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
