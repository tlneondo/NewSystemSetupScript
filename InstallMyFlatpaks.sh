#add flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak update --noninteractive
flatpak install -y --noninteractive flathub net.davidotek.pupgui2
flatpak install -y --noninteractive flathub com.usebottles.bottles
flatpak install -y --noninteractive flathub org.chromium.Chromium
flatpak install -y --noninteractive flathub com.anydesk.Anydesk
flatpak install -y --noninteractive flathub com.github.tchx84.Flatseal
flatpak install -y --noninteractive flathub org.signal.Signal
flatpak install -y --noninteractive flathub org.onlyoffice.desktopeditors
flatpak install -y --noninteractive flathub com.github.Matoking.protontricks
flatpak install -y --noninteractive flathub org.duckstation.DuckStation
flatpak install -y --noninteractive flathub org.DolphinEmu.dolphin-emu
flatpak install -y --noninteractive flathub net.rpcs3.RPCS3
flatpak install -y --noninteractive flathub io.github.shiiion.primehack
flatpak install -y --noninteractive flathub dev.vencord.Vesktop

#SystemPackage
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.dec05eba.gpu_screen_recorder