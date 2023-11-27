#install and enable BTRFS snapshotting
yay -S --sudoloop timeshift
yay -S --sudoloop timeshift-autosnap
yay -S --sudoloop update-grubhttps://github.com/dotaxis/7H-SteamDeck-Fix
sudo systemctl enable grub-btrfs.path
