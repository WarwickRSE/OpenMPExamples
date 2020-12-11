/*THIS PROGRAM DOESN'T WORK PROPERLY*/

#include <stdio.h>
#include <omp.h>

#define MAX_ITS 10000

int main(){

  int its_global, i;
  
  its_global = 0;
#pragma omp parallel for
  for (i=0;i<MAX_ITS;++i){
    /*Two threads trying to update this simultaneously won't work properly
    because updating the variable isn't instantaneous*/
    its_global++;
  }

  printf("Counter records %i iterations\n", its_global);
}
