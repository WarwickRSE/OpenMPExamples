PROGRAM loop_decompose
  
  USE omp_lib
  IMPLICIT NONE
  INTEGER, PARAMETER :: max_its = 10000
  INTEGER :: i, its_global

  its_global = 0
!$OMP PARALLEL DO
  DO i = 1, max_its
!The atomic section means that operations in this section
!cannot be interrupted by other threads. Only certain
!mathematical operations can be performed in an atomic section
!$OMP ATOMIC
    its_global = its_global + 1
!$OMP END ATOMIC
  END DO
!$OMP END PARALLEL DO

PRINT '(A,I0,A)','Counter records ', its_global, ' iterations'

END PROGRAM loop_decompose
