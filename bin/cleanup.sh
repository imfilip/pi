#!/usr/bin/bash

echo ===========================
echo Welcome
echo ===========================
file=cleanup.sh
echo Changing permissions to a file ${file}
chmod a+x $file
echo Permissions changed to a+x
echo

echo ===========================
echo Disk usage summary
echo ===========================
df -H
echo

echo ===========================
echo Clean up APT cache folder /var/cache/apt
echo ===========================
sudo apt-get autoclean # remove only the outdated packages
sudo apt-get clean # delete apt cache in its entirety
echo Cleaning done!

echo     
echo ===========================
echo Clear systemd journal logs
echo ===========================
journalctl --disk-usage

if [ $# == 0 ];
then 
echo Provide number of days before which you would like to delete logs: 
read vacum_time
else
vacum_time=$1
fi

sudo journalctl --vacuum-time=$vacum_time
echo Cleaning logs older than ${vacum_time} done!

echo     
echo ===========================
echo Clean the thumbnail cache
echo ===========================

du -sh ~/.cache/thumbnails
rm -rf ~/.cache/thumbnails/*

echo Cleaning cache done!
