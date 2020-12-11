PROGRAM MAIN

  USE omp_lib

  ! Size of grid and number of iterations
  INTEGER, PARAMETER :: N = 10000, T =10
  LOGICAL, DIMENSION(:,:), ALLOCATABLE :: grid, tmp_grid
  INTEGER, DIMENSION(2) :: init_pos
  INTEGER :: it, ix, iy
  INTEGER :: cnt
  LOGICAL :: show = .FALSE.

  ALLOCATE(grid(N,N), tmp_grid(N,N))

  grid = .FALSE.

  !Place a simple structure in the bottom left - this should move
  ! and reform it's shape (called a glider)
  init_pos = [2, N-2]
  grid(init_pos(1)+1:init_pos(1)+3, init_pos(2)) = .TRUE.
  grid(init_pos(1)+3, init_pos(2)+1) = .TRUE.
  grid(init_pos(1)+2, init_pos(2)+2) = .TRUE.


  !Iterate over time
  DO it = 1, T

    ! Loop over grid
    ! Use a temporary for the updated state
    ! Reset this each time
    tmp_grid = .FALSE.
    ! Leave all edge cells unchanged
!$OMP PARALLEL DO PRIVATE(cnt)
   DO ix = 2, N-1
     DO iy = 2, N-1
        ! We need to know how many True neghbours the current location has
        ! The cell itself isn't included in the sum
        cnt = COUNT(grid(ix-1:ix+1, iy-1:iy+1))
        IF(grid(ix, iy)) cnt = cnt -1
        ! The automaton rules can be reduced to this simple condition
        IF((cnt == 2 .AND. grid(ix,iy)) .OR. cnt == 3) tmp_grid(ix, iy) = .TRUE.

      END DO
    END DO
!$OMP END PARALLEL DO
!$OMP WORKSHARE
    grid = tmp_grid
!$OMP END WORKSHARE
  END DO

 IF(show) THEN
    ! Show to screen
    PRINT*, "_________________________________"
    PRINT*, "Time =", it-1
    PRINT*, "_________________________________"
    DO iy = 1, N
      PRINT*, MERGE("*", " ", grid(:,iy))

    END DO
    PRINT*, "_________________________________"
  END IF

END PROGRAM
