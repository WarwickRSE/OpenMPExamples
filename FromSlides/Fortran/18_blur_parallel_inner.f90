MODULE blurmod
  IMPLICIT NONE
  CONTAINS

  SUBROUTINE blur(image, its)

    INTEGER, DIMENSION(0:,0:), INTENT(INOUT) :: image
    INTEGER, INTENT(IN) :: its
    INTEGER :: ix, iy, iit, UB1, UB2
    INTEGER, DIMENSION(:,:), ALLOCATABLE :: temp

    ALLOCATE(temp, SOURCE = image)

    UB1 = UBOUND(image,2) - 1
    UB2 = UBOUND(image,1) - 1

!$OMP PARALLEL PRIVATE(iit, iy)
    DO iit = 1, its
      DO iy = 1, UB1
!$OMP DO
        DO ix = 1, UB2
          temp(ix,iy) = INT(0.25 * REAL(image(ix+1,iy) + image(ix-1,iy) &
              + image(ix,iy+1) + image(ix,iy-1)))
        END DO
!$OMP END DO
      END DO
!$OMP WORKSHARE
      image = temp
!$OMP END WORKSHARE
    END DO
!$OMP END PARALLEL

  END SUBROUTINE blur
END MODULE blurmod


PROGRAM omptest

  USE blurmod
  USE omp_lib
  IMPLICIT NONE
  INTEGER, DIMENSION(0:1001, 0:1001) ::image
  INTEGER :: t1, t2
  REAL :: tick

  image = 5
  PRINT '(A,I0,A)','OpenMP code running on ', omp_get_max_threads(), ' threads'
  CALL SYSTEM_CLOCK(COUNT_RATE = tick)
  CALL SYSTEM_CLOCK(COUNT=t1)
  CALL blur(image, 10000)
  CALL SYSTEM_CLOCK(COUNT=t2)
  PRINT '(A,F5.2,A)','Time taken was ',REAL(t2-t1)/tick, ' seconds'
  PRINT '(A,I0)', 'Maximum of image was ', MAXVAL(image)
  PRINT '(A)', 'Maximim value printed to avoid compiler optimising the blur out'

END PROGRAM omptest
