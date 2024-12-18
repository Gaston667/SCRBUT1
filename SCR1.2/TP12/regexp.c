#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <regex.h>

int main (int argc, char * argv [])
{
	regex_t	regex;
	int	retour;
	char	message [128];

	if (argc != 3) {
		fprintf (stderr, "syntaxe : %s expression chaine\n",
			argv [0]);
		exit (1);
	}
	
	if ((retour = regcomp (& regex, argv [1], REG_NOSUB)) != 0) {
		regerror (retour, & regex, message, 128);
		fprintf (stderr, "Erreur : %s\n", message);
		exit (1);
	}

	if (regexec (& regex, argv [2], 0, NULL, 0) == 0) 
		fprintf (stdout, "Correspondance !\n");
	else 
		fprintf (stdout, "Pas de correspondance.\n");

	regfree (& regex);
	exit (0);
}