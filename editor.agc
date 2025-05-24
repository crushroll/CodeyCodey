#option_explicit

//-----------------------------------------------------
//
#constant ED_MODE_NONE 0
#constant ED_MODE_BACK_BUT 1
#constant ED_MODE_MORE_BAR 2
#constant ED_MODE_SUB_BAR 3 // A button on a sub bar was pressed.
#constant ED_MODE_SEL_MOVE 4 // Clicked on a selection, about to move.
#constant ED_MODE_GFX 5 // Pressed in the work area.
#constant ED_MODE_SHAPE_BAR 6 // The shape sub bar was pressed.

#constant ED_LINE_SIZE_MAX 10
#constant ED_POLY_SIDES_MIN 3
#constant ED_POLY_SIDES_MAX 20
//#constant ED_TEXT_SIZE_MAX 100
#constant ED_GRID_ROWS_MAX 64
#constant ED_GRID_COLS_MAX 64

#constant ED_HOLD_DIST 42
#constant ED_HOLD_TIME 500 // 200 The time to wait before showing a popup.
#constant ED_DRAG_TIME 50 // 200 The time to wait before engaging a drag of a cmd.
#constant ED_SCROLL_FRICTION = 0.08  //Amount of friction to apply to scroll control
#constant ED_CLICK_START_DIST = 42.0 //Square of the distance from origin to determine whether the user intends to click or scroll	

#constant ED_BLOCK_DEPTH 200

#constant ED_ZOOM_MIN 0.1
#constant ED_ZOOM_MAX 100

#constant ED_SCROLL_DEPTH 600
#constant ED_GRID_DEPTH 700
#constant ED_SEL_DEPTH 800
#constant ED_WORK_DEPTH 900
#constant ED_SPR_DEPTH 1000
#constant ED_OVER_TRANS_DEPTH 1100
#constant ED_TRANS_DEPTH 1200

#constant ED_CHG_PIXELS 1
#constant ED_CHG_MB 2
#constant ED_CHG_MB2 3
#constant ED_CHG_IMG 4
#constant ED_CHG_FLIP_X 5
#constant ED_CHG_FLIP_Y 6
#constant ED_CHG_ROT_LEFT 7
#constant ED_CHG_ROT_RIGHT 8

#constant ED_SCROLL_EDGE 64
#constant ED_SCROLL_DIST 32
#constant ED_SCROLL_TIME 10
#constant ED_SCROLL_WAIT 300

//-----------------------------------------------------
//
global ed as Editor

//-----------------------------------------------------
//
type Editor

	mode as integer
	editImg as integer // Passed in to edit or view.
	editMode as integer // True all editing is active, false only viewing tools, e.g. zoom.
	//moreBut as Button
	moreBar as Toolbar
	panBar as Toolbar
	colBar as Toolbar
	sizeBar as Toolbar
	lineBar as Toolbar
	textBar as Toolbar
	shapeBar as Toolbar
	selBar as Toolbar
	selShapeBar as Toolbar
	gridBar as Toolbar
	imageBar as Toolbar
	undoBar as Toolbar
	saveBar as Toolbar
	resizeBar as Toolbar
	adjustBar as Toolbar
	clearBar as Toolbar
	editBar as Toolbar
	rectIconImg as integer
	squareIconImg as integer
	ovalIconImg as integer
	circleIconImg as integer
	polyIconImg as integer
	triIconImg as integer
	filledRectIconImg as integer
	filledSquareIconImg as integer
	filledOvalIconImg as integer
	filledCircleIconImg as integer
	filledPolyIconImg as integer
	filledTriIconImg as integer
	topBlock as integer
	leftBlock as integer
	waitStart as integer
	moveButCol as integer
	selButCol as integer
	toggleButCol as integer
	toggleButCol2 as integer
	waitIdx as integer
	waitX as float
	waitY as float
	pressed as integer
	butId as integer // The but of the current tool.
	pressedButId as integer // A toolbar item just pressed.
	gfx as Gfx
	scroll as Scroll
	vmSprs as integer[]
	hmSprs as integer[]
	vmTexts as integer[]
	hmTexts as integer[]
	vmS as float // Height of vm spr.
	hmS as float // Width of hm spr.
	vmT as float // Height of vm spr.
	hmT as float // Width of hm spr.
	x0Text as integer
	y0Text as integer
	x1Text as integer
	y1Text as integer
	zooms as float[] // All zooms.
	zoomIdx as integer // The zoom selected, idx into zooms.
	zoom1 as float // The index in zooms, where 1.0 is.
	zoomTip as float // The point as which to switch from scaled sprite zoom to drawing blocks.
	zoomFixed as integer // If true, then the zoom array is used, otherwise free form.
	defPad as float
	//lineButId as integer
	//shapeButId as integer
	//selShapeButId as integer
	//filledButId as integer
	//sameButId as integer
	pickerButId as integer
	pasteButId as integer
	eraseButId as integer
	textButId as integer
	imageButId as integer
	//gridButId as integer
	imageSpr as integer
	text as integer
	clearCol as integer
	
	tt as integer
	t1 as integer
	t2 as integer

endtype

type Selection

	sel as MemBlock
	col as integer
	editCol as integer // The color of edit selection.
	active as integer
	sp as Point
	ep as Point
	lining as integer // If true, in the middle of a line selection.
	filling as integer // If true, the next press will fill a selection.
	dirty as integer
	spr as integer // The selection as a sprite for optimisation.

endtype

// Deals with drawing of gfx.

type Gfx
	
	spr as integer // Standard size.
	transSpr as integer // The spr for transparency.
	transEdgeSpr as integer // For clearing the extra edge of the last trans spr.
	workSpr as integer // The spr for the work.
	gridSpr as integer // The grid for spr drawing model.
	cols as MemBlock // Holds cols from the img.
	//draw as MemBlock // For drawing the fake spr draw.
	work as MemBlock // Holds working data.
	tmp as MemBlock // For erase drawing.
	sel as Selection
	pixSpr as integer
	vGridSpr as integer
	hGridSpr as integer
	gridPixSize as integer
	zoom as float // Zoom.
	w as float
	h as float
	x0 as float
	y0 as float
	x1 as float
	y1 as float
	padX as float
	padY as float
	offX as float
	offY as float
	drawX as float
	drawY as float
	pp as Point // The pressed point.
	sp as Point // The current start point.
	ep as Point // The current end point.
	cp as Point // Centre pixel.
	dp as Point // Offset of centre pixel.
	col as integer // The current color.
	lineSize as integer
	textSize as integer
	polySides as integer
	textFont as integer
	textEdit as string
	imageFile as string // The image selected.
	lineStyle as integer
	gridCols as integer
	gridRows as integer
	gridWidth as integer
	gridHeight as integer
	gridCol as integer // Color of the grid.
	transIdx as integer
	copy as MemBlock // Copied block.
	image as MemBlock // The loaded image after selecting the image place tool.
	text as integer // A Text for rendering.
	drawDirty as integer
	workDirty as integer
	gridDirty as integer
	pipsDirty as integer
	undos as Change[]
	redos as Change[]
	drawShape as integer
	shapeFilled as integer
	shapeSameWH as integer
	selShape as integer
	snapToGrid as integer
	
endtype

type ButPos
	
	x as float
	y as float
	dx as float
	dy as float
	ci as integer // color.
	colIdx as integer
	cols as integer[]
	updCols as integer
	
endtype

type Change // For undo/redo.
	
	typ as integer // pixel update, whole image (eg. resize, crop), operation (e.g. full screen rotate, flip)
	pixels as Pixel[] // For pixel undos and redos, i.e. put back in the list.
	mb as MemBlock // For whole image save.
	op as integer // For operations.
	bounds as Bounds
	img as integer // For img type.
		
endtype

