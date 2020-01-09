all:
	pdflatex main.tex
	pdflatex main.tex

utf8:
	./utf8.sh

overfull:
	pdflatex main.tex | grep -va Underfull | grep  -a . | grep -aC 12 Overfull
	pdflatex main.tex | grep -c Overfull

join:
	nodejs ~/git/node-text-split-join/text-join.js Data/joined.tex.tmp Data/*.tex Data/hist/*.tex

split:
	nodejs ~/git/node-text-split-join/text-split.js Data/joined.tex.tmp
