#!/bin/bash

#Removing Existing Configs
sudo rm -rf ~/.config/lxpanel
sudo rm -rf ~/.config/lxterminal
sudo rm -rf ~/.config/lxsession
sudo rm -rf ~/.config/pcmanfm

#restoring backups
cp -rf  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxpanel ~/.config &>/dev/null
cp -rf  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxsession ~/.config &>/dev/null
cp -rf  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/lxterminal ~/.config &>/dev/null
cp -rf  ~/.local/share/MacOSBigSurThemeConverter/.config_backup/pcmanfm ~/.config &>/dev/null

#Removing autostart shortcuts
sudo rm -f /home/pi/.config/autostart/MacOSBigSurThemeConverterAutostart.desktop

#Removing Gtk Themes
rm -rf ~/.themes/WhiteSur-dark/
rm -rf ~/.themes/WhiteSur-light/

#Removing Icon Themes
rm -rf ~/.local/share/icons/BigSur/
rm -rf ~/.local/share/icons/BigSur-dark/

#Removing Cursors
sudo rm -rf /usr/share/icons/BigSur-Originals-Cursor/

#Removing Plank Theme
rm -rf ~/.local/share/plank/themes/mcOS-BS-Black-Stock/
rm -rf ~/.local/share/plank/themes/mcOS-BS-White-Stock/

#Killing applets
killall nm-applet
killall blueman-applet

#Removing Ulauncher, xfce4-panel-profiles, lightpad, and panther launcher
sudo apt -y purge ulauncher xfce4-panel-profiles lightpad panther-launcher plank xfwm4 xfce4-settings nautilus xfce4-panel xfce4-appmenu-plugin xfce4-statusnotifier-plugin xfce4-pulseaudio-plugin blueman network-manager figlet lolcat pavucontrol 

#Removing Desktop Files
rm -f ~/.local/share/applications/Pi-Apps.desktop
rm -f ~/.local/share/applications/panther_launcher.desktop
rm -f ~/.local/share/applications/ThemeConverter.desktop 
rm -f ~/.local/share/applications/lightpad.desktop 
rm -f ~/.local/share/applications/logout.desktop 

#Removing Icons
rm -f ~/.local/share/icons/AppStore.png
rm -f ~/.local/share/icons/MacOSBigSurThemeConverterLogo.png
rm -f ~/.local/share/icons/aunchpad.svg

#Removing Network Manager
sudo sed -i '/denyinterfaces wlan0/c\ ' /etc/dhcpcd.conf 
sudo sed -i '/[main]/,/managed=true/d' /etc/NetworkManager/NetworkManager.conf 

#Restoring Default Desktop File For Chromium
sudo sed -i '/Icon/c\Icon=chromium-browser' /usr/share/applications/chromium-browser.desktop

#Refreshing Desktop Session
killall plank xfce4-panel lxpanel openbox &>/dev/null
setsid openbox-lxde-pi --replace &>/dev/null &
setsid pcmanfm --desktop --profile LXDE-pi &>/dev/null &
setsid pcmanfm --reconfigure &>/dev/null &
setsid lxpanel --profile LXDE-pi &>/dev/null &

rm -r ~/MacOSBigSurThemeConverter

echo "Finished Uninstallation :)"
