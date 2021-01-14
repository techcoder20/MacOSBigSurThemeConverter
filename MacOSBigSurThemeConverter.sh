#!/bin/bash

clear
echo "What Do You Want To Do ?"
echo "1)Convert RPi OS To MacOSBigSurLight"
echo "2)Convert RPi OS To MacOSBigSurDark"
echo "3)Uninstall MacOSBigSurThemeConverter :("
echo -n "Choose One Of The Above Options [1/2/3] "
read -r answer
if [ "$answer" == 1 ]; then
    Theme=Light
elif [ "$answer" == 2 ]; then
    Theme=Dark
elif [ "$answer" == 3 ]; then
    sudo chmod +x ~/.local/share/MacOSBigSurThemeConverter/uninstall.sh
    ~/.local/share/MacOSBigSurThemeConverter/uninstall.sh
else
    echo "Thats A Invalid Option: "
    exit 1
fi 

#killing Lxpanel
killall lxpanel &>/dev/null

#Launching Compton
killall compton &>/dev/null 
nohup compton &>/dev/null &

#Launching Xfce4-panel
xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/MacOSBigSurDark.tar.bz2
nohup xfce4-panel &>/dev/null &

#Launching Plank
nohup plank &>/dev/null &

#Restarting xfwm4
killall xfwm4 &>/dev/null 
xfwm4 --replace --compositor=off &>/dev/null &

rm ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurLight &>/dev/null
rm ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurDark &>/dev/null

if [ $Theme == Light ]; then
    #Changing Wallpaper
    pcmanfm --set-wallpaper="/home/pi/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLightWallpaper.jpg" &>/dev/null &
    #Copying Config Files
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/lxsession /home/pi/.config/    
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/lxterminal /home/pi/.config/
    #Restating Desktop
    nohup pcmanfm --desktop --profile LXDE-pi &>/dev/null &
    sudo update-icon-caches /usr/share/icons/*
    #Changing Wallpaper
    pcmanfm --set-wallpaper="/home/pi/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLightWallpaper.jpg" &>/dev/null &
    #Copying Ulauncher Configs
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/ulauncher ~/.config
    #Applying Plank Theme
    cp -r /home/pi/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/mcOS-BS-White-Stock ~/.local/share/plank/themes/
    gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme mcOS-BS-White-Stock
    #Applying Xfce4-panel configuration
    nohup xfce4-panel &>/dev/null &
    xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLight.tar.bz2
    #Applying Xfwm4 Theme
    killall xfwm4 
    xfwm4 --replace --compositor=off &>/dev/null &
    xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-light &>/dev/null
    xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
    echo " " > ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurLight
    xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLight.tar.bz2
else
    #Copying Config Files
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/lxsession /home/pi/.config/
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/lxterminal /home/pi/.config/
    #Refreshing Desktop
    nohup pcmanfm --desktop --profile LXDE-pi &>/dev/null &
    sudo update-icon-caches /usr/share/icons/*
    #Changing Wallpaper
    pcmanfm --set-wallpaper="/home/pi/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/MacOSBigSurDarkWallpaper.jpg" &>/dev/null &
    #Copying Ulauncher Configs
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/ulauncher ~/.config
    #Applying Plank Theme
    cp -r /home/pi/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/mcOS-BS-Black-Stock ~/.local/share/plank/themes/
    gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme mcOS-BS-Black-Stock
    #Applying Xfce4-panel configuration
    nohup xfce4-panel &>/dev/null &
    xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/MacOSBigSurDark.tar.bz2
    #Applying Xfwm4 Theme
    xfwm4 --replace --compositor=off &>/dev/null &
    xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-dark &>/dev/null
    xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
    echo " " > ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurDark
    xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/MacOSBigSurDark.tar.bz2
fi

nm-applet &>/dev/null &
blueman-applet &>/dev/null &
nohup pcmanfm --desktop --profile LXDE-pi &>/dev/null &

echo " "
echo "Finished Converting Theme. This Window Will Close In 10 Seconds"
sleep 10
exit
