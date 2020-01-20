#!/bin/bash

for tex in $(find Data -maxdepth 1 -name "[А-Яа-яёЁ]*.tex"); do
	echo \\thesis{\\detokenize{$(basename "$tex")}};
done | sort > theses.tex

for tex in $(find Data -maxdepth 1 -name "[A-Za-z]*.tex"); do
	echo \\thesis{\\detokenize{$(basename "$tex")}};
done | sort >> theses.tex
