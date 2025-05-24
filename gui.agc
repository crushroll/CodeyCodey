#option_explicit

//-----------------------------------------------------
// Button constants.
//
#constant BUT_BG_NONE 0
#constant BUT_BG_NORMAL 1
#constant BUT_BG_LEFT_TAB 2
#constant BUT_BG_TOP_TAB 3
#constant BUT_BG_BOT_TAB 4
#constant BUT_BG_STATIC 5
#constant BUT_BG_SMALL 6
#constant BUT_BG_BIG_TOP_TAB 7
#constant BUT_KEY 8
#constant BUT_LARGE_KEY 9
#constant BUT_HUGE_KEY 10
#constant BUT_MEDIUM_KEY 11

#constant BUT_PRESS_NONE 0
#constant BUT_PRESS_LEFT 1
#constant BUT_PRESS_RIGHT 2

//-----------------------------------------------------
// Button ids.
//
#constant BUT_TITLE_EXIT 1
#constant BUT_TITLE_SHOW 2
//#constant BUT_DESIGN_GRID 2
#constant BUT_DESIGN_MORE 3
#constant BUT_DESIGN_BACK 4 // Go to code for sprite.
#constant BUT_DESIGN_RESET_SPRITE 5 // Reset a thing.
#constant BUT_DESIGN_RAISE 6
#constant BUT_DESIGN_LOWER 7
#constant BUT_DESIGN_TO_FRONT 8
#constant BUT_DESIGN_TO_BACK 9
#constant BUT_DESIGN_TITLE_POS 10
#constant BUT_DESIGN_TITLE_FONT 11
#constant BUT_DESIGN_TITLE_VIS 12
#constant BUT_DESIGN_TITLE_COL 13
#constant BUT_DESIGN_TEXT_FONT 14
#constant BUT_DESIGN_BOX_COL 15
#constant BUT_DESIGN_TEXT_COL 16
#constant BUT_DESIGN_VARBG_COL 17
#constant BUT_DESIGN_RUN 18
#constant BUT_DESIGN_RESET_VAR 19
#constant BUT_DESIGN_TITLE_ALIGN 20
#constant BUT_DESIGN_TEXT_ALIGN 21
#constant BUT_DESIGN_TEXT_SECRET 22
#constant BUT_DESIGN_TITLE_FONT_SIZE 23
#constant BUT_DESIGN_TEXT_FONT_SIZE 24
#constant BUT_DESIGN_SNAP_HORIZ 25
#constant BUT_DESIGN_RESET_SCREEN 26
#constant BUT_DESIGN_SNAP_VERT 27
#constant BUT_DESIGN_GRID 28
#constant BUT_DESIGN_GRID_SNAP 29
#constant BUT_DESIGN_GRID_ROWS 30
#constant BUT_DESIGN_GRID_COLS 31
#constant BUT_DESIGN_NAMES 32
#constant BUT_DESIGN_SCREEN 33

#constant BUT_DESIGN_MENU_POS 407
#constant BUT_DESIGN_GRID_WIDTH 413
#constant BUT_DESIGN_GRID_HEIGHT 414
#constant BUT_DESIGN_PAN 415
#constant BUT_DESIGN_BG_COLOR 416
#constant BUT_DESIGN_CANCEL_EDIT 417 // The designer edit was cancelled.
#constant BUT_DESIGN_SMOOTH_SCALING 418

#constant BUT_CODER_DESIGN 101
#constant BUT_CODER_RUN 102
#constant BUT_CODER_THING 103
#constant BUT_CODER_UNDO 104
#constant BUT_CODER_REDO 105
#constant BUT_CODER_CMD 106
#constant BUT_CODER_APP 107
#constant BUT_CODER_APP_CLOSE 108
#constant BUT_CODER_CUT 110
#constant BUT_CODER_COPY 111
#constant BUT_CODER_PASTE 112
#constant BUT_CODER_TIDY 113
#constant BUT_CODER_ITEM_DELETE 114
#constant BUT_CODER_THING_NEW 115 // Show images for this sprite.
#constant BUT_CODER_THING_RENAME 116 // Rename sprite on sprite tab.
#constant BUT_CODER_THING_REMOVE 117 // Remove sprite from sprite tab.
#constant BUT_CODER_THING_DUP 118 // Duplicate a whole sprite.
#constant BUT_CODER_APP_OPEN 119 // Open an app.
#constant BUT_CODER_APP_RENAME 120
#constant BUT_CODER_APP_DELETE 121
#constant BUT_CODER_APP_DUP 122
#constant BUT_CODER_HELP 123
#constant BUT_CODER_ZOOM_OUT 124
#constant BUT_CODER_CURR_THING 125
#constant BUT_CODER_LIBRARY 126
#constant BUT_CODER_SHARED 127
#constant BUT_CODER_FILES 128
#constant BUT_CODER_CANCEL 129
#constant BUT_CODER_THING_PLAY 130
#constant BUT_CODER_APP_SHARE 131
#constant BUT_CODER_APP_UNSHARE 132
#constant BUT_CODER_IMAGE_REMOVE 133
#constant BUT_CODER_VAR_HELP 134
#constant BUT_CODER_VAR_REMOVE 135
#constant BUT_CODER_VAR_SHARE 136
#constant BUT_CODER_IMAGE_NEW 137
#constant BUT_CODER_CODE 138
#constant BUT_CODER_ITEM_RENAME 139
#constant BUT_CODER_VAR_RENAME 140
#constant BUT_CODER_THING_EDIT 141
#constant BUT_CODER_IMAGE_EDIT 142
#constant BUT_CODER_ITEM_HELP 143
#constant BUT_CODER_HELP_QUICK 144
#constant BUT_CODER_HELP_DETAILS 145
#constant BUT_CODER_VAR_ADD 146
#constant BUT_CODER_VAR_TO_LIST 147
#constant BUT_CODER_VAR_TO_OBJECT 148
#constant BUT_CODER_DELETE 149
#constant BUT_CODER_APP_OPEN_FROM_HELP 150 // Open an app from help.
#constant BUT_CODER_IMAGE_VIEW 151
#constant BUT_CODER_EDIT_SAVE 152
#constant BUT_CODER_EDIT_CANCEL 153
#constant BUT_CODER_EDIT_ZOOM_IN 154
#constant BUT_CODER_EDIT_ZOOM_OUT 155
#constant BUT_CODER_EDIT_LINE 156
#constant BUT_CODER_EDIT_RECT 157
#constant BUT_CODER_EDIT_OVAL 158
#constant BUT_CODER_EDIT_FILL 159
#constant BUT_CODER_EDIT_CUT 160
#constant BUT_CODER_EDIT_CLEAR 161
#constant BUT_CODER_EDIT_FLIP_HORIZ 162
#constant BUT_CODER_EDIT_FLIP_VERT 163
#constant BUT_CODER_EDIT_ROT_LEFT 164
#constant BUT_CODER_EDIT_ROT_RIGHT 165
#constant BUT_CODER_EDIT_GRID_SNAP 166
#constant BUT_CODER_EDIT_SPLIT 167
#constant BUT_CODER_EDIT_SELECT 168
#constant BUT_CODER_EDIT_PAN 169
#constant BUT_CODER_EDIT_COLOR 170
#constant BUT_CODER_EDIT_PICKER 171
#constant BUT_CODER_EDIT_DRAW 172
#constant BUT_CODER_EDIT_COPY 173
#constant BUT_CODER_EDIT_PASTE 174
#constant BUT_CODER_EDIT_REDO 175
#constant BUT_CODER_EDIT_UNDO 176
#constant BUT_CODER_EDIT_GRID_ROWS 177
#constant BUT_CODER_EDIT_GRID_COLS 178
#constant BUT_CODER_EDIT_RESIZE 179
#constant BUT_CODER_EDIT_ZOOM_RESET 180
#constant BUT_CODER_EDIT_SIZE 181
#constant BUT_CODER_EDIT_CROP 182
#constant BUT_CODER_EDIT_TEXT 183
#constant BUT_CODER_EDIT_IMAGE 184
#constant BUT_CODER_PASTE_PART 185
#constant BUT_CODER_ITEM_FOLDER_RENAME 186
#constant BUT_CODER_APP_INFO 187
#constant BUT_CODER_THING_ADDLIB 188
#constant BUT_CODER_IMAGE_ADDLIB 189
#constant BUT_CODER_IMAGE_DUP 190
#constant BUT_CODER_ITEM_DUP 191
#constant BUT_CODER_LIB_APP_DUP 192
#constant BUT_CODER_APP_ADDEX 193
#constant BUT_CODER_MORE 194
#constant BUT_CODER_APP_ADDLIB 195
#constant BUT_CODER_APP_REMLIB 196
#constant BUT_CODER_EDIT_ERASE 197
#constant BUT_CODER_EDIT_RECT_FILLED 198
#constant BUT_CODER_EDIT_OVAL_FILLED 199
#constant BUT_CODER_EDIT_IMAGE_ADD 200
#constant BUT_CODER_EDIT_TEXT_SIZE 201
#constant BUT_CODER_EDIT_RESIZE_TL 202
#constant BUT_CODER_EDIT_RESIZE_TP 203
#constant BUT_CODER_EDIT_RESIZE_TR 204
#constant BUT_CODER_EDIT_RESIZE_RT 205
#constant BUT_CODER_EDIT_RESIZE_BR 206
#constant BUT_CODER_EDIT_RESIZE_BT 207
#constant BUT_CODER_EDIT_RESIZE_BL 208
#constant BUT_CODER_EDIT_RESIZE_LT 209
#constant BUT_CODER_EDIT_SET_SIZE 210
#constant BUT_CODER_EDIT_LINE_SQR 211
#constant BUT_CODER_EDIT_LINE_CIRC 212
#constant BUT_CODER_VIEW_IMAGE 213
#constant BUT_CODER_AUTO_NAMING 214
#constant BUT_CODER_LIBRARIES 215
#constant BUT_CODER_CMD_SIZE 216
#constant BUT_CODER_HELP_SIZE 217
#constant BUT_CODER_EDITOR_POS 218
#constant BUT_CODER_ITEM_PLAY 219
#constant BUT_CODER_VAR_ADD_ABOVE 220
#constant BUT_CODER_VAR_ADD_BELOW 221
#constant BUT_CODER_VAR_CLEAR 222

#constant BUT_RUNNER_STOP 301
#constant BUT_RUNNER_RUN 302
#constant BUT_RUNNER_BACK 303
#constant BUT_RUNNER_RESET 304
#constant BUT_RUNNER_MORE 305
#constant BUT_RUNNER_PAUSE 306
#constant BUT_RUNNER_RESUME 307
#constant BUT_RUNNER_SNAP 308
#constant BUT_RUNNER_START_RECORD 309
#constant BUT_RUNNER_END_RECORD 310
#constant BUT_RUNNER_MENU_POS 311
#constant BUT_RUNNER_AUTO_RUN 312

