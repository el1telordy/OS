#!/bin/bash

while true;
do
	read line
	echo "$line" > pipe5

	if [[ "$line" == "QUIT" ]];
	then
		echo "Exiting..."
		exit 0
	fi

	if [[ "$line" != "+" && "$line" != "*" && "$line" != [0-9]* ]];
	then 
		echo "ERROR"
		exit 1
	fi
done
