#option_explicit

//
// Common code.
//

//-----------------------------------------------------
// Booleans.
//
#constant FALSE = 0
#constant TRUE = 1

#constant _Q chr(34)
#constant _T chr(9)
#constant _N chr(13)

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

// Depth values.
//
#constant FRONT_DEPTH 100

// Thing logical depth is between 1 and MAX (3000).
#constant THING_DEPTH_MAX 3000 // Max logical depth.

// It is they multiplied by TIP SKIP to account for the number of depth layers required to draw a tip.
// Then the base is added, because we can't go higher that the GUI controls above.
// Which results in a visible depth range of 500 to 8500.
#constant THING_DEPTH_SKIP 3 // Other with a tip.
#constant THING_DEPTH_BASE 500 // The lowest depth during design or runtime.

// Var depth, 200 / 4 = 50 vars.
#constant VAR_DEPTH_MAX 50 // Max logical depth.
#constant VAR_DEPTH_SKIP 4 // Allow for the layers of a tip, i.e. border text, etc.
#constant VAR_DEPTH_BASE 200 // The lowest depth during design or runtime.

#constant BACK_DEPTH 10000

// Game states.
//
#constant STATE_NONE 0
#constant STATE_PLAY 1
#constant STATE_WON 2
#constant STATE_LOST 3
#constant STATE_HELP 4
#constant STATE_SETTINGS 5
#constant STATE_BACK 6
#constant STATE_START 7
#constant STATE_END 8
#constant STATE_COUNTER 9

#constant CO_CS 16
#constant CO_CS2 8
#constant CO_BS 128
#constant CO_BS2 64

#constant CO_LINE_MID_CIRC 1
#constant CO_LINE_MID_SQR 2
#constant CO_LINE_END_CIRC 3
#constant CO_LINE_END_SQR 4

#constant CO_LINE_CIRC 1
#constant CO_LINE_SQR 2
#constant CO_LINE_POLY 3 // Not a real flag, just used to check for values of 3 or greater.

#constant CO_SHAPE_RECT 1
#constant CO_SHAPE_OVAL 2
#constant CO_SHAPE_POLY 3

#constant CO_SEL_RECT 1
#constant CO_SEL_OVAL 2
#constant CO_SEL_FREE 3
#constant CO_SEL_LINE 4
#constant CO_SEL_FILL 5

#constant CO_COL_EQ 0x01
#constant CO_COL_NE 0x02
#constant CO_COL_CLEAR 0x04
#constant CO_COL_CLEAR_NO_MATCH 0x08
#constant CO_COL_FILL_MASK 0x10

#constant CO_GRID_PAIR 1

#constant CO_NO_PIXEL 0 // Save no pixels.
#constant CO_PRE_PIXEL 1 // Save pixel before writing over, i.e. undo.
#constant CO_POST_PIXEL 2 // Save pixel after writing over, i.e. redo.

#constant CO_MEM_TMP_SIZE 100

#constant CO_LASSO_OUTSIDE -1
#constant CO_LASSO_INSIDE 1
#constant CO_LASSO_VISITED 2

#constant CO_FONT_REGULAR 0
#constant CO_FONT_EXTRA_LIGHT 1
#constant CO_FONT_LIGHT 2
#constant CO_FONT_MEDIUM 3
#constant CO_FONT_SEMI_BOLD 4
#constant CO_FONT_BOLD 5
#constant CO_FONT_BLACK 6

#constant CO_INFO_X_POS 1
#constant CO_INFO_Y_POS 2
#constant CO_INFO_ANGLE 3
#constant CO_INFO_FRAME 4
#constant CO_INFO_X_SIZE 5
#constant CO_INFO_Y_SIZE 6
#constant CO_INFO_COLOR 7
#constant CO_INFO_TRANS 8
#constant CO_INFO_WIDTH 9
#constant CO_INFO_HEIGHT 10
#constant CO_INFO_DEPTH 11
#constant CO_INFO_VISIBLE 12

#constant CO_WRAP_NONE 0
#constant CO_WRAP_HITS_EDGE 1
#constant CO_WRAP_OFF_SCREEN 2

global CO_PI as float
global CO_PI_2 as float

#constant CO_ID_LEN 10 // 10 random letters or numbers.

//-----------------------------------------------------
// Drag distance before a touch becomes a drag.
//
#constant DRAG_SIZE_MIN = 20 // The minimum distance a drag needs to be to not just be a touch.

//-----------------------------------------------------
// Strip chars for a file name.
//
#constant CO_DELIMS$ = " ~!@#$%^&*()_+`-=[]\[]\;':,./<>?" + chr(34)
#constant CO_LOWERS$ = "abcdefghijklmnopqrstuvwxyz"
#constant CO_UPPERS$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#constant CO_DIGITS$ = "0123456789"

global CO_ALPHANUMS$
global CO_ALPHANUMS_LEN as integer

//-----------------------------------------------------
global co as Common

//-----------------------------------------------------
type Common
	
	log as string[]
	logTop as integer
	logNbr as integer
	logMsg as string 
	printSize as integer
	logLineMax as integer
	
	pixImg as integer
	//circleImg as integer[]
	//circleSize as integer[]
	circles as Circle[]
	
	cs as float // Width of one block, e.g. 8
	bs as float // Width of a square button.
	w as float
	h as float
	w1 as float
	w2 as float
	w3 as float
	iw as float
	iw0 as float
	iw1 as float
	iw2 as float
	iw3 as float
	iw4 as float
	h1 as float
	h2 as float
	h3 as float
	ih as float
	ih0 as float
	ih1 as float
	ih2 as float
	ih3 as float
	ih4 as float
	tabW as float
	
	mw as float
	mh as float
	
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

	openCol as integer
	renameCol as integer
	editCol as integer
	deleteCol as integer
	helpCol as integer
	detailsCol as integer
	cutCol as integer
	copyCol as integer
	undoCol as integer
	redoCol as integer
	runCol as integer
	moreCol as integer
	special1Col as integer
	special11Col as integer
	special12Col as integer
	special13Col as integer
	special2Col as integer
	special21Col as integer
	special22Col as integer
	special23Col as integer
	special3Col as integer
	special31Col as integer
	special32Col as integer
	special33Col as integer
	special4Col as integer
	special41Col as integer
	special42Col as integer
	special43Col as integer
	special5Col as integer
	special51Col as integer
	special52Col as integer
	special53Col as integer
	
	fonts as Font[]
	fontSizes as float[]
	editFontSizes as float[]

	sprs as integer[] // Debug holder.
	sprNames as string[]
	txts as integer[]
	imgs as integer[]
	sprDebug as integer
	baseName as string
	appName as string

	dateFmt as string[]
	dateFmtHelp as string[]
	timeFmt as string[]
	timeFmtHelp as string[]
	days as string[]
	months as string[]

	progressImg as integer
	progress as integer
	
	lassoDx as integer[]
	lassoDy as integer[]
	
	mems as MemBlock[]
	freeMems as integer[]
	
	// For rotate2 fn, to store the complete rotation area for undo.
	memRot as MemBlock
	memRotBounds as Bounds
	
	symbols as string
	alphas as string
	digits as string
	alphanum as string
	depthRange as integer
		
endtype

type KVPair

	k as string
	v as string
	
endtype

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

type NameUnique

	name as string
	unique as integer
	suffix as integer
	
endtype

type StringFinder

	pos as integer
	s as string
	t as string
	
endtype

type Pixel 
	
	off as integer // If this is set, then it's an offset pixel. Otherwise x and y should be set.
	col as integer
	grp as integer // A key that groups all pixel changes together, e.g. for an undo.
	
endtype

type Circle 
	
	smoothImg as integer
	pixelImg as integer
	smoothSpr as integer
	pixelSpr as integer
	size as integer
	
endtype

//-----------------------------------------------------
// Mem block / image pixel handling.
//
type MemBlock

	deleted as integer
	idx as integer
	id as integer
	w as integer
	h as integer
	offMax as integer
	blend as integer
	line as integer // Temp memblock for lines.
	lineCol as integer // The current lineCol for use of whether to rebuild the line memblock.
	lineSize as integer // The current lineSize.
	lineStyle as integer // The current lineStyle.
	lasso as integer // Temp memblock for lasso.
	sel as integer // A selection, drawing ops must not exceed it. It must be the same size as the original mb.
	pixCount as integer // How many pixels were affected by operation.
	stack as Segment[]
	bs as Bounds // Limits fill operations.
	fill as integer // The fill mask.
	mask as integer // Mask flag meaning this memblock is a single color mask only.
	undo as integer // If true, save pixels.
	snap as integer // If true, pixels that exceed the memblock are snapped back to the closest edge.
	undoGrp as integer // The grp for the Pixels of an undo.
	pixels as Pixel[] // The pixels affected by all operations.
	copy as integer // If true, then this is a copy of a another memblock, and shouldn't bee freed.

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

	CO_PI = 3.14159265359
	CO_PI_2 = CO_PI / 2.0

	CO_ALPHANUMS$ = CO_DIGITS$ + CO_UPPERS$ + CO_LOWERS$
	CO_ALPHANUMS_LEN = len(CO_ALPHANUMS$)

	co.cs = CO_CS
	co.bs = CO_BS
	
	co.w = GetVirtualWidth() // 2048
	co.h = GetVirtualHeight() // 1536
	
	co.w1 = co.w / 4
	co.w2 = co.w / 2
	co.w3 = co.w2 + co.w1
	co.iw = co.w / 6 * 5	
	co.iw0 = (co.w - co.iw) / 2
	co.iw1 = co.w1 / 4
	co.iw2 = co.w / 2
	co.iw3 = co.iw2 + co.iw1
	co.iw4 = co.w - co.iw0
	co.h1 = co.h / 4
	co.h2 = co.h / 2
	co.h3 = co.h2 + co.h1
	co.ih = co.h / 71 * 60
	co.ih0 = (co.h - co.ih) / 2
	co.ih1 = co.ih / 4
	co.ih2 = co.h / 2
	co.ih3 = co.h2 + co.ih1
	co.ih4 = co.h - co.ih0
	co.tabW = co.h
	co.depthRange = (THING_DEPTH_MAX * THING_DEPTH_SKIP)
	
	co.mw = 1920
	co.mh = 1080
	
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

	co.special1Col = co.purple[5]
	co.special11Col = co.purple[3]
	co.special12Col = co.purple[2]
	co.special13Col = co.purple[1]
	co.special2Col = co.indigo[5]
	co.special21Col = co.indigo[3]
	co.special22Col = co.indigo[2]
	co.special23Col = co.indigo[1]
	co.special3Col = co.cyan[5]
	co.special31Col = co.cyan[3]
	co.special32Col = co.cyan[2]
	co.special33Col = co.cyan[1]
	co.special4Col = co.deeppurple[5]
	co.special41Col = co.pink[3]
	co.special42Col = co.pink[2]
	co.special43Col = co.pink[1]
	co.special5Col = co.amber[9]
	co.special51Col = co.amber[5]
	co.special52Col = co.amber[4]
	co.special53Col = co.amber[3]

	co.openCol = co.blue[5] // Add, play, open, etc.
	co.renameCol = co.teal[5]
	co.editCol = co.orange[5]
	co.deleteCol = co.red[5]
	co.runCol = co.green[5]
	co.helpCol = co.bluegrey[3]
	co.detailsCol = co.lightblue[5]
	co.undoCol = co.bluegrey[4]
	co.redoCol = co.bluegrey[6]
	co.cutCol = co.undoCol
	co.copyCol = co.redoCol
	co.moreCol = co.lime[7]

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
	co.dateFmtHelp.insert("Full day of the week, all uppercase, e.g. MONDAY, WEDNESDAY, SATURDAY.")
	co.dateFmtHelp.insert("Full day of the week, e.g. Monday, Wednesday, Saturday.")
	co.dateFmtHelp.insert("Full day of the week, all lowercase, e.g. monday, wednesday, saturday.")
	co.dateFmtHelp.insert("Short day of the week, all uppercase, e.g. MON, WED, SAT.")
	co.dateFmtHelp.insert("Date as 2 digits. If date \< 10, then shows a zero prefix, e.g. 01, 15, 31.")
	co.dateFmtHelp.insert("Date as 1 or 2 digits. If date \< 10, then only shows 1 digit, e.g. 1, 15, 31.")
	co.dateFmtHelp.insert("Short day of the week, all lowercase, e.g. mon, wed, sat.")
	co.dateFmtHelp.insert("Short day of the week, e.g. Mon, Wed, Sat.")
	co.dateFmtHelp.insert("Full month name, all uppercase, e.g. JANUARY, MAY, DECEMBER.")
	co.dateFmtHelp.insert("Full month name, e.g. January, May, December.")
	co.dateFmtHelp.insert("Full month name, all lowercase, e.g. january, may, december.")
	co.dateFmtHelp.insert("Short month name, all uppercase, e.g. JAN, MAY, DEC.")
	co.dateFmtHelp.insert("Short month name, e.g. Jan, May, Dec.")
	co.dateFmtHelp.insert("Short month name, all lowercase, e.g. jan, may, dec.")
	co.dateFmtHelp.insert("Month as 2 digits. If the month \< 10, then shows zero prefix, e.g. 01, 07, 12")
	co.dateFmtHelp.insert("Month as 1 or digits. If the month \< 10, then only shows 1 digit, e.g. 1, 7, 12")
	co.dateFmtHelp.insert("Year as 4 digits, e.g. 1966, 2000, 2018.")
	co.dateFmtHelp.insert("Year as 2 digits, e.g. 66, 00, 18.")

	co.timeFmt = ["HH", "hh", "H", "h", "mm", "m", "ss", "s", "TT", "Tt", "tt", "T", "t"]
	co.timeFmtHelp.insert("Hour in 24-hour clock. If hour \< 10, then prefix with 0, e.g. 01, 13, 23.")
	co.timeFmtHelp.insert("Hour in 12-hour clock. If hour \< 10, then prefix with 0, e.g. 01, 05, 12.")
	co.timeFmtHelp.insert("Hour in 24-hour clock. If hour \< 10, shows 1 digit, e.g. 1, 13, 23.")
	co.timeFmtHelp.insert("Hour in 12-hour clock. If hour \< 10, shows 1 digit, e.g. 1, 5, 12.")
	co.timeFmtHelp.insert("Minutes. If minute \< 10, then prefix with 0, e.g. 01, 23, 59.")
	co.timeFmtHelp.insert("Minutes. If minute \< 10, then only show 1 digit, e.g. 1, 23, 59.")
	co.timeFmtHelp.insert("Seconds. If second \< 10, then prefix with 0, e.g. 01, 23, 59.")
	co.timeFmtHelp.insert("Seconds. If second \< 10, then only show 1 digit, e.g. 1, 23, 59.")
	co.timeFmtHelp.insert("Show AM or PM.")
	co.timeFmtHelp.insert("Show Am or Pm.")
	co.timeFmtHelp.insert("Show am or pm.")
	co.timeFmtHelp.insert("Show A or P for AM and PM.")
	co.timeFmtHelp.insert("Show a or p for am and pm.")

	co.days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
	co.months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

	co.sprs.length = -1
	co.sprNames.length = -1
	co.sprDebug = true

	co.baseName = GetDeviceBaseName()
	co.appName = "Codey Codey"

	co.printSize = 50
	co.log.length = -1
	co.logTop = false
	co.logNbr = 1
	co.logMsg = ""
	co.logLineMax = floor(co.h / co.printSize)

	co.lassoDx = [-1, 0, 1, 0]
	co.lassoDy = [0, 1, 0, -1]
	
	co.symbols = "`~!@#$%^&*()_-+={[}]|\:;'<,>.?/" + chr(34)
	co.alphas = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	co.digits = "0123456789"
	co.alphanum = co.alphas + co.digits
	
	setPrintColor(0, 0, 0)
	SetPrintSize(co.printSize)	

	coInitCircles()
	coMemCreateRef(0, 0) // Waste index 0, because it's easier to check for 0 than -1.

	co.progressImg = loadimage("gfx/ProgressIcon.png")
	co.progress = cocreatesprite("progress", co.progressImg)
	SetSpriteDepth(co.progress, 1)
	coSetProgressPos(1)
	SetSpriteVisible(co.progress, false)
	//coProgressEnd()
		