#constant BUT_EDITOR_NONE 500
#constant BUT_EDITOR_MORE 501
#constant BUT_EDITOR_BACK 502 
#constant BUT_EDITOR_SAVE 503
#constant BUT_EDITOR_CANCEL 504
#constant BUT_EDITOR_ZOOM_IN 505
#constant BUT_EDITOR_ZOOM_OUT 506
#constant BUT_EDITOR_LINE 507
#constant BUT_EDITOR_RECT 508
#constant BUT_EDITOR_OVAL 509
#constant BUT_EDITOR_FILL 510
#constant BUT_EDITOR_CUT 511
#constant BUT_EDITOR_CLEAR 512
#constant BUT_EDITOR_FLIP_HORIZ 513
#constant BUT_EDITOR_FLIP_VERT 514
#constant BUT_EDITOR_ROT_LEFT 515
#constant BUT_EDITOR_ROT_RIGHT 516
#constant BUT_EDITOR_GRID_SNAP 517
#constant BUT_EDITOR_SPLIT 518
#constant BUT_EDITOR_SELECT 519
#constant BUT_EDITOR_PAN 520
#constant BUT_EDITOR_COLOR 521
#constant BUT_EDITOR_PICKER 522
#constant BUT_EDITOR_DRAW 523
#constant BUT_EDITOR_COPY 524
#constant BUT_EDITOR_PASTE 525
#constant BUT_EDITOR_REDO 526
#constant BUT_EDITOR_UNDO 527
#constant BUT_EDITOR_GRID_ROWS 528
#constant BUT_EDITOR_GRID_COLS 529
#constant BUT_EDITOR_RESIZE 530
#constant BUT_EDITOR_ZOOM_RESET 531
#constant BUT_EDITOR_LINE_SIZE 532
#constant BUT_EDITOR_CROP 533
#constant BUT_EDITOR_TEXT 534
#constant BUT_EDITOR_IMAGE 535
#constant BUT_EDITOR_RECT_SEL 536
#constant BUT_EDITOR_OVAL_SEL 537
#constant BUT_EDITOR_LINE_CIRC 538
#constant BUT_EDITOR_LINE_SQR 539
#constant BUT_EDITOR_ERASE 540
#constant BUT_EDITOR_TEXT_SIZE 541
#constant BUT_EDITOR_DESELECT 542
#constant BUT_EDITOR_SQUARE 543
#constant BUT_EDITOR_FILLED 544
#constant BUT_EDITOR_CIRCLE 545
#constant BUT_EDITOR_TEXT_EDIT 546
#constant BUT_EDITOR_SHAPE 547
#constant BUT_EDITOR_CANCEL_EDIT 548 // The editor was cancelled.
#constant BUT_EDITOR_SHAPE_SEL 549 // The button on the shape bar.
#constant BUT_EDITOR_DRAW_SEL 550
#constant BUT_EDITOR_LINE_SEL 551
#constant BUT_EDITOR_FILL_SEL 552
#constant BUT_EDITOR_POLY 553
#constant BUT_EDITOR_POLY_SIDES 554
#constant BUT_EDITOR_TEXT_PLACE 555
#constant BUT_EDITOR_IMAGE_PLACE 556
#constant BUT_EDITOR_EDIT_LAST 557
#constant BUT_EDITOR_SAME_SIDES 558
#constant BUT_EDITOR_GRID_WIDTH 559
#constant BUT_EDITOR_GRID_HEIGHT 560
#constant BUT_EDITOR_ZOOM_FIT 561
#constant BUT_EDITOR_TEXT_FONT 562
#constant BUT_EDITOR_TEXT_PLACE_MID 563
#constant BUT_EDITOR_IMAGE_PLACE_MID 564

//-----------------------------------------------------
// Tip styles.
//
#constant TIP_INFO 1
#constant TIP_WARN 2
#constant TIP_ERROR 3
#constant TIP_HELP 4
#constant TIP_PRINT 5
#constant TIP_PRINT_AT 6

//-----------------------------------------------------
// Scrolling values.
//
#constant SCROLL_FRICTION = 0.08  //Amount of friction to apply to scroll control
#constant SCROLL_FRICTION_WIN = 0.2 //Amount of friction to apply to scroll control
#constant CLICK_START_DIST = 42.0 //Square of the distance from origin to determine whether the user intends to click or scroll	

#constant GUI_BAR_EDGE 6
#constant GUI_SHADOW_SIZE 8

#constant GUI_TIP_DEPTH 120
#constant GUI_POP_DEPTH 130
#constant GUI_HELP_DEPTH 195 // 150
#constant GUI_KEY_DEPTH 140
#constant GUI_TOP_DEPTH 180
#constant GUI_VALUE_DEPTH 187
#constant GUI_CTRL_DEPTH 188
#constant GUI_BACK_DEPTH 189
#constant GUI_SHADOW_DEPTH 190
#constant GUI_BEHIND_DEPTH 198
#constant GUI_OVER_DEPTH 10 // This amount is subtracted to raise above other items.

#constant GUI_HOLD_TIME 500 // 200 The time to wait before showing a popup.

#constant GUI_PANEL_ALL 0x3
#constant GUI_PANEL_BARS 0x1
#constant GUI_PANEL_PAN 0x2
#constant GUI_PANEL_WHEEL 0x4

//-----------------------------------------------------
//
global gui as Gui

//-----------------------------------------------------
// Gui types.
//
type Gui

	scrollFriction as float
	normalButBgImg as integer
	mediumButBgImg as integer
	largeButBgImg as integer
	hugeButBgImg as integer
	smallButBgImg as integer
	sideButBgImg as integer
	sideButShadowImg as integer
	bigSideButBgImg as integer
	bigSideButShadowImg as integer
	butSelImg as integer
	tip as Tip
	tipBgColor as integer
	tipBorderColor as integer
	tipTextColor as integer
	tipUpImg as integer
	tipFont as integer
	tipFontSize as integer
	butTipImg as integer
	tipBoxImg as integer
	barSize as float
	pollStyle as integer
	butFontSize as integer
	keyFontSize as integer
	fadeAlpha as integer
	inactiveAlpha as integer
	shadowAlpha as integer
	butSelRatio as float
	titleFontSize as integer
	editFontSize as integer
	nameFontSize as integer
	cmdFontSize as integer
	onImg as integer
	offImg as integer
	crossImg as integer
	butPress as integer
	
endtype

type Tip

	arrow as integer
	arrowShadow as integer
	border as integer
	box as integer
	shadow as integer
	dir as integer
	text2 as integer
	cross as integer
	font as integer
	fontSize as integer

endtype

type Toolbar

	buts as Button[]
	vis as integer
	butIdx as integer
	bg as integer
	sbg as integer
	dir as integer
	arrow as integer
	arrowShadow as integer
	rowLen as integer // Number of buts per row.

endtype

type Button

	id as integer
	sel as integer // Selected icon.
	bg as integer
	iconImg as integer
	icon as integer
	icon2Img as integer
	icon2 as integer
	text as integer
	text2 as integer // top text for a dual key.
	help as string
	active as integer
	selected as integer
	selBg as integer // If true, use a color change for selection, not a box.
	origBgCol as integer // For not sel.
	selBgCol as integer // For bgsel.
	bgType as integer
	vis as integer
	bgVis as integer
	depth as integer
	shadowImg as integer
	shadow as integer
	shadowVis as integer
	ox as float
	oy as float
	x0 as float
	y0 as float
	x1 as float
	y1 as float
	onOff as integer // If an ON_OFF button, this is the state.
	tip as integer // Note that the button has a menu.
	
endtype

type Panel

	id as integer
	panel as integer
	inset as integer
	vBar as integer
	vDrag as integer
	hBar as integer
	hDrag as integer
	vBarAllowed as integer
	hBarAllowed as integer
	vBarVis as integer
	hBarVis as integer
	vx as float
	vy as float
	vw as float
	vh as float
	cx as float
	cy as float
	cw as float
	ch as float
	selSpr as integer
	dx as float
	dy as float
	firstX as float
	firstY as float
	originX as float
	originY as float
	holding as integer
	xMomentum as float
	yMomentum as float
	//clickStart as integer
	scrolling as integer
	spr as integer // Testing scrolling.
	//endlessX as integer
	//endlessY as integer   //Uncap the XY boundaries

endtype

type Scroll 
	
	firstX as float
	firstY as float
	originX as float
	originY as float
	xMomentum as float
	yMomentum as float
	holding as integer
	scrolling as integer
	w as float
	h as float
	zone as integer
	time as integer
	spr as integer // Shows when the ptr is in the scroll zone.

endtype

//-----------------------------------------------------
// Create a standard button.
//
function guiInit()

	local i as integer
	local txt as integer

	if WIN_MODE
		gui.scrollFriction = SCROLL_FRICTION_WIN
	else 
		gui.scrollFriction = SCROLL_FRICTION
	endif
	
	gui.barSize = co.bs / 4
	//gui.endlessX = false
	//gui.endlessY = false
	gui.pollStyle = false
	gui.butFontSize = 0
	gui.keyFontSize = 2
	gui.tipFont = 0
	gui.tipFontSize = co.fontSizes[0]
	gui.titleFontSize = 1
	gui.editFontSize = 2
	gui.nameFontSize = 0
	gui.cmdFontSize = 1
	gui.fadeAlpha = 192
	gui.inactiveAlpha = 127
	gui.shadowAlpha = 63
	
	// Button bg's.
	gui.normalButBgImg = loadimage("gfx/NormalButBg.png")
	gui.mediumButBgImg = loadimage("gfx/MediumButBg.png")
	gui.largeButBgImg = loadimage("gfx/LargeButBg.png")
	gui.hugeButBgImg = loadimage("gfx/HugeButBg.png")
	gui.smallButBgImg = loadimage("gfx/SmallButBg.png")
	gui.sideButBgImg = loadimage("gfx/SideButBg.png")
	gui.sideButShadowImg = loadimage("gfx/SideButShadow.png")
	gui.bigSideButBgImg = loadimage("gfx/BigSideButBg.png")
	gui.bigSideButShadowImg = loadimage("gfx/BigSideButShadow.png")
	gui.onImg = loadimage("gfx/On3Icon.png")
	gui.offImg = loadimage("gfx/Off3Icon.png")
	gui.crossImg = loadimage("gfx/CloseIcon.png")

	gui.tipUpImg = loadimage("gfx/TipUp.png")
	gui.tipBoxImg = loadimage("gfx/TipBox.png")

	// Button selection.
	gui.butTipImg = loadimage("gfx/TipCnr.png")
	gui.butSelImg = loadimage("gfx/ButSel.png")
	gui.butSelRatio = getimagewidth(gui.butSelImg) / getimagewidth(gui.normalButBgImg)

	guiSetPrintTipColors(co.grey[0], co.grey[3], co.black)
	guiSetPrintTipFont(0, co.fontSizes[0])
	guiCreateTip(gui.tip, true)
	guiHideTip(gui.tip)

endfunction

//-----------------------------------------------------
// Create a toolbar.
//
function guiCreateToolbar()

	local bar as Toolbar
	
	// Button selection.
	bar.butIdx = -1
	bar.rowLen = -1
	
	bar.bg = guiCreateBox("guiCreateToolbar:bar.bg", 1, 1)
	coSetSpriteColor(bar.bg, co.bluegrey[1])
	SetSpriteVisible(bar.bg, false)
	SetSpriteDepth(bar.bg, GUI_BACK_DEPTH)
	
	bar.sbg = guiCreateBox("guiCreateToolbar.bar.sbg", 1, 1)
	coSetSpriteColor(bar.sbg, co.black)
	SetSpriteVisible(bar.sbg, false)
	SetSpriteColorAlpha(bar.sbg, gui.shadowAlpha)
	SetSpriteDepth(bar.sbg, GUI_SHADOW_DEPTH)

	bar.arrow = cocreatesprite("guiCreateToolbarp:tip.arrow", gui.tipUpImg)
	coSetSpriteColor(bar.arrow, co.bluegrey[1])
	SetSpriteVisible(bar.arrow, false)
	SetSpriteDepth(bar.arrow, GUI_BACK_DEPTH)

	bar.arrowshadow = cocreatesprite("guiCreateToolbarp:tip.arrowshadow", gui.tipUpImg)
	SetSpriteScale(bar.arrowshadow, 0.5, 0.5)
	coSetSpriteColor(bar.arrowshadow, co.black)
	SetSpriteColorAlpha(bar.arrowShadow, gui.shadowAlpha)
	SetSpriteVisible(bar.arrowshadow, false)
	SetSpriteDepth(bar.arrowshadow, GUI_SHADOW_DEPTH)

	bar.dir = DIR_N

endfunction bar

//-----------------------------------------------------
// Delete a toolbar.
//
function guiDeleteToolbar(bar ref as Toolbar)
	
	if bar.bg
		
		deletesprite(bar.bg)
		bar.bg = 0
		
	endif

	if bar.bg
		
		deletesprite(bar.bg)
		bar.bg = 0
		
	endif

	if bar.arrow
		
		deletesprite(bar.arrow)
		bar.arrow = 0
		
	endif
	
	if bar.arrowShadow
		
		deletesprite(bar.arrowShadow)
		bar.arrowShadow = 0
		
	endif

endfunction

