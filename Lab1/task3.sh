#!/bin/bash

echo "1. Nano"
echo "2. Vim"
echo "3. Links"
echo "4. Quit"

read selected
case $selected in
1)
nano
;;
2)
vi
;;
3)
links
;;
4)
exit 0
;;
esac
