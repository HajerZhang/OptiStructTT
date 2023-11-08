subroutine initial_parameter
    use global
    implicit none

    num_load_case = 2
    optimization_criterion = 2

    area_1 = 1.d0
    area_2 = 1.d0
    rho_1 = 0.1
    rho_2 = 0.1
    allow_stress_1_low = -1500.d0
    allow_stress_1_up = 2000.d0
    allow_stress_2_low = -1500.d0
    allow_stress_2_up = 2000.d0

    total_weight = area_1*100*sqrt(2.0)*rho_1*2 + area_2*100*rho_2
    optimal_weight = total_weight
    
    allocate(stress_1(num_load_case), stress_2(num_load_case), source = 0.d0)
    
    allocate(stress_ratio_1(num_load_case), source = 0.d0)
    allocate(stress_ratio_2(num_load_case), source = 0.d0)
    
end subroutine initial_parameter

