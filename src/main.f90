program main
    use global
    implicit none
    
    call time_print

    call initial_parameter
    
    call output_menu

    if(task_setting.eq.0)then
        if(optimization_criterion.ne.3)then
            call single_step
        else if(optimization_criterion.eq.3)then
            call single_step_extra
        endif
    elseif(task_setting.eq.1)then
        call variable_density
    elseif(task_setting.eq.2)then
        call variable_allowable_stress
    endif

    call check_result

    call time_print
    
    write(*,"(A)")"-----------------------------------------------------------------"
    write(*,"(A)")'  Enter to exit ...'
    write(*,"(A)")"-----------------------------------------------------------------"
    read(*,*)

end program main