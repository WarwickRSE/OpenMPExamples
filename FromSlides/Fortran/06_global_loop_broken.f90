!THIS PROGRAM DOESN'T WORK PROPERLY
PROGRAM loop_decompose
  
  USE omp_lib
  IMPLICIT NONE
  INTEGER, PARAMETER :: max_its = 10000
  INTEGER :: i, its_global


its_global = 0
!$OMP PARALLEL DO
  DO i = 1, max_its
    !Two threads trying to update this simultaneously won't work properly
    !because updating the variable isn't instantaneous
    its_global = its_global + 1
  END DO
!$OMP END PARALLEL DO

PRINT '(A,I0,A)','Counter records ', its_global, ' iterations'

END PROGRAM loop_decompose