//-----------------------------------------------------
// Create a standard button.
//
function guiCreateButton(label as string, bgType as integer, gfxFile as string, col as integer)

	local but as Button
	local w as float
	local h as float

	but.bgType = bgType
	but.origBgCol = col

	if bgType = BUT_KEY or bgType = BUT_MEDIUM_KEY or bgType = BUT_LARGE_KEY or bgType = BUT_HUGE_KEY
		but.depth = GUI_KEY_DEPTH - 2
	else
		but.depth = GUI_BACK_DEPTH
	endif
	
	if bgType = BUT_KEY
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.normalButBgImg)
		//SetSpriteDepth(but.bg, FRONT_DEPTH - 2)
		SetSpriteScale(but.bg, 0.75, 0.75)

	elseif bgType = BUT_MEDIUM_KEY
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.mediumButBgImg)
		//SetSpriteDepth(but.bg, FRONT_DEPTH - 2)
		SetSpriteScale(but.bg, 0.75, 0.75)

	elseif bgType = BUT_LARGE_KEY
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.largeButBgImg)
		//SetSpriteDepth(but.bg, FRONT_DEPTH - 2)
		SetSpriteScale(but.bg, 0.75, 0.75)

	elseif bgType = BUT_HUGE_KEY
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.hugeButBgImg)
		//SetSpriteDepth(but.bg, FRONT_DEPTH - 2)
		SetSpriteScale(but.bg, 0.75, 0.75)
		
	elseif bgType = BUT_BG_NORMAL
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.normalButBgImg)
		
	elseif bgType = BUT_BG_SMALL
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.smallButBgImg)
		
	elseif bgType = BUT_BG_BIG_TOP_TAB
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.bigSideButBgImg)
		
	elseif bgType = BUT_BG_LEFT_TAB
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.sideButBgImg)
		
	elseif bgType = BUT_BG_TOP_TAB
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.sideButBgImg)
		SetSpriteAngle(but.bg, 90)
		
	elseif bgType = BUT_BG_BOT_TAB
		
		but.bg = coCreateSprite("guiCreateButton.but.bg", gui.sideButBgImg)
		SetSpriteAngle(but.bg, -90)

	elseif bgType = BUT_BG_NONE

		but.bg = guiCreateBox("guiCreateButton.but.bg", co.bs, co.bs)
		
	endif

	if but.bg
		
		SetSpriteDepth(but.bg, but.depth)	
		cosetspritecolor(but.bg, but.origBgCol)

	endif

	if gfxFile <> ""

		if bgType = BUT_KEY or bgType = BUT_MEDIUM_KEY or bgType = BUT_LARGE_KEY or bgType = BUT_HUGE_KEY

			if label = ""

				but.iconImg = coloadimage("guiCreateButton:key icon", gfxFile)
				guiSetButtonIcon(but, but.iconImg)
				coSetSpriteColor(but.icon, co.black)
				SetSpriteScale(but.icon, 0.75, 0.75)
				SetSpriteDepth(but.icon, but.depth - 1)
				but.text2 = 0
				
			else

				but.text2 = guicreatetext(gfxFile, gui.keyFontSize)
				coSetTextColor(but.text2, co.black)
				SettextDepth(but.text2, but.depth - 1)
				but.icon = 0

			endif

		else

			but.iconImg = coloadimage("guiCreateButton:but icon", gfxFile)
			guiSetButtonIcon(but, but.iconImg)

		endif

	else

		but.iconImg = 0
		but.icon = 0
		but.icon2Img = 0
		but.icon2 = 0
		
	endif

	if label <> ""

		if bgType = BUT_KEY or bgType = BUT_MEDIUM_KEY or bgType = BUT_LARGE_KEY or bgType = BUT_HUGE_KEY
				
			but.text = guicreatetext(label, gui.keyFontSize)
			coSetTextColor(but.text, co.black)
			SettextDepth(but.text, but.depth - 1)

		else
			
			but.text = guicreatetext(label, gui.butFontSize)
			coSetTextColor(but.text, co.white)
			SettextDepth(but.text, but.depth - 1)

		endif

	else

		but.text = 0
		
	endif
	
	if bgType = BUT_BG_BIG_TOP_TAB or bgType = BUT_BG_LEFT_TAB //or bgType = BUT_BG_TOP_TAB or bgType = BUT_BG_BOT_TAB
		
		if bgType = BUT_BG_BIG_TOP_TAB
			but.shadow = createsprite(gui.bigSideButShadowImg)			
		else			
			but.shadow = createsprite(gui.sideButShadowImg)
		endif


		if bgType = BUT_BG_TOP_TAB		
			SetSpriteAngle(but.shadow, 90)		
		elseif bgType = BUT_BG_BOT_TAB
			SetSpriteAngle(but.shadow, -90)
		endif

	endif

	if but.shadow
		
		coSetSpriteColor(but.shadow, co.black)
		SetSpriteColorAlpha(but.shadow, gui.shadowAlpha)
		SetspriteDepth(but.shadow, but.depth + 1)
		SetSpriteVisible(but.shadow, false)

	endif
	
	but.ox = 0
	but.oy = 0
	but.x0 = 0
	but.y0 = 0
	but.x1 = 0
	but.y1 = 0
	but.vis = true
	but.shadowVis = false
	but.active = true
	but.sel = 0
	but.selected = false
	but.selBg = false
	but.selBgCol = but.bg
	but.tip = 0
	
	if bgType = BUT_BG_NONE
		but.bgVis = false
	else
		but.bgVis = true
	endif
		
endfunction but

//-----------------------------------------------------
// Set the icon for a but.
//
function guiSetButtonIcon(but ref as Button, img as integer)

	local b as float
	local w as float
	local h as float
	local s as float

	// Already set cleanup.
	if but.icon
		
		coDeleteSprite("guiSetButtonIcon:but.icon", but.icon)
		but.icon = 0

		// If this is set, I created it (i.e. not passed in), so I can delete it.
		if but.iconImg

			DeleteImage(but.iconImg)
			but.iconImg = 0

		endif

	endif

	if img

		but.icon = coCreateSprite("guiSetButtonIcon.but.iconImg", img)
		SetSpriteDepth(but.icon, GUI_CTRL_DEPTH)
		//SetSpriteDepth(but.icon, but.depth - 1)
		SetSpriteVisible(but.icon, but.vis)

		b = getspritewidth(but.bg) // 96

		if but.text			
			b = b - GetTextTotalHeight(but.text)			
		endif

		coResizeSprite(but.icon, b)
		
	endif

	guiSetButtonDepth(but, but.depth)
	guiSetButtonPos(but, GetSpriteXByOffset(but.bg), GetSpriteYByOffset(but.bg))
	
endfunction

//-----------------------------------------------------
// Set the icon for a but.
//
function guiSetButtonIcon2(but ref as Button, img as integer)

	local b as float
	local w as float
	local h as float
	local s as float
	
	if but.icon2
		
		coDeleteSprite("guiSetButtonIcon:but.icon", but.icon2)
		but.icon2 = 0

		// If this is set, I created it (i.e. not passed in), so I can delete it.
		if but.icon2Img

			DeleteImage(but.icon2Img)
			but.icon2Img = 0

		endif

	endif

	if img

		but.icon2 = coCreateSprite("guiSetButtonIcon.but.iconImg", img)
		SetSpriteDepth(but.icon2, GUI_CTRL_DEPTH)
		//SetSpriteDepth(but.icon2, but.depth - 2)
		SetSpriteColorAlpha(but.icon2, 160)
		SetSpriteVisible(but.icon2, but.vis)

		b = getspritewidth(but.bg) // 96

		if but.text
			b = b - GetTextTotalHeight(but.text)
		endif
		
	endif

	guiSetButtonDepth(but, but.depth)
	guiSetButtonPos(but, GetSpriteXByOffset(but.bg), GetSpriteYByOffset(but.bg))
	
endfunction

//-----------------------------------------------------
// Set the text for a but.
//
function guiSetButtonText(but ref as Button, label as string)

	local w as float
	local t as string
	
	if but.text
		
		coDeleteText("guiSetButtonText:but.text", but.text)
		but.text = 0

	endif

	but.text = guicreatetext(label, gui.butFontSize)

	w = GetSpriteWidth(but.bg)
	guiSetTextToWidth(but.text, label, w)
	coSetTextColor(but.text, co.white)
	guiSetButtonDepth(but, but.depth)

	if not but.vis
		SettextVisible(but.text, false)
	endif

	guiSetButtonPos(but, GetSpriteXByOffset(but.bg), GetSpriteYByOffset(but.bg))
	
endfunction

//-----------------------------------------------------
// Set the pos of a button.
//
function guiSetButtonPos(but ref as Button, x as float, y as float)
	
	if but.bg
		SetSpritePositionByOffset(but.bg, x, y)
	endif

	if but.bgType = BUT_KEY or but.bgType = BUT_MEDIUM_KEY or but.bgType = BUT_LARGE_KEY or but.bgType = BUT_HUGE_KEY

		if but.text and but.text2
			
			SetTextPosition(but.text2, x, y - GetTextTotalHeight(but.text) / 2 - co.bs / 8 - co.bs / 16)
			SetTextAlignment(but.text2, 1)
			SetTextPosition(but.text, x, y - GetTextTotalHeight(but.text) / 2 + co.bs / 8)
			SetTextAlignment(but.text, 1)

		elseif but.text
			
			SetTextPosition(but.text, x, y - GetTextTotalHeight(but.text) / 2)
			SetTextAlignment(but.text, 1)

		elseif but.icon
			
			SetSpritePositionByOffset(but.icon, x, y)

		endif

		if but.shadow
			SetSpritePositionByOffset(but.shadow, x + GUI_SHADOW_SIZE, y + GUI_SHADOW_SIZE)
		endif
		
	else
		
		if but.icon and but.icon2
			
			if but.text
				
				SetSpritePositionByOffset(but.icon, x, y - co.bs / 8)
				SetSpritePositionByOffset(but.icon2, x, y - co.bs / 8)
				//SetSpritePositionByOffset(but.icon2, x, y + GetSpriteHeight(but.bg) / 2 - GetTextTotalHeight(but.text) / 2 - GetSpriteHeight(but.bg) / 32)
				
			else
				
				SetSpritePositionByOffset(but.icon, x, y)
				SetSpritePositionByOffset(but.icon2, x, y)
				
			endif
			
		elseif but.icon
			
			if but.text
				SetSpritePositionByOffset(but.icon, x, y - co.bs / 8)
			else
				SetSpritePositionByOffset(but.icon, x, y)
			endif
			
		endif

		if but.text

			if but.bgType = BUT_BG_NONE or (not but.icon and not but.icon2)
				SetTextPosition(but.text, x, y - GetTextTotalHeight(but.text) / 2 - GetSpriteHeight(but.bg) / 32)
			else
				//SettextPosition(but.text, x, y + co.bs / 2 - co.bs / 3)
				SetTextPosition(but.text, x, y + GetSpriteHeight(but.bg) / 2 - GetTextTotalHeight(but.text) - GetSpriteHeight(but.bg) / 32)
			endif
			
			SetTextAlignment(but.text, 1)

		endif

		if but.shadow
			if but.bgType = BUT_BG_NORMAL or but.bgType = BUT_BG_SMALL
				SetSpritePositionByOffset(but.shadow, x + GUI_SHADOW_SIZE, y + GUI_SHADOW_SIZE)
			else // Tab
				SetSpritePositionByOffset(but.shadow, x, y)
			endif
		endif

		if but.sel
			SetSpritePositionByOffset(but.sel, x, y)
		endif

		if but.tip
			SetSpritePositionByOffset(but.tip, x + GetSpriteWidth(but.bg) / 2 - getspritewidth(but.tip) / 2 - co.bs / 16, y - GetSpriteHeight(but.bg) / 2 + GetSpriteHeight(but.tip) / 2 + co.bs / 32)
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the depth of a button.
//
function guiSetButtonDepth(but ref as Button, depth as integer)

	but.depth = depth

	if but.bg
		SetSpriteDepth(but.bg, depth)
	endif

	if but.sel
		SetSpriteDepth(but.sel, depth)
	endif

	if but.tip
		SetSpriteDepth(but.tip, depth - 2)
	endif
	
	if but.icon
		SetSpriteDepth(but.icon, depth - 2)
	endif

	if but.icon2
		SetSpriteDepth(but.icon2, depth - 3)
	endif

	if but.text
		SetTextDepth(but.text, depth - 4)
	endif

	if but.text2
		SetTextDepth(but.text2, depth - 4)
	endif

	if but.shadow
		SetSpriteDepth(but.shadow, depth + 1)
	endif
	
endfunction

//-----------------------------------------------------
// Set the depth of a button.
//
function guiSetButtonScissor(but ref as Button, x0 as float, y0 as float, x1 as float, y1 as float)

	local i as integer

	but.x0 = x0
	but.y0 = y0
	but.x1 = x1
	but.y1 = y1

	if but.bg
		SetSpriteScissor(but.bg, x0, y0, x1, y1)
	endif

	if but.tip
		SetSpriteScissor(but.tip, x0, y0, x1, y1)
	endif

	if but.icon
		SetSpriteScissor(but.icon, x0, y0, x1, y1)
	endif

	if but.icon2
		SetSpriteScissor(but.icon2, x0, y0, x1, y1)
	endif

	if but.text
		SetTextScissor(but.text, x0, y0, x1, y1)
	endif

	if but.text2
		SetTextScissor(but.text2, x0, y0, x1, y1)
	endif

	if but.shadow
		SetSpriteScissor(but.shadow, x0, y0, x1, y1)
	endif

	if but.sel
		SetTextScissor(but.sel, x0, y0, x1, y1)
	endif
	
