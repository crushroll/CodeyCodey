#option_explicit

//-----------------------------------------------------
//
#constant DE_MODE_NONE 0
#constant DE_MODE_WAIT_THING 1
#constant DE_MODE_DRAG_THING 2
#constant DE_MODE_THING_BAR 3
#constant DE_MODE_MORE_BAR 4
#constant DE_MODE_RESIZE_THING_BOX 5
#constant DE_MODE_ROT_THING_BOX 6
#constant DE_MODE_WAIT_VAR 7
#constant DE_MODE_DRAG_VAR 8
#constant DE_MODE_VAR_BAR 9
#constant DE_MODE_RESIZE_VAR_BOX 10
#constant DE_MODE_BACK_BUT 11
#constant DE_MODE_RUN_BUT 12
#constant DE_MODE_SCROLL 13
#constant DE_MODE_PAN 14

#constant DE_LINE_SIZE 16
#constant DE_BOX_EXTRA 32
#constant DE_DOT_LINE_SIZE 96
#constant DE_SMALLEST_SCALE 0.2
#constant DE_SMALLEST_SIZE 32

//-----------------------------------------------------
//
global de as Designer

//-----------------------------------------------------
//
type Designer

	mode as integer
	imgs as integer[]
	sprs as integer[]
	thingBar as Toolbar // Toolbar for a thing.
	moreBut as Button
	moreBar as Toolbar
	backBut as Button
	runBut as Button
	varBar as Toolbar
	appIdx as integer
	backImg as integer
	leftImg as integer
	centreImg as integer
	secretOnImg as integer
	secretOffImg as integer
	snapLeftImg as integer
	snapVMidImg as integer
	snapRightImg as integer
	snapTopImg as integer
	snapHMidImg as integer
	snapBottomImg as integer
	rightImg as integer
	thingIdx as integer // Currently pressed thing.
	varIdx as integer // Currently pressed var.
	lines as integer[] // Lines on the screen.
	//gridSize as integer
	//snapSize as integer // The distance within a grid for snapping.
	waitStart as integer
	waitX as float
	waitY as float
	selBoxImg as integer
	selBoxScale as float
	selLine as integer[3] // Sel lines.
	selBox as integer[7] // Sel dots.
	selDot as integer
	selDotLine as integer
	selLineCol as integer
	selBoxCol as integer
	boxIdx as integer // The box being dragged.
	thingX as float // Pre-resize x.
	thingY as float // Pre-resize y.
	thingW as float // Pre-resize width.
	thingH as float // Pre-resize height.
	thingSx as float // Pre-resize scale x.
	thingSy as float // Pre-resize scale y.
	thingAng as float // Pre-move angle.
	spr1 as integer
	spr2 as integer
	spr3 as integer
	resizeAllowed as integer
	depths as Depth[]
	vardepths as Depth[]
	pressed as integer
	dragOx as float
	dragOy as float
	bg as integer // The background spr.
	bgPos as Point
	bgOff as Point
	toggleButCol as integer
	pan as Pan
	w as float
	h as float

endtype

type Pan 
	
	back as integer // Pan window back.
	shadow as integer
	bg as integer // The bg spr.
	sprs as integer[]
	scale as Point
	bounds as Bounds

endtype

//-----------------------------------------------------
// 
function deInit()

	local but as Button
	local x as integer
	local y as integer
	local spr as integer
	local txt as integer
	local i as integer
	local thing as integer
	local s as float
	local img as integer
	
	cd.mode = CD_MODE_NONE

	//de.gridSize = co.bs / 2
	//de.snapSize = de.gridSize / 8
	de.thingIdx = -1
	de.varIdx = -1
	de.appIdx = -1
	de.resizeAllowed = true
	de.pressed = false
	de.w = co.w
	de.h = co.h

	de.bgPos.x = 0 // co.w2
	de.bgPos.y = 0 // co.h2
	de.bgoff.x = 0
	de.bgoff.y = 0

	//de.bg = guiCreateBox("bg", co.w, co.h)
	//SetSpriteDepth(de.bg, BACK_DEPTH)
	//SetSpritePosition(de.bg, de.bgPos.x, de.bgPos.y)
	//SetSpriteVisible(de.bg, false)
	//deShowBgColor()
		
	de.pan.Scale.x = 0
	de.pan.Scale.y = 0
	de.pan.bounds.x0 = 0
	de.pan.bounds.y0 = 0
	//de.pan.bounds.x1 = de.w
	//de.pan.bounds.y1 = de.h	
	de.pan.bounds.x1 = co.w
	de.pan.bounds.y1 = co.h	
	
	de.backImg = loadimage("gfx/BackIcon.png")
	de.leftImg = loadimage("gfx/LeftIcon.png")
	de.centreImg = loadimage("gfx/CentreIcon.png")
	de.rightImg = loadimage("gfx/RightIcon.png")
	de.secretOnImg = loadimage("gfx/SecretIcon.png")
	de.secretOffImg = loadimage("gfx/NoSecretIcon.png")
	de.snapLeftImg = loadimage("gfx/SnapLeftIcon.png")
	de.snapVMidImg = loadimage("gfx/SnapVMidIcon.png")
	de.snapRightImg = loadimage("gfx/SnapRightIcon.png")
	de.snapTopImg = loadimage("gfx/SnapTopIcon.png")
	de.snapHMidImg = loadimage("gfx/SnapHMidIcon.png")
	de.snapBottomImg = loadimage("gfx/SnapBottomIcon.png")

	de.toggleButCol = co.orange[5]

	//
	// Buttons.
	//

	// New runner like back with more.
	
	de.runBut = guiCreateButton("run", BUT_BG_NORMAL, "gfx/RunBlackIcon.png", co.runCol)
	de.runBut.id = BUT_DESIGN_RUN
	cosettextcolor(de.runBut.text, co.black)
	guiSetButtonDepth(de.runBut, GUI_BACK_DEPTH)

	de.backBut = guiCreateButton("back", BUT_BG_NORMAL, "gfx/BackBlackIcon.png", co.detailsCol)
	de.backBut.id = BUT_DESIGN_BACK
	cosettextcolor(de.backBut.text, co.black)
	guiSetButtonDepth(de.backBut, GUI_BACK_DEPTH)

	de.moreBut = guiCreateButton("more", BUT_BG_NORMAL, "gfx/MoreBlackIcon.png", co.moreCol)
	de.moreBut.id = BUT_DESIGN_MORE
	cosettextcolor(de.moreBut.text, co.black)
	guiSetButtonDepth(de.moreBut, GUI_BACK_DEPTH)

	// Original back press bar.
	
	de.moreBar = guiCreateToolbar()
	de.moreBar.rowLen = 4
	
	but = guiCreateButton("grid", BUT_BG_NORMAL, "gfx/GridIcon.png", co.special1Col)
	but.id = BUT_DESIGN_GRID_SNAP
	but.help = "Turn grid snapping on or off."
	de.moreBar.buts.insert(but)

	but = guiCreateButton("width", BUT_BG_NORMAL, "gfx/GridWidthIcon.png", co.special11Col) // co.bluegrey[col])
	but.id = BUT_DESIGN_GRID_WIDTH
	but.help = "Change the grid width in pixels."
	de.morebar.buts.insert(but)

	but = guiCreateButton("height", BUT_BG_NORMAL, "gfx/GridHeightIcon.png", co.special12Col) // co.bluegrey[col])
	but.id = BUT_DESIGN_GRID_HEIGHT
	but.help = "Change the grid height in pixels."
	de.morebar.buts.insert(but)

	but = guiCreateButton("snap v", BUT_BG_NORMAL, "", co.special11Col) // co.bluegrey[col])
	but.id = BUT_DESIGN_SNAP_VERT
	but.help = "Select whether to snap a sprite or variable left, middle or right to the grid."
	de.morebar.buts.insert(but)

	//but = guiCreateButton("", BUT_BG_NONE, "", co.special1Col)
	//but.id = 0
	//de.moreBar.buts.insert(but)

	but = guiCreateButton("bg col", BUT_BG_NORMAL, "", co.grey[7])	
	img = coCreateTransImg(1, 64, 64)	
	guiSetButtonIcon(but, img)
	guiSetButtonIcon2(but, co.pixImg)	
	SetSpriteScale(but.icon2, 64, 64)
	but.id = BUT_DESIGN_BG_COLOR
	but.help = "Set the background color of the layout area."
 	de.moreBar.buts.insert(but)

	but = guiCreateButton("cols", BUT_BG_NORMAL, "gfx/GridColsIcon.png", co.special12Col) // co.bluegrey[col])
	but.id = BUT_DESIGN_GRID_COLS
	but.help = "Change the width of the grid in pixels by dividing the screen width by a number of columns."
	de.morebar.buts.insert(but)

	but = guiCreateButton("rows", BUT_BG_NORMAL, "gfx/GridRowsIcon.png", co.special11Col) // co.bluegrey[col])
	but.id = BUT_DESIGN_GRID_ROWS
	but.help = "Change the height of the grid in pixels by dividing thr sreen height by a number of rows."
	de.morebar.buts.insert(but)

	but = guiCreateButton("snap h", BUT_BG_NORMAL, "", co.special12Col) // co.bluegrey[col])
	but.id = BUT_DESIGN_SNAP_HORIZ
	but.help = "Select whether to snap a sprite or variable top, middle or bottom to the grid."
	de.morebar.buts.insert(but)

	but = guiCreateButton("screen", BUT_BG_NORMAL, "gfx/Help2Icon.png", co.special3Col)
	but.id = BUT_DESIGN_SCREEN
	but.help = "Change the screen size."
	de.moreBar.buts.insert(but)

	but = guiCreateButton("names", BUT_BG_NORMAL, "gfx/Help2Icon.png", co.special2Col)
	but.id = BUT_DESIGN_NAMES
	but.help = "Turn sprite names on or off."
	de.moreBar.buts.insert(but)

	but = guiCreateButton("pan", BUT_BG_NORMAL, "gfx/PanIcon.png", co.special4Col)
	but.id = BUT_DESIGN_PAN
	but.help = "Show and hide panning window."
	de.moreBar.buts.insert(but)

	but = guiCreateButton("reset", BUT_BG_NORMAL, "gfx/ResetIcon.png", co.editCol) // co.bluegrey[col])
	but.id = BUT_DESIGN_RESET_SCREEN
	but.help = "Reset the position of the screen to the middle."
	de.morebar.buts.insert(but)

	//but = guiCreateButton("menu pos", BUT_BG_NORMAL, "", co.special3Col)
	//but.id = BUT_DESIGN_MENU_POS
	//but.help = "Change the position of the button menu."
	//guiSetButtonIcon(but, de.backImg)
	//de.moreBar.buts.insert(but)

	deSetSettingsButtons()

	//
	// Thing bar.
	//
	
	de.thingBar = guiCreateToolbar()

	but = guiCreateButton("to front", BUT_BG_NORMAL, "gfx/ToFrontIcon.png", co.bluegrey[4])
	but.id = BUT_DESIGN_TO_FRONT
	but.help = "Bring this sprite to the very front of other sprites."
	de.thingBar.buts.insert(but)

	but = guiCreateButton("to back", BUT_BG_NORMAL, "gfx/ToBackIcon.png", co.bluegrey[6])
	but.id = BUT_DESIGN_TO_BACK
	but.help = "Send this sprite to the very back of other sprites."
	de.thingBar.buts.insert(but)

	but = guiCreateButton("smooth", BUT_BG_NORMAL, "gfx/SmoothIcon.png", co.bluegrey[2])
	but.id = BUT_DESIGN_SMOOTH_SCALING
	but.help = "Set whether this sprite should look pixelly or smooth (anti-aliased) when scaled."
	de.thingBar.buts.insert(but)

	if de.resizeAllowed
		
		but = guiCreateButton("reset", BUT_BG_NORMAL, "gfx/ResetIcon.png", co.editCol)
		//guiSetButtonDepth(but, GUI_SHADOW_DEPTH - GUI_OVER_DEPTH)
		but.id = BUT_DESIGN_RESET_SPRITE
		but.help = "Reset the size and angle of this sprite to edited image."
		de.thingBar.buts.insert(but)

	endif

	//
	// Var bar.
	//
	
	de.varBar = guiCreateToolbar()
	de.varBar.rowLen = 8

	but = guiCreateButton("title" + chr(10) + "settings", BUT_BG_NONE, "", co.bluegrey[3])
	coSetTextColor(but.text, co.black)
	de.varBar.buts.insert(but)

	but = guiCreateButton("visible", BUT_BG_NORMAL, "gfx/DoneIcon.png", co.bluegrey[5])
	but.id = BUT_DESIGN_TITLE_VIS
	but.help = "Show or hide the variable title."
	de.varBar.buts.insert(but)

	but = guiCreateButton("pos", BUT_BG_NORMAL, "", co.bluegrey[3])
	but.id = BUT_DESIGN_TITLE_POS
	but.help = "Change the position of the variable title."
	guiSetButtonIcon(but, de.backImg)
	de.varBar.buts.insert(but)

	but = guiCreateButton("title col", BUT_BG_NORMAL, "", co.bluegrey[5])
	guiSetButtonIcon(but, co.pixImg)
	SetSpriteScale(but.icon, 64, 64)
	but.id = BUT_DESIGN_TITLE_COL
	but.help = "Change the color of the variable title."
	de.varBar.buts.insert(but)

	but = guiCreateButton("font", BUT_BG_NORMAL, "gfx/TextIcon.png", co.bluegrey[3])
	but.id = BUT_DESIGN_TITLE_FONT
	but.help = "Change the font of the variable title."
	de.varBar.buts.insert(but)

	but = guiCreateButton("font size", BUT_BG_NORMAL, "gfx/TextSizeIcon.png", co.bluegrey[5])
	but.id = BUT_DESIGN_TITLE_FONT_SIZE
	but.help = "Change the font size of the variable title."
	de.varBar.buts.insert(but)

	but = guiCreateButton("align", BUT_BG_NORMAL, "", co.bluegrey[3])
	guiSetButtonIcon(but, de.centreImg)
	but.id = BUT_DESIGN_TITLE_ALIGN
	but.help = "Change the alignment of the variable title, i.e. show the title from the left, middle or right."
	de.varBar.buts.insert(but)

	but = guiCreateButton("reset", BUT_BG_NORMAL, "gfx/ResetIcon.png", co.editCol)
	//guiSetButtonDepth(but, GUI_SHADOW_DEPTH - GUI_OVER_DEPTH)
	but.id = BUT_DESIGN_RESET_VAR
	but.help = "Reset the visual settings of the variable to default."
	de.varBar.buts.insert(but)

	but = guiCreateButton("value" + chr(10) + "settings", BUT_BG_NONE, "", co.bluegrey[5])
	coSetTextColor(but.text, co.black)
	de.varBar.buts.insert(but)

	but = guiCreateButton("bg col", BUT_BG_NORMAL, "", co.bluegrey[3])
	guiSetButtonIcon(but, co.pixImg)
	SetSpriteScale(but.icon, 64, 64)
	but.id = BUT_DESIGN_VARBG_COL
	but.help = "Change the color of the variable background."
	de.varBar.buts.insert(but)

	but = guiCreateButton("box col", BUT_BG_NORMAL, "", co.bluegrey[5])
	guiSetButtonIcon(but, co.pixImg)
	SetSpriteScale(but.icon, 64, 64)
	but.id = BUT_DESIGN_BOX_COL
	but.help = "Change the color of the variable value box."
	de.varBar.buts.insert(but)

	but = guiCreateButton("value col", BUT_BG_NORMAL, "", co.bluegrey[3])
	guiSetButtonIcon(but, co.pixImg)
	SetSpriteScale(but.icon, 64, 64)
	but.id = BUT_DESIGN_TEXT_COL
	but.help = "Change the color of the variable value."
	de.varBar.buts.insert(but)

	but = guiCreateButton("font", BUT_BG_NORMAL, "gfx/TextIcon.png", co.bluegrey[5])
	but.id = BUT_DESIGN_TEXT_FONT
	but.help = "Change the font size of the variable value."
	de.varBar.buts.insert(but)

	but = guiCreateButton("font size", BUT_BG_NORMAL, "gfx/TextSizeIcon.png", co.bluegrey[3])
	but.id = BUT_DESIGN_TEXT_FONT_SIZE
	but.help = "Change the font size of the variable value."
	de.varBar.buts.insert(but)

	but = guiCreateButton("align", BUT_BG_NORMAL, "", co.bluegrey[5])
	guiSetButtonIcon(but, de.centreImg)
	but.id = BUT_DESIGN_TEXT_ALIGN
	but.help = "Change the alignment of the variable value, i.e. show the value from the left, middle or right."
	de.varBar.buts.insert(but)

	but = guiCreateButton("secret", BUT_BG_NORMAL, "gfx/FontIcon.png", co.bluegrey[3])
	but.id = BUT_DESIGN_TEXT_SECRET
	but.help = "Change the variable value to be secret, i.e. show stars insread of the actual value."
	de.varBar.buts.insert(but)

	deSetVarButtons()
	
	de.selLineCol = co.grey[5]
		
	for i = 0 to de.selLine.length
		
		de.selLine[i] = guicreatebox("deInit:de.selLine", 1, 1)
		cosetspritecolor(de.selLine[i], de.selLineCol)
		//SetSpriteDepth(de.selLine[i], FRONT_DEPTH)
		SetSpriteDepth(de.selLine[i], GUI_BEHIND_DEPTH)
		
	next	

	if de.resizeAllowed
		
		de.selBoxCol = co.grey[6]

		//de.selBoxImg = loadimage("gfx/circle.png")
		//de.selBoxScale = 0.2
		de.selBoxImg = co.pixImg
		de.selBoxScale = co.bs / 4

		for i = 0 to de.selBox.length
			
			de.selBox[i] = createsprite(de.selBoxImg)
			setspritescale(de.selBox[i], de.selBoxScale, de.selBoxScale)
			cosetspritecolor(de.selBox[i], de.selBoxCol)
			//SetSpriteDepth(de.selBox[i], FRONT_DEPTH - 2)
			SetSpriteDepth(de.selBox[i], GUI_BEHIND_DEPTH - 2)
			
		next	

		de.selDotLine = guicreatebox("deInit:de.selDotLine", 1, 1)
		cosetspritecolor(de.selDotLine, de.selLineCol)
		//SetSpriteDepth(de.selDotLine, FRONT_DEPTH)
		SetSpriteDepth(de.selDotLine, GUI_BEHIND_DEPTH)

		de.selDot = createsprite(de.selBoxImg)
		cosetspritecolor(de.selDot, de.selBoxCol)
		setspritescale(de.selDot, de.selBoxScale, de.selBoxScale)
		//SetSpriteDepth(de.selDot, FRONT_DEPTH - 2)
		SetSpriteDepth(de.selDot, GUI_BEHIND_DEPTH - 2)

	endif
	
	deHide()
	
