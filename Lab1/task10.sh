#!/bin/bash

man bash | grep -o "[[:alpha:]]\{4,\}" | sort | uniq -c | sort -rnk 1 | head -n 3 | awk '{print $2}'
