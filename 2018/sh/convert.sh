#!/bin/bash

cp $1 $1.bak

iconv -f WINDOWS-1251 -t UTF-8 $1.bak > $1

#From: http://blog.e-shell.org/188

sed '/./,$!d' $1 > $1.parsed
mv $1.parsed $1
