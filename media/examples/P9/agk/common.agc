#option_explicit

//
// Common code.
//

//-----------------------------------------------------
// Booleans.
//
#constant FALSE = 0
#constant TRUE = 1

//-----------------------------------------------------
// General purpose directions.

#constant DIR_N 1
#constant DIR_S 2
#constant DIR_E 4
#constant DIR_W 8

#constant DIR_NE 5
#constant DIR_NW 9
#constant DIR_SE 6
#constant DIR_SW 10

#constant DIR_ALL 15

// Superhack to mean extreme directions.
#constant DIR_NN 0x10
#constant DIR_SS 0x20
#constant DIR_EE 0x40
#constant DIR_WW 0x80

#constant CO_CS 16
#constant CO_CS2 8
#constant CO_BS 128
#constant CO_BS2 64

#constant CO_LINE_MID_CIRC 1
#constant CO_LINE_MID_SQR 2
#constant CO_LINE_END_CIRC 3
#constant CO_LINE_END_SQR 4

#constant CO_FONT_REGULAR 0
#constant CO_FONT_EXTRA_LIGHT 1
#constant CO_FONT_LIGHT 2
#constant CO_FONT_MEDIUM 3
#constant CO_FONT_SEMI_BOLD 4
#constant CO_FONT_BOLD 5
#constant CO_FONT_BLACK 6

// Var depth, 200 / 4 = 50 vars.
#constant VAR_DEPTH_MAX 50 // Max logical depth.
#constant VAR_DEPTH_SKIP 4 // Allow for the layers of a tip, i.e. border text, etc.
#constant VAR_DEPTH_BASE 200 // The lowest depth during design or runtime.
#constant BACK_DEPTH 10000

#constant _Q chr(34)
#constant _T chr(9)
#constant _N chr(13)
#constant _L chr(10)

#constant CO_DELIMS$ = " ~!@#$%^&*()_+`-=[]\[]\;':,./<>?" + chr(34)
#constant CO_LOWERS$ = "abcdefghijklmnopqrstuvwxyz"
#constant CO_UPPERS$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#constant CO_DIGITS$ = "0123456789"

global CO_PI as float
global CO_PI_2 as float

//-----------------------------------------------------
global co as Common

type Line

	x0 as float
	y0 as float // y first, because we want to sort by y.
	x1 as float
	y1 as float
	
endtype

type Rect

	x as float
	y as float // y first, because we want to sort by y.
	w as float
	h as float
	
endtype

type Point

	x as float
	y as float
	
endtype

type Circle 
	
	smoothImg as integer
	pixelImg as integer
	smoothSpr as integer
	pixelSpr as integer
	size as integer
	
endtype

//-----------------------------------------------------
type Common
	
	pixImg as integer
	cs as float // Width of one block, e.g. 8
	bs as float // Width of a square button.
	w as float
	h as float
	circles as Circle[]
	
	red as integer[9]
	blue as integer[9]
	green as integer[9]
	deeppurple as integer[9]
	yellow as integer[9]
	pink as integer[9]
	orange as integer[9]
	indigo as integer[9]
	amber as integer[9]
	deeporange as integer[9]
	grey as integer[9]
	brown as integer[9]
	lightgreen as integer[9]
	lime as integer[9]
	teal as integer[9]
	lightblue as integer[9]
	cyan as integer[9]
	purple as integer[9]
	bluegrey as integer[9]
	white as integer
	black as integer

	fonts as Font[]
	fontSizes as float[]
	editFontSizes as float[]

	dateFmt as string[]
	dateFmtHelp as string[]
	timeFmt as string[]
	timeFmtHelp as string[]
	days as string[]
	months as string[]
	
	uname as integer[3] // 4 chars, 0-3
	
endtype

//-----------------------------------------------------
// Used in fill algorithm.
//
type Segment

	y as integer
	xl as integer
	xr as integer
	dy as integer

Endtype

type Bounds

	x0 as integer
	y0 as integer
	x1 as integer
	y1 as integer

endtype

type Font 
	
	name as string
	id as integer
	weight as integer
	italic as integer
	
endtype
		
