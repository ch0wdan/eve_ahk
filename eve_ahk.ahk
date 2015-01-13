;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CHOWDAN EVE ONLINE MINING BOT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; "Minons - Lets make some ISK" ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#SingleInstance force
#InstallKeybdHook
#InstallMouseHook
#NoEnv


if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

lasers = 2
global locktime = 3000
global cycle_time = 90000
global destination
global activity

global box = 1
global laser1
global laser2
global Belt := {}
firstbeltx =
y1 = 212
y2 = 220


;;;;;;;;;;;;;;;;;;; FIND AND LOAD EXITING ASTROID BELTS ;;;;;;;;;;;;;;;;;;;;;

result := DllCall("MessageBox","Uint",0,"Str","Activate mining bot?","Str","Eve mining bot","Uint","0x00000034L")
If result=7
	ExitApp
isEveActive()
KeyWait, S, up
ToolTip, Starting Mining Bot, 800, 50
sleep 2000
send {shift up}
send {ctrl up}
click 763, 224
sleep 500

loop, 30
{
	ToolTip, searching for belts, 800, 50
	PixelSearch, x, y, 856, y1, 270, y2, 0xFFFFFF, 20, fast
	if errorlevel {
		Belt.Insert(A_Index, 0)
	}else {
		Belt.Insert(A_Index, 1)
		beltx%A_Index% := x
		belty%A_Index% := y
	}
	y1 += 19
	y2 += 19

}

;;;;;;;;;;;;;; BELT WARP ;;;;;;;;;;;;;

warptobelt:

ToolTip, Slowing ship.., 800, 50
loop, 2 {
Send {Lcontrol down}
Send {space}
Send {Lcontrol up}
sleep 1000
}
loop {
	PixelSearch, x,y, 550, 747, 554, 750, 0x949494, 10
		if (!ErrorLevel)
			break
}
Loop {
	PixelSearch, x,y, 491, 749, 493, 752, 0x949494, 10
		if (!ErrorLevel)
			break
}
ToolTip, Selecting next available belt, 800, 50
click 784, 177
sleep 500
	PixelGetColor, box, 907, 200
	if(box == 0x000000)
		click 907, 200
sleep 1000

Loop
{
	if(Belt[A_index] == 1) {
		global destination := Belt[A_Index]
		beltx := beltx%A_Index%
		belty := belty%A_Index%
		break
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CHECK TO SEE IF EVE IS ACTIVE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
return

^+C::
ExitApp
return
;ctrl+shift+C to exit script

isEveActive()
{
	WinWait, EVE,
	IfWinNotActive, EVE, , WinActivate, EVE,
	WinWaitActive, EVE,
	IfWinActive, EVE
		return 1
	else
		return 0
}

+p::pause ;; shift + p to pause