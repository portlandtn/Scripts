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

;If Report Settings is not up, pop-up box terminating script and informing user to open Report Settings
If Not WinExists("Report Settings") Then
	MsgBox("","Open Report Settings","Please open Report Settings prior to running this Script File")
	Exit
EndIf

WinActivate("Report Settings")
WinWaitActive("Report Settings")

;Checks to see that the Active Printer is loaded as a way to make sure the form has loaded completely.
Local $ActivePrinter=0
Do
	Sleep(100)
	$ActivePrinter = ControlGetText("Report Settings","","[NAME:lblActivePrinter]")
Until $ActivePrinter <> ""
$ActivePrinter = 0


;Populates the default printer in the dialog box to the previously saved Printer. If it is blank, it defaults to the system default printer
Local $PrinterSaved=ControlGetText("Report Settings","","[NAME:lblSavedPrinter]")
If $PrinterSaved = "" Then
	$PrinterSaved=ControlGetText("Report Settings","","[NAME:lblActivePrinter]")
EndIf

Local $DesiredPrinter = InputBox("Choose Printer","What printer do you want to be selected for each report?",$PrinterSaved)
If @error Then
	Exit
EndIf

;Iteration count
Local $i = 0


Local $ReportCount = inputbox("Number to Update","How many reports do you want updated?","10")

If @error Then
	Exit
EndIf


;Clears Printer Dialog box and sets the printer to user-desired printer, and clicks the change button.
Do
WinActivate("Report Settings")
WinWaitActive("Report Settings")

ControlSetText("Report Settings","","[NAME:cboDefaultPrinters]", "")
ControlSetText("Report Settings", "", "[NAME:cboDefaultPrinters]", $DesiredPrinter)
ControlClick("Report Settings", "", "[NAME:btnChgPrinter]")

#cs
;Wait for the printer to be officially changed before moving on
Do
   Sleep(250)
   $PrinterSaved=ControlGetText("Report Settings","","[NAME:lblSavedPrinter]")
Until $PrinterSaved=$DesiredPrinter

$PrinterSaved = 0

ControlClick("Report Settings", "", "[NAME:btnSave]")

;Checks to make sure the save was successful
Local $ivisible = 0

While $ivisible = 0
	Sleep(250)
	$ivisible = ControlCommand("Report Settings", "", "[NAME:lblsuccess]", "IsVisible")
	$i=$i+1
WEnd
$ivisible=0

;Goes to the next report on the list if more reports remain
If $i < $ReportCount Then
Send("{Down 3}")
EndIf

Until $i=$ReportCount


MsgBox("","Complete","Reports have been updated")
#ce

;Original Code (1/23/18)
;Wait for the printer to be officially changed before moving on
Do
   Sleep(100)
   $PrinterSaved=ControlGetText("Report Settings","","[NAME:lblSavedPrinter]")
Until $PrinterSaved=$DesiredPrinter
$PrinterSaved = 0

ControlClick("Report Settings", "", "[NAME:btnSave]")

;Checks to make sure the save was successful
Local $ivisible = 0
While $ivisible = 0
Sleep(100)
$ivisible = Controlcommand("Report Settings", "", "[NAME:lblsuccess]", "IsVisible")
WEnd
$ivisible=0

$i=$i+1
;Goes to the next report on the list
If $i<$ReportCount Then
	Send("{Down 3}")

;Checks to see that the Active Printer is loaded as a way to make sure the form has loaded completely.
	Local $ActivePrinter=0
	Do
		Sleep(100)
		$ActivePrinter = ControlGetText("Report Settings","","[NAME:lblActivePrinter]")
	Until $ActivePrinter <> ""
EndIf
$ActivePrinter = 0

Until $i=$ReportCount


MsgBox("","Complete","Reports have been updated")
