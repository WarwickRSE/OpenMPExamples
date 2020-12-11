PROGRAM hello_world

  USE omp_lib

  CALL omp_set_num_threads(4)

  PRINT *, 'Hello world from the main program'

  !$OMP PARALLEL
    PRINT '(A,I0)','Hello world! I am processor ', omp_get_thread_num()
  !$OMP END PARALLEL

END PROGRAM hello_world