endfunction

//-----------------------------------------------------
//
function deShow()

	local i as integer
	local txt as integer
	local toks as string[]
	local s as string

	//coSetClearColor(co.yellow[0])
	coSetClearColor(co.grey[4])
	coSetBorderColor(co.grey[4])

	if WIN_MODE
		
		i = ma.apps[de.appIdx].screen
		
	else 
		
		if ma.apps[de.appIdx].status && LD_STATUS_MOB_LAND
			i = 2
		elseif ma.apps[de.appIdx].status && LD_STATUS_MOB_PORT
			i = 5
		else 
			i = 0	
		endif
		
	endif
		
	s = cdGetObjVarVals(OBJ_VAR_SCREEN, str(i), false)
	coSplitString(toks, s, " ")

	de.w = valfloat(toks[1]) // co.w
	de.h = valfloat(toks[3]) // co.h

	//SetVirtualResolution(de.w, de.h)

	de.bg = guiCreateBox("bg", de.w, de.h)
	SetSpriteDepth(de.bg, BACK_DEPTH)
	SetSpritePosition(de.bg, de.bgPos.x, de.bgPos.y)
	SetSpriteVisible(de.bg, false)
	deShowBgColor()

	//ld.set.gridCols = floor(de.w / ld.set.gridWidth)
	//ld.set.gridRows = floor(de.h / ld.set.gridHeight)
	ld.set.gridCols = floor(co.w / ld.set.gridWidth)
	ld.set.gridRows = floor(co.h / ld.set.gridHeight)
	
	//
	// Background.
	//
	de.bgOff.x = 0
	de.bgOff.y = 0
	
	//setpos(de.bg, de.bgPos.x, de.bgPos.y)
	SetSpriteVisible(de.bg, true)

	//SetSpriteVisible(de.pan.Back, true)
	//SetSpriteVisible(de.pan.Shadow, true)
		
	for i = 0 to de.sprs.length
		SetSpriteVisible(de.sprs[i], true)
	next

	//deShowGrid()

	de.thingIdx = -1
	de.varIdx = -1
	
	if de.appIdx > -1
		
		deInitVars()
		deInitThings()

	endif

	deShowPan()
	deMoveStuff(0, 0)

	if ld.set.showLayoutNames
		deShowNames()		
	endif

	guiSetButtonAlpha(de.runBut, 127)
	guiSetButtonVisible(de.runBut, true)

	guiSetButtonAlpha(de.backBut, 127)
	guiSetButtonVisible(de.backBut, true)
	
	guiSetButtonAlpha(de.moreBut, 127)
	guiSetButtonVisible(de.moreBut, true)

	deSetSettingsButtons()
	deSetButPos()
	deShowBgColor()
	
	guiHideBar(de.moreBar)
	guiHideBar(de.thingBar)
	guiHideTip(gui.tip)
		
endfunction

//-----------------------------------------------------
//
function deSetVarButtons()

	deSetVarBgColButton()
	deSetVarTitlePosButton()
	deSetVarTitleVisButton()
	deSetVarTitleColButton()
	deSetVarTitleFontButton()
	deSetVarBoxColButton()
	deSetVarTextColButton()
	deSetVarTextFontButton()
	deSetVarTitleAlignButton()
	deSetVarTextAlignButton()
	deSetVarTextSecretButton()

endfunction

//-----------------------------------------------------
// Save the title pos.
//
function deSaveVarTitlePos()

	if de.varIdx > -1

		if ma.vars[de.varIdx].v.titleDir = DIR_N	
			ma.vars[de.varIdx].v.titleDir = DIR_W
		elseif ma.vars[de.varIdx].v.titleDir = DIR_W
			ma.vars[de.varIdx].v.titleDir = DIR_S
		elseif ma.vars[de.varIdx].v.titleDir = DIR_S		
			ma.vars[de.varIdx].v.titleDir = DIR_E
		elseif ma.vars[de.varIdx].v.titleDir = DIR_E	
			ma.vars[de.varIdx].v.titleDir = DIR_N
		endif
		
		maSave()
		
	endif

endfunction

//-----------------------------------------------------
// Set the design button in settings to the current setting value.
//
function deSetVarTitlePosButton()

	local idx as integer

	if de.varIdx > -1

		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_POS)
	
		if ma.vars[de.varIdx].v.titleDir = DIR_N
	
			//SetSpriteAngle(de.varbar.buts[idx].icon, 0)
			SetSpriteAngle(de.varbar.buts[idx].icon, 90)
			//de.varbar.buts[idx].help = "Tap to change the position of title to the left."
			
		elseif ma.vars[de.varIdx].v.titleDir = DIR_W
	
			//SetSpriteAngle(de.varbar.buts[idx].icon, -90)
			SetSpriteAngle(de.varbar.buts[idx].icon, 0)
			//de.varbar.buts[idx].help = "Tap to change the position of title to the bottom."
	
		elseif ma.vars[de.varIdx].v.titleDir = DIR_S
	
			//SetSpriteAngle(de.varbar.buts[idx].icon, 180)
			SetSpriteAngle(de.varbar.buts[idx].icon, -90)
			//de.varbar.buts[idx].help = "Tap to change the position of title to the right."
	
		elseif ma.vars[de.varIdx].v.titleDir = DIR_E
	
			//SetSpriteAngle(de.varbar.buts[idx].icon, 90)
			SetSpriteAngle(de.varbar.buts[idx].icon, 180)
			//de.varbar.buts[idx].help = "Tap to change the position of title to the top."
	
		endif
		
	endif

endfunction

//-----------------------------------------------------
// Set the status of the sprite buttons.
//
function deSetSpriteButtons()

	local idx as integer

	if de.thingIdx > -1
		
		idx = guiFindBarButtonById(de.thingbar, BUT_DESIGN_SMOOTH_SCALING)
	
		if ma.things[de.thingIdx].smoothScaling
			guiSetButtonIcon2(de.thingbar.buts[idx], gui.onImg)		
		else
			guiSetButtonIcon2(de.thingbar.buts[idx], gui.offImg)
		endif
		
	endif

endfunction

//-----------------------------------------------------
// Set the visibility of the title.
//
function deSetVarTitleVisButton()

	local idx as integer

	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_VIS)
	
		if ma.vars[de.varIdx].v.titleVis
			guiSetButtonIcon2(de.varbar.buts[idx], gui.onImg)		
		else
			guiSetButtonIcon2(de.varbar.buts[idx], gui.offImg)
		endif
	
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_POS)
		guiSetButtonActive(de.varbar.buts[idx], ma.vars[de.varIdx].v.titleVis)
	
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_COL)
		guiSetButtonActive(de.varbar.buts[idx], ma.vars[de.varIdx].v.titleVis)
	
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_FONT)
		guiSetButtonActive(de.varbar.buts[idx], ma.vars[de.varIdx].v.titleVis)
	
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_FONT_SIZE)
		guiSetButtonActive(de.varbar.buts[idx], ma.vars[de.varIdx].v.titleVis)
	
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_ALIGN)
		guiSetButtonActive(de.varbar.buts[idx], ma.vars[de.varIdx].v.titleVis)
		
	endif

endfunction

//-----------------------------------------------------
// save the var title vis.
//
function deSaveVarTitleVis()

	if de.varIdx > -1

		if not ma.vars[de.varIdx].v.titleVis
				
			ma.vars[de.varIdx].v.titleVis = true
			maSave()
			
		else
			
			ma.vars[de.varIdx].v.titleVis = false
			maSave()
	
		endif
		
	endif

endfunction

//-----------------------------------------------------
// Set the color of the title.
//
function deSetVarTitleColButton()

	local idx as integer

	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_COL)
		coSetSpriteColor(de.varbar.buts[idx].icon, ma.vars[de.varIdx].v.titleCol)
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the color of the box.
//
function deSetVarBoxColButton()

	local idx as integer

	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_BOX_COL)
		coSetSpriteColor(de.varbar.buts[idx].icon, ma.vars[de.varIdx].v.boxCol)
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the color of the text.
//
function deSetVarTextColButton()

	local idx as integer

	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TEXT_COL)
		coSetSpriteColor(de.varbar.buts[idx].icon, ma.vars[de.varIdx].v.textCol)
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the color of the background.
//
function deSetVarBgColButton()

	local idx as integer
	
	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_VARBG_COL)
		coSetSpriteColor(de.varbar.buts[idx].icon, ma.vars[de.varIdx].v.bgCol)
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the color of the title.
//
function deSetVarTitleFontButton()

	local idx as integer
	local s as string 

	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_FONT_SIZE)
		//s = lower(cdGetObjVarVals(OBJ_VAR_FONT_SIZE, str(ma.vars[de.varIdx].v.titleFontSize), false))
		s = "size (" + str(ma.vars[de.varIdx].v.titleFontSize) + ")"
		guiSetButtonText(de.varbar.buts[idx], s)
	
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_FONT)
		s = lower(cdGetObjVarVals(OBJ_VAR_FONT, str(ma.vars[de.varIdx].v.titleFont), false))
		guiSetButtonText(de.varbar.buts[idx], s)
		
	endif

endfunction

//-----------------------------------------------------
// Set the font for the var text.
//
function deSetVarTextFontButton()

	local idx as integer
	local s as string 

	if de.varIdx > -1
	
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TEXT_FONT_SIZE)
		//s = lower(cdGetObjVarVals(OBJ_VAR_FONT_SIZE, str(ma.vars[de.varIdx].v.textFontSize), false))
		s = "size (" + str(ma.vars[de.varIdx].v.textFontSize) + ")"
		guiSetButtonText(de.varbar.buts[idx], s)
	
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TEXT_FONT)
		s = lower(cdGetObjVarVals(OBJ_VAR_FONT, str(ma.vars[de.varIdx].v.textFont), false))
		guiSetButtonText(de.varbar.buts[idx], s)
		
	endif

endfunction

//-----------------------------------------------------
// Show the secret status of the text.
//
function deSetVarTextSecretButton()

	local idx as integer

	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TEXT_SECRET)
	
		if ma.vars[de.varIdx].v.textSecret
			guiSetButtonIcon(de.varbar.buts[idx], de.secretOnImg)
		else
			guiSetButtonIcon(de.varbar.buts[idx], de.secretOffImg)
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the align of the title button.
//
function deSetVarTitleAlignButton()

	local idx as integer

	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TITLE_ALIGN)
	
		if ma.vars[de.varIdx].v.titleAlign = 0
			guiSetButtonIcon(de.varbar.buts[idx], de.leftImg)
		elseif ma.vars[de.varIdx].v.titleAlign = 1
			guiSetButtonIcon(de.varbar.buts[idx], de.centreImg)
		elseif ma.vars[de.varIdx].v.titleAlign = 2
			guiSetButtonIcon(de.varbar.buts[idx], de.rightImg)
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the align of the text button.
//
function deSetVarTextAlignButton()

	local idx as integer

	if de.varIdx > -1
		
		idx = guiFindBarButtonById(de.varbar, BUT_DESIGN_TEXT_ALIGN)
	
		if ma.vars[de.varIdx].v.textAlign = 0
			guiSetButtonIcon(de.varbar.buts[idx], de.leftImg)
		elseif ma.vars[de.varIdx].v.textAlign = 1
			guiSetButtonIcon(de.varbar.buts[idx], de.centreImg)
		elseif ma.vars[de.varIdx].v.textAlign = 2
			guiSetButtonIcon(de.varbar.buts[idx], de.rightImg)
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Launch the font size editor.
//
function deSaveVarTitleFontSize()

	if de.varIdx > -1

		inc ma.vars[de.varIdx].v.titleFontSize
	
		if ma.vars[de.varIdx].v.titleFontSize > co.fonts.length
			ma.vars[de.varIdx].v.titleFontSize = 1
		endif
	
		maSave()
		
	endif

