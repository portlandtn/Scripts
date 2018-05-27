#cs ----------------------------------------------------------------------------
MsgBox(262144, 'Debug line ~' & @ScriptLineNumber, 'Selection:' & @CRLF & '#cs' & @CRLF & @CRLF & 'Return:' & @CRLF & #cs) ;### Debug MSGBOX

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
#include "\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\ScriptLibraries\NewJobLib.au3"

Opt("WinTitleMatchMode",2)


;Checks if the Order Log is open
Call("CheckWindowExists","Order Log")

;Clicks New Job Button
$WindowTitle = "New Order Number"
Call("NewJobButton","Order Log",$WindowTitle)


;Chooses Customer Number
$CustomerNumber = Call("CustomerLookUpOrderLog")
Call("CustomerNumber",$WindowTitle,$CustomerNumber)

Call("Visibility","[NAME:lblCustName]",$WindowTitle)

;Set Job Name and sets blank customer contact
$CurrentDate = _NowDate()
ControlClick($WindowTitle,"","[NAME:txtOrdName]")
ControlSetText($WindowTitle,"","[Name:txtOrdName]","Test B, C:" & $CurrentDate)
Call("CustomerContact",$WindowTitle)

;Sets category to 2, Order type to DCD
Call("CatSchedType","2","D",$WindowTitle)

;Sets Order Entry Date, Primers to Red, Saves new job
Call("SetPrimerAndSave",$WindowTitle)

;Dismisses the pop-up window certain division have warning of no delivery schedule information
Call("DismissPopUp",$WindowTitle)
Call("Visibility","[NAME:btnOrderEntry]",$WindowTitle)

Call("GoToOrderEntry",$WindowTitle,"Order Log")

Call("Visibility","[NAME:btnNewJob]","Order Log")
WinClose($WindowTitle)