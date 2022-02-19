########################################################################
##                      Making the entire book                        ##
########################################################################

# These are plain bash + LaTeX + unoconv, and you shouldn't need to install smth else like NodeJS

# (for preparational scripts, see below)

all: include_theses
	# The default target to be run
	# Rebuilds the list of the theses and tries to build the PDF file
	unoconv -f pdf -o title_page.pdf docs/title_page.fodt
	unoconv -f pdf -o second_page.pdf docs/second_page.fodt
	unoconv -f pdf -o last_page.pdf docs/last_page.fodt
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
	rm -f publishing/*

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

litlist:
	# List all the theses without well-written reference header
	# and try to turn homemade header into standard `litlist`
	# Does plenty of work, but the result is not guranteed :-(
	# Sometimes you need to run it twice
	# If you find another rows that should be replaced by `litlist`,
	# don't hesitate to add them into the script!
	node ./format_litlist.js

litautolang: litlist
	# Insert '\selectlanguage' into bibliography where necessary
	# WARNING!
	# Sometimes it can break the build,
	# e.g. if Russian shortifications like 'С.' are used in an English reference
	# (although they probably should not!)
	# However, it turns to be extremely useful for hyphenation of non-Russian references
	# WARNING!
	# Sometimes it does not recognize English references, don't lean on the script
	node ./format_autolang.js


join:
	# Mix all the theses to a single file
	# Extremely useful for further runs of tex-lint
	node node_modules/text-split-join/text-join.js Data/joined.tex.tmp Data/*.tex

# (cast tex-lint here!)

split:
	# Revert the above :)
	node node_modules/text-split-join/text-split.js Data/joined.tex.tmp


###########################################################
##    Preparation the theses for the publishing house    ##
###########################################################

# These are plain bash + LaTeX + unoconv

publishing: all
	unoconv -f docx -o publishing/title_page.docx docs/title_page.fodt
	unoconv -f docx -o publishing/second_page.docx docs/second_page.fodt
	unoconv -f docx -o publishing/last_page.docx docs/last_page.fodt
	cp main.pdf publishing/
