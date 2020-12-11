PROGRAM single_thread

  USE omp_lib

 !$OMP PARALLEL
    PRINT *,'Parallel from thread ', omp_get_thread_num()
 !$OMP SINGLE
    PRINT *,'Single from thread ', omp_get_thread_num()
 !$OMP END SINGLE
 !$OMP END PARALLEL

END PROGRAM single_thread
