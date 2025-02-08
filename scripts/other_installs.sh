# just do installs
alias yaync="yay -S --noconfirm"

yaync gnome gnome-extra rsync sudo visudo zsh rofi gvim neovim lazygit sshfs polybar dropbox jdk-openjdk intellij-idea-ultimate-edition firefox-nightly-bin ttf-martian-mono ttf-maple copyq feh flameshot keepassxc wezterm atuin starship broot task dunst dex fzf ripgrep gnome-pomodoro syncthing yazi nyxt libreoffice-fresh obsidian jq p7zip ffmpegthumbnailer fd zoxide chafa tmux-plugin-manager ttf-martian-mono-nerd npm tailwindcss htop redshift signal-desktop pacman-contrib gnome-browser-connector network-manager-applet shellcheck bat otf-departure-mono

# enable multilib support
#
echo <<EOL
[multilib]
Include = /etc/pacman.d/mirrorlist
EOL


yay -S i3  i3-gnome
yay -S xss-lock betterlockscreen 
