#!/bin/bash

RED='\033[0;31m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
NC='\033[0m' 
printf "${RED}This script is made by techcoder20\n"
printf "${RED}I am not responsible if anything wrong happens${NC}\n"
printf "${RED}This script will make raspberry pi os look similar to MacOSBigSur\n"
printf "${RED}Please note that I have not made any of the themes or icons${NC}\n"
printf "${PURPLE}Theme and wallpaper made by vinceliuice\n"
printf "${PURPLE}Find the theme at https://github.com/vinceliuice/WhiteSur-gtk-theme.git\n"
printf "${PURPLE}Find the Wallpaper at https://raw.githubusercontent.com/vinceliuice/WhiteSur-kde/master/wallpaper/WhiteSur.png${NC}\n"
printf "${BLUE}Icons made by yeyushengfan258\n"
printf "${BLUE}Find the icons at https://github.com/yeyushengfan258/BigSur-icon-theme.git${NC}\n"
printf "${GREEN}Cursors and plank theme made by Macintosh98\n"
printf "${GREEN}Find the cursors at https://github.com/BigSur-Originals-Cursor.git${NC}\n"
printf "${GREEN}Find the plank theme at https://github.com/Macintosh98/MacOS-Mojave-Plank-themes.git${NC}\n"

read -n 1 -s -r -p "PRESS ANY BUTTON TO CONTINUE: "
echo " "

echo "Updating ...."
sudo apt update

echo "Installing all required packages"
sudo apt -y install compton plank xfwm4 xfce4-settings sassc optipng inkscape libcanberra-gtk-module libglib2.0-dev libxml2-utils nautilus  

if [ ! -d ~/.MacOSBigSurThemeassets ]; then #Checking if ~/.MacOSBigSurThemeassets directory is created
    mkdir ~/.MacOSBigSurThemeassets
fi

if [ ! -d ~/.MacOSBigSurThemeassets/.config_backup]; then
    mkdir ~/.MacOSBigSurThemeassets/.config_backup
fi

#Backing up config files
cp -r ~/.config/lxpanel ~/.MacOSBigSurThemeassets/.config_backup
cp -r ~/.config/lxsession ~/.MacOSBigSurThemeassets/.config_backup
cp -r ~/.config/lxterminal ~/.MacOSBigSurThemeassets/.config_backup


#Backing up converter file to ~/.MacOSBigSurThemeassets
cp ConfigCopy.sh ~/.MacOSBigSurThemeassets/
cp MacOSBigSurThemeConverter.sh ~/.MacOSBigSurThemeassets/
cp RevertBackToDefaultConfigs.sh ~/.MacOSBigSurThemeassets/
cp -r assets ~/.MacOSBigSurThemeassets/


if [ -d ~/.MacOSBigSurThemeassets/WhiteSur-gtk-theme ]; then  #Checking if the theme from github has already been cloned
    echo "The theme is already downloaded ,installing themes"
else #Cloning theme if not downloaded
    echo "Downloading theme"
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git ~/.MacOSBigSurThemeassets/WhiteSur-gtk-theme
fi


if [ -d  ~/.themes/WhiteSur-dark-solid ]; then #Checking if the theme is installed
    echo "The theme is already installed"
else #Installing themes if not installed
    cd ~/.MacOSBigSurThemeassets/WhiteSur-gtk-theme
    echo "Installing theme ...."
    sudo chmod +x install.sh
    ./install.sh -c dark -o standard -a standard
fi


if [ -d ~/.MacOSBigSurThemeassets/BigSur-icon-theme ]; then #Checking if the icons from github have already been cloned
    echo "The icon theme is already downloaded"
else #Cloning the icons if not downloaded
    git clone https://github.com/yeyushengfan258/BigSur-icon-theme.git ~/.MacOSBigSurThemeassets/BigSur-icon-theme
fi


if [ -d  ~/.local/share/icons/BigSur-dark ]; then #Checking if the icons have been installed
    echo "The icon theme is already installed"
else #Installing icons if not installed
    cd ~/.MacOSBigSurThemeassets/BigSur-icon-theme
    echo "Installing theme ...."
    sudo chmod +x install.sh
    ./install.sh
fi


if [ -d ~/.MacOSBigSurThemeassets/MacOS-Mojave-Plank-themes ]; then #Checking if the plank theme has been cloned
    echo "The plank theme is already installed"
else 
    git clone https://github.com/Macintosh98/MacOS-Mojave-Plank-themes.git ~/.MacOSBigSurThemeassets/MacOS-Mojave-Plank-themes
fi


if [ -d ~/.MacOSBigSurThemeassets/BigSur-Originals-Cursor ]; then #Checking if the cursor theme has been cloned
    echo "The cursor theme is already downloaded"
else 
    git clone https://github.com/Macintosh98/BigSur-Originals-Cursor.git ~/.MacOSBigSurThemeassets/BigSur-Originals-Cursor
fi


if [ -f ~/.MacOSBigSurThemeassets/WhiteSur.png ]; then 
    echo "The wallpaper is already downloaded"
else 
    cd ~/.MacOSBigSurThemeassets/
    wget https://raw.githubusercontent.com/vinceliuice/WhiteSur-kde/master/wallpaper/WhiteSur.png
fi


pcmanfm --set-wallpaper="/home/pi/.MacOSBigSurThemeassets/WhiteSur.png"


cd ~/.MacOSBigSurThemeassets

#Copying Config Files
sudo cp -r ~/.MacOSBigSurThemeassets/assets/lxpanel /home/pi/.config/ 
sudo cp -r ~/.MacOSBigSurThemeassets/assets/lxsession /home/pi/.config/
sudo cp -r ~/.MacOSBigSurThemeassets/assets/lxterminal /home/pi/.config/
sudo cp -r ~/.MacOSBigSurThemeassets/assets/autostart /home/pi/.config/

#Replacing Chromium Desktop File
sudo cp ~/.MacOSBigSurThemeassets/assets/chromium-browser.desktop /usr/share/applications/

#Removing Default Plank Theme
sudo rm /usr/share/plank/themes/Default/dock.theme 

#Copying Plank Theme
sudo cp /home/pi/.MacOSBigSurThemeassets/MacOS-Mojave-Plank-themes/themes/MacOS-BigSur-Dark/dock.theme /usr/share/plank/themes/Default/

#Copying Icon Theme
sudo cp -r /home/pi/.MacOSBigSurThemeassets/BigSur-Originals-Cursor/ /usr/share/icons/

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
xfwm4 --replace &>/dev/null &
xfconf-query -c xfwm4 -p /general/theme -s WhiteSur-dark
sleep 2
plank &>/dev/null &
sleep 2
compton &>/dev/null &
sleep 2

echo ""
echo "YOU COULD EITHER CONTINUE USING YOUR DESKTOP OR REBOOT. CLICK ALT + F4 TO CONTINUE USING YOUR DESKTOP. IT IS RECOMMENDED TO REBOOT"
read -n 1 -s -r -p "YOUR SYSTEM WILL REBOOT NOW PRESS ANY BUTTON: "
sudo reboot now

