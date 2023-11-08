-----------------------------------------------------------------
   __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ 
  |       ____  _                   _                         |
  |      / ___|| |_ _ __ _   _  ___| |_ _ __ _   _  ___       |
  |      \___ \| __| '__| | | |/ __| __| '__| | | |/ _ \      |
  |       ___) | |_| |  | |_| | (__| |_| |  | |_| |  __/      |
  |      |____/ \__|_|   \__,_|\___|\__|_|   \__,_|\___|      |
  |              _   _           _          _   _             |
  |   ___  _ __ | |_(_)_ __ ___ (_)______ _| |_(_) ___  _ __  |
  |  / _ \| '_ \| __| | '_ ` _ \| |_  / _` | __| |/ _ \| '_ \ |
  | | (_) | |_) | |_| | | | | | | |/ / (_| | |_| | (_) | | | ||
  |  \___/| .__/ \__|_|_| |_| |_|_/___\__,_|\__|_|\___/|_| |_||
  |       |_|                                                 |
  |__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __|

-----------------------------------------------------------------
  version: 1.1  
  The copyright belongs to IDEAS, 2023， DLUT.                                                 
----------------------------------------------------------------- 
  This program will optimize the structural of a three-bar truss,
through two optimization criteria, the full stress criterion and 
the zigzag method. Each iteration process is calculated by Abaqus
and the results that the optimization varies with the density and
the allowable stress of the truss are given.
----------------------------------------------------------------- 
environmental dependence:
  Abaqus 2022
  python
  matplotlib
  libgcc_s_seh-1.dll
  libquadmath-0.dll
----------------------------------------------------------------- 
deployment:
 1. Add the abaqus system environment variable
    OR 
    Change "Abaqus" in file='./batchfile/RunAbaqus.bat' to the 
    path of Abaqus

 2. "make"

 3. Run ".\build\StrucOpti.exe"(win)
----------------------------------------------------------------- 
Content:
├──  StrucOpti.exe
├── ReadMe.txt                            // help    
├── plot.py                               // plot result                        
├── Makefile                              // construct procedure
├── src                                   // source code
│   ├── main.f90
│   ├── initial_parameter.f90 
│   ├── menu.f90           
│   ├── time_print.f90                    // output system time
│   ├── variable_density.f90
│   ├── variable_allowable_stress.f90
│   ├── single_step.f90      
│   ├── initial_file.f90                  // create input file
│   ├── read_output.f90                   // read output file
│   ├── delete_file.f90 
│   └── adjust_parameter.f90              // adjust area
├── module
│   └── global.mod
├── input 
│   ├── 1.inp                             // condition 1
│   └── 2.inp                             // condition 2
├── include
│   └── global.f90                        // global variables 
├── data                                  // result file
├── plot								   // png file
├── bulid
├── batchfile                    
│   └──  RunAbaqus.bat                    // bat file
└── .vscode                               // vscode config

----------------------------------------------------------------- 
version 1.1 :
1. Add the graphic method to get the theroetical result.
2. Added drawing capability via python with matplotlib.