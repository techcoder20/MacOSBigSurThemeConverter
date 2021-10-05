#!/bin/bash

RED='\033[0;31m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
AQUA='\033[1;34m'
NC='\033[0m' 

#Clearing Terminal Screen
clear

#Printing Credits
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
read -n 1 -s -r -p "Press any key to continue"
echo ""

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

#Checking if ~/.local/share/MacOSBigSurThemeConverter directory is created
if [ ! -d ~/.local/share/MacOSBigSurThemeConverter ]; then 
    mkdir ~/.local/share/MacOSBigSurThemeConverter
fi

#Checking if ~/.local/share/MacOSBigSurThemeConverter/.config_backup directory is created
if [ -d ~/.local/share/MacOSBigSurThemeConverter/.config_backup ];then
  echo -e -n  "${RED}WARNING! It appears there is already a backup at ~/.local/share/MacOSBigSurThemeConverter/.config_backup. Do you want to overwrite ? [Y/n] ${NC}"
  read -r answer
  if [ "$answer" == 'n' ];then
    echo "OK, Not Going to overwrite :)"
    exit
  fi
fi
    

#Backing up config files
mkdir ~/.local/share/MacOSBigSurThemeConverter/.config_backup
cp -r ~/.config/lxpanel ~/.local/share/MacOSBigSurThemeConverter/.config_backup
cp -r ~/.config/lxsession ~/.local/share/MacOSBigSurThemeConverter/.config_backup
cp -r ~/.config/lxterminal ~/.local/share/MacOSBigSurThemeConverter/.config_backup
cp -r ~/.config/pcmanfm ~/.local/share/MacOSBigSurThemeConverter/.config_backup