endfunction

//-----------------------------------------------------
// Launch the font size editor.
//
function deSaveVarTitleFont()

	if de.varIdx > -1

		inc ma.vars[de.varIdx].v.titleFontSize
	
		if ma.vars[de.varIdx].v.titleFontSize > co.fonts.length
			ma.vars[de.varIdx].v.titleFontSize = 1
		endif
	
		maSave()
		
	endif

endfunction

//-----------------------------------------------------
// Save the text font.
//
function deSaveVarTextFontSize()

	if de.varIdx > -1

		inc ma.vars[de.varIdx].v.textFontSize
	
		if ma.vars[de.varIdx].v.textFontSize > co.fonts.length
			ma.vars[de.varIdx].v.textFontSize = 1
		endif
	
		maSave()
		
	endif

endfunction

//-----------------------------------------------------
// Save the text font.
//
function deSaveVarTextFont()

	if de.varIdx > -1

		inc ma.vars[de.varIdx].v.textFontSize
	
		if ma.vars[de.varIdx].v.textFontSize > co.fonts.length
			ma.vars[de.varIdx].v.textFontSize = 1
		endif
	
		maSave()
		
	endif

endfunction

//-----------------------------------------------------
// Save the text secret.
//
function deSaveVarTextSecret()

	if de.varIdx > -1

		if ma.vars[de.varIdx].v.textSecret
			ma.vars[de.varIdx].v.textSecret = false
		else 
			ma.vars[de.varIdx].v.textSecret = true
		endif
	
		maSave()
		
	endif

endfunction

//-----------------------------------------------------
//
function deSetSettingsButtons()

	//deSetSettingsDesignPosButton()
	deSetSettingsGridSnapButton()
	deSetSettingsGridRowsButton()
	deSetSettingsGridColsButton()
	deSetSettingsNamesButton()
	deSetSettingsPanButton()

endfunction

//-----------------------------------------------------
//
function deHide()

	local i as integer
	local j as integer
	local thingIdx as integer

	if de.bg
		
		//SetSpriteVisible(de.bg, false)
		deletesprite(de.bg)
		de.bg = 0
		
	endif
	
	guiSetButtonVisible(de.runBut, false)
	guiSetButtonVisible(de.backBut, false)
	guiSetButtonVisible(de.moreBut, false)
	guiHideBar(de.moreBar)
	guiHideBar(de.thingBar)
	guiHideBar(de.varBar)
	guiHideTip(gui.tip)
	deHideSel()
	
	for i = 0 to de.lines.length
		deletesprite(de.lines[i])
	next

	de.lines.length = -1

	deHidePan()
	
	for i = 0 to de.sprs.length
		SetSpriteVisible(de.sprs[i], false)
	next

	for i = 0 to de.depths.length

		thingIdx = de.depths[i].idx
		
		if ma.things[thingIdx].obj
			
			removeobject(ma.things[thingIdx].obj)
			ma.things[thingIdx].obj = 0
			
		endif

		ldUnloadThingImage(thingIdx, -1, LD_MODE_IMAGE)
		guiDeleteTip(ma.things[thingIdx].tip)

	next

	de.depths.length = -1

	for i = 0 to de.vardepths.length
		maDeleteVarView(ma.vars[de.vardepths[i].idx].v)
	next
	
	de.vardepths.length = -1

	de.thingIdx = -1
	de.varIdx = -1
	
endfunction

//-----------------------------------------------------
//
function deSetButPos()

	local x as float
	local dx as float
	local y as float
	local gap as float

	gap = co.bs / 4

	if ld.set.designButPos && DIR_N
		y = gap + GetSpriteHeight(de.backBut.bg) / 2
	else
		y = co.h - gap - GetSpriteHeight(de.backBut.bg) / 2
	endif

	if ld.set.designButPos && DIR_W
		
		x = gap + GetSpriteWidth(de.backBut.bg) / 2
		dx = 1
		
	else
		
		//x = de.w - gap - GetSpriteWidth(de.backBut.bg) / 2
		x = co.w - gap - GetSpriteWidth(de.backBut.bg) / 2
		dx = -1
		
	endif

	guiSetButtonPos(de.runBut, x, y)
	
	x = x + (GetSpriteWidth(ru.runBut.bg) * dx)
	guiSetButtonPos(de.backBut, x, y)

	x = x + (GetSpriteWidth(de.moreBut.bg) * dx)
	guiSetButtonPos(de.moreBut, x, y)

endfunction

//-----------------------------------------------------
// Show or hide the grid.
//
function deShowGrid()

	local i as integer
	local x as integer
	local y as integer
	local spr as integer
	local dx as integer
	local dy as integer
	local idx as integer
	local sx as float
	local sy as float
	
	for i = 0 to de.lines.length
		deletesprite(de.lines[i])
	next

	de.lines.length = -1

	if ld.set.snapToGrid

		//dx = co.w / ld.set.gridCols
		dx = ld.set.gridWidth
		sx = getspritex(de.bg)
		
		while sx > 0
			sx = sx - dx
		endwhile
		
		sx = sx + dx

		//for x = sx to co.w step dx
		x = sx
		//while x < de.w
		while x < co.w
			
			//spr = guicreatebox("deInit:spr", 2, de.h)
			spr = guicreatebox("deInit:spr", 2, co.h)
			coSetSpriteColor(spr, co.lightblue[1])
			SetSpriteDepth(spr, BACK_DEPTH - 2)
			SetSpritePosition(spr, x, 0)
			de.lines.insert(spr)
			x = x + dx
			
		//next
		endwhile

		//dy = co.h / ld.set.gridRows
		dy = ld.set.gridHeight
		sy = getspritey(de.bg)

		while sy > 0
			sy = sy - dy
		endwhile
		
		sy = sy + dy
		
		//for y = dy to co.h step dy
		y = sy
		//while y < de.h
		while y < co.h
			
			//spr = guicreatebox("deInit:spr", de.w, 2)
			spr = guicreatebox("deInit:spr", co.w, 2)
			coSetSpriteColor(spr, co.lightblue[1])
			SetSpriteDepth(spr, BACK_DEPTH - 2)
			SetSpritePosition(spr, 0, y)
			de.lines.insert(spr)
			y = y + dy
		
		//next
		endwhile
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the app.
//
function deSetApp(appIdx as integer)

	de.appIdx = appIdx
	
endfunction

//-----------------------------------------------------
// Set the thing.
//
function deSetThing(thingIdx as integer)

	de.thingIdx = thingIdx
	
endfunction

//-----------------------------------------------------
// Hide the selector.
//
function deHideSel()

	local i as integer

	for i = 0 to de.selLine.length
		SetSpriteVisible(de.selLine[i], false)
	next	

	if de.resizeAllowed
		
		for i = 0 to de.selBox.length
			SetSpriteVisible(de.selBox[i], false)		
		next

		SetSpriteVisible(de.selDot, false)
		SetSpriteVisible(de.selDotLine, false)

	endif
	
endfunction

//-----------------------------------------------------
// Show the selector.
//
function deShowSel()

	local x as float
	local y as float
	local w as float
	local h as float
	local spr as integer
	local i as integer
	local vis as integer
	local ang as float
	local boxSize as float
	local depth as integer
	local resize as integer
	local rotate as integer
	local cmd as integer

	vis = false
	spr = 0
	resize = false
	rotate = false

	if de.thingIdx > -1

		vis = true
		
		spr = getsprite(ma.things[de.thingIdx].obj)
		if ma.things[de.thingIdx].tip.box
			depth = getdepth(ma.things[de.thingIdx].tip.text2) - 1
		else
			depth = getdepth(spr)	
		endif
		w = GetSpriteWidth(spr)
		h = GetSpriteHeight(spr)
		x = GetSpriteX(spr)
		y = GetSpritey(spr)

		resize = true
		rotate = true

	elseif de.varIdx > -1

		vis = true

		depth = GetTextDepth(ma.vars[de.varIdx].v.text)
		w = GetSpriteWidth(ma.vars[de.varIdx].v.bg)
		h = GetSpriteHeight(ma.vars[de.varIdx].v.bg)
		x = GetSpriteX(ma.vars[de.varIdx].v.bg)
		y = GetSpriteY(ma.vars[de.varIdx].v.bg)

		resize = true
		
	endif

	for i = 0 to de.selLine.length		
		SetSpriteVisible(de.selLine[i], false)						
	next

	for i = 0 to de.selBox.length
		SetSpriteVisible(de.selBox[i], false)				
	next	

	SetSpriteVisible(de.selDot, false)
	SetSpriteVisible(de.selDotLine, false)

	if vis
		
		SetSpriteScale(de.selLine[0], w + DE_LINE_SIZE * 2, DE_LINE_SIZE)
		SetSpriteScale(de.selLine[1], w + DE_LINE_SIZE * 2, DE_LINE_SIZE)
		SetSpriteScale(de.selLine[2], DE_LINE_SIZE, h + DE_LINE_SIZE * 2)
		SetSpriteScale(de.selLine[3], DE_LINE_SIZE, h + DE_LINE_SIZE * 2)
		
		SetSpritePosition(de.selLine[0], x - DE_LINE_SIZE, y - DE_LINE_SIZE)
		SetSpriteOffset(de.selLine[0], GetSpriteWidth(de.selLine[0]) / 2, h / 2 + DE_LINE_SIZE)
		SetSpritePosition(de.selLine[1], x - DE_LINE_SIZE, y + h)
		SetSpriteOffset(de.selLine[1], GetSpriteWidth(de.selLine[1]) / 2, -(h / 2))
		SetSpritePosition(de.selLine[2], x - DE_LINE_SIZE, y - DE_LINE_SIZE)
		SetSpriteOffset(de.selLine[2], w / 2 + DE_LINE_SIZE, GetSpriteheight(de.selLine[2]) / 2)
		SetSpritePosition(de.selLine[3], x + w, y - DE_LINE_SIZE)
		SetSpriteOffset(de.selLine[3], -(w / 2), GetSpriteheight(de.selLine[3]) / 2)

		if rotate
			ang = getangle(ma.things[de.thingIdx].obj)
		endif

		for i = 0 to de.selLine.length
			
			//SetSpriteDepth(de.selLine[i], depth - 1)
			
			if rotate					
				setspriteangle(de.selLine[i], ang)
			else
				setspriteangle(de.selLine[i], 0)
			endif

			SetSpriteVisible(de.selLine[i], vis)
							
		next
		
		if resize and de.resizeAllowed

			boxSize = GetSpriteWidth(de.selDot)

			if rotate
				
				//SetSpriteScale(de.selDotLine, DE_LINE_SIZE, DE_DOT_LINE_SIZE + h / 2)
				SetSpriteScale(de.selDotLine, DE_LINE_SIZE, DE_DOT_LINE_SIZE)
				//SetSpritePosition(de.selDotLine, x + w / 2 - DE_LINE_SIZE / 2, y + h / 2 - GetSpriteHeight(de.selDotLine))
				//SetSpriteOffset(de.selDotLine, DE_LINE_SIZE / 2, GetSpriteHeight(de.selDotLine))
				SetSpritePosition(de.selDotLine, x + w / 2 - DE_LINE_SIZE / 2, y + h)
				SetSpriteOffset(de.selDotLine, DE_LINE_SIZE / 2, -(h / 2))
					
				//SetSpritePosition(de.selDot, x + w / 2 - boxSize / 2, GetSpritey(de.selDotLine) - boxSize / 2)
				//SetSpriteOffset(de.selDot, boxSize / 2, boxSize / 2 - getspriteheight(de.selDotLine))
				//SetSpritePosition(de.selDot, x + w / 2 - boxSize / 2, GetSpritey(de.selDotLine) + GetSpriteHeight(de.selDotLine) - boxSize / 2)
				//SetSpriteOffset(de.selDot, boxSize / 2, boxSize / 2 - getspriteheight(de.selDotLine))
				SetSpritePosition(de.selDot, x + w / 2 - boxSize / 2, y + h + GetSpriteHeight(de.selDotLine) - boxSize / 2)
				SetSpriteOffset(de.selDot, boxSize / 2, boxSize / 2 - GetSpriteHeight(de.selDotLine) - h / 2)

				//SetSpriteDepth(de.selDotLine, depth - 1)
				//SetSpriteDepth(de.selDot, depth - 2)
				
				setspriteangle(de.selDot, ang)
				SetSpriteVisible(de.selDot, vis)

				setspriteangle(de.selDotLine, ang)
				SetSpriteVisible(de.selDotLine, vis)
				
			endif
			
			SetSpritePosition(de.selBox[0], x - boxSize, y - boxSize)
			SetSpriteOffset(de.selBox[0], w / 2 + boxSize, h / 2 + boxSize)
			SetSpritePosition(de.selBox[1], x + w / 2 - boxSize / 2, y - boxSize)
			SetSpriteOffset(de.selBox[1], getspritewidth(de.selBox[1]) / 2, h / 2 + boxSize)
			SetSpritePosition(de.selBox[2], x + w, y - boxSize)
			SetSpriteOffset(de.selBox[2], -(w / 2), h / 2 + boxSize)
			SetSpritePosition(de.selBox[3], x - boxSize, y + h / 2 - boxSize / 2)
			SetSpriteOffset(de.selBox[3], w / 2 + boxSize, boxSize / 2)
			SetSpritePosition(de.selBox[4], x + w, y + h / 2 - boxSize / 2)
			SetSpriteOffset(de.selBox[4], -(w / 2), boxSize / 2)
			SetSpritePosition(de.selBox[5], x - boxSize, y + h)
			SetSpriteOffset(de.selBox[5], w / 2 + boxSize, -(h / 2))
			SetSpritePosition(de.selBox[6], x + w / 2 - boxSize / 2, y + h)
			SetSpriteOffset(de.selBox[6], getspritewidth(de.selBox[6]) / 2, -(h / 2))
			SetSpritePosition(de.selBox[7], x + w, y + h)
			SetSpriteOffset(de.selBox[7], -(w / 2), -(h / 2))
			
			for i = 0 to de.selBox.length

				//SetSpriteDepth(de.selBox[i], depth - 2)
				setspriteangle(de.selBox[i], ang)

				if vis
					if de.thingIdx > -1
						SetSpriteVisible(de.selBox[i], vis)
					elseif de.varIdx > -1 //and (i = 3 or i = 4)
						SetSpriteVisible(de.selBox[i], vis)
					endif
				else
					SetSpriteVisible(de.selBox[i], vis)
				endif
						
			next	

		endif

	endif
	
endfunction

//-----------------------------------------------------
// thingIdx is the array index of the selected item.
//
function deShowBar(xx as float, yy as float)

	local x as float
	local y as float
	local w as float
	local h as float
	local spr as integer

	if de.thingIdx > -1		
		spr = getsprite(ma.things[de.thingIdx].obj)		
	elseif de.varIdx > -1		
		spr = getsprite(ma.vars[de.varIdx].v.bg)		
	endif
	
	w = GetSpriteWidth(spr)
	h = GetSpriteHeight(spr)
	x = GetSpriteX(spr)
	y = GetSpritey(spr)

	// Popup at the point of press.
	w = co.bs / 4
	h = co.bs / 4
	x = xx - w / 2
	y = yy - h / 2
	
	if de.thingIdx > -1
		guiPopupBar(de.thingBar, x, y, w, h)		
	elseif de.varIdx > -1
		guiPopupBar(de.varBar, x, y, w, h)
	endif
	
