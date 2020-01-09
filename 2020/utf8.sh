for tex in Data/*.tex Data/*/*.tex; do
	echo $tex;
	nodejs ~/git/node-force-utf8-in-cyrtext/force-utf8-in-cyrtext.js $tex ;
done
