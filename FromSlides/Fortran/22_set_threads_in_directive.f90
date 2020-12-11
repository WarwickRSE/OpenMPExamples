PROGRAM hello_world

  USE omp_lib
  INTEGER :: n_threads = 6

  PRINT *, 'Hello world from the main program'

  !$OMP PARALLEL NUM_THREADS(n_threads)
    PRINT '(A,I0)','Hello world! I am processor ', omp_get_thread_num()
  !$OMP END PARALLEL

END PROGRAM hello_world
