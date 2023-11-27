#Take ownership of drives - recursive
sudo chown -R icyjiub:icyjiub /mnt/Storage
sudo chown -R icyjiub:icyjiub /mnt/SSD0
sudo chown -R icyjiub:icyjiub /mnt/SSD1
sudo chown -R icyjiub:icyjiub /mnt/SSD2
sudo chown -R icyjiub:icyjiub /mnt/SSD3
sudo chown -R icyjiub:icyjiub /mnt/Documents

#Remove folders in Home
#rm Documents/ Videos/ Pictures/ Downloads/ Music/

#symbolically link folders on separate drives to links in home folder
#ln -s /mnt/Documents/Media/Documents/ /home/icyjiub/
#ln -s /mnt/Documents/Media/Videos/ /home/icyjiub/
#ln -s /mnt/Documents/Media/Pictures/ /home/icyjiub/
#ln -s /mnt/Documents/Media/Downloads/ /home/icyjiub/
#ln -s /mnt/Documents/Media/Music/ /home/icyjiub/
