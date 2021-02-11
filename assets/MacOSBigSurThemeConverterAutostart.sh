#!/bin/bash

killall lxpanel compton &>/dev/null 
nohup compton &>/dev/null &
nohup xfwm4 --replace --compositor=off &>/dev/null &
nohup plank &>/dev/null &
nohup xfce4-panel &>/dev/null &
env GDK_BACKEND=x11 /usr/bin/ulauncher --hide-window --hide-window
