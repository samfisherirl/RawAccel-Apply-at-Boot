#NoEnv
#SingleInstance force
SetTitleMatchMode, 2
SetWorkingDir, %A_ScriptDir%
;#include <UIA_Interface> ; Uncomment if you have moved UIA_Interface.ahk to your main Lib folder
#include UIA_Interface.ahk
path := A_ScriptDir "\rawaccel.exe"
app :=  "rawaccel.exe"
loop, 2
{
  try {

    Run, %path%,,,PID
    break
  } catch e {
    sleep, 500
  }
}
UIA := UIA_Interface() ; Initialize UIA interface
Sleep, 500
loop, 12
{
  try {
    npEl := UIA.ElementFromHandle("ahk_exe " app) ; Get the element for the Notepad window
    documentEl := npEl.FindFirstByName("Apply") ; Find the first Document control (in Notepad there is only one). This assumes the user is running a relatively recent Windows and UIA interface version 2+ is available. In UIA interface v1 this control was Edit, so an alternative option instead of "Document" would be "UIA.__Version > 1 ? "Document" : "Edit""
    documentEl.Click(200)
    break
  } catch e {
    sleep, 500
  }
}
; Highlight the found element
; Set the value for the document control.
; Equivalent ways of setting the value:
; documentEl.CurrentValue := "Lorem ipsum"
; documentEl.SetValue("Lorem ipsum")
loop, 15
{
  try {
    Process, Close, %PID%
    sleep, 100
    break
  } catch e {
    sleep, 1000
  }
}
ExitApp

; #Include <UIA_Interface>
; SetTitleMatchMode, 2

;el := WinExist("Raw Accel ahk_exe rawaccel.exe")
;WinActivate, ahk_id %el%
;WinWaitActive, ahk_id %el%
;el := UIA.ElementFromHandle(el)

; el.FindFirstBy("ControlType=Button AND Name='Apply' AND AutomationId='writeButton'",,2).ControlClick()