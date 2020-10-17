#!/bin/bash

ps au | awk '$1 == "user"' | wc -l > res1.txt
ps au | awk '$1 == "user"' | awk '{print $2, $11}' >> res1.txt