endfunction

//-----------------------------------------------------
// Set the depth of a button.
//
function guiDeleteButton(but ref as Button)

	if but.bg
		
		DeleteSprite(but.bg)
		but.bg = 0
		
	endif

	if but.icon
		
		DeleteSprite(but.icon)
		but.icon = 0

	endif

	if but.iconImg
		
		DeleteImage(but.iconImg)
		but.iconImg = 0

	endif

	if but.icon2
		
		DeleteSprite(but.icon2)
		but.icon2 = 0

	endif

	if but.icon2Img
		
		DeleteImage(but.icon2Img)
		but.icon2Img = 0

	endif

	if but.text
		
		Deletetext(but.text)
		but.text = 0

	endif

	if but.text2

		Deletetext(but.text2)
		but.text2 = 0

	endif

	if but.shadow

		DeleteSprite(but.shadow)
		but.shadow = 0

	endif

	if but.sel

		DeleteSprite(but.sel)
		but.sel = 0

	endif

	but.active = false
	
endfunction

//-----------------------------------------------------
// Set a button active.
//
function guiSetButtonActive(but ref as Button, active as integer)

	but.active = active

	if active
		guiSetButtonAlpha(but, 255)
	else
		guiSetButtonAlpha(but, gui.inactiveAlpha)
	endif
	
endfunction

//-----------------------------------------------------
// Set the active state of a button.
//
function guiGetButtonActive(but ref as Button)

endfunction but.active

//-----------------------------------------------------
// Get vis  state of a button.
//
function guiGetButtonVisible(but ref as Button)

endfunction but.vis

//-----------------------------------------------------
// Set the color of a button.
//
function guiSetButtonBgCol(but ref as Button, col as integer)

	but.origBgCol = col
	guiResetButton(but)
	
endfunction

//-----------------------------------------------------
// Set the selection bg color of a button.
// selBg - Set the but to use selection based on background color.
// Otherwise it uses a black box.
//
function guiSetButtonBgSel(but ref as Button, selBg as integer, col as integer)

	but.selBg = selBg
	but.selBgCol = col
	guiSetButtonSelected(but, but.selected) // Reset the selection.
		
endfunction

//-----------------------------------------------------
// Set the vis of a button.
//
function guiSetButtonBgVisible(but ref as Button, vis as integer)

	but.bgVis = vis
	guiSetButtonVisible(but, but.vis)
	
endfunction

//-----------------------------------------------------
// Set the vis of a button.
//
function guiSetButtonShadowVisible(but ref as Button, vis as integer)

	but.shadowVis = vis
	guiSetButtonVisible(but, but.vis)
	
endfunction

//-----------------------------------------------------
// Set the vis of a button.
//
function guiSetButtonVisible(but ref as Button, vis as integer)
	
	but.vis = vis

	if but.bg
		
		coSetSpriteColor(but.bg, but.origBgCol)
		setspritevisible(but.bg, vis and but.bgVis)
		
	endif

	if but.tip
		setspritevisible(but.tip, vis)
	endif

	if but.icon
		setspritevisible(but.icon, vis)
	endif

	if but.icon2
		setspritevisible(but.icon2, vis)
	endif

	if but.text
		settextvisible(but.text, vis)
	endif

	if but.text2
		settextvisible(but.text2, vis)
	endif

	if but.shadow
		setspritevisible(but.shadow, vis and but.shadowVis)
	endif

	if but.selBg
		if vis
			if but.selected
				coSetSpriteColor(but.bg, but.selBgcol)
			else
				coSetSpriteColor(but.bg, but.origBgcol)
			endif
		endif
	else
		if but.sel
			setspritevisible(but.sel, vis and but.selected)
		endif
	endif
		
endfunction

//-----------------------------------------------------
// Create a panel.
//
function guiCreatePanel(w as float, h as float, baseDepth as integer, vBar as integer, hBar as integer)

	local panel as Panel
	local x as float
	local y as float
	
	panel.panel = guiCreateBox("guiCreatePanel:panel.panel", w, h)

	panel.vx = 0
	panel.vy = 0
	panel.vw = w
	panel.vh = h
	panel.cx = panel.vx
	panel.cy = panel.vy
	panel.cw = panel.vw
	panel.ch = panel.vh
	panel.selSpr = 0
	//panel.endlessX = false
	//panel.endlessY = false
	
	panel.VBar = guiCreateBox("guiCreatePanel:panel.vbar", 1, 1)
	//SetSpriteDepth(panel.VBar, GUI_BAR_DEPTH)

	panel.VDrag = guicreatebox("guiCreatePanel:panel.vdrag", 1, 1)
	//SetSpriteDepth(panel.VDrag, GUI_BAR_DEPTH - 1)

	panel.HBar = guiCreateBox("guiCreatePanel:panel.hbar", 1, 1)			
	//SetSpriteDepth(panel.HBar, GUI_BAR_DEPTH)

	panel.HDrag = guicreatebox("guiCreatePanel:panel.hdrag", 1, 1)
	//SetSpriteDepth(panel.HDrag, GUI_BAR_DEPTH - 1)

	guiSetPanelDepth(panel, baseDepth)
	
	panel.vBarAllowed = vBar
	panel.hBarAllowed = hBar
	panel.vBarVis = false
	panel.hBarVis = false

	guiSetPanelBarsVisible(panel, false)

	panel.holding = false
	//panel.clickStart = false
	panel.xMomentum = 0
	panel.yMomentum = 0
	panel.scrolling = false
	
endfunction panel

//-----------------------------------------------------
// Delete a panel.
//
function guiDeletePanel(panel ref as Panel)

	if panel.panel
		
		deletesprite(panel.panel)
		panel.panel = 0
		
	endif

	if panel.vbar
		
		deletesprite(panel.vbar)
		panel.vbar = 0
		
	endif

	if panel.hbar
		
		deletesprite(panel.hbar)
		panel.hbar = 0
		
	endif

	if panel.vdrag
		
		deletesprite(panel.vdrag)
		panel.vdrag = 0
		
	endif

	if panel.hdrag
		
		deletesprite(panel.hdrag)
		panel.hdrag = 0
		
	endif
		
endfunction

//-----------------------------------------------------
// Set the depth of the panel.
//
function guiSetPanelDepth(panel ref as Panel, depth as integer)
	
	SetSpriteDepth(panel.panel, depth)
	SetSpriteDepth(panel.VBar, depth - 2)
	SetSpriteDepth(panel.VDrag, depth - 4)
	SetSpriteDepth(panel.HBar, depth - 2)
	SetSpriteDepth(panel.HDrag, depth - 4)

endfunction

//-----------------------------------------------------
// Check if the panel was pressed.
// Touch panel, keep offset for scrolling.
// Touch scroll bar, empty area or bar.
// mode = GUI_PANEL_ALL, GUI_PANEL_BARS, GUI_PANEL_PAN
//
function guiPanelPressed(panel ref as Panel, x as float, y as float, mode as integer)
	
	panel.selSpr = 0

	if mode && GUI_PANEL_WHEEL
		
		//if coGetSpriteHitTest(panel.vDrag, x, y, 0)
		if not panel.selSpr and coPointWithinRect(x, y, panel.vx, panel.vy, panel.vw, panel.vh)
					
			panel.selSpr = panel.vDrag

			panel.firstX = GetSpritexByOffset(panel.vDrag)
			panel.firstY = GetSpriteYByOffset(panel.vDrag) + in.mouseWheelDelta
			panel.originX = panel.cx
			panel.originY = panel.cy
			
		endif

	else

		if mode && GUI_PANEL_BARS
			
			if panel.vBarVis
				
				//if coGetSpriteHitTest(panel.vDrag, x, y, 0)
				if coGetSpriteHitTest3(panel.vDrag, x, y, 0, gui.barSize, 0, 0)
					
					panel.selSpr = panel.vDrag
					panel.firstX = x
					panel.firstY = y
					panel.originX = panel.cx
					panel.originY = panel.cy
		
				elseif coGetSpriteHitTest(panel.vBar, x, y, 0)
					
					panel.selSpr = panel.vBar
					
				endif
				
			endif
		
			if not panel.selSpr and panel.hBarVis
				
				//if coGetSpriteHitTest(panel.hDrag, x, y, 0)
				if coGetSpriteHitTest3(panel.hDrag, x, y, 0, 0, 0, gui.barSize)
					
					panel.selSpr = panel.hDrag
					panel.firstX = x
					panel.firstY = y
					panel.originX = panel.cx
					panel.originY = panel.cy
		
				elseif coGetSpriteHitTest(panel.hBar, x, y, 0)
					
					panel.selSpr = panel.hBar
					
				endif
				
			endif
			
		endif
	
		if mode && GUI_PANEL_PAN
			
			// Panel itself.
			if not panel.selSpr and coPointWithinRect(x, y, panel.vx, panel.vy, panel.vw, panel.vh)
						
				panel.selSpr = panel.panel
		
				panel.firstX = x
				panel.firstY = y
				panel.originX = x
				panel.originY = y
		
				//Start checking to see whether this is a click or a scroll.
				// If the control is currently spinning with momentum, then don't process a click, just stop the control.
				// Otherwise, process a click.		
				//If panel.yMomentum = 0 And panel.xMomentum = 0 Then panel.clickStart = True
		
				panel.xMomentum = 0
				panel.yMomentum = 0
				panel.holding = true
				panel.scrolling = True
					
			endif
			
		endif
		
	endif
		
endfunction panel.selSpr

//-----------------------------------------------------
// Check if the panel was moved, or left the area that was original touched.
//
function guiPanelMoved(panel ref as Panel, x as float, y as float)

	if panel.selSpr = panel.panel
		
		panel.holding = True
		
	elseif panel.selSpr = panel.vDrag

		panel.cy = panel.originY - ((y - panel.firstY) / (getspriteheight(panel.vDrag) / getspriteheight(panel.vBar)))
		
	elseif panel.selSpr = panel.hDrag

		panel.cx = panel.originX - ((x - panel.firstX) / (getspritewidth(panel.hDrag) / getspritewidth(panel.hBar)))

	endif
	
endfunction

//-----------------------------------------------------
//
function guiPanelReleased(panel ref as Panel, x as float, y as float)

	if panel.selSpr = panel.hBar

		if x < getspritex(panel.hDrag)
			panel.cx = 0
		elseif x > getspritex(panel.hDrag) + GetSpritewidth(panel.hDrag)
			panel.cx = - 0xFFFFFF
		endif
		
	elseif panel.selSpr = panel.vBar

		if y < getspritey(panel.vDrag)
			panel.cy = 0
		elseif y > getspritey(panel.vDrag) + GetSpriteHeight(panel.vDrag)
			panel.cy = - 0xFFFFFF
		endif

	endif

	panel.selSpr = 0
	panel.holding = False
		
	// Put the first click origins into a galaxy far, far away. 
	// Prevents re-clicks from instantly stopping the scroller on the next poll.
	panel.firstX = - 0xFFFFFF
	panel.firstY = - 0xFFFFFF  
	
endfunction

