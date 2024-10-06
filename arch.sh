#!/bin/bash

if [[ -z $1 ]]; then
    echo "Please provide hostname, tmndesk, crossroads"
    exit
fi


ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
hwclock --systohc
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo $1 > /etc/hostname
pacman -S --noconfirm grub efibootmgr tmux
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm gnome gnome-extra i3 rsync sudo visudo zsh rofi
pacman -S --noconfirm --needed git base-devel networkmanager cmake pacman-contrib


useradd -m mahmood -G wheel
passwd mahmood
chsh -s /usr/bin/zsh mahmood
# Need to enable wheel in sudoer file
echo "Please enable sudo in sudoer file, creating the user based install script"

# Just in case, this is a very annoying issue
ln -s /dev/null /etc/udev/rules.d/61-gdm.rules
systemctl enable gdm

sudo -u mahmood cat << EOF > /home/mahmood/setup.sh
mkdir repo
cd repo
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -Y --gendb

git clone https://github.com/tmahmood/dotfiles
ln -sf ~/repo/dotfiles/zshrc ~/.zshrc

alias yaync=yay -S --noconfirm

yaync i3-gnome polybar dropbox jdk-openjdk intellij-idea-ultimate-edition firefox-nightly-bin ttf-martian-mono ttf-maple copyq feh flameshot keepassxc wezterm atuin starship broot task betterlockscreen dunst dex fzf ripgrep gnome-pomodoro syncthing yazi nyxt libreoffice-fresh obsidian jq p7zip ffmpegthumbnailer fd zoxide chafa tmux-plugin-manager ttf-martian-mono-nerd npm tailwindcss

rustup toolchain install nightly

## NEXT

git clone https://github.com/tmahmood/taskwarrior-web
git clone https://github.com/tmahmood/bing-wall-rs

cd taskwarrior-web
cargo build --release
cd ../bing-wall-rs
cargo build --release
cd 

mkdir ~/bin

cat << EOF_IN > /home/mahmood/bin/run_org_me
cd ~/repo/taskwarrior-web/
target/release/taskwarrior-web
EOF_IN

cat << EOF_IN > /home/mahmood/bin/polybar.sh
#!/bin/bash

polybar-msg cmd quit
# Launch bar1 and bar2
polybar main 2>&1 | tee -a /tmp/polybar.log & disown
EOF_IN

chmod +x ~/bin/polybar.sh
chmod +x ~/bin/run_org_me.sh

ln -sf ~/repo/dotfiles/scripts/reboot_needed ~/bin/reboot_needed
ln -sf ~/repo/dotfiles/scripts/change_wall.sh ~/bin/change_wall.sh
ln -sf ~/repo/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/repo/dotfiles/wezterm ~/.config/
ln -sf ~/repo/dotfiles/dunst ~/.config/dunst
ln -sf ~/repo/dotfiles/vim_bundle ~/.vim

vim +'PlugInstall --sync' +qa

if [[ $1 == 'crossroads' ]]; then
    echo 'crossroads'
    ln -sf ~/repo/dotfiles/crossroads/i3 ~/.config/
    ln -sf ~/repo/dotfiles/crossroads/polybar ~/.config/polybar
elif [[ $1 == 'tmndesk' ]]; then
    echo 'tmndesk'
    ln -sf ~/repo/dotfiles/tmahmood/i3 ~/.config/
    ln -sf ~/repo/dotfiles/tmahmood/polybar ~/.config/polybar
fi

EOF
