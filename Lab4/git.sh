#!/bin/bash

if [[ -n "$1" && -n "$2" ]]
then
	if [[ "$2" == "create" ]]
	then 
		echo "create"
		(find /home/user/.asgit -type d 2> /dev/null) || (mkdir /home/user/.asgit)	
		path=$(echo $(ls /home/user/.asgit | tail -1)"+1" | bc)
		for file in $(ls $1)
		do	
			if [[ "$path" == "1" ]]
			then
				path=$(echo $(ls /home/user/.asgit | tail -1)"+1" | bc)
			fi
			ln "$file" /home/user/.asgit/$path 2> /dev/null
		done
	elif [[ "$2" == "check" ]]
	then 
		echo "check"
	else
		echo "wrong arg"
		exit
	fi
else
	echo "No args"
	exit 1
fi
