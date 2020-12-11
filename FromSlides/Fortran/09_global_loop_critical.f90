PROGRAM loop_decompose
  
  USE omp_lib
  IMPLICIT NONE
  INTEGER, PARAMETER :: max_its = 10000
  INTEGER :: i, its_global


its_global = 0
!$OMP PARALLEL DO
  DO i = 1, max_its
!The critical section ensures that only one thread can be in it at a time
!this makes the incrementing of its_global safe
!$OMP CRITICAL
    its_global = its_global + 1
!$OMP END CRITICAL
  END DO
!$OMP END PARALLEL DO

PRINT '(A,I0,A)','Counter records ', its_global, ' iterations'

END PROGRAM loop_decompose
