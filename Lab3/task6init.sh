#!/bin/bash

./task6handler.sh &pid=$!
./task6gen.sh $pid
