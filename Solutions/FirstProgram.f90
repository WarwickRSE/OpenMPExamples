PROGRAM MAIN

  USE omp_lib

  INTEGER, PARAMETER :: T=10000
  INTEGER :: sum
  INTEGER :: i

  sum = 0
  
  ! Simple accumulation loop
  ! (Note in Fortran we can use a built-in for this, but
  ! ignore that for this demo)

!$OMP PARALLEL DO REDUCTION(+:sum)
  DO i = 1, T
    sum = sum + i
  END DO
!$OMP END PARALLEL DO 

  PRINT*, "Loop gave        ", sum

  PRINT*, "Answer should be ", T*(T+1)/2

END PROGRAM