//-----------------------------------------------------
// 
function edInit()

	local but as Button
	local col as integer
	local i as integer
	local spr as integer
	local text as integer
	local img as integer

	ed.rectIconImg = LoadImage("gfx/Rect2Icon.png")
	ed.squareIconImg = LoadImage("gfx/SquareIcon.png")
	ed.ovalIconImg = LoadImage("gfx/OvalIcon.png")
	ed.circleIconImg = LoadImage("gfx/CircleIcon.png")
	ed.polyIconImg = LoadImage("gfx/PolygonIcon.png")
	ed.triIconImg = LoadImage("gfx/TriangleIcon.png")
	ed.filledRectIconImg = LoadImage("gfx/RectFilledIcon.png")
	ed.filledSquareIconImg = LoadImage("gfx/SquareFilledIcon.png")
	ed.filledOvalIconImg = LoadImage("gfx/OvalFilledIcon.png")
	ed.filledCircleIconImg = LoadImage("gfx/CircleFilledIcon.png")
	ed.filledPolyIconImg = LoadImage("gfx/PolygonFilledIcon.png")
	ed.filledTriIconImg = LoadImage("gfx/TriangleFilledIcon.png")
	
	ed.mode = CD_MODE_NONE
	ed.editImg = 0
	ed.editMode = true
	ed.pressed = false
	ed.moveButCol = co.lightgreen[5]
	ed.selButCol = co.lightgreen[5]
	ed.toggleButCol = co.orange[5]
	ed.toggleButCol2 = co.orange[7]
	ed.zooms = [0.1, 0.25, 0.5, 1.0, 5, 10, 25, 50, 100]
	ed.zoomTip = 5.1
	ed.zoomFixed = false
	ed.defPad = co.bs
	ed.butId = BUT_EDITOR_PAN
	ed.pressedButId = -1
	//ed.lineButId = BUT_EDITOR_LINE_CIRC
	//ed.shapeButId = BUT_EDITOR_RECT
	//ed.selShapeButId = BUT_EDITOR_RECT_SEL
	ed.pasteButId = -1
	//ed.filledButId = -1
	//ed.sameButId = -1
	ed.pickerButId = -1
	ed.eraseButId = -1
	ed.textButId = -1
	ed.imageButId = -1
	//ed.gridButId = -1
	ed.imageSpr = 0

	// Graphics setup.

	ed.gfx.pixSpr = CreateSprite(co.pixImg)
	SetSpriteScissor(ed.gfx.pixSpr, ed.gfx.x0, ed.gfx.y0, ed.gfx.x1, ed.gfx.y1)
	SetSpriteDepth(ed.gfx.pixSpr, ED_SPR_DEPTH)

	ed.gfx.transEdgeSpr = CreateSprite(co.pixImg)
	SetSpriteScissor(ed.gfx.transEdgeSpr, ed.gfx.x0, ed.gfx.y0, ed.gfx.x1, ed.gfx.y1)
	SetSpriteDepth(ed.gfx.transEdgeSpr, ED_OVER_TRANS_DEPTH)

	ed.gfx.vGridSpr = CreateSprite(co.pixImg)
	SetSpriteScissor(ed.gfx.vGridSpr, ed.gfx.x0, ed.gfx.y0, ed.gfx.x1, ed.gfx.y1)
	SetSpriteDepth(ed.gfx.vGridSpr, ED_GRID_DEPTH)

	ed.gfx.hGridSpr = CreateSprite(co.pixImg)
	SetSpriteScissor(ed.gfx.hGridSpr, ed.gfx.x0, ed.gfx.y0, ed.gfx.x1, ed.gfx.y1)
	SetSpriteDepth(ed.gfx.hGridSpr, ED_GRID_DEPTH)
		
	ed.gfx.spr = 0
	ed.gfx.transSpr = 0
	ed.gfx.workSpr = 0
	ed.gfx.gridSpr = 0
	ed.gfx.cols.id = 0
	ed.gfx.tmp.id = 0
	ed.gfx.x0 = co.bs + co.bs / 2
	ed.gfx.y0 = co.bs + co.bs / 2
	ed.gfx.x1 = co.w - 1
	ed.gfx.y1 = co.h - 1
	ed.gfx.w = ed.gfx.x1 - ed.gfx.x0 + 1
	ed.gfx.h = ed.gfx.y1 - ed.gfx.y0 + 1
	ed.gfx.offX = 0
	ed.gfx.offY = 0
	ed.gfx.drawX = 0
	ed.gfx.drawY = 0
	ed.gfx.pp.x = 0
	ed.gfx.pp.y = 0
	ed.gfx.sp.x = 0
	ed.gfx.sp.y = 0
	ed.gfx.ep.x = 0
	ed.gfx.ep.y = 0
	ed.gfx.col = co.black
	ed.gfx.textEdit = ""
	ed.gfx.imageFile = ""
	ed.gfx.padX = 0
	ed.gfx.padY = 0
	ed.gfx.transIdx = 1
	ed.gfx.copy.id = 0
	ed.gfx.drawDirty = false
	ed.gfx.workDirty = false
	ed.gfx.gridPixSize = 1
	ed.gfx.gridCol = coSetColorAlpha(co.blue[5], 127)
	ed.gfx.shapeFilled = false
	ed.gfx.shapeSameWH = false
	ed.gfx.snapToGrid = false

	edSetDrawShape(CO_SHAPE_RECT)
	edSetSelShape(CO_SEL_RECT)
	edSetLineStyle(CO_LINE_CIRC)
	edSetLineSize(1)
	edSetTextFont(0)
	edSetTextSize(36)
	edSetGridWidth(32)
	edSetGridHeight(32)
	ed.gfx.gridCols = 16
	ed.gfx.gridRows = 16

	ed.gfx.sel.col = coSetColorAlpha(co.purple[5], 127)
	ed.gfx.sel.editCol = coSetColorAlpha(co.teal[5], 127)
	ed.gfx.sel.active = false
	ed.gfx.sel.lining = false
	ed.gfx.sel.filling = false
	ed.gfx.sel.spr = 0
	ed.gfx.sel.dirty = false
	
	// Scrolling setup.
	
	ed.scroll.firstX = 0
	ed.scroll.firstY = 0
	ed.scroll.originX = 0
	ed.scroll.originY = 0
	ed.scroll.xMomentum = 0
	ed.scroll.yMomentum = 0
	ed.scroll.holding = false
	ed.scroll.scrolling = false
	ed.scroll.w = ed.gfx.w
	ed.scroll.h = ed.gfx.h
	ed.scroll.zone = false
	ed.scroll.time = 0
	ed.scroll.spr = CreateSprite(co.pixImg)
	coSetSpriteColorWithAlpha(ed.scroll.spr, co.blue[5], 255)
	SetSpriteScissor(ed.scroll.spr, ed.gfx.x0, ed.gfx.y0, ed.gfx.x1, ed.gfx.y1)
	SetSpriteDepth(ed.scroll.spr, ED_SCROLL_DEPTH)

	if ed.zoomFixed
		
		ed.zoom1 = 3
		ed.zoomIdx = ed.zoom1
		
	else
		
		ed.zoom1 = 1.0
		
	endif

	col = co.grey[2]

	ed.topBlock = guiCreateBox("", co.w, co.bs + co.bs / 2)
	coSetSpriteColor(ed.topBlock, co.grey[2])
	SetSpriteDepth(ed.topBlock, ED_BLOCK_DEPTH)
	ed.leftBlock = guiCreateBox("", co.bs + co.bs / 2, co.h)
	coSetSpriteColor(ed.leftBlock, co.grey[2])
	SetSpriteDepth(ed.leftBlock, ED_BLOCK_DEPTH)
		
	col = co.grey[6]
	
	for i = 0 to 19
		
		spr = CreateSprite(co.pixImg)
		SetSpriteScissor(spr, ed.gfx.x0, 0, ed.gfx.x1, ed.gfx.y0)
		SetSpriteDepth(spr, ED_BLOCK_DEPTH - 10)
		SetSpriteScale(spr, 4, 24)
		coSetSpriteColor(spr, col)
		ed.vmS = GetSpriteHeight(spr)
		SetSpritePosition(spr, co.w / 2, ed.gfx.y0 - ed.vmS)
		ed.vmSprs.insert(spr)

		text = guiCreateText("1", 0)
		SetTextScissor(text, ed.gfx.x0, 0, ed.gfx.x1, ed.gfx.y0)
		SetTextDepth(text, ED_BLOCK_DEPTH - 20)
		SetTextAlignment(text, 0)
		coSetTextColor(text, col)
		ed.vmT = GetTextTotalHeight(text) - 4
		ed.vmTexts.insert(text)
	
		spr = CreateSprite(co.pixImg)
		SetSpriteScissor(spr, 0, ed.gfx.y0, ed.gfx.x0, ed.gfx.y1)
		SetSpriteDepth(spr, ED_BLOCK_DEPTH - 10)
		SetSpriteScale(spr, 24, 4)
		coSetSpriteColor(spr, col)
		ed.hmS = GetSpriteWidth(spr)
		SetSpritePosition(spr, ed.gfx.x0 - ed.hmS, co.h / 2)
		ed.hmSprs.insert(spr)

		text = guiCreateText("1", 0)
		SetTextScissor(text, 0, ed.gfx.y0, ed.gfx.x0, ed.gfx.y1)
		SetTextDepth(text, ED_BLOCK_DEPTH - 20)
		SetTextAlignment(text, 2)
		SetTextAngle(text, -90)
		coSetTextColor(text, col)
		ed.hmT = GetTextTotalHeight(text) - 4
		ed.hmTexts.insert(text)
	
	next
	
	col = co.black

	text = guiCreateText("", 0)
	//SetTextScissor(text, ed.gfx.x0, 0, ed.gfx.x1, ed.gfx.y0)
	SetTextDepth(text, ED_BLOCK_DEPTH - 20)
	SetTextAlignment(text, 0)
	coSetTextColor(text, col)
	ed.x0Text = text

	text = guiCreateText("", 0)
	//SetTextScissor(text, ed.gfx.x0, 0, ed.gfx.x1, ed.gfx.y0)
	SetTextDepth(text, ED_BLOCK_DEPTH - 20)
	SetTextAlignment(text, 0)
	coSetTextColor(text, col)
	ed.y0Text = text
	
	text = guiCreateText("", 0)
	//SetTextScissor(text, ed.gfx.x0, 0, ed.gfx.x1, ed.gfx.y0)
	SetTextDepth(text, ED_BLOCK_DEPTH - 20)
	SetTextAlignment(text, 0)
	coSetTextColor(text, col)
	ed.x1Text = text

	text = guiCreateText("", 0)
	//SetTextScissor(text, ed.gfx.x0, 0, ed.gfx.x1, ed.gfx.y0)
	SetTextDepth(text, ED_BLOCK_DEPTH - 20)
	SetTextAlignment(text, 0)
	coSetTextColor(text, col)
	ed.y1Text = text

	//
	// Buttons.
	//
	
	//ed.moreBut = guiCreateButton("more", BUT_BG_NORMAL, "gfx/MoreIcon.png", co.detailsCol) // co.moreCol
	//ed.moreBut.id = BUT_EDITOR_MORE

	// Toolbar.

	ed.moreBar = guiCreateToolbar()
	ed.panBar = guiCreateToolbar()
	ed.colBar = guiCreateToolbar()
	ed.sizeBar = guiCreateToolbar()
	ed.lineBar = guiCreateToolbar()
	ed.textBar = guiCreateToolbar()
	ed.shapeBar = guiCreateToolbar()
	ed.selBar = guiCreateToolbar()
	ed.selShapeBar = guiCreateToolbar()
	ed.gridBar = guiCreateToolbar()
	ed.undoBar = guiCreateToolbar()
	ed.resizeBar = guiCreateToolbar()
	ed.adjustBar = guiCreateToolbar()
	ed.clearBar = guiCreateToolbar()
	ed.editBar = guiCreateToolbar()
	ed.saveBar = guiCreateToolbar()

	col = 3	
	but = guiCreateButton("move", BUT_BG_NORMAL, "gfx/ScrollIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_PAN
	but.help = "Zooming and dragging the image around, if it is larger than the edit area."
 	guiSetButtonBgSel(but, true, co.detailsCol)
	ed.moreBar.buts.insert(but)

	inc col
	but = guiCreateButton("draw", BUT_BG_NORMAL, "gfx/FreeDrawIcon.png", co.bluegrey[col]) // BrushIcon
	but.id = BUT_EDITOR_DRAW
	but.help = "Draw a freehand line. Press and drag to draw, then release. Draws in current color and line size."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)

	dec col
	but = guiCreateButton("line", BUT_BG_NORMAL, "gfx/LineIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_LINE
	but.help = "Draw a straight line. Press and drag to draw a line, then release. Draws in current color and line size."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)

	inc col		
	but = guiCreateButton("shape", BUT_BG_NORMAL, "gfx/Rect2Icon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_SHAPE
	but.help = "Draw a number of shapes such as rectangle, square, oval and circle."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)

	dec col
	but = guiCreateButton("fill", BUT_BG_NORMAL, "gfx/PaintIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_FILL
	but.help = "Fill are area with the current color. Press on the image, and all adjacent pixels of the same color with be changed."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)

	inc col
	but = guiCreateButton("text", BUT_BG_NORMAL, "gfx/TextIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_TEXT
	but.help = "Insert text into the image."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)

	dec col
	but = guiCreateButton("image", BUT_BG_NORMAL, "gfx/ImageIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_IMAGE
	but.help = "Insert an image from the sprite library."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)

	inc col
	but = guiCreateButton("select", BUT_BG_NORMAL, "gfx/SelectIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_SELECT
	but.help = "Select a rectangular area of the image to resize or restrict drawing operations."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)
	
	dec col	
	but = guiCreateButton("grid", BUT_BG_NORMAL, "gfx/GridIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_GRID_SNAP
	but.help = "Drawing elements like draw, line, etc. will snap to a grid. The grid can also be used to split an image."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)

	inc col
	but = guiCreateButton("adjust", BUT_BG_NORMAL, "gfx/TransformIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_RESIZE
	but.help = "Change the size and orientation of the image. If a selection is active, only the selection is affected."
 	guiSetButtonBgSel(but, true, co.detailsCol)
 	ed.moreBar.buts.insert(but)

	//
	// Zoom bar for pan.
	//
	
	but = guiCreateButton("zoom in", BUT_BG_NORMAL, "gfx/ZoomInIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_ZOOM_IN
	but.help = "Zoom in on the centre of the image, for close up editing. If the image doesn't fit within the edit area, use the pan tool."
	ed.panBar.buts.insert(but)

	but = guiCreateButton("zoom out", BUT_BG_NORMAL, "gfx/ZoomOutIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_ZOOM_OUT
	but.help = "Zoom out, to see more of the image again."
	ed.panBar.buts.insert(but)

	but = guiCreateButton("actual", BUT_BG_NORMAL, "gfx/ZoomResetIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_ZOOM_RESET
	but.help = "Reset the zoom size back to normal."
	ed.panBar.buts.insert(but)

	but = guiCreateButton("fit screen", BUT_BG_NORMAL, "gfx/GrowIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_ZOOM_FIT
	but.help = "Zoom to fit the screen space."
	ed.panBar.buts.insert(but)

	//
	// Color bar for drawing tools.
	//
	
	but = guiCreateButton("color", BUT_BG_NORMAL, "", co.bluegrey[col])	
	img = coCreateTransImg(1, 64, 64)	
	guiSetButtonIcon(but, img)
	guiSetButtonIcon2(but, co.pixImg)	
	SetSpriteScale(but.icon2, 64, 64)
	but.id = BUT_EDITOR_COLOR
	but.help = "Set the color to use will all drawing tools."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.colBar.buts.insert(but)
	
	but = guiCreateButton("picker", BUT_BG_NORMAL, "gfx/PickerIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_PICKER
	but.help = "Press a color on the image to make it the current color. First press turns on, second press turns off."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.colBar.buts.insert(but)

	but = guiCreateButton("erase", BUT_BG_NORMAL, "", co.bluegrey[col])
	
	img = coCreateTransImg(1, 64, 64)	
	guiSetButtonIcon(but, img)
	//guiSetButtonIcon2(but, co.pixImg)	
	//SetSpriteScale(but.icon2, 64, 64)
	
	but.id = BUT_EDITOR_ERASE
	but.help = "Clear with all drawing tools. First press turns on, second press turns off."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.colBar.buts.insert(but)

	//
	// Size bar.
	//

	but = guiCreateButton("size", BUT_BG_NORMAL, "gfx/LineSizeIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_LINE_SIZE
	but.help = "Select the size (thickness) of lines."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.sizeBar.buts.insert(but)

	//
	// Line bar.
	//
	
	but = guiCreateButton("round", BUT_BG_NORMAL, "gfx/LineCircIcon.png", co.blueGrey[col])
	but.id = BUT_EDITOR_LINE_CIRC
	but.help = "Select rounded end lines for use with draw, line and shape tools."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.lineBar.buts.insert(but)

	but = guiCreateButton("square", BUT_BG_NORMAL, "gfx/LineSqrIcon.png", co.blueGrey[col])
	but.id = BUT_EDITOR_LINE_SQR
	but.help = "Select square end lines for use with draw, line and shape tools."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.lineBar.buts.insert(but)

	//
	// Text bar.
	//

	but = guiCreateButton("edit", BUT_BG_NORMAL, "gfx/TextIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_TEXT_EDIT
	but.help = "Edit text to paste to the image."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.textBar.buts.insert(but)

	but = guiCreateButton("font", BUT_BG_NORMAL, "gfx/FontIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_TEXT_FONT
	but.help = "Select the font for the text."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.textBar.buts.insert(but)

	but = guiCreateButton("size", BUT_BG_NORMAL, "gfx/TextSizeIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_TEXT_SIZE
	but.help = "Select the size of the text font. Valid value " + str(LD_TEXT_SIZE_MIN) + " to " + str(LD_TEXT_SIZE_MAX) + "."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.textBar.buts.insert(but)
	
	but = guiCreateButton("place top", BUT_BG_NORMAL, "gfx/PlaceTextTopIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_TEXT_PLACE
	but.help = "Paste the edited text at the top-left corner of pressed position. First press turns on, second press turns off."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.textBar.buts.insert(but)

	but = guiCreateButton("place mid", BUT_BG_NORMAL, "gfx/PlaceTextMidIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_TEXT_PLACE_MID
	but.help = "Paste the edited text with middle at pressed position. First press turns on, second press turns off."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.textBar.buts.insert(but)

	//
	// Image bar.
	//

	but = guiCreateButton("library", BUT_BG_NORMAL, "gfx/ImageIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_IMAGE
	but.help = "Opens the sprite library to select an image to paste."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.imageBar.buts.insert(but)

	but = guiCreateButton("place top", BUT_BG_NORMAL, "gfx/PlaceImageTopIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_IMAGE_PLACE
	but.help = "Paste the library image at the top-left corner of pressed position. First press turns on, second press turns off."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.imageBar.buts.insert(but)

	but = guiCreateButton("place mid", BUT_BG_NORMAL, "gfx/PlaceImageMidIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_IMAGE_PLACE_MID
	but.help = "Paste the edited text with middle at pressed position. First press turns on, second press turns off."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.imageBar.buts.insert(but)

	//
	// Rect bar.
	//
		
	but = guiCreateButton("rect", BUT_BG_NORMAL, "gfx/Rect2Icon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_RECT
	but.help = "Press and drag to draw a rectangle, then release. Draws in current color and size."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.shapeBar.buts.insert(but)
	 	
	but = guiCreateButton("oval", BUT_BG_NORMAL, "gfx/OvalIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_OVAL
	but.help = "Press and drag to draw an oval, then release. Draws in current color and size."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.shapeBar.buts.insert(but)
	
	but = guiCreateButton("polygon", BUT_BG_NORMAL, "gfx/PolygonIcon.png", co.blueGrey[col])
	but.id = BUT_EDITOR_POLY
	but.help = "Press and drag to draw a polygon with n sides, then release. Draws in current color and size."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.shapeBar.buts.insert(but)

	but = guiCreateButton("sides", BUT_BG_NORMAL, "gfx/PolygonSidesIcon.png", co.blueGrey[col])
	but.id = BUT_EDITOR_POLY_SIDES
	but.help = "Select the number of sides for the polygon."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.shapeBar.buts.insert(but)

	but = guiCreateButton("w = h", BUT_BG_NORMAL, "", co.blueGrey[col])
	but.id = BUT_EDITOR_SAME_SIDES
	but.help = "Make the width and height the same, i.e. make a rectangle into a square, oval into a circle."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.shapeBar.buts.insert(but)

	but = guiCreateButton("filled", BUT_BG_NORMAL, "", co.blueGrey[col])
	but.id = BUT_EDITOR_FILLED
	but.help = "Make the selected shape filled. First press turns on, second press turns off."
 	guiSetButtonBgSel(but, true, ed.toggleButCol2)
 	ed.shapeBar.buts.insert(but)

	//
	// Select bar.
	//
	
	but = guiCreateButton("rect sel", BUT_BG_NORMAL, "gfx/RectFilledIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_RECT_SEL
	but.help = "Press and drag to select a rectangle."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.selShapeBar.buts.insert(but)
	 	
	but = guiCreateButton("oval sel", BUT_BG_NORMAL, "gfx/OvalFilledIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_OVAL_SEL
	but.help = "Press and drag to select an oval."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.selShapeBar.buts.insert(but)

	but = guiCreateButton("draw sel", BUT_BG_NORMAL, "gfx/FreeDrawIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_DRAW_SEL
	but.help = "Draw free hand to the mark out the edge of the selection."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.selShapeBar.buts.insert(but)

	but = guiCreateButton("line sel", BUT_BG_NORMAL, "gfx/LineIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_LINE_SEL
	but.help = "Draw lines to mark our the edge of the selection."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.selShapeBar.buts.insert(but)

	but = guiCreateButton("fill sel", BUT_BG_NORMAL, "gfx/PaintIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_FILL_SEL
	but.help = "Fill an area to mark out the selection. First press turns on, second press turns off."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.selShapeBar.buts.insert(but)
 	
	but = guiCreateButton("deselect", BUT_BG_NORMAL, "gfx/DeselectIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_DESELECT
	but.help = "Deselect the selected area."
 	guiSetButtonBgSel(but, true, ed.selButCol)
 	ed.selShapeBar.buts.insert(but)

	//
	// Selection bar.
	//
	
	but = guiCreateButton("cut", BUT_BG_NORMAL, "gfx/CutIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_CUT
	but.help = "Cut (erase) the selected area, and make it a selection."
 	ed.selBar.buts.insert(but)

	but = guiCreateButton("copy", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_COPY
	but.help = "Copy the selected area, and make it a selection."
 	ed.selBar.buts.insert(but)

	but = guiCreateButton("paste", BUT_BG_NORMAL, "gfx/PasteIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_PASTE
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
	but.help = "Paste a selection into the image at the pressed position. First press turns on, second press turns off."
 	ed.selBar.buts.insert(but)

	//
	// Resize bar.
	//

	but = guiCreateButton("resize", BUT_BG_NORMAL, "gfx/ResizeIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_RESIZE
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
	but.help = "Resize the image."
 	ed.resizeBar.buts.insert(but)

	but = guiCreateButton("crop", BUT_BG_NORMAL, "gfx/CropIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_CROP
	but.help = "Crop the image to just what is selected."
 	ed.resizeBar.buts.insert(but)

	but = guiCreateButton("flip x", BUT_BG_NORMAL, "gfx/FlipIcon.png", co.bluegrey[col])
	SetSpriteAngle(but.icon, 90)
	but.id = BUT_EDITOR_FLIP_HORIZ
	but.help = "Flip the image in the x axis, i.e. from left to right."
 	ed.adjustBar.buts.insert(but)

	but = guiCreateButton("flip y", BUT_BG_NORMAL, "gfx/FlipIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_FLIP_VERT
	but.help = "Flip the image in the y axis, i.e. from top to bottom."
 	ed.adjustBar.buts.insert(but)

	but = guiCreateButton("rotate 90", BUT_BG_NORMAL, "gfx/RotateLeftIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_ROT_LEFT
	but.help = "Rotate the image anti-clockwise 90 degree."
 	ed.adjustBar.buts.insert(but)

	but = guiCreateButton("rotate 90", BUT_BG_NORMAL, "gfx/RotateLeftIcon.png", co.bluegrey[col])
	SetSpriteFlip(but.icon, true, false)
	but.id = BUT_EDITOR_ROT_RIGHT
	but.help = "Rotate the image clockwise 90 degree."
 	ed.adjustBar.buts.insert(but)

	but = guiCreateButton("clear", BUT_BG_NORMAL, "gfx/ClearIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_CLEAR
	but.help = "Clear the whole image, or clear a selected area. If a cut, copy or drawing tool selection is active, then that area will be cleared."
 	ed.clearBar.buts.insert(but)

	//but = guiCreateButton("menu pos", BUT_BG_NORMAL, "gfx/BackIcon.png", co.special3Col)
	//but.id = BUT_SETTINGS_EDITOR_POS
	//but.help = "Change the position of the button menu."
	//ed.moreBar.buts.insert(but)

	//
	// Grid bar.
	//

	but = guiCreateButton("snap", BUT_BG_NORMAL, "gfx/GridIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_GRID_SNAP
	but.help = "Snap to the grid."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.gridBar.buts.insert(but)
	
	but = guiCreateButton("width", BUT_BG_NORMAL, "gfx/GridWidthIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_GRID_WIDTH
	but.help = "Select width of the grid in pixels."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.gridBar.buts.insert(but)

	but = guiCreateButton("height", BUT_BG_NORMAL, "gfx/GridHeightIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_GRID_HEIGHT
	but.help = "Select the height of the grid in pixels."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.gridBar.buts.insert(but)

	but = guiCreateButton("cols", BUT_BG_NORMAL, "gfx/GridColsIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_GRID_COLS
	but.help = "Select the number of columns to divide the image into for the grid."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.gridBar.buts.insert(but)

	but = guiCreateButton("rows", BUT_BG_NORMAL, "gfx/GridRowsIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_GRID_ROWS
	but.help = "Select the number of rows to divide the image into for the grid."
 	guiSetButtonBgSel(but, true, ed.toggleButCol)
 	ed.gridBar.buts.insert(but)

	//
	// Edit bar.
	//

	//but = guiCreateButton("edit last", BUT_BG_NORMAL, "gfx/UndoIcon.png", co.bluegrey[col])
	//but.id = BUT_EDITOR_EDIT_LAST
	//but.help = "Edit the last drawing action, e.g. resize, rotate, change color, etc."
	//ed.editBar.buts.insert(but)

	//
	// Undo bar.
	//
	
	but = guiCreateButton("undo", BUT_BG_NORMAL, "gfx/UndoIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_UNDO
	but.help = "Undo the last change."
	ed.undoBar.buts.insert(but)

	but = guiCreateButton("redo", BUT_BG_NORMAL, "gfx/RedoIcon.png", co.bluegrey[col])
	but.id = BUT_EDITOR_REDO
	but.help = "Redo the last change that was undone."
	ed.undoBar.buts.insert(but)

	//
	// Save bar.
	//
	
	but = guiCreateButton("save", BUT_BG_NORMAL, "gfx/DoneIcon.png", co.runCol)
	but.id = BUT_EDITOR_SAVE
	but.help = "Saves your changes."
	ed.saveBar.buts.insert(but)

	but = guiCreateButton("cancel", BUT_BG_NORMAL, "gfx/CancelIcon.png", co.deleteCol)
	but.id = BUT_EDITOR_CANCEL
	but.help = "Cancels your changes."
	ed.saveBar.buts.insert(but)

	edHide()
	
endfunction

//-----------------------------------------------------
// Boot the entry to the editor.
//
function edSetImage(img as integer, edit as integer)
	
	ed.editImg = img
	ed.editMode = edit
	
endfunction

//-----------------------------------------------------
//
function edShow()

	local img as integer
	local i as integer
	local x0 as integer
	local y0 as integer
	
	SetSyncRate(60, 0)

	ed.clearCol = co.grey[5]
	coSetClearColor(ed.clearCol)
	SetBorderColor(128, 0, 0)

	SetPrintSize(48)

	SetVirtualResolution(co.w, co.h)
	// Set to settings.

	ed.gfx.shapeFilled = ld.set.editShapeFilled
	ed.gfx.shapeSameWH = ld.set.editShapeSameWH
	ed.gfx.snapToGrid = ld.set.editSnapToGrid	
	ed.gfx.col = coMakeHexColor(ld.set.editCol)
	edSetLineStyle(ld.set.editLineStyle)
	edSetDrawShape(ld.set.editDrawShape)
	edSetSelShape(ld.set.editSelShape)	
	edSetLineSize(ld.set.editLineSize)
	edSetTextFont(ld.set.editTextFont)
	edSetTextSize(ld.set.editTextSize)
	edSetPolySides(ld.set.editPolySides)
	
	ed.gfx.gridWidth = ld.set.editGridWidth
	ed.gfx.gridHeight = ld.set.editGridHeight
	
	//guiSetButtonVisible(ed.moreBut, true)
	
	// TEST.
	//img = loadimage("help/Made-With-AGK-250px.png")
	//img = loadimage("help/cmds_tab_screen.png")
	
	if ed.editImg
		img = ed.editImg
	else 
		img = loadimage("help/Made-With-AGK-250px.png")
	endif
	
	ed.editImg = 0
	edReset(img)
	
endfunction

//-----------------------------------------------------
// Called to rebuild everything based on a new image.
// NOTE: Creates a memblock, then deletes the img.
//
function edReset(img as integer)

	edHide()
	
	SetSpritePosition(ed.topBlock, 0, 0)
	SetSpriteVisible(ed.topBlock, true)
	SetSpritePosition(ed.leftBlock, 0, 0)
	SetSpriteVisible(ed.leftBlock, true)

	//ed.gfx.spr = CreateSprite(img)
	ed.gfx.workSpr = 0
	ed.gfx.sel.spr = 0
	ed.gfx.transSpr = 0
	ed.gfx.gridSpr = 0
	ed.gfx.text = 0
	ed.gfx.image.id = 0
	//ed.gfx.col = co.black
	//ed.gfx.lineSize = 1
	//ed.gfx.polySides = 3
	ed.gfx.drawDirty = true
	ed.gfx.pipsDirty = true
	
	coMemFromImage(img, ed.gfx.cols)
	//deleteimage(img)

	edSetGridWidth(ed.gfx.gridWidth)
	edSetGridHeight(ed.gfx.gridHeight)
	ed.gfx.gridCols = floor(ed.gfx.cols.w / ed.gfx.gridWidth)
	ed.gfx.gridRows = floor(ed.gfx.cols.h / ed.gfx.gridHeight)
	ed.gfx.gridDirty = true
	
	coMemCreate(ed.gfx.work, ed.gfx.cols.w, ed.gfx.cols.h)
	coMemSetBlend(ed.gfx.work, false)
	coMemSetUndo(ed.gfx.work, CO_POST_PIXEL)
	coMemSetMask(ed.gfx.work, true)
	
	coMemCreate(ed.gfx.sel.sel, ed.gfx.cols.w, ed.gfx.cols.h)
	coMemSetBlend(ed.gfx.sel.sel, false)
		
	edHideBars()
	edShowButtons()

	edFitZoom()
	edBuildTrans()

endfunction

//-----------------------------------------------------
// Fit zoom to screen.
//
function	edFitZoom()

	local count as integer
	
	if ed.zoomFixed
		
		ed.zoom1 = 3
		ed.zoomIdx = ed.zoom1
		
	else
		
		ed.zoom1 = 1.0
		
	endif
	
	edSetZoom(ed.zoom1) // Default to 1.

	edSubButtonAction(BUT_EDITOR_ZOOM_IN, 0)
	edScrollUpdate(ed.gfx.x0 + ed.gfx.w / 2, ed.gfx.y0 + ed.gfx.h / 2)

	count = 100
	
	// Keep zooming in until it is off the screen.
	while count > 0 and ed.gfx.offX >= 0 and ed.gfx.offY >= 0

		if ed.zoomFixed
			edSetZoom(ed.zoomIdx + 1)
		else
			edSetZoom(ed.gfx.zoom * 1.1)
		endif
		
		edScrollUpdate(ed.gfx.x0 + ed.gfx.w / 2, ed.gfx.y0 + ed.gfx.h / 2)
		
		dec count
		
	endwhile

	// Went too far, correct back.
	if ed.gfx.offX < 0 or ed.gfx.offY < 0

		if ed.zoomFixed
			edSetZoom(ed.zoomIdx - 1)
		else
			edSetZoom(ed.gfx.zoom / 1.1)
		endif

		edScrollUpdate(ed.gfx.x0 + ed.gfx.w / 2, ed.gfx.y0 + ed.gfx.h / 2)
		
	endif
	
endfunction

//-----------------------------------------------------
//
function edHideBars()
		
	guiHideBar(ed.panBar)
	guiHideBar(ed.colBar)
	guiHideBar(ed.sizeBar)
	guiHideBar(ed.lineBar)
	guiHideBar(ed.textBar)
	guiHideBar(ed.shapeBar)	
	guiHideBar(ed.selBar)
	guiHideBar(ed.selShapeBar)
	guiHideBar(ed.gridBar)
	guiHideBar(ed.imageBar)
	guiHideBar(ed.undoBar)
	guiHideBar(ed.resizeBar)
	guiHideBar(ed.adjustBar)
	guiHideBar(ed.clearBar)
	guiHideBar(ed.saveBar)
	guiHideBar(ed.editBar)

	if ed.imageSpr
		SetSpriteVisible(ed.imageSpr, false)
	endif
	
	if ed.text
		SetTextVisible(ed.text, false)
	endif
	
endfunction

//-----------------------------------------------------
// Clear the selection on the move bar.
//
function edClearMoveBarSel()
	
	local i as integer
	
	for i = 0 to ed.moreBar.buts.length
		guiSetButtonSelected(ed.moreBar.buts[i], false)
	next
	
endfunction

//-----------------------------------------------------
// Enable or disable all more bar buttons.
//
function edEnableMoreBar(enable as integer)
	
	local i as integer
	
	for i = 0 to ed.moreBar.buts.length
		guiSetButtonActive(ed.moreBar.buts[i], enable)
	next
	
endfunction

//-----------------------------------------------------
// Make everything inactive.
//
function edSetBarsActive(active as integer)

	local idx as integer
	local col as integer
	local alpha as integer
	
	//guiSetButtonActive(ed.moreBut, active)
	guiSetBarActive(ed.moreBar, active)
	guiSetBarActive(ed.panBar, active)
	guiSetBarActive(ed.lineBar, active)
	guiSetBarActive(ed.textBar, active)
	guiSetBarActive(ed.shapeBar, active)	
	guiSetBarActive(ed.selBar, active)
	guiSetBarActive(ed.gridBar, active)
	guiSetBarActive(ed.imageBar, active)
	guiSetBarActive(ed.undoBar, active)
	guiSetBarActive(ed.resizeBar, active)
	guiSetBarActive(ed.adjustBar, active)
	guiSetBarActive(ed.clearBar, active)
	guiSetBarActive(ed.saveBar, active)
			
	if not active
		
		idx = guiFindBarButtonById(ed.colbar, BUT_EDITOR_COLOR)
		col = coGetSpriteColor(ed.colbar.buts[idx].icon2)	
		
	endif

	guiSetBarActive(ed.colBar, active)

	if not active
		
		alpha = coGetColorAlpha(col) - gui.inactiveAlpha
		if alpha < 0 then alpha = 0
		col = coSetColorAlpha(col, alpha)
		coSetSpriteColor(ed.colbar.buts[idx].icon2, col)
		
	else
		
		edSetColorButton()
		
	endif
	
endfunction

//-----------------------------------------------------
//
function edHide()
	
	local img as integer
	
	SetSpriteVisible(ed.topBlock, false)
	SetSpriteVisible(ed.leftBlock, false)

	edShowCoords(false, false, 0, 0, 0, 0)

	SetSpriteVisible(ed.gfx.pixSpr, false)
	SetSpriteVisible(ed.gfx.transEdgeSpr, false)
	SetSpriteVisible(ed.scroll.spr, false)
	SetSpriteVisible(ed.gfx.vGridSpr, false)
	SetSpriteVisible(ed.gfx.vGridSpr, false)
		
	edHideMarks()
		
	//guiSetButtonVisible(ed.moreBut, false)
	edHideBars()
	guiHideBar(ed.moreBar)
	
	// TODO: Set the destination, they must copy this image.

	if ed.gfx.spr

		img = GetSpriteImageID(ed.gfx.spr)		
		DeleteSprite(ed.gfx.spr)
		ed.gfx.spr = 0
		
		if img
			deleteimage(img)
		endif
					
	endif
		
	if ed.gfx.transSpr

		img = GetSpriteImageID(ed.gfx.transSpr)		
		DeleteSprite(ed.gfx.transSpr)
		ed.gfx.transSpr = 0
		
		if img
			DeleteImage(img)
		endif
					
	endif

	if ed.gfx.workSpr

		img = GetSpriteImageID(ed.gfx.workSpr)		
		DeleteSprite(ed.gfx.workSpr)
		ed.gfx.workSpr = 0
		
		if img
			DeleteImage(img)
		endif
					
	endif

	if ed.gfx.sel.spr

		img = GetSpriteImageID(ed.gfx.sel.spr)		
		DeleteSprite(ed.gfx.sel.spr)
		ed.gfx.sel.spr = 0
		
		if img
			DeleteImage(img)
		endif
					
	endif
	
	if ed.gfx.gridSpr

		img = GetSpriteImageID(ed.gfx.gridSpr)		
		DeleteSprite(ed.gfx.gridSpr)
		ed.gfx.gridSpr = 0
		
		if img
			DeleteImage(img)
		endif
					
	endif

	if ed.imageSpr

		img = GetSpriteImageID(ed.imageSpr)		
		DeleteSprite(ed.imageSpr)
		ed.imageSpr = 0
		
		if img
			DeleteImage(img)
		endif
					
	endif
	
	if ed.gfx.text
		
		deletetext(ed.gfx.text)
		ed.gfx.text = 0
		
	endif
	
	if ed.gfx.cols.id		
		coMemDelete(ed.gfx.cols)	
	endif

	if ed.gfx.work.id		
		coMemDelete(ed.gfx.work)		
	endif

	if ed.gfx.sel.sel.id		
		coMemDelete(ed.gfx.sel.sel)		
	endif

	if ed.gfx.copy.id
		coMemDelete(ed.gfx.copy)
	endif

	if ed.gfx.image.id
		coMemDelete(ed.gfx.image)
	endif

	if ed.editImg
		
		deleteimage(ed.editImg)
		ed.editImg = 0
		
	endif
	
endfunction

//-----------------------------------------------------
//
function edShowButtons()

	local gap as float
	local idx as integer
	local i as integer
	local p as ButPos
	local ty as float
	local tdy as float
	
	gap = co.bs / 4	
	p.dx = 0
	p.dy = 0
	p.ci = 1
	p.updCols = true
	
	for i = 3 to 6
		p.cols.insert(co.bluegrey[i])
	next
	
	// More button and bar.

	p.dy = 1
	p.dx = 0
	p.ci = 1
	p.x = gap + co.bs / 2
	p.y = gap + co.bs / 2
	p.x = p.x + (co.bs * p.dx)
	p.y = p.y + (co.bs * p.dy)
	
	edShowBarGap(p, gap)
	p.colIdx = 0
	edShowBar(ed.moreBar, p)
	edHideBars()
		
	// Sub tool bar.
				
	p.dy = 0
	p.dx = 1
	p.ci = 1

	p.x = gap + co.bs / 2
	p.y = gap + co.bs / 2
	//p.x = p.x + (co.bs * p.dx)
	p.y = p.y + (co.bs * p.dy)
	
	p.colIdx = 0
	
	edClearMoveBarSel()

	if not ed.editMode
		ed.butId = BUT_EDITOR_PAN
	endif
	
	if ed.butId = BUT_EDITOR_PAN
		
		edShowBar(ed.panBar, p)

	elseif ed.butId = BUT_EDITOR_DRAW

		edShowBar(ed.colBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.sizeBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.lineBar, p)

	elseif ed.butId = BUT_EDITOR_LINE
	
		edShowBar(ed.colBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.sizeBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.lineBar, p)

	elseif ed.butId = BUT_EDITOR_FILL
	
		edShowBar(ed.colBar, p)

	elseif ed.butId = BUT_EDITOR_SHAPE
	
		edShowBar(ed.colBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.sizeBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.shapeBar, p)			

	elseif ed.butId = BUT_EDITOR_TEXT
	
		edShowBar(ed.colBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.textBar, p)

	elseif ed.butId = BUT_EDITOR_IMAGE
	
		edShowBar(ed.imageBar, p)

	elseif ed.butId = BUT_EDITOR_SELECT
	
		edShowBar(ed.selShapeBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.selBar, p)

	elseif ed.butId = BUT_EDITOR_GRID_SNAP
	
		edShowBar(ed.gridBar, p)

	elseif ed.butId = BUT_EDITOR_RESIZE
	
		edShowBar(ed.resizeBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.adjustBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.clearBar, p)
		edShowBarGap(p, gap)
		p.colIdx = 0
		edShowBar(ed.editBar, p)

	endif

	idx = guiFindBarButtonById(ed.moreBar, ed.butId)
	guiSetButtonSelected(ed.moreBar.buts[idx], true)

	// Undo and save buttons.
		
	p.dy = 0		
	p.dx = -1
	p.ci = -2

	p.x = co.w - gap - co.bs / 2
	p.y = gap + co.bs / 2
	
	p.colIdx = p.cols.length
	p.updCols = false
	
	edShowBar(ed.saveBar, p)

	if ed.butId <> BUT_EDITOR_PAN
		
		edShowBarGap(p, gap)
		p.colIdx = p.cols.length
		p.updCols = true
		edShowBar(ed.undoBar, p)
				
	endif
		
	tdy = co.bs / 4 - 4

	// Position to left of undo but.	
	//ty = co.bs / 4 - 4
	//p.x = p.x - co.bs / 2

	// Top-left of drawing area.	
	ty = ed.gfx.y0 + gap / 2
	p.x = ed.gfx.x0 + gap
	
	SetTextPosition(ed.x0Text, p.x, ty)
	ty = ty + tdy
	SetTextPosition(ed.y0Text, p.x, ty)
	ty = ty + tdy
	SetTextPosition(ed.x1Text, p.x, ty)
	ty = ty + tdy
	SetTextPosition(ed.y1Text, p.x, ty)
	
	//edSetMoreButton()
	edSetSizeButton()
	edSetColorButton()
	edSetLineButton()
	edSetShapeButton()
	edSetSelShapeButton()
	edSetSelButton()
	edSetGridButton()
	edSetTextButton()
	edSetImageButton()
	edSetResizeButtons()
	edSetSaveUndoButtons()

	if not ed.editMode
				
		edEnableMoreBar(false)
		idx = guiFindBarButtonById(ed.moreBar, BUT_EDITOR_PAN)
		guiSetButtonActive(ed.moreBar.buts[idx], true)
		
	else
		
		edEnableMoreBar(true)
			
	endif

endfunction

//-----------------------------------------------------
// Set the resize buttons.
//
function edSetResizeButtons()
		
	local idx as integer
	
	idx = guiFindBarButtonById(ed.resizeBar, BUT_EDITOR_CROP)
	guiSetButtonActive(ed.resizeBar.buts[idx], ed.gfx.sel.active)
	
endfunction

//-----------------------------------------------------
// Set the save and undo buttons.
//
function edSetSaveUndoButtons()
		
	local idx as integer
	
	idx = guiFindBarButtonById(ed.undoBar, BUT_EDITOR_UNDO)
	guiSetButtonActive(ed.undoBar.buts[idx], ed.gfx.undos.length > -1)
	idx = guiFindBarButtonById(ed.undoBar, BUT_EDITOR_REDO)
	guiSetButtonActive(ed.undoBar.buts[idx], ed.gfx.redos.length > -1)

	idx = guiFindBarButtonById(ed.saveBar, BUT_EDITOR_SAVE)
	guiSetButtonActive(ed.saveBar.buts[idx], ed.gfx.undos.length > -1)

	if not ed.editMode
		guiSetButtonActive(ed.saveBar.buts[idx], false)
	endif
		
endfunction

//-----------------------------------------------------
// Show the coords.
//
function edShowCoords(vis0 as integer, vis1 as integer, x0 as float, y0 as float, x1 as float, y1 as float)
	
	if vis0 and vis1
		
		SetTextString(ed.x0Text, "X0: " + str(trunc(x0)))
		SetTextString(ed.y0Text, "Y0: " + str(trunc(y0)))
		SetTextString(ed.x1Text, "X1: " + str(trunc(x1)))
		SetTextString(ed.y1Text, "Y1: " + str(trunc(y1)))

		SetTextVisible(ed.x0Text, true)
		SetTextVisible(ed.y0Text, true)
		SetTextVisible(ed.x1Text, true)
		SetTextVisible(ed.y1Text, true)
		
	elseif vis0

		SetTextString(ed.x0Text, "X: " + str(trunc(x0)))
		SetTextString(ed.y0Text, "Y: " + str(trunc(y0)))

		SetTextVisible(ed.x0Text, false)
		SetTextVisible(ed.y0Text, true)
		SetTextVisible(ed.x1Text, true)
		SetTextVisible(ed.y1Text, false)
		
	elseif vis1

		SetTextString(ed.x0Text, "X: " + str(trunc(x1)))
		SetTextString(ed.y0Text, "Y: " + str(trunc(y1)))

		SetTextVisible(ed.x0Text, false)
		SetTextVisible(ed.y0Text, true)
		SetTextVisible(ed.x1Text, true)
		SetTextVisible(ed.y1Text, false)

	else
		
		SetTextVisible(ed.x0Text, false)
		SetTextVisible(ed.y0Text, false)
		SetTextVisible(ed.x1Text, false)
		SetTextVisible(ed.y1Text, false)
		
	endif

endfunction

//-----------------------------------------------------
// Check if a tip is ready to show.
//
function edCheckTip(butId as integer, dt as integer, but ref as Button)
	
	if butId = ed.pressedButId
			
		if dt > ED_HOLD_TIME
			
			guiShowTip(gui.tip, but.bg, but.help, TIP_INFO, 0)
			ed.mode = ED_MODE_NONE
			
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Check for a button for the appropriate buts for the passed butId.
//
function edCheckSubBarPressed(x as float, y as float, dt as integer)
	
	local butIdx as integer
	local butId as integer
	
	butIdx = -1
	butId = -1

	if butIdx = -1			

		butIdx = guiCheckBarPressed(ed.saveBar, x, y, 1)			

		if butIdx > -1
			
			butId = ed.saveBar.buts[butIdx].id
			edCheckTip(butId, dt, ed.saveBar.buts[butIdx])

		endif

	endif
	
	if ed.butId = BUT_EDITOR_PAN
	
		if butIdx = -1
			
			butIdx = guiCheckBarPressed(ed.panBar, x, y, 1)
			
			if butIdx > -1
				
				butId = ed.panBar.buts[butIdx].id

				if butId > -1 and butId = ed.pressedButId // Needs to be the same.
					
					if butId = BUT_EDITOR_ZOOM_IN or butId = BUT_EDITOR_ZOOM_OUT
						edSubButtonAction(butId, 0)
					else
						edCheckTip(butId, dt, ed.panBar.buts[butIdx])
					endif
					
				endif

			endif
					
		endif

	elseif ed.butId = BUT_EDITOR_DRAW
	
		if butIdx = -1
						
			butIdx = guiCheckBarPressed(ed.colBar, x, y, 1)

			if butIdx > -1
				
				butId = ed.colBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.colBar.buts[butIdx])

			endif

		endif

		if butIdx = -1		
	
			butIdx = guiCheckBarPressed(ed.sizeBar, x, y, 1)
	
			if butIdx > -1
				
				butId = ed.sizeBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.sizeBar.buts[butIdx])

			endif

		endif
	
		if butIdx = -1			
		
			butIdx = guiCheckBarPressed(ed.lineBar, x, y, 1)

			if butIdx > -1

				butId = ed.lineBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.lineBar.buts[butIdx])

			endif

		endif

	elseif ed.butId = BUT_EDITOR_LINE
	
		if butIdx = -1		

			butIdx = guiCheckBarPressed(ed.colBar, x, y, 1)
			
			if butIdx > -1
				
				butId = ed.colBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.colBar.buts[butIdx])

			endif

		endif

		if butIdx = -1		
	
			butIdx = guiCheckBarPressed(ed.sizeBar, x, y, 1)
	
			if butIdx > -1
				
				butId = ed.sizeBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.sizeBar.buts[butIdx])

			endif

		endif

		if butIdx = -1			
		
			butIdx = guiCheckBarPressed(ed.lineBar, x, y, 1)

			if butIdx > -1

				butId = ed.lineBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.lineBar.buts[butIdx])

			endif

		endif

	elseif ed.butId = BUT_EDITOR_FILL
	
		if butIdx = -1
								
			butIdx = guiCheckBarPressed(ed.colBar, x, y, 1)
			
			if butIdx > -1
				
				butId = ed.colBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.colBar.buts[butIdx])
				
			endif

		endif

	elseif ed.butId = BUT_EDITOR_SHAPE
	
		if butIdx = -1			
			
			butIdx = guiCheckBarPressed(ed.shapeBar, x, y, 1)			
		
			if butIdx > -1
				
				butId = ed.shapeBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.shapeBar.buts[butIdx])

			endif

		endif

		if butIdx = -1			
			
			butIdx = guiCheckBarPressed(ed.colBar, x, y, 1)			
		
			if butIdx > -1
				
				butId = ed.colBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.colBar.buts[butIdx])

			endif

		endif

		if butIdx = -1		
	
			butIdx = guiCheckBarPressed(ed.sizeBar, x, y, 1)
	
			if butIdx > -1
				
				butId = ed.sizeBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.sizeBar.buts[butIdx])

			endif

		endif

	elseif ed.butId = BUT_EDITOR_TEXT
	
		if butIdx = -1		
	
			butIdx = guiCheckBarPressed(ed.textBar, x, y, 1)			

			if butIdx > -1
				
				butId = ed.textBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.textBar.buts[butIdx])

			endif

		endif

		if butIdx = -1		
	
			butIdx = guiCheckBarPressed(ed.colBar, x, y, 1)
	
			if butIdx > -1
				
				butId = ed.colBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.colBar.buts[butIdx])

			endif

		endif

	elseif ed.butId = BUT_EDITOR_IMAGE
	
		if butIdx = -1		

			butIdx = guiCheckBarPressed(ed.imageBar, x, y, 1)
	
			if butIdx > -1
				
				butId = ed.imageBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.imageBar.buts[butIdx])

			endif

		endif

	elseif ed.butId = BUT_EDITOR_SELECT

		if butIdx = -1		

			butIdx = guiCheckBarPressed(ed.selShapeBar, x, y, 1)

			if butIdx > -1
				
				butId = ed.selShapeBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.selShapeBar.buts[butIdx])

			endif

		endif
	
		if butIdx = -1		

			butIdx = guiCheckBarPressed(ed.selBar, x, y, 1)

			if butIdx > -1
				
				butId = ed.selBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.selBar.buts[butIdx])

			endif

		endif

	elseif ed.butId = BUT_EDITOR_GRID_SNAP
	
		if butIdx = -1			

			butIdx = guiCheckBarPressed(ed.gridBar, x, y, 1)			

			if butIdx > -1
				
				butId = ed.gridBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.gridBar.buts[butIdx])

			endif

		endif

	elseif ed.butId = BUT_EDITOR_RESIZE
	
		if butIdx = -1			

			butIdx = guiCheckBarPressed(ed.resizeBar, x, y, 1)			

			if butIdx > -1
				
				butId = ed.resizeBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.resizeBar.buts[butIdx])

			endif

		endif

		if butIdx = -1			

			butIdx = guiCheckBarPressed(ed.adjustBar, x, y, 1)			

			if butIdx > -1
				
				butId = ed.adjustBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.adjustBar.buts[butIdx])

			endif

		endif

		if butIdx = -1			

			butIdx = guiCheckBarPressed(ed.clearBar, x, y, 1)			

			if butIdx > -1
				
				butId = ed.clearBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.clearBar.buts[butIdx])

			endif

		endif

		if butIdx = -1			

			butIdx = guiCheckBarPressed(ed.editBar, x, y, 1)			

			if butIdx > -1
				
				butId = ed.editBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.editBar.buts[butIdx])

			endif

		endif

	endif

	if ed.butId <> BUT_EDITOR_PAN
		
		if butIdx = -1			

			butIdx = guiCheckBarPressed(ed.undoBar, x, y, 1)			

			if butIdx > -1
				
				butId = ed.undoBar.buts[butIdx].id
				edCheckTip(butId, dt, ed.undoBar.buts[butIdx])

			endif

		endif

	endif
	
endfunction butId

//-----------------------------------------------------
// Check for a button in the more bar.
//
function edCheckMoreBarPressed(x as float, y as float, dt as integer)
	
	local butIdx as integer
	local butId as integer
	
	butId = -1		
	butIdx = guiCheckBarPressed(ed.moreBar, x, y, 1)
	
	if butIdx > -1
		
		butId = ed.moreBar.buts[butIdx].id
		edCheckTip(butId, dt, ed.moreBar.buts[butIdx])

	endif
	
endfunction butId

//-----------------------------------------------------
// Check for a button for the appropriate buts for the passed butId.
//
function edCheckSubBarReleased(x as float, y as float)
	
	local butId as integer
	
	butId = -1

	if butId = -1				
		butId = guiCheckBarReleased(ed.saveBar, x, y, 1)					
	endif
	
	if ed.butId = BUT_EDITOR_PAN
	
		if butId = -1			
			butId = guiCheckBarReleased(ed.panBar, x, y, 1)					
		endif

	elseif ed.butId = BUT_EDITOR_DRAW
	
		if butId = -1					
			butId = guiCheckBarReleased(ed.colBar, x, y, 1)
		endif

		if butId = -1		
			butId = guiCheckBarReleased(ed.sizeBar, x, y, 1)
		endif
	
		if butId = -1					
			butId = guiCheckBarReleased(ed.lineBar, x, y, 1)
		endif

	elseif ed.butId = BUT_EDITOR_LINE
	
		if butId = -1		
			butId = guiCheckBarReleased(ed.colBar, x, y, 1)
		endif

		if butId = -1		
			butId = guiCheckBarReleased(ed.sizeBar, x, y, 1)
		endif

		if butId = -1					
			butId = guiCheckBarReleased(ed.lineBar, x, y, 1)
		endif

	elseif ed.butId = BUT_EDITOR_FILL
	
		if butId = -1							
			butId = guiCheckBarReleased(ed.colBar, x, y, 1)
		endif

	elseif ed.butId = BUT_EDITOR_SHAPE
	
		if butId = -1						
			butId = guiCheckBarReleased(ed.shapeBar, x, y, 1)			
		endif

		if butId = -1						
			butId = guiCheckBarReleased(ed.colBar, x, y, 1)			
		endif

		if butId = -1		
			butId = guiCheckBarReleased(ed.sizeBar, x, y, 1)
		endif

	elseif ed.butId = BUT_EDITOR_TEXT
	
		if butId = -1			
			butId = guiCheckBarReleased(ed.textBar, x, y, 1)			
		endif

		if butId = -1			
			butId = guiCheckBarReleased(ed.colBar, x, y, 1)
		endif

	elseif ed.butId = BUT_EDITOR_IMAGE
	
		if butId = -1		
			butId = guiCheckBarReleased(ed.imageBar, x, y, 1)
		endif

	elseif ed.butId = BUT_EDITOR_SELECT
	
		if butId = -1		
			butId = guiCheckBarReleased(ed.selShapeBar, x, y, 1)
		endif

		if butId = -1		
			butId = guiCheckBarReleased(ed.selBar, x, y, 1)
		endif

	elseif ed.butId = BUT_EDITOR_GRID_SNAP
	
		if butId = -1			
			butId = guiCheckBarReleased(ed.gridBar, x, y, 1)			
		endif

	elseif ed.butId = BUT_EDITOR_RESIZE
	
		if butId = -1			
			butId = guiCheckBarReleased(ed.resizeBar, x, y, 1)			
		endif

		if butId = -1			
			butId = guiCheckBarReleased(ed.adjustBar, x, y, 1)			
		endif

		if butId = -1			
			butId = guiCheckBarReleased(ed.clearBar, x, y, 1)			
		endif

		if butId = -1			
			butId = guiCheckBarReleased(ed.editBar, x, y, 1)			
		endif

	endif

	if ed.butId <> BUT_EDITOR_PAN
		
		if butId = -1			
			butId = guiCheckBarReleased(ed.undoBar, x, y, 1)			
		endif

	endif
	
endfunction butId

//-----------------------------------------------------
// Show a bar appending as it goes.
//
function edShowBar(bar ref as Toolbar, p ref as ButPos)

	local i as integer

	if p.ci > 0
			
		for i = 0 to bar.buts.length
			
			guiSetButtonPos(bar.buts[i], p.x, p.y)
			
			if p.updCols
				guiSetButtonBgCol(bar.buts[i], p.cols[p.colIdx])
			endif
							
			p.colIdx = p.colIdx + p.ci
			
			if p.colIdx > p.cols.length
				p.colIdx = 0
			endif
					
			p.x = p.x + (getspritewidth(bar.buts[i].bg) * p.dx)
			p.y = p.y + (GetSpriteHeight(bar.buts[i].bg) * p.dy)
					
		next

	else
	
		for i = bar.buts.length to 0 step -1
			
			guiSetButtonPos(bar.buts[i], p.x, p.y)
			
			if p.updCols
				guiSetButtonBgCol(bar.buts[i], p.cols[p.colIdx])
			endif
					
			p.colIdx = p.colIdx + p.ci
			
			if p.colIdx < 0
				p.colIdx = p.cols.length
			endif
					
			p.x = p.x + (getspritewidth(bar.buts[i].bg) * p.dx)
			p.y = p.y + (GetSpriteHeight(bar.buts[i].bg) * p.dy)
					
		next
			
	endif
		
	guiShowBar(bar)

endfunction

//-----------------------------------------------------
// Show a bar appending as it goes.
//
function edShowBarGap(p ref as ButPos, gap as float)
					
	p.x = p.x + gap * p.dx
	p.y = p.y + gap * p.dy

endfunction

//-----------------------------------------------------
// Check sub buttons.
//
function edSubButtonAction(butId as integer, obj as integer)

	local x as float
	local y as float
	local idx as integer
	local cut as MemBlock
	local b as Bounds
	local w as integer
	local h as integer
	local img as integer
	local max as integer
	local dx as integer
	local dy as integer
	local spr as integer
	local redos as Change[]
	local blend as integer
	local tmp as MemBlock

	if ed.gfx.sel.lining
		
		edFinishLineSel()
		edShowButtons()

	endif

	//if ed.gfx.sel.filling
		
	//	edFinishFillSel()
	//	edShowButtons()

	//endif

	if ed.pasteButId > -1 and butId <> BUT_EDITOR_PASTE
		ed.pasteButId = -1
	endif

	if ed.textButId > -1 and butId <> BUT_EDITOR_TEXT_PLACE and butId <> BUT_EDITOR_TEXT_PLACE_MID
		ed.textButId = -1
	endif

	if ed.imageButId > -1 and butId <> BUT_EDITOR_IMAGE_PLACE and butId <> BUT_EDITOR_IMAGE_PLACE_MID
		ed.imageButId = -1
	endif
	
	if butId = BUT_EDITOR_SAVE 

		//edSaveSettings(BUT_EDITOR_SAVE)	
		edClearChanges(ed.gfx.undos)
		edClearChanges(ed.gfx.redos)
		img = coMemToImage(ed.gfx.cols)
		OnButtonAction(butId, img)

	elseif butId = BUT_EDITOR_CANCEL

		//edSaveSettings(BUT_EDITOR_CANCEL)
		OnButtonAction(butId, 0)

	elseif butId = BUT_EDITOR_REDO

		edUndo(ed.gfx.cols, ed.gfx.redos, ed.gfx.undos, true)
		edShowButtons()		
		
	elseif butId = BUT_EDITOR_UNDO
		
		edUndo(ed.gfx.cols, ed.gfx.undos, ed.gfx.redos, true)
		edShowButtons()

	elseif butId = BUT_EDITOR_EDIT_LAST

//xxx need to add fine rotation.
//xxx need to allow rotation, flip and fine rotation angle on work / sel.

		edUndo(ed.gfx.cols, ed.gfx.undos, ed.gfx.redos, true)

		edClearWork()
		blend = coMemSetBlend(ed.gfx.work, false)
		edUndo(ed.gfx.work, ed.gfx.redos, redos, false) // Undo the redo to work, but don't save for redo.
		coMemSetBlend(ed.gfx.work, blend)
				
		coMemGetBounds(ed.gfx.work, b)
		edClearSel()
		coMemDrawRect(ed.gfx.sel.sel, b.x0, b.y0, b.x1, b.y1, ed.gfx.sel.editCol, 0)		
		ed.gfx.sel.dirty = true
		ed.gfx.sel.active = true
		edShowButtons()

	elseif butId = BUT_EDITOR_ZOOM_IN
		
		if ed.zoomFixed
			edSetZoom(ed.zoomIdx + 1)
		else
			edSetZoom(ed.gfx.zoom * 1.1)
		endif

		edBuildTrans()
		
	elseif butId = BUT_EDITOR_ZOOM_OUT

		if ed.zoomFixed
			edSetZoom(ed.zoomIdx - 1)
		else
			edSetZoom(ed.gfx.zoom / 1.1)
		endif
		
		edBuildTrans()

	elseif butId = BUT_EDITOR_ZOOM_RESET

		edSetZoom(ed.zoom1)
		edBuildTrans()

	elseif butId = BUT_EDITOR_ZOOM_FIT

		edFitZoom()
		edBuildTrans()

	elseif butId = BUT_EDITOR_RESIZE
		
		idx = guiFindBarButtonById(ed.resizeBar, BUT_EDITOR_RESIZE)
		guiSetButtonSelected(ed.resizeBar.buts[idx], true)
		edSetBarsActive(false)
		img = coMemToImage(ed.gfx.cols)
		spr = createsprite(img)
		cdButtonAction(butId, spr)
		// Don't delete the img or spr, the resizing will do that.
		
	elseif butId = BUT_EDITOR_CROP
	
		img = coMemToImage(ed.gfx.cols)
		edAddImgUndo(img)
	
		coMemGetBounds(ed.gfx.sel.sel, b)
		coMemExtract(ed.gfx.cols, b, ed.gfx.sel.sel, cut, false)
		img = coMemToImage(cut)
		edAddMbUndo(ED_CHG_MB, cut, b)
		coMemDelete(cut)
		edReset(img)
		//edShowButtons()
	
	elseif butId = BUT_EDITOR_FLIP_HORIZ
					
		if ed.gfx.sel.active			

			coMemGetBounds(ed.gfx.sel.sel, b)
			coMemGrab(ed.gfx.cols, cut, b.x0, b.y0, b.x1 - b.x0 + 1, b.y1 - b.y0 + 1)
			edAddMbUndo(ED_CHG_MB2, cut, b)
			coMemDelete(cut)
			coMemExtract(ed.gfx.cols, b, ed.gfx.sel.sel, cut, true)
			coMemFlipX(cut, 0, 0, cut.w, cut.h)
			coMemPaste(cut, ed.gfx.cols, b.x0, b.y0)
			coMemDelete(cut)

			coMemGrab(ed.gfx.sel.sel, cut, b.x0, b.y0, b.x1 - b.x0 + 1, b.y1 - b.y0 + 1)
			edAddMbUndo(ED_CHG_MB2, cut, b)
			coMemDelete(cut)
			w = b.x1 - b.x0 + 1
			h = b.y1 - b.y0 + 1
			coMemFlipX(ed.gfx.sel.sel, b.x0, b.y0, w, h)
			ed.gfx.sel.dirty = true

		else
			
			coMemFlipX(ed.gfx.cols, 0, 0, ed.gfx.cols.w, ed.gfx.cols.h)
			b.x0 = 0
			b.y0 = 0
			b.x1 = ed.gfx.cols.w - 1
			b.y1 = ed.gfx.cols.h - 1
			edAddOpUndo(ED_CHG_FLIP_X, b)
			
		endif

		ed.gfx.drawDirty = true
		
		edShowButtons()

	elseif butId = BUT_EDITOR_FLIP_VERT
				
		if ed.gfx.sel.active			

			coMemGetBounds(ed.gfx.sel.sel, b)
			coMemGrab(ed.gfx.cols, cut, b.x0, b.y0, b.x1 - b.x0 + 1, b.y1 - b.y0 + 1)
			edAddMbUndo(ED_CHG_MB2, cut, b)
			coMemDelete(cut)
			coMemExtract(ed.gfx.cols, b, ed.gfx.sel.sel, cut, true)
			coMemFlipY(cut, 0, 0, cut.w, cut.h)
			coMemPaste(cut, ed.gfx.cols, b.x0, b.y0)
			coMemDelete(cut)

			coMemGrab(ed.gfx.sel.sel, cut, b.x0, b.y0, b.x1 - b.x0 + 1, b.y1 - b.y0 + 1)
			edAddMbUndo(ED_CHG_MB2, cut, b)
			coMemDelete(cut)
			w = b.x1 - b.x0 + 1
			h = b.y1 - b.y0 + 1
			coMemFlipY(ed.gfx.sel.sel, b.x0, b.y0, w, h)
			ed.gfx.sel.dirty = true
				
		else
			
			coMemFlipY(ed.gfx.cols, 0, 0, ed.gfx.cols.w, ed.gfx.cols.h)
			b.x0 = 0
			b.y0 = 0
			b.x1 = ed.gfx.cols.w - 1
			b.y1 = ed.gfx.cols.h - 1
			edAddOpUndo(ED_CHG_FLIP_Y, b)
			
		endif

		ed.gfx.drawDirty = true
		
		edShowButtons()

	elseif butId = BUT_EDITOR_ROT_LEFT
		
		if ed.gfx.sel.active			

			edRotateSel(true)			

		else
			
			coMemRotate(ed.gfx.cols, true)
			b.x0 = 0
			b.y0 = 0
			b.x1 = ed.gfx.cols.w - 1
			b.y1 = ed.gfx.cols.h - 1
			edAddOpUndo(ED_CHG_ROT_RIGHT, b)

			img = coMemToImage(ed.gfx.cols)
			coMemDelete(ed.gfx.cols)
			edReset(img)
			
		endif

		ed.gfx.drawDirty = true
		
		edShowButtons()

	elseif butId = BUT_EDITOR_ROT_RIGHT
		
		if ed.gfx.sel.active			

			edRotateSel(false)			

		else
			
			coMemRotate(ed.gfx.cols, false)
			b.x0 = 0
			b.y0 = 0
			b.x1 = ed.gfx.cols.w - 1
			b.y1 = ed.gfx.cols.h - 1
			edAddOpUndo(ED_CHG_ROT_LEFT, b)

			img = coMemToImage(ed.gfx.cols)
			coMemDelete(ed.gfx.cols)
			edReset(img)
			
		endif

		ed.gfx.drawDirty = true
		
		edShowButtons()
	
	elseif butId = BUT_EDITOR_COLOR

		if ed.eraseButId > -1
			
			edSetEraseMode(-1)
			edShowButtons()
	
		endif
		
		idx = guiFindBarButtonById(ed.colBar, BUT_EDITOR_COLOR)
		guiSetButtonSelected(ed.colBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, ed.gfx.col)

	elseif butId = BUT_EDITOR_PICKER
			
		if ed.pickerButId > -1
			
			ed.pickerButId = -1
			
		else
			
			ed.pickerButId = BUT_EDITOR_PICKER
			
			if ed.eraseButId > -1
				edSetEraseMode(-1)
			endif
		
		endif	
		
		edShowButtons()

	elseif butId = BUT_EDITOR_ERASE

		if ed.eraseButId > -1
			
			edSetEraseMode(-1)	
					
		else
			
			edSetEraseMode(BUT_EDITOR_ERASE)		
			
			if ed.pickerButId > -1
				ed.pickerButId = -1
			endif
	
		endif	
		
		edShowButtons()
	
	elseif butId = BUT_EDITOR_CUT
		
		coMemGetBounds(ed.gfx.sel.sel, b)
		// Grab for undo.
		tmp.id = 0
		coMemExtract(ed.gfx.cols, b, tmp, cut, false)
		edAddMbUndo(ED_CHG_MB, cut, b)
		// Now extract into copy buffer.
		coMemExtract(ed.gfx.cols, b, ed.gfx.sel.sel, ed.gfx.copy, true)
		//edAddMbUndo(ED_CHG_MB, ed.gfx.copy, b)
		ed.gfx.drawDirty = true
		edShowButtons()
		
	elseif butId = BUT_EDITOR_COPY
		
		coMemGetBounds(ed.gfx.sel.sel, b)
		coMemExtract(ed.gfx.cols, b, ed.gfx.sel.sel, ed.gfx.copy, false)
		edShowButtons()

	elseif butId = BUT_EDITOR_PASTE

		if ed.pasteButId > -1
			ed.pasteButId = -1
		else
			ed.pasteButId = BUT_EDITOR_PASTE
		endif	
		
		edShowButtons()
		
	elseif butId = BUT_EDITOR_CLEAR
					
		if ed.gfx.sel.active			
			
			coMemGetBounds(ed.gfx.sel.sel, b)
			coMemExtract(ed.gfx.cols, b, ed.gfx.sel.sel, cut, true)
			edAddMbUndo(ED_CHG_MB, cut, b)
			
		else
			
			coMemGrab(ed.gfx.cols, cut, 0, 0, ed.gfx.cols.w, ed.gfx.cols.h)
			coMemClear(ed.gfx.cols)
			b.x0 = 0
			b.y0 = 0
			b.x1 = ed.gfx.cols.w - 1
			b.y1 = ed.gfx.cols.h - 1
			edAddMbUndo(ED_CHG_MB, cut, b)
			coMemDelete(cut)
			
		endif

		ed.gfx.drawDirty = true
		
		edShowButtons()

  	elseif butId = BUT_EDITOR_GRID_SNAP
	
		//if ed.gridButId > -1
		//	ed.gridButId = -1
		//else
		//	ed.gridButId = BUT_EDITOR_GRID_SNAP
		//endif	
		
		if ed.gfx.snapToGrid
			ed.gfx.snapToGrid = false
		else 
			ed.gfx.snapToGrid = true
		endif

		edSaveSettings(BUT_EDITOR_GRID_SNAP)	
		
		ed.gfx.gridDirty = true
		
		edShowButtons()

	elseif butId = BUT_EDITOR_GRID_ROWS
		
		idx = guiFindBarButtonById(ed.gridBar, BUT_EDITOR_GRID_ROWS)
		guiSetButtonSelected(ed.gridBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, ed.gfx.gridRows)

	elseif butId = BUT_EDITOR_GRID_COLS

		idx = guiFindBarButtonById(ed.gridBar, BUT_EDITOR_GRID_COLS)
		guiSetButtonSelected(ed.gridBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, ed.gfx.gridCols)

	elseif butId = BUT_EDITOR_GRID_WIDTH
		
		idx = guiFindBarButtonById(ed.gridBar, BUT_EDITOR_GRID_WIDTH)
		guiSetButtonSelected(ed.gridBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, ed.gfx.gridWidth)

	elseif butId = BUT_EDITOR_GRID_HEIGHT

		idx = guiFindBarButtonById(ed.gridBar, BUT_EDITOR_GRID_HEIGHT)
		guiSetButtonSelected(ed.gridBar.buts[idx], true)
		cdButtonAction(butId, ed.gfx.gridHeight)

	elseif butId = BUT_EDITOR_LINE_SIZE
		
		idx = guiFindBarButtonById(ed.sizeBar, BUT_EDITOR_LINE_SIZE)
		guiSetButtonSelected(ed.sizeBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, ed.gfx.lineSize)

	elseif butId = BUT_EDITOR_POLY_SIDES
		
		idx = guiFindBarButtonById(ed.shapeBar, BUT_EDITOR_POLY_SIDES)
		guiSetButtonSelected(ed.shapeBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, ed.gfx.polySides)

	elseif butId = BUT_EDITOR_TEXT_FONT
	
		idx = guiFindBarButtonById(ed.textBar, BUT_EDITOR_TEXT_FONT)
		guiSetButtonSelected(ed.textBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, ed.gfx.textFont)

	elseif butId = BUT_EDITOR_TEXT_SIZE
	
		idx = guiFindBarButtonById(ed.textBar, BUT_EDITOR_TEXT_SIZE)
		guiSetButtonSelected(ed.textBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, ed.gfx.textSize)

	elseif butId = BUT_EDITOR_TEXT_EDIT
	
		idx = guiFindBarButtonById(ed.textBar, BUT_EDITOR_TEXT_EDIT)
		guiSetButtonSelected(ed.textBar.buts[idx], true)
		ma.passedStrs.insert(ed.gfx.textEdit)
		idx = ma.passedStrs.length
		edSetBarsActive(false)
		cdButtonAction(butId, idx)

	elseif butId = BUT_EDITOR_TEXT_PLACE

		if ed.textButId > -1
			ed.textButId = -1
		else
			ed.textButId = BUT_EDITOR_TEXT_PLACE
			
		endif	
		
		edShowButtons()

	elseif butId = BUT_EDITOR_TEXT_PLACE_MID

		if ed.textButId > -1
			ed.textButId = -1
		else
			ed.textButId = BUT_EDITOR_TEXT_PLACE_MID
			
		endif	
		
		edShowButtons()

	elseif butId = BUT_EDITOR_IMAGE
	
		idx = guiFindBarButtonById(ed.imageBar, BUT_EDITOR_IMAGE)
		guiSetButtonSelected(ed.imageBar.buts[idx], true)
		edSetBarsActive(false)
		cdButtonAction(butId, idx)

	elseif butId = BUT_EDITOR_IMAGE_PLACE

		if ed.imageButId > -1
			ed.imageButId = -1
		else
			ed.imageButId = BUT_EDITOR_IMAGE_PLACE
			
		endif	
		
		edShowButtons()

	elseif butId = BUT_EDITOR_IMAGE_PLACE_MID

		if ed.imageButId > -1
			ed.imageButId = -1
		else
			ed.imageButId = BUT_EDITOR_IMAGE_PLACE_MID
			
		endif	
		
		edShowButtons()

	elseif butId = BUT_EDITOR_RECT

		ed.gfx.drawShape = CO_SHAPE_RECT
		edSaveSettings(BUT_EDITOR_RECT)
		edShowButtons()
 	
	elseif butId = BUT_EDITOR_OVAL
	
		ed.gfx.drawShape = CO_SHAPE_OVAL
		edSaveSettings(BUT_EDITOR_OVAL)
		edShowButtons()

 	elseif butId = BUT_EDITOR_POLY
	
		ed.gfx.drawShape = CO_SHAPE_POLY
		edSaveSettings(BUT_EDITOR_POLY)
		edShowButtons()

  	elseif butId = BUT_EDITOR_FILLED
			
		if ed.gfx.shapeFilled
			ed.gfx.shapeFilled = false
		else 
			ed.gfx.shapeFilled = true
		endif

		edSaveSettings(BUT_EDITOR_FILLED)		
		edShowButtons()

  	elseif butId = BUT_EDITOR_SAME_SIDES
			
		if ed.gfx.shapeSameWH
			ed.gfx.shapeSameWH = false
		else 
			ed.gfx.shapeSameWH = true
		endif

		edSaveSettings(BUT_EDITOR_SAME_SIDES)		
		edShowButtons()

	elseif butId = BUT_EDITOR_RECT_SEL

		ed.gfx.selShape = CO_SEL_RECT
		edSaveSettings(BUT_EDITOR_RECT_SEL)		
		edShowButtons()
 	
	elseif butId = BUT_EDITOR_OVAL_SEL
	
		ed.gfx.selShape = CO_SEL_OVAL
		edSaveSettings(BUT_EDITOR_OVAL_SEL)		
		edShowButtons()

 	elseif butId = BUT_EDITOR_DRAW_SEL
	
		ed.gfx.selShape = CO_SEL_FREE	
		edSaveSettings(BUT_EDITOR_DRAW_SEL)		
		edShowButtons()

 	elseif butId = BUT_EDITOR_LINE_SEL

		ed.gfx.selShape = CO_SEL_LINE
		edSaveSettings(BUT_EDITOR_LINE_SEL)		
		edFinishLineSel()		
		edShowButtons()

 	elseif butId = BUT_EDITOR_FILL_SEL

		ed.gfx.selShape = CO_SEL_FILL
		edSaveSettings(BUT_EDITOR_FILL_SEL)		

		//if ed.gfx.sel.filling
		//	ed.gfx.sel.filling = false
		//else
		//	ed.gfx.sel.filling = true
		//endif
		
		edShowButtons()

 	elseif butId = BUT_EDITOR_DESELECT

		ed.gfx.sel.active = false													
		edClearSel()
		edShowButtons()

	elseif butId = BUT_EDITOR_LINE_CIRC

		ed.gfx.lineStyle = CO_LINE_CIRC
		edSaveSettings(BUT_EDITOR_LINE_CIRC)		
		edShowButtons()
	 
	elseif butId = BUT_EDITOR_LINE_SQR 
		
		ed.gfx.lineStyle = CO_LINE_SQR
		edSaveSettings(BUT_EDITOR_LINE_SQR)		
		edShowButtons()

	else
		
		OnButtonAction(butId, 0)

	endif
		
endfunction

//-----------------------------------------------------
// Rotate a selection.
//
function edRotateSel(lt as integer)

	local w as float 
	local h as float 
	local max as float 
	local dx as float 
	local dy as float 
	local bounds as Bounds
	local destMb as MemBlock
				
	coMemGetBounds(ed.gfx.sel.sel, bounds)
	w = bounds.x1 - bounds.x0 + 1
	h = bounds.y1 - bounds.y0 + 1

	if w > h
		max = w
	else
		max = h
	endif

	dx = ceil((max - w) / 2)
	dy = ceil((max - h) / 2)

	// Grab square area, but selection only.
	bounds.x0 = bounds.x0 - dx
	bounds.y0 = bounds.y0 - dy			
	bounds.x1 = bounds.x0 + max - 1
	bounds.y1 = bounds.y0 + max - 1
	
	//coMemSetSel(ed.gfx.cols, ed.gfx.sel.sel)
	coMemGrab(ed.gfx.cols, destMb, bounds.x0, bounds.y0, max, max)
	//coMemRemoveSel(ed.gfx.cols)	
	edAddMbUndo(ED_CHG_MB2, destMb, bounds)
	coMemExtract(ed.gfx.cols, bounds, ed.gfx.sel.sel, destMb, true)
	coMemRotate(destMb, lt)
	coMemPaste(destMb, ed.gfx.cols, bounds.x0, bounds.y0)
	coMemDelete(destMb)

	//coMemSetSel(ed.gfx.sel.sel, ed.gfx.sel.sel)
	coMemGrab(ed.gfx.sel.sel, destMb, bounds.x0, bounds.y0, max, max)
	//coMemRemoveSel(ed.gfx.sel.sel)	
	edAddMbUndo(ED_CHG_MB2, destMb, bounds)
	coMemExtract(ed.gfx.sel.sel, bounds, ed.gfx.sel.sel, destMb, true)
	coMemRotate(destMb, lt)
	coMemPaste(destMb, ed.gfx.sel.sel, bounds.x0, bounds.y0)
	coMemDelete(destMb)

	ed.gfx.sel.dirty = true

endfunction

//-----------------------------------------------------
// Save settings.
//
function edSaveSettings(butId as integer)
	
	ld.set.editLineSize = ed.gfx.lineSize
	ld.set.editLineStyle = ed.gfx.lineStyle
	ld.set.editTextSize = ed.gfx.textSize
	ld.set.editDrawShape = ed.gfx.drawShape
	ld.set.editShapeSameWH = ed.gfx.shapeSameWH
	ld.set.editShapeFilled = ed.gfx.shapeFilled	
	ld.set.editPolySides = ed.gfx.polySides
	ld.set.editSelShape = ed.gfx.selShape
	ld.set.editSnapToGrid = ed.gfx.snapToGrid	
	ld.set.editGridWidth = ed.gfx.gridWidth
	ld.set.editGridHeight = ed.gfx.gridHeight
	ld.set.editCol = coColorToHex(ed.gfx.col)
	
	ldSaveSettings()
	
endfunction

//-----------------------------------------------------
// Set up erase mode.
//
function edSetEraseMode(mode as integer)
	
	ed.eraseButId = mode

	if ed.eraseButId = -1
				
		if ed.gfx.tmp.id
			coMemDelete(ed.gfx.tmp)
		endif
		
		//coMemSetUndo(ed.gfx.work, CO_NO_PIXEL)
		//coMemClearUndo(ed.gfx.work)
		
	else
				
		if not ed.gfx.tmp.id
			coMemCreate(ed.gfx.tmp, ed.gfx.cols.w, ed.gfx.cols.h)
		endif

		//coMemSetUndo(ed.gfx.work, CO_POST_PIXEL)

	endif	

endfunction

//-----------------------------------------------------
// Finish a line selection.
//
function edFinishLineSel()
	
	local bounds as Bounds
	local snap as integer
	
	if ed.gfx.sel.lining
		
		ed.gfx.sel.lining = false
		snap = coMemSnapPixels(ed.gfx.sel.sel, true)
		coMemDrawLine(ed.gfx.sel.sel, ed.gfx.pp.x, ed.gfx.pp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)		
		coMemSnapPixels(ed.gfx.sel.sel, snap)
		edClearWork()
		coMemGetBounds(ed.gfx.sel.sel, bounds)
		coMemSetBounds(ed.gfx.sel.sel, bounds)
		coMemFillLasso(ed.gfx.sel.sel, ed.gfx.sel.col)
		coMemResetBounds(ed.gfx.sel.sel)
		ed.gfx.sel.dirty = true
		
	endif

endfunction

//-----------------------------------------------------
// Finish a fill selection.
//
function edFinishFillSel()
	
	if ed.gfx.sel.filling		
		ed.gfx.sel.lining = false		
	endif

endfunction

//-----------------------------------------------------
// Call back from coder.
//
function edCallbackFromCoder(butId as integer, obj as integer)

	local idx as integer
	
	if butId = BUT_CODER_EDITOR_POS

		edSetSettingsEditorPosButton()
		//edShowButtons()
		
	elseif butId = BUT_EDITOR_COLOR

		ed.gfx.col = obj
		edSaveSettings(BUT_EDITOR_COLOR)
		idx = guiFindBarButtonById(ed.colBar, BUT_EDITOR_COLOR)
		guiSetButtonSelected(ed.colBar.buts[idx], false)
		//edShowButtons()

	elseif butId = BUT_EDITOR_LINE_SIZE

		edSetLineSize(obj)		
		edSaveSettings(BUT_EDITOR_LINE_SIZE)
		idx = guiFindBarButtonById(ed.sizeBar, BUT_EDITOR_LINE_SIZE)
		guiSetButtonSelected(ed.sizeBar.buts[idx], false)
		//edShowButtons()

	elseif butId = BUT_EDITOR_POLY_SIDES

		edSetPolySides(obj)		
		edSaveSettings(BUT_EDITOR_POLY_SIDES)
		idx = guiFindBarButtonById(ed.shapeBar, BUT_EDITOR_POLY_SIDES)
		guiSetButtonSelected(ed.shapeBar.buts[idx], false)
		//edShowButtons()

	elseif butId = BUT_EDITOR_TEXT_FONT

		edSetTextFont(obj)
		edSaveSettings(BUT_EDITOR_TEXT_FONT)
		edCreateText()		
		idx = guiFindBarButtonById(ed.textBar, BUT_EDITOR_TEXT_FONT)
		guiSetButtonSelected(ed.textBar.buts[idx], false)
		edShowButtons()

	elseif butId = BUT_EDITOR_TEXT_SIZE

		edSetTextSize(obj)
		edSaveSettings(BUT_EDITOR_TEXT_SIZE)
		edCreateText()		
		idx = guiFindBarButtonById(ed.textBar, BUT_EDITOR_TEXT_SIZE)
		guiSetButtonSelected(ed.textBar.buts[idx], false)
		edShowButtons()

	elseif butId = BUT_EDITOR_TEXT_EDIT

		ed.gfx.textEdit = ma.passedStrs[obj]
		ma.passedStrs.remove(obj)
		edCreateText()		
		idx = guiFindBarButtonById(ed.textBar, BUT_EDITOR_TEXT_EDIT)
		guiSetButtonSelected(ed.textBar.buts[idx], false)
		//edShowButtons()

	elseif butId = BUT_EDITOR_IMAGE

		ed.gfx.imageFile = ma.passedStrs[obj]
		ma.passedStrs.remove(obj)
		edCreateImage()	
		idx = guiFindBarButtonById(ed.imageBar, BUT_EDITOR_IMAGE)
		guiSetButtonSelected(ed.imageBar.buts[idx], false)
		//edSetBarsActive(true)
		//edShowButtons()

	elseif butId = BUT_EDITOR_RESIZE

		edResizeImage(obj)	
		idx = guiFindBarButtonById(ed.resizeBar, BUT_EDITOR_RESIZE)
		guiSetButtonSelected(ed.resizeBar.buts[idx], false)
		//edSetBarsActive(true)
		//edShowButtons()

	elseif butId = BUT_EDITOR_GRID_ROWS

		edSetGridRows(obj	)
		edSaveSettings(BUT_EDITOR_GRID_ROWS)
		idx = guiFindBarButtonById(ed.gridBar, BUT_EDITOR_GRID_ROWS)
		guiSetButtonSelected(ed.gridBar.buts[idx], false)
	
	elseif butId = BUT_EDITOR_GRID_COLS

		edSetGridCols(obj	)
		edSaveSettings(BUT_EDITOR_GRID_COLS)
		idx = guiFindBarButtonById(ed.gridBar, BUT_EDITOR_GRID_COLS)
		guiSetButtonSelected(ed.gridBar.buts[idx], false)

	elseif butId = BUT_EDITOR_GRID_WIDTH

		edSetGridWidth(obj)
		edSaveSettings(BUT_EDITOR_GRID_WIDTH)
		idx = guiFindBarButtonById(ed.gridBar, BUT_EDITOR_GRID_WIDTH)
		guiSetButtonSelected(ed.gridBar.buts[idx], false)
	
	elseif butId = BUT_EDITOR_GRID_HEIGHT

		edSetGridHeight(obj)
		edSaveSettings(BUT_EDITOR_GRID_HEIGHT)
		idx = guiFindBarButtonById(ed.gridBar, BUT_EDITOR_GRID_HEIGHT)
		guiSetButtonSelected(ed.gridBar.buts[idx], false)

	elseif butId = BUT_EDITOR_CANCEL_EDIT

		if obj = BUT_EDITOR_COLOR
	
			idx = guiFindBarButtonById(ed.colBar, BUT_EDITOR_COLOR)
			guiSetButtonSelected(ed.colBar.buts[idx], false)
			//edShowButtons()

		elseif obj = BUT_EDITOR_LINE_SIZE
	
			idx = guiFindBarButtonById(ed.sizeBar, BUT_EDITOR_LINE_SIZE)
			guiSetButtonSelected(ed.sizeBar.buts[idx], false)
			//edShowButtons()

		elseif obj = BUT_EDITOR_POLY_SIDES
	
			idx = guiFindBarButtonById(ed.shapeBar, BUT_EDITOR_POLY_SIDES)
			guiSetButtonSelected(ed.shapeBar.buts[idx], false)
			//edShowButtons()
				
		elseif obj = BUT_EDITOR_TEXT_SIZE
	
			idx = guiFindBarButtonById(ed.textBar, BUT_EDITOR_TEXT_SIZE)
			guiSetButtonSelected(ed.textBar.buts[idx], false)
			//edShowButtons()
	
		elseif obj = BUT_EDITOR_GRID_ROWS
	
			idx = guiFindBarButtonById(ed.gridBar, obj)
			guiSetButtonSelected(ed.gridBar.buts[idx], false)
			//edShowButtons()
		
		elseif obj = BUT_EDITOR_GRID_COLS

			idx = guiFindBarButtonById(ed.gridBar, obj)
			guiSetButtonSelected(ed.gridBar.buts[idx], false)
			//edShowButtons()

		elseif obj = BUT_EDITOR_GRID_WIDTH
	
			idx = guiFindBarButtonById(ed.gridBar, obj)
			guiSetButtonSelected(ed.gridBar.buts[idx], false)
			//edShowButtons()
		
		elseif obj = BUT_EDITOR_GRID_HEIGHT

			idx = guiFindBarButtonById(ed.gridBar, obj)
			guiSetButtonSelected(ed.gridBar.buts[idx], false)
			//edShowButtons()

		elseif obj = BUT_EDITOR_IMAGE

			idx = guiFindBarButtonById(ed.imageBar, BUT_EDITOR_IMAGE)
			guiSetButtonSelected(ed.imageBar.buts[idx], false)

		elseif obj = BUT_EDITOR_RESIZE

			idx = guiFindBarButtonById(ed.resizeBar, BUT_EDITOR_RESIZE)
			guiSetButtonSelected(ed.resizeBar.buts[idx], false)
			
		endif

	endif

	edSetBarsActive(true)
	edShowButtons()

endfunction

//-----------------------------------------------------
// Create the text for rendering.
//
function edCreateText()
	
	local s as string
	local mw as integer
	local mh as integer
	local size as integer
	
	mw = co.bs * 5
	mh = co.bs + co.bs / 2
	
	if ed.text
		
		deletetext(ed.text)
		ed.text = 0

	endif
			
	if ed.gfx.text
		
		deletetext(ed.gfx.text)
		ed.gfx.text = 0
		
	endif
	
	if ed.gfx.textEdit <> ""
				
		s = ed.gfx.textEdit
		
		ed.text = guiCreateText2(s, ed.gfx.textSize) // co.fontSizes[ed.gfx.textSize]) // 3
		coSetTextFont(ed.text, ed.gfx.textFont)

		if GetTextTotalHeight(ed.text) > mh
			
			size = ed.gfx.textSize
			
			while GetTextTotalHeight(ed.text) > mh

				size = size - 10
				SetTextSize(ed.text, size)
			
			endwhile
			
		endif
		
		if GetTextTotalWidth(ed.text) > mw
			
			settextstring(ed.text, s + "...")
					
			while GetTextTotalWidth(ed.text) > mw
				
				s = left(s, len(s) - 1) // Remove a char.
				settextstring(ed.text, s + "...")
				
			endwhile
			
		endif
		
		settextalignment(ed.text, 0)
		coSetTextColor(ed.text, ed.gfx.col)
		SetTextVisible(ed.text, false)
		
		ed.gfx.text = guiCreateText2(ed.gfx.textEdit, ed.gfx.textSize)
		coSetTextFont(ed.text, ed.gfx.textFont)
		settextalignment(ed.gfx.text, 0)
		coSetTextColor(ed.gfx.text, ed.gfx.col)
		SetTextVisible(ed.gfx.text, false)
						
	endif

endfunction		

//-----------------------------------------------------
// Create the image for rendering.
//
function edCreateImage()

	local img as integer
	local b as float
	local w as float
	local h as float
	local sc as float

	if ed.imageSpr
		
		img = GetSpriteImageID(ed.imageSpr)
		deletesprite(ed.imageSpr)
		ed.imageSpr = 0
		
		if img
			deleteimage(img)
		endif
		
	endif

	if ed.gfx.image.id		
		coMemDelete(ed.gfx.image)
	endif
					
	if ed.gfx.imageFile <> ""
					
		img = loadimage(ed.gfx.imageFile)
		coMemFromImage(img, ed.gfx.image)
		ed.imageSpr = CreateSprite(img)
		
		b = co.bs - co.bs / 16 // GetSpriteWidth(libItem.bg) - co.bs / 8
		w = GetSpriteWidth(ed.imageSpr)
		h = GetSpriteHeight(ed.imageSpr)
		sc = 1.0

		if h > w
			if h > b
				sc = b / h
			endif
		else //if w > h
			if w > b
				sc = b / w
			endif
		endif

		SetSpriteScaleByOffset(ed.imageSpr, sc, sc)
		SetSpriteVisible(ed.imageSpr, false)
	
	endif

endfunction

//-----------------------------------------------------
// The new image.
//
function edResizeImage(img as integer)
	
	local oldImg as integer
	
	oldImg = coMemToImage(ed.gfx.cols)
	edAddImgUndo(oldImg)
	
	edReset(img)
	
endfunction

//-----------------------------------------------------
// Set the poly size.
//
function edSetPolySides(sides as integer)

	if sides < ED_POLY_SIDES_MIN
		sides = ED_POLY_SIDES_MIN
	elseif sides > ED_POLY_SIDES_MAX
		sides = ED_POLY_SIDES_MAX
	endif
	
	ed.gfx.polySides = sides
	
endfunction

//-----------------------------------------------------
// Set the line style, i.e. circ, sqr.
//
function edSetLineStyle(lineStyle as integer)
	
	if lineStyle = CO_LINE_SQR or lineStyle = CO_LINE_CIRC
		ed.gfx.lineStyle = lineStyle
	else 
		ed.gfx.lineStyle = CO_LINE_CIRC
	endif
	
endfunction

//-----------------------------------------------------
// Set the draw shape.
//
function edSetDrawShape(drawShape as integer)
	
	if drawShape = CO_SHAPE_RECT or drawShape = CO_SHAPE_OVAL or drawShape = CO_SHAPE_POLY
		ed.gfx.drawShape = drawShape
	else 
		ed.gfx.drawShape = CO_SHAPE_RECT
	endif

endfunction

//-----------------------------------------------------
// Set the select shape.
//
function edSetSelShape(selShape as integer)

	if selShape = CO_SEL_RECT or selShape = CO_SEL_OVAL or selShape = CO_SEL_FREE or selShape = CO_SEL_LINE or selShape = CO_SEL_FILL
		ed.gfx.selShape = selShape
	else 
		ed.gfx.selShape = CO_SEL_RECT
	endif

endfunction

//-----------------------------------------------------
// Set the line size.
//
function edSetLineSize(size as integer)

	if size < 1
		size = 1
	elseif size > ED_LINE_SIZE_MAX
		size = ED_LINE_SIZE_MAX
	endif
	
	ed.gfx.lineSize = size		

endfunction

//-----------------------------------------------------
// Set the text font.
//
function edSetTextFont(font as integer)

	if font < 0
		font = 0
	elseif font > co.fonts.length
		font = co.fonts.length
	endif
	
	ed.gfx.textFont = font		

endfunction

//-----------------------------------------------------
// Set the text size.
//
function edSetTextSize(size as integer)

	if size < LD_TEXT_SIZE_MIN
		size = LD_TEXT_SIZE_MIN
	elseif size > LD_TEXT_SIZE_MAX
		size = LD_TEXT_SIZE_MAX
	endif
	
	ed.gfx.textSize = size		

endfunction

//-----------------------------------------------------
// Set the grid width.
//
function edSetGridWidth(width as integer)

	if width < 2
		width = 2
	elseif width > ed.gfx.cols.w
		width = ed.gfx.cols.w
	endif
	
	ed.gfx.gridWidth = width	
	ed.gfx.gridDirty = true

endfunction

//-----------------------------------------------------
// Set the grid height.
//
function edSetGridHeight(height as integer)

	if height < 2
		height = 2
	elseif height > ed.gfx.cols.h
		height = ed.gfx.cols.h
	endif
	
	ed.gfx.gridHeight = height	
	ed.gfx.gridDirty = true

endfunction

//-----------------------------------------------------
// Set the grid rows.
//
function edSetGridRows(rows as integer)

	ed.gfx.gridRows = rows
	
	if ed.gfx.gridRows < 1
		ed.gfx.gridRows = 1
	elseif ed.gfx.gridRows > ED_GRID_ROWS_MAX
		ed.gfx.gridRows = ED_GRID_ROWS_MAX
	endif
	
	ed.gfx.gridHeight = ed.gfx.cols.h / ed.gfx.gridRows
	ed.gfx.gridDirty = true

endfunction

//-----------------------------------------------------
// Set the grid cols.
//
function edSetGridCols(cols as integer)

	ed.gfx.gridCols = cols
	
	if ed.gfx.gridCols < 1
		ed.gfx.gridCols = 1
	elseif ed.gfx.gridCols > ED_GRID_COLS_MAX
		ed.gfx.gridCols = ED_GRID_COLS_MAX
	endif
	
	ed.gfx.gridWidth = ed.gfx.cols.w / ed.gfx.gridCols
	ed.gfx.gridDirty = true

endfunction

//-----------------------------------------------------
// Set the line but to butId.
//
function edSetLineButton()

	local idx as integer
	local but1Id as integer
	local but2Id as integer

	if ed.butId = BUT_EDITOR_DRAW or ed.butId = BUT_EDITOR_LINE
			
		if ed.gfx.lineStyle = CO_LINE_CIRC
			
			but1Id = BUT_EDITOR_LINE_CIRC
			but2Id = BUT_EDITOR_LINE_SQR
			
		else
			
			but1Id = BUT_EDITOR_LINE_SQR
			but2Id = BUT_EDITOR_LINE_CIRC

		endif
				
		idx = guiFindBarButtonById(ed.linebar, but1Id)		
		
		if not guiGetButtonSelected(ed.lineBar.buts[idx])
			guiSetButtonSelected(ed.linebar.buts[idx], true)
		endif
	
		idx = guiFindBarButtonById(ed.linebar, but2Id)	
		guiSetButtonSelected(ed.linebar.buts[idx], false)

	endif
	
endfunction

//-----------------------------------------------------
// Set the shape but to butId.
//
function edSetShapeButton()

	local idx as integer
	local idx2 as integer
	local i as integer
	local shapeButId as integer
	local tmpShapeButId as integer

	if ed.butId = BUT_EDITOR_SHAPE
			
		shapeButId = edDrawShapeToBut(ed.gfx.drawShape)
					
		idx = guiFindBarButtonById(ed.shapebar, shapeButId)			
		guiSetButtonSelected(ed.shapebar.buts[idx], true)
	
		for i = 0 to ed.shapeBar.buts.length
			
			tmpShapeButId = ed.shapeBar.buts[i].id
			
			if tmpShapeButId = BUT_EDITOR_RECT or tmpShapeButId = BUT_EDITOR_OVAL or tmpShapeButId = BUT_EDITOR_POLY
				if tmpShapeButId <> shapeButId // ed.tmpShapeButId
					guiSetButtonSelected(ed.shapeBar.buts[i], false)
				endif
			endif
				
		next
	
		idx = guiFindBarButtonById(ed.shapebar, BUT_EDITOR_SAME_SIDES)		

		//if ed.sameButId > -1
		if ed.gfx.shapeSameWH
			guiSetButtonSelected(ed.shapebar.buts[idx], true)
		else
			guiSetButtonSelected(ed.shapebar.buts[idx], false)
		endif

		//if ed.shapeButId = BUT_EDITOR_RECT
		if ed.gfx.drawShape = CO_SHAPE_RECT
			
			//if ed.sameButId = -1
			if not ed.gfx.shapeSameWH
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.rectIconImg)
			else
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.squareIconImg)
			endif
			
		//elseif ed.shapeButId = BUT_EDITOR_OVAL
		elseif ed.gfx.drawShape = CO_SHAPE_OVAL
			
			//if ed.sameButId = -1
			if not ed.gfx.shapeSameWH
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.ovalIconImg)
			else
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.circleIconImg)
			endif
			
		//elseif ed.shapeButId = BUT_EDITOR_POLY
		elseif ed.gfx.drawShape = CO_SHAPE_POLY

			//if ed.sameButId = -1	
			if not ed.gfx.shapeSameWH		
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.polyIconImg)
			else 
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.triIconImg)
			endif
			
		endif

		idx = guiFindBarButtonById(ed.shapebar, BUT_EDITOR_FILLED)		

		//if ed.filledButId > -1
		if ed.gfx.shapeFilled
			guiSetButtonSelected(ed.shapebar.buts[idx], true)
		else
			guiSetButtonSelected(ed.shapebar.buts[idx], false)
		endif
							
		//if ed.shapeButId = BUT_EDITOR_RECT
		if ed.gfx.drawShape = CO_SHAPE_RECT
			
			//if ed.sameButId = -1
			if not ed.gfx.shapeSameWH
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledRectIconImg)
			else
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledSquareIconImg)
			endif
			
		//elseif ed.shapeButId = BUT_EDITOR_OVAL
		elseif ed.gfx.drawShape = CO_SHAPE_OVAL

			//if ed.sameButId = -1
			if not ed.gfx.shapeSameWH
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledOvalIconImg)
			else
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledCircleIconImg)
			endif
			
		//elseif ed.shapeButId = BUT_EDITOR_POLY
		elseif ed.gfx.drawShape = CO_SHAPE_POLY

			//if ed.sameButId = -1		
			if not ed.gfx.shapeSameWH	
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledPolyIconImg)
			else 
				guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledTriIconImg)
			endif
			
		endif

		idx = guiFindBarButtonById(ed.shapebar, BUT_EDITOR_RECT)		
		
		//if ed.sameButId > -1 and ed.filledButId > -1
		if ed.gfx.shapeSameWH and ed.gfx.shapeFilled
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledSquareIconImg)
		//elseif ed.sameButId > -1
		elseif ed.gfx.shapeSameWH
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.squareIconImg)
		//elseif ed.filledButId > -1
		elseif ed.gfx.shapeFilled
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledRectIconImg)
		else
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.rectIconImg)
		endif
			
		idx = guiFindBarButtonById(ed.shapebar, BUT_EDITOR_OVAL)		
	
		//if ed.sameButId > -1 and ed.filledButId > -1
		if ed.gfx.shapeSameWH and ed.gfx.shapeFilled
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledCircleIconImg)
		//elseif ed.sameButId > -1
		elseif ed.gfx.shapeSameWH
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.circleIconImg)
		//elseif ed.filledButId > -1
		elseif ed.gfx.shapeFilled
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledOvalIconImg)
		else
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.ovalIconImg)
		endif
		
		idx = guiFindBarButtonById(ed.shapebar, BUT_EDITOR_POLY)		

		//if ed.sameButId > -1 and ed.filledButId > -1	
		if ed.gfx.shapeSameWH and ed.gfx.shapeFilled
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledTriIconImg)
		//elseif ed.sameButId > -1
		elseif ed.gfx.shapeSameWH
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.triIconImg)
		//elseif ed.filledButId > -1	
		elseif ed.gfx.shapeFilled
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.filledPolyIconImg)
		else 
			guiSetButtonIcon(ed.shapeBar.buts[idx], ed.polyIconImg)
		endif
								
	endif
	
