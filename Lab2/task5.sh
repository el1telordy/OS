#!/bin/bash

bash task4.sh

awk 'BEGIN {i=0; cppid; cart=0.0; count=.0}{
if (i == 0){
	count=1.0
	cppid=$7
	cart+=$11
} else if ($7 != cppid){
	print "AverageSleepingChildrenOfParentID" cppid ": " cart/count
	cppid=$7
	cart=$11
	count=.0
} else{
	count++
	cart+=$1
} fi
print $0
i++}' res4.txt > res5.txt
