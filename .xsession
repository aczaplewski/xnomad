#!/bin/bash

# Load resources

xrdb -merge .Xresources

# Set up an icon tray
stalonetray &

# Fire up apps

xscreensaver -no-splash &

# Set background image with feh

feh --bg-scale /usr/share/backgrounds/f32/default/f32.png  &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

exec xmonad