//-----------------------------------------------------
function coInit()

	local i as integer
	local f as float
	local font as Font
		
	co.pixImg = LoadImage("gfx/pix.png")
	//coInitCircles()

	CO_PI = 3.14159265359
	CO_PI_2 = CO_PI / 2.0

	co.cs = CO_CS
	co.bs = CO_BS
	
	co.w = GetVirtualWidth() // 2048
	co.h = GetVirtualHeight() // 1536
		
	co.red[0] = coMakeHexColor("FFEBEE")
	co.red[1] = coMakeHexColor("FFCDD2")
	co.red[2] = coMakeHexColor("EF9A9A")
	co.red[3] = coMakeHexColor("E57373")
	co.red[4] = coMakeHexColor("EF5350")
	co.red[5] = coMakeHexColor("F44336")
	co.red[6] = coMakeHexColor("E53935")
	co.red[7] = coMakeHexColor("D32F2F")	
	co.red[8] = coMakeHexColor("C62828")	
	co.red[9] = coMakeHexColor("B71C1C")	
	co.blue[0] = coMakeHexColor("E3F2FD")
	co.blue[1] = coMakeHexColor("BBDEFB")
	co.blue[2] = coMakeHexColor("90CAF9")
	co.blue[3] = coMakeHexColor("64B5F6")
	co.blue[4] = coMakeHexColor("42A5F5")
	co.blue[5] = coMakeHexColor("2196F3")
	co.blue[6] = coMakeHexColor("1E88E5")
	co.blue[7] = coMakeHexColor("1976D2")
	co.blue[8] = coMakeHexColor("1565C0")
	co.blue[9] = coMakeHexColor("0D47A1")
	co.green[0] = coMakeHexColor("E8F5E9")
	co.green[1] = coMakeHexColor("C8E6C9")
	co.green[2] = coMakeHexColor("A5D6A7")
	co.green[3] = coMakeHexColor("81C784")
	co.green[4] = coMakeHexColor("66BB6A")
	co.green[5] = coMakeHexColor("4CAF50")
	co.green[6] = coMakeHexColor("43A047")
	co.green[7] = coMakeHexColor("388E3C")
	co.green[8] = coMakeHexColor("2E7D32")
	co.green[9] = coMakeHexColor("1B5E20")
	co.deeppurple[0] = coMakeHexColor("EDE7F6")
	co.deeppurple[1] = coMakeHexColor("D1C4E9")
	co.deeppurple[2] = coMakeHexColor("B39DDB")
	co.deeppurple[3] = coMakeHexColor("9575CD")
	co.deeppurple[4] = coMakeHexColor("7E57C2")
	co.deeppurple[5] = coMakeHexColor("673AB7")
	co.deeppurple[6] = coMakeHexColor("5E35B1")
	co.deeppurple[7] = coMakeHexColor("512DA8")	
	co.deeppurple[8] = coMakeHexColor("4527A0")	
	co.deeppurple[9] = coMakeHexColor("311B92")	
	co.yellow[0] = coMakeHexColor("FFFDE7")
	co.yellow[1] = coMakeHexColor("FFF9C4")
	co.yellow[2] = coMakeHexColor("FFF59D")
	co.yellow[3] = coMakeHexColor("FFF176")
	co.yellow[4] = coMakeHexColor("FFEE58")
	co.yellow[5] = coMakeHexColor("FFEB3B")
	co.yellow[6] = coMakeHexColor("FDD835")
	co.yellow[7] = coMakeHexColor("FBC02D")
	co.yellow[8] = coMakeHexColor("F9A825")
	co.yellow[9] = coMakeHexColor("F57F17")
	co.amber[0] = coMakeHexColor("FFF8E1")
	co.amber[1] = coMakeHexColor("FFECB3")
	co.amber[2] = coMakeHexColor("FFE082")
	co.amber[3] = coMakeHexColor("FFD54F")
	co.amber[4] = coMakeHexColor("FFCA28")
	co.amber[5] = coMakeHexColor("FFC107")
	co.amber[6] = coMakeHexColor("FFB300")
	co.amber[7] = coMakeHexColor("FFA000")	
	co.amber[8] = coMakeHexColor("FF8F00")
	co.amber[9] = coMakeHexColor("FF6F00")
	co.pink[0] = coMakeHexColor("FCE4EC")
	co.pink[1] = coMakeHexColor("F8BBD0")
	co.pink[2] = coMakeHexColor("F48FB1")
	co.pink[3] = coMakeHexColor("F06292")
	co.pink[4] = coMakeHexColor("EC407A")
	co.pink[5] = coMakeHexColor("E91E63")
	co.pink[6] = coMakeHexColor("D81B60")
	co.pink[7] = coMakeHexColor("C2185B")
	co.pink[8] = coMakeHexColor("AD1457")
	co.pink[9] = coMakeHexColor("880E4F")
	co.orange[0] = coMakeHexColor("FFF3E0")
	co.orange[1] = coMakeHexColor("FFE0B2")
	co.orange[2] = coMakeHexColor("FFCC80")
	co.orange[3] = coMakeHexColor("FFB74D")
	co.orange[4] = coMakeHexColor("FFA726")
	co.orange[5] = coMakeHexColor("FF9800")
	co.orange[6] = coMakeHexColor("FB8C00")
	co.orange[7] = coMakeHexColor("F57C00")
	co.orange[8] = coMakeHexColor("EF6C00")
	co.orange[9] = coMakeHexColor("E65100")
	co.deeporange[0] = coMakeHexColor("FBE9E7")
	co.deeporange[1] = coMakeHexColor("FFCCBC")
	co.deeporange[2] = coMakeHexColor("FFAB91")
	co.deeporange[3] = coMakeHexColor("FF8A65")
	co.deeporange[4] = coMakeHexColor("FF7043")
	co.deeporange[5] = coMakeHexColor("FF5722")
	co.deeporange[6] = coMakeHexColor("F4511E")
	co.deeporange[7] = coMakeHexColor("E64A19")
	co.deeporange[8] = coMakeHexColor("D84315")
	co.deeporange[9] = coMakeHexColor("BF360C")
	co.indigo[0] = coMakeHexColor("E8EAF6")
	co.indigo[1] = coMakeHexColor("C5CAE9")
	co.indigo[2] = coMakeHexColor("9FA8DA")
	co.indigo[3] = coMakeHexColor("7986CB")
	co.indigo[4] = coMakeHexColor("5C6BC0")
	co.indigo[5] = coMakeHexColor("3F51B5")
	co.indigo[6] = coMakeHexColor("3949AB")
	co.indigo[7] = coMakeHexColor("303F9F")
	co.indigo[8] = coMakeHexColor("283593")
	co.indigo[9] = coMakeHexColor("1A237E")
	co.brown[0] = coMakeHexColor("EFEBE9")
	co.brown[1] = coMakeHexColor("D7CCC8")
	co.brown[2] = coMakeHexColor("BCAAA4")
	co.brown[3] = coMakeHexColor("A1887F")
	co.brown[4] = coMakeHexColor("8D6E63")
	co.brown[5] = coMakeHexColor("795548")
	co.brown[6] = coMakeHexColor("6D4C41")
	co.brown[7] = coMakeHexColor("5D4037")	
	co.brown[8] = coMakeHexColor("4E342E")
	co.brown[9] = coMakeHexColor("3E2723")
	co.grey[0] = coMakeHexColor("FAFAFA")
	co.grey[1] = coMakeHexColor("F5F5F5")
	co.grey[2] = coMakeHexColor("EEEEEE")
	co.grey[3] = coMakeHexColor("E0E0E0")
	co.grey[4] = coMakeHexColor("BDBDBD")
	co.grey[5] = coMakeHexColor("9E9E9E")	
	co.grey[6] = coMakeHexColor("757575")
	co.grey[7] = coMakeHexColor("616161")
	co.grey[8] = coMakeHexColor("424242")
	co.grey[9] = coMakeHexColor("212121")
	co.lightgreen[0] = coMakeHexColor("F1F8E9")
	co.lightgreen[1] = coMakeHexColor("DCEDC8")
	co.lightgreen[2] = coMakeHexColor("C5E1A5")
	co.lightgreen[3] = coMakeHexColor("AED581")
	co.lightgreen[4] = coMakeHexColor("9CCC65")
	co.lightgreen[5] = coMakeHexColor("8BC34A")
	co.lightgreen[6] = coMakeHexColor("7CB342")
	co.lightgreen[7] = coMakeHexColor("689F38")
	co.lightgreen[8] = coMakeHexColor("558B2F")
	co.lightgreen[9] = coMakeHexColor("33691E")
	co.lime[0] = coMakeHexColor("F9FBE7")
	co.lime[1] = coMakeHexColor("F0F4C3")
	co.lime[2] = coMakeHexColor("E6EE9C")
	co.lime[3] = coMakeHexColor("DCE775")
	co.lime[4] = coMakeHexColor("D4E157")
	co.lime[5] = coMakeHexColor("CDDC39")
	co.lime[6] = coMakeHexColor("C0CA33")
	co.lime[7] = coMakeHexColor("AFB42B")
	co.lime[8] = coMakeHexColor("9E9D24")
	co.lime[9] = coMakeHexColor("827717")
	co.teal[0] = coMakeHexColor("E0F2F1")
	co.teal[1] = coMakeHexColor("B2DFDB")
	co.teal[2] = coMakeHexColor("80CBC4")
	co.teal[3] = coMakeHexColor("4DB6AC")
	co.teal[4] = coMakeHexColor("26A69A")
	co.teal[5] = coMakeHexColor("009688")
	co.teal[6] = coMakeHexColor("00897B")
	co.teal[7] = coMakeHexColor("00796B")
	co.teal[8] = coMakeHexColor("00695C")
	co.teal[9] = coMakeHexColor("004D40")
	co.lightblue[0] = coMakeHexColor("E1F5FE")
	co.lightblue[1] = coMakeHexColor("B3E5FC")
	co.lightblue[2] = coMakeHexColor("81D4FA")
	co.lightblue[3] = coMakeHexColor("4FC3F7")
	co.lightblue[4] = coMakeHexColor("29B6F6")
	co.lightblue[5] = coMakeHexColor("03A9F4")
	co.lightblue[6] = coMakeHexColor("039BE5")
	co.lightblue[7] = coMakeHexColor("0288D1")
	co.lightblue[8] = coMakeHexColor("0277BD")
	co.lightblue[9] = coMakeHexColor("01579B")
	co.cyan[0] = coMakeHexColor("E0F7FA")
	co.cyan[1] = coMakeHexColor("B2EBF2")
	co.cyan[2] = coMakeHexColor("80DEEA")
	co.cyan[3] = coMakeHexColor("4DD0E1")
	co.cyan[4] = coMakeHexColor("26C6DA")
	co.cyan[5] = coMakeHexColor("00BCD4")
	co.cyan[6] = coMakeHexColor("00ACC1")
	co.cyan[7] = coMakeHexColor("0097A7")
	co.cyan[8] = coMakeHexColor("00838F")
	co.cyan[9] = coMakeHexColor("006064")
	co.purple[0] = coMakeHexColor("F3E5F5")
	co.purple[1] = coMakeHexColor("E1BEE7")
	co.purple[2] = coMakeHexColor("CE93D8")
	co.purple[3] = coMakeHexColor("BA68C8")
	co.purple[4] = coMakeHexColor("AB47BC")
	co.purple[5] = coMakeHexColor("9C27B0")
	co.purple[6] = coMakeHexColor("8E24AA")
	co.purple[7] = coMakeHexColor("7B1FA2")
	co.purple[8] = coMakeHexColor("6A1B9A")
	co.purple[9] = coMakeHexColor("4A148C")
	co.bluegrey[0] = coMakeHexColor("ECEFF1")
	co.bluegrey[1] = coMakeHexColor("CFD8DC")
	co.bluegrey[2] = coMakeHexColor("B0BEC5")
	co.bluegrey[3] = coMakeHexColor("90A4AE")
	co.bluegrey[4] = coMakeHexColor("78909C")
	co.bluegrey[5] = coMakeHexColor("607D8B")
	co.bluegrey[6] = coMakeHexColor("546E7A")
	co.bluegrey[7] = coMakeHexColor("455A64")
	co.bluegrey[8] = coMakeHexColor("37474F")
	co.bluegrey[9] = coMakeHexColor("263238")
	
	co.white = coMakeHexColor("FFFFFF")
	co.black = coMakeHexColor("000000")

	font.id = 0
	font.name = "Default"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	
	font.name = "Muli"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_REGULAR
	font.italic = true
	co.fonts.insert(font)
	font.weight = CO_FONT_BOLD
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_BOLD
	font.italic = true
	co.fonts.insert(font)
	font.weight = CO_FONT_BLACK
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_BLACK
	font.italic = true
	co.fonts.insert(font)
	font.weight = CO_FONT_EXTRA_LIGHT
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_EXTRA_LIGHT
	font.italic = true
	co.fonts.insert(font)
	
	font.name = "Orbitron"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_BOLD
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_BLACK
	font.italic = false
	co.fonts.insert(font)
	
	font.name = "Oswald"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_BOLD
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_EXTRA_LIGHT
	font.italic = false
	co.fonts.insert(font)
	
	font.name = "Crimson Text"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_REGULAR
	font.italic = true
	co.fonts.insert(font)
	font.weight = CO_FONT_BOLD
	font.italic = false
	co.fonts.insert(font)
	font.weight = CO_FONT_BOLD
	font.italic = true
	co.fonts.insert(font)
	
	font.name = "Chilanka"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	
	font.name = "Press Start 2P"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	
	font.name = "Lobster"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	
	font.name = "Acme"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	
	font.name = "Abril Fatface"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	
	font.name = "Parisienne"
	font.weight = CO_FONT_REGULAR
	font.italic = false
	co.fonts.insert(font)
	
	co.fontSizes.insert(36.0)
	co.fontSizes.insert(48.0)
	co.fontSizes.insert(60.0)
	co.fontSizes.insert(72.0)
	co.fontSizes.insert(96.0)

	co.dateFmt = ["DDDD", "Dddd", "dddd", "DDD", "Ddd", "ddd", "dd", "d", "MMMM", "Mmmm", "mmmm", "MMM", "mmm", "Mmm", "mm", "m", "yyyy", "yy"]
	co.timeFmt = ["HH", "hh", "H", "h", "mm", "m", "ss", "s", "TT", "Tt", "tt", "T", "t"]
	co.days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
	co.months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
		
