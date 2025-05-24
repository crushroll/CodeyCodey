#option_explicit

#include "common.agc"

#constant T_EOF 0
#constant T_STRING 1
#constant T_NUMBER 2
#constant T_SYMBOL 3
#constant T_IDENT 4

#constant JSON_NULL 0
#constant JSON_OBJECT 1
#constant JSON_ARRAY 2
#constant JSON_STRING 3
#constant JSON_NUMBER 4
#constant JSON_BOOL 5

//----------------------------------------------------------
// Json value, supports all json types.
//
type JsonValue

	typ as integer
	obj as JsonPair[]
	arr as JsonEntry[]
	strValue as string
	nbrValue as float
	boolValue as integer
	

endtype

//----------------------------------------------------------
//
function jsonSetByName(jv ref as JsonValue, name as string, value ref as JsonValue)

	local pair as JsonPair
	local i as integer
	local idx as integer
	
	if jv.typ <> JSON_OBJECT		
		jv.obj.length = -1		
	endif

	jv.typ = JSON_OBJECT

	jv.arr.length = -1
	jv.strValue = ""
	jv.nbrValue = 0
	jv.boolValue = false
	
	// If was already an object, remove item with name.
	for i = 0 to jv.obj.length
		
		if jv.obj[i].name = name

			jv.obj.remove(i)
			exit

		endif
				
	next

	pair.name = name
	pair.value = value
	jv.obj.insert(pair)
	
endfunction

//----------------------------------------------------------
// Get all the name keys from an object.
//
function jsonGetNames(jv ref as JsonValue)

	local ret as string[]
	local i as integer

	if jv.typ = JSON_OBJECT

		for i = 0 to jv.obj.length			
			ret.insertsorted(jv.obj[i].name)				
		next
		
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonGetByName(jv ref as JsonValue, name as string)

	local ret as JsonValue
	local i as integer
	
	if jv.typ = JSON_OBJECT

		for i = 0 to jv.obj.length
			
			if jv.obj[i].name = name
				
				ret = jv.obj[i].value
				exit

			endif
				
		next
		
	endif
	
endfunction ret

//----------------------------------------------------------
// Coercing to arr, if not already one.
//
function jsonSetByAppend(jv ref as JsonValue, value ref as JsonValue)

	local entry as JsonEntry
	
	if jv.typ <> JSON_ARRAY
		jv.arr.length = -1
	endif
	
	jv.typ = JSON_ARRAY

	jv.obj.length = -1
	jv.strValue = ""
	jv.nbrValue = 0
	jv.boolValue = false

	entry.value = value
	jv.arr.insert(entry)
	
endfunction

//----------------------------------------------------------
// Coercing to arr, if not already one.
//
function jsonSetByIndex(jv ref as JsonValue, idx as integer, value ref as JsonValue)

	local entry as JsonEntry
	
	if jv.typ <> JSON_ARRAY
		jv.arr.length = -1
	endif
	
	jv.typ = JSON_ARRAY

	jv.obj.length = -1
	jv.strValue = ""
	jv.nbrValue = 0
	jv.boolValue = false

	if idx <= jv.arr.length
		
		entry.value = value
		jv.arr.insert(entry, idx)

	else

		jv.arr.insert(entry)
			
	endif
	
endfunction

//----------------------------------------------------------
//
function jsonGetByIndex(jv ref as JsonValue, idx as integer)

	local ret as JsonValue
	local entry as JsonEntry
	
	if jv.typ = JSON_ARRAY
		
		if idx <= jv.arr.length

			entry = jv.arr[idx]			
			ret = entry.value
			
		endif
		
	endif
	
endfunction ret


//----------------------------------------------------------
//
function jsonSetString(jv ref as JsonValue, strValue as string)

	jv.typ = JSON_STRING
	jv.strValue = strValue

	jv.obj.length = -1
	jv.arr.length = -1
	jv.nbrValue = 0
	jv.boolValue = false
	
endfunction

//----------------------------------------------------------
//
function jsonGetString(jv ref as JsonValue)

	local ret as string
	
	if jv.typ <> JSON_STRING
		ret = ""
	else
		ret = jv.strValue
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonGetStringDef(jv ref as JsonValue, def as string)

	local ret as string
	
	if jv.typ <> JSON_STRING
		ret = def
	else
		ret = jv.strValue
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonSetInt(jv ref as JsonValue, intValue as integer)

	jv.typ = JSON_NUMBER
	jv.nbrValue = intValue

	jv.obj.length = -1
	jv.arr.length = -1
	jv.strValue = ""
	jv.boolValue = false
	
