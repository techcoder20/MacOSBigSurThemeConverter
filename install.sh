#!/bin/bash

RED='\033[0;31m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
AQUA='\033[1;34m'
NC='\033[0m' 

clear

echo -e  "${RED}This script is made by RPICoder  "
echo -e  "${RED}Special thanks to Botspot for helping me with the script  "
echo -e  "${RED}This script will make raspberry pi os look similar to MacOSBigSur "
echo -e  "${RED}I am not responsible if anything wrong happens${NC} "
echo -e  "${RED}Please note that I have not made any of the themes or icons${NC} "
echo -e  "${PURPLE}Theme made by vinceliuice "
echo -e  "${PURPLE}Find the theme at https://github.com/vinceliuice/WhiteSur-gtk-theme.git${NC} "
echo -e  "${BLUE}Icons made by yeyushengfan258 "
echo -e  "${BLUE}Find the icons at https://github.com/yeyushengfan258/BigSur-icon-theme.git${NC} "
echo -e  "${GREEN}Cursors and plank theme made by Macintosh98 "
echo -e  "${GREEN}Find the cursors at https://github.com/BigSur-Originals-Cursor.git${NC} "
echo -e  "${AQUA}Plank theme and wallpaper make by FKORPSVART"
echo -e  "${AQUA}Find the plank theme and wallpapers at https://www.pling.com/p/1399398/${NC} "
echo ""
echo ""
echo "1)MacOSBigSurLight"
echo "2)MacOSBigSurDark"
echo "Which Theme Do You Want? [1/2]"
read -r answer
if [ "$answer" == 1 ]; then
    Theme=Light
elif [ "$answer" == 2 ]; then
    Theme=Dark
else
    echo "Thats A Invalid Option: "
fi   

if [ ! -d ~/.MacOSBigSurThemeassets ]; then #Checking if ~/.MacOSBigSurThemeassets directory is created
    mkdir ~/.MacOSBigSurThemeassets
fi

if [ -d ~/.MacOSBigSurThemeassets/.config_backup ];then
  echo -e  "${RED}WARNING! It appears there is already a backup at ~/.MacOSBigSurThemeassets/.config_backup. If you continue, it will be overwritten. Continue? [Y/n] ${NC}"
  read -r answer
  if [ "$answer" == 'n' ];then
    echo "OK, exiting now."
    exit 0
  fi
fi

#Backing up config files
cp -r ~/.config/lxpanel ~/.MacOSBigSurThemeassets/.config_backup
cp -r ~/.config/lxsession ~/.MacOSBigSurThemeassets/.config_backup
cp -r ~/.config/lxterminal ~/.MacOSBigSurThemeassets/.config_backup
cp -r ~/.config/pcmanfm ~/.MacOSBigSurThemeassets/.config_backup

#Backing up converter file to ~/.MacOSBigSurThemeassets
cp ~/MacOSBigSurThemeConverter/install.sh ~/.MacOSBigSurThemeassets/
cp ~/MacOSBigSurThemeConverter/uninstall.sh ~/.MacOSBigSurThemeassets/
cp -r ~/MacOSBigSurThemeConverter/assets ~/.MacOSBigSurThemeassets/


echo "Updating ...."
sudo apt update &>/dev/null
echo "Installing all required packages...."
echo "This may take a while"
sudo apt -y install compton plank xfwm4 xfce4-settings sassc optipng inkscape libcanberra-gtk-module libglib2.0-dev libxml2-utils nautilus  libatk1.0-dev libglib2.0-dev libcairo2-dev libgtk-3-dev libpango1.0-dev libgdk-pixbuf2.0-dev libgee-0.8-dev libglib2.0-dev json-glib-tools libgnome-menu-3-dev libsoup2.4-dev libx11-dev cmake gettext pkg-config gcc make gnome-icon-theme valac-0.26 libjson-glib-dev libpanel-applet-dev libmate-panel-applet-dev yad &>/dev/null   

if [ -d ~/.MacOSBigSurThemeassets/WhiteSur-gtk-theme ]; then  #Checking if the theme from github has already been cloned
    echo "The theme is already downloaded, Installing light theme...."
else #Cloning theme if not downloaded
    echo "Downloading theme"
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git ~/.MacOSBigSurThemeassets/WhiteSur-gtk-theme &>/dev/null
fi

if [ -d  ~/.themes/WhiteSur-dark ] && [ $Theme==Dark ]; then #Checking if the theme is installed
    echo "The dark theme is already installed"
else 
    cd ~/.MacOSBigSurThemeassets/WhiteSur-gtk-theme || exit
    echo "Installing theme ...."
    sudo chmod +x install.sh
    ./install.sh -c dark -o standard -a standard &>/dev/null
fi

if [ -d  ~/.themes/WhiteSur-light ] && [ $Theme==Light ]; then 
    echo "The light theme is already installed"
else 
    cd ~/.MacOSBigSurThemeassets/WhiteSur-gtk-theme || exit
    echo "Installing theme ...."
    sudo chmod +x install.sh
    ./install.sh -c light -o standard -a standard &>/dev/null
fi

if [ -d ~/.MacOSBigSurThemeassets/BigSur-icon-theme ]; then #Checking if the icons from github have already been cloned
    echo "The icon theme is already downloaded, Installing icons...."
else #Cloning the icons if not downloaded
    git clone https://github.com/yeyushengfan258/BigSur-icon-theme.git ~/.MacOSBigSurThemeassets/BigSur-icon-theme &>/dev/null
