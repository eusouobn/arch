#!/bin/bash

mount /dev/sda1 /boot/efi

pacman -S nano pacman-contrib btrfs-progs --noconfirm

curl -s "https://archlinux.org/mirrorlist/?country=FR&country=GB&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -

pacman -S networkmanager intel-ucode grub efibootmgr

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

hwclock --systohc

mv /etc/locale.gen /etc/locale.gen.bak

echo -e 'pt_BR.UTF-8 UTF-8' | tee /etc/locale.gen

locale-gen

echo -e 'LANG=pt_BR.UTF-8' | tee /etc/locale.conf

echo -e 'thinkpad-arch' | tee /etc/hostname

echo -e "127.0.0.1      localhost.localdomain   localhost\n::1          localhost.localdomain   localhost\n127.0.1.1    thinkpad-arch.localdomain       thinkpad-arch" | tee /etc/hosts

mkinitcpio -P

passwd

useradd -m bn

passwd bn

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --removable

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S networkmanager xorg-server xorg-xinit xterm xf86-video-intel xfce4 lightdm lightdm-gtk-greeter mousepad galculator xfce4-screenshooter ristretto mousepad audacious --noconfirm


systemctl enable NetworkManager lightdm


exit
