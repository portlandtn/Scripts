#cs ----------------------------------------------------------------------------
MsgBox(262144, 'Debug line ~' & @ScriptLineNumber, 'Selection:' & @CRLF & '#cs' & @CRLF & @CRLF & 'Return:' & @CRLF & #cs) ;### Debug MSGBOX

 AutoIt Version: 3.3.14.2
 Author:         Jedidiah May

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <MsgBoxConstants.au3>
#include <GUIListBox.au3>
#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <Date.au3>
#include <File.au3>

Opt("WinTitleMatchMode",2)

$WindowTitle = "BomsNet"

Call("OpenSysInfo",$WindowTitle)

Func OpenSysInfo($WindowTitle)
WinActivate($WindowTitle)
WinWaitActive($WindowTitle)
Send("{ALT}{DOWN 8}{RIGHT}{DOWN}{ENTER}")
Sleep(1000)
$WindowTitle = "System Info"
WinActivate($WindowTitle)
WinWaitActive($WindowTitle)
EndFunc

$WindowTitle = "System Info"
$BomsWeekNum = ControlGetText($WindowTitle,"","[NAME:txtCurrWeek]")
WinClose($WindowTitle)
$CurrentWeekNum = _WeekNumberISO()

If $BomsWeekNum <> $CurrentWeekNum Then

$WeekStatus = MsgBox(3,"Week Incorrect","The financial week in Boms does not match the current week. Do you want to update the week number? (Current week number is "& _
_WeekNumberISO()&", BomsNet has "&$BomsWeekNum&").")

	If $WeekStatus = 2 Then
		Exit

	ElseIf $WeekStatus = 6 Then
		Call("OpenSysInfo","BomsNet")
		$WindowTitle = "System Info"
		ControlSetText($WindowTitle,"","[NAME:txtCurrWeek]",$CurrentWeekNum)
		ControlClick($WindowTitle,"","[NAME:btnSave]")
		WinWait("frmSuccessful")
		Sleep(1000)
		WinClose($WindowTitle)
	EndIf

EndIf



Call("RunJobs","A","1")
Call("RunJobs","A","2")
Call("RunJobs","B","1")
Call("RunJobs","B","2")
Call("RunJobs","C","1")
Call("RunJobs","C","2")
Call("RunJobs","D","1")
Call("RunJobs","D","2")

Func RunJobs($JobType,$Phase)
RunWait("\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\Boms-Net\New Job ("&$JobType&").exe")

Sleep(1000)

$WindowTitle = "Order Entry"
WinActivate($WindowTitle)
WinWaitActive($WindowTitle)

RunWait("\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\Boms-Net\Fixed\Book Job, "&$Phase&"-Phase, Fixed.exe")
Sleep(2000)


WinActivate($WindowTitle)
WinWaitActive($WindowTitle)
RunWait("\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\Boms-Net\Fixed\New Change Order, Fixed.exe")
Sleep(1000)

WinClose($WindowTitle)
$WindowTitle = "Daily Sales"
WinClose($WindowTitle)
WinClose("Excel")
EndFunc

RunWait("\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\Boms-Net\Daily Sales Report.exe")