//-----------------------------------------------------
// Check if the panel was moved, or left the area that was original touched.
//
function guiPanelPoll(panel ref as Panel, x as float, y as float)

	// Don't scroll if editing.
	if cdIsEditActive()
		exitfunction
	endif

	// Is the click+drag origin from tfchis control?
	Local originallyFromHere as integer
	Local amtX as Float
	Local amtY as Float
	//local ph as float
	//local py as float
	//local sy as float
	//local pw as float
	//local px as float
	//local sx as float
			
	originallyFromHere = coPointWithinRect(panel.firstX, panel.firstY, panel.vx, panel.vy, panel.vw, panel.vh)
	
	panel.xMomentum = panel.xMomentum * (1.0 - gui.scrollFriction)  //Apply friction
	panel.yMomentum = panel.yMomentum * (1.0 - gui.scrollFriction)

	//amtX = in.ptrX - panel.originX //Amount change from origin since last update
	//amtY = in.ptrY - panel.originY
	amtX = x - panel.originX //Amount change from origin since last update
	amtY = y - panel.originY

	If panel.holding and originallyFromHere // drag

		panel.cx = panel.cx + amtX //Increment the offset.
		panel.cy = panel.cy + amtY //Increment the offset.

		If Abs(amtX) > Abs(panel.xMomentum) Then panel.xMomentum = amtX //only add momentum if going faster than before.
		If Abs(amtY) > Abs(panel.yMomentum) Then panel.yMomentum = amtY

		If coSgn(amtX) <> 0 And coSgn(amtX) <> coSgn(panel.xMomentum) Then panel.xMomentum = amtX //stops direction popping
		If coSgn(amtY) <> 0 And coSgn(amtY) <> coSgn(panel.yMomentum) Then panel.yMomentum = amtY

		//panel.originX = in.ptrX //update the origin for next update		
		//panel.originY = in.ptrY
		panel.originX = x //update the origin for next update		
		panel.originY = y

	endif
	
	If not panel.holding Or (panel.holding And Not originallyFromHere)  //no drag.  Slide with momentum.

		panel.cx = panel.cx + panel.xMomentum
		panel.cy = panel.cy + panel.yMomentum

	EndIf
	
	//Dink the momentums if they're below threshold. 
	
	If abs(panel.xMomentum) > 0 and Abs(panel.xMomentum) < 0.01
		
		panel.xMomentum = 0
		panel.cx = Floor(panel.cx + 0.4) //round
		
	EndIf
	
	If abs(panel.yMomentum) > 0 and Abs(panel.yMomentum) < 0.01
		
		panel.yMomentum = 0
		panel.cy = Floor(panel.cy + 0.4) //round
		
	EndIf		

	If panel.cx > 0  //left

		panel.cx = 0
		panel.xMomentum = 0

	ElseIf panel.cw > panel.vw And -panel.cx > panel.cw - panel.vw  //right

		panel.cx = -(panel.cw - panel.vw)
		panel.xMomentum = 0

	ElseIf panel.cw <= panel.vw  //no X scroll possible

		panel.cx = 0
		panel.xMomentum = 0

	EndIf
	
	If panel.cy > 0  //top

		panel.cy = 0
		panel.yMomentum = 0

	ElseIf panel.ch > panel.vh And -panel.cy > panel.ch - panel.vh  //bottom

		panel.cy = -(panel.ch - panel.vh)
		panel.yMomentum = 0

	ElseIf panel.ch <= panel.vh  //no Y scroll possible

		panel.cy = 0
		panel.yMomentum = 0				

	EndIf

/*	
	if panel.vBarVis

		ph = GetSpriteHeight(panel.vBar) - GUI_BAR_EDGE * 2
		sy = panel.vh / panel.ch
		py = panel.vy + GUI_BAR_EDGE / 2 - panel.cy * sy 
		
		setspritescale(panel.vDrag, getspritewidth(panel.vBar) - GUI_BAR_EDGE * 2, ph * sy)
		SetSpritePosition(panel.vDrag, getspritex(panel.vBar) + GUI_BAR_EDGE, py)
		
	endif

	if panel.hBarVis

		pw = GetSpritewidth(panel.hBar) - GUI_BAR_EDGE * 2
		sx = panel.vw / panel.cw
		px = panel.vx + GUI_BAR_EDGE / 2 - panel.cx * sx
		
		setspritescale(panel.hDrag, pw * sx, getspriteheight(panel.hBar) - GUI_BAR_EDGE * 2)
		SetSpritePosition(panel.hDrag, px, getspritey(panel.hBar) + GUI_BAR_EDGE)
		
	endif
*/

	guiUpdatePanelBars(panel)
	
	panel.scrolling = Not (panel.xMomentum = 0 And panel.yMomentum = 0)
				
endfunction

//-----------------------------------------------------
// Update the panel bars based on current settings.
//
function guiUpdatePanelBars(panel ref as Panel)

	local ph as float
	local py as float
	local sy as float
	local pw as float
	local px as float
	local sx as float

	if panel.vBarVis

		ph = GetSpriteHeight(panel.vBar) - GUI_BAR_EDGE * 2
		sy = panel.vh / panel.ch
		py = panel.vy + GUI_BAR_EDGE / 2 - panel.cy * sy 

		setspritescale(panel.vDrag, getspritewidth(panel.vBar) - GUI_BAR_EDGE * 2, ph * sy)
		SetSpritePosition(panel.vDrag, getspritex(panel.vBar) + GUI_BAR_EDGE, py)
/*
		if sy >= 1.0

			SetSpriteVisible(panel.vDrag, false)
			SetSpriteVisible(panel.vBar, false)

		else

			SetSpriteVisible(panel.vDrag, true)
			SetSpriteVisible(panel.vBar, true)

		endif
*/		
	endif

	if panel.hBarVis

		pw = GetSpritewidth(panel.hBar) - GUI_BAR_EDGE * 2
		sx = panel.vw / panel.cw
		px = panel.vx + GUI_BAR_EDGE / 2 - panel.cx * sx
		
		setspritescale(panel.hDrag, pw * sx, getspriteheight(panel.hBar) - GUI_BAR_EDGE * 2)
		SetSpritePosition(panel.hDrag, px, getspritey(panel.hBar) + GUI_BAR_EDGE)

/*
		if sx >= 1.0

			SetSpriteVisible(panel.hDrag, false)
			SetSpriteVisible(panel.hBar, false)

		else

			SetSpriteVisible(panel.hDrag, true)
			SetSpriteVisible(panel.hBar, true)

		endif
*/		
	endif

endfunction

//-----------------------------------------------------
// Create a panel inset.
//
function guiCreatePanelInset(panel ref as Panel, col as integer)

	if panel.inset
		
		coDeleteSprite("guiCreatePanelInset:panel.inset", panel.inset)
		panel.inset = 0

	endif
	
	panel.inset = guiCreateBox("guiCreatePanelInset:panel.inset", GetSpriteWidth(panel.panel) - co.bs / 4, GetSpriteHeight(panel.panel) - co.bs / 4)
	coSetSpriteColor(panel.inset, col)
	SetSpriteDepth(panel.inset, GetSpriteDepth(panel.panel) - 2)

endfunction

//-----------------------------------------------------
// Set the panel pos.
//
function guiSetPanelPos(panel ref as Panel, x as float, y as float)

	SetSpritePosition(panel.panel, x, y)

	if panel.inset
		SetSpritePosition(panel.inset, x + co.bs / 8, y + co.bs / 8)
	endif

	panel.vx = getspritex(panel.panel)
	panel.vy = getspritey(panel.panel)
		
endfunction

//-----------------------------------------------------
// Determine if scrollbars are required.
//
function guiSetPanelContentSize(panel ref as Panel, cx0 as float, cy0 as float, cx1 as float, cy1 as float)
	
	panel.vx = getspritex(panel.panel)
	panel.vy = getspritey(panel.panel)
	panel.vw = GetSpriteWidth(panel.panel)
	panel.vh = GetSpriteHeight(panel.panel)
	panel.hBarVis = false
	panel.vBarVis = false

///* V1

	if panel.vBarAllowed and (cy0 < panel.vy or cy1 > panel.vy + panel.vh - 1)
			
		panel.vBarVis = true
		panel.vw = panel.vw - gui.barSize
		
	endif

	if panel.hBarAllowed and (cx0 < panel.vx or cx1 > panel.vx + panel.vw - 1)

		panel.hBarVis = true
		panel.vh = panel.vh - gui.barSize
		
	endif

	if cx0 > panel.vx
		cx0 = panel.vx
	endif

	if cy0 > panel.vy
		cy0 = panel.vy
	endif

	if cx1 < panel.vx + panel.vw - 1		
		cx1 = panel.vx + panel.vw - 1
	endif

	if cy1 < panel.vy + panel.vh - 1		
		cy1 = panel.vy + panel.vh - 1
	endif

//*/

	panel.cx = (cx0 - panel.vx)
	panel.cy = (cy0 - panel.vy)

	// V1+V2 Position content position to top left.
	panel.cw = cx1 - cx0 + 1
	panel.ch = cy1 - cy0 + 1

/* V2

	//panel.cx = 0
	//panel.cy = 0

	if panel.vBarAllowed and panel.ch > panel.vh
			
		panel.vBarVis = true
		panel.vw = panel.vw - gui.barSize
		
	endif

	if panel.hBarAllowed and panel.cw > panel.vw

		panel.hBarVis = true
		panel.vh = panel.vh - gui.barSize
		
	endif

	if not panel.vBarVis and panel.vBarAllowed and panel.ch > panel.vh
			
		panel.vBarVis = true
		panel.vw = panel.vw - gui.barSize
		
	endif

	if panel.cw < panel.vw
		panel.cw = panel.vw
	endif
	
	if panel.ch < panel.vh
		panel.ch = panel.vh
	endif

*/
					
	if panel.vBarVis and panel.hBarVis

		SetSpriteScale(panel.vbar, gui.barSize, GetSpriteHeight(panel.panel) - gui.barSize)
		setspritescale(panel.hbar, GetSpriteWidth(panel.panel) - gui.barSize, gui.barSize)

	elseif panel.vBarVis

		setspritescale(panel.vbar, gui.barSize, GetSpriteHeight(panel.panel))

	elseif panel.hBarVis

		setspritescale(panel.hbar, GetSpriteWidth(panel.panel), gui.barSize)

	endif

	SetSpritePosition(panel.VBar, getspritex(panel.panel) + GetSpriteWidth(panel.panel) - getspritewidth(panel.vbar), getspritey(panel.panel))
	SetSpritePositionByOffset(panel.VDrag, getspritex(panel.vBar) + getspritewidth(panel.vBar) / 2, getspritey(panel.vBar) + GetSpriteWidth(panel.vBar) + GetSpriteHeight(panel.vDrag) / 2)	
	SetSpritePosition(panel.HBar, getspritex(panel.panel), getspritey(panel.panel) + GetSpriteHeight(panel.panel) - GetSpriteHeight(panel.hbar))
	SetSpritePositionByOffset(panel.HDrag, getspritex(panel.hBar) + getspriteheight(panel.hBar) + GetSpriteWidth(panel.hDrag) / 2, getspritey(panel.hBar) + getspriteheight(panel.hBar) / 2)

	guiSetPanelBarsVisible(panel, false)
	//guiPanelPoll(panel)
	
endfunction

//-----------------------------------------------------
// Set the panel color.
//
function guiSetPanelColor(panel ref as Panel, panelCol as integer, barCol as integer, dragCol as integer)

	coSetSpriteColor(panel.panel, panelCol)

	if panel.inset
		coSetSpriteColor(panel.inset, barCol)
	endif
	
	coSetSpriteColor(panel.VBar, barCol)
	cosetspritecolor(panel.VDrag, dragCol)
	
	coSetSpriteColor(panel.HBar, barCol)
	cosetspritecolor(panel.HDrag, dragCol)

endfunction

//-----------------------------------------------------
// Set the panel color.
//
function guiSetPanelAlpha(panel ref as Panel, alpha as integer)

	SetSpriteColorAlpha(panel.panel, alpha)

	if panel.inset
		SetSpriteColorAlpha(panel.inset, alpha)
	endif
	
	SetSpriteColorAlpha(panel.VBar, alpha)
	SetSpriteColorAlpha(panel.VDrag, alpha)	
	SetSpriteColorAlpha(panel.HBar, alpha)
	SetSpriteColorAlpha(panel.HDrag, alpha)

endfunction

//-----------------------------------------------------
// Set the panel visibility.
//
function guiSetPanelVisible(panel ref as Panel, vis as integer)

	SetSpriteVisible(panel.panel, vis)

	if panel.inset
		SetSpriteVisible(panel.inset, vis)
	endif

	guiSetPanelBarsVisible(panel, vis)
	
endfunction

//-----------------------------------------------------
// Set the bar visibility.
//
function guiSetPanelBarsVisible(panel ref as Panel, vis as integer)

	local myVis as integer

	myVis = vis
	
	if myVis and not panel.vBarVis
		myVis = false
	endif

	SetSpriteVisible(panel.vBar, myVis)
	SetSpriteVisible(panel.vDrag, myVis)

	myVis = vis
	
	if myVis and not panel.hBarVis
		myVis = false
	endif

	SetSpriteVisible(panel.hBar, myVis)
	SetSpriteVisible(panel.hDrag, myVis)

endfunction

