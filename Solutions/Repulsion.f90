PROGRAM MAIN

  USE omp_lib

  ! Size of grid and number of iterations
  INTEGER, PARAMETER :: N = 30000, T =10
  INTEGER, PARAMETER :: M = 5 ! DO NOT change M without changing setup below!
  REAL, DIMENSION(:), ALLOCATABLE :: grid, forces 
  REAL, DIMENSION(:), ALLOCATABLE :: posns
  INTEGER :: it, ix, ib, ix_f
  LOGICAL :: show = .FALSE.
  REAL :: force_retention = 0.1

  ! Grid of "potential" and grid for forces
  ! Use spare cells on potential grid that never update
  ALLOCATE(grid(0:N+1), forces(N))
  ALLOCATE(posns(5))

  grid = 0.0

  ! Make all grid edges value 1
  grid(0)   = 1.0
  grid(N+1) = 1.0

  ! Pick some "random" positions for the M blobs
  ! And place blobs on grid
  DO ib = 1, M
    posns(ib) = (REAL(N)/2.0) - (REAL(M)/2.0) + REAL(ib)
    grid(NINT(posns(ib))) = 1.0
  END DO


  IF(show) THEN
  ! Show to screen
    PRINT*, "_________________________________"
    PRINT*, "Time =", 0
    PRINT*, "_________________________________"
    PRINT*, MERGE('*', ' ', grid(:) > 0.0)
    PRINT*, "_________________________________"
  END IF


  !Iterate over time
  DO it = 1, T

    ! Damp out previous forces. If we reset to 0 we get a minimisation
    ! If just damp, we get some oscillations
!$OMP PARALLEL DO 
    DO ix = 1, N
      forces(ix) = forces(ix) * force_retention
    END DO
!$OMP END PARALLEL DO
    ! Only apply forces within the domain, but make sure to include those
    ! from the edge cells!
!$OMP PARALLEL DO SCHEDULE(static, 1)
    DO ix = 1, N
       DO ix_f = 0, N+1
            IF(ix == ix_f) CYCLE
            ! Force falls off as square of distance
            forces(ix) = forces(ix) + grid(ix_f)/REAL(ix-ix_f)**2 &
                    * SIGN(1, ix-ix_f)
! NOTE : calculating all the forces like this is inefficient, but suppose for thi
! example that we have a good reason for it! For instance, imagine we really want
! the persistence of the forces or something
        END DO
    END DO
!$OMP END PARALLEL DO
   ! Zero out grid before moving and re-placing blobs
    grid(1:N) = 0.0

    ! Push blobs according to forces
    DO ib = 1, M
      ! Include a factor for how rapidly the "forces" move the "blobs"
      posns(ib) = posns(ib) + forces(NINT(posns(ib)))*0.9
      ! Forcibly keep in grid
      IF(posns(ib) < 1 ) posns(ib) = 1
      IF(posns(ib) >= N ) posns(ib) = N

      ! Place blob in new position
      grid(NINT(posns(ib))) = 1.0
    END DO

    IF(show) THEN
      ! Show to screen
            PRINT*, "_________________________________"
            PRINT*, "Time =", it
            PRINT*, "_________________________________"
            PRINT*, MERGE('*', ' ', grid(:) > 0.0)
            PRINT*, "_________________________________"
    END IF

  END DO

END PROGRAM
