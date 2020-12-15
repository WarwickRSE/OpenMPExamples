PROGRAM hello
  USE OMP_LIB
  IMPLICIT NONE
  PRINT *, "Hello in different sections"
!$OMP PARALLEL
!$OMP SECTIONS
    !$OMP SECTION
    PRINT *, "Hello ", omp_get_thread_num()
    !$OMP SECTION
    PRINT *, "Olá ", omp_get_thread_num()
    !$OMP SECTION
    PRINT *, "Hola", omp_get_thread_num()
    !$OMP SECTION
    PRINT *, "Heghlu'meH QaQ jajvam", omp_get_thread_num()
!$OMP END SECTIONS
!$OMP END PARALLEL
END PROGRAM hello
