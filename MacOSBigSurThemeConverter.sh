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
printf "${GREEN}Find the cursors at https://github.com/Macintosh98/MacOS-Mojave-Plank-themes.git${NC}\n"
printf "${GREEN}Find the plank theme at https://github.com/Macintosh98/MacOS-Mojave-Plank-themes.git${NC}\n"

read -n 1 -s -r -p "PRESS ANY BUTTON TO CONTINUE: "
echo " "

echo "Updating ...."
sudo apt update

echo "Installing all required packages"
sudo apt -y install compton plank xfwm4 xfce4-settings gtk2-engines-murrine gtk2-engines-pixbuf sassc optipng inkscape libcanberra-gtk-module libglib2.0-dev libxml2-utils appmenu-gtk2-module appmenu-gtk3-module nautilus    

if [ ! -d /home/pi/.MacOSBigSurThemeassets ]; then 
    mkdir /home/pi/.MacOSBigSurThemeassets
fi


cp ConfigCopy.sh /home/pi/.MacOSBigSurThemeassets/
cp MacOSBigSurThemeConverter.sh /home/pi/.MacOSBigSurThemeassets/
cp RevertBackToDefaultConfigs.sh /home/pi/.MacOSBigSurThemeassets/
cp -r assets /home/pi/.MacOSBigSurThemeassets/




if [ -d /home/pi/.MacOSBigSurThemeassets/WhiteSur-gtk-theme ]; then  #Checking if the theme from github has already been cloned
    echo "The theme is already downloaded ,installing themes"
else #Cloning theme if not downloaded
    echo "Downloading theme"
    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git /home/pi/.MacOSBigSurThemeassets/WhiteSur-gtk-theme
fi


if [ -d  /home/pi/.themes/WhiteSur-dark-solid ]; then #Checking if the theme is installed
    echo "The theme is already installed"
else #Installing themes if not installed
    cd /home/pi/.MacOSBigSurThemeassets/WhiteSur-gtk-theme
    echo "Installing theme ...."
    sudo chmod +x install.sh
    ./install.sh
fi



if [ -d /home/pi/.MacOSBigSurThemeassets/BigSur-icon-theme ]; then #Checking if the icons from github have already been cloned
    echo "The icon theme is already downloaded"
else #Cloning the icons if not downloaded
    git clone https://github.com/yeyushengfan258/BigSur-icon-theme.git /home/pi/.MacOSBigSurThemeassets/BigSur-icon-theme

fi

if [ -d  /home/pi/.local/share/icons/BigSur-dark ]; then #Checking if the icons have been installed
    echo "The icon theme is already installed"
else #Installing icons if not installed
    cd /home/pi/.MacOSBigSurThemeassets/BigSur-icon-theme
    echo "Installing theme ...."
    sudo chmod +x install.sh
    ./install.sh
fi



if [ -d /home/pi/.MacOSBigSurThemeassets/MacOS-Mojave-Plank-themes ]; then 
    echo "The plank theme is already installed"
else 
    git clone https://github.com/Macintosh98/MacOS-Mojave-Plank-themes.git /home/pi/.MacOSBigSurThemeassets/MacOS-Mojave-Plank-themes
fi


if [ -d /home/pi/.MacOSBigSurThemeassets/BigSur-Originals-Cursor ]; then 
    echo "The cursor theme is already downloaded"
else 
    git clone https://github.com/Macintosh98/BigSur-Originals-Cursor.git /home/pi/.MacOSBigSurThemeassets/BigSur-Originals-Cursor
fi


if [ -f /home/pi/.MacOSBigSurThemeassets/WhiteSur.png ]; then 
    echo "The wallpaper is already downloaded"
else 
    cd /home/pi/.MacOSBigSurThemeassets/
    wget https://raw.githubusercontent.com/vinceliuice/WhiteSur-kde/master/wallpaper/WhiteSur.png
fi


pcmanfm --set-wallpaper="/home/pi/.MacOSBigSurThemeassets/WhiteSur.png"


cd /home/pi/.MacOSBigSurThemeassets
./ConfigCopy.sh




echo ""
read -n 1 -s -r -p "YOUR SYSTEM WILL REBOOT NOW PRESS ANY BUTTON: "
sudo reboot now

