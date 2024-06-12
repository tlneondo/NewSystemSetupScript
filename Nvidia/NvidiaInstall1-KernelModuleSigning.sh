#Setup self Signing Kernel Modules
sudo dnf install kmodtool akmods mokutil openssl
sudo kmodgenca -a
sudo mokutil --import /etc/pki/akmods/certs/public_key.der

echo "Please Reboot"