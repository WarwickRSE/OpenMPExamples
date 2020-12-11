PROGRAM loop_decompose
  
  USE omp_lib
  IMPLICIT NONE
  INTEGER :: thread_id
  INTEGER, DIMENSION(:), ALLOCATABLE :: work_id

  ALLOCATE(work_id(omp_get_max_threads() * 2))
  !$OMP PARALLEL PRIVATE(thread_id)
    thread_id = omp_get_thread_num()
    !$OMP WORKSHARE
    work_id = thread_id
    !$OMP END WORKSHARE
  !$OMP END PARALLEL

  PRINT *, work_id

END PROGRAM loop_decompose