endfunction

//-----------------------------------------------------
// Set the new bg color.
//
function deShowBgColor()
	
	coSetSpriteColor(de.bg, ld.set.deBgCol)

endfunction

//-----------------------------------------------------
// Show names on the things.
//
function deShowNames()

	local i as integer
	local idx as integer
	local thingIdx as integer
	
	if ld.set.showLayoutNames

		for i = 0 to ma.apps[de.appIdx].sprites.length

			thingIdx = ma.apps[de.appIdx].sprites[i]
			guiCreateTip(ma.things[thingIdx].tip, true)
			guiShowTip(ma.things[thingIdx].tip, getsprite(ma.things[thingIdx].obj), ma.things[thingIdx].name, TIP_PRINT, 0)

		next

		//maApplyThingDepths(de.depths)

	else

		for i = 0 to ma.apps[de.appIdx].sprites.length

			thingIdx = ma.apps[de.appIdx].sprites[i]
			guiDeleteTip(ma.things[thingIdx].tip)
			
		next
		
	endif
	
endfunction

//-----------------------------------------------------
// Reset the screen.
//
function deShowScreen()
	
	deHide()
	deShow()
	
endfunction

//-----------------------------------------------------
// 
function deDragThing(x as float, y as float)

	local px as float
	local py as float
	local mx as float
	local my as float
	local dx as float
	local dy as float

	// Middle.		
	px = x + de.bgPos.x - ma.things[de.thingIdx].offX
	py = y + de.bgPos.y - ma.things[de.thingIdx].offY

	if ld.set.snapToGrid

		if ld.set.snapGridVert = 0			
			px = px - GetWidth(ma.things[de.thingIdx].obj) / 2			
		elseif ld.set.snapGridVert = 2			
			px = px + getwidth(ma.things[de.thingIdx].obj) / 2
		endif

		if ld.set.snapGridHoriz = 0			
			py = py - GetHeight(ma.things[de.thingIdx].obj) / 2			
		elseif ld.set.snapGridHoriz = 2			
			py = py + getHeight(ma.things[de.thingIdx].obj) / 2
		endif

		px = deSnapPosToEditGrid(true, px, true)
		py = deSnapPosToEditGrid(false, py, true)		
		
		if ld.set.snapGridVert = 0			
			px = px + GetWidth(ma.things[de.thingIdx].obj) / 2
		elseif ld.set.snapGridVert = 2		
			px = px - getwidth(ma.things[de.thingIdx].obj) / 2		
		endif

		if ld.set.snapGridHoriz = 0			
			py = py + GetHeight(ma.things[de.thingIdx].obj) / 2			
		elseif ld.set.snapGridHoriz = 2			
			py = py - getHeight(ma.things[de.thingIdx].obj) / 2
		endif

	endif

	setpos(ma.things[de.thingIdx].obj, px, py)	
	
	deShowSel()
	
endfunction

//-----------------------------------------------------
// 
function deDragVar(x as float, y as float)

	local px as float
	local py as float
	local mx as float
	local my as float
	local dx as float
	local dy as float
	
	px = x + de.bgPos.x - ma.vars[de.varIdx].v.offX
	py = y + de.bgPos.y - ma.vars[de.varIdx].v.offY

	if ld.set.snapToGrid

		if ld.set.snapGridVert = 1		
			px = px + GetWidth(ma.vars[de.varIdx].v.bg) / 2		
		elseif ld.set.snapGridVert = 2			
			px = px + getwidth(ma.vars[de.varIdx].v.bg)
		endif

		if ld.set.snapGridHoriz = 1			
			py = py + GetHeight(ma.vars[de.varIdx].v.bg) / 2			
		elseif ld.set.snapGridHoriz = 2			
			py = py + getHeight(ma.vars[de.varIdx].v.bg)
		endif

		px = deSnapPosToEditGrid(true, px, true)
		py = deSnapPosToEditGrid(false, py, true)		

		if ld.set.snapGridVert = 1			
			px = px - GetWidth(ma.vars[de.varIdx].v.bg) / 2
		elseif ld.set.snapGridVert = 2		
			px = px - getwidth(ma.vars[de.varIdx].v.bg)		
		endif

		if ld.set.snapGridHoriz = 1			
			py = py - GetHeight(ma.vars[de.varIdx].v.bg) / 2			
		elseif ld.set.snapGridHoriz= 2			
			py = py - getHeight(ma.vars[de.varIdx].v.bg)
		endif

	endif
	
	maSetVarViewPos(ma.vars[de.varIdx].v, px, py)
	
	deShowSel()
	
endfunction

//-----------------------------------------------------
// 
function deResizeVarBox(x as float, y as float)

	local dx as float
	local dy as float
	local sx as float
	local sy as float
	local nx as float
	local ny as float
	local w as float
	local h as float
	local obj as integer
	local wx as float
	local xx as float
	local wy as float
	local yy as float
	local r as float
	local ang as float
	local cx as float
	local cy as float
	local spr as integer

	obj = ma.vars[de.varIdx].v.bg

	ang = -de.thingAng
	cx = de.thingX
	cy = de.thingY
		
	// Adjust by rotating to ang = 0, so calcs are easier.
	wx = cos(ang) * (de.waitX - cx) - sin(ang) * (de.waitY - cy) + cx
	wy = sin(ang) * (de.waitX - cx) + cos(ang) * (de.waitY - cy) + cy
	xx = cos(ang) * (x - cx) - sin(ang) * (y - cy) + cx
	yy = sin(ang) * (x - cx) + cos(ang) * (y - cy) + cy
	
	ang = getangle(obj)
	
	if de.boxIdx = 0

		dx = wx - xx
		dy = wy - yy
		nx = (de.thingW + dx) / de.thingW
		ny = (de.thingH + dy) / de.thingH

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		if nx < ny
			ny = nx
		else 
			nx = ny
		endif

		sx = de.thingSx * nx
		if sx < ma.vars[de.varIdx].v.mw then sx = ma.vars[de.varIdx].v.mw
		setscalex(obj, sx)
		dx = -(getwidth(obj) - de.thingW) / 2

		sy = de.thingSy * ny	
		if sy < ma.vars[de.varIdx].v.mh then sy = ma.vars[de.varIdx].v.mh
		setscaley(obj, sy)
		dy = -(getheight(obj) - de.thingH) / 2
		
	elseif de.boxIdx = 1

		dy = wy - yy
		ny = (de.thingH + dy) / de.thingH

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		sy = de.thingSy * ny	
		if sy < ma.vars[de.varIdx].v.mh then sy = ma.vars[de.varIdx].v.mh
		setscaley(obj, sy)
		dy = -(getheight(obj) - de.thingH) / 2

	elseif de.boxIdx = 2

		dx = xx - wx
		dy = wy - yy
		nx = (de.thingW + dx) / de.thingW
		ny = (de.thingH + dy) / de.thingH

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		if nx < ny
			ny = nx
		else 
			nx = ny
		endif

		sx = de.thingSx * nx
		if sx < ma.vars[de.varIdx].v.mw then sx = ma.vars[de.varIdx].v.mw
		setscalex(obj, sx)
		dx = (getwidth(obj) - de.thingW) / 2

		sy = de.thingSy * ny	
		if sy < ma.vars[de.varIdx].v.mh then sy = ma.vars[de.varIdx].v.mh
		setscaley(obj, sy)
		dy = -(getheight(obj) - de.thingH) / 2

	elseif de.boxIdx = 3

		dx = wx - xx
		nx = (de.thingW + dx) / de.thingW

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		sx = de.thingSx * nx
		if sx < ma.vars[de.varIdx].v.mw then sx = ma.vars[de.varIdx].v.mw
		setscalex(obj, sx)
		dx = -(getwidth(obj) - de.thingW) / 2

	elseif de.boxIdx = 4

		dx = xx - wx
		nx = (de.thingW + dx) / de.thingW

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		sx = de.thingSx * nx
		if sx < ma.vars[de.varIdx].v.mw then sx = ma.vars[de.varIdx].v.mw
		setscalex(obj, sx)
		dx = (getwidth(obj) - de.thingW) / 2

	elseif de.boxIdx = 5

		dx = wx - xx
		dy = yy - wy
		nx = (de.thingW + dx) / de.thingW
		ny = (de.thingH + dy) / de.thingH

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		if nx < ny
			ny = nx
		else 
			nx = ny
		endif

		sx = de.thingSx * nx
		if sx < ma.vars[de.varIdx].v.mw then sx = ma.vars[de.varIdx].v.mw
		setscalex(obj, sx)
		dx = -(getwidth(obj) - de.thingW) / 2

		sy = de.thingSy * ny	
		if sy < ma.vars[de.varIdx].v.mh then sy = ma.vars[de.varIdx].v.mh
		setscaley(obj, sy)
		dy = (getheight(obj) - de.thingH) / 2
		
	elseif de.boxIdx = 6

		dy = yy - wy
		ny = (de.thingH + dy) / de.thingH

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		sy = de.thingSy * ny	
		if sy < ma.vars[de.varIdx].v.mh then sy = ma.vars[de.varIdx].v.mh
		setscaley(obj, sy)
		dy = (getheight(obj) - de.thingH) / 2

	elseif de.boxIdx = 7

		dx = xx - wx
		dy = yy - wy
		nx = (de.thingW + dx) / de.thingW
		ny = (de.thingH + dy) / de.thingH

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		if nx < ny
			ny = nx
		else 
			nx = ny
		endif
		
		sx = de.thingSx * nx
		if sx < ma.vars[de.varIdx].v.mw then sx = ma.vars[de.varIdx].v.mw
		setscalex(obj, sx)
		dx = (getwidth(obj) - de.thingW) / 2

		sy = de.thingSy * ny	
		if sy < ma.vars[de.varIdx].v.mh then sy = ma.vars[de.varIdx].v.mh
		setscaley(obj, sy)
		dy = (getheight(obj) - de.thingH) / 2
		
	endif

/*
	// X movement.
	if not (de.boxIdx = 1 or de.boxIdx = 6)
            		
		if de.boxIdx = 0 or de.boxIdx = 3 or de.boxIdx = 5 // Left.	

			dx = wx - xx
			nx = (de.thingW + dx) / de.thingW
			sx = de.thingSx * nx
			//if sx < DE_SMALLEST_SCALE then sx = DE_SMALLEST_SCALE
			if sx < ma.vars[de.varIdx].v.mw then sx = ma.vars[de.varIdx].v.mw
			setscalex(obj, sx)
			dx = -(getwidth(obj) - de.thingW) / 2

		elseif de.boxIdx = 2 or de.boxIdx = 4 or de.boxIdx = 7 // Right.

			dx = xx - wx
			nx = (de.thingW + dx) / de.thingW
			sx = de.thingSx * nx
			//if sx < DE_SMALLEST_SCALE then sx = DE_SMALLEST_SCALE
			if sx < ma.vars[de.varIdx].v.mw then sx = ma.vars[de.varIdx].v.mw
			setscalex(obj, sx)
			dx = (getwidth(obj) - de.thingW) / 2

		endif

	endif

	// Y movement.
	if not (de.boxIdx = 3 or de.boxIdx = 4)

		if de.boxIdx = 0 or de.boxIdx = 1 or de.boxIdx = 2 // Up.

			//dy = de.waitY - y
			dy = wy - yy
			ny = (de.thingH + dy) / de.thingH
			sy = de.thingSy * ny	
			//if sy < DE_SMALLEST_SCALE then sy = DE_SMALLEST_SCALE
			if sy < ma.vars[de.varIdx].v.mh then sy = ma.vars[de.varIdx].v.mh
			setscaley(obj, sy)
			dy = -(getheight(obj) - de.thingH) / 2
			
		elseif de.boxIdx = 5 or de.boxIdx = 6 or de.boxIdx = 7 // Down.
				
			//dy = y - de.waitY
			dy = yy - wy
			ny = (de.thingH + dy) / de.thingH
			sy = de.thingSy * ny	
			//if sy < DE_SMALLEST_SCALE then sy = DE_SMALLEST_SCALE
			if sy < ma.vars[de.varIdx].v.mh then sy = ma.vars[de.varIdx].v.mh
			setscaley(obj, sy)
			dy = (getheight(obj) - de.thingH) / 2
			
		endif

	endif
*/
	
	// Adjust back by rotating back to ang.
	x = de.thingX + dx
	y = de.thingY + dy
	wx = cos(ang) * (x - cx) - sin(ang) * (y - cy) + cx
	wy = sin(ang) * (x - cx) + cos(ang) * (y - cy) + cy
	setpos(obj, wx, wy)
	
	deShowSel()
	
endfunction

//-----------------------------------------------------
// 
function deResizeThingBox(x as float, y as float)

	local dx as float
	local dy as float
	local sx as float
	local sy as float
	local nx as float
	local ny as float
	local w as float
	local h as float
	local obj as integer
	local wx as float
	local wy as float
	local xx as float
	local yy as float
	local r as float
	local ang as float
	local cx as float
	local cy as float
	local spr as integer
	local ox as float
	local oy as float

	obj = ma.things[de.thingIdx].obj
	ang = -de.thingAng
	cx = de.thingX
	cy = de.thingY
					
	// Adjust by rotating to ang = 0, so calcs are easier.
	wx = cos(ang) * (de.waitX - cx) - sin(ang) * (de.waitY - cy) + cx
	wy = sin(ang) * (de.waitX - cx) + cos(ang) * (de.waitY - cy) + cy
	xx = cos(ang) * (x - cx) - sin(ang) * (y - cy) + cx
	yy = sin(ang) * (x - cx) + cos(ang) * (y - cy) + cy
	ang = getangle(obj)

	if de.boxIdx = 0

		dx = wx - xx		
		dy = wy - yy	
		
		nx = (de.thingW + dx) / de.thingW
		ny = (de.thingH + dy) / de.thingH

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif
		
		if nx < ny
			ny = nx
		else 
			nx = ny
		endif
				
		sx = de.thingSx * nx
		sy = de.thingSy * ny
				
		setscalexy(obj, sx, sy)
		dx = -(getwidth(obj) - de.thingW) / 2
		dy = -(getheight(obj) - de.thingH) / 2
		
	elseif de.boxIdx = 1
		
		dy = wy - yy
		
		ny = (de.thingH + dy) / de.thingH
		
		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		sy = de.thingSy * ny	

		setscaley(obj, sy)
		dy = -(getheight(obj) - de.thingH) / 2

	elseif de.boxIdx = 2

		dx = xx - wx
		dy = wy - yy

		nx = (de.thingW + dx) / de.thingW
		ny = (de.thingH + dy) / de.thingH

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		if nx < ny
			ny = nx
		else 
			nx = ny
		endif
		
		sx = de.thingSx * nx
		sy = de.thingSy * ny	

		setscalexy(obj, sx, sy)
		
		dx = (getwidth(obj) - de.thingW) / 2
		dy = -(getheight(obj) - de.thingH) / 2

	elseif de.boxIdx = 3

		dx = wx - xx
		
		nx = (de.thingW + dx) / de.thingW
		
		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		sx = de.thingSx * nx
		setscalex(obj, sx)
		dx = -(getwidth(obj) - de.thingW) / 2

	elseif de.boxIdx = 4

		dx = xx - wx
		
		nx = (de.thingW + dx) / de.thingW

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif
		
		sx = de.thingSx * nx

		setscalex(obj, sx)
		dx = (getwidth(obj) - de.thingW) / 2

	elseif de.boxIdx = 5
		
		dx = wx - xx
		dy = yy - wy
		
		nx = (de.thingW + dx) / de.thingW
		ny = (de.thingH + dy) / de.thingH

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		if nx < ny
			ny = nx
		else 
			nx = ny
		endif

		sx = de.thingSx * nx
		sy = de.thingSy * ny	

		setscalexy(obj, sx, sy)
		dx = -(getwidth(obj) - de.thingW) / 2
		dy = (getheight(obj) - de.thingH) / 2

	elseif de.boxIdx = 6

		dy = yy - wy
		
		ny = (de.thingH + dy) / de.thingH

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		sy = de.thingSy * ny	
		
		setscaley(obj, sy)
		dy = (getheight(obj) - de.thingH) / 2

	elseif de.boxIdx = 7
		
		dx = xx - wx
		dy = yy - wy
		
		nx = (de.thingW + dx) / de.thingW
		ny = (de.thingH + dy) / de.thingH

		if de.thingW * nx < DE_SMALLEST_SIZE
			nx = DE_SMALLEST_SIZE / de.thingW
		endif

		if de.thingH * ny < DE_SMALLEST_SIZE
			ny = DE_SMALLEST_SIZE / de.thingH
		endif

		if nx < ny
			ny = nx
		else 
			nx = ny
		endif

		sx = de.thingSx * nx
		sy = de.thingSy * ny	
		
		setscalexy(obj, sx, sy)
		dx = (getwidth(obj) - de.thingW) / 2
		dy = (getheight(obj) - de.thingH) / 2

	endif

	// Adjust back by rotating back to ang.
	x = de.thingX + dx
	y = de.thingY + dy

	wx = cos(ang) * (x - cx) - sin(ang) * (y - cy) + cx
	wy = sin(ang) * (x - cx) + cos(ang) * (y - cy) + cy
	setpos(ma.things[de.thingIdx].obj, wx, wy)
	
	deShowSel()
	
