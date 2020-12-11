#include <stdio.h>
#include <omp.h>

int main(){


 #pragma omp parallel
   printf("Parallel from thread %i\n", omp_get_thread_num());
 #pragma omp single
  {
    printf("Single from thread %i\n", omp_get_thread_num());
  }
}
