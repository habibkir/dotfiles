#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance

Capslock::Esc
Esc::Capslock
SC056::RCtrl
!Enter::
run, C:\Program Files\Git\git-bash.exe --cd-to-home
return
#Enter::
run, C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico -
return