endfunction

//-----------------------------------------------------
// 
function deRotThingBox(x as float, y as float)

	local obj as integer
	local da as float
	local ang as float
	local a as float
	
	obj = ma.things[de.thingIdx].obj
	//ang = atanfull(x - de.thingX, y - de.thingY)
	ang = atanfull(x - de.thingX, y - de.thingY)
	ang = ang + 180

	if ang >= 360
		ang = ang - 360
	elseif ang < 0
		ang = ang + 360
	endif
	
	setangle(ma.things[de.thingIdx].obj, ang)

	deShowSel()
	
endfunction

//-----------------------------------------------------
// Get the idx of a selbox if pressed.
//
function deGetBoxPressed(x as float, y as float)

	local idx as integer

	idx = -1
	
	if GetSpriteVisible(de.selBox[0]) and getspritehittest(de.selBox[0], x, y)
		idx = 0
	elseif GetSpriteVisible(de.selBox[1]) and getspritehittest(de.selBox[1], x, y)
		idx = 1
	elseif GetSpriteVisible(de.selBox[2]) and getspritehittest(de.selBox[2], x, y)
		idx = 2
	elseif GetSpriteVisible(de.selBox[3]) and getspritehittest(de.selBox[3], x, y)
		idx = 3
	elseif GetSpriteVisible(de.selBox[4]) and getspritehittest(de.selBox[4], x, y)
		idx = 4
	elseif GetSpriteVisible(de.selBox[5]) and getspritehittest(de.selBox[5], x, y)
		idx = 5
	elseif GetSpriteVisible(de.selBox[6]) and getspritehittest(de.selBox[6], x, y)
		idx = 6
	elseif GetSpriteVisible(de.selBox[7]) and getspritehittest(de.selBox[7], x, y)
		idx = 7
	elseif GetSpriteVisible(de.selDot) and getspritehittest(de.selDot, x, y)
		idx = 8
	endif
	
endfunction idx

//-----------------------------------------------------
// Search for a thing based on the pressed location and depth.
// -1 if not over a thing.
//
function deFindThing(x as float, y as float)

	local idx as integer
	local i as integer
	local spr as integer

	idx = -1

	for i = 0 to de.depths.length

		if de.depths[i].idx > -1
			
			if GetspriteHitTest(getsprite(ma.things[de.depths[i].idx].obj), x, y)

				idx = de.depths[i].idx
				exit
				
			endif

		endif
		
	next

endfunction idx

//-----------------------------------------------------
// Search for a VAR based on the pressed location and depth.
// -1 if not over a VAR.
//
function deFindVar(x as float, y as float)

	local i as integer
	local j as integer
	local spr as integer
	local idx as integer
	local varIdx as integer
	local thingIdx as integer
	local cmd as integer

	idx = -1
	
	for i = 0 to de.vardepths.length
			
		varIdx = de.vardepths[i].idx

		if ma.vars[varIdx].v.bg

			if coPointWithinRect(x, y, getspritex(ma.vars[varIdx].v.bg), getspritey(ma.vars[varIdx].v.bg), GetSpriteWidth(ma.vars[varIdx].v.bg), GetSpriteHeight(ma.vars[varIdx].v.bg))
				
				idx = varIdx
				exit
				
			endif
			
		endif
					
	next
	
endfunction idx

//-----------------------------------------------------
// Init things.
//
function deInitThings()

	local i as integer
	local thingIdx as integer
	local sx as float
	local sy as float
	local img as integer
	
	for i = 0 to ma.apps[de.appIdx].sprites.length

		thingIdx = ma.apps[de.appIdx].sprites[i]
		
		if not ma.things[thingIdx].obj

			ldLoadThingImage(de.appIdx, thingIdx, ma.things[thingIdx].imgIdx, LD_MODE_IMAGE)					
			ma.things[thingIdx].obj = createobject(ma.things[thingIdx].imgs[ma.things[thingIdx].imgIdx].img)

			img = GetSpriteImageID(ma.things[thingIdx].obj)
			SetImageMinFilter(img, ma.things[thingIdx].smoothScaling)
			SetImageMagFilter(img, ma.things[thingIdx].smoothScaling)
		
		endif

		//SetSpriteShape(ma.things[thingIdx].obj, 1)
		//if ma.things[thingIdx].moved
			setpos(ma.things[thingIdx].obj, ma.things[thingIdx].x, ma.things[thingIdx].y)
		//else 
		//	setpos(ma.things[thingIdx].obj, de.w / 2, de.h / 2)
		//endif
		
		setangle(ma.things[thingIdx].obj, ma.things[thingIdx].ang)

		if ma.things[thingIdx].w > 0
			sx = ma.things[thingIdx].w / GetSpriteWidth(ma.things[thingIdx].obj)
		else 
			sx = ma.things[thingIdx].sx
		endif

		setscalex(ma.things[thingIdx].obj, sx)

		if ma.things[thingIdx].h > 0
			sy = ma.things[thingIdx].h / GetSpriteHeight(ma.things[thingIdx].obj)
		else 
			sy = ma.things[thingIdx].sy
		endif

		setscaley(ma.things[thingIdx].obj, sy)			
		setvisible(ma.things[thingIdx].obj, true)
		
	next

	maMakeThingDepths(de.depths, de.appIdx)
	maApplyThingDepths(de.depths)

endfunction

//-----------------------------------------------------
// Init vars.
//
function deInitVars()

	local i as integer
	local j as integer
	local thingIdx as integer
	local varIdx as integer
	local depth as integer
	local td as Depth
	local vars as integer[]

	de.vardepths.length = -1
	
	if de.appIdx > -1
		
		for i = 0 to ma.apps[de.appIdx].vars.length
			
			varIdx = ma.apps[de.appIdx].vars[i]
			deShowVar(varIdx)

			td.idx = varIdx
			de.vardepths.insert(td)
			
		next
		
		for i = 0 to ma.apps[de.appIdx].sprites.length

			thingIdx = ma.apps[de.appIdx].sprites[i]
			
			for j = 0 to ma.things[thingIdx].vars.length
				
				varIdx = ma.things[thingIdx].vars[j]
				deShowVar(varIdx)

				td.idx = varIdx
				de.vardepths.insert(td)
				
			next

		next
		
	endif

	deApplyVarDepths(de.vardepths)
	
endfunction

//-----------------------------------------------------
// Reset all thing depths.
//
function deApplyVarDepths(depths ref as Depth[])

	local i as integer
	local visDepth as integer
	local depthRange as integer
	local depthDiv as integer

	depthRange = (VAR_DEPTH_MAX * VAR_DEPTH_SKIP) // + VAR_DEPTH_BASE	
	depthDiv = depthRange / (depths.length + 2) 
	visDepth = VAR_DEPTH_BASE // depthDiv
	
	for i = 0 to depths.length
		
		ma.vars[depths[i].idx].v.depth = visDepth
		maSetVarViewDepth(ma.vars[depths[i].idx].v, ma.vars[depths[i].idx].v.depth)
		visDepth = visDepth + depthDiv
		
	next

endfunction

//-----------------------------------------------------
// Rebuild the var view.
//
function deRebuildVarView(var as integer)

	maDeleteVarView(ma.vars[var].v)
	maCreateVarView(ma.vars[var].v)
	maSetVarViewPos(ma.vars[var].v, ma.vars[var].v.x, ma.vars[var].v.y)
	//deSetVarViewDepth(de.varIdx)
	maSetVarViewDepth(ma.vars[var].v, ma.vars[var].v.depth)
	deShowSel()
	deShowPan()

endfunction

//-----------------------------------------------------
// Show a var if it needs to be shown.
//
function deShowVar(varIdx as integer)

	local selIdx as integer
	local part as Part
	local name as string
	local pos as integer
	
	if ma.vars[varIdx].vis

		if not ma.vars[varIdx].v.bg

			ma.vars[varIdx].v.name = ma.vars[varIdx].name
			maCreateVarView(ma.vars[varIdx].v)
			maSetVarViewPos(ma.vars[varIdx].v, ma.vars[varIdx].v.x, ma.vars[varIdx].v.y)
	
		endif
			
	endif

endfunction

//-----------------------------------------------------
// 
function dePressed(x as float, y as float)

	local thingIdx as integer
	local varIdx as integer
	local hitThingIdx as integer
	local hitVarIdx as integer
	local idx as integer
	local i as integer

	if cdIsEditActive()

		cdPressed(x, y)
		exitfunction
		
	endif

	if de.pressed
		exitfunction
	endif
	
	de.pressed = true

	if ma.helpInter.howTo
		if maCheckHelpInterPress(de.mode, x, y)
			exitfunction
		endif		
	endif
	
	guiHideBar(de.moreBar)
	guiHideBar(de.thingBar)
	guiHideTip(gui.tip)

	de.mode = DE_MODE_NONE
	
	if guiGetButtonPressed(de.backBut, x, y, 1)

		de.mode = DE_MODE_BACK_BUT

	elseif guiGetButtonPressed(de.runBut, x, y, 1)

		de.mode = DE_MODE_RUN_BUT

	elseif guiGetButtonPressed(de.runBut, x, y, 2)

		de.mode = DE_MODE_RUN_BUT

	elseif guiGetButtonPressed(de.moreBut, x, y, 1)
		
		de.mode = DE_MODE_MORE_BAR
		guiPopupBar(de.moreBar, getspritex(de.moreBut.bg), getspritey(de.moreBut.bg), getspritewidth(de.moreBut.bg), getspriteheight(de.moreBut.bg))

	endif

	if de.mode = DE_MODE_NONE

		if GetSpriteVisible(de.pan.Back) and coPointWithinRect(x, y, getspritex(de.pan.Back), getspritey(de.pan.Back), GetSpriteWidth(de.pan.Back), GetSpriteHeight(de.pan.Back))

			de.mode = DE_MODE_PAN
			deMovePan(x, y)
					
		endif
		
	endif

	if de.mode = DE_MODE_NONE
					
		if de.varIdx > -1

			//hitVarIdx = deFindVar(x, y)

			// If not the same hit, then we don't check for selection box points.
			//if hitVarIdx = -1 or hitVarIdx = de.varIdx

				// Check box press on current var.
				idx = deGetBoxPressed(x, y)

				if idx > -1

					if de.resizeAllowed
						
						de.boxIdx = idx
						de.waitX = x
						de.waitY = y
						de.dragox = deGetEditSelBoxPosOffset(de.boxIdx, true, x)
						de.dragoy = deGetEditSelBoxPosOffset(de.boxIdx, false, y)						
						de.thingX = getposx(ma.vars[de.varIdx].v.bg)
						de.thingY = getposy(ma.vars[de.varIdx].v.bg)
						de.thingW = GetWidth(ma.vars[de.varIdx].v.bg)
						de.thingH = GetHeight(ma.vars[de.varIdx].v.bg)
						de.thingSx = getscalex(ma.vars[de.varIdx].v.bg)
						de.thingSy = getscaley(ma.vars[de.varIdx].v.bg)
						de.thingAng = getangle(ma.vars[de.varIdx].v.bg)

						de.mode = DE_MODE_RESIZE_VAR_BOX

					endif
					
				endif

			//endif
			
		endif

	endif
	
	if de.mode = DE_MODE_NONE
		
		if de.thingIdx > -1

			//hitThingIdx = deFindThing(x, y)

			// If not the same hit, then we don't check for selection box points.
			//if hitThingIdx = -1 or hitThingIdx = de.thingIdx
				
				// Check box press on current sprite.
				idx = deGetBoxPressed(x, y)

				if idx > -1

					if de.resizeAllowed
						
						de.boxIdx = idx
						de.waitX = x
						de.waitY = y
						de.thingX = getposx(ma.things[de.thingIdx].obj)
						de.thingY = getposy(ma.things[de.thingIdx].obj)
						de.thingW = getwidth(ma.things[de.thingIdx].obj)
						de.thingH = getheight(ma.things[de.thingIdx].obj)
						de.thingSx = getscalex(ma.things[de.thingIdx].obj)
						de.thingSy = getscaley(ma.things[de.thingIdx].obj)	
						de.thingAng = getangle(ma.things[de.thingIdx].obj)

						if idx = 8 // Dot for rotation.
							
							de.mode = DE_MODE_ROT_THING_BOX
							
						else

							de.dragox = deGetEditSelBoxPosOffset(de.boxIdx, true, x)
							de.dragoy = deGetEditSelBoxPosOffset(de.boxIdx, false, y)						
							de.mode = DE_MODE_RESIZE_THING_BOX

						endif

					endif
					
				endif

			//endif
			
		endif

	endif

	if de.mode = DE_MODE_NONE

		varIdx = deFindVar(x, y)

		if varIdx > -1

			de.varIdx = varIdx
			de.thingIdx = -1
			de.waitStart = GetMilliseconds()
			de.waitX = x
			de.waitY = y
			de.mode = DE_MODE_WAIT_VAR

			deShowSel()
			deSetVarButtons()

		endif
		
	endif

	if de.mode = DE_MODE_NONE

		thingIdx = deFindThing(x, y)

		if thingIdx > -1

			de.thingIdx = thingIdx
			de.varIdx = -1
			de.waitStart = GetMilliseconds()
			de.waitX = x
			de.waitY = y
			de.mode = DE_MODE_WAIT_THING

			deShowSel()
			deSetSpriteButtons()

		endif

	endif

	if de.mode = DE_MODE_NONE
			
		de.mode = DE_MODE_SCROLL
		de.bgOff.x = x
		de.bgOff.y = y
		
	endif
		
