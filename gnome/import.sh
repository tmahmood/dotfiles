#!/bin/bash
#
# export gnome settings


dconf load /org/gnome/settings-daemon/plugins/media-keys/ < keybindings.txt
dconf load /org/gnome/mutter/keybindings/ < mutter-keybindings.txt
dconf load /org/gnome/shell/keybindings/ < shell-keybindings.txt
dconf load /org/gnome/desktop/wm/keybindings/ < wm-keybindings.txt
