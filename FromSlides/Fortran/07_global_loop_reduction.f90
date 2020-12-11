PROGRAM loop_decompose
  
  USE omp_lib
  IMPLICIT NONE
  INTEGER, PARAMETER :: max_its = 10000
  INTEGER :: i, its_global


its_global = 0
!$OMP PARALLEL DO REDUCTION(+:its_global)
  DO i = 1, max_its
  !Reduction means that its_global is recorded separately
   !on each thread and then combined between all threads by using
   !a reduction operator (here +) at the end
    its_global = its_global + 1
  END DO
!$OMP END PARALLEL DO

PRINT '(A,I0,A)','Counter records ', its_global, ' iterations'

END PROGRAM loop_decompose
