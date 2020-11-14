#!/bin/bash

rm report.log
                                                                                
counter=0
index=0
array=()

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
                echo "${#array[@]}" >> report2.log
		counter=0
        fi
done
