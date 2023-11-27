#Backup default FSTAB drive mapping
sudo cp /etc/fstab /etc/fstab.vanilla

#make mount points
cd /mnt
sudo mkdir Windows SSDWin Storage SSD0 SSD1 SSD2 SSD3 Documents
cd ~

##Add drives to fstab
sudo su -c "echo 'UUID=90dfd5d0-475b-4d01-b2fe-5eb31aed37fc /mnt/SSD0         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=39917c3f-1d3f-4e70-875b-cfc3b8fdc1a9 /mnt/SSD1         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=ed43e4f3-64d3-40d9-a929-11354bf8c339 /mnt/SSD2         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=ed43e4f3-64d3-40d9-a929-11354bf8c339 /mnt/SSD3         btrfs   defaults,discard=async,ssd,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=ab7ffd5c-1cb6-4e20-9168-3f9d3b26393e /mnt/Documents    btrfs   defaults,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=c658b823-655d-4e67-8a9a-1c4d87313200 /mnt/Storage      btrfs   defaults,noatime,compress=zstd 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=CA4AFA3B4AFA23BB                     /mnt/Windows      ntfs    defaults,windows_names,noauto,prealloc 0 0' >> /etc/fstab"
sudo su -c "echo 'UUID=82C425D7C425CDEB                     /mnt/SSDWin      ntfs    defaults,windows_names,noauto,prealloc 0 0' >> /etc/fstab"


#reload fstab
sudo mount -a

sleep 5
