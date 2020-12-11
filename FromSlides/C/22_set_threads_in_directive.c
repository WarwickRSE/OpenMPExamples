#include <stdio.h>
#include <omp.h>

int main()
{
  printf("Hello world from the main program\n");

  int nthreads = 6;
#pragma omp parallel num_threads(nthreads)
  {
    printf("Hello world! I am processor %i\n", omp_get_thread_num());
  }
  return 0;
}

