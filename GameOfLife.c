#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>

int main(){

  const int N=10, T=5;
  bool *grid, *tmp_grid, *tmp_ptr;
  int init_pos[2];
  int cnt;
  bool show = true;

  // Allocate some 1-D arrays - we'll use indexing to make it 2D
  // Initialise to value 0
  grid = calloc(N*N, sizeof(bool));
  tmp_grid = calloc(N*N, sizeof(bool));

  //Place a simple structure in the top left - this should move
  // and reform it's shape (called a glider)
  // Note the indexing we use to get the position right
  init_pos[0] = 2; init_pos[1] = 4;
  grid[init_pos[1]*N + init_pos[0]+1] = 1;
  grid[init_pos[1]*N + init_pos[0]+2] = 1;
  grid[init_pos[1]*N + init_pos[0]+3] = 1;
  grid[(init_pos[1]+1)*N + init_pos[0]+3] = 1;
  grid[(init_pos[1]+2)*N + init_pos[0]+2] = 1;

  //Iterate over time
  for(int it = 1; it<= T; it++){

    // Loop over cells in grid
    // Use a temporary for the updated state
    // Reset this each time
    // Leave all edge cells unchanged
    for(int ix=1; ix< N-1; ix++){
      for(int iy=1; iy< N-1; iy++){
        // We need to know how many True neghbours the current location has
        // The cell itself isn't included in the sum
        cnt = 0;
        if(grid[(iy-1)*N + ix-1]) cnt = cnt + 1;
        if(grid[(iy-1)*N + ix  ]) cnt = cnt + 1;
        if(grid[(iy-1)*N + ix+1]) cnt = cnt + 1;

        if(grid[iy*N     + ix-1]) cnt = cnt + 1;
        if(grid[iy*N     + ix+1]) cnt = cnt + 1;

        if(grid[(iy+1)*N + ix-1]) cnt = cnt + 1;
        if(grid[(iy+1)*N + ix  ]) cnt = cnt + 1;
        if(grid[(iy+1)*N + ix+1]) cnt = cnt + 1;

        // The automaton rules can be reduced to this simple condition
        if((cnt == 2 && grid[iy*N + ix]) || cnt == 3){
          tmp_grid[iy*N + ix] = 1;
        }else{
          tmp_grid[iy*N + ix] = 0;
        }

      }
    }
    // Swap the pointers using a temporary
    tmp_ptr = tmp_grid;
    tmp_grid = grid;
    grid = tmp_ptr;

  }

  // Show final state to screen
  if(show){
    for(int iy=0; iy<N; iy++){
      for(int ix=0; ix<N; ix++){
        if(grid[iy*N + ix]){
          printf("*");
        }else{
          printf(" ");
        }
      }
      printf("\n");
    }
  }
}
