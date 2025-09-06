#!/bin/bash
#

~/bin/bing-wall

find $HOME/Pictures/Wallpapers/ /usr/share/backgrounds $HOME/Pictures/BingWallpaper -type f | shuf -n1 --output ~/tmp/wallpaper.txt 

disp_bk=$DISPLAY
USR_DISPLAY=$(cat /proc/$$/environ | tr '\0' '\n' | grep '^DISPLAY=' | cut -c 9-)
XX=$(awk --field-separator '\n' '{print "\x27"$1"\x27"}' ~/tmp/wallpaper.txt)
echo "$XX" | DISPLAY="$USR_DISPLAY" xargs betterlockscreen -u
echo "$XX" | DISPLAY="$USR_DISPLAY" xargs feh --bg-fill
DISPLAY=$disp_bk
echo "$XX"
# generates the color
# wal -s -t -n -i "$XX"
