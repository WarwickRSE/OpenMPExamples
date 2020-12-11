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
    data = 42
    flag = .TRUE.
    !Flush both the data and the flag to main memory
    !It is important that you do both here!
    !$OMP FLUSH (data,flag)
  ELSE
    !On all other threads wait until the flag is set
    DO WHILE(.NOT. flag)
      !This is the code that actually sychronises the flag variable
      !$OMP FLUSH(flag)
    END DO
    !Now synchronize the payload
    !$OMP FLUSH(data)
    PRINT '(A,I0,A,I0)', 'Thread ', omp_get_thread_num(), ' got payload ', data
  END IF
!$OMP END PARALLEL

END PROGRAM loop_decompose
