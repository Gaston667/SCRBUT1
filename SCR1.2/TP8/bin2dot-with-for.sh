#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <SRC_FILE> <DEST_FILE>"
    exit 1
fi

#cp /dev/null $2
for addr in $(cat $1); do
    #statements
    #On recupere le digits 
    octet1=$(expr substr $addr 1 8)
    octet2=$(expr substr $addr 9 8)
    octet3=$(expr substr $addr 17 8)
    octet4=$(expr substr $addr 25 8)
    addr_dot="$((2#$octet1)).$((2#$octet2)).$((2#$octet3)).$((2#$octet4))"
    echo $addr_dot >> $2
done 
exit 0 
