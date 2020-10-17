#!/bin/bash

file_1="temp.log"
file_2="temp2.log"
(
echo ""> "$file_1"

ps aux | awk '{print $2" "$11 }' | tail -n +2 | sort -nk1 | head -n -5 > temp1.log
while read line
do
	file_id=$(awk '{print $1}' <<< $line)
	file_bytes=$(grep "read_bytes" /proc/"$file_id"/io | awk '{print $2}')
	file_patch=$(awk '{print $2}' <<< $line)
	echo $file_id" "$file_patch" "$file_bytes >> "$file_1" 
done < temp1.log
sleep 1m
) 2> /dev/null

cat temp1.log |

(while read line
do
	pid=$(awk '{print $1}' <<< $line)
	mem_2=$(grep "read_bytes" /proc/"$pid"/io | awk '{print $2}')
	patch=$(awk -v id="$pid" '{if($1 == id) print $2}' < "$file_1" )
	mem_1=$(awk -v id="$pid" '{if($1 == id) print $3}' < "$file_1")	
	if [[ -n bytes2 ]]
	then 
		delta=$(`expr $mem_2-$mem_1`)
		echo "$pid":"$patch":"$mem_2" 
	fi
done | sort -t ":" -nk3 | tail -n 3 
rm temp*
) 2> /dev/null
