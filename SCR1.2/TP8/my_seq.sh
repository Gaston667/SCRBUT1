#!/bin/bash
if [[ $# -lt 1 ]]
then
	echo "Usage:$0 <arg_numeric>"
	exit
fi

for (( i = 1; i <=$1; i++)); do
	echo $i
done
exit


