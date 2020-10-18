#!/bin/bash

cd /home/pi/.MacOSBigSurThemeassets/assets
sudo cp -r lxpanel /home/pi/.config/ 
sudo cp -r lxsession /home/pi/.config/
sudo cp -r lxterminal /home/pi/.config/


sudo cp -r /home/pi/.MacOSBigSurThemeassets/assets/autostart /home/pi/.config/
sudo cp chromium-browser.desktop /usr/share/applications/


cd ..


sudo rm /usr/share/plank/themes/Default/dock.theme 
cd /home/pi/.MacOSBigSurThemeassets/MacOS-Mojave-Plank-themes/themes/MacOS-BigSur-Dark
sudo cp dock.theme /usr/share/plank/themes/Default/
cd ..
cd ..
cd ..

sudo cp -r /home/pi/.MacOSBigSurThemeassets/BigSur-Originals-Cursor/ /usr/share/icons/
cd ..


