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

;<--------THIS BEGINS INVOICING------->

;Project Info Screen

$WindowTitle = "Order Entry"
WinActivate($WindowTitle)
WinWaitActive($WindowTitle)

Send("{ALT}{DOWN 6}{ENTER}")
$WindowTitle = "Invoicing"

WinWait($WindowTitle,"The job folder does not exist.",7)
If WinExists($WindowTitle,"The job folder does not exist.") Then
	Send("{ENTER}")
EndIf

While Not WinExists($WindowTitle)
Sleep(250)
WEnd

Call("Visibility","[NAME:btnFind]")
ControlClick($WindowTitle,"","[NAME:TabControl1]","left",1,153, 12)
Call("Visibility","[NAME:btnUpdateInvoice]")

ControlClick($WindowTitle,"","[NAME:btnNew]")

WinWait("New Invoice","",7)
If WinExists("New Invoice","") Then
	Send("{ENTER}")
EndIf

WinWait("Flat Rate","",7)
If WinExists("Flat Rate","") Then
	Send("{ENTER}")
EndIf

WinWait("Tax Calculation","",7)
If WinExists("Tax Calculation","") Then
	Send("{ENTER}")
EndIf

WinWait("Avalara","",7)
If WinExists("Avalara","") Then
	Send("{ENTER}")
EndIf

ControlClick($WindowTitle,"","[NAME:fpInvoice2]","left",1,132, 49)

For $i = 7 To 1 Step -1
    Send(Random(2,99,1))
	Sleep(50)
	Send("{DOWN}")
Next
Send("{RIGHT 2}{UP 7}")
For $i = 7 To 1 Step -1
    Send(Random(2,99,1))
	Sleep(50)
	Send("{DOWN}")
Next
Send("{RIGHT}{UP 7}")
For $i = 7 To 1 Step -1
    Send(Random(100,99999,1))
	Sleep(50)
	Send("{DOWN}")
Next

ControlClick($WindowTitle,"","[NAME:btnUpdateInvoice]")

Call("Visibility","[NAME:PictureBoxHappy]")
Send("{ALT}{DOWN 2}{ENTER}")

$YesNo = MsgBox(4,"Complete","Invoice has been created. Would you like to Get Numbers for all invoices listed and Post them to BomsNet?")
If $YesNo = 7 Then
	Exit
EndIf

ControlClick("Invoice Edit Summary","","[NAME:btnGetInvNbrs]")
Sleep(2000)
ControlClick("Invoice Edit Summary","","[NAME:btnPostInvoice]")

Call("Visibility","[NAME:PictureBoxHappy]")
MsgBox("","Invoicing Complete","Invoice Complete.")

Func Visibility(ByRef $visible)
	$isvisible = 0
While $isvisible = 0
	Sleep(250)
$isvisible = Controlcommand($WindowTitle, "", $visible, "IsVisible")
WEnd
$isvisible = 0
EndFunc