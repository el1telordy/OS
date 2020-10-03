#!/bin/bash

man $1 | awk '/^ *- *.*$/,/^$/{print}'
