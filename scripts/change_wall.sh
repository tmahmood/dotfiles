#!/bin/bash
#

~/bin/bing-wall

find $HOME/Pictures/Wallpapers/ /usr/share/backgrounds $HOME/Pictures/BingWallpaper -type f | shuf -n1 --output ~/tmp/wallpaper.txt 

disp_bk=$DISPLAY
DISPLAY=$(cat /proc/$$/environ | tr '\0' '\n' | grep '^DISPLAY=' | cut -c 9-)
XX=`cat ~/tmp/wallpaper.txt | awk --field-separator '\n' '{print "\x27"$1"\x27"}'`
echo $XX | xargs feh --bg-fill
DISPLAY=$disp_bk
echo $XX