fi


if [ -d  ~/.local/share/icons/BigSur-dark ]; then #Checking if the icons have been installed
    echo "The icon theme is already installed"
else #Installing icons if not installed
    cd ~/.MacOSBigSurThemeassets/BigSur-icon-theme || exit
    echo "Installing theme ...."
    sudo chmod +x install.sh
    ./install.sh &>/dev/null
fi


if [ -d ~/.MacOSBigSurThemeassets/BigSur-Originals-Cursor ]; then #Checking if the cursor theme has been cloned
    echo "The cursor theme is already downloaded"
else 
    git clone https://github.com/Macintosh98/BigSur-Originals-Cursor.git ~/.MacOSBigSurThemeassets/BigSur-Originals-Cursor &>/dev/null
fi

if [ $Theme == Light ]; then
    pcmanfm --set-wallpaper="/home/pi/.MacOSBigSurThemeassets/assets/MacOSBigSurLight/MacOSBigSurLightWallpaper.jpg"
else
    pcmanfm --set-wallpaper="/home/pi/.MacOSBigSurThemeassets/assets/MacOSBigSurDark/MacOSBigSurDarkWallpaper.jpg"
fi

echo "Installing Lightpad...."
sudo rm -r lightpad_0.0.8.rev1_armhf.deb &>/dev/null
wget https://github.com/libredeb/lightpad/releases/download/v0.0.8/lightpad_0.0.8.rev1_armhf.deb -P ~/.MacOSBigSurThemeassets &>/dev/null
sudo dpkg -i ~/.MacOSBigSurThemeassets/lightpad_0.0.8.rev1_armhf.deb &>/dev/null
sudo apt -y --fix-broken install &>/dev/null

echo "Installing Panther Launcher...."
git clone https://github.com/phoenixbyrd/panther_launcher.git ~/.MacOSBigSurThemeassets/panther_launcher &>/dev/null
cd ~/.MacOSBigSurThemeassets/panther_launcher || exit
mkdir install &>/dev/null
cd install || exit
cmake .. -DCMAKE_INSTALL_PREFIX=/usr &>/dev/null
make &>/dev/null
sudo make install &>/dev/null

#Installing Pi-Apps
cd 
sudo rm -r ~/pi-apps
git clone https://github.com/Botspot/pi-apps &>/dev/null
~/pi-apps/install &>/dev/null
cp ~/.MacOSBigSurThemeassets/assets/Pi-Apps.desktop ~/.local/share/applications/


#Copying Config Files
if [ $Theme == Light ]; then
    cp -r ~/.MacOSBigSurThemeassets/assets/MacOSBigSurLight/lxpanel /home/pi/.config/ 
    cp -r ~/.MacOSBigSurThemeassets/assets/MacOSBigSurLight/lxsession /home/pi/.config/    
    cp -r ~/.MacOSBigSurThemeassets/assets/MacOSBigSurLight/lxterminal /home/pi/.config/
else
    cp -r ~/.MacOSBigSurThemeassets/assets/MacOSBigSurDark/lxpanel /home/pi/.config/ 
    cp -r ~/.MacOSBigSurThemeassets/assets/MacOSBigSurDark/lxsession /home/pi/.config/
    cp -r ~/.MacOSBigSurThemeassets/assets/MacOSBigSurDark/lxterminal /home/pi/.config/
fi

cp -r ~/.MacOSBigSurThemeassets/assets/autostart /home/pi/.config/

#Replacing Chromium Desktop File
sudo cp ~/.MacOSBigSurThemeassets/assets/chromium-browser.desktop /usr/share/applications/


#Copying Plank Theme
if [ $Theme == Light ]; then
    sudo cp -r /home/pi/.MacOSBigSurThemeassets/assets/MacOSBigSurLight/mcOS-BS-White-Stock /usr/share/plank/themes/
else
    sudo cp -r /home/pi/.MacOSBigSurThemeassets/assets/MacOSBigSurDark/mcOS-BS-Black-Stock /usr/share/plank/themes/
fi

#Copying Plank apps
sudo rm -r ~/.config/plank
cp -r /home/pi/.MacOSBigSurThemeassets/assets/plank ~/.config

#Copying Icon Theme
sudo cp -r /home/pi/.MacOSBigSurThemeassets/BigSur-Originals-Cursor/ /usr/share/icons/

cp ~/.MacOSBigSurThemeassets/assets/lightpad.desktop ~/.local/share/applications/
cp ~/.MacOSBigSurThemeassets/assets/logout.desktop ~/.local/share/applications/
cp ~/.MacOSBigSurThemeassets/assets/panther_launcher.desktop ~/.local/share/applications/


echo "Installation complete. Refreshing desktop session now, but rebooting is recommended."

#Refreshing Desktop Session
sudo update-icon-caches /usr/share/icons/*
killall compton pcmanfm lxpanel plank &>/dev/null
lxpanel --profile LXDE-pi &>/dev/null &
pcmanfm --desktop --profile LXDE-pi &>/dev/null &
compton &>/dev/null &
xfwm4 --replace --compositor=off &>/dev/null &
xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-dark
plank &>/dev/null &
if [ $Theme == Light ]; then
    gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme mcOS-BS-White-Stock
    xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-light
    xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-light
else
    gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ theme mcOS-BS-Black-Stock
    xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-dark
    xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-dark
fi

xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
