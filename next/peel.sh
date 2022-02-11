#!/bin/bash

for file in `ls Data/*.tex`; do
	echo $file;
	# Remove all after \end{document}
	printf "\n\\\\end{document}\n" >> $file;
	cat $file | grep -B20480 -m1 '\end{document}' > $file.1.tmp;
	mv $file.1.tmp $file;

	touch $file; # That's magic. Just don't touch it, otherwise grep will delete all files.
	cat $file | grep -v '\\end{document}' | grep -v '\\begin{document}' | grep -v '\\documentclass{vzmsthesis}' | grep -v '\\inputencoding{cp1251}'> $file.2.tmp;
	mv $file.2.tmp $file;

	# Remove blank lines from begin and end of a file
	# https://unix.stackexchange.com/questions/552188/how-to-remove-empty-lines-from-beginning-and-end-of-file
	sed -i -e '/./,$!d' -e :a -e '/^\n*$/{$d;N;ba' -e '}' $file
done;
