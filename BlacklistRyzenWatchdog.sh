#blacklist ryzen watchdog for less annoyance at reboots
sudo su -c "echo 'blacklist sp5100_tco' > /etc/modprobe.d/disable-sp5100-watchdog.conf"
