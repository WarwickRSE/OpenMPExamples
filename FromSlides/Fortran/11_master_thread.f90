PROGRAM single_thread

  USE omp_lib

 !$OMP PARALLEL
    PRINT *,'Parallel from thread ', omp_get_thread_num()
 !$OMP MASTER
    PRINT *,'Master from thread ', omp_get_thread_num()
 !$OMP END MASTER
 !$OMP END PARALLEL

END PROGRAM single_thread
