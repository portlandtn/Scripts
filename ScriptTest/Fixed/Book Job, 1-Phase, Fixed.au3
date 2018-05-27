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

$CurrentJobName = ControlGetText($WindowTitle,"","[NAME:txtOrderName]")
Call("ProjectInfoInput",$WindowTitle,$CurrentJobName,"1Ph")

ControlFocus($WindowTitle,"","[NAME:cboPriceType]")

$Division = Call("GetDivision")
Call("PriceType",$Division)

Call("EndUse",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:btnSaveProject]","left",1)

Call("Visibility","[NAME:PictureBoxHappy]",$WindowTitle)


;Phasings/Buildings Screen (Prebook)
ControlClick($WindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,116, 12)

Call("Visibility", "[NAME:btnSaveBldgInfo]",$WindowTitle)

WinActivate($WindowTitle)

ControlClick($WindowTitle,"","[NAME:FpSpread_Bldg]","left",1,293, 52)

;Adds 1,000 to each subsequent category, choosing first value based on division
Call("BuildingInfo",$Division)


ControlClick($WindowTitle,"","[NAME:btnSaveBldgInfo]")

Call("Visibility","[NAME:picboxHappy_BldgInfo]",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:btnPrebookFromBldg]")

Call("Visibility","[NAME:btnSaveMultiPhasesToDB]",$WindowTitle)

;Disable Email checkbox
Call("DisableEmail",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:btnSaveMultiPhasesToDB]")

;Transfer $$ and ## to Phases
ControlClick($WindowTitle,"","[NAME:ProjectFeaturesTab]","left",1,116, 12)

Call("Visibility","[NAME:btnSaveBldgInfo]",$WindowTitle)

WinActivate($WindowTitle)

ControlClick($WindowTitle,"","[NAME:FpPhaseTool]","left",1,34, 27)
Send("A {TAB} 1 {TAB} 100 {ENTER}")
Sleep(250)

ControlClick($WindowTitle,"","[NAME:btnSaveBldgInfo]")

Call("Visibility","[NAME:picboxHappy_BldgInfo]",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:btnTsfrToPhases]")
Call("Visibility","[NAME:btnSaveMultiPhasesToDB]",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:btnSaveMultiPhasesToDB]")

Call("Visibility","[NAME:btnSaveProjectDates2]",$WindowTitle)

$Coords = StringSplit(Call("GetCoords",$Division),",")

ControlClick($WindowTitle,"","[NAME:FpSpreadProjDates]","",1,$Coords[1], $Coords[2])

$Date = StringSplit(_NowDate(),"/")
$Date2 = $Date[1]&$Date[2]&StringRight($Date[3],2)
Send($Date2)
Send("{ENTER}")
ControlClick($WindowTitle,"","[NAME:btnSaveProjectDates2]")

Call("Visibility","[NAME:picboxHappy_Dates]",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:ProjectFeaturesTab]","",1,118, 9)
Call("Visibility","[NAME:btnSaveBldgInfo]",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:TabControl4]","",1,171, 12)
Call("Visibility","[NAME:chkBookTonsDoll_ViewTons]",$WindowTitle)

ControlClick($WindowTitle,"","[NAME:lvwSalesSummary]","right",1,180, 70)
Sleep(250)
Send("{DOWN 4}")
Send("{ENTER}")

