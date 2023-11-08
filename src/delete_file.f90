subroutine delete_file
    implicit none

    call system("rm RunAbaqus.bat")
    call system("rm task.*")
    
end subroutine delete_file