subroutine variable_allowable_stress
    use global
    implicit none
    real(8) allostress_low,allostress_up,spacing
    integer num_spacing,i
    real(8) allostress_2

    allostress_low = 1000
    allostress_up = 3000
    num_spacing = 50

    spacing = allostress_up - allostress_low
    spacing = spacing / num_spacing

    if(optimization_criterion.eq.1)then
        open(105,file="data\Stress\FullStressMethod\data.txt")
    elseif(optimization_criterion.eq.2)then
        open(105,file="data\Stress\ZigzagMethod\data.txt")
    elseif(optimization_criterion.eq.3)then
        open(105,file="data\Stress\GraphicMethod\data.txt")
    endif

    write(105,'(A)')"alloStress of truss 2     weight"

    do i = 0, num_spacing
        allostress_2 = allostress_low + spacing * i
        allow_stress_2_up = allostress_2

        if(optimization_criterion.ne.3) then
            call single_step
        else if(optimization_criterion.eq.3) then
            call single_step_extra
        endif
        write(*,"(A)")"-----------------------------------------------------------------"
        write(*,*)"The allowable_stress of ", allostress_2 ," is finished."
        write(*,"(A)")"-----------------------------------------------------------------"
        write(105,*)allostress_2,optimal_weight
    enddo

    close(105)


    
end subroutine variable_allowable_stress