endfunction

//-----------------------------------------------------
// Build the circle image.
//
function coInitCircles()

	local x as float
	local y as float
	local d as integer
	local i as integer
	local img as integer
	local circle as Circle
	
	x = 0

	// 16, 32, 64, 128, 256, 512

	co.circles.length = -1
	
	circle.smoothImg = 0
	circle.pixelImg = 0
	circle.size = 0
	
	for i = 0 to 0 //
		co.circles.insert(circle)
	next

	//d = 16
	d = 256
	
	for i = 0 to co.circles.length
		
		img = coInitCircle(x, y, d, true)
		co.circles[i].smoothImg = img
		co.circles[i].smoothSpr = createsprite(co.circles[i].smoothImg)
		SetSpriteVisible(co.circles[i].smoothSpr, false)
		co.circles[i].size = d
		d = d * 2

	next

	//d = 16
	d = 256

	for i = 0 to co.circles.length
		
		img = coInitCircle(x, y, d, false)
		co.circles[i].pixelImg = img
		co.circles[i].pixelSpr = createsprite(co.circles[i].pixelImg)
		SetSpriteVisible(co.circles[i].pixelSpr, false)
		co.circles[i].size = d
		d = d * 2

	next
	
endfunction

//-----------------------------------------------------
// Build the circle image.
//
function coInitCircle(x as float, y as float, d as integer, smooth as integer)

	local img as integer

	// Open GL, i.e. renderer Basic
	//img = CreateImageColor(0, 0, 0, 0)
	//ResizeImage(img, d, d)
	// Vulcan.
	img = CreateRenderImage(d, d, 0, 0)
	
	if not smooth
		
		SetImageMinFilter(img, 0)
		SetImageMagFilter(img, 0)
		
	endif
	
	SetRenderToImage(img, 0)
	clearscreen()
	SetVirtualResolution(GetImageWidth(img), GetImageHeight(img))
	DrawEllipse(x + d / 2, y + d / 2, d / 2, d / 2, co.white, co.white, true)
	SetRenderToScreen()
	SetVirtualResolution(co.w, co.h)

endfunction img

//-----------------------------------------------------
// Create a box.
//
function coCreateBox(w as float, h as float)
	
	spr as integer

	spr = createSprite(co.pixImg)	
	SetSpriteScale(spr, w, h)
	
endfunction spr

//-----------------------------------------------------
//
function coSetTextFont(text as integer, fontIdx as integer)
	
	if fontIdx < 0
		fontIdx = 0
	elseif fontIdx > co.fonts.length
		fontIdx = co.fonts.length
	endif
	
	coLoadTextFont(fontIdx)
	SetTextFont(text, co.fonts[fontIdx].id)
	
endfunction

//-----------------------------------------------------
//
function coSetEditBoxFont(text as integer, fontIdx as integer)
	
	if fontIdx < 0
		fontIdx = 0
	elseif fontIdx > co.fonts.length
		fontIdx = co.fonts.length
	endif
	
	coLoadTextFont(fontIdx)
	SetEditBoxFont(text, co.fonts[fontIdx].id)
	
endfunction

//-----------------------------------------------------
// Convert a weight code to name.
//
function coFontWeightToName(weight as integer)
	
	local ret as string
	
	if weight = CO_FONT_EXTRA_LIGHT
		ret = "Extra Light"
	elseif weight = CO_FONT_LIGHT
		ret = "Light"
	elseif weight = CO_FONT_REGULAR
		ret = "Regular"
	elseif weight = CO_FONT_MEDIUM
		ret = "Medium"
	elseif weight = CO_FONT_SEMI_BOLD
		ret = "Semi Bold"
	elseif weight = CO_FONT_BOLD
		ret = "Bold"
	elseif weight = CO_FONT_BLACK
		ret = "Black"
	else 
		ret = ""
	endif

endfunction ret

//-----------------------------------------------------
// Get the full name of the font for this font object.
//
function coGetFontName(font ref as Font)

	local name as string
	
	name = font.name + " " + coFontWeightToName(font.weight)
	
	if font.italic
		name = name + " Italic"
	endif
	
endfunction name

//-----------------------------------------------------
//
function coLoadTextFont(fontIdx as integer)

	local file as string 
	local folder as string
	local name as string
	
	if fontIdx = 0 // Default font.
		exitfunction
	endif
	
	if not co.fonts[fontIdx].id
		
		folder = replacestring(co.fonts[fontIdx].name, " ", "_", -1)
		name = co.fonts[fontIdx].name + "-" + coFontWeightToName(co.fonts[fontIdx].weight)
		
		if co.fonts[fontIdx].italic
			name = name + " Italic"
		endif

		//colog("Font name before = '" + name + "'")
		name = replacestring(name, " ", "", -1)	
		//colog("Font name after = '" + name + "'")
		file = "fonts/" + folder + "/" + name + ".ttf"
		//colog("Loading font " + file)
		
		co.fonts[fontIdx].id = LoadFont(file)
		
		//if not co.fonts[fontIdx].id
		//	colog("Error: Font " + file + " not found")
		//endif
		
	endif

endfunction

//-----------------------------------------------------
// IMAGES / SPRITES

//-----------------------------------------------------
// Check whether the rect(ax, ay, aw, ah) in completely within rect (bx, by, bw, bh)
//
function coRectWithinRect(ax as float, ay as float, aw as float, ah as float, bx as float, by as float, bw as float, bh as float)
		
	local ret as integer
	
	If ax >= bx and ax + aw <= bx + bw and ay >= by and ay + ah <= by + bh
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Check whether the rect(ax, ay, aw, ah) overlaps any over rect (bx, by, bw, bh)
//
function coRectOverlapsRect(ax as float, ay as float, aw as float, ah as float, bx as float, by as float, bw as float, bh as float)
		
	local ret as integer
	
	If ax > bx + bw - 1 Or ax + aw - 1 < bx Or ay > by + bh - 1 Or ay + ah - 1 < by
		ret = False
	else
		ret = True
	endif
	
endfunction ret

//-----------------------------------------------------
// Check whether the rect1 overlaps any over rect2
//
function coRectOverlapsRect2(rect1 ref as Line, rect2 as Line)

	local ret as integer
	
	ret = coRectOverlapsRect(rect1.x0, rect1.y0, rect1.x1 - rect1.x0 + 1, rect1.y1 - rect1.y0 + 1, rect2.x0, rect2.y0, rect2.x1 - rect2.x0 + 1, rect2.y1 - rect2.y0 + 1)
	
endfunction ret

//-----------------------------------------------------
// Check whether the rect(ax, ay, aw, ah) overlaps anywhere over rect (bx, by, bw, bh)
// Returns the edges.
//
function coRectOverlapRectEdges(ax as float, ay as float, aw as float, ah as float, bx as float, by as float, bw as float, bh as float)
		
	local ret as integer

	ret = 0
	
	If (ax < bx + bw - 1 and ax + aw - 1 > bx + bw - 1)
		ret = ret || DIR_E
	endif
	
	if (ax < bx and ax + aw - 1 > bx)
		ret = ret || DIR_W
	endif
	
	if (ay < by + bh - 1 and ay + ah - 1 > by + bh - 1)
		ret = ret || DIR_S
	endif
	
	if (ay < by and ay + ah - 1 > by)
		ret = ret || DIR_N
	endif
	
endfunction ret

//-----------------------------------------------------
// Check whether the spr was hit with a touch position of (x, y) plus edge around (l, r, t, b)
// Uses a rect method instead of GetSpriphteHitTest.
// NOTE: assumes ByOffset positioning.
//
function coGetSpriteHitTest(spr as integer, x as float, y as float, extra as float)
		
	local ret as integer

	ret = coGetSpriteHitTest3(spr, x, y, extra, extra, extra, extra)

endfunction ret

//-----------------------------------------------------
// Check whether the spr was hit with a touch position of (x, y) plus edge around (l, r, t, b)
// Uses a rect method instead of GetSpriteHitTest.
// NOTE: assumes ByOffset positioning.
//
function coGetSpriteHitTest2(spr as integer, x as float, y as float, horiz as float, vert as float)
		
	local ret as integer

	ret = coGetSpriteHitTest3(spr, x, y, horiz, horiz, vert, vert)

endfunction ret

//-----------------------------------------------------
// Check whether the spr was hit with a touch position of (x, y) plus edge around (l, r, t, b)
// Uses a rect method instead of GetSpriteHitTest.
//
function coGetSpriteHitTest3(spr as integer, x as float, y as float, l as float, r as float, t as float, b as float)
		
	local ret as integer

	if spr
		ret = getspritevisible(spr) and coPointWithinRect(x, y, GetSpriteX(spr) - l, GetSpriteY(spr) - t, l + GetSpriteWidth(spr) + r, t + GetSpriteHeight(spr) + b)
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
// Check spr first.
//
function coSetSpriteScissor(spr as integer, x0 as float, y0 as float, x1 as float, y1 as float)
	
	if spr
		SetSpriteScissor(spr, x0, y0, x1, y1)
	endif
	
