#!/bin/bash
                                                                             
for pid in $(ps -eo pid | sed 1d)                                            
do                                                           
                                                                             
        fs="/proc/"$pid"/status"                                    
        fsc="/proc/"$pid"/sched"                                      
                                                                             
        ppid=$(grep -Ehis "ppid" "$fs" | grep -o "[0-9]\+")        
                                                                             
        sum_exec_runtime=$(grep -Ehis "se\.sum_exec_runtime" "$fsc" | awk '{print $3}')
        nr_switches=$(grep -Ehis "nr_switches" "$fsc" | awk '{print $3}')
                                                                             
        if [ -z $ppid ]
        then
        continue
        fi
        if [ -z $sum_exec_runtime ] || [ -z $nr_switches ]                   
        then                                                                 
                art=0                                                        
        else                                                                 
                                                                             
                art=$(echo "scale=6; $sum_exec_runtime/$nr_switches" | bc) 
        fi                                                                   
        echo "$pid $ppid $art"                                               
done | sort -nk2 | awk '{print "ProcessID="$1" : ParentProcessID="$2" : AverageRunningTime="$3""}' > res4.txt                                                               

