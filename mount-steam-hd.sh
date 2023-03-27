#!/bin/sh

USER=$(whoami)
FILESYSTEM=$(sudo blkid -o value -s TYPE /dev/sdb1)

sudo mkdir /mnt/hd
sudo chown -R $USER:$USER /mnt/hd
sudo chmod 777 /mnt/hd

sudo blkid -s UUID -o value /dev/sdb1 | while read line
do
echo -e "\nUUID=$line /mnt/hd  $FILESYSTEM  defaults  0 0" | sudo tee -a /etc/fstab
done
