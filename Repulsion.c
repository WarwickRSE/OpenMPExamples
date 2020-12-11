#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

int main(){

  const int N=40, T=50, M=5;
  float *grid, *forces;
  float *posns;
  float force_retention = 0.0;
  int show = 1;

  // Allocate some 1-D arrays
  // Initialise to value 0
  // Main grid has extra edge cells
  // Use these in forces array so we don't have to struggle lining them up, but they are ignored
  grid = calloc(N+2, sizeof(float));
  forces = calloc(N+2, sizeof(float));

  //End values set to 1.0
  grid[0] = 1.0;
  grid[N+1] = 1.0;

  // Array for blob positions
  // Initialise in a group roughly in middle
  // Set grid to 1.0 where a blob is
  posns = malloc(M*sizeof(int));
  for(int ib=0; ib < M; ib++){
    posns[ib] = ((float)N/2.0) - ((float)M/2.0) + (float)ib;
    grid[(int)round(posns[ib])] = 1.0;
  }

  if(show){
    for(int ix=0; ix<N+2; ix++){
      if(grid[ix]>0.0){
        printf("*");
      }else{
        printf(" ");
      }
    }
    printf("\n");
  }

  //Iterate over time
  for(int it = 1; it<= T; it++){

    // Damp out previous forces. If we reset to 0 we get a minimisation
    // If just damp, we get some oscillations
    for(int ix = 1; ix <N+1; ix++){
      forces[ix] = forces[ix] * force_retention;
    }

    // Loop over cells in grid and calculate array of forces at each cell
    for(int ix=1; ix< N+1; ix++){
      // Only apply forces within the domain, but make sure to include those
      // from the edge cells!
      for(int ix_f=0; ix_f< N+2; ix_f++){
        if(ix == ix_f) continue;
        // Force falls off as square of distance
          forces[ix] = forces[ix] + grid[ix_f]/pow((float)(ix-ix_f),2) * copysign(1.0, ix-ix_f);
// NOTE : calculating all the forces like this is inefficient, but suppose for thi
// example that we have a good reason for it! For instance, imagine we really want
// the persistence of the forces or something
      }
    }
    // Zero out grid before moving and re-placing blobs
    memset(grid+1, 0, N * sizeof(float));

    // Push blobs according to forces
    for(int ib=0; ib< M; ib++){
      // Include a factor for how rapidly the "forces" move the "blobs"
      posns[ib] = posns[ib] + forces[(int)round(posns[ib])]*0.9;
      // Forcibly keep in grid
      if(posns[ib] < 1 ) posns[ib] = 1;
      if(posns[ib] > N-1 ) posns[ib] = N-1;
      // Place blob in new position
      grid[(int)round(posns[ib])] = 1.0;
    }
  }

  // Show final state to screen
  if(show){
    for(int ix=0; ix<N+2; ix++){
      if(grid[ix]>0.0){
        printf("*");
      }else{
        printf(" ");
      }
    }
    printf("\n");
  }
}
