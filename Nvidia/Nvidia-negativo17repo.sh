#from https://negativo17.org/nvidia-driver/

sudo dnf config-manager addrepo --overwrite --from-repofile  https://negativo17.org/repos/fedora-nvidia.repo

sudo dnf update --refresh

sudo dnf install nvidia-driver nvidia-driver-libs.i686 nvidia-settings nvidia-driver-NvFBCOpenGL nvidia-driver-cuda cuda-devel
