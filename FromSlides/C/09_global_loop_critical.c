/*THIS PROGRAM DOESN'T WORK PROPERLY*/

#include <stdio.h>
#include <omp.h>

#define MAX_ITS 10000

int main(){

  int its_global, i;
  
  its_global = 0;
#pragma omp parallel for
  for (i=0;i<MAX_ITS;++i){
/*The critical section ensures that only one thread can be in it at a time
this makes the incrementing of its_global safe*/

#pragma omp critical
    {
      its_global++;
    }
  }

  printf("Counter records %i iterations\n", its_global);
}
