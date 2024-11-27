#!/bin/bash
#
# any2dec.sh <radix> <string_representation_in_that_radix>
#
if [[ $# -lt 2 ]]
	then
	echo "Usage: $0 <radix> <string_representation_in_that_radix>"
	exit
fi

if [[ $1 -lt 2 || $1 -gt 36 ]]
	then
	echo "The radix is a decimal between 2 and 36"
	exit
fi
DIGITS=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
LEGAL_DIGITS=$(expr substr $DIGITS 1 $1)
decimal=0
l=$(expr length $2)

# Pas besoin de ça dans le cas 2
#	pow_radix=1;
#	for ((i=0;i<l;i++))

for (( i = 1; i <= l; i++ ));
	do
	#On recupềre le digits 
	digit=$(expr substr $2 $i 1)
	pos=$(expr index $LEGAL_DIGITS $digit)
	if [[ pos -eq 0 ]]
		then
		echo "Authorized digits are : $LEGAL_DIGITS"; exit
	fi
	digit_val=$((pos-1))
	#decimal=$((decimal+digit_val*pow_radix))
	decimal=$(((decimal)*$1+digit_val))
	#pow_radix=$(($1*pow_radix))
done
echo "decimal : $decimal"
exit

