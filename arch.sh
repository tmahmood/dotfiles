#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
hwclock --systohc
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo $1 > /etc/hostname
pacman -S --noconfirm grub efibootmgr tmux
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S --noconfirm gnome gnome-extra i3 rsync sudo visudo zsh rofi
pacman -S --needed git base-devel

# Need to enable wheel in sudoer file
useradd -m mahmood -G wheel
echo "Please enable sudo in sudoer file"

# change password
passwd mahmood

sudo -u mahmood bash << EOF
mkdir repo
cd repo
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -Y --gendb
yay -S --noconfirm i3-gnome 
yay -S --noconfirm polybar
yay -S --noconfirm dropbox
yay -S --noconfirm intellij-idea-ultimate-edition
yay -S --noconfirm firfox-nightly-bin
EOF

# Just in case, this is a very annoying isse
sudo ln -s /dev/null /etc/udev/rules.d/61-gdm.rules
