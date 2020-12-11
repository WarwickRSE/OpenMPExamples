#include <stdio.h>
#include <omp.h>

int main()
{
  printf("Hello world from the main program\n");
#pragma omp parallel
  {
    printf("Hello world! I am processor %i\n", omp_get_thread_num());
  }
  return 0;
}