endfunction

//----------------------------------------------------------
//
function jsonGetInt(jv ref as JsonValue)

	local ret as integer
	
	if jv.typ <> JSON_NUMBER
		ret = 0
	else
		ret = round(jv.nbrValue)
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonGetIntDef(jv ref as JsonValue, def as integer)

	local ret as integer
	
	if jv.typ <> JSON_NUMBER
		ret = def
	else
		ret = round(jv.nbrValue)
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonSetFloat(jv ref as JsonValue, floatValue as float)

	jv.typ = JSON_NUMBER
	jv.nbrValue = floatValue

	jv.obj.length = -1
	jv.arr.length = -1
	jv.strValue = ""
	jv.boolValue = false
	
endfunction

//----------------------------------------------------------
//
function jsonGetFloat(jv ref as JsonValue)

	local ret as float
	
	if jv.typ <> JSON_NUMBER
		ret = 0.0
	else
		ret = jv.nbrValue
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonGetFloatDef(jv ref as JsonValue, def as float)

	local ret as float
	
	if jv.typ <> JSON_NUMBER
		ret = def
	else
		ret = jv.nbrValue
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonSetBool(jv ref as JsonValue, boolValue as integer)

	jv.typ = JSON_BOOL
	jv.boolValue = boolValue

	jv.obj.length = -1
	jv.arr.length = -1
	jv.nbrValue = 0
	jv.strValue = ""
	
endfunction

//----------------------------------------------------------
//
function jsonGetBool(jv ref as JsonValue)

	local ret as integer
	
	if jv.typ <> JSON_BOOL
		ret = false
	else
		ret = jv.boolValue
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonGetBoolDef(jv ref as JsonValue, def as integer)

	local ret as integer
	
	if jv.typ <> JSON_BOOL
		ret = def
	else
		ret = jv.boolValue
	endif
	
endfunction ret

//----------------------------------------------------------
//
function jsonSetNull(jv ref as JsonValue)

	jv.typ = JSON_NULL

	jv.obj.length = -1
	jv.arr.length = -1
	jv.strValue = ""
	jv.nbrValue = 0
	jv.boolValue = false
	
endfunction

//----------------------------------------------------------
//
function jsonIsNull(jv ref as JsonValue)

	local ret as integer
	
	if jv.typ = JSON_NULL
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//----------------------------------------------------------
// Json parser types.
//
type JsonParser

	text as string
	toke as String
	typ as integer
	pos as integer
	
endtype

type JsonEntry

	value as JsonValue

endtype

type JsonPair

	name as string
	value as JsonValue

endtype

type JsonPrinter

	jv as JsonValue
	ind as integer // The indent value.
	width as integer // width of an ind.
	nl as integer // Last char output.
	
endtype

//----------------------------------------------------------
// Parse a string into a JsonValue.
//
function jsonParse(dbg as string, text as String)

	local jp as JsonParser
	local jv as JsonValue
	
	jp.text = text
	jp.pos = 0	
	jsonBump(jp)
	jv = jsonParseValue(dbg, jp)
	
Endfunction jv

//----------------------------------------------------------
//
function jsonParseValue(dbg as string, jp ref as JsonParser)

	local ret as JsonValue
	
	If jp.typ = T_STRING
		ret = jsonString(jsonParseString(jp))
	elseIf jp.typ = T_NUMBER
		ret = jsonNumber(jsonParseNumber(jp))
	elseIf jp.toke = "{"
		ret = jsonObject(jsonParseObject(jp))
	elseIf jp.toke = "["
		ret = jsonArray(jsonParseArray(jp))
	elseIf jsonCParse(jp, "true")
		ret = jsonBool(True)
	elseIf jsonCParse(jp, "false")
		ret = jsonBool(False)
	elseIf jsonCParse(jp, "null")
		ret = jsonNull()
	else
		colog("jsonParseValue error: json not recognised (" + dbg + "). typ=" + str(jp.typ) + ", toke=" + jp.toke)
	endif
	
Endfunction ret

//----------------------------------------------------------
//
function jsonObject(obj ref as JsonPair[])

	local ret as JsonValue

	ret.typ = JSON_OBJECT
	ret.obj = obj
	
endfunction ret

//----------------------------------------------------------
//
function jsonArray(arr ref as JsonEntry[])

	local ret as JsonValue

	ret.typ = JSON_ARRAY
	ret.arr = arr
	
endfunction ret

