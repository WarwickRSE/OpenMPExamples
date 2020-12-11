/*THIS PROGRAM DOESN'T WORK PROPERLY*/

#include <stdio.h>
#include <omp.h>

#define MAX_ITS 10000

int main(){

  int its_global, i;
  
  its_global = 0;
#pragma omp parallel for
  for (i=0;i<MAX_ITS;++i){
/*The atomic section means that operations in this section
cannot be interrupted by other threads. Only certain
mathematical operations can be performed in an atomic section*/

#pragma omp atomic
    {
      its_global++;
    }
  }

  printf("Counter records %i iterations\n", its_global);
}
