#!/bin/bash

ps -Al | awk '{print $13, $4, $2}' | grep -E "R" | grep '^00:00' | awk '{print $2}'
