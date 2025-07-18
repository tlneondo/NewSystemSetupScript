#remove old nvidia drivers
sudo dnf -y remove *nvidia*
sudo dnf -y remove libva-utils vdpauinfo
sudo dnf -y remove xorg-x11-drv-nvidia\*
sudo dnf -y remove nvidia-driver nvidia-driver-libs.i686 nvidia-settings

sudo dnf copr disable kwizart/nvidia-driver-rawhide -y
sudo rm /etc/yum.repos.d/fedora-nvidia.repo


