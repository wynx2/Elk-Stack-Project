#!/bin/bash

current_date=$(date)
output_file='/home/sysadmin/research/sys_info.txt'
echo "My System Info and the date is $current_date"
echo $current_date 
echo $USER
echo $(hostname -I)
echo $(hostname)
echo $(cat /etc/resolv.conf)
echo $(cat /proc/cpuinfo)

if [ -d "/home/sysadmin/research" ]
    then 
        echo '~research exists'
    else
        mkdir ~/research
fi

if [ -f "$output_file" ]
    then
	sudo rm $output_file
	echo "'$output_file deleted"
    else
        echo 'do nothing' 
fi
  

sudo find /home -type f -perm 777 > $output_file
ps -aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $output_file
