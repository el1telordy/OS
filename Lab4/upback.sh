#!/bin/bash

backup=$(find /home/user -name "Backup-[0-9]*-[0-9]*-[0-9]*" -type d | sort -n | tail -1 | awk -F "/" '{print $4}')

if [[ -n $backup ]]
then
	for file in $(ls /home/user/$backup)
	do
		if ! [[ $file =~ .*\.[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
		then
			cp /home/user/$backup/$file /home/user/restore/$file
		fi
	done
else
	echo "Backup doesn't exist"
fi
