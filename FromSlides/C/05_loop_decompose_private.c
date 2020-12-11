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

#pragma omp parallel for private(thread_id)
  for (i = 0; i< MAX_ITS; ++i){
    thread_id = omp_get_thread_num();
    its_per_proc[thread_id]++;
}

  sum = 0;
  for (i = 0; i< nproc; ++i){
    printf("Processor %i performed %i iterations\n", i, its_per_proc[i]);
    sum += its_per_proc[i];
  }
  printf("Total work on all processors is %i\n", sum); 
}
