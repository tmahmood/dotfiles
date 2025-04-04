#!/bin/bash
#
# export gnome settings


dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > keybindings.txt
dconf dump /org/gnome/mutter/keybindings/ > mutter-keybindings.txt
dconf dump /org/gnome/shell/keybindings/ > shell-keybindings.txt
dconf dump /org/gnome/desktop/wm/keybindings/ > wm-keybindings.txt
