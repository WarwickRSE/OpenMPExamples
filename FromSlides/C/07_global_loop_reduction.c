#include <stdio.h>
#include <omp.h>

#define MAX_ITS 10000

int main(){

  int its_global, i;
  
  its_global = 0;
#pragma omp parallel for reduction(+:its_global)
  for (i=0;i<MAX_ITS;++i){
  /*Reduction means that its_global is recorded separately
   on each thread and then combined between all threads by using
   a reduction operator (here +) at the end*/
    its_global++;
  }

  printf("Counter records %i iterations\n", its_global);
}
