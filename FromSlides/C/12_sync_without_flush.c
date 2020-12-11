/*NOTE THIS CODE DOESN'T WORK*/
#include <stdio.h>
#include <omp.h>

int main(){

  int data;
  int flag;

  flag = 0;
  data = 0;

#pragma omp parallel
  if(omp_get_thread_num() == 0) {
    //Thread 0 sets the payload and sets the flag
    data = 42;
    flag = 1;
  } else {
    //On all other threads wait until the flag is set
    while (!flag);
    printf("Thread %i got payload %i\n", omp_get_thread_num(), data);
  }
}