//-----------------------------------------------------
// Create a box.
//
function guiCreateBox(s as string, w as float, h as float)
	
	spr as integer

	spr = coCreateSprite(s, co.pixImg)	
	SetSpriteScale(spr, w, h)
	
endfunction spr

//-----------------------------------------------------
// Create a text with font size from the font size list.
//
function guiCreateText(s as string, fontSize as integer)

	text as integer

	text = cocreatetext("guiCreateText", s)
	//SetTextFontImage(text, co.fonts[fontIdx])
	
	if fontSize < 0
		
		//colog("guiCreateText(" + s + ", fontIdx out of bounds=" + str(fontIdx))
		fontSize = 0
		
	elseif fontSize > co.fontSizes.length

		//colog("guiCreateText(" + s + ", fontIdx out of bounds=" + str(fontIdx))
		fontSize = co.fontSizes.length

	endif
	
	cosettextfont(text, 0) // Default.
	SetTextSize(text, co.fontSizes[fontSize])
	coSetTextColor(text, co.white)
	
endfunction text

//-----------------------------------------------------
// Create a text with an explicit size, not a fixed size from fontSizes list.
//
function guiCreateText2(s as string, fontSize as float)

	text as integer

	text = cocreatetext("guiCreateText2", s)

	cosettextfont(text, 0)
	SetTextSize(text, fontSize)
	coSetTextColor(text, co.white)
	
endfunction text

//-----------------------------------------------------
// Set the size of a text field, to max w.
//
function guiSetTextToWidth(text as integer, s as string, w as float)

	local t as String
	
	SetTextString(text, s)
	
	while GetTextTotalWidth(text) > w

		s = mid(s, 1, len(s) - 1)
		t = s + "..."				
		SetTextString(text, t)
		
	endwhile

endfunction

//-----------------------------------------------------
// Create a tip.
//
function guiCreateTip(tip ref as Tip, rounded as integer)

	local i as integer
	local txt as integer

	tip.Dir = DIR_N	
	tip.font = 0
	tip.fontSize = co.fontSizes[0]

	if not tip.arrow		
		tip.Arrow = cocreatesprite("guiCreateTip:tip.arrow", gui.tipUpImg)
	endif

	if not tip.arrowshadow
		tip.arrowShadow = cocreatesprite("guiCreateTip:tip.arrowshadow", gui.tipUpImg)
	endif

	if tip.arrowshadow

		coSetSpriteColor(tip.arrowshadow, co.black)
		SetSpriteColorAlpha(tip.arrowshadow, gui.shadowAlpha)

	endif
	
	if not rounded
		if not tip.border
			tip.Border = guicreatebox("guiCreateTip:gui.tipBorder", co.bs * 3, co.bs * 2)
		endif
	else 
		tip.border = 0
	endif
	
	if not tip.box
		if not rounded
			tip.Box = guicreatebox("guiCreateTip:gui.tipBox", co.bs * 3 - CD_CMD_GAP * 4, co.bs * 2 - CD_CMD_GAP * 4)
		else
			tip.box = cocreatesprite("gui.tipBox", gui.tipBoxImg)
		endif
	endif
	
	if not tip.shadow
		
		if not rounded
			tip.shadow = guicreatebox("guiCreateTip:gui.tipBoxShadow", co.bs * 3, co.bs * 2)
		else 
			tip.shadow = cocreatesprite("guitipbox", gui.tipBoxImg)
		endif
		
		coSetSpriteColor(tip.shadow, co.black)
		SetSpriteColorAlpha(tip.shadow, gui.shadowAlpha)

	endif
	

	tip.cross = 0

	if not tip.text2
		//tip.text2 = guicreatetext("", gui.tipFontSize)
		tip.text2 = guicreatetext2("", gui.tipFontSize)
	endif
		
	//coSetTextFont(tip.text2, tip.font)
	//SetTextSize(text, tip.fontSize)
	coSetTextColor(tip.text2, co.black)
	SetTextAlignment(tip.text2, 1)
	SetTextMaxWidth(tip.text2, GetSpriteWidth(tip.box) - co.bs / 4)
	SetTextScissor(tip.text2, getspritex(tip.box), getspritey(tip.box), getspritex(tip.box) + GetSpriteWidth(tip.box) - 1, getspritey(tip.box) + GetSpriteHeight(tip.box) - 1)

	guiSetTipDepth(tip, GUI_TIP_DEPTH)
	
endfunction

//-----------------------------------------------------
// Create a tip close icon.
//
function guiSetTipClose(tip ref as Tip, col as integer)

	if tip.cross
		
		deletesprite(tip.cross)
		tip.cross = 0
		
	endif
	
	if not tip.cross		
		
		tip.cross = coCreateSprite("cross", gui.crossImg)
		coSetSpriteColor(tip.cross, col)
		SetSpriteScale(tip.cross, 0.5, 0.5)
		
	endif
	
endfunction

//-----------------------------------------------------
// Set the tip's depth.
//
function guiSetTipDepth(tip ref as Tip, depth as integer)

	if tip.shadow				
		SetSpriteDepth(tip.shadow, depth)
	endif

	if tip.arrowshadow				
		SetSpriteDepth(tip.arrowshadow, depth)
	endif

	if tip.shadow or tip.arrowshadow
		dec depth
	endif
	
	if tip.arrow
		SetSpriteDepth(tip.Arrow, depth)
	endif

	if tip.border
		SetSpriteDepth(tip.Border, depth)
	endif

	dec depth

	if tip.box
		
		SetSpriteDepth(tip.Box, depth)
		dec depth

	endif
	
	if tip.text2
		SetTextDepth(tip.text2, depth)
	endif

	if tip.cross
		SetSpriteDepth(tip.cross, depth)
	endif

endfunction

//-----------------------------------------------------
// Delete a tip.
//
function guiDeleteTip(tip ref as Tip)
	
	if tip.Arrow

		coDeleteSprite("guiDeleteTip:tip.arrow", tip.arrow)
		tip.arrow = 0

	endif

	if tip.arrowshadow
		
		coDeleteSprite("guiDeleteTip:tip.shadow", tip.arrowshadow)
		tip.arrowshadow = 0

	endif

	if tip.border
			
		coDeleteSprite("guiDeleteTip:tip.border", tip.Border)
		tip.border = 0

	endif

	if tip.box
		
		coDeleteSprite("guiDeleteTip:tip.box", tip.Box)
		tip.box = 0

	endif

	if tip.shadow
		
		coDeleteSprite("guiDeleteTip:tip.shadow", tip.shadow)
		tip.shadow = 0

	endif

	if tip.text2
		
		coDeleteText("guiDeleteTip:tip.text2", tip.text2)
		tip.text2 = 0

	endif

	if tip.cross
		
		coDeleteSprite("guiDeleteTip:tip.cross", tip.cross)
		tip.cross = 0

	endif
	
	tip.font = 0
	tip.fontSize = co.fontSizes[0]
	
endfunction

//-----------------------------------------------------
// Set the colors for print tip display.
//
function guiSetPrintTipColors(bgColor as integer, borderColor as integer, textColor as integer)

	gui.tipBgColor = bgColor
	gui.tipBorderColor = borderColor
	gui.tipTextColor = textColor
	
endfunction

//-----------------------------------------------------
// Set the colors for print tip display.
//
function guiSetPrintTipFont(font as integer, fontSize as integer)

	gui.tipFont = font
	gui.tipFontSize = fontSize
	
endfunction