endfunction

//-----------------------------------------------------
// 
function deMoved(x as float, y as float)

	local cmd as integer
	
	if cdIsEditActive()

		cdMoved(x, y)
		exitfunction
		
	endif

	if de.mode = DE_MODE_WAIT_THING

		if coLeftDown(coDist(de.waitX, de.waitY, x, y) > CD_CODE_HOLD_DIST)

			ma.things[de.thingIdx].offX = x - ma.things[de.thingIdx].x
			ma.things[de.thingIdx].offY = y - ma.things[de.thingIdx].y
			de.mode = DE_MODE_DRAG_THING
			
		elseif coRightDown((GetMilliseconds() - de.waitStart) > CD_CODE_HOLD_TIME)

			de.mode = DE_MODE_THING_BAR
			deShowBar(x, y)
				
		endif

	elseif de.mode = DE_MODE_WAIT_VAR

		if coLeftDown(coDist(de.waitX, de.waitY, x, y) > CD_CODE_HOLD_DIST)

			ma.vars[de.varIdx].v.offX = x - ma.vars[de.varIdx].v.x
			ma.vars[de.varIdx].v.offY = y - ma.vars[de.varIdx].v.y
			de.mode = DE_MODE_DRAG_VAR
			
		elseif coRightDown((GetMilliseconds() - de.waitStart) > CD_CODE_HOLD_TIME)

			de.mode = DE_MODE_VAR_BAR
			deSetVarButtons()
			deShowBar(x, y)
				
		endif

	elseif de.mode = DE_MODE_DRAG_THING
 
		deDragThing(x, y)

		if ld.set.showLayoutNames
			guiShowTip(ma.things[de.thingIdx].tip, getsprite(ma.things[de.thingIdx].obj), ma.things[de.thingIdx].name, TIP_PRINT, 0)
		endif
		
	elseif de.mode = DE_MODE_DRAG_VAR
 
		deDragVar(x, y)

	elseif de.mode = DE_MODE_ROT_THING_BOX
 
		deRotThingBox(x, y)

		if ld.set.showLayoutNames
			guiShowTip(ma.things[de.thingIdx].tip, getsprite(ma.things[de.thingIdx].obj), ma.things[de.thingIdx].name, TIP_PRINT, 0)
		endif
		
	elseif de.mode = DE_MODE_RESIZE_THING_BOX

		//if getangle(ma.things[de.thingIdx].obj) = 0 and ld.set.snapToGrid				
		if ld.set.snapToGrid				

			x = deSnapPosToEditGrid(true, x, false) - de.dragox
			y = deSnapPosToEditGrid(false, y, false) - de.dragoy
			
		endif

		deResizeThingBox(x, y)

		if ld.set.showLayoutNames
			guiShowTip(ma.things[de.thingIdx].tip, getsprite(ma.things[de.thingIdx].obj), ma.things[de.thingIdx].name, TIP_PRINT, 0)
		endif

	elseif de.mode = DE_MODE_RESIZE_VAR_BOX

		if ld.set.snapToGrid				

			x = deSnapPosToEditGrid(true, x, false) - de.dragox
			y = deSnapPosToEditGrid(false, y, false) - de.dragoy
			
		endif

		deResizeVarBox(x, y)
		ma.vars[de.varIdx].v.x = Getspritex(ma.vars[de.varIdx].v.bg)
		ma.vars[de.varIdx].v.y = Getspritey(ma.vars[de.varIdx].v.bg)
		ma.vars[de.varIdx].v.w = GetWidth(ma.vars[de.varIdx].v.bg)
		ma.vars[de.varIdx].v.h = GetHeight(ma.vars[de.varIdx].v.bg)
		maCreateVarView(ma.vars[de.varIdx].v)
		maSetVarViewPos(ma.vars[de.varIdx].v, ma.vars[de.varIdx].v.x, ma.vars[de.varIdx].v.y)
		
	elseif de.mode = DE_MODE_THING_BAR

		guiCheckBarPressed(de.thingBar, x, y, 2)

	elseif de.mode = DE_MODE_MORE_BAR

		guiCheckBarPressed(de.moreBar, x, y, 1)

	elseif de.mode = DE_MODE_VAR_BAR

		guiCheckBarPressed(de.varBar, x, y, 2)

	elseif de.mode = DE_MODE_SCROLL
		
		deMoveStuff(x, y)

	elseif de.mode = DE_MODE_PAN

		//if coPointWithinRect(x, y, getspritex(de.pan.Back), getspritey(de.pan.Back), GetSpriteWidth(de.pan.Back), GetSpriteHeight(de.pan.Back))		
			deMovePan(x, y)
		//endif

	endif
	
endfunction

//-----------------------------------------------------
// Get the offset of the press location 'pos' vs. the corner of the box.
//
function deGetEditSelBoxPosOffset(idx as integer, xpos as integer, pos as float)

	local spr as integer
	local off as float
	
	spr = de.selBox[idx]

	if xpos

		if idx = 0 or idx = 3 or idx = 5
			off = GetSpriteX(spr) + GetSpriteWidth(spr) - pos
		elseif idx = 2 or idx = 4 or idx = 7
			off = getspritex(spr) - pos
		elseif idx = 1 or 6
			off = GetSpriteX(spr)
		endif

	else

		if idx = 0 or idx = 1 or idx = 2
			off = GetSpriteY(spr) + GetSpriteHeight(spr) - pos
		elseif idx = 5 or idx = 6 or idx = 7
			off = getspritey(spr) - pos
		elseif idx = 1 or 6
			off = GetSpritey(spr)
		endif

	endif
	
endfunction off


//-----------------------------------------------------
// Snap pos to the grid and return it.
// xdir = true mean horiz axis.
// pos is the position in the "xdir" direction.
// start is true if x0, y0, otherwise x1, y1.
//
function deSnapPosToEditGrid(xdir as integer, pos as float, start as integer)

	local i as integer
	local x as float
	local y as float
	local xx as float
	local yy as float
	local dx as float
	local dy as float
	local tx as float
	local ty as float

/*
	if xdir
		
		xx = pos
		tx = 0xffffff
		
		for i = 0 to de.lines.length
			
			//x = GetSpriteXByOffset(cd.edimg.gridColLines[i])
			x = GetSpriteX(de.lines[i])
			dx = pos - x
			
			if abs(dx) < abs(tx)
				
				tx = dx
				xx = x
				
			endif
			
		next

		pos = xx

	else
		
		yy = pos
		ty = 0xffffff

		for i = 0 to de.lines.length
			
			//y = GetSpriteYByOffset(cd.edimg.gridRowLines[i])
			y = GetSpriteY(de.lines[i])
			dy = pos - y
			
			if abs(dy) < abs(ty)
				
				ty = dy
				yy = y
				
			endif
			
		next

		pos = yy

	endif
*/

	if xdir
		
		x = pos - de.bgPos.x
		xx = floor(x / ld.set.gridWidth) * ld.set.gridWidth
		pos = xx + de.bgPos.x
		
	else 
		
		y = pos - de.bgPos.y
		yy = floor(y / ld.set.gridHeight) * ld.set.gridHeight
		pos = yy + de.bgPos.y

	endif
	
	// For end of the grid, we want to take 1 away to stay within the grid box.
	if not start
		dec pos
	endif
	
endfunction pos

//-----------------------------------------------------
// 
function deReleased(x as float, y as float)

	local butId as integer
	local obj as integer
	local cmd as integer

	if cdIsEditActive()

		cdReleased(x, y)
		exitfunction
		
	endif

	de.pressed = false

	if de.mode = DE_MODE_BACK_BUT

		deButtonAction(BUT_DESIGN_BACK, 0)
		
	elseif de.mode = DE_MODE_RUN_BUT

		deButtonAction(BUT_DESIGN_RUN, 0)

	elseif de.mode = DE_MODE_WAIT_THING

		//deShowSel()
		
	elseif de.mode = DE_MODE_WAIT_VAR

		//deShowSel()
		
	elseif de.mode = DE_MODE_DRAG_THING

		obj = ma.things[de.thingIdx].obj
		ma.things[de.thingIdx].x = getposx(obj) - de.bgPos.x
		ma.things[de.thingIdx].y = getposy(obj) - de.bgPos.y
		maSave()
		deShowPan()

	elseif de.mode = DE_MODE_DRAG_VAR

		obj = ma.vars[de.varIdx].v.bg
		ma.vars[de.varIdx].v.x = getspritex(obj) - de.bgPos.x
		ma.vars[de.varIdx].v.y = getspritey(obj) - de.bgPos.y
		maSave()
		deShowPan()

	elseif de.mode = DE_MODE_RESIZE_THING_BOX

		obj = ma.things[de.thingIdx].obj
		ma.things[de.thingIdx].x = getposx(obj) - de.bgPos.x
		ma.things[de.thingIdx].y = getposy(obj) - de.bgPos.y
		ma.things[de.thingIdx].sx = getscalex(obj)
		ma.things[de.thingIdx].sy = getscaley(obj)
		ma.things[de.thingIdx].w = GetImageWidth(GetSpriteImageID(obj)) * ma.things[de.thingIdx].sx
		ma.things[de.thingIdx].h = GetImageHeight(GetSpriteImageID(obj)) * ma.things[de.thingIdx].sy
		maSave()
		deShowPan()

	elseif de.mode = DE_MODE_ROT_THING_BOX

		obj = ma.things[de.thingIdx].obj
		ma.things[de.thingIdx].ang = getangle(obj)
		maSave()
		deShowPan()
		
	elseif de.mode = DE_MODE_RESIZE_VAR_BOX

		obj = ma.vars[de.varIdx].v.bg
		ma.vars[de.varIdx].v.x = Getspritex(obj) - de.bgPos.x
		ma.vars[de.varIdx].v.y = Getspritey(obj) - de.bgPos.y
		ma.vars[de.varIdx].v.w = GetWidth(obj)
		ma.vars[de.varIdx].v.h = Getheight(obj)
		maSave()
		
		maCreateVarView(ma.vars[de.varIdx].v)
		maSetVarViewPos(ma.vars[de.varIdx].v, ma.vars[de.varIdx].v.x, ma.vars[de.varIdx].v.y)
		deShowPan()
		
	elseif de.mode = DE_MODE_THING_BAR

		butId = guiCheckBarReleased(de.thingBar, x, y, 2)
		guiHideBar(de.thingBar)

		if butId > -1
			deButtonAction(butId, 0)
		endif
		
	elseif de.mode = DE_MODE_MORE_BAR

		butId = guiCheckBarReleased(de.moreBar, x, y, 1)
		guiHideBar(de.moreBar)

		if butId > -1
			deButtonAction(butId, 0)
		endif
		
	elseif de.mode = DE_MODE_VAR_BAR

		butId = guiCheckBarReleased(de.varBar, x, y, 2)
		guiHideBar(de.varBar)

		if butId > -1
			deButtonAction(butId, de.varIdx)
		endif
/*
	elseif de.mode = DE_MODE_PAN

		deMovePan(x, y)
		de.bgPos.x = getspritex(de.bg)
		de.bgPos.y = getspritey(de.bg)
		de.bgOff.x = 0
		de.bgOff.y = 0
*/
	elseif de.mode = DE_MODE_SCROLL

		deMoveStuff(x, y)
		de.bgPos.x = getspritex(de.bg)
		de.bgPos.y = getspritey(de.bg)
		de.bgOff.x = 0
		de.bgOff.y = 0
		//maSave()
			
	endif

	if ma.helpInter.howTo
		maProcessInterHelpReleased(de.mode)
	endif

	de.mode = DE_MODE_NONE
	
	guiHideTip(gui.tip)
	
endfunction

//-----------------------------------------------------
// Set alpha.
//
function deSetAllAlpha(alpha as integer)

	local i as integer
	local spr as integer
	local thingIdx as integer
	local varIdx as integer
	
	for i = 0 to de.sprs.length
		SetSpriteColorAlpha(de.sprs[i], alpha)
	next

	for i = 0 to de.depths.length

		thingIdx = de.depths[i].idx
		
		if ma.things[thingIdx].obj
			
			spr = ma.things[thingIdx].obj
			SetSpriteColorAlpha(spr, alpha)
			
		endif
		
	next
	
	for i = 0 to de.vardepths.length

		varIdx = de.vardepths[i].idx
		spr = ma.vars[varIdx].v.bg
		
		if spr
			SetSpriteColorAlpha(spr, alpha)
		endif
		
	next

	SetSpriteColorAlpha(de.pan.Back, alpha)	
	SetSpriteColorAlpha(de.pan.Shadow, alpha)
	
	for i = 0 to de.pan.Sprs.length
		SetSpriteColorAlpha(de.pan.Sprs[i], alpha)
	next 

	for i = 0 to de.selLine.length		
		SetSpriteColorAlpha(de.selLine[i], alpha)		
	next	

	for i = 0 to de.selBox.length
		SetSpriteColorAlpha(de.selBox[i], alpha)
	next	

	SetSpriteColorAlpha(de.selDotLine, alpha)
	SetSpriteColorAlpha(de.selDot, alpha)

endfunction

