#!/bin/bash

#Removing Existing Configs
sudo rm -r ~/.config/lxpanel
sudo rm -r ~/.config/lxterminal
sudo rm -r ~/.config/lxsession
sudo rm -r ~/.config/pcmanfm

#restoring backups
cp -r  ~/.MacOSBigSurThemeassets/.config_backup/lxpanel ~/.config
cp -r  ~/.MacOSBigSurThemeassets/.config_backup/lxsession ~/.config
cp -r  ~/.MacOSBigSurThemeassets/.config_backup/lxterminal ~/.config
cp -r  ~/.MacOSBigSurThemeassets/.config_backup/pcmanfm ~/.config

#Removing autostart shortcuts
sudo rm /home/pi/.config/autostart/compton.desktop
sudo rm /home/pi/.config/autostart/plank.desktop
sudo rm /home/pi/.config/autostart/xfwm4.desktop

#Restoring Default Desktop File For Chromium
sudo cp /home/pi/.MacOSBigSurThemeassets/assets/extra/chromium-browser.desktop /usr/share/applications/

echo "Finished Restoring Config Files.Refreshing desktop session now, but rebooting is recommended."

#Refreshing Desktop Session
killall lxpanel plank xfwm4 &>/dev/null
sudo update-icon-caches /usr/share/icons/*
openbox &>/dev/null &
pcmanfm --desktop --profile LXDE-pi &>/dev/null &
pcmanfm --reconfigure
lxpanel --profile LXDE-pi &>/dev/null &