//-----------------------------------------------------
// Show the tip.
// Style = TIP_INFO, TIP_WARN, TIP_ERROR.
//
function guiShowTip(tip ref as Tip, spr as integer, help as string, style as integer, dir as integer)

	local x as float
	local y as float
	local sw as float // Sprite height.
	local sh as float // Sprite height.
	local ah as float // Arrow height.
	local bh as float // Box height.
	local th as float // Text height.
	local h as float
	local i as integer
	local hasText as integer
	local s as string
	local count as integer
	local xx as float
	local yy as float
	local tipVis as integer
	local off as float
	local rw as float
	local rh as float
	local gap as float
	local gap2 as float
	local ang as float
	local xa as float
	local ya as float
	local a as float
	local pt as Point
	local tipspr as integer

	// Don't do anything if tip text2 not created.
	if not tip.text2
		exitfunction
	endif

	if style = TIP_PRINT or style = TIP_PRINT_AT

		if tip.shadow
			
			coDeleteSprite("guiDeleteTip:tip.shadow", tip.shadow)
			tip.shadow = 0
	
		endif

		if tip.arrowshadow
		
			coDeleteSprite("guiDeleteTip:tip.arrowshadow", tip.arrowshadow)
			tip.arrowshadow = 0
	
		endif
				
	elseif style = TIP_HELP	
		
		coSetTextFont(tip.text2, 0)
		//SetTextSize(tip.text2, co.fontSizes[gui.tipFontSize + 1])
		SetTextSize(tip.text2, co.fontSizes[1])
				
	endif
		
	if style = TIP_PRINT or style = TIP_PRINT_AT

		coSetTextFont(tip.text2, gui.tipFont)
		SetTextSize(tip.text2, gui.tipFontSize)

		help = coReplaceTildes(help, chr(10))

		if help = ""
			help = " "
		endif
		
		SetTextMaxWidth(tip.text2, 0)
		SetTextString(tip.text2, help)

		rw = GetTextTotalWidth(tip.text2)
		rh = GetTextTotalHeight(tip.text2)
		gap = co.bs / 4
		gap2 = CD_CMD_GAP * 2
		if tip.border then SetSpriteScale(tip.border, rw + gap + gap2, rh + gap + gap2)
		if tip.shadow then SetSpriteScale(tip.shadow, rw + gap + gap2, rh + gap + gap2)
		SetSpriteScale(tip.box, rw + gap, rh + gap)

	else

		//help = coReplaceTildes(help, " ")
		help = coReplaceTildes(help, chr(10))
		SetTextString(tip.text2, help)
		
	endif

	SetSpriteScale(tip.arrow, 0.75, 0.75)

	if tip.arrowShadow
		SetSpriteScale(tip.arrowshadow, 0.6, 0.6)
	endif

	off = 4

	if style = TIP_PRINT_AT

		x = coGetPointX(spr)
		y = coGetPointY(spr)
		sh = 0
		ah = getspriteheight(tip.Arrow)
		
		if tip.border
			bh = getspriteheight(tip.Border)
		else 
			bh = getspriteheight(tip.box)
		endif
		
	else
		
		x = GetSpriteXByOffset(spr)
		y = GetSpriteYByOffset(spr)
		sw = GetSpriteWidth(spr)
		sh = getspriteheight(spr)
		ah = getspriteheight(tip.Arrow)
		
		if tip.border
			bh = getspriteheight(tip.Border)
		else 
			bh = getspriteheight(tip.box)
		endif

		a = GetSpriteAngle(spr)
		xa = sw / 2
		ya = abs(xa / sin(a))
		if ya > sh / 2
			ya = sh / 2
		endif
		//drawline(x, y, x - xa, y - ya, co.black, co.black)
		//drawline(x, y, x - xa, y, co.black, co.black)
		//drawline(x - xa, y, x - xa, y - ya, co.black, co.black)
		
		sh = ya * 2
		
	endif
	
	xx = x
	yy = y
	tipVis = false
	count = 0

	if style = TIP_WARN
		
		if tip.border
			
			cosetspritecolor(tip.Arrow, co.amber[4])
			cosetspritecolor(tip.Border, co.amber[4])
			cosetspritecolor(tip.Box, co.amber[2])
		
		else 

			cosetspritecolor(tip.Arrow, co.amber[2])
			cosetspritecolor(tip.Box, co.amber[2])
			
		endif
		
		coSetTextColor(tip.text2, co.black)
		
	elseif style = TIP_ERROR
		
		if tip.border
			
			cosetspritecolor(tip.Arrow, co.pink[4])
			cosetspritecolor(tip.Border, co.pink[4])
			cosetspritecolor(tip.Box, co.pink[2])
			
		else 
			
			cosetspritecolor(tip.Arrow, co.pink[2])
			cosetspritecolor(tip.Box, co.pink[2])

		endif
		
		coSetTextColor(tip.text2, co.black)

	elseif style = TIP_INFO
		
		if tip.border
			
			cosetspritecolor(tip.Arrow, co.lightgreen[4])
			cosetspritecolor(tip.Border, co.lightgreen[4])
			cosetspritecolor(tip.Box, co.lightgreen[2])
			
		else 
			
			cosetspritecolor(tip.Arrow, co.lightgreen[2])
			cosetspritecolor(tip.Box, co.lightgreen[2])

		endif
		
		coSetTextColor(tip.text2, co.black)

	elseif style = TIP_HELP
		
		if tip.border
			
			cosetspritecolor(tip.Arrow, co.grey[4])
			cosetspritecolor(tip.Border, co.grey[4])
			cosetspritecolor(tip.Box, co.grey[2])
			
		else 
			
			cosetspritecolor(tip.Arrow, co.grey[2])
			cosetspritecolor(tip.Box, co.grey[2])

		endif
		
		coSetTextColor(tip.text2, co.black)

	elseif style = TIP_PRINT or style = TIP_PRINT_AT
		
		if tip.border
			
			cosetspritecolor(tip.Arrow, gui.tipBorderColor)
			cosetspritecolor(tip.Border, gui.tipBorderColor)
			cosetspritecolor(tip.Box, gui.tipBgColor)
			
		else 
			
			cosetspritecolor(tip.Arrow, gui.tipBgColor)
			cosetspritecolor(tip.Box, gui.tipBgColor)

		endif
		
		coSetTextColor(tip.text2, gui.tipTextColor)

	endif

	if style = TIP_PRINT_AT

		if tip.border
			
			SetSpritePosition(tip.Border, x, y)
			SetSpritePosition(tip.Box, x + CD_CMD_GAP, y + CD_CMD_GAP)
			
		else 
			
			SetSpritePosition(tip.Box, x, y)

		endif
		
		if tip.shadow then SetSpritePosition(tip.shadow, x + CD_CMD_GAP, y + CD_CMD_GAP)

	else

		dir = !(!dir || (DIR_W + DIR_E))
		
		if dir = 0
			tip.dir = DIR_N
		else 
			tip.dir = dir
		endif
		
		while not tipVis
			
			if tip.Dir = DIR_N

				SetSpriteAngle(tip.Arrow, 180)
				if tip.arrowshadow then SetSpriteAngle(tip.Arrowshadow, 180)
				
				y = yy - sh / 2 - ah / 2 - off
				SetSpritePositionByOffset(tip.Arrow, x, y)
				if tip.arrowShadow then SetSpritePositionByOffset(tip.Arrowshadow, x + CD_CMD_GAP, y + CD_CMD_GAP)

				//y = y - bh / 2 - off
				y = y - ah / 2 - bh / 2 + off
				if tip.border then SetSpritePositionByOffset(tip.Border, x, y)
				SetSpritePositionByOffset(tip.Box, x, y)
				if tip.shadow then SetSpritePositionByOffset(tip.shadow, x + CD_CMD_GAP, y + CD_CMD_GAP)

				if count >= 2 then exit
				
				if tip.border
					if getspritey(tip.Border) < 0
						tip.Dir = DIR_S
					else
						tipVis = true
					endif
				else 
					if getspritey(tip.box) < 0
						tip.Dir = DIR_S
					else
						tipVis = true
					endif
				endif

				inc count
				
			endif
			
			if tip.Dir = DIR_S
				
				SetSpriteAngle(tip.Arrow, 0)
				if tip.arrowshadow then SetSpriteAngle(tip.Arrowshadow, 0)

				y = yy + sh / 2 + ah / 2 + off
				SetSpritePositionByOffset(tip.Arrow, x, y)
				if tip.arrowShadow then SetSpritePositionByOffset(tip.Arrowshadow, x + CD_CMD_GAP + CD_CMD_GAP / 2, y + CD_CMD_GAP)

				//y = y + bh / 2 + off
				y = y + ah / 2 + bh / 2 - off
				if tip.border then SetSpritePositionByOffset(tip.Border, x, y)
				SetSpritePositionByOffset(tip.Box, x, y)
				if tip.shadow then SetSpritePositionByOffset(tip.shadow, x + CD_CMD_GAP, y + CD_CMD_GAP)

				if tip.border
					if getspritey(tip.Border) + GetSpriteHeight(tip.Border) > co.h - 1
						tip.Dir = DIR_N
					else
						tipVis = true
					endif
				else 
					if getspritey(tip.box) + GetSpriteHeight(tip.box) > co.h - 1
						tip.Dir = DIR_N
					else
						tipVis = true
					endif
				endif

				inc count

			endif

		endwhile

		// Make sure the box doesn't overlap side borders.
		
		if tip.border
			tipspr = tip.border
		else 
			tipspr = tip.box
		endif
		
		if getspritex(tipspr) < 0
			
			x = co.bs / 8 + GetSpriteWidth(tipspr) / 2
			if tip.border then SetSpritePositionByOffset(tipspr, x, GetSpriteYByOffset(tipspr))
			SetSpritePositionByOffset(tip.Box, x, GetSpriteYByOffset(tipspr))
			if tip.shadow then SetSpritePositionByOffset(tip.shadow, x + CD_CMD_GAP, GetSpriteYByOffset(tipspr) + CD_CMD_GAP)

			if getspritex(tip.arrow) < 0
				
				// Try move the arrow across near the edge.
				x = getspritex(tipspr) + GetSpriteWidth(tip.arrow) / 2

				// If the move went passed the centre, then recentre.
				if x > GetSpriteXByOffset(tipspr)
					x = GetSpriteXByOffset(tipspr)
				endif
				
				SetSpritePositionByOffset(tip.arrow, x, GetSpriteYByOffset(tip.arrow))
				if tip.arrowShadow then SetSpritePositionByOffset(tip.arrowshadow, x + CD_CMD_GAP, GetSpriteYByOffset(tip.arrowshadow))
				
			endif
			
		elseif getspritex(tipspr) + GetSpriteWidth(tipspr) > co.w - 1
			
			x = co.w - GetSpriteWidth(tipspr) / 2 - co.bs / 8
			if tip.border then SetSpritePositionByOffset(tipspr, x, GetSpriteYByOffset(tipspr))
			SetSpritePositionByOffset(tip.Box, x, GetSpriteYByOffset(tipspr))
			if tip.shadow then SetSpritePositionByOffset(tip.shadow, x + CD_CMD_GAP, GetSpriteYByOffset(tipspr) + CD_CMD_GAP)

			if getspritex(tip.arrow) + GetSpriteWidth(tip.arrow) > co.w - 1
				
				// Try move the arrow across near the edge.
				x = getspritex(tipspr) + getspritewidth(tipspr) - GetSpriteWidth(tip.arrow) / 2

				// If the move went passed the centre, then recentre.
				if x < GetSpriteXByOffset(tipspr)
					x = GetSpriteXByOffset(tipspr)
				endif

				SetSpritePositionByOffset(tip.arrow, x, GetSpriteYByOffset(tip.arrow))
				if tip.arrowShadow then SetSpritePositionByOffset(tip.arrowshadow, x + CD_CMD_GAP, GetSpriteYByOffset(tip.arrowshadow))

			endif
			
		endif

	endif
	
	hasText = false

	if help <> ""

		hasText = true
		
		//SetTextString(tip.text2, help)
		SetTextPosition(tip.Text2, GetSpriteXByOffset(tip.box), GetSpriteYByOffset(tip.box) - GetTextTotalHeight(tip.text2) / 2)
		SetTextScissor(tip.text2, getspritex(tip.box), getspritey(tip.box), getspritex(tip.box) + GetSpriteWidth(tip.box) - 1, getspritey(tip.box) + GetSpriteHeight(tip.box) - 1)
		
		if tip.cross
			
			SetSpritePositionByOffset(tip.cross, GetSpriteX(tip.box) + getspritewidth(tip.box) - GetSpriteWidth(tip.cross) / 2 - co.bs / 16, GetSpriteY(tip.box) + GetSpriteHeight(tip.box) - GetSpriteHeight(tip.cross) / 2 - co.bs / 16)
			SetSpriteScissor(tip.cross, getspritex(tip.box), getspritey(tip.box), getspritex(tip.box) + GetSpriteWidth(tip.box) - 1, getspritey(tip.box) + GetSpriteHeight(tip.box) - 1)

		endif
		
	endif

	SetSpriteVisible(tip.Arrow, hasText)
	if tip.arrowShadow then SetSpriteVisible(tip.Arrowshadow, hasText)

	if tip.border then SetSpriteVisible(tip.Border, hasText)
	SetSpriteVisible(tip.Box, hasText)
	SetTextVisible(tip.text2, hasText)

	if style = TIP_PRINT or style = TIP_PRINT_AT
		
		if tip.shadow then SetSpriteVisible(tip.shadow, false)
		if tip.arrowshadow then SetSpriteVisible(tip.arrowshadow, false)
		//SetSpriteVisible(tip.box, false)

		if style = TIP_PRINT_AT
			
			SetSpriteVisible(tip.arrow, false)
			if tip.arrowshadow then SetSpriteVisible(tip.arrowshadow, false)

		endif
		
	else
		
		if tip.shadow then SetSpriteVisible(tip.shadow, hasText)
		
	endif

endfunction

//-----------------------------------------------------
// Check if the tip is active.
// An active tip simply has a text2 that is non-zero.
//
function guiIsTipActive(tip ref as Tip)

endfunction tip.text2

//-----------------------------------------------------
// Hide the tip.
//
function guiHideTip(tip ref as Tip)

	local i as integer
	
	SetSpriteVisible(tip.Arrow, false)
	if tip.border then SetSpriteVisible(tip.Border, false)
	SetSpriteVisible(tip.Box, false)
	if tip.shadow then SetSpriteVisible(tip.shadow, false)
	if tip.arrowShadow then SetSpriteVisible(tip.arrowshadow, false)
	SetTextVisible(tip.text2, false)
	
endfunction

//-----------------------------------------------------
// If win mode, then check pressed.
//
function guiGetButtonPressed(but ref as Button, x as float, y as float, mouse as integer)

	local ret as integer

	if WIN_MODE
		
		if but.active and GetSpriteVisible(but.bg) and GetSpriteHitTest(but.bg, x, y)
			if mouse = 1
				if in.leftMousePressed				
					ret = true
				else 			
					ret = false
				endif
			elseif mouse = 2
				if in.rightMousePressed				
					ret = true
				else 			
					ret = false
				endif
			else 
				ret = true
			endif
		else		
			ret = false		
		endif

	else 
		
		if but.active and GetSpriteVisible(but.bg) and GetSpriteHitTest(but.bg, x, y)
			ret = true
		else
			ret = false
		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// If win mode, then check down.
//
function guiGetButtonDown(but ref as Button, x as float, y as float, mouse as integer)

	local ret as integer

	if WIN_MODE
		
		if but.active and GetSpriteVisible(but.bg) and GetSpriteHitTest(but.bg, x, y)
			if mouse = 1
				if in.leftMouseDown		
					ret = true
				else 			
					ret = false
				endif
			elseif mouse = 2
				if in.rightMouseDown
					ret = true
				else 			
					ret = false
				endif
			else 
				ret = true
			endif
		else		
			ret = false		
		endif

	else 
		
		if but.active and GetSpriteVisible(but.bg) and GetSpriteHitTest(but.bg, x, y)
			ret = true
		else
			ret = false
		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// If win mode, then check released instead.
//
function guiGetButtonReleased(but ref as Button, x as float, y as float, mouse as integer)

	local ret as integer

	if WIN_MODE
		
		if but.active and GetSpriteVisible(but.bg) and GetSpriteHitTest(but.bg, x, y)
			if mouse = 1
				if in.leftMouseReleased		
					ret = true
				else 			
					ret = false
				endif
			elseif mouse = 2
				if in.rightMouseReleased		
					ret = true
				else 			
					ret = false
				endif
			else 
				ret = true
			endif
		else		
			ret = false		
		endif

	else 
		
		if but.active and GetSpriteVisible(but.bg) and GetSpriteHitTest(but.bg, x, y)
			ret = true
		else
			ret = false
		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// Reset the button states.
//
function guiResetButton(but ref as Button)

	guiSetButtonDepth(but, GetSpriteDepth(but.bg))
	guiSetButtonPos(but, GetSpriteXByOffset(but.bg), GetSpriteYByOffset(but.bg))
	guiSetButtonVisible(but, but.vis)	

endfunction

//-----------------------------------------------------
// 
function guiSetButtonSelected(but ref as Button, selected as integer)

	local s as float

	but.selected = selected
	
	// Create the button sel, if not already there.
	if but.selected
		
		if not but.selBg and not but.sel
			but.sel = coCreateSprite("guiSetButtonSelected:but.sel", gui.butSelImg)	
		endif
			
	endif

	guiResetButton(but)
	
