#!/bin/bash

grep -EIshro "[[:alnum:]._%+-]+\@[[:alnum:]._-]+\.[[:alnum:]]+" /etc/* > emails.lst
