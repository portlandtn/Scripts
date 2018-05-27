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


Opt("WinTitleMatchMode",2)

;Check to see if the Order Entry screen is open
$WindowTitle = "Order Entry"
Call("CheckWindowExists",$WindowTitle)


;<--------THIS BEGINS ORDER ENTRY INPUT------->

;Project Info Screen
$OEWindowTitle = "Order Entry"

$CurrentJobName = ControlGetText($OEWindowTitle,"","[NAME:txtOrderName]")
Call("ProjectInfoInput",$OEWindowTitle,$CurrentJobName,"1Ph")

ControlFocus($OEWindowTitle,"","[NAME:cboPriceType]")

$Division = Call("GetDivision")
Call("PriceType",$Division)

Call("EndUse",$OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:btnSaveProject]","left",1)

Call("Visibility","[NAME:PictureBoxHappy]",$OEWindowTitle)


;Phasings/Buildings Screen (Prebook)
ControlClick($OEWindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,116, 12)

Call("Visibility", "[NAME:btnSaveBldgInfo]",$OEWindowTitle)

WinActivate($OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:FpSpread_Bldg]","left",1,293, 52)

;Adds 1,000 to each subsequent category, choosing first value based on division
Call("BuildingInfo",$Division)


ControlClick($OEWindowTitle,"","[NAME:btnSaveBldgInfo]")

Call("Visibility","[NAME:picboxHappy_BldgInfo]",$OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:btnPrebookFromBldg]")

Call("Visibility","[NAME:btnSaveMultiPhasesToDB]",$OEWindowTitle)

;Disable Email checkbox
Call("DisableEmail",$OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:btnSaveMultiPhasesToDB]")

;Transfer $$ and ## to Phases
ControlClick($OEWindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,116, 12)

Call("Visibility","[NAME:btnSaveBldgInfo]",$OEWindowTitle)

WinActivate($OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:FpPhaseTool]","left",1,34, 27)
Send("A {TAB} 1 {TAB} 100 {ENTER}")
Sleep(250)

ControlClick($OEWindowTitle,"","[NAME:btnSaveBldgInfo]")

Call("Visibility","[NAME:picboxHappy_BldgInfo]",$OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:btnTsfrToPhases]")
Call("Visibility","[NAME:btnSaveMultiPhasesToDB]",$OEWindowTitle)

ControlClick($OEWindowTitle,"","[NAME:btnSaveMultiPhasesToDB]")



