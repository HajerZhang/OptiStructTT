subroutine read_output
    use global
    implicit none
    character(len=20) index_word
    integer a,b

    open(102,file = "task.dat")

    do while(index_word.ne."ELEMENT")
        read(102,*) index_word
    end do

    read(102,*)
    read(102,*) 
    read(102,*)a,b,stress_2(load_case)
    read(102,*)a,b,stress_1(load_case)
    close(102)
    
end subroutine read_output