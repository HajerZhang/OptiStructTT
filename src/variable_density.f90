subroutine variable_density
    use global
    implicit none
    real(8) density_low,density_up,spacing
    integer num_spacing,i
    real(8) density_2

    density_low = 0.1d0
    density_up = 0.3d0
    num_spacing = 50

    spacing = density_up - density_low
    spacing = spacing / num_spacing
    if(optimization_criterion.eq.1)then
        open(104,file="data\density\FullStressMethod\data.txt")
    elseif(optimization_criterion.eq.2)then
        open(104,file="data\density\ZigzagMethod\data.txt")
    elseif(optimization_criterion.eq.3)then
        open(104,file="data\density\GraphicMethod\data.txt")
    endif
    write(104,'(A)')"density of truss 2        weight"
    do i = 0, num_spacing
        density_2 = density_low + spacing * i
        rho_2 = density_2

        if(optimization_criterion.ne.3) then
            call single_step
        else if(optimization_criterion.eq.3) then
            call single_step_extra
        endif

        write(*,"(A)")"-----------------------------------------------------------------"
        write(*,"(A)")"The density of ", density_2 ," is finished."
        write(*,"(A)")"-----------------------------------------------------------------"

        write(104,*)density_2,optimal_weight
    enddo
    close(104)

end subroutine variable_density
