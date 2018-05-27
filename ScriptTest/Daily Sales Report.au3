#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Jedidiah May

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------


#include <MsgBoxConstants.au3>
#include <GUIListBox.au3>
#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <Date.au3>


Opt("WinTitleMatchMode",2)
$WindowTitle = "BomsNet"
If Not WinExists($WindowTitle) Then
	MsgBox("","Open BomsNet","This script requires BomsNet to be open. Please open BomsNet and then re-run this script.")
	Exit
EndIf



$WindowTitle = "BomsNet"
WinActivate($WindowTitle)
WinWaitActive($WindowTitle)
Sleep(500)

Send("{ALT}VSS{RIGHT}S{RIGHT}{ENTER}")
Sleep(500)

$WindowTitle = "Daily Sales Report"

While Not WinActive($WindowTitle)
	WinActivate($WindowTitle)
WEnd

Sleep(500)

ControlSetText($WindowTitle,"","[NAME:txtBegDate]",_NowDate())
ControlSetText($WindowTitle,"","[NAME:txtEndDate]",_NowDate())
ControlClick($WindowTitle,"","[NAME:btnRefresh]")
Sleep(5000)

Call("Visibility","[NAME:btnToExcel]")
ControlClick($WindowTitle,"","[NAME:btnToExcel]")
Sleep(2000)


While Not WinActive("Excel")
	WinActivate("Excel")
WEnd

Sleep(500)

While Not WinActive($WindowTitle)
	WinActivate($WindowTitle)
WEnd
Sleep(500)

While Not WinActive("Excel")
	WinActivate("Excel")
WEnd

Call("Visibility","[NAME:btnToExcel]")


Send("{F12}")
Sleep(500)
$date = StringSplit(_NowDate(),"/")
$DashDate = $date[1]& "-" & $date[2] & "-" & $date[3]
Send("C:\ProgramData\" & $DashDate & " Daily Sales Report")
Send("{ENTER}")
Sleep(500)

If WinExists("Confirm") Then
WinActivate("Confirm")
Sleep(500)
ControlClick("Confirm","","[CLASS:Button; INSTANCE:1]")
EndIf


Sleep(500)
;WinClose("Excel")
;WinClose($WindowTitle)

;Run("Explorer.exe C:\ProgramData\")


Func Visibility($visible)
	$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($WindowTitle, "", $visible, "IsVisible")
WEnd
$isvisible = 0
EndFunc