endfunction

//-----------------------------------------------------
// Check spr first.
//
function coSetSpriteVisible(spr as integer, vis as integer)
	
	if spr
		SetSpriteVisible(spr, vis)
	endif
	
endfunction

//-----------------------------------------------------
// Check whether px, py is within x0,y0,x1,y1
//
function coPointWithinBounds(px as float, py as float, x0 as float, y0 as float, x1 as float, y1 as float)

	local t as integer
	local ret as integer
	
	if x0 > x1
		
		t = x0
		x0 = x1
		x1 = t
		
	endif

	if y0 > y1
		
		t = y0
		y0 = y1
		y1 = t
		
	endif
	
	ret = coPointWithinRect(px, py, x0, y0, x1 - x0 + 1, y1 - y0 + 1)
		
endfunction ret


//-----------------------------------------------------
// Check whether rect1 px, py is within x,y,w,h
//
function coPointWithinRect(px as float, py as float, x as float, y as float, w as float, h as float)
		
	local ret as integer
	
	if px >= x And px < x + w And py >= y And py < y + h
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Given a hex string, return an int value.
// Can include a # at the fromt, which will be ignored.
//
function coHexToInt(h as string)

	local ret as integer
	
	if left(h, 1) = "#"
		h = mid(h, 2, -1)
	endif

	ret = val(h, 16)
	
endfunction ret

//-----------------------------------------------------
// Set the alpha of a color.
//
function coSetColorAlpha(col as integer, alpha as integer)
	
	col = col && 0x00ffffff
	col = col || (alpha << 24)
	
endfunction col

//-----------------------------------------------------
// Get the alpha of a color.
//
function coGetColorAlpha(col as integer)
	
	col = col >> 24
	
endfunction col


//-----------------------------------------------------
// Given a string in hex form or dec form, return a makecolor value.
//
function coMakeColor(h as string)

	local ret as integer
	
	if left(h, 1) = "#"
		ret = coMakeHexColor(h)
	else
		ret = coMakeDecColor(h)
	endif
	
endfunction ret

//-----------------------------------------------------
// Given a string for a color segment, e.g. red, in hex form or dec form, return a makecolor value.
//
function coMakeColorSegment(h as string)

	local ret as integer

	if left(h, 1) = "#"
		ret = coHexToInt(h)
	else 
		ret = val(h)
	endif

	if ret < 0
		ret = 0
	elseif ret > 255
		ret = 255
	endif
	
endfunction ret

//-----------------------------------------------------
// Given a string in hex form or dec form, return a makecolor value.
//
function coIsValidColor(h as string)

	local ret as integer
	local v as string 

	ret = true
	
	if len(h) = 7
		if not coIsValidHex(h)
			ret = false
		endif
	elseif len(h) = 9

		v = left(h, 3)
		
		if not coIsValidNbr(v, false, false) or val(v) > 255
			ret = false
		endif

		v = mid(h, 4, 3)
		
		if not coIsValidNbr(v, false, false) or val(v) > 255
			ret = false
		endif

		v = mid(h, 7, 3)
		
		if not coIsValidNbr(v, false, false) or val(v) > 255
			ret = false
		endif


	endif
	
endfunction ret

//-----------------------------------------------------
// Check that the passed string is valid hex.
//
function coIsValidHex(h as string)

	local i as integer
	local ret as integer
	local c as string 

	ret = true
	h = upper(h)
	
	for i = 1 to len(h)
		
		c = mid(h, i, 1)
		
		if FindString("0123456789ABCDEF", c) = 0
			
			ret = false
			exit

		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Check that the passed string is valid number.
// if isDec is true, then one . in the number is okay.
// If allowNeg is true, then - is allowed.
// Returns 1 if integer, 2 if isDec is true and it is a decimal.
// Retruns 0 if not a number, or isDec is false and has ., or allowNeg is false, and has -.
//
function coIsValidNbr(h as string, isDec as integer, allowNeg as integer)

	local i as integer
	local ret as integer
	local c as string
	local ln as integer
	local dotCount as integer
	local startIdx as integer

	ret = 1 // Assume integer.
	dotCount = 0
	startIdx = 1

	if allowNeg
		if mid(h, 1, 1) = "-"
			inc startIdx
		endif			
	endif
	
	//h = upper(h)
	ln = len(h)
	
	for i = startIdx to ln
		
		c = mid(h, i, 1)
		
		if FindString("0123456789.", c) = 0
			
			ret = 0
			exit

		elseif c = "."

			inc dotCount
			ret = 2
			
		endif
		
	next

	if ret
		if isDec
			if dotCount > 1
				ret = 0
			endif
		else
			if dotCount > 0
				ret = 0
			endif
		endif
	endif		
	
endfunction ret

//-----------------------------------------------------
// Given a hex string in the form rrggbb, return a makecolor value.
//
function coMakeHexColor(h as string)
	
	local a as integer
	local r as integer
	local g as integer
	local b as integer
	local ret as integer

	if len(h) = 9 or len(h) = 7

		if left(h, 1) = "#"			
			h = mid(h, 2, -1)
		else
			h = ""
		endif

	endif

	if len(h) = 8
		
		a = val(mid(h, 1, 2), 16)
		h = mid(h, 3, -1)

	else
		
		a = 255
				
	endif
		
	if len(h) = 6
	
		r = val(mid(h, 1, 2), 16)
		g = val(mid(h, 3, 2), 16)
		b = val(mid(h, 5, 2), 16)
		
		ret = makecolor(r, g, b)

	else

		ret = MakeColor(0, 0, 0)

	endif
	
	ret = coSetColorAlpha(ret, a)
	
endfunction ret

//-----------------------------------------------------
// Given a dec string in the form rrrgggbbb, return a makecolor value.
//
function coMakeDecColor(h as string)
	
	local a as integer
	local r as integer
	local g as integer
	local b as integer
	local ret as integer

	if len(h) = 12
		
		a = val(mid(h, 1, 3), 10)
		h = mid(h, 4, -1)

	else
		
		a = 255
				
	endif
	
	if len(h) = 9
		
		r = val(mid(h, 1, 3), 10)
		g = val(mid(h, 4, 3), 10)
		b = val(mid(h, 7, 3), 10)
		
		ret = makecolor(r, g, b)

	else

		ret = makecolor(0, 0, 0)

	endif
			
	ret = coSetColorAlpha(ret, a)

endfunction ret

//-----------------------------------------------------
// Set the color of the clear color.
//
function coSetClearColor(col as integer)
	
	SetClearColor(getcolorred(col), getcolorgreen(col), getcolorblue(col))

endfunction

//-----------------------------------------------------
// Set the color of the border color.
//
function coSetBorderColor(col as integer)
	
	SetBorderColor(getcolorred(col), getcolorgreen(col), getcolorblue(col))

endfunction

//-----------------------------------------------------
// Set the color of the print color.
//
function coSetPrintColor(col as integer)
	
	SetPRintColor(getcolorred(col), getcolorgreen(col), getcolorblue(col))

endfunction

//-----------------------------------------------------
// Set the color of the passed sprite using bit pattern color.
//
function coSetSpriteColor(spr as integer, col as integer)
	
	//if col = co.black
	//	col = col
	//endif
	
	if spr
		SetSpriteColor(spr, getcolorred(col), getcolorgreen(col), getcolorblue(col), coGetColorAlpha(col))
	endif

endfunction

//-----------------------------------------------------
// Set the color of the passed sprite using bit pattern color.
//
function coSetSpriteColorWithAlpha(spr as integer, col as integer, alpha as integer)
	
	SetSpriteColor(spr, getcolorred(col), getcolorgreen(col), getcolorblue(col), alpha)

endfunction

//-----------------------------------------------------
// Get sprite visible, checking spr for non-zero.
//
function coGetSpriteVisible(spr as integer)
	
	local ret as integer
	
	if spr
		ret = GetSpriteVisible(spr)
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Get the color of the passed sprite returning a bit pattern color.
//
function coGetSpriteColor(spr as integer)
	
	ret as integer
	ret = makecolor(getspritecolorred(spr), getspritecolorgreen(spr), getspritecolorblue(spr))
	ret = coSetColorAlpha(ret, GetSpriteColorAlpha(spr))

endfunction ret

//-----------------------------------------------------
// Set the color of the passed text using bit pattern color.
//
function coSetTextColor(spr as integer, col as integer)
	
	SetTextColor(spr, getcolorred(col), getcolorgreen(col), getcolorblue(col), 255)

endfunction

//-----------------------------------------------------
// Display the passed 'millis' int as hh:mm:ss
//
function coTimeToString(millis as integer, frac as integer)

	local h as integer
	local m as integer
	local s as integer
	local f as integer // Hundreths.
	local div as integer

	div = (1000 * 60 * 60)
	h = millis / div
	millis = millis - h * div
	
	div = (1000 * 60)
	m = millis / div
	millis = millis - m * div

	div = 1000
	s = millis / div
	millis = millis - s * div

	f = round(millis / 10.0)

	local ret as string

	if h > 0

		ret = ret + right("00" + str(h), 2)
		ret = ret + ":"

	endif
	
	ret = ret + right("00" + str(m), 2)
	ret = ret + ":"
	ret = ret + right("00" + str(s), 2)

	if frac

		ret = ret + "."
		ret = ret + right("00" + str(f), 2)

	endif

