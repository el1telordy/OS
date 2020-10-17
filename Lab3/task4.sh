#!/bin/bash

./loop4.sh & pid0=$!
./loop4.sh & pid1=$!
./loop4.sh & pid2=$!

renice +10 -p $pid0
