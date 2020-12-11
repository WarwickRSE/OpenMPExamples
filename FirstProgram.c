#include<stdio.h>

int main(){

  const int T = 100;
  int sum;

  sum = 0;
  
  // Simple accumulation loop
  // (Note in Fortran we can use a built-in for this, but
  // ignore that for this demo)

  for(int i = 1; i <= T; i++){
    sum = sum + i;
  }

  printf("Loop gave         %i\n", sum);
  printf("Answer should be  %i\n", T*(T+1)/2);

}
