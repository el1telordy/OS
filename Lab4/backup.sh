#!/bin/bash

function makeBackup {
	catalog=$(echo "Backup-"$(date +"%Y-%m-%d"))
	mkdir /home/user/$catalog
	echo "Created "$catalog $(date +"%Y-%m-%d")>> /home/user/backup-report
	echo "File list: " >> /home/user/backup-report
	for file in $(ls /home/user/source)
	do	
		space="$(ls /home/user/source/)"
		if [[ "$space" != "${space// /_}" ]]
		then
			echo "Backup did't created: don't use spaces in file name"
			exit 1
		elif [[ "$(tree /home/user/source/ | tail -l | awk '{print $1}')" != 0 ]]
		then
			echo "Backup did't created: don't use folders"
			exit 1
		else
			cp /home/user/source/$file /home/user/$catalog/$file 2> /dev/null
			echo $file >> /home/user/backup-report
		fi
	done
}

backup=$(find /home/user -name "Backup-[0-9]*-[0-9]*-[0-9]*" -type d 2> /dev/null | sort -n | tail -1 | awk -F "/" '{print $4}' )

if [[ -z $backup ]]
then	
	makeBackup
else
	oldBackup=$(echo $(find /home/user -name "Backup-[0-9]*-[0-9]*-[0-9]*") 2> /dev/null | awk -F "-" '{print $4}')
	current=$(echo $(date +"%Y-%m-%d") | awk -F "-" '{print $3}')
	age=$(echo $current"-"$oldBackup | bc)

	if [[ $age -ge 7 ]]
	then
		echo "New backup created"
		makeBackup
	else
		echo "Backup is up to date"

		stat="0"

		for i in $(ls /home/user/source)
		do
			find /home/user/$backup/$i 2> /dev/null

			if [[ $? == "1" ]]
			then
				if [[ $stat == "0" ]]
				then
					echo "Updated "$backup $(date +"%Y-%m-%d") >> /home/user/backup-report
					stat="1"
				fi

				cp /home/user/source/$i /home/user/$backup/$i 2> /dev/null
				echo "Copied " $i >> /home/user/backup-report
			else
				size1=$(wc -c /home/user/$backup/$i | awk '{print $1}')
				size2=$(wc -c /home/user/source/$i | awk '{print $1}')

				if [[ $size1 -ne $size2 ]]
				then
					if [[ $stat == "0" ]]
					then
						echo "Updated "$backup  $(date +"%Y-%m-%d") >> /home/user/backup-report
						stat="1"
					fi

					mv /home/user/$backup/$i /home/user/$backup/$i"."$(echo $backup | awk -F "-" '{print $2"-"$3"-"$4}')
					cp /home/user/source/$i /home/user/$backup/$i 2> /dev/null

					echo "New "$i  $i"."$(echo $backup | awk -F "-" '{print $2"-"$3"-"$4}') >> /home/user/backup-report
				fi
			fi
		done
	fi

fi
