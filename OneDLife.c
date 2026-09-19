#include <stdio.h>
#include <stdlib.h>

int X [40], Y[40];
int M = 38;

void CalculateLife(int);

int main() {
	
	int r, i, t;					// random number, loop counters		
	unsigned int user_seed = 0;

    printf("--- Press Any Key To Start ---\n");

    // Loop and rapidly increment seed until a key is pressed
    while (getk() == 0) {
        user_seed++;
    }

    // Seed the generator with the final unique value
    srand(user_seed); 
	
	printf("\016");					// clear the screen

	while(1){
		
		for (i = M; i > -1; i--) {
			r=(rand() % 10)+1;
			if (r < 5) {X[i]=0;printf(" ");}else {X[i]=1;printf("*");}
		}
		printf("\n");
		
		//24 iterations of lines of life
		for (t= 20; t> -1; t--) {
			//for each creature see what is around it
			for (i = M - 2 ; i > -1; i--) {
				CalculateLife(i);
			}	
			//print out the new line
			for (i = M; i > -1; i--) {
				X[i]=Y[i];
				if (X[i]==0){printf(" ");}else{printf("*");}
			}
		}
	}
    return 0;
}

void CalculateLife(int i)
{
	int c, z;
	c = 0;
  
	for (z = i + 2;z > i-3;z--) {
		if (z!=i && X[z]==1){c++;}	
	}
	Y[i]=0;
	if (X[i] == 1){		
		if (c == 2 || c == 4){Y[i]=1;}		
	}
	else {
		if (c == 2 || c == 3){Y[i]=1;}
	}
}
