#!/bin/bash

if [[ -n "$1" ]]
then 
for i in "$(cat ~/.trash.log | awk -v name=$1 '$1 ~ "/*/"name {print $0}')"
do
	echo $(echo $i | awk '{print $1}')
	echo "Are you sure?"
	read line;
	if [[ ( "$line" != "Y" ) && ( "$line" != "N" ) ]]
	then
		echo "Answer Y or N"
		exit 1
	else
		if [[ "$line" == "Y" ]]
		then
			path=$(echo $i | awk '{print $1}')
			file=$(echo $i | awk '{print $2}')

			path_without_file=$(echo $path | awk -F "/" '{for(i=1;i<NF;i++){printf "%s/",$i}}')

			find $path_without_file -type d 2> /dev/null

			if [[ $? == "1" ]]
			then
				path=~/$1
			fi
		
			while true
			do
				find $path -type d 2> /dev/null
				
				if [[ $? == "0" ]]
				then
					echo "Enter new file name "
					read new_name
					path=$(echo $path | awk -F "/" '{for(i=1;i<NF;i++){printf "%s/",$i}}')
					path=$path""$new_name
				else
					break;
				fi
			done
			
			sed -i "/ $file/d" ~/.trash.log

			mv ~/.trash/$file $path
			break
		fi
	fi
done
else
	echo "No args"
	exit 1
fi
