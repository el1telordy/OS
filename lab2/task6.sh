#!/bin/bash

grep "VmSize" /proc/*/status | sed "s/[^0-9.]\+/ /g" | sed "s/ //" | sort -nk2 | tail -1 | awk '{print "PID:"$1" VmSize:"$2}'

top -bo VIRT | head -8 | tail -1 | awk '{print "PID:"$1" VIRT:"$5}'
