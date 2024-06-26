#official rpmfusion instructions for stable driver
sudo dnf install "kernel-devel-uname-r >= $(uname -r)"
sudo dnf update -y
sudo dnf install libva-utils vdpauinfo
sudo dnf install akmod-nvidia 
sudo dnf install xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-power vulkan xorg-x11-drv-nvidia-cuda-libs xorg-x11-drv-nvidia-libs.i686 nvidia-vaapi-driver
sudo systemctl enable nvidia-{suspend,resume,hibernate}


echo "Add the following to your Kernel Command Line Options"
echo ""
echo "IE, add these to the end of GRUB_CMDLINE_LINUX=, in the parentheses, separated by spaces"
echo ""
echo "NVreg_UsePageAttributeTable=1 NVreg_PreserveVideoMemoryAllocations=1 nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_EnableGpuFirmware=0"
echo ""
echo ""
echo "It should look someting like: (rhgb quiet are just what was including on my machine, don't remove whatever was on yours)"
echo ""
echo "GRUB_CMDLINE_LINUX=\"rhgb quiet NVreg_UsePageAttributeTable=1 NVreg_PreserveVideoMemoryAllocations=1 nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_EnableGpuFirmware=0\""
echo ""
echo "Now we run the next script to import the options into the grub bootloader, then we'll be set"
