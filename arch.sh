#!/bin/bash

if [[ -z $1 ]]; then
  echo "Please provide hostname, tmndesk, crossroads"
  exit
fi

ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
hwclock --systohc
locale-gen
echo LANG=en_US.UTF-8 >/etc/locale.conf
echo $1 >/etc/hostname
pacman -S --noconfirm grub efibootmgr tmux
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm --needed git base-devel networkmanager cmake pacman-contrib reflector
pacman -S --noconfirm gnome gnome-extra i3 rsync sudo visudo zsh rofi neovim lazygit

systemctl enable reflector.service
systemctl enable sshd.service
reflector --latest 15 --sort rate --save /etc/pacman.d/mirrorlist

useradd -m mahmood -G wheel
passwd mahmood
chsh -s /usr/bin/zsh mahmood
# Need to enable wheel in sudoer file
echo "Enabling sudo access, take note if it worked or not"
echo '%wheel ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
ln -s /dev/null /etc/udev/rules.d/61-gdm.rules
systemctl enable gdm

echo "Trying to fetch the latest user script and run"
cd /home/mahmood
sudo -u mahmood curl -sLO https://github.com/tmahmood/dotfiles/tree/main/crossroads/user_setup.sh
sudo -u mahmood sh user_setup.sh
