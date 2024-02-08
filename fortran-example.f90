!> \file fortran-example.f90  Some example Fortran code.
!! 
!! MvdS, 2024-02-07: initial version
!!
!! \note
!! - You can compile and run this on most systems with:
!!   - gfortran -Wall -Wextra -o fortran-example fortran-example.f90  # Compile an print any warnings
!!   - ./fortran-example  # Run
!!
!! - The notation used in this block can be turned into documentation by the Doxygen program.


!> \brief A main program (the name doesn't really matter - there can only be one program anyway...)
program fortran_example
  implicit none  ! Make sure you have to define all your variables to avoid surprises.
  ! (There's a reason why Fortran is 100.000x faster than Excel and 1000x faster than Python...)
  
  integer :: multiply, intvar,  product,power  ! Declare some variables
  
  ! Comments follow an exclamation mark
  
  ! Let's do some printing to screen (stdout):
  call print_stuff()  ! (we use a subroutine here and explain them below)
  
  
  ! A function can return a single variable (may be an array):
  intvar = multiply(2,3)
  print*,'Multiply:', intvar, multiply(3,4)
  
  ! A subroutine has no type, must be CALLed and can return multiple variables:
  call product_and_power(2,3, product,power)
  print*,'Product and power:', product,power
  
  ! Now that we know about routines, lets use them to structure our stuff:
  call if_statements_and_do_loops()

end program fortran_example


!> \brief Example  printing to screen (stdout).
subroutine print_stuff()
  implicit none
  real :: single_precision_variable
  real(8) :: double_precision_variable, array(10)
  
  ! Text:
  print*,'Unformatted print statement'
  print*
  
  ! Floating point: differentiate between single and double precision!
  single_precision_variable = 4*atan(1.0)    ! No annotation: single precision
  double_precision_variable = 4*atan(1.0d0)  ! The 'd' is like 'e' for exponential, but double precision
  print*, single_precision_variable, ' <- Note how the last ~two digits are off!          ', double_precision_variable
  double_precision_variable = 4*atan(1.0)    ! Oops... - you're using a single-precision variable as input...
  print*, 'Note the precision loss because you used a single-precision value! ->', double_precision_variable
  print*, 'Also note that this is not true when multiplying a real with an integer, because integers are "infinitely accurate.'
  print*, 'The same is true for float**power.  Integer division is a different thing though.'
  
  print*
  
  ! Line continuation:
  print*, 'Even for modern Fortran, try to stay within 132 characters of line length...', &
       '  If you need more, use the ampersand as a continuation character.'
  print*, 'Even for modern Fortran, try to stay within 132 characters of line len'// &
       'gth...  You can concatenate two strings into one with the // operator.'
  
  ! Formatted output:
  write(*,'(A, 5x, 2I3,F6.2, ES20.12)') 'You can also write formatted output: ', 1,2, 1.0, -1.234d56  ! Note: 1.e56 would't work - doesn't fit in single precision!
  print*, 'Format: A(scii), I(nteger), F(loat), ES(exponential/scientific), x: space.   Note: 2I3 = I3,I3'
  write(*,'(A)') 'The asterisk (*) stand for standard output, 0 is standard error, and 5 is (usually) standard in (for reading).'
  print*
  
  ! Array:
  array = [1,2,3,4,5,6,7,8,9,0]
  print*,array
  write(*,'(A,10F6.2)') 'Formatting can render readable, use multiplier 10 for this array: ', array
  write(*,'(//,A,////)') 'Add some line breaks...'
end subroutine print_stuff

  


!> \brief Example function
function multiply(x,y)
  implicit none
  integer, intent(in) :: x,y  ! Use intent(in) for input variables to help the optimiser
  integer :: multiply         ! The function itself must be declared to the type it returns - here and in the caller routine!
  multiply = x*y
end function multiply


!> \brief Example subroutine
subroutine product_and_power(x,y, prod,pow)
  implicit none
  integer, intent(in) :: x,y  ! Use intent(in) for input variables
  integer, intent(out) :: prod,pow  ! Use intent(out) for output variables
  prod = x*y
  pow = x**y  ! x^y - comment out this line, compile with -Wall and -Wextra and see what happens...
  
  return  ! Return to the caller routine
  
  print*,"Don't print this, because we just returned!"
end subroutine product_and_power


subroutine if_statements_and_do_loops()
  implicit none
  integer :: iter

  do iter=1,10  ! Do loops are like for loops
     if(iter == 1) print*,iter, ': one!'  ! Single if - brackets required
     
     if(iter == 2 .or. iter == 3) then  ! if - then for multiple lines or multiple options
        print*,iter,': more than one!'
        print*,'(and more than one line...)'
     else if(iter >= 5 .and. iter <= 6) then
        cycle                   ! Cycle (skip) to the next iteration
     else if(iter >= 8) then
        if(iter == 9) exit      ! Exit the loop completely (use stop to exit the program)
        print*,iter,': a lot!'
     else
        continue  ! Does nothing (well, it continues to the next line, as it says), like Python pass
        !           (and unlike Python's continue, which does NOT continue...!)
        print*,iter
     end if
  end do
  
  print*
  
  iter = 1
  do while(iter<3)
     print*,iter
     iter = iter + 1  ! No ++ or +=... :-(
  end do
  
end subroutine if_statements_and_do_loops

  
