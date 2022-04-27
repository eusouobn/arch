#!/bin/bash

timedatectl set-ntp true

pacman -S btrfs-progs dosfstools nano wget wipe

parted /dev/sda mklabel gpt

parted /dev/sda mkpart "EFI system partition" fat32 1MiB 301MiB

parted /dev/sda set 1 esp on

parted /dev/sda mkpart "root" btrfs 301MiB 100%

#mkfs.fat /dev/sda1

#mkfs.btrfs /dev/sda2

mkdir /mnt/boot/efi

mount /dev/sda2 /mnt

mount /dev/sda1 /mnt/boot/efi

pacstrap /mnt base linux-zen linux-firmware

genfstab -U /mnt > /mnt/etc/fstab

cd /mnt

git clone http://github.com/eusouobn/arch

arch-chroot /mnt
