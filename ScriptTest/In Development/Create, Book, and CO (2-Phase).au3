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

Opt("WinTitleMatchMode",2)

RunWait("\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\Boms-Net\New Job (A).exe")

Sleep(1000)

$WindowTitle = "Order Entry"
WinActivate($WindowTitle)
WinWaitActive($WindowTitle)

RunWait("\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\Boms-Net\Fixed\Book Job, 2-Phase, Fixed.exe")
Sleep(2000)


WinActivate($WindowTitle)
WinWaitActive($WindowTitle)
RunWait("\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\Boms-Net\Fixed\New Change Order, Fixed.exe")
Sleep(1000)

RunWait("\\bgnbgcltfile01\NBG Business Tools\Testing Scripts\Boms-Net\Daily Sales Report.exe")