//-----------------------------------------------------
// Check local buttons, then fire global.
//
function deButtonAction(butId as integer, obj as integer)

	local x as float
	local y as float
	local img as integer
	
	if butId = BUT_DESIGN_RESET_SPRITE
		
		deResetThing(de.thingIdx)

		if ld.set.showLayoutNames
			guiShowTip(ma.things[de.thingIdx].tip, getsprite(ma.things[de.thingIdx].obj), ma.things[de.thingIdx].name, TIP_PRINT, 0)
		endif

		obj = ma.things[de.thingIdx].obj
		ma.things[de.thingIdx].x = getposx(obj) - de.bgPos.x
		ma.things[de.thingIdx].y = getposy(obj) - de.bgPos.y
		ma.things[de.thingIdx].sx = getscalex(obj)
		ma.things[de.thingIdx].sy = getscaley(obj)
		ma.things[de.thingIdx].ang = GetAngle(obj)
		ma.things[de.thingIdx].w = GetImageWidth(GetSpriteImageID(obj)) * ma.things[de.thingIdx].sx
		ma.things[de.thingIdx].h = GetImageHeight(GetSpriteImageID(obj)) * ma.things[de.thingIdx].sy
		maSave()

	elseif butId = BUT_DESIGN_SMOOTH_SCALING

		if ma.things[de.thingIdx].smoothScaling
			ma.things[de.thingIdx].smoothScaling = 0
		else 
			ma.things[de.thingIdx].smoothScaling = 1
		endif

		maSave()
			
		obj = ma.things[de.thingIdx].obj
		img = GetSpriteImageID(obj)
		SetImageMinFilter(img, ma.things[de.thingIdx].smoothScaling)
		SetImageMagFilter(img, ma.things[de.thingIdx].smoothScaling)
		//SetSpriteVisible(obj, true)

		deSetSpriteButtons()
		
	elseif butId = BUT_DESIGN_RESET_SCREEN
		
		de.bgPos.x = 0
		de.bgPos.y = 0
		deMoveStuff(0, 0)

	elseif butId = BUT_DESIGN_TO_FRONT
		
		deToFrontThing(de.thingIdx)
		maSave()

	elseif butId = BUT_DESIGN_TO_BACK
				
		deToBackThing(de.thingIdx)
		maSave()
	
	//elseif butId = BUT_DESIGN_RAISE
	//	deRaiseThing(de.thingIdx)
	//elseif butId = BUT_DESIGN_LOWER
	//	deLowerThing(de.thingIdx)

	elseif butId = BUT_DESIGN_GRID_SNAP

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_NAMES

		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_SCREEN

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_MENU_POS

		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_BG_COLOR

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, ld.set.deBgCol)

	elseif butId = BUT_DESIGN_GRID_COLS

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_GRID_WIDTH

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_GRID_ROWS

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_GRID_HEIGHT

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_SNAP_HORIZ
		
		if ld.set.snapGridHoriz = 0
			ld.set.snapGridHoriz = 1
		elseif ld.set.snapGridHoriz = 1
			ld.set.snapGridHoriz = 2
		elseif ld.set.snapGridHoriz = 2
			ld.set.snapGridHoriz = 0
		endif
		
		ldSaveSettings()
		deSetSettingsGridSnapButton()

	elseif butId = BUT_DESIGN_SNAP_VERT
		
		if ld.set.snapGridVert = 0
			ld.set.snapGridVert = 1
		elseif ld.set.snapGridVert = 1
			ld.set.snapGridVert = 2
		elseif ld.set.snapGridVert = 2
			ld.set.snapGridVert = 0
		endif
		
		ldSaveSettings()
		deSetSettingsGridSnapButton()

	elseif butId = BUT_DESIGN_PAN

		if ld.set.panOn
			ld.set.panOn = false
		else
			ld.set.panOn = true
		endif
			
		ldSaveSettings()
		deSetSettingsPanButton()
		deShowPan()

	elseif butId = BUT_DESIGN_TITLE_POS

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_TITLE_VIS

		deSaveVarTitleVis()
		deSetVarTitleVisButton()
		deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_VARBG_COL

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_TITLE_COL

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_BOX_COL

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_TEXT_COL

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_TITLE_ALIGN

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_TEXT_ALIGN

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_TITLE_FONT_SIZE

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)

	elseif butId = BUT_DESIGN_TITLE_FONT

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)
	
	elseif butId = BUT_DESIGN_TEXT_FONT_SIZE

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)
	
	elseif butId = BUT_DESIGN_TEXT_FONT

		deSetAllAlpha(gui.inactiveAlpha)
		cdButtonAction(butId, obj)
	
	elseif butId = BUT_DESIGN_TEXT_SECRET

		deSaveVarTextSecret()
		deSetVarTextSecretButton()
		deRebuildVarView(de.varIdx)
		
	elseif butId = BUT_DESIGN_RESET_VAR
		
		maDeleteVarView(ma.vars[de.varIdx].v)
		x = ma.vars[de.varIdx].v.x
		y = ma.vars[de.varIdx].v.y
		maInitVarView(ma.vars[de.varIdx].v)
		ma.vars[de.varIdx].v.x = x
		ma.vars[de.varIdx].v.y = y
		ma.vars[de.varIdx].v.name = ma.vars[de.varIdx].name
		maSave()

		deSetVarButtons()
		maCreateVarView(ma.vars[de.varIdx].v)
		maSetVarViewPos(ma.vars[de.varIdx].v, ma.vars[de.varIdx].v.x, ma.vars[de.varIdx].v.y)
		//deSetVarViewDepth(de.varIdx)
		maSetVarViewDepth(ma.vars[de.varIdx].v, ma.vars[de.varIdx].v.depth)
		deShowSel()
		deShowPan()

	else
		
		OnButtonAction(butId, 0)

	endif
		
endfunction

//-----------------------------------------------------
// Call back from coder.
//
function deCallbackFromCoder(butId as integer, obj as integer)

	deSetAllAlpha(255)

	if butId = BUT_DESIGN_MENU_POS

		deSetSettingsDesignPosButton()
		deSetButPos()

	elseif butId = BUT_DESIGN_GRID_SNAP

		deSetSettingsGridSnapButton()
		deShowGrid()

	elseif butId = BUT_DESIGN_SCREEN

		if WIN_MODE
			
			ma.apps[de.appIdx].screen = obj
			
		else
			
			// Remove bits.
			ma.apps[de.appIdx].status = !(!ma.apps[de.appIdx].status || LD_STATUS_MOB_LAND)
			ma.apps[de.appIdx].status = !(!ma.apps[de.appIdx].status || LD_STATUS_MOB_PORT)
			
			// Selective add back.
			if obj = 2
				ma.apps[de.appIdx].status = ma.apps[de.appIdx].status || LD_STATUS_MOB_LAND
			elseif obj = 5
				ma.apps[de.appIdx].status = ma.apps[de.appIdx].status || LD_STATUS_MOB_PORT
			endif
			
		endif
	
		maSave()
		deSetSettingsScreenButton()
		deShowScreen()

	elseif butId = BUT_DESIGN_NAMES

		deSetSettingsNamesButton()
		deShowNames()
		
	elseif butId = BUT_DESIGN_BG_COLOR

		//ld.set.deBgCol = obj
		deSetSettingsBgColorButton()
		deShowBgColor()

	elseif butId = BUT_DESIGN_GRID_COLS

		deSetSettingsGridColsButton()
		deShowGrid()

	elseif butId = BUT_DESIGN_GRID_WIDTH

		deSetSettingsGridColsButton()
		deShowGrid()

	elseif butId = BUT_DESIGN_GRID_ROWS

		deSetSettingsGridRowsButton()
		deShowGrid()

	elseif butId = BUT_DESIGN_GRID_HEIGHT

		deSetSettingsGridRowsButton()
		deShowGrid()

	elseif butId = BUT_DESIGN_TITLE_POS

		ma.vars[de.varIdx].v.titleDir = obj
		maSave()
		deSetVarTitlePosButton()
		deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_TITLE_FONT_SIZE

		ma.vars[de.varIdx].v.titleFontSize = obj
		
		if ma.vars[de.varIdx].v.titleFontSize < LD_TEXT_SIZE_MIN
			ma.vars[de.varIdx].v.titleFontSize = LD_TEXT_SIZE_MIN
		elseif ma.vars[de.varIdx].v.titleFontSize > LD_TEXT_SIZE_MAX
			ma.vars[de.varIdx].v.titleFontSize = LD_TEXT_SIZE_MAX
		endif
		
		maSave()
		deSetVarTitleFontButton()
		deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_TITLE_FONT

		ma.vars[de.varIdx].v.titleFont = obj
		maSave()
		deSetVarTitleFontButton()
		deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_TEXT_FONT_SIZE

		ma.vars[de.varIdx].v.textFontSize = obj
		
		if ma.vars[de.varIdx].v.textFontSize < LD_TEXT_SIZE_MIN
			ma.vars[de.varIdx].v.textFontSize = LD_TEXT_SIZE_MIN
		elseif ma.vars[de.varIdx].v.textFontSize > LD_TEXT_SIZE_MAX
			ma.vars[de.varIdx].v.textFontSize = LD_TEXT_SIZE_MAX
		endif

		maSave()
		deSetVarTextFontButton()
		deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_TEXT_FONT

		ma.vars[de.varIdx].v.textFont = obj
		maSave()
		deSetVarTextFontButton()
		deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_VARBG_COL

		ma.vars[de.varIdx].v.bgCol = obj
		maSave()
		deSetVarBgColButton()
		maUpdateVarView(ma.vars[de.varIdx].v)
		//deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_TITLE_COL

		ma.vars[de.varIdx].v.titleCol = obj
		maSave()
		deSetVarTitleColButton()
		maUpdateVarView(ma.vars[de.varIdx].v)
		//deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_BOX_COL

		ma.vars[de.varIdx].v.boxCol = obj
		maSave()
		deSetVarBoxColButton()
		maUpdateVarView(ma.vars[de.varIdx].v)
		//deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_TEXT_COL

		ma.vars[de.varIdx].v.textCol = obj
		maSave()
		deSetVarTextColButton()
		maUpdateVarView(ma.vars[de.varIdx].v)
		//deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_TITLE_ALIGN

		ma.vars[de.varIdx].v.titleAlign = obj
		maSave()
		deSetVarTitleAlignButton()
		deRebuildVarView(de.varIdx)

	elseif butId = BUT_DESIGN_TEXT_ALIGN

		ma.vars[de.varIdx].v.textAlign = obj
		maSave()
		deSetVarTextAlignButton()
		deRebuildVarView(de.varIdx)

	elseif butId = BUT_EDITOR_CANCEL_EDIT

	endif

endfunction

//-----------------------------------------------------
// Set the design button in settings to the current setting value.
//
function deSetSettingsDesignPosButton()

	local idx as integer

	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_MENU_POS)

	if ld.set.designButPos = DIR_NE

		SetSpriteAngle(de.morebar.buts[idx].icon, -135)
		//guiSetButtonText(de.morebar.buts[idx], "top-right")
		de.morebar.buts[idx].help = "Tap to change the position of menu to bottom-right."
		
	elseif ld.set.designButPos = DIR_NW

		SetSpriteAngle(de.morebar.buts[idx].icon, 135)
		//guiSetButtonText(de.morebar.buts[idx], "top-left")
		de.morebar.buts[idx].help = "Tap to change the position of menu to top-right."

	elseif ld.set.designButPos = DIR_SE

		SetSpriteAngle(de.morebar.buts[idx].icon, -45)
		//guiSetButtonText(de.morebar.buts[idx], "bot-right")
		de.morebar.buts[idx].help = "Tap to change the position of menu to bottom-left."

	elseif ld.set.designButPos = DIR_SW

		SetSpriteAngle(de.morebar.buts[idx].icon, 45)
		//guiSetButtonText(de.morebar.buts[idx], "bot-left")
		de.morebar.buts[idx].help = "Tap to change the position of menu to top-left."

	endif

endfunction

//-----------------------------------------------------
// Set the pan button.
//
function deSetSettingsPanButton()

	local idx as integer
		
	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_PAN)

	if ld.set.panOn
		guiSetButtonIcon2(de.morebar.buts[idx], gui.onImg)		
	else
		guiSetButtonIcon2(de.morebar.buts[idx], gui.offImg)
	endif

endfunction

//-----------------------------------------------------
// Set the snap to grid button in settings to the current setting value.
//
function deSetSettingsGridSnapButton()

	local idx as integer
		
	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_GRID_SNAP)

	if ld.set.snapToGrid
		guiSetButtonIcon2(de.morebar.buts[idx], gui.onImg)		
	else
		guiSetButtonIcon2(de.morebar.buts[idx], gui.offImg)
	endif

	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_SNAP_VERT)
	
	if ld.set.snapGridVert = 0	
		guiSetButtonIcon(de.morebar.buts[idx], de.snapLeftImg)			
	elseif ld.set.snapGridVert = 1
		guiSetButtonIcon(de.morebar.buts[idx], de.snapVMidImg)		
	elseif ld.set.snapGridVert = 2		
		guiSetButtonIcon(de.morebar.buts[idx], de.snapRightImg)	
	endif	

	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_SNAP_HORIZ)

	if ld.set.snapGridHoriz = 0	
		guiSetButtonIcon(de.morebar.buts[idx], de.snapTopImg)			
	elseif ld.set.snapGridHoriz = 1
		guiSetButtonIcon(de.morebar.buts[idx], de.snapHMidImg)		
	elseif ld.set.snapGridHoriz = 2		
		guiSetButtonIcon(de.morebar.buts[idx], de.snapBottomImg)	
	endif	

endfunction

//-----------------------------------------------------
// Set the names button in settings to the current setting value.
//
function deSetSettingsNamesButton()

	local idx as integer	
	
	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_NAMES)

	if ld.set.showLayoutNames		
		guiSetButtonIcon2(de.morebar.buts[idx], gui.onImg)		
	else
		guiSetButtonIcon2(de.morebar.buts[idx], gui.offImg)
	endif

endfunction

//-----------------------------------------------------
// Set the bg color button.
//
function deSetSettingsBgColorButton()

	local idx as integer
		
	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_BG_COLOR)
	coSetSpriteColor(de.morebar.buts[idx].icon2, ld.set.deBgCol)

endfunction

//-----------------------------------------------------
// Set the grid cols button value.
//
function deSetSettingsGridColsButton()

	local idx as integer

	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_GRID_WIDTH)
	guiSetButtonText(de.morebar.buts[idx], "w (" + str(ld.set.gridWidth) + ")")
	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_GRID_COLS)
	guiSetButtonText(de.morebar.buts[idx], "cols")

endfunction

//-----------------------------------------------------
// Set the grid rows button value.
//
function deSetSettingsGridRowsButton()

	local idx as integer

	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_GRID_HEIGHT)
	guiSetButtonText(de.morebar.buts[idx], "h (" + str(ld.set.gridHeight) + ")")
	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_GRID_ROWS)
	guiSetButtonText(de.morebar.buts[idx], "rows")

endfunction

//-----------------------------------------------------
// Set the screen button.
//
function deSetSettingsScreenButton()

	local idx as integer
	local name as string
	local toks as string[]
	local s as string

	idx = guiFindBarButtonById(de.morebar, BUT_DESIGN_SCREEN)
	
	if WIN_MODE 
		
		s = cdGetObjVarVals(OBJ_VAR_SCREEN, str(ma.apps[de.appIdx].screen), false)		
		coSplitString(toks, s, " ")
		name = toks[1] + " x\n" + toks[3]
		guiSetButtonText(de.morebar.buts[idx], name)
		
	else
		if ma.apps[cd.appIdx].status && LD_STATUS_MOB_LAND
			guiSetButtonText(de.morebar.buts[idx], "phone\nland")
		elseif ma.apps[cd.appIdx].status && LD_STATUS_MOB_PORT
			guiSetButtonText(de.morebar.buts[idx], "phone\nport")
		else
			guiSetButtonText(de.morebar.buts[idx], "tablet\nland")
		endif
	endif
	
endfunction

//-----------------------------------------------------
// Reset a thing to its natural size and 0 rotation.
//
function deResetThing(thingIdx as integer)

	setscalex(ma.things[thingIdx].obj, 1)
	setscaley(ma.things[thingIdx].obj, 1)
	setangle(ma.things[thingIdx].obj, 0)

	deShowSel()
	
endfunction

//-----------------------------------------------------
// Bring thing to front, and push other back.
//
function deToFrontThing(thingIdx as integer)

	local idx as integer
	local i as integer

	for i = 0 to ma.apps[de.appIdx].sprites.length
		
		if ma.apps[de.appIdx].sprites[i] = thingIdx
			
			ma.apps[de.appIdx].sprites.remove(i)
			exit
			
		endif
		
	next

	if ma.apps[de.appIdx].sprites.length > -1
		ma.apps[de.appIdx].sprites.insert(thingIdx, 0)
	else
		ma.apps[de.appIdx].sprites.insert(thingIdx)
	endif

	maMakeThingDepths(de.depths, de.appIdx)
	maApplyThingDepths(de.depths)
	
	deShowSel()
	
endfunction

