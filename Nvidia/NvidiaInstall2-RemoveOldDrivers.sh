#remove old nvidia drivers
sudo dnf -y remove *nvidia*
sudo dnf -y remove xorg-x11-drv-nvidia\*
sudo dnf copr disable kwizart/nvidia-driver-rawhide -y