//----------------------------------------------------------
//
function jsonString(s as string)

	local ret as JsonValue

	ret.typ = JSON_STRING
	ret.strValue = s
	
endfunction ret

//----------------------------------------------------------
//
function jsonNumber(nbr as string)

	local ret as JsonValue

	ret.typ = JSON_NUMBER
	ret.nbrValue = val(nbr)
	
endfunction ret

//----------------------------------------------------------
//
function jsonBool(bool as integer)

	local ret as JsonValue

	ret.typ = JSON_BOOL
	ret.boolValue = bool
	
endfunction ret

//----------------------------------------------------------
//
function jsonNull()

	local ret as JsonValue

	ret.typ = JSON_NULL
	
endfunction ret

//----------------------------------------------------------
// pos is zero-based, so need to add 1 for mid()
//
function jsonOneChar(jp ref as JsonParser, pos as integer)

	local ret as integer
	
	ret = asc(mid(jp.text, pos + 1, 1)) //_text[_pos-1]

endfunction ret

//----------------------------------------------------------
//
function jsonGetChar(jp ref as JsonParser)

	local ret as integer
	
	If jp.pos = len(jp.text)
		
		colog("GetChar error: EOF")
		exitfunction 0

	endif
		
	inc jp.pos
	
	ret = jsonOneChar(jp, jp.pos - 1) //_text[_pos-1]
	
Endfunction ret

//----------------------------------------------------------
//
function jsonPeekChar(jp ref as JsonParser)

	local ret as integer
	
	If jp.pos = len(jp.text)
		ret = 0
	else
		ret = jsonOneChar(jp, jp.pos)
	endif

Endfunction ret

//----------------------------------------------------------
//
function jsonParseChar(jp ref as JsonParser, ch as integer)
	
	If jp.pos >= len(jp.text) Or jsonOneChar(jp, jp.pos) <> ch
		
		colog("ParseChar error: EOF or wrong expected ch")
		exitfunction
		
	endif
	
	inc jp.pos
	
Endfunction

//----------------------------------------------------------
//
function jsonCParseChar(jp ref as JsonParser, ch as integer)

	local ret as integer
	
	If jp.pos >= len(jp.text) Or jsonOneChar(jp, jp.pos) <> ch
		
		ret = False
		
	else

		inc jp.pos
		ret = true
		
	endif
	
Endfunction ret

//----------------------------------------------------------
//
function jsonCParseDigits(jp ref as JsonParser)

	local p as integer
	local a as integer

	p = jp.pos
	
	While jp.pos < len(jp.text)

		a = jsonOneChar(jp, jp.pos)
		
		if a >= 48 And a <= 57
			inc jp.pos
		else
			exit
		endif
		
	endwhile
	
Endfunction jp.pos > p

//----------------------------------------------------------
//
function jsonBump(jp ref as JsonParser)

	local a as integer
	local ch as integer
	Local pos as integer
	
	a = jsonOneChar(jp, jp.pos)

	While jp.pos < len(jp.text) And a <= 32
		
		inc jp.pos
		a = jsonOneChar(jp, jp.pos)
		
	endwhile
	
	If jp.pos = len(jp.text)
		
		jp.toke = ""
		jp.typ = T_EOF
		exitfunction jp.toke
		
	Endif
		
	pos = jp.pos	
	ch = jsonGetChar(jp)
	
	If ch = 34 // "
		
		while true
			
			ch = jsonGetChar(jp)
			If ch = 34 then Exit // "
			If ch = 92 then jsonGetChar(jp) // \
				
		endwhile
		
		jp.typ = T_STRING
		
	ElseIf ch = 45 Or (ch >= 48 And ch <= 57) // - or 0 to 9
	
		If ch = 45 //-
			
			ch = jsonGetChar(jp)
			
			If ch < 48 Or ch > 57 // not 0 to 9
				
				colog("Bump error: Invalid digit " + str(ch))
				exitfunction ""
				
			endif
				
		Endif
		
		If ch <> 48 // 0
			jsonCParseDigits(jp)
		Endif
		
		If jsonCParseChar(jp, 46) //.
			jsonCParseDigits(jp)
		Endif
		
		If jsonCParseChar(jp, 69) Or jsonCParseChar(jp, 101) //e E
			
			If jsonPeekChar(jp) = 43 Or jsonPeekChar(jp) = 45 then jsonGetChar(jp)	//+ -

			If Not jsonCParseDigits(jp)
				colog("Bump error: Expected digit")
			endif
			
		Endif
		
		jp.typ = T_NUMBER
		
	ElseIf (ch >= 65 And ch < 91) Or (ch >= 97 And ch < 123) // upper or lower
		
		ch = jsonPeekChar(jp)
		
		While (ch >= 65 And ch < 91) Or (ch >= 97 And ch < 123) // upper or lower
			
			jsonGetChar(jp)
			ch = jsonPeekChar(jp)
			
		endwhile

		jp.typ = T_IDENT

	Else
		
		jp.typ = T_SYMBOL
		
	Endif
	
	jp.toke = mid(jp.text, pos + 1, jp.pos - pos) // _text[pos.._pos]
		
