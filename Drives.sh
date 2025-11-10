#make mount points
cd /mnt
sudo mkdir Windows SSDWin Storage SSD0 SSD1 SSD2 SSD3 NVME0 Documents


#Take ownership of drives - recursive
sudo chown -R icyjiub:icyjiub /mnt/*

#Backup default FSTAB drive mapping
sudo cp /etc/fstab /etc/fstab.vanilla


cd ~


#Remove folders in Home
#rm Documents/ Videos/ Pictures/ Downloads/ Music/

#symbolically link folders on separate drives to links in home folder
#ln -s /mnt/Documents/Media/Documents/ /home/icyjiub/
#ln -s /mnt/Documents/Media/Videos/ /home/icyjiub/
#ln -s /mnt/Documents/Media/Pictures/ /home/icyjiub/
#ln -s /mnt/Documents/Media/Downloads/ /home/icyjiub/
#ln -s /mnt/Documents/Media/Music/ /home/icyjiub/




#reload fstab
sudo mount -a
