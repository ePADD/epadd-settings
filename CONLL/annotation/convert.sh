#!/usr/bin/bash

echo $1;
cat "$1.dat"| perl -ane '@F=split("\t");print $F[0];map {print " $_"} @F[1..$#F]'>"$1spacesep.txt"
