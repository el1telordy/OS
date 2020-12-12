#!/bin/bash
                                                                                
counter=0
index=0
array=()

if [[ $# == 0 ]]
then
	N=1800000
else
	N=$1
fi

while true
do
        for (( count=1; count<11; count++ ))
        do 
		array[$index]=$count
                index=$((index+1))
        done
        counter=$((counter+1))
        if [[ $counter == 100000 ]]
	then
		counter=0
		if [[ "${#array[@]}" > "$N" ]]
		then
			echo "$N"
			exit 0
		fi
        fi
done
