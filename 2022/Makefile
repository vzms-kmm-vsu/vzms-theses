########################################################################
##                      Making the entire book                        ##
########################################################################

# These are plain bash + LaTeX, and you shouldn't need to install smth else like NodeJS

# (for preparational scripts, see below)

all: include_theses
	# The default target to be run
	# Rebuilds the list of the theses and tries to build the PDF file
	pdflatex main.tex
	pdflatex main.tex

overfull:
	# Count the existing overfulls (if any)
	# after providing a convenient brief list with filenames and row numbers
	# This is extremely useful for debug
	pdflatex main.tex | grep -va Underfull | grep  -a . | grep -aC 12 Overfull
	pdflatex main.tex | grep -c Overfull

clean:
	# Remove all the temporary files
	# Be careful if some images are in PDF
	# `git checkout` is your friend!
	rm -f *.aux *.log *.toc *.pdf
	rm -f Data/pic/*.pdf
	rm -f theses.tex

include_theses:
	# Build the list of the theses in alphabetical order of filenames, Russian first
	# An auxiliary script, not to usually be run directly
	./include_theses.sh


########################################################################
##    Preparing the theses from how they are received from authors    ##
########################################################################

# (you still have to do something by hand)

# When you get new theses and put them into `Data/`,
# you usually want to run the scripts, usually in this order
# You are highly recommended to run these scripts one-by-one
# and look into `git diff` after every iteration!

# Note that these targets require NodeJS to be installed
# Don't forget to run `npm install` !

utf8:
	# Convert all the theses to UTF-8
	# Can be run much more than once without any harm
	# Sometimes it plays tricky and "converts" files with mostly-English text
	# Then, just place a Russian comment with a couple of phrases somewhere in the file
	# Be careful and always check the result with `git diff`
	./utf8.sh

peel:
	# Remove such lines as '\begin{document}' from all theses
	# as well as empty lines on the top and bottom of each file
	# Can be run much more than once without any harm
	# Be careful and always check the result with `git diff`
	# TODO: it DOES NOT renormalize line endings
	./peel.sh

join:
	# Mix all the theses to a single file
	# Extremely useful for further runs of tex-lint
	nodejs ~/git/node-text-split-join/text-join.js Data/joined.tex.tmp Data/*.tex

# (cast tex-lint here!)

split:
	# Revert the above :)
	nodejs ~/git/node-text-split-join/text-split.js Data/joined.tex.tmp
