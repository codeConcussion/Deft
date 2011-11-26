#NoEnv
#SingleInstance
#KeyHistory 0
SendMode Input
SetCapsLockState, AlwaysOff

_positionHome := 1
_positionLeft := 2
_positionTop := 3
_positionRight := 4
_positionBottom := 5
_positionTopLeft := 6
_positionTopRight := 7
_positionBottomRight := 8
_positionBottomLeft := 9
_positionCount := 9
_padding := 8
_undoId := ""
_undoPositions := ""

StartUp()

#Left::Move()
#Up::Move()
#Right::Move()
#Down::Move()
#Home::Move()
#End::MoveToNextMonitor()
#PgUp::MaximizeRestore()
#PgDn::Minimize()
#Insert::SetOnTop()
#Delete::RemoveOnTop()
#Backspace::UndoMove()

CapsLock & j::Move()
CapsLock & l::Move()
CapsLock & i::Move()
CapsLock & k::Move()
CapsLock & u::MoveToNextMonitor()
CapsLock & o::MoveToNextMonitor()
CapsLock & y::MaximizeRestore()
CapsLock & h::Minimize()

#Include Setup.ahk
#Include Actions.ahk