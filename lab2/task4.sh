#!/bin/bash

for i in $(ls /proc | grep "[0-9]")
do
	(awk '{
		if ($1 == "Pid:"){
			printf "ProcessID = %d : ", $2
		}
		if ($1 == "PPid:"){
			printf "ParentProcessID = %d : ", $2
		}
	}' /proc/$i/status >> tmp)

	(awk '{
		if ($1 == "se.sum_exec_runtime"){
			sum_exec_runtime=$3
		}
		if ($1 == "nr_switches"){
			nr_switches=$3
			printf "ART = " sum_exec_runtime/nr_switches
		}
	}' /proc/$i/sched >> tmp)
done

sort -nk7 tmp > res4.txt
rm tmp
