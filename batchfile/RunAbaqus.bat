@echo off
call abaqus job=task.inp datacheck interactive
call abaqus job=task.inp continue interactive