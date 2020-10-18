#!/bin/bash

if [[ -n "$1" ]]
then
	name=$((echo $1) | (tr " " "_"))
	mv "$1" "$name"
	(find ~/.trash -type d 2> /dev/null) || (mkdir ~/.trash)
	(find "$name" -type d 2> /dev/null) || (echo "File not found")
	path=$(echo $(tree ~/.trash | tail -1 | awk '{print $3}')"+1" | bc)
	if [[ "$path" != "1" ]]
	then
		path=$(echo $(ls ~/.trash | tail -1)"+1" | bc)
	fi
	ln "$name" ~/.trash/$path
	rm "$name"
	echo $PWD"/"$name" "$path >> ~/.trash.log
else
	echo "No args!"
	exit 1
fi