Endfunction jp.toke

//----------------------------------------------------------
//
function jsonCParse(jp ref as JsonParser, toke as String)

	local ret as integer
	
	If toke <> jp.toke
		
		ret = False
		
	else
		
		jsonBump(jp)
		ret = True

	endif
	
Endfunction ret

//----------------------------------------------------------
//
function jsonParseToke(jp ref as JsonParser, toke as String)
	
	If Not jsonCParse(jp, toke)
		colog("Parse error: failed to parse toke " + toke)
	endif
	
Endfunction

//----------------------------------------------------------
//
function jsonParseObject(jp ref as JsonParser)

	local ret as JsonPair[]
	local pair as JsonPair
	local name as string
	local value as JsonValue
	
	jsonParseToke(jp, "{")

	If jsonCParse(jp, "}") then exitfunction ret
		
	Repeat
		
		name = jsonParseString(jp)
		jsonParseToke(jp, ":")
		value = jsonParseValue("3", jp)
		pair.name = name
		pair.value = value
		ret.insert(pair)
		
	Until Not jsonCParse(jp, ",")
	
	jsonParseToke(jp, "}")
	
Endfunction ret

//----------------------------------------------------------
//
function jsonParseArray(jp ref as JsonParser)
	
	Local ret as JsonEntry[]
	local value as JsonValue
	local entry as JsonEntry
	
	jsonParseToke(jp, "[")
	
	If jsonCParse(jp, "]") then exitfunction ret
		
	Repeat
		
		value = jsonParseValue("2", jp)
		entry.value = value
		ret.insert(entry)
		
	Until Not jsonCParse(jp, ",")
	
	jsonParseToke(jp, "]")
	
Endfunction ret

