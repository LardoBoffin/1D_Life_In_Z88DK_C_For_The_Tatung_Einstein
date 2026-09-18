#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int X [40], Y[40];
int M = 38;

void CalculateLife(int i)
{
	int c, z;
	c = 0;
  
	for (z = i + 2;z > i-3;z--) {
		if (z==i || X[z]==0){}else{c++;}		
	}
	Y[i]=0;
	if (X[i] == 1){		
		if (c == 2 || c == 4){Y[i]=1;}		
	}
	else {
		if (c == 2 || c == 3){Y[i]=1;}
	}
}

int main() {
	
	int r, i, t;					// random number, loop counters	
	printf("\016");					// clear the screen
	srand((unsigned int) 9999);  	// seed with current time
	
	while(1){
		
		for (i = M; i > -1; i--) {
			r=(rand() % 10)+1;
			if (r < 5) {X[i]=0;printf(" ");}else {X[i]=1;printf("*");}
		}
		printf("\n");
		
		//24 iterations of lines of life
		for (t= 24; t> -1; t--) {
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


