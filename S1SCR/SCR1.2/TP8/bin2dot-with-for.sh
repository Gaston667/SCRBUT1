#!/bin/bash

# Vérifier si deux arguments sont fournis
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <SRC_FILE> <DEST_FILE>"
    exit 1
fi

SRC_FILE=$1
DEST_FILE=$2

# Vérifier si le fichier de destination existe déjà
if [ -f "$DEST_FILE" ]; then
    echo "$DEST_FILE existe déjà. Voulez-vous le remplacer ? (o/n)"
    read answer
    if [ "$answer" != "o" ]; then
        echo "Annulation."
        exit 0
    fi
fi

# Vider le fichier de destination si nécessaire
> "$DEST_FILE"

i=1

# Lire chaque ligne du fichier source
cat "$SRC_FILE" | while read -r line; do
    # Extraire les 4 octets de l'adresse binaire avec 'expr'
    octet1=$(expr substr "$line" 1 8)
    octet2=$(expr substr "$line" 9 8)
    octet3=$(expr substr "$line" 17 8)
    octet4=$(expr substr "$line" 25 8)

    dec1=$((2#$octet1))
    dec2=$((2#$octet2))
    dec3=$((2#$octet3))
    dec4=$((2#$octet4))

    # Ajouter l'adresse IPv4 en notation décimale pointée au fichier de destination
    echo "$i - $dec1.$dec2.$dec3.$dec4" >> "$DEST_FILE"

    #incrementation du compteur i
    i=$((i + 1))
done

echo "La conversion est terminée. Les adresses IPv4 sont dans $DEST_FILE."