//-----------------------------------------------------
// Send thing to back.
//
function deToBackThing(thingIdx as integer)

	local idx as integer
	local i as integer

	for i = 0 to ma.apps[de.appIdx].sprites.length
		
		if ma.apps[de.appIdx].sprites[i] = thingIdx
			
			ma.apps[de.appIdx].sprites.remove(i)
			exit
			
		endif
		
	next

	// Append.
	ma.apps[de.appIdx].sprites.insert(thingIdx)
	
	maMakeThingDepths(de.depths, de.appIdx)
	maApplyThingDepths(de.depths)
	
	deShowSel()

endfunction

//-----------------------------------------------------
// Bring thing up one level.
//
function deBringForwardThing(thingIdx as integer)

	local idx as integer
	local td as Depth
	local i as integer
	local diff as integer
	local depth as integer
	
	idx = -1

	for i = 0 to ma.apps[de.appIdx].sprites.length
		
		if ma.apps[de.appIdx].sprites[i] = thingIdx

			idx = i
			ma.apps[de.appIdx].sprites.remove(i)
			exit
			
		endif
		
	next

	if idx > -1
		
		dec idx
		
		if idx > 0 and ma.apps[de.appIdx].sprites.length > -1
			ma.apps[de.appIdx].sprites.insert(thingIdx, idx)
		else 
			ma.apps[de.appIdx].sprites.insert(thingIdx)
		endif
	
		maMakeThingDepths(de.depths, de.appIdx)
		maApplyThingDepths(de.depths)
		
	endif
	
	deShowSel()
	
endfunction

//-----------------------------------------------------
// Send thing back one level.
//
function deSendBackwardThing(thingIdx as integer)

	local idx as integer
	local i as integer

	idx = -1
	
	for i = 0 to ma.apps[de.appIdx].sprites.length
		
		if ma.apps[de.appIdx].sprites[i] = thingIdx
			
			idx = i
			ma.apps[de.appIdx].sprites.remove(i)
			exit
			
		endif
		
	next

	if idx > -1
		
		inc idx
		
		if idx < ma.apps[de.appIdx].sprites.length and ma.apps[de.appIdx].sprites.length > -1
			ma.apps[de.appIdx].sprites.insert(thingIdx, idx)
		else 
			ma.apps[de.appIdx].sprites.insert(thingIdx)
		endif
	
		maMakeThingDepths(de.depths, de.appIdx)
		maApplyThingDepths(de.depths)
		
	endif
	
	deShowSel()

endfunction

//-----------------------------------------------------
// Restore things lost off the screen.
//
function deRestoreLostOff()

	local i as integer
	local thingIdx as integer
	local spr as integer

	for i = 0 to ma.apps[de.appIdx].sprites.length
		
		thingIdx = ma.apps[de.appIdx].sprites[i]
		spr = ma.things[thingIdx].obj
		
		if getspritex(spr) + GetSpriteWidth(spr) < 0 or getspritey(spr) + GetSpriteHeight(spr) < 0 or getspritex(spr) > de.w or getspritey(spr) > de.h

			ma.things[thingIdx].x = de.w / 2
			ma.things[thingIdx].y = de.h / 2
			setpos(ma.things[thingIdx].obj, ma.things[thingIdx].x, ma.things[thingIdx].y)

		endif
		
	next
//xxx do vars
endfunction

//-----------------------------------------------------
// Raise thing 1 depth in the stack.
//
function deRaiseThing(thingIdx as integer)
	
endfunction

//-----------------------------------------------------
// Lower thing 1 depth in the stack.
//
function deLowerThing(thingIdx as integer)
	
endfunction

//-----------------------------------------------------
// object update.
//
function deOnObjUpdate(obj as integer)

	if cdIsEditActive()

		cdOnObjUpdate(obj)
		exitfunction
		
	endif

endfunction

//-----------------------------------------------------
// Timer tick.
//
function deOnObjTimer(obj as integer)

	if cdIsEditActive()

		cdOnObjTimer(obj)
		exitfunction
		
	endif

endfunction

//-----------------------------------------------------
// 
function deUpdate(delta as float)

	if cdIsEditActive()

		cdUpdate(delta)
		exitfunction
		
	endif
	
	if in.ptrPressed

		dePressed(in.ptrX, in.ptrY)

	elseif in.ptrDown

		deMoved(in.ptrX, in.ptrY)			
		
	elseif in.ptrReleased

		deReleased(in.ptrX, in.ptrY)
			
	elseif ma.helpInter.howTo
		
		maUpdateHelpInterAnim(delta)

	endif

endfunction

//-----------------------------------------------------
// Scale up the position in the pan window up to full screen so we can move stuff.
//
function deMovePan(x as float, y as float)

	local dx as float
	local dy as float

	dx = x - getspritex(de.pan.back)
	dx = dx / de.pan.Scale.x
	dx = dx + de.pan.bounds.x0 // co.w2
	dx = dx - de.w / 2
	//dx = dx - co.w / 2
		
	if dx < de.pan.bounds.x0
		dx = de.pan.bounds.x0 // dx + (de.pan.bounds.x0 - dx)
	endif

	if dx + de.w - 1 > de.pan.bounds.x1
		dx = de.pan.bounds.x1 - de.w // dx - (dx + co.w - 1 - de.pan.bounds.x1)
	endif
	//if dx + co.w - 1 > de.pan.bounds.x1
	//	dx = de.pan.bounds.x1 - co.w
	//endif
	
	dy = y - getspritey(de.pan.back)
	dy = dy / de.pan.Scale.y
	dy = dy + de.pan.bounds.y0 // co.h2
	dy = dy - de.h / 2
	//dy = dy - co.h / 2
		
	if dy < de.pan.bounds.y0
		dy = de.pan.bounds.y0 // dy + (de.pan.bounds.y0 - dy)
	endif

	if dy + de.h - 1 > de.pan.bounds.y1
		dy = de.pan.bounds.y1 - de.h // dy - (dy + co.h - 1 - de.pan.bounds.y1)
	endif
	//if dy + co.h - 1 > de.pan.bounds.y1
	//	dy = de.pan.bounds.y1 - co.h // dy - (dy + co.h - 1 - de.pan.bounds.y1)
	//endif
	
	de.bgOff.x = 0
	de.bgOff.y = 0
	de.bgPos.x = -dx
	de.bgPos.y = -dy

	deMoveStuff(0, 0)
	
endfunction

//-----------------------------------------------------
// Move all things on the screen around.
//
function deMoveStuff(x as float, y as float)

	local i as integer
	local dx as float
	local dy as float
	local xx as float
	local yy as float
	local spr as integer
	local thingIdx as integer
	local varIdx as integer

	dx = x - de.bgoff.x
	dy = y - de.bgoff.y

	xx = de.bgPos.x + dx
	yy = de.bgPos.y + dy
	SetSpritePosition(de.bg, xx, yy)
		
	deShowGrid()
				
	for i = 0 to de.depths.length

		thingIdx = de.depths[i].idx
		
		if ma.things[thingIdx].obj
			
			spr = ma.things[thingIdx].obj
			
			//if ma.things[thingIdx].moved
				setpos(spr, ma.things[thingIdx].x + xx, ma.things[thingIdx].y + yy)
			//else 
				//setpos(spr, de.w / 2 + xx, de.h / 2 + yy)
			//endif
			
		endif
		
	next
	
	for i = 0 to de.vardepths.length

		varIdx = de.vardepths[i].idx
		maSetVarViewPos(ma.vars[varIdx].v, ma.vars[varIdx].v.x + xx, ma.vars[varIdx].v.y + yy)
		
	next

	deShowSel()

endfunction

//-----------------------------------------------------
// Hide the pan window.
//
function deHidePan()
	
	local i as integer
	
	deletesprite(de.pan.Back)
	de.pan.Back = 0
	
	deletesprite(de.pan.Shadow)
	de.pan.Shadow = 0
	
	for i = 0 to de.pan.Sprs.length
		deletesprite(de.pan.Sprs[i])
	next 
	
	de.pan.Sprs.length = -1

endfunction

//-----------------------------------------------------
// Show the pan window.
//
function deShowPan()

	local i as integer
	local spr as integer
	local thingIdx as integer
	local varIdx as integer
	local x as float
	local y as float
	local xx as float
	local yy as float
	local w as float
	local h as float
	local s as float

	deHidePan()

	if not ld.set.panOn
		exitfunction
	endif
					
	de.pan.Bounds.x0 = 0
	de.pan.Bounds.y0 = 0
	//de.pan.Bounds.x1 = de.w - 1 
	//de.pan.Bounds.y1 = de.h - 1 
	de.pan.Bounds.x1 = co.w - 1 
	de.pan.Bounds.y1 = co.h - 1 
	
	for i = 0 to de.depths.length

		thingIdx = de.depths[i].idx
		
		if ma.things[thingIdx].obj
			
			spr = ma.things[thingIdx].obj
			x = ma.things[thingIdx].x - GetSpriteWidth(spr) / 2
			y = ma.things[thingIdx].y - GetSpriteHeight(spr) / 2
			
			if x < de.pan.Bounds.x0
				de.pan.Bounds.x0 = x
			elseif x + getspritewidth(spr) - 1 > de.pan.Bounds.x1
				de.pan.Bounds.x1 = x + getspritewidth(spr) - 1
			endif

			if y < de.pan.Bounds.y0
				de.pan.Bounds.y0 = y
			elseif y + getspriteheight(spr) - 1 > de.pan.Bounds.y1
				de.pan.Bounds.y1 = y + getspriteheight(spr) - 1
			endif
			
		endif
		
	next
	
	for i = 0 to de.vardepths.length

		varIdx = de.vardepths[i].idx
		
		if ma.vars[varIdx].v.bg

			spr = ma.vars[varIdx].v.bg
			
			if ma.vars[varIdx].v.x < de.pan.Bounds.x0
				de.pan.Bounds.x0 = ma.vars[varIdx].v.x
			elseif ma.vars[varIdx].v.x + getspritewidth(spr) - 1 > de.pan.Bounds.x1
				de.pan.Bounds.x1 = ma.vars[varIdx].v.x + getspritewidth(spr) - 1
			endif
	
			if ma.vars[varIdx].v.y < de.pan.Bounds.y0
				de.pan.Bounds.y0 = ma.vars[varIdx].v.y
			elseif ma.vars[varIdx].v.y + getspriteheight(spr) - 1 > de.pan.Bounds.y1
				de.pan.Bounds.y1 = ma.vars[varIdx].v.y + getspriteheight(spr) - 1
			endif
			
		endif
		
	next

	w = de.pan.Bounds.x1 - de.pan.Bounds.x0 + 1
	h = de.pan.Bounds.y1 - de.pan.Bounds.y0 + 1

	s = co.bs * 3
	de.pan.scale.x = s / w
	de.pan.scale.y = s / h
			
	if de.pan.scale.x < de.pan.scale.y
		de.pan.scale.y = de.pan.scale.x		
	else 
		de.pan.scale.x = de.pan.scale.y		
	endif

	
	de.pan.Back = guiCreateBox("panback", w * de.pan.scale.x, h * de.pan.scale.y)
	coSetSpriteColor(de.pan.Back, co.grey[4])
	SetSpriteDepth(de.pan.Back, GUI_SHADOW_DEPTH - 1)
	//SetSpritePosition(de.pan.Back, co.bs / 2, de.h - co.bs / 2 - GetSpriteHeight(de.pan.Back))
	SetSpritePosition(de.pan.Back, co.bs / 2, co.h - co.bs / 2 - GetSpriteHeight(de.pan.Back))
	
	de.pan.Shadow = guiCreateBox("panshadow", GetSpriteWidth(de.pan.Back) + 16, getspriteheight(de.pan.Back) + 16)
	coSetSpriteColor(de.pan.Shadow, co.black)
	//SetSpritePosition(de.pan.Shadow, co.bs / 2 - 8, de.h - co.bs / 2 - GetSpriteHeight(de.pan.Back) - 8)
	SetSpritePosition(de.pan.Shadow, co.bs / 2 - 8, co.h - co.bs / 2 - GetSpriteHeight(de.pan.Back) - 8)
	SetSpriteDepth(de.pan.Shadow, GUI_SHADOW_DEPTH)	//setspritevisible(de.pan.Shadow, false)

	x = getspritex(de.pan.Back)
	y = getspritey(de.pan.Back)

	// Screen area.
	spr = guiCreateBox("", Getspritewidth(de.bg) * de.pan.Scale.x, GetSpriteHeight(de.bg) * de.pan.Scale.y)
	cosetspritecolor(spr, coGetSpriteColor(de.bg))
	xx = -de.pan.Bounds.x0
	yy = -de.pan.Bounds.y0
	SetSpritePosition(spr, x + xx * de.pan.Scale.x, y + yy * de.pan.Scale.y)
	SetSpriteDepth(spr, GUI_BACK_DEPTH)
	SetSpriteScissor(spr, getspritex(de.pan.back), getspritey(de.pan.back), getspritex(de.pan.back) + GetSpriteWidth(de.pan.back) - 1, getspritey(de.pan.back) + GetSpriteheight(de.pan.back) - 1) 
	de.pan.Sprs.insert(spr)
	
	for i = 0 to de.depths.length

		thingIdx = de.depths[i].idx
		
		if ma.things[thingIdx].obj
			
			spr = guiCreateBox("", Getspritewidth(ma.things[thingIdx].obj) * de.pan.Scale.x, GetSpriteHeight(ma.things[thingIdx].obj) * de.pan.Scale.y)
			cosetspritecolor(spr, co.blue[7])
			xx = (ma.things[thingIdx].x - de.pan.Bounds.x0) 
			yy = (ma.things[thingIdx].y - de.pan.Bounds.y0)
			SetSpriteAngle(spr, ma.things[thingIdx].ang)
			SetSpritePositionByOffset(spr, x + xx * de.pan.Scale.x, y + yy * de.pan.Scale.y)
			SetSpriteDepth(spr, GUI_BACK_DEPTH - 1)
			SetSpriteScissor(spr, getspritex(de.pan.back), getspritey(de.pan.back), getspritex(de.pan.back) + GetSpriteWidth(de.pan.back) - 1, getspritey(de.pan.back) + GetSpriteheight(de.pan.back) - 1) 
			de.pan.Sprs.insert(spr)
			
		endif
		
	next 

	for i = 0 to de.vardepths.length

		varIdx = de.vardepths[i].idx
		
		if ma.vars[varIdx].v.bg
			
			spr = guiCreateBox("", Getspritewidth(ma.vars[varIdx].v.bg) * de.pan.Scale.x, GetSpriteHeight(ma.vars[varIdx].v.bg) * de.pan.Scale.y)
			cosetspritecolor(spr, co.red[7])
			xx = (ma.vars[varIdx].v.x - de.pan.Bounds.x0) 
			yy = (ma.vars[varIdx].v.y - de.pan.Bounds.y0)
			SetSpritePosition(spr, x + xx * de.pan.Scale.x, y + yy * de.pan.Scale.y)
			SetSpriteDepth(spr, GUI_BACK_DEPTH - 1)
			SetSpriteScissor(spr, getspritex(de.pan.back), getspritey(de.pan.back), getspritex(de.pan.back) + GetSpriteWidth(de.pan.back) - 1, getspritey(de.pan.back) + GetSpriteheight(de.pan.back) - 1) 
			de.pan.Sprs.insert(spr)
			
		endif

	next 
		
endfunction

//
// END.
//