endfunction

//-----------------------------------------------------
// Set the sel shape but to butId.
//
function edSetSelShapeButton()

	local idx as integer
	local idx2 as integer
	local i as integer
	local shapeButId as integer
	local tmpShapeButId as integer

	if ed.butId = BUT_EDITOR_SELECT

		idx = guiFindBarButtonById(ed.selShapeBar, BUT_EDITOR_DESELECT)
		guiSetButtonActive(ed.selShapeBar.buts[idx], ed.gfx.sel.active)

		shapeButId = edSelShapeToBut(ed.gfx.selShape)		
		//idx = guiFindBarButtonById(ed.selshapebar, ed.selShapeButId)			
		idx = guiFindBarButtonById(ed.selshapebar, shapeButId)			
		guiSetButtonSelected(ed.selshapebar.buts[idx], true)
	
		//if ed.selShapeButId = BUT_EDITOR_LINE_SEL
		if shapeButId = BUT_EDITOR_LINE_SEL
			if ed.gfx.sel.lining
				guiSetButtonBgSel(ed.selshapebar.buts[idx], true, ed.toggleButCol)
			else
				guiSetButtonBgSel(ed.selshapebar.buts[idx], true, ed.selButCol)
			endif		
		//elseif ed.selShapeButId = BUT_EDITOR_FILL_SEL
		elseif shapeButId = BUT_EDITOR_FILL_SEL
			if ed.gfx.sel.filling
				guiSetButtonBgSel(ed.selshapebar.buts[idx], true, ed.toggleButCol)
			else
				guiSetButtonBgSel(ed.selshapebar.buts[idx], true, ed.selButCol)
			endif
		endif

		for i = 0 to ed.selshapeBar.buts.length
			
			tmpShapeButId = ed.selShapeBar.buts[i].id
			
			if tmpShapeButId = BUT_EDITOR_RECT_SEL or tmpShapeButId = BUT_EDITOR_OVAL_SEL or tmpShapeButId = BUT_EDITOR_DRAW_SEL or tmpShapeButId = BUT_EDITOR_LINE_SEL or tmpShapeButId = BUT_EDITOR_FILL_SEL
				if tmpShapeButId <> shapeButId // ed.selShapeButId
					guiSetButtonSelected(ed.selshapeBar.buts[i], false)
				endif
			endif
				
		next
					
	endif
	
