#!/bin/bash

killall lxpanel compton &>/dev/null 
nohup compton &>/dev/null &
nohup xfwm4 --replace --compositor=off &>/dev/null &
nohup plank &>/dev/null &
nohup xfce4-panel &>/dev/null &

if [ -f ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurLight ]; then
    pcmanfm --set-wallpaper="/home/pi/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLightWallpaper.jpg" &>/dev/null &
    xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurLight.tar.bz2
    xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-light &>/dev/null
    xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
elif [ -f ~/.local/share/MacOSBigSurThemeConverter/assets/.MacOSBigSurDark ]; then
    pcmanfm --set-wallpaper="/home/pi/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/MacOSBigSurDarkWallpaper.jpg" &>/dev/null &
    xfce4-panel-profiles load ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/MacOSBigSurDark.tar.bz2
    xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-dark &>/dev/null
    xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
fi