#Copying All converter files to ~/.local/share/MacOSBigSurThemeConverter Directory
cp -r ~/MacOSBigSurThemeConverter/* ~/.local/share/MacOSBigSurThemeConverter || error "Unable to copy converter files to ~/.local/share/MacOSBigSurThemeConverter"

#Updating apt Packages
sudo apt update || error "Failed to update apt packages"

#Installing Dependencies
sudo apt -y install compton plank xfwm4 xfce4-settings nautilus yad xfce4-panel xfce4-appmenu-plugin xfce4-statusnotifier-plugin xfce4-pulseaudio-plugin blueman figlet lolcat python3-pil python3-pil.imagetk || error "Failed to install dependencies"

#Installing Gtk Theme
if [ -d  ~/.themes/WhiteSur-dark ] && [ -d  ~/.themes/WhiteSur-light ]; then #Checking if the theme is installed
    figlet "The themes are already installed" | lolcat
else
    figlet "Installing themes...." | lolcat
    mkdir ~/.themes
    echo "Installing light theme"
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/WhiteSur-light ~/.themes || error "Failed to copy WhiteSur-light theme"
    echo "Installing dark theme"
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/WhiteSur-dark ~/.themes || error "Failed to copy WhiteSur-Dark theme"
fi

#Installing Icons
if [ -d  ~/.local/share/icons/BigSur-dark ] && [-d ~/.local/share/icons/BigSur ]; then 
    figlet "The Icon Theme Is Alredy Installed" | lolcat
else 
    mkdir ~/.local/share/icons
    echo "Installing BigSur Icon Theme"
    mkdir ~/.local/share/icons/BigSur
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurLight/BigSur/* ~/.local/share/icons/BigSur
    echo "Installing BigSur-dark Icon Theme"
    mkdir ~/.local/share/icons/BigSur-dark
    cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurDark/BigSur-dark/* ~/.local/share/icons/BigSur-dark 
fi

#Installing Cursors
if [ -d ~/.local/share/MacOSBigSurThemeConverter/BigSur-Originals-Cursor ]; then 
    figlet "The cursor theme is already downloaded" | lolcat
else 
    figlet "Installing Cursors...." | lolcat
    git clone https://github.com/Macintosh98/BigSur-Originals-Cursor.git ~/.local/share/MacOSBigSurThemeConverter/BigSur-Originals-Cursor || error "Failed to clone cursors from github"
    sudo cp -r ~/.local/share/MacOSBigSurThemeConverter/BigSur-Originals-Cursor/ /usr/share/icons/
fi

#Installing Ulauncher
if command -v ulauncher &> /dev/null
then
    figlet "ULauncher Is Already Installed" | lolcat
else
    figlet "Installing Ulauncher...." | lolcat
    sudo rm ~/.local/share/MacOSBigSurThemeConverter/ulauncher_5.9.0_all.deb
    wget https://github.com/Ulauncher/Ulauncher/releases/download/5.9.0/ulauncher_5.9.0_all.deb -P ~/.local/share/MacOSBigSurThemeConverter/  || error "Failed to download deb file for ulauncher"
    sudo dpkg -i ~/.local/share/MacOSBigSurThemeConverter/ulauncher_5.9.0_all.deb 
    sudo apt -y --fix-broken install
fi

#Installing Lightpad
if command -v com.github.libredeb.lightpad &> /dev/null
then
    figlet "Lightpad Is Already Installed" | lolcat
else
    figlet "Installing Lightpad...." | lolcat
    sudo rm ~/.local/share/MacOSBigSurThemeConverter/lightpad_0.0.8.rev1_armhf.deb 
    wget https://github.com/libredeb/lightpad/releases/download/v0.0.8/lightpad_0.0.8.rev1_armhf.deb -P ~/.local/share/MacOSBigSurThemeConverter || error "Failed to download deb file for lightpad"
    sudo dpkg -i ~/.local/share/MacOSBigSurThemeConverter/lightpad_0.0.8.rev1_armhf.deb 
    sudo apt -y --fix-broken install 
fi

#Installing Panther Launcher
sudo apt -y install libatk1.0-dev libglib2.0-dev libcairo2-dev libgtk-3-dev libpango1.0-dev libgdk-pixbuf2.0-dev libgee-0.8-dev libglib2.0-dev json-glib-tools libgnome-menu-3-dev libsoup2.4-dev libx11-dev cmake gettext pkg-config gcc make gnome-icon-theme valac-0.26 libjson-glib-dev libpanel-applet-dev libmate-panel-applet-dev
if command -v panther_launcher &> /dev/null
then
    figlet "Panther Launcher Is Already Installed" | lolcat
else
    figlet "Installing Panther Launcher...." | lolcat
    sudo dpkg -i ~/.local/share/MacOSBigSurThemeConverter/assets/panther-launcher_armhf.deb
    sudo apt -y --fix-broken install
fi

#Installing xfce4-panel-profiles
if command -v xfce4-panel-profiles &> /dev/null
then
    figlet "Xfce4-panel-profiles Is Already Installed" | lolcat
else
    figlet "Installing Xfce4-panel-profiles...." | lolcat
    sudo dpkg -i ~/.local/share/MacOSBigSurThemeConverter/assets/xfce4-panel-profiles_armhf.deb
    sudo apt -y --fix-broken install
fi

#Installing Pi-Apps
if [ -d ~/pi-apps ]; then
    figlet "Pi Apps Is Already Installed" | lolcat
else
    figlet "Installing Pi Apps...." | lolcat
    git clone https://github.com/Botspot/pi-apps ~/pi-apps

    #Creating Pi Apps Desktop entry
    echo "[Desktop Entry]
    Name=Pi-Apps
    Comment=Simple RPI App Store for projects not in the repositories 
    Exec=/home/$USER/pi-apps/gui
    Icon=AppStore
    Terminal=false
    Type=Application
    Categories=Utility;" ~/.local/share/applications/Pi-Apps.desktop

    mkdir -p ~/.config/autostart
    #Creating Pi Apps Startup Desktop entry
    echo "[Desktop Entry]
    Name=Pi Apps Updater
    Exec=${DIRECTORY}/updater onboot
    Icon=${DIRECTORY}/icons/logo.png
    Terminal=false
    Type=Application
    X-GNOME-Autostart-enabled=true
    Hidden=false
    NoDisplay=false" > ~/.config/autostart/pi-apps-updater.desktop
fi

#Setting Up Network Manager
sudo apt -y install network-manager network-manager-gnome 

sudo systemctl enable network-manager &>/dev/null

sudo sed -i '/denyinterfaces wlan0/c\ ' /etc/dhcpcd.conf 
echo "denyinterfaces wlan0" | sudo tee -a /etc/dhcpcd.conf &>/dev/null

sudo sed -i '/[main]/,/managed=true/d' /etc/NetworkManager/NetworkManager.conf 
echo '''
[main]
plugins=ifupdown,keyfile
dhcp=internal

[ifupdown]
managed=true''' | sudo tee -a /etc/NetworkManager/NetworkManager.conf &>/dev/null

#Copying MacOSBigSurThemeConverterAutostart to ~/.config/autostart
mkdir ~/.config/autostart &>/dev/null

#Creating autostart desktop file
echo "[Desktop Entry]
Type=Application
Terminal=false
Exec=/home/$USER/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurThemeConverterAutostart.sh
Name=MacOSBigSurThemeConverterAutostart
Icon=MacOSBigSurThemeConverterLogo" >> ~/.config/autostart/MacOSBigSurThemeConverterAutostart.desktop 

#Creating Lightpad dekstop file
echo "[Desktop Entry]
Type=Application
Terminal=false
Exec=com.github.libredeb.lightpad
Name=lightpad
Icon=launchpad
Categories=Utility;" >> ~/.local/share/applications/lightpad.desktop

#Creating logout desktop file
if command -v sudo raspi-config &> /dev/null #Checking if the os is Raspberry Pi OS
then
    #Using lxde-pi-logout-helper if using Raspberry Pi OS
    echo "[Desktop Entry]
    Type=Application
    Terminal=false
    Exec=lxde-pi-shutdown-helper
    Name=logout
    Icon=system-shutdown
    Categories=System;" >> ~/.local/share/applications/logout.desktop
else
    #Using lxde-logout if its not Raspberry Pi OS
    echo "[Desktop Entry]
    Type=Application
    Terminal=false
    Exec=lxde-logout
    Name=logout
    Icon=system-shutdown
    Categories=System;" >> ~/.local/share/applications/logout.desktop
fi

#Creating panther_launcher desktop file
echo "[Desktop Entry]
Type=Application
Terminal=false
Exec=panther_launcher
Name=panther_launcher
Icon=start-here" >> ~/.local/share/applications/panther_launcher.desktop

#Changing Chromium Icon
sudo sed -i '/Icon/c\Icon=dillo' /usr/share/applications/chromium-browser.desktop

#Copying All Required Icons
cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/Icons/* ~/.local/share/icons/

#Copying All Desktop Files
cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/DesktopFiles/* ~/.local/share/applications

#Copying binary for themeconverter
sudo cp ~/.local/share/MacOSBigSurThemeConverter/assets/themeconverter /usr/local/bin/ 
sudo chmod +x /usr/local/bin/themeconverter

#Copying Plank apps
sudo rm -r ~/.config/plank
cp -r ~/.local/share/MacOSBigSurThemeConverter/assets/plank ~/.config

sudo chmod +x ~/.local/share/MacOSBigSurThemeConverter/uninstall.sh
sudo chmod +x ~/.local/share/MacOSBigSurThemeConverter/MacOSBigSurThemeConverter.sh
sudo chmod +x ~/.local/share/MacOSBigSurThemeConverter/assets/MacOSBigSurThemeConverterAutostart.sh
sudo chmod +x ~/.local/share/MacOSBigSurThemeConverter/gui.py

themeconverter

echo "[Desktop Entry]
Type=Application
Terminal=false
Exec=themeconverter
Name=ThemeConverter
Icon=MacOSBigSurThemeConverterLogo
Categories=Utility;" >> ~/.local/share/applications/ThemeConverter.desktop

echo -e "${GREEN}Installation Over"
echo -e "${GREEN}Open the Theme Converter app whenever you want to change your theme"
echo -e "${GREEN}To run: Menu -> Accessories -> ThemeConverter"
echo -e "${GREEN}To run in a terminal: themeconverter${NC}"

