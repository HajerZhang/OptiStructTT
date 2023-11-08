subroutine adjust_parameter
    use global
    implicit none
    real(8) max_stress_ratio_1,max_stress_ratio_2,max_stress_ratio
    real(8) stress_adjust_1,stress_adjust_2
    real(8) adjust_stress_ratio_1,adjust_stress_ratio_2
    
    max_stress_ratio_1 = 0
    max_stress_ratio_2 = 0

    do load_case=1,num_load_case
        if(stress_1(load_case).le.0) then
            stress_ratio_1(load_case) = stress_1(load_case)/allow_stress_1_low
        else
            stress_ratio_1(load_case) = stress_1(load_case)/allow_stress_1_up
        endif
        if(stress_2(load_case).le.0) then
            stress_ratio_2(load_case) = stress_2(load_case)/allow_stress_2_low
        else
            stress_ratio_2(load_case) = stress_2(load_case)/allow_stress_2_up
        endif
    enddo
    
    do load_case=1,num_load_case
        if(stress_ratio_1(load_case).gt.max_stress_ratio_1)then
            max_stress_ratio_1 = stress_ratio_1(load_case)
        endif
        if(stress_ratio_2(load_case).gt.max_stress_ratio_2)then
            max_stress_ratio_2 = stress_ratio_2(load_case)
        endif
    enddo

    ratio_1 = max_stress_ratio_1
    ratio_2 = max_stress_ratio_2

    if(optimization_criterion.eq.1)then
        area_1 = area_1*max_stress_ratio_1
        area_2 = area_2*max_stress_ratio_2
    elseif(optimization_criterion.eq.2)then
        max_stress_ratio = max(max_stress_ratio_1,max_stress_ratio_2)
        area_adjust_1 = max_stress_ratio * area_1
        area_adjust_2 = max_stress_ratio * area_2
        stress_adjust_1 = stress_1(1) / max_stress_ratio
        stress_adjust_2 = stress_2(1) / max_stress_ratio
        if(stress_1(1).le.0) then
            adjust_stress_ratio_1 = stress_adjust_1/allow_stress_1_low
        else
            adjust_stress_ratio_1 = stress_adjust_1/allow_stress_1_up
        endif
        if(stress_2(1).le.0) then
            adjust_stress_ratio_2 = stress_adjust_2/allow_stress_2_low
        else
            adjust_stress_ratio_2 = stress_adjust_2/allow_stress_2_up
        endif
        area_1 = area_adjust_1 * adjust_stress_ratio_1
        area_2 = area_adjust_2 * adjust_stress_ratio_2
    endif
end subroutine adjust_parameter