endfunction ret

//-----------------------------------------------------
// Convert a float to a string price.
//
function coFloatToPrice(price as float)

	local ret as string
	local pos as integer

	ret = "$" + str(price)
	pos = FindString(ret, ".")

	if pos > 0
		
		pos = pos + 2
		ret = mid(ret, 1, pos)
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Convert a color value to a rrrgggbbb dec string
//
function coDecToColor(s as string)

	local col as integer
	local r as integer
	local g as integer
	local b as integer
	local a as integer
	
	if len(s) < 12
		
		col = makecolor(0, 0, 0, 255)
		
	else
		
		a = val(mid(s, 1, 3))
		r = val(mid(s, 4, 3))
		g = val(mid(s, 7, 3))
		b = val(mid(s, 10, 3))
		col = makecolor(r, g, b, a)
		
	endif
	
endfunction col

//-----------------------------------------------------
// Convert a color value to a rrrgggbbb dec string
//
function coColorToDec(col as integer)

	local ret as string

	ret = ""
	ret = ret + right("00" + str(coGetColorAlpha(col)), 3)
	ret = ret + right("00" + str(GetColorRed(col)), 3)
	ret = ret + right("00" + str(GetColorGreen(col)), 3)
	ret = ret + right("00" + str(GetColorBlue(col)), 3)
	
endfunction ret

//-----------------------------------------------------
// Convert a color segment value (e.g. red) to a nnn dec string
//
function coColorSegmentToDec(col as integer, digits as integer)

	local ret as string

	if digits > 0
		ret = right("00" + str(col), digits)
	else
		ret = str(col)
	endif
	
endfunction ret

//-----------------------------------------------------
// Convert a color value to a rrggbb hex string
//
function coColorToHex(col as integer)

	local ret as string

	ret = "#"
	ret = ret + right("0" + hex(coGetColorAlpha(col)), 2)
	ret = ret + right("0" + hex(GetColorRed(col)), 2)
	ret = ret + right("0" + hex(GetColorGreen(col)), 2)
	ret = ret + right("0" + hex(GetColorBlue(col)), 2)
	
endfunction ret

//-----------------------------------------------------
// Convert a color segment value (e.g. red) to a nn hex string
//
function coColorSegmentToHex(col as integer, digits as integer)

	local ret as string

	if digits > 0
		ret = right("0" + hex(col), digits)
	else
		ret = hex(col)
	endif
	
	ret = "#" + ret
	
endfunction ret

//-----------------------------------------------------
function coBoolToString(bool as integer)

	local ret as string

	if bool
		ret = "true"
	else
		ret = "false"
	endif
	
endfunction ret

//-----------------------------------------------------
function coStringToBool(text as string)

	local ret as integer

	if lower(text) = "true"
		ret = 1
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
// Convert a dir to a string.
// longStyle false for single letter, true for lower full name.
//
function coDirToString(dir as integer, longStyle as integer)

	local ret as string

	if dir = DIR_N
		if longStyle then ret = "north" else ret = "n"
	elseif dir = DIR_S
		if longStyle then ret = "south" else ret = "s"
	elseif dir = DIR_W
		if longStyle then ret = "west" else ret = "w"
	elseif dir = DIR_E
		if longStyle then ret = "east" else ret = "e"
	endif
		
endfunction ret

//-----------------------------------------------------
// Get a direction, based on an angle.
// If fuzzy is true, then the ang will be "forced" to a 90 degree angle.
//
function coAngleToDir(ang as float, fuzzy as integer)

	local dir as integer

	ang = mod(ang, 360)

	if fuzzy
		ang = (ang / 90) * 90
	endif
	
	if ang = 0
		dir = DIR_N
	elseif ang = 90
		dir = DIR_E
	elseif ang = 180
		dir = DIR_S
	elseif ang = 270
		dir = DIR_W
	endif

endfunction dir

//-----------------------------------------------------
// Get the angle for the passed dir.
//
function coDirToAngle(dir as integer)

	local ang as float
	
	if dir = DIR_E
		ang = 90
	elseif dir = DIR_S
		ang = 180
	elseif dir = DIR_W
		ang = 270
	else//if dir = DIR_N
		ang = 0
	endif

endfunction ang

//-----------------------------------------------------
// Creates a string with 's' repeated 'count' times.
//
function coRepeatString(s as string, count as integer)

	local ret as string
	local i as integer

	for i = 1 to count
		ret = ret + s
	next
	
endfunction ret

//----------------------------------------------------------
// Format the passed float as the format.
//
function coFormatNbr(s as string, minw as integer, delim as string, places as integer)
	
	local pos as integer
	local v as integer
	local count as integer
	local i as integer
	local ret as string
	local inbr as string
	
	pos = findstring(s, ".")
	count = 0
	ret = ""
		
	if pos > 0		
		inbr = mid(s, 1, pos - 1)
	else 
		inbr = s
	endif
	
	if minw < len(inbr) then minw = len(inbr)				
	inbr = right(coRepeatString("0", minw) + inbr, minw)
		
	if delim <> ""	
		
		for i = len(inbr) to 1 step -1
			
			if count = 3
				
				ret = delim + ret
				count = 0
				
			endif
			
			ret = mid(inbr, i, 1) + ret
			inc count
			
		next

	else 
		
		ret = inbr
				
	endif
		
	if pos > 0
			
		inbr = mid(s, pos + 1, -1)
		
		if len(inbr) > places
						
			if places > 6
				places = 6
			elseif places < 0
				places = 0
			endif
			
			v = valfloat(left(inbr, places))
			ret = ret + "." + str(v)
			
		else 
			
			ret = ret + "." + inbr
			
		endif

	else
						
		if places > 6
			places = 6
		elseif places < 0
			places = 0
		endif
		
		if places > 0			
			ret = ret + "." + coRepeatString("0", places)
		endif
		
	endif
	
endfunction ret

//----------------------------------------------------------
// Takes a number that is a float like 0.000000 amd strips all
// unneccesary 0's and .'s
//
function coTrimFloatStr(s as string)

	local idx as integer
	local pos as integer

	// Check redundant 0's at front of number.
	idx = 1
	
	while mid(s, idx, 1) = "0"
		inc idx
	endwhile

	s = mid(s, idx, -1)

	if s = ""

		// Integer 0, put it back. We're done.
		s = "0"
		
	else

		// Check if it's decimal.
		pos = FindString(s, ".")

		if pos > 0
			
			// Is it decimal, now remove 0's from the back.
			idx = len(s)
			
			while mid(s, idx, 1) = "0"
				dec idx
			endwhile

			// If we have eaten all the decimal zeroes, get rid of the dot too.
			if mid(s, idx, 1) = "."
				dec idx
			endif

			s = left(s, idx)

			// Make sure we still have a zero before the .
			if pos = 1
				s = "0" + s
			endif
			
		endif

	endif
		
endfunction s

//-----------------------------------------------------
// Fill 'arr' with value 'v'.
//
function coFillArray(arr ref as integer[], v as integer)

	local i as integer

	for i = 0 to arr.length - 1
		arr[i] = v
	next

endfunction

// --------------------------------------------------------------------
// Make an integer value combining x as top 16 bits, and y as bottom 16 bits.
//
function coMakePoint(x as integer, y as integer)

	local v as integer
	
	v = x << 16
	v = v || y
	//colog("x=" + str(x) + ", y=" + str(y) + ", v=" + str(v))
	
endfunction v

// --------------------------------------------------------------------
// Return the x portion of a maze point.
//
function coGetPointX(pt as integer)

	local x as integer
	x = (pt >> 16) && 0x0000ffff
	//colog("pt=" + str(pt) + ", x=" + str(x))
	
endfunction x

// --------------------------------------------------------------------
// Return the y portion of a maze point.
//
function coGetPointY(pt as integer)

	local y as integer
	y = pt && 0x0000ffff
	//colog("pt=" + str(pt) + ", y=" + str(y))
	
endfunction y

// --------------------------------------------------------------------
// Get a string rep of a pt.
//
function coPointToString(pt as integer)

	local s as string

	s = "(" + str(coGetPointX(pt)) + "," + str(coGetPointY(pt)) + ")"
	
endfunction s

// --------------------------------------------------------------------
// Create a color streak (list of colors) starting from firstCol, ending at lastCol.
//
function coCalcColorRange(cols ref as integer[], steps as float, firstCol as integer, lastCol as integer)

	local i as integer
	local ratio as float
	local red as integer
	local green as integer
	local blue as integer
	local newCol as integer
	//local cols as integer[]
	
	for i = 0 to steps - 1
	
		ratio = i / steps
		red = GetColorRed(lastCol) * ratio + GetColorRed(firstCol) * (1 - ratio)
		green = GetColorGreen(lastCol) * ratio + GetColorGreen(firstCol) * (1 - ratio)
		blue = GetColorBlue(lastCol) * ratio + GetColorBlue(firstCol) * (1 - ratio)		
		newCol = MakeColor(red, green, blue)
		//colog("ratio=" + str(ratio) + ", r=" + str(red) + ", g=" + str(green) + ", b=" + str(blue))
		cols.insert(newCol)

	next

