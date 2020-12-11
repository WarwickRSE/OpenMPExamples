PROGRAM loop_decompose
  
  USE omp_lib
  IMPLICIT NONE
  INTEGER, PARAMETER :: max_its = 10000
  INTEGER :: nproc, i, thread_id
  INTEGER, DIMENSION(:), ALLOCATABLE :: its_per_proc

  nproc = omp_get_max_threads()
  ALLOCATE(its_per_proc(nproc))
  its_per_proc = 0

!This causes a SEPARATE copy of the variable thread_id
!to be created on each thread
!$OMP PARALLEL DO PRIVATE(thread_id)
  DO i = 1, max_its
    thread_id = omp_get_thread_num() + 1
    its_per_proc(thread_id) = its_per_proc(thread_id) + 1
  END DO
!$OMP END PARALLEL DO

  DO i = 1, nproc
    PRINT '(A, I0, A, I0, A)', 'Processor ', i, ' performed ', &
        its_per_proc(i), ' iterations'
  END DO

 PRINT '(A, I0)','Total work on all processors is ', SUM(its_per_proc)

 DEALLOCATE(its_per_proc)

END PROGRAM loop_decompose
