#!/bin/bash

if [[ $PWD == $HOME ]]
then
echo $HOME
exit 0
else
echo "NOT HOME"
exit 0
fi