endfunction

//-----------------------------------------------------
// Convert a sel shape to button.
//
function edSelShapeToBut(selShape as integer)
	
	local shapeButId as integer
	
	if selShape = CO_SEL_RECT
		shapeButId = BUT_EDITOR_RECT_SEL
	elseif selShape = CO_SEL_OVAL
		shapeButId = BUT_EDITOR_OVAL_SEL
	elseif selShape = CO_SEL_FREE
		shapeButId = BUT_EDITOR_DRAW_SEL
	elseif selShape = CO_SEL_LINE
		shapeButId = BUT_EDITOR_LINE_SEL
	elseif selShape = CO_SEL_FILL
		shapeButId = BUT_EDITOR_FILL_SEL
	else 
		shapeButId = BUT_EDITOR_RECT_SEL
	endif
	
endfunction shapeButId
	
//-----------------------------------------------------
// Convert a draw shape to a but.
//
function edDrawShapeToBut(drawShape as integer)
	
	local shapeButId as integer
	
	if drawShape = CO_SHAPE_RECT
		shapeButId = BUT_EDITOR_RECT
	elseif drawShape = CO_SHAPE_OVAL
		shapeButId = BUT_EDITOR_OVAL
	elseif drawShape = CO_SHAPE_POLY
		shapeButId = BUT_EDITOR_POLY
	else 
		shapeButId = BUT_EDITOR_RECT
	endif
	
