module global
    implicit none
    integer num_load_case
    integer load_case
    integer optimization_criterion
    integer task_setting

    real(8) area_1, area_2
    real(8) area_adjust_1,area_adjust_2
    real(8) rho_1, rho_2
    real(8) total_weight
    real(8) allow_stress_1_low, allow_stress_1_up
    real(8) allow_stress_2_low, allow_stress_2_up
    real(8),allocatable :: stress_1(:), stress_2(:)
    real(8),allocatable :: stress_ratio_1(:), stress_ratio_2(:)

    real(8) optimal_weight
    real(8) ratio_1,ratio_2
end module global