#!/bin/bash

operation="+"
value=1

(tail -f pipe5) |
while true;
do
	read line

	case $line in
		"+")
			operation="$line"
			echo "Now: PLUS"
		;;
		"*")
			operation="$line"
			echo "Now: MULTIPLY"
		;;
		[0-9]*)
			case $operation in
				"+")
					value=$(($value + $line))
					echo $value
				;;
				"*")
					value=$(($value * $line))
					echo $value
				;;
			esac
		;;
		"QUIT")
			killall tail
			echo "Now: QUIT"
			exit 0
		;;
		*)
			killall tail
			echo "ERROR"
			exit 1
		;;
	esac
done