endfunction shapeButId

//-----------------------------------------------------
// Set the color button.
//
function edSetColorButton()

	local idx as integer
		
	idx = guiFindBarButtonById(ed.colbar, BUT_EDITOR_COLOR)
	coSetSpriteColor(ed.colbar.buts[idx].icon2, ed.gfx.col)	
	
	idx = guiFindBarButtonById(ed.colbar, BUT_EDITOR_PICKER)		

	if ed.pickerButId > -1
		guiSetButtonSelected(ed.colbar.buts[idx], true)
	else
		guiSetButtonSelected(ed.colbar.buts[idx], false)
	endif

	idx = guiFindBarButtonById(ed.colbar, BUT_EDITOR_ERASE)		

	if ed.eraseButId > -1
		guiSetButtonSelected(ed.colbar.buts[idx], true)
	else
		guiSetButtonSelected(ed.colbar.buts[idx], false)
	endif

endfunction

//-----------------------------------------------------
// Set the color button.
//
function edSetSelButton()

	local idx as integer

	idx = guiFindBarButtonById(ed.selBar, BUT_EDITOR_CUT)
	guiSetButtonActive(ed.selBar.buts[idx], ed.gfx.sel.active)
	idx = guiFindBarButtonById(ed.selBar, BUT_EDITOR_COPY)
	guiSetButtonActive(ed.selBar.buts[idx], ed.gfx.sel.active)
	idx = guiFindBarButtonById(ed.selBar, BUT_EDITOR_PASTE)
	guiSetButtonActive(ed.selBar.buts[idx], ed.gfx.copy.id)
		
	idx = guiFindBarButtonById(ed.selbar, BUT_EDITOR_PASTE)

	if ed.pasteButId > -1
		guiSetButtonSelected(ed.selbar.buts[idx], true)
	else
		guiSetButtonSelected(ed.selbar.buts[idx], false)
	endif

endfunction

//-----------------------------------------------------
// Set a size button.
//
function edSetSizeButton()

	local idx as integer

	if ed.butId = BUT_EDITOR_DRAW
				
		idx = guiFindBarButtonById(ed.sizebar, BUT_EDITOR_LINE_SIZE)
		guiSetButtonText(ed.sizebar.buts[idx], "size (" + str(ed.gfx.lineSize) + ")")

	elseif ed.butId = BUT_EDITOR_LINE
				
		idx = guiFindBarButtonById(ed.sizebar, BUT_EDITOR_LINE_SIZE)
		guiSetButtonText(ed.sizebar.buts[idx], "size (" + str(ed.gfx.lineSize) + ")")
		
	elseif ed.butId = BUT_EDITOR_SHAPE
				
		idx = guiFindBarButtonById(ed.sizebar, BUT_EDITOR_LINE_SIZE)
		guiSetButtonText(ed.sizebar.buts[idx], "size (" + str(ed.gfx.lineSize) + ")")
		idx = guiFindBarButtonById(ed.shapebar, BUT_EDITOR_POLY_SIDES)
		guiSetButtonText(ed.shapebar.buts[idx], "sides (" + str(ed.gfx.polySides) + ")")
		
	elseif ed.butId = BUT_EDITOR_TEXT
				
		idx = guiFindBarButtonById(ed.textbar, BUT_EDITOR_TEXT_SIZE)
		guiSetButtonText(ed.textbar.buts[idx], "size (" + str(ed.gfx.textSize) + ")")

		idx = guiFindBarButtonById(ed.textbar, BUT_EDITOR_TEXT_FONT)
		guiSetButtonText(ed.textbar.buts[idx], coGetFontName(co.fonts[ed.gfx.textFont]) + ")")

	endif

endfunction

//-----------------------------------------------------
// Set text buttons.
//
function edSetTextButton()
	
	local idx as integer
	local x as float
	local y as float
	local w as float
	local h as float

	if ed.butId = BUT_EDITOR_TEXT
		
		idx = guiFindBarButtonById(ed.textbar, BUT_EDITOR_TEXT_PLACE)
		guiSetButtonSelected(ed.textbar.buts[idx], ed.textButId = BUT_EDITOR_TEXT_PLACE)
		guiSetButtonActive(ed.textbar.buts[idx], ed.gfx.text)

		idx = guiFindBarButtonById(ed.textbar, BUT_EDITOR_TEXT_PLACE_MID)
		guiSetButtonSelected(ed.textbar.buts[idx], ed.textButId = BUT_EDITOR_TEXT_PLACE_MID)
		guiSetButtonActive(ed.textbar.buts[idx], ed.gfx.text)
		
		if ed.text
			
			x = getspritexbyoffset(ed.textbar.buts[idx].bg)
			y = getspriteybyoffset(ed.textbar.buts[idx].bg)
			w = getspritewidth(ed.textbar.buts[idx].bg)
			h = getspriteheight(ed.textbar.buts[idx].bg)
			SetTextPosition(ed.text, x + w / 2 + co.bs / 8, y - GetTextTotalHeight(ed.text) / 2)
			SetTextVisible(ed.text, true)
	
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Set image buttons.
//
function edSetImageButton()
	
	local idx as integer
	local x as float
	local y as float
	local w as float
	
	if ed.butId = BUT_EDITOR_IMAGE
		
		idx = guiFindBarButtonById(ed.imagebar, BUT_EDITOR_IMAGE_PLACE)	
		guiSetButtonSelected(ed.imagebar.buts[idx], ed.imageButId = BUT_EDITOR_IMAGE_PLACE)
		guiSetButtonActive(ed.imagebar.buts[idx], ed.gfx.image.id)

		idx = guiFindBarButtonById(ed.imagebar, BUT_EDITOR_IMAGE_PLACE_MID)	
		guiSetButtonSelected(ed.imagebar.buts[idx], ed.imageButId = BUT_EDITOR_IMAGE_PLACE_MID)
		guiSetButtonActive(ed.imagebar.buts[idx], ed.gfx.image.id)
		
		if ed.imageSpr
			
			x = getspritexbyoffset(ed.imagebar.buts[idx].bg)
			y = getspriteybyoffset(ed.imagebar.buts[idx].bg)
			w = getspritewidth(ed.imagebar.buts[idx].bg)
			SetSpritePositionByOffset(ed.imageSpr, x + w + co.bs / 16, y)
			SetSpriteVisible(ed.imageSpr, true)
				
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Set grid row/col buttons.
//
function edSetGridButton()

	local idx as integer

	idx = guiFindBarButtonById(ed.gridbar, BUT_EDITOR_GRID_SNAP)	
	//guiSetButtonSelected(ed.gridbar.buts[idx], ed.gridButId > -1)
	guiSetButtonSelected(ed.gridbar.buts[idx], ed.gfx.snapToGrid)
	//idx = guiFindBarButtonById(ed.gridbar, BUT_EDITOR_GRID_COLS)
	//guiSetButtonText(ed.gridbar.buts[idx], "cols (" + str(ed.gfx.gridCols) + ")")
	//idx = guiFindBarButtonById(ed.gridbar, BUT_EDITOR_GRID_ROWS)
	//guiSetButtonText(ed.gridbar.buts[idx], "rows (" + str(ed.gfx.gridRows) + ")")
	idx = guiFindBarButtonById(ed.gridbar, BUT_EDITOR_GRID_WIDTH)
	guiSetButtonText(ed.gridbar.buts[idx], "w (" + str(ed.gfx.gridWidth) + ")")
	idx = guiFindBarButtonById(ed.gridbar, BUT_EDITOR_GRID_HEIGHT)
	guiSetButtonText(ed.gridbar.buts[idx], "h (" + str(ed.gfx.gridHeight) + ")")
	
endfunction

//-----------------------------------------------------
// Set the editor button in settings to the current setting value.
//
function edSetSettingsEditorPosButton()

	local idx as integer

	idx = guiFindBarButtonById(ed.moreBar, BUT_CODER_EDITOR_POS)

	if ld.set.editorButPos = DIR_NE

		SetSpriteAngle(ed.morebar.buts[idx].icon, -135)
		//guiSetButtonText(de.morebar.buts[idx], "top-right")
		ed.morebar.buts[idx].help = "Tap to change the position of menu to bottom-right."
		
	elseif ld.set.editorButPos = DIR_NW

		SetSpriteAngle(ed.morebar.buts[idx].icon, 135)
		//guiSetButtonText(de.morebar.buts[idx], "top-left")
		ed.morebar.buts[idx].help = "Tap to change the position of menu to top-right."

	elseif ld.set.editorButPos = DIR_SE

		SetSpriteAngle(ed.morebar.buts[idx].icon, -45)
		//guiSetButtonText(de.morebar.buts[idx], "bot-right")
		ed.morebar.buts[idx].help = "Tap to change the position of menu to bottom-left."

	elseif ld.set.editorButPos = DIR_SW

		SetSpriteAngle(ed.morebar.buts[idx].icon, 45)
		//guiSetButtonText(de.morebar.buts[idx], "bot-left")
		ed.morebar.buts[idx].help = "Tap to change the position of menu to top-left."

	endif

endfunction

//-----------------------------------------------------
// Convert press point to gfx point.
//
function edPressPointToGfx(press ref as Point, gfx ref as Point)

	local ox as float
	local oy as float
	
	ox = press.x - ed.gfx.x0 - ed.gfx.offX - ed.gfx.drawX - ed.gfx.padX
	oy = press.y - ed.gfx.y0 - ed.gfx.offY - ed.gfx.drawY - ed.gfx.padY
		
	if ed.gfx.zoom > 0
		
		gfx.x = floor(ox / ed.gfx.zoom)
		gfx.y = floor(oy / ed.gfx.zoom)

	else
		
		gfx.x = floor(ox / 0.00001)
		gfx.y = floor(oy / 0.00001)
		
	endif
			
endfunction

//-----------------------------------------------------
// Convert press point to gfx point.
//
function edSnapPointToGrid(gfx ref as Point)

	local dx as integer
	local dy as integer

	if ed.gfx.snapToGrid
		
		dx = gfx.x / ed.gfx.gridWidth
		gfx.x = ed.gfx.gridWidth * dx
		dy = gfx.y / ed.gfx.gridHeight
		gfx.y = ed.gfx.gridHeight * dy
		
	endif

endfunction

//-----------------------------------------------------
// Set the pressed point for a gfx operation.
//
function edGfxPressed(x as float, y as float, snap as integer)

	ed.gfx.sp.x = x
	ed.gfx.sp.y = y
	edPressPointToGfx(ed.gfx.sp, ed.gfx.sp)	
	if snap then edSnapPointToGrid(ed.gfx.sp)
	ed.gfx.pp.x = ed.gfx.sp.x
	ed.gfx.pp.y = ed.gfx.sp.y
	ed.gfx.ep.x = ed.gfx.sp.x
	ed.gfx.ep.y = ed.gfx.sp.y
		
endfunction

//-----------------------------------------------------
// Handle the gfx move.
//
function edGfxMoved(x as float, y as float)

	//ed.gfx.sp.x = ed.gfx.pp.x // Reset so calc below works.
	//ed.gfx.sp.y = ed.gfx.pp.y
	ed.gfx.ep.x = x
	ed.gfx.ep.y = y
	edPressPointToGfx(ed.gfx.ep, ed.gfx.ep)
	edSnapPointToGrid(ed.gfx.ep)

endfunction

//-----------------------------------------------------
// Correct snap to fit with a selection box.
// If fix is true, then won't allow single pixel snap.
//
function edCorrectSnap(b ref as Bounds, fix as integer)

	if ed.gfx.snapToGrid
		
		if b.x1 > b.x0
			if mod(b.x0, ed.gfx.gridWidth) <> 0 // Not aligned, fix to grid.
				b.x0 = b.x0 - 1
			endif
			if mod(b.x1, ed.gfx.gridWidth) = 0 // Aligned to grid, move back 1 pixel.
				b.x1 = b.x1 - 1
			endif
		elseif b.x1 < b.x0
			if mod(b.x0, ed.gfx.gridWidth) = 0 
				b.x0 = b.x0 - 1
			endif
			if mod(b.x1, ed.gfx.gridWidth) <> 0
				b.x1 = b.x1 - 1
			endif
		elseif fix 
			b.y1 = b.y0
		endif
		
		if b.y1 > b.y0
			if mod(b.y0, ed.gfx.gridWidth) <> 0 // Not aligned, fix to grid.
				b.y0 = b.y0 - 1
			endif
			if mod(b.y1, ed.gfx.gridWidth) = 0 // Aligned to grid, move back 1 pixel.
				b.y1 = b.y1 - 1
			endif
		elseif b.y1 < b.y0
			if mod(b.y0, ed.gfx.gridWidth) = 0 
				b.y0 = b.y0 - 1
			endif
			if mod(b.y1, ed.gfx.gridWidth) <> 0
				b.y1 = b.y1 - 1
			endif
		elseif fix 
			b.x1 = b.x0
		endif
		
		//colog("sx=" + str(ed.gfx.sp.x) + ", sy=" + str(ed.gfx.sp.y) + ", ex=" + str(ed.gfx.ep.x) + ", ey=" + str(ed.gfx.ep.y))
				
	endif
	
