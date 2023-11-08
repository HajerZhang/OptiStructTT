subroutine time_print
       implicit none
       integer, parameter :: output = 6

       ! . local scalars.
       character ( len =  8 ) :: datstr
       character ( len = 10 ) :: timstr

       ! . Get the current date and time.
       call date_and_time ( datstr, timstr )

       ! . Write out the date and time.
       write ( output, "(A)"   ) "-----------------------------------------------------------------"
       write ( output, "(A)", advance = 'no') "  Date = " //datstr(7:8) // "/" // datstr(5:6) // "/" // datstr(1:4)
       write ( output, "(A)") "  Time = " //timstr(1:2) // ":" // timstr(3:4) // ":" // timstr(5:10)
       write ( output, "(A)", advance = 'no') "-----------------------------------------------------------------"
       write ( output, *)

end subroutine time_print