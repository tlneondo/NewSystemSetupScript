sudo dnf install "kernel-devel-uname-r >= $(uname -r)"
sudo dnf update -y
sudo dnf install libva-utils vdpauinfo
sudo dnf copr enable kwizart/nvidia-driver-rawhide -y
sudo dnf install rpmfusion-nonfree-release-rawhide -y
sudo dnf --enablerepo=rpmfusion-nonfree-rawhide install akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-power vulkan xorg-x11-drv-nvidia-cuda-libs xorg-x11-drv-nvidia-libs.i686 nvidia-vaapi-driver --nogpgcheck
sudo systemctl enable nvidia-{suspend,resume,hibernate}

echo "Add the following to your Kernel Command Line Options\n"
echo "NVreg_UsePageAttributeTable=1 NVreg_PreserveVideoMemoryAllocations=1 nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_EnableGpuFirmware=0"

#Make sure the kernel modules got compiled
sudo akmods --force

#Make sure the boot image got updated as well
sudo dracut --force

#update grub with new options
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

echo "Please Reboot"
