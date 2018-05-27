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

;<--------THIS BEGINS COLOR EDIT------->

;Project Info Screen

$WindowTitle = "Order Entry"
WinActivate($WindowTitle)
WinWaitActive($WindowTitle)


ControlClick($WindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,36,12)
Call("Visibility","[NAME:btnSaveProject]")




ControlClick($WindowTitle,"","[NAME:Button5]")
$WindowTitle = "BuyOuts"
While NOT WinExists($WindowTitle)
	Sleep(250)
WEnd
WinActivate($WindowTitle)
WinWaitActive($WindowTitle)


Call("Visibility","[NAME:btnSavePanelTrim]")



ControlClick($WindowTitle,"","[NAME:fpPanelTrim]","left",1,202, 33)
Sleep(500)
Send(Call("RoofPanel"))
Send("{TAB}R{TAB 2}26{TAB}")
Send("{DOWN}{LEFT 4}")
Sleep(500)
Send(Call("RoofPanel"))
Send("{TAB}R{TAB 2}26{TAB}")
Sleep(500)
Send("{DOWN}{LEFT 3}")
Sleep(500)
Send("P{TAB 2}26{TAB}{DOWN}{LEFT 3}")
Send("P{TAB 2}26{TAB}{DOWN}{LEFT 3}")
Send("B{TAB 2}26{TAB}{DOWN}{LEFT 3}")
Send("S{TAB 2}26{TAB}{DOWN}{LEFT 3}")
Send("F{TAB 2}26{TAB}{DOWN}{LEFT 4}")

$Division = WinGetTitle("Order Log")
If $Division = "Order Log - IT DEVELOPMENT SOUTH" Or $Division = "Order Log - IT DEVELOPMENT ATL" Or _
$Division = "Order Log - IT DEVELOPMENT MW" Or $Division = "Order Log - IT DEVELOPMENT WEST" Then
Send(Call("RoofPanel"))
Send("{TAB}A{TAB 2}26{TAB}")
EndIf


Sleep(250)

ControlClick($WindowTitle,"","[NAME:cboDoors]")
Send("N{TAB}N{TAB}")

MsgBox("","Complete","Review and Click Save to accept Changes")


Func RoofPanel()
	Local $Division = WinGetTitle("Order Log")

	Select
		;Regionals
		Case $Division = "Order Log - Kirby (Test)"
			$roofpanel = "KR2"
		Case $Division = "Order Log - GSM (Test)"
			$roofpanel = "R"
		Case $Division = "Order Log - CBC (Test)"
			$roofpanel = "R"

		;NBS
		Case $Division = "Order Log - Waterloo"
			$roofpanel = "Classic"
		Case $Division = "Order Log - Utah"
			$roofpanel = "Classic"
		Case $Division = "Order Log - Swansea"
			$roofpanel = "Classic"
		Case $Division = "Order Log - Terrell"
			$roofpanel = "Classic"

		;ABC
		Case $Division = "Order Log - IT DEVELOPMENT SOUTH"
			$roofpanel = "L3P"
		Case $Division = "Order Log - IT DEVELOPMENT ATL"
			$roofpanel = "L3P"
		Case $Division = "Order Log - IT DEVELOPMENT MW"
			$roofpanel = "L3P"
		Case $Division = "Order Log - IT DEVELOPMENT WEST"
			$roofpanel = "L3P"
		Case Else
			MsgBox("","Order Log Not Open","Options are predetermined based on the title of the Order Log. Either the Order Log is not open, the title has been changed, or the environment is not a Test environment.")
	EndSelect
	Return $roofpanel
EndFunc



Func Visibility(ByRef $visible)
	$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($WindowTitle, "", $visible, "IsVisible")
WEnd
$isvisible = 0
EndFunc
