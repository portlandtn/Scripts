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

$file = FileOpen("C:\ProgramData\Nucor\NBGSettings.config",0)

$line = FileReadLine($file,2)

$trimDiv = StringRight(StringLeft($line,38),5)
$trimLoc = StringRight(StringLeft($line,59),5)

MsgBox("","Test","Div = " & $trimDiv & ". Loc = " & $trimLoc)

If $trimLoc = "NBGGS" Or $trimLoc = "NBSGS" Then
	MsgBox("","Good","Okay. You're good now. In test.")
Else
	MsgBox("","Nope","You're not in a test environment. Probably something is wrong.")
EndIf



Select

	Case $trimDiv = "ABCVA"
		$JobNumber = "Axxxxxx"
	Case $trimDiv = "ABCIL"
		$JobNumber = "Mxxxxxx"
	Case $trimDiv = "ABCAL"
		$JobNumber = "Sxxxxxx"
	Case $trimDiv = "ABCNV"
	If $trimLoc = "NBSGS" Then
		$JobNumber = "Nxxxxxx"
	ElseIf $trimLoc = "NBGGS" Then
		$JobNumber = "Wxxxxxx"
	EndIf

	Case $trimDiv = "CBCCA"
		$JobNumber = "NoGood"
	Case $trimDiv = "KBSTN"
		$JobNumber = "K17A0116A"

	Case $trimDiv = "NBSSC"
		$JobNumber = "S17A0343A"
	Case $trimDiv = "NBSTX"
		$JobNumber = "NoGood"
	Case $trimDiv = "NBSIN"
		$JobNumber = "W17A0146A"
	Case $trimDiv = "NBSUT"
		$JobNumber = "U17E0135A"

EndSelect

MsgBox("","Job Stuff","Job number format would be: " & $JobNumber)