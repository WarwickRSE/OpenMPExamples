PROGRAM loop_decompose
  
  USE omp_lib
  IMPLICIT NONE
  INTEGER, PARAMETER :: max_its = 10000
  INTEGER :: nproc, i, thread_id
  INTEGER, DIMENSION(:), ALLOCATABLE :: its_per_proc

  nproc = omp_get_max_threads()
  ALLOCATE(its_per_proc(nproc))
  its_per_proc = 0

!$OMP PARALLEL DO
  DO i = 1, max_its
    its_per_proc(omp_get_thread_num()+1) = its_per_proc(omp_get_thread_num()+1)&
        + 1
  END DO
!$OMP END PARALLEL DO

  DO i = 1, nproc
    PRINT '(A, I0, A, I0, A)', 'Processor ', i, ' performed ', &
        its_per_proc(i), ' iterations'
  END DO

 PRINT '(A, I0)','Total work on all processors is ', SUM(its_per_proc)

 DEALLOCATE(its_per_proc)

END PROGRAM loop_decompose
