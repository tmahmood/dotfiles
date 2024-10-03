#!/bin/bash
#
# starts some applications 

. $GLOBALAUTOSTART
gnome-setting-daemon
xcompmgr -c -t-5 -l-5 -r4.2 -o.55 &