endfunction

//-----------------------------------------------------
//
function coSgn(v as integer)

	local ret as integer
	
	if v < 0
		ret = -1
	elseif v > 0
		ret = 1
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
// Take a size that may be a power of 2 and make it the next power of 2.
//
function coRoundImageSize(v as integer, min as integer, max as integer)

	local pp as integer
	local p as integer

	pp = min
	p = min

	while p < v and p < max

		pp = p
		p = p * 2
		
	endwhile

	if v < pp + (p - pp) / 2
		p = pp
	endif
		
endfunction p

//-----------------------------------------------------
// Returns the distance between v1 and v2.
//
function covdistance(v1 ref as Point, v2 ref as Point)

	local ret as float
	
	ret = covlength(covsub(v1, v2))

endfunction ret

//-----------------------------------------------------
// Returns the length of v.
//
function covlength(v ref as Point)

	local ret as float
	
	ret = sqrt(covdot(v, v))

endfunction ret

//-----------------------------------------------------
// Vector dot product.
//
function covdot(v1 ref as Point, v2 ref as Point)

	local ret as float
	
	ret = v1.x * v2.x + v1.y * v2.y

endfunction ret

//-----------------------------------------------------
// Subtract two vectors.
// Note v1 and v2 are "points" created with coMakePoint.
//
function covsub(v1 ref as Point, v2 ref as Point)

	local pt as Point

	//pt = coCreatePoint(v1.x - v2.x, v1.y - v2.y)
	pt.x = v1.x - v2.x
	pt.y = v1.y - v2.y

endfunction pt

//-----------------------------------------------------
// Returns the distance between two points squared.
//
Function coDistSq(x as Float, y as Float, x2 as Float, y2 as Float)

	local ret as float
	
	ret = (x2 - x) * (x2 - x) + (y2 - y) * (y2 - y)
	
Endfunction ret

//-----------------------------------------------------
// Returns the min of the two values.
//
Function coMin(a as Float, b as Float)
	
	local ret as float
	
	if a < b
		ret = a
	else 
		ret = b
	endif
	
endfunction ret

//-----------------------------------------------------
// Returns the max of the two values.
//
Function coMax(a as Float, b as Float)
	
	local ret as float
	
	if a > b
		ret = a
	else 
		ret = b
	endif
	
endfunction ret

//-----------------------------------------------------
// Returns the distance between two points.
//
Function coDist(x0 as Float, y0 as Float, x1 as Float, y1 as Float)

	local ret as float
	local dx as float
	local dy as float
	
	dx = abs(x1 - x0)
	dy = abs(y1 - y0)
	
	ret = sqrt((dx * dx) + (dy * dy))
	
Endfunction ret

//-----------------------------------------------------
// Copy a file.
//
function coCopyFile(src as string, dest as string)

	local inId as integer
	local outId as integer
	local ret as integer
	local b as integer

	ret = false
	inId = OpenToRead(src)
	outId = OpenToWrite(dest)		

	if inId and outId

		while not FileEOF(inId)

			b = ReadInteger(inId)
			WriteInteger(outId, b)

		endwhile

		closefile(inId)
		closefile(outId)

		ret = true
		
	endif

endfunction ret

//-----------------------------------------------------
// Split a string by 'd'elim.
// Returns a string[]/
//
function coSplitString(toks ref as string[], s as string, d as string)

	local tok as string 
	local pos1 as integer
	local pos2 as integer
	local dlen as integer

	pos1 = 1
	dlen = len(d)
	pos2 = FindString(s, d, 1, pos1)

	while pos2 > 0
		
		tok = mid(s, pos1, pos2 - pos1)
		toks.insert(tok)
		pos1 = pos2 + dlen
		pos2 = FindString(s, d, 1, pos1)

	endwhile

	if pos1 < len(s)

		tok = mid(s, pos1, -1)
		toks.insert(tok)

	endif
		
endfunction

//-----------------------------------------------------
// Find the paired tokens, e.g. toks = {}, find { and }.
//
function coFindPair(s as string, toks as string, idx ref as integer[])

	local c as string 
	local c1 as String
	local c2 as string
	local ln as integer
	local i as integer
	local depth as integer

	c1 = left(toks, 1)
	c2 = right(toks, 1)
	depth = 0
	idx.length = -1
	
	for i = 1 to len(s)

		c = mid(s, i, 1)
		
		if c = c1

			if depth = 0
				idx.insert(i)
			endif
			
			inc depth
			
		elseif c = c2
			
			dec depth
			
			if depth = 0

				idx.insert(i)
				exit
				
			endif
			
		endif
		
	next
	
endfunction idx

//-----------------------------------------------------
// Draw a fake sprite-based line, using a single pixel.
// If spr is non-zero, it reuses that spr, otherwise it creates a new one.
// The spr drawn is returned.
// typ is the end-type, e.g. CO_LINE_MID_CIRC or CO_LINE_MID_SQR
//
function coDrawFakeSprLine(sprs ref as integer[], x0 as float, y0 as float, x1 as float, y1 as float, col as integer, size as float, typ as integer)

	local mix as float
	local miy as float
	local mihx as float
	local mihy as float
	local mia as float
	local mil as float
	local spr as integer
	local i as integer
	local s2 as float
	local sx as float
	local sy as float
	local px as float
	local py as float

	for i = 0 to sprs.length
		deletesprite(sprs[i])
	next

	sprs.length = -1
	
	spr = CreateSprite(co.pixImg)
	sprs.insert(spr)

	mix = (x1 - x0)
	miy = (y1 - y0)
	mihx = mix / 2
	mihy = miy / 2
	px = x0 + mihx
	py = y0 + mihy
	mia = atanfull(-miy, mix)
	mil = sqrt(abs(mix * mix) + abs(miy * miy))

	if typ = CO_LINE_END_CIRC
		
		mil = mil - size // Reduce by size / 2 (* 2 for each end).
		If x0 < x1 Then sx = 1 Else sx = -1
		If y0 < y1 Then sy = 1 Else sy = -1

		s2 = size / 2
		x0 = x0 - (sx * s2 * cos(mia))
		y0 = y0 - (sy * s2 * sin(mia))
		x1 = x1 + (sx * s2 * cos(mia))
		y1 = y1 + (sy * s2 * sin(mia))

		typ = CO_LINE_MID_CIRC
		
	elseif typ = CO_LINE_MID_SQR
		
		mil = mil + size // Increase by size / 2 (* 2 for each end).
		
	endif

	SetSpriteScale(spr, mil, size)
	SetSpriteOffset(spr, mil / 2, size / 2)
	SetSpritePositionByOffset(spr, px, py)
	SetSpriteAngle(spr, mia)
	coSetSpriteColor(spr, col)
	SetSpriteVisible(spr, true)

	if typ = CO_LINE_MID_CIRC

		spr = coDrawDot(x0, y0, col, size, false)
		sprs.insert(spr)
		//spr = coDrawDot(x1, y1, col, size)
		spr = CloneSprite(spr)
		SetSpritePositionByOffset(spr, x1, y1)
		sprs.insert(spr)

	endif
	
endfunction

//-----------------------------------------------------
// Draw a fake sprite-based line, using a single pixel.
// typ is the end-type, e.g. CO_LINE_MID_CIRC or CO_LINE_MID_SQR
//
function coDrawFakeSprLine2(spr as integer, x0 as float, y0 as float, x1 as float, y1 as float, col as integer, size as float, typ as integer)

	local mix as float
	local miy as float
	local mihx as float
	local mihy as float
	local mia as float
	local mil as float
	//local spr as integer
	local i as integer
	local s2 as float
	local sx as float
	local sy as float
	local px as float
	local py as float

	if not spr	
		exitfunction
	endif
	
	mix = (x1 - x0)
	miy = (y1 - y0)
	mihx = mix / 2
	mihy = miy / 2
	px = x0 + mihx
	py = y0 + mihy
	mia = atanfull(-miy, mix)
	mil = sqrt(abs(mix * mix) + abs(miy * miy))

	if typ = CO_LINE_END_CIRC
		
		mil = mil - size // Reduce by size / 2 (* 2 for each end).
		If x0 < x1 Then sx = 1 Else sx = -1
		If y0 < y1 Then sy = 1 Else sy = -1

		s2 = size / 2
		x0 = x0 - (sx * s2 * cos(mia))
		y0 = y0 - (sy * s2 * sin(mia))
		x1 = x1 + (sx * s2 * cos(mia))
		y1 = y1 + (sy * s2 * sin(mia))

		typ = CO_LINE_MID_CIRC
		
	elseif typ = CO_LINE_MID_SQR
		
		mil = mil + size // Increase by size / 2 (* 2 for each end).
		
	endif

	SetSpriteScale(spr, mil, size)
	SetSpriteOffset(spr, mil / 2, size / 2)
	SetSpritePositionByOffset(spr, px, py)
	SetSpriteAngle(spr, mia)
	coSetSpriteColor(spr, col)
	SetSpriteVisible(spr, true)
	drawsprite(spr)
	SetSpriteVisible(spr, false)

	if typ = CO_LINE_MID_CIRC

		spr = coDrawDot2(col, size, false)
		SetSpriteVisible(spr, true)
		SetSpritePositionByOffset(spr, x0, y0)
		drawsprite(spr)
		SetSpritePositionByOffset(spr, x1, y1)
		drawsprite(spr)
		SetSpriteVisible(spr, false)

	endif
		
