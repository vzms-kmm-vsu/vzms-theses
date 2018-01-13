all:
	pdflatex main.tex
	pdflatex main.tex

utf8:
	bash -c 'for tex in Data/*.tex Data/*/*.tex; do js ~/git/node-force-utf8-in-cyrtext/force-utf8-in-cyrtext.js $tex ; done'

overfull:
	pdflatex main.tex | grep -v Underfull | grep . | grep -C 12 Overfull
	pdflatex main.tex | grep -c Overfull
