#include <time.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

int main(int argc, char const *argv[])
{
	// Gestion des erreurs
	if (argc<2)
	{
		printf("Usage: %s <character> \n", argv[0]);
		exit(1);
	}

	while(1){
		printf("%s", argv[1]);
		usleep(6000);
	}
	
	exit(0);
}