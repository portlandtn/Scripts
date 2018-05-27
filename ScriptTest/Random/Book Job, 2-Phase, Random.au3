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
	MsgBox("","Open Order Entry","This script relies on Order Entry window existing. Right-click the project you wish to edit and choose Order Entry to open that window. Ensure it is on the first tab, and then run this script.")
	Exit
EndIf

;<--------THIS BEGINS ORDER ENTRY INPUT------->

;Project Info Screen


$OEWindowTitle = ControlGetText("","","[NAME:txtJobNbr]")
#cs
Opt("WinTitleMatchMode",2)
WinActivate($OEWindowTitle)
WinWaitActive($OEWindowTitle)

$ActiveWindow = 0


$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:btnSaveProject]", "IsVisible")
WEnd
$isvisible = 0

#ce

Opt("WinTitleMatchMode",2)
$CurrentDate = _NowDate() & ", " & _NowTime(4)
$OEWindowTitle = "Order Entry"
ControlSetText($OEWindowTitle,"","[NAME:txtOrderName]","Test Random 2-Phase Job - Created " & $CurrentDate)
ControlSetText($OEWindowTitle,"","[NAME:txtShipAddr1]","1111 Generic Address")
ControlSetText($OEWindowTitle,"","[NAME:cboShipCity]","City")
ControlSetText($OEWindowTitle,"","[NAME:txtShipState]","ST")
ControlSetText($OEWindowTitle,"","[NAME:txtShipZip]",Random(10000,99999,1))
ControlSetText($OEWindowTitle,"","[NAME:txtshipcounty]","County")
ControlSetText($OEWindowTitle,"","[NAME:txtFreightMiles]",Random(10,999,1))
ControlSetText($OEWindowTitle,"","[NAME:txtSqFeet]",Random(5,999999,1))
ControlSetText($OEWindowTitle,"","[NAME:cboDept]","CSR")

ControlFocus($OEWindowTitle,"","[NAME:cboPriceType]")
Send("{UP 4}")

ControlFocus($OEWindowTitle,"","[NAME:cboEndUse]")
Send("{UP 10}")

ControlClick($OEWindowTitle,"","[NAME:btnSaveProject]","left",1)

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:PictureBoxHappy]", "IsVisible")
WEnd
$isvisible = 0

;Phasings/Buildings Screen (Prebook)
ControlClick($OEWindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,116, 12)

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:btnSaveBldgInfo]", "IsVisible")
WEnd
$isvisible = 0

WinActivate($OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:FpSpread_Bldg]","left",1,293, 52)

For $i = 7 To 1 Step -1
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

ControlClick($OEWindowTitle,"","[NAME:btnSaveBldgInfo]")
While $isvisible = 0
	Sleep(50)
	$isvisible = ControlCommand($OEWindowTitle,"","[NAME:picboxHappy_BldgInfo]","IsVisible")
WEnd
$isvisible = 0

ControlClick($OEWindowTitle,"","[NAME:btnPrebookFromBldg]")

While $isvisible = 0
	Sleep(50)
	$isvisible = ControlCommand($OEWindowTitle,"","[NAME:btnSaveMultiPhasesToDB]","IsVisible")
WEnd
$isvisible = 0

ControlClick($OEWindowTitle,"","[NAME:chkEmail_JobInfo]")
Sleep(100)
ControlClick($OEWindowTitle,"","[NAME:btnSaveMultiPhasesToDB]")

;Transfer $$ and ## to Phases
ControlClick($OEWindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,116, 12)

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:btnSaveBldgInfo]", "IsVisible")
WEnd
$isvisible = 0

WinActivate($OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:FpPhaseTool]","left",1,34, 27)
Send("A {TAB} 1 {TAB} 70 {ENTER}")
Sleep(250)
Send("{DOWN} 30 +{TAB} 1 +{TAB} B {ENTER}")
Sleep(250)

ControlClick($OEWindowTitle,"","[NAME:btnSaveBldgInfo]")

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:picboxHappy_BldgInfo]", "IsVisible")
WEnd
$isvisible = 0
Sleep(50)

ControlClick($OEWindowTitle,"","[NAME:btnTsfrToPhases]")

$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($OEWindowTitle, "", "[NAME:btnSaveMultiPhasesToDB]", "IsVisible")
WEnd
$isvisible = 0

ControlClick($OEWindowTitle,"","[NAME:btnSaveMultiPhasesToDB]")

MsgBox("","Project Created","Project has been created successfully. Enter a Must-Ship date, Save, and then you can make the Transaction Active.")

