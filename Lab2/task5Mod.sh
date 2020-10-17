#!/bin/bash

bash task4Mod.sh

fileIn="res4.txt"
fileOut="res5.txt"
prev_ppid="0"
art_sum="0"
count="0"
m="0"

echo -e "$(<"$fileIn")\n" | sed "s/[^0-9.]\+/ /g" | sed "s/^ //g" |

while read line
do                                                                           
        ppid=$(awk '{print $2}' <<< $line )                                  
        art=$(awk '{print $3}' <<< $line )                                   
        pid=$(awk '{print $1}'<<< $line )                                    
        if [[ $prev_ppid == $ppid ]]                                         
        then                                                                 
                count=$(($count+1))                                          
                m=$(echo "scale=4; $m+$art"| bc)                             
                line2=$(awk '{print "PID="$1" : PPID="$2" : ART="$3}' <<< $line)
                echo $line2 >> $fileOut                                  
        else                                                                 
                m=$(echo "scale=4; $m/$count" | bc)                          
                                                                             
                echo "Average_Sleeping_Children_of_PatientID="$prev_ppid" is "$m >> $fileOut
                prev_ppid=$ppid                                              
                count=1                                                      
                m=$art
		line2=$(awk '{print "ProcessID="$1" : ParentProcessID="$2" : AverageRunningTime="$3""}' <<< $line)
		echo $line2 >> $fileOut
	fi
done
