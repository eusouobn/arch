#!/bin/bash

pacman -Sy nano pacman-contrib sudo grub efibootmgr

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && reflector --country Brazil --sort rate --save /etc/pacman.d/mirrorlist

cp /etc/pacman.conf /etc/pacman.conf.bak && sudo sed -i '37c\ParallelDownloads = 16' /etc/pacman.conf && pacman -Syyyuuu --noconfirm

sed -i '93c\[multilib]' /etc/pacman.conf && sudo sed -i '94c\Include = /etc/pacman.d/mirrorlist' /etc/pacman.conf && pacman -Syyyuu --noconfirm

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

hwclock --systohc

mv /etc/locale.gen /etc/locale.gen.bak

echo -e 'pt_BR.UTF-8 UTF-8' | tee /etc/locale.gen

locale-gen

echo -e 'LANG=pt_BR.UTF-8' | tee /etc/locale.conf

echo -e 'amd-arch' | tee /etc/hostname

echo -e "127.0.0.1      localhost.localdomain   localhost\n::1          localhost.localdomain   localhost\n127.0.1.1    amd-arch.localdomain       amd-arch" | tee /etc/hosts

mkinitcpio -P

passwd

useradd -m bn

groupadd -r autologin
groupadd -r sudo

usermod -G autologin,sudo,wheel,lp bn

passwd bn

cp /etc/sudoers /etc/sudoers.bak && sed -i '82c\ %wheel ALL=(ALL:ALL) ALL' /etc/sudoers

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --removable

grub-mkconfig -o /boot/grub/grub.cfg

pacman -S xorg-server xorg-xinit xterm xf86-video-amdgpu networkmanager network-manager-applet xfce4 lightdm lightdm-gtk-greeter pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber xdg-user-dirs --noconfirm

xdg-user-dirs-update

systemctl enable NetworkManager lightdm

exit
