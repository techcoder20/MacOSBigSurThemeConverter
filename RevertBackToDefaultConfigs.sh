#!/bin/bash

#Removing Existing Configs
sudo rm -r /home/pi/.config/lxpanel
sudo rm -r /home/pi/.config/lxterminal
sudo rm -r /home/pi/.config/lxsession
#restoring backups
cp -r  ~/.MacOSBigSurThemeassets/.config_backup/lxpanel ~/.config
cp -r  ~/.MacOSBigSurThemeassets/.config_backup/lxsession ~/.config
cp -r  ~/.MacOSBigSurThemeassets/.config_backup/lxterminal ~/.config
pcmanfm --set-wallpaper=/usr/share/rpd-wallpaper/temple.jpg
#Removing autostart shortcuts
sudo rm /home/pi/.config/autostart/compton.desktop
sudo rm /home/pi/.config/autostart/plank.desktop
sudo rm /home/pi/.config/autostart/xfwm4.desktop
#Restoring Default Desktop File For Chromium
sudo cp /home/pi/.MacOSBigSurThemeassets/assets/extra/chromium-browser.desktop /usr/share/applications/
#Refreshing Desktop
sudo update-icon-caches /usr/share/icons/*
sleep 1
openbox --restart &>/dev/null
killall tint2 pcmanfm lxpanel &>/dev/null
rm -r /home/pi/.cache/tint2 &>/dev/null
sleep 5
tint2 &>/dev/null &
sleep 1
lxpanel --profile LXDE-pi &>/dev/null &
sleep 2
openbox --restart &>/dev/null
sleep 1
pcmanfm --desktop --profile LXDE-pi &>/dev/null &
sleep 2

read -n 1 -s -r -p "YOUR SYSTEM WILL REBOOT NOW PRESS ANY KEY"
sudo reboot now