endfunction

//-----------------------------------------------------
// Handle the gfx release.
//
function edGfxReleased(x as float, y as float)
	
endfunction

//-----------------------------------------------------
// Make sure sp is less that ep coords.
//
function edSwapCoords(sp ref as Point, ep ref as Point)

	local t as integer
	
	if sp.x > ep.x
		
		t = sp.x
		sp.x = ep.x
		ep.x = t
		
	endif

	if sp.y > ep.y
		
		t = sp.y
		sp.y = ep.y
		ep.y = t
		
	endif
	
endfunction

//-----------------------------------------------------
// Clear the work area.
//
function edClearWork()
	
	coMemClear(ed.gfx.work)
	ed.gfx.workDirty = true // Cleared.
	
endfunction

//-----------------------------------------------------
// Clear the sel.
//
function edClearSel()
	
	coMemClear(ed.gfx.sel.sel)
	coMemRemoveSel(ed.gfx.work)
	ed.gfx.sel.dirty = true // Cleared.
	
endfunction

//-----------------------------------------------------
// Paste the work area over the cols.
//
function edPasteWork()
	
	local blend as integer
	local undo as integer

	undo = coMemSetUndo(ed.gfx.cols, CO_PRE_PIXEL)
	
	if ed.eraseButId > -1
		
		blend = coMemSetBlend(ed.gfx.cols, false)
		coMemApplyPixels(ed.gfx.work, ed.gfx.cols, CO_COL_CLEAR)
		coMemSetBlend(ed.gfx.cols, blend)

	else
		
		coMemApplyPixels(ed.gfx.work, ed.gfx.cols, 0)
		//coMemPasteNez(ed.gfx.work, ed.gfx.cols, 0, 0)
		
	endif
	
	coMemSetUndo(ed.gfx.cols, undo)
	coMemClear(ed.gfx.work)
	
	ed.gfx.drawDirty = true // Pasted on.
	ed.gfx.workDirty = true // Cleared.
	
endfunction

//-----------------------------------------------------
// Set the zoom level.
//
function edSetZoom(zoom as float)

	local px as float
	local py as float
	local dx as float
	local dy as float
	local ox as float
	local oy as float
	local den as integer
	local origZoom as float

	//
	// Set zoom.
	//
	
	origZoom = ed.gfx.zoom
	
	px = ed.gfx.x0 + ed.gfx.w / 2
	py = ed.gfx.y0 + ed.gfx.h / 2
	ed.gfx.cp.x = px
	ed.gfx.cp.y = py

	edPressPointToGfx(ed.gfx.cp, ed.gfx.cp)

	if ed.gfx.zoom > 0
		
		ed.gfx.dp.x = fmod(px - ed.gfx.x0 - ed.gfx.offX - ed.gfx.drawX - ed.gfx.padX, ed.gfx.zoom)
		ed.gfx.dp.y = fmod(py - ed.gfx.y0 - ed.gfx.offY - ed.gfx.drawY - ed.gfx.padY, ed.gfx.zoom)

	else
					
		ed.gfx.dp.x = 0
		ed.gfx.dp.y = 0
			
	endif
				
	if ed.zoomFixed
	
		// Change the zoom.
		ed.zoomIdx = zoom
		
		if ed.zoomIdx < 0
			ed.zoomIdx = 0
		elseif ed.zoomIdx > ed.zooms.length
			ed.zoomIdx = ed.zooms.length
		endif
		
		ed.gfx.zoom = ed.zooms[ed.zoomIdx]

	else
		
		ed.gfx.zoom = zoom
		
		if ed.gfx.zoom < ED_ZOOM_MIN
			ed.gfx.zoom = ED_ZOOM_MIN
		elseif ed.gfx.zoom > ED_ZOOM_MAX
			ed.gfx.zoom = ED_ZOOM_MAX
		endif
				
	endif
		
	//	
	// Centre.
	//

	ox = ed.gfx.x0 + ed.gfx.w / 2 - (ed.gfx.cols.w * ed.gfx.zoom) / 2					
		
	if ox > ed.gfx.x0
				
		ed.gfx.drawX = ox - ed.gfx.x0
		ox = ox - ed.gfx.drawX

	else
			
		ed.gfx.drawX = 0
			
	endif

	if ed.gfx.drawX = 0
		
		ed.gfx.padX = ed.defPad
		ox = ox - ed.gfx.padX

	else
//xx see if we need to add pad based on drawx to ensure there's a border.		
		ed.gfx.padX = 0
				
	endif
			
	ed.gfx.offX = ox - ed.gfx.x0
	ed.gfx.offX = ed.gfx.offX + ((ed.gfx.cols.w / 2 - ed.gfx.cp.x) * ed.gfx.zoom) - ed.gfx.dp.x

	oy = ed.gfx.y0 + ed.gfx.h / 2 - (ed.gfx.cols.h * ed.gfx.zoom) / 2		

	if oy > ed.gfx.y0
				
		ed.gfx.drawY = oy - ed.gfx.y0
		oy = oy - ed.gfx.drawX

	else
			
		ed.gfx.drawY = 0
			
	endif

	if ed.gfx.drawY = 0
		
		ed.gfx.padY = ed.defPad
		oy = oy - ed.gfx.padY

	else
		
		ed.gfx.padY = 0
						
	endif
	
	ed.gfx.offY = oy - ed.gfx.y0 
	ed.gfx.offY = ed.gfx.offY + ((ed.gfx.cols.h / 2 - ed.gfx.cp.y) * ed.gfx.zoom) - ed.gfx.dp.y
	
	SetSpriteScale(ed.gfx.pixSpr, ed.gfx.zoom, ed.gfx.zoom)
	SetSpriteScale(ed.gfx.vGridSpr, ed.gfx.gridPixSize, ed.gfx.zoom)
	SetSpriteScale(ed.gfx.hGridSpr, ed.gfx.zoom, ed.gfx.gridPixSize)

	coSetSpriteColor(ed.gfx.vGridSpr, ed.gfx.gridCol)
	coSetSpriteColor(ed.gfx.hGridSpr, ed.gfx.gridCol)
	
	//if ed.gfx.transSpr
	//	SetSpriteScale(ed.gfx.transSpr, ed.gfx.zoom / 2, ed.gfx.zoom / 2)
	//endif

	ed.scroll.w = ed.gfx.padX + ed.gfx.cols.w * ed.gfx.zoom + ed.gfx.padX
	ed.scroll.h = ed.gfx.padY + ed.gfx.cols.h * ed.gfx.zoom + ed.gfx.padY
			
	if ed.scroll.w < ed.gfx.w
		ed.scroll.w = ed.gfx.w
	endif

	if ed.scroll.h < ed.gfx.h
		ed.scroll.h = ed.gfx.h
	endif
	
	if origZoom <> ed.gfx.zoom
		ed.gfx.pipsDirty = true
	endif

endfunction

//-----------------------------------------------------
// Build the trans spr.
//
function edBuildTrans()

	local img as integer
	local fakeDraw as integer
		
	//
	// Build trans for drawing.
	//
	
	if ed.gfx.zoom < ed.zoomTip
		
		edPrepSprDraw()
		fakeDraw = true

	else
	
		fakeDraw = false
		
	endif

	if ed.gfx.transSpr

		img = GetSpriteImageID(ed.gfx.transSpr)
		deletesprite(ed.gfx.transSpr)

		if img
			deleteimage(img)
		endif
		
	endif

	if fakeDraw				
		img = coCreateTransImg(ed.gfx.transIdx, ed.gfx.cols.w * ed.gfx.zoom, ed.gfx.cols.h * ed.gfx.zoom)		
	else		
		img = coCreateTransImg(ed.gfx.transIdx, co.bs / 4, co.bs / 4)		
	endif
	
	SetImageMinFilter(img, 0)
	SetImageMagFilter(img, 0)		
	
	ed.gfx.transSpr = CreateSprite(img)
	SetSpriteDepth(ed.gfx.transSpr, ED_TRANS_DEPTH)
	//SetSpriteScissor(ed.gfx.transSpr, ed.gfx.x0, ed.gfx.y0, ed.gfx.x1, ed.gfx.y1)
	
endfunction

//-----------------------------------------------------
// Hide the marks.
//
function edHideMarks()
	
	local i as integer
	
	for i = 0 to ed.vmSprs.length	
		SetSpriteVisible(ed.vmSprs[i], false)
	next

	for i = 0 to ed.vmTexts.length	
		SetTextVisible(ed.vmTexts[i], false)
	next

	for i = 0 to ed.hmSprs.length	
		SetSpriteVisible(ed.hmSprs[i], false)
	next

	for i = 0 to ed.hmTexts.length	
		SetTextVisible(ed.hmTexts[i], false)
	next

endfunction

//-----------------------------------------------------
// Setup the selection.
//
function edSetSel(mb ref as MemBlock)
	
	if ed.gfx.sel.active
		coMemSetSel(mb, ed.gfx.sel.sel)
	else
		coMemRemoveSel(mb)
	endif

endfunction

//-----------------------------------------------------
// Prep before draw, just in case it is low zoom, we need to update the sprite.
//
function edPrepSprDraw()
	
	local tmp as MemBlock
	local x as float
	local y as float
	local px as float
	local py as float
	local w as float
	local h as float
	local i as integer
	local vmn as float
	local hmn as float
	local tgap as float
	local d as float
	local ln as integer
	local img as integer
	local blend as integer
	local undo as integer

	tgap = 8
	
	if ed.eraseButId > -1 // For erase we need to override update the drawing if work is updated.
		if ed.gfx.drawDirty or ed.gfx.workDirty
			ed.gfx.drawDirty = true
		endif
	endif
				
	if ed.gfx.drawDirty
										
		if ed.gfx.spr
	
			img = GetSpriteImageID(ed.gfx.spr)
			deletesprite(ed.gfx.spr)
			ed.gfx.spr = 0
			
			if img
				deleteimage(img)
			endif
			
		endif

		if ed.eraseButId > -1

			if ed.gfx.workDirty
				
				undo = coMemSetUndo(ed.gfx.cols, CO_PRE_PIXEL) // About to change and undo cols.
				blend = coMemSetBlend(ed.gfx.cols, false)		
				coMemApplyPixels(ed.gfx.work, ed.gfx.cols, CO_COL_CLEAR)
				coMemSetUndo(ed.gfx.cols, undo)
				coMemSetBlend(ed.gfx.cols, blend)
					
			endif
			
			img = coMemToImage(ed.gfx.cols)

			if ed.gfx.workDirty				
				coMemUndoPixels(ed.gfx.cols) // Restore the original.				
			endif
		
		else
				
			img = coMemToImage(ed.gfx.cols)
			
		endif

		SetImageMinFilter(img, 0)
		SetImageMagFilter(img, 0)		
		ed.gfx.spr = CreateSprite(img)
				
	endif

	if ed.eraseButId > -1
		ed.gfx.workDirty = false // We don't draw work during erase. Taken care of in draw above.
	endif		
	
	if ed.gfx.work.id and ed.gfx.workDirty

		if ed.gfx.workSpr
	
			img = GetSpriteImageID(ed.gfx.workSpr)
			deletesprite(ed.gfx.workSpr)
			ed.gfx.workSpr = 0
			
			if img
				deleteimage(img)
			endif
			
		endif

		img = coMemToImage(ed.gfx.work)		
		SetImageMinFilter(img, 0)
		SetImageMagFilter(img, 0)		
		ed.gfx.workSpr = CreateSprite(img)
								
	endif

	if ed.gfx.gridDirty

		if ed.gfx.gridSpr
	
			img = GetSpriteImageID(ed.gfx.gridSpr)
			deletesprite(ed.gfx.gridSpr)
			ed.gfx.gridSpr = 0
			
			if img
				deleteimage(img)
			endif
			
		endif

		//if ed.gridButId > -1
		if ed.gfx.snapToGrid
			
			coMemCreate(tmp, ed.gfx.cols.w, ed.gfx.cols.h) 
			coMemDrawGrid(tmp, ed.gfx.gridWidth, ed.gfx.gridHeight, ed.gfx.gridCol, 0)
			img = coMemToImage(tmp)	
			coMemDelete(tmp)	
			SetImageMinFilter(img, 0)
			SetImageMagFilter(img, 0)		
			ed.gfx.gridSpr = CreateSprite(img)
			
		endif
										
	endif
		
	if ed.gfx.sel.sel.id and ed.gfx.sel.dirty		
		
		if ed.gfx.sel.spr

			img = GetSpriteImageID(ed.gfx.sel.spr)
			deletesprite(ed.gfx.sel.spr)
			ed.gfx.sel.spr = 0
			
			if img
				deleteimage(img)
			endif					

		endif

		if ed.gfx.sel.active
		
			img = coMemToImage(ed.gfx.sel.sel)				
			SetImageMinFilter(img, 0)
			SetImageMagFilter(img, 0)		
			ed.gfx.sel.spr = CreateSprite(img)
							
		else	
			
			//coMemPasteMask(ed.gfx.sel.sel, tmp, 0, 0, CO_COL_NE, 0)
			coMemPasteNez(ed.gfx.sel.sel, tmp, 0, 0)
		
		endif
			
	endif

	if ed.gfx.spr
		
		SetSpriteDepth(ed.gfx.spr, ED_SPR_DEPTH)
		SetSpriteScale(ed.gfx.spr, ed.gfx.zoom, ed.gfx.zoom)	
	
	endif	

	if ed.gfx.workSpr
		
		SetSpriteDepth(ed.gfx.workSpr, ED_WORK_DEPTH)
		SetSpriteScale(ed.gfx.workSpr, ed.gfx.zoom, ed.gfx.zoom)		
		
	endif

	if ed.gfx.sel.spr
		
		SetSpriteDepth(ed.gfx.sel.spr, ED_SEL_DEPTH)
		SetSpriteScale(ed.gfx.sel.spr, ed.gfx.zoom, ed.gfx.zoom)		
		
	endif

	if ed.gfx.gridSpr
		
		SetSpriteDepth(ed.gfx.gridSpr, ED_GRID_DEPTH)
		SetSpriteScale(ed.gfx.gridSpr, ed.gfx.zoom, ed.gfx.zoom)		
		
	endif

	ed.gfx.drawDirty = false
	ed.gfx.workDirty = false
	ed.gfx.sel.dirty = false
	ed.gfx.gridDirty = false

endfunction

//-----------------------------------------------------
// Render the image.
//
function edDrawImage()

	local x as integer
	local y as integer
	local xx as float
	local yy as float
	local x0 as float // The start of a pixel.
	local y0 as float 
	local x1 as float // The end of a pixel.
	local y1 as float
	local tw as float
	local th as float
	local spr as integer
	local col as integer
	local alpha as integer
	local off as integer
	local i as integer
	local vm as integer
	local hm as integer
	local vmx as float
	local hmy as float
	local vmIdx as integer
	local hmIdx as integer
	local vmn as float
	local hmn as float
	local tgap as float
	local fakeDraw as integer // fakeDraw = true means using sprites, not drawing pixels.
	local fakePos as integer
	local ww as integer
	local hh as integer
	local w as integer
	local h as integer
	local img as integer
	local gx as integer
	local gy as integer
	local dx as integer
	local dy as integer
	local t1 as integer
	local t2 as integer
	
	t1 = GetMilliseconds()
	
	if ed.gfx.zoom < ed.zoomTip
	//if ed.gfx.cols.w <= ed.gfx.w and ed.gfx.cols.h <= ed.gfx.h

		edPrepSprDraw()
		fakeDraw = true

	else
		
		fakeDraw = false
		
	endif

	//
	// Determine which sprites need to be visible for fake or not drawing.
	//
		
	if ed.gfx.workSpr
		
		if ed.eraseButId > -1 // Don't want to draw work if erasing.
			SetSpriteVisible(ed.gfx.workSpr, false)
		else
			SetSpriteVisible(ed.gfx.workSpr, fakeDraw)
		endif
		
	endif
	
	if ed.gfx.sel.spr
		SetSpriteVisible(ed.gfx.sel.spr, fakeDraw)
	endif

	if ed.gfx.gridSpr
		SetSpriteVisible(ed.gfx.gridSpr, fakeDraw)
	endif
	
	if ed.gfx.spr
		SetSpriteVisible(ed.gfx.spr, fakeDraw)
	endif
	
	if ed.gfx.vGridSpr
		SetSpriteVisible(ed.gfx.vGridSpr, fakeDraw)
	endif
	
	if ed.gfx.hGridSpr
		SetSpriteVisible(ed.gfx.hGridSpr, fakeDraw)
	endif
	
	if not fakeDraw
		
		if ed.gfx.transSpr
			SetSpriteVisible(ed.gfx.transSpr, true)
		endif
		
		coSetSpriteColor(ed.gfx.transEdgeSpr, ed.clearCol)
		//coSetSpriteColor(ed.gfx.transEdgeSpr, co.blue[5])
		SetSpriteVisible(ed.gfx.transEdgeSpr, true)
		SetSpriteVisible(ed.gfx.pixSpr, true)
		
		//if ed.gridButId > -1
		if ed.gfx.snapToGrid

			SetSpriteVisible(ed.gfx.vGridSpr, true)
			SetSpriteVisible(ed.gfx.hGridSpr, true)
			
		endif

	endif	
	
	//
	// Draw trans.
	//
	
//t2 = GetMilliseconds()
//colog("A: " + str(t2 - t1))
//t1 = t2
	
	if not fakeDraw

		if ed.gfx.transSpr
			
			tw = GetSpriteWidth(ed.gfx.transSpr)
			th = GetSpriteHeight(ed.gfx.transSpr)
			
		endif
			
		ww = (ed.gfx.cols.w * ed.gfx.zoom)
		hh = (ed.gfx.cols.h * ed.gfx.zoom)
		w = ceil(ww / tw)
		h = ceil(hh / th)
		
		y0 = ed.gfx.y0 + ed.gfx.offY + ed.gfx.padY
		yy = y0
		y1 = y0 + th
		
		for y = 0 to h - 1
	
			x0 = ed.gfx.x0 + ed.gfx.offX + ed.gfx.padX
			xx = x0
	
			if y1 >= ed.gfx.y0 and y0 <= ed.gfx.y1 // If the pixel is visible.
							
				x1 = x0 + tw
					
				for x = 0 to w - 1
	
					if x1 >= ed.gfx.x0 and x0 <= ed.gfx.x1 // If the pixel is visible.
					
						if ed.gfx.transSpr
							
							SetSpritePosition(ed.gfx.transSpr, x0 + ed.gfx.drawX, y0 + ed.gfx.drawY)
							DrawSprite(ed.gfx.transSpr)
							
						endif
													
					endif
	
					x0 = x1
					x1 = x1 + tw
	
				next

				if x0 > xx + ww
				
					dx = x0 - (xx + ww)
					SetSpriteScale(ed.gfx.transEdgeSpr, dx, th)
					SetSpritePosition(ed.gfx.transEdgeSpr, x0 - dx + ed.gfx.drawX, y0 + ed.gfx.drawY)
					DrawSprite(ed.gfx.transEdgeSpr)
	
				endif
								
			endif
	
			y0 = y1
			y1 = y1 + th
			
		next

		if y0 > yy + hh

			x0 = ed.gfx.x0 + ed.gfx.offX + ed.gfx.padX
			x1 = x0 + tw

			dy =	 y0 - (yy + hh)
			SetSpriteScale(ed.gfx.transEdgeSpr, tw, dy)
			
			for x = 0 to w - 1
	
				if x1 >= ed.gfx.x0 and x0 <= ed.gfx.x1 // If the pixel is visible.
								
					SetSpritePosition(ed.gfx.transEdgeSpr, x0 + ed.gfx.drawX, y0 - dy + ed.gfx.drawY)
					DrawSprite(ed.gfx.transEdgeSpr)
											
				endif
	
				x0 = x1
				x1 = x1 + tw
	
			next
			
		endif
		
	endif

//t2 = GetMilliseconds()
//colog("B: " + str(t2 - t1))
//t1 = t2

	//
	// Position sprites (fakeDraw)
	//

	if fakeDraw
	
		y0 = ed.gfx.y0 + ed.gfx.offY + ed.gfx.padY
		x0 = ed.gfx.x0 + ed.gfx.offX + ed.gfx.padX
	
		xx = x0 + ed.gfx.drawX
		yy = y0 + ed.gfx.drawY
				
		if ed.gfx.spr				
			SetSpritePosition(ed.gfx.spr, xx, yy)
		endif
		
		if ed.gfx.transSpr
			SetSpritePosition(ed.gfx.transSpr, xx, yy)	
		endif
		
		if ed.gfx.workSpr
			SetSpritePosition(ed.gfx.workSpr,xx, yy)
		endif
		
		if ed.gfx.sel.spr
			SetSpritePosition(ed.gfx.sel.spr, xx, yy)
		endif

		if ed.gfx.gridSpr
			SetSpritePosition(ed.gfx.gridSpr,xx, yy)
		endif
		
	endif

//t2 = GetMilliseconds()
//colog("C: " + str(t2 - t1))
//t1 = t2

	//
	// Draw pips.
	//

	if ed.gfx.pipsDirty

		edHideMarks()
	
		vm = true
		hm = true
		vmIdx = 0
		hmIdx = 0
		tgap = 8
		
		vmn = (ed.gfx.w / ed.gfx.zoom) / ed.vmSprs.length
		if vmn < 1 then vmn = 1
		
		hmn = (ed.gfx.h / ed.gfx.zoom) / ed.hmSprs.length
		if hmn < 1 then hmn = 1	
			
		y0 = ed.gfx.y0 + ed.gfx.offY + ed.gfx.padY
		
		for y = 0 to ed.gfx.cols.h - 1
	
			yy = y0 + ed.gfx.drawY
					
			if hm
				if yy + GetSpriteHeight(ed.hmSprs[hmIdx]) + tgap + GetTextTotalWidth(ed.hmTexts[hmIdx]) > ed.gfx.y0 and y0 <= ed.gfx.y1 // If the pixel is visible.
					if mod(y, hmn) = 0	
												
						SetSpritePosition(ed.hmSprs[hmIdx], ed.gfx.x0 - ed.hmS, yy)
						SetSpriteVisible(ed.hmSprs[hmIdx], true)
						SetTextString(ed.hmTexts[hmIdx], str(y))
						SetTextPosition(ed.hmTexts[hmIdx], ed.gfx.x0 - ed.hmT, yy + tgap)
						SetTextVisible(ed.hmTexts[hmIdx], true)
		
						inc hmIdx
						
						if hmIdx > ed.hmSprs.length
							hm = false
						endif
						
					endif												
				endif
			endif
			
			y0 = y0 + ed.gfx.zoom
				
		next
	
		x0 = ed.gfx.x0 + ed.gfx.offX + ed.gfx.padX
			
		for x = 0 to ed.gfx.cols.w - 1
	
			xx = x0 + ed.gfx.drawX
	
			if vm
				if xx + GetSpriteWidth(ed.vmSprs[vmIdx]) + tgap + gettexttotalwidth(ed.vmTexts[vmIdx]) > ed.gfx.x0 and x0 <= ed.gfx.x1 // If the pixel is visible.
					if mod(x, vmn) = 0														
	
						SetSpritePosition(ed.vmSprs[vmIdx], xx, ed.gfx.y0 - ed.vmS)
						SetSpriteVisible(ed.vmSprs[vmIdx], true)
						SetTextString(ed.vmTexts[vmIdx], str(x))
						SetTextPosition(ed.vmTexts[vmIdx], xx + tgap, ed.gfx.y0 - ed.vmT)
						SetTextVisible(ed.vmTexts[vmIdx], true)
												
						inc vmIdx
						
						if vmIdx > ed.vmSprs.length
							vm = false
						endif
						
					endif												
				endif
			endif
				
			x0 = x0 + ed.gfx.zoom
			
		next	
		
	endif

//t2 = GetMilliseconds()
//colog("D: " + str(t2 - t1))
//t1 = t2

