//IMPORTANT NOTE! THIS CODE DOESN'T WORK PROPERLY
#include <stdio.h>
#include <omp.h>

#define MAX_ITS 10000

int main()
{
  int nproc, i, sum, thread_id;
  nproc = omp_get_max_threads();
  int its_per_proc[nproc];

  for (i = 0; i< nproc; ++i){
    its_per_proc[i] = 0;
  }

#pragma omp parallel for
  for (i = 0; i< MAX_ITS; ++i){
    /*This line isn't safe because by default there is only one
    thread_id variable and all of the threads are competing to write to it*/
    thread_id = omp_get_thread_num();
    //Which element of its_per_proc is written to here is pretty much random
    its_per_proc[thread_id]++;
}

  sum = 0;
  for (i = 0; i< nproc; ++i){
    printf("Processor %i performed %i iterations\n", i, its_per_proc[i]);
    sum += its_per_proc[i];
  }
  printf("Total work on all processors is %i\n", sum); 
}
