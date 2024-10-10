#!/bin/bash

RUNTIME=`date +%s`
BK_DIR="~/bk/$RUNTIME"
mkdir $BK_DIR

mkdir repo
cd repo
# Install yay
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -Y --gendb

# get my dotfiles
git clone https://github.com/tmahmood/dotfiles

# fix zsh
ln -sf ~/repo/dotfiles/zshrc ~/.zshrc

# just do installs
alias yaync=yay -S --noconfirm
yaync i3-gnome polybar dropbox jdk-openjdk intellij-idea-ultimate-edition firefox-nightly-bin ttf-martian-mono ttf-maple copyq feh flameshot keepassxc wezterm atuin starship broot task betterlockscreen dunst dex fzf ripgrep gnome-pomodoro syncthing yazi nyxt libreoffice-fresh obsidian jq p7zip ffmpegthumbnailer fd zoxide chafa tmux-plugin-manager ttf-martian-mono-nerd npm tailwindcss

# setup rust
rustup toolchain install nightly

## setup my apps
git clone https://github.com/tmahmood/taskwarrior-web
git clone https://github.com/tmahmood/bing-wall-rs

cd taskwarrior-web
cargo build --release

cd ../bing-wall-rs
cargo build --release

# back to home
cd

# bin dir
mkdir ~/bin
# this is where I will backup already existing scripts

# running programs
cat <<EOF_IN >/home/mahmood/bin/run_org_me
cd ~/repo/taskwarrior-web/
target/release/taskwarrior-web
EOF_IN

# Polybar
cat <<EOF_IN >/home/mahmood/bin/polybar.sh
#!/bin/bash

polybar-msg cmd quit
# Launch bar1 and bar2
polybar main 2>&1 | tee -a /tmp/polybar.log & disown
EOF_IN

# make executable
chmod +x ~/bin/polybar.sh
chmod +x ~/bin/run_org_me.sh

# setup other scripts
ln -sf ~/repo/dotfiles/scripts/reboot_needed ~/bin/reboot_needed
ln -sf ~/repo/dotfiles/scripts/change_wall.sh ~/bin/change_wall.sh

# install configurations
if [[ -f ~/.tmux.conf ]]; then
    echo 'file exists, backing up'
    mv ~/.tmux.conf $BK_DIR
fi
ln -sf ~/repo/dotfiles/tmux/tmux.conf ~/.tmux.conf

if [[ -d ~/.config/wezterm ]]; then
    echo 'file exists, backing up'
    mv ~/.config/wezterm $BK_DIR
fi
ln -sf ~/repo/dotfiles/wezterm ~/.config/
if [[ -d ~/.config/dunst ]]; then
    echo 'file exists, backing up'
    mv ~/.config/dunst $BK_DIR
fi
ln -sf ~/repo/dotfiles/dunst ~/.config/dunst
if [[ -d ~/.vim ]]; then
    echo 'file exists, backing up'
    mv ~/.vim $BK_DIR
fi
ln -sf ~/repo/dotfiles/vim_bundle ~/.vim

vim +'PlugInstall --sync' +qa

if [[ $1 == 'crossroads' ]]; then
  echo 'crossroads'
  ln -sf ~/repo/dotfiles/crossroads/i3 ~/.config/
  ln -sf ~/repo/dotfiles/crossroads/polybar ~/.config/polybar
elif [[ $1 == 'tmndesk' ]]; then
  echo 'tmndesk'
  ln -sf ~/repo/dotfiles/tmndesk/i3 ~/.config/
  ln -sf ~/repo/dotfiles/tmndesk/polybar ~/.config/polybar
fi