//ed.tt = 0
			
	//
	// Draw pixels and grid for real draw (i.e. not fakedraw).
	//
	
	if not fakeDraw
		
		//fakePos = false
		off = 12 // into memblock for speed.
		y0 = ed.gfx.y0 + ed.gfx.offY + ed.gfx.padY
		y1 = y0 + ed.gfx.zoom
		
		gy = 0
		
		for y = 0 to ed.gfx.cols.h - 1
	
			x0 = ed.gfx.x0 + ed.gfx.offX + ed.gfx.padX	
			xx = x0 + ed.gfx.drawX
			yy = y0 + ed.gfx.drawY
					
			if y1 >= ed.gfx.y0 and y0 <= ed.gfx.y1 // If the pixel is visible.
							
				x1 = x0 + ed.gfx.zoom
				gx = 0
					
				for x = 0 to ed.gfx.cols.w - 1
	
					xx = x0 + ed.gfx.drawX
					yy = y0 + ed.gfx.drawY
												
					if x1 >= ed.gfx.x0 and x0 <= ed.gfx.x1 // If the pixel is visible.
															
						col = getMemblockInt(ed.gfx.cols.id, off)							
						
						if ed.eraseButId > -1							
							if getMemblockInt(ed.gfx.work.id, off) <> 0							
								col = 0 // Erase if work has a non-zero.
							endif
						endif
						
						edDrawPixel(xx, yy, col)
	
						if ed.gfx.work.id and ed.eraseButId = -1 // Don't draw if erasing.
							
							col = getMemblockInt(ed.gfx.work.id, off)
							alpha = coGetColorAlpha(col)
		
							if alpha > 0
								edDrawPixel(xx, yy, col)							
							endif
							
						endif
						
						if ed.gfx.sel.active
							
							if ed.gfx.sel.sel.id // and ed.gfx.sel.dirty

								col = getMemblockInt(ed.gfx.sel.sel.id, off)
								alpha = coGetColorAlpha(col)
			
								if alpha > 0
									edDrawPixel(xx, yy, col)							
								endif
								
							endif
							
						endif
																					
					endif
								
					//if ed.gridButId > -1 // Draw grid line.
					if ed.gfx.snapToGrid

						if gx = 0 // gx < 2 // mod(x, ed.gfx.gridCols) = 0
							edDrawVGrid(xx, yy, col)						
						endif
	
						if gy = 0 // gy < 2 // mod(y, ed.gfx.gridRows) = 0
							edDrawHGrid(xx, yy, col)						
						endif
	
					endif	
											
					x0 = x1
					x1 = x1 + ed.gfx.zoom
					off = off + 4
					
					inc gx
					
					if gx >= ed.gfx.gridWidth
						gx = 0
					endif
					
				next	
										
			else
				
				off = off + (ed.gfx.cols.w * 4)
				
			endif
				
			y0 = y1
			y1 = y1 + ed.gfx.zoom
		
			inc gy
					
			if gy >= ed.gfx.gridHeight
				gy = 0
			endif
			
		next

	endif
	
/*
	//
	// Draw a darker spr at the border being scrolled to show we are scrolling.
	//
	
	if ed.scroll.zone > 0
			
		x0 = ed.gfx.x0 + ed.gfx.offX + ed.gfx.padX
		y0 = ed.gfx.y0 + ed.gfx.offY + ed.gfx.padY
	
		if ed.scroll.zone = DIR_N
			
			SetSpriteScale(ed.scroll.spr, ed.gfx.w, ED_SCROLL_EDGE)
			SetSpritePosition(ed.gfx.spr, x0 + ed.gfx.drawX, y0 + ed.gfx.drawY)
			
		elseif ed.scroll.zone = DIR_S
			
			SetSpriteScale(ed.scroll.spr, ed.gfx.w, ED_SCROLL_EDGE)
			SetSpritePosition(ed.gfx.spr, x0 + ed.gfx.drawX, y0 + hh - ED_SCROLL_EDGE + ed.gfx.drawY)
			
		elseif ed.scroll.zone = DIR_W
			
			SetSpriteScale(ed.scroll.spr, ED_SCROLL_EDGE, ed.gfx.h)
			SetSpritePosition(ed.gfx.spr, x0 + ed.gfx.drawX, y0 + ed.gfx.drawY)
			
		elseif ed.scroll.zone = DIR_E
			
			SetSpriteScale(ed.scroll.spr, ED_SCROLL_EDGE, ed.gfx.h)
			SetSpritePosition(ed.gfx.spr, x0 + ww - eD_SCROLL_EDGE + ed.gfx.drawX, y0 + ed.gfx.drawY)

		endif
		
		SetSpriteVisible(ed.scroll.spr, true)
		
		if not fakeDraw
			DrawSprite(ed.scroll.spr)
		endif
		
	else 

		SetSpriteVisible(ed.scroll.spr, false)

	endif
*/

//t2 = GetMilliseconds()
//colog("E: " + str(t2 - t1))
//t1 = t2

//colog("E drawpix: " + str(ed.tt))
	
	if ed.gfx.pixSpr
		SetSpriteVisible(ed.gfx.pixSpr, false)
	endif
	
	if ed.gfx.vGridSpr
		SetSpriteVisible(ed.gfx.vGridSpr, false)
	endif
	
	if ed.gfx.hGridSpr
		SetSpriteVisible(ed.gfx.hGridSpr, false)
	endif
	
	if not fakeDraw

		if ed.gfx.transSpr
			SetSpriteVisible(ed.gfx.transSpr, false) // Just drew, don't need it anymore.			
		endif
		
		SetSpriteVisible(ed.gfx.transEdgeSpr, false) // Just drew, don't need it anymore.

	endif
	
	//drawbox(ed.gfx.x0 + ed.gfx.w / 2 - 8, ed.gfx.y0 + ed.gfx.h / 2 - 8, ed.gfx.x0 + ed.gfx.w / 2 + 8, ed.gfx.y0 + ed.gfx.h / 2 + 8, co.black, co.black, co.black, co.black, true) 

endfunction

//-----------------------------------------------------
// Draw a pixel at the location.
//
function edDrawPixel(x as float, y as float, col as integer)

ed.t1 = GetMilliseconds()
										
	SetSpritePosition(ed.gfx.pixSpr, x, y)
	coSetSpriteColor(ed.gfx.pixSpr, col)
	DrawSprite(ed.gfx.pixSpr)
	//drawbox(x0 + ed.gfx.drawX, y0 + ed.gfx.drawY, x1 + ed.gfx.drawX, y1 + ed.gfx.drawY, col, col, col, col, true) 

ed.t2 = GetMilliseconds()
ed.tt = ed.tt + (ed.t2 - ed.t1)
	
endfunction

//-----------------------------------------------------
// Draw vGrid.
//
function edDrawVGrid(x as float, y as float, col as integer)

	SetSpritePosition(ed.gfx.vGridSpr, x, y)
	DrawSprite(ed.gfx.vGridSpr)										
	
endfunction

//-----------------------------------------------------
// Draw hGrid.
//
function edDrawHGrid(x as float, y as float, col as integer)

	SetSpritePosition(ed.gfx.hGridSpr, x, y)
	DrawSprite(ed.gfx.hGridSpr)										
	
endfunction

//-----------------------------------------------------
//
function edScrollUpdate(x as float, y as float)
	
	local originallyFromHere as integer
	Local amtX as Float
	Local amtY as Float
	local origOffX as float
	local origOffY as float

	origOffX = ed.gfx.offX
	origOffY = ed.gfx.offY
	
	originallyFromHere = coPointWithinRect(ed.scroll.firstX, ed.scroll.firstY, ed.gfx.x0, ed.gfx.y0, ed.gfx.w, ed.gfx.h)
			
	ed.scroll.xMomentum = ed.scroll.xMomentum * (1.0 - ED_SCROLL_FRICTION)  //Apply friction
	ed.scroll.yMomentum = ed.scroll.yMomentum * (1.0 - ED_SCROLL_FRICTION)

	amtX = x - ed.scroll.originX //Amount change from origin since last update
	amtY = y - ed.scroll.originY

	If ed.scroll.holding // drag

		ed.gfx.offX = ed.gfx.offX + amtX //Increment the offset.
		ed.gfx.offY = ed.gfx.offY + amtY //Increment the offset.

		If Abs(amtX) > Abs(ed.scroll.xMomentum) Then ed.scroll.xMomentum = amtX //only add momentum if going faster than before.
		If Abs(amtY) > Abs(ed.scroll.yMomentum) Then ed.scroll.yMomentum = amtY

		If coSgn(amtX) <> 0 And coSgn(amtX) <> coSgn(ed.scroll.xMomentum) Then ed.scroll.xMomentum = amtX //stops direction popping
		If coSgn(amtY) <> 0 And coSgn(amtY) <> coSgn(ed.scroll.yMomentum) Then ed.scroll.yMomentum = amtY

		ed.scroll.originX = x //update the origin for next update		
		ed.scroll.originY = y
		
	endif
	
	If not ed.scroll.holding Or (ed.scroll.holding And Not originallyFromHere)  //no drag.  Slide with momentum.

		ed.gfx.offX = ed.gfx.offX + ed.scroll.xMomentum
		ed.gfx.offY = ed.gfx.offY + ed.scroll.yMomentum

	EndIf
	
	//Dink the momentums if they're below threshold. 
	
	If abs(ed.scroll.xMomentum) > 0 and Abs(ed.scroll.xMomentum) < 0.01
		
		ed.scroll.xMomentum = 0
		ed.gfx.offX = Floor(ed.gfx.offX + 0.4) //round
		
	EndIf
	
	If abs(ed.scroll.yMomentum) > 0 and Abs(ed.scroll.yMomentum) < 0.01
		
		ed.scroll.yMomentum = 0
		ed.gfx.offY = Floor(ed.gfx.offY + 0.4) //round
		
	EndIf		

	If ed.gfx.offX > 0  //left

		ed.gfx.offX = 0
		ed.scroll.xMomentum = 0

	ElseIf ed.scroll.w > ed.gfx.w And -ed.gfx.offX > (ed.scroll.w - ed.gfx.w)  //right

		ed.gfx.offX = -(ed.scroll.w - ed.gfx.w)
		ed.scroll.xMomentum = 0

	ElseIf ed.scroll.w <= ed.gfx.w  //no X scroll possible

		ed.gfx.offX = 0
		ed.scroll.xMomentum = 0

	EndIf

	If ed.gfx.offY > 0  //top

		ed.gfx.offY = 0
		ed.scroll.yMomentum = 0

	ElseIf ed.scroll.h > ed.gfx.h And -ed.gfx.offY > (ed.scroll.h - ed.gfx.h) //bottom

		ed.gfx.offY = -(ed.scroll.h - ed.gfx.h)
		ed.scroll.yMomentum = 0

	ElseIf ed.scroll.h <= ed.gfx.h  //no Y scroll possible

		ed.gfx.offY = 0
		ed.scroll.yMomentum = 0				

	EndIf
	
	ed.scroll.scrolling = Not (ed.scroll.xMomentum = 0 And ed.scroll.yMomentum = 0)			

	if origOffX <> ed.gfx.offX or origOffY <> ed.gfx.offY
		ed.gfx.pipsDirty = true
	endif
	
endfunction

//-----------------------------------------------------
// Check if we are within the edge of the edit image area, to see if we need to scroll.
//
function edCheckEdgeScroll(x as float, y as float)

	if coPointWithinRect(x, y, ed.gfx.x0, ed.gfx.y0, ed.gfx.w, ed.gfx.h) and not coPointWithinRect(x, y, ed.gfx.x0 + ED_SCROLL_EDGE, ed.gfx.y0 + ED_SCROLL_EDGE, ed.gfx.w - ED_SCROLL_EDGE * 2, ed.gfx.h - ED_SCROLL_EDGE * 2)

		if not ed.scroll.Zone
			
			if x < ed.gfx.x0 + ED_SCROLL_EDGE
				ed.scroll.Zone = ed.scroll.Zone + DIR_W
			elseif x > ed.gfx.x0 + ed.gfx.w - ED_SCROLL_EDGE
				ed.scroll.Zone = ed.scroll.Zone + DIR_E
			endif
				
			if y < ed.gfx.y0 + ED_SCROLL_EDGE
				ed.scroll.Zone = ed.scroll.Zone + DIR_N
			elseif y > ed.gfx.y0 + ed.gfx.h - ED_SCROLL_EDGE
				ed.scroll.Zone = ed.scroll.Zone + DIR_S
			endif

			ed.scroll.Time = GetMilliseconds() + ED_SCROLL_WAIT

		endif
		
		if ed.scroll.Zone and GetMilliseconds() > ed.scroll.Time
			
			if ed.scroll.Zone && DIR_W							
				ed.gfx.offX = ed.gfx.offX + ED_SCROLL_DIST				
			endif
			
			if ed.scroll.Zone && DIR_E
				ed.gfx.offX = ed.gfx.offX - ED_SCROLL_DIST
			endif

			if ed.scroll.Zone && DIR_N				
				ed.gfx.offY = ed.gfx.offY + ED_SCROLL_DIST

			endif

			if ed.scroll.Zone && DIR_S
				ed.gfx.offY = ed.gfx.offY - ED_SCROLL_DIST
			endif

			//guiSetPanelBarsVisible(cd.edimg.dataPanel, false)
			
			edScrollUpdate(x, y)
			
			ed.scroll.Time = GetMilliseconds() + ED_SCROLL_TIME
			
		endif
		
	else

		ed.scroll.Zone = 0
		
	endif
	
endfunction

//-----------------------------------------------------
// 
function edPressed(x as float, y as float)

	local butId as integer
	local butArea as integer
	local idx as integer
	local snap as integer
	local b as Bounds

	if cdIsEditActive()

		cdPressed(x, y)
		exitfunction

	elseif cd.subMode = CD_SUBMODE_EDIT_EDITOR_IMAGE

		cdPressed(x, y)
		exitfunction

	endif

	if ed.pressed // Avoid double-press.
		exitfunction
	endif
	
	ed.pressed = true
	ed.mode = ED_MODE_NONE
		
	butId = -1
	butArea = false
			
	if y < ed.gfx.y0
			
		butId = edCheckSubBarPressed(x, y, 0)		

		if butId > -1				
			ed.mode = ED_MODE_SUB_BAR			
		endif
		
		butArea = true

	elseif x < ed.gfx.x0
		
		butId = edCheckMoreBarPressed(x, y, 0)		
		
		if butId > -1		
			ed.mode = ED_MODE_MORE_BAR
		endif
		
		butArea = true
			
	endif
	
	if butArea
			
		if butId > -1
	
			ed.pressedButId = butId
			ed.scroll.xMomentum = 0
			ed.scroll.yMomentum = 0
			ed.waitStart = GetMilliseconds()
						
		endif
		
	else
	
		ed.mode = ED_MODE_GFX
					
		if ed.butId = BUT_EDITOR_SELECT

			edGfxPressed(x, y, true)
					
			if ed.pasteButId > -1 // Paste is active.

				ed.mode = ED_MODE_NONE
				edSetSel(ed.gfx.work)
				coMemPaste(ed.gfx.copy, ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y)
				edPasteWork()
				edAddPixelUndo()
				ed.pasteButId = -1
				edShowButtons()

			elseif ed.gfx.selShape = CO_SEL_LINE

				if not ed.gfx.sel.lining
						
					ed.gfx.sel.active = false													
					edClearSel()
					
				else
					
					ed.gfx.sp = ed.gfx.sel.sp
					ed.gfx.pp = ed.gfx.sel.ep

					snap = coMemSnapPixels(ed.gfx.sel.sel, true)
					b.x0 = ed.gfx.sp.x
					b.y0 = ed.gfx.sp.y
					b.x1 = ed.gfx.ep.x
					b.y1 = ed.gfx.ep.y
					edCorrectSnap(b, false)
					//coMemDrawLine(ed.gfx.sel.sel, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)											
					coMemDrawLine(ed.gfx.sel.sel, b.x0, b.y0, b.x1, b.y1, ed.gfx.sel.col, 1, 0)											
					coMemSnapPixels(ed.gfx.sel.sel, snap)
					edClearWork()
					snap = coMemSnapPixels(ed.gfx.work, true)											
					b.x0 = ed.gfx.pp.x
					b.y0 = ed.gfx.pp.y
					b.x1 = ed.gfx.ep.x
					b.y1 = ed.gfx.ep.y
					edCorrectSnap(b, false)
					//coMemDrawLine(ed.gfx.work, ed.gfx.pp.x, ed.gfx.pp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)		
					coMemDrawLine(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.sel.col, 1, 0)		
					coMemSnapPixels(ed.gfx.work, snap)
					ed.gfx.sel.dirty = true
					
					ed.gfx.sp.x = ed.gfx.ep.x
					ed.gfx.sp.y = ed.gfx.ep.y
					
				endif
																	
			else

				ed.gfx.sel.active = false													
				edClearSel()
				
				if ed.gfx.selShape = CO_SEL_FILL
					
					//if ed.gfx.sel.filling
											
						coMemSetFill(ed.gfx.sel.sel, ed.gfx.cols)
						coMemDrawFill(ed.gfx.sel.sel, ed.gfx.pp.x, ed.gfx.pp.y, ed.gfx.sel.col)
						coMemRemoveFill(ed.gfx.sel.sel)
						edShowCoords(false, true, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y)
						ed.gfx.sel.active = true
						ed.gfx.sel.dirty = true
						ed.gfx.sel.filling = false
						
					//endif

				endif
				
			endif

			edClearWork()
			edShowCoords(true, false, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y)

		elseif ed.pickerButId = BUT_EDITOR_PICKER
	
			edGfxPressed(x, y, false)
			ed.gfx.col = coMemGetPoint(ed.gfx.cols, ed.gfx.pp.x, ed.gfx.pp.y)
			ed.pickerButId = -1
			edSetEraseMode(-1)
			edShowButtons()
			
		elseif ed.butId = BUT_EDITOR_DRAW
	
			edGfxPressed(x, y, true)
			edClearWork()
			edDrawFree()
	
		elseif ed.butId = BUT_EDITOR_LINE
			
			edGfxPressed(x, y, true)
			edDrawLine()
			
		elseif ed.butId = BUT_EDITOR_SHAPE
			
			edGfxPressed(x, y, true)
			edDrawShape()
				
		elseif ed.butId = BUT_EDITOR_FILL
				
			edGfxPressed(x, y, false)
			edClearWork()
			edDrawFill()
			edAddPixelUndo()
			edShowButtons()

		elseif ed.butId = BUT_EDITOR_TEXT

			edGfxPressed(x, y, true)
			edDrawText()
					
		elseif ed.butId = BUT_EDITOR_IMAGE
			
			edGfxPressed(x, y, true)
			edPasteImage()
									
		elseif ed.butId = BUT_EDITOR_PAN
	
			ed.scroll.firstX = x
			ed.scroll.firstY = y
			ed.scroll.originX = x
			ed.scroll.originY = y
			ed.scroll.xMomentum = 0
			ed.scroll.yMomentum = 0
			ed.scroll.holding = True
			ed.scroll.scrolling = True
		
		endif
		
	endif
		
endfunction

//-----------------------------------------------------
// 
function edMoved(x as float, y as float)

	local cmd as integer
	local m as integer
	local dt as integer
	local snap as integer
	local b as Bounds
	local b2 as Bounds
	
	if cdIsEditActive()

		cdMoved(x, y)
		exitfunction

	elseif cd.subMode = CD_SUBMODE_EDIT_EDITOR_IMAGE

		cdMoved(x, y)
		exitfunction
		
	endif

	m = GetMilliseconds()
	dt = m - ed.waitStart

	if ed.mode = ED_MODE_MORE_BAR

		edCheckMoreBarPressed(x, y, dt)

	elseif ed.mode = ED_MODE_SUB_BAR
		
		edCheckSubBarPressed(x, y, dt)
/*
	elseif ed.mode = ED_MODE_SEL_MOVE

		edGfxMoved(x, y)
		ed.gfx.sp.x = ed.gfx.ep.x - (ed.gfx.pp.x - ed.gfx.sel.sp.x)
		ed.gfx.sp.y = ed.gfx.ep.y - (ed.gfx.pp.y - ed.gfx.sel.sp.y)
		ed.gfx.ep.x = ed.gfx.sp.x + abs(ed.gfx.sel.ep.x - ed.gfx.sel.sp.x)
		ed.gfx.ep.y = ed.gfx.sp.y + abs(ed.gfx.sel.ep.y - ed.gfx.sel.sp.y)
		edShowCoords(true, true, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y)
				
		edClearWork()
		coMemDrawRect(ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 0)		
		ed.gfx.workDirty = true
*/
	elseif ed.mode = ED_MODE_GFX
		
		if ed.butId = BUT_EDITOR_SELECT

			edGfxMoved(x, y)
			
			//if ed.gfx.selShape = CO_SEL_RECT or ed.gfx.selShape = CO_SEL_OVAL
			//	edCorrectSnap(true)
			//else
			//	edCorrectSnap(false)
			//endif
			
			edCheckEdgeScroll(x, y)
			
			if not ed.gfx.sel.active
				
				b.x0 = ed.gfx.sp.x
				b.y0 = ed.gfx.sp.y
				b.x1 = ed.gfx.ep.x
				b.y1 = ed.gfx.ep.y				
				edCorrectSnap(b, true)
				
				//if ed.gfx.sp.x <> ed.gfx.ep.x or ed.gfx.sp.y <> ed.gfx.ep.y		
				if b.x0 <> b.x1 or b.y0 <> b.y1
						
					ed.gfx.sel.active = true // If moved, then sel is active.
					
					if ed.gfx.selShape = CO_SEL_LINE
						
						ed.gfx.sel.lining = true
						edShowButtons()
						
					endif
					
				endif
				
			endif
			
			if ed.gfx.sel.active
					
				b.x0 = ed.gfx.sp.x
				b.y0 = ed.gfx.sp.y
				b.x1 = ed.gfx.ep.x
				b.y1 = ed.gfx.ep.y

				if ed.gfx.selShape = CO_SEL_RECT
	
					edCorrectSnap(b, true)				
					edClearSel()
					//coMemDrawRect(ed.gfx.sel.sel, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 0)		
					coMemDrawRect(ed.gfx.sel.sel, b.x0, b.y0, b.x1, b.y1, ed.gfx.sel.col, 0)		
					ed.gfx.sel.dirty = true
	
				elseif ed.gfx.selShape = CO_SEL_OVAL

					edCorrectSnap(b, true)				
					edClearSel()
					//coMemDrawOval(ed.gfx.sel.sel, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 0)		
					coMemDrawOval(ed.gfx.sel.sel, b.x0, b.y0, b.x1, b.y1, ed.gfx.sel.col, 0)		
					ed.gfx.sel.dirty = true

				elseif ed.gfx.selShape = CO_SEL_FREE

					edCorrectSnap(b, false)				
					snap = coMemSnapPixels(ed.gfx.sel.sel, true)					
					//coMemDrawLine(ed.gfx.sel.sel, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)											
					coMemDrawLine(ed.gfx.sel.sel, b.x0, b.y0, b.x1, b.y1, ed.gfx.sel.col, 1, 0)											
					coMemSnapPixels(ed.gfx.sel.sel, snap)
					edClearWork()
					snap = coMemSnapPixels(ed.gfx.work, true)					
					b2.x0 = ed.gfx.pp.x
					b2.y0 = ed.gfx.pp.y
					b2.x1 = ed.gfx.ep.x
					b2.y1 = ed.gfx.ep.y
					edCorrectSnap(b2, false)				
					//coMemDrawLine(ed.gfx.work, ed.gfx.pp.x, ed.gfx.pp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)		
					coMemDrawLine(ed.gfx.work, b2.x0, b2.y0, b2.x1, b2.y1, ed.gfx.sel.col, 1, 0)		
					coMemSnapPixels(ed.gfx.work, snap)
					ed.gfx.sel.dirty = true
					
					ed.gfx.sp.x = ed.gfx.ep.x
					ed.gfx.sp.y = ed.gfx.ep.y
							
				elseif ed.gfx.selShape = CO_SEL_LINE
	
					edCorrectSnap(b, false)				
					edClearWork()
					snap = coMemSnapPixels(ed.gfx.work, true)					
					edCorrectSnap(b, false)				
					//coMemDrawLine(ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)		
					coMemDrawLine(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.sel.col, 1, 0)		
					b2.x0 = ed.gfx.pp.x
					b2.y0 = ed.gfx.pp.y
					b2.x1 = ed.gfx.ep.x
					b2.y1 = ed.gfx.ep.y
					edCorrectSnap(b2, false)				
				//coMemDrawLine(ed.gfx.work, ed.gfx.pp.x, ed.gfx.pp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)		
					coMemDrawLine(ed.gfx.work, b2.x0, b2.y0, b2.x1, b2.y1, ed.gfx.sel.col, 1, 0)		
					coMemSnapPixels(ed.gfx.work, snap)
					ed.gfx.workDirty = true

				endif
				
				//edShowCoords(true, true, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y)
				edShowCoords(true, true, b.x0, b.y0, b.x1, b.y1)

			endif
						
		elseif ed.butId = BUT_EDITOR_DRAW
			
			edGfxMoved(x, y)	
			edCheckEdgeScroll(x, y)
			edDrawFree()
			
		elseif ed.butId = BUT_EDITOR_LINE
			
			edGfxMoved(x, y)
			edCheckEdgeScroll(x, y)
			edDrawLine()	
				
		elseif ed.butId = BUT_EDITOR_SHAPE
			
			edGfxMoved(x, y)
			edCheckEdgeScroll(x, y)
			edDrawShape()
						
		elseif ed.butId = BUT_EDITOR_PAN
			
			if coDist(ed.scroll.firstX, ed.scroll.firstY, x, y) > ED_HOLD_DIST			
				ed.scroll.holding = true
			endif		
			
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// 
function edDrawFree()

	local b as Bounds
	local mask as integer

	edSetSel(ed.gfx.work)
	b.x0 = ed.gfx.sp.x
	b.y0 = ed.gfx.sp.y
	b.x1 = ed.gfx.ep.x
	b.y1 = ed.gfx.ep.y
	edCorrectSnap(b, false)
	//coMemDrawLine(ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.col, ed.gfx.lineSize, ed.gfx.lineStyle)		
	coMemDrawLine(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.col, ed.gfx.lineSize, ed.gfx.lineStyle)		
	ed.gfx.sp.x = ed.gfx.ep.x
	ed.gfx.sp.y = ed.gfx.ep.y
	//edShowCoords(false, true, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y)
	edShowCoords(false, true, b.x0, b.y0, b.x1, b.y1)
	ed.gfx.workDirty = true

