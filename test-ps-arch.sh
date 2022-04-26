#!/bin/bash

pacman -S networkmanager intel-ucode grub efibootmgr

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

hwclock --systohc

mv /etc/locale.gen /etc/locale.gen.bak

echo -e `pt_BR.UTF-8 UTF-8` | tee /etc/locale.gen

locale-gen

echo -e `LANG=pt_BR.UTF-8` | tee /etc/locale.conf

echo -e `thinkpad-arch` | tee /etc/hostname

echo -e "127.0.0.1      localhost.localdomain   localhost\n::1          localhost.localdomain   localhost\n127.0.1.1    thinkpad-arch.localdomain       thinkpad-arch" | tee /etc/hosts

systemctl enable NetworkManager

mkinitcpio -P

passwd

useradd -m bn

passwd bn

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --removable

grub-mkconfig -o /boot/grub/grub.cfg

exit
