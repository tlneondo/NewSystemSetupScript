#official rpmfusion instructions for stable driver
sudo dnf install "kernel-devel-uname-r >= $(uname -r)"
sudo dnf update -y
sudo dnf install libva-utils vdpauinfo
sudo dnf install akmod-nvidia 
sudo dnf install xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-power vulkan xorg-x11-drv-nvidia-cuda-libs xorg-x11-drv-nvidia-libs.i686 nvidia-vaapi-driver
sudo systemctl enable nvidia-{suspend,resume,hibernate}


echo "Now we run the next script to import any options into the grub bootloader and make sure kernel modules are compiled then we'll be set"
