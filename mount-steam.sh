#!/usr/bin/env sh

sudo mkdir /steam
sudo mkdir /lutris
sudo chown -R bn:bn /steam
sudo chown -R bn:bn /lutris
sudo chmod 777 /steam
sudo chmod 777 /lutris

sudo blkid -s UUID -o value /dev/sdb1 | while read line
if [  $(grep -c steam /etc/fstab) != 0 ]; then
do
echo -e "\nUUID=$line /steam  btrfs  defaults  0 0" | sudo tee -a /etc/fstab
done

sudo blkid -s UUID -o value /dev/sdb1 | while read line
if [  $(grep -c steam /etc/lutris) != 0 ]; then
do
echo -e "\nUUID=$line /lutris  btrfs  defaults  0 0" | sudo tee -a /etc/fstab
done
