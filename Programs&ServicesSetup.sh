#cachyh uksmd
sudo systemctl enable uksmd.service

#syncthing
sudo systemctl enable --now syncthing@icyjiub.service

#add my aliases to zsh

echo "alias update-grub="sudo grub2-mkconfig -o /boot/grub2/grub.cfg"" >> ~/.zshrc




#add drives to fstab
#sudo su -c "echo 'UUID=90dfd5d0-475b-4d01-b2fe-5eb31aed37fc /mnt/SSD0         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"

