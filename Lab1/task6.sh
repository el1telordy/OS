#!/bin/bash

info="$(cat /var/log/anaconda/X.log | awk '$3 == "(II)"')"
warning="$(cat /var/log/anaconda/X.log | awk '$3 == "(WW)"')"
echo "${warning//"(WW)"/"Warning: "}" > info.log
echo "${info//"(II)"/"Information: "}" >> info.log
