subroutine single_step
    use global
    implicit none

    interface
    pure function to_string(var) result(str)
        implicit none
        class(*),     intent(in)  :: var
        character(:), allocatable :: str
    end function to_string
    end interface

    real(8) det_area_1, det_area_limit, area_1_old, area_2_old
    integer iteration
    real(8) old_weight

    area_1 = 1.d0
    area_2 = 1.d0
    
    det_area_1 = 1.d0
    det_area_limit = 0.001

    total_weight = area_1*100*sqrt(2.0)*rho_1*2 + area_2*100*rho_2
    optimal_weight = total_weight

    if(task_setting.eq.0)then
        if(optimization_criterion.eq.1)then
            open(103,file = "data\default\FullStressMethod.txt")
        elseif(optimization_criterion.eq.2)then
            open(103,file = "data\default\ZigzagMethod.txt")
        endif
    elseif(task_setting.eq.1)then
        if(optimization_criterion.eq.1)then
            open(103,file = "data\density\FullStressMethod\Process\result_"//to_string(rho_2)//".txt")
        elseif(optimization_criterion.eq.2)then
            open(103,file = "data\density\ZigzagMethod\Process\result_"//to_string(rho_2)//".txt")
        endif
    elseif(task_setting.eq.2)then
        if(optimization_criterion.eq.1)then
            open(103,file = "data\Stress\FullStressMethod\Process\result_"//to_string(allow_stress_2_up)//".txt")
        elseif(optimization_criterion.eq.2)then
            open(103,file = "data\Stress\ZigzagMethod\Process\result_"//to_string(allow_stress_2_up)//".txt")
        endif
    endif

    if(optimization_criterion.eq.1)then
        write(103,'(A)')"iteration  area_1  area_2  ratio_1  ratio_2  total_weight"
    elseif(optimization_criterion.eq.2)then
        write(103,'(A)', advance = 'no')"iteration area_1 area_2 "
        write(103,'(A)')"adjust_area_1 adjust_area_2 total_weight"
    endif

    iteration=0

    do
        do load_case = 1, num_load_case
            call initial_file

            call system("RunAbaqus.bat")

            call read_output

            call delete_file
        enddo    

        area_1_old = area_1
        area_2_old = area_2

        call adjust_parameter
        
        old_weight = total_weight
        det_area_1 = abs(area_1_old-area_1)
        
        if(optimization_criterion.eq.1)then
            total_weight = area_1*100*sqrt(2.0)*rho_1*2.0 + area_2*100*rho_2
        elseif(optimization_criterion.eq.2)then
            total_weight = area_adjust_1*100*sqrt(2.0)*rho_1*2.0 + area_adjust_2*100*rho_2
        endif

        if(optimization_criterion.eq.1) then
            optimal_weight = old_weight 
        elseif(optimization_criterion.eq.2) then
            optimal_weight = old_weight
        endif

        if(optimization_criterion.eq.1)then
            write(103,202)iteration, area_1_old, area_2_old, ratio_1, ratio_2, old_weight
        elseif(optimization_criterion.eq.2)then
            write(103,202)iteration, area_1_old, area_2_old, area_adjust_1, area_adjust_2, total_weight
202 FORMAT(I9, 5(1X, F11.7))
        endif

        iteration = iteration + 1

        if(optimization_criterion.eq.1)then
            if(det_area_1.lt.det_area_limit) exit
        elseif(optimization_criterion.eq.2)then
            if(total_weight.ge.old_weight.and.iteration.ne.1) exit
        endif
        
    enddo

        write(*,*)optimal_weight
    close(103)


end subroutine single_step

subroutine single_step_extra
    use global
    implicit none

    interface
    pure function to_string(var) result(str)
        implicit none
        class(*),     intent(in)  :: var
        character(:), allocatable :: str
    end function to_string
    end interface

    integer i,j
    real(8) a1,a2
    real(8) a1_min,a1_max,a2_min,a2_max
    integer a1_step,a2_step
    real(8) op_weight,op_a1,op_a2
    real(8) weight

    a1_min = 0.d0
    a1_max = 1.d0
    a2_min = 0.d0
    a2_max = 1.d0
    a1_step = 1000
    a2_step = 1000
    
    op_weight = area_1*100*sqrt(2.0)*rho_1*2 + area_2*100*rho_2

    if(task_setting.eq.0)then
        open(103,file = "data\default\GraphicMethod.txt")
    endif

    if(optimization_criterion .eq. 3)then
        do i = 0, a1_step
            do j = 0, a2_step

                a1 = a1_min + i*(a1_max-a1_min)/a1_step
                a2 = a2_min + j*(a2_max-a2_min)/a2_step

                if( 2000*(a2+2**(0.5)*a1)/(2**(0.5)*a1**2+2*a1*a2) <= 2000 &
                .and. 2000*2**(0.5)*a1/(2**(0.5)*a1**2+2*a1*a2) <= allow_stress_2_up &
                .and. -2000*a2/(2**(0.5)*a1**2+2*a1*a2) >= -1500 &
                ! .and. 2000/(2**(0.5)*a1+2*a2) <= 2000 &
                ! .and. 2*2000/(2**(0.5)*a1+2*a2) <= allow_stress_2_up &
                )then

                    weight = a1*100*sqrt(2.0)*rho_1*2 + a2*100*rho_2
                    if(weight .lt. op_weight)then
                        op_weight = weight
                        op_a1 = a1
                        op_a2 = a2
                    endif

                endif
            enddo
        enddo
        if(task_setting.eq.0)then
            write(103,'(A)')"area_1  area_2 total_weight"
            write(103,*)a1, a2, op_weight
        endif
        
        optimal_weight = op_weight
        if(task_setting .eq. 0) &
        write(*,"(A)")"The standard theoretical solution is "// &
                     to_string(op_weight) //" obtained by the graphical method"
    endif
    close(103)

end subroutine single_step_extra

pure function to_string(var) result(str)
        implicit none
        class(*),     intent(in)  :: var
        character(:), allocatable :: str
        character(len=128)        :: buffer

        select type(var)
        type is (integer)
            write(buffer, *) var
            str = trim(adjustl(buffer))
        type is (real(8))
            write(buffer, *) var
            str = trim(adjustl(buffer))
            str = str(1:7)
        type is (real(4))
            write(buffer, *) var
            str = trim(adjustl(buffer))
        type is (logical)
            write(buffer, *) var
            str = trim(adjustl(buffer))
        end select

end function to_string


