#!/bin/bash

if [[ "$1" -lt "$2" ]] && [[ "$3" -lt "$2" ]]
then echo $2
elif [[ "$1" -gt "$2" ]] && [[ "$1" -gt "$3" ]]
then echo $1
else
    echo $3
fi

