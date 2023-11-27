#Set Up BTRFS Swap file
sudo btrfs filesystem mkswapfile --size 8g /swap
sudo swapon /swap
sudo su -c "echo '/swap none swap defaults 0 0' >> /etc/fstab"
