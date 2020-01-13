for tex in Data/*.tex; do
	echo \\thesis{\\detokenize{$(basename "$tex")}};
done | sort > theses.tex
