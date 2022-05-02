#!/bin/bash

mount /dev/sda1 /boot/efi

localectl set-x11-keymap br abnt2 thinkpad

pacman -S nano pacman-contrib btrfs-progs sudo --noconfirm

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

pacman -S networkmanager xorg-server xorg-xinit xterm xf86-video-intel xfce4 lightdm lightdm-gtk-greeter mousepad galculator xfce4-screenshooter ristretto mousepad audacious xdg-user-dirs--noconfirm

xdg-user-dirs-update

systemctl enable NetworkManager lightdm

echo 'vm.dirty_background_ratio = 2 \nvm.dirty_ratio = 5' | tee /etc/sysctl.conf && sysctl -p

echo 'Section "Device"\n Identifier "Intel Graphics"\n Driver "Intel"\n Option "TearFree" "true"\nEndSection' | tee /etc/X11/xorg.conf.d/20-intel.conf

truncate -s 0 /swapfile && chattr +C /swapfile && btrfs property set /swapfile compression none && fallocate -l 4096M /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && echo -e '/swapfile none swap defaults 0 0\n' | tee -a /etc/fstab

echo 'net.ipv4.ping_group_range = 1000 1000' | tee -a /etc/sysctl.d/60-mysql.conf


exit
