all: include_theses
	# The default target to be run
	# Rebuilds the list of the theses and tries to build the PDF file
	pdflatex main.tex
	pdflatex main.tex

utf8:
	# Convert all the theses to UTF-8
	# Can be run much more than once
	# Sometimes it plays tricky and "converts" files with mostly-English text
	# Then, just place a Russian comment with a couple of phrases somewhere in the file
	# Be careful and always check the result with `git diff`
	./utf8.sh

peel:
	# Remove such lines as '\begin{document}' from all theses
	# as well as empty lines on the top and bottom of each file
	# Can be run much more than once
	# Be careful and always check the result with `git diff`
	# TODO: it DOES NOT renormalize line endings
	./peel.sh


overfull:
	# Count the existing overfulls (if any)
	# after providing a convenient brief list with filenames and row numbers
	pdflatex main.tex | grep -va Underfull | grep  -a . | grep -aC 12 Overfull
	pdflatex main.tex | grep -c Overfull

join:
	# Mix all the theses to a single file
	# Extremely useful for further runs of tex-lint
	nodejs ~/git/node-text-split-join/text-join.js Data/joined.tex.tmp Data/*.tex

split:
	# Revert the above :)
	nodejs ~/git/node-text-split-join/text-split.js Data/joined.tex.tmp

include_theses:
	# Build the list of the theses in alphabetical order of filenames, Russian first
	./include_theses.sh

clean:
	# Remove all the temporary files
	# Be careful if some images are in PDF
	# `git checkout` is your friend!
	rm -f *.aux *.log *.toc *.pdf
	rm -f Data/pic/*.pdf
	rm -f theses.tex
