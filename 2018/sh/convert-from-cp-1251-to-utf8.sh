#!/bin/bash
FILES=*.tex
for i in $FILES
do
echo \"Converting $i from WINDOWS-1251 to UTF-8 encoding…\"
mv $i $i.icv
iconv -f WINDOWS-1251 -t UTF-8 $i.icv > $i
rm -f $i.icv
done
