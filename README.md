# What are these files

These are the code files for WarwickRSEs OpenMP workshop. Here
you will find the following:

* A HelloWorld example program in C and Fortran. We'll use this to check you can compile OMP programs in the morning session
* an Exercises.pdf sheet to work through in the exercises session
* example code files that go with this sheet
* a Solutions directory containing example solutions to these
* a FromSlides directory containing all the code examples from the slides

# C or Fortran

Pick your favorite, or whichever is most familiar. If torn, we recommend
Fortran as arrays are easier and OpenMP is more natural. 

## C Standard
We use C99, and you may need to add something like '-std=c99' to your compile
line. Some of the examples also need the math library ('-lm')

## Fortran Standard
The Fortran codes have been left simple so will work with any modern Fortran
compiler that is OMP aware. You shouldn't need to specify anything to compile
the codes, just '-fopenmp' for the OpenMP variants

