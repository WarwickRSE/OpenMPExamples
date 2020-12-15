#include <stdio.h>
#include <omp.h>

int main()
{
  printf("Hello in different sections\n");
#pragma omp parallel
  {
#pragma omp sections
    {
    #pragma omp section
    printf("Hello %i\n", omp_get_thread_num());
    #pragma omp section
    printf("Olá %i\n",omp_get_thread_num());
    #pragma omp section
    printf("Hola %i\n",omp_get_thread_num());
    #pragma omp section
    printf("Heghlu'meH QaQ jajvam %i\n",omp_get_thread_num());
    }
  }
  return 0;
}

