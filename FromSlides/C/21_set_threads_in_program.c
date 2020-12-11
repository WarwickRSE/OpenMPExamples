#include <stdio.h>
#include <omp.h>

int main()
{
  printf("Hello world from the main program\n");
  omp_set_num_threads(4);
#pragma omp parallel
  {
    printf("Hello world! I am processor %i\n", omp_get_thread_num());
  }
  return 0;
}