endfunction

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
		
		if not co.fonts[fontIdx].id
			colog("Error: Font " + file + " not found")
		endif
		
	endif

endfunction

//-----------------------------------------------------
//
function coSetProgressPos(pos as integer)

	if pos = 1
		SetSpritePositionByOffset(co.progress, co.bs * 5, co.bs - co.bs / 8)
	elseif pos = 2
		SetSpritePositionByOffset(co.progress, co.w - co.bs / 4 - GetSpriteWidth(co.progress) / 2, co.bs / 4 + GetSpriteHeight(co.progress) / 2)
	endif

endfunction

//-----------------------------------------------------
//
function coProgressStart(pos as integer)

	coSetProgressPos(pos)

	if not GetSpriteVisible(co.progress)
				
		SetSpriteAngle(co.progress, 0)
		SetSpriteVisible(co.progress, true)

	endif

endfunction

//-----------------------------------------------------
//
function coProgressEnd()

	SetSpriteVisible(co.progress, false)
	
endfunction

//-----------------------------------------------------
//
function coProgressStep()

	local ang as float

	if GetSpriteVisible(co.progress)
		
		ang = GetSpriteAngle(co.progress)
		
		ang = ang + 5
		if ang > 360
			ang = ang - 360
		endif
		
		SetSpriteAngle(co.progress, ang)
		
		//maLoop()
		sync()

	endif
	
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
	
	if false
		
		SetRenderToImage(img, 0)
		clearscreen()
		SetVirtualResolution(GetImageWidth(img), GetImageHeight(img))
		DrawEllipse(x + d / 2, y + d / 2, d / 2, d / 2, co.white, co.white, true)
		SetRenderToScreen()
		SetVirtualResolution(co.w, co.h)

	else 
		
		log("t=" + GetCurrentTime())
		local mb as MemBlock
		coMemFromImage(img, mb)
		//coMemCreate(mb, d, d)
		coMemDrawOval(mb, 0, 0, d - 1, d - 1, co.white, d - 1)
		img = coMemToImage(mb)
		coMemDelete(mb)	
		
	endif

endfunction img

//-----------------------------------------------------
// Log a message ready to print.
//
function coLog(msg as string)

	local s as string 
	
	s = str(co.logNbr) + ": " + msg
	co.log.insert(s)
	co.logMsg = ""

	if co.log.length > co.logLineMax
		co.log.remove(0)
	endif
	
	co.logNbr = co.logNbr + 1
	
endfunction

//-----------------------------------------------------
// Log a message ready to print.
//
function coLogPrint()

	local msg as string
	local i as integer

	if co.logMsg = ""
		if co.logTop
			for i = co.log.length to 0 step -1
				co.logMsg = co.logMsg + co.log[i] + chr(10)
			next
		else
			for i = 0 to co.log.length
				co.logMsg = co.logMsg + co.log[i] + chr(10)
			next		
		endif
	endif
	
	print(co.logMsg)
	
endfunction

//-----------------------------------------------------
function coMessage(msg as string)
	
	//coLog(msg$)
	message(msg)
	
endfunction

//-----------------------------------------------------
// Log a message ready to print.
//
function coLogClear()
	
	co.log.length = -1
	co.logNbr = 1
	
endfunction

//-----------------------------------------------------
// Set the log point.
// logTop=true for prepend, or false for append.
//
function coLogTop(logTop as integer)
	
	co.logTop = logTop
	
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
// Uses a rect method instead of GetSpriteHitTest.
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
// Check if in win_mode that the left mouse is pressed.
//
function coLeftPress()

	if WIN_MODE
		if in.leftMousePressed
			exitfunction true
		endif
	else 
		if in.ptrPressed
			exitfunction true
		endif
	endif
	
endfunction false

//-----------------------------------------------------
// Check if in win_mode that the left mouse is down.
//
function coLeftDown2()

	if WIN_MODE
		if in.leftMouseDown
			exitfunction true
		endif
	else 
		if in.ptrDown
			exitfunction true
		endif
	endif
	
endfunction false

//-----------------------------------------------------
// Check if in win_mode that the left or right mouse is down.
//
function coAnyDown2()

	exitfunction true
	
	if WIN_MODE
		if in.leftMouseDown or in.rightMouseDown
			exitfunction true
		endif
	else 
		if in.ptrDown
			exitfunction true
		endif
	endif
	
endfunction false

//-----------------------------------------------------
// Check if in win_mode that the left mouse is down, otherwise if the cond is true.
//
function coLeftDown(cond)

	exitfunction cond
	
	if WIN_MODE
		if in.leftMouseDown
			//if cond
				exitfunction true
			//endif
		endif
	else 
		if cond
			exitfunction true
		endif
	endif
	
endfunction false

//-----------------------------------------------------
// Check if in win_mode that the right mouse is pressed.
//
function coRightPress()

	if WIN_MODE
		if in.rightMousePressed
			exitfunction true
		endif
	else 
		if in.ptrPressed
			exitfunction true
		endif
	endif
	
endfunction false

//-----------------------------------------------------
// Check if in win_mode that the right mouse is down, otherwise if the cond is true.
//
function coRightDown(cond)

	if WIN_MODE
		if in.rightMouseDown
			exitfunction true
		endif
	else 
		if cond
			exitfunction true
		endif
	endif
	
endfunction false

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
// Search fin.s from fin.pos and extract only digits, and return in fin.t
// fin.pos will be moved if digits are found.
//
function coFindStrDigits(fin ref as StringFinder)

	local c as string
	local a as integer
	
	fin.t = ""
	c = mid(fin.s, fin.pos, 1)
	a = asc(c)

	while a >= 48 and a <= 57

		fin.t = fin.t + c
		inc fin.pos
		c = mid(fin.s, fin.pos, 1)
		a = asc(c)

	endwhile
	
endfunction

//----------------------------------------------------------
// Search fin.s from fin.pos and extract chars, and return in fin.t
// fin.pos will be moved if symbols are found.
//
function coFindStrChars(fin ref as StringFinder, chars as string)

	local c as string
	local a as integer
	
	fin.t = ""
	c = mid(fin.s, fin.pos, 1)
	a = asc(c)
	
	//while a >= 48 and a <= 57
	while FindString(chars, c) > 0

		fin.t = fin.t + c
		inc fin.pos
		c = mid(fin.s, fin.pos, 1)
		a = asc(c)

	endwhile
	
endfunction

//----------------------------------------------------------
// Search fin.s from fin.pos and extract symbols, and return in fin.t
// fin.pos will be moved if symbols are found.
//
function coFindStrQuoted(fin ref as StringFinder)

	local c as string
	local a as integer
	local lc as string
	
	fin.t = ""
	c = mid(fin.s, fin.pos, 1)
	a = asc(c)
	lc = ""
	
	if a = 34 // Quote.
	
		lc = c
		inc fin.pos		
		c = mid(fin.s, fin.pos, 1)
		a = asc(c)
		
		while a <> 34 and fin.pos < len(fin.s) // Not quote.
	
			fin.t = fin.t + c
			lc = c
			inc fin.pos
			c = mid(fin.s, fin.pos, 1)
			a = asc(c)

			// If we hit a quote, but the last char was escaping it, then keep it and move on.
			if a = 34 and lc = "\"
				
				fin.t = fin.t + c
				lc = c
				inc fin.pos
				c = mid(fin.s, fin.pos, 1)
				a = asc(c)

			endif
	
		endwhile
		
		inc fin.pos
					
	endif
	
endfunction

//----------------------------------------------------------
// Search fin.s from fin.pos and extract only digits, and return in fin.t
// fin.pos will be moved if digits are found.
//
function coFindStrHex(fin ref as StringFinder)

	local c as string
	local a as integer
	
	fin.t = ""
	c = mid(fin.s, fin.pos, 1)
	a = asc(lower(c))

	while (a >= 48 and a <= 57) or (a >= 97 and a <= 102)

		fin.t = fin.t + c
		inc fin.pos
		c = mid(fin.s, fin.pos, 1)
		a = asc(lower(c))

	endwhile
	
endfunction

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
// Format the passed float as the format.
// 0.00 = decimal with 1 or more int digits + 2 decimals.
// 000.000 = min 3 digits, even if value < 100, min 3 decimals, even if less significance.
// Note: Doesn't round, you need to do that first.
//
function xxxcoFormatNbr(s as string, f as string, delim as string)
	
	local fpos as integer
	local spos as integer
	local inbr as string
	local dnbr as string
	local ret as string
	local in as integer
	local fl as float

	spos = findstring(s, ".")
	
	if spos > 0 // The nbr is decimal.

		fpos = findstring(f, ".")
		
		if fpos > 0 // The fmt is a decimal.

			inbr = coFormatIntNbr(mid(s, 1, spos - 1), mid(f, 1, fpos - 1), delim)
			dnbr = coFormatDecNbr(mid(s, spos + 1, -1), mid(f, fpos + 1, -1))
			ret = inbr + "." + dnbr

		else 
			
			s = str(round(valfloat(s)))
			ret = coFormatIntNbr(s, f, delim)
			
		endif
		
	else // Int.
		
		fpos = findstring(f, ".") // The fmt is a decimal.
		
		if fpos > 0 // The fmt is a decimal.
			
			inbr = coFormatIntNbr(s, mid(f, 1, fpos - 1), delim)
			dnbr = mid(f, fpos + 1, -1)
			ret = inbr + "." + dnbr

		else
			
			ret = coFormatIntNbr(s, f, delim)
			
		endif
				
	endif
	
endfunction ret

//----------------------------------------------------------
// Format an int.
// e.g. 0,000
//
function coFormatIntNbr(s as string, f as string, delim as string)
	
	local sp as integer
	local fp as integer
	local nbr as string
	local c as string
	local count as integer
	
	if s = "" or f = ""
		exitfunction ""
	endif

	// Whole part.			
	sp = len(s)
	fp = len(f)
	nbr = ""
	count = 0
	
	while sp > 0
		
		if fp > 0
			
			c = mid(f, fp, 1)
			
			if findstring(CO_DIGITS$, c) > 0	

				if count = 3
					
					nbr = delim + nbr
					count = 0
				
				endif
																						
				nbr = mid(s, sp, 1) + nbr
				inc count
				dec sp
												
			endif
			
			dec fp
			
		else
			
			c = mid(f, sp, 1)

			if findstring(CO_DIGITS$, c) > 0	
			
				nbr = mid(s, sp, 1) + nbr
				inc count
			endif
			
			dec sp
			
		endif 
		
	endwhile 
			
	while fp > 0

		if findstring(CO_DIGITS$, c) > 0		
			
			if count = 3	
				
				nbr = delim + nbr
				count = 0
				
			endif
			
			nbr = mid(f, fp, 1) + nbr	
			inc count
				
		endif

		dec fp
		
	endwhile

endfunction nbr

//----------------------------------------------------------
// Format a dec nbr.
// e.g. 000 reduce decimal rounded to 3 digits.
//
function coFormatDecNbr(s as string, f as string)

	local sp as integer
	local fp as integer
	local sl as integer
	local fl as integer
	local nbr as string
	
	if s = "" or f = ""
		exitfunction ""
	endif
		
	// Decimal part.			
	sp = 1
	fp = 1
	sl = len(s)
	fl = len(f)
	nbr = ""
	
	while sp <= sl
		
		if fp < fl
			
			nbr = nbr + mid(s, sp, 1)
			inc sp
			inc fp
				
		else
			
			if sp < sl										
				nbr = nbr + str(round(ValFloat(mid(s, sp, 1) + "." + mid(s, sp + 1, -1))))
			else 
				nbr = nbr + mid(s, sp, 1)
			endif
						
			exit
								
		endif 
		
	endwhile 
	
	// Finish off format.
	while fp < fl
		
		nbr = nbr + mid(f, fp, 1)
		inc fp
		
	endwhile
			
endfunction nbr

//----------------------------------------------------------
// Trim chars in c from ends of s.
//
function coTrimStr(s as string, c as string)

	local ret as string
	
	ret = TrimString(s, c)
	
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
// Delete the settings file.
//
function coDeleteSettings(fileName as string)

	DeleteFile(fileName)
	
endfunction

//-----------------------------------------------------
// Load a file containing a list of k=v lines.
//
function coLoadSettings(fileName as string, list ref as KVPair[])

	local file as integer
	local line as string
	local pair as KVPair
	
	file = OpenToRead(fileName)
	
	if file
		
		while not FileEOF(file)
			
			line = ReadLine(file)
			pair.k = GetStringToken2(line, "=", 1)
			pair.v = GetStringToken2(line, "=", 2)
			coInsertSetting(list, pair)

		endwhile

	endif
	
	CloseFile(file)
	
endfunction

//-----------------------------------------------------
// Insert a pair into the list.
// If the pair's k already exists, replace the value only.
//
function coInsertSetting(list ref as KVPair[], pair ref as KVPair)

	local i as integer
	local found as integer

	found = false
	
	for i = 0 to list.length
		
		if list[i].k = pair.k

			list[i].v = pair.v
			found = true
			
		endif
		
	next

	if not found
		list.insert(pair)
	endif
	
endfunction

//-----------------------------------------------------
// Insert a pair into the list.
// If the pair's k already exists, replace the value only.
//
function coSetSetting(list ref as KVPair[], k as string, v as string)

	local i as integer
	local found as integer
	local pair as KVPair

	found = false
	
	for i = 0 to list.length
		
		if list[i].k = k

			list[i].v = v
			found = true
			
		endif
		
	next

	if not found

		pair.k = k
		pair.v = v
		list.insert(pair)
		
	endif
	
endfunction

//-----------------------------------------------------
// Find a value for a given k (key) into thr settings list.
//
function coGetSetting(list ref as KVPair[], k as string, def as string)

	local i as integer
	local ret as string

	ret = def
	
	for i = 0 to list.length
		
		if list[i].k = k

			ret = list[i].v
			
		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Save a list of k=v (Key-value pairs) into the passed file.
//
function coSaveSettings(fileName as string, list ref as KVPair[])

	local file as integer
	local i as integer
	
	file = opentowrite(fileName)

	if file

		for i = 0 to list.length
			writeline(file, list[i].k + "=" + list[i].v)
		next
		
	endif

	CloseFile(file)
	
endfunction