endfunction

//-----------------------------------------------------
// 
function guiGetButtonSelected(but ref as Button)
	
endfunction but.selected

//-----------------------------------------------------
// 
function guiSetButtonTip(but ref as Button, tip as integer)

	local s as float

	if tip
		
		// Create the button sel, if not already there.
		if not but.tip
			
			but.tip = coCreateSprite("guiSetButtonSelected:but.sel", gui.butTipImg)
			SetSpriteScale(but.tip, 0.75, 0.75)
			//coSetSpriteColor(but.tip, co.black)
				
		endif

		if but.tip
			
			guiResetButton(but)
			//SetSpriteDepth(but.tip, GetSpriteDepth(but.bg) - 1)
			//SetSpritePositionByOffset(but.tip, GetSpriteXByOffset(but.bg), GetSpriteY(but.bg))
			//SetSpriteVisible(but.tip, true)			

		endif

	elseif but.tip

		deletesprite(but.tip)
		but.tip = 0
		
	endif
	
endfunction


//-----------------------------------------------------
// 
function guiSetButtonAlpha(but ref as Button, alpha as integer)
	
	if not but.active
		alpha = gui.inactiveAlpha
	endif
	
	if but.bg
		SetSpriteColorAlpha(but.bg, alpha)
	endif

	if but.tip		
		SetSpriteColorAlpha(but.tip, alpha)
	endif		

	if but.icon		
		SetSpriteColorAlpha(but.icon, alpha)
	endif		

	if but.icon2
		SetSpriteColorAlpha(but.icon2, alpha)
	endif		

	if but.text
		SetTextColorAlpha(but.text, alpha)
	endif	

	if but.text2
		SetTextColorAlpha(but.text2, alpha)
	endif	

	if but.shadow
		if but.active
			SetSpriteColorAlpha(but.shadow, gui.shadowAlpha / 2)
		else
			SetSpriteColorAlpha(but.shadow, 0)
		endif
	endif	

	if but.sel
		SetSpriteColorAlpha(but.sel, alpha)
	endif	

endfunction

//-----------------------------------------------------
// Search for a but based on the pressed location in the toolbar.
//
function guiFindBarButtonPressed(bar ref as Toolbar, x as float, y as float, mouse as integer)

	local idx as integer
	local i as integer

	idx = -1
	
	for i = 0 to bar.buts.length

		if WIN_MODE

			if guiGetButtonPressed(bar.buts[i], x, y, mouse)
				
				idx = i
				exit
				
			endif
			
		else 
			
			if guiGetButtonPressed(bar.buts[i], x, y, 0) // Only ever check ptr.
				
				idx = i
				exit
				
			endif
			
		endif

	next
	
endfunction idx

//-----------------------------------------------------
// Search for a but based on the down location in the toolbar.
//
function guiFindBarButtonDown(bar ref as Toolbar, x as float, y as float, mouse as integer)

	local idx as integer
	local i as integer

	idx = -1
	
	for i = 0 to bar.buts.length

		if WIN_MODE

			if guiGetButtonDown(bar.buts[i], x, y, mouse)
				
				idx = i
				exit
				
			endif
			
		else 
			
			if guiGetButtonDown(bar.buts[i], x, y, 0) // Only ever check ptr.
				
				idx = i
				exit
				
			endif
			
		endif

	next
	
endfunction idx

//-----------------------------------------------------
// Search for a but based on the pressed location in the toolbar.
//
function guiFindBarButtonReleased(bar ref as Toolbar, x as float, y as float, mouse as integer)

	local idx as integer
	local i as integer

	idx = -1
	
	for i = 0 to bar.buts.length

		if WIN_MODE

			if guiGetButtonReleased(bar.buts[i], x, y, mouse)
				
				idx = i
				exit
				
			endif
			
		else 
			
			if guiGetButtonReleased(bar.buts[i], x, y, 0) // Only ever check ptr.
				
				idx = i
				exit
				
			endif
			
		endif

	next
	
endfunction idx

//-----------------------------------------------------
// Find a button by id.
//
function guiFindBarButtonById(bar ref as Toolbar, id as integer)

	local idx as integer
	local i as integer

	idx = -1
	
	for i = 0 to bar.buts.length

		// Allows for -vv but id, which is use for keyboard to indicate shifted char, i.e. in icon.
		if bar.buts[i].id = id
			
			idx = i
			exit

		endif

	next
	
endfunction idx

//-----------------------------------------------------
// Popup a bar above or below the passed rect.
// Note: x & y are top / left, not centre
//
function guiPopupBar(bar ref as Toolbar, x as float, y as float, w as float, h as float)

	local i as integer
	local xx as float
	local yy as float
	local ay as float
	local ah as float
	local ww as float
	local hh as float

	if bar.rowLen > -1
		
		ww = bar.rowLen * co.bs
		hh = (bar.buts.length + 1) / bar.rowLen

		// If not an exact division, need to add 1.
		if mod(bar.buts.length + 1, bar.rowLen) > 0
			inc hh
		endif

		hh = hh * co.bs
		
	else
		
		ww = ((bar.buts.length + 1) * co.bs)
		hh = co.bs
		
	endif
	
	SetSpriteScale(bar.bg, ww + co.bs / 4, hh + co.bs / 4)
	SetSpriteScale(bar.sbg, ww + co.bs / 4, hh + co.bs / 4)

	xx = x
	yy = y //- GetSpriteHeight(bar.arrow)
	ah = GetSpriteHeight(bar.arrow)
	bar.dir = DIR_N
	
	if bar.dir = DIR_N

		gui.tip.Dir = DIR_N
		x = xx + w / 2 - GetSpriteWidth(bar.bg) / 2
		y = yy - GetSpriteHeight(bar.bg) - ah / 2 - co.bs / 8
		ay = y + GetSpriteHeight(bar.bg) + ah / 8

		if y < 0 // Goes out of nice screen area.
			bar.dir = DIR_S // Try below.
		endif

		SetSpriteAngle(bar.arrow, 180)

		if bar.arrowshadow
			SetSpriteAngle(bar.arrowshadow, 180)
		endif
		
	endif
	
	if bar.dir = DIR_S

		gui.tip.Dir = DIR_S
		x = xx + w / 2 - GetSpriteWidth(bar.bg) / 2
		y = yy + h + ah / 2 + co.bs / 8
		ay = y - ah / 8

		SetSpriteAngle(bar.arrow, 0)

		if bar.arrowshadow
			SetSpriteAngle(bar.arrowshadow, 0)
		endif
		
	endif

	if x < 0
		x = co.bs / 8 // 0 plus a bit.
	elseif x + GetSpriteWidth(bar.bg) > co.w - 1
		x = co.w - co.bs / 8 - GetSpriteWidth(bar.bg)
	endif

	SetSpriteDepth(bar.bg, GUI_POP_DEPTH - 4)
	SetSpritePosition(bar.bg, x, y)
	SetSpriteVisible(bar.bg, true)
	
	SetSpriteDepth(bar.sbg, GUI_POP_DEPTH - 2)
	SetSpritePosition(bar.sbg, x + CD_CMD_GAP, y + CD_CMD_GAP)
	SetSpriteVisible(bar.sbg, true)

	SetSpriteDepth(bar.arrow, GUI_POP_DEPTH - 3)
	SetSpritePositionByOffset(bar.arrow, xx + w / 2, ay)
	SetSpriteVisible(bar.arrow, true)

	if bar.arrowshadow
		
		SetSpriteDepth(bar.arrowshadow, GUI_POP_DEPTH - 2)
		SetSpritePositionByOffset(bar.arrowshadow, xx + w / 2 + CD_CMD_GAP + CD_CMD_GAP / 4, ay + CD_CMD_GAP + CD_CMD_GAP / 2 + 2)
		SetSpriteVisible(bar.arrowshadow, true)

	endif

	xx = x
	
	for i = 0 to bar.buts.length

		guiSetButtonDepth(bar.buts[i], GUI_POP_DEPTH - 6)
		guiSetButtonPos(bar.buts[i], x + co.bs / 8 + co.bs / 2, y + co.bs / 8 + co.bs / 2)
		guiSetButtonSelected(bar.buts[i], false)
		guiSetButtonVisible(bar.buts[i], true)
	
		if bar.rowLen > -1 and mod(i + 1, bar.rowLen) = 0
			
			x = xx
			y = y + GetSpriteHeight(bar.buts[i].bg)

		else
			
			x = x + getspritewidth(bar.buts[i].bg)

		endif
	
	next
	
endfunction

//-----------------------------------------------------
//
function guiSetBarActive(bar ref as Toolbar, active as integer)

	local i as integer

	for i = 0 to bar.buts.length		
		guiSetButtonActive(bar.buts[i], active)		
	next
	
endfunction

//-----------------------------------------------------
//
function guiSetBarVisible(bar ref as Toolbar, vis as integer)

	local i as integer

	for i = 0 to bar.buts.length		
		guiSetButtonVisible(bar.buts[i], vis)		
	next
	
endfunction

//-----------------------------------------------------
//
function guiSetBarDepth(bar ref as Toolbar, depth as integer)

	local i as integer

	for i = 0 to bar.buts.length
		guiSetButtonDepth(bar.buts[i], depth)
	next
	
endfunction

//-----------------------------------------------------
//
function guiSetBarAlpha(bar ref as Toolbar, alpha as integer)

	local i as integer

	for i = 0 to bar.buts.length
		guiSetButtonAlpha(bar.buts[i], alpha)
	next
	
endfunction

//-----------------------------------------------------
// Show a bar as positioned.
//
function guiShowBar(bar ref as Toolbar)

	local i as integer

	for i = 0 to bar.buts.length

		guiSetButtonPos(bar.buts[i], getspritex(bar.buts[i].bg) + co.bs / 2, getspritey(bar.buts[i].bg) + co.bs / 2)
		guiSetButtonVisible(bar.buts[i], true)
		
	next

	gui.tip.Dir = DIR_N
	
endfunction


//-----------------------------------------------------
//
function guiHideBar(bar ref as Toolbar)

	local i as integer
		
	for i = 0 to bar.buts.length

		guiSetButtonVisible(bar.buts[i], false)
		guiSetButtonSelected(bar.buts[i], false)
		
	next

	coSetSpriteVisible(bar.bg, false)
	coSetSpriteVisible(bar.sbg, false)
	coSetSpriteVisible(bar.arrow, false)

	if bar.arrowShadow
		SetSpriteVisible(bar.arrowshadow, false)
	endif
		
endfunction

//-----------------------------------------------------
// 
function guiCheckBarPressed(bar ref as Toolbar, x as float, y as float, mouse as integer)

	local butIdx as integer
	
	butIdx = guiFindBarButtonDown(bar, x, y, mouse)

	if butIdx > -1
		if bar.buts[butIdx].bgType = BUT_BG_NONE
			butIdx = -1
		endif
	endif
	
	if butIdx <> bar.butIdx

		// Clear current button highlight.
		if bar.butIdx > -1	
			if bar.bg	
				if GetSpriteVisible(bar.bg)
					guiSetButtonSelected(bar.buts[bar.butIdx], false)
				endif
			endif
		endif

		// Highlight new button.
		bar.butIdx = butIdx

		if bar.butIdx > -1

			// Highlight if popup.
			if bar.bg
				if GetSpriteVisible(bar.bg)
					
					guiSetButtonSelected(bar.buts[bar.butIdx], true)
					guiShowTip(gui.tip, bar.buts[bar.butIdx].bg, bar.buts[bar.butIdx].help, TIP_INFO, 0)
				
				endif
			endif

		else

			guiHideTip(gui.tip)
			
		endif

	endif

endfunction butIdx

//-----------------------------------------------------
// 
function guiCheckBarReleased(bar ref as Toolbar, x as float, y as float, mouse as integer)

	local butId as integer
	local butIdx as integer

	butId = -1
	
	butIdx = guiFindBarButtonReleased(bar, x, y, mouse)
	
	if butIdx > -1 and butIdx = bar.butIdx // Only fire if released on the same button.

		if bar.bg
			if GetSpriteVisible(bar.bg)				
				guiSetButtonSelected(bar.buts[butIdx], false)
			endif
		endif
		
		butId = bar.buts[butIdx].id

	endif

	// If popup bar, hide it now.
	if bar.bg	
		if GetSpriteVisible(bar.bg)	
			guiHideBar(bar)
		endif
	endif
	
	guiHideTip(gui.tip)

endfunction butId


//
//
//
