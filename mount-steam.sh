#!/usr/bin/env sh


sudo blkid -s UUID -o value /dev/sdb1 | while read line
do
echo '\nUUID='$line /steam  btrfs  defaults  0 0' | sudo tee -a /etc/fstab
done
