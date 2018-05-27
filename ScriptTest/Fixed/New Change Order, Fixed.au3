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
#include "\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\ScriptLibraries\NewJobLib.au3"
#include "\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\ScriptLibraries\BookJobLib.au3"
#include "\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\ScriptLibraries\COLib.au3"



Opt("WinTitleMatchMode",2)

$WindowTitle = "Order Entry"
Call("CheckWindowExists",$WindowTitle)

;<--------THIS BEGINS CHANGE ORDER ENTRY INPUT------->

WinActivate($WindowTitle)
WinWaitActive($WindowTitle)
ControlClick($WindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,352, 12)

Call("Visibility","[NAME:btnNewCO]",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:btnNewCO]")

Sleep(3000)

ControlClick($WindowTitle,"","[NAME:FpCO2]","left",1,257, 29)
Send("{SPACE}")


ControlClick($WindowTitle,"","[NAME:FpCO2]","left",1,286, 53)
$Weight = 1500
$Dollars = 2000
Call("COCostWeightInput",$Weight,$Dollars)


ControlClick($WindowTitle,"","[NAME:FpCO2]","left",1,302, 291)
Send("0 {Enter}")
ControlClick($WindowTitle,"","[NAME:btnSaveCO]")

Call("Visibility","[NAME:picbox_COSave_Happy]",$WindowTitle)



If WinExists("BomsNet","A ton change") Then
	WinActivate("BomsNet")
	WinWaitActive("BomsNet")
	Send("{ENTER}")
EndIf



ControlClick($WindowTitle,"","[NAME:TabCtrlCO]","left",1,183, 13)

ControlClick($WindowTitle,"","[NAME:txtCODescription3]","left",1,226, 147)
Send("Test Change Order")
ControlClick($WindowTitle,"","[NAME:btnSaveDetails]")


Call("Visibility","[NAME:pic_CO_Details_Happy]",$WindowTitle)

WinActivate($WindowTitle)
WinWaitActive($WindowTitle)

ControlClick($WindowTitle,"","[NAME:TabCtrlCO]","left",1,32, 13)

Call("Visibility","[NAME:btnNewCO]",$WindowTitle)


ControlClick($WindowTitle,"","[NAME:lvwChgOrdSumm2]","right",1,93, 35)
Send("{Down} {Down} {Down} {Enter}")
