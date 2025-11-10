#make mount points
cd /mnt
sudo mkdir -p Windows SSDWin SSD2Win Storage SSD3 NVME0 Documents winOverlay/SSDWinLower winOverlay/SSD2WinLower

#Backup default FSTAB drive mapping
sudo cp /etc/fstab /etc/fstab.vanilla

read -n 1 -p "Press Enter After Making changes to FSTAB"
echo "" # Add a newline for better formatting
echo "Continuing script..."




#Take ownership of drives - recursive
sudo chown -R icyjiub:icyjiub /mnt/*

cd ~


#Remove folders in Home
rm Documents/ Videos/ Pictures/ Downloads/ Music/

#symbolically link folders on separate drives to links in home folder
ln -s /mnt/Documents/Media/Documents/ /home/icyjiub/
ln -s /mnt/Documents/Media/Videos/ /home/icyjiub/
ln -s /mnt/Documents/Media/Pictures/ /home/icyjiub/
ln -s /mnt/Documents/Media/Downloads/ /home/icyjiub/
ln -s /mnt/Documents/Media/Music/ /home/icyjiub/




#reload fstab
sudo mount -a