endfunction

//-----------------------------------------------------
// Bresenham line algorithm
// size >= 1
//
Function coDrawSprLine(sprs ref as integer[], x0 as integer, y0 as integer, x1 as integer, y1 as integer, col as integer, size as integer, smooth as integer)

	Local dx as integer
	Local dy as integer
	Local sx as integer
	Local sy as integer
	Local err as integer
	local e2 as integer
	local a0 as integer
	local b0 as integer
	local a1 as integer
	local b1 as integer
	local t as integer
	local baseSpr as integer
	local spr as integer

	baseSpr = coDrawDot(x0, y0, col, size, smooth)
	
	dx = Abs(x1 - x0)
	dy = Abs(y1 - y0) 
	
	If x0 < x1 Then sx = 1 Else sx = -1
	If y0 < y1 Then sy = 1 Else sy = -1

	err = dx - dy
	
	While True
	
		a0 = x0 - size / 2
		b0 = y0 - size / 2
		a1 = x0 + size / 2
		b1 = y0 + size / 2

		if a0 < x0 then a0 = x0
		if b0 < y0 then b0 = y0
		if a1 > x1 then a1 = x1
		if b1 > y1 then b1 = y1
		
		//coMemSetPoint(mb, x0, y0, col)
		//coMemDrawRectInt(mb, a0, b0, abs(a1 - a0), abs(b1 - b0), col)
		spr = CloneSprite(baseSpr)
		SetSpritePositionByOffset(spr, x0, y0)
		sprs.insert(spr)
		
		If x0 = x1 And y0 = y1 Then Exit
		e2 = 2 * err
		
		If e2 > -dy
		 
			err = err - dy
			x0 = x0 + sx
			
		EndIf
		
		If e2 < dx 
		
			err = err + dx
			y0 = y0 + sy 
			
		EndIf
		
	endwhile

	deletesprite(baseSpr)
	
EndFunction

//-----------------------------------------------------
// Bresenham line algorithm
// size >= 1
//
Function coDrawDotLine(x0 as integer, y0 as integer, x1 as integer, y1 as integer, col as integer, size as integer, typ as integer)

	Local dx as integer
	Local dy as integer
	Local sx as integer
	Local sy as integer
	Local err as integer
	local e2 as integer
	local a0 as integer
	local b0 as integer
	local a1 as integer
	local b1 as integer
	local t as integer
	local s2 as integer
	
	s2 = size / 2
	
	dx = Abs(x1 - x0)
	dy = Abs(y1 - y0) 
	
	If x0 < x1 Then sx = 1 Else sx = -1
	If y0 < y1 Then sy = 1 Else sy = -1

	if typ = CO_LINE_END_CIRC or typ = CO_LINE_END_SQR

		x0 = x0 + (sx * s2)
		y0 = y0 + (sy * s2)
		x1 = x1 - (sx * s2)
		y1 = y1 - (sy * s2)

		if typ = CO_LINE_END_CIRC
			typ = CO_LINE_MID_CIRC
		elseif typ = CO_LINE_END_SQR
			typ = CO_LINE_MID_SQR
		endif

		dx = Abs(x1 - x0)
		dy = Abs(y1 - y0) 
		
		If x0 < x1 Then sx = 1 Else sx = -1
		If y0 < y1 Then sy = 1 Else sy = -1

	endif

	err = dx - dy
	
	While True
	
		if typ = CO_LINE_MID_CIRC
			DrawEllipse(x0, y0, s2, s2, col, col, true)
		elseif typ = CO_LINE_MID_SQR
			DrawBox(x0 - s2, y0 - s2, x0 - s2 + size - 1, y0 - s2 + size - 1, col, col, col, col, true)
		endif

		If x0 = x1 And y0 = y1 Then Exit
		
		e2 = 2 * err
		
		If e2 > -dy
		 
			err = err - dy
			x0 = x0 + sx
			
		EndIf
		
		If e2 < dx 
		
			err = err + dx
			y0 = y0 + sy 
			
		EndIf
		
	endwhile
	
EndFunction

//-----------------------------------------------------
// Bresenham line algorithm
// size >= 1
//
Function coCreateLinePoints(pts ref as Point[], x0 as integer, y0 as integer, x1 as integer, y1 as integer)

	Local dx as integer
	Local dy as integer
	Local sx as integer
	Local sy as integer
	Local err as integer
	local e2 as integer
	local a0 as integer
	local b0 as integer
	local a1 as integer
	local b1 as integer
	local t as integer
	local pt as Point
	
	dx = Abs(x1 - x0)
	dy = Abs(y1 - y0) 
	
	If x0 < x1 Then sx = 1 Else sx = -1
	If y0 < y1 Then sy = 1 Else sy = -1

	err = dx - dy
	
	While True
	
		pt.x = x0
		pt.y = y0
		pts.insert(pt)
		
		If x0 = x1 And y0 = y1 Then Exit
		e2 = 2 * err
		
		If e2 > -dy
		 
			err = err - dy
			x0 = x0 + sx
			
		EndIf
		
		If e2 < dx 
		
			err = err + dx
			y0 = y0 + sy 
			
		EndIf
		
	endwhile
	
EndFunction

//-----------------------------------------------------
// Draw a line.
// x,y = top-left
//
function coDrawLine(x0 as float, y0 as float, x1 as float, y1 as float, col as integer, size as integer)

	local r as integer
	local g as integer
	local b as integer
	local s as float
	local ang as float
	local aa as float
	local bb as float
	local st as float
	
	s = size / 2
	r = GetColorRed(col)
	g = GetColorGreen(col)
	b = GetColorBlue(col)
	st = 0.05

	// up=0, right=90, down=180, left=270
	ang = atanfull(x1 - x0, y1 - y0)

	aa = ang + 180
	bb = aa
			
	for ang = 0.0 to 180.0 step st
		
		drawline(x0 + cos(aa) * s, y0 + sin(aa) * s, x1 + cos(bb) * s, y1 + sin(bb) * s, r, g, b)
		aa = aa - st
		bb = bb + st

	next

endfunction

//-----------------------------------------------------
// Draw a fake sprite-based line, using a single pixel.
// If spr is non-zero, it reuses that spr, otherwise it creates a new one.
// The spr drawn is returned.
//
function coDrawDot(x as float, y as float, col as integer, size as float, smooth as integer)

	local spr as integer
	local idx as integer
	local i as integer
	local s as float

	idx = -1
	
	for i = 0 to co.circles.length
		
		if size < co.circles[i].size
			
			idx = i
			exit
			
		endif
		
	next

	// If bigger that the biggest, then select it.
	if idx = -1
		idx = co.circles.length
	endif

	if smooth
		spr = CreateSprite(co.circles[idx].smoothImg)
	else 
		spr = CreateSprite(co.circles[idx].pixelImg)
	endif
	
	SetSpritePositionByOffset(spr, x, y)
	s = size / co.circles[idx].size
	SetSpriteScaleByOffset(spr, s, s)
	coSetSpriteColor(spr, col)
	
endfunction spr

//-----------------------------------------------------
// Create a sprite of a circle wit the required size.
// Trying to smooth by using different size sprites.
//
function coDrawDot2(col as integer, size as float, smooth as integer)

	local spr as integer
	local idx as integer
	local i as integer
	local s as float

	idx = -1
	
	for i = 0 to co.circles.length
		
		if size < co.circles[i].size
			
			idx = i
			exit
			
		endif
		
	next

	// If bigger that the biggest, then select it.
	if idx = -1
		idx = co.circles.length
	endif

	if smooth
		spr = co.circles[idx].smoothSpr
	else 
		spr = co.circles[idx].pixelSpr
	endif
	
	//SetSpritePositionByOffset(spr, x, y)
	s = size / co.circles[idx].size
	SetSpriteScaleByOffset(spr, s, s)
	coSetSpriteColor(spr, col)
	
endfunction spr

//-----------------------------------------------------
// Draw a rect like the DrawRect function.
// x,y = top-left
//
function coDrawRect(x as float, y as float, w as float, h as float, col as integer, size as integer)

	local i as integer

	for i = 0 to size

		DrawBox(x, y, x + w - 1, y + h - 1, col, col, col, col, false)
		inc x
		inc y
		w = w - 2
		h = h - 2

		if w < 0 or h < 0
			exit
		endif
		
	next

endfunction

