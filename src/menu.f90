subroutine output_menu
    use global
    implicit none
    integer i
    character(len = 65) str
    character index_word

    do i = 1, 18
        open(100,file="ReadMe.txt")
        read(100,'(A65)')str
        write(*,'(A65)')str
    enddo

    write(*,"(A)")"  This program will optimize the structural of a three-bar truss "
    write(*,"(A)")"  please select the optimization criterion: "
    write(*,"(A)")"-----------------------------------------------------------------"
11  write(*,"(A)")"  1 --- full stress design criterion "
    write(*,"(A)")"  2 --- zigzag method "
    write(*,"(A)")"  3 --- graphic method "
    write(*,"(A)")"  q --- quit "
    write(*,"(A)")"  (Please enter the numer)"
    write(*,"(A)")"-----------------------------------------------------------------"

    read(*,*)index_word

    if(index_word.eq.'1')then
        optimization_criterion = 1
    elseif(index_word.eq.'2')then
        optimization_criterion = 2
    elseif(index_word.eq.'3')then
        optimization_criterion = 3
    elseif(index_word.eq.'q')then 
        task_setting = 9   
        go to 33
    else
        write(*,"(A)")"-----------------------------------------------------------------"
        write(*,"(A)")"  Input error please re-enter:"
        write(*,"(A)")"-----------------------------------------------------------------"
        goto 11
    endif

    write(*,"(A)")"-----------------------------------------------------------------"
    write(*,"(A)")"  Please set task goals"
    write(*,"(A)")"-----------------------------------------------------------------"
22  write(*,"(A)")"  0 --- Optimize with default parameters "
    write(*,"(A)")"  1 --- Optimization varies with density "
    write(*,"(A)")"  2 --- Optimization varies with allowable stress "
    write(*,"(A)")"  q --- quit " 
    write(*,"(A)")"  (Please enter the numer)"
    write(*,"(A)")"-----------------------------------------------------------------"

    read(*,*)index_word
    if(index_word.eq.'0')then
        task_setting = 0
    elseif(index_word.eq.'1')then
        task_setting = 1
    elseif(index_word.eq.'2')then
        task_setting = 2
    elseif(index_word.eq.'q')then
        task_setting = 9
    else
        write(*,"(A)")"-----------------------------------------------------------------"
        write(*,"(A)")"  Input error please re-enter:"
        write(*,"(A)")"-----------------------------------------------------------------"
        goto 22
    endif

33  if(index_word.ne.'q')then
        write(*,"(A)")"-----------------------------------------------------------------"
        write(*,"(A)")"  The calculation will begin in 3s . Please wait for the result  "
        write(*,"(A)")"-----------------------------------------------------------------"
        call sleep(3)
    endif
        
end subroutine output_menu

subroutine check_result

    write(*,"(A)")"-----------------------------------------------------------------"
    write(*,"(A)")'  Program is over, Please check resule in file "data" '
    write(*,"(A)")"-----------------------------------------------------------------"

end subroutine check_result