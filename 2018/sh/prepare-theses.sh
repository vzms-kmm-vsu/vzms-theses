#!/bin/bash

cp $1 $1.bak

iconv -f WINDOWS-1251 -t UTF-8 $1.bak |\
grep -A 10000 -x '\\widowpenalty=10000' |\
tail -n +2 |\
grep -B 10000 -x '\\end{document}' |\
head -n -1 >\
$1

#From: http://blog.e-shell.org/188

sed '/./,$!d' $1 > $1.parsed
mv $1.parsed $1