//-----------------------------------------------------
// Draw an elipse like the DrawElispse function, but using lines.
// x,y = top-left
//
function coDrawEllipse(x as float, y as float, w as float, h as float, col as integer, size as integer)

	local w2 as float
	local h2 as float
	local a as float
	local xx as float
	local yy as float
	local r as integer
	local g as integer
	local b as integer
	local st as float
	local i as integer
	
	r = GetColorRed(col)
	g = GetColorGreen(col)
	b = GetColorBlue(col)
	st = 1.0

	for i = 0 to size step st

		w2 = w / 2
		h2 = h / 2
			
		for a = -90.0 to 270.0 step 0.1
					
			xx = x + w2 + cos(a) * w2
			yy = y + h2 + sin(a) * h2
			drawline(xx, yy, xx, yy, r, g, b)

		next
				
		x = x + st
		y = y + st
		w = w - st * 2 
		h = h - st * 2

		if w < 0 or h < 0
			exit
		endif
		
	next

endfunction

//-----------------------------------------------------
// Resize an img to a specific scale.
// ms = maxsize
//
function coResizeImage(img as integer, ms as float)

	local w as float
	local h as float
	local s as float
	
	w = GetImageWidth(img)
	h = GetImageHeight(img)
	s = 1.0

	if h > w
		if h > ms
			s = ms / h
		endif
	else //if w > h
		if w > ms
			s = ms / w
		endif
	endif

	ResizeImage(img, w * s, h * s)

endfunction s

//-----------------------------------------------------
// Resize an img to a specific scale.
// ms = maxsize
//
function coResizeSprite(spr as integer, ms as float)

	local w as float
	local h as float
	local s as float

	w = GetSpriteWidth(spr)
	h = GetSpriteHeight(spr)
	s = 1.0

	if h > w
		if h > ms
			s = ms / h
		endif
	else //if w > h
		if w > ms
			s = ms / w
		endif
	endif

	SetSpriteScaleByOffset(spr, s, s)

endfunction s

//-----------------------------------------------------
// Format a date.
//
function coFormatDate(dt as integer, s as string)

	local date as string
	local pos as integer
	local yy as integer
	local mm as integer
	local dd as integer
	local i as integer
	local m as integer
	local f as integer
	local d as integer
	local c as integer
	local dddd as string
	local mmmm as string
	local dow as integer

	if dt = 0
			
		date = GetCurrentDate()
		yy = val(mid(date, 1, 4))
		mm = val(mid(date, 6, 2))
		dd = val(mid(date, 9, 2))

	else 
		
		yy = GetYearFromUnix(dt)
		mm = GetMonthFromUnix(dt)
		dd = GetDaysFromUnix(dt)
				
	endif

	//f = k + [(13*m-1)/5] + D + [D/4] + [C/4] - 2*C
	//k = dd
	//m = mm, mar=1, apr=2, feb=12
	//D = yy
	//C = century

	m = mm - 2
	if m < 0 then m = m + 13
	d = fmod(yy, 100.0)
	c = trunc(yy / 100)
	f = dd + floor((13 * m - 1) / 5) + d + floor(d/4) + floor(c/4) - 2 * c
//xxx check this algorithm
	dow = abs(mod(f, 7))	
	dddd = co.days[dow] // "Monday"
	mmmm = co.months[mm - 1] // "August"
	
	for i = 0 to co.dateFmt.length

		pos = FindString(s, co.dateFmt[i])

		if pos > 0
		
			if co.dateFmt[i] = "DDDD"
				s = ReplaceString(s, co.dateFmt[i], upper(dddd), -1)				
			elseif co.dateFmt[i] = "Dddd"
				s = ReplaceString(s, co.dateFmt[i], dddd, -1)				
			elseif co.dateFmt[i] = "dddd"
				s = ReplaceString(s, co.dateFmt[i], lower(dddd), -1)				
			elseif co.dateFmt[i] = "DDD"
				s = ReplaceString(s, co.dateFmt[i], upper(left(dddd, 3)), -1)				
			elseif co.dateFmt[i] = "Ddd"
				s = ReplaceString(s, co.dateFmt[i], left(dddd, 3), -1)				
			elseif co.dateFmt[i] = "ddd"
				s = ReplaceString(s, co.dateFmt[i], lower(left(dddd, 3)), -1)				
			elseif co.dateFmt[i] = "dd"
				s = ReplaceString(s, co.dateFmt[i], right("00" + str(dd), 2), -1)		
			elseif co.dateFmt[i] = "d"
				s = ReplaceString(s, co.dateFmt[i], str(dd), -1)				
			elseif co.dateFmt[i] = "MMMM"
				s = ReplaceString(s, co.dateFmt[i], upper(mmmm), -1)				
			elseif co.dateFmt[i] = "Mmmm"
				s = ReplaceString(s, co.dateFmt[i], mmmm, -1)				
			elseif co.dateFmt[i] = "mmmm"
				s = ReplaceString(s, co.dateFmt[i], lower(mmmm), -1)				
			elseif co.dateFmt[i] = "MMM"
				s = ReplaceString(s, co.dateFmt[i], upper(left(mmmm, 3)), -1)				
			elseif co.dateFmt[i] = "Mmm"
				s = ReplaceString(s, co.dateFmt[i], left(mmmm, 3), -1)				
			elseif co.dateFmt[i] = "mmm"
				s = ReplaceString(s, co.dateFmt[i], lower(left(mmmm, 3)), -1)				
			elseif co.dateFmt[i] = "mm"
				s = ReplaceString(s, co.dateFmt[i], right("00" + str(mm), 2), -1)				
			elseif co.dateFmt[i] = "m"
				s = ReplaceString(s, co.dateFmt[i], str(mm), -1)				
			elseif co.dateFmt[i] = "yyyy"
				s = ReplaceString(s, co.dateFmt[i], right(str(yy), 4), -1)				
			elseif co.dateFmt[i] = "yy"
				s = ReplaceString(s, co.dateFmt[i], right(str(yy), 2), -1)				
			endif
			
		endif
		
	next

endfunction s

//-----------------------------------------------------
// Format a time.
//
function coFormatTime(dt as integer, s as string)

	local time as string
	local pos as integer
	local hh as integer
	local mm as integer
	local ss as integer
	local i as integer
	local h12 as integer
	local tt as string 
	
	if dt = 0
		
		time = GetCurrentTime()
		hh = val(mid(time, 1, 2))
		mm = val(mid(time, 4, 2))
		ss = val(mid(time, 7, 2))
		
	else 
		
		hh = GetHoursFromUnix(dt)
		mm = GetMinutesFromUnix(dt)
		ss = GetSecondsFromUnix(dt)
		
	endif
	
	h12 = mod(hh, 12)

	if hh > 12
		tt = "Pm"
	else
		tt = "Am"
	endif
	
	for i = 0 to co.timeFmt.length

		pos = FindString(s, co.timeFmt[i])

		if pos > 0
		
			if co.timeFmt[i] = "HH"
				s = ReplaceString(s, co.timeFmt[i], right("00" + str(hh), 2), -1)				
			elseif co.timeFmt[i] = "H"
				s = ReplaceString(s, co.timeFmt[i], str(hh), -1)				
			elseif co.timeFmt[i] = "hh"
				s = ReplaceString(s, co.timeFmt[i], right("00" + str(h12), 2), -1)				
			elseif co.timeFmt[i] = "h"
				s = ReplaceString(s, co.timeFmt[i], str(h12), -1)				
			elseif co.timeFmt[i] = "mm"
				s = ReplaceString(s, co.timeFmt[i], right("00" + str(mm), 2), -1)				
			elseif co.timeFmt[i] = "m"
				s = ReplaceString(s, co.timeFmt[i], str(mm), -1)				
			elseif co.timeFmt[i] = "ss"
				s = ReplaceString(s, co.timeFmt[i], right("00" + str(ss), 2), -1)				
			elseif co.timeFmt[i] = "s"
				s = ReplaceString(s, co.timeFmt[i], str(ss), -1)				
			elseif co.timeFmt[i] = "TT"
				s = ReplaceString(s, co.timeFmt[i], upper(tt), -1)				
			elseif co.timeFmt[i] = "Tt"
				s = ReplaceString(s, co.timeFmt[i], tt, -1)				
			elseif co.timeFmt[i] = "tt"
				s = ReplaceString(s, co.timeFmt[i], lower(tt), -1)				
			elseif co.timeFmt[i] = "T"
				s = ReplaceString(s, co.timeFmt[i], left(tt, 1), -1)				
			elseif co.timeFmt[i] = "t"
				s = ReplaceString(s, co.timeFmt[i], left(lower(tt), 1), -1)				
			endif
			
		endif
		
	next

endfunction s

//-----------------------------------------------------
// Create a unique name.
//
function coGetUniqueName()
	
	local i as integer
	local s as string
	local t as string
	local ln as integer

	ln = len(CO_LOWERS$)
	
	if co.uname[0] = 0 // Hasn't been initialised yet.
		
		for i = 0 to co.uname.length
			co.uname[i] = 1
		next

	else 
			
		for i = co.uname.length to 0 step -1
			
			inc co.uname[i]
			
			if co.uname[i] > ln
				co.uname[i] = 1
			else 
				exit 
			endif
			
		next
		
	endif

	s = ""
		
	for i = 0 to co.uname.length
		
		t = mid(CO_LOWERS$, co.uname[i], 1)
		s = s + t
		
	next
	
endfunction s

//
// End.
//

