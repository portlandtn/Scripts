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


Opt("WinTitleMatchMode",2)

If Not WinExists("Order Entry") Then
	MsgBox("","Open Order Log","This script relies on Order Entry window existing. Right-click the project you wish to edit and choose Order Entry to open that window. Ensure it is on the first tab, and then run this script.")
	Exit
EndIf

;<--------THIS BEGINS CHANGE ORDER ENTRY INPUT------->

$OEWindowTitle = "Order Entry"
WinActivate($OEWindowTitle)
WinWaitActive($OEWindowTitle)
ControlClick($OEWindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,352, 12)

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:btnNewCO]", "IsVisible")
WEnd
$isvisible = 0

ControlClick($OEWindowTitle,"","[NAME:btnNewCO]")

Sleep(3000)

ControlClick($OEWindowTitle,"","[NAME:FpCO2]","left",1,257, 29)
Send("{SPACE}")


ControlClick($OEWindowTitle,"","[NAME:FpCO2]","left",1,286, 53)

For $i = 4 To 1 Step -1
    Send(Random(100,99999,1))
	Sleep(50)
	Send("{TAB}")
	Sleep(50)
	Send(Random(100,99999,1))
	Sleep(50)
	Send("{ENTER}")
	Sleep(50)
	Send("{LEFT}")
	Sleep(50)
Next


ControlClick($OEWindowTitle,"","[NAME:FpCO2]","left",1,302, 291)
Send("0 {Enter}")
ControlClick($OEWindowTitle,"","[NAME:btnSaveCO]")

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:picbox_COSave_Happy]", "IsVisible")
WEnd
$isvisible = 0
Sleep(1000)


if WinExists("BomsNet","A ton change") Then
	WinActivate("BomsNet")
	WinWaitActive("BomsNet")
	Send("{ENTER}")
EndIf



ControlClick($OEWindowTitle,"","[NAME:TabCtrlCO]","left",1,183, 13)

ControlClick($OEWindowTitle,"","[NAME:txtCODescription3]","left",1,226, 147)
Send("Test Change Order")
ControlClick($OEWindowTitle,"","[NAME:btnSaveDetails]")

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:pic_CO_Details_Happy]", "IsVisible")
WEnd
$isvisible = 0

ControlClick($OEWindowTitle,"","[NAME:btnCOConfirm]")
While NOT WinExists("CO")
	Sleep(250)
WEnd

WinActivate($OEWindowTitle)
WinWaitActive($OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:TabCtrlCO]","left",1,32, 13)

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:btnNewCO]", "IsVisible")
WEnd
$isvisible = 0
Sleep(1000)

ControlClick($OEWindowTitle,"","[NAME:lvwChgOrdSumm2]","right",1,93, 35)
Send("{Down} {Down} {Down} {Enter}")