//-----------------------------------------------------
//
function coInitAds() 
 
        select GetDeviceType() //just an array with the contents of getDeviceType()
 
            case "ios"
                SetAdMobDetails("ca-app-pub-3359100048392078/9758071542") //pushdown_full_ios_admob_interstit
 
            endcase
 
            case "android"                
                setAdMobDetails("ca-app-pub-xxxxxxxxxxxxxxx/xxxxxxxxxxxxxxx") //pushdown_android_admob_banner
 
            endcase
        endselect
 
endfunction

//-----------------------------------------------------
//
function coDisplayAdvertBanner()
//call this when you want a banner ad
 
        CreateAdvert(0, 1, 0, 1)
		SetAdvertLocationEx(1, 0, 0, 100, co.iw)
        SetAdvertVisible(true)
        RequestAdvertRefresh()
 
endfunction

//-----------------------------------------------------
//
function coDisplayAdvertFullscreen()
//call this when you want a full screen ad
 
        coInitAds() 
        //PauseMusic() //full screen ads sometimes have sounds/music
        CreateFullscreenAdvert()
        SetAdvertVisible(true)
        RequestAdvertRefresh()
 
endfunction

//-----------------------------------------------------
// Find the sprite as position, that is visible.
//
function coFindDbgSpr(x as float, y as float)

	local spr as integer
	local i as integer
	local depth as integer

	spr = 0
	depth = 0xffffff
	
	if co.sprDebug
		
		for i = 0 to co.sprs.length
			
			if GetSpriteHitTest(co.sprs[i], x, y)
				
				if GetSpriteVisible(co.sprs[i])

					if GetSpriteDepth(co.sprs[i]) < depth
						
						depth = GetSpriteDepth(co.sprs[i])
						spr = co.sprs[i]
						colog("spr=" + str(spr) + ", name=" + co.sprNames[i])
						exit

					endif
					
				endif
				
			endif
			
		next
		
	endif

endfunction spr

//-----------------------------------------------------
//
function coCreateSprite(s as string, img as integer)

	local spr as integer

	spr = createsprite(img)

	if co.sprDebug
		
		co.sprs.insert(spr)
		co.sprNames.insert(s)
			
	endif

	//colog("coCreateSprite: " + s + ", spr=" + str(spr))
	
endfunction spr

//-----------------------------------------------------
//
function coCloneSprite(s as string, img as integer)

	local spr as integer

	spr = clonesprite(img)

	if co.sprDebug
		
		co.sprs.insert(spr)
		co.sprNames.insert(s)

	endif

	//colog("coCreateSprite: " + s + ", spr=" + str(spr))
	
endfunction spr

//-----------------------------------------------------
//
function coCreateText(s as string, msg as string)

	local txt as integer
	
	txt = CreateText(msg)

	if co.sprDebug
		co.txts.insert(txt)
	endif

	//colog("coCreateText: " + s + ", txt=" + str(txt))
	
endfunction txt

//-----------------------------------------------------
//
function coLoadImage(s as string, file as string)

	local img as integer

	setfolder(LD_MEDIA_DIR)
	
	img = LoadImage(file)

	if co.sprDebug
		co.imgs.insert(img)
	endif

	//colog("coLoadImage: " + s + ", img=" + str(imf))
	
endfunction img

//-----------------------------------------------------
//
function coDeleteSprite(s as string, spr as integer)

	deletesprite(spr)

	if co.sprDebug
		
		local i as integer
		
		for i = 0 to co.sprs.length

			if co.sprs[i] = spr
				
				co.sprs.remove(i)
				co.sprnames.remove(i)
				spr = 0
				exit

			endif
			
		next

		if spr
			colog("coDeleteSprite: " + s + ", spr=" + str(spr) + ", was NOT allocated")
		endif

	endif
	
endfunction

//-----------------------------------------------------
//
function coDeleteText(s as string, txt as integer)

	deletetext(txt)

	if co.sprDebug
		
		local i as integer
		
		for i = 0 to co.txts.length

			if co.txts[i] = txt
				
				co.txts.remove(i)
				txt = 0
				exit

			endif
			
		next

		if txt
			colog("coDeleteText: " + s + ", txt=" + str(txt) + ", was NOT allocated")
		endif

	endif

endfunction

//-----------------------------------------------------
//
function coDeleteImage(s as string, img as integer)

	deleteimage(img)

	if co.sprDebug
		
		local i as integer
		
		for i = 0 to co.imgs.length

			if co.imgs[i] = img
				
				co.imgs.remove(i)
				img = 0
				exit

			endif
			
		next

		if img
			colog("coDeleteImage: " + s + ", img=" + str(img) + ", was NOT loaded")
		endif

	endif
	
endfunction

//-----------------------------------------------------
//
function coIsMobileDevice()

	local ret as integer
	
	ret = co.baseName = "ios" or co.baseName = "android"

endfunction ret

