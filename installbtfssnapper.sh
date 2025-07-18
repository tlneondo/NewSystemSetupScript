#install btrfs snapping

sudo dnf install snapper cronie cronie-anacron


sudo snapper -c rootsnap create-config /
sudo snapper -c homesnap create-config /home


sudo systemctl enable snapper-timeline.timer
sudo systemctl enable snapper-cleanup.timer
sudo systemctl start snapper-timeline.timer
sudo systemctl start snapper-cleanup.timer
