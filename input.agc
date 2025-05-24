#option_explicit

//-----------------------------------------------------
// Key codes.
//

#constant KEY_BACK 8
#constant KEY_TAB 9
#constant KEY_ENTER 13
#constant KEY_SHIFT 16
#constant KEY_CONTROL 17
#constant KEY_ESCAPE 27
#constant KEY_SPACE 32
#constant KEY_PAGEUP 33
#constant KEY_PAGEDOWN 34
#constant KEY_END 35
#constant KEY_HOME 36
#constant KEY_LEFT 37
#constant KEY_UP 38
#constant KEY_RIGHT 39
#constant KEY_DOWN 40
#constant KEY_INSERT 45
#constant KEY_DELETE 46

#constant KEY_SEMICOLON 186 
#constant KEY_EQUALS 187
#constant KEY_COMMA 188
#constant KEY_DASH 189
#constant KEY_PERIOD 190
#constant KEY_SLASH 191
#constant KEY_APOS 192
#constant KEY_LBRACKET 219
#constant KEY_BACKSLASH 220
#constant KEY_RBRACKET 221
#constant KEY_HASH 222
#constant KEY_TICK 223

#constant KEY_CTRL_UNSHIFT 300
#constant KEY_CTRL_123 301
#constant KEY_CTRL_ABC 302
#constant KEY_CTRL_SYM 303
#constant KEY_CTRL_LEFT 304
#constant KEY_CTRL_RIGHT 305

#constant KEY_WAIT_TIME 500
#constant KEY_REPEAT_TIME 100

#constant KEY_TOP_0 263
#constant KEY_TOP_1 264
#constant KEY_TOP_2 265
#constant KEY_TOP_3 266
#constant KEY_TOP_4 267
#constant KEY_TOP_5 268
#constant KEY_TOP_6 269
#constant KEY_TOP_7 270
#constant KEY_TOP_8 271
#constant KEY_TOP_9 272

//-----------------------------------------------------
global in as Input

type Input

	ptrPressed as integer
	ptrDown as integer
	ptrReleased as integer
	ptrX as float
	ptrY as float
	
	leftMousePressed as integer
	leftMouseDown as integer
	leftMouseReleased as integer
	rightMousePressed as integer
	rightMouseDown as integer
	rightMouseReleased as integer
	mouseX as float
	mouseY as float
	mouseWheel as float
	mouseWheelDelta as float

	hasKeyboard as integer
	keyPressedScan as integer
	keyPressed as integer
	keyRepeatTime as integer
	keyWaitTime as integer
	
endtype

//-----------------------------------------------------
// Setup with seperate input obj.
//
function inInit()

	in.ptrPressed = 0
	in.ptrDown = 0
	in.ptrReleased = 0
	in.ptrX = 0
	in.ptrY = 0
	
	if WIN_MODE
		
		in.leftMousePressed = 0
		in.leftMouseDown = 0
		in.leftMouseReleased = 0
		in.rightMousePressed = 0
		in.rightMouseDown = 0
		in.rightMouseReleased = 0
		in.mouseX = 0
		in.mouseY = 0
		in.mouseWheel = 0
		in.mouseWheelDelta = 0
		
	endif
	
	in.hasKeyboard = GetKeyboardExists()
	in.keyRepeatTime = 0
	in.keyWaitTime = KEY_WAIT_TIME
	
endfunction

//-----------------------------------------------------
// Update all input.
//
function inUpdate()

	inPointer()

endfunction

//-----------------------------------------------------
//
function inPointer()
		
	if WIN_MODE
		
		in.leftMousePressed = GetRawMouseLeftPressed()
		in.leftMouseDown = GetRawMouseLeftState()
		in.leftMouseReleased = GetRawMouseLeftReleased()
		in.rightMousePressed = GetRawMouseRightPressed()
		in.rightMouseDown = GetRawMouseRightState()
		in.rightMouseReleased = GetRawMouseRightReleased()
		in.mouseX = GetRawMouseX()
		in.mouseY = GetRawMouseY()
		in.mouseWheel = GetRawMouseWheel()
		in.mouseWheelDelta = GetRawMouseWheelDelta()

		//colog("wheel=" + str(in.mouseWheel) + ", delta=" + str(in.mouseWheelDelta))
		
		if in.leftMousePressed
			in.ptrPressed = 1
		elseif in.rightMousePressed
			in.ptrPressed = 2
		else 
			in.ptrPressed = 0
		endif

		if in.leftMouseReleased
			in.ptrReleased = 1
		elseif in.rightMouseReleased
			in.ptrReleased = 2
		else 
			in.ptrReleased = 0
		endif

		if in.leftMouseDown
			in.ptrDown = 1
		elseif in.rightMouseDown
			in.ptrDown = 2
		else 
			in.ptrDown = 0
		endif
		
		in.ptrX = in.mouseX
		in.ptrY = in.mouseY

	else 
		
		in.ptrPressed = GetPointerPressed()
		in.ptrDown = GetPointerState()
		in.ptrReleased = GetPointerReleased()
		in.ptrX = GetPointerX()
		in.ptrY = GetPointerY()
		
	endif

endfunction

