echo 'KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"' | \
sudo tee /etc/udev/rules.d/60-sunshine.rules
sudo udevadm control --reload-rules
sudo udevadm trigger
sudo modprobe uinput

sudo setcap cap_sys_admin+p $(readlink -f $(which sunshine))

cp ./Extra/sunshine.service ~/.config/systemd/user/

systemctl --user start sunshine
systemctl --user enable sunshine