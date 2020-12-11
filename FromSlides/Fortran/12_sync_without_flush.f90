!NOTE THIS CODE DOESN'T WORK
PROGRAM loop_decompose
  
  USE omp_lib
  IMPLICIT NONE
  INTEGER :: data
  LOGICAL :: flag

  flag = .FALSE.
  data = 0

!$OMP PARALLEL
  IF (omp_get_thread_num() == 0) THEN
    !Thread 0 sets the payload and sets the flag
!$OMP ATOMIC
    data = 42
    flag = .TRUE.
  ELSE
    !On all other threads wait until the flag is set
    DO WHILE(.NOT. flag)
    END DO
    PRINT '(A,I0,A,I0)', 'Thread ', omp_get_thread_num(), ' got payload ', data
  END IF
!$OMP END PARALLEL

END PROGRAM loop_decompose
