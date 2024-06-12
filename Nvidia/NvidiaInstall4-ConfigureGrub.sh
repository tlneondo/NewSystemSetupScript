
#Make sure the kernel modules got compiled
sudo akmods --force

#Make sure the boot image got updated as well
sudo dracut --force

#update grub with new options
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

echo "Please Reboot"