endfunction

//-----------------------------------------------------
// 
function edDrawLine()

	local b as Bounds		
	local mask as integer
	
	edClearWork()
	edSetSel(ed.gfx.work)
	b.x0 = ed.gfx.sp.x
	b.y0 = ed.gfx.sp.y
	b.x1 = ed.gfx.ep.x
	b.y1 = ed.gfx.ep.y
	edCorrectSnap(b, false)
	//coMemDrawLine(ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.col, ed.gfx.lineSize, ed.gfx.lineStyle)		
	coMemDrawLine(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.col, ed.gfx.lineSize, ed.gfx.lineStyle)		
	//edShowCoords(true, true, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y)
	edShowCoords(false, true, b.x0, b.y0, b.x1, b.y1)
	ed.gfx.workDirty = true
	
endfunction

//-----------------------------------------------------
// 
function edDrawShape()

	local lineSize as integer
	local lineStyle as integer
	local b as Bounds
	local dx as float
	local dy as float
	local t as float
	local h as float
		
	edClearWork()
	edSetSel(ed.gfx.work)	
					
	//if ed.filledButId > -1
	if ed.gfx.shapeFilled
		lineSize = 0
	else
		lineSize = ed.gfx.lineSize
	endif

	//if ed.shapeButId = BUT_EDITOR_RECT
	if ed.gfx.drawShape = CO_SHAPE_RECT

		b.x0 = ed.gfx.sp.x
		b.y0 = ed.gfx.sp.y
		b.x1 = ed.gfx.ep.x
		b.y1 = ed.gfx.ep.y
		edCorrectSnap(b, false)											

		//if ed.sameButId = -1
		if not ed.gfx.shapeSameWH

			//coMemDrawRect(ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.col, lineSize)
			coMemDrawRect(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.col, lineSize)
			//edShowCoords(true, true, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y)
			edShowCoords(true, true, b.x0, b.y0, b.x1, b.y1)

		else
			
			dx = abs(b.x1 - b.x0)
			dy = abs(b.y1 - b.y0)

			if b.x0 > b.x1
				
				if dx > dy							
					b.x1 = b.x1 + (dx - dy)
				endif

			else 
				
				if dx > dy						
					b.x1 = b.x1 - (dx - dy)
				endif
					
			endif
		
			if b.y0 > b.y1
				
				if dy > dx		
					b.y1 = b.y1 + (dy - dx)				
				endif

			else 
				
				if dy > dx		
					b.y1 = b.y1 - (dy - dx)				
				endif

			endif

			coMemDrawRect(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.col, lineSize)	
			edShowCoords(true, true, b.x0, b.y0, b.x1, b.y1)
			
		endif

	//elseif ed.shapeButId = BUT_EDITOR_OVAL	
	elseif ed.gfx.drawShape = CO_SHAPE_OVAL									

		b.x0 = ed.gfx.sp.x
		b.y0 = ed.gfx.sp.y
		b.x1 = ed.gfx.ep.x
		b.y1 = ed.gfx.ep.y
		edCorrectSnap(b, false)											

		//if ed.sameButId = -1
		if not ed.gfx.shapeSameWH
			
			coMemDrawOval(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.col, lineSize)
			edShowCoords(true, true, b.x0, b.y0, b.x1, b.y1)
	
		else									
	
			dx = abs(b.x1 - b.x0)
			dy = abs(b.y1 - b.y0)

			if b.x0 > b.x1
				
				if dx > dy							
					b.x1 = b.x1 + (dx - dy)
				endif

			else 
				
				if dx > dy						
					b.x1 = b.x1 - (dx - dy)
				endif
					
			endif
		
			if b.y0 > b.y1
				
				if dy > dx		
					b.y1 = b.y1 + (dy - dx)				
				endif

			else 
				
				if dy > dx		
					b.y1 = b.y1 - (dy - dx)				
				endif

			endif
							
			coMemDrawOval(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.col, lineSize)			
			edShowCoords(true, true,b.x0, b.y0, b.x1, b.y1)

		endif

	//elseif ed.shapeButId = BUT_EDITOR_POLY	
	elseif ed.gfx.drawShape = CO_SHAPE_POLY							

		b.x0 = ed.gfx.sp.x
		b.y0 = ed.gfx.sp.y
		b.x1 = ed.gfx.ep.x
		b.y1 = ed.gfx.ep.y
		edCorrectSnap(b, false)											

		//if ed.sameButId = -1
		if not ed.gfx.shapeSameWH
				
			coMemDrawPoly(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.polySides, ed.gfx.col, lineSize)			
			edShowCoords(true, true, b.x0, b.y0, b.x1, b.y1)

		else
				
			dx = abs(b.x1 - b.x0)
			dy = abs(b.y1 - b.y0)

			if b.x0 > b.x1
				
				if dx > dy							
					b.x1 = b.x1 + (dx - dy)
				endif

			else 
				
				if dx > dy						
					b.x1 = b.x1 - (dx - dy)
				endif
					
			endif
		
			if b.y0 > b.y1
				
				if dy > dx		
					b.y1 = b.y1 + (dy - dx)				
				endif

			else 
				
				if dy > dx		
					b.y1 = b.y1 - (dy - dx)				
				endif

			endif

			if ed.gfx.polySides = 3
				
				h = ((b.x1 - b.x0) / 2) * tan(-120)
				b.y1 = b.y0 + h
				
			endif
	
			coMemDrawPoly(ed.gfx.work, b.x0, b.y0, b.x1, b.y1, ed.gfx.polySides, ed.gfx.col, lineSize)	
			edShowCoords(true, true, b.x0, b.y0, b.x1, b.y1)

		endif
		
	endif
	
	ed.gfx.workDirty = true

endfunction

//-----------------------------------------------------
// 
function edDrawText()

	local img as integer
	local tmp as MemBlock
	local bounds as Bounds
	local w as float
	local h as float
	
	if ed.textButId > -1 and ed.gfx.textEdit <> "" // Text paste is active.

		edClearWork()
		edSetSel(ed.gfx.work)				

		//img = CreateImageColor(0, 0, 0, 0)
		//resizeimage(img, GetTextTotalWidth(ed.gfx.text), GetTextTotalHeight(ed.gfx.text))
		img = CreateRenderImage(GetTextTotalWidth(ed.gfx.text), GetTextTotalHeight(ed.gfx.text), 0, 0)
		SetImageMinFilter(img, 0)
		SetImageMagFilter(img, 0)

		SetRenderToImage(img, 0)
		SetVirtualResolution(GetImageWidth(img), GetImageHeight(img))
		//coSetClearColor(co.red[5])
		//ClearScreen()
	
		h = GetTextTotalHeight(ed.gfx.text)
		SetTextPosition(ed.gfx.text, 0, 0)
		SetTextVisible(ed.gfx.text, true)
		coSetTextColor(ed.gfx.text, ed.gfx.col)
		coSetTextFont(ed.gfx.text, ed.gfx.textFont)
		SetTextSize(ed.gfx.text, ed.gfx.textSize)
		drawtext(ed.gfx.text)
						
		SetRenderToScreen()
		SetVirtualResolution(co.w, co.h)
		//coSetClearColor(ed.clearCol)

		SetTextVisible(ed.gfx.text, false)
		
		coMemFromImage(img, tmp)											
		deleteimage(img)
		
		//coMemPaste(tmp, ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y)
		coMemGetBounds(tmp, bounds)
		w = bounds.x1 - bounds.x0 + 1
		h = bounds.y1 - bounds.y0 + 1
		
		//coMemPasteMask(tmp, ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y, CO_COL_NE, 0)
		if ed.textButId = BUT_EDITOR_TEXT_PLACE
			coMemPasteRectMask(tmp, bounds.x0, bounds.y0, w, h, ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y, CO_COL_NE, 0)
		elseif ed.textButId = BUT_EDITOR_TEXT_PLACE_MID
			coMemPasteRectMask(tmp, bounds.x0, bounds.y0, w, h, ed.gfx.work, ed.gfx.sp.x - w / 2, ed.gfx.sp.y - h / 2, CO_COL_NE, 0)
		endif
		
		coMemDelete(tmp)
						
		edPasteWork()
		ed.textButId = -1
		edAddPixelUndo()
		edShowButtons()

	endif

endfunction

//-----------------------------------------------------
//
function edPasteImage()

	if ed.imageButId > -1 and ed.gfx.imageFile <> "" // Image paste is active.

		edClearWork()
		edSetSel(ed.gfx.work)				

		if ed.imageButId = BUT_EDITOR_IMAGE_PLACE
			coMemPasteNez(ed.gfx.image, ed.gfx.work, ed.gfx.sp.x, ed.gfx.sp.y)
		elseif ed.imageButId = BUT_EDITOR_IMAGE_PLACE_MID
			coMemPasteNez(ed.gfx.image, ed.gfx.work, ed.gfx.sp.x - ed.gfx.image.w / 2, ed.gfx.sp.y - ed.gfx.image.h / 2)
		endif
		
		edPasteWork()
		ed.imageButId = -1
		edAddPixelUndo()
		edShowButtons()
		
	endif

endfunction

//-----------------------------------------------------
// 
function edDrawFill()
	
	local blend as integer
	local undo as integer
	
	edSetSel(ed.gfx.cols)
	undo = coMemSetUndo(ed.gfx.cols, CO_PRE_PIXEL)
	
	if ed.eraseButId > -1
		
		blend = coMemSetBlend(ed.gfx.cols, false)
		coMemDrawFill(ed.gfx.cols, ed.gfx.pp.x, ed.gfx.pp.y, 0)
		coMemSetBlend(ed.gfx.cols, blend)

	else
		
		coMemDrawFill(ed.gfx.cols, ed.gfx.pp.x, ed.gfx.pp.y, ed.gfx.col)
		
	endif

	coMemSetUndo(ed.gfx.cols, undo)	
	coMemRemoveSel(ed.gfx.cols)
	edShowCoords(false, true, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y)
	ed.gfx.drawDirty = true
		
endfunction

//-----------------------------------------------------
// Add a pixel undo.
//
function edAddPixelUndo()
	
	local undo as Change
	
	ed.gfx.undos.insert(undo)
	ed.gfx.undos[ed.gfx.undos.length].typ = ED_CHG_PIXELS
	coMemMovePixels(ed.gfx.cols, ed.gfx.undos[ed.gfx.undos.length].pixels, false)
	edClearChanges(ed.gfx.redos)
	
endfunction

//-----------------------------------------------------
// Add a mb undo.
//
function edAddMbUndo(typ as integer, mb ref as MemBlock, bounds ref as Bounds)
	
	local undo as Change
	
	undo.typ = typ
	coMemGrab(mb, undo.mb, 0, 0, mb.w, mb.h)
	undo.bounds = bounds	
	ed.gfx.undos.insert(undo)
	edClearChanges(ed.gfx.redos)
	
endfunction

//-----------------------------------------------------
// Add a mb undo.
//
function edAddOpUndo(typ as integer, bounds ref as Bounds)
	
	local undo as Change
	
	undo.typ = typ
	undo.bounds = bounds	
	ed.gfx.undos.insert(undo)
	edClearChanges(ed.gfx.redos)
	
endfunction

//-----------------------------------------------------
// Add an img undo, i.e. replace the main img.
//
function edAddImgUndo(img as integer)
	
	local undo as Change
	
	undo.typ = ED_CHG_IMG
	undo.img = img	
	ed.gfx.undos.insert(undo)
	edClearChanges(ed.gfx.redos)
	
endfunction

//-----------------------------------------------------
// Clear the change list.
//
function edClearChanges(list ref as Change[])
	
	local i as integer
	
	for i = 0 to list.length
		
		if list[i].typ = ED_CHG_IMG
			if list[i].img
				deleteimage(list[i].img)
			endif
		elseif list[i].typ = ED_CHG_PIXELS
			list[i].pixels.length = -1
		elseif list[i].typ = ED_CHG_MB
			if list[i].mb.id
				coMemDelete(list[i].mb)
			endif
		elseif list[i].typ = ED_CHG_MB2
			if list[i].mb.id
				coMemDelete(list[i].mb)
			endif
		endif
		
	next
	
	list.length = -1
	
endfunction

//-----------------------------------------------------
// Do an undo from the undos list, and put a redo into the redos list.
// mb is the memblock to affect, e.g. ed.gfx.cols. Only works with PIXELS and MB types.
//
function edUndo(mb ref as MemBlock, undos ref as Change[], redos ref as Change[], saveRedo as integer)
	
	local undo as integer
	local blend as integer
	local redo as Change
	local redo2 as Change
	local img as integer
	
	if undos.length = -1
		exitfunction
	endif
	
	if undos[undos.length].typ = ED_CHG_PIXELS

		coMemCopyPixels(undos[undos.length].pixels, mb)
		
		undo = coMemSetUndo(mb, CO_PRE_PIXEL)		
		blend = coMemSetBlend(mb, false)
		coMemUndoPixels(mb)
		coMemSetBlend(mb, blend)
		coMemSetUndo(mb, undo)
		undos.remove()
		edSetMemDirty(mb)

		if saveRedo
			
			redos.insert(redo)
			redos[redos.length].typ = ED_CHG_PIXELS
			coMemMovePixels(mb, redos[redos.length].pixels, false)

		else 
			
			coMemClearUndo(mb)
						
		endif
		
	elseif undos[undos.length].typ = ED_CHG_MB

		if saveRedo
			
			redo.typ = ED_CHG_MB
			coMemGrab(mb, redo.mb, undos[undos.length].bounds.x0, undos[undos.length].bounds.y0, undos[undos.length].bounds.x1 - undos[undos.length].bounds.x0 + 1, undos[undos.length].bounds.y1 - undos[undos.length].bounds.y0 + 1)
			redo.bounds.x0 = undos[undos.length].bounds.x0
			redo.bounds.x1 = undos[undos.length].bounds.x1
			redo.bounds.y0 = undos[undos.length].bounds.y0
			redo.bounds.y1 = undos[undos.length].bounds.y1

		endif
				
		blend = coMemSetBlend(mb, false)
		coMemPaste(undos[undos.length].mb, mb, undos[undos.length].bounds.x0, undos[undos.length].bounds.y0)
		coMemSetBlend(mb, blend)
		coMemDelete(undos[undos.length].mb)
		undos.remove()
		edSetMemDirty(mb)

		if saveRedo
			redos.insert(redo)
		endif

	elseif undos[undos.length].typ = ED_CHG_MB2
			
		if saveRedo
			
			// If doing MB2, first is sel, then cols.
			redo2.typ = ED_CHG_MB2
			coMemGrab(ed.gfx.sel.sel, redo2.mb, undos[undos.length].bounds.x0, undos[undos.length].bounds.y0, undos[undos.length].bounds.x1 - undos[undos.length].bounds.x0 + 1, undos[undos.length].bounds.y1 - undos[undos.length].bounds.y0 + 1)
			redo2.bounds.x0 = undos[undos.length].bounds.x0
			redo2.bounds.x1 = undos[undos.length].bounds.x1
			redo2.bounds.y0 = undos[undos.length].bounds.y0
			redo2.bounds.y1 = undos[undos.length].bounds.y1
	
		endif
			
		coMemClear(ed.gfx.sel.sel)			
		coMemPaste(undos[undos.length].mb, ed.gfx.sel.sel, undos[undos.length].bounds.x0, undos[undos.length].bounds.y0)
		coMemDelete(undos[undos.length].mb)
		edSetMemDirty(ed.gfx.sel.sel)
	
		undos.remove() // Remove last item.
		
		if undos.length > -1 // Should still be undos as we are doing MB2

			if undos[undos.length].typ = ED_CHG_MB2 // Make sure the next one is also MB2.

				if saveRedo
					
					redo.typ = ED_CHG_MB2
					coMemGrab(mb, redo.mb, undos[undos.length].bounds.x0, undos[undos.length].bounds.y0, undos[undos.length].bounds.x1 - undos[undos.length].bounds.x0 + 1, undos[undos.length].bounds.y1 - undos[undos.length].bounds.y0 + 1)
					redo.bounds.x0 = undos[undos.length].bounds.x0
					redo.bounds.x1 = undos[undos.length].bounds.x1
					redo.bounds.y0 = undos[undos.length].bounds.y0
					redo.bounds.y1 = undos[undos.length].bounds.y1
				
				endif
								
				blend = coMemSetBlend(mb, false)	
				coMemPaste(undos[undos.length].mb, mb, undos[undos.length].bounds.x0, undos[undos.length].bounds.y0)
				coMemDelete(undos[undos.length].mb)
				coMemSetBlend(mb, blend)
				undos.remove()
				edSetMemDirty(mb)

			endif
			
		endif
		
		if saveRedo
			
			redos.insert(redo)
			redos.insert(redo2)
			
		endif
	
	elseif undos[undos.length].typ = ED_CHG_FLIP_X
		
		coMemFlipX(mb, 0, 0, undos[undos.length].bounds.x1 - undos[undos.length].bounds.x0 + 1, undos[undos.length].bounds.y1 - undos[undos.length].bounds.y0 + 1)
		undos.remove()
		edSetMemDirty(mb)

		if saveRedo
			
			redos.insert(redo)
			redos[redos.length].typ = ED_CHG_FLIP_X
			
		endif

	elseif undos[undos.length].typ = ED_CHG_FLIP_Y

		coMemFlipY(mb, 0, 0, undos[undos.length].bounds.x1 - undos[undos.length].bounds.x0 + 1, undos[undos.length].bounds.y1 - undos[undos.length].bounds.y0 + 1)
		undos.remove()
		edSetMemDirty(mb)

		if saveRedo
			
			redos.insert(redo)
			redos[redos.length].typ = ED_CHG_FLIP_Y
			
		endif

	elseif undos[undos.length].typ = ED_CHG_ROT_LEFT
			
		coMemRotate(mb, true)
		undos.remove()
		edSetMemDirty(mb)

		if saveRedo

			redos.insert(redo)
			redos[redos.length].typ = ED_CHG_ROT_RIGHT
			
		endif

		img = coMemToImage(mb)
		coMemDelete(mb)
		edReset(img)

	elseif undos[undos.length].typ = ED_CHG_ROT_RIGHT
			
		coMemRotate(mb, false)
		undos.remove()
		edSetMemDirty(mb)

		if saveRedo

			redos.insert(redo)
			redos[redos.length].typ = ED_CHG_ROT_LEFT
			
		endif

		img = coMemToImage(mb)
		coMemDelete(mb)
		edReset(img)

	elseif undos[undos.length].typ = ED_CHG_IMG

		if saveRedo
					
			redos.insert(redo)
			redos[redos.length].typ = ED_CHG_IMG
			redos[redos.length].img = coMemToImage(mb)

		endif
		
		img = undos[undos.length].img
		undos.remove()
		edReset(img)

	endif
	
endfunction

//-----------------------------------------------------
// 
function edSetMemDirty(mb ref as MemBlock)
	
	if mb.id = ed.gfx.cols.id
		ed.gfx.drawDirty = true
	elseif mb.id = ed.gfx.work.id
		ed.gfx.workDirty = true
	elseif mb.id = ed.gfx.sel.sel.id
		ed.gfx.sel.dirty = true
	endif

endfunction

//-----------------------------------------------------
// 
function edReleased(x as float, y as float)

	local butId as integer
	local obj as integer
	local cmd as integer
	local snap as integer
	
	if cdIsEditActive()

		cdReleased(x, y)
		exitfunction
		
	elseif cd.subMode = CD_SUBMODE_EDIT_EDITOR_IMAGE

		cdReleased(x, y)
		exitfunction

	endif
	
	if ed.mode = ED_MODE_MORE_BAR

		butId = guiCheckBarReleased(ed.moreBar, x, y, 1)

		if butId > -1 and butId = ed.pressedButId // Needs to be the same.

			ed.pressedButId = -1
			
			// Reset state.
			if ed.butId <> butId
				
				ed.pickerButId = -1
				ed.imageButId = -1
				ed.textButId = -1
				
			endif
			
			if ed.gfx.sel.lining			
				edFinishLineSel()
			endif

			//if ed.gfx.sel.filling				
			//	edFinishFillSel()
			//endif
			
			ed.butId = butId
			edShowButtons()	
			edShowCoords(false, false, 0, 0, 0, 0)
		
		endif
				
	elseif ed.mode = ED_MODE_SUB_BAR

		butId = edCheckSubBarReleased(x, y)

		if butId > -1 and butId = ed.pressedButId // Needs to be the same.
			
			ed.pressedButId = -1
			edShowCoords(false, false, 0, 0, 0, 0)
			edSubButtonAction(butId, 0)
			
		endif
			
	elseif ed.mode = ED_MODE_SEL_MOVE

		edGfxReleased(x, y)	
		
		// Remember selection.
		ed.gfx.sel.sp = ed.gfx.sp	
		ed.gfx.sel.sp = ed.gfx.ep
		edSwapCoords(ed.gfx.sel.sp, ed.gfx.sel.ep)
		ed.gfx.sel.active = true // Active.

	elseif ed.mode = ED_MODE_GFX
		
		if ed.butId = BUT_EDITOR_SELECT

			edGfxReleased(x, y)	
						
			if ed.gfx.sel.active				

				// Remember selection.
				//ed.gfx.sel.sp = ed.gfx.sp	
				//ed.gfx.sel.ep = ed.gfx.ep
				//edSwapCoords(ed.gfx.sel.sp, ed.gfx.sel.ep)

				if ed.gfx.selShape = CO_SEL_FREE

					snap = coMemSnapPixels(ed.gfx.sel.sel, true)
					coMemDrawLine(ed.gfx.sel.sel, ed.gfx.pp.x, ed.gfx.pp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)		
					coMemSnapPixels(ed.gfx.sel.sel, snap)
					edClearWork()
					coMemFillLasso(ed.gfx.sel.sel, ed.gfx.sel.col)
					ed.gfx.sel.dirty = true

				elseif ed.gfx.selShape = CO_SEL_LINE
					
					snap = coMemSnapPixels(ed.gfx.sel.sel, true)
					coMemDrawLine(ed.gfx.sel.sel, ed.gfx.sp.x, ed.gfx.sp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)		
					coMemSnapPixels(ed.gfx.sel.sel, snap)
					edClearWork()
					snap = coMemSnapPixels(ed.gfx.work, true)
					coMemDrawLine(ed.gfx.work, ed.gfx.pp.x, ed.gfx.pp.y, ed.gfx.ep.x, ed.gfx.ep.y, ed.gfx.sel.col, 1, 0)		
					coMemSnapPixels(ed.gfx.work, snap)
					ed.gfx.sel.sp = ed.gfx.ep
					ed.gfx.sel.ep = ed.gfx.pp
					ed.gfx.sel.dirty = true
					ed.gfx.workDirty = true

				endif
								
			endif
			
			edShowButtons()

		elseif ed.butId = BUT_EDITOR_DRAW
			
			edGfxReleased(x, y)
			edPasteWork()
			edAddPixelUndo()
			edShowButtons()
	
		elseif ed.butId = BUT_EDITOR_LINE
			
			edGfxReleased(x, y)
			edPasteWork()
			edAddPixelUndo()
			edShowButtons()
	
		elseif ed.butId = BUT_EDITOR_SHAPE
			
			edGfxReleased(x, y)
			edPasteWork()
			edAddPixelUndo()
			edShowButtons()
			
		elseif ed.butId = BUT_EDITOR_PAN
	
			ed.scroll.holding = False			
			// Put the first click origins into a galaxy far, far away. 
			ed.scroll.firstX = - 0xFFFFFF
			ed.scroll.firstY = - 0xFFFFFF  //Prevents re-clicks from instantly stopping the scroller on the next poll.
			
		endif
		
	endif

	guiHideTip(gui.tip)	
	ed.mode = ED_MODE_NONE	
	ed.pressed = false
	ed.scroll.zone = 0

endfunction

//-----------------------------------------------------
// object update.
//
function edOnObjUpdate(obj as integer)

	if cdIsEditActive()

		cdOnObjUpdate(obj)
		exitfunction
		
	endif

endfunction

//-----------------------------------------------------
// Timer tick.
//
function edOnObjTimer(obj as integer)

	if cdIsEditActive()

		cdOnObjTimer(obj)
		exitfunction
		
	endif

endfunction

//-----------------------------------------------------
// 
function edUpdate(delta as float)

	if cdIsEditActive()

		edDrawImage()
		cdUpdate(delta)
		exitfunction
		
	endif
	
	if in.ptrPressed

		edPressed(in.ptrX, in.ptrY)

	elseif in.ptrDown

		edMoved(in.ptrX, in.ptrY)			
		
	elseif in.ptrReleased

		edReleased(in.ptrX, in.ptrY)
			
	endif

	if ed.butId = BUT_EDITOR_PAN		
		edScrollUpdate(in.ptrX, in.ptrY)
	endif

	if ed.gfx.cols.id		
		edDrawImage()
	endif
	
endfunction

//
//
//