//-----------------------------------------------------
//
function inKeys()

	local i as integer
	local lastScan as integer
	local lastKey as integer
	local shiftDown as integer
	local c as string
	local pressed as integer
	local m as integer
	local butIdx as integer

	in.keyPressedScan = 0
	in.keyPressed = 0
	
	if in.hasKeyboard

		shiftDown = GetRawKeyState(KEY_SHIFT)
		lastScan = GetRawLastKey()
		lastKey = inScanToAsc(lastScan, shiftDown)
		
		if lastScan <> KEY_SHIFT
			
			if GetRawKeyPressed(lastScan)
				
				pressed = true
				in.keyRepeatTime = GetMilliseconds()
				in.keyWaitTime = KEY_WAIT_TIME
				
			elseif GetRawKeyState(lastScan)

				m = GetMilliseconds()
				
				if m - in.keyRepeatTime >= in.keyWaitTime
					
					pressed = true
					in.keyRepeatTime = m
					in.keyWaitTime = KEY_REPEAT_TIME
					
				endif
					
			endif

			if pressed

				in.keyPressedScan = lastScan
				in.keyPressed = lastKey

				if in.keyPressed <> 0
					c = chr(in.keyPressed)
				else
					c = ""
				endif

				if in.keyPressedScan = KEY_LEFT
					in.keyPressedScan = KEY_CTRL_LEFT
				elseif in.keyPressedScan = KEY_RIGHT
					in.keyPressedScan = KEY_CTRL_RIGHT
				endif

				OnKeyAction(in.keyPressedScan, c)

			endif

		endif
		
	endif
	
endfunction

//-----------------------------------------------------
//
function inIsScanControl(scanCode as integer)

	local ret as integer
	
	if scanCode = KEY_CTRL_123 or scanCode = KEY_CTRL_ABC or scanCode = KEY_CTRL_SYM or scanCode = KEY_CTRL_UNSHIFT or scanCode = KEY_SHIFT or scanCode = KEY_ENTER
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
//
function inScanToAsc(scanCode as integer, shiftDown as integer)

	local a as integer

	if shiftDown

		if scanCode >= 65 and scanCode <= 90 // A - Z
			a = scanCode
		elseif scanCode = KEY_TOP_1
			a = 33
		elseif scanCode = KEY_TOP_2
			a = 64
		elseif scanCode = KEY_TOP_3
			a = 35
		elseif scanCode = KEY_TOP_4
			a = 36
		elseif scanCode = KEY_TOP_5
			a = 37
		elseif scanCode = KEY_TOP_6
			a = 94
		elseif scanCode = KEY_TOP_7
			a = 38
		elseif scanCode = KEY_TOP_8
			a = 42
		elseif scanCode = KEY_TOP_9
			a = 40
		elseif scanCode = KEY_TOP_0
			a = 41
		elseif scanCode = 48 // 0
			a = 41	
		elseif scanCode = 49 // 1
			a = 33
		elseif scanCode = 50 // 2
			a = 64
		elseif scanCode = 51 // 3
			a = 35
		elseif scanCode = 52 // 4
			a = 36
		elseif scanCode = 53 // 5
			a = 37
		elseif scanCode = 54 // 6
			a = 94
		elseif scanCode = 55 // 7
			a = 38
		elseif scanCode = 56 // 8
			a = 42
		elseif scanCode = 57 // 9
			a = 40
		elseif scanCode = 32
			a = scanCode
		elseif scanCode = KEY_SEMICOLON
			a = 58
		elseif scanCode = KEY_EQUALS
			a = 43
		elseif scanCode = KEY_COMMA
			a = 60
		elseif scanCode = KEY_DASH
			a = 95
		elseif scanCode = KEY_PERIOD
			a = 62
		elseif scanCode = KEY_SLASH
			a = 63
		elseif scanCode = KEY_APOS
			a = 34
		elseif scanCode = KEY_LBRACKET
			a = 123
		elseif scanCode = KEY_RBRACKET
			a = 125
		elseif scanCode = KEY_BACKSLASH
			a = 124
		elseif scanCode = KEY_HASH
			a = 35
		elseif scanCode = KEY_TICK
			a = 126
		else
			a = 0
		endif

	else

		if scanCode >= 65 and scanCode <= 90 // A - Z
			a = scanCode + 32
		elseif scanCode >= 48 and scanCode <= 57 // 0 - 9
			a = scanCode		
		elseif scanCode >= 263 and scanCode <= 272 // 0 - 9 numeric keypad
			a = scanCode - 215	
		elseif scanCode = 32
			a = scanCode
		elseif scanCode = KEY_SEMICOLON
			a = 59
		elseif scanCode = KEY_EQUALS
			a = 61
		elseif scanCode = KEY_COMMA
			a = 44
		elseif scanCode = KEY_DASH
			a = 45
		elseif scanCode = KEY_PERIOD
			a = 46
		elseif scanCode = KEY_SLASH
			a = 47
		elseif scanCode = KEY_APOS
			a = 39
		elseif scanCode = KEY_LBRACKET
			a = 91
		elseif scanCode = KEY_RBRACKET
			a = 93
		elseif scanCode = KEY_BACKSLASH
			a = 92
		elseif scanCode = KEY_HASH
			a = 35
		elseif scanCode = KEY_TICK
			a = 96
		else
			a = 0
		endif

	endif

	//colog("scanCode=" + str(scanCode) + ", shiftDown=" + str(shiftDown) + ", a=" + str(a))
	
endfunction a

//
//
//




