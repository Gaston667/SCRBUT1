#!/bin/bash
#
#mult_mat.sh <NUM_ARG1> <NUM_ARG1>
#

if [[ $# -lt 2 || $1 -gt $2 ]] 
	then 
	echo "Usage: $0 <NUM_ARG1> <NUM_ARG2> AND <NUM_ARG1> less or equal <NUM_ARG2>"
	exit
fi

for (( l=$1 ; l<=$2 ; l++ ));
do
	for (( c=$1 ; c<=$2 ; c++ )); 
	do
	    printf "%3d   " $((l*c)) 
	done
	echo ""
done

exit