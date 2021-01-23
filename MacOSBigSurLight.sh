#!/bin/bash

#killing Lxpanel
killall lxpanel &>/dev/null

#Launching Compton
killall compton &>/dev/null 
nohup compton &>/dev/null &
disown

#Launching Plank
nohup plank &>/dev/null &
disown

#Restarting xfwm4
killall xfwm4 &>/dev/null 
xfwm4 --replace --compositor=off &>/dev/null &

rm ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurLight &>/dev/null
rm ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurDark &>/dev/null

#Changing Wallpaper
pcmanfm --set-wallpaper="/home/$USER/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLightWallpaper.jpg" &>/dev/null &
#Copying Config Files
cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/lxsession ~/.config/    
cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/lxterminal ~/.config/
#Restating Desktop
nohup pcmanfm --desktop --profile LXDE-pi &>/dev/null &
sudo update-icon-caches /usr/share/icons/*
#Copying Ulauncher Configs
cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/ulauncher ~/.config
#Applying Plank Theme
cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/mcOS-BS-White-Stock ~/.local/share/plank/themes/
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme mcOS-BS-White-Stock
#Applying Xfce4-panel configuration
xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLight.tar.bz2
#Applying Xfwm4 Theme
killall xfwm4 
xfwm4 --replace --compositor=off &>/dev/null &
disown
xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-light &>/dev/null
xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
echo " " > ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurLight
xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLight.tar.bz2

nohup xfce4-panel &>/dev/null &
disown
nohup nm-applet &>/dev/null &
disown
nohup blueman-applet &>/dev/null &
disown
nohup pcmanfm --desktop --profile LXDE-pi &>/dev/null &
disown

echo " "
echo "Finished Converting Theme"
exit