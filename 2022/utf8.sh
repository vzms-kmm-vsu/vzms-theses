#!/bin/bash

for tex in Data/*.tex Data/*/*.tex; do
	echo $tex;
	nodejs node_modules/force-utf8-in-cyrtext/force-utf8-in-cyrtext.js $tex ;
done
