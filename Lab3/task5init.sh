#!/bin/bash

mkfifo pipe5
./task5handler.sh & ./task5gen.sh
rm pipe5