//-----------------------------------------------------
// Replace \ + a char with the char they represent, e.g.
// \n with be replaced with nl
// \\ replaced with 1 single \.
//
function coReplaceTildes(s as string, nl as string)

	local pos as integer

	pos = FindString(s, "\")

	while pos

		inc pos // Skip the \.
		
		if mid(s, pos, 1) = "\"			
			s = mid(s, 1, pos - 1) + mid(s, pos + 1, -1) // Remove the extra slash.
		elseif mid(s, pos, 1) = "n"
			s = mid(s, 1, pos - 2) + chr(10) + mid(s, pos + 1, -1) // Replace /n with chr(10).
		endif

		pos = findstring(s, "\", false, pos)
		
	endwhile

endfunction s

//-----------------------------------------------------
// Replace newlines with \c as follows.
// newline (chr(10)) with be replaced with \n
// \ replaced with two \\ backslashes.
//
function coReplaceNewlines(s as string)

	s = replacestring(s, "\", "\\", -1)
	s = ReplaceString(s, chr(10), "\n", -1)

endfunction s

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
function coCopyMediaFile(src as string, dest as string)

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
// Copy a file.
//
function coCopyTextFile(src as string, dest as string)

	local inId as integer
	local outId as integer
	local ret as integer
	local s as string

	ret = false
	inId = OpenToRead(src)
	outId = OpenToWrite(dest)		

	if inId and outId

		while not FileEOF(inId)

			s = ReadLine(inId)
			WriteLine(outId, s)

		endwhile

		closefile(inId)
		closefile(outId)

		ret = true
		
	endif

endfunction ret

//-----------------------------------------------------
// Copy a folder.
//
function coGetFiles(folder as string, files ref as string[])

	local origFolder as string
	local file as string
	
	origFolder = GetFolder()
	
	if SetFolder(folder)

		file = GetFirstFile()

		while file <> ""

			if left(file, 1) <> "."
				files.insert(folder + "/" + file)
			endif
						
			file = GetNextFile()

		endwhile

		setfolder("/" + origFolder)
		
	endif

endfunction

//-----------------------------------------------------
// join a list.
//
function coJoinList(toks ref as string[], d as string)

	local ret as string
	local i as integer
	
	for i = 0 to toks.length
		
		if i > 0 then ret = ret + d
		ret = ret + toks[i]
		
	next 
	
endfunction ret

//-----------------------------------------------------
// Split a string by 'd'elim.
// Returns a string[]/
//
function coSplitString(toks ref as string[], s as string, d as string)

/*
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
*/

	local i as integer
	local count as integer
	local t as string 
	
	count = CountStringTokens(s, d)
	
	for i = 1 to count
		
		t = GetStringToken(s, d, i)
		toks.insert(t)
		
	next 
		
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
// Create a mem block that can be referenced inside another memblock.
//
function coMemCreateRef(w as integer, h as integer)

	local idx as integer

	if co.freeMems.length >= 0
		
		idx = co.freeMems[0]
		co.freeMems.remove(0)

	else
		
		local mb as MemBlock
		co.mems.insert(mb)
		idx = co.mems.length

	endif

	coMemDelete(co.mems[idx])
	
	co.mems[idx].idx = idx
	co.mems[idx].w = w
	co.mems[idx].h = h
	co.mems[idx].offMax = 12 + (w * h * 4)
	coMemResetBounds(co.mems[idx])

	co.mems[idx].id = CreateMemblock(co.mems[idx].offMax)
	
endfunction idx

//-----------------------------------------------------
// Create a mem block ref from a memblock object.
//
function coMemCopyToRef(fromMb ref as MemBlock)

	local idx as integer

	if co.freeMems.length >= 0
		
		idx = co.freeMems[0]
		co.freeMems.remove(0)

	else
		
		local mb as MemBlock
		co.mems.insert(mb)
		idx = co.mems.length

	endif

	co.mems[idx].copy = true
	co.mems[idx].idx = idx
	co.mems[idx].deleted = fromMb.deleted
	co.mems[idx].id = fromMb.id
	co.mems[idx].w = fromMb.w
	co.mems[idx].h = fromMb.h
	co.mems[idx].offMax = fromMb.offMax
	co.mems[idx].blend = fromMb.blend
	co.mems[idx].line = fromMb.line
	co.mems[idx].lineCol = fromMb.lineCol
	co.mems[idx].lineSize = fromMb.lineSize
	co.mems[idx].lineStyle = fromMb.lineStyle
	co.mems[idx].lasso = fromMb.lasso
	co.mems[idx].sel = fromMb.sel
	co.mems[idx].fill = fromMb.fill
	co.mems[idx].mask = fromMb.mask
	co.mems[idx].undo = fromMb.undo
	co.mems[idx].undoGrp = fromMb.undoGrp
	co.mems[idx].pixels.length = fromMb.pixels.length
	co.mems[idx].pixCount = fromMb.pixCount
	co.mems[idx].stack.length = fromMb.stack.length
	co.mems[idx].snap = fromMb.snap
	
endfunction idx

//-----------------------------------------------------
// Delete a memblock.
//
function coMemDeleteRef(idx as integer)

	if not co.mems[idx].deleted

		coMemDelete(co.mems[idx])				
		co.mems[idx].deleted = True
		co.freeMems.insert(idx)

	endif

endfunction

//-----------------------------------------------------
// Convert an image to a mb.
//
Function coMemFromImage(img as integer, mb ref as MemBlock)

	coMemDelete(mb)
	
	mb.id = CreateMemblockFromImage(img)
	mb.w = GetImageWidth(img)
	mb.h = GetImageHeight(img)
	mb.offMax = 12 + (mb.w * mb.h * 4)
	coMemResetBounds(mb)
	
endfunction

//-----------------------------------------------------
// Resize the passed image (assume to be at scale 1.0) up to s.
//
Function coResizeImageUp(img as integer, s as integer)

	if false

		SetImageMagFilter(img, 0)
		SetImageMinFilter(img, 0)
		ResizeImage(img, GetImageWidth(img) * s, GetImageHeight(img) * s)
						
	else

		local srcMb as MemBlock
		local destMb as MemBlock

		if s > 1.0

			coMemFromImage(img, srcMb)
			deleteimage(img)
			coMemResizeUp(srcMb, destMb, s)
			img = coMemToImage(destMb)
			coMemDelete(srcMb)
			coMemDelete(destMb)

		endif

	endif
	
endfunction img

//-----------------------------------------------------
// Resize the passed image (assume to be at scale s) down to 1.0.
//
Function coResizeImageDown(img as integer, s as integer)

	if false
		
		SetImageMagFilter(img, 0)
		SetImageMinFilter(img, 0)
		ResizeImage(img, GetImageWidth(img) / s, GetImageHeight(img) / s)

	else
		
		local srcMb as MemBlock
		local destMb as MemBlock

		if s > 1.0
			
			coMemFromImage(img, srcMb)
			deleteimage(img)
			coMemResizeDown(srcMb, destMb, s)
			img = coMemToImage(destMb)
			coMemDelete(srcMb)
			coMemDelete(destMb)

		endif

	endif

endfunction img

//-----------------------------------------------------
// Init a memblock after a create. Don't call directly.
//
Function coMemInit(mb ref as MemBlock)
	
	mb.deleted = false
	mb.id = 0
	mb.w = 0
	mb.h = 0
	mb.offMax = 0
	mb.idx = -1
	mb.blend = true
	mb.line = 0
	mb.lineCol = 0
	mb.lineSize = 0
	mb.lineStyle = 0
	mb.lasso = 0
	mb.sel = 0
	mb.fill = 0
	mb.mask = false
	mb.undo = false
	mb.undoGrp = 0
	mb.pixels.length = -1
	mb.pixCount = 0
	mb.stack.length = -1
	mb.snap = false
				
endfunction

//-----------------------------------------------------
// Convert an image to a mb.
//
Function coMemCreate(mb ref as MemBlock, w as integer, h as integer)

	//local count as integer
	local destOff as integer
	
	coMemDelete(mb)
	
	mb.w = w
	mb.h = h
	mb.offMax = 12 + (mb.w * mb.h * 4)
	coMemResetBounds(mb)

	mb.id = CreateMemblock(mb.offMax)

	// Save the dest size.
	destOff = 0
	SetMemblockInt(mb.id, destOff, mb.w)	
	destOff = destOff + 4	
	SetMemblockInt(mb.id, destOff, mb.h)	
	destOff = destOff + 4
	SetMemblockInt(mb.id, destOff, 32) // Depth.
	
endfunction

//-----------------------------------------------------
// Get the width from inside the mem block.
//
Function coMemGetWidth(mb as integer)

	local w as integer
	
	//w = getmemblockint(mb, 0)
	w = co.mems[mb].w
	
endfunction w

//-----------------------------------------------------
// Get the height from inside the mem block.
//
Function coMemGetHeight(mb as integer)

	local h as integer
	
	//h = getmemblockint(mb, 4)
	h = co.mems[mb].h
	
endfunction h

//-----------------------------------------------------
// Convert a mb to an image.
//
Function coMemToImage(mb ref as MemBlock)

	local img as integer
	
	img = CreateImageFromMemblock(mb.id)
	
endfunction img

//-----------------------------------------------------
// Convert a mb to an image.
//
Function coMemInToImage(mb ref as MemBlock, img as integer)
	
	CreateImageFromMemblock(img, mb.id)
	
endfunction

//-----------------------------------------------------
// Convert an image to a mb.
//
Function coMemResizeUp(srcMb ref as MemBlock, destMb ref as MemBlock, s as integer)

	local srcOff as integer
	local destOff as integer
	local firstDestOff as integer
	local x as integer
	local y as integer
	local xx as integer
	local yy as integer
	local pix as integer
	local size as integer

	coMemCreate(destMb, srcMb.w * s, srcMb.h * s)

	srcOff = coMemOffset(srcMb, 0, 0)
	size = destMb.w * 4 // For copying first row to subsequent roles.

	for y = 0 to srcMb.h - 1

		destOff = coMemOffset(destMb, 0, y * s)
		firstDestOff = destOff

		coProgressStep()
		
		for x = 0 to srcMb.w - 1

			pix = GetMemblockInt(srcMb.id, srcOff)
			srcOff = srcOff + 4

			// Draw s pix's into the destMb.
			for xx = 1 to s
				
				SetMemblockInt(destMb.id, destOff, pix)
				destOff = destOff + 4

			next
						 
		next

		// Copy the lines down to speed it up.
		for yy = 2 to s
			
			CopyMemblock(destMb.id, destMb.id, firstDestOff, destOff, size)
			destOff = destOff + size
			
		next
		
	next

endfunction

//-----------------------------------------------------
// Convert an image to a mb.
//
Function coMemResizeDown(srcMb ref as MemBlock, destMb ref as MemBlock, s as integer)

	local srcOff as integer
	local destOff as integer
	local x as integer
	local y as integer
	local z as integer
	local pix as integer

	coMemCreate(destMb, srcMb.w / s, srcMb.h / s)

	for y = 0 to srcMb.h - 1

		srcOff = coMemOffset(srcMb, 0, y * s)
		destOff = coMemOffset(destMb, 0, y)

		coProgressStep()
		
		for x = 0 to srcMb.w - 1

			pix = GetMemblockInt(srcMb.id, srcOff)
			srcOff = srcOff + (4 * s)
			SetMemblockInt(destMb.id, destOff, pix)
			destOff = destOff + 4
						 
		next
		
	next

endfunction

//-----------------------------------------------------
// Extract a rect from  an image to a mb.
//
Function coMemGrab(srcMb ref as MemBlock, destMb ref as MemBlock, sx as integer, sy as integer, sw as integer, sh as integer)

	local srcOff as integer
	local destOff as integer
	local size as integer
	local pix as integer
	local xx as integer
	local yy as integer

	// Nothing to grab.
	if sx >= srcMb.w or sy >= srcMb.h
		
		coMemCreate(destMb, 0, 0)
		exitfunction

	endif

	if sx < 0		
		sx = 0
	endif
	
	if sx + sw > srcMb.w
		sw = srcMb.w - sx
	endif

	if sy < 0
		sy = 0
	endif
	
	if sy + sh > srcMb.h
		sh = srcMb.h - sy
	endif
	
	coMemCreate(destMb, sw, sh)

	size = sw * 4
	destOff = coMemOffset(destMb, 0, 0)

	for yy = 0 to sh - 1

		srcOff = coMemOffset(srcMb, sx, yy + sy)
		CopyMemblock(srcMb.id, destMb.id, srcOff, destOff, size)
		destOff = destOff + size
		
	next
			
endfunction

//-----------------------------------------------------
// Draw a rect section of the memblock.
//
Function coMemClear(mb ref as MemBlock)

	local off as integer
	//local size as integer
	local i as integer

	//size = coMemSize(mb)
	off = coMemOffset(mb, 0, 0)

	//for i = off to size step 4		
	for i = off to mb.offMax - 1 step 4		
		SetMemblockInt(mb.id, i, 0)
	next
	
	mb.pixels.length = -1

endfunction

//-----------------------------------------------------
// Fast paste from one memblock to another.
// Assumes memblocks are the same.
//
Function coMemPasteFast(srcMb ref as MemBlock, destMb ref as MemBlock)

	local off as integer
	local pix as integer
	//local size as integer
	local i as integer

	//size = coMemSize(srcMb)
	off = coMemOffset(srcMb, 0, 0)

	//for i = off to size step 4	
	for i = off to srcMb.offMax - 1 step 4	
		
		pix = getmemblockint(srcMb.id, i)	
		SetMemblockInt(destMb.id, i, pix)
		
	next

endfunction

//-----------------------------------------------------
// Paste srcMb to destMb at destination dx, dy
//
Function coMemPaste(srcMb ref as MemBlock, destMb ref as MemBlock, dx as integer, dy as integer)

	local pix as integer
	local x as integer
	local y as integer
	local xx as integer
	local yy as integer
	local sx as integer
	local sy as integer
	local sw as integer
	local sh as integer

	if dx + srcMb.w < 0 or dy + srcMb.h < 0 or dx >= destMb.w or dy >= destMb.h
		exitfunction
	endif

	sx = 0
	sy = 0
	sw = srcMb.w
	sh = srcMb.h

	if dx < 0
		
		sx = sx - dx
		sw = sw + dx
		dx = 0
		
	endif
	
	if dy < 0
		
		sy = sy - dy
		sh = sh + dy
		dy = 0
		
	endif
	
	if dx + sw > destMb.w
		sw = sw - ((dx + sw) - destMb.w)
	endif

	if dy + sh > destMb.h
		sh = sh - ((dy + sh) - destMb.h)
	endif

	yy = dy
	
	for y = sy to sh - 1
		
		xx = dx
		
		for x = sx to sw - 1

			//pix = coMemGetPoint(srcMb, x, y)
			pix = coMemGetPointFast(srcMb, x, y)
			//coMemSetPoint(destMb, xx, yy, pix)			
			coMemSetPointFast(destMb, xx, yy, pix)			
			
			inc xx
			 
		next
		
		inc yy
		
	next
	
endfunction

//-----------------------------------------------------
// Undo the last grp.
//
Function coMemUndoPixels(mb ref as MemBlock)
	
	local plen as integer
	local i as integer
	local grp as integer
	
	i = mb.pixels.length
	
	if i > -1
		grp = mb.pixels[i].grp
	endif
	
	while i >= 0
		
		if mb.pixels[i].grp <> grp
			exit
		endif
		
		coMemSetPointByOffset(mb, mb.pixels[i].off, mb.pixels[i].col)
		
		mb.pixels.remove(i)
		dec i
		
	endwhile
		
endfunction

//-----------------------------------------------------
// Move (append) the last group of pixels from mb to the passed list.
// If all = true, then all pixels are moved, otherwise just the last group.
//
Function coMemMovePixels(mb ref as MemBlock, list ref as Pixel[], all as integer)
	
	local plen as integer
	local i as integer
	local grp as integer
	
	i = mb.pixels.length
	
	if i > -1
		grp = mb.pixels[i].grp
	endif
	
	while i >= 0
		
		if not all and mb.pixels[i].grp <> grp
			exit
		endif
		
		list.insert(mb.pixels[i])
		
		mb.pixels.remove(i)
		dec i
		
	endwhile
		
endfunction

//-----------------------------------------------------
// Copy (append) the pixels in the list to the mb undo list.
//
Function coMemCopyPixels(list ref as Pixel[], mb ref as MemBlock)

	local i as integer
	
	for i = 0 to list.length
		mb.pixels.insert(list[i])								
	next
	
endfunction

//-----------------------------------------------------
// Apply the pixels list from srcMb to destMb
// If colMode = CO_COL_CLEAR, then the pixels are cleared in destMb. Use for erase.
//
Function coMemApplyPixels(srcMb ref as MemBlock, destMb ref as MemBlock, colMode as integer)

	local pix as integer
	local i as integer
	local plen as integer

	plen = srcMb.pixels.length

	if colMode && CO_COL_CLEAR
		
		for i = 0 to plen									
			coMemSetPointByOffset(destMb, srcMb.pixels[i].off, 0)
		next

	else
		
		for i = 0 to plen									
			coMemSetPointByOffset(destMb, srcMb.pixels[i].off, srcMb.pixels[i].col)
		next
		
	endif
	
endfunction

//-----------------------------------------------------
// Paste all pixels in srcMb but checking mode.
// Slower that normal paste.
// CO_COL_EQ means paste where srcMb pix = col
// CO_COL_NE means paste where srcMb pix <> col
// CO_COL_CLEAR_MATCH means clear destMb pixels if above match, instead of the srcMb pixel.
// CO_COL_CLEAR_NO_MATCH means clear destMb pixels if no match above, instead of srcMb pixel.
// CO_COL_FILL_MASK means uses the fill mask to match the above, rather that the srcMb.
// Anything else, nothing happens.
//
Function coMemPasteMask(srcMb ref as MemBlock, destMb ref as MemBlock, dx as integer, dy as integer, colMode as integer, col as integer)

	local pix as integer
	local x as integer
	local y as integer
	local xx as integer
	local yy as integer
	//local fill as MemBlock
	local clear as integer
	local clearOpp as integer
	local mpix as integer
	local mode as integer

	if dx + srcMb.w < 0 or dy + srcMb.h < 0 or dx >= destMb.w or dy >= destMb.h
		exitfunction
	endif
/*
	if (colMode && CO_COL_FILL_MASK) and destMb.fill
	
		fill.id = destMb.fill
		fill.w = destMb.w
		fill.h = destMb.h

	else
		
		fill.id = 0 // No mask.

	endif
*/

	if colMode && CO_COL_CLEAR
		clear = true
	else
		clear = false
	endif

	if colMode && CO_COL_CLEAR_NO_MATCH
		clearOpp = true
	else
		clearOpp = false
	endif

	mode = (colMode && (CO_COL_EQ || CO_COL_NE))

	yy = dy
	
	for y = 0 to srcMb.h - 1
		
		xx = dx
		
		for x = 0 to srcMb.w - 1

			pix = coMemGetPoint(srcMb, x, y)

			//if fill.id
			if destMb.fill

				//mpix = coMemGetPoint(fill, x, y)
				mpix = coMemGetPoint(co.mems[destMb.fill], x, y)
								
				if mode = CO_COL_EQ
					if mpix = col
						if clear
							coMemSetPoint(destMb, xx, yy, 0)	
						else
							coMemSetPoint(destMb, xx, yy, pix)	
						endif
					elseif clearOpp
						coMemSetPoint(destMb, xx, yy, 0)	
					endif
				elseif mode = CO_COL_NE
					if mpix <> col
						if clear
							coMemSetPoint(destMb, xx, yy, 0)	
						else
							coMemSetPoint(destMb, xx, yy, pix)	
						endif
					elseif clearOpp
						coMemSetPoint(destMb, xx, yy, 0)	
					endif
				endif
		
			else
								
				if mode = CO_COL_EQ
					if pix = col
						if clear
							coMemSetPoint(destMb, xx, yy, 0)	
						else
							coMemSetPoint(destMb, xx, yy, pix)	
						endif	
					elseif clearOpp
						coMemSetPoint(destMb, xx, yy, 0)	
					endif
				elseif mode = CO_COL_NE
					if pix <> col
						if clear
							coMemSetPoint(destMb, xx, yy, 0)	
						else
							coMemSetPoint(destMb, xx, yy, pix)		
						endif	
					elseif clearOpp
						coMemSetPoint(destMb, xx, yy, 0)	
					endif
				endif
				
			endif
			
			inc xx
			 
		next
		
		inc yy
		
	next
	
endfunction

//-----------------------------------------------------
// Paste all pixels in srcMb but checking mode.
// Slower that normal paste.
// Paste where srcMb pix <> 0
//
Function coMemPasteNez(srcMb ref as MemBlock, destMb ref as MemBlock, dx as integer, dy as integer)

	local pix as integer
	local x as integer
	local y as integer
	local xx as integer
	local yy as integer
	local mpix as integer
	local sx as integer
	local sy as integer
	local sw as integer
	local sh as integer

	if dx + srcMb.w < 0 or dy + srcMb.h < 0 or dx >= destMb.w or dy >= destMb.h
		exitfunction
	endif
	
	sx = 0
	sy = 0
	sw = srcMb.w
	sh = srcMb.h

	if dx < 0
		
		sx = sx - dx
		sw = sw + dx
		dx = 0
		
	endif
	
	if dy < 0
		
		sy = sy - dy
		sh = sh + dy
		dy = 0
		
	endif
	
	if dx + sw > destMb.w
		sw = sw - ((dx + sw) - destMb.w)
	endif

	if dy + sh > destMb.h
		sh = sh - ((dy + sh) - destMb.h)
	endif

	yy = dy
		
	for y = sy to sy + sh - 1
		
		xx = dx
		
		for x = sx to sx + sw - 1

			//pix = coMemGetPoint(srcMb, x, y)
			pix = coMemGetPointFast(srcMb, x, y)
								
			if pix <> 0
				//coMemSetPoint(destMb, xx, yy, pix)		
				coMemSetPointFast(destMb, xx, yy, pix)		
			endif
			
			inc xx
			 
		next
		
		inc yy
		
	next
	
endfunction

//-----------------------------------------------------
// Get the bounds of used pixels in the passed memblock.
//
Function coMemGetBounds(mb ref as MemBlock, bounds ref as Bounds)

	local x as integer
	local y as integer
	local pix as integer
	
	bounds.x0 = 0xffffff
	bounds.y0 = 0xffffff
	bounds.x1 = -1
	bounds.y1 = -1
	
	for y = 0 to mb.h - 1
				
		for x = 0 to mb.w - 1

			pix = coMemGetPoint(mb, x, y)
			
			if pix <> 0 and x < bounds.x0
					
				bounds.x0 = x
				exit
				
			endif
			 
		next

		for x = mb.w - 1 to 0 step -1

			pix = coMemGetPoint(mb, x, y)
			
			if pix <> 0 and x > bounds.x1
					
				bounds.x1 = x
				exit
				
			endif
			 
		next
		
	next

	for x = 0 to mb.w - 1
				
		for y = 0 to mb.h - 1

			pix = coMemGetPoint(mb, x, y)
			
			if pix <> 0 and y < bounds.y0
					
				bounds.y0 = y
				exit
				
			endif
			 
		next

		for y = mb.h - 1 to 0 step -1

			pix = coMemGetPoint(mb, x, y)
			
			if pix <> 0 and y > bounds.y1
					
				bounds.y1 = y
				exit
				
			endif
			 
		next
		
	next
	
	if bounds.x0 = 0xffffff then bounds.x0 = 0
	if bounds.y0 = 0xffffff then bounds.y0 = 0
	if bounds.x1 = -1 then bounds.x1 = mb.w - 1
	if bounds.y1 = -1 then bounds.y1 = mb.h - 1
	
endfunction

//-----------------------------------------------------
// Extract pixels from src to dest, based on sel. destMb is (re)created.
// bounds is the area of the srcMb to consider, typically the bounds of srcMb
// selMb specifies the pixels to grab with bounds from srcMb. 
// If supplied must be same size as srcMb. To not supply a selMb, make the selMb.id = 0
// cut is true or false.
// destMb is where to put the cut.
// Anything else, nothing happens.
//
Function coMemExtract(srcMb ref as MemBlock, bounds ref as Bounds, selMb ref as MemBlock, destMb ref as MemBlock, cut as integer)

	local sel as integer
	local src as integer
	local x as integer
	local y as integer
	local dx as integer
	local dy as integer
	//local bounds as Bounds
	local blend as integer

	if not srcMb.id // or not selMb.id
		exitfunction
	endif
	
	// All memblocks need to be the same.
	if selMb.id
		if srcMb.w <> selMb.w or srcMb.h <> selMb.h
			exitfunction
		endif
	endif

	coMemDelete(destMb)
	
	//if selMode
		
		//coMemGetBounds(selMb, bounds)
		coMemCreate(destMb, bounds.x1 - bounds.x0 + 1, bounds.y1 - bounds.y0 + 1)
		
	//else

	//	coMemCreate(destMb, srcMb.w, srcMb.h)
	//	bounds.x0 = 0
	//	bounds.y0 = 0
	//	bounds.x1 = srcMb.w - 1
	//	bounds.y1 = srcMb.h - 1
		
	//endif
	
	coMemSetBlend(destMb, false)
	coMemClear(destMb)
	
	if cut		
		blend = coMemSetBlend(srcMb, false)		
	endif
			
	dy = 0
	
	for y = bounds.y0 to bounds.y1
		
		dx = 0
				
		for x = bounds.x0 to bounds.x1

			if selMb.id
				sel = coMemGetPoint(selMb, x, y)
			else 
				sel = 1 // Hack.
			endif
			
			if sel > 0
				
				src = coMemGetPoint(srcMb, x, y)
				coMemSetPoint(destMb, dx, dy, src)			
	
				if cut
					coMemSetPoint(srcMb, x, y, 0)
				endif
				
			endif
			
			inc dx
			 
		next
		
		inc dy
		
	next

	if cut	
		coMemSetBlend(srcMb, blend)
	endif
	
endfunction

//-----------------------------------------------------
// Turn on or off snapping of pixels to edge of memblock, i.e. not ignore.
//
Function coMemSnapPixels(mb ref as MemBlock, snap as integer)

	local oldSnap as integer
	
	oldSnap = mb.snap
	mb.snap = snap
	
endfunction oldSnap

//-----------------------------------------------------
// Turn on or off the blend mode.
//
Function coMemSetBlend(mb ref as MemBlock, blend as integer)

	local oldBlend as integer
	
	oldBlend = mb.blend
	mb.blend = blend
	
endfunction oldBlend

//-----------------------------------------------------
// Remove the selection. Does not affect the selection memblock.
//
Function coMemRemoveSel(mb ref as MemBlock)

	local oldSel as integer
	
	oldSel = mb.sel
	
	if mb.sel
		
		coMemDeleteRef(mb.sel)
		mb.sel = 0
		
	endif
	
endfunction oldSel

//-----------------------------------------------------
// Hold a selection for the next operation.
// Returns the original sel if the sel is valid, otherwise -1.
//
Function coMemSetSel(mb ref as MemBlock, sel ref as MemBlock)

	local oldSel as integer
	
	if sel.w = mb.w and sel.h = mb.h
		
		oldSel = mb.sel
		
		if mb.sel
			
			coMemDeleteRef(mb.sel)
			//mb.sel = sel.id
			mb.sel = coMemCopyToRef(sel)
			
		endif
		
	else
		
		oldSel = 0
		
	endif
	
endfunction oldSel

//-----------------------------------------------------
// Remove the fill mask.
//
Function coMemRemoveFill(mb ref as MemBlock)

	if mb.fill
		
		coMemDeleteRef(mb.fill)
		mb.fill = 0
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the mask for filling. That is, the mb sent to coMemSetFill
// is where the fill will occur. However, if this is set, then
// this mask will be used as official destimation, i.e. it will be
// checked for the fill, but the actual fill will occur in mb.
// This allow creating a filled work area for saving as an undo.
// Returns the old mask, or -1 if the mask didn't match size of mb.
//
Function coMemSetFill(mb ref as MemBlock, fill ref as MemBlock)

	local oldFill as integer
	
	if fill.w = mb.w and fill.h = mb.h
		
		oldFill = mb.fill
		//mb.fill = fill.id
		mb.fill = coMemCopyToRef(fill)
		
	else
		
		oldFill = -1
		
	endif
	
endfunction oldFill

//-----------------------------------------------------
// Blend the foreground with the background.
//
Function coMemBlendPix(fg as integer, bg as integer)

	local af as float
	local a2f as float
	local iaf as float
	local rf as float
	local gf as float
	local bf as float
	local oaf as float
	local pix as integer
	local afg as float
	local abg as float
	local r as integer
	local g as integer
	local b as integer

	af = coGetColorAlpha(fg) / 255.0
	a2f = coGetColorAlpha(bg) / 255.0
	oaf = 1 - ((1 - af) * (1 - a2f))
	afg = af / oaf
	abg = 1 - afg	
	r = (afg * (getcolorred(fg) / 255.0) + abg * (getcolorred(bg) / 255.0)) * 255
	g = (afg * (getcolorgreen(fg) / 255.0) + abg * (getcolorgreen(bg) / 255.0)) * 255
	b = (afg * (getcolorblue(fg) / 255.0) + abg * (getcolorblue(bg) / 255.0)) * 255
	pix = makecolor(r, g, b)
	pix = coSetColorAlpha(pix, oaf * 255)

/*
	local sa as float
	local da as float
	local da2 as float
	local oa as float
	local r as integer
	local g as integer
	local b as integer
	local pix as integer
	
	sa = coGetColorAlpha(fg) / 255.0
	da = coGetColorAlpha(bg) / 255.0
	da2 = da * (1.0 - sa)
	oa = sa + da2	
	r = (((getcolorred(fg) / 255.0) * sa + (getcolorred(bg) / 255.0) * da2) / oa) * 255
	g = (((getcolorgreen(fg) / 255.0) * sa + (getcolorgreen(bg) / 255.0) * da2) / oa) * 255
	b = (((getcolorblue(fg) / 255.0) * sa + (getcolorblue(bg) / 255.0) * da2) / oa) * 255
	pix = makecolor(r, g, b)
	pix = coSetColorAlpha(pix, oa * 255)
*/
	
endfunction pix

//-----------------------------------------------------
// Paste srcMb to destMb at x,y, but not Col
// SLower.
//
Function coMemReplaceColor(mb ref as MemBlock, fromCol as integer, toCol as integer)

	local off as integer
	local col as integer
	//local size as integer
	local i as integer

	//size = coMemSize(mb)
	off = coMemOffset(mb, 0, 0)

	//for i = off to size step 4
	for i = off to mb.offMax - 1 step 4
		
		col = GetMemblockInt(mb.id, i)

		if col = fromCol
			
			SetMemblockInt(mb.id, i, toCol)	
			coMemSavePixelByOffset(mb, i, toCol)
								
		endif

	next
		
endfunction

//-----------------------------------------------------
// Fast paste of the srcMb rect to a destMb mostly used for internal
// requirements, e.g. drawing a thick line quickly.
//
function coMemPasteRectMask(srcMb ref as MemBlock, sx as integer, sy as integer, sw as integer, sh as integer, destMb ref as MemBlock, dx as integer, dy as integer, mode as integer, col as integer)

	local x as integer
	local y as integer
	local xx as integer
	local yy as integer
	local pix as integer
	local x1 as integer
	local y1 as integer
	
	x1 = sx + sw - 1
	y1 = sy + sh - 1
	yy = dy
		
	for y = sy to y1
			
		xx = dx
			
		for x = sx to x1

			pix = coMemGetPoint(srcMb, x, y)

			if mode = CO_COL_EQ
				if pix = col
					coMemSetPoint(destMb, xx, yy, pix)			
				endif
			elseif mode = CO_COL_NE
				if pix <> col
					coMemSetPoint(destMb, xx, yy, pix)			
				endif
			else
				coMemSetPoint(destMb, xx, yy, pix)			
			endif
			
			inc xx
			 
		next
		
		inc yy
		
	next

endfunction

//-----------------------------------------------------
// Prep a line draw with a size > 1
// size >= 1
//
Function coMemPrepDrawLine(mb ref as MemBlock, col as integer, size as integer, style as integer)

	local w as integer
	local h as integer
	local a as integer
					
	if not mb.line or col <> mb.lineCol or size <> mb.lineSize or style <> mb.lineStyle
	
		if style >= CO_LINE_POLY
			
			w = coGetPointX(size)
			h = coGetPointY(size)
			
			if w < 2 and h < 2
				exitfunction false
			endif
		else 

			if size < 2
				exitfunction false
			endif
						
			w = size
			h = size
									
		endif
					
		// Create a tmp mem area for drawing circles. If already exists, we need to change.
		if mb.line
							
			coMemDeleteRef(mb.line)
			mb.line = 0
				
		endif
		
		if not mb.line
			mb.line = coMemCreateRef(w + 1, h + 1)												
			//mb.line = coMemCreateRef(w, h)												
		endif
							
		coMemClear(co.mems[mb.line])
		coMemSetBlend(co.mems[mb.line], false)
		
		if style = CO_LINE_CIRC
			coMemDrawOvalWH(co.mems[mb.line], 0, 0, w, h, col, 0)
		elseif style = CO_LINE_SQR
			coMemDrawRectWH(co.mems[mb.line], 0, 0, w, h, col, 0)
		else // Poly sides.
			if w > 20
				a = a
			endif
			coMemDrawPolyWH(co.mems[mb.line], 0, 0, w, h, style, col, 0)
		endif
	
		//mb.line = tmp.id
		mb.lineCol = col
		mb.lineSize = size
		mb.lineStyle = style
					
	endif
	
endfunction true

//-----------------------------------------------------
// Show if there are colors in the block by showing X where there is > 0, otherwise space.
//
function coMemDebugBlock(mb ref as MemBlock, w as integer, h as integer)
	
	local x as integer
	local y as integer
	local s as string
	
	for y = 0 to h - 1
		
		s = "y=" + str(y) + ": "
		
		for x = 0 to w - 1		
			if coMemGetPoint(mb, x, y) <> 0
				s = s + "X"
			else
				s = s + " "
			endif
		next
		
		colog(s)
		
	next

endfunction

//-----------------------------------------------------
// Bresenham line algorithm
// size >= 1
//
Function coMemDrawLine2(mb ref as MemBlock, x0 as integer, y0 as integer, x1 as integer, y1 as integer, col as integer, size as integer, style as integer)

	Local dx as integer
	Local dy as integer
	Local sx as integer
	Local sy as integer
	local t as integer
	local s2 as integer
	local w2 as integer
	local h2 as integer
	local paste as integer
	local w as integer
	local h as integer
	local ratio as float
	local pixelStep as integer
	local maxDistance as integer
	local isAtStep as integer
	local x as integer
	local y as integer
	local i as integer

	//if size <= 0
	//	exitfunction
	//endif

	//if size > 1

		//if size > CO_MEM_TMP_SIZE
		//	size = CO_MEM_TMP_SIZE
		///endif
		
		paste = coMemPrepDrawLine(mb, col, size, style)			

	//endif

	if style >= CO_LINE_POLY
		
		w = coGetPointX(size)
		h = coGetPointY(size)
	
	else 

		w = size
		h = size
								
	endif

	//s2 = size / 2
	w2 = w / 2
	h2 = h / 2
			
	//var dx = Math.abs(x1 - x0) + 1;
	//var dy = Math.abs(y1 - y0) + 1;

	dx = Abs(x1 - x0) + 1
	dy = Abs(y1 - y0) + 1
		
	If x0 < x1 Then sx = 1 Else sx = -1
	If y0 < y1 Then sy = 1 Else sy = -1

	ratio = coMax(dx, dy) / coMin(dx, dy)
	// in pixel art, lines should use uniform number of pixels for each step
	pixelStep = round(ratio)
	
	if pixelStep > coMin(dx, dy)
		pixelStep = 999999999 // Infinity;
	endif
	
	//maxDistance = coDist(x0, x1, y0, y1)
	maxDistance = coDist(x0, y0, x1, y1)
	
	x = x0
	y = y0
	i = 0
	
	While True
			
		inc i

		//pixels.push({'col': x, 'row': y});
		if paste
			coMemPasteRectMask(co.mems[mb.line], 0, 0, w + 1, h + 1, mb, x0 - w2, y0 - h2, CO_COL_EQ, col)
		else
			coMemSetPoint(mb, x, y, col)
		endif

//colog("x=" + str(x) + ", y=" + str(y))				

		if coDist(x0, y0, x, y) >= maxDistance
			exit
		endif
		
		if mod(i, pixelStep) = 0
			isAtStep = true
		else 
			isAtStep = false
		endif
		
		if dx >= dy or isAtStep
			x = x + sx
		endif
		
		if dy >= dx or isAtStep
			y = y + sy
		endif

	endwhile
	
EndFunction

//-----------------------------------------------------
// Bresenham line algorithm
// size >= 1
//
Function coMemDrawLine(mb ref as MemBlock, x0 as integer, y0 as integer, x1 as integer, y1 as integer, col as integer, size as integer, style as integer)

	Local dx as integer
	Local dy as integer
	Local sx as integer
	Local sy as integer
	Local err as integer
	local e2 as integer
	local t as integer
	local s2 as integer
	local w2 as integer
	local h2 as integer
	local tmp as MemBlock
	local paste as integer
	local w as integer
	local h as integer

	paste = coMemPrepDrawLine(mb, col, size, style)			

	if style >= CO_LINE_POLY
		
		w = coGetPointX(size)
		h = coGetPointY(size)
	
	else 

		w = size
		h = size
								
	endif

	//s2 = size / 2
	w2 = w / 2
	h2 = h / 2
			
	dx = Abs(x1 - x0)
	dy = Abs(y1 - y0) 
	
	If x0 < x1 Then sx = 1 Else sx = -1
	If y0 < y1 Then sy = 1 Else sy = -1

	err = dx - dy
	
	While True
			
		if paste
			coMemPasteRectMask(co.mems[mb.line], 0, 0, w + 1, h + 1, mb, x0 - w2, y0 - h2, CO_COL_EQ, col)
			//coMemPasteRectMask(co.mems[mb.line], 0, 0, w, h, mb, x0 - w2, y0 - h2, CO_COL_EQ, col)
		else
			coMemSetPoint(mb, x0, y0, col)
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
// Create a image of trans squares w x h, using transColIdx color scheme (1-4).
// Returns an image.
//
function coCreateTransImg(tran as integer, w as integer, h as integer)

	local tmp as MemBlock
	local col1 as integer
	local col2 as integer
	local size as integer
	local i as integer
	local img as integer
	
	size = co.bs / 8

	if tran = 1
		
		col1 = co.white
		col2 = MakeColor(223, 223, 223)

	elseif tran = 2
		
		col1 = MakeColor(186, 186, 186)
		col2 = co.white

	elseif tran = 3
		
		col1 = MakeColor(219, 219, 219)
		col2 = MakeColor(213, 213, 213)

	else
		
		col1 = MakeColor(76, 76, 76)
		col2 = MakeColor(85, 85, 85)
		
	endif
	
	coMemCreate(tmp, w, h)				
	coMemFillTrans(tmp, size, size, col1, col2)

	img = coMemToImage(tmp)
	coMemDelete(tmp)

endfunction img

//-----------------------------------------------------
// Fill will transparency.
//
function coMemFillTrans(mb ref as MemBlock, tw as integer, th as integer, col1 as integer, col2 as integer)

	local srcOff as integer 
	local destOff as integer 
	local size as integer
	local col as integer
	local t as integer
	local i as integer
	local x as integer
	local y as integer
	local yy as integer
	local blend as integer
	
	blend = mb.blend
	mb.blend = false
	
	size = (mb.w * 4)
	y = 0
		
	while y < mb.h
		
		col = col1
		x = 0
		i = 0
		
		while x < mb.w

			coMemSetPoint(mb, x, y, col)

			inc i
			
			if i = tw

				if col = col1
					col = col2
				else
					col = col1
				endif
				
				i = 0
						
			endif
			
			inc x
						
		endwhile

		yy = y
		inc y
		i = 1
		
		while y < mb.h and i < th

			srcOff = coMemOffset(mb, 0, yy)
			destOff = coMemOffset(mb, 0, y)
			CopyMemblock(mb.id, mb.id, srcOff, destOff, size)
			inc y
			inc i
			
		endwhile
		
		t = col1
		col1 = col2
		col2 = t
		
	endwhile
	
	mb.blend = blend

endfunction

//-----------------------------------------------------
// Draw a grid.
// Mode = 0 = standard single line grid, CO_GRID_PAIR = two line pair.
//
Function coMemDrawGrid(mb ref as MemBlock, w as integer, h as integer, col as integer, mode as integer)

	local x as integer
	local y as integer
	local gx as integer
	local gy as integer
	
	gy = 0
	
	for y = 0 to mb.h - 1
			
		gx = 0
		
		for x = 0 to mb.w - 1
	
			if mode = CO_GRID_PAIR
				if gx < 2 or gy < 2
					coMemSetPoint(mb, x, y, col)
				endif
			else 					
				if gx = 0 or gy = 0
					coMemSetPoint(mb, x, y, col)
				endif
			endif
			
			inc gx
				
			if gx >= w
				gx = 0
			endif
	
		next		

		inc gy
				
		if gy >= h
			gy = 0
		endif
		
	next

endfunction

//-----------------------------------------------------
// Draw a rect section of the memblock.
// size<=0 for filled, otherwise rect thickness is size > 1
//
Function coMemDrawRect(mb ref as MemBlock, x0 as float, y0 as float, x1 as float, y1 as float, col as integer, size as integer)

	local t as float
	
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
	
	coMemDrawRectWH(mb, x0, y0, x1 - x0 + 1, y1 - y0 + 1, col, size)
		
endfunction

//-----------------------------------------------------
// Draw a rect section of the memblock.
// size<=0 for filled, otherwise rect thickness is size > 1
//
Function coMemDrawRectWH(mb ref as MemBlock, x as float, y as float, w as float, h as float, col as integer, size as integer)

	local off as integer
	local xx as float
	local yy as float

	if size > 0 and size < w / 2 and size < h / 2

		for yy = 0 to h - 1

			if yy < size or yy >= h - size
				
				for xx = 0 to w - 1						
					coMemSetPoint(mb, x + xx, y + yy, col)					 
				next

			else

				for xx = 0 to w - 1
					if xx < size or xx >= w - size						
						coMemSetPoint(mb, x + xx, y + yy, col)
					endif				
				next
				
			endif
			
		next

	else

		coMemDrawRectWHInt(mb, x, y, w, h, col)
		
	endif
	
endfunction

//-----------------------------------------------------
// Draw a rect internal.
//
Function coMemDrawRectWHInt(mb ref as MemBlock, x as float, y as float, w as float, h as float, col as integer)

	local xx as float
	local yy as float
				
	for yy = 0 to h - 1
		for xx = 0 to w - 1
			coMemSetPoint(mb, x + xx, y + yy, col)				 
		next		
	next
	
endfunction

//-----------------------------------------------------
// Apply an alpha to the area.
//
Function coMemApplyAlphaWH(mb ref as MemBlock, x as float, y as float, w as float, h as float, da as integer)

	local xx as float
	local yy as float
	local alpha as integer
	local pix as integer
				
	for yy = 0 to h - 1
		for xx = 0 to w - 1
			
			pix = coMemGetPoint(mb, x + xx, y + yy)
			alpha = coGetColorAlpha(pix)
			
			alpha = alpha + da
			
			if alpha < 0
				alpha = 0
			elseif alpha > 255
				alpha = 255
			endif
			
			pix = coSetColorAlpha(pix, alpha)
			coMemSetPoint(mb, x + xx, y + yy, pix)		
					 
		next		
	next
	
endfunction

//xxx drawing a oval is bad! Edges don't align properly.
//-----------------------------------------------------
// Draw a mem oval.
// size<=0 to fill, otherwise size > 1
//
function coMemDrawOval(mb ref as MemBlock, x0 as float, y0 as float, x1 as float, y1 as float, col as integer, size as integer)

	coMemDrawArc(mb, x0, y0, x1, y1, 0, 360, col, size)
	
endfunction

//-----------------------------------------------------
// Draw a mem oval.
// size<=0 to fill, otherwise size > 1
//
function coMemDrawOvalWH(mb ref as MemBlock, x as float, y as float, w as float, h as float, col as integer, size as integer)

	coMemDrawArcWH(mb, x, y, w, h, 0, 360, col, size)
	
endfunction

//-----------------------------------------------------
// Draw a mem arc.
// size<=0 to fill, otherwise size > 1
// ang=0 to 360, to create an arc.
//
function coMemDrawArc(mb ref as MemBlock, x0 as float, y0 as float, x1 as float, y1 as float, a1 as float, a2 as float, col as integer, size as integer)

	local t as float
	
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
	
	coMemDrawArcWH(mb, x0, y0, x1 - x0 + 1, y1 - y0 + 1, a1, a2, col, size)
		
endfunction

//-----------------------------------------------------
// Draw a mem oval.
// size<=0 to fill, otherwise size > 1
// ang=0 to 360, to create an arc.
// Returns the point at which the arc finished. For joining following curves.
//
function coMemDrawArcWH(mb ref as MemBlock, x as float, y as float, w as float, h as float, a1 as float, a2 as float, col as integer, size as integer)

	local w2 as float
	local h2 as float
	local wr as float
	local hr as float
	local a as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local i as integer
	local k as integer
	local b as integer
	local fill as integer
	local s2 as float
	local xx as float
	local yy as float
	local thickLine as integer
	
	thickLine = true
		
	w2 = w / 2
	if mod(w2, 2) = 0 then w2 = w2 - 0.5
	h2 = h / 2
	if mod(h2, 2) = 0 then h2 = h2 - 0.5
	wr = w2
	hr = h2
	fill = false
	b = 0

	//s2 = (size - 1) / 2
	s2 = (size / 2) //- 1
		
	if s2 < 1
		s2 = 1 // Need this to make sure the fill in the loop works.
	endif

	if not thickLine
					
		if size > 0	
			if size >= w2 or size >= h2 // Line size > w/h oval, don't draw second loop, just fill centre.
				fill = true						
			elseif size = 2			
				b = 1 // Need 2 loops, outer and inner.
			elseif size > 1			
				b = 2 // Need 3 loops, outer, inner, fill.
			endif				
		else		
			fill = true // Size is fill.		
		endif

		dec size

	else 
					
		b = 0

		if size >= w2 or size >= h2 // Line size > w/h oval, don't draw second loop, just fill centre.
			
			fill = true
			size = 1						

		elseif size = 0
			
			fill = true
			size = 1 // Ensure we draw a 1 pt line.
			
		else 
						
			// Make the oval smaller to cater for drawing lines at the pointer centre.
			wr = wr - s2
			hr = hr - s2
			
		endif
				
	endif
		
	if wr < 0 then wr = 0
	if hr < 0 then hr = 0
			
	for k = 0 to b
					
		i = 0
			
		for a = a1 to a2 step 5

			if k = 2 // Fill loop.
				
				//x1 = round(x + w2 + cos(a - 90.0) * (w2 - s2))
				//y1 = round(y + h2 + sin(a - 90.0) * (h2 - s2))
				x1 = x + w2 + cos(a - 90.0) * (w2 - s2)
				y1 = y + h2 + sin(a - 90.0) * (h2 - s2)
				coMemDrawFill(mb, x1, y1, col)		
				
			else
					
				//x1 = round(x + w2 + cos(a - 90.0) * wr)
				//y1 = round(y + h2 + sin(a - 90.0) * hr)
				x1 = x + w2 + cos(a - 90.0) * wr					
				y1 = y + h2 + sin(a - 90.0) * hr
						
				if i = 0
						
					xx = x1
					yy = y1
					
				else
						
					if thickLine //and not fill			
						coMemDrawLine(mb, x0, y0, x1, y1, col, size, CO_LINE_CIRC)
					else 
						coMemDrawLine(mb, x0, y0, x1, y1, col, 1, CO_LINE_CIRC)
					endif
										
				endif
									
				x0 = x1
				y0 = y1
				
			endif
					
			inc i
	
		next
		
		if k < 2
			if thickLine //and not fill
				coMemDrawLine(mb, x0, y0, xx, yy, col, size, CO_LINE_CIRC)
			else 
				coMemDrawLine(mb, x0, y0, xx, yy, col, 1, CO_LINE_CIRC)
			endif
		endif
									
		wr = wr - size
		hr = hr - size
		
	next
	
	if fill
		coMemDrawFill(mb, x + w2, y + h2, col)		
	endif
	
endfunction

//-----------------------------------------------------
// Draw a mem arc.
// size<=0 to fill, otherwise size > 1
// ang=0 to 360, to create an arc.
//
function coMemDrawPoly(mb ref as MemBlock, x0 as float, y0 as float, x1 as float, y1 as float, sides as integer, col as integer, size as integer)

	local t as float
	
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

	//colog("x0=" + str(x0) + ", y0=" + str(y0) + ", x1=" + str(x1) + ", y1=" + str(y1))
		
	coMemDrawPolyWH(mb, x0, y0, x1 - x0 + 1, y1 - y0 + 1, sides, col, size)
		
endfunction

//-----------------------------------------------------
// Draw a mem polygon.
// size<=0 to fill, otherwise size > 1
// sides between 3 and 20.
//
function coMemDrawPolyWH(mb ref as MemBlock, x as float, y as float, w as float, h as float, sides as integer, col as integer, size as integer)

	local w2 as float
	local h2 as float
	local wr as float
	local hr as float
	local a as float
	local x0 as float
	local y0 as float
	local x1 as float
	local x2 as float
	local x3 as float
	local y1 as float
	local i as integer
	local k as integer
	local fill as integer
	local da as float
	local s as integer
	local ww as float
	local hh as float
	local dw as float
	local dh as float
	local pt as Point
	local pts as Point[]
	local size2 as float
	local aa as float

	if sides < 3
		sides = 3
	elseif sides > 20
		sides = 20
	endif

	da = (360 / sides)				
	w2 = w / 2
	h2 = h / 2
	wr = w2
	hr = h2
	fill = false
					
	if size >= w2 or size >= h2 // Line size > w/h oval, don't draw second loop, just fill centre.
		
		fill = true
		size = 1						

	elseif size = 0
		
		fill = true
		size = 1 // Ensure we draw a 1 pt line.
		
	endif
	
	if size > 1

		ww = w
		hh = h
			
		if w > h
			
			dw = size * (ww / hh)
			dh = size
			
		elseif h > w
			
			dw = size
			dh = size * (hh / ww)
			
		else 
			
			dw = size
			dh = size
			
		endif
	
		size2 = coMakePoint(dw, dh)
		// Make sure the size fits withn the w,h box with size pixels.
		wr = wr - dw / 2
		hr = hr - dh / 2
	
	endif

	if wr < 0 then wr = 0
	if hr < 0 then hr = 0
									
	i = 0

	if sides > 3 // Seems to draw okay for sides > 3, triangles handled below.
				
		for a = 0 to 180 step da
					
			x1 = round(x + w2 + cos(a - 90.0) * wr)
			x3 = round(x + w2 + cos(-a - 90.0) * wr)
			y1 = round(y + h2 + sin(a - 90.0) * hr)
	
			if i > 0
									
				if size > 1
					
					coMemDrawLine(mb, x0, y0, x1, y1, col, size2, sides) // Draw a single poly.
					coMemDrawLine(mb, x2, y0, x3, y1, col, size2, sides) // Draw a single poly.
					
				else
					
					coMemDrawLine(mb, x0, y0, x1, y1, col, size, CO_LINE_CIRC)
					coMemDrawLine(mb, x2, y0, x3, y1, col, size, CO_LINE_CIRC)
	
				endif
												
			endif
								
			x0 = x1
			x2 = x3
			y0 = y1
					
			inc i
	
		next
		
	else // Triange.

		x0 = x + w2
		y0 = y + dh / 2
		x1 = x + dw / 2
		x2 = x0
		x3 = x + w - dw / 2
		//h = sin(120) * (x3 - x1)
		//y1 = y + h //- dh / 2
		y1 = y + h - dh / 2
				
		if size > 1
			
			coMemDrawLine(mb, x0, y0, x1, y1, col, size2, sides) // Draw a single poly.
			coMemDrawLine(mb, x2, y0, x3, y1, col, size2, sides) // Draw a single poly.
			
		else
			
			coMemDrawLine(mb, x0, y0, x1, y1, col, size, CO_LINE_CIRC)
			coMemDrawLine(mb, x2, y0, x3, y1, col, size, CO_LINE_CIRC)

		endif
		
		x0 = x1
		x2 = x3
		y0 = y1
		
	endif
	
	// Join the bottom line.
	if size > 1				
		coMemDrawLine(mb, x0, y0, x2, y0, col, size2, sides)		
	else
		coMemDrawLine(mb, x0, y0, x2, y0, col, size, CO_LINE_CIRC)
	endif

	if fill
		coMemDrawFill(mb, x + w2, y + h2, col)		
	endif
	
endfunction

//-----------------------------------------------------
// Returns true if the point is valid, otherwise false.
//
Function coMemIsValidPoint(mb ref as MemBlock, x as integer, y as integer)
	
	local ret as integer
	
	if (x < mb.bs.x0 Or x > mb.bs.x1 Or y < mb.bs.y0 Or y > mb.bs.y1)
		ret = false
	else
		ret = true
	endif

endfunction ret

//-----------------------------------------------------
// If there is a selection active, returns true if the point is selected in the selection.
// Otherwise returns true.
//
Function coMemPointInSelection(mb ref as MemBlock, x as integer, y as integer)

	local ret as integer
	local off as integer
	
	if mb.sel
		
		if coMemIsValidPoint(mb, x, y)
			
			off = 12 + y * coMemGetWidth(mb.sel) * 4 + x * 4
			ret = coMemOffsetInSelection(mb, off)
			
		else 
			
			ret = false
			
		endif
		
	else
		
		ret = true
		
	endif
	
endfunction ret

//-----------------------------------------------------
// If there is a selection active, returns true if the point is selected in the selection.
// Otherwise returns true.
//
Function coMemOffsetInSelection(mb ref as MemBlock, off as integer)

	local ret as integer
	
	ret = false
	
	if off >= 0 and off <= mb.offMax
		//if getMemblockInt(mb.sel, off) <> 0
		if mb.sel
			if getMemblockInt(co.mems[mb.sel].id, off) <> 0
				ret = true
			endif 
		endif
	endif

endfunction ret

//-----------------------------------------------------
// Set a point.
// Returns true if the point is valid, otherwise false.
//
Function coMemSetPoint(mb ref as MemBlock, x as integer, y as integer, col as integer)

	local off as integer
	local ret as integer
	local valid as integer
	
	valid = coMemIsValidPoint(mb, x, y)
		
	if not valid
		
		if mb.snap
		
			if x < mb.bs.x0
				x = mb.bs.x0
			elseif x > mb.bs.x1
				x = mb.bs.x1
			endif
			
			if y < mb.bs.y0
				y = mb.bs.y0
			elseif y > mb.bs.y1
				y = mb.bs.y1
			endif
			
			valid = true
			
		endif
		
	endif
		
	if valid
		
		if coMemPointInSelection(mb, x, y)
					
			off = coMemOffset(mb, x, y)
			coMemSetPointByOffset(mb, off, col)
			ret = true
			
		else 
			
			ret = false
			
		endif
			
	else
		
		ret = false
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Set a point faster, doesn't check bounds, also doesn't snap to edge.
// Only used for pasting.
// Returns true if the point is valid, otherwise false.
//
Function coMemSetPointFast(mb ref as MemBlock, x as integer, y as integer, col as integer)

	local off as integer
		
	if coMemIsValidPoint(mb, x, y)
			
		if coMemPointInSelection(mb, x, y)
					
			off = coMemOffset(mb, x, y)
			coMemSetPointByOffset(mb, off, col)
			
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Save saving pixels on.
// Call with undo = CO_NO_PIXEL, CO_PRE_PIXEL, CO_POST_PIXEL.
// Every time this is called with CO_PRE_PIXEL or CO_POST_PIXEL, the undo grp is updated.
// grp allows undos to be applied one by one.
//
Function coMemSetUndo(mb ref as MemBlock, undo as integer)
	
	local oldUndo as integer
	
	oldUndo = mb.undo
	mb.undo = undo
	
	if mb.undo
		inc mb.undoGrp
	endif
	
endfunction oldUndo

//-----------------------------------------------------
// Get undo flag.
//
Function coMemGetUndo(mb ref as MemBlock)
	
endfunction mb.undo

//-----------------------------------------------------
// Clear pixels.
//
Function coMemClearUndo(mb ref as MemBlock)
	
	mb.pixels.length = -1
	
endfunction

//-----------------------------------------------------
// Set this memblock as a mask type. That is, it can only contain one color
// as used by drawing tools before that mask layer is pasted to the final layer.
// This technique allows saying the mask as undo.
//
Function coMemSetMask(mb ref as MemBlock, mask as integer)
	
	local oldMask as integer
	
	oldMask = mb.mask
	mb.mask = mask
		
endfunction oldMask

//-----------------------------------------------------
// Get mask flag.
//
Function coMemGetMask(mb ref as MemBlock)
	
endfunction mb.mask


//-----------------------------------------------------
// Save the pixel for undo.
//
Function coMemSavePixelByOffset(mb ref as MemBlock, off as integer, col as integer)

	local pix as Pixel
	
	if mb.undo
		
		pix.off = off
		pix.col = col
		pix.grp = mb.undoGrp
		
		mb.pixels.insert(pix)
	
	endif
	
endfunction

//-----------------------------------------------------
// Set a point by offset. Offset is not checked, make sure it is within memblock.
//
Function coMemSetPointByOffset(mb ref as MemBlock, off as integer, col as integer)

	local pix as integer
	local bpix as integer
	
	if mb.blend
		
		pix = getmemblockint(mb.id, off)
		bpix = coMemBlendPix(col, pix)
		SetMemblockInt(mb.id, off, bpix)

	else
		
		if mb.undo or mb.mask // If undo buffer is set, we need to grab the pixel before overwriting.
			pix = getmemblockint(mb.id, off)
		endif

		SetMemblockInt(mb.id, off, col)

	endif
	
	if mb.undo = CO_PRE_PIXEL
		if not mb.mask or pix <> col
			coMemSavePixelByOffset(mb, off, pix)
		endif
	elseif mb.undo = CO_POST_PIXEL
		if not mb.mask or pix <> col
			coMemSavePixelByOffset(mb, off, col)
		endif
	endif

endfunction

//-----------------------------------------------------
// Get a point checking for bounds of the memblock and the selection.
//
Function coMemGetPoint(mb ref as MemBlock, x as integer, y as integer)

	local col as integer
	
	if coMemIsValidPoint(mb, x, y)
		col = coMemGetPointFast(mb, x, y)
	else
		
		col = 0
	
	endif
		
endfunction col

//-----------------------------------------------------
// Get a point without doing any checks, ensure x and y are within the memblock.
//
Function coMemGetPointFast(mb ref as MemBlock, x as integer, y as integer)

	local off as integer
	local col as integer
	
	off = coMemOffset(mb, x, y)
	col = getMemblockInt(mb.id, off)

endfunction col

//-----------------------------------------------------
// Get the x from an offset memblock.
//
function coMemOffsetToX(mb ref as MemBlock, off as integer)

	local x as integer
		
	x = mod((off - 12), mb.w * 4)

endfunction x

//-----------------------------------------------------
// Get the y from an offset memblock.
//
function coMemOffsetToY(mb ref as MemBlock, off as integer)

	local y as integer
		
	y = (off - 12) / (mb.w * 4)

endfunction y

//-----------------------------------------------------
// Get the offset of x and y into a memblock.
//
function coMemOffset(mb ref as MemBlock, x as integer, y as integer)

	local off as integer
	
	off = 12 + y * mb.w * 4 + x * 4

endfunction off

//-----------------------------------------------------
// Get the size of the memblock, excluding the first 3 bytes.
//
function coMemSize(mb ref as MemBlock)

	local size as integer
	
	size = GetMemblockSize(mb.id) - 12

endfunction size

//-----------------------------------------------------
// Paste srcMb to destMb at x,y
//
Function coMemDelete(mb ref as MemBlock)

	if not mb.copy
		
		if mb.id	
			DeleteMemblock(mb.id)
		endif
		
		if mb.line		
			//DeleteMemblock(mb.line)
			coMemDeleteRef(mb.line)
		endif
	
		if mb.lasso		
			//DeleteMemblock(mb.lasso)
			coMemDeleteRef(mb.lasso)
		endif
		
	endif

	coMemInit(mb)				
	coMemResetBounds(mb)

endfunction

//-----------------------------------------------------
// Set the bounds for an operation.
//
Function coMemSetBounds(mb ref as MemBlock, bounds ref as Bounds)

	mb.bs.x0 = bounds.x0
	mb.bs.y0 = bounds.y0
	mb.bs.x1 = bounds.x1
	mb.bs.y1 = bounds.y1
	
Endfunction

//-----------------------------------------------------
// Reset the bounds to full mb.
//
Function coMemResetBounds(mb ref as MemBlock)

	mb.bs.x0 = 0
	mb.bs.y0 = 0
	mb.bs.x1 = mb.w - 1
	mb.bs.y1 = mb.h - 1
	
Endfunction

//-----------------------------------------------------
// Get the lasso pixels.
//
function coMemFillLasso(sel ref as MemBlock, col as integer)

	local tmp as MemBlock
	local x as integer
	local y as integer
	local bounds as Bounds

	if sel.lasso > 0
				
		if coMemGetWidth(sel.lasso) <> sel.w and coMemGetHeight(sel.lasso) <> sel.h
	
			//DeleteMemblock(sel.lasso)
			coMemDeleteRef(sel.lasso)
			sel.lasso = 0
			
		endif
		
	endif

	if sel.lasso = 0
				
		//coMemCreate(tmp, sel.w, sel.h)
		//sel.lasso = tmp.id
		sel.lasso = coMemCreateRef(sel.w, sel.h)
		coMemSetBlend(co.mems[sel.lasso], false)
				
	endif

	//tmp.id = sel.lasso
	//tmp.w = sel.w
	//tmp.h = sel.h
	//tmp.blend = false

	//coMemClear(tmp)
	coMemClear(co.mems[sel.lasso])
	coMemGetBounds(sel, bounds)
	//coMemSetBounds(tmp, bounds)			
	coMemSetBounds(co.mems[sel.lasso], bounds)			
	
	// Prep a calc area.		
	//for y = tmp.bs.y0 to tmp.bs.y1
	for y = co.mems[sel.lasso].bs.y0 to co.mems[sel.lasso].bs.y1
		//for x = tmp.bs.x0 to tmp.bs.x1
		for x = co.mems[sel.lasso].bs.x0 to co.mems[sel.lasso].bs.x1
			if coMemGetPoint(sel, x, y) = col
				//coMemSetPoint(tmp, x, y, CO_LASSO_INSIDE)
				coMemSetPoint(co.mems[sel.lasso], x, y, CO_LASSO_INSIDE)
			endif
		next
	next

	//coMemFillLassoInside(sel, tmp, col)
	coMemFillLassoInside(sel, co.mems[sel.lasso], col)

endfunction

//-----------------------------------------------------
// Fill the inside area of the lasso.
//
function coMemFillLassoInside(sel ref as MemBlock, tmp ref as MemBlock, col as integer)
	
	local x as integer
	local y as integer
	local pt as Point
	
	for y = tmp.bs.y0 to tmp.bs.y1
		for x = tmp.bs.x0 to tmp.bs.x1
			
			pt.x = x
			pt.y = y
			
			if coMemInLassoSelection(tmp, pt)
				coMemSetPoint(sel, x, y, col)
			endif
		next
	next

endfunction

//-----------------------------------------------------
// Fill the lasso pixel inside selection.
//
function coMemInLassoSelection(tmp ref as MemBlock, pt ref as Point)

	local alreadyVisited as integer
	local ret as integer
	
	alreadyVisited = coMemGetPoint(tmp, pt.x, pt.y)
	
	if alreadyVisited = 0
	//if alreadyVisited <> CO_LASSO_VISITED
		coMemFillLassoVisitPixel(tmp, pt)
	endif

	ret = (coMemGetPoint(tmp, pt.x, pt.y) = CO_LASSO_INSIDE)

endfunction ret

//-----------------------------------------------------
// Visit all directions on a single pixel.
//
function coMemFillLassoVisitPixel(tmp ref as MemBlock, pt ref as Point)
		
	local frameBorderReached as integer[0]
	local visitedPixels as Point[]
	local i as integer

	frameBorderReached[0] = false
	coMemFillLassoVisitConnected(tmp, pt, frameBorderReached, visitedPixels)
	
	for i = 0 to visitedPixels.length
		if frameBorderReached[0]
			coMemSetPoint(tmp, visitedPixels[i].x, visitedPixels[i].y, CO_LASSO_OUTSIDE)
		else
			coMemSetPoint(tmp, visitedPixels[i].x, visitedPixels[i].y, CO_LASSO_INSIDE)
		endif
	next

endfunction

//-----------------------------------------------------
// Visit connected pixels.
// x and y are the points to the start the fill from.
//	
function coMemFillLassoVisitConnected(tmp ref as MemBlock, pt ref as Point, frameBorderReached ref as integer[], visitedPixels ref as Point[])

	local queue as Point[]
	local i as integer
	local connectedPixel as Point
	local loopCount as integer
	local cellCount as integer
	local currentItem as Point

	queue.insert(pt)
	visitedPixels.insert(pt)
	coMemFillLassoPixelVisitor(tmp, pt, frameBorderReached)

	loopCount = 0	
	cellCount = tmp.w * tmp.h
	
	while queue.length > -1

		inc loopCount
		
		currentItem = queue[queue.length]		
		queue.remove() // Last item.

		for i = 0 to 3

			connectedPixel.x = currentItem.x + co.lassoDx[i]
			connectedPixel.y = currentItem.y + co.lassoDy[i]
			
			if coMemFillLassoPixelVisitor(tmp, connectedPixel, frameBorderReached)
			
				queue.insert(connectedPixel)
				visitedPixels.insert(connectedPixel)
			
			endif
	
		next

		if loopCount > 10 * cellCount
			exit
		endif

	endwhile

endfunction

//-----------------------------------------------------
// The visitor fn called by the visitor.
//	
function coMemFillLassoPixelVisitor(tmp ref as MemBlock, pt ref as Point, frameBorderReached ref as integer[])
	
	local alreadyVisited as integer
		
	alreadyVisited = coMemGetPoint(tmp, pt.x, pt.y)
	
	if alreadyVisited <> 0
		exitfunction false
	endif

	if not coMemIsValidPoint(tmp, pt.x, pt.y)
		
		frameBorderReached[0] = true
		exitfunction false
		
	endif

	coMemSetPoint(tmp, pt.x, pt.y, CO_LASSO_VISITED)

endfunction true

//-----------------------------------------------------
// Do a flood fill.
// x and y are the points to the start the fill from.
//
function coMemDrawFill2(mb ref as MemBlock, x as integer, y as integer, col as integer)

	local tcol as integer
	
	//Flood-fill (node, target-color, replacement-color):
	if not coMemIsValidPoint(mb, x, y)
		exitfunction
	endif

	if not coMemPointInSelection(mb, x, y)
		exitfunction
	endif

	tcol = coMemFillGetPoint(mb, x, y)	
	coMemDrawFillInt(mb, x, y, tcol, col)
 
endfunction

//-----------------------------------------------------
// Do a flood fill.
// x and y are the points to the start the fill from.
//
function coMemDrawFillInt(mb ref as MemBlock, x as integer, y as integer, tcol as integer, col as integer)

	local ncol as integer

	if not coMemIsValidPoint(mb, x, y)
		exitfunction
	endif
	
	//1. If target-color is equal to replacement-color, return.			
	If tcol = col
		exitfunction
	endif
	
	//2. ElseIf the color of node is not equal to target-color, return.
	ncol = coMemFillGetPoint(mb, x, y)
	
	if ncol <> tcol
		exitfunction
	endif
		
	//3. Else Set the color of node to replacement-color.
	if coMemPointInSelection(mb, x, y)
		coMemSetPoint(mb, x, y, col)
	endif

	//4. Perform Flood-fill (one step to the south of node, target-color, replacement-color).
	coMemDrawFillInt(mb, x, y + 1, tcol, col)
	//   Perform Flood-fill (one step to the north of node, target-color, replacement-color).
	coMemDrawFillInt(mb, x, y - 1, tcol, col)
	//   Perform Flood-fill (one step to the west of node, target-color, replacement-color).
	coMemDrawFillInt(mb, x - 1, y, tcol, col)
	//   Perform Flood-fill (one step to the east of node, target-color, replacement-color).
	coMemDrawFillInt(mb, x + 1, y, tcol, col)
	
	//5. Return.

endfunction

//-----------------------------------------------------
// Do a flood fill.
// x and y are the points to the start the fill from.
//
function coMemDrawFill3(mb ref as MemBlock, x as integer, y as integer, col as integer)

	local ncol as integer
	local tcol as integer
	local p as Point
	local n as Point
	local queue as Point[]

	if not coMemIsValidPoint(mb, x, y)
		exitfunction
	endif

	if not coMemPointInSelection(mb, x, y)
		exitfunction
	endif

	tcol = coMemFillGetPoint(mb, x, y)	
	
	//1. If target-color is equal to replacement-color, return.
	If tcol = col
		exitfunction
	endif
	
	// 2. If color of node is not equal to target-color, return.
	ncol = coMemFillGetPoint(mb, x, y)
	
	if ncol <> tcol
		exitfunction
	endif

	// 3. Set the color of node to replacement-color.
	if coMemPointInSelection(mb, x, y)
		coMemSetPoint(mb, x, y, col)
	endif

	// 4. Set Q to the empty queue.
	queue.length = -1
	
	// 5. Add node to the end of Q.
	p.x = x
	p.y = y
	queue.insert(p)
	
	// 6. While Q is not empty:
	while queue.length > -1
		
		// 7. Set n equal to the first element of Q.
		n.x = queue[0].x
		n.y = queue[0].y
		
		// 8. Remove first element from Q.
		queue.remove(0)
		
		// 9. If the color of the node to the west of n is target-color,
		if n.x - 1 >= mb.bs.x0
			
			ncol = coMemFillGetPoint(mb, n.x - 1, n.y)
			
			// set the color of that node to replacement-color and add that node to the end of Q.
			if ncol = tcol
					
				if coMemPointInSelection(mb, n.x - 1, n.y)
					coMemSetPoint(mb, n.x - 1, n.y, col)
				endif
				
				p.x = n.x - 1
				p.y = n.y
				queue.insert(p)
				
			endif
			
		endif
		
		//10. If the color of the node to the east of n is target-color,
		if n.x + 1 <= mb.bs.x1
			
			ncol = coMemFillGetPoint(mb, n.x + 1, n.y)

			if ncol = tcol
		
				// set the color of that node to replacement-color and add that node to the end of Q.
				if coMemPointInSelection(mb, n.x + 1, n.y)
					coMemSetPoint(mb, n.x + 1, n.y, col)
				endif

				p.x = n.x + 1
				p.y = n.y
				queue.insert(p)
				
			endif
			
		endif
		
		//11. If the color of the node to the north of n is target-color,
		if n.y - 1 >= mb.bs.y0
			
			ncol = coMemFillGetPoint(mb, n.x, n.y - 1)

			// set the color of that node to replacement-color and add that node to the end of Q.
			if ncol = tcol
			
				if coMemPointInSelection(mb, n.x, n.y - 1)
					coMemSetPoint(mb, n.x, n.y - 1, col)
				endif

				p.x = n.x
				p.y = n.y - 1
				queue.insert(p)
				
			endif
			
		endif

		//12. If the color of the node to the south of n is target-color,
		if n.y + 1 <= mb.bs.y1
			
			ncol = coMemFillGetPoint(mb, n.x, n.y + 1)

			// set the color of that node to replacement-color and add that node to the end of Q.
			if ncol = tcol
			
				if coMemPointInSelection(mb, n.x, n.y + 1)
					coMemSetPoint(mb, n.x, n.y + 1, col)
				endif

				p.x = n.x 
				p.y = n.y + 1
				queue.insert(p)
				
			endif
			
		endif
	
	//13. Continue looping until Q is exhausted.
	endwhile
	
	//14. Return.
 
endfunction

//-----------------------------------------------------
// Do a flood fill.
// x and y are the points to the start the fill from.
//
function coMemDrawFill(mb ref as MemBlock, x as integer, y as integer, col as integer)
	
	Local l as integer
	Local x1 as integer
	Local x2 as integer
	Local dy as integer
	Local ov as integer	//  old pixel value
	local s as Segment
	Local skip as integer

	if not coMemIsValidPoint(mb, x, y)
		exitfunction
	endif

	if not coMemPointInSelection(mb, x, y)
		exitfunction
	endif
			
	ov = coMemFillGetPoint(mb, x, y)

	If ov = col // No need to fill.
		exitfunction
	endif

	mb.pixCount = 0
	mb.stack.length = -1
		
	coMemPushStack(mb, y, x, x, 1)	
	coMemPushStack(mb, y + 1, x, x, -1)
	
	While mb.stack.length > -1

		coMemPopStack(mb, s)
		dy = s.dy
		y = s.y + dy
		x1 = s.xl
		x2 = s.xr
		
		x = x1
		
		//While x >= mb.bs.x0 and coMemPointInSelection(mb, x, y) and coMemFillGetPoint(mb, x, y) = ov

		//if coMemIsValidPoint(mb, x, y)
			
			While x >= mb.bs.x0 and coMemFillGetPoint(mb, x, y) = ov
				
				if coMemPointInSelection(mb, x, y)
					coMemSetPoint(mb, x, y, col)
				endif
				
				inc mb.pixCount
				dec x
				
				//if not coMemIsValidPoint(mb, x, y)
				//	exit
				//endif
										
			endwhile
			
		//endif
		
		skip = False
		
		If x >= x1 Then skip = True
		
		If Not skip
		
			l = x + 1
			If l < x1 Then coMemPushStack(mb, y, l, x1 - 1, -dy)
			x = x1 + 1
			
		EndIf
		
		Repeat
		
			If Not skip
						
				//While x <= mb.bs.x1 and coMemPointInSelection(mb, x, y) and coMemFillGetPoint(mb, x, y) = ov

				//if coMemIsValidPoint(mb, x, y)
					
					While x <= mb.bs.x1 and coMemFillGetPoint(mb, x, y) = ov
					
						if coMemPointInSelection(mb, x, y)
							coMemSetPoint(mb, x, y, col)
						endif
						
						inc mb.pixCount
						inc x
	
						//if not coMemIsValidPoint(mb, x, y)
						//	exit
						//endif
					
					endwhile
				
				//endif
											
				coMemPushStack(mb, y, l, x - 1, dy)
	
				If x > x2 + 1 Then coMemPushStack(mb, y, x2 + 1, x - 1, -dy)
				
			EndIf
			
			skip = False
			
			inc x
			
			//if coMemIsValidPoint(mb, x, y)

				While x <= x2 and coMemFillGetPoint(mb, x, y) <> ov
					
					inc x
	
					//if not coMemIsValidPoint(mb, x, y)
					//	exit
					//endif
	
				endwhile
				
			//endif
			
			l = x
			
		Until x > x2
		
	endwhile

	mb.stack.length = -1

endfunction

//-----------------------------------------------------
// Get a point from either the mb or mask if it is set.
//
function coMemFillGetPoint(mb ref as MemBlock, x as integer, y as integer)

	local pix as integer

	if coMemIsValidPoint(mb, x, y)

		pix = coMemGetPointFast(mb, x, y)
			
		if pix = 0
				
			if mb.fill
			
				//local fill as MemBlock
				//fill.id = mb.fill
				//fill.w = mb.w
				//fill.h = mb.h
				//pix = coMemGetPointFast(fill, x, y)
				pix = coMemGetPointFast(co.mems[mb.fill], x, y)
			
			endif
							
		endif
		
	else 
		
		pix = 0
	
	endif

endfunction pix

//-----------------------------------------------------
// Push New segment on stack
//
function coMemPushStack(mb ref as MemBlock, y as integer, xl as integer, xr as integer, dy as integer)
	
	local s as Segment
	
	If y + dy >= mb.bs.y0 And y + dy <= mb.bs.y1

		s.y = y
		s.xl = xl
		s.xr = xr
		s.dy = dy

		if mb.stack.length > -1
			mb.stack.insert(s, 0)
		else
			mb.stack.insert(s) // Append.
		endif
		
		//inc ff.sp
		
	EndIf
	
Endfunction

//-----------------------------------------------------
// Pop segment off stack.
//
function coMemPopStack(mb ref as MemBlock, s ref as Segment)

	if mb.stack.length > -1
		
		s.y = mb.stack[0].y
		s.xl = mb.stack[0].xl
		s.xr = mb.stack[0].xr
		s.dy = mb.stack[0].dy

		mb.stack.remove(0)

	endif
	
Endfunction

//-----------------------------------------------------
// Swap pixels as each off, consider sel.
//
function coMemSwapPixel(mb ref as MemBlock, off1 as integer, off2 as integer)
	
	local a as integer
	local b as integer
	
	a = GetMemblockint(mb.id, off2)
	b = GetMemblockint(mb.id, off1)
	
	if mb.sel = 0
		
		SetMemblockInt(mb.id, off2, b)
		SetMemblockInt(mb.id, off1, a)

	else
	
		if coMemOffsetInSelection(mb, off2)
			coMemSetPointByOffset(mb, off2, b)
		endif
		
		if coMemOffsetInSelection(mb, off1)
			coMemSetPointByOffset(mb, off1, a)
		endif

	endif

endfunction

//-----------------------------------------------------
// Flip a memblock image.
//
function coMemFlipX(mb ref as MemBlock, x as integer, y as integer, w as integer, h as integer)

	local off as integer
	local off1 as integer
	local off2 as integer
	local xx as integer
	local yy as integer
	local blend as integer

	blend = coMemSetBlend(mb, false)
			
	for yy = 0 to h / 2 - 1

		// Make sure we don't go off the end.
		if y + yy >= 0 and y + yy < mb.h and y + h - 1 - yy >= 0 and y + h - 1 - yy < mb.h
			
			off1 = coMemOffset(mb, x, y + yy)
			off2 = coMemOffset(mb, x, y + h - 1 - yy)

			for xx = 0 to w - 1

				if x + xx >= 0 and x + xx < mb.w
					
					coMemSwapPixel(mb, off1, off2)
					off1 = off1 + 4
					off2 = off2 + 4

				endif
				
			next
		
		endif
		
	next

	coMemSetBlend(mb, blend)

endfunction

//-----------------------------------------------------
// Flip a memblock image.
//
function coMemFlipY(mb ref as MemBlock, x as integer, y as integer, w as integer, h as integer)

	local off as integer
	local off1 as integer
	local off2 as integer
	local xx as integer
	local yy as integer
	local size as integer
	local blend as integer

	blend = coMemSetBlend(mb, false)
	size = mb.w * 4
			
	for xx = 0 to w / 2 - 1

		//if x + xx < w and x + w - 1 - xx < w
		if x + xx >= 0 and x + xx < mb.w and x + w - 1 - xx >= 0 and x + w - 1 - xx < mb.w
			
			off1 = coMemOffset(mb, x + xx, y)
			off2 = coMemOffset(mb, x + w - 1 - xx, y)

			for yy = 0 to h - 1

				//if y + yy < h
				if y + yy >= 0 and y + yy < mb.h

					coMemSwapPixel(mb, off1, off2)
					off1 = off1 + size
					off2 = off2 + size

				endif
				
			next
			
		endif
		
	next
	
	coMemSetBlend(mb, blend)
	
endfunction

//-----------------------------------------------------
// Rotate the whole shape.
//
function coMemRotate(srcMb ref as MemBlock, lt as integer)

	local destMb as MemBlock
	local dx as float
	local dy as float
	local xx as integer
	local yy as integer
	local pix as integer
			
	coMemDelete(destMb)
	coMemCreate(destMb, srcMb.h, srcMb.w) // Rotate whole image.
	coMemClear(destMb)
	coMemSetBlend(destMb, false)
				
	for yy = 0 to srcMb.h - 1
		
		for xx = 0 to srcMb.w - 1
								
			if lt

				dx = yy
				dy = srcMb.w - xx - 1

			else

				dx = srcMb.h - yy - 1
				dy = xx
			
			endif
			
			pix = coMemGetPoint(srcMb, xx, yy)
			coMemSetPoint(destMb, dx, dy, pix)				
						
		next
				
	next
	
	coMemDelete(srcMb)
	srcMb = destMb

endfunction

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
// Flip an image.
//
function coFlipImageX(img as integer)

	local mb as MemBlock
	local ret as integer
	
	coMemFromImage(img, mb)
	coMemFlipX(mb, 0, 0, mb.w, mb.h)
	ret = coMemToImage(mb)
	coMemDelete(mb)

endfunction ret

//-----------------------------------------------------
// Flip an image.
//
function coFlipImageY(img as integer)

	local mb as MemBlock
	local ret as integer
	
	coMemFromImage(img, mb)
	coMemFlipY(mb, 0, 0, mb.w, mb.h)
	ret = coMemToImage(mb)
	coMemDelete(mb)

endfunction ret

//-----------------------------------------------------
// Get the bounds of a rotated spr.
//
function coGetRotSprBounds(rotSpr as integer, bounds ref as Line)

	local sx as float
	local sy as float
	local sx0 as float
	local sy0 as float
	local sx1 as float
	local sy1 as float	
	local dx as float
	local dy as float
	local r as float
	local xx as float
	local yy as float
	local ang as float

	sx = GetSpriteXByOffset(rotSpr)
	sy = GetSpriteyByOffset(rotSpr)
	sx0 = getspritex(rotSpr)
	sy0 = getspritey(rotSpr)
	sx1 = sx0 + GetSpriteWidth(rotSpr) - 1
	sy1 = sy0 + GetSpriteHeight(rotSpr) - 1
	
	dx = sx - sx0
	dy = sy - sy0
	r = sqrt(abs(dx * dx) + abs(dy * dy))
	
	// Top-left
	ang = atanfull(-dy, dx)
	ang = ang + GetSpriteAngle(rotSpr)
	xx = sx + cos(ang) * r
	yy = sy + sin(ang) * r
	//spr = CreateSprite(co.pixImg)
	//SetSpriteScaleByOffset(spr, 20, 20)
	//coSetSpriteColor(spr, co.red[5])
	//SetSpriteDepth(spr, FRONT_DEPTH)
	//SetSpritePositionByOffset(spr, xx, yy)

	if xx < sx0
		sx0 = xx
	elseif xx > sx1
		sx1 = xx
	endif
	
	if yy < sy0
		sy0 = yy
	elseif yy > sy1
		sy1 = yy
	endif
	
	// Bottom-left
	ang = atanfull(dy, dx)
	ang = ang + GetSpriteAngle(rotSpr)
	xx = sx + cos(ang) * r
	yy = sy + sin(ang) * r
	//spr = CreateSprite(co.pixImg)
	//SetSpriteScaleByOffset(spr, 20, 20)
	//coSetSpriteColor(spr, co.red[5])
	//SetSpriteDepth(spr, FRONT_DEPTH)
	//SetSpritePositionByOffset(spr, xx, yy)

	if xx < sx0
		sx0 = xx
	elseif xx > sx1
		sx1 = xx
	endif
	
	if yy < sy0
		sy0 = yy
	elseif yy > sy1
		sy1 = yy
	endif

	// Top-right
	ang = atanfull(-dy, -dx)
	ang = ang + GetSpriteAngle(rotSpr)
	xx = sx + cos(ang) * r
	yy = sy + sin(ang) * r
	//spr = CreateSprite(co.pixImg)
	//SetSpriteScaleByOffset(spr, 20, 20)
	//coSetSpriteColor(spr, co.red[5])
	//SetSpriteDepth(spr, FRONT_DEPTH)
	//SetSpritePositionByOffset(spr, xx, yy)

	if xx < sx0
		sx0 = xx
	elseif xx > sx1
		sx1 = xx
	endif
	
	if yy < sy0
		sy0 = yy
	elseif yy > sy1
		sy1 = yy
	endif

	// Bottom-right
	ang = atanfull(dy, -dx)
	ang = ang + GetSpriteAngle(rotSpr)
	xx = sx + cos(ang) * r
	yy = sy + sin(ang) * r
	//spr = CreateSprite(co.pixImg)
	//SetSpriteScaleByOffset(spr, 20, 20)
	//coSetSpriteColor(spr, co.red[5])
	//SetSpriteDepth(spr, FRONT_DEPTH)
	//SetSpritePositionByOffset(spr, xx, yy)

	if xx < sx0
		sx0 = xx
	elseif xx > sx1
		sx1 = xx
	endif
	
	if yy < sy0
		sy0 = yy
	elseif yy > sy1
		sy1 = yy
	endif

	bounds.x0 = sx0
	bounds.y0 = sy0
	bounds.x1 = sx1
	bounds.y1 = sy1
	
endfunction

//-----------------------------------------------------
// Get a unique name from the passed name and suffix.
//
function coGetUniqueName(nu ref as NameUnique)

	local pos as integer
	local s as string 
	local t as string 

	s = nu.name	
	pos = FindStringReverse(s, "-")

	if pos > 0
		
		t = mid(s, pos + 1, -1)

		if coIsValidNbr(t, false, false)

			s = mid(s, 1, pos - 1)
			nu.suffix = val(t)
			
		endif

	endif
	
	inc nu.suffix
	nu.name = s + "-" + str(nu.suffix)
	nu.unique = false

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
// Generate a unique id.
//
function coGenId()
	
	local i as integer
	local s as string
	local r as integer
	
	s = ""
	
	for i = 1 to CO_ID_LEN
		
		r = random2(1, CO_ALPHANUMS_LEN)
		s = s + mid(CO_ALPHANUMS$, r, 1)
		
	next 
	
endfunction s

//
// End.
//
