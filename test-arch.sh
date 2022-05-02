#!/bin/bash

read -p "Press enter to continue"

timedatectl set-ntp true

read -p "Press enter to continue"

pacman -S btrfs-progs dosfstools nano wget

read -p "Press enter to continue"

parted /dev/sda mklabel gpt

read -p "Press enter to continue"

parted /dev/sda mkpart primary fat32 1MiB 301MiB

read -p "Press enter to continue"

parted /dev/sda set 1 esp on

read -p "Press enter to continue"

parted /dev/sda mkpart primary btrfs 301MiB 100%

read -p "Press enter to continue"

mkfs.fat -f /dev/sda1

read -p "Press enter to continue"

mkfs.btrfs -f /dev/sda2

read -p "Press enter to continue"

mount /dev/sda2 /mnt

read -p "Press enter to continue"

mkdir /mnt/boot/

read -p "Press enter to continue"

mkdir /mnt/boot/efi

read -p "Press enter to continue"

mount /dev/sda1 /mnt/boot/efi

read -p "Press enter to continue"

pacstrap /mnt base btrfs-progs linux-zen linux-firmware

read -p "Press enter to continue"

genfstab -U /mnt > /mnt/etc/fstab

read -p "Press enter to continue"

cd /mnt

git clone http://github.com/eusouobn/arch

read -p "Press enter to continue"

arch-chroot /mnt