//----------------------------------------------------------
//
function jsonParseString(jp ref as JsonParser)
	
	If jp.typ <> T_STRING

		colog("ParseString error: not a string")
		exitfunction ""

	endif
	
	Local toke as string
	local i as integer
	local frags as string[]
	local p as integer
	local esc as string
	local va as integer
	local j as integer
	local ch as integer
	local c as string
	
	toke = mid(jp.toke, 2, len(jp.toke) - 2) // [1..-1]
	
	i = findstring(toke, "\") - 1
	
	If i <> -1
		
		p = 0
		esc = ""
		
		while true
			
			If i + 1 >= len(toke)
				
				colog("ParseString error: too short")
				exitfunction ""

			endif
			
			frags.insert(mid(toke, p + 1, i - p))
			
			c = mid(toke, i + 2, 1)
			
			Select asc(c)
				Case 34
					esc = '"'					//\"
				endcase
				Case 92
					esc = "\"					//\\
				endcase
				Case 47
					esc = "/"					//\/
				endcase
				Case 98
					esc = chr(8)	//\b
				endcase
				Case 102
					esc = chr(12)	//\f
				endcase
				Case 114
					esc = chr(13)	//\r
				endcase
				Case 110
					esc = chr(10)	//\n
				endcase
				Case 117							//\uxxxx
					If i + 6 > len(toke)
						
						colog("ParseString error: token too short")
						exitfunction ""

					endif
					
					va = 0
					
					For j = 2 to 6
						
						ch = asc(mid(toke, i + j + 1, 1))
						
						If ch >= 48 And ch < 58
							
							va = va << 4 || (ch - 48)
							
						ElseIf ch >= 65 And ch < 123
						
							ch = ch && 31
							
							If ch < 1 Or ch > 6
								
								colog("ParseString error: bad char")
								exitfunction ""

							endif
							
							va = va << 4 || (ch + 9)
							
						Else

							colog("ParseString error: bugger")
							exitfunction ""
							
						Endif
						
					Next
					
					esc = chr(va)				
					i = i + 4
					
				endcase
					
				case Default
					colog("ParseString error: bombed")
					exitfunction ""
				endcase
				
			Endselect
			
			frags.insert(esc)
			
			p = i + 2
			i = findstring(toke, "\", 1, p + 1) - 1
			
			If i <> -1 then Continue
			frags.insert(mid(toke, p + 1, -1))
			
			Exit
			
		endwhile
		
		toke = jsonJoinString(frags)
		
	Endif
	
	jsonBump(jp)
	
Endfunction toke

//----------------------------------------------------------
//
function jsonJoinString(bits ref as string[])

	local ret as String
	local i as integer

	ret = ""
	
	for i = 0 to bits.length

		ret = ret + bits[i]
		
	next
	
endfunction ret

//----------------------------------------------------------
//
function jsonParseNumber(jp ref as JsonParser)
	
	If jp.typ <> T_NUMBER
		
		colog("ParseNumber error: not a number")
		exitfunction ""

	endif
	
	Local toke as string

	toke = jp.toke
	jsonBump(jp)
	
Endfunction toke

//----------------------------------------------------------
//
function jsonToString(jv ref as JsonValue)

	local jp as JsonPrinter
	local ret as string 

	jp.jv = jv
	jp.ind = 0
	jp.width = 0
	jp.nl = false
	ret = jsonPrint(jp)
	ret = ret + jsonEol(jp)
	
endfunction ret

//----------------------------------------------------------
//
function jsonIndent(jp ref as JsonPrinter)

	local s as string

	s = spaces(jp.width * jp.ind)
	
endfunction s

//----------------------------------------------------------
//
function jsonEol(jp ref as JsonPrinter)

	local s as string
		
	if jp.width

		if not jp.nl
			
			s = chr(10)
			jp.nl = true

		endif
		
	else
		
		s = ""
		
	endif
	
endfunction s

//----------------------------------------------------------
//
function jsonPrint(jp ref as JsonPrinter)

	local i as integer
	local s as string
	local t as string 
	local jv as JsonValue
	local pair as JsonPair
	local entry as JsonEntry
	local jp2 as JsonPrinter

	jv = jp.jv
	s = ""
	
	if jv.typ = JSON_OBJECT

		s = s + jsonEol(jp)
		s = s + jsonIndent(jp) + "{"
		jp.nl = false
		s = s + jsonEol(jp)
		inc jp.ind
		
		for i = 0 to jv.obj.length

			if i > 0

				s = s + ","
				jp.nl = false
				s = s + jsonEol(jp)

			endif
			
			pair = jv.obj[i]
			s = s + jsonIndent(jp)
			s = s + '"' + pair.name + '"'
			s = s + ":"
			jp.nl = false
			
			//s = s + jsonToString(pair.value)
			jp2.jv = pair.value
			jp2.ind = jp.ind
			jp2.width = jp.width
			jp2.nl = jp.nl
			s = s + jsonPrint(jp2)
			jp.nl = jp2.nl
			
		next

		dec jp.ind
		s = s + jsonEol(jp)
		s = s + jsonIndent(jp) + "}"
		jp.nl = false
		//s = s + jsonEol(jp)
		
	elseif jv.typ = JSON_ARRAY

		s = s + jsonEol(jp)
		s = s + jsonIndent(jp) + "["
		jp.nl = false
		s = s + jsonEol(jp)
		inc jp.ind
		
		for i = 0 to jv.arr.length

			if i > 0

				s = s + ","
				jp.nl = false
				s = s + jsonEol(jp)

			endif
			
			entry = jv.arr[i]
			
			//s = s + jsonToString(entry.value)
			jp2.jv = entry.value
			jp2.ind = jp.ind
			jp2.width = jp.width
			jp2.nl = jp.nl
			s = s + jsonPrint(jp2)
			jp.nl = jp2.nl
			
		next

		dec jp.ind
		s = s + jsonEol(jp)
		s = s + jsonIndent(jp) + "]"
		jp.nl = false
		//s = s + jsonEol(jp)

	elseif jv.typ = JSON_STRING

		s = s + '"' + jv.strValue + '"'
		jp.nl = false
		
	elseif jv.typ = JSON_NUMBER

		t = str(jv.nbrValue)
		t = coTrimFloatStr(t)
		s = s + t
		jp.nl = false
		
	elseif jv.typ = JSON_BOOL

		if jv.boolValue
			s = s + "true"
		else
			s = s + "false"
		endif

		jp.nl = false
		
	elseif jv.typ = JSON_NULL

		s = s + "null"
		jp.nl = false
		
	endif

endfunction s

//
// End
//

