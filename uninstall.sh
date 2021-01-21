#!/bin/bash

#Removing Existing Configs
sudo rm -r ~/.config/lxpanel
sudo rm -r ~/.config/lxterminal
sudo rm -r ~/.config/lxsession
sudo rm -r ~/.config/pcmanfm

#restoring backups
cp -r  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxpanel ~/.config
cp -r  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxsession ~/.config
cp -r  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxterminal ~/.config
cp -r  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/pcmanfm ~/.config

#Removing autostart shortcuts
sudo rm /home/pi/.config/autostart/MacOSBigSurThemeConverterAutostart.desktop

#Removing Gtk Themes
rm -r ~/.themes/WhiteSur-dark/
rm -r ~/.themes/WhiteSur-light/

#Removing Icon Themes
rm -r ~/.local/share/icons/BigSur/
rm -r ~/.local/share/icons/BigSur-dark/

#Removing Cursors
sudo rm -r /usr/share/icons/BigSur-Originals-Cursor/

#Removing Plank Theme
rm -r ~/.local/share/plank/themes/mcOS-BS-Black-Stock/
rm -r ~/.local/share/plank/themes/mcOS-BS-White-Stock/

#Removing Ulauncher, xfce4-panel-profiles, lightpad, and panther launcher
sudo apt -y purge ulauncher xfce4-panel-profiles lightpad panther-launcher
sudo apt -y purge plank xfwm4 xfce4-settings nautilus yad xfce4-panel xfce4-appmenu-plugin xfce4-statusnotifier-plugin xfce4-pulseaudio-plugin blueman figlet lolcat

#Removing Desktop Files
rm ~/.local/share/applications/Pi-Apps.desktop
rm ~/.local/share/applications/panther_launcher.desktop
rm ~/.local/share/applications/ThemeConverter.desktop 
rm ~/.local/share/applications/lightpad.desktop 
rm ~/.local/share/applications/logout.desktop 

#Removing Icons
rm ~/.local/share/icons/AppStore.png
rm ~/.local/share/icons/MacOSBigSurThemeConverterLogo.png
rm ~/.local/share/icons/aunchpad.svg

#Removing Network Manager
sudo sed -i '/denyinterfaces wlan0/c\ ' /etc/dhcpcd.conf 
sudo sed -i '/[main]/,/managed=true/d' /etc/NetworkManager/NetworkManager.conf 

#Restoring Default Desktop File For Chromium
sudo sed -i '/Icon/c\Icon=chromium-browser' /usr/share/applications/chromium-browser.desktop

echo "Finished Restoring Config Files.Refreshing desktop session now, but rebooting is recommended."

#Refreshing Desktop Session
killall lxpanel plank xfwm4 xfce4-panel &>/dev/null
sudo update-icon-caches /usr/share/icons/*
nohup openbox &>/dev/null &
nohup pcmanfm --desktop --profile LXDE-pi &>/dev/null &
nohup pcmanfm --reconfigure &>/dev/null &
nohup lxpanel --profile LXDE-pi &>/dev/null &
disown

