#option_explicit

//-----------------------------------------------------
global cd as Coder
//-----------------------------------------------------

#constant CD_MODE_NONE 0
#constant CD_MODE_GRP 1 // Grp button selected.
#constant CD_MODE_DRAG_CMD 2 // Cmd button selected.
#constant CD_MODE_WAIT_CODE 3 
#constant CD_MODE_DRAG_CODE 4
#constant CD_MODE_CODE_BAR 5
#constant CD_MODE_CODE_TAB 6
#constant CD_MODE_TOOL_BAR 7
#constant CD_MODE_VAR_ITEM_BAR 8
#constant CD_MODE_WAIT_CMD 9
#constant CD_MODE_CMD_BAR 10
#constant CD_MODE_APP_BAR 11
#constant CD_MODE_SPRITE_BAR 12
#constant CD_MODE_WAIT_SPRITE 13
#constant CD_MODE_DRAG_SPRITE 14
#constant CD_MODE_DRAG_FRAME 15
#constant CD_MODE_KEY_BAR 16
#constant CD_MODE_CMD_PANEL 17
#constant CD_MODE_CODE_PANEL 18
#constant CD_MODE_APP_PANEL 19
#constant CD_MODE_THING_PANEL 20
#constant CD_MODE_WAIT_APP 21
#constant CD_MODE_DRAG_APP 22
#constant CD_MODE_FILE_TAB 23
#constant CD_MODE_LOAD_PANEL 24
#constant CD_MODE_IMAGE_ITEM_BAR 25
#constant CD_MODE_WAIT_ITEM 26
#constant CD_MODE_WAIT_FRAME 27
#constant CD_MODE_FRAME_BAR 28
#constant CD_MODE_VAR_BAR 29
#constant CD_MODE_EDIT_PART 30
//#constant CD_MODE_SETTINGS_PANEL 31
#constant CD_MODE_APP_BUT 32
#constant CD_MODE_THING_BUT 33
#constant CD_MODE_SETTING_BUT 34
#constant CD_MODE_CODE_BUT 35
#constant CD_MODE_MAIN_BAR 36
#constant CD_MODE_LIB_BUT 37
#constant CD_MODE_IMAGE_BLANK_ITEM_BAR 38
#constant CD_MODE_HELP_BUT 39
#constant CD_MODE_HELP_BAR 40
#constant CD_MODE_CMD_BUT 41
#constant CD_MODE_WAIT_CODE_PANEL 42
#constant CD_MODE_CODE_PANEL_BAR 43
#constant CD_MODE_DRAG_ITEM 44
#constant CD_MODE_PROJ_ITEM_BAR 45
#constant CD_MODE_THING 46
#constant CD_MODE_WAIT_VAR 47
#constant CD_MODE_DRAG_VAR 48
#constant CD_MODE_PART_HELP 49
#constant CD_MODE_WAIT_VAR_VALUE 50
#constant CD_MODE_DRAG_SOUND 51
#constant CD_MODE_DRAG_VIDEO 52
#constant CD_MODE_DRAG_VAR_VALUE 53
#constant CD_MODE_WAIT_SOUND 54
#constant CD_MODE_WAIT_VIDEO 55
#constant CD_MODE_VAR_VALUE_BAR 56
#constant CD_MODE_SOUND_BAR 57
#constant CD_MODE_VIDEO_BAR 58
#constant CD_MODE_HELP_PANEL 59
#constant CD_MODE_SOUND_ITEM_BAR 60
#constant CD_MODE_VIDEO_ITEM_BAR 61
#constant CD_MODE_WAIT_PART 62
#constant CD_MODE_WAIT_HELP 63
#constant CD_MODE_PART_BAR 64
#constant CD_MODE_FOLDER_ITEM_BAR 65
//#constant CD_MODE_SETTINGS_BAR 66
#constant CD_MODE_VAR_VALUE_ITEM_BAR 67
#constant CD_MODE_PROJ_BLANK_ITEM_BAR 68
#constant CD_MODE_MORE_BAR 69

#constant CD_SUBMODE_NONE 0
#constant CD_SUBMODE_NEW_APP 1
#constant CD_SUBMODE_NEW_THING 2
#constant CD_SUBMODE_NEW_VALUE 3 // New var value.
#constant CD_SUBMODE_DUP_APP 4
#constant CD_SUBMODE_EDIT_PART 5
#constant CD_SUBMODE_RENAME_APP 6
#constant CD_SUBMODE_RENAME_THING 7
#constant CD_SUBMODE_RENAME_ITEM_FOLDER 8
#constant CD_SUBMODE_PRELOAD 9
#constant CD_SUBMODE_RENAME_ITEM 10
#constant CD_SUBMODE_DELETE_ITEM 11
#constant CD_SUBMODE_EDIT_IMAGE_TEXT 12
#constant CD_SUBMODE_DUP_THING 13
#constant CD_SUBMODE_DUP_LIB_THING 14
#constant CD_SUBMODE_COPY_THING_TO_LIB 15
#constant CD_SUBMODE_DUP_LIB_APP 16
#constant CD_SUBMODE_EDIT_IMAGE_GRID_ROWS 17
#constant CD_SUBMODE_EDIT_IMAGE_GRID_COLS 18
#constant CD_SUBMODE_EDIT_IMAGE_COLOR 19
#constant CD_SUBMODE_EDIT_SETTINGS_GRID_ROWS 20
#constant CD_SUBMODE_EDIT_SETTINGS_GRID_COLS 21
#constant CD_SUBMODE_EDIT_VAR_VALUE 22 // Edit a var value.
#constant CD_SUBMODE_EDIT_DESIGN_TITLE_COL 23
#constant CD_SUBMODE_EDIT_DESIGN_BOX_COL 24
#constant CD_SUBMODE_EDIT_DESIGN_TEXT_COL 25
#constant CD_SUBMODE_EDIT_DESIGN_VARBG_COL 26
#constant CD_SUBMODE_EDIT_IMAGE_SIZE 27
#constant CD_SUBMODE_EDIT_IMAGE_TEXT_SIZE 28
#constant CD_SUBMODE_EDIT_RESIZE 29
#constant CD_SUBMODE_EDIT_DESIGN_TITLE_ALIGN 30
#constant CD_SUBMODE_EDIT_DESIGN_TEXT_ALIGN 31
#constant CD_SUBMODE_EDIT_DESIGN_TITLE_POS 32
#constant CD_SUBMODE_EDIT_DESIGN_TITLE_FONT_SIZE 33
#constant CD_SUBMODE_EDIT_DESIGN_TEXT_FONT_SIZE 34
#constant CD_SUBMODE_EDIT_EDITOR_COL 35
#constant CD_SUBMODE_EDIT_EDITOR_GRID_ROWS 36
#constant CD_SUBMODE_EDIT_EDITOR_GRID_COLS 37
#constant CD_SUBMODE_EDIT_EDITOR_LINE_SIZE 38
#constant CD_SUBMODE_EDIT_EDITOR_TEXT_SIZE 39
#constant CD_SUBMODE_EDIT_EDITOR_TEXT_EDIT 40
#constant CD_SUBMODE_EDIT_EDITOR_POLY_SIZE 41
#constant CD_SUBMODE_EDIT_EDITOR_IMAGE 42
#constant CD_SUBMODE_EDIT_EDITOR_RESIZE 43
#constant CD_SUBMODE_EDIT_EDITOR_GRID_WIDTH 44
#constant CD_SUBMODE_EDIT_EDITOR_GRID_HEIGHT 45
#constant CD_SUBMODE_EDIT_DESIGN_TITLE_FONT 46
#constant CD_SUBMODE_EDIT_DESIGN_TEXT_FONT 47
#constant CD_SUBMODE_EDIT_EDITOR_TEXT_FONT 48
#constant CD_SUBMODE_EDIT_SETTINGS_GRID_WIDTH 49
#constant CD_SUBMODE_EDIT_SETTINGS_GRID_HEIGHT 50
#constant CD_SUBMODE_EDIT_DESIGN_BG_COLOR 51
#constant CD_SUBMODE_EDIT_VAR_VALUE_NAME 52 // Edit a var value.
#constant CD_SUBMODE_EDIT_DESIGN_SCREEN 53

#constant CD_CMD_GAP 8
#constant CD_CODE_INDENT 32
//#constant CD_CMD_GAP 8
#constant CD_CODE_TAB_COUNT 5
#constant CD_CODE_HOLD_DIST 42
#constant CD_CODE_HOLD_TIME 400 // 200 The time to wait before showing a popup.
#constant CD_CODE_DRAG_TIME 50 // 200 The time to wait before engaging a drag of a cmd.
#constant CD_CMD_COUNT 200 // Maximum nbr cmds.
#constant CD_TEXT_OFF 4
#constant CD_CURSOR_TIMER 20
#constant CD_PART_FLASH_TIMER 1
#constant CD_ANIM_TIMER 1
#constant CD_KEY_PRESS_TIMER 5
#constant CD_PING_TIMER 1
#constant CD_PING_COUNT 10
#constant CD_CODE_EDGE 64
#constant CD_CODE_SCROLL_DIST 10
#constant CD_CODE_SCROLL_TIME 20
#constant CD_CODE_SCROLL_WAIT 600
#constant CD_CODE_DOUBLE_TAP_TIME 550
#constant CD_PREV_VALUES_MAX 20
#constant CO_EDIT_CLICK_DOUBLE_TAP_TIME 500

#constant CD_TAB_APP 0
#constant CD_TAB_THING 1
#constant CD_TAB_CMD 2
#constant CD_TAB_SETTINGS 3
#constant CD_TAB_CODE 4
#constant CD_TAB_APP_LIBRARY 5
#constant CD_TAB_SPRITE_LIBRARY 6
#constant CD_TAB_NAME_LIBRARY 7
#constant CD_TAB_SOUND_LIBRARY 8
#constant CD_TAB_VIDEO_LIBRARY 9

#constant CD_FILE_TAB_CODE 0
#constant CD_FILE_TAB_LIBRARY 1
#constant CD_FILE_TAB_HELP 2

#constant CD_KBD_LOWER 0
#constant CD_KBD_UPPER 1
#constant CD_KBD_NUMSYM 2
#constant CD_KBD_SYM2 3
#constant CD_KBD_NUMONLY 4
#constant CD_KBD_COLOR 5
#constant CD_KBD_MAX 5

#constant CD_KEYSET_NAME 0
#constant CD_KEYSET_INTEGER 1
#constant CD_KEYSET_DECIMAL 2
#constant CD_KEYSET_ALL 3
#constant CD_KEYSET_COLOR 4
#constant CD_KEYSET_MAX 4

#constant CD_KEYRULE_NONE 0 // No rule.
#constant CD_KEYRULE_INTEGER 1 // Only 1 period, not at the end.
#constant CD_KEYRULE_DECIMAL 2 // Only 1 period, not at the end.
#constant CD_KEYRULE_COLOR 3 // rrggbb as hex, or rrrgggbbb as decimal.
#constant CD_KEYRULE_NAME 4 // Names must start with a letter, then letters and numbers.

#constant CD_CHECK_LEFT 0
#constant CD_CHECK_AFTER_FOLD 1
#constant CD_CHECK_RIGHT 2

#constant CD_FOLD_LEFT 0
#constant CD_FOLD_RIGHT 1

#constant CD_PROJ_VAR_PREFIX "^"

//#constant CD_CMD_EDGE_W 24
//#constant CD_CMD_EDGE_H 64

#constant CD_MAIN_PANEL 10
#constant CD_APP_PANEL 20
#constant CD_THING_PANEL 30
#constant CD_CODE_PANEL 40
#constant CD_LOAD_PANEL 50
#constant CD_KEY_PANEL 60
#constant CD_GRP_PANEL 70
//#constant CD_SETTINGS_PANEL 80
#constant CD_HELP_PANEL 90
#constant CD_EDIT_CTRL_PANEL 91
#constant CD_EDIT_DATA_PANEL 92

#constant CD_EDIT_NONE 0
#constant CD_EDIT_TEXT 1
#constant CD_EDIT_COLOR 2
#constant CD_EDIT_TAGS 3
#constant CD_EDIT_END 4

#constant CD_CLIP_CUT 1 // Cut a code block via popup menu.
#constant CD_CLIP_COPY 2 // Copied a code block via popup menu.
#constant CD_CLIP_DROP_DEL 3 // Delete code, dropped outside of code panel.
#constant CD_CLIP_DROP 4 // Dropped a cmd on the code panel.
#constant CD_CLIP_SNAP 5 // Added a part cmd to a part in the code panel.
#constant CD_CLIP_EDIT 6 // Edit the value of a part.
#constant CD_CLIP_LIFT 7 // Position of code when lifted off code panel.
#constant CD_CLIP_CUT_DEL 8 // Delete via a menu, like cut but not to clipboard.
#constant CD_CLIP_SNAP_LIFT 9 // Special lift of a oper snapped into a part.

#constant CD_CLIPMODE_NONE 0 // Normal mode, not undo or redo.
#constant CD_CLIPMODE_UNDO 1 
#constant CD_CLIPMODE_REDO 2

#constant CD_ITEMS_PER_ROW 4
#constant CD_DRAW_SIZE_MAX 50
#constant CD_TEXT_SIZE_MAX 200

#constant OBJ_VAR_EDGES "edges"
#constant OBJ_VAR_WRAP "wrap"
#constant OBJ_VAR_EDGE "edge"
#constant OBJ_VAR_TITLE_ALIGN "title align"
#constant OBJ_VAR_TEXT_ALIGN "value align"
#constant OBJ_VAR_FONT "font"
#constant OBJ_VAR_FONT_SIZE "fontsize"
#constant OBJ_VAR_SPRITE "sprite"
#constant OBJ_VAR_FRAME "frame"
#constant OBJ_VAR_STOP "type" // For stop cmd.
#constant OBJ_VAR_STYLE "style" // For pens.
#constant OBJ_VAR_VALUE "var"
#constant OBJ_VAR_LIST "list"
#constant OBJ_VAR_VAR "var"
#constant OBJ_VAR_INFO "info"
#constant OBJ_VAR_BOUNCE "bounce"
#constant OBJ_VAR_OPER "math"
#constant OBJ_VAR_CMP "compare"
#constant OBJ_VAR_BOOL "logic"
#constant OBJ_VAR_BITS "bits"
#constant OBJ_VAR_EVENT "event"
#constant OBJ_VAR_KEY "key"
#constant OBJ_VAR_JOIN "join"
#constant OBJ_VAR_SCREEN "screen"
#constant OBJ_VAR_SHAPE "shape"
#constant OBJ_VAR_TO "to"

#constant CD_EDIT_MODE_NONE 0
#constant CD_EDIT_MODE_DRAG_BOX 1
#constant CD_EDIT_MODE_ROT_BOX 2
#constant CD_EDIT_MODE_PANEL 3
#constant CD_EDIT_MODE_TOOL 4
#constant CD_EDIT_MODE_SELECT 5
#constant CD_EDIT_MODE_LINE 6
#constant CD_EDIT_MODE_OVAL 7
#constant CD_EDIT_MODE_RECT 8
#constant CD_EDIT_MODE_RESIZE_BOX 9
#constant CD_EDIT_MODE_DRAW 10
#constant CD_EDIT_MODE_FILL 11
#constant CD_EDIT_MODE_PICK 12
#constant CD_EDIT_MODE_COLOR_BAR 13
#constant CD_EDIT_MODE_RECT_BAR 14
#constant CD_EDIT_MODE_OVAL_BAR 15
#constant CD_EDIT_MODE_TEXT 16
#constant CD_EDIT_MODE_IMAGE 17
#constant CD_EDIT_MODE_WAIT_BUT 18
#constant CD_EDIT_MODE_LINE_BAR 19

#constant CD_EDIT_LINE_SIZE 8
#constant CD_EDIT_BOX_EXTRA 32
#constant CD_EDIT_DOT_LINE_SIZE 128
#constant CD_EDIT_SMALLEST_SCALE 0.2

// Depths for edit components higher than the dataPanel depth.
#constant CD_EDIT_BORDER_DEPTH 2
#constant CD_EDIT_DATA_DEPTH 4
#constant CD_EDIT_GRID_DEPTH 6
#constant CD_EDIT_SEL_DEPTH 8
#constant CD_EDIT_WORK_DEPTH 10
#constant CD_EDIT_RUBBER_DEPTH 12

#constant CD_FOLDER_LIBRARY "library"
#constant CD_FOLDER_LIBRARIES "libraries"
#constant CD_FOLDER_MY_PROJECTS "my projects"
#constant CD_FOLDER_SHARED_TO_YOU "community"
#constant CD_FOLDER_EXAMPLES "examples"

#constant CD_HELP_APP 1
#constant CD_HELP_CMD 2
#constant CD_HELP_MAIN 3
#constant CD_HELP_INTER 4 // Interactive help.

#constant CD_EDIT_STYLE_VISIO 0 // Draw anywhere, grab whole sel, burn whole sel - visio-like.
#constant CD_EDIT_STYLE_TRUNC_KEEP_SEL 1 // Draw anywhere, grab whole sel, burn over image.
#constant CD_EDIT_STYLE_TRUNC_SEL 2 // Draw anywhere, grab sel over image, burn that.
#constant CD_EDIT_STYLE_SNAP_SEL 3 // Draw only within image, grab sel over image, burn that.

#constant CD_ZOOM_ONE 0 // Index of the 1.0 scale zoom level.
#constant CD_ZOOM_NONE 0 // Nothing special, just zoom with no moving or work spr.
#constant CD_ZOOM_ADJUST 1 // Zoom is to adjust the zoom level.
#constant CD_ZOOM_DRAW 2 // Zoom is occuring while drawing.

//#constant CD_DEF_HELP_FONT 1

//-----------------------------------------------------
//
type Coder

	mode as integer // The UI mode: CD_MODE_cmd, CD_MODE_drag, etc.
	selCmds as integer[] // The list of commands to select.
	grpTab as integer // The current grp.
	thingTab as integer // The current thing tab.
	mainTab as integer // Projects / Sprites / Code.
	fileTab as integer // Code / Shared / Files.
	currCmds as integer[] // The list of commands detached.
	attachCmd as integer // The selected command.
	attachDir as integer // DIR_N, DIR_S, for cmd, or DIR_W for partIdx.
	attachPartIdx as integer // If Dir = DIR_W.
	detachCmd as integer // The point at which the cmd was lifted and detattached.
	detachDir as integer // The direction of the detach.
	detachPartIdx as integer // The part detached from.
	offX as float // Cmd drag offset.
	offY as float
	
	//topDepth as integer // The highest depth of a drawn cmd, so dragging starts higher.
	imgs as integer[] // All images created, for hide/show, destroy.
	//sprs as integer[] // All sprites created, for hide/show, destroy.
	bg as integer
	grpBar as Toolbar // List of cmd group buttons.
	//mainBar as Toolbar // Toolbar in app/thing/cmd panels, containing run, design, etc.
	toolBar as Toolbar // Controls for code panel, e.g. undo, redo.
	cmdBar as Toolbar // Popup on cmd in code panel.
	partBar as Toolbar // Popup on part in code panel.
	varBar as Toolbar // Popup on var in cmd panel.
	varValueBar as Toolbar // Popup on var value in cmd panel.
	codeBar as Toolbar // Popup on holder the code panel background.
	helpBar as Toolbar // Popup on selcmd to show cmd help.
	appBar as Toolbar // Popup on app in app panel.
	thingBar as Toolbar // The thing tabs on the things tab.
	spriteBar as Toolbar // Popup on thing in thing panel.
	soundBar as Toolbar // Tabs for the sound panels.
	videoBar as Toolbar // Tabs for the video panels.
	fileBar as Toolbar // For file tabs.
	addItemBar as Toolbar // Pop-up for adding a image to the editor.
	imageItemBar as Toolbar // Pop-up for an image item.
	imageBlankItemBar as Toolbar // Pop-up for a blank image item.
	soundItemBar as Toolbar // Pop-up for an sound item.
	videoItemBar as Toolbar // Pop-up for an video item.
	varItemBar as Toolbar // Pop-up for an var item.
	varValueItemBar as Toolbar // Pop-up for an var item.
	projItemBar as Toolbar // Pop-up for an project item.
	projBlankItemBar as Toolbar // Pop-up for an project item.
	folderItemBar as Toolbar // Pop-up for a folder item.
	frameBar as Toolbar // Pop-up for an image.
	//settingsBar as Toolbar // Setting buttons.
	moreBar as Toolbar // The more bar.
	appId as string  // Id of the current app.
	appIdx as integer // short hand.
	thingId as string // Id ofthe current thing, within the current app.
	thingIdx as integer // Convenience for instanting access the current thing.
	grpCols as integer[]
	cmdCols as integer[]
	barCols as integer[]
	dragCols as integer[]
	selCols as integer[]
	itemCols as integer[]
	tabCols as integer[]
	tabBarCols as integer[] // The scroll bar.
	tabPipCols as integer[] // The handles on scrollers.
	//settingsBut as Button
	appBut as Button
	thingBut as Button
	cmdBut as Button
	codeBut as Button
	libraryBut as Button
	helpBut as Button
	dragImg as integer // THe image of the drag icon on cmds.
	appImg as integer // Big version of the project icon.
	loadedImg as integer // The img for the load icon.
	loadedIconImg as integer // The img for the load tag on lib items.
	thingImg as integer // Thing smilie for button.
	codeImg as integer // Code image.
	shareImg as integer // Image of the shared icon.
	unshareImg as integer // Image of the unshared icon.
	builtInImg as integer
	smallBuiltInImg as integer
	sharedByYouImg as integer
	sharedToYouImg as integer
	purchasedImg as integer
	forSaleImg as integer
	appVarImg as integer // Icon for proj var.
	spriteVarImg as integer // Icon for sprite var.
	varButImg as integer 
	soundImg as integer // Sound icon.
	videoImg as integer // Video icon.
	findImg as integer 
	refreshImg as integer
	childImg as integer
	subFolderImg as integer
	backImg as integer
	upImg as integer
	removeImg as integer
	cancelImg as integer
	ltArrImg as integer
	rtArrImg as integer
	transImg as integer
	colTransImg as integer
	cmdScales as float[]
	oldCmdSize as integer
	zoomScale as float
	zoomFontSize as float
	zoomActive as integer
	waitStart as integer
	waitX as float
	waitY as float
	waitIdx as integer
	waitIdx2 as integer
	cmdSelLt as integer // Command selector left.
	cmdSelMid as integer // Command selector mid.
	cmdSelRt as integer // Command selector right.
	thingSel as integer // Thing and proj selector.
	thingSelArrImg as integer // Image for Arrow for thing sel.
	thingSelArr as integer // Arrow for thing sel.
	
	edgeImgs as integer[]
	mainPanel as Panel	
	appPanel as Panel
	loadPanel as Panel
	//thingPanel as Panel	
	//thingPanels as Panel[]	
	cmdPanels as Panel[]
	//settingsPanel as Panel	
	codePanel as Panel
	keyPanel as Panel
	keyPanelX as float
	keyPanelY as float
	helpPanel as Panel
	//closeButImg as integer
	//closeBut as integer
	codeScroll as integer // A rect graphic denoting the scroll area, when over an edge.
	
	qx as float
	qy as float // Quick y value for creating commands.

	// Edit stuff.
	
	editCmd as integer
	editCmdX as float
	editCmdY as float
	editPartIdx as integer
	editCmdTitle as integer
	editBlankAllowed as integer
	editPress as CmdPress
	editClickPos1 as integer
	editClickPos2 as integer
	editSelection as integer
	editClickTime as integer
	editClickCount as integer // Nbr of taps within click time.
	editClickTimePos as integer
	editOrigCol as integer
	editBut as Button // For editing image colors.
	editColorEditor as integer
	
	keyBar as Toolbar[CD_KBD_MAX]
	kbdIdx as integer // The current keyboard.
	keySet as KeySet[CD_KEYSET_MAX]
	keySetIdx as integer
	key as string  // The currently pressed key for repeating.
	keyPresses as KeyPress[]
	scanCode as integer // The currently pressed scanCode for repeating.
	editTitle as integer // The title for the edit box.
	editBox as integer // The one and only edit box.
	editBg as integer
	editText as integer
	editTextX as integer
	prevEditText as string
	colorEditBox as EditBox[]
	resizeEditBox as EditBox[]
	masterEditBox as EditBox // Holds the main text edit field.
	editIdx as integer
	editImgIdx as integer
	topEditX as float
	topEditY as float
	topEditW as float
	acceptBut as Button
	acceptButX as float
	acceptButY as float
	cancelBut as Button
	allBut as Button
	autoAcceptBut as Button
	noneBut as Button
	cursorPos as integer // The location in the edit text for the cursor.
	cursorObj as integer
	cursorObjTimer as integer
	partFlashObj as integer // Holder to use a timer to flash the select part indicator.
	partFlashObjTimer as integer
	partFlashMin as integer
	partFlashMax as integer
	partFlashDelta as integer
	partFlashAlpha as integer
	keyRepeatTime as integer
	keyWaitTime as integer
	fileIdx as integer // The thing or app set when a find is in action.
	fileItemIdx as integer // The selected image.
	varValueIdx as integer // The index of the value within a list var.
	varThingIdx as integer // Thing for a selected var.
	subMode as integer
	foldImg as integer
	tickOnImg as integer
	tickOffImg as integer
	textBoxWidth as float
	textBoxHeight as float
	alphas as string
	digits as string
	syms as string
	choosingImage as integer
	closeImg as integer
	openImg as integer
	//pingImg as integer
	//pingObj as integer // Sprite.
	//pingCounter as integer
	clip as Clip
	clipFull as integer // Have something in the clipboard.
	tmpClip as Clip // The holder for the clip that is being dragged, that may be deleted.
	undos as Clip[] // Holds the undo buffer.
	redos as Clip[] // Holds the redo's.
	clipMode as integer // Normal, undo or redo.
	grabX as float // The x & y of the top currCmd after a grabCmds call. For saving MOVE pos.
	grabY as float
		
	scrollZone as integer // We are in the scroll zone, which direction we are scrolling, e.g. DIR_L
	scrollCount as integer // Number of times we've scrolled to keep timer running.
	scrollTime as integer // The next scroll time.
	//trimWhite as integer // If true, cdDrawCode() with clear all whitespace around the visible cmd area.
	//tidyCode as integer // If true, causes the fix of rect after a draw to reset code to the left.
	gw as float // Width of the last guipanelsetcontentsize.
	gh as float
	targetImg as integer
	target as integer // Spr for the target.
	currLibItem as LibItem
	panelDepth as integer
	tabDepth as integer

	colorBoxes as integer[] // The color boxes to select a color.
	objVars as integer[] // Object vars that are used for PART_OBJ parts.
	editObjIdx as integer // The index into the above objVars
	editMode as integer
	helpDetails as HelpDetails
	//helpInter as HelpInter
	//edimg as EditImage
	//edsel as EditSelect
	//eddrag as EditDrag
	edi as EditImage2 // To allow for the functions required by Editor.
	clearCol as integer
	lastWaitCodeTime as integer // Holds the last time a code cmd was released.
	appFolder as string 
	imageFolder as string
	soundFolder as string
	videoFolder as string

	openAppHelp as string 
	closeAppHelp as string 
	remLibAppHelp as string
	pressed as integer // true if cdPressed already called.
	pressInterHelp as integer // flag to know whether a help item was pressed.

	origName as string // For renaming sprites.
	colInc as integer // If true, we are holding a color inc arrow.
	prevValues as PrevValue[] // Holds all prev values for editors.
	prevValueTitle as integer
	
	player as Player // For playing sounds.
	delete as Delete // For popup delete comfirmation dialog.
		
endtype

type Clip // Clipboard entry.

	typ as integer // CUT, COPY, DELETE, ADDCMD, ADDPART, EDITPART, MOVE.
	cmds as integer[] // What was clipped, except for EDITPART, which uses part.
	part as Part // If an EDITPART clip.
	attachCmd as integer // The detach point, for reattaching.
	attachPartIdx as integer // It was a part.
	attachDir as integer // The dir for reattaching.
	isRoot as integer // Is a root, so we need to restore location.
	grabX as float // The x & y pos of the grab for MOVE typ.
	grabY as float
	
endtype

type KeyRule

	typ as integer
	helpMsg as string
	
endtype

type KeySet

	normSet as string // Normal keys that are allowed.
	specSet as string // Special keys that are allowed.
	hiddenSet as string // For hidden keys.
	helpMsg as string // What to display if the first char is not valid.
	rules as KeyRule[]
	
endtype

type KeyPress 
	
	kbdIdx as integer // The kbd index.
	butIdx as integer // The but within the kbd.
	offTimer as integer // The milli time to switch off.
	
endtype

//
// The drawing pen for code.
//
type CodePen

	x as float
	y as float
	indent as integer
	depth as integer
	
endtype

//
// Type for detecting a press on a cmd.
//
type CmdPress

	idx as integer // The idx into the thing cmd list.
	parentCmd as integer // parent.
	cmd as integer // If > 0, the pressed cmd, otherwise partIdx.
	code as integer // If cmd = 0, then search for code instead.
	partIdx as integer
	
endtype

type StackItem

	openIdx as integer
	closeIdx as integer
	
endtype

type CmdRect

	sort as float
	r as Line
	cmd as integer
	
endtype

type PrevValue
	
	info as string // The string value.
	cmd as integer // Cmd for display.
	typ as integer // The part type.
	
endtype

type VarEntry

	name as string
	varIdx as integer
	selIdx as integer
	
endtype

type HelpDetails

	cmds as integer[]
	cmdIdx as integer // Mark point for copy cmds.
	zcmds as integer[] // Sub cmds, don't want to copy these.
	texts as HelpText[]
	stack as integer[]
	things as integer[]
	vars as integer[]
	sprs as HelpSpr[]
	buts as Button[]
	//apps as integer[]
	x as float
	y as float
	x1 as float
	y1 as float
	y0 as float
	ind as integer
	nbrs as integer[] // The <#> number.
	circImg as integer // Circle image.
	gaps as float[] // One space for each font.
	fontSizeIdx as integer
	bold as integer
	under as integer
	trailIdx as integer
	trail as integer[] // The bread crumb trail of pages.
	pageIdx as integer // The last pageIdx.
	pages as HelpPage[] // string[15, -1]
	currMode as integer
	currIdx as integer
	interactive as integer
	
endtype

type HelpText

	text as integer
	spr as integer
	ox as float
	oy as float
	idx as integer // page of master help, for hyperlinking.
	typ as integer // Goes with idx to specify the type, e.g. CMD or PAGE.
	trailIdx as integer // The list idx in the trail list, or -1.
	
endtype

type HelpSpr

	spr as integer
	ox as float
	oy as float
	
endtype

type HelpPage
	
	name as string
	toks as string[]
	
endtype

type EditImage2
	
	origSpr as integer // fOr resizing.
	resizedSpr as integer
	resizedSpr2 as integer // For resize to smaller size.
	resizedBorderSpr as integer[] // The white background showing the actual size.
	resizedArrow as Button[]
	resizedArrowIdx as integer // The direction of paste.
	thingIdx as integer
	frameIdx as integer
	
endtype

type EditBox

	err as string // The error string.
	title as integer // Text field for title.
	box as integer // EditBox / Sprite for edit box.
	text as integer // Text field for the edit content.
	lt as integer // Left arrow.
	rt as integer // Right arrow.

endtype

type Player
	
	idx as integer // soundIdx or videoIdx
	file as string
	bg as integer
	shdw as integer
	cmd as integer // The sound or video command.
	stopBut as Button	
	loadId as integer
	playId as integer
	typ as integer // CODE_SOUND_BASE or VIDEO_BASE

endtype

type Delete 
	
	tab as integer
	idx as integer
	idx2 as integer
	appIdx as integer
	bg as integer
	shdw as integer
	text as integer
	yesBut as Button	
	noBut as Button
	item as integer // If true, it's a library item, i.e. idx is in ld.libItem[idx]

endtype

//-----------------------------------------------------
// 
function cdInit()

	local thing as Thing // The thing we are coding for.
	local x as float
	local y as float
	local xx as float
	local yy as float
	local but as Button
	local gap as float
	local i as integer
	local col as integer
	local cmd2 as integer
	local cmd3 as integer
	local newPart as Part
	local edgeImg as integer
	local s as string
	local panel as Panel
	local t as integer
	local rule as KeyRule
	local box as integer
	local px as float
	local py as float
	local gx as float
	local gy as float
	local spr as integer
	local depth as integer
	local w as float
	local ww as float
	local h as float
	local hh as float

	// No thing to start.
	cd.appId = ""
	cd.appIdx = -1
	cd.thingId = ""
	cd.thingIdx = -1
	cd.attachCmd = 0
	cd.attachDir = 0
	cd.attachPartIdx = -1
	cd.detachCmd = 0
	cd.detachDir = 0
	cd.detachPartIdx = -1
	cd.offX = 0
	cd.offY = 0
	cd.editCmd = 0
	cd.editPartIdx = -1
	cd.oldCmdSize = ld.set.cmdSize
	cd.cmdScales = [0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
	cd.zoomScale = 1.0
	cd.zoomFontSize = co.fontSizes[gui.cmdFontSize] * cd.zoomScale
	cd.zoomActive = false
	cd.fileItemIdx = -1
	cd.subMode = CD_SUBMODE_NONE
	cd.editClickPos1 = -1
	cd.editClickTime = 0
	cd.editClickCount = 0
	cd.editClickTimePos = 0
	cd.editClickPos2 = -1
	cd.editColorEditor = 1 // Boxes.
	cd.alphas = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	cd.digits = "0123456789"
	cd.syms = "~!@#$%^&*()_+`-=[]\{}|;':" + chr(34) + ",./<>? "
	cd.choosingImage = false
	cd.tmpClip.isRoot = false
	cd.clipFull = false
	cd.clip.isRoot = false
	cd.scrollZone = false
	cd.scrollCount = 0
	cd.scrollTime = 0
	//cd.trimWhite = false
	//cd.tidyCode = false
	cd.clipMode = CD_CLIPMODE_NONE
	cd.lastWaitCodeTime = 0
	cd.appFolder = ""
	cd.imageFolder = ""
	cd.soundFolder = ""
	cd.videoFolder = ""
	cd.colInc = false

	cd.player.idx = -1
	cd.player.bg = 0
	cd.player.loadId = 0
	cd.player.playId = 0
	
	cd.panelDepth = BACK_DEPTH - 10
	cd.tabDepth = BACK_DEPTH - 6
	cd.clearCol = co.bluegrey[5]

	// Add 4, allows for 4 levels 0 to 3.
	cd.helpDetails.nbrs.insert(0)
	cd.helpDetails.nbrs.insert(0)
	cd.helpDetails.nbrs.insert(0)
	cd.helpDetails.nbrs.insert(0)
	
	//cd.helpInter.ptrImg = loadimage("help/ptr7.png")

	//cd.helpDetails.gaps.insert(0.0) // Not used.

	for i = 0 to co.fontSizes.length
		
		t = guiCreateText(" ", i)
		cd.helpDetails.gaps.insert(GetTextTotalHeight(t))
		deletetext(t)

	next 

	cd.helpDetails.circImg = loadimage("gfx/circle.png")
	cd.helpDetails.pageIdx = -1
	
	cd.targetImg = loadimage("gfx/TargetBlack.png")
	cd.target = cocreatesprite("target", cd.targetImg)
	setspritedepth(cd.target, cd.panelDepth - 2)
	SetSpriteVisible(cd.target, false)
	
	t = guiCreateText(" ", gui.cmdFontSize)
	cd.textBoxWidth = co.bs / 4 + co.bs / 8
	//cd.textBoxHeight = co.bs / 4 + co.bs / 8
	cd.textBoxHeight = GetTextTotalHeight(t)
	deletetext(t)
		
	// Events.
	cd.grpCols.insert(co.red[3])
	cd.cmdCols.insert(co.red[8])
	cd.barCols.insert(co.red[3])
	cd.dragCols.insert(co.red[1])
	cd.selCols.insert(co.red[9])
	cd.itemCols.insert(co.red[0])
	// Move.
	cd.grpCols.insert(co.orange[4])
	cd.cmdCols.insert(co.orange[8])
	cd.barCols.insert(co.orange[4])
	cd.dragCols.insert(co.orange[1])
	cd.selCols.insert(co.orange[9])
	cd.itemCols.insert(co.orange[0])
	// Look.
	cd.grpCols.insert(co.amber[3])
	cd.cmdCols.insert(co.amber[7])
	cd.barCols.insert(co.amber[3])
	cd.dragCols.insert(co.amber[1])
	cd.selCols.insert(co.amber[9])
	cd.itemCols.insert(co.amber[0])
	// Flow.
	cd.grpCols.insert(co.green[4])
	cd.cmdCols.insert(co.green[7])
	cd.barCols.insert(co.green[4])
	cd.dragCols.insert(co.green[1])
	cd.selCols.insert(co.green[9])
	cd.itemCols.insert(co.green[0])
	// Sense.
	cd.grpCols.insert(co.lightblue[4])
	cd.cmdCols.insert(co.lightblue[7])
	cd.barCols.insert(co.lightblue[4])
	cd.dragCols.insert(co.lightblue[1])
	cd.selCols.insert(co.lightblue[9])
	cd.itemCols.insert(co.lightblue[0])
	// Output.
	cd.grpCols.insert(co.indigo[3])
	cd.cmdCols.insert(co.indigo[6])
	cd.barCols.insert(co.indigo[3])
	cd.dragCols.insert(co.indigo[1])
	cd.selCols.insert(co.indigo[9])
	cd.itemCols.insert(co.indigo[0])
	// Calc.
	cd.grpCols.insert(co.purple[3])
	cd.cmdCols.insert(co.purple[6])
	cd.barCols.insert(co.purple[3])
	cd.dragCols.insert(co.purple[1])
	cd.selCols.insert(co.purple[9])
	cd.itemCols.insert(co.purple[0])
	// Data.
	cd.grpCols.insert(co.grey[4])
	cd.cmdCols.insert(co.grey[6])
	cd.barCols.insert(co.grey[4])
	cd.dragCols.insert(co.grey[6])
	cd.selCols.insert(co.grey[9])
	cd.itemCols.insert(co.grey[0])
	// Things.
	cd.grpCols.insert(co.teal[2])
	cd.cmdCols.insert(co.teal[7])
	cd.barCols.insert(co.teal[2])
	cd.dragCols.insert(co.teal[7])
	cd.selCols.insert(co.teal[9])
	cd.itemCols.insert(co.teal[0])
	// Vars.
	cd.grpCols.insert(co.brown[3])
	cd.cmdCols.insert(co.brown[7])
	cd.barCols.insert(co.brown[3])
	cd.dragCols.insert(co.brown[7])
	cd.selCols.insert(co.brown[9])
	cd.itemCols.insert(co.brown[0])
	// Sounds.
	cd.grpCols.insert(co.pink[2])
	cd.cmdCols.insert(co.pink[6])
	cd.barCols.insert(co.pink[2])
	cd.dragCols.insert(co.pink[6])
	cd.selCols.insert(co.pink[9])
	cd.itemCols.insert(co.pink[0])
	// Videos.
	cd.grpCols.insert(co.bluegrey[3])
	cd.cmdCols.insert(co.bluegrey[7])
	cd.barCols.insert(co.bluegrey[3])
	cd.dragCols.insert(co.bluegrey[7])
	cd.selCols.insert(co.bluegrey[9])
	cd.itemCols.insert(co.bluegrey[0])
	// Frames.
	cd.grpCols.insert(co.teal[1])
	cd.cmdCols.insert(co.teal[4])
	cd.barCols.insert(co.teal[0])
	cd.dragCols.insert(co.teal[0])
	cd.selCols.insert(co.teal[9])
	cd.itemCols.insert(co.teal[0])
	// Apps.
	cd.grpCols.insert(co.deeppurple[2])
	cd.cmdCols.insert(co.deeppurple[4])
	cd.barCols.insert(co.deeppurple[2])
	cd.dragCols.insert(co.deeppurple[4])
	cd.selCols.insert(co.deeppurple[9])
	cd.itemCols.insert(co.deeppurple[0])

	// Panel colors.

	// Project.
	cd.tabCols.insert(co.deeppurple[2])
	cd.tabBarCols.insert(co.deeppurple[2])
	cd.tabPipCols.insert(co.deeppurple[2])
	// Things.
	cd.tabCols.insert(co.grey[3])
	cd.tabBarCols.insert(co.grey[3])
	cd.tabPipCols.insert(co.grey[3])
	// Cmds.
	cd.tabCols.insert(co.white)
	cd.tabBarCols.insert(co.white)
	cd.tabPipCols.insert(co.white)
	// Settings.
	cd.tabCols.insert(co.yellow[2])
	cd.tabBarCols.insert(co.yellow[2])
	cd.tabPipCols.insert(co.yellow[2])
	// Code.
	cd.tabCols.insert(co.white)
	cd.tabBarCols.insert(co.white)
	cd.tabPipCols.insert(co.grey[4])
	// App Library.
	cd.tabCols.insert(co.deeppurple[1])
	cd.tabBarCols.insert(co.deeppurple[1])
	cd.tabPipCols.insert(co.deeppurple[3])
	// Sprite Library.
	cd.tabCols.insert(co.teal[1])
	cd.tabBarCols.insert(co.teal[1])
	cd.tabPipCols.insert(co.teal[3])
	// Var Library.
	cd.tabCols.insert(co.brown[1])
	cd.tabBarCols.insert(co.brown[1])
	cd.tabPipCols.insert(co.brown[3])
	// Sound Library.
	cd.tabCols.insert(co.pink[1])
	cd.tabBarCols.insert(co.pink[1])
	cd.tabPipCols.insert(co.pink[3])
	// Video Library.
	cd.tabCols.insert(co.bluegrey[1])
	cd.tabBarCols.insert(co.bluegrey[1])
	cd.tabPipCols.insert(co.bluegrey[3])

	cd.grpBar = guiCreateToolbar()
	cd.thingBar = guiCreateToolbar()
	cd.cmdBar = guiCreateToolbar()
	cd.partBar = guiCreateToolbar()
	cd.toolBar = guiCreateToolbar()
	cd.varBar = guiCreateToolbar()
	cd.varValueBar = guiCreateToolbar()
	cd.codeBar = guiCreateToolbar()
	cd.helpBar = guiCreateToolbar()
	cd.appBar = guiCreateToolbar()
	cd.spriteBar = guiCreateToolbar()
	//cd.fileBar = guiCreateToolbar()
	cd.addItemBar = guiCreateToolbar()
	cd.imageItemBar = guiCreateToolbar()
	cd.imageBlankItemBar = guiCreateToolbar()
	cd.soundItemBar = guiCreateToolbar()
	cd.videoItemBar = guiCreateToolbar()
	cd.varItemBar = guiCreateToolbar()
	cd.varValueItemBar = guiCreateToolbar()
	cd.projItemBar = guiCreateToolbar()
	cd.projBlankItemBar = guiCreateToolbar()
	cd.folderItemBar = guiCreateToolbar()
	cd.frameBar = guiCreateToolbar()
	cd.soundBar = guiCreateToolbar()
	cd.videoBar = guiCreateToolbar()
	//cd.edimg.toolbar = guiCreateToolbar()
	//cd.settingsbar = guiCreateToolbar()
	cd.morebar = guiCreateToolbar()

	for i = 0 to cd.keybar.length
		cd.keyBar[i] = guiCreateToolbar()
	next

	//Original iPad.
	//w = co.bs * 5 + co.bs / 2
	//ww = co.bs * 10 - co.bs / 4
	//h = co.bs * 10 + co.bs / 4
	
	// 1:2 split
	w = (co.w - co.bs / 4 * 3) / 3
	ww = w * 2
	// 1:3 split
	//w = (co.w - co.bs / 4 * 3) / 4
	//ww = w * 3
	h = (co.h - co.bs - co.bs / 2 - co.bs / 4)
	
	//
	// Panel around the left panels such as app, thing, cmds, etc.
	//
	cd.mainPanel = guiCreatePanel(w, h, cd.panelDepth, false, false)
	cd.mainPanel.id = CD_MAIN_PANEL
	guiSetPanelPos(cd.mainPanel, co.bs / 4, co.bs + co.bs / 2)

	x = getspritex(cd.mainPanel.panel) + co.bs / 2 + co.bs / 8 + co.bs / 4
	y = getspritey(cd.mainPanel.panel) - co.bs / 2 - co.bs / 8

	cd.dragImg = loadimage("gfx/DragIcon.png")
	cd.appImg = loadimage("gfx/ProjectBlackIcon.png")
	cd.loadedImg = loadimage("gfx/StarIcon.png")
	cd.loadedIconImg = loadimage("gfx/SmallBlackStarIcon.png")
	cd.thingImg = loadimage("gfx/ThingsBlackIcon.png")
	//cd.cmdImg = loadimage("gfx/CmdBlackIcon.png")
	cd.codeImg = loadimage("gfx/CodeBlackIcon.png")
	//cd.settingsImg = loadimage("gfx/Settings2Icon.png")
	cd.foldImg = loadimage("gfx/FoldIcon.png")
	cd.tickOnImg = loadimage("gfx/TickOnIcon.png")
	cd.tickOffImg = loadimage("gfx/TickOffIcon.png")
	cd.shareImg = loadimage("gfx/CloudUpIcon.png")
	cd.unshareImg = loadimage("gfx/CloudNoIcon.png")
	cd.openImg = loadimage("gfx/OpenIcon.png")
	cd.closeImg = loadimage("gfx/CloseIcon.png")
	cd.builtInImg = loadimage("gfx/BuiltinIcon.png")
	cd.smallBuiltInImg = loadimage("gfx/SmallBuiltinIcon.png")
	cd.sharedByYouImg = loadimage("gfx/SmallPublishedIcon.png")
	cd.sharedToYouImg = loadimage("gfx/SmallFileDownIcon.png")
	cd.purchasedImg = loadimage("gfx/SmallPurchasedIcon.png")
	cd.forSaleImg = loadimage("gfx/SmallForSaleIcon.png")
	cd.appVarImg = loadimage("gfx/ProjectIcon.png")
	cd.spriteVarImg = loadimage("gfx/SpriteIcon.png")
	cd.varButImg = loadimage("gfx/VarIcon.png")
	cd.soundImg = loadimage("gfx/SoundBlackIcon.png")
	cd.videoImg = loadimage("gfx/VideoBlackIcon.png")
	cd.findImg = loadimage("gfx/FindIcon.png")
	cd.refreshImg = loadimage("gfx/CloudDownIcon.png")
	cd.childImg = loadimage("gfx/ChildIcon.png")
	cd.subFolderImg = loadimage("gfx/FolderIcon.png")
	cd.backImg = loadimage("gfx/BackIcon.png")
	cd.upImg = loadimage("gfx/UpIcon.png")
	cd.removeImg = loadimage("gfx/RemoveIcon.png")
	cd.cancelImg = loadimage("gfx/CancelIcon.png")
	cd.ltArrImg = loadimage("gfx/KbdLeftIcon.png")
	cd.rtArrImg = loadimage("gfx/KbdRightIcon.png")
	cd.transImg = coCreateTransImg(1, 64, 64)	

/*	
	cd.settingsBut = guiCreateButton("settings", BUT_BG_BIG_TOP_TAB, "gfx/SettingsBlackIcon.png", co.white)
	//guiSetButtonIcon(cd.settingsBut, cd.settingsImg)
	coSetSpriteColor(cd.settingsBut.bg, cd.tabCols[CD_TAB_SETTINGS])
	coSetTextColor(cd.settingsBut.text, co.black)
	cd.settingsBut.id = BUT_SETTINGS
	guiSetButtonDepth(cd.settingsBut, cd.tabDepth)
	guiSetButtonPos(cd.settingsBut, x, y)
	
	x = x + GetSpriteWidth(cd.settingsBut.bg)
*/

	cd.appBut = guiCreateButton("projects", BUT_BG_BIG_TOP_TAB, "", co.white)
	guiSetButtonIcon(cd.appBut, cd.appImg)
	//coSetSpriteColor(cd.appBut.bg, cd.tabCols[CD_TAB_APP])
	guiSetButtonBgCol(cd.appBut, cd.tabCols[CD_TAB_APP])
	coSetTextColor(cd.appbut.text, co.black)
	cd.appBut.id = BUT_CODER_APP
	cd.appBut.help = "This tab shows open projects. Press and hold on a project for options." 
	guiSetButtonDepth(cd.appBut, cd.tabDepth)
	guiSetButtonPos(cd.appBut, x, y)

	x = x + GetSpriteWidth(cd.appBut.bg)
	cd.thingBut = guiCreateButton("things", BUT_BG_BIG_TOP_TAB, "", co.white)
	guiSetButtonIcon(cd.thingBut, cd.thingImg)
	//coSetSpriteColor(cd.thingBut.bg, cd.tabCols[CD_TAB_THING])
	guiSetButtonBgCol(cd.thingBut, cd.tabCols[CD_TAB_THING])
	coSetTextColor(cd.thingbut.text, co.black)
	cd.thingBut.id = BUT_CODER_THING
	cd.thingBut.help = "This tab shows sprites, sounds, videos and variables used in this project." 
	guiSetButtonDepth(cd.thingBut, cd.tabDepth)
	guiSetButtonPos(cd.thingBut, x, y)

	x = x + GetSpriteWidth(cd.thingBut.bg)
	cd.cmdBut = guiCreateButton("commands", BUT_BG_BIG_TOP_TAB, "gfx/CmdBlackIcon.png", co.white)
	//guiSetButtonIcon(cd.cmdBut, cd.cmdImg)
	//coSetSpriteColor(cd.cmdBut.bg, cd.tabCols[CD_TAB_CMD])
	guiSetButtonBgCol(cd.cmdBut, cd.tabCols[CD_TAB_CMD])
	coSetTextColor(cd.cmdBut.text, co.black)
	cd.cmdBut.id = BUT_CODER_CMD
	cd.cmdBut.help = "This tab shows commands you can use in your project. Press and hold on a command for help." 
	guiSetButtonDepth(cd.cmdBut, cd.tabDepth)
	guiSetButtonPos(cd.cmdBut, x, y)
	
	cd.codePanel = guiCreatePanel(ww, h, cd.panelDepth - 2, true, true)
	cd.codePanel.id = CD_CODE_PANEL
	guiSetPanelPos(cd.codePanel, getspritex(cd.mainPanel.panel) + getspritewidth(cd.mainPanel.panel) + co.bs / 4, co.bs + co.bs / 2)
	//guiSetPanelColor(cd.codePanel, co.white, co.white, co.grey[4])
	guiSetPanelColor(cd.codePanel, cd.tabCols[CD_TAB_CODE], cd.tabBarCols[CD_TAB_CODE], cd.tabPipCols[CD_TAB_CODE])

/*
	x = getspritex(cd.codePanel.panel) - co.bs / 2

	cd.helpDetails.helpBut = guiCreateButton("close", BUT_BG_LEFT_TAB, "", co.grey[3])
	guiSetButtonIcon(cd.helpDetails.helpBut, cd.closeImg)
	coSetSpriteColor(cd.helpDetails.helpBut.icon, co.black)
	coSetTextColor(cd.helpDetails.helpBut.text, co.black)
	cd.helpDetails.helpBut.id = BUT_CODER_HELP
	cd.helpDetails.helpBut.help = "This button closes help." 
	guiSetButtonDepth(cd.helpDetails.helpBut, GUI_HELP_DEPTH)
	guiSetButtonPos(cd.helpDetails.helpBut, x, getspritey(cd.codePanel.panel) + co.bs / 2)
*/

	// Second tab above code.
	//x = GetSpriteXByOffset(cd.libraryBut.bg) + GetSpriteWidth(cd.libraryBut.bg)
	x = getspritex(cd.codePanel.panel) + co.bs / 2 + co.bs / 4 + co.bs / 8
	// Second tab above code, after curr thing.
	cd.helpBut = guiCreateButton("help", BUT_BG_BIG_TOP_TAB, "gfx/HelpIcon.png", co.amber[0])
	coSetTextColor(cd.helpBut.text, co.black)
	coSetSpriteColor(cd.helpBut.icon, co.black)
	cd.helpBut.id = BUT_CODER_HELP
	cd.helpBut.help = "This tab shows help." 
	guiSetButtonPos(cd.helpBut, x, y)
	guiSetButtonDepth(cd.helpBut, cd.tabDepth)

	//x = getspritex(cd.codePanel.panel) + co.bs / 2 + co.bs / 4 + co.bs / 8
	x = GetSpriteXByOffset(cd.helpBut.bg) + GetSpriteWidth(cd.helpBut.bg)

	cd.codeBut = guiCreateButton("code", BUT_BG_BIG_TOP_TAB, "", co.white)
	guiSetButtonIcon(cd.codeBut, cd.codeImg)
	//coSetSpriteColor(cd.codeBut.bg, cd.tabCols[CD_TAB_CODE])
	guiSetButtonBgCol(cd.codeBut, cd.tabCols[CD_TAB_CODE])
	coSetTextColor(cd.codeBut.text, co.black)
	cd.codeBut.id = BUT_CODER_CODE
	cd.codeBut.help = "This tab shows code for the displayed sprite." 
	guiSetButtonDepth(cd.codeBut, cd.tabDepth)
	guiSetButtonPos(cd.codeBut, x, y)

	cd.codeScroll = guiCreateBox("cdInit:codeScroll", getspritewidth(cd.codePanel.panel) - CD_CODE_EDGE * 2, GetSpriteHeight(cd.codePanel.panel) - CD_CODE_EDGE * 2)
	SetSpriteDepth(cd.codeScroll, cd.panelDepth - 2)
	SetSpriteVisible(cd.codeScroll, false)
	SetSpritePositionByOffset(cd.codeScroll, GetSpriteXByOffset(cd.codePanel.panel), GetSpriteYByOffset(cd.codePanel.panel))
	
	//
	// Cmd panel.
	//

	// co.bs * 5	
	hh = co.h - co.bs - co.bs - co.bs / 4
	
	//cd.appPanel = guiCreatePanel(w - co.bs / 2, co.bs * 9 + co.bs / 2 + co.bs / 4, cd.panelDepth - 2, true, true)
	cd.appPanel = guiCreatePanel(w - co.bs / 2, hh, cd.panelDepth - 2, true, true)
	cd.appPanel.id = CD_APP_PANEL
	guiSetPanelPos(cd.appPanel, getspritex(cd.mainPanel.panel) + co.bs / 4, getspritey(cd.mainPanel.panel) + co.bs / 4)
	guiSetPanelColor(cd.appPanel, co.white, co.white, co.grey[4])

	for i = GRP_BEGIN to GRP_VIDEO //GRP_VAR

		// co.bs * 4
		//panel = guiCreatePanel(w - co.bs - co.bs / 2, co.bs * 9 + co.bs / 2 + co.bs / 4, cd.panelDepth - 2, true, true)
		panel = guiCreatePanel(w - co.bs - co.bs / 2, hh, cd.panelDepth - 2, true, true)
		panel.id = CD_GRP_PANEL + i
		cd.cmdPanels.insert(panel)
		
		guiSetPanelPos(cd.cmdPanels[i], getspritex(cd.mainPanel.panel) + co.bs / 4 + co.bs, getspritey(cd.mainPanel.panel) + co.bs / 4)

	next

	//
	// Thing panel buttons.
	//

	x = getspritex(cd.cmdPanels[GRP_SPRITE].panel) - co.bs + co.bs / 2
	y = getspritey(cd.cmdPanels[GRP_SPRITE].panel) + co.bs / 2 + co.bs / 4 + co.bs / 8
	gap = 0 // co.bs / 4
	
	//y = y + cd.titleH + co.bs
	but = guiCreateButton("sprites", BUT_BG_LEFT_TAB, "gfx/SpriteIcon.png", cd.grpCols[GRP_SPRITE])
	but.help = "All sprites in the project are listed here."
	cd.thingBar.buts.insert(but)
	guiSetButtonPos(but, x, y)
	guiSetButtonDepth(but, cd.panelDepth - 4)

	y = y + co.bs + gap
	but = guiCreateButton("variables", BUT_BG_LEFT_TAB, "gfx/VarIcon.png", cd.grpCols[GRP_VAR])
	but.help = "All variables in the project are listed here."
	cd.thingBar.buts.insert(but)
	guiSetButtonPos(but, x, y)
	guiSetButtonDepth(but, cd.panelDepth - 4)
	
	y = y + co.bs + gap
	but = guiCreateButton("sounds", BUT_BG_LEFT_TAB, "gfx/Sound2Icon.png", cd.grpCols[GRP_SOUND])
	but.help = "All sounds in the project are listed here."
	cd.thingBar.buts.insert(but)
	guiSetButtonPos(but, x, y)
	guiSetButtonDepth(but, cd.panelDepth - 4)

	y = y + co.bs + gap
	but = guiCreateButton("videos", BUT_BG_LEFT_TAB, "gfx/Video2Icon.png", cd.grpCols[GRP_VIDEO])
	but.help = "All videos in the project are listed here."
	cd.thingBar.buts.insert(but)
	guiSetButtonPos(but, x, y)
	guiSetButtonDepth(but, cd.panelDepth - 4)
/*
	y = y + co.bs + gap
	but = guiCreateButton("variables", BUT_BG_LEFT_TAB, "gfx/VarIcon.png", cd.grpCols[GRP_VAR])
	but.help = "All variables in the project are listed here."
	cd.thingBar.buts.insert(but)
	guiSetButtonPos(but, x, y)
	guiSetButtonDepth(but, cd.panelDepth - 4)
*/
	
	//
	// Grp buttons.
	//

	x = getspritex(cd.cmdPanels[GRP_BEGIN].panel) - co.bs + co.bs / 2
	y = getspritey(cd.cmdPanels[GRP_BEGIN].panel) + co.bs / 2 + co.bs / 4 + co.bs / 8
	gap = 0 // co.bs / 4
	
	if AGK_BUILD

		for i = 0 to ag.agkGrps.length
			
			//but = guiCreateButton(ag.agkgrps[i].name, BUT_BG_LEFT_TAB, ag.agkgrps[i].iconName, cd.grpCols[i])
			but = guiCreateButton(ag.agkgrps[i].name, BUT_BG_LEFT_TAB, "gfx/EventIcon.png", cd.grpCols[i])
			
			but.help = ag.agkgrps[i].help
			cd.grpBar.buts.insert(but)
			guiSetButtonPos(but, x, y)
			guiSetButtonDepth(but, cd.panelDepth - 4)
	
			y = y + co.bs + gap
		
		next
		
	else 
		
		//y = y + cd.titleH + co.bs
		but = guiCreateButton("event", BUT_BG_LEFT_TAB, "gfx/EventIcon.png", cd.grpCols[GRP_BEGIN])
		but.help = "Event commands start code\nexecution, when the event occurs.\nOnly commands attached\nbelow an event command,\nwill execute."
		cd.grpBar.buts.insert(but)
		guiSetButtonPos(but, x, y)
		guiSetButtonDepth(but, cd.panelDepth - 4)
		
		y = y + co.bs + gap
		but = guiCreateButton("move", BUT_BG_LEFT_TAB, "gfx/MoveIcon.png", cd.grpCols[GRP_MOVE])
		but.help = "Move commands change the position or angle of the sprite."
		cd.grpBar.buts.insert(but)
		guiSetButtonPos(but, x, y)
		guiSetButtonDepth(but, cd.panelDepth - 4)
	
		y = y + co.bs + gap
		but = guiCreateButton("look", BUT_BG_LEFT_TAB, "gfx/LookIcon.png", cd.grpCols[GRP_LOOK])
		but.help = "Look commands change the appearance of the sprite."
		cd.grpBar.buts.insert(but)
		guiSetButtonPos(but, x, y)
		guiSetButtonDepth(but, cd.panelDepth - 4)
	
		y = y + co.bs + gap
		but = guiCreateButton("flow", BUT_BG_LEFT_TAB, "gfx/Flow2Icon.png", cd.grpCols[GRP_FLOW])
		but.help = "Flow commands control the flow of the code execution."
		cd.grpBar.buts.insert(but)
		guiSetButtonPos(but, x, y)
		guiSetButtonDepth(but, cd.panelDepth - 4)
	
		y = y + co.bs + gap
		but = guiCreateButton("sense", BUT_BG_LEFT_TAB, "gfx/Sense1Icon.png", cd.grpCols[GRP_SENSE])
		but.help = "Sense commands detect input from the user (like presses), sprite collisions, and other data."
		cd.grpBar.buts.insert(but)
		guiSetButtonPos(but, x, y)
		guiSetButtonDepth(but, cd.panelDepth - 4)
	
		y = y + co.bs + gap
		but = guiCreateButton("output", BUT_BG_LEFT_TAB, "gfx/EmitIcon.png", cd.grpCols[GRP_EMIT])
		but.help = "Output commands change aspects of the screen, and play sounds and videos."
		cd.grpBar.buts.insert(but)
		guiSetButtonPos(but, x, y)
		guiSetButtonDepth(but, cd.panelDepth - 4)
	
		y = y + co.bs + gap
		but = guiCreateButton("calc", BUT_BG_LEFT_TAB, "gfx/Calc5Icon.png", cd.grpCols[GRP_CALC])
		but.help = "Calculate commands are for math and numeric functions."
		cd.grpBar.buts.insert(but)
		guiSetButtonPos(but, x, y)
		guiSetButtonDepth(but, cd.panelDepth - 4)
	
		y = y + co.bs + gap
		but = guiCreateButton("vars", BUT_BG_LEFT_TAB, "gfx/Data2Icon.png", cd.grpCols[GRP_DATA])
		but.help = "Data commands manipulate text and create variables that hold data you can use in your project."
		cd.grpBar.buts.insert(but)
		guiSetButtonPos(but, x, y)
		guiSetButtonDepth(but, cd.panelDepth - 4)
		
	endif

	//
	// Load panel.
	//

	cd.loadPanel = guiCreatePanel(ww, h, cd.panelDepth - 2, true, true)
	cd.loadPanel.id = CD_LOAD_PANEL
	guiSetPanelPos(cd.loadPanel, getspritex(cd.mainPanel.panel) + getspritewidth(cd.mainPanel.panel) + co.bs / 4, co.bs + co.bs / 2)
	guiSetPanelColor(cd.loadPanel, co.white, co.white, co.grey[4])

	//
	// Library buttons.
	//

	x = GetSpriteXByOffset(cd.codeBut.bg) + GetSpriteWidth(cd.codeBut.bg)
	y = GetSpritey(cd.codepanel.panel) - co.bs / 2 - co.bs / 8
	// Second tab above code, after curr thing.
	cd.libraryBut = guiCreateButton("library", BUT_BG_BIG_TOP_TAB, "gfx/LibraryIcon.png", co.deeppurple[1])
	coSetTextColor(cd.libraryBut.text, co.black)
	coSetSpriteColor(cd.libraryBut.icon, co.black)
	cd.libraryBut.id = BUT_CODER_LIBRARY
	guiSetButtonPos(cd.libraryBut, x, y)
	guiSetButtonDepth(cd.libraryBut, cd.tabDepth)

	//
	// Tool bar buttons.
	//
	
	y = getspritey(cd.codePanel.panel) - co.bs / 2 - co.bs / 4

	// First the main panel.
	x = GetSpriteXByOffset(cd.libraryBut.bg) + GetSpriteWidth(cd.libraryBut.bg) + co.bs / 8	
	but = guiCreateButton("import", BUT_BG_NORMAL, "gfx/FindIcon.png", co.openCol)
	but.id = BUT_CODER_FILES
	guiSetButtonPos(but, x, y)
	cd.toolBar.buts.insert(but)

	x = getspritex(cd.codePanel.panel) + GetSpriteWidth(cd.codePanel.panel) - co.bs * 5 + co.bs / 4 
	but = guiCreateButton("undo", BUT_BG_NORMAL, "gfx/UndoIcon.png", co.undoCol)
	but.id = BUT_CODER_UNDO
	but.help = "Undo the last code drag, or change of value in a command."
	cd.toolBar.buts.insert(but)
	guiSetButtonDepth(but, cd.tabDepth)
	guiSetButtonPos(but, x, y)

	x = x + co.bs
	but = guiCreateButton("redo", BUT_BG_NORMAL, "gfx/RedoIcon.png", co.redoCol)
	but.id = BUT_CODER_REDO
	but.help = "Redo the last undo."
	cd.toolBar.buts.insert(but)
	guiSetButtonDepth(but, cd.tabDepth)
	guiSetButtonPos(but, x, y)

	x = x + co.bs + co.bs / 4
	//but = guiCreateButton("help", BUT_BG_NORMAL, "gfx/Help2Icon.png", co.helpCol)
	but = guiCreateButton("more", BUT_BG_NORMAL, "gfx/MoreIcon.png", co.moreCol)
	but.id = BUT_CODER_MORE
	but.help = "Press the more button to see the menu."
	cd.toolBar.buts.insert(but)
	guiSetButtonDepth(but, cd.tabDepth)
	guiSetButtonPos(but, x, y)

	x = x + co.bs
	but = guiCreateButton("layout", BUT_BG_NORMAL, "gfx/GridIcon.png", co.openCol)
	but.id = BUT_CODER_DESIGN
	but.help = "Press the layout button\nto switch to the layout screen\nand position your sprites."
	cd.toolBar.buts.insert(but)
	guiSetButtonDepth(but, cd.tabDepth)
	guiSetButtonPos(but, x, y)

	x = x + co.bs
	but = guiCreateButton("run", BUT_BG_NORMAL, "gfx/RunIcon.png", co.runCol)
	but.id = BUT_CODER_RUN
	but.help = "Press the run button to switch to the run screen and execute your project code."
	cd.toolBar.buts.insert(but)
	guiSetButtonDepth(but, cd.tabDepth)
	guiSetButtonPos(but, x, y)

	guiHideBar(cd.toolBar)

	//
	// More toolbar.
	//
/*
	but = guiCreateButton("help", BUT_BG_NORMAL, "gfx/Help2Icon.png", co.helpCol)
	but.id = BUT_CODER_HELP_MAIN
	but.help = "Press the help button to show general help about how to use Codey Codey."
	cd.moreBar.buts.insert(but)
*/
	but = guiCreateButton("naming", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.special1Col) //co.bluegrey[col])
	but.id = BUT_CODER_AUTO_NAMING
	but.help = "If this setting is on, projects, sprites, etc. are automatically named. Otherwise, you will be asked for a name."
	cd.morebar.buts.insert(but)

	but = guiCreateButton("libraries", BUT_BG_NORMAL, "gfx/LibraryIcon.png", co.special3Col) //co.bluegrey[col])
	but.id = BUT_CODER_LIBRARIES
	but.help = "If this setting is on, show the 'libraries' folder containing library projects."
	cd.morebar.buts.insert(but)

	but = guiCreateButton("cmds", BUT_BG_NORMAL, "gfx/CmdIcon.png", co.special4Col) //co.bluegrey[col])
	but.id = BUT_CODER_CMD_SIZE
	but.help = "Change the size of commands, each press with increase the size up to " + str(LD_CMD_SIZE_MAX) + ", then jump back to the smallest size 1."
	cd.morebar.buts.insert(but)

	but = guiCreateButton("help", BUT_BG_NORMAL, "gfx/CmdIcon.png", co.special5Col) //co.bluegrey[col])
	but.id = BUT_CODER_HELP_SIZE
	but.help = "Change the size of help text, each press with increase the size up to " + str(LD_HELP_SIZE_MAX) + ", then jump back to the smallest size 1."
	cd.morebar.buts.insert(but)

	but = guiCreateButton("title", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.special2Col)
	but.id = BUT_TITLE_SHOW
	but.help = "Show the title screen."
	cd.moreBar.buts.insert(but)

	guiHideBar(cd.moreBar)
	cdSetSettingsAutoNamingButton()
	cdSetSettingsLibrariesButton()
	cdSetSettingsCmdSizeButton()
	cdSetSettingsHelpSizeButton()
	
	//
	// app toolbar.
	//

	but = guiCreateButton("close", BUT_BG_NORMAL, "gfx/CloseIcon.png", co.openCol)
	but.id = BUT_CODER_APP_CLOSE
	but.help = "Close this project."
	cd.appBar.buts.insert(but)

	but = guiCreateButton("info", BUT_BG_NORMAL, "gfx/InfoIcon.png", co.special1Col)
	but.id = BUT_CODER_APP_INFO
	but.help = "Show information for this project."
	cd.appBar.buts.insert(but)

	but = guiCreateButton("make lib", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special2col)
	but.id = BUT_CODER_APP_ADDLIB
	but.help = "Make this a library project. Sprite, sound and video libraries will show things from this project."
	cd.appBar.buts.insert(but)

	but = guiCreateButton("make ex", BUT_BG_NORMAL, "gfx/AddIcon.png", co.editcol)
	but.id = BUT_CODER_APP_ADDEX
	but.help = "Make this project an example. Internal only."
	cd.appBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renameCol)
	but.id = BUT_CODER_APP_RENAME
	but.help = "Rename this project."
	cd.appBar.buts.insert(but)

	but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	but.id = BUT_CODER_APP_DUP
	but.help = "Duplicate this project with a new name."
	cd.appBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deletecol)
	but.id = BUT_CODER_APP_DELETE
	but.help = "Delete this project."
	cd.appBar.buts.insert(but)

	guiHideBar(cd.appBar)

	//
	// Sprite toolbar.
	//

	but = guiCreateButton("edit", BUT_BG_NORMAL, "gfx/EditIcon.png", co.opencol)
	but.id = BUT_CODER_THING_EDIT
	but.help = "Edit the image of the selected frame for this sprite."
	cd.spriteBar.buts.insert(but)

	but = guiCreateButton("library", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1col)
	but.id = BUT_CODER_THING_ADDLIB
	but.help = "Add this sprite to the library."
	cd.spriteBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renamecol)
	but.id = BUT_CODER_THING_RENAME
	but.help = "Rename this sprite."
	cd.spriteBar.buts.insert(but)

	but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	but.id = BUT_CODER_THING_DUP
	but.help = "Duplicate this sprite, including all frames, code and variables."
	cd.spriteBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deletecol)
	but.id = BUT_CODER_THING_REMOVE
	but.help = "Delete this sprite from the project, including all frames, code and variables."
	cd.spriteBar.buts.insert(but)

	guiHideBar(cd.spriteBar)

	//
	// Frame toolbar.
	//

	but = guiCreateButton("edit", BUT_BG_NORMAL, "gfx/EditIcon.png", co.opencol)
	but.id = BUT_CODER_IMAGE_EDIT
	but.help = "Edit this frame image."
	cd.frameBar.buts.insert(but)

	but = guiCreateButton("library", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1col)
	but.id = BUT_CODER_IMAGE_ADDLIB
	but.help = "Add this frame to the library."
	cd.frameBar.buts.insert(but)

	but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	but.id = BUT_CODER_IMAGE_DUP
	but.help = "Duplicate this frame image."
	cd.frameBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deletecol)
	but.id = BUT_CODER_IMAGE_REMOVE
	but.help = "Delete this frame from the sprite."
	cd.frameBar.buts.insert(but)

	guiHideBar(cd.frameBar)

	//
	// Sound toolbar.
	//
	but = guiCreateButton("play", BUT_BG_NORMAL, "gfx/RunIcon.png", co.opencol)
	but.id = BUT_CODER_THING_PLAY
	but.help = "Play this sound."
	cd.soundBar.buts.insert(but)

	//but = guiCreateButton("edit", BUT_BG_NORMAL, "gfx/EditIcon.png", co.editcol)
	//but.id = BUT_CODER_THING_EDIT
	//but.help = "Edit this sound."
	//cd.soundBar.buts.insert(but)

	but = guiCreateButton("library", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1col)
	but.id = BUT_CODER_THING_ADDLIB
	but.help = "Add this sound to the library."
	cd.soundBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renamecol)
	but.id = BUT_CODER_THING_RENAME
	but.help = "Rename this sound."
	cd.soundBar.buts.insert(but)

	but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	but.id = BUT_CODER_THING_DUP
	but.help = "Duplicate this sound."
	cd.soundBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deletecol)
	but.id = BUT_CODER_THING_REMOVE
	but.help = "Delete this sound from the project."
	cd.soundBar.buts.insert(but)

	guiHideBar(cd.soundBar)

	//
	// Video toolbar.
	//
	but = guiCreateButton("play", BUT_BG_NORMAL, "gfx/RunIcon.png", co.opencol)
	but.id = BUT_CODER_THING_PLAY
	but.help = "Play this video."
	cd.videoBar.buts.insert(but)

	but = guiCreateButton("library", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1col)
	but.id = BUT_CODER_THING_ADDLIB
	but.help = "Add this video to the library."
	cd.videoBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renamecol)
	but.id = BUT_CODER_THING_RENAME
	but.help = "Rename this video."
	cd.videoBar.buts.insert(but)

	but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	but.id = BUT_CODER_THING_DUP
	but.help = "Duplicate this video."
	cd.videoBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deletecol)
	but.id = BUT_CODER_THING_REMOVE
	but.help = "Delete this video from the project."
	cd.videoBar.buts.insert(but)

	guiHideBar(cd.videoBar)

	//
	// Code cmd Popup buts.
	//
	
	but = guiCreateButton("cut", BUT_BG_NORMAL, "gfx/CutIcon.png", co.cutCol)
	but.id = BUT_CODER_CUT
	but.help = "Cut this block of code to the clipboard. You can paste it later."
	cd.cmdBar.buts.insert(but)

	but = guiCreateButton("copy", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copyCol)
	but.id = BUT_CODER_COPY
	but.help = "Copy this block of code to the clipboard. You can paste it later."
	cd.cmdBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deleteCol)
	but.id = BUT_CODER_DELETE
	but.help = "Delete this block of code."
	cd.cmdBar.buts.insert(but)

	guiHideBar(cd.cmdBar)

	//
	// Part Popup buts.
	//
	
	but = guiCreateButton("paste", BUT_BG_NORMAL, "gfx/PasteIcon.png", co.redoCol)
	but.id = BUT_CODER_PASTE_PART
	but.help = "Paste the current operator cmd in the clipboard to this command value."
	cd.partBar.buts.insert(but)

	but = guiCreateButton("tip", BUT_BG_NORMAL, "gfx/Help2Icon.png", co.helpCol)
	but.id = BUT_CODER_HELP_QUICK
	cd.partBar.buts.insert(but)

	but = guiCreateButton("help", BUT_BG_NORMAL, "gfx/HelpIcon.png", co.detailsCol)
	but.id = BUT_CODER_HELP_DETAILS
	but.help = "Show detailed help for this command value."
	cd.partBar.buts.insert(but)

	guiHideBar(cd.partBar)

	//
	// Code panel Popup buts.
	//
	
	but = guiCreateButton("paste", BUT_BG_NORMAL, "gfx/PasteIcon.png", co.redoCol)
	but.id = BUT_CODER_PASTE
	but.help = "Paste code from the clipboard right here."
	cd.codeBar.buts.insert(but)

	but = guiCreateButton("tidy", BUT_BG_NORMAL, "gfx/CodeIcon.png", co.editCol)
	but.id = BUT_CODER_TIDY
	but.help = "Tidy all code, and format it to the left."
	cd.codeBar.buts.insert(but)

	but = guiCreateButton("show all", BUT_BG_NORMAL, "gfx/ZoomOutIcon.png", co.special2Col)
	but.id = BUT_CODER_ZOOM_OUT
	but.help = "Zoom out and show all the code for this sprite."
	cd.codeBar.buts.insert(but)

	guiHideBar(cd.codeBar)

	//
	// Var Popup buts.
	//

	//but = guiCreateButton("edit", BUT_BG_NORMAL, "gfx/EditIcon.png", co.editCol)
	//but.id = BUT_CODER_THING_EDIT
	//but.help = "Edit this variable value."
	//cd.varBar.buts.insert(but)

	//but = guiCreateButton("make list", BUT_BG_NORMAL, "gfx/ListIcon.png", co.openCol)
	//but.id = BUT_CODER_VAR_TO_LIST
	//but.help = "Make this variable a list. A list contains multiple values that can be accessed via a list command."
	//cd.varBar.buts.insert(but)

	but = guiCreateButton("add item", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_VAR_ADD
	but.help = "Append an item to this list."
	cd.varBar.buts.insert(but)

	but = guiCreateButton("clear", BUT_BG_NORMAL, "gfx/ClearIcon.png", co.special2Col)
	but.id = BUT_CODER_VAR_CLEAR
	but.help = "Clear this list."
	cd.varBar.buts.insert(but)

	but = guiCreateButton("share", BUT_BG_NORMAL, "gfx/ProjectIcon.png", co.special3Col)
	but.id = BUT_CODER_VAR_SHARE
	but.help = "Change a sprite variable or list into a project variable or list so it can be shared across all sprites."
	cd.varBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renameCol)
	but.id = BUT_CODER_THING_RENAME
	but.help = "Rename this variable."
	cd.varBar.buts.insert(but)

	but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	but.id = BUT_CODER_THING_DUP
	but.help = "Duplicate this variable."
	cd.varBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deleteCol)
	but.id = BUT_CODER_THING_REMOVE
	but.help = "Delete this variable. It will also be removed from your code."
	cd.varBar.buts.insert(but)

	guiHideBar(cd.varBar)

	//
	// Var value Popup buts.
	//

	but = guiCreateButton("above", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_VAR_ADD_ABOVE
	but.help = "Insert a new item above this one on the list."
	cd.varValueBar.buts.insert(but)

	but = guiCreateButton("below", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special2Col)
	but.id = BUT_CODER_VAR_ADD_BELOW
	but.help = "Insert a new item below this one on the list."
	cd.varValueBar.buts.insert(but)

	but = guiCreateButton("value", BUT_BG_NORMAL, "gfx/EditIcon.png", co.openCol)
	but.id = BUT_CODER_THING_EDIT
	but.help = "Edit this list item value."
	cd.varValueBar.buts.insert(but)

	but = guiCreateButton("name", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renameCol)
	but.id = BUT_CODER_THING_RENAME
	but.help = "Edit this list item name."
	cd.varValueBar.buts.insert(but)

	but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	but.id = BUT_CODER_THING_DUP
	but.help = "Duplicate this list item."
	cd.varValueBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deleteCol)
	but.id = BUT_CODER_VAR_REMOVE
	but.help = "Delete this value from the list."
	cd.varValueBar.buts.insert(but)

	guiHideBar(cd.varValueBar)

	//
	// Sel cmd help bar.
	//
	
	but = guiCreateButton("tip", BUT_BG_NORMAL, "gfx/Help2Icon.png", co.helpCol)
	but.id = BUT_CODER_HELP_QUICK
	cd.helpBar.buts.insert(but)

	but = guiCreateButton("help", BUT_BG_NORMAL, "gfx/HelpIcon.png", co.detailsCol)
	but.id = BUT_CODER_HELP_DETAILS
	but.help = "Show detailed help for this command."
	cd.helpBar.buts.insert(but)

	guiHideBar(cd.helpBar)

	cd.helpPanel = guiCreatePanel(ww, h, GUI_HELP_DEPTH, true, true)
	cd.helpPanel.id = CD_HELP_PANEL
	guiSetPanelPos(cd.helpPanel, getspritex(cd.mainPanel.panel) + getspritewidth(cd.mainPanel.panel) + co.bs / 4, co.bs + co.bs / 2)
	guiSetPanelColor(cd.helpPanel, co.amber[0], co.amber[0], co.amber[2])
	guiSetPanelContentSize(cd.helpPanel, getspritex(cd.helpPanel.panel), getspritey(cd.helpPanel.panel), getspritex(cd.helpPanel.panel) + GetSpriteWidth(cd.helpPanel.panel) - 1, getspritey(cd.helpPanel.panel) + GetSpriteHeight(cd.helpPanel.panel) - 1)

	//depth = GetSpriteDepth(cd.helpPanel.panel)
	//SetSpriteDepth(cd.helpPanel.VBar, depth - 10)
	//SetSpriteDepth(cd.helpPanel.VDrag, depth - 12)
	//SetSpriteDepth(cd.helpPanel.HBar, depth - 10)
	//SetSpriteDepth(cd.helpPanel.HDrag, depth - 12)

	//cd.closeButImg = LoadImage("gfx/CloseIcon.png")
	//cd.closeBut = coCreateSprite("closeBut", cd.closeButImg)
	//SetSpriteDepth(cd.closeBut, GetSpriteDepth(cd.helpPanel.panel) - 2)
	//SetSpriteVisible(cd.closeBut, false)

	//
	// proj item toolbar.
	//

	cd.openAppHelp = "Open this project. You can also drag this project icon to the 'Projects' panel."
	cd.closeAppHelp = "Close this project."
	cd.remLibAppHelp = "No longer make this project a library, so you can open it again."
	
	but = guiCreateButton("open", BUT_BG_NORMAL, "gfx/OpenIcon.png", co.openCol)
	but.id = BUT_CODER_APP_OPEN
	but.help = cd.openAppHelp
	cd.projItemBar.buts.insert(but)

	but = guiCreateButton("info", BUT_BG_NORMAL, "gfx/InfoIcon.png", co.special1Col)
	but.id = BUT_CODER_APP_INFO
	but.help = "Show information for this project."
	cd.projItemBar.buts.insert(but)

	//but = guiCreateButton("share", BUT_BG_NORMAL, "gfx/CloudUpIcon.png", co.special2Col)
	//but.id = BUT_CODER_APP_SHARE
	//but.help = "Share this project for the community to try."
	//cd.projItemBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renameCol)
	but.id = BUT_CODER_APP_RENAME
	but.help = "Rename this project."
	cd.projItemBar.buts.insert(but)

	but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	but.id = BUT_CODER_LIB_APP_DUP
	but.help = "Duplicate this project."
	cd.projItemBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deleteCol)
	but.id = BUT_CODER_APP_DELETE
	but.help = "Delete this project. Note: it cannot be recovered after deleting."
	cd.projItemBar.buts.insert(but)

	guiHideBar(cd.projItemBar)

	//
	// proj blank item toolbar.
	//
	
	but = guiCreateButton("add", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_APP_OPEN
	but.help = "Create a new project. You can also drag this project icon to the 'Projects' panel."
	cd.projBlankItemBar.buts.insert(but)

	guiHideBar(cd.projBlankItemBar)
	
	//
	// sprite item toolbar.
	//

	but = guiCreateButton("sprite", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_THING_NEW
	but.help = "Add this image as a new sprite in the project."
	cd.imageItemBar.buts.insert(but)

	but = guiCreateButton("frame", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special2Col)
	but.id = BUT_CODER_IMAGE_NEW
	but.help = "Add this image as a frame on the selected sprite."
	cd.imageItemBar.buts.insert(but)

	but = guiCreateButton("view", BUT_BG_NORMAL, "gfx/ZoomInIcon.png", co.openCol)
	but.id = BUT_CODER_IMAGE_VIEW
	but.help = "View a larger version of this image, if one exists."
	cd.imageItemBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renameCol)
	but.id = BUT_CODER_ITEM_RENAME
	but.help = "Rename this image."
	cd.imageItemBar.buts.insert(but)

	//but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	//but.id = BUT_CODER_ITEM_DUP
	//but.help = "Duplicate this sprite, including all frames, code and variables."
	//cd.imageItemBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deleteCol)
	but.id = BUT_CODER_ITEM_DELETE
	but.help = "Delete this sprite from the library."
	cd.imageItemBar.buts.insert(but)

	guiHideBar(cd.imageItemBar)

	//
	// add item toolbar for image editor.
	//

	but = guiCreateButton("add", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_EDIT_IMAGE_ADD
	but.help = "Add this image to the image editor."
	cd.addItemBar.buts.insert(but)

	guiHideBar(cd.addItemBar)

	//
	// sprite item toolbar.
	//

	but = guiCreateButton("sprite", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_THING_NEW
	but.help = "Add this image as a new sprite in the project."
	cd.imageBlankItemBar.buts.insert(but)

	but = guiCreateButton("frame", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special2Col)
	but.id = BUT_CODER_IMAGE_NEW
	but.help = "Add this image as a frame on the selected sprite."
	cd.imageBlankItemBar.buts.insert(but)

	guiHideBar(cd.imageBlankItemBar)

	//
	// sound item toolbar.
	//

	but = guiCreateButton("play", BUT_BG_NORMAL, "gfx/RunIcon.png", co.openCol)
	but.id = BUT_CODER_ITEM_PLAY
	but.help = "Play this sound."
	cd.soundItemBar.buts.insert(but)

	but = guiCreateButton("add", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_THING_NEW
	but.help = "Add this sound to the project."
	cd.soundItemBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renameCol)
	but.id = BUT_CODER_ITEM_RENAME
	but.help = "Rename this sound."
	cd.soundItemBar.buts.insert(but)

	//but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	//but.id = BUT_CODER_ITEM_DUP
	//but.help = "Duplicate this sound."
	//cd.soundItemBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deleteCol)
	but.id = BUT_CODER_ITEM_DELETE
	but.help = "Delete this sound from the library."
	cd.soundItemBar.buts.insert(but)

	guiHideBar(cd.soundItemBar)

	//
	// video item toolbar.
	//

	but = guiCreateButton("play", BUT_BG_NORMAL, "gfx/RunIcon.png", co.openCol)
	but.id = BUT_CODER_ITEM_PLAY
	but.help = "Play this video."
	cd.videoItemBar.buts.insert(but)

	but = guiCreateButton("add", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_THING_NEW
	but.help = "Add this video to the project."
	cd.videoItemBar.buts.insert(but)

	but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.renameCol)
	but.id = BUT_CODER_ITEM_RENAME
	but.help = "Rename this video."
	cd.videoItemBar.buts.insert(but)

	//but = guiCreateButton("duplicate", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.copycol)
	//but.id = BUT_CODER_ITEM_DUP
	//but.help = "Duplicate this video."
	//cd.videoItemBar.buts.insert(but)

	but = guiCreateButton("delete", BUT_BG_NORMAL, "gfx/TrashIcon.png", co.deleteCol)
	but.id = BUT_CODER_ITEM_DELETE
	but.help = "Delete this video from the library."
	cd.videoItemBar.buts.insert(but)

	guiHideBar(cd.videoItemBar)

	//
	// var item toolbar.
	//

	but = guiCreateButton("add", BUT_BG_NORMAL, "gfx/AddIcon.png", co.special1Col)
	but.id = BUT_CODER_THING_NEW
	cd.varItemBar.buts.insert(but)

	guiHideBar(cd.varItemBar)

	//
	// var value item toolbar.
	//

	but = guiCreateButton("help", BUT_BG_NORMAL, "gfx/Help2Icon.png", co.helpCol)
	but.id = BUT_CODER_HELP_QUICK
	cd.varValueItemBar.buts.insert(but)

	guiHideBar(cd.varValueItemBar)

	//
	// folder item toolbar.
	//

	//but = guiCreateButton("rename", BUT_BG_NORMAL, "gfx/RenameIcon.png", co.lime[7])
	//but.id = BUT_CODER_ITEM_FOLDER_RENAME
	//but.help = "Rename this folder."
	//cd.folderItemBar.buts.insert(but)

	but = guiCreateButton("help", BUT_BG_NORMAL, "gfx/Help2Icon.png", co.helpCol)
	but.id = BUT_CODER_HELP_QUICK
	but.help = "Press to open the folder."
	cd.folderItemBar.buts.insert(but)

	guiHideBar(cd.folderItemBar)

/*
	// Image / sound editor.

	// co.bs * 5 + co.bs / 2
	cd.edimg.ctrlPanel = guiCreatePanel(w, co.bs * 11 + co.bs / 2, cd.panelDepth - 6, false, false)
	cd.edimg.ctrlPanel.id = CD_MAIN_PANEL
	guiSetPanelPos(cd.edimg.ctrlPanel, co.bs / 4, co.bs / 4)
	guiSetPanelColor(cd.edimg.ctrlPanel, co.grey[3], co.grey[3], co.grey[7])
	guiSetPanelVisible(cd.edimg.ctrlPanel, false)

	// co.bs * 10 - co.bs / 4
	cd.edimg.dataPanel = guiCreatePanel(ww, co.bs * 10 + co.bs / 4, cd.panelDepth - 6, true, true)
	cd.edimg.dataPanel.id = CD_EDIT_DATA_PANEL
	guiSetPanelPos(cd.edimg.dataPanel, getspritex(cd.mainPanel.panel) + getspritewidth(cd.mainPanel.panel) + co.bs / 4, co.bs + co.bs / 2)
	//guiSetPanelColor(cd.edimg.dataPanel, co.white, co.white, co.grey[4])
	guiSetPanelColor(cd.edimg.dataPanel, co.grey[2], co.grey[2], co.grey[4])
	guiSetPanelVisible(cd.edimg.dataPanel, false)
	
	//s = "Image size \nImage space \nZoom level "
	s = "Image size \nZoom level "
	cd.edimg.title1 = guiCreateText(ReplaceString(s, "\n", chr(10), -1), 2)
	SetTextAlignment(cd.edimg.title1, 0)
	SetTextPosition(cd.edimg.title1, getspritex(cd.edimg.dataPanel.panel) + co.bs / 8 + co.bs * 3, co.bs / 8 + co.bs / 4)

	//s = ": 123 w x 456 h\n: 15Mb\n: 1"
	s = ": 123 w x 456 h\n: 1"
	cd.edimg.title2 = guiCreateText(ReplaceString(s, "\n", chr(10), -1), 2)
	SetTextAlignment(cd.edimg.title2, 0)
	SetTextPosition(cd.edimg.title2, getspritex(cd.edimg.dataPanel.panel) + co.bs / 8 + co.bs * 3 + GettexttotalWidth(cd.edimg.title1), co.bs / 8 + co.bs / 4)
*/

	s = "Previous values entered, select to use"
	cd.prevValueTitle = guiCreateText(s, 1)
	cosettextcolor(cd.prevValueTitle, co.black)
	SetTextAlignment(cd.prevValueTitle, 0)
	SetTextVisible(cd.prevValueTitle, false)

/*
	cd.edimg.rectImg = loadimage("gfx/RectIcon.png")
	cd.edimg.rectFilledImg = loadimage("gfx/RectFilledIcon.png")
	cd.edimg.ovalImg = loadimage("gfx/OvalIcon.png")
	cd.edimg.ovalFilledImg = loadimage("gfx/OvalFilledIcon.png")
	cd.edimg.selectImg = loadimage("gfx/SelectIcon.png")
	cd.edimg.deselectImg = loadimage("gfx/DeselectIcon.png")
	cd.edimg.eraseImg = loadimage("gfx/EraseIcon.png")
	cd.edimg.lineImg = loadimage("gfx/LineSizeIcon.png")
	cd.edimg.textImg = loadimage("gfx/RenameIcon.png")
	cd.edimg.lineSqrImg = loadimage("gfx/LineSqrIcon.png")
	cd.edimg.lineCircImg = loadimage("gfx/LineCircIcon.png")
	
	cd.edimg.thingIdx = -1
	cd.edimg.frameIdx = -1

	cd.edimg.editWithSprs = false
	cd.edimg.editWithImages = true

	cd.edimg.colorbar = guiCreateToolbar()
	cd.edimg.rectbar = guiCreateToolbar()
	cd.edimg.ovalbar = guiCreateToolbar()
	cd.edimg.linebar = guiCreateToolbar()
	
	px = getspritex(cd.edimg.ctrlPanel.panel) + co.bs / 2 + co.bs / 4
	py = getspritey(cd.edimg.ctrlPanel.panel) + co.bs / 2 + co.bs / 4
	gx = co.bs / 4
	gy = co.bs / 4

	depth = GetSpriteDepth(cd.edimg.ctrlPanel.panel)

	//
	// Image editor toolbar.
	//
	
	xx = px
	but = guiCreateButton("save", BUT_BG_NORMAL, "gfx/DoneIcon.png", co.runCol)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_SAVE
	but.help = "Saves your changes."
	cd.edimg.toolbar.buts.insert(but)

	xx = xx + co.bs + gx
	but = guiCreateButton("cancel", BUT_BG_NORMAL, "gfx/CancelIcon.png", co.deleteCol)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_CANCEL
	but.help = "Cancels your changes."
	cd.edimg.toolbar.buts.insert(but)

	//py = py + co.bs + gx

	//col = 3
	//xx = px
	col = 5
	xx = xx + co.bs + gx
	but = guiCreateButton("undo", BUT_BG_NORMAL, "gfx/UndoIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_UNDO
	but.help = "Undo the last change."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("redo", BUT_BG_NORMAL, "gfx/RedoIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_REDO
	but.help = "Redo the last change that was undone."
	cd.edimg.toolbar.buts.insert(but)

	py = py + co.bs + gx

	col = 3
	xx = px

	but = guiCreateButton("pan", BUT_BG_NORMAL, "gfx/PanIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	//SetSpriteScale(but.icon, 0.75, 0.75)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_PAN
	but.help = "Panning mode, allows you to drag the image, if it is larger than the edit area."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("zoom in", BUT_BG_NORMAL, "gfx/ZoomInIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_ZOOM_IN
	but.help = "Zoom in on the centre of the image, for close up editing. If the image doesn't fit within the edit area, use the pan tool."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("zoom out", BUT_BG_NORMAL, "gfx/ZoomOutIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_ZOOM_OUT
	but.help = "Zoom out, to see more of the image again."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("normal", BUT_BG_NORMAL, "gfx/ZoomResetIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_ZOOM_RESET
	but.help = "Reset the zoom size back to normal."
	cd.edimg.toolbar.buts.insert(but)

	py = py + co.bs + gx

	col = 3
	xx = px
	but = guiCreateButton("draw", BUT_BG_NORMAL, "gfx/BrushIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_DRAW
	but.help = "Draw a freehand line. Press and drag to draw, then release. Draws in current color and line size."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("line", BUT_BG_NORMAL, "gfx/LineIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_LINE
	but.help = "Draw a straight line. Press and drag to draw a line, then release. Draws in current color and line size."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("rect", BUT_BG_NORMAL, "", co.bluegrey[col])
	guiSetButtonIcon(but, cd.edimg.rectImg)
	guiSetButtonTip(but, true)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_RECT
	//but.help = "Draw a hollow rectangle. Press and drag to draw a rectangle, then release. Draws in current color and size."
	cd.edimg.toolbar.buts.insert(but)

	//
	// Start rect toolbar.
	//
	
	col = 3
	but = guiCreateButton("rect", BUT_BG_NORMAL, "", co.blueGrey[col])
	guiSetButtonIcon(but, cd.edimg.rectImg)
	but.id = BUT_CODER_EDIT_RECT
	but.help = "Draw a hollow rectangle. Press and drag to draw a rectangle, then release. Draws in current color and size."
	cd.edimg.rectbar.buts.insert(but)

	inc col
	but = guiCreateButton("filled rect", BUT_BG_NORMAL, "", co.blueGrey[col])
	guiSetButtonIcon(but, cd.edimg.rectFilledImg)
	but.id = BUT_CODER_EDIT_RECT_FILLED
	but.help = "Draw a filled rectangle. Press and drag to draw a rectangle, then release. Draws in current color and size."
	cd.edimg.rectbar.buts.insert(but)

	guiHideBar(cd.edimg.rectBar)

	//
	// End color bar.
	//

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("oval", BUT_BG_NORMAL, "", co.bluegrey[col])
	guiSetButtonIcon(but, cd.edimg.ovalImg)
	guiSetButtonTip(but, true)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_OVAL
	//but.help = "Draw a hollow oval. Press and drag to draw an oval, then release. Draws in current color and size."
	cd.edimg.toolbar.buts.insert(but)

	//
	// Start oval toolbar.
	//

	col = 3
	but = guiCreateButton("oval", BUT_BG_NORMAL, "", co.blueGrey[col])
	guiSetButtonIcon(but, cd.edimg.ovalImg)
	but.id = BUT_CODER_EDIT_OVAL
	but.help = "Draw a hollow oval. Press and drag to draw a rectangle, then release. Draws in current color and size."
	cd.edimg.ovalbar.buts.insert(but)

	inc col
	but = guiCreateButton("filled oval", BUT_BG_NORMAL, "", co.blueGrey[col])
	guiSetButtonIcon(but, cd.edimg.ovalFilledImg)
	but.id = BUT_CODER_EDIT_OVAL_FILLED
	but.help = "Draw a filled oval. Press and drag to draw a rectangle, then release. Draws in current color and size."
	cd.edimg.ovalbar.buts.insert(but)

	guiHideBar(cd.edimg.ovalBar)

	//
	// End color bar.
	//

	py = py + co.bs + gx

	col = 3
	xx = px
	but = guiCreateButton("select", BUT_BG_NORMAL, "", co.bluegrey[col])
	guiSetButtonIcon(but, cd.edimg.selectImg)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_SELECT
	//but.help = "Select a rectangular area of the image to resize or restrict drawing operations."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("text", BUT_BG_NORMAL, "gfx/TextIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_TEXT
	but.help = "Insert text into the image."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("fill", BUT_BG_NORMAL, "gfx/PaintIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_FILL
	but.help = "Fill are area with the current color. Press on the image, and all adjacent pixels of the same color with be changed."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("image", BUT_BG_NORMAL, "gfx/ImageIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_IMAGE
	but.help = "Insert an image from the sprite library."
	cd.edimg.toolbar.buts.insert(but)
	
	py = py + co.bs + gx
	
	col = 3
	xx = px
	but = guiCreateButton("size", BUT_BG_NORMAL, "", co.bluegrey[col])
	guiSetButtonIcon(but, cd.edimg.lineImg)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_SIZE
	//but.help = "Select the size (thickness) of drawing, lines, rectangles, and ovals."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("line style", BUT_BG_NORMAL, "", co.bluegrey[col])
	guiSetButtonIcon(but, cd.edimg.lineCircImg)
	guiSetButtonTip(but, true)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_LINE_CIRC
	//but.help = "Select the size (thickness) of drawing, lines, rectangles, and ovals."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("color", BUT_BG_NORMAL, "", co.bluegrey[col])
	guiSetButtonIcon(but, co.pixImg)
	SetSpriteScale(but.icon, 64, 64)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	guiSetButtonTip(but, true)
	but.id = BUT_CODER_EDIT_COLOR
	but.help = "Set the color to use will all drawing tools."
	cd.edimg.toolbar.buts.insert(but)

	but = guiCreateButton("erase", BUT_BG_NORMAL, "gfx/EraseIcon.png", co.bluegrey[col])
	guiSetButtonPos(but, xx, py)
	guiSetButtonTip(but, true)
	but.id = BUT_CODER_EDIT_ERASE
	but.help = "Set drawing tools to erase."
	cd.edimg.toolbar.buts.insert(but)
	
	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("picker", BUT_BG_NORMAL, "gfx/PickerIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_PICKER
	but.help = "Press a color on the image to make it the current color."
	cd.edimg.toolbar.buts.insert(but)

	//
	// Line style toolbar.
	//

	col = 3
	but = guiCreateButton("round", BUT_BG_NORMAL, "", co.blueGrey[col])
	guiSetButtonIcon(but, cd.edimg.lineCircImg)
	but.id = BUT_CODER_EDIT_LINE_CIRC
	but.help = "Select rounded end lines."
	cd.edimg.linebar.buts.insert(but)

	inc col
	but = guiCreateButton("square", BUT_BG_NORMAL, "", co.blueGrey[col])
	guiSetButtonIcon(but, cd.edimg.lineSqrImg)
	but.id = BUT_CODER_EDIT_LINE_SQR
	but.help = "Select square end lines."
	cd.edimg.linebar.buts.insert(but)

	guiHideBar(cd.edimg.lineBar)

	//
	// Start Color toolbar.
	//
	
	but = guiCreateButton("color", BUT_BG_NORMAL, "", co.blueGrey[col])
	guiSetButtonIcon(but, co.pixImg)
	SetSpriteScale(but.icon, 64, 64)
	but.id = BUT_CODER_EDIT_COLOR
	but.help = "Set the color to use will all drawing tools."
	cd.edimg.colorbar.buts.insert(but)

	but = guiCreateButton("erase", BUT_BG_NORMAL, "gfx/EraseIcon.png", co.blueGrey[col - 2])
	but.id = BUT_CODER_EDIT_ERASE
	but.help = "Set drawing tools to erase."
	cd.edimg.colorbar.buts.insert(but)

	guiHideBar(cd.edimg.colorBar)

	//
	// End color bar.
	//

	py = py + co.bs + gx

	col = 3
	xx = px
	but = guiCreateButton("cut", BUT_BG_NORMAL, "gfx/CutIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_CUT
	but.help = "Cut (erase) the selected area, and make it a selection."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("copy", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_COPY
	but.help = "Copy the selected area, and make it a selection."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("paste", BUT_BG_NORMAL, "gfx/PasteIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_PASTE
	but.help = "Paste a selection into the image at its current position."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("clear", BUT_BG_NORMAL, "gfx/ClearIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_CLEAR
	//but.help = "Clear the whole image, or clear a selected area. If a cut, copy or drawing tool selection is active, then that area will be cleared."
	cd.edimg.toolbar.buts.insert(but)

	py = py + co.bs + gx

	col = 3
	xx = px
	but = guiCreateButton("flip x", BUT_BG_NORMAL, "gfx/FlipIcon.png", co.bluegrey[col])
	SetSpriteAngle(but.icon, 90)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_FLIP_HORIZ
	//but.help = "Flip the image in the x axis, i.e. from left to right."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("flip y", BUT_BG_NORMAL, "gfx/FlipIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_FLIP_VERT
	//but.help = "Flip the image in the y axis, i.e. from top to bottom."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("rotate 90", BUT_BG_NORMAL, "gfx/RotateLeftIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_ROT_LEFT
	//but.help = "Rotate the image anti-clockwise 90 degree."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("rotate 90", BUT_BG_NORMAL, "gfx/RotateLeftIcon.png", co.bluegrey[col])
	SetSpriteFlip(but.icon, true,false)
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_ROT_RIGHT
	//but.help = "Rotate the image clockwise 90 degree."
	cd.edimg.toolbar.buts.insert(but)

	py = py + co.bs + gx

	col = 3
	xx = px
	but = guiCreateButton("grid", BUT_BG_NORMAL, "gfx/GridIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_GRID_SNAP
	//but.help = "Shows a grid over the image. Drawing elements like draw, line, etc. will snap to grid positions. The grid can also be used to split an image."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("cols", BUT_BG_NORMAL, "gfx/GridColsIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_GRID_COLS
	but.help = "Select how many columns in the grid."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("rows", BUT_BG_NORMAL, "gfx/GridRowsIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_GRID_ROWS
	but.help = "Select how many rows in the grid."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("split", BUT_BG_NORMAL, "gfx/SplitIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_SPLIT
	but.help = "Split an image into frames based on the grid. Used for image sheets, where there are multiple same sized blocks in one image."
	cd.edimg.toolbar.buts.insert(but)

	py = py + co.bs + gx

	col = 3
	xx = px
	but = guiCreateButton("set size", BUT_BG_NORMAL, "gfx/ResizeIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_SET_SIZE
	but.help = "Change the size of the image to a specific width and height."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("resize", BUT_BG_NORMAL, "gfx/GrowIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_RESIZE
	but.help = "Change the size of the image by dragging."
	cd.edimg.toolbar.buts.insert(but)

	inc col
	xx = xx + co.bs + gx
	but = guiCreateButton("crop", BUT_BG_NORMAL, "gfx/CropIcon.png", co.bluegrey[col])
	guiSetButtonDepth(but, depth - 2)
	guiSetButtonPos(but, xx, py)
	but.id = BUT_CODER_EDIT_CROP
	but.help = "Crop the image to just what is selected."
	cd.edimg.toolbar.buts.insert(but)
	
	guiSetBarVisible(cd.edimg.toolbar, false)

	cd.edimg.pz = 1.0
	cd.edimg.cx = 0
	cd.edimg.cy = 0
	cd.edimg.toolIdx = guiFindBarButtonById(cd.edimg.toolbar, BUT_CODER_EDIT_PAN)
	//cd.edimg.toolIdx = guiFindBarButtonById(cd.edimg.toolbar, BUT_CODER_EDIT_DRAW)

	cd.edimg.eraseButIdx = guiFindBarButtonById(cd.edimg.toolBar, BUT_CODER_EDIT_ERASE)

	//cd.edimg.zoomScales.insert(0.25)
	//cd.edimg.zoomScales.insert(0.5)
	cd.edimg.zoomScales.insert(1.0)
	cd.edimg.zoomScales.insert(2.0)
	cd.edimg.zoomScales.insert(3.0)
	cd.edimg.zoomScales.insert(4.0)
	cd.edimg.zoomScales.insert(5.0)

	cd.edimg.workZoom = CD_ZOOM_ONE
	cd.edsel.zoom = CD_ZOOM_ONE
	
	cdInitEditSelect()
	cdHideEditImage()
*/
	
	//
	// Keyboard / editing.
	//
	
	cd.editTitle = guicreatetext(" ", gui.titleFontSize)
	cd.masterEditBox.title = cd.editTitle
	cosettextcolor(cd.editTitle, co.black)
	SetTextVisible(cd.editTitle, false)

	local rgbNames as string[]
	local rgbErrs as string[]
	local resizeNames as string[]
	local editBox as EditBox

	rgbNames.insert("Enter a color as 0 to 255 or hex #0 to #ff, or select below" + chr(10) + "Red")
	rgbNames.insert(chr(10) + "Green")
	rgbNames.insert(chr(10) + "Blue")
	rgbNames.insert(chr(10) + "Transparency")
	rgbErrs.insert("Red in invalid.")
	rgbErrs.insert("Green in invalid.")
	rgbErrs.insert("Blue in invalid.")
	rgbErrs.insert("Transparency in invalid.")

	resizeNames.insert("Enter the width and height of the image" + chr(10) + "Width")	
	resizeNames.insert(chr(10) + "Height")

	for i = 0 to rgbNames.length

		editBox.title = guicreatetext(rgbNames[i], gui.titleFontSize)
		cosettextcolor(editBox.title, co.black)
		SetTextVisible(editBox.title, false)
		editBox.err = rgbErrs[i]
		cd.colorEditBox.insert(editBox)

	next

	for i = 0 to resizeNames.length

		editBox.title = guicreatetext(resizeNames[i], gui.titleFontSize)
		cosettextcolor(editBox.title, co.black)
		SetTextVisible(editBox.title, false)
		editBox.err = ""
		cd.resizeEditBox.insert(editBox)

	next 

	//co.bs * 10 - co.bs / 4
	//if WIN_MODE
	//	cd.keyPanel = guiCreatePanel(w, h, GUI_KEY_DEPTH, true, true)
	//else 
		cd.keyPanel = guiCreatePanel(ww, h, GUI_KEY_DEPTH, true, true)
	//endif
	
	cd.keyPanel.id = CD_KEY_PANEL
	guiSetPanelPos(cd.keyPanel, getspritex(cd.mainPanel.panel) + getspritewidth(cd.mainPanel.panel) + co.bs / 4, co.bs + co.bs / 2)
	cd.keyPanelx = cd.keypanel.vx // Save the original location.
	cd.keyPanely = cd.keypanel.vy // Save the original location.
	guiSetPanelColor(cd.keyPanel, co.grey[3], co.grey[2], co.grey[4])
	guiSetPanelContentSize(cd.keyPanel, getspritex(cd.keyPanel.panel), getspritey(cd.keyPanel.panel), getspritex(cd.keyPanel.panel) + GetSpriteWidth(cd.keyPanel.panel) - 1, getspritey(cd.keyPanel.panel) + GetSpriteHeight(cd.keyPanel.panel) - 1)
	
	if ld.set.trueEdit

		//cd.editBg = guiCreateBox("cdInit:editBg", GetSpriteWidth(cd.codePanel.panel), getspritey(cd.codePanel.panel) - co.bs / 4)
		//coSetSpriteColor(cd.editBg, co.grey[2])
		//SetSpritePosition(cd.editBg, getspritex(cd.codePanel.panel), co.bs / 4)
		//SetSpritedepth(cd.editBg, GUI_CTRL_DEPTH + 1)
		//SetSpriteVisible(cd.editBg, false)
		
		//cd.editBox = CreateEditBox()
		cd.editBox = cdCreateEditBox(ww - co.bs / 4)
		cd.masterEditBox.box = cd.editBox
/*
		//co.bs * 9 + co.bs / 2
		SetEditBoxSize(cd.editBox, ww - co.bs / 4, co.bs / 2)

		SetEditBoxPosition(cd.editBox, co.w - GetEditBoxWidth(cd.editBox) - co.bs * 2 - co.bs / 2 - co.bs / 8, co.bs / 2 + co.bs / 4)
		SetEditBoxTextColor(cd.editBox, 0, 0, 0)
		//SetEditBoxFont(cd.editBox, co.fonts[3])
		SetEditBoxTextSize(cd.editBox, 60)
		SetEditBoxCursorColor(cd.editBox, 3, 169, 244)
		SetEditBoxCursorWidth(cd.editBox, 3)
		SetEditBoxBackgroundColor(cd.editBox, 255, 255, 255, 255)
		SetEditBoxDepth(cd.editBox, GetSpriteDepth(cd.keyPanel.panel) - 2)
		SetEditBoxVisible(cd.editBox, false)
		SetEditBoxScissor(cd.editBox, geteditboxx(cd.editBox), geteditboxy(cd.editBox), geteditboxx(cd.editBox) + GetEditBoxWidth(cd.editBox) - 1, geteditboxy(cd.editBox) + GetEditBoxHeight(cd.editBox) - 1)
*/
		SetTextPosition(cd.editTitle, GetEditBoxx(cd.editBox), geteditboxy(cd.editBox) - GetTextTotalHeight(cd.editTitle))

		for i = 0 to rgbNames.length

			cd.colorEditBox[i].lt = coCreateSprite("editBoxLt", cd.ltArrImg)
			//coSetSpriteColor(cd.colorEditBox[i].lt, co.white)
			SetSpriteDepth(cd.colorEditBox[i].lt, GetSpriteDepth(cd.keyPanel.panel) - 2)
			SetSpriteVisible(cd.colorEditBox[i].lt, false)

			cd.colorEditBox[i].rt = coCreateSprite("editBoxRt", cd.rtArrImg)
			//coSetSpriteColor(cd.colorEditBox[i].lt, co.white)
			SetSpriteDepth(cd.colorEditBox[i].rt, GetSpriteDepth(cd.keyPanel.panel) - 2)
			SetSpriteVisible(cd.colorEditBox[i].rt, false)

			//cd.colorEditBox[i].box = guiCreateBox("cdInit:cd.editBox", co.bs, co.bs / 2)
			cd.colorEditBox[i].box = cdCreateEditBox(co.bs)
			//coSetSpriteColor(cd.colorEditBox[i].box, co.white)
			//SetSpriteDepth(cd.colorEditBox[i].box, GetSpriteDepth(cd.keyPanel.panel) - 2)
			//SetSpriteVisible(cd.colorEditBox[i].box, false)

			cd.colorEditBox[i].text = guicreatetext("", gui.editFontSize)
			cosettextcolor(cd.colorEditBox[i].text, co.black)
			SetTextDepth(cd.colorEditBox[i].text, GetSpriteDepth(cd.keyPanel.panel) - 6)
			SetTextVisible(cd.colorEditBox[i].text, false)

		next

		for i = 0 to resizeNames.length

			//cd.resizeEditBox[i].box = guiCreateBox("cdInit:cd.editBox", co.bs * 3, co.bs / 2)
			cd.resizeEditBox[i].box = cdCreateEditBox(co.bs * 3)
			//coSetSpriteColor(cd.resizeEditBox[i].box, co.white)
			//SetSpriteDepth(cd.resizeEditBox[i].box, GetSpriteDepth(cd.keyPanel.panel) - 2)
			//SetSpriteVisible(cd.resizeEditBox[i].box, false)

			cd.resizeEditBox[i].text = guicreatetext("", gui.editFontSize)
			cosettextcolor(cd.resizeEditBox[i].text, co.black)
			SetTextDepth(cd.resizeEditBox[i].text, GetSpriteDepth(cd.keyPanel.panel) - 6)
			SetTextVisible(cd.resizeEditBox[i].text, false)

		next

	else

		cd.editBox = guiCreateBox("cdInit:cd.editBox", co.bs * 9 + co.bs / 2, co.bs / 2)
		cd.masterEditBox.box = cd.editBox
		
		coSetSpriteColor(cd.editBox, co.white)
		//SetSpritePosition(cd.editBox, cd.topEditX, cd.topEditY)
		SetSpriteDepth(cd.editBox, GetSpriteDepth(cd.keyPanel.panel) - 2)
		SetSpriteVisible(cd.editBox, false)
		
		cd.editText = guiCreateText("", gui.editFontSize)
		cd.masterEditBox.text = cd.editText
		
		coSetTextColor(cd.editText, co.black)
		//cd.editTextX = getspritex(cd.editBox) + co.bs / 16
		//SettextPosition(cd.edittext, cd.editTextX, getspritey(cd.editBox))
		SetTextDepth(cd.editText, GetSpriteDepth(cd.keyPanel.panel) - 6)
		SetTextVisible(cd.editText, false)

		cd.editSelection = guiCreateBox("cdInit:cd.editSelection", 1, 1)
		cosetspritecolor(cd.editSelection, co.lightblue[5])
		setspritedepth(cd.editSelection, GetSpriteDepth(cd.keyPanel.panel) - 4)
		setspritevisible(cd.editSelection, false)

/*
		cd.cursorObj = createbox(co.bs / 16, GetSpriteHeight(cd.editBox) - co.bs / 16)
		cosetspritecolor(getsprite(cd.cursorObj), co.lightblue[5])
		setdepth(cd.cursorObj, GetSpriteDepth(cd.keyPanel.panel) - 8)
		setvisible(cd.cursorObj, false)
*/

		cd.cursorObj = guicreatebox("cursor", co.bs / 16, GetSpriteHeight(cd.editBox) - co.bs / 16)
		cosetspritecolor(cd.cursorObj, co.lightblue[5])
		SetSpriteDepth(cd.cursorObj, GetSpriteDepth(cd.keyPanel.panel) - 8)
		SetSpriteVisible(cd.cursorObj, false)
		
		cd.cursorObjTimer = 0

		for i = 0 to rgbNames.length

			cd.colorEditBox[i].lt = coCreateSprite("editBoxLt", cd.ltArrImg)
			//coSetSpriteColor(cd.colorEditBox[i].lt, co.white)
			SetSpriteDepth(cd.colorEditBox[i].lt, GetSpriteDepth(cd.keyPanel.panel) - 2)
			SetSpriteVisible(cd.colorEditBox[i].lt, false)

			cd.colorEditBox[i].rt = coCreateSprite("editBoxRt", cd.rtArrImg)
			//coSetSpriteColor(cd.colorEditBox[i].lt, co.white)
			SetSpriteDepth(cd.colorEditBox[i].rt, GetSpriteDepth(cd.keyPanel.panel) - 2)
			SetSpriteVisible(cd.colorEditBox[i].rt, false)

			cd.colorEditBox[i].box = guiCreateBox("cdInit:cd.editBox", co.bs, co.bs / 2)
			coSetSpriteColor(cd.colorEditBox[i].box, co.white)
			SetSpriteDepth(cd.colorEditBox[i].box, GetSpriteDepth(cd.keyPanel.panel) - 2)
			SetSpriteVisible(cd.colorEditBox[i].box, false)

			cd.colorEditBox[i].text = guicreatetext("", gui.editFontSize)
			cosettextcolor(cd.colorEditBox[i].text, co.black)
			SetTextDepth(cd.colorEditBox[i].text, GetSpriteDepth(cd.keyPanel.panel) - 6)
			SetTextVisible(cd.colorEditBox[i].text, false)

		next

		for i = 0 to resizeNames.length

			cd.resizeEditBox[i].box = guiCreateBox("cdInit:cd.editBox", co.bs * 3, co.bs / 2)
			coSetSpriteColor(cd.resizeEditBox[i].box, co.white)
			SetSpriteDepth(cd.resizeEditBox[i].box, GetSpriteDepth(cd.keyPanel.panel) - 2)
			SetSpriteVisible(cd.resizeEditBox[i].box, false)

			cd.resizeEditBox[i].text = guicreatetext("", gui.editFontSize)
			cosettextcolor(cd.resizeEditBox[i].text, co.black)
			SetTextDepth(cd.resizeEditBox[i].text, GetSpriteDepth(cd.keyPanel.panel) - 6)
			SetTextVisible(cd.resizeEditBox[i].text, false)

		next
		
	endif

/*
	cd.partFlashObj = createbox(1, 1)
	setpos(cd.partFlashObj, -100, -100)
	setvisible(cd.partFlashObj, false)
*/

	cd.partFlashObj = guicreatebox("flash", 1, 1)
	SetSpritePositionByOffset(cd.partFlashObj, -100, -100)
	SetSpriteVisible(cd.partFlashObj, false)
	cd.partFlashObjTimer = 0
	
	cd.partFlashMin = 0
	cd.partFlashMax = 255
	
	cd.editBlankAllowed = true
	
	cd.acceptBut = guiCreateButton("accept", BUT_BG_NORMAL, "gfx/DoneIcon.png", co.green[4])
	guiSetButtonDepth(cd.acceptBut, GetSpriteDepth(cd.keyPanel.panel) - 2)
	
	cd.acceptButX = co.w - co.bs * 2 + co.bs / 8
	cd.acceptButY = co.bs / 2 + co.bs / 4 + co.bs / 8
	
	guiSetButtonPos(cd.acceptBut, cd.acceptButX, cd.acceptButY)
	guiSetButtonVisible(cd.acceptBut, false)

	cd.cancelBut = guiCreateButton("cancel", BUT_BG_NORMAL, "gfx/CancelIcon.png", co.red[5])
	guiSetButtonDepth(cd.cancelBut, GetSpriteDepth(cd.keyPanel.panel) - 2)
	guiSetButtonPos(cd.cancelBut, cd.acceptButX + GetSpriteWidth(cd.acceptBut.bg), cd.acceptButY)
	guiSetButtonVisible(cd.cancelBut, false)

//
	cd.allBut = guiCreateButton("all", BUT_BG_NORMAL, "gfx/SelectAllIcon.png", co.lightblue[5])
	guiSetButtonDepth(cd.allBut, GetSpriteDepth(cd.keyPanel.panel) - 2)		
	guiSetButtonPos(cd.allBut, cd.acceptButX, cd.acceptButY + co.bs + co.bs / 2)
	guiSetButtonVisible(cd.allBut, false)

	cd.autoAcceptBut = guiCreateButton("auto", BUT_BG_NORMAL, "gfx/DoneIcon.png", co.lightgreen[3])
	guiSetButtonDepth(cd.autoAcceptBut, GetSpriteDepth(cd.keyPanel.panel) - 2)		
	guiSetButtonPos(cd.autoAcceptBut, cd.acceptButX, cd.acceptButY + co.bs + co.bs / 2)
	guiSetButtonVisible(cd.autoAcceptBut, false)

	cd.noneBut = guiCreateButton("none", BUT_BG_NORMAL, "gfx/ClearIcon.png", co.grey[5])
	guiSetButtonDepth(cd.noneBut, GetSpriteDepth(cd.keyPanel.panel) - 2)
	guiSetButtonPos(cd.noneBut, cd.acceptButX + GetSpriteWidth(cd.acceptBut.bg), cd.acceptButY + co.bs + co.bs / 2)
	guiSetButtonVisible(cd.noneBut, false)

	cdSetSettingsAutoAcceptButton()

//

	cd.editCmdTitle = guicreatetext(" ", gui.titleFontSize)
	coSetTextColor(cd.editCmdTitle, co.black)
	SetTextPosition(cd.editCmdTitle, getspritex(cd.keyPanel.panel) + co.bs / 8, getspritey(cd.keyPanel.panel))
	SetTextDepth(cd.editCmdTitle, GetSpriteDepth(cd.keyPanel.panel) - 2)
	SetTextVisible(cd.editCmdTitle, false)

	if not ld.set.trueEdit
		
		cd.keySet[CD_KEYSET_NAME].normset = cd.alphas + cd.digits + "-_ "
		cd.keySet[CD_KEYSET_NAME].specset = ";<<;^-;^ ;AB;12;#+;<-;->"
		cd.keySet[CD_KEYSET_NAME].helpMsg = "Names must start with a letter, and only\ncontain letters, digits, space, - or _. Names cannot be blank."
		rule.typ = CD_KEYRULE_NAME
		rule.helpMsg = cd.keySet[CD_KEYSET_NAME].helpMsg
		cd.keySet[CD_KEYSET_NAME].rules.insert(rule)

		cd.keySet[CD_KEYSET_INTEGER].normset = cd.digits + "-"
		cd.keySet[CD_KEYSET_INTEGER].specset = ";<<;<-;->"
		cd.keySet[CD_KEYSET_INTEGER].helpMsg = "Whole numbers can start with a - and only contain digits."
		rule.typ = CD_KEYRULE_INTEGER
		rule.helpMsg = cd.keySet[CD_KEYSET_INTEGER].helpMsg
		cd.keySet[CD_KEYSET_INTEGER].rules.insert(rule)
		
		cd.keySet[CD_KEYSET_DECIMAL].normset = cd.digits + "-."
		cd.keySet[CD_KEYSET_DECIMAL].specset = ";<<;<-;->"
		cd.keySet[CD_KEYSET_DECIMAL].helpMsg = "Decimal numbers can start with a - and only contain digits and one point (dot)."
		rule.typ = CD_KEYRULE_DECIMAL
		rule.helpMsg = cd.keySet[CD_KEYSET_DECIMAL].helpMsg
		cd.keySet[CD_KEYSET_DECIMAL].rules.insert(rule)
		
		cd.keySet[CD_KEYSET_ALL].normset = cd.alphas + cd.digits + cd.syms
		cd.keySet[CD_KEYSET_ALL].specset = ";<<;^-;^ ;AB;12;#+;<-;->"
		cd.keySet[CD_KEYSET_ALL].helpMsg = ""

		cd.keySet[CD_KEYSET_COLOR].normset = cd.digits + "ABCDEF#"
		cd.keySet[CD_KEYSET_COLOR].specset = ";<<;<-;->"
		cd.keySet[CD_KEYSET_COLOR].helpMsg = "Color format is decimal value 0 to 255 or hex value #0 to #ff"
		rule.typ = CD_KEYRULE_COLOR
		rule.helpMsg = cd.keySet[CD_KEYSET_COLOR].helpMsg
		cd.keySet[CD_KEYSET_COLOR].rules.insert(rule)
		
		s = " q w e r t y u i o p<<;;;  a s d f g h j k l[];;^- z x c v b n m!,?.^-;;12  <-->12"
		cdCreateKeyboard(s, CD_KBD_LOWER)

		s = " Q W E R T Y U I O P<<;;;  A S D F G H J K L[];;^  Z X C V B N M!,?.^ ;;12  <-->12"
		cdCreateKeyboard(s, CD_KBD_UPPER)
		
		s = " 1 2 3 4 5 6 7 8 9 0<<;;;  - / : ; ( ) $ & @[];;#+; ; ;  . , ? ! ' " + chr(34) + "; #+;;AB  <-->AB"
		cdCreateKeyboard(s, CD_KBD_NUMSYM)
		
		s = " [ ] { } # % ^ * + =<<;;;  _ \ | ~ < > # E Y[];;12; ; ;  . , ? ! ' " + chr(34) + "; 12;;AB  <-->AB"
		cdCreateKeyboard(s, CD_KBD_SYM2)

		//s = " 1 2 3 4 5 6 7 8 9 0<<;;;  -; ; ; ; ; ; ; ; ; ; ; ; ; ; ; ; [];;; ; ; ;  .;;; ; ; ; ; ; ; ; ; ; ; ; ; ; ; <-->"
		//s = " 1 2 3 4 5 6 7 8 9 0<<;;;  - .; ; ; ; ; ; ; ; ; ; ; ; ; ; ; [];;; ; ; ; ;;; ; ; ; ; ; ; ; ; ; ; ; ; ; ; <-->"
		s = " 1 2 3 4 5 6 7 8 9 0<<;;;  - .; ; ; ; ; ; ; ; ; ; <-->[]"
		cdCreateKeyboard(s, CD_KBD_NUMONLY)

		//s = " 1 2 3 4 5 6 7 8 9 0<<;;;  A B C D E F; ; ; ; ; ; ; ; ; ; ; [];;; ; ; ; ;;; ; ; ; ; ; ; ; ; ; ; ; ; ; ; <-->"
		s = " 1 2 3 4 5 6 7 8 9 0<<;;;  A B C D E F #; ; <-->[]"
		cdCreateKeyboard(s, CD_KBD_COLOR)
		
		cdSetKeyboardVisible(-1)
		cdSetKeySet(-1)
		
	endif
	
	//
	// Cmds.
	//
		
	cd.edgeImgs.length = -1
	
	edgeImg = loadimage("gfx/RndEdge.png") // Stmt.
	cd.imgs.insert(edgeImg)
	cd.edgeImgs.insert(edgeImg)

	edgeImg = loadimage("gfx/SqrEdge.png") // Oper.
	cd.imgs.insert(edgeImg)
	cd.edgeImgs.insert(edgeImg)

	edgeImg = loadimage("gfx/TriEdge.png") // Cond.
	cd.imgs.insert(edgeImg)
	cd.edgeImgs.insert(edgeImg)

	cd.cmdSelLt = guiCreateBox("cdInit:cd.cmdSelLt", 1, 1)
	coSetSpriteColor(cd.cmdSelLt, co.black)
	//cd.sprs.insert(cd.cmdSelLt)

	cd.cmdSelRt = guiCreateBox("cdInit:cd.cmdSelRt", 1, 1)
	coSetSpriteColor(cd.cmdSelRt, co.black)
	//cd.sprs.insert(cd.cmdSelRt)
		
	cd.cmdSelMid = guiCreateBox("cdInit:cd.cmdSelMid", 1, 1)
	coSetSpriteColor(cd.cmdSelMid, co.black)
	//cd.sprs.insert(cd.cmdSelMid)

	cd.thingSel = guiCreateBox("cdInit:cd.thingSel", 1, 1)
	coSetSpriteColor(cd.thingSel, co.black)
	//cd.sprs.insert(cd.thingSel)

	cd.thingSelArrImg = loadimage("gfx/TipUp.png")
	cd.imgs.insert(cd.thingSelArrImg)
	cd.thingSelArr = cocreatesprite("cd.thingSelArrImg", cd.thingSelArrImg)
	coSetSpriteColor(cd.thingSelArr, co.black)
	//cd.sprs.insert(cd.thingSelArr)

	cdCreateColors()
	
	cd.thingTab = -1
	cdSetThingsVisible("b", false)
	cd.thingTab = GRP_SPRITE
	cdSetThingsVisible("c", true)

	cdInitObjVars()

	x = getspritex(cd.cmdPanels[GRP_BEGIN].panel) + co.bs / 8
	yy = getspritey(cd.cmdPanels[GRP_BEGIN].panel) + co.bs / 8

	if AGK_BUILD
		
		agAgkCreateCmds(x, yy)

	else 
		
		// Build all sel cmds.
		cdCreateAllCmds(x, yy)
		cdSetupCmdHelp(ld.cmdhelp)
		cdSetupPageHelp()
		
	endif
	
	cdSetGrpContentSizes()

	// Show the first tab.
	cd.grpTab = -1
	cdSetGrpVisible(false)
	cd.grpTab = GRP_BEGIN
	cdSetGrpVisible(true)
	
	// Set code visible.
	cdSetCodeVisible(true)

	cd.mainTab = CD_TAB_APP
	cd.fileTab = CD_FILE_TAB_CODE

	cd.appId = ""
	cd.appIdx = -1
	cd.thingId = ""
	cd.thingIdx = -1
	
	// Base depth for drop.
	//cd.topDepth = getspritedepth(cd.codePanel.panel) - 2

	cdSetTabVisible("j", true)

	cdLoadApps()
	
	cdHide()
	
endfunction

//-----------------------------------------------------
//
function cdCreateEditBox(ww as float)
	
	local editBox as integer
	
	editBox = CreateEditBox()
	SetEditBoxSize(editBox, ww, co.bs / 2)
	SetEditBoxPosition(editBox, co.w - GetEditBoxWidth(editBox) - co.bs * 2 - co.bs / 2 - co.bs / 8, co.bs / 2 + co.bs / 4)
	SetEditBoxTextColor(editBox, 0, 0, 0)
	SetEditBoxTextSize(editBox, 60)
	SetEditBoxCursorColor(editBox, 3, 169, 244)
	SetEditBoxCursorWidth(editBox, 3)
	SetEditBoxBackgroundColor(editBox, 255, 255, 255, 255)
	SetEditBoxDepth(editBox, GetSpriteDepth(cd.keyPanel.panel) - 2)
	SetEditBoxVisible(editBox, false)
	SetEditBoxScissor(editBox, geteditboxx(editBox), geteditboxy(editBox), geteditboxx(editBox) + GetEditBoxWidth(editBox) - 1, geteditboxy(editBox) + GetEditBoxHeight(editBox) - 1)
	
endfunction editBox

//-----------------------------------------------------
// 
function cdDestroy()

	local i as integer
	
	cd.helpDetails.nbrs.length = -1
	cd.helpDetails.gaps.length = -1

	cdClearDetailedHelp(false)

	deleteimage(cd.helpDetails.circImg)
	cd.helpDetails.circImg = 0

	codeletesprite("target", cd.target)
	cd.target = 0
		
	codeleteimage("targetImg", cd.targetImg)
	cd.targetImg = 0
	
	cd.grpCols.length = -1
	cd.cmdCols.length = -1
	cd.barCols.length = -1
	cd.dragCols.length = -1
	cd.selCols.length = -1
			
	cd.tabCols.length = -1
	cd.tabBarCols.length = -1
	cd.tabPipCols.length = -1
	
	guiDeleteToolbar(cd.grpBar)
	guiDeleteToolbar(cd.thingBar)
	guiDeleteToolbar(cd.cmdBar)
	guiDeleteToolbar(cd.partBar)
	guiDeleteToolbar(cd.toolBar)
	guiDeleteToolbar(cd.varBar)
	guiDeleteToolbar(cd.varValueBar)
	guiDeleteToolbar(cd.codeBar)
	guiDeleteToolbar(cd.helpBar)
	guiDeleteToolbar(cd.appBar)
	guiDeleteToolbar(cd.spriteBar)
	//guiDeleteToolbar(cd.fileBar)
	guiDeleteToolbar(cd.addItemBar)
	guiDeleteToolbar(cd.imageItemBar)
	guiDeleteToolbar(cd.imageBlankItemBar)
	guiDeleteToolbar(cd.soundItemBar)
	guiDeleteToolbar(cd.videoItemBar)
	guiDeleteToolbar(cd.varItemBar)
	guiDeleteToolbar(cd.varValueItemBar)
	guiDeleteToolbar(cd.projItemBar)
	guiDeleteToolbar(cd.projBlankItemBar)
	guiDeleteToolbar(cd.folderItemBar)
	guiDeleteToolbar(cd.frameBar)
	guiDeleteToolbar(cd.soundBar)
	guiDeleteToolbar(cd.videoBar)
	//guiDeleteToolbar(cd.edimg.toolBar)
	//guiDeleteToolbar(cd.settingsBar)
	guiDeleteToolbar(cd.moreBar)

	for i = 0 to cd.keybar.length
		guiDeleteToolbar(cd.keyBar[i])
	next

	guiDeletePanel(cd.mainPanel)

	DeleteImage(cd.dragImg)
	cd.dragImg = 0
	DeleteImage(cd.appImg)
	cd.appImg = 0
	DeleteImage(cd.loadedImg)
	cd.loadedImg = 0
	DeleteImage(cd.loadedIconImg)
	cd.loadedIconImg = 0
	DeleteImage(cd.thingImg)
	cd.thingImg = 0
	DeleteImage(cd.codeImg)
	cd.codeImg = 0
	DeleteImage(cd.foldImg)
	cd.foldImg = 0
	DeleteImage(cd.tickOnImg)
	cd.tickOnImg = 0
	DeleteImage(cd.tickOffImg)
	cd.tickOffImg = 0
	DeleteImage(cd.shareImg)
	cd.shareImg = 0
	DeleteImage(cd.unshareImg)
	cd.unshareImg = 0
	DeleteImage(cd.openImg)
	cd.openImg = 0
	DeleteImage(cd.closeImg)
	cd.closeImg = 0
	DeleteImage(cd.builtInImg)
	cd.builtInImg = 0
	DeleteImage(cd.smallBuiltInImg)
	cd.smallBuiltInImg = 0
	DeleteImage(cd.sharedByYouImg)
	cd.sharedByYouImg = 0
	DeleteImage(cd.sharedToYouImg)
	cd.sharedToYouImg = 0
	DeleteImage(cd.purchasedImg)
	cd.purchasedImg = 0
	DeleteImage(cd.forSaleImg)
	cd.forSaleImg = 0
	DeleteImage(cd.appVarImg)
	cd.appVarImg = 0
	DeleteImage(cd.spriteVarImg)
	cd.spriteVarImg = 0
	DeleteImage(cd.varButImg)
	cd.varButImg = 0
	DeleteImage(cd.soundImg)
	cd.soundImg = 0
	DeleteImage(cd.videoImg)
	cd.videoImg = 0
	DeleteImage(cd.findImg)
	cd.findImg = 0
	DeleteImage(cd.refreshImg)
	cd.refreshImg = 0
	DeleteImage(cd.childImg)
	cd.childImg = 0
	DeleteImage(cd.subFolderImg)
	cd.subFolderImg = 0
	DeleteImage(cd.backImg) 
	cd.backImg = 0
	DeleteImage(cd.upImg) 
	cd.upImg = 0
	DeleteImage(cd.removeImg)
	cd.removeImg = 0
	DeleteImage(cd.cancelImg) 
	cd.cancelImg = 0
	DeleteImage(cd.ltArrImg)
	cd.ltArrImg = 0
	DeleteImage(cd.rtArrImg)
	cd.rtArrImg = 0
	DeleteImage(cd.transImg)
	cd.transImg = 0

	guiDeleteButton(cd.appBut)
	guiDeleteButton(cd.thingBut)
	guiDeleteButton(cd.cmdBut)
	
	guiDeletePanel(cd.codePanel)
	
	guiDeleteButton(cd.helpBut)
	guiDeleteButton(cd.codeBut)

	deletesprite(cd.codeScroll)

	for i = GRP_BEGIN to GRP_VIDEO //GRP_VAR
		guiDeletePanel(cd.cmdPanels[i])
	next
	
	cd.cmdPanels.length = -1

	guiDeletePanel(cd.loadPanel)

	guiDeleteButton(cd.libraryBut)

	guiDeletePanel(cd.helpPanel)
	
	codeletetext("prev", cd.prevValueTitle)
	cd.prevValueTitle = 0

	//
	// Keyboard / editing.
	//
	
	codeletetext("edittitle", cd.editTitle)
	cd.editTitle = 0

	for i = 0 to cd.colorEditBox.length
		
		codeletesprite("colorlt", cd.colorEditBox[i].lt) 
		codeletesprite("colorrt", cd.colorEditBox[i].rt)
		
		if ld.set.trueEdit
			DeleteEditBox(cd.colorEditBox[i].box)
		else 
			codeletesprite("colorbox", cd.colorEditBox[i].box) 
		endif
		
		if cd.editBox = cd.colorEditBox[i].box
			cd.editBox = 0
		endif
		
		if cd.colorEditBox[i].text then codeletetext("colortext", cd.colorEditBox[i].text)
		
	next
	
	cd.colorEditBox.length = -1

	for i = 0 to cd.resizeEditBox.length
		
		codeletesprite("resizelt", cd.resizeEditBox[i].lt) 
		codeletesprite("resizert", cd.resizeEditBox[i].rt)
		
		if ld.set.trueEdit
			DeleteEditBox(cd.resizeEditBox[i].box)
		else 
			codeletesprite("resizebox", cd.resizeEditBox[i].box) 
		endif

		if cd.editBox = cd.resizeEditBox[i].box
			cd.editBox = 0
		endif
		
		if cd.resizeEditBox[i].text then codeletetext("resizetext", cd.resizeEditBox[i].text)
		
	next 
	
	cd.resizeEditBox.length = -1

	//co.bs * 10 - co.bs / 4
	guiDeletePanel(cd.keyPanel)
	
	if ld.set.trueEdit
		
		if cd.editBox
			
			deleteeditbox(cd.editBox)
			cd.editBox = 0
			
		endif

	else

		if cd.editBox
			
			codeletesprite("Editbox", cd.editBox)
			cd.editBox = 0
			
		endif

		if cd.editText then codeletetext("edittext", cd.editText)
		codeletesprite("editsel", cd.editSelection)
		codeletesprite("cursor", cd.cursorObj)
		
	endif

	codeletesprite("partflash", cd.partFlashObj)	

	guiDeleteButton(cd.acceptBut) 
	guideletebutton(cd.cancelBut)
	guideletebutton(cd.allBut)

	guideletebutton(cd.autoAcceptBut)

	guideletebutton(cd.noneBut)

	codeletetext("editcmdtitle", cd.editCmdTitle)
	
	if not ld.set.trueEdit
		
		cd.keySet[CD_KEYSET_NAME].rules.length = -1
		cd.keySet[CD_KEYSET_INTEGER].rules.length = -1		
		cd.keySet[CD_KEYSET_DECIMAL].rules.length = -1
		cd.keySet[CD_KEYSET_COLOR].rules.length = -1
		
		cdDeleteKeyboard(CD_KBD_LOWER)
		cdDeleteKeyboard(CD_KBD_UPPER)
		cdDeleteKeyboard(CD_KBD_NUMSYM)
		cdDeleteKeyboard(CD_KBD_SYM2)
		cdDeleteKeyboard(CD_KBD_NUMONLY)
		cdDeleteKeyboard(CD_KBD_COLOR)
		
	endif
	
	for i = 0 to cd.imgs.length	
		deleteimage(cd.imgs[i])
	next
	
	cd.imgs.length = -1

	for i = 0 to cd.edgeimgs.length	
		deleteimage(cd.edgeimgs[i])
	next

	cd.edgeImgs.length = -1

	codeletesprite("cmdsellt", cd.cmdSelLt)
	codeletesprite("cmdselrt", cd.cmdSelRt)		
	codeletesprite("cmdselmid", cd.cmdSelMid)

	codeletesprite("thingsel", cd.thingSel)

	cdDeleteColors()
	cdDeleteAllCmds()
	
	//cdDestroyGrpContentSizes()

	cdUnloadApps()
	
endfunction

//-----------------------------------------------------
// Create the color boxes to select colors for a part.
//
function cdCreateColors()

	local x as float
	local y as float
	local xsize as float
	local ysize as float
	local box as integer
	local w as float
	local h as float
	local size as float
	local s as float
	local img as integer
	
	xsize = co.bs / 2
	ysize = co.bs / 2 - 8
	x = 0
	y = 0
	
	cdCreateColorList(co.red, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.deeporange, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.orange, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.amber, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.yellow, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.lime, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.lightgreen, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.green, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.teal, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.cyan, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.lightblue, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.blue, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.indigo, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.deeppurple, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.purple, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.brown, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.bluegrey, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColorList(co.grey, x, y, xsize, ysize)
	x = x + xsize
	cdCreateColor(co.white, x, y, xsize, ysize)
	y = y + ysize
	cdCreateColor(co.black, x, y, xsize, ysize)
	y = y + ysize

	//cd.colTransImg = coCreateTransImg(1, xsize, ysize)		
	//box = createsprite(cd.colTransImg)
	//SetSpritePosition(box, x, y)
	//cd.colorBoxes.insert(box)
	//SetSpriteVisible(box, false)

	y = y + ysize

endfunction

//-----------------------------------------------------
// Create the color boxes to select colors for a part.
//
function cdCreateColorList(list ref as integer[], x as float, y as float, xsize as float, ysize as float)

	local i as integer
	local box as integer
	
	for i = 0 to list.length

		box = cdCreateColor(list[i], x, y, xsize, ysize)
		y = y + ysize
		
	next

endfunction

//-----------------------------------------------------
// Create the color boxes to select colors for a part.
//
function cdCreateColor(col as integer, x as float, y as float, xsize as float, ysize as float)

	local box as integer
		
	box = guiCreateBox("colorbox", xsize, ysize)
	coSetSpriteColor(box, col)
	SetSpritePosition(box, x, y)
	cd.colorBoxes.insert(box)
	SetSpriteVisible(box, false)

endfunction box

//-----------------------------------------------------
// Delete all colors.
//
function cdDeleteColors()

	local i as integer
	
	for i = 0 to cd.colorBoxes.length
		codeletesprite("colorbox", cd.colorBoxes[i])
	next 
	
	cd.colorBoxes.length = -1

endfunction

//-----------------------------------------------------
//
function cdCreateKeyboard(s as string, idx as integer)

	local x as float
	local y as float
	local xx as float
	local yy as float
	local c1 as string
	local c2 as string
	local gap as float
	local gapScale as float
	local but as Button
	local i as integer
	local col as integer

	xx = getspritex(cd.keyPanel.panel) + co.bs / 8
	yy = getspritey(cd.keyPanel.panel) + co.bs / 8
	//yy = yy + co.bs * 3
	yy = yy + co.bs * 4
	x = xx
	y = yy
	gap = co.bs / 2 - co.bs / 16
	gapScale = gap / co.bs
	col = co.white // co.grey[3]
	
	for i = 1 to len(s) step 2

		c1 = mid(s, i, 1)
		c2 = mid(s, i + 1, 1)

		if c1 = ";" and c2 = ";"

			x = xx
			y = y + GetSpriteheight(but.bg) + co.bs / 8

		elseif c1 = ";"	and c2 = " "
						
			x = x + gap
			
		else
			
			if c1 = "<" and c2 = "<"
				
				but = guiCreateButton("", BUT_KEY, "gfx/KbdBackIcon.png", col)
				but.id = KEY_BACK
				
			elseif c1 = "^" and c2 = "-"
				
				but = guiCreateButton("", BUT_KEY, "gfx/KbdUpIcon.png", col)
				but.id = KEY_SHIFT
				
			elseif c1 = "^" and c2 = " "
				
				but = guiCreateButton("", BUT_KEY, "gfx/KbdCapsIcon.png", col)
				but.id = KEY_CTRL_UNSHIFT
				
			elseif c1 = "A" and c2 = "B"
		
				but = guiCreateButton("abc", BUT_MEDIUM_KEY, "", col)
				but.id = KEY_CTRL_ABC
								
			elseif c1 = "[" and c2 = "]"
				
				but = guiCreateButton("enter", BUT_MEDIUM_KEY, "", col)
				but.id = KEY_ENTER

			elseif c1 = "1" and c2 = "2"
				
				but = guiCreateButton("123", BUT_MEDIUM_KEY, "", col)
				but.id = KEY_CTRL_123
							
			elseif c1 = "#" and c2 = "+"
				
				but = guiCreateButton("#+=", BUT_MEDIUM_KEY, "", col)
				but.id = KEY_CTRL_SYM
								
			elseif c1 = "<" and c2 = "-"
				
				but = guiCreateButton("", BUT_KEY, "gfx/KbdLeftIcon.png", col)
				but.id = KEY_CTRL_LEFT
							
			elseif c1 = "-" and c2 = ">"
				
				but = guiCreateButton("", BUT_KEY, "gfx/KbdRightIcon.png", col)
				but.id = KEY_CTRL_RIGHT
							
			elseif c1 = " " and c2 = " "
				
				but = guiCreateButton(" ", BUT_HUGE_KEY, "", col)
				but.id = KEY_SPACE
				
			elseif c1 = " " // Single key.
								
				but = guiCreateButton(c2, BUT_KEY, "", col)
				but.id = asc(c2)
				
			else // Dual key.
				
				but = guiCreateButton(c2, BUT_KEY, c1, col)
				
				if idx = CD_KBD_LOWER
					but.id = asc(c2)
				elseif idx = CD_KBD_UPPER
					but.id = -asc(c1)
				endif
				
			endif

			guiSetButtonDepth(but, GetSpriteDepth(cd.keyPanel.panel) - 2)
			guiSetButtonPos(but, x + GetSpriteWidth(but.bg) / 2, y + GetSpriteheight(but.bg) / 2)
			guiSetButtonBgSel(but, true, co.grey[5])
			cd.keyBar[idx].buts.insert(but)
			x = x + GetSpriteWidth(but.bg) + co.bs / 8

		endif

	next

endfunction

//-----------------------------------------------------
//
function cdDeleteKeyboard(idx as integer)
	
	guiDeleteToolbar(cd.keyBar[idx])
	
	/*
	local i as integer
	
	for i = 0 to cd.keyBar[idx].buts.length
		guiDeleteButton(cd.keyBar[idx].buts[i])
	next 
	
	cd.keyBar[idx].buts.length = -1
	*/
	
endfunction

global sss as integer

//-----------------------------------------------------
//
function cdSetKeyboardVisible(idx as integer)

	local i as integer
	local j as integer
	local y as float
	local yy as float

	cd.kbdIdx = idx
	cd.key = ""
	//cd.scanCode = 0
	cd.keyRepeatTime = 0
	cd.keyWaitTime = KEY_WAIT_TIME
	
	cdHideKeyPresses()
	
	guiSetPanelVisible(cd.keyPanel, false)
		
	for i = 0 to cd.keybar.length	
		guiSetBarVisible(cd.keyBar[i], false)
	next

	guiSetPanelVisible(cd.keyPanel, true)

	y = 0
	yy = y

	if idx > -1

//colog("len=" + str(cd.keybar[idx].buts.length))

		guiSetBarVisible(cd.keyBar[idx], true)
		cdHideKeyboardKeys(idx)
		
		for j = 0 to cd.keybar[idx].buts.length

			if guiGetButtonVisible(cd.keybar[idx].buts[j])
//colog("x=" + str(getspritex(cd.keybar[idx].buts[j].bg)) + ", y=" + str(getspritey(cd.keybar[idx].buts[j].bg)))
				
				yy = getspritey(cd.keybar[idx].buts[j].bg) + GetSpriteHeight(cd.keybar[idx].buts[j].bg)
				
				if yy > y
					y = yy
				endif
				
			endif
			
		next

	endif
	
endfunction y

//-----------------------------------------------------
//
function cdSetKeySet(keySetIdx as integer)

	cd.keySetIdx = keySetIdx

	if cd.keySetIdx > -1
		cd.keyset[cd.keySetIdx].hiddenSet = ""
	endif
	
endfunction

//-----------------------------------------------------
// Hide a single key on the given keyboard.
//
function cdHideKeyboardKeys(idx as integer)

	local i as integer
	local j as integer
	local txt as string 

	if cd.keySetIdx = -1
		exitfunction
	endif
	
	for i = 0 to cd.keybar[idx].buts.length

		txt = cdGetSpecialKey(cd.keybar[idx].buts[i].id)

		if txt <> ""
			
			if findstring(cd.keyset[cd.keySetIdx].specSet, ";" + txt) = 0
				guiSetButtonVisible(cd.keyBar[idx].buts[i], false)
			endif
			
		else

			txt = GetTextString(cd.keybar[idx].buts[i].text)

			if FindString(cd.keyset[cd.keySetIdx].normSet, txt) = 0
				guiSetButtonVisible(cd.keyBar[idx].buts[i], false)
			endif
			
		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Check if the passed but id is special.
//
function cdGetSpecialKey(id as integer)

	local ret as string 
	
	if id = KEY_BACK
		ret = "<<"
	elseif id = KEY_ENTER
		ret = "[]"
	elseif id = KEY_SHIFT
		ret = "^-"
	elseif id = KEY_CTRL_UNSHIFT
		ret = "^ "
	elseif id = KEY_CTRL_123
		ret = "12"
	elseif id = KEY_CTRL_ABC
		ret = "AB"
	elseif id = KEY_CTRL_SYM
		ret = "#+"
	elseif id = KEY_CTRL_LEFT
		ret = "<-"
	elseif id = KEY_CTRL_RIGHT
		ret = "->"
	else
		ret = ""
	endif
	
endfunction ret

//-----------------------------------------------------
// Hide a single key on the given keyboard.
//
function cdHideKeyboardKey(idx as integer, key as string)

	local i as integer
	local txt as string 
	
	for i = 0 to cd.keybar[idx].buts.length

		if cd.keybar[idx].buts[i].text
			txt = GetTextString(cd.keybar[idx].buts[i].text)
		else
			txt = ""
		endif

		if txt = key
			
			cd.keyset[cd.keySetIdx].hiddenSet = cd.keyset[cd.keySetIdx].hiddenSet + key
			guiSetButtonVisible(cd.keyBar[idx].buts[i], false)
			exit

		endif
		
	next

endfunction

//-----------------------------------------------------
//
function cdSetKeyboardPos(y as float)

	local i as integer
	local j as integer
	local dy as float
	local xx as float
	local yy as float
	
	dy = y - getspritey(cd.keybar[0].buts[0].bg)
	//dy = 0
		
	for i = 0 to cd.keybar.length
		
		for j = 0 to cd.keyBar[i].buts.length

			xx = GetSpriteXByOffset(cd.keybar[i].buts[j].bg)
			yy = GetSpriteYByOffset(cd.keybar[i].buts[j].bg)
			guiSetButtonPos(cd.keyBar[i].buts[j], xx, yy + dy)
			
		next
		
	next
	
endfunction

//-----------------------------------------------------
// Add a key press. First check it ins't already active.
//
function cdAddKeyPress(kbdIdx as integer, butIdx as integer)

	local kp as KeyPress
	local i as integer
	local idx as integer
	
	idx = -1
	
	for i = 0 to cd.keyPresses.length
		
		if cd.keyPresses[i].kbdIdx = kbdIdx and cd.keyPresses[i].butIdx = butIdx
			
			idx = i
			exit
			
		endif
		
	next 
	
	if idx > -1
		
		cd.keyPresses[idx].offTimer = CD_KEY_PRESS_TIMER // Reset the timer to hold it longer.
		
	else 
	
		// Not in the list, select it and add it to the timer list.
		guiSetButtonSelected(cd.keyBar[kbdIdx].buts[butIdx], true)
		kp.kbdIdx = kbdIdx
		kp.butIdx = butIdx
		kp.offTimer = CD_KEY_PRESS_TIMER
		cd.keyPresses.insert(kp)
		
	endif

endfunction

//-----------------------------------------------------
// Hide any keys that a still visible.
//
function cdHideKeyPresses()
	
	local i as integer
	
	for i = 0 to cd.keyPresses.length
		guiSetButtonSelected(cd.keybar[cd.keyPresses[i].kbdIdx].buts[cd.keyPresses[i].butIdx], false)
	next
	
	cd.keyPresses.length = -1
	
endfunction

//-----------------------------------------------------
// Check if key press timers are expiring.
//
function cdCheckKeyPresses(delta as float)

	local i as integer
	local del as integer
	
	i = 0
	del = false
	
	while i <= cd.keyPresses.length

		if cd.keyPresses[i].offTimer > 0.0
			
			dec cd.keyPresses[i].offTimer, delta
			
			if cd.keyPresses[i].offTimer <= 0.0
				
				//cdOnObjTimer(cd.keyPressObj)
				guiSetButtonSelected(cd.keybar[cd.keyPresses[i].kbdIdx].buts[cd.keyPresses[i].butIdx], false)
				del = true
				
			endif
			
		endif
		
		if del 
			cd.keyPresses.remove(i)
		else 
			inc i
		endif
		
		del = false
	
	endwhile
	
endfunction

//-----------------------------------------------------
// Check that a double or triple tap has occurs on text.
//
function cdCheckDoubleTapSelection()
	
	local s as string
	local ls as integer
	local c as string
	local dt as integer
	local pos as integer
	
	dt = GetMilliseconds() - cd.editClickTime
	
	// If multiple clicks, and we now have exceed the double/triple click time, process it.
	if cd.editClickTime > 0 and dt > CO_EDIT_CLICK_DOUBLE_TAP_TIME			
						
		if cd.editClickCount >= 3
						
			s = cdGetEditText()
			cd.editClickPos1 = 0
			cd.editClickPos2 = len(s) + 1
			cdSetEditCursorSelection(true)
			
		elseif cd.editClickCount = 2
						
			// Find word boundary.
			s = cdGetEditText()

			if cd.editClickTimePos <= -1				
				cd.editClickTimePos = 0
			endif
			
			pos = cd.editClickTimePos
			
			if pos > 0
				
				c = mid(s, pos, 1)
			
				if c <> " "
					
					while pos > 0
											
						dec pos
						
						if pos > 0
							
							c = mid(s, pos, 1)
							
							if c = " "
								exit
							endif
							
						endif
	
					endwhile
					
				endif
						
			endif
			
			cd.editClickPos1 = pos

			ls = len(s)
			pos = cd.editClickTimePos
			
			if pos < ls
								
				c = mid(s, pos, 1)
				
				if c <> " "
			
					while pos < ls
											
						inc pos
						
						if pos < ls
							
							c = mid(s, pos, 1)
							
							if c = " "
								
								dec pos
								exit
								
							endif
							
						endif
	
					endwhile
					
				endif
				
			endif
			
			cd.editClickPos2 = pos
			
			cdSetEditCursorSelection(true)

		endif
		
		cd.editClickTime = 0
		cd.editClickCount = 0
		cd.editClickTimePos = 0

	endif
	
endfunction

//-----------------------------------------------------
//
function cdShow()

	local i as integer
	local idx as integer
	//local appIdx as integer
	//local apps as integer[]

	SetSyncRate(30, 0)
	
	coSetClearColor(cd.clearCol)
	coSetBorderColor(co.grey[4])
	coSetPrintColor(co.red[7])
	SetPrintSize(48)
	
	SetVirtualResolution(co.w, co.h)
	
	guiHideBar(cd.grpBar)

	guiSetBarVisible(cd.toolBar, true)

	guiSetButtonVisible(cd.appbut, true)
	guiSetButtonActive(cd.thingBut, false)
	guiSetButtonVisible(cd.thingbut, true)
	guiSetButtonVisible(cd.cmdbut, true)
	//guiSetButtonVisible(cd.settingsbut, true)
	guiSetButtonVisible(cd.helpbut, true)
	guiSetButtonActive(cd.codeBut, false)
	guiSetButtonVisible(cd.codebut, true)

	//for i = 0 to cd.sprs.length
	//	if cd.sprs[i]
	//		SetSpriteVisible(cd.sprs[i], true)
	//	endif
	//next

	guiSetPanelVisible(cd.mainPanel, true)
	guiSetPanelVisible(cd.codePanel, true)

	cdHideCmdHover()
	cdHideThingHover()
	cdHidePrevEditValues(true)

	//cdSetTabVisible("p", true)
	//cdLoadApps()
		
	if cd.appId <> ""		
		
		cdSetApp(cd.appId)		
		
	elseif ld.set.autoLoadPrevApp and ld.set.prevLoadedAppId <> ""	
			
		cdLoadApp(ld.set.prevLoadedAppId)
		
	else
		
		cdSetApp("")
		cd.fileTab = CD_FILE_TAB_HELP
		
	endif

	cd.pressed = false
	cd.pressInterHelp = false
	
	cdSetTabVisible("x", true)
	
	if cd.fileTab = CD_FILE_TAB_HELP
		
		cdClearDetailedHelp(true)
		cdShowDetailedHelp(CD_HELP_MAIN, 13)
		
	endif
		
endfunction

//-----------------------------------------------------
// Load all apps.
//
function cdLoadApps()
	
	local i as integer
	local appIdx as integer
	local apps as integer[]

	apps = maFindAppsByStatus(LD_STATUS_MASTER_LIB)

	if apps.length > -1
		appIdx = apps[0]
	else
		appIdx = -1
	endif

	// No library, usually on start up. Create it.
	if appIdx = -1
				
		appIdx = cdCreateApp(CD_FOLDER_LIBRARY, cd.appImg)
		ma.apps[appIdx].status = LD_STATUS_MASTER_LIB || LD_STATUS_LIBRARY
		ldSaveApp(ma.apps[appIdx].id)
		
	endif

	apps = maFindAppsByStatus(LD_STATUS_LIBRARY)

	for i = 0 to apps.length

		appIdx = apps[i]
		
		if not ma.apps[appIdx].loaded
			cdLoadApp(ma.apps[appIdx].id)
			//colog("loaded app name=" + ma.apps[appIdx].name + ", id=" + ma.apps[appIdx].id + ", sprites=" + str(ma.apps[appIdx].sprites.length))
		endif

	next
	
endfunction

//-----------------------------------------------------
//
function cdHide()

	local i as integer
	local grpTab as integer
	local thingTab as integer
	
	guiHideBar(cd.grpBar)
	guiHideBar(cd.thingBar)
	guiHideBar(cd.cmdBar)
	guiHideBar(cd.partBar)
	guiHideBar(cd.toolBar)
	guiHideBar(cd.varBar)
	guiHideBar(cd.varValueBar)
	guiHideBar(cd.codeBar)
	guiHideBar(cd.helpBar)
	guiHideBar(cd.appBar)
	guiHideBar(cd.spriteBar)
	guiHideBar(cd.imageItemBar)
	guiHideBar(cd.imageBlankItemBar)
	guiHideBar(cd.soundItemBar)
	guiHideBar(cd.videoItemBar)
	guiHideBar(cd.varItemBar)
	guiHideBar(cd.varValueItemBar)
	guiHideBar(cd.projItemBar)
	guiHideBar(cd.projBlankItemBar)
	guiHideBar(cd.folderItemBar)
	guiHideBar(cd.frameBar)
	guiHideBar(cd.soundBar)
	guiHideBar(cd.videoBar)
	//guiHideBar(cd.edimg.toolbar)
	//guiHideBar(cd.settingsbar)

	guiSetButtonVisible(cd.appbut, false)
	guiSetButtonVisible(cd.thingbut, false)
	guiSetButtonVisible(cd.cmdbut, false)
	//guiSetButtonVisible(cd.settingsbut, false)
	guiSetButtonVisible(cd.helpbut, false)
	guiSetButtonVisible(cd.codebut, false)
	guiSetButtonVisible(cd.librarybut, false)
	guiHideTip(gui.tip)

	cdHideCmdHover()
	cdHideThingHover()
	
	//for i = 0 to cd.sprs.length
	//	if cd.sprs[i]
	//		SetSpriteVisible(cd.sprs[i], false)
	//	endif
	//next

	guiSetPanelVisible(cd.mainPanel, false)
	guiSetPanelVisible(cd.appPanel, false)
	guiSetPanelVisible(cd.codePanel, false)
	//guiSetPanelVisible(cd.settingsPanel, false)
	guiSetPanelVisible(cd.loadPanel, false)
	guiSetPanelVisible(cd.keyPanel, false)
	guiSetPanelVisible(cd.helpPanel, false)
	//SetSpriteVisible(cd.closeBut, false)

	cdSetSettingsVisible("ssss", false)
	
	thingTab = cd.thingTab
	cd.thingTab = -1
	cdSetThingsVisible("a", false)
	cd.thingTab = thingTab
	
	grpTab = cd.grpTab
	cd.grpTab = -1
	cdSetGrpVisible(false)
	cd.grpTab = grpTab

	cdSetTabVisible("i", false)
	
	if cd.thingIdx > -1

		for i = 0 to ma.things[cd.thingIdx].cmds.length
			cdSetCmdVisible(ma.things[cd.thingIdx].cmds[i], false)
		next
		
	endif

	coProgressEnd()
	
endfunction

//-----------------------------------------------------
// Create object vars, such as "edges", e.g. top-left, etc.
// edges > top, bottom, left, right
//
function cdInitObjVars()

	local var as integer
	local i as integer
	local j as integer
	local fontNames as string[]
	local name as string

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_SPRITE
	ma.vars[var].value = "1" // Single select.
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_FRAME
	ma.vars[var].value = "1" // Single select.
	cd.objVars.insert(var)
	
	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_EDGES
	ma.vars[var].value = "0" // Multiple select.
	maSetObjValue(var, "top", str(DIR_N))
	maSetObjValueIndex(var, "top", 1)
	maSetObjValue(var, "bottom", str(DIR_S))
	maSetObjValueIndex(var, "bottom", 2)
	maSetObjValue(var, "left", str(DIR_W))
	maSetObjValueIndex(var, "left", 3)
	maSetObjValue(var, "right", str(DIR_E))
	maSetObjValueIndex(var, "right", 4)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_EDGE
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "top", str(DIR_N))
	maSetObjValueIndex(var, "top", 1)
	maSetObjValue(var, "bottom", str(DIR_S))
	maSetObjValueIndex(var, "bottom", 2)
	maSetObjValue(var, "left", str(DIR_W))
	maSetObjValueIndex(var, "left", 3)
	maSetObjValue(var, "right", str(DIR_E))
	maSetObjValueIndex(var, "right", 4)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_WRAP
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "no wrap", str(CO_WRAP_NONE))
	maSetObjValueIndex(var, "no wrap", 1)
	maSetObjValue(var, "hits edge", str(CO_WRAP_HITS_EDGE))
	maSetObjValueIndex(var, "hits edge", 2)
	maSetObjValue(var, "off screen", str(CO_WRAP_OFF_SCREEN))
	maSetObjValueIndex(var, "off screen", 3)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_TITLE_ALIGN
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "left", str(0))
	maSetObjValueIndex(var, "left", 1)
	maSetObjValue(var, "middle", str(1))
	maSetObjValueIndex(var, "middle", 2)
	maSetObjValue(var, "right", str(2))
	maSetObjValueIndex(var, "right", 3)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_TEXT_ALIGN
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "top-left", str(0))
	maSetObjValueIndex(var, "top-left", 1)
	maSetObjValue(var, "top-middle", str(1))
	maSetObjValueIndex(var, "top-middle", 2)
	maSetObjValue(var, "top-right", str(2))
	maSetObjValueIndex(var, "top-right", 3)
	maSetObjValue(var, "middle-left", str(3))
	maSetObjValueIndex(var, "middle-left", 4)
	maSetObjValue(var, "middle-middle", str(4))
	maSetObjValueIndex(var, "middle-middle", 5)
	maSetObjValue(var, "middle-right", str(5))
	maSetObjValueIndex(var, "middle-right", 6)
	maSetObjValue(var, "bottom-left", str(6))
	maSetObjValueIndex(var, "bottom-left", 7)
	maSetObjValue(var, "bottom-middle", str(7))
	maSetObjValueIndex(var, "bottom-middle", 8)
	maSetObjValue(var, "bottom-right", str(8))
	maSetObjValueIndex(var, "bottom-right", 9)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_FONT_SIZE
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "tiny", str(0))
	maSetObjValueIndex(var, "tiny", 1)
	maSetObjValue(var, "small", str(1))
	maSetObjValueIndex(var, "small", 2)
	maSetObjValue(var, "medium", str(2))
	maSetObjValueIndex(var, "medium", 3)
	maSetObjValue(var, "large", str(3))
	maSetObjValueIndex(var, "large", 4)
	maSetObjValue(var, "huge", str(4))
	maSetObjValueIndex(var, "huge", 5)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_STOP
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "this block", str(0))
	maSetObjValueIndex(var, "this block", 1)
	maSetObjValue(var, "other blocks", str(1))
	maSetObjValueIndex(var, "other blocks", 2)
	maSetObjValue(var, "all blocks", str(2))
	maSetObjValueIndex(var, "all blocks", 3)
	maSetObjValue(var, "project", str(3))
	maSetObjValueIndex(var, "project", 4)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_STYLE
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "round", str(CO_LINE_MID_CIRC))
	maSetObjValueIndex(var, "round", 1)
	maSetObjValue(var, "square mid", str(CO_LINE_MID_SQR))
	maSetObjValueIndex(var, "square mid", 2)
	maSetObjValue(var, "square end", str(CO_LINE_END_SQR))
	maSetObjValueIndex(var, "square end", 3)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_INFO
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "frame", str(CO_INFO_FRAME))
	maSetObjValueIndex(var, "frame", 1)
	maSetObjValue(var, "x pos", str(CO_INFO_X_POS))
	maSetObjValueIndex(var, "x pos", 2)
	maSetObjValue(var, "y pos", str(CO_INFO_Y_POS))
	maSetObjValueIndex(var, "y pos", 3)
	maSetObjValue(var, "width", str(CO_INFO_WIDTH))
	maSetObjValueIndex(var, "width", 4)
	maSetObjValue(var, "height", str(CO_INFO_HEIGHT))
	maSetObjValueIndex(var, "height", 5)
	maSetObjValue(var, "x size", str(CO_INFO_X_SIZE))
	maSetObjValueIndex(var, "x size", 6)
	maSetObjValue(var, "y size", str(CO_INFO_Y_SIZE))
	maSetObjValueIndex(var, "y size", 7)
	maSetObjValue(var, "angle", str(CO_INFO_ANGLE))
	maSetObjValueIndex(var, "angle", 8)
	maSetObjValue(var, "color", str(CO_INFO_COLOR))
	maSetObjValueIndex(var, "color", 9)
	maSetObjValue(var, "transparency", str(CO_INFO_TRANS))
	maSetObjValueIndex(var, "transparency", 10)
	maSetObjValue(var, "depth", str(CO_INFO_DEPTH))
	maSetObjValueIndex(var, "depth", 11)	
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_BOUNCE
	ma.vars[var].value = "1" // Single select.
	maSetObjValue(var, "right angle", str(0))
	maSetObjValueIndex(var, "right angle", 1)
	maSetObjValue(var, "same angle", str(1))
	maSetObjValueIndex(var, "same angle", 2)
	maSetObjValue(var, "random angle", str(2))
	maSetObjValueIndex(var, "random angle", 3)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_OPER
	ma.vars[var].value = "1"
	maSetObjValue(var, "+", str(0))
	maSetObjValueIndex(var, "+", 1)
	maSetObjValue(var, "-", str(1))
	maSetObjValueIndex(var, "-", 2)
	maSetObjValue(var, "*", str(2))
	maSetObjValueIndex(var, "*", 3)
	maSetObjValue(var, "/", str(3))
	maSetObjValueIndex(var, "/", 4)
	maSetObjValue(var, "%", str(4))
	maSetObjValueIndex(var, "%", 5)
	maSetObjValue(var, "^", str(5))
	maSetObjValueIndex(var, "^", 6)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_CMP
	ma.vars[var].value = "1"
	maSetObjValue(var, "=", str(0))
	maSetObjValueIndex(var, "=", 1)
	maSetObjValue(var, "<>", str(1))
	maSetObjValueIndex(var, "<>", 2)
	maSetObjValue(var, "<", str(2))
	maSetObjValueIndex(var, ">", 3)
	maSetObjValue(var, "<=", str(3))
	maSetObjValueIndex(var, "<=", 4)
	maSetObjValue(var, ">", str(4))
	maSetObjValueIndex(var, ">", 5)
	maSetObjValue(var, ">=", str(5))
	maSetObjValueIndex(var, ">=", 6)
	maSetObjValue(var, ">", str(6))
	maSetObjValueIndex(var, ">", 7)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_BOOL
	ma.vars[var].value = "1"
	maSetObjValue(var, "AND", str(0))
	maSetObjValueIndex(var, "AND", 1)
	maSetObjValue(var, "OR", str(1))
	maSetObjValueIndex(var, "OR", 2)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_BITS
	ma.vars[var].value = "1"
	maSetObjValue(var, "<<", str(0))
	maSetObjValueIndex(var, "<<", 1)
	maSetObjValue(var, ">>", str(1))
	maSetObjValueIndex(var, ">>", 2)
	maSetObjValue(var, "&&", str(2))
	maSetObjValueIndex(var, "&&", 3)
	maSetObjValue(var, "||", str(3))
	maSetObjValueIndex(var, "||", 4)
	maSetObjValue(var, "~~", str(4))
	maSetObjValueIndex(var, "~~", 5)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_EVENT
	ma.vars[var].value = "1"
	maSetObjValue(var, "POINTER PRESSED", str(0))
	maSetObjValueIndex(var, "POINTER PRESSED", 1)
	maSetObjValue(var, "POINTER HELD", str(1))
	maSetObjValueIndex(var, "POINTER HELD", 2)
	maSetObjValue(var, "POINTER RELEASED", str(2))
	maSetObjValueIndex(var, "POINTER RELEASED", 3)
	maSetObjValue(var, "KEY PRESSED", str(3))
	maSetObjValueIndex(var, "KEY PRESSED", 4)
	maSetObjValue(var, "KEY HELD", str(4))
	maSetObjValueIndex(var, "KEY HELD", 5)
	maSetObjValue(var, "KEY RELEASED", str(5))
	maSetObjValueIndex(var, "KEY RELEASED", 6)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_KEY
	ma.vars[var].value = "0" // Hack. value is used as the index for the maSetObjValueAndIndex fn.
	
	maSetObjValueAndIndex(var, "BACK", str(8))
	maSetObjValueAndIndex(var, "TAB", str(9))
	maSetObjValueAndIndex(var, "ENTER", str(13))
	maSetObjValueAndIndex(var, "SHIFT", str(16))
	maSetObjValueAndIndex(var, "CONTROL", str(17))
	maSetObjValueAndIndex(var, "ALT", str(18))
	maSetObjValueAndIndex(var, "ESCAPE", str(27))
	maSetObjValueAndIndex(var, "SPACE", str(32))
	maSetObjValueAndIndex(var, "PAGEUP", str(33))
	maSetObjValueAndIndex(var, "PAGEDOWN", str(34))
	maSetObjValueAndIndex(var, "END", str(35))
	maSetObjValueAndIndex(var, "HOME", str(36))
	maSetObjValueAndIndex(var, "LEFT", str(37))
	maSetObjValueAndIndex(var, "UP", str(38))
	maSetObjValueAndIndex(var, "RIGHT", str(39))
	maSetObjValueAndIndex(var, "DOWN", str(40))
	maSetObjValueAndIndex(var, "INSERT", str(45))
	maSetObjValueAndIndex(var, "DELETE", str(46))
	maSetObjValueAndIndex(var, "0", str(48))
	maSetObjValueAndIndex(var, "1", str(49))
	maSetObjValueAndIndex(var, "2", str(50))
	maSetObjValueAndIndex(var, "3", str(51))
	maSetObjValueAndIndex(var, "4", str(52))
	maSetObjValueAndIndex(var, "5", str(53))
	maSetObjValueAndIndex(var, "6", str(54))
	maSetObjValueAndIndex(var, "7", str(55))
	maSetObjValueAndIndex(var, "8", str(56))
	maSetObjValueAndIndex(var, "9", str(57))
	maSetObjValueAndIndex(var, "A", str(65))
	maSetObjValueAndIndex(var, "B", str(66))
	maSetObjValueAndIndex(var, "C", str(67))
	maSetObjValueAndIndex(var, "D", str(68))
	maSetObjValueAndIndex(var, "E", str(69))
	maSetObjValueAndIndex(var, "F", str(70))
	maSetObjValueAndIndex(var, "G", str(71))
	maSetObjValueAndIndex(var, "H", str(72))
	maSetObjValueAndIndex(var, "I", str(73))
	maSetObjValueAndIndex(var, "J", str(74))
	maSetObjValueAndIndex(var, "K", str(75))
	maSetObjValueAndIndex(var, "L", str(76))
	maSetObjValueAndIndex(var, "M", str(77))
	maSetObjValueAndIndex(var, "N", str(78))
	maSetObjValueAndIndex(var, "O", str(79))
	maSetObjValueAndIndex(var, "P", str(80))
	maSetObjValueAndIndex(var, "Q", str(81))
	maSetObjValueAndIndex(var, "R", str(82))
	maSetObjValueAndIndex(var, "S", str(83))
	maSetObjValueAndIndex(var, "T", str(84))
	maSetObjValueAndIndex(var, "U", str(85))
	maSetObjValueAndIndex(var, "V", str(86))
	maSetObjValueAndIndex(var, "W", str(87))
	maSetObjValueAndIndex(var, "X", str(88))
	maSetObjValueAndIndex(var, "Y", str(89))
	maSetObjValueAndIndex(var, "Z", str(90))
	maSetObjValueAndIndex(var, "*", str(106))
	maSetObjValueAndIndex(var, "+", str(107))
	maSetObjValueAndIndex(var, "-", str(109))
	//maSetObjValueAndIndex(var, ".", str(110))
	//maSetObjValueAndIndex(var, "/", str(111))
	maSetObjValueAndIndex(var, "F1", str(112))
	maSetObjValueAndIndex(var, "F2", str(113))
	maSetObjValueAndIndex(var, "F3", str(114))
	maSetObjValueAndIndex(var, "F4", str(115))
	maSetObjValueAndIndex(var, "F5", str(116))
	maSetObjValueAndIndex(var, "F6", str(117))
	maSetObjValueAndIndex(var, "F7", str(118))
	maSetObjValueAndIndex(var, "F8", str(119))
	maSetObjValueAndIndex(var, "F9", str(120))
	maSetObjValueAndIndex(var, "F10", str(121))
	maSetObjValueAndIndex(var, "F11", str(122))
	maSetObjValueAndIndex(var, "F12", str(123))
	maSetObjValueAndIndex(var, ";", str(186))
	maSetObjValueAndIndex(var, "=", str(187))
	maSetObjValueAndIndex(var, ",", str(188))
	maSetObjValueAndIndex(var, "-", str(189))
	maSetObjValueAndIndex(var, ".", str(190))
	maSetObjValueAndIndex(var, "/", str(191))
	maSetObjValueAndIndex(var, "'", str(192))
	maSetObjValueAndIndex(var, "[", str(219))
	maSetObjValueAndIndex(var, "\", str(220))
	maSetObjValueAndIndex(var, "]", str(221))
	maSetObjValueAndIndex(var, "#", str(222))
	maSetObjValueAndIndex(var, "`", str(223))
	maSetObjValueAndIndex(var, "LEFT_SHIFT", str(257))
	maSetObjValueAndIndex(var, "RIGHT_SHIFT", str(258))
	maSetObjValueAndIndex(var, "LEFT_CTRL", str(259))
	maSetObjValueAndIndex(var, "RIGHT_CTRL", str(260))
	maSetObjValueAndIndex(var, "LEFT_ALT", str(261))
	maSetObjValueAndIndex(var, "RIGHT_ALT", str(262))
	maSetObjValueAndIndex(var, "TOP_0", str(263))
	maSetObjValueAndIndex(var, "TOP_1", str(264))
	maSetObjValueAndIndex(var, "TOP_2", str(265))
	maSetObjValueAndIndex(var, "TOP_3", str(266))
	maSetObjValueAndIndex(var, "TOP_4", str(267))
	maSetObjValueAndIndex(var, "TOP_5", str(268))
	maSetObjValueAndIndex(var, "TOP_6", str(269))
	maSetObjValueAndIndex(var, "TOP_7", str(270))
	maSetObjValueAndIndex(var, "TOP_8", str(271))
	maSetObjValueAndIndex(var, "TOP_9", str(272))

	ma.vars[var].value = "1" // Reset back to 1.
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_JOIN
	ma.vars[var].value = "1"
	maSetObjValue(var, "VALUE", str(0))
	maSetObjValueIndex(var, "VALUE", 1)
	maSetObjValue(var, "NAME", str(1))
	maSetObjValueIndex(var, "NAME", 2)
	maSetObjValue(var, "NAME:VALUE", str(2))
	maSetObjValueIndex(var, "NAME:VALUE", 3)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_SCREEN
	ma.vars[var].value = "1"
	maSetObjValue(var, "Landscape 2560 x 1536", str(0))
	maSetObjValueIndex(var, "Landscape 2560 x 1536", 1)
	maSetObjValue(var, "Landscape 2560 x 1440", str(1))
	maSetObjValueIndex(var, "Landscape 2560 x 1440", 2)
	maSetObjValue(var, "Landscape 1920 x 1080", str(2))
	maSetObjValueIndex(var, "Landscape 1920 x 1080", 3)
	maSetObjValue(var, "Landscape 1024 x 768", str(3))
	maSetObjValueIndex(var, "Landscape 1024 x 768", 4)
	maSetObjValue(var, "Portrait 1536 x 2560", str(4))
	maSetObjValueIndex(var, "Portrait 1536 x 2560", 5)
	maSetObjValue(var, "Portrait 1080 x 1920", str(5))
	maSetObjValueIndex(var, "Portrait 1080 x 1920", 6)
	maSetObjValue(var, "Portrait 768 x 1024", str(6))
	maSetObjValueIndex(var, "Portrait 768 x 1024", 7)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_SHAPE
	ma.vars[var].value = "1"
	maSetObjValue(var, "CIRCLE", str(1))
	maSetObjValueIndex(var, "CIRCLE", 1)
	maSetObjValue(var, "BOX", str(2))
	maSetObjValueIndex(var, "BOX", 2)
	maSetObjValue(var, "POLYGON", str(3))
	maSetObjValueIndex(var, "POLYGON", 3)
	cd.objVars.insert(var)

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_TO
	ma.vars[var].value = "1"
	maSetObjValue(var, "ANY", str(0))
	maSetObjValueIndex(var, "ANY", 1)
	maSetObjValue(var, "ANY + WAIT", str(1))
	maSetObjValueIndex(var, "ANY + WAIT", 2)
	maSetObjValue(var, "ANY + AS ME", str(2))
	maSetObjValueIndex(var, "ANY + AS ME", 3)
	maSetObjValue(var, "ANY + AS ME + WAIT", str(3))
	maSetObjValueIndex(var, "ANY + AS ME + WAIT", 4)
	maSetObjValue(var, "ME", str(4))
	maSetObjValueIndex(var, "ME", 5)
	maSetObjValue(var, "ME + WAIT", str(5))
	maSetObjValueIndex(var, "ME + WAIT", 6)
	cd.objVars.insert(var)

	//
	// Create the var list.
	//

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_VALUE
	ma.vars[var].value = "1" // Single select.
	cd.objVars.insert(var)

	//
	// Create the var list list.
	//

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_LIST
	ma.vars[var].value = "1" // Single select.
	cd.objVars.insert(var)
	
	//
	// Create the var or list.
	//

	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_VAR
	ma.vars[var].value = "1" // Single select.
	cd.objVars.insert(var)

	//
	// Create the font list.
	//
	
	var = maCreateVar(VAR_TYPE_OBJECT)
	ma.vars[var].name = OBJ_VAR_FONT
	ma.vars[var].value = "1" // Single select.

	for i = 0 to co.fonts.length
		
		name = coGetFontName(co.fonts[i])
		maSetObjValue(var, name, str(i))
		fontNames.insertsorted(name)
		
	next 

	for i = 0 to fontNames.length
		maSetObjValueIndex(var, fontNames[i], i + 1)
	next 
	
	cd.objVars.insert(var)
	
endfunction

//-----------------------------------------------------
// Create the var obj list.
//
function cdCreateObjVarValue()
	
	local var as integer
	local i as integer
	local name as string
	local varNames as string[]
	
	var = cdGetObjVarIndex(OBJ_VAR_VALUE)	
	cdClearVarItems(var)	

	for i = 0 to ma.vars.length
		
		if ma.vars[i].typ = VAR_TYPE_VALUE
			
			maSetObjValue(var, name, str(i))
			varNames.insertsorted(name)
			
		endif
		
	next 

	for i = 0 to varNames.length
		maSetObjValueIndex(var, varNames[i], i + 1)
	next 
	
endfunction

//-----------------------------------------------------
// Create the var obj list.
//
function cdCreateObjVarVar()
	
	local var as integer
	local i as integer
	local name as string
	local varNames as string[]
	
	var = cdGetObjVarIndex(OBJ_VAR_VAR)	
	cdClearVarItems(var)	

	for i = 0 to ma.vars.length
		
		if ma.vars[i].typ = VAR_TYPE_VALUE
			
			maSetObjValue(var, name, str(i))
			varNames.insertsorted(name)
			
		endif
		
	next 

	for i = 0 to varNames.length
		maSetObjValueIndex(var, varNames[i], i + 1)
	next
	
	for i = 0 to ma.vars.length
		
		if ma.vars[i].typ = VAR_TYPE_LIST
			
			maSetObjValue(var, name, str(i))
			varNames.insertsorted(name)
			
		endif
		
	next 

	for i = 0 to varNames.length
		maSetObjValueIndex(var, varNames[i], i + 1)
	next 
	
endfunction

//-----------------------------------------------------
// Create the var obj list list.
//
function cdCreateObjVarList()
	
	local var as integer
	local i as integer
	local name as string
	local varNames as string[]
	
	var = cdGetObjVarIndex(OBJ_VAR_LIST)	
	cdClearVarItems(var)	

	for i = 0 to ma.vars.length
		
		if ma.vars[i].typ = VAR_TYPE_LIST
			
			maSetObjValue(var, name, str(i))
			varNames.insertsorted(name)
			
		endif
		
	next 

	for i = 0 to varNames.length
		maSetObjValueIndex(var, varNames[i], i + 1)
	next 
	
endfunction

//-----------------------------------------------------
//
function cdCreateAllCmds(x as float, y as float)

	local yy as float
	local cmd as integer
	local s as string
	local cmd2 as integer
	local s2 as string
	local endCmd as integer
	local i as integer

	cd.qx = x
	
	// Begin commands.
	cd.qy = y
	cmd = cdCreateCmdQuick(CODE_EVENT_RUN, "S:when,M:gfx/SmallPlayIcon.png,S:pressed")
	ma.cmds[cmd].help = "Run attached code, for this sprite, when the project is run."
	//cmd = cdCreateCmdQuick(CODE_EVENT_UPDATE, "S:when updated")
	//ma.cmds[cmd].help = "Run attached code, on every update of the game, i.e. 60 times per second."
	cmd = cdCreateCmdQuick(CODE_EVENT_PTR_PRESSED, "S:when pointer pressed")
	ma.cmds[cmd].help = "Run attached code, when the pointer is pressed. Runs once per press."
	////cmd = cdCreateCmdQuick(CODE_EVENT_PTR_DOWN, "S:when pointer held")
	////ma.cmds[cmd].help = "Run attached code, when the pointer is held down. Runs once per move of the pointer. Be careful to not put too much code here."
	cmd = cdCreateCmdQuick(CODE_EVENT_PTR_RELEASED, "S:when pointer released")
	ma.cmds[cmd].help = "Run attached code, when the pointer is released. Runs once per release."
	cmd = cdCreateCmdQuick(CODE_EVENT_SPRITE_PRESSED, "S:when sprite pressed")
	ma.cmds[cmd].help = "Run attached code, when the sprite is pressed. Runs once per press."
	////cmd = cdCreateCmdQuick(CODE_EVENT_SPRITE_DOWN, "S:when sprite held")
	////ma.cmds[cmd].help = "Run attached code, when the sprite is held down. Runs once per move of the pointer. Be careful to not put too much code here."
	cmd = cdCreateCmdQuick(CODE_EVENT_SPRITE_RELEASED, "S:when sprite released")
	ma.cmds[cmd].help = "Run attached code, when the sprite is released after being pressed. Runs once per release."
	cmd = cdCreateCmdQuick(CODE_EVENT_CLONE, "S:when sprite cloned")
	ma.cmds[cmd].help = "Run attached code, when this sprite, is cloned. Runs once per clone."
	cmd = cdCreateCmdQuick(CODE_EVENT_COLL_ANY_THING, "S:when sprite hit")
	ma.cmds[cmd].help = "Run attached code, if this sprite it hit by any other sprite or clone."
	cmd = cdCreateCmdQuick(CODE_EVENT_COLL_THING, "S:when sprite hit by ,H:")
	ma.cmds[cmd].help = "Run attached code, when this sprite is hit by the specified sprite or clone."
	//cmd = cdCreateCmdQuick(CODE_EVENT_COLL_ANY_CLONE, "S:when clone hit")
	//ma.cmds[cmd].help = "Run attached code, if a clone of this sprite it hit by any other sprite or clone."
	//cmd = cdCreateCmdQuick(CODE_EVENT_COLL_CLONE, "S:when clone hit by ,H:")
	//ma.cmds[cmd].help = "Run attached code, when a clone of this sprite is hit by the specified sprite or clone."
	////cmd = cdCreateCmdQuick(CODE_EVENT_COLL_ANY_EDGE, "S:when edge hit")
	////ma.cmds[cmd].help = "Run attached code, when this sprite hits any edge of the screen."
	cmd = cdCreateCmdQuick(CODE_EVENT_COLL_EDGE, "S:when edge hit ,J:edges")
	ma.cmds[cmd].help = "Run attached code, when this sprite hits the specified edge(s) of the screen."
	cmd = cdCreateCmdQuick(CODE_EVENT_BLOCK, "S:when block called ,T:")
	ma.cmds[cmd].help = "Run attached code, when this block is called with the 'call block' command."
	cmd = cdCreateCmdQuick(CODE_EVENT_RECEIVED, "S:when message received ,T:")
	ma.cmds[cmd].help = "Run attached code, when this block receives a message from 'send message' command."
	cmd = cdCreateCmdQuick(CODE_EVENT_TIMER, "S:when timer at ,N:0")
	ma.cmds[cmd].help = "Run attached code, for this sprite, when the timer reaches the specified time. Only runs once; call 'reset timer' to start again."
	cmd = cdCreateCmdQuick(CODE_EVENT_VAR_PRESSED, "S:when variable pressed ,V:")
	ma.cmds[cmd].help = "Run attached code, when the variable is pressed. Runs once per press."
	cmd = cdCreateCmdQuick(CODE_EVENT_VAR_RELEASED, "S:when variable released ,V:")
	ma.cmds[cmd].help = "Run attached code, when the variable is released after being pressed. Runs once per release."

	// Move commands.
	cd.qy = y
	cmd = cdCreateCmdQuick(CODE_MOVE_SET_X, "S:set x to ,F:0")
	ma.cmds[cmd].help = "Set the sprite x position.  The screen width ranges from 0 on the left, to [max x] on the right."
	cmd = cdCreateCmdQuick(CODE_MOVE_MOVE_X, "S:change x by ,F:0")
	ma.cmds[cmd].help = "Change the sprite x position."
	cmd = cdCreateCmdQuick(CODE_MOVE_SET_Y, "S:set y to ,F:0")
	ma.cmds[cmd].help = "Set the sprite y position.  The screen height ranges from 0 at the top, to [max y] at the bottom."
	cmd = cdCreateCmdQuick(CODE_MOVE_MOVE_Y, "S:change y by ,F:0")
	ma.cmds[cmd].help = "Change the sprite y position."
	cmd = cdCreateCmdQuick(CODE_MOVE_SET_POS, "S:set x to ,F:0,S: and y to ,F:0")
	ma.cmds[cmd].help = "Set the sprite x position and y position at the same time."
	cmd = cdCreateCmdQuick(CODE_MOVE_FORWARD, "S:move forward by ,F:0")
	ma.cmds[cmd].help = "Change the sprite position by moving forward (or backward if negative) at the current angle."
	cmd = cdCreateCmdQuick(CODE_MOVE_SET_RANDOM_POS, "S:set to random pos")
	ma.cmds[cmd].help = "Set the sprite x position and y position to a random position on the screen."
	cmd = cdCreateCmdQuick(CODE_MOVE_SET_ANGLE, "S:set angle to ,F:0")
	ma.cmds[cmd].help = "Set the sprite angle, making the sprite point in that direction. Angles range from 0 to 360, 0 points up, 90 is right, 180 is down, 270 is left."
	cmd = cdCreateCmdQuick(CODE_MOVE_MOVE_ANGLE, "S:change angle by ,F:0")
	ma.cmds[cmd].help = "Change the sprite angle."
	cmd = cdCreateCmdQuick(CODE_MOVE_POINT_AT_POS, "S:point at x ,F:0,S: and y ,F:0")
	ma.cmds[cmd].help = "Set the sprite angle, making the sprite top point at position x and y."
	cmd = cdCreateCmdQuick(CODE_MOVE_POINT_AT_THING, "S:point at sprite ,H:")
	ma.cmds[cmd].help = "Set the sprite angle, making the sprite top point at another sprite."
	//cmd = cdCreateCmdQuick(CODE_MOVE_SET_SPEED, "S:set speed to ,F:0")
	//ma.cmds[cmd].help = "Set the sprite speed. If speed is not 0, the sprite will continue to move at the current angle."
	cmd = cdCreateCmdQuick(CODE_MOVE_CAN_COLL, "S:can hit ,B:")
	ma.cmds[cmd].help = "Set whether a clone can hit (true) other clones or sprites. Must be within the (when sprite cloned) command."
	cmd = cdCreateCmdQuick(CODE_MOVE_EDGE_BOUNCE, "S:on hit edge ,J:edges,S: bounce ,J:bounce,S: angle ,N:0")
	ma.cmds[cmd].help = "If after hitting an edge, bounce this sprite."
	cmd = cdCreateCmdQuick(CODE_MOVE_THING_BOUNCE, "S:on hit sprite ,H:,S: bounce ,J:bounce,S: angle ,N:0")
	ma.cmds[cmd].help = "If after hittong another sprite or clone, bounce this sprite."
	cmd = cdCreateCmdQuick(CODE_MOVE_WRAP_SCREEN_X, "S:set wrap x when ,J:wrap")
	ma.cmds[cmd].help = "Wrap the sprite around the screen in the x axis. Values: 'NEVER' (default), when sprite 'HITS EDGE', when sprite goes 'OFF SCREEN'."
	cmd = cdCreateCmdQuick(CODE_MOVE_WRAP_SCREEN_Y, "S:set wrap y when ,J:wrap")
	ma.cmds[cmd].help = "Wrap the sprite around the screen in the y axis. Values: 'NEVER' (default), when sprite 'HITS EDGE', when sprite goes 'OFF SCREEN'."
	cmd = cdCreateCmdQuick(CODE_MOVE_GET_X, "S:x pos")
	ma.cmds[cmd].help = "Get the sprite x position."
	cmd = cdCreateCmdQuick(CODE_MOVE_GET_Y, "S:y pos")
	ma.cmds[cmd].help = "Get the sprite y position."
	cmd = cdCreateCmdQuick(CODE_MOVE_GET_ANGLE, "S:angle")
	ma.cmds[cmd].help = "Get the sprite angle."
	cmd = cdCreateCmdQuick(CODE_MOVE_DIST_TO_POS, "S:distance to x ,F:0,S: and y ,F:0")
	ma.cmds[cmd].help = "Get the distance between the sprite and the position x and y."
	cmd = cdCreateCmdQuick(CODE_MOVE_DIST_TO_THING, "S:distance to sprite ,H:")
	ma.cmds[cmd].help = "Get the distance between this sprite and another sprite."

	// Look commands.
	cd.qy = y
	cmd = cdCreateCmdQuick(CODE_LOOK_SHOW, "S:show")
	ma.cmds[cmd].help = "Show the sprite."
	cmd = cdCreateCmdQuick(CODE_LOOK_HIDE, "S:hide")
	ma.cmds[cmd].help = "Hide the sprite."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_FRAME, "S:set frame to ,N:1")
	ma.cmds[cmd].help = "Set the sprite to look like the frame with specified number. Every sprite has at least one frame starting with value 1."
	//cmd = cdCreateCmdQuick(CODE_LOOK_SET_FRAME_IMAGE, "S:set frame image to ,R:frame")
	//ma.cmds[cmd].help = "Set the sprite to look like the specified frame. Every sprite has at least one frame starting with value 1."
	//cmd = cdCreateCmdQuick(CODE_LOOK_SET_FRAME_IMAGE, "S:set frame to ,R:")
	//ma.cmds[cmd].help = "Set the sprite to look like the specified frame. Every sprite has at least one frame starting with value 1."
	cmd = cdCreateCmdQuick(CODE_LOOK_PREV_FRAME, "S:previous frame")
	ma.cmds[cmd].help = "Set the sprite to look like the previous frame. If the first frame is showing (frame 1), then it will switch to the last frame."
	cmd = cdCreateCmdQuick(CODE_LOOK_NEXT_FRAME, "S:next frame")
	ma.cmds[cmd].help = "Set the sprite to look like the next frame. If the last frame is showing , then it will switch to the frame 1."
	cmd = cdCreateCmdQuick(CODE_LOOK_CREATE_CLONE, "S:clone this sprite")
	ma.cmds[cmd].help = "Make an exact copy of the sprite and place it at the same place. The (when sprite cloned) event will run at this time."
	cmd = cdCreateCmdQuick(CODE_LOOK_DELETE_CLONE, "S:delete this clone")
	ma.cmds[cmd].help = "Delete the current sprite clone."
	cmd = cdCreateCmdQuick(CODE_LOOK_DELETE_ALL_CLONES, "S:delete all clones")
	ma.cmds[cmd].help = "Delete all sprite clones."
	cmd = cdCreateCmdQuick(CODE_LOOK_STAMP_SPRITE, "S:stamp sprite")
	ma.cmds[cmd].help = "Stamp the sprite at the current location. The sprite will stay there until the project stops or 'clear stamps' is used."
	cmd = cdCreateCmdQuick(CODE_LOOK_ERASE_STAMP_SPRITES, "S:clear stamps")
	ma.cmds[cmd].help = "Clear all stamped sprites."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_SCALE, "S:set size to ,F:1.0")
	ma.cmds[cmd].help = "Set the sprite size. A sprite size of 1.0 = 100%. Less than 1.0 makes it smaller, more than 1.0 makes it larger."
	cmd = cdCreateCmdQuick(CODE_LOOK_CHANGE_SCALE, "S:change size by ,F:0.1")
	ma.cmds[cmd].help = "Change the sprite size."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_SCALE_X, "S:set x size to ,F:1.0")
	ma.cmds[cmd].help = "Set the sprite x size only. A sprite x size of 1.0 = 100%. Less than 1.0 makes it smaller, more than 1.0 makes it larger."
	cmd = cdCreateCmdQuick(CODE_LOOK_CHANGE_SCALE_X, "S:change x size by ,F:0.1")
	ma.cmds[cmd].help = "Change the sprite x size only."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_SCALE_Y, "S:set y size to ,F:1.0")
	ma.cmds[cmd].help = "Set the sprite y size only. A sprite y size of 1.0 = 100%. Less than 1.0 makes it smaller, more than 1.0 makes it larger."
	cmd = cdCreateCmdQuick(CODE_LOOK_CHANGE_SCALE_Y, "S:change y size by ,F:0.1")
	ma.cmds[cmd].help = "Change the sprite y size only."
	//cmd = cdCreateCmdQuick(CODE_LOOK_UPDATES_OFF, "S:turbo on")
	//ma.cmds[cmd].help = "Make execution much faster. However, only this event block will run until 'turbo off'."
	//cmd = cdCreateCmdQuick(CODE_LOOK_UPDATES_ON, "S:turbo off")
	//ma.cmds[cmd].help = "Back to normal speed. Other event blocks will run."
	cmd = cdCreateCmdQuick(CODE_LOOK_PRINT, "S:say ,T:hello")
	ma.cmds[cmd].help = "Display a message near the sprite. Insert \\n to add a newline. Insert \\\\ to insert a single \\ (backslash)."
	cmd = cdCreateCmdQuick(CODE_LOOK_PRINT_FOR_TIME, "S:say ,T:hello,S: for ,F:2.0,S: seconds")
	ma.cmds[cmd].help = "Display a message near the sprite. Insert \\n to add a newline. Insert \\\\ to insert a single \\ (backslash)."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PRINT_FONT, "S:set say font to ,J:font")
	ma.cmds[cmd].help = "Set the font of the say box text."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PRINT_FONT_SIZE, "S:set say font size to ,N:" + str(LD_TEXT_SIZE_MIN))
	ma.cmds[cmd].help = "Set the font size of the say box text. Valid values are from " + str(LD_TEXT_SIZE_MIN) + " to " + str(LD_TEXT_SIZE_MAX) + "."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PRINT_BG_COLOR, "S:set say background color to ,C:#FAFAFA")
	ma.cmds[cmd].help = "Set the background color of the say box."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PRINT_BORDER_COLOR, "S:set say border color to ,C:#E0E0E0")
	ma.cmds[cmd].help = "Set the border color of the say box border and arrow."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PRINT_TEXT_COLOR, "S:set say text color to ,C:#000000")
	ma.cmds[cmd].help = "Set the color of the say box text."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_COLOR, "S:set color to ,C:#000000")
	ma.cmds[cmd].help = "Set the sprite color."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_COLOR_PARTS, "S:set red ,N:255,S: green ,N:255,S: blue ,N:255")
	ma.cmds[cmd].help = "Set the sprite color using red, green and blue. Valid values are between 0 and 255."
	cmd = cdCreateCmdQuick(CODE_LOOK_CHANGE_COLOR_PARTS, "S:change red ,N:0,S: green ,N:0,S: blue ,N:0")
	ma.cmds[cmd].help = "Change the sprite color red, green and blue by an amount. No matter the value, colors will stay within range of 0 to 255."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_TRANSPARENCY, "S:set transparency to ,N:255")
	ma.cmds[cmd].help = "Set how transparent the sprite is. Value ranges from 0 invisible, to 255 completely visible."
	cmd = cdCreateCmdQuick(CODE_LOOK_CHANGE_TRANSPARENCY, "S:change transparency by ,N:1")
	ma.cmds[cmd].help = "Change how transparent the sprite is. Value ranges from 0 invisible, to 255 completely visible."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PIXEL_SCALING, "S:set pixel scaling ,B:")
	ma.cmds[cmd].help = "Set pixel scaling to true or false. If true, scaling is blocky like big pixels. The default is smooth scaling."
	cmd = cdCreateCmdQuick(CODE_LOOK_PEN_DOWN, "S:pen down")
	ma.cmds[cmd].help = "Put the pen down. Any movement of this sprite will draw a line."
	cmd = cdCreateCmdQuick(CODE_LOOK_PEN_UP, "S:pen up")
	ma.cmds[cmd].help = "Lift the pen up. Pen drawing will stop."
	cmd = cdCreateCmdQuick(CODE_LOOK_DRAW_OVAL, "S:pen oval width ,F:,S: height ,F:,S: angle ,F:0,S: to ,F:360")
	ma.cmds[cmd].help = "Draw an oval (or part of) with the pen. The oval has width and height, and angles between 0 (at top) and 360, is a full oval."
	cmd = cdCreateCmdQuick(CODE_LOOK_CLEAR_PEN, "S:clear pen")
	ma.cmds[cmd].help = "Clear all pen drawing."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PEN_COLOR, "S:set pen color to ,C:#000000")
	ma.cmds[cmd].help = "Set the pen color for subsequent drawing."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PEN_SIZE, "S:set pen size to ,N:1")
	ma.cmds[cmd].help = "Set the pen size. Size ranges from 1 to 100."
	cmd = cdCreateCmdQuick(CODE_LOOK_SET_PEN_STYLE, "S:set pen style to ,J:style")
	ma.cmds[cmd].help = "Set the pen style to round or square points. Defaults to round. More noticable at larger pen sizes."
	cmd = cdCreateCmdQuick(CODE_LOOK_FLIP_X, "S:flip x")
	ma.cmds[cmd].help = "Flip the sprite in the x axis."
	cmd = cdCreateCmdQuick(CODE_LOOK_FLIP_Y, "S:flip y")
	ma.cmds[cmd].help = "Flip the sprite in the y axis."
	cmd = cdCreateCmdQuick(CODE_LOOK_BRING_TO_FRONT, "S:bring to front")
	ma.cmds[cmd].help = "Bring this sprite to the front. The depth value will become 1."
	cmd = cdCreateCmdQuick(CODE_LOOK_SEND_TO_BACK, "S:send to back")
	ma.cmds[cmd].help = "Send this sprite to the back. The depth value will be the largest."
	cmd = cdCreateCmdQuick(CODE_LOOK_BRING_FORWARD, "S:bring forward")
	ma.cmds[cmd].help = "Bring this sprite above the sprite that is currently above it (if there is one)."
	cmd = cdCreateCmdQuick(CODE_LOOK_SEND_BACKWARD, "S:send backward")
	ma.cmds[cmd].help = "Send this sprite behind the sprite that is currently below it (if there is one)."
	cmd = cdCreateCmdQuick(CODE_LOOK_TILE_BG, "S:tile background with frame ,R:,S: cols ,N:1,S: rows ,N:1")
	ma.cmds[cmd].help = "Tile (stretch) this sprite all over the background. Cols and rows specifies how many time to show the sprite."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_VISIBLE, "S:visible")
	ma.cmds[cmd].help = "Return <true> if the sprite is visible, otherwise <false> if hidden."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_OFF_SCREEN, "S:off screen")
	ma.cmds[cmd].help = "Return <true> if the sprite position means it is completely off screen, otherwise returns <false>."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_COLOR, "S:color")
	ma.cmds[cmd].help = "Get the sprite color."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_TRANSPARENCY, "S:transparency")
	ma.cmds[cmd].help = "Get the sprite transparency level, i.e. 0 invisible to 255 fully visible."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_FRAME, "S:frame")
	ma.cmds[cmd].help = "Get the sprite frame."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_SCALE_X, "S:x size")
	ma.cmds[cmd].help = "Get the sprite x size."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_SCALE_Y, "S:y size")
	ma.cmds[cmd].help = "Get the sprite y size."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_WIDTH, "S:width")
	ma.cmds[cmd].help = "Get the sprite width. The width is equal to the original sprite width affected by the x size."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_HEIGHT, "S:height")
	ma.cmds[cmd].help = "Get the sprite height. The height is equal to the original sprite height affected by the y size."
	cmd = cdCreateCmdQuick(CODE_LOOK_GET_DEPTH, "S:depth")
	ma.cmds[cmd].help = "Get the sprite depth."

	// Flow commands.
	cd.qy = y
	//cmd = cdCreateCmdQuick(CODE_FLOW_REPEAT_END, "S:end repeat")
	//cmd = cdCreateCmdQuick(CODE_FLOW_REPEAT_END, "M:gfx/SmallEndCmdIcon.png")
	cmd = cdCreateCmdQuick(CODE_FLOW_REPEAT_END, "M:gfx/SmallEndCmd2Icon.png")
	cdSetCmdVisible(cmd, false)
	ma.cmds[cmd].active = false

	//cmd = cdCreateCmdQuick(CODE_FLOW_ENDIF, "S:end if")
	cmd = cdCreateCmdQuick(CODE_FLOW_ENDIF, "S:     ")
	cdSetCmdVisible(cmd, false)
	ma.cmds[cmd].active = false

	cmd = cdCreateCmdQuick(CODE_FLOW_ELSE, "S:else")
	cdSetCmdVisible(cmd, false)
	ma.cmds[cmd].active = false

	cd.qy = y
	cmd = cdCreateCmdQuick(CODE_FLOW_REPEAT_FOREVER, "S:repeat forever")
	ma.cmds[cmd].help = "Repeat all commands within the 'repeat' block forever."
	cmd = cdCreateCmdQuick(CODE_FLOW_REPEAT_TIMES, "S:repeat ,N:10,S: times")	
	ma.cmds[cmd].help = "Repeat all commands within the 'repeat' block a number of times."
	cmd = cdCreateCmdQuick(CODE_FLOW_REPEAT_WHILE, "S:repeat while ,B:")
	ma.cmds[cmd].help = "Repeat all commands within the 'repeat' block while the <value> is true."
	cmd = cdCreateCmdQuick(CODE_FLOW_REPEAT_UNTIL, "S:repeat until ,B:")
	ma.cmds[cmd].help = "Repeat all commands within the 'repeat' block until the <value> is true."
	cmd = cdCreateCmdQuick(CODE_FLOW_EXIT_LOOP, "S:exit loop")
	ma.cmds[cmd].help = "Exit out of the current loop, and continue code at the first command after the loop end."
	cmd = cdCreateCmdQuick(CODE_FLOW_SKIP_LOOP, "S:skip loop")
	ma.cmds[cmd].help = "Skip all code to the end of loop, and go back to the start of the loop."
	cmd = cdCreateCmdQuick(CODE_FLOW_SEND_EVENT, "S:send message ,T:") // ,S: with ,L:")
	ma.cmds[cmd].help = "Send a message to be received by 'when message received' commands, but doesn't wait. Optionally pass list of data."
	cmd = cdCreateCmdQuick(CODE_FLOW_CALL_BLOCK, "S:call block ,T:,S: turbo ,B:,S: with ,T:,S:  ,T:,S:  ,T:")
	ma.cmds[cmd].help = "Call the block with name and wait until all the code in the block is executed. Optionally pass list of data."
	cmd = cdCreateCmdQuick(CODE_FLOW_PARAM_VALUE, "S:param ,N:1")	
	ma.cmds[cmd].help = "Get the parameter as a value at position in the 'call block' command."
	//cmd = cdCreateCmdQuick(CODE_FLOW_PARAM_BOOL, "S:param ,N:1")	
	//ma.cmds[cmd].help = "Get the parameter as a boolean (<true> or <false>) at position in the 'call block' command."
	cmd = cdCreateCmdQuick(CODE_FLOW_IF, "S:if ,B:false,S: then")
	ma.cmds[cmd].help = "Executes the code within the 'if' block, if the <value> is true."
	cmd = cdCreateCmdQuick(CODE_FLOW_IF_ELSE, "S:if ,B:false,S: then,S: else")
	ma.cmds[cmd].help = "Executes the code in the 'if' block, if the <value> is true. Otherwise, it executes the code in the 'else' block."
	cmd = cdCreateCmdQuick(CODE_FLOW_WAIT_SECS, "S:wait for ,F:1.0,S: seconds")
	ma.cmds[cmd].help = "Pause execution of code for this sprite, until a number of seconds has passed. Value can be decimal, starting from 0.0"
	cmd = cdCreateCmdQuick(CODE_FLOW_WAIT_UNTIL, "S:wait until ,B:")
	ma.cmds[cmd].help = "Pause execution of code for this sprite, until the value returns <true>."
	cmd = cdCreateCmdQuick(CODE_FLOW_RESET_TIMER, "S:reset timer")
	ma.cmds[cmd].help = "Reset the timer to 0. When the project is run, the timer starts at 0."
	cmd = cdCreateCmdQuick(CODE_FLOW_GET_TIMER, "S:timer")
	ma.cmds[cmd].help = "Get the value of the timer. The timer is in milliseconds (1000 ticks per second)."
	cmd = cdCreateCmdQuick(CODE_FLOW_STOP, "S:stop ,J:type")
	ma.cmds[cmd].help = "Stop execution of code for 'this block', 'other blocks', 'all blocks' for the current sprite or clone, or 'program'."
	cmd = cdCreateCmdQuick(CODE_FLOW_COMMENT, "S:comment ,T:")
	ma.cmds[cmd].help = "Create a single line comment in your code. Doesn't do anything."

	// Sense commands.
	cd.qy = y
	cmd = cdCreateCmdQuick(CODE_SENSE_TRUE, "S:true")
	ma.cmds[cmd].help = "True operator. Always return <true>."
	cmd = cdCreateCmdQuick(CODE_SENSE_FALSE, "S:false")
	ma.cmds[cmd].help = "False operator. Always return <false>."
	cmd = cdCreateCmdQuick(CODE_SENSE_EQ, "S:eq ,F:,S: = ,F:")	
	ma.cmds[cmd].help = "Equals operator. Return <true> if the two values are equal."
	cmd = cdCreateCmdQuick(CODE_SENSE_NE, "S:ne ,F:,S: <> ,F:")	
	ma.cmds[cmd].help = "Not equals operator. Return <true> if the two values are not equal."
	cmd = cdCreateCmdQuick(CODE_SENSE_LT, "S:lt ,F:,S: < ,F:")	
	ma.cmds[cmd].help = "Less than operator. Return <true> if the first value is less than the second value."
	cmd = cdCreateCmdQuick(CODE_SENSE_LE, "S:le ,F:,S: <= ,F:")	
	ma.cmds[cmd].help = "Less than or equal operator. Return <true> if the first value is less than, or equals to the second value."
	cmd = cdCreateCmdQuick(CODE_SENSE_GT, "S:gt ,F:,S: > ,F:")	
	ma.cmds[cmd].help = "Greater than operator. Return <true> if the first value is greater than the second value."
	cmd = cdCreateCmdQuick(CODE_SENSE_GE, "S:ge ,F:,S: >= ,F:")	
	ma.cmds[cmd].help = "Greater than or equal operator. Return <true> if the first value is greater than, or equals to the second value."
	cmd = cdCreateCmdQuick(CODE_SENSE_NOT, "S:not ,B:")	
	ma.cmds[cmd].help = "Not operator. Return <true> if the value is not <true>, otherwise returns <false>."
	cmd = cdCreateCmdQuick(CODE_SENSE_OR, "B:,S: or ,B:")	
	ma.cmds[cmd].help = "Or operator. Return <true> if the first value is <true>, or the second value is <true>."
	cmd = cdCreateCmdQuick(CODE_SENSE_AND, "B:,S: and ,B:")	
	ma.cmds[cmd].help = "And operator. Return <true> if the first value is <true>, and the second value is <true>."
	cmd = cdCreateCmdQuick(CODE_SENSE_AS_BOOL, "S:as bool ,T:")
	ma.cmds[cmd].help = "Converts a value to a boolean, i.e. <true> or <false>. If the value is zero or blank, returns <false>, otherwise return <true>."
	cmd = cdCreateCmdQuick(CODE_SENSE_PTR_PRESSED, "S:pointer pressed?")
	ma.cmds[cmd].help = "Return <true> if the pointer was just pressed."
	cmd = cdCreateCmdQuick(CODE_SENSE_PTR_DOWN, "S:pointer held?")
	ma.cmds[cmd].help = "Return <true> if the pointer is currently held down."
	cmd = cdCreateCmdQuick(CODE_SENSE_PTR_RELEASED, "S:pointer released?")
	ma.cmds[cmd].help = "Return <true> if the pointer was pressed, then released."
	cmd = cdCreateCmdQuick(CODE_SENSE_SPRITE_PRESSED, "S:pressed on sprite?")
	ma.cmds[cmd].help = "Return <true> if the pointer was pressed on a sprite."
	//cmd = cdCreateCmdQuick(CODE_SENSE_SPRITE_DOWN, "S:held on sprite?")
	//ma.cmds[cmd].help = "Return <true> if the pointer is currently held down on a sprite."
	cmd = cdCreateCmdQuick(CODE_SENSE_SPRITE_RELEASED, "S:released on sprite?")
	ma.cmds[cmd].help = "Return <true> if the pointer was pressed on a sprite, then released."
	cmd = cdCreateCmdQuick(CODE_SENSE_COLL_ANY_THING, "S:hit by sprite?")
	ma.cmds[cmd].help = "Return <true> if this sprite or clone of this sprite just collided with any other sprite."
	cmd = cdCreateCmdQuick(CODE_SENSE_COLL_THING, "S:hit by sprite? ,H:")
	ma.cmds[cmd].help = "Return <true> if this sprite or clone of this sprite just collided with the specified sprite."
	cmd = cdCreateCmdQuick(CODE_SENSE_COLL_ANY_CLONE, "S:hit by clone?")
	ma.cmds[cmd].help = "Return <true> if this sprite just collided with a clone of any other sprite."
	cmd = cdCreateCmdQuick(CODE_SENSE_COLL_CLONE, "S:hit by clone? ,H:")
	ma.cmds[cmd].help = "Return <true> if this sprite just collided with a clone of the specified sprite."
	cmd = cdCreateCmdQuick(CODE_SENSE_IAM_SPRITE, "S:a sprite")
	ma.cmds[cmd].help = "Return <true> if I'm a sprite."
	cmd = cdCreateCmdQuick(CODE_SENSE_IAM_CLONE, "S:a clone")
	ma.cmds[cmd].help = "Return <true> if I'm a clone."
	cmd = cdCreateCmdQuick(CODE_SENSE_SPRITE_VIS, "S:sprite visible ,H:,S: ?")
	ma.cmds[cmd].help = "Check if the specified sprite is visible."
	cmd = cdCreateCmdQuick(CODE_SENSE_SPRITE_OFF_SCREEN, "S:sprite off screen ,H:,S: ?")
	ma.cmds[cmd].help = "Check if the specified sprite is visible."
	cmd = cdCreateCmdQuick(CODE_SENSE_COLL_EDGE, "S:hit edge? ,J:edges")
	ma.cmds[cmd].help = "Return <true> if this sprite has just collided with the specified screen edge."
	cmd = cdCreateCmdQuick(CODE_SENSE_VAR_PRESSED, "S:pressed on var ,V:,S: ?")
	ma.cmds[cmd].help = "Return <true> if the pointer was pressed over a variable."
	//cmd = cdCreateCmdQuick(CODE_SENSE_VAR_DOWN, "S:held on variable ,V:,S: ?")
	//ma.cmds[cmd].help = "Return <true> if the pointer is currently held down on a variable."
	cmd = cdCreateCmdQuick(CODE_SENSE_VAR_RELEASED, "S:released on var ,V:,S: ?")
	ma.cmds[cmd].help = "Return <true> if the pointer was pressed on a variable, then released."
	cmd = cdCreateCmdQuick(CODE_SENSE_PTR_X, "S:pointer x")
	ma.cmds[cmd].help = "Get the x position on the screen where the pointer is."
	cmd = cdCreateCmdQuick(CODE_SENSE_PTR_Y, "S:pointer y")
	ma.cmds[cmd].help = "Get the y position on the screen where the pointer is."
	//cmd = cdCreateCmdQuick(CODE_SENSE_SET_AS_BG, "S:set background press")
	//ma.cmds[cmd].help = "Set this sprite as a background sprite, i.e. it will respond to presses anywhere on the screen."
	cmd = cdCreateCmdQuick(CODE_SENSE_X_MAX, "S:max x")
	ma.cmds[cmd].help = "Get the x position at the very right of the screen. The width of the screen = max x + 1."
	cmd = cdCreateCmdQuick(CODE_SENSE_Y_MAX, "S:max y")
	ma.cmds[cmd].help = "Get the y position at the very bottom of the display. The height of the screen = maxy + 1."
	cmd = cdCreateCmdQuick(CODE_SENSE_X_MID, "S:mid x")
	ma.cmds[cmd].help = "Get the middle x position of the screen."
	cmd = cdCreateCmdQuick(CODE_SENSE_Y_MID, "S:mid y")
	ma.cmds[cmd].help = "Get the middle y position of the screen."
	cmd = cdCreateCmdQuick(CODE_SENSE_SPRITE_INFO, "J:info,S: of sprite ,H:")
	ma.cmds[cmd].help = "Get info about a sprite, including x position, y position, angle, etc."

	// Emit commands.
	cd.qy = y
	//cmd = cdCreateCmdQuick(CODE_EMIT_PRINT_AT, "S:display ,T:hello,S: at x ,F:,S: and y ,F:")
	//ma.cmds[cmd].help = "Display the message at the x and y position."
	cmd = cdCreateCmdQuick(CODE_EMIT_SET_BG_COLOR, "S:set background color to ,C:#FFFFFF")
	ma.cmds[cmd].help = "Set the screen background color."
	cmd = cdCreateCmdQuick(CODE_EMIT_MAKE_COLOR, "S:color red ,N:0,S: green ,N:0,S: blue ,N:0")
	ma.cmds[cmd].help = "Make a color, with red, green and blue value between 0 and 255. Also see 'random color value'."
	cmd = cdCreateCmdQuick(CODE_EMIT_PRELOAD_SOUND, "S:load sound ,U:")
	ma.cmds[cmd].help = "Load a sound. Use 'play sound' to play."
	cmd = cdCreateCmdQuick(CODE_EMIT_UNLOAD_SOUND, "S:unload sound ,U:")
	ma.cmds[cmd].help = "Unload a loaded sound to clear the memory used."
	cmd = cdCreateCmdQuick(CODE_EMIT_PLAY_SOUND, "S:play sound ,U:")
	ma.cmds[cmd].help = "Play a loaded sound in the background. You can play the same sound many times. See 'channel' command."
	cmd = cdCreateCmdQuick(CODE_EMIT_PLAY_SOUND_DONE, "S:play sound ,U:,S: until done")
	ma.cmds[cmd].help = "Play a loaded sound until it is complete. Code will not resume for this sprite until the sound stops playing."
	cmd = cdCreateCmdQuick(CODE_EMIT_GET_CHANNEL, "S:channel")
	ma.cmds[cmd].help = "Get the channel for the last 'play sound' command. The channel can be used with other sound commands."
	cmd = cdCreateCmdQuick(CODE_EMIT_SET_CHANNEL_VOLUME, "S:set volume to ,F:100,S: % for channel ,N:1")
	ma.cmds[cmd].help = "Set the volume for the sound playing on the specified channel."
	cmd = cdCreateCmdQuick(CODE_EMIT_GET_CHANNEL_VOLUME, "S:volume for channel ,N:1")
	ma.cmds[cmd].help = "Get the volume for the specified sound channel."
	cmd = cdCreateCmdQuick(CODE_EMIT_STOP_SOUND, "S:stop sound on channel ,N:1")
	ma.cmds[cmd].help = "Stop the sound playing on the specified channel."
	cmd = cdCreateCmdQuick(CODE_EMIT_STOP_ALL_SOUNDS, "S:stop all sounds")
	ma.cmds[cmd].help = "Stop all sounds playing on all channels."
	cmd = cdCreateCmdQuick(CODE_EMIT_SET_SOUND_VOLUME, "S:set volume to ,F:100,S: %")
	ma.cmds[cmd].help = "Set the default volume for next played sound. Volume ranges from 0.0 to 100.0%"
	cmd = cdCreateCmdQuick(CODE_EMIT_SET_SOUND_LOOPS, "S:set sound loops to ,N:1")
	ma.cmds[cmd].help = "Set the number of times to loop for next played sound. Set 'loops' value = 0 to loop forever, otherwise 1 or greater."
	cmd = cdCreateCmdQuick(CODE_EMIT_GET_SOUND_VOLUME, "S:volume")
	ma.cmds[cmd].help = "Get the default volume that played sounds will use."
	cmd = cdCreateCmdQuick(CODE_EMIT_PLAY_VIDEO, "S:play video")
	ma.cmds[cmd].help = "Play the loaded video. By default, the video plays in the middle of the screen. Does nothing if a video is not loaded."
	cmd = cdCreateCmdQuick(CODE_EMIT_PLAY_VIDEO_DONE, "S:play video until done")
	ma.cmds[cmd].help = "Play the loaded video until it is complete. That is, code will not resume for this sprite until the video stops playing."
	cmd = cdCreateCmdQuick(CODE_EMIT_LOAD_VIDEO, "S:load video ,O:")
	ma.cmds[cmd].help = "Load a video. To play use 'play video'"
	cmd = cdCreateCmdQuick(CODE_EMIT_UNLOAD_VIDEO, "S:unload video")
	ma.cmds[cmd].help = "Unload a loaded video to clear the memory used."
	cmd = cdCreateCmdQuick(CODE_EMIT_PAUSE_VIDEO, "S:pause video")
	ma.cmds[cmd].help = "Pause the playing video. Call 'play video' to resume playing."
	cmd = cdCreateCmdQuick(CODE_EMIT_STOP_VIDEO, "S:stop video")
	ma.cmds[cmd].help = "Stop the playing video."
	cmd = cdCreateCmdQuick(CODE_EMIT_SHOW_VIDEO, "S:show video")
	ma.cmds[cmd].help = "Show the video, but don't start playing."
	cmd = cdCreateCmdQuick(CODE_EMIT_HIDE_VIDEO, "S:hide video")
	ma.cmds[cmd].help = "Hide the video. Show video with [play video] or [show video]."
	cmd = cdCreateCmdQuick(CODE_EMIT_SHOW_VIDEO_PANEL, "S:show video panel")
	ma.cmds[cmd].help = "Show the video panel with play/pause button, and video progress, under the loaded video."
	cmd = cdCreateCmdQuick(CODE_EMIT_HIDE_VIDEO_PANEL, "S:hide video panel")
	ma.cmds[cmd].help = "Hide the video panel."
	cmd = cdCreateCmdQuick(CODE_EMIT_SET_VIDEO_POS, "S:set video x to ,F:0,S: and y to ,F:0")
	ma.cmds[cmd].help = "Set the video x position and y position at the same time."
	cmd = cdCreateCmdQuick(CODE_EMIT_SET_VIDEO_WIDTH, "S:set video width to ,F:0")
	ma.cmds[cmd].help = "Set the video width. Note: the video height will be set automatically, to keep the aspect ratio of the video."
	cmd = cdCreateCmdQuick(CODE_EMIT_SET_VIDEO_HEIGHT, "S:set video height to ,F:0")
	ma.cmds[cmd].help = "Set the video height. Note: the video width will be set automatically, to keep the aspect ratio of the video."
	cmd = cdCreateCmdQuick(CODE_EMIT_GET_VIDEO_DURATION, "S:video duration")
	ma.cmds[cmd].help = "Get the video duration in seconds."
	cmd = cdCreateCmdQuick(CODE_EMIT_GET_VIDEO_TIME, "S:video time")
	ma.cmds[cmd].help = "Get the video time (in seconds) where the video is up to, i.e. between 0 and duration."
	cmd = cdCreateCmdQuick(CODE_EMIT_SET_VIDEO_TIME, "S:set video time ,F:0")
	ma.cmds[cmd].help = "Set the video time (in seconds), i.e. between 0 and duration."
	cmd = cdCreateCmdQuick(CODE_EMIT_GET_VIDEO_X, "S:video x position")
	ma.cmds[cmd].help = "Get the video y position."
	cmd = cdCreateCmdQuick(CODE_EMIT_GET_VIDEO_Y, "S:video y position")
	ma.cmds[cmd].help = "Get the video y position."
	// Calc commands.
	cd.qy = y	
	cmd = cdCreateCmdQuick(CODE_CALC_PLUS, "S:add ,F:,S:  +  ,F:")	
	ma.cmds[cmd].help = "Add two values and return the result."
	cmd = cdCreateCmdQuick(CODE_CALC_MINUS, "S:sub ,F:,S:  -  ,F:")	
	ma.cmds[cmd].help = "Subtract the second value from the first and return the result."
	cmd = cdCreateCmdQuick(CODE_CALC_MULTIPLY, "S:mult ,F:,S:  x  ,F:")	
	ma.cmds[cmd].help = "Multiply two values and return the result."
	cmd = cdCreateCmdQuick(CODE_CALC_DIVIDE, "S:div ,F:,S:  /  ,F:1")	
	ma.cmds[cmd].help = "Divide the first value by the second and return the result."
	cmd = cdCreateCmdQuick(CODE_CALC_MOD, "S:rem ,F:,S:  /  ,F:1")	
	ma.cmds[cmd].help = "Divide the first value by the second and return the remainder."
	cmd = cdCreateCmdQuick(CODE_CALC_POW, "S:power ,F:1,S: ^ ,F:1")	
	ma.cmds[cmd].help = "Return the result of the first value to the power of the second value."
	cmd = cdCreateCmdQuick(CODE_CALC_ROUND, "S:round ,F:")	
	ma.cmds[cmd].help = "Round the value and return the result."
	cmd = cdCreateCmdQuick(CODE_CALC_RANDOM, "S:random ,N:1,S: to ,N:10")	
	ma.cmds[cmd].help = "Return a random whole number between the first value and the second value."
	cmd = cdCreateCmdQuick(CODE_CALC_RANDOM_X_POS, "S:random x pos")	
	ma.cmds[cmd].help = "Return a random x position between 0 and [x max]."
	cmd = cdCreateCmdQuick(CODE_CALC_RANDOM_Y_POS, "S:random y pos")	
	ma.cmds[cmd].help = "Return a random y position between 0 and [y max]."
	cmd = cdCreateCmdQuick(CODE_CALC_RANDOM_FLOAT, "S:random float")	
	ma.cmds[cmd].help = "Return a random float number between the 0.0 and 1.0"
	cmd = cdCreateCmdQuick(CODE_CALC_RANDOM_COLOR, "S:random color")
	ma.cmds[cmd].help = "Return a random color in the form rrrgggbbb, where rrr is red, ggg is green and bbb is blue. Values of rrr, ggg and bbb are from 000 to 255"
	cmd = cdCreateCmdQuick(CODE_CALC_NEG, "S:neg ,F:")
	ma.cmds[cmd].help = "Return the opposite sign of the value. If positive, return negative, and visa-versa."
	cmd = cdCreateCmdQuick(CODE_CALC_SIN, "S:sin ,F:")	
	ma.cmds[cmd].help = "Return the sine of the angle value."
	cmd = cdCreateCmdQuick(CODE_CALC_COS, "S:cos ,F:")	
	ma.cmds[cmd].help = "Return the cosine of the angle value."
	cmd = cdCreateCmdQuick(CODE_CALC_TAN, "S:tan ,F:")	
	ma.cmds[cmd].help = "Return the tangent of the angle value."
	cmd = cdCreateCmdQuick(CODE_CALC_ASIN, "S:asin ,F:")	
	ma.cmds[cmd].help = "Return the arc sine of the value."
	cmd = cdCreateCmdQuick(CODE_CALC_ACOS, "S:acos ,F:")	
	ma.cmds[cmd].help = "Return the arc cosine of the value."
	cmd = cdCreateCmdQuick(CODE_CALC_ATAN, "S:atan ,F:")	
	ma.cmds[cmd].help = "Return the arc tangent of the value."
	cmd = cdCreateCmdQuick(CODE_CALC_LOG, "S:log ,F:1")	
	ma.cmds[cmd].help = "Return the log 10 of the value."
	cmd = cdCreateCmdQuick(CODE_CALC_SQRT, "S:sqrt ,F:")
	ma.cmds[cmd].help = "Return the square root of the value."
	cmd = cdCreateCmdQuick(CODE_CALC_FORMAT_NBR, "S:format ,T:0,S: digits ,N:1,S: split ,T:,,S: places ,N:2")	
	ma.cmds[cmd].help = "Return a formatted number value with minimum digits, padded with 0 if too small. Split is added at every 3 digits. Places is now many decimals."
	//cmd = cdCreateCmdQuick(CODE_CALC_GET_DATETIME, "S:datetime")
	//ma.cmds[cmd].help = "Get the current date and time as a number in seconds from 1-1-1970. Use it for calculations, or in 'date' and 'time' commands."
	cmd = cdCreateCmdQuick(CODE_CALC_AS_NBR, "S:as number ,B:")
	ma.cmds[cmd].help = "Return the boolean value (<true> or <false>) as a number. <true> = 1, <false> = 0."
	cmd = cdCreateCmdQuick(CODE_CALC_AS_TEXT, "S:as text ,B:")
	ma.cmds[cmd].help = "Return the boolean value (<true> or <false>) as a text value, i.e. the word 'true' or 'false'."
	cmd = cdCreateCmdQuick(CODE_CALC_GET_DATE, "S:date as ,T:yyyy-mm-dd")
	ma.cmds[cmd].help = "Return the date formatted, e.g. 2017-07-01. If date is left blank, the current date is used."
	cdAppendHelpTok(ma.cmds[cmd].help2, "<B>Formats<B><F ->")
	for i = 0 to co.dateFmt.length
		cdAppendHelpTok(ma.cmds[cmd].help2, co.dateFmt[i] + "<X 135>" + co.dateFmtHelp[i])
	next
	cdAppendHelpTok(ma.cmds[cmd].help2, "<F +>")
	cmd = cdCreateCmdQuick(CODE_CALC_GET_TIME, "S:time as ,T:hh:mm:ss")
	ma.cmds[cmd].help = "Return the time formatted, e.g. 12:34:56. If time is left blank, the current time is used."
	cdAppendHelpTok(ma.cmds[cmd].help2, "<B>Formats<B><F ->")
	for i = 0 to co.timeFmt.length
		cdAppendHelpTok(ma.cmds[cmd].help2, co.timeFmt[i] + "<X 135>" + co.timeFmtHelp[i])
	next 
	cdAppendHelpTok(ma.cmds[cmd].help2, "<F +>")	
	cmd = cdCreateCmdQuick(CODE_CALC_TRIM, "S:trim ,T:,S: from ,T:")	
	ma.cmds[cmd].help = "Return a new string by trimming both ends of the text, e.g. trim [.0] from [1.000000] with return 1"
	cmd = cdCreateCmdQuick(CODE_CALC_EXTRACT, "S:part ,N:1,S: len ,N:1,S: in ,T:")
	ma.cmds[cmd].help = "Return a part of value at position with length."
	cmd = cdCreateCmdQuick(CODE_CALC_REPLACE, "S:replace ,T:,S: with ,T:,S: in ,T:,S: count ,N:0")	
	ma.cmds[cmd].help = "Return the result of replacing the first value with second value in the third value. Count is how many times to replace, 0 = all."
	cmd = cdCreateCmdQuick(CODE_CALC_FIND, "S:find ,T:,S: in ,T:,S: from ,N:1,S: rev ,B:")	
	ma.cmds[cmd].help = "Return the position of the first value found within second value, starting at from position. If rev is <true>, search from end in reverse. Return 0 if not found."
	//cmd = cdCreateCmdQuick(CODE_CALC_FIND_REV, "S:find rev ,T:,S: in ,T:,S: from ,N:-1")	
	//ma.cmds[cmd].help = "Return the position of the first value found within second value, starting at position, searching in reverse. Return 0 if not found."
	cmd = cdCreateCmdQuick(CODE_CALC_APPEND, "S:append ,T:,S: and ,T:")	
	ma.cmds[cmd].help = "Return a new value by appending the second value to the first value."
	cmd = cdCreateCmdQuick(CODE_CALC_SPLIT_TEXT, "S:split ,T:,S: by ,T:,")	
	ma.cmds[cmd].help = "Return a list, by splitting the value by the delimiter."
	cmd = cdCreateCmdQuick(CODE_CALC_LEN, "S:length ,T:")	
	ma.cmds[cmd].help = "Return the length of a value."
	cmd = cdCreateCmdQuick(CODE_CALC_IGNORE_CASE, "S:ignore case ,B:")	
	ma.cmds[cmd].help = "Sets whether 'find' and 'replace' ignores case, i.e. doesn't consider upper and lower case letters. Default is false."

	// Data commands.
	cd.qy = y
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR, "S:set ,V:,S: to ,T:")
	ma.cmds[cmd].help = "Set the named value variable to a value."		
	cmd = cdCreateCmdQuick(CODE_DATA_CHANGE_VAR, "S:change ,V:,S: by ,F:")
	ma.cmds[cmd].help = "Increase or decrease the number in the value variable by the amount. If the value is not a pure number, then the first number found is used."		

	if ld.set.tmpVarsAllowed
		
		cmd = cdCreateCmdQuick(CODE_DATA_MAKE_TMP_VAR, "S:make value ,T:")
		ma.cmds[cmd].help = "Make a new value variable for use with this sprite. The variable only exists while the project is running."
		cmd = cdCreateCmdQuick(CODE_DATA_GET_TMP_VAR, "S:value ,T:")
		ma.cmds[cmd].help = "Access a new value variable. Note: If you drop a value variable onto this command, the variable value is used as the name."

	endif
	
	cmd = cdCreateCmdQuick(CODE_DATA_WAIT_INPUT, "S:wait for input into ,V:")
	ma.cmds[cmd].help = "Request input from the keyboard into the value variable."
	cmd = cdCreateCmdQuick(CODE_DATA_ADD_ITEM, "S:add ,T:,S: to ,L:")	
	ma.cmds[cmd].help = "Add a value to the list variable."
	cmd = cdCreateCmdQuick(CODE_DATA_INSERT_ITEM, "S:insert ,T:,S: at ,N:1,S: in ,L:")	
	ma.cmds[cmd].help = "Insert a value at position in the list variable."
	cmd = cdCreateCmdQuick(CODE_DATA_ADD_ITEM_BY_NAME, "S:add ,T:,S: as name ,T:,S: to ,L:")	
	ma.cmds[cmd].help = "Add a value to the list variable, give it a name for looking up. If it exists with the name, it is replaced, otherwise appended to the list."
	cmd = cdCreateCmdQuick(CODE_DATA_REMOVE_ITEM, "S:remove ,N:1,S: from ,L:")	
	ma.cmds[cmd].help = "Remove the item at position in the list variable."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_ITEM_VALUE, "S:change item ,T:,S: at ,N:1,S: in ,L:")	
	ma.cmds[cmd].help = "Change the value of the list item at position in the list. variable"
	cmd = cdCreateCmdQuick(CODE_DATA_SET_ITEM_NAME, "S:change name ,T:,S: at ,N:1,S: in ,L:")	
	ma.cmds[cmd].help = "Set the name of the list item at position in the list variable. Note: If this name already exists in the list, the other item will be removed."
	cmd = cdCreateCmdQuick(CODE_DATA_ITEM, "S:item at ,N:1,S: in ,L:")	
	ma.cmds[cmd].help = "Return the item at position in list variable."
	cmd = cdCreateCmdQuick(CODE_DATA_ITEM_NAME, "S:name at ,N:1,S: in ,L:")	
	ma.cmds[cmd].help = "Return the item name at position in list variable."
	cmd = cdCreateCmdQuick(CODE_DATA_ITEM_BY_NAME, "S:item by name ,T:,S: in ,L:")	
	ma.cmds[cmd].help = "Return the item with name in list variable."
	cmd = cdCreateCmdQuick(CODE_DATA_ITEM_VALUE_INDEX, "S:pos of item ,T:,S: in ,L:")	
	ma.cmds[cmd].help = "Return the position of the item with value in the list. If there are duplicate names, the first is returned. Returns 0 if not found."
	cmd = cdCreateCmdQuick(CODE_DATA_ITEM_NAME_INDEX, "S:pos of name ,T:,S: in ,L:")	
	ma.cmds[cmd].help = "Return the position of the item with name in the list. If there are duplicate names, the first is returned. Returns 0 if not found."
	cmd = cdCreateCmdQuick(CODE_DATA_JOIN_LIST, "S:join ,L:,S: by ,T:,")	
	ma.cmds[cmd].help = "Return a new value by joining all items in the list seperated by the delimiter."
	//cmd = cdCreateCmdQuick(CODE_DATA_CLEAR_LIST, "S:clear ,L:")	
	//ma.cmds[cmd].help = "Clear all items from the list."
	//cmd = cdCreateCmdQuick(CODE_DATA_PARAM_BY_INDEX, "S:param at ,N:1")	
	//ma.cmds[cmd].help = "Get the item at position in the list variable passed to 'call block'."

	if ld.set.tmpVarsAllowed
		
		cmd = cdCreateCmdQuick(CODE_DATA_MAKE_TMP_LIST, "S:make list ,T:")
		ma.cmds[cmd].help = "Make a new list variable to hold values for use with this sprite. The list only exists while the project is running."
		cmd = cdCreateCmdQuick(CODE_DATA_GET_TMP_LIST, "S:list ,T:")
		ma.cmds[cmd].help = "Access a new list variable. Note: If you drop a variable onto this command, the variable value is used as the name."

	endif

	cmd = cdCreateCmdQuick(CODE_DATA_CLEAR_VAR, "S:clear ,A:")	
	ma.cmds[cmd].help = "Clear the variable value. For a list, clear all items."
	cmd = cdCreateCmdQuick(CODE_DATA_SHOW_VAR, "S:show ,A:")
	ma.cmds[cmd].help = "Show the var."
	cmd = cdCreateCmdQuick(CODE_DATA_HIDE_VAR, "S:hide ,A:")
	ma.cmds[cmd].help = "Hide the var."
	cmd = cdCreateCmdQuick(CODE_DATA_SHARE_TMP_VAR, "S:share ,A:")
	ma.cmds[cmd].help = "Change a sprite variable into a project variable shared across all sprites."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_X, "S:set ,A:,S: x to ,F:0")
	ma.cmds[cmd].help = "Set the variable x position."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_Y, "S:set ,A:,S: y to ,F:0")
	ma.cmds[cmd].help = "Set the variable y position."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_W, "S:set ,A:,S: width to ,F:0")
	ma.cmds[cmd].help = "Set the variable width."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_H, "S:set ,A:,S: height to ,F:0")
	ma.cmds[cmd].help = "Set the variable height."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_BG_COLOR, "S:set ,A:,S: background color to ,C:#" + coColorToHex(ma.defvv.bgCol))
	ma.cmds[cmd].help = "Set the color of the variable background box."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TITLE_VIS, "S:set ,A:,S: title visible ,B:false")
	ma.cmds[cmd].help = "Set whether the variable title is visible."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TITLE_COLOR, "S:set ,A:,S: title color to ,C:#" + coColorToHex(ma.defvv.titleCol))
	ma.cmds[cmd].help = "Set the color of the variable title."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TITLE_FONT, "S:set ,A:,S: title font to ,J:" + OBJ_VAR_FONT)
	ma.cmds[cmd].help = "Set the font of the variable title."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TITLE_FONT_SIZE, "S:set ,A:,S: title font size to ,N:" + str(LD_TEXT_SIZE_MIN))
	ma.cmds[cmd].help = "Set the font size of the variable title. Valid values are from " + str(LD_TEXT_SIZE_MIN) + " to " + str(LD_TEXT_SIZE_MAX) + "."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TITLE_DIR, "S:set ,A:,S: title pos to ,J:edge")
	ma.cmds[cmd].help = "Set where variable title is displayed. Valid values are from top, bottom, left and right."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TITLE_ALIGN, "S:set ,A:,S: title align to ,J:" + OBJ_VAR_TITLE_ALIGN)
	ma.cmds[cmd].help = "Set the alignment of variable title. Valid values are from left, middle and right."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TEXT_COLOR, "S:set ,A:,S: value color to ,C:#" + coColorToHex(ma.defvv.textCol))
	ma.cmds[cmd].help = "Set the color of the variable text."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TEXT_FONT, "S:set ,A:,S: value font to ,J:" + OBJ_VAR_FONT)
	ma.cmds[cmd].help = "Set the font of the variable value."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TEXT_FONT_SIZE, "S:set ,A:,S: value font size to ,N:" + str(LD_TEXT_SIZE_MIN))
	ma.cmds[cmd].help = "Set the font size of the variable value. Valid values are from " + str(LD_TEXT_SIZE_MIN) + " to " + str(LD_TEXT_SIZE_MAX) + "."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TEXT_ALIGN, "S:set ,A:,S: value align to ,J:" + OBJ_VAR_TEXT_ALIGN)
	ma.cmds[cmd].help = "Set the alignment of variable value. Valid values are from left, middle and right."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_TEXT_SECRET, "S:set ,A:,S: value secret to ,B:")
	ma.cmds[cmd].help = "Set the variable value to be secret, i.e. show stars instead of the variable value. Useful for passwords."
	cmd = cdCreateCmdQuick(CODE_DATA_SET_VAR_BOX_COLOR, "S:set ,A:,S: value box color to ,C:#" + coColorToHex(ma.defvv.textCol))
	ma.cmds[cmd].help = "Set the color of the variable value box."
	
/*
	// Block commands.
	cd.qy = y
	cmd = cdCreateCmdQuick(CODE_NAME_MAKE, "S:make variable")
	ma.cmds[cmd].help = "Make a [variable] to hold a value or name a block."
	cdSetCmdColor(cmd, co.bluegrey[7])
*/

endfunction

//-----------------------------------------------------
//
function cdDeleteAllCmds()
	
	local i as integer
	
	for i = 0 to cd.selCmds.length
		cdDeleteCmd(cd.selCmds[i])
	next 
	
	cd.selCmds.length = -1
	
endfunction

//-----------------------------------------------------
//
function cdSetupCmdHelp(cmdhelp ref as string[])

	local cmd as integer
	local i as integer
	local fin as StringFinder
	local code as integer
	local selIdx as integer
	local tok as string
	local waitLine as string
	
	cmd = 0
	waitLine = ""
	
	for i = 0 to cmdhelp.length

		if left(cmdhelp[i], 2) = "//" // Comment, ignore.
			
			continue
			
		elseif left(cmdhelp[i], 1) = "#" // Cmd or page line.
			
			fin.s = cmdhelp[i]
			fin.pos = 2
			coFindStrHex(fin)
			code = coHexToInt(fin.t)
			selIdx = cdFindSelCmdIdx(code)
			
			if selIdx > -1
					
				cmd = cd.selCmds[selIdx]
	
				if cmd > -1
					cdAppendHelpTok(ma.cmds[cmd].help2, " ") // Add a blank line first.
				endif
				
			endif
			
		elseif cmd > -1

			tok = cmdhelp[i]
			if tok = "" then tok = " " 

			if waitLine <> ""
				
				tok = waitLine + tok
				waitLine = ""
				
			endif
			 		
			if right(tok, 1) = "\"
				waitLine = TrimString(tok, "\")
			else 
				cdAppendHelpTok(ma.cmds[cmd].help2, tok)
			endif			
			
		endif
					
	next

	cmdhelp.length = -1 // Clear space.
	
endfunction

//-----------------------------------------------------
//
function cdSetupPageHelp()

	local cmd as integer
	local pageIdx as integer
	local i as integer
	local fin as StringFinder
	
	pageIdx = -1
	
	for i = 0 to ld.pagehelp.length

		if left(ld.pagehelp[i], 1) = "#" // Cmd or page line.
		//if left(lower(ld.pagehelp[i]), 7) = "<a name" // Cmd or page line.
			
			fin.s = ld.pagehelp[i]
			fin.pos = 2
			//fin.pos = 8
			coFindStrDigits(fin) 
			pageIdx = val(fin.t)
			coFindStrChars(fin, " ")
			coFindStrChars(fin, co.alphas + " ")

			if cd.helpDetails.pages.length < pageIdx
				cd.helpDetails.pages.length = pageIdx
			endif
						
			cd.helpDetails.pages[pageIdx].name = fin.t
			cd.helpDetails.pages[pageIdx].toks.length = -1
			
/*
			//coFindStrSymbols(fin, "= ")
			
			if fin.t <> ""
				
				coFindStrQuoted(fin)
				
				if fin.t <> ""
					pageIdx = val(fin.t)
				endif
				
			endif
*/
		elseif pageIdx > -1 //and pageIdx <= cd.helpDetails.pages.length
							
			if len(ld.pagehelp[i]) = 0
				cdAppendHelpTok(cd.helpDetails.pages[pageIdx].toks, " ")
			else
				cdAppendHelpTok(cd.helpDetails.pages[pageIdx].toks, ld.pagehelp[i])
			endif
			
		endif
		
	next

	ld.pagehelp.length = -1 // Clear space.
	
endfunction

function coFindHelpPage(pageIdx as integer)
endfunction

//-----------------------------------------------------
// Create a cmd quickly with text based defs.
// Add it to the selCmds list.
//
function cdCreateCmdQuick(code as integer, def as string)

	local cmd as integer
	
	cmd = cdBuildCmdQuick(code, def)
	cdSetSelCmdPos(cmd)
	cd.qy = cd.qy + ma.cmds[cmd].h + CD_CMD_GAP * cd.cmdScales[ld.set.cmdSize]
	
	cd.selCmds.insert(cmd)

endfunction cmd

//-----------------------------------------------------
// Set the naming button in settings to the current setting value.
//
function cdResizeSelCmds()

	local i as integer
	local j as integer
	local grpTab as integer
	local thingIdx as integer
	local idx as integer
	local cmd as integer

	// Delete project cmds for resize.
	for i = 0 to ma.apps.length

		for j = 0 to ma.apps[i].vars.length

			idx = ma.apps[i].vars[j]
			
			if ma.vars[idx].cmd

				cdDeleteCmd(ma.vars[idx].cmd)
				ma.vars[idx].cmd = 0

			endif
			
		next

		if ma.apps[i].cmd

			cdDeleteCmd(ma.apps[i].cmd)
			ma.apps[i].cmd = 0
			
		endif
		
	next

	// Delete sprite cmds for resize.
	for i = 0 to ma.apps[cd.appIdx].sprites.length

		thingIdx = ma.apps[cd.appIdx].sprites[i]

		if ma.things[thingIdx].cmd
			
			cdDeleteCmd(ma.things[thingIdx].cmd)
			ma.things[thingIdx].cmd = 0

		endif

		for j = 0 to ma.things[thingIdx].vars.length

			idx = ma.things[thingIdx].vars[j]
			
			if ma.vars[idx].cmd

				cdDeleteCmd(ma.vars[idx].cmd)
				ma.vars[idx].cmd = 0

			endif
			
		next

		for j = 0 to ma.things[thingIdx].imgs.length

			if ma.things[thingIdx].imgs[j].cmd

				cdDeleteCmd(ma.things[thingIdx].imgs[j].cmd)
				ma.things[thingIdx].imgs[j].cmd = 0

			endif
			
		next
		
		for j = 0 to ma.things[thingIdx].cmds.length

			cmd = ma.things[thingIdx].cmds[j]
			//cdSetCmdScale(cmd, cd.cmdScales[cd.oldCmdSize], cd.cmdScales[ld.set.cmdSize])
			cdSetCmdScale(cmd)
			cdUpdateCmdSize(cmd)
			
		next
		
	next

	// Delete sound cmds for resize.
	for i = 0 to ma.apps[cd.appIdx].sounds.length

		idx = ma.apps[cd.appIdx].sounds[i]

		if ma.sounds[idx].cmd
			
			cdDeleteCmd(ma.sounds[idx].cmd)
			ma.sounds[idx].cmd = 0

		endif

	next

	// Delete video cmds for resize.
	for i = 0 to ma.apps[cd.appIdx].videos.length

		idx = ma.apps[cd.appIdx].videos[i]

		if ma.videos[idx].cmd
			
			cdDeleteCmd(ma.videos[idx].cmd)
			ma.videos[idx].cmd = 0

		endif

	next
	
	// Reposition the sel cmds.
	for i = GRP_BEGIN to GRP_DATA

		cd.qx = getspritex(cd.cmdPanels[i].panel) + co.bs / 8
		cd.qy = getspritey(cd.cmdPanels[i].panel) + co.bs / 8

		for j = 0 to cd.selCmds.length

			cmd = cd.selCmds[j]
			
			if ma.cmds[cmd].grp = i and ma.cmds[cmd].active

				//cdSetCmdScale(cmd, cd.cmdScales[cd.oldCmdSize], cd.cmdScales[ld.set.cmdSize])
				cdSetCmdScale(cmd)
				cdUpdateCmdSize(cmd)				
				cdSetSelCmdPos(cmd)
				cdSetCmdScissor(cmd, cd.cmdPanels[ma.cmds[cmd].grp].vx, cd.cmdPanels[ma.cmds[cmd].grp].vy, cd.cmdPanels[ma.cmds[cmd].grp].vx + cd.cmdPanels[ma.cmds[cmd].grp].vw - 1, cd.cmdPanels[ma.cmds[cmd].grp].vy + cd.cmdPanels[ma.cmds[cmd].grp].vh - 1)
				cd.qy = cd.qy + ma.cmds[cmd].h + CD_CMD_GAP * cd.cmdScales[ld.set.cmdSize]

			endif

		next
		
	next

	cdSetGrpContentSizes()
	
	cd.grpTab = -1
	cdSetGrpVisible(false)
	cd.grpTab = grpTab

	//cd.trimWhite = true
	//cd.tidyCode = true
	cdSetTidyCode(ma.apps[cd.appIdx].id)
	
	cdSetTabVisible("resize", true)
	
endfunction

//-----------------------------------------------------
// Make all things trim and tidy.
//
function cdSetTidyCode(appId as string)

	local i as integer
	local thingIdx as integer
	local appIdx as integer

	appIdx = maFindAppById(appId)

	if appIdx > -1
	
		for i = 0 to ma.apps[appIdx].sprites.length

			thingIdx = ma.apps[appIdx].sprites[i]
			ma.things[thingIdx].trimWhite = true
			//ma.things[thingIdx].tidyCode = true
			
		next

	endif
	
endfunction

//-----------------------------------------------------
// Create a cmd quickly with text based defs.
// Add it to the selCmds list.
//
function cdSetSelCmdPos(cmd as integer)

	cdSetCmdDepth(cmd, GetSpriteDepth(cd.cmdPanels[ma.cmds[cmd].grp].panel) - 2)
	cdSetCmdPos(cmd, cd.qx, cd.qy)
	ma.cmds[cmd].ox = cd.qx - getspritex(cd.cmdPanels[ma.cmds[cmd].grp].panel)
	ma.cmds[cmd].oy = cd.qy - getspritey(cd.cmdPanels[ma.cmds[cmd].grp].panel)

endfunction

//-----------------------------------------------------
// Create a cmd quickly with text based defs.
//
function cdBuildCmdQuick(code as integer, def as string)

	local cmd as integer
	local s as string
	local t as string
	local k as string
	local v as string
	local i as integer
	local count as integer
	local id as integer
	local typ as integer
	
	cmd = cdCreateCmd(code)
	count = CountStringTokens(def, ",")
	t = ""

	for i = 1 to count

		s = GetStringToken(def, ",", i)
		
		if t <> ""
			
			s = t + "," + s
			t = ""
			
		endif
		
		if right(s, 1) = "\" and right(s, 2) <> "\\"
			
			t = trimstring(s, "\")
			continue
			
		endif
		
		k = left(s, 1)
		v = mid(s, 3, -1)
		typ = cdGetPartTypFromQuickCode(k)

		if typ = PART_CMD
			cdAddCmdPart(cmd, cdCreatePartCmd(val(v)))
		else 
			cdAddCmdPart(cmd, cdCreatePart(typ, v))
		endif

	next
		
endfunction cmd

//-----------------------------------------------------
// Create a cmd quickly with text based defs.
// The code is copied from selcmds,
// The def is #:T:v where # = the index of the part, T = type, e.g. N for int
//
function cdBuildCmdQuick2(cmd as integer, def as string)

	//local cmd as integer
	local s as string
	local k as string
	local v as string
	local i as integer
	local count as integer
	local id as integer
	local typ as integer
	local p as integer
	local idx as integer
	local vv as integer
	local cmd2 as integer
	local v2 as string
	
	//cmd = cdCreateCmd(code)
	count = CountStringTokens(def, ",")

	for i = 1 to count

		s = GetStringToken(def, ",", i)
		p = findstring(s, ":")		
		idx = val(mid(s, 1, p - 1))
		s = mid(s, p + 1, -1)
		p = findstring(s, ":")		
		k = mid(s, 1, p - 1)
		s = mid(s, p + 1, -1)
		v = s
		typ = cdGetPartTypFromQuickCode(k)

		if typ = PART_CMD
			
			vv = val(v)
			cmd2 = cd.helpDetails.zcmds[vv]
			cd.helpDetails.zcmds[vv] = 0 // Clear, so we can clear ones that were not used.		
			//cdAddCmdPart(cmd, cdCreatePartCmd(cmd2))
			cdSetCmdPart(cmd, cdCreatePartCmd(cmd2), idx)

		elseif typ = PART_OBJ // named object.
			
			p = findstring(s, ":")
			
			// See if there's a named value.
			if p > 0
					
				v = mid(s, 1, p - 1)
				s = mid(s, p + 1, -1)
				v2 = s
				v2 = ReplaceString(v2, "|", ",", -1)

				//vv = val(cdGetObjVarVals(v, v2, true))
				cdSetCmdPart(cmd, cdCreatePart(typ, v2), idx)
				
			endif
					
		else 
			
			//cdAddCmdPart(cmd, cdCreatePart(typ, v))
			cdSetCmdPart(cmd, cdCreatePart(typ, v), idx)
			
		endif
		
		// Hack. Place the cmd just added above to the idx position, then remove it from the end.
		//cdSetCmdPart(cmd, ma.cmds[cmd].parts[ma.cmds[cmd].parts.length], idx)
		//ma.cmds[cmd].parts.remove(ma.cmds[cmd].parts.length)
		cdUpdateCmdSize(cmd)
		cdSetCmdPos(cmd, ma.cmds[cmd].x, ma.cmds[cmd].y)
		cdSetCmdDepth(cmd, ma.cmds[cmd].depth)

	next
		
endfunction //cmd

//-----------------------------------------------------
// Get the part type from a code.
// i.e.
// A:<vAr>
// B:<Bool>
// C:<Color>
// F:<Float>
// G:sprite idx for agk code.
// H:<tHing> - sprite.
// I:<cmd Id>
// J:<obJect var properies>, i.e. a list of items, e.g. edges.
// K:<Key, 1 to 127>
// L:<List>
// M:<iMage>
// N:<iNteger>
// O:<videO>
// P:<Percentage>
// R:<fRame>
// S:<String>
// T:<Text>
// U:<soUnd>
// V:<Value>
//
function cdGetPartTypFromQuickCode(k as string)

	local ret as integer
	
	if k = "A"
		ret = PART_VAR
	elseif k = "B"
		ret = PART_BOOL
	elseif k = "C"
		ret = PART_COL
	elseif k = "F"
		ret = PART_FLOAT
	elseif k = "G"
		ret = PART_SPRITE_IDX
	elseif k = "H"
		ret = PART_SPRITE
	elseif k = "I"
		ret = PART_CMD
	elseif k = "J"
		ret = PART_OBJ
	elseif k = "L"
		ret = PART_LIST
	elseif k = "M"
		ret = PART_IMG
	elseif k = "N"
		ret = PART_INT
	elseif k = "O"
		ret = PART_VIDEO
	elseif k = "R"
		ret = PART_FRAME
	elseif k = "S"
		ret = PART_STR
	elseif k = "T"
		ret = PART_TXT
	elseif k = "U"
		ret = PART_SOUND
	elseif k = "V"
		ret = PART_VALUE
	elseif k = "X"
		ret = PART_TMP_CREATE
	elseif k = "Y"
		ret = PART_TMP_FIND
	else
		ret = 0
	endif

endfunction ret

//-----------------------------------------------------
// Load a help project from a string.
// Creates a fake app, and loads it with the s.
//
function cdLoadHelpProject(s as string)
	
	local appIdx as integer
	local list as integer[]
	local ret as string
	local lib as string
			
	appIdx = maCreateApp("TMP")
	ma.apps[appIdx].folder = ""	
	ma.apps[appIdx].name = "TMP"
	ma.apps[appIdx].versionNbr = "1.0.0"

	ldDecodeApp(appIdx, s)

	ma.apps[appIdx].status = LD_STATUS_HACK
	ma.apps[appIdx].loaded = true
	ma.apps[appIdx].saved = true

endfunction appIdx

//-----------------------------------------------------
// Hide detailed help.
// In format: <P {project name}[ I]> - The I ignores showing sprites, just the first sprite's code.
//
function cdAppendHelpProject(s as string)

	local appIdx as integer
	local things as integer
	local pos as integer
	local appKey as string
	local thingIdx as integer
	local i as integer
	local j as integer
	local k as integer
	local y0 as integer
	local spr as integer
	local hs as HelpSpr
	local px as float
	local py as float
	local but as Button
	local cmd as integer
	local w as float
	local o as NbrOrder
	local order as NbrOrder[]
	local cmds as integer[]
	local seenRoot as integer
	local thingIdx2 as integer
	local loaded as integer
	local img as Image
	local pre as string
	local v as JsonValue
	
	pre = left(s, 3)
	things = false
	y0 = cd.helpDetails.y
	cd.helpDetails.y0 = y0		
	cd.helpDetails.y = cd.helpDetails.y + CD_CMD_GAP
		
	if pre = "<P " or pre = "<PI" // Full project string.

		if pre = "<P "
			s = mid(s, 4, -1)	
		else 
			s = mid(s, 5, -1)	
		endif
					
		s = TrimString(s, ">")
				
		appKey = s
		appIdx = maFindAppById(appKey)
	
		if appIdx = -1
			exitfunction
		endif
			
		if not ma.apps[appIdx].loaded
			
			ldLoadApp(ma.apps[appIdx].id)
			
			if things
				ldLoadThingImages(appIdx, LD_MODE_THUMB)
			endif
			
			loaded = true
			//cd.helpDetails.apps.insert(appIdx)
			
		endif
					
		for i = 0 to ma.apps[appIdx].sprites.length
	
			thingIdx = ma.apps[appIdx].sprites[i]
	
			if i > 0
				cdBumpHelp(0, co.bs / 2)
			endif
			
			if things
							
				img.id = "I"
				img.img = ma.things[thingIdx].imgs[ma.things[thingIdx].imgIdx].img
				
				if img.img
					img.img = copyimage(img.img, 0, 0, GetImageWidth(img.img), GetImageHeight(img.img))
				endif 
				
				img.thumb = ma.things[thingIdx].imgs[ma.things[thingIdx2].imgIdx].thumb
				
				if img.thumb
					img.thumb = copyimage(img.thumb, 0, 0, GetImageWidth(img.thumb), GetImageHeight(img.thumb))
				endif
	
				thingIdx2 = maCreateThing("S")
				ma.things[thingIdx2].name = ma.things[thingIdx].name
				ma.things[thingIdx2].imgs.insert(img)
				ma.things[thingIdx2].imgIdx = 0
				cd.helpDetails.things.insert(thingIdx2)
	
				cdAppendHelpSprite(thingIdx2)
				
			endif
	
			// Don't want the spr. Still need to handle other sprites.
			cd.helpDetails.cmdIdx = cd.helpDetails.cmds.length + 1
		
			for j = 0 to ma.things[thingIdx].cmds.length
				
				cmd = ma.things[thingIdx].cmds[j]
				
				if j > 0 and ma.cmds[cmd].root
					cd.helpDetails.y = cd.helpDetails.y + CD_CMD_GAP * 6
				endif
				
				cmd = cdCloneCmd(cmd)
				cdAppendHelpCmd(cmd)
				
			next
			
		next
	
		if loaded
	
			ldUnloadThingImages(appIdx, LD_MODE_THUMB || LD_MODE_IMAGE)
			ldUnloadApp(ma.apps[appIdx].id)
			//cd.helpDetails.apps.insert(appIdx)
			
		endif
		
		px = cd.helpPanel.vx
		py = cd.helpPanel.vy
		
		cd.helpDetails.y = cd.helpDetails.y + CD_CMD_GAP
	
		spr = cocreatesprite("helpDetails", co.pixImg)
	
		w = GetSpriteWidth(cd.helpPanel.panel) - co.bs / 2 - co.bs / 4
		
		if cd.helpDetails.x1 - cd.helpDetails.x > w
			w = cd.helpDetails.x1 - cd.helpDetails.x
		endif
			
		SetSpriteScale(spr, w, cd.helpDetails.y - y0)
		SetSpriteDepth(spr, GetSpriteDepth(cd.helpPanel.panel) - 1)
		//coSetSpriteColor(spr, co.grey[4])
		coSetSpriteColor(spr, co.amber[1])
		SetSpriteScissor(spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
		SetSpritePosition(spr, cd.helpPanel.vx + co.bs / 8, y0)
		hs.spr = spr
		hs.ox = getspritex(spr) - px
		hs.oy = getspritey(spr) - py
		cd.helpDetails.sprs.insert(hs)
		cdBumpHelp(0, CD_CMD_GAP)
			
		but = guiCreateButton("open", BUT_BG_NORMAL, "gfx/ProjectIcon.png", co.grey[5])
		guiSetButtonDepth(but, GetSpriteDepth(cd.helpPanel.panel) - 2)
		guiSetButtonPos(but, getspritex(spr) + GetSpriteWidth(spr) - GetSpriteWidth(but.bg) / 2 - co.bs / 8, getspritey(spr) + GetSpriteHeight(but.bg) / 2 + co.bs / 8)
		guiSetButtonScissor(but, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
		guiSetButtonVisible(but, true)
		but.ox = GetSpriteXByOffset(but.bg) - px
		but.oy = GetSpriteYByOffset(but.bg) - py
		but.id = appIdx
		cd.helpDetails.buts.insert(but)
	
		if GetSpriteHeight(spr) < GetSpriteHeight(but.bg) + CD_CMD_GAP * 2
			SetSpriteScale(spr, GetSpriteWidth(spr), GetSpriteHeight(but.bg) + (co.bs / 8) * 2)
		endif
	
	elseif pre = "<Q " or pre = "<QP" or pre = "<QI" // Full project string.
	
		if pre = "<Q "
			s = mid(s, 4, -1)	
		else 
			s = mid(s, 5, -1)	
		endif

		s = TrimString(s, ">")

		if pre = "<QP" or pre = "<QI"
			
			appIdx = cdLoadHelpProject(s)

			if pre = "<QI"
				things = true
			endif
				
			for i = 0 to ma.apps[appIdx].sprites.length
		
				thingIdx = ma.apps[appIdx].sprites[i]
		
				if i > 0
					cdBumpHelp(0, co.bs / 2)
				endif
				
				if things
								
					img.id = "I"
					img.img = ma.things[thingIdx].imgs[ma.things[thingIdx].imgIdx].img
					
					if img.img
						img.img = copyimage(img.img, 0, 0, GetImageWidth(img.img), GetImageHeight(img.img))
					endif 
					
					img.thumb = ma.things[thingIdx].imgs[ma.things[thingIdx2].imgIdx].thumb
					
					if img.thumb
						img.thumb = copyimage(img.thumb, 0, 0, GetImageWidth(img.thumb), GetImageHeight(img.thumb))
					endif
		
					thingIdx2 = maCreateThing("S")
					ma.things[thingIdx2].name = ma.things[thingIdx].name
					ma.things[thingIdx2].imgs.insert(img)
					ma.things[thingIdx2].imgIdx = 0
					cd.helpDetails.things.insert(thingIdx2)
		
					cdAppendHelpSprite(thingIdx2)
					
				endif
		
				// Don't want the spr. Still need to handle other sprites.
				cd.helpDetails.cmdIdx = cd.helpDetails.cmds.length + 1
			
				for j = 0 to ma.things[thingIdx].cmds.length
					
					cmd = ma.things[thingIdx].cmds[j]
					
					if j > 0 and ma.cmds[cmd].root
						cd.helpDetails.y = cd.helpDetails.y + CD_CMD_GAP * 6
					endif
					
					cmd = cdCloneCmd(cmd)
					cdAppendHelpCmd(cmd)
					
				next
				
			next 
			
			ldUnloadThingImages(appIdx, LD_MODE_THUMB || LD_MODE_IMAGE)
			ldUnloadApp(ma.apps[appIdx].id)
					
		else 
			
			v = jsonParse("decApp", s)
			thingIdx = maCreateThing("T")
			ldDecodeCmds(-1, thingIdx, v)
			cd.helpDetails.cmdIdx = cd.helpDetails.cmds.length + 1
	
			for j = 0 to ma.things[thingIdx].cmds.length
				
				cmd = ma.things[thingIdx].cmds[j]
				
				if j > 0 and ma.cmds[cmd].root
					cd.helpDetails.y = cd.helpDetails.y + CD_CMD_GAP * 6
				endif
				
				cmd = cdCloneCmd(cmd)
				cdAppendHelpCmd(cmd)
				
			next
			
			maDeleteThing(thingIdx)
			
		endif
		
		cdAppendHelpCopyCode()
		//cd.helpDetails.buts[cd.helpDetails.buts.length].id = -10 // Hack to make sure id < -1
		if cd.helpDetails.cmdIdx > -1
			cd.helpDetails.buts[cd.helpDetails.buts.length].id = -(cd.helpDetails.cmdIdx + 10) // Hack to make sure id < -1
		endif

	endif
		
endfunction

//-----------------------------------------------------
// Add a background and a copy code button.
//
function cdAppendHelpCopyCode()
	
	local spr as integer
	local w as float
	local hs as HelpSpr
	local px as float
	local py as float
	local but as Button
	local y0 as float
	
	px = cd.helpPanel.vx
	py = cd.helpPanel.vy
	y0 = cd.helpDetails.y0
		
	cd.helpDetails.y = cd.helpDetails.y + CD_CMD_GAP

	spr = cocreatesprite("helpDetails", co.pixImg)

	w = GetSpriteWidth(cd.helpPanel.panel) - co.bs / 2 - co.bs / 4
	
	if cd.helpDetails.x1 - cd.helpDetails.x > w
		w = cd.helpDetails.x1 - cd.helpDetails.x
	endif
		
	SetSpriteScale(spr, w, cd.helpDetails.y - y0)
	SetSpriteDepth(spr, GetSpriteDepth(cd.helpPanel.panel) - 1)
	//coSetSpriteColor(spr, co.grey[4])
	coSetSpriteColor(spr, co.amber[1])
	SetSpriteScissor(spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
	SetSpritePosition(spr, cd.helpPanel.vx + co.bs / 8, y0)
	hs.spr = spr
	hs.ox = getspritex(spr) - px
	hs.oy = getspritey(spr) - py
	cd.helpDetails.sprs.insert(hs)
	cdBumpHelp(0, CD_CMD_GAP)
		
	but = guiCreateButton("copy", BUT_BG_NORMAL, "gfx/CopyIcon.png", co.grey[5])
	guiSetButtonDepth(but, GetSpriteDepth(cd.helpPanel.panel) - 2)
	guiSetButtonPos(but, getspritex(spr) + GetSpriteWidth(spr) - GetSpriteWidth(but.bg) / 2 - co.bs / 8, getspritey(spr) + GetSpriteHeight(but.bg) / 2 + co.bs / 8)
	guiSetButtonScissor(but, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
	guiSetButtonVisible(but, true)
	but.ox = GetSpriteXByOffset(but.bg) - px
	but.oy = GetSpriteYByOffset(but.bg) - py
	but.id = 0
	cd.helpDetails.buts.insert(but)

	if GetSpriteHeight(spr) < GetSpriteHeight(but.bg) + CD_CMD_GAP * 2
		SetSpriteScale(spr, GetSpriteWidth(spr), GetSpriteHeight(but.bg) + (co.bs / 8) * 2)
	endif

endfunction

//-----------------------------------------------------
// Hide detailed help.
//
function cdAppendHelpSprite(thingIdx as integer)

	local cmd as integer
	local px as float
	local py as float
	local part as Part

	px = cd.helpPanel.vx
	py = cd.helpPanel.vy
	
	cmd = cdCreateCmd(CODE_SPRITE_BASE)
	//cdAddCmdPart(cmd, cdCreatePartSprite(thingIdx))
	cdAddCmdPart(cmd, cdCreatePartSprite(ma.things[thingIdx].id))
	part = cdCreatePart(PART_STR, " " + ma.things[thingIdx].name)
	cdAddCmdPart(cmd, part)

	cd.helpDetails.cmds.insert(cmd)
	cdSetCmdDepth(cmd, GetSpriteDepth(cd.helpPanel.panel) - 2)		
	cdSetCmdPos(cmd, cd.helpDetails.x + cd.helpDetails.ind, cd.helpDetails.y)
	ma.cmds[cmd].ox = ma.cmds[cmd].x - px
	ma.cmds[cmd].oy = ma.cmds[cmd].y - py
	//cdSetCmdScissor(cmd, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
	cdSetCmdScissor(cmd, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
	cdSetCmdAlpha(cmd, 255)
	cdSetCmdVisible(cmd, true)

	cdBumpHelp(cdGetCmdWidth(cmd), cdGetCmdHeight(cmd))
	
endfunction

//-----------------------------------------------------
// Hide detailed help.
//
function cdAppendHelpApp(appIdx as integer)

	local cmd as integer
	local px as float
	local py as float
	local part as Part

	px = cd.helpPanel.vx
	py = cd.helpPanel.vy

	cmd = cdCreateCmd(CODE_APP_BASE)
	cdInitPart(part, PART_APP_INFO)
	cdSetPart(part, str(appIdx))
	cdAddCmdPart(cmd, part)

	cd.helpDetails.cmds.insert(cmd)
	cdSetCmdDepth(cmd, GetSpriteDepth(cd.helpPanel.panel) - 2)		
	cdSetCmdPos(cmd, cd.helpDetails.x + cd.helpDetails.ind, cd.helpDetails.y)
	ma.cmds[cmd].ox = ma.cmds[cmd].x - px
	ma.cmds[cmd].oy = ma.cmds[cmd].y - py
	//cdSetCmdScissor(cmd, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
	cdSetCmdScissor(cmd, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
	cdSetCmdAlpha(cmd, 255)
	cdSetCmdVisible(cmd, true)
	
	cdBumpHelp(cdGetCmdWidth(cmd), cdGetCmdHeight(cmd))

endfunction

//-----------------------------------------------------
// Append a cmd to the help output.
//
function cdAppendHelpCmd(cmd as integer)

	local openCmd as integer
	local closeCmd as integer
	local dist as float
	local px as float
	local py as float
	local ind as float

	px = cd.helpPanel.vx
	py = cd.helpPanel.vy
	ind = CD_CODE_INDENT * cd.cmdScales[ld.set.cmdSize]

	if maIsCloseCode(ma.cmds[cmd].code)
		cd.helpDetails.ind = cd.helpDetails.ind - ind
	endif
	
	cd.helpDetails.cmds.insert(cmd)
	cdSetCmdDepth(cmd, GetSpriteDepth(cd.helpPanel.panel) - 1)		
	cdSetCmdPos(cmd, cd.helpDetails.x + cd.helpDetails.ind, cd.helpDetails.y)
	ma.cmds[cmd].ox = ma.cmds[cmd].x - px
	ma.cmds[cmd].oy = ma.cmds[cmd].y - py
	//cdSetCmdScissor(cmd, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
	cdSetCmdScissor(cmd, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh -gui.barSize  - 1)
	cdSetCmdAlpha(cmd, 255)
	//cdUpdateCmdSize(cmd)
	cdSetCmdVisible(cmd, true)
	cdBumpHelp(cdGetCmdWidth(cmd), cdGetCmdHeight(cmd)) // CD_CMD_GAP is added inside.

	if maIsCloseCode(ma.cmds[cmd].code)
		
		openCmd = cdPopHelpCmd()
		closeCmd = cmd
		dist = (ma.cmds[closeCmd].y + ma.cmds[closeCmd].h / 2) - (ma.cmds[openCmd].y + ma.cmds[openCmd].h / 2)
		cdSetCmdEdge(openCmd, dist)			
		cdSetCmdDepth(openCmd, GetSpriteDepth(cd.helpPanel.panel) - 1)		
		//cdSetCmdScissor(openCmd, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
		cdSetCmdScissor(openCmd, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
		//cdUpdateCmdSize(openCmd)
		cdSetCmdPos(openCmd, ma.cmds[openCmd].x, ma.cmds[openCmd].y)

	elseif maIsOpenCode(ma.cmds[cmd].code)

		cdPushHelpCmd(cmd)
		cd.helpDetails.ind = cd.helpDetails.ind + ind
		
	endif
	
endfunction

//-----------------------------------------------------
// Append a help cmd to the help output.
//
function cdAppendHelpLine(s as string)

	local text as integer
	local px as float
	local py as float
	local ht as HelpText
	local tok as string 
	local count as integer
	local i as integer
	local x as float
	local c as string
	local pos as integer
	local w as float
	local ww as float
	local spr as integer
	local h as float
	local hh as float
	local idx as integer
	local pre as string
	local p1 as integer
	local p2 as integer
	local cmd as integer
	local cmd2 as integer
	local code as integer
	local def as string
	local thingIdx as integer
	local selIdx as integer
	local img as Image
	local nbrIdx as integer
	local nbrS as string 
	local nbrW as integer
	local maxW as float
	local retry as integer
	local cw as float
	local wrap as integer
	local typ as integer
	local y0 as float
	local bump as integer
	local j as integer
	local var as integer
	
	px = cd.helpPanel.vx
	py = cd.helpPanel.vy	
	x = cd.helpDetails.x
	w = 0
	h = 0
	hh = 0
	ww = 0
	maxW = GetSpriteWidth(cd.helpPanel.panel) - co.bs / 2
	wrap = false
	typ = 0

	while s <> ""

		bump = true
		
		if wrap
			s = TrimString(s, " ")
		endif
		
		p1 = findstring(s, "<")

		// Skip \<, printable <
		if p1 > 1
			while p1 > 1 and mid(s, p1 - 1, 1) = "\"
				p1 = findstring(s, "<", false, p1 + 1)
			endwhile
		endif
		
		if p1 > 0 // Found a <

			if p1 > 1 // Something before <, need to process first.
				
				tok = mid(s, 1, p1 - 1)
				s = mid(s, p1, -1)

			else // p1 = 1, < at the start.
				
				p2 = FindString(s, ">", false, p1 + 1)

				// Skip \>, printable >
				if p2 > 1
					while p2 > 1 and mid(s, p2 - 1, 1) = "\"
						p2 = FindString(s, ">", false, p2 + 1)
					endwhile
				endif

				// <F 2><H 1>...
				// p1 = 1, p2 = 5
				
				if p2 > 0

					tok = mid(s, p1, p2 - p1 + 1)
					s = mid(s, p2 + 1, -1)

				else // No closing, grab the rest.

					tok = mid(s, p1, -1)
					s = ""
					
				endif
				
			endif
			
		else
			
			tok = s
			s = ""
			
		endif

		if left(tok, 2) = "<#"

			tok = mid(tok, 3, -1)
			tok = TrimString(tok, ">")
			nbrIdx = 0 // Nbr index.
			i = 1

			// See if we have anymore hashes.
			while i <= len(tok) and mid(tok, i, 1) = "#"
				
				inc nbrIdx
				inc i
				
			endwhile

			if nbrIdx <= cd.helpDetails.nbrs.length
				
				cd.helpDetails.nbrs[nbrIdx] = cd.helpDetails.nbrs[nbrIdx] + 1

				if nbrIdx + 1 <= cd.helpDetails.nbrs.length

					for i = nbrIdx + 1 to cd.helpDetails.nbrs.length
						cd.helpDetails.nbrs[i] = 0
					next

				endif
					
				tok = "" // Now filling it with a nbr.
				
				for i = 0 to nbrIdx

					if i > 0
						tok = tok + "."
					endif

					tok = tok + str(cd.helpDetails.nbrs[i])

				next
				
			else // Only 4 levels allowed.

				tok = ""
				
			endif
			
		endif

		pre = left(tok, 3)
		
		if pre = "<P " or pre = "<PI" or pre = "<Q " or pre = "<QP" or pre = "<QI" // Load project.

			cdAppendHelpProject(tok)

		elseif pre = "<M>" // Mark a cmd block.

			cd.helpDetails.y0 = cd.helpDetails.y
			cd.helpDetails.y = cd.helpDetails.y + CD_CMD_GAP
			cd.helpDetails.cmdIdx = cd.helpDetails.cmds.length + 1

		elseif pre = "</M" // End cmd mark.

			cdAppendHelpCopyCode()
			
			if cd.helpDetails.cmdIdx > -1
				cd.helpDetails.buts[cd.helpDetails.buts.length].id = -(cd.helpDetails.cmdIdx + 10) // Hack to make sure id < -1
			endif

			x = 0
			w = 0
			hh = 0 // -CD_CMD_GAP
			
		elseif pre = "<ZV" // Create a var cmd.
		
			var = maCreateVar(VAR_TYPE_VALUE)
			tok = mid(tok, 5, -1)
			tok = TrimString(tok, ">")

			ma.vars[var].name = tok
			cd.helpDetails.vars.insert(var)
			cmd2 = cdCreateVarCmd(var)
			cd.helpDetails.zcmds.insert(cmd2) // Save this z cmd for a later real cmd.
			bump = false
			
		elseif pre = "<C " or pre = "<ZC" // C = Clone a cmd, ZC = clone but park for use in a later cmd.

			if pre = "<C "
				tok = mid(tok, 4, -1)
			else 
				tok = mid(tok, 5, -1)
			endif
				
			tok = TrimString(tok, ">")
			p1 = FindString(tok, " ")
			p2 = FindString(tok, "_")

			if p1 > 0 // space
				
				code = coHexToInt(mid(tok, 1, p1 - 1))
				def = mid(tok, p1 + 1, -1)
				cmd2 = cdBuildCmdQuick(code, def)

			elseif p2 > 0 // _
				
				code = coHexToInt(mid(tok, 1, p2 - 1))
				def = mid(tok, p2 + 1, -1)
				
				selIdx = cdFindSelCmdIdx(code)
				
				if selIdx > -1
					
					cmd2 = cdCloneCmd(cd.selCmds[selIdx])
					cdBuildCmdQuick2(cmd2, def)
					
				endif

			else

				code = coHexToInt(tok)
				selIdx = cdFindSelCmdIdx(code)
				
				if selIdx > -1
					cmd2 = cdCloneCmd(cd.selCmds[selIdx])
				endif

			endif

			if pre = "<C "
				
				cdAppendHelpCmd(cmd2)
				
				for j = 0 to cd.helpDetails.zcmds.length
					if cd.helpDetails.zcmds[j]
						colog("zcmds[" + str(j) + "] was not used")
					endif
				next
					
				cdDeleteCmds(cd.helpDetails.zcmds) // Clear up zcmds, just in they weren't all used.
				cd.helpDetails.zcmds.length = -1 // Dont need zcmds, all used up.

			else // <Z
				
				cd.helpDetails.zcmds.insert(cmd2) // Save this z cmd for a later real cmd.
				bump = false
				
			endif
	
			x = 0
			w = 0
			hh = -CD_CMD_GAP
	
		elseif pre = "<S " or pre = "<ZS" // Explict creation of a sprite and command.
			
			if pre = "<S "
				tok = mid(tok, 4, -1)
			else 
				tok = mid(tok, 5, -1)
			endif

			tok = TrimString(tok, ">")
			img.id = "I"							
			img.img = loadimage(tok)
			img.thumb = loadimage(tok)
			thingIdx = maCreateThing("S")
			ma.things[thingIdx].imgs.insert(img)
			ma.things[thingIdx].imgIdx = 0
			cd.helpDetails.things.insert(thingIdx)

			if pre = "<S "
				
				cdAppendHelpSprite(thingIdx)
				
			else 
				
				cmd2 = cdCreateCmd(CODE_SPRITE_PART)
				//cdAddCmdPart(cmd2, cdCreatePartSprite(thingIdx))
				cdAddCmdPart(cmd2, cdCreatePartSprite(ma.things[thingIdx].id))
				cd.helpDetails.zcmds.insert(cmd2) // Save this z cmd for a later real cmd.
				bump = false

			endif
			
			x = 0
			w = 0
			hh = 0
					
		elseif pre = "<G "
			
			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")
			spr = LoadSprite(tok)
				
			SetSpriteDepth(spr, GetSpriteDepth(cd.helpPanel.panel) - 2)
			SetSpriteScissor(spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
			SetSpritePosition(spr, x, cd.HelpDetails.y)
			SetSpriteVisible(spr, true)

			ht.ox = getspritex(spr) - px
			ht.oy = getspritey(spr) - py
			ht.text = 0
			ht.spr = spr	
			cd.helpDetails.texts.insert(ht)

			ww = GetSpriteWidth(spr)
			x = x + ww
			w = w + ww
			h = GetSpriteHeight(spr)
			if h > hh then hh = h
			
		elseif pre = "<I "

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")
			spr = coCreateSprite("<I", val(tok))
			
			SetSpriteDepth(spr, GetSpriteDepth(cd.helpPanel.panel) - 2)
			//SetSpriteScissor(spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
			setSpriteScissor(spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
			SetSpritePosition(spr, x, cd.HelpDetails.y)
			SetSpriteVisible(spr, true)

			ht.ox = getspritex(spr) - px
			ht.oy = getspritey(spr) - py
			ht.text = 0
			ht.spr = spr	
			cd.helpDetails.texts.insert(ht)

			ww = GetSpriteWidth(spr)
			x = x + ww
			w = w + ww
			h = GetSpriteHeight(spr)
			if h > hh then hh = h

		elseif pre = "<B>"
			
			//if cd.helpDetails.bold
			//	cd.helpDetails.bold = false
			//else
				cd.helpDetails.bold = true
			//endif

		elseif pre = "</B"
			
			//if cd.helpDetails.bold
				cd.helpDetails.bold = false
			//else
			//	cd.helpDetails.bold = true
			//endif
			
		elseif pre = "<H "

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")

			typ = CD_HELP_MAIN
			idx = val(tok)
			s = "<F +><B>" + cdAppendHelpPageName(idx) + "</B><F ->" + s
			
		elseif pre = "<L "

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")

			typ = CD_HELP_MAIN
			idx = val(tok)
			s = cdAppendHelpPageLink(idx) + s

		elseif pre = "<A "

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")
			cd.helpDetails.under = true // Hyperlink the next token.
			cd.helpDetails.interactive = false

			if tok = ":"
				
				idx = 999
				
			else
				
				typ = CD_HELP_MAIN
				idx = val(tok)
						
			endif

		elseif pre = "<K "

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")
			cd.helpDetails.under = true // Hyperlink the next token.
			cd.helpDetails.interactive = false

			if tok = ":"
				
				idx = 999
				
			else
							
				typ = CD_HELP_CMD
				idx = val(tok)
					
			endif
			
		elseif pre = "<N "

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")
			cd.helpDetails.under = true // Hyperlink the next token.
			cd.helpDetails.interactive = true
				
			typ = CD_HELP_INTER
			idx = val(tok)

		elseif pre = "</A" or pre = "</K" or pre = "</N"

			tok = mid(tok, 3, -1)
			tok = TrimString(tok, ">")

			if tok = "A" or tok = "K" or tok = "N"
				
				cd.helpDetails.under = false
				cd.helpDetails.interactive = false
				idx = 0

			endif

		elseif pre = "<X "
			
			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")

			if left(tok, 1) = "+"
				
				ww = val(mid(tok, 2, -1))
				x = x + ww
				w = w + ww
				
			else
				
				ww = val(tok)

				if cd.HelpDetails.x + ww > x
					w = w + (cd.helpDetails.x + ww - x)
				endif
					
				x = cd.helpDetails.x + ww
				
			endif

		elseif pre = "<Y "
			
			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")

			if left(tok, 1) = "+"
				cd.HelpDetails.y = cd.HelpDetails.y + val(mid(tok, 2, -1))							
			elseif left(tok, 1) = "-"
				cd.HelpDetails.y = cd.HelpDetails.y - val(mid(tok, 2, -1))							
			endif
			
		elseif pre = "<F "

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")

			if tok = "+"
				cd.helpDetails.fontSizeIdx = cd.helpDetails.fontSizeIdx + 1
			elseif tok = "-"			
				cd.helpDetails.fontSizeIdx = cd.helpDetails.fontSizeIdx - 1
			else
				if len(tok) = 1 and findstring("0123456789", tok) > 0		
					cd.helpDetails.fontSizeIdx = val(tok)
				endif
			endif

			if cd.helpDetails.fontSizeIdx < 0
				cd.helpDetails.fontSizeIdx = 0
			elseif cd.helpDetails.fontSizeIdx >= LD_HELP_SIZE_MAX
				cd.helpDetails.fontSizeIdx = LD_HELP_SIZE_MAX
			endif

		elseif pre = "<F>"

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")

			if tok = "F"
				cd.helpDetails.fontSizeIdx = ld.set.helpSize //+ 1 // CD_DEF_HELP_FONT
			endif

		elseif pre = "<*>"

			tok = mid(tok, 4, -1)
			tok = TrimString(tok, ">")
			spr = coCreateSprite("<*>", cd.HelpDetails.circImg)

			SetSpriteScale(spr, 0.1, 0.1)
			coSetSpriteColor(spr, co.black)
			SetSpriteDepth(spr, GetSpriteDepth(cd.helpPanel.panel) - 2)
			//SetSpriteScissor(spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
			setspriteScissor(spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
			SetSpritePosition(spr, x, cd.HelpDetails.y + cd.helpDetails.gaps[cd.helpDetails.fontSizeIdx] / 2 - GetSpriteHeight(spr) / 2)
			SetSpriteVisible(spr, true)

			ht.ox = getspritex(spr) - px
			ht.oy = getspritey(spr) - py
			ht.text = 0
			ht.spr = spr	
			cd.helpDetails.texts.insert(ht)

			ww = GetspriteWidth(spr)
			x = x + ww
			w = w + ww
			h = GetSpriteHeight(spr)
			if h > hh then hh = h
			
		elseif pre = "<T>" // Trail index.

			inc cd.helpDetails.trailIdx
			ht.trailIdx = cd.helpDetails.trailIdx

		elseif tok <> ""

			tok = ReplaceString(tok, "\<", "<", -1)
			tok = ReplaceString(tok, "\>", ">", -1)

			text = guiCreateText(tok, cd.helpDetails.fontSizeIdx)
			coSetTextColor(text, co.black)				
			//SetTextMaxWidth(text, maxW)
			SetTextDepth(text, GetSpriteDepth(cd.helpPanel.panel) - 2)
			//SetTextScissor(text, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
			SetTextScissor(text, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
			SetTextPosition(text, x, cd.helpDetails.y)
			SetTextBold(text, cd.helpDetails.bold)
			SetTextVisible(text, true)
			ht.ox = gettextx(text) - px
			ht.oy = gettexty(text) - py
			ht.text = text
			ht.spr = 0

			retry = 3 // Set to 3, so dec retry below can be used to debug 3 tries and stop hang.
			wrap = false
			
			while retry

				ww = GetTextTotalWidth(text)

				if w + ww > maxW

					tok = gettextstring(text)					

					// Find break point based on pixels and chars.
					cw = (ww / len(tok)) // Figure out how wide a char is on average.
					p1 = len(tok) - (((w + ww) - maxW) / cw) // Convert pix width to chars.					
					p2 = p1 - 1 // Save last char pos just if we hit 0 on backtrack.

//colog("tok=" + tok)
//colog("p1=" + str(p1) + ", p2=" + str(p2))

					if p1 > 0
												
						c = mid(tok, p1, 1)
	
						// Track back until a space or > is found.
						while p1 > 0 and c <> " " and c <> ">"
	
							dec p1
							
							if p1 > 0
								c = mid(tok, p1, 1)
							else 
								c = ""
							endif
	
						endwhile
						
					endif

					if p1 <= 0
						
						p1 = p2 // No spaces or >, break at maxW.
						c = ""
						
					endif
					
					if p1 <= 0
						p1 = 1
					endif

					// Park the remainder in s, for the next loop.
					if c = " "						
						//s = mid(tok, p1 + 1, -1) + s // Skip the space.
						s = mid(tok, p1, -1) + s // Skip the space.
					else
						s = mid(tok, p1, -1) + s
					endif

					// Reset tok for another try.
					tok = mid(tok, 1, p1 - 1)

					SetTextString(text, tok)
					wrap = true
					
				else

					retry = 0
					
				endif

			endwhile
			
			w = w + ww
			h = GetTextTotalHeight(text)
			if h - 4 > hh then hh = h //- 4

			if cd.helpDetails.under

				ht.typ = typ
				ht.idx = idx
				ht.spr = guiCreateBox("", ww, h)
				
				if cd.helpDetails.interactive
					
					coSetSpriteColor(ht.spr, co.green[3])
					ht.idx = -ht.idx
					
				else 
					
					coSetSpriteColor(ht.spr, co.blue[3])
					
				endif
				
				SetSpriteDepth(ht.spr, GetSpriteDepth(cd.helpPanel.panel) - 1)
				//SetSpriteScissor(ht.spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - 1, cd.helpPanel.vy + cd.helpPanel.vh - 1)
				SetSpriteScissor(ht.spr, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpPanel.vx + cd.helpPanel.vw - gui.barSize - 1, cd.helpPanel.vy + cd.helpPanel.vh - gui.barSize - 1)
				SetSpritePosition(ht.spr, x, cd.HelpDetails.y)
				SetSpriteVisible(ht.spr, true)
				
			endif

			if wrap
				
				x = cd.helpDetails.x
				w = 0
				cdBumpHelp(w, hh)
				
			else
				
				x = x + ww
				
			endif

			cd.helpDetails.texts.insert(ht)

		endif
		
	endwhile

	if bump
		cdBumpHelp(w, hh)
	endif
		
endfunction

//-----------------------------------------------------
// Hide detailed help.
//
function cdSetDetailedHelpVisible(vis as integer)

	local i as integer
	
	for i = 0 to cd.helpDetails.cmds.length
		cdSetCmdVisible(cd.helpDetails.cmds[i], vis)
	next

	for i = 0 to cd.helpDetails.texts.length
		
		if cd.HelpDetails.texts[i].text
			SetTextVisible(cd.helpDetails.texts[i].text, vis)
		endif

		if cd.HelpDetails.texts[i].spr
			SetSpriteVisible(cd.helpDetails.texts[i].spr, vis)
		endif
		
	next

	for i = 0 to cd.helpDetails.things.length
		//if ma.things[cd.helpDetails.things[i]].obj
		//	SetSpriteVisible(ma.things[cd.helpDetails.things[i]].obj, vis)
		//endif

		if ma.things[cd.helpDetails.things[i]].cmd
			cdSetCmdVisible(ma.things[cd.helpDetails.things[i]].cmd, vis)
		endif
		
	next

	for i = 0 to cd.helpDetails.sprs.length
		SetSpriteVisible(cd.helpDetails.sprs[i].spr, vis)
	next

	for i = 0 to cd.helpDetails.vars.length
		//cdDeleteVar(cd.helpDetails.vars[i])
		if ma.vars[cd.helpDetails.vars[i]].cmd
			cdSetCmdVisible(ma.vars[cd.helpDetails.vars[i]].cmd, vis)
		endif
	next

	for i = 0 to cd.helpDetails.buts.length
		guiSetButtonVisible(cd.helpDetails.buts[i], vis)
	next
	
	//cdSetAllAlpha(255)
	guiSetPanelVisible(cd.helpPanel, vis)
	//SetSpriteVisible(cd.closeBut, false)
	
endfunction

//-----------------------------------------------------
// Clear the detailed help.
//
function cdClearDetailedHelp(preserveTrail as integer)

	local i as integer
	
	for i = 0 to cd.helpDetails.cmds.length
		cdDeleteCmd(cd.helpDetails.cmds[i])
	next

	cd.helpDetails.cmds.length = -1
	cd.helpDetails.cmdIdx = -1
	cd.helpDetails.zcmds.length = -1 // Don't need to delete these, they are part of another cmd.

	for i = 0 to cd.helpDetails.texts.length
		
		if cd.HelpDetails.texts[i].text
			DeleteText(cd.helpDetails.texts[i].text)
		endif

		if cd.HelpDetails.texts[i].spr
			DeleteSprite(cd.helpDetails.texts[i].spr)
		endif
		
	next

	cd.helpDetails.texts.length = -1

	for i = 0 to cd.helpDetails.things.length
		cdDeleteSprite(cd.helpDetails.things[i])
	next

	cd.helpDetails.things.length = -1

	for i = 0 to cd.helpDetails.sprs.length
		DeleteSprite(cd.helpDetails.sprs[i].spr)
	next

	cd.helpDetails.sprs.length = -1

	for i = 0 to cd.helpDetails.vars.length
		cdDeleteVar(cd.helpDetails.vars[i])
	next

	cd.helpDetails.vars.length = -1

	for i = 0 to cd.helpDetails.buts.length
		guiDeleteButton(cd.helpDetails.buts[i])
	next

	cd.helpDetails.buts.length = -1

	//for i = 0 to cd.helpDetails.apps.length
	//	if not ma.apps[cd.helpDetails.apps[i]].cmd
	//		cdDeleteApp(cd.helpDetails.apps[i])
	//	endif
	//next

	//cd.helpDetails.apps.length = -1
	cd.helpDetails.stack.length = -1

	cd.helpDetails.ind = 0
	cd.helpDetails.x = 0
	cd.helpDetails.y = 0
	cd.helpDetails.x1 = 0
	cd.helpDetails.y1 = 0
	cd.helpDetails.y0 = 0
	cd.helpDetails.cmdIdx = -1
	
	if not preserveTrail
		cd.helpDetails.trail.length = -1
	endif

	guiSetPanelVisible(cd.helpPanel, false)
		
endfunction

//-----------------------------------------------------
// Bump the help position.
//
function cdBumpHelp(w as float, h as float)

	//if cd.helpDetails.x + w > cd.helpDetails.x1 then cd.helpDetails.x1 = cd.helpDetails.x + w
	if cd.helpDetails.ind + cd.helpDetails.x + w + CD_CMD_GAP > cd.helpDetails.x1 then cd.helpDetails.x1 = cd.helpDetails.ind + cd.helpDetails.x + w + CD_CMD_GAP
	cd.helpDetails.y = cd.helpDetails.y + h
	cd.helpDetails.y = cd.helpDetails.y + CD_CMD_GAP
	cd.helpDetails.y1 = cd.helpDetails.y

endfunction

//-----------------------------------------------------
// Bump the help position.
//
function cdUpdateHelp()

	cdShowDetailedHelp(cd.helpDetails.currMode, cd.helpDetails.currIdx)
	
endfunction

//-----------------------------------------------------
// Run the next inter task until it hits the end, or user cancels.
//
function cdRunInterHelp(hd ref as HelpData)
	
	local taskIdx as integer
	local idx as integer
	local appIdx as integer
	local ret as integer
	local spr as integer
	local switch as integer
	local selIdx as integer
	local i as integer
	local code as integer
	local cmdIdx as integer
	local selCmdIdx as integer
	local grp as integer
	local selCode as integer
	local partIdx as integer
	local cmd as integer
	local tmp as integer
	local pcount as integer
	local thingIdx as integer
	
	taskIdx = hd.taskIdx // cd.helpInter.taskIdx // Restart, make sure all actions are taken.
	switch = 0
	ret = false
	pcount = 0
		
	if ma.helpInter.tasks[taskIdx].act = MA_HELP_ACT_CHECK
			
		thingIdx = -1
		
		if ma.apps[cd.appIdx].sprites.length > -1			
			thingIdx = ma.apps[cd.appIdx].sprites[0]			
		endif
		
		if thingIdx > -1
				
			//ret = true
						
		else

			switch = ma.helpInter.tasks[taskIdx].switch					
			ret = true
				
		endif
							
	elseif ma.helpInter.tasks[taskIdx].act = MA_HELP_ACT_PRESS
		
		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_PROJECTS_TAB
			if cd.mainTab <> CD_TAB_APP
				
				maSetHelpPress(taskIdx, cd.appBut.bg, "Press the 'projects' tab", DIR_E || DIR_S, 0, 0)					
				ret = true
				
			endif
		endif

		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_THINGS_TAB
			if cd.mainTab <> CD_TAB_THING
				
				if guiGetButtonActive(cd.thingBut)
					maSetHelpPress(taskIdx, cd.thingBut.bg, "Press the 'things' tab", DIR_E || DIR_S, 0, 0)	
				else
					switch = ma.helpInter.tasks[taskIdx].switch
				endif
								
				ret = true
				
			endif
		endif

		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_THINGS_TAB_INACTIVE
			if cd.mainTab <> CD_TAB_THING
				
				maSetHelpPress(taskIdx, cd.thingBut.bg, "The 'things' tab is not active.\nTry opening a project", DIR_E || DIR_S, 0, 0)										
				ret = true
				
			endif
		endif
	
		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_LIBRARY_TAB
			if cd.fileTab <> CD_FILE_TAB_LIBRARY
				
				maSetHelpPress(taskIdx, cd.libraryBut.bg, "Press the 'library' tab", DIR_E || DIR_S, 0, 0)			
				ret = true
			
			endif
		endif

		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_COMMANDS_TAB
			if cd.mainTab <> CD_TAB_CMD
				
				if guiGetButtonActive(cd.cmdBut)
					maSetHelpPress(taskIdx, cd.cmdBut.bg, "Press the 'commands' tab", DIR_E || DIR_S, 0, 0)			
				else 
					switch = ma.helpInter.tasks[taskIdx].switch						
				endif
				
				ret = true
			
			endif
		endif

		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_COMMANDS_TAB_INACTIVE
			if cd.mainTab <> CD_TAB_CMD
				
				maSetHelpPress(taskIdx, cd.thingBut.bg, "The 'commands' tab is not active.\nTry adding a sprite", DIR_E || DIR_S, 0, 0)										
				ret = true
				
			endif
		endif

		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_CODE_TAB
			if cd.fileTab <> CD_FILE_TAB_CODE
				
				if guiGetButtonActive(cd.codeBut)
					maSetHelpPress(taskIdx, cd.codeBut.bg, "Press the 'code' tab", DIR_E || DIR_S, 0, 0)			
				else 
					switch = ma.helpInter.tasks[taskIdx].switch						
				endif
				
				ret = true
			
			endif
		endif

		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_MY_PROJECTS_FOLDER
			if ld.libitems.length > 0
				if ld.libitems[1].name = CD_FOLDER_MY_PROJECTS and gettextstring(ld.libitems[1].text2) <> "parent folder"
					
					maSetHelpPress(taskIdx, ld.libitems[1].bg, "Press the \n'" + CD_FOLDER_MY_PROJECTS + "' folder", DIR_E || DIR_S, 0, 0)
					ret = true
				
				endif
			endif
		endif

		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_CODE_CMD_PART

			selIdx = cdFindSelCmdIdx(ma.helpInter.tasks[taskIdx].idx)
			
			if selIdx > -1
				
				selCmdIdx = cd.selCmds[selIdx]
				code = ma.cmds[selCmdIdx].code										
				cmdIdx = -1 // Checking to see if we have this cmd already.
			 
				for i = 0 to ma.things[cd.thingIdx].cmds.length							
					if ma.cmds[ma.things[cd.thingIdx].cmds[i]].code = code
						cmdIdx = ma.things[cd.thingIdx].cmds[i]
						exit
					endif
				next 
				
				if cmdIdx > -1 and cd.mode <> CD_MODE_EDIT_PART
					
					idx = ma.helpInter.tasks[taskIdx].switch
					maSetHelpPress(taskIdx, ma.cmds[cmdIdx].parts[idx].spr, "Press here to edit.", DIR_E || DIR_S, 0, 0)			
					ret = true
					
				endif
					
			endif
						
		endif								

		if not ret and ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_PROJECT_OPEN
			if cd.mainTab = CD_TAB_APP
				
				appIdx = -1
				
				for i = 0 to ma.apps.length
					if ma.apps[i].loaded && not (ma.apps[i].status && LD_STATUS_LIBRARY)
						appIdx = i
						exit
					endif
				next 
				
				if appIdx > -1
					
					maSetHelpPress(taskIdx, ma.cmds[ma.apps[i].cmd].parts[0].spr, "Press and hold for 'rename' button", DIR_E || DIR_S, 0, 0)					
					ret = true
					
				elseif cd.fileTab = CD_FILE_TAB_HELP

					idx = ma.helpInter.tasks[taskIdx].switch
					
					for i = 0 to cd.helpDetails.texts.length
		
						if cd.helpDetails.texts[i].text and cd.helpDetails.texts[i].spr
		
							if cd.helpDetails.texts[i].idx = idx
								
								maSetHelpPress(taskIdx, cd.helpDetails.texts[i].spr, "Open a project first", DIR_E || DIR_EE || DIR_S, 0, 0)					
								ret = true
								exit
								
							endif
							
						endif
		
					next
										
				endif
				
			endif
		endif

	elseif ma.helpInter.tasks[taskIdx].act = MA_HELP_ACT_DRAG
		
		if ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_PROJECT_LIBRARY_ITEM
			
			if ma.helpInter.tasks[taskIdx].idx = 0
				
				if cd.mode <> CD_MODE_DRAG_ITEM and cd.mode <> CD_MODE_PROJ_BLANK_ITEM_BAR
					
					if ma.helpInter.howTo = MA_HOWTO_CREATE_PROJECT2
						maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "No project to open, try a new one.\nPress or drag or press and hold for popup, press 'Add' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, cd.appPanel.panel)
					else
						maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "Press or drag or press and hold for popup, press 'Add' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, cd.appPanel.panel)
					endif
					
					ret = true
					
				endif
				
			elseif ma.helpInter.tasks[taskIdx].idx >= 2
				
				//if ma.mode <> CD_MODE_DRAG_ITEM and ma.mode <> CD_MODE_PROJ_ITEM_BAR
					
					idx = ma.helpInter.tasks[taskIdx].idx
					tmp = false
					spr = 0
					
					while ld.libItems.length >= idx

						if not spr
							if ld.libitems[1].name <> CD_FOLDER_MY_PROJECTS
								exit
							elseif gettextstring(ld.libitems[1].text2) = "parent folder"
								spr = ld.libitems[1].bg
							endif
						endif
						
						if idx >= ma.helpInter.tasks[taskIdx].idx
								
							appIdx = maFindAppById(ld.libitems[idx].id)
							
							if appIdx > -1
								if not ma.apps[appidx].loaded
									
									maSetHelpPress(taskIdx, ld.libItems[idx].bg, "Drag or press and hold for 'open' button.", DIR_E || DIR_S, ld.libItems[idx].bg, cd.appPanel.panel)
									tmp = true
									exit
									
								endif
							endif
							
						endif
						
						inc idx
						
					endwhile
					
					if tmp
						ret = true
					elseif spr
						switch = ma.helpInter.tasks[taskIdx].switch
					endif
					
				//endif
				
			endif
			
		elseif ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_SPRITE_LIBRARY_ITEM or ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_SPRITE_LIBRARY_ITEM2
			
			if ma.helpInter.tasks[taskIdx].idx = 0

				if ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_SPRITE_LIBRARY_ITEM2
	
					thingIdx = -1
					
					if ma.apps[cd.appIdx].sprites.length > -1						
						thingIdx = ma.apps[cd.appIdx].sprites[0]						
					endif
					
					if thingIdx > -1
						
						if ma.cmds[ma.things[thingIdx].cmd].folded

							if cd.mode <> CD_MODE_DRAG_ITEM and cd.mode <> CD_MODE_IMAGE_BLANK_ITEM_BAR

								maSetHelpPress(taskIdx, ma.cmds[ma.things[thingIdx].cmd].fold, "Press the arrow to show frames.", DIR_E, 0, 0)
								ret = true

							endif
														
						else 
							
							if cd.mode <> CD_MODE_DRAG_ITEM and cd.mode <> CD_MODE_IMAGE_BLANK_ITEM_BAR
														
								//if ma.helpInter.howTo = MA_HOWTO_CREATE_SPRITE2
								//	maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "No images, try a new one.\nPress or drag or press and hold for 'frame' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, ma.cmds[ma.things[thingIdx].cmd].parts[0].spr)
								//else
									maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "Drag and snap above or below this frame, or press and hold for 'frame' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, ma.cmds[ma.things[thingIdx].imgs[0].cmd].rt)
								//endif
								
								ret = true
								
							endif
							
						endif
						
					endif
															
				else 
										
					if cd.mode <> CD_MODE_DRAG_ITEM and cd.mode <> CD_MODE_IMAGE_BLANK_ITEM_BAR
												
						if ma.helpInter.howTo = MA_HOWTO_CREATE_SPRITE2
							maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "No images, try a new one.\nPress or drag or press and hold for 'sprite' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, cd.cmdPanels[GRP_SPRITE].panel)
						else
							maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "Press or drag or press and hold for 'sprite' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, cd.cmdPanels[GRP_SPRITE].panel)
						endif
						
						ret = true
						
					endif
					
				endif

			else // if ma.helpInter.tasks[taskIdx].idx >= 0
				
				if ld.libItems.length > 0 // Need new plus 1 sprite.
					
					if ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_SPRITE_LIBRARY_ITEM2
		
						thingIdx = -1
						
						if ma.apps[cd.appIdx].sprites.length > -1							
							thingIdx = ma.apps[cd.appIdx].sprites[0]							
						endif
						
						if thingIdx > -1
						
							if ma.cmds[ma.things[thingIdx].cmd].folded
	
								if cd.mode <> CD_MODE_DRAG_ITEM and cd.mode <> CD_MODE_IMAGE_BLANK_ITEM_BAR
	
									maSetHelpPress(taskIdx, ma.cmds[ma.things[thingIdx].cmd].fold, "Press the arrow to show frames.", DIR_E, 0, 0)
									ret = true
	
								endif
								
							else

								if cd.mode <> CD_MODE_DRAG_ITEM and cd.mode <> CD_MODE_IMAGE_ITEM_BAR
		
									if ma.helpInter.howTo = MA_HOWTO_CREATE_SPRITE2
										maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "No images, try a new one.\nPress or drag or press and hold for 'frame' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, ma.cmds[ma.things[thingIdx].cmd].parts[0].spr)
									else
										maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "Press or drag or press and hold for 'frame' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, ma.cmds[ma.things[thingIdx].cmd].parts[0].spr)
									endif
													
								endif
								
							endif
							
						endif
						
					else

						if cd.mode <> CD_MODE_DRAG_ITEM and cd.mode <> CD_MODE_IMAGE_ITEM_BAR
													
							maSetHelpPress(taskIdx, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, "Drag or press and hold for 'sprite' button.", DIR_E || DIR_S, ld.libItems[ma.helpInter.tasks[taskIdx].idx].bg, cd.cmdPanels[GRP_SPRITE].panel)					
							ret = true
								
						endif
						
					endif
					
				else

					switch = ma.helpInter.tasks[taskIdx].switch					
					ret = true
					
				endif
				
			endif

		elseif ma.helpInter.tasks[taskIdx].item = MA_HELP_ITEM_SEL_CMD
			
			selIdx = cdFindSelCmdIdx(ma.helpInter.tasks[taskIdx].idx)
			
			if selIdx > -1
				
				selCmdIdx = cd.selCmds[selIdx]
				selCode = ma.cmds[selCmdIdx].code
								
				if cd.mode <> CD_MODE_DRAG_ITEM and cd.mode <> CD_MODE_CMD_BAR
					
					cmdIdx = -1 // Checking to see if we have this cmd already.
				 
				 	// Is it an operator?
				 	if ma.helpInter.tasks[taskIdx].switch > 0 and ma.helpInter.tasks[taskIdx].prevCode > 0

						code = ma.helpInter.tasks[taskIdx].prevCode
						
				 		for i = 0 to ma.things[cd.thingIdx].cmds.length
				 										
				 			// Found cmd holding value cmd.
							if ma.cmds[ma.things[cd.thingIdx].cmds[i]].code = code
								
								cmdIdx = ma.things[cd.thingIdx].cmds[i] // i
								partIdx = ma.helpInter.tasks[taskIdx].switch
								
								if ma.cmds[cmdIdx].parts[partIdx].typ = PART_CMD
									
									cmd = cdGetPartAsInt(ma.cmds[cmdIdx].parts[partIdx])
									
									if ma.cmds[cmd].code = selCode											
										exit
									else 
										cmdIdx = -1 // Not found.
									endif
									
								else 
									
									cmdIdx = -1 // Not found.
									
								endif
																	
							endif
							
						next 
				 		
				 	else // Not an operator, check if we have the cmd.
				 	
						for i = 0 to ma.things[cd.thingIdx].cmds.length							
							if ma.cmds[ma.things[cd.thingIdx].cmds[i]].code = selCode
								cmdIdx = ma.things[cd.thingIdx].cmds[i] // i
								exit
							endif
						next 
						
					endif
					
					if cmdIdx = -1 // Don't have it.

						grp = (selCode >> 12) && 0xf

						// Are we on the right tab.
						if cd.mainTab = CD_TAB_CMD and cd.grpTab <> grp
							
							if guiGetButtonActive(cd.grpBar.buts[grp])
								maSetHelpPress(taskIdx, cd.grpBar.buts[grp].bg, "Press the '" + gettextstring(cd.grpBar.buts[grp].text) + "' tab", DIR_E || DIR_S, 0, 0)			
							else 
								switch = ma.helpInter.tasks[taskIdx].switch						
							endif
							
							ret = true
						
						endif
								
						// Are we snapping to a previous cmd?
						if not ret and ma.helpInter.tasks[taskIdx].prevCode > 0
					
							// If switch is > 0, it means we are added to a part of prevCode.
							if ma.helpInter.tasks[taskIdx].switch > 0

								code = ma.helpInter.tasks[taskIdx].prevCode

								for i = 0 to ma.things[cd.thingIdx].cmds.length							
									if ma.cmds[ma.things[cd.thingIdx].cmds[i]].code = code
										cmdIdx = ma.things[cd.thingIdx].cmds[i]
										exit
									endif
								next 

								if cmdIdx > -1
									
									idx = ma.helpInter.tasks[taskIdx].switch
									maSetHelpPress(taskIdx, ma.cmds[selCmdIdx].lt, "Drag this command and snap into there.", -(DIR_W || DIR_S), ma.cmds[selCmdIdx].rt, ma.cmds[cmdIdx].parts[idx].spr)			
									ret = true
									
								endif
								
							else 
								
								code = ma.helpInter.tasks[taskIdx].prevCode

								for i = 0 to ma.things[cd.thingIdx].cmds.length							
									if ma.cmds[ma.things[cd.thingIdx].cmds[i]].code = code
										cmdIdx = ma.things[cd.thingIdx].cmds[i]
										exit
									endif
								next 

								if cmdIdx > -1
									
									maSetHelpPress(taskIdx, ma.cmds[selCmdIdx].lt, "Drag this command and snap below that command.", -(DIR_W || DIR_S), ma.cmds[selCmdIdx].rt, ma.cmds[cmdIdx].lt)					
									ret = true
									
								endif

							endif
							
						endif
													
						if not ret and cmdIdx = -1
							
							maSetHelpPress(taskIdx, ma.cmds[selCmdIdx].lt, "Drag this command.", -(DIR_W || DIR_S), ma.cmds[selCmdIdx].rt, cd.codePanel.panel)					
							ret = true
							
						endif
					
						//ret = true

					else 
													
						// We have the cmd, see if it's attached appropriately.
						if ma.helpInter.tasks[taskIdx].prevCode > 0 and ma.helpInter.tasks[taskIdx].switch = 0
							
							cmdIdx = -1
							code = ma.helpInter.tasks[taskIdx].prevCode

							for i = 0 to ma.things[cd.thingIdx].cmds.length	
								
								if cmdIdx > -1
									
									if ma.cmds[ma.things[cd.thingIdx].cmds[i]].code = selCode
										if ma.cmds[ma.things[cd.thingIdx].cmds[i]].root // Don't want root.
											maSetHelpPress(taskIdx, ma.cmds[ma.things[cd.thingIdx].cmds[i]].lt, "Drag this command and snap below that command.", -(DIR_W || DIR_S), ma.cmds[ma.things[cd.thingIdx].cmds[i]].rt, ma.cmds[cmdIdx].lt)					
											cmdIdx = -2
										endif
									endif
									
									exit
									
								elseif ma.cmds[ma.things[cd.thingIdx].cmds[i]].code = code
									
									cmdIdx = ma.things[cd.thingIdx].cmds[i]
									
								endif
								
							next 
							
							if cmdIdx = -2 // Need to break.
								ret = true
							endif
							
						endif

					endif
					
				endif
			endif
			
		endif
						
	endif
	
	hd.ret = ret
	hd.switch = switch
		
endfunction

//-----------------------------------------------------
// Show detailed help for the passed cmd.
// mode
//   CD_HELP_CMD, idx = selIdx
//   CD_HELP_APP, idx = appIdx
//   CD_HELP_MAIN, idx is the help page, 0 = index.
// For mode=CD_HELP_CMD
//   Adds the actual cmd, and its ma.cmds[cd.selCmds[selIdx]].help.
//   If ma.cmds[cd.selCmds[selIdx]].help2 is non-null, extra help is added.
//   help2 text lines must be seperated by \n.
// For mode=CD_HELP_APP
//   Shows project details.
// For mode=CD_HELP_MAIN
//   Show help index, and underlying help pages.
//
// Valid values in each line of the help2 text:
// #idx <title> - start of a section, that can be linked to with a <L idx>.
// <P {project id}[ I]>, optional I to ignore the first thing 0. Optionally shows thing[0] and thing[0] commands, e.g. (P14 T)
// <C {cmd code[ {build def}]> - create a cmd, e.g. <C {code for CODE_MATH_DIVIDE}>, see cdAppendHelpCmd()
// <S {gfx file}> - create a sprite and cmd, e.g. <S sprites/ghost.png>
// <G {gfx file}> - Load a gfx, e.g. for an icon.
// <I {image id}> - Show an already loaded image, e.g. for an icon.
// Just text:
// <B> - Makes text bold (until next <B>).
// <H idx><text><H> - Display a heading for # section, until next <H>.
// <F +> - Increase font.
// <F -> - Decrease font.
// <F [1-6]> - Set font to size.
// <F> - Reset font back to normal (default is 2).
// <L idx> - Makes text a hyperlink to another help page denoted by idx.
// <N idx><title><N> - Makes text a hyperlink to interactive help.
// <X [+]nnn> - Position at x position. With +, add to x.
// <Y [+/-]nnn> - Mmove the y position up or down by nnn. Good if you place a long image and you want text to the right of it.
// Otherwise, creates text, and automatically wraps.
// All lines are followed by a new line (except <X> above), i.e. they make their way down the screen.
// The help box scrolls.
//
function cdShowDetailedHelp(mode as integer, idx as integer)

	local count as integer
	local s as string
	local i as integer
	local toks as string[]
	local text as integer
	local thingIdx as integer
	local img as Image
	local appIdx as integer
	local off as integer
	local os1 as string
	local os2 as string 
	local os3 as string 
	local os4 as string
	local cmd as integer
	local cmd2 as integer
	local code as integer
	local def as string
	local pos as integer
	local selIdx as integer
	local page as HelpPage
	local folder as string
	
	cd.helpDetails.currMode = mode
	cd.helpDetails.currIdx = idx

	guiSetPanelContentSize(cd.helpPanel, cd.helpPanel.vx, cd.helpPanel.vy, GetSpriteWidth(cd.helpPanel.panel), GetSpriteHeight(cd.helpPanel.panel))
	guiSetPanelBarsVisible(cd.helpPanel, false)	
	
	cd.helpDetails.x = cd.helpPanel.vx + co.bs / 4
	cd.helpDetails.y = cd.helpPanel.vy + co.bs / 4

	// Clear the trail if we are about to go to main page, and that it the only thing in the trail.
	if mode = CD_HELP_MAIN and idx = 0 and cd.helpDetails.trail.length = 0 
		if cd.helpDetails.trail[0] = 0
			cd.helpDetails.trail.length = -1
		endif
	endif

	s = cdAppendHelpTrail()

	if s <> ""
		
		toks.insert(s)
		toks.insert(" ")

	endif
				
	//if idx >= 0
	if mode = CD_HELP_CMD

		cmd = cd.selCmds[idx]
		s = "<C " + hex(ma.cmds[cmd].code) + ">"
		toks.insert(s)
	
		// Then actual cmd help.	
		s = coReplaceTildes(ma.cmds[cmd].help, " ")
		cdAppendHelpTok(toks, s)
	
		// Now check if there is any additional help2.		
		cdAppendHelpToks(toks, ma.cmds[cmd].help2)		
		cdAppendHelpLines(toks)	

	elseif mode = CD_HELP_MAIN

		//cd.helpDetails.y = cd.helpDetails.y - co.bs / 8

		if idx > -1 // Have a page to load.

			if idx > 999

				OpenBrowser(cdAppendHelpPageName(idx))				

			else				

				cd.helpDetails.pageIdx = idx	
				page.name = "Help Index"
				page.toks = toks			
				cdAppendHelpPage(page /*toks*/, cd.helpDetails.pageIdx)

			endif

		elseif cd.helpDetails.pageIdx > -1 // No page to load, and haven't previously loaded one.			

			page.name = "Help Index"
			page.toks = toks			
			cdAppendHelpPage(page /*toks*/, cd.helpDetails.pageIdx)

		else
			
			cd.helpDetails.pageIdx = 0
			page.name = "Help Index"
			page.toks = toks
			cdAppendHelpPage(page /*toks*/, cd.helpDetails.pageIdx)

		endif

	elseif mode = CD_HELP_APP

		appIdx = idx
		idx = -1
		off = 350
		os1 = "<X " + str(off) + ">"
		os2 = "<X +" + str(64) + ">"
		os3 = "<X +" + str(32) + ">"
		os4 = "<X +" + str(off - 64) + ">"

		//cd.helpDetails.y = cd.helpDetails.y - co.bs / 8	
		
		toks.insert("Project name" + os1 + ":" + os3 + "<B>" + ma.apps[appIdx].name + "<B>")
		toks.insert("Owner" + os1 + ":" + os3 + "<B>" + ma.apps[appIdx].ownerName + "<B>")
		toks.insert("Version " + os1 + ":" + os3 + "<B>" + ma.apps[appIdx].versionNbr + "<B>")
		
		folder = getwritepath()
		
		if right(folder, 1) = "/"
			folder = mid(folder, 1, len(folder) - 1)
		endif
		
		toks.insert("Folder " + os1 + ":" + os3 + "<B>" + folder + ma.apps[appIdx].folder + "<B>")

		s = ""
		
		//if ma.apps[appIdx].status && LD_STATUS_LOCKED or ma.apps[appIdx].status && LD_STATUS_LIBRARY

			if ma.apps[appIdx].status && LD_STATUS_LIBRARY

				if s <> ""
					s = s + ", "
				endif

				s = s + "library project"

			endif
			
			if ma.apps[appIdx].status && LD_STATUS_EXAMPLE

				if s <> ""
					s = s + ", "
				endif

				s = s + "example project"
				
			endif

			if ma.apps[appIdx].status && LD_STATUS_LOCKED

				if s <> ""
					s = s + ", "
				endif

				s = s + "not editable"
				
			endif
			
			toks.insert("Status" + os1 + ":" + os3 + "<B>" + s + "<B>")
			
		//endif
		
		if ma.apps[appIdx].status && LD_STATUS_PURCHASED
			
			toks.insert("Purchased" + os4 + "<G " + LD_MEDIA_DIR + "/gfx/SmallPurchasedIcon.png>" + os2 + ":" + os3 + "<B>" + coFloatToPrice(ma.apps[appIdx].buyPrice) + "<B>")			
			toks.insert("Purchased date" + os1 + ":" + os3 + "<B>" + ma.apps[appIdx].buyDate + "<B>")

		elseif ma.apps[appIdx].status && LD_STATUS_FOR_SALE

			toks.insert("For sale" + os4 + "<I " + str(cd.forSaleImg) + ">" + os2 + ":<B>" + os3 + coFloatToPrice(ma.apps[appIdx].salePrice))			

		elseif ma.apps[appIdx].status && LD_STATUS_SHARED_TO_YOU

			if ma.apps[appIdx].shared <> "" // Should have your id.
				toks.insert("Shared by owner to" + os4 + "<I " + str(cd.sharedToYouImg) + ">" + os2 + ":" + os3 + "<B>only you<B>")			
			else
				toks.insert("Shared by owner to" + os4 + "<I " + str(cd.sharedToYouImg) + ">" + os2 + ":" + os3 + "<B>everyone<B>")			
			endif		

		elseif ma.apps[appIdx].status && LD_STATUS_SHARED_BY_YOU

			if ma.apps[appIdx].shared <> "" // Should have the id of the person you shared to.
				toks.insert("Shared by you to" + os4 + "<I " + str(cd.sharedByYouImg) + ">" + os2 + ":" + os3 + "<B>" + ma.apps[appIdx].shared + "<B>")			
			else 
				toks.insert("Shared by you to" + os4 + "<I " + str(cd.sharedByYouImg) + ">" + os2 + ":" + os3 + "<B>everyone<B>")			
			endif		

		endif
		
		toks.insert("Icon:")
		toks.insert("")
		folder = ma.apps[appIdx].folder + "/" + LD_ICON_FILE // GetImageFilename(ma.apps[appIdx].img)
		toks.insert("<S " + folder + ">")

		cdAppendHelpLines(toks)
	
		//cd.helpDetails.pageIdx = -idx
			
	endif
	
	guiSetPanelContentSize(cd.helpPanel, cd.helpPanel.vx, cd.helpPanel.vy, cd.helpDetails.x1, cd.helpDetails.y1)
	guiSetPanelBarsVisible(cd.helpPanel, true)	
	guiSetPanelVisible(cd.helpPanel, true)

endfunction

//-----------------------------------------------------
// Get help for the page denoted by idx.
//
function cdAppendHelpTrail()

	local i as integer
	local s as string
	local idx as integer

	if cd.helpDetails.trail.length > -1
		
		//s = "<F 2>"
		s = ""
		
		for i = 0 to cd.helpDetails.trail.length
			
			if i > 0
				s = s + " > "
			endif
			
			s = s + "<T>"
			
			idx = cd.helpDetails.trail[i]
			
			if idx >= 0
				s = s + cdAppendHelpPageLink(idx)
			else 
				s = s + cdAppendHelpCmdLink(idx)
			endif

		next

		//s = s + "<F>"
		
	endif
		
endfunction s

//-----------------------------------------------------
// Trim all items with idx.
//
function cdTrimHelpTrail(idx as integer)
	
	local i as integer
	
	while i <= cd.helpDetails.trail.length
		
		if cd.helpDetails.trail[i] = idx
			cd.helpDetails.trail.remove(i)
		else
			inc i
		endif
		
	endwhile
	
endfunction

//-----------------------------------------------------
// Append a trail item.
//
function cdAddHelpTrail(idx as integer)
	
	cdTrimHelpTrail(idx)	
	cd.helpDetails.trail.insert(idx)
	
endfunction

//-----------------------------------------------------
// Get help for the page denoted by idx.
//
function cdAppendHelpPageLink(idx as integer)

	local s as string

	s = "<A " + str(idx) + "> " + cdAppendHelpPageName(idx) + " </A>"
	
endfunction s

//-----------------------------------------------------
// Get help for the cmd denoted by idx.
// idx could be -ve or +ve, but represented a selCmd[idx]
//
function cdAppendHelpCmdLink(idx as integer)

	local s as string
	
	if idx < 0 then idx = -idx
	s = "<K " + str(idx) + "> " + cdAppendHelpCmdName(idx) + " </K>"
	
endfunction s

//-----------------------------------------------------
// Get help for the page denoted by idx.
//
function cdAppendHelpCmdName(idx as integer)

	local cmd as integer
	local s as string
	
	if idx < 0 then idx = -idx
	cmd = cd.selCmds[idx]
	s = ma.cmds[cmd].parts[0].info

endfunction s

//-----------------------------------------------------
// Get help for the page denoted by idx.
//
function cdAppendHelpPageName(idx as integer)

	local name as string

	if idx = 1000
		name = "https://www.appgamekit.com"
	else
		name = "Project info" // cd.helpDetails.pages[idx].name
	endif
	
/*			
	if idx = 0
		name = "Help Index"
	elseif idx= 1
		name = "Things to know"
	elseif idx= 2
		name = "Projects"
	elseif idx= 3
		name = "Libraries"
	elseif idx= 4
		name = "Things"
	elseif idx= 5
		name = "Commands"
	elseif idx= 6
		name = "Coding"
	elseif idx= 7
		name = "Layout"
	elseif idx= 8
		name = "Runtime"
	elseif idx= 9
		name = "Variables"
	elseif idx= 10
		name = "Sounds and video"
	elseif idx= 11
		name = "Sprite editor"
	elseif idx= 12
		name = "Credits"
	elseif idx = 1000
		name = "https://www.appgamekit.com"
	else
		name = "Unknown"
	endif
*/
	
endfunction name

//-----------------------------------------------------
// Get help for the page denoted by idx.
// linkedIdx is what called this.
//
function cdAppendHelpPage(page ref as HelpPage, idx as integer) // toks ref as string[], idx as integer)

	cdAppendHelpLines(page.toks)
	if cd.helpDetails.pages.length > -1
		cdAppendHelpLines(cd.helpDetails.pages[idx].toks)
	endif
	cdAddHelpTrail(idx)
	
endfunction

//-----------------------------------------------------
// Append a string to the tok list.
//
function cdAppendHelpTok(toks ref as string[], s as string)
	
	//coSplitString(toks, s, "\n")
	toks.insert(s)
	
endfunction

//-----------------------------------------------------
// Append a string to the tok list.
//
function cdAppendHelpToks(toks ref as string[], s ref as string[])

	local i as integer
	
	for i = 0 to s.length
		toks.insert(s[i])
	next
	
endfunction

//-----------------------------------------------------
// Append a list of lines.
//
function cdAppendHelpLines(toks ref as string[])

	local i as integer

	for i = 0 to cd.helpDetails.nbrs.length
		cd.helpDetails.nbrs[i] = 0
	next

	cd.helpDetails.bold = false
	cd.helpDetails.under = false
	cd.helpDetails.interactive = false
	cd.helpDetails.fontSizeIdx = ld.set.helpSize // + 1 // CD_DEF_HELP_FONT
	cd.helpDetails.trailIdx = 0

	for i = 0 to toks.length // toks.length
		cdAppendHelpLine(toks[i])
	next

endfunction

//-----------------------------------------------------
// Push a help cmd onto the helpdetails stack.
//
function cdPushHelpCmd(cmd as integer)

	cd.helpDetails.stack.insert(cmd)
	
endfunction

//-----------------------------------------------------
// Push a help cmd onto the helpdetails stack.
//
function cdPopHelpCmd()

	local cmd as integer

	if cd.helpDetails.stack.length > -1
			
		cmd = cd.helpDetails.stack[cd.HelpDetails.stack.length]
		cd.helpDetails.stack.remove(cd.HelpDetails.stack.length)
		
	endif
	
endfunction cmd

//-----------------------------------------------------
// The the app.
//
function cdSetApp(appId as string)

	if cd.appIdx > -1
		cdSetCmdSelected(ma.apps[cd.appIdx].cmd, false)		
	endif
	
	cd.appId = appId

	if cd.appId <> ""

		cd.appIdx = maFindAppById(cd.appId)
		cdSetCmdSelected(ma.apps[cd.appIdx].cmd, true)

		guiSetButtonActive(cd.appbut, true)
		guiSetButtonActive(cd.thingbut, true)
		
		cdSetSprite(ma.apps[cd.appIdx].sprId)

	else

		// TODO: Unload current app.
		
		cd.appIdx = -1
		
		guiSetButtonActive(cd.appbut, true)
		guiSetButtonActive(cd.thingbut, false)

		cdSetSprite("")

	endif
		
endfunction

//-----------------------------------------------------
// The the thing.
//
function cdSetSprite(thingId as string)

	local i as integer
	local prevThingIdx as integer
	local thingIdx as integer
	local cmd as integer
	local partIdx as integer
	local selIdx as integer
	local s as string 

	// Clear the previous thing.
	
	if cd.thingIdx > -1

		//cdShowVars(cd.thingIdx, false)
		cdSetGrpVisible(false)
		cdShowCode("a", false)
		cdSetCmdSelected(ma.things[cd.thingIdx].cmd, false)
		
	endif

	cd.thingIdx = -1
	cd.thingId = thingId

	if cd.thingId <> ""		
		cd.thingIdx = maFindThingById(cd.appIdx, cd.thingId)
	endif

	// Show the new thing.
	
	if cd.thingIdx > -1

		// Make sure cmds are built.
		cdSetSpritesVisible(false, 1)

		cmd = ma.things[cd.thingIdx].cmd

		if cmd
			
			cdSetCmdSelected(cmd, true)
			cdSetCmdScissor(cmd, cd.cmdPanels[GRP_SPRITE].vx, cd.cmdPanels[GRP_SPRITE].vy, cd.cmdPanels[GRP_SPRITE].vx + cd.cmdPanels[GRP_SPRITE].vw - 1, cd.cmdPanels[GRP_SPRITE].vy + cd.cmdPanels[GRP_SPRITE].vh - 1)
			
			guiSetButtonActive(cd.codeBut, true)

			if ma.things[cd.thingIdx].imgIdx > -1
				
				//if ma.things[cd.thingIdx].imgs[ma.things[cd.thingIdx].imgIdx].img
				if ma.things[cd.thingIdx].imgs[ma.things[cd.thingIdx].imgIdx].thumb
					
					//guiSetButtonIcon(cd.codeBut, ma.things[cd.thingIdx].imgs[ma.things[cd.thingIdx].imgIdx].img)
					guiSetButtonIcon(cd.codeBut, ma.things[cd.thingIdx].imgs[ma.things[cd.thingIdx].imgIdx].thumb)
					SetSpriteScaleByOffset(cd.codeBut.icon, GetSpriteScaleX(cd.codeBut.icon) * 0.9, GetSpriteScaleY(cd.codeBut.icon) * 0.9)

					s = ma.things[cd.thingIdx].name
					guiSetButtonText(cd.codeBut, s)
					coSetTextColor(cd.codeBut.text, co.black)

					guiSetButtonDepth(cd.codeBut, cd.codeBut.depth)
					
					// Refresh the thing part and cmd.
					partIdx = cdFindPartByType(cmd, PART_SPRITE_ICON)

					if partIdx > -1
						
						cdClearPart(ma.cmds[cmd].parts[partIdx])
						//cdSetPartThing(ma.cmds[cmd].parts[partIdx], cd.thingIdx)
						cdSetPartThing(ma.cmds[cmd].parts[partIdx], ma.things[cd.thingIdx].id)
						cdUpdateCmdSize(cmd)
						cdSetCmdPos(cmd, ma.cmds[cmd].x, ma.cmds[cmd].y)
						//cdSetCmdDepth(cmd, GUI_SHADOW_DEPTH)
						cdSetCmdDepth(cmd, GetSpriteDepth(cd.cmdPanels[GRP_SPRITE].panel) - 2)
						cdSetCmdScissor(cmd, cd.cmdPanels[GRP_SPRITE].vx, cd.cmdPanels[GRP_SPRITE].vy, cd.cmdPanels[GRP_SPRITE].vx + cd.cmdPanels[GRP_SPRITE].vw - 1, cd.cmdPanels[GRP_SPRITE].vy + cd.cmdPanels[GRP_SPRITE].vh - 1)	

					endif
					
				endif

			endif

			if cd.mainTab = CD_TAB_THING
				cdSetCmdVisible(cmd, true)
			else
				cdSetCmdVisible(cmd, false)
			endif

		endif

		guiSetButtonActive(cd.cmdBut, true)
		cdReplaceAllImageParts(cd.appIdx, PART_SPRITE, str(cd.thingIdx), "-2")
		
	else
				
		guiSetButtonIcon(cd.codeBut, cd.codeImg)
		guiSetButtonText(cd.codeBut, "code")
		coSetTextColor(cd.codeBut.text, co.black)
		guiSetButtonActive(cd.codeBut, false)
		guiSetButtonActive(cd.cmdBut, false)
				
	endif

	cdSetTabVisible("o", true)
	
endfunction

//-----------------------------------------------------
// Find a part index by type.
//
function cdFindPartByType(cmd as integer, partTyp as integer)

	local ret as integer
	local i as integer

	ret = -1
	
	for i = 0 to ma.cmds[cmd].parts.length

		if ma.cmds[cmd].parts[i].typ = partTyp
			
			ret = i
			exit

		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Show code if it needs to be shown.
//
function cdShowCode(s as string, show as integer)

//colog("cdShowCode, s=" + s + ", show=" + str(show))

	local i as integer
	local j as integer

	coSetSpriteColor(cd.codePanel.panel, cd.tabCols[CD_TAB_CODE])
	
	if cd.thingIdx > -1

		if show
			cdDrawCode("a", 0)
		endif

		for i = 0 to ma.things[cd.thingIdx].cmds.length
			cdSetCmdVisible(ma.things[cd.thingIdx].cmds[i], show)			
		next
		
	endif

endfunction

//-----------------------------------------------------
// Make color with alpha.
//
function cdMakeColor(r as integer, g as integer, b as integer, a as integer)
	
	local col as integer
	
	col = MakeColor(r, g, b)
	col = col && 0x00ffffff
	col = col && (a << 24)
	
endfunction col

//-----------------------------------------------------
// Zoom out, i.e. make all cmds smaller to fit the code window.
//
function cdZoomOut()

	local cmd as integer
	local i as integer
	local ws as float
	local hs as float
	local w as float
	local h as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local edge as float
	local tx as float
	local ty as float
	
	cdSetAllAlpha(gui.inactiveAlpha)

	// Fix zoom the button.
	
	guiSetPanelAlpha(cd.codePanel, 255)
	
	// No cmds, get out now.
	if cd.thingIdx = -1
		exitfunction
	endif

	w = getspritewidth(cd.codePanel.panel)
	h = getspriteheight(cd.codePanel.panel)

	//ws = w / ((x1 - x0) + 1)
	ws = w / cd.gw
	if ws >= 1.0
		ws = 1.0
	endif

	//hs = h / ((y1 - y0) + 1)
	hs = h / cd.gh
	if hs >= 1.0
		hs = 1.0
	endif

	if ws < hs
		cd.zoomScale = ws
	else
		cd.zoomScale = hs
	endif

	cd.zoomFontSize = co.fontSizes[gui.cmdFontSize] * cd.zoomScale
	cd.zoomActive = true
	
	for i = 0 to ma.things[cd.thingIdx].cmds.length

		cmd = ma.things[cd.thingIdx].cmds[i]
		//cdSetCmdScale(cmd, cd.cmdScales[ld.set.cmdSize], cd.cmdScales[ld.set.cmdSize] * cd.zoomScale)
		cdSetCmdScale(cmd)
		cdUpdateCmdSize(cmd)
		
	next

	cdDrawCode("b", 0)

	guiShowTip(gui.tip, cd.codePanel.panel, "The white area shows all code for this sprite. Press anywhere in the white area to refocus.", TIP_INFO, DIR_E || DIR_S)
	cdReposCodePanelTip()
	
endfunction

//-----------------------------------------------------
// Zoom in again, but place code positioned at x, y in the centre.
//
function cdZoomIn(x as float, y as float)

	local idx as integer
	local cmd as integer
	local i as integer
	local zs as float
	local dx as float
	local dy as float

	//idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_ZOOM_OUT)
	idx = guiFindBarButtonById(cd.codeBar, BUT_CODER_ZOOM_OUT)

	guiSetPanelAlpha(cd.codePanel, 255)

	guiSetButtonAlpha(cd.toolBar.buts[idx], 255)
	//guiSetButtonVisible(cd.toolBar.buts[idx], true)

	cdSetAllAlpha(255)
	guiHideTip(gui.tip)

	SetSpriteVisible(cd.codeScroll, false)
	coSetSpriteColor(cd.codePanel.panel, co.white)
	
	// No cmds, get out now.
	if cd.thingIdx = -1
		exitfunction
	endif

	zs = cd.zoomScale
	cd.zoomScale = 1.0
	cd.zoomFontSize = co.fontSizes[gui.cmdFontSize] * cd.zoomScale
	cd.zoomActive = false

	for i = 0 to ma.things[cd.thingIdx].cmds.length

		cmd = ma.things[cd.thingIdx].cmds[i]
		//cdSetCmdScale(cmd, cd.cmdScales[ld.set.cmdSize] * zs, cd.cmdScales[ld.set.cmdSize])
		cdSetCmdScale(cmd)
		cdUpdateCmdSize(cmd)
		cdRestoreCmdPos(cmd)
		
	next

	//cd.trimWhite = true
	ma.things[cd.thingIdx].trimWhite = true
	
	cdDrawCode("c", 0)

	dx = x - cd.codePanel.vx
	dy = y - cd.codePanel.vy
	dx = dx / zs
	dy = dy / zs

	cd.codePanel.cx = cd.codePanel.vw / 2 - dx
	cd.codePanel.cy = cd.codePanel.vh / 2 - dy
	
endfunction

/*
//-----------------------------------------------------
// Remove cmds.
//
function cdRemoveThing(cmds ref as integer[])

	local i as integer
	
	for i = 0 to cmds.length
		cdDeleteCmd(cmds[i])
	next
	
endfunction
*/

//-----------------------------------------------------
// Delete a var.
//
function cdDeleteVar(varIdx as integer)
		
	cdClearVar(varIdx)
	maDeleteVar(varIdx)
	
endfunction

//-----------------------------------------------------
// Delete a var's items.
//
function cdClearVarItems(varIdx as integer)

	local i as integer
	
	if ma.vars[varIdx].typ = VAR_TYPE_LIST or ma.vars[varIdx].typ = VAR_TYPE_OBJECT

		for i = 0 to ma.vars[varIdx].list.length

			if ma.vars[varIdx].list[i].cmd
				cdDeleteCmd(ma.vars[varIdx].list[i].cmd)
			endif

		next
		
	endif

	ma.vars[varIdx].list.length = -1

endfunction

//-----------------------------------------------------
// Remove the passed appIdx fro memory.
//
function cdDeleteApp(appIdx as integer)

	local i as integer
	
	for i = 0 to ma.apps[appIdx].sprites.length
		cdDeleteSprite(ma.apps[appIdx].sprites[i])
	next

	ma.apps[appIdx].sprites.length = -1

	for i = 0 to ma.apps[appIdx].vars.length
		cdDeleteVar(ma.apps[appIdx].vars[i])
	next

	ma.apps[appIdx].vars.length = -1

	for i = 0 to ma.apps[appIdx].sounds.length
		cdDeleteSound(ma.apps[appIdx].sounds[i])
	next

	ma.apps[appIdx].sounds.length = -1

	for i = 0 to ma.apps[appIdx].videos.length
		cdDeleteVideo(ma.apps[appIdx].videos[i])
	next

	ma.apps[appIdx].videos.length = -1

	cdClearApp(appIdx)
	
endfunction

//-----------------------------------------------------
// Clear the app cmd object.
//
function cdClearApp(appIdx as integer)

	if ma.apps[appIdx].cmd
		
		cdDeleteCmd(ma.apps[appIdx].cmd)
		ma.apps[appIdx].cmd = 0
		
	endif

endfunction

//-----------------------------------------------------
// Remove the passed thingIdx.
//
function cdDeleteSprite(thingIdx as integer)

	local i as integer
	
	for i = 0 to ma.things[thingIdx].vars.length
		cdDeleteVar(ma.things[thingIdx].vars[i])
	next

	ma.things[thingIdx].vars.length = -1

	for i = 0 to ma.things[thingIdx].cmds.length
		cdDeleteCmd(ma.things[thingIdx].cmds[i])
	next

	ma.things[thingIdx].cmds.length = -1

	if ma.things[thingIdx].cmd
		
		cdDeleteCmd(ma.things[thingIdx].cmd)
		ma.things[thingIdx].cmd = 0
		
	endif

	if ma.things[thingIdx].obj
		
		removeobject(ma.things[thingIdx].obj)
		ma.things[thingIdx].obj = 0

	endif
	
	cdDeleteImages(thingIdx)
	
	maDeleteThing(thingIdx)

endfunction

//-----------------------------------------------------
// Remove the passed soundIdx.
//
function cdDeleteSound(soundIdx as integer)

	if ma.sounds[soundIdx].cmd
		
		cdDeleteCmd(ma.sounds[soundIdx].cmd)
		ma.sounds[soundIdx].cmd = 0
		
	endif
	
	maDeleteSound(soundIdx)

endfunction

//-----------------------------------------------------
// Remove the passed videoIdx.
//
function cdDeleteVideo(videoIdx as integer)

	if ma.videos[videoIdx].cmd
		
		cdDeleteCmd(ma.videos[videoIdx].cmd)
		ma.videos[videoIdx].cmd = 0
		
	endif
	
	maDeleteVideo(videoIdx)

endfunction

//-----------------------------------------------------
// Remove the frames for the passed thing.
//
function cdDeleteImages(thingIdx as integer)

	local i as integer

	for i = 0 to ma.things[thingIdx].imgs.length
		cdDeleteImage(thingIdx, i)
	next

	
	ma.things[thingIdx].imgs.length = -1
	ma.things[thingIdx].imgIdx = -1

endfunction

//-----------------------------------------------------
// Remove the passed thingIdx.
//
function cdDeleteImage(thingIdx as integer, imgIdx as integer)
	
	if ma.things[thingIdx].imgs[imgIdx].img
		
		DeleteImage(ma.things[thingIdx].imgs[imgIdx].img)
		ma.things[thingIdx].imgs[imgIdx].img = 0

	endif

	if ma.things[thingIdx].imgs[imgIdx].thumb
		
		DeleteImage(ma.things[thingIdx].imgs[imgIdx].thumb)
		ma.things[thingIdx].imgs[imgIdx].thumb = 0

	endif

	if ma.things[thingIdx].imgs[imgIdx].cmd

		cdDeleteCmd(ma.things[thingIdx].imgs[imgIdx].cmd)
		ma.things[thingIdx].imgs[imgIdx].cmd = 0

	endif

endfunction

//-----------------------------------------------------
// Remove all parts holding this sprite/image, or change to newIdx if > -1.
//
function cdReplaceAllImageParts(appIdx as integer, typ as integer, idx as string, newIdx as string)

	local i as integer
	local thingIdx as integer
	
	for i = 0 to ma.apps[appIdx].sprites.length
		cdReplaceImageParts(ma.apps[appIdx].sprites[i], typ, idx, newIdx)				
	next

	//cdSetTabVisible("bbb", true)
	//ldSaveApp(ma.apps[cd.appIdx].id)

endfunction

//-----------------------------------------------------
// Remove all parts holding this sprite/image, or change to newIdx if > -1.
//
function cdReplaceImageParts(thingIdx as integer, typ as integer, idx as string, newIdx as string)

	local i as integer
	local cmd as integer
	
	for i = 0 to ma.things[thingIdx].cmds.length

		cmd = ma.things[thingIdx].cmds[i]
		cdReplaceImagePart(cmd, thingIdx, typ, idx, newIdx)
				
	next

	//cdSetTabVisible("bbb", true)
	//ldSaveApp(ma.apps[cd.appIdx].id)

endfunction

//-----------------------------------------------------
// Recurse into a cmd, to find the PART_FRAME.
// newIdx = -1 remove.
// newIdx = -2 reset current.
// newIdx > -1 set.
//
function cdReplaceImagePart(cmd as integer, thingIdx as integer, typ as integer, idx as string, newIdx as string)

	local i as integer
	local j as integer
	local subCmd as integer
	local rootCmd as integer
	local press as CmdPress
	local a as integer
	local imgId as string
	local partThingIdx as integer

	for i = 0 to ma.cmds[cmd].parts.length

		if typ = PART_FRAME and ma.cmds[cmd].code = CODE_LOOK_SET_FRAME

			if ma.cmds[cmd].parts[i].typ = PART_INT

				//if cdGetPartAsInt(ma.cmds[cmd].parts[1]) = idx + 1
				if cdGetPartAsString(ma.cmds[cmd].parts[i]) = idx

					press.cmd = subCmd
					cdFindThingRootCmd(thingIdx, press)
					cdClearPart(ma.cmds[cmd].parts[i])

					//if newIdx > -1
					//	cdSetPart(ma.cmds[cmd].parts[1], str(newIdx + 1))
					//endif
					
					cdUpdateCmdSize(press.parentCmd)
					cdSetCmdPos(press.parentCmd, ma.cmds[press.parentCmd].x, ma.cmds[press.parentCmd].y)
					cdSetCmdVisible(press.parentCmd, false)

				endif
				
			endif
			
		elseif typ = PART_FRAME and ma.cmds[cmd].code = CODE_LOOK_SET_FRAME_IMAGE

			if ma.cmds[cmd].parts[i].typ = PART_CMD

				subCmd = cdGetPartAsInt(ma.cmds[cmd].parts[i])

				if subCmd > -1
					
					if ma.cmds[subCmd].code = CODE_FRAME_PART

						imgId = cdGetPartFrameImage(ma.cmds[subCmd].parts[0].info)
						
						press.cmd = subCmd
						cdFindThingRootCmd(thingIdx, press)

						if val(newIdx) = -2

							if FindString(idx, imgId) = 0 // Not found, clear.

								cdClearPart(ma.cmds[subCmd].parts[0])
								newIdx = str(-1)

							endif
							
						endif
						
						if val(newIdx) = -1

							cdDeleteCmd(subCmd)
							cdRevertPart(thingIdx, cmd, i)

						elseif val(newIdx) > -1

							cdSetPart(ma.cmds[subCmd].parts[0], cdMakePartFrameInfo(thingIdx, newIdx))

						endif
						
						cdUpdateCmdSize(press.parentCmd)
						cdSetCmdPos(press.parentCmd, ma.cmds[press.parentCmd].x, ma.cmds[press.parentCmd].y)
						cdSetCmdVisible(press.parentCmd, false)
						//cdDrawCode("replace image", 0)
											
					else // See if the the cmd in this frame cmd has a frame image cmd.

						cdReplaceImagePart(subCmd, thingIdx, typ, idx, newIdx)
						
					endif

				endif
				
			elseif ma.cmds[cmd].parts[i].typ = PART_FRAME
//colog("PART_FRAME_REPLACE, SHOULDN'T BE HERE")

				if ma.cmds[cmd].parts[i].info <> ""
					
					imgId = cdGetPartFrameImage(ma.cmds[cmd].parts[i].info)
					
					press.cmd = cmd
					cdFindThingRootCmd(thingIdx, press)
					cdClearPart(ma.cmds[cmd].parts[i])
	
	 				if FindString(idx, imgId) > 0 // Not found clear.
						newIdx = imgId
					else					
						newIdx = str(-1)
					endif
						
					if val(newIdx) = -1
						cdRevertPart(thingIdx, cmd, i)
					elseif val(newIdx) > -1
						cdSetPart(ma.cmds[cmd].parts[i], cdMakePartFrameInfo(thingIdx, newIdx))
					endif
						
					cdUpdateCmdSize(press.parentCmd)
					cdSetCmdPos(press.parentCmd, ma.cmds[press.parentCmd].x, ma.cmds[press.parentCmd].y)
					cdSetCmdVisible(press.parentCmd, false)
					
				endif
				
			endif

		elseif typ = PART_SPRITE and (ma.cmds[cmd].code = CODE_MOVE_POINT_AT_THING or ma.cmds[cmd].code = CODE_EVENT_COLL_THING or ma.cmds[cmd].code = CODE_SENSE_COLL_THING or ma.cmds[cmd].code = CODE_SENSE_SPRITE_INFO or ma.cmds[cmd].code = CODE_SENSE_SPRITE_VIS or ma.cmds[cmd].code = CODE_SENSE_SPRITE_OFF_SCREEN)

			if ma.cmds[cmd].parts[i].typ = PART_CMD

				subCmd = cdGetPartAsInt(ma.cmds[cmd].parts[i])

				if subCmd > -1

					if ma.cmds[subCmd].code = CODE_SPRITE_PART

						if cdGetPartAsInt(ma.cmds[subCmd].parts[0]) = val(idx)

							press.cmd = subCmd
							cdFindThingRootCmd(thingIdx, press)
							cdClearPart(ma.cmds[subCmd].parts[0])

							if val(newIdx) = -2

								// Reset the sprite image to the new image at imgIdx.
								//cdSetPartThing(ma.cmds[subCmd].parts[0], val(idx))
								cdSetPartThing(ma.cmds[subCmd].parts[0], ma.things[val(idx)].id)

							elseif val(newIdx) = -1

								cdDeleteCmd(subCmd)
								cdRevertPart(thingIdx, cmd, i)

							endif
							
							cdUpdateCmdSize(press.parentCmd)
							cdSetCmdPos(press.parentCmd, ma.cmds[press.parentCmd].x, ma.cmds[press.parentCmd].y)
							cdSetCmdVisible(press.parentCmd, false)
							//cdDrawCode("replace image", 0)
																	
						endif
											
					else // See if the the cmd in this frame cmd has a frame image cmd.

						cdReplaceImagePart(subCmd, thingIdx, typ, idx, newIdx)
						
					endif

				endif
								
			elseif ma.cmds[cmd].parts[i].typ = PART_SPRITE
//colog("PART_SPRITE_REPLACE, SHOULDN'T BE HERE")

				if ma.cmds[cmd].parts[i].info <> ""
					
					if cdGetPartAsInt(ma.cmds[cmd].parts[i]) = val(idx)
	
						press.cmd = cmd
						cdFindThingRootCmd(thingIdx, press)
						cdClearPart(ma.cmds[cmd].parts[i])
						
						if val(newIdx) = -2
							cdSetPart(ma.cmds[cmd].parts[i], idx)
						elseif val(newIdx) = -1
							cdRevertPart(thingIdx, cmd, i)
						else
							cdSetPart(ma.cmds[cmd].parts[i], newIdx)
						endif
							
						cdUpdateCmdSize(press.parentCmd)
						cdSetCmdPos(press.parentCmd, ma.cmds[press.parentCmd].x, ma.cmds[press.parentCmd].y)
						cdSetCmdVisible(press.parentCmd, false)
	
					endif
					
				endif
				
			endif

		elseif ma.cmds[cmd].parts[i].typ = PART_CMD

			subCmd = cdGetPartAsInt(ma.cmds[cmd].parts[i])

			if subCmd > -1
				cdReplaceImagePart(subCmd, thingIdx, typ, idx, newIdx)
			endif
		
		endif
		
	next

endfunction

//-----------------------------------------------------
// Sort all images, and fix commands.
//
function cdSortImages(thingIdx as integer)

	local i as integer
	local cmd as integer
	
	for i = 0 to ma.things[thingIdx].imgs.length

		cmd = ma.things[thingIdx].imgs[i].cmd

		if cmd

			// Fix the visible image number.
			cdClearPart(ma.cmds[cmd].parts[1])
			cdSetPart(ma.cmds[cmd].parts[1], " " + str(i + 1))
			
			cdUpdateCmdSize(cmd)
			cdSetCmdPos(cmd, ma.cmds[cmd].x, ma.cmds[cmd].y)
			cdSetCmdVisible(cmd, false)

		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Create a cmd.
//
function cdCreateCmd(code as integer)

	local cmd as integer
	
	cmd = maCreateCmd(code)
	cdCreateCmdPtr(ma.cmds[cmd])
	
endfunction cmd

//-----------------------------------------------------
// Finish creation of a cmd.
//
function cdCreateCmdPtr(cmd ref as Cmd)

	local part as Part
	local i as integer
	local typ as integer

	typ = cmd.typ && (CMD_STMT || CMD_OPER || CMD_COND)
	
	if not (cmd.typ && CMD_TEXT)
		
		// Create wrapping box.
		cmd.lt = coCreateSprite("cdCCP:cmd.lt", cd.edgeImgs[typ])
		SetSpriteAnimation(cmd.lt, GetImageWidth(cd.edgeImgs[typ]) / 2, GetImageHeight(cd.edgeImgs[typ]), 2)
		setspriteframe(cmd.lt, 1) 
		cosetspritecolor(cmd.lt, cd.cmdCols[cmd.grp])

		cmd.rt = coCreateSprite("cdCCP:cmd.rt", cd.edgeImgs[typ])
		SetSpriteAnimation(cmd.rt, GetImageWidth(cd.edgeImgs[typ]) / 2, GetImageHeight(cd.edgeImgs[typ]), 2)
		setspriteframe(cmd.rt, 2) 
		cosetspritecolor(cmd.rt, cd.cmdCols[cmd.grp])
		
		cmd.bg = guicreatebox("cdCCP:cmd.bg", 1, 1)
		cosetspritecolor(cmd.bg, cd.cmdCols[cmd.grp])
	
		if cd.grpBar.buts.length >= cmd.grp

			if not (maIsElseCode(cmd.code) or maIsCloseCode(cmd.code))

				cmd.icon = coCreateSprite("cdCCP:cmd.icon", cd.grpBar.buts[cmd.grp].iconImg)

				//if cmd.typ && CMD_SPEC
					cmd.iconScale = 1.0
				//else 
				//	cmd.iconScale = cd.cmdScales[ld.set.cmdSize]
				//endif
								
				if not (cmd.typ && CMD_BUT)					

					cmd.iconScale = cmd.iconScale * 0.5
					if cmd.icon then setspritescale(cmd.icon, cmd.iconScale, cmd.iconScale)					

				endif

			endif

		elseif cmd.grp = GRP_SOUND or cmd.grp = GRP_VIDEO

			cmd.icon = coCreateSprite("cdCCP:cmd.icon", cd.thingBar.buts[cmd.grp - GRP_SPRITE].iconImg)
			//cmd.iconScale = cd.cmdScales[ld.set.cmdSize]
			cmd.iconScale = 1.0

			if not (cmd.typ && CMD_BUT)				

				cmd.iconScale = cmd.iconScale * 0.5
				if cmd.icon then setspritescale(cmd.icon, cmd.iconScale, cmd.iconScale)

			endif

		elseif cmd.grp = GRP_VAR

			if cmd.code = CODE_VAR_GET //or cmd.code = CODE_VAR_RUN

				cmd.icon = coCreateSprite("cdCCP:cmd.icon", cd.thingBar.buts[cmd.grp - GRP_SPRITE].iconImg)
				//cmd.iconScale = cd.cmdScales[ld.set.cmdSize]
				cmd.iconScale = 1.0

				if cmd.icon

					cmd.iconScale = cmd.iconScale * 0.6
					setspritescale(cmd.icon, cmd.iconScale, cmd.iconScale)

				endif

			elseif cmd.code = CODE_VAR_VALUE
				
				cmd.icon = coCreateSprite("cdCCP:cmd.icon", cd.childImg)
				//cmd.iconScale = cd.cmdScales[ld.set.cmdSize]
				cmd.iconScale = 1.0
				
				if cmd.icon

					cmd.iconScale = cmd.iconScale * 0.5
					setspritescale(cmd.icon, cmd.iconScale, cmd.iconScale)

				endif

			endif

		endif
		
		// Setup shadow.
		cmd.slt = coclonesprite("cdCCP:cmd.slt", cmd.lt)
		cosetspritecolorwithalpha(cmd.slt, co.black, gui.shadowAlpha)
		cmd.srt = coclonesprite("cdCCP:cmd.srt", cmd.rt)
		cosetspritecolorwithalpha(cmd.srt, co.black, gui.shadowAlpha)		
		cmd.sbg = guicreatebox("cdCCP:cmd.sbg", 1, 1)
		cosetspritecolorwithalpha(cmd.sbg, co.black, gui.shadowAlpha)

	endif

	cdUpdateCmdSizePtr(cmd)	
	cdSetCmdPosPtr(cmd, 0, 0)
	cdSetCmdDepthPtr(cmd, GetSpriteDepth(cd.codePanel.panel) - 2) // code panel is the same as the cmdPanels.
	cdSetCmdShadowVisiblePtr(cmd, false)

	cdSetCmdVisiblePtr(cmd, false)
	
endfunction cmd

//-----------------------------------------------------
// Cut or copy the passed cmds to a named "Cut..." block, and then delete.
//
function cdSaveCmds(typ as integer)

	local clip as Clip
	local idx as integer
	local i as integer

	clip = cd.tmpClip		
	clip.typ = typ

	cdSetCodeTab(clip.cmds, false)
	
	if cd.clipMode = CD_CLIPMODE_NONE and (typ = CD_CLIP_CUT or typ = CD_CLIP_COPY)

		// Save to the clipboard.
		cd.clip = clip	
		cd.clipFull = true

	endif
	
	if cd.clipMode = CD_CLIPMODE_UNDO

		// If not a copy, save to the redo buffer.
		if typ <> CD_CLIP_COPY

			if cd.redos.length > -1
				cd.redos.insert(clip, 0)
			else 
				cd.redos.insert(clip) // Append.
			endif						

		endif

	else

		// We've made a new change, redos are gone.
		if cd.clipMode = CD_CLIPMODE_NONE
			cd.redos.length = -1
		endif
		
		// If not a copy, save to the undo buffer.
		if typ <> CD_CLIP_COPY

			if cd.undos.length > -1
				cd.undos.insert(clip, 0)
			else 
				cd.undos.insert(clip) // Append.
			endif						

		endif

	endif

//colog("SAVECMDS")
//cdPrintUndoRedo()

	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_UNDO)
	guiSetButtonActive(cd.toolBar.buts[idx], cd.undos.length > -1)
	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_REDO)
	guiSetButtonActive(cd.toolBar.buts[idx], cd.redos.length > -1)
	
endfunction

//-----------------------------------------------------
// Cut or lift a cmd. Lift just doesn't go to clipboard.
// count specifies how many cmds to cut.
//
function cdClipCut(cmd as integer, typ as integer, count as integer)

	// If count = 0, then we have already selected the commands to cut.
	if count > 0
		// Grabs cmds and detach, sets detach point in tmpClip.
		cdGrabCmd(cmd, count)
	endif
	
	cdDetachCmds(cd.currCmds)	
	cdSaveCmds(typ)		
	cdHideCmds(cd.currCmds)
	cd.currCmds.length = -1	

endfunction

//-----------------------------------------------------
// Delete the current curr cmd set.
//
function cdClipDelete()

	cdSaveCmds(CD_CLIP_DROP_DEL)
	cdHideCmds(cd.currCmds)
	cd.currCmds.length = -1	

endfunction

//-----------------------------------------------------
// Copy a cmd.
//
function cdClipCopy(cmd as integer)

	local typ as integer
	
	// Grabs cmds.
	//cdGrabCmd(cmd, -1)
	
	cd.tmpClip.cmds.length = -1
	cdCloneCmds(cd.currCmds, cd.tmpClip.cmds)
	cd.tmpClip.attachCmd = 0
	cd.tmpClip.attachPartIdx = -1
	cd.tmpClip.attachDir = 0
	cd.tmpClip.isRoot = false
	cdSaveCmds(CD_CLIP_COPY)

	typ = (ma.cmds[cd.currCmds[0]].code >> 3) && 0xff

	if typ <> CMD_STMT // Oper or bool.
		cdSetCmdShadowVisible(cd.currCmds[0], false)		
	else
		cdRestoreCmds(cd.currCmds)
	endif
	
	cd.currCmds.length = -1

endfunction

//-----------------------------------------------------
// Paste the clipboard to x, y.
//
function cdClipPaste(x as float, y as float)

	cd.currCmds.length = -1
	cdCloneCmds(cd.clip.cmds, cd.currCmds)
	ma.cmds[cd.currCmds[0]].x = x
	ma.cmds[cd.currCmds[0]].y = y
	cd.attachCmd = 0
	cd.attachPartIdx = -1		
	cdDropCmd()
	cd.currCmds.length = -1	

endfunction

//-----------------------------------------------------
// Paste the clipboard to a part.
//
function cdClipPasteToPart(cmd as integer, partIdx as integer)

	cd.tmpClip.attachCmd = cmd
	cd.tmpClip.attachPartIdx = partIdx
	cd.tmpClip.cmds.length = -1
	cd.tmpClip.part = ma.cmds[cmd].parts[partIdx]
	cdSaveCmds(CD_CLIP_EDIT)

	cd.currCmds.length = -1
	cdCloneCmds(cd.clip.cmds, cd.currCmds)
	//ma.cmds[cd.currCmds[0]].x = x
	//ma.cmds[cd.currCmds[0]].y = y
	cd.attachCmd = cmd
	cd.attachPartIdx = partIdx		
	cdDropCmd()
	cd.currCmds.length = -1	

	//cdPrintUndoRedo()

endfunction

//-----------------------------------------------------
// Drop a clip back to the code panel.
//
function cdClipDrop(clip ref as Clip)

	cd.currCmds = clip.cmds
	ma.cmds[cd.currCmds[0]].x = clip.grabX
	ma.cmds[cd.currCmds[0]].y = clip.grabY
	cd.attachCmd = clip.attachCmd
	cd.attachPartIdx = clip.attachPartIdx
	cd.attachDir = clip.attachDir	
	cdDropCmd()
	cd.currCmds.length = -1	

endfunction

//-----------------------------------------------------
// Redo the last undo.
//
function cdUndo()

	local idx as integer

	cd.clipMode = CD_CLIPMODE_UNDO
//colog("APPLING UNDO")
	cdUndoRedo(cd.undos)
	cd.clipMode = CD_CLIPMODE_NONE
	
	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_UNDO)
	guiSetButtonActive(cd.toolBar.buts[idx], cd.undos.length > -1)
	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_REDO)
	guiSetButtonActive(cd.toolBar.buts[idx], cd.redos.length > -1)

endfunction

//-----------------------------------------------------
// Redo the last undo.
//
function cdRedo()

	local idx as integer

	cd.clipMode = CD_CLIPMODE_REDO
//colog("APPLING REDO")
	cdUndoRedo(cd.redos)
	cd.clipMode = CD_CLIPMODE_NONE
	
	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_UNDO)
	guiSetButtonActive(cd.toolBar.buts[idx], cd.undos.length > -1)
	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_REDO)
	guiSetButtonActive(cd.toolBar.buts[idx], cd.redos.length > -1)

endfunction

//-----------------------------------------------------
// Print the undo and redo lists.
//
function cdPrintUndoRedo()

	local i as integer
	
	if cd.undos.length > -1
		
		colog("*** START UNDO")
		
		for i = 0 to cd.undos.length
			colog(str(i) + ". UNDO - " + cdPrintClip(cd.undos[i]))
		next
		
		colog("*** END UNDO")

	endif

	if cd.redos.length > -1
		
		colog("*** START REDO")
		
		for i = 0 to cd.redos.length
			colog(str(i) + ". REDO - " + cdPrintClip(cd.redos[i]))
		next
		
		colog("*** END REDO")
		
	endif

endfunction

//-----------------------------------------------------
// Print a clip.
//
function cdPrintClip(clip ref as Clip)

	local s as String

	s = "["
	
	if clip.typ = CD_CLIP_CUT
		s = s + "Cut"
	elseif clip.typ = CD_CLIP_COPY
		s = s + "Copy"
	elseif clip.typ = CD_CLIP_DROP_DEL
		s = s + "Drop Delete"
	elseif clip.typ = CD_CLIP_DROP
		s = s + "Drop"
	elseif clip.typ = CD_CLIP_SNAP
		s = s + "Snap"
	elseif clip.typ = CD_CLIP_SNAP_LIFT
		s = s + "Snap Lift"
	elseif clip.typ = CD_CLIP_EDIT
		s = s + "Edit"
	elseif clip.typ = CD_CLIP_LIFT
		s = s + "Lift"
	elseif clip.typ = CD_CLIP_CUT_DEL
		s = s + "Cut Delete"
	endif

	if clip.cmds.length > -1
		s = s + ", cmd=" + str(clip.cmds[0])
	else
		s = s + ", cmd=none"
	endif
	
	s = s + ", attCmd=" + str(clip.attachCmd)
	s = s + ", attPartIdx=" + str(clip.attachPartIdx)
	s = s + ", attDir=" + str(clip.attachDir)

	if clip.isRoot
		s = s + ", isRoot=true"
	else
		s = s + ", isRoot=false"
	endif

	s = s + ", grabX=" + stR(clip.grabX)
	s = s + ", grabY=" + stR(clip.grabY)
	s = s + "]"
		
endfunction s

//-----------------------------------------------------
// Undo or redo logic.
//
function cdUndoRedo(list ref as Clip[])

	local idx as integer
	local move as integer
	local edit as integer

//colog("UNDO/REDO")
//colog("BEFORE")
//cdPrintUndoRedo()
	
	if list.length > -1
		
		if list[0].typ = CD_CLIP_CUT

			// Drop the cut code back to the panel.
			cdClipDrop(list[0])
			list.remove(0)

		elseif list[0].typ = CD_CLIP_CUT_DEL

			// Drop the cut code back to the panel.
			cdClipDrop(list[0])
			list.remove(0)

		elseif list[0].typ = CD_CLIP_COPY

			// Do nothing, will never happen.
			
		elseif list[0].typ = CD_CLIP_DROP_DEL

			// Drop the delete clip back to the code panel.
			//cdClipDrop(list[0])
			list.remove(0)

			if list.length > -1
				
				if list[0].typ = CD_CLIP_LIFT

					// Put back a LIFT to parallel the LIFT/DELETE pair.
					//cd.tmpClip = list[0]
					//cdSaveCmds(CD_CLIP_LIFT)
					
					// Put it back, from where it was lifted.
					cdClipDrop(list[0])
					list.remove(0)

				endif

			endif
			
		elseif list[0].typ = CD_CLIP_DROP

			// Lift it from the code panel.
			cdClipCut(list[0].cmds[0], CD_CLIP_LIFT, list[0].cmds.length + 1)
			list.remove(0)

			if list.length > -1
				
				if list[0].typ = CD_CLIP_LIFT

					// Put it back, from where it was lifted.
					cdClipDrop(list[0])
					list.remove(0)

				endif

			endif

		elseif list[0].typ = CD_CLIP_SNAP

			// Remove the dropped operator cmd.
			cdClipCut(list[0].cmds[0], CD_CLIP_LIFT, 1)
			list.remove(0)

			if list.length > -1

				if list[0].typ = CD_CLIP_LIFT // If dragged and dropped, it should have a LIFT.

					cdClipDrop(list[0])
					list.remove(0)

				elseif list[0].typ = CD_CLIP_EDIT // If pasted, it should have an EDIT.

					if cd.clipMode = CD_CLIPMODE_UNDO
						cd.redos[0].typ = CD_CLIP_SNAP_LIFT
					endif
					
					// Using this to apply the changes.
					cdApplyPartEdit(list[0].attachCmd, list[0].attachPartIdx, list[0].part.info, false)

					// Save edit to help reconstruct the undo below at SNAP_LIFT.
					cd.tmpClip.attachCmd = list[0].attachCmd
					cd.tmpClip.attachPartIdx = list[0].attachPartIdx
					cd.tmpClip.cmds.length = -1
					cd.tmpClip.part = ma.cmds[cd.tmpClip.attachCmd].parts[cd.tmpClip.attachPartIdx]
					cdSaveCmds(CD_CLIP_EDIT)

					list.remove(0)

				endif

			endif
			
		elseif list[0].typ = CD_CLIP_LIFT

			// Put it back, from where it was lifted. Will only happen for redo.
			cdClipDrop(list[0])
			list.remove(0)

		elseif list[0].typ = CD_CLIP_EDIT

			// Grab the edit, so we can determine what to do.
			cd.tmpClip.attachCmd = list[0].attachCmd
			cd.tmpClip.attachPartIdx = list[0].attachPartIdx
			cd.tmpClip.cmds.length = -1
			cd.tmpClip.part = list[0].part
			list.remove(0)

			edit = true
			
			if list.length > -1

				// We have a snap lift, we need to reconstruct the undo.
				if list[0].typ = CD_CLIP_SNAP_LIFT

					cdSaveCmds(CD_CLIP_EDIT)
					
					// Put it back, from where it was lifted. Will only happen for redo.
					cdClipDrop(list[0])
					list.remove(0)

					edit = false

				endif

			endif

			if edit
				
				// Assuming this will put back the edit into the redo buffer.
				//cdApplyPartEdit(list[0].attachCmd, list[0].attachPartIdx, list[0].part.info, true)
				//list.remove(0)
				cdApplyPartEdit(cd.tmpClip.attachCmd, cd.tmpClip.attachPartIdx, cd.tmpClip.part.info, true)

			endif
			
		endif

		cdDrawCode("cc", 0)
		maSave()

	endif

//colog("AFTER")
//cdPrintUndoRedo()
	
endfunction

//-----------------------------------------------------
// Hide a list of cmds.
//
function cdHideCmds(cmds ref as integer[])

	local i as integer
	
	for i = 0 to cmds.length
		cdSetCmdVisible(cmds[i], false)
	next
	
endfunction

//-----------------------------------------------------
// Delete a list of cmds.
//
function cdDeleteCmds(cmds ref as integer[])

	local i as integer
	
	for i = 0 to cmds.length
		cdDeleteCmd(cmds[i])
	next
	
endfunction

//-----------------------------------------------------
// Delete a cmd.
//
function cdDeleteCmd(cmd as integer)

	if cmd
		cdDeleteCmdPtr(ma.cmds[cmd])
	endif
	
endfunction

//-----------------------------------------------------
// Delete a cmd by ptr.
//
function cdDeleteCmdPtr(cmd ref as Cmd)

	local i as integer

	if cmd.lt

		coDeleteSprite("cdDeleteCmdPtr:cmd.lt", cmd.lt)
		cmd.lt = 0

	endif

	if cmd.bg
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.bg", cmd.bg)
		cmd.bg = 0

	endif

	if cmd.rt
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.rt", cmd.rt)
		cmd.rt = 0

	endif

	if cmd.slt
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.slt", cmd.slt)
		cmd.slt = 0

	endif

	if cmd.sbg
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.sbg", cmd.sbg)
		cmd.sbg = 0

	endif

	if cmd.srt
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.srt", cmd.srt)
		cmd.srt = 0

	endif
	
	if cmd.sel

		coDeleteSprite("cdDeleteCmdPtr:cmd.sel", cmd.sel)
		cmd.sel = 0

	endif

	if cmd.fold
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.fold", cmd.fold)
		cmd.fold = 0

	endif

	if cmd.check
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.check", cmd.check)
		cmd.check = 0

	endif

	if cmd.icon
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.icon", cmd.icon)
		cmd.icon = 0

	endif

	if cmd.icon2
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.icon2", cmd.icon2)
		cmd.icon2 = 0

	endif

	if cmd.edge
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.edge", cmd.edge)
		cmd.edge = 0

	endif

	if cmd.sedge
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.sedge", cmd.sedge)
		cmd.sedge = 0

	endif

	if cmd.clip
		
		coDeleteSprite("cdDeleteCmdPtr:cmd.clip", cmd.clip)
		cmd.clip = 0

	endif

	
	for i = 0 to cmd.parts.length
		cdDeletePart(cmd.parts[i])
	next

	cmd.parts.length = -1

	if cmd.var

		//maDeleteVar(cmd.var)
		cmd.var = 0
		
	endif
	
	cmd.root = false
	cmd.foldable = false
	cmd.folded = false
	cmd.foldImg = 0
	cmd.checkable = false
	cmd.checked = false
	cmd.foldAlignment = CD_FOLD_LEFT
	cmd.checkAlignment = CD_CHECK_LEFT
	cmd.parent = 0
	
	maDeleteCmd(cmd.idx)
	
endfunction

//-----------------------------------------------------
// Simplifies creation of a command copy.
//
function cdCloneCmd(cmd as integer)

	local newCmd as integer

	newCmd = cdCloneCmdPtr(ma.cmds[cmd])

endfunction newCmd

//-----------------------------------------------------
// Clone via ptr.
//
function cdCloneCmdPtr(cmd ref as Cmd)

	local newCmd as integer
	
	newCmd = cdCreateCmd(cmd.code)
	cdCopyCmdPtr(cmd, ma.cmds[newCmd])

endfunction newCmd

//-----------------------------------------------------
// Clone a list of commands.
//
function cdCloneCmds(fromCmds ref as integer[], toCmds ref as integer[])

	local i as integer
	local cmd as integer
	
	for i = 0 to fromCmds.length

		cmd = cdCloneCmd(fromCmds[i])
		toCmds.insert(cmd)
		
	next
	
endfunction

//-----------------------------------------------------
// Convert a part to an int.
//
function cdGetPartAsInt(part ref as Part)

	local ret as integer

	ret = val(part.info)

endfunction ret

//-----------------------------------------------------
// Convert a part as a string.
//
function cdGetPartAsString(part ref as Part)

endfunction part.info

//-----------------------------------------------------
// Convert a part to an bool.
//
function cdGetPartAsBool(part ref as Part)

	local ret as integer

	if part.info = "true"
		ret = true
	else
		ret = false
	endif 

endfunction ret

//-----------------------------------------------------
// Convert a part to an int.
//
function cdGetPartAsFloat(part ref as Part)

	local ret as float

	ret = valfloat(part.info)

endfunction ret

//-----------------------------------------------------
// Copy from cmd into newCmd.
//
function cdCopyCmdPtr(cmd ref as Cmd, newCmd ref as Cmd)

	local childCmd as integer
	local newPart as Part
	local i as integer
	local partCmd as integer
	local thingIdx as integer
	local imgIdx as integer
	local varIdx as integer
	local appIdx as integer
	local soundIdx as integer
	local videoIdx as integer
	local pos as integer
	local depth as integer
	local sprId as string
	local imgId as string 
	local soundId as string
	local videoId as string
	
	for i = 0 to cmd.parts.length

		if cmd.parts[i].typ = PART_CMD
			
			partCmd = cdGetPartAsInt(cmd.parts[i])

			if partCmd
				
				childCmd = cdCloneCmd(partCmd)
				newPart = cdCreatePartCmd(childCmd)
				cdAddCmdPartPtr(newCmd, newPart)

			endif
			
		elseif cmd.parts[i].typ = PART_SPRITE_ICON

			//thingIdx = cdGetPartAsInt(cmd.parts[i])
			//newPart = cdCreatePartSprite(thingIdx)
			sprId = cdGetPartAsString(cmd.parts[i])
			newPart = cdCreatePartSprite(sprId)
			cdAddCmdPartPtr(newCmd, newPart)
			 			 
		elseif cmd.parts[i].typ = PART_FRAME_ICON

			imgId = cmd.parts[i].info
			thingIdx = cdGetPartFrameThing(imgId)
			newPart = cdCreatePartFrame(imgId)
			cdAddCmdPartPtr(newCmd, newPart)
			 
		elseif cmd.parts[i].typ = PART_APP_ICON

			appIdx = cdGetPartAsInt(cmd.parts[i])
			newPart = cdCreatePartApp(appIdx)
			cdAddCmdPartPtr(newCmd, newPart)			 
			 
		elseif cmd.parts[i].typ = PART_VAR_NAME

			varIdx = cdGetPartAsInt(cmd.parts[i])
			newPart = cdCreatePartVar(varIdx)
			cdAddCmdPartPtr(newCmd, newPart)
			 
		elseif cmd.parts[i].typ = PART_SOUND_NAME

			//soundIdx = cdGetPartAsInt(cmd.parts[i])
			//newPart = cdCreatePartSound(soundIdx)
			soundId = cdGetPartAsString(cmd.parts[i])
			newPart = cdCreatePartSound(soundId)
			cdAddCmdPartPtr(newCmd, newPart)
			 
		elseif cmd.parts[i].typ = PART_VIDEO_NAME

			//videoIdx = cdGetPartAsInt(cmd.parts[i])
			//newPart = cdCreatePartVideo(videoIdx)
			videoId = cdGetPartAsString(cmd.parts[i])
			newPart = cdCreatePartVideo(videoId)
			cdAddCmdPartPtr(newCmd, newPart)
			 
		else

			newPart = cdCreatePart(cmd.parts[i].typ, cmd.parts[i].info)
			cdAddCmdPartPtr(newCmd, newPart)

		endif
				
	next

	if cmd.fold

		cdSetCmdFoldAlignmentPtr(newCmd, cmd.foldAlignment)
		cdSetCmdFoldablePtr(newCmd, cmd.foldable)
		cdSetCmdFoldedPtr(newCmd, cmd.folded)
		cdSetCmdParentPtr(newCmd, cmd.idx)
		
	endif

	if cmd.check

		cdSetCmdCheckAlignmentPtr(newCmd, cmd.checkAlignment)
		cdSetCmdCheckablePtr(newCmd, cmd.checkable)
		cdSetCmdCheckedPtr(newCmd, cmd.checked)
		
	endif

	if cmd.code = CODE_VAR_GET

		if ma.vars[cmd.var].thingIdx = -1
			cdSetCmdIcon2Ptr(newCmd, cd.appVarImg)
		else
			cdSetCmdIcon2Ptr(newCmd, cd.spriteVarImg)
		endif
		
	endif
	
	if cmd.openCmd
		newCmd.openCmd = cmd.openCmd
	endif

	if cmd.closeCmd
		newCmd.closeCmd = cmd.closeCmd
	endif
	
	cdSetCmdAlphaPtr(newCmd, cmd.alpha)
	cdUpdateCmdSizePtr(newCmd)
	cdSetCmdDepthPtr(newCmd, cmd.depth)
	cdSetCmdPosPtr(newCmd, cmd.x, cmd.y)
		
endfunction newCmd

//-----------------------------------------------------
// Init a part.
//
function cdInitPart(part ref as Part, typ as integer)

	part.typ = typ
	part.vis = true
	part.active = true
	part.resized = false
	part.iconScale = 1.0

endfunction

//-----------------------------------------------------
// Create a cmd part.
//
function cdCreatePart(typ as integer, info as string)

	local part as Part

	part.idx = maCreatePart()

	cdInitPart(part, typ)
	cdSetPart(part, info)
	
endfunction part

//-----------------------------------------------------
// Delete the part internals, ready for reset.
//
function cdClearPart(part ref as Part)

	if part.spr
		
		coDeleteSprite("cdClearPart:part.spr", part.spr)
		part.spr = 0
		
	endif

	if part.icon
		
		coDeleteSprite("cdClearPart:part.icon", part.icon)
		part.icon = 0
		
	endif

	if part.lt
		
		coDeleteSprite("cdClearPart:part.lt", part.lt)
		part.lt = 0
		
	endif

	if part.rt
		
		coDeleteSprite("cdClearPart:part.rt", part.rt)
		part.rt = 0
		
	endif

	if part.text
		
		coDeleteText("cdClearPart:part.text", part.text)
		part.text = 0

	endif

	if part.img

		//ldDeleteImageCached(part.img, cd.imgCache)
		coDeleteImage("cdClearPart:part.img", part.img)
		part.img = 0

	endif

/*
	if part.var
		
		if ma.vars[part.var].name = ""
			
			maDeleteVar(part.var)
			part.var = 0
			
		endif
		
	endif
*/
	
endfunction

//-----------------------------------------------------
// Delete a part.
//
function cdDeletePart(part ref as Part)

	cdClearPart(part)

	if part.typ = PART_CMD
		cdDeleteCmd(cdGetPartAsInt(part))
	endif

	maDeletePart(part)
	
endfunction

//-----------------------------------------------------
// Set a cmd part value.
//
function cdSetPartCmd(part ref as Part, cmd as integer)

	part.typ = PART_CMD
	part.info = str(cmd)

	// No call to setPart, because it is built as part of the update size cmd.
	
endfunction

//-----------------------------------------------------
// Set a thing part value.
//
//function cdSetPartThing(part ref as Part, thing as integer)
function cdSetPartThing(part ref as Part, sprId as string)

	part.typ = PART_SPRITE_ICON
	//part.var = 0

	//cdSetPart(part, str(thing))
	cdSetPart(part, sprId)
	
endfunction

//-----------------------------------------------------
// Set a var part value.
//
function cdSetPartVar(part ref as Part, var as integer)

	part.typ = PART_VAR_NAME
	//part.var = 0

	cdSetPart(part, str(var))
	
endfunction

//-----------------------------------------------------
// Set a sound part value.
//
function cdSetPartSound(part ref as Part, sound as string)

	part.typ = PART_SOUND_NAME
	//part.var = 0

	cdSetPart(part, sound)
	
endfunction

//-----------------------------------------------------
// Set a video part value.
//
function cdSetPartVideo(part ref as Part, video as string)

	part.typ = PART_VIDEO_NAME
	//part.var = 0

	cdSetPart(part, video)

endfunction

//-----------------------------------------------------
// Set a sprite name part value.
//
//function cdSetPartSprite(part ref as Part, spr as integer)
function cdSetPartSprite(part ref as Part, sprId as string)

	part.typ = PART_SPRITE
	//cdSetPart(part, ma.things[spr].name)
	cdSetPart(part, sprId)

endfunction

//-----------------------------------------------------
// Set a part value. Always creates graphic components.
// Call clear first to reset.
// Note: Nothing to do for PART_CMD, because it is handled recursively when drawn.
//
function cdSetPart(part ref as Part, info as string)

	local thingIdx as integer
	local appIdx as integer
	local b as float
	local w as float
	local h as float
	local s as float
	local imgIdx as integer
	local imgId as string 
	local varIdx as integer
	local varName as string 
	local soundIdx as integer
	local soundName as string 
	local videoIdx as integer
	local videoName as string 
	local pos as integer
	local count as integer
	local i as integer
	local t as string
	//local font as integer
	local div as float
	local zs as float
	local col as integer
	local toks as string[]
	local sc as float // sprite scale.
	local sf as float // font scale.
	local sm as float
	local tmp as string 
	local tmpVal as integer
	local setTextCol as integer
	local setBoxCol as integer
	local empty as string
	local idxs as integer[]
		
	part.info = info
	part.w = 0
	part.h = 0

	sm = cd.cmdScales[ld.set.cmdSize]
	sc = sm * cd.zoomScale
	sf = sm * cd.zoomFontSize
	
	if part.typ = PART_IMG // file name.

		part.img = coloadimage("cdSetPart:part_img", part.info)
		part.spr = coCreateSprite("cdSetPart:part_img:part.spr", part.img)
		SetSpriteScale(part.spr, sc, sc)			
		
		part.w = GetSpriteWidth(part.spr)
		part.h = GetSpriteHeight(part.spr)

	elseif part.typ = PART_SPRITE_ICON or part.typ = PART_FRAME_ICON

		if part.typ = PART_SPRITE_ICON

			if info = ""
				thingIdx = -1
			else 
				//thingIdx = val(info)
				thingIdx = maFindThingById(cd.appIdx, info)
			endif

			if thingIdx > -1 and thingIdx <= ma.things.length
				imgIdx = ma.things[thingIdx].imgIdx
			else
				thingIdx = -1
			endif

		else // Frame.

			if info = ""
				
				thingIdx = -1
				
			else 

				thingIdx = cdGetPartFrameThing(info)
				imgId = cdGetPartFrameImage(info)

				if thingIdx > -1 and thingIdx <= ma.things.length
					//if imgIdx > ma.things[thingIdx].imgs.length
					if imgId <> ""
						//imgIdx = cdFindFrameIdxById(thingIdx, imgId)
						cdFindFrameIdxById(thingIdx, imgId, idxs)
						imgIdx = idxs[1]
					else
						imgIdx = 0
					endif
				else
					thingIdx = -1
				endif

			endif
			
		endif

		if thingIdx > -1 and imgIdx > -1 // We have a thing.

			b = co.bs * 1.5
			b = b * sc
			part.sprScale = b
			part.spr = guicreatebox("cdSetPart:part.spr", b, b)
			part.icon = coCreateSprite("cdSetPart:PART_SPRITE:part.icon", ma.things[thingIdx].imgs[imgIdx].thumb)
/*
			part.iconScale = sc
			SetSpriteScaleByOffset(part.icon, s, s)

			part.w = b
			part.h = b
*/
			
			w = GetSpriteWidth(part.icon)
			h = GetSpriteHeight(part.icon)
			s = sc

			if h > w
				if h > b
					s = b / h
				endif
			else //if w > h
				if w > b
					s = b / w
				endif
			endif

			s = s * 0.9

			part.iconScale = s
			SetSpriteScaleByOffset(part.icon, s, s)

			part.w = b
			part.h = b
			
		else // Drop point for a thing.

			part.spr = guicreatebox("setPart:part.spr", cd.textBoxWidth * sc, cd.textBoxHeight * sc)
			part.w = GetSpriteWidth(part.spr)
			part.h = GetSpriteHeight(part.spr)

		endif
		
	elseif part.typ = PART_APP_ICON or part.typ = PART_APP_INFO

		if info = ""
			appIdx = -1
		else 
			appIdx = val(info)
		endif

		if appIdx > -1 // We have an app.

			b = co.bs * 1.5

			if part.typ = PART_APP_INFO

				//if GetImageWidth(ma.apps[appIdx].img) < b * 0.9

				//	part.typ = PART_APP_ICON

				//else

					part.icon = coCreateSprite("cdSetPart:part_app:part.icon", ma.apps[appIdx].img)
					part.iconScale = 1.0

					b = GetSpriteWidth(part.icon) * 1.1
					part.sprScale = b			
					part.spr = guicreatebox("cdSetPart:part_app:part.icon", b, b)

					part.w = b
					part.h = b

				//endif

			endif
			
			if part.typ = PART_APP_ICON

				b = b * sc
				
				part.sprScale = b			
				part.spr = guicreatebox("cdSetPart:part_app:part.icon", b, b)
				part.icon = coCreateSprite("cdSetPart:part_app:part.icon", ma.apps[appIdx].img)

				w = GetSpriteWidth(part.icon)
				h = GetSpriteHeight(part.icon)
				s = sc

				if h > w
					if h > b
						s = b / h
					endif
				else //if w > h
					if w > b
						s = b / w
					endif
				endif

				s = s * 0.9

				part.iconScale = s
				SetSpriteScaleByOffset(part.icon, s, s)

				part.w = b
				part.h = b

			endif
						
		else

			part.spr = guicreatebox("setPart:part_app:part.spr", cd.textBoxWidth * sc, cd.textBoxHeight * sc)
			part.w = GetSpriteWidth(part.spr)
			part.h = GetSpriteHeight(part.spr)

		endif

		// Fix.
		part.typ = PART_APP_ICON
		
	elseif part.typ = PART_INT or part.typ = PART_FLOAT or part.typ = PART_TXT

		if part.typ = PART_INT or part.typ = PART_FLOAT			
			part.info = coTrimFloatStr(part.info)
		endif	

		part.text = guicreatetext2(part.info, sf)
		coSetTextColor(part.text, co.black)		
		w = GetTextTotalWidth(part.text)
		if w = 0 then w = (co.bs / 8) * sc
		h = GetTextTotalHeight(part.text)
		if h = 0 then h = cd.textBoxHeight * sc
		//part.spr = guicreatebox("setPart:part_int/float/txt/var/blk:part.spr", w, cd.textBoxHeight * cd.zoomScale)
		part.spr = guicreatebox("setPart:part_int/float/txt/var/blk:part.spr", w, h)
		coSetSpriteColor(part.spr, co.white)

		cdCreatePartEdges(part, CMD_OPER)

		part.w = GetSpriteWidth(part.lt) + GetSpriteWidth(part.spr) + GetSpriteWidth(part.rt)
		part.h = GetSpriteHeight(part.spr)

	elseif part.typ = PART_APP or part.typ = PART_SPRITE or part.typ = PART_FRAME or part.typ = PART_VAR or part.typ = PART_VALUE or part.typ = PART_LIST or part.typ = PART_SOUND or part.typ = PART_VIDEO or part.typ = PART_OBJ

		setTextCol = co.grey[5]
		setBoxCol = co.white
		
		if part.typ = PART_SPRITE

			//if part.info = cdGetEmptyPartValue(PART_SPRITE)
			//	part.info = ""
			//endif
			
			if part.info <> ""

				tmpVal = val(part.info)

				if tmpVal > -1 and tmpVal <= ma.things.length

					tmp = ma.things[tmpVal].name
					setTextCol = co.white
					setBoxCol = cd.cmdCols[GRP_SPRITE]

				else

					tmp = cdGetEmptyPartValue(PART_SPRITE)

				endif

			else

				tmp = cdGetEmptyPartValue(PART_SPRITE)

			endif

		elseif part.typ = PART_FRAME

			//if part.info = cdGetEmptyPartValue(PART_FRAME)
			//	part.info = ""
			//endif

			if part.info <> ""
				
				//tmpVal = cdFindFrameIdxById(-1, part.info)				
				cdFindFrameIdxById(-1, part.info, idxs)
				tmpVal = idxs[1]			
				tmp = str(tmpVal + 1)
				setTextCol = co.white
				setBoxCol = cd.cmdCols[GRP_SPRITE]

			else
				
				tmp = cdGetEmptyPartValue(PART_FRAME)
				
			endif
		
		else
			
			tmp = part.info
			empty = cdGetEmptyPartValue(part.typ)
			
			if tmp = ""				
				tmp = empty
			endif

			if tmp <> empty
				
				if part.typ = PART_OBJ
					
					coSplitString(toks, tmp, "|")
					tmp = toks[0]
					
					if toks.length > 0
						tmp = toks[1]
					endif
					
					if cdGetObjVarIndex(tmp) = -1 // Not found it, it's an actual value, not blank.
						
						setTextCol = co.white
						setBoxCol = cd.grpCols[GRP_APP]
						
					endif

				elseif part.typ = PART_VAR

					setTextCol = co.white
					setBoxCol = cd.cmdCols[GRP_VAR]

				elseif part.typ = PART_VALUE

					setTextCol = co.white
					setBoxCol = cd.cmdCols[GRP_VAR]

				elseif part.typ = PART_LIST

					setTextCol = co.white
					setBoxCol = cd.cmdCols[GRP_VAR]

				elseif part.typ = PART_SOUND

					setTextCol = co.white
					setBoxCol = cd.cmdCols[GRP_SOUND]

				elseif part.typ = PART_VIDEO

					setTextCol = co.white
					setBoxCol = cd.cmdCols[GRP_VIDEO]

				endif

			endif
			
		endif

		part.text = guicreatetext2(tmp, sf)

		coSetTextColor(part.text, setTextCol)
			
		w = GetTextTotalWidth(part.text)
		if w = 0 then w = (co.bs / 8) * sc
		part.spr = guicreatebox("setPart:part_int/float/txt/var/blk:part.spr", w, cd.textBoxHeight * sc)

		cosetspritecolor(part.spr, setBoxCol)		
		cdCreatePartEdges(part, CMD_OPER)

		part.w = GetSpriteWidth(part.lt) + GetSpriteWidth(part.spr) + GetSpriteWidth(part.rt)
		part.h = GetSpriteHeight(part.spr)

	elseif part.typ = PART_COL

		w = (co.bs / 4 + co.bs / 8) * sc
		part.spr = guicreatebox("setPart:part_col:part.spr", w, cd.textBoxHeight * sc)

		col = coMakeColor(part.info)
		coSetSpriteColor(part.spr, col)

		cdCreatePartEdges(part, CMD_OPER)
		
		part.w = GetSpriteWidth(part.lt) + GetSpriteWidth(part.spr) + GetSpriteWidth(part.rt)
		part.h = GetSpriteHeight(part.spr)

	elseif part.typ = PART_BOOL // Number editor.

		w = (co.bs / 8) * sc
		part.spr = guicreatebox("setPart:part_bool:part.spr", w, cd.textBoxHeight * sc)
		coSetSpriteColor(part.spr, co.white)

		cdCreatePartEdges(part, CMD_COND)
		
		part.w = GetSpriteWidth(part.lt) + GetSpriteWidth(part.spr) + GetSpriteWidth(part.rt)
		part.h = GetSpriteHeight(part.spr)
						
	elseif part.typ = PART_VAR_NAME

		if info = ""
			varIdx = -1
		else
			varIdx = val(info)
		endif

		if varIdx > -1 and varIdx <= ma.vars.length // We have a var.
			varName = ma.vars[varIdx].name
		else
			varName = "No var"
		endif
		
		//part.text = guicreatetext2(info, font, cd.zoomFontSize)
		part.text = guicreatetext2(varName, sf)
		coSetTextColor(part.text, co.white)
		part.w = GetTextTotalWidth(part.text)
		part.h = GetTextTotalHeight(part.text)

		// Make sure there is room for the text, and it's not too small as per a text box.
		if part.h < cd.textBoxHeight * sc	
			part.h = cd.textBoxHeight * sc
		endif
		
	elseif part.typ = PART_SOUND_NAME

		if info = ""
			soundIdx = -1
		else 
			soundIdx = maFindSoundById(cd.appIdx, info) // val(info)
		endif

		if soundIdx > -1 and soundIdx <= ma.sounds.length
			soundName = ma.sounds[soundIdx].name
		else
			soundName = "No sound"
		endif
		
		//part.text = guicreatetext2(info, font, cd.zoomFontSize)
		part.text = guicreatetext2(soundName, sf)
		coSetTextColor(part.text, co.white)
		part.w = GetTextTotalWidth(part.text)
		part.h = GetTextTotalHeight(part.text)

		// Make sure there is room for the text, and it's not too small as per a text box.
		if part.h < cd.textBoxHeight * sc
			part.h = cd.textBoxHeight * sc
		endif
		
	elseif part.typ = PART_VIDEO_NAME

		if info = ""
			videoIdx = -1
		else
			videoIdx = maFindVideoById(cd.appIdx, info) // val(info)
		endif

		if videoIdx > -1 and videoIdx <= ma.videos.length
			videoName = ma.videos[videoIdx].name
		else
			videoName = "No video"
		endif
		
		//part.text = guicreatetext2(info, font, cd.zoomFontSize)
		part.text = guicreatetext2(videoName, sf)
		coSetTextColor(part.text, co.white)
		part.w = GetTextTotalWidth(part.text)
		part.h = GetTextTotalHeight(part.text)

		// Make sure there is room for the text, and it's not too small as per a text box.
		if part.h < cd.textBoxHeight * sc	
			part.h = cd.textBoxHeight * sc
		endif
		
	elseif part.typ = PART_STR // Just plain text.

		info = coReplaceTildes(info, chr(10))
		part.text = guicreatetext2(info,  sf)		
		coSetTextColor(part.text, co.white)
		part.w = GetTextTotalWidth(part.text)
		part.h = GetTextTotalHeight(part.text)

		// Make sure there is room for the text, and it's not too small as per a text box.
		if part.h < cd.textBoxHeight * sc			
			part.h = cd.textBoxHeight * sc
		endif

	endif
	
endfunction part

//-----------------------------------------------------
// Get the empty part value for a specific part typ.
//
function cdGetEmptyPartValue(typ as integer)

	local ret as string
	
	if typ = PART_STR
		ret = ""
	elseif typ = PART_IMG
		ret = ""
	elseif typ = PART_INT
		ret = "0"
	elseif typ = PART_FLOAT
		ret = "0.0"
	elseif typ = PART_BOOL
		ret = "false"
	elseif typ = PART_COL
		ret = "#000000"
	elseif typ = PART_TXT
		ret = ""
	elseif typ = PART_SPRITE
		ret = OBJ_VAR_SPRITE
	elseif typ = PART_FRAME
		ret = OBJ_VAR_FRAME
	elseif typ = PART_OBJ
		ret = ""
	elseif typ = PART_CMD
		ret = ""
	elseif typ = PART_VAR
		ret = OBJ_VAR_VAR
	elseif typ = PART_VALUE
		ret = OBJ_VAR_VALUE
	elseif typ = PART_LIST
		ret = OBJ_VAR_LIST
	elseif typ = PART_SOUND
		ret = "sound"
	elseif typ = PART_VIDEO
		ret = "video"
	else
		ret = ""
	endif
	
endfunction ret

//-----------------------------------------------------
// Create the edges part.
//
function cdCreatePartEdges(part ref as Part, cmdTyp as integer)

	local s as float
	local col as integer

	s = GetSpriteHeight(part.spr) / GetImageHeight(cd.edgeImgs[cmdTyp])

	col = cogetspritecolor(part.spr)
	
	if part.lt
		
		coDeleteSprite("cdCreatePartEdges:part.lt", part.lt)
		part.lt = 0
		
	endif
	
	part.lt = coCreateSprite("cdCreatePartEdges:part.lt", cd.edgeImgs[cmdTyp])
	SetSpriteVisible(part.lt, part.vis)
	SetSpriteAnimation(part.lt, GetImageWidth(cd.edgeImgs[cmdTyp]) / 2, GetImageHeight(cd.edgeImgs[cmdTyp]), 2)
	SetSpriteFrame(part.lt, 1)
	coSetSpriteColor(part.lt, col)
	SetSpriteScale(part.lt, s, s)

	if part.rt
		
		coDeleteSprite("cdCreatePartEdges:part.rt", part.rt)
		part.rt = 0
		
	endif

	part.rt = coCreateSprite("cdCreatePartEdges:part.rt", cd.edgeImgs[cmdTyp])
	SetSpriteVisible(part.rt, part.vis)
	SetSpriteAnimation(part.rt, GetImageWidth(cd.edgeImgs[cmdTyp]) / 2, GetImageHeight(cd.edgeImgs[cmdTyp]), 2)
	SetSpriteFrame(part.rt, 2)
	coSetSpriteColor(part.rt, col)
	SetSpriteScale(part.rt, s, s)
		
endfunction

//-----------------------------------------------------
// Create a cmd part.
//
function cdCreatePartCmd(cmd as integer)

	local part as part

	cdInitPart(part, PART_CMD)
	part.info = str(cmd)

	// NOTE: We don't set the part here.
	
endfunction part

//-----------------------------------------------------
// Create a var part.
//
function cdCreatePartVar(varIdx as integer)

	local part as part

	cdInitPart(part, PART_VAR_NAME)
	cdSetPart(part, str(varIdx))

endfunction part

//-----------------------------------------------------
// Create a thing part.
//
//function cdCreatePartSprite(thingIdx as integer)
function cdCreatePartSprite(sprId as string)

	local part as part

	cdInitPart(part, PART_SPRITE_ICON)
	//cdSetPart(part, str(thingIdx))
	cdSetPart(part, sprId)

endfunction part

//-----------------------------------------------------
// Create a sound part.
//
function cdCreatePartSound(soundId as string)

	local part as part

	cdInitPart(part, PART_SOUND_NAME)
	cdSetPart(part, soundId)

endfunction part

//-----------------------------------------------------
// Create a sound part.
//
function cdCreatePartVideo(videoId as string)

	local part as part

	cdInitPart(part, PART_VIDEO_NAME)
	cdSetPart(part, videoId)

endfunction part

//-----------------------------------------------------
// Create an image part.
//
function cdCreatePartFrame(imgId as string)

	local part as part
	cdInitPart(part, PART_FRAME_ICON)
	cdSetPart(part, imgId)
	
endfunction part

//-----------------------------------------------------
// Get the thing idx of the image part.
//
function cdGetPartFrameThing(info as string)
	
	local ret as integer
	local i as integer
	local j as integer
	local appIdx as integer
	local thingIdx as integer

	ret = -1

	if cd.appIdx > -1
		appIdx = cd.appIdx
	elseif ld.loadingAppIdx > -1
		appIdx = ld.loadingAppIdx
	endif
	
	for i = 0 to ma.apps[appIdx].sprites.length

		thingIdx = ma.apps[appIdx].sprites[i]

		for j = 0 to ma.things[thingIdx].imgs.length

			if ma.things[thingIdx].imgs[j].id = info
				
				ret = thingIdx
				exit

			endif
			
		next

		if ret > -1
			exit
		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Find a frame index by thing and id.
//
function cdFindFrameIdxById(thingIdx as integer, frameId as string, ret ref as integer[])

	//local ret as integer
	local i as integer
	local j as integer
	local appIdx as integer

	ret.length = -1

	if thingIdx = -1

		if cd.appIdx > -1
			appIdx = cd.appIdx
		elseif ld.loadingAppIdx > -1
			appIdx = ld.loadingAppIdx
		endif

		if appIdx > -1
			
			for j = 0 to ma.apps[appIdx].sprites.length

				thingIdx = ma.apps[appIdx].sprites[j]
				
				for i = 0 to ma.things[thingIdx].imgs.length

					if ma.things[thingIdx].imgs[i].id = frameId

						ret.insert(thingIdx)
						ret.insert(i)
						//ret = i
						exit

					endif
					
				next

				//if ret > -1
				if ret.length > -1 // Found it.
					exit
				endif

			next
			
		endif

	else
		
		for i = 0 to ma.things[thingIdx].imgs.length

			if ma.things[thingIdx].imgs[i].id = frameId

				ret.insert(thingIdx)
				ret.insert(i)
				//ret = i
				exit

			endif
			
		next

	endif

	if ret.length = -1

		ret.insert(-1)
		ret.insert(-1)

	endif

endfunction //ret

//-----------------------------------------------------
// Get the image idx of the image part.
//
function cdGetPartFrameImage(info as string)

endfunction info

//-----------------------------------------------------
// Create an image part.
//
function cdMakePartFrameInfo(thingIdx as integer, imgId as string)

endfunction imgId

//-----------------------------------------------------
// Create an app part.
//
function cdCreatePartApp(appIdx as integer)

	local part as part

	cdInitPart(part, PART_APP_ICON)
	cdSetPart(part, str(appIdx))

endfunction part

//-----------------------------------------------------
// Add a part.
//
function cdAddCmdPart(cmd as integer, part ref as Part)

	cdAddCmdPartPtr(ma.cmds[cmd], part)
	
endfunction

//-----------------------------------------------------
// Add a part ptr.
//
function cdAddCmdPartPtr(cmd ref as Cmd, part ref as Part)

	cdSetPartVisible(part, cmd.vis)

	cmd.parts.insert(part)
	
	cdUpdateCmdSizePtr(cmd)
	cdSetCmdPosPtr(cmd, cmd.x, cmd.y)
	cdSetCmdDepthPtr(cmd, cmd.depth)
	
endfunction

//-----------------------------------------------------
// Add a part.
//
function cdSetCmdPart(cmd as integer, part ref as Part, partIdx as integer)

	cdSetCmdPartPtr(ma.cmds[cmd], part, partIdx)
	
endfunction

//-----------------------------------------------------
// Add a part ptr.
//
function cdSetCmdPartPtr(cmd ref as Cmd, part ref as Part, partIdx as integer)

	cdSetPartVisible(part, cmd.vis)

	//cdClearPart(cmd.parts[partIdx])
	//cdSetPart(cmd.parts[partIdx], part.info)

	// a, b, c
	// partIdx = 1 (b)
	
	if partIdx <= cmd.parts.length
			
		cdDeletePart(cmd.parts[partIdx])
		cmd.parts.remove(partIdx)
		
	endif
	
	// a, c
	// partIdx = 1
	
	if cmd.parts.length > -1 and partIdx <= cmd.parts.length
		cmd.parts.insert(part, partIdx)
	else 
		cmd.parts.insert(part) // Append, insert with idx won't work.
	endif
	
	cdUpdateCmdSizePtr(cmd)
	cdSetCmdPosPtr(cmd, cmd.x, cmd.y)
	cdSetCmdDepthPtr(cmd, cmd.depth)
	
endfunction

//-----------------------------------------------------
// Attach cmd to thing at attCmd point with attCmdDir (N or S). If attCmd is blank, append.
//
function cdAttachCmd1(thing as integer, currCmd as integer, attachCmd as integer, attachDir as integer)

	local currCmds as integer[]

	currCmds.insert(currCmd)
	cdAttachCmd(thing, currCmds, attachCmd, attachDir)
	
endfunction

//-----------------------------------------------------
// Attach list of cmds to thing at attCmd point with attCmdDir (N or S). If attCmd is blank, append.
//
function cdAttachCmd(thing as integer, currCmds ref as integer[], attachCmd as integer, attachDir as integer)

	local lastCmd as integer
	local idx as integer
	local i as integer
	local root as integer

	// If we have an insert location.
	if attachCmd

		if attachDir = DIR_N

			idx = cdFindThingCmd(thing, attachCmd, 0)

			for i = 0 to currCmds.length

				if i = 0

					if ma.cmds[attachCmd].root
				
						ma.cmds[currCmds[i]].x = cdGetCmdPosX(attachCmd)
						ma.cmds[currCmds[i]].y = cdGetCmdPosY(attachCmd)
						ma.cmds[currCmds[i]].root = true
						ma.cmds[attachCmd].root = false

					endif

				endif
				
				if idx <= ma.things[thing].cmds.length
					ma.things[thing].cmds.insert(currCmds[i], idx)
				else
					ma.things[thing].cmds.insert(currCmds[i])
				endif
				
				inc idx

			next

		else // attachCmd = DIR_S

			idx = cdFindThingCmd(thing, attachCmd, 0)
			inc idx

			for i = 0 to currCmds.length

				if idx <= ma.things[thing].cmds.length
					ma.things[thing].cmds.insert(currCmds[i], idx)
				else
					ma.things[thing].cmds.insert(currCmds[i])
				endif
				
				inc idx

			next

			
		endif

		cd.tmpClip.cmds = cd.currCmds
		cd.tmpClip.attachCmd = attachCmd
		cd.tmpClip.attachPartIdx = -1
		cd.tmpClip.attachDir = attachDir
		cd.tmpClip.isRoot = false
		cdSaveCmds(CD_CLIP_DROP)

	//elseif cdIsElseCode(ma.cmds[currCmds[0]].code)

		//cdDeleteCmds(currCmds)
			
	else // Append, new root.
		
		for i = 0 to currCmds.length

			if i = 0
				ma.cmds[currCmds[i]].root = true
			endif
					
			ma.things[thing].cmds.insert(currCmds[i]) // Append.
			
		next

		cd.tmpClip.cmds = cd.currCmds
		cd.tmpClip.attachCmd = 0
		cd.tmpClip.attachPartIdx = -1
		cd.tmpClip.attachDir = 0
		cd.tmpClip.isRoot = true
		cdSaveCmds(CD_CLIP_DROP)

	endif
	
endfunction

//-----------------------------------------------------
// Check if we have the highest depth yet.
//
function cdCheckTopDepth(depth as integer)

	//if depth < cd.topDepth
	//	cd.topDepth = depth
	//endif

	if depth < ma.things[cd.thingIdx].topDepth
		ma.things[cd.thingIdx].topDepth = depth
	endif
	
endfunction

//-----------------------------------------------------
//
function cdSetCmdDepth(cmd as integer, depth as integer)

	local ret as integer
	
	ret = cdSetCmdDepthPtr(ma.cmds[cmd], depth)
	
endfunction ret

//-----------------------------------------------------
//
function cdSetCmdDepthPtr(cmd ref as Cmd, depth as integer)

	local ret as integer
	local tmp as integer
	local i as integer

	cmd.prevDepth = cmd.depth
	cmd.depth = depth

	if cmd.sbg
		
		SetSpriteDepth(cmd.slt, depth)
		SetSpriteDepth(cmd.srt, depth)
		SetSpriteDepth(cmd.sbg, depth)

	endif

	if cmd.sedge		
		SetSpriteDepth(cmd.sedge, depth)
	endif

	depth = depth - 2

	if cmd.edge		
		SetSpriteDepth(cmd.edge, depth)
	endif

	if cmd.clip //and cmd.clipMode = 1 // Don't bring up if mode = 2	
		SetSpriteDepth(cmd.clip, depth)
	endif
	
	depth = depth - 2

	if cmd.sel
		SetSpriteDepth(cmd.sel, depth)
	endif
	
	depth = depth - 2

	if cmd.lt
		SetSpriteDepth(cmd.lt, depth)
	endif
	
	if cmd.rt
		SetSpriteDepth(cmd.rt, depth)
	endif
	
	if cmd.bg
		SetSpriteDepth(cmd.bg, depth)
	endif

	depth = depth - 2

	if cmd.fold
		SetSpriteDepth(cmd.fold, depth)
	endif

	if cmd.check
		SetSpriteDepth(cmd.check, depth)
	endif

	if cmd.icon
		SetSpriteDepth(cmd.icon, depth)
	endif

	if cmd.icon2		
		SetSpriteDepth(cmd.icon2, depth - 2)		
	endif

	ret = depth // Top depth of the cmd, excluding parts.

	for i = 0 to cmd.parts.length
		
		tmp = cdSetPartDepth(cmd.parts[i], depth)
		
		if tmp < ret
			ret = tmp // Now top depth is the part depth.
		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
//
function cdSetPartVisible(part ref as Part, vis as integer)

	local partCmd as integer

	part.vis = vis

	if not part.active
		part.vis = false
	endif
	
	if part.lt
		SetSpriteVisible(part.lt, part.vis)
	endif

	if part.rt
		SetSpriteVisible(part.rt, part.vis)
	endif

	if part.spr
		SetSpriteVisible(part.spr, part.vis)
	endif

	if part.icon
		SetSpriteVisible(part.icon, part.vis)
	endif
	
	if part.text
		SetTextVisible(part.text, part.vis)
	endif

	if part.typ = PART_CMD

		partCmd = cdGetPartAsInt(part)
		
		if partCmd
			cdSetCmdVisible(partCmd, part.vis)
		endif

	endif

endfunction

//-----------------------------------------------------
//
function cdSetPartDepth(part ref as Part, depth as integer)

	local ret as integer
	local tmp as integer
	local partCmd as integer

	ret = depth

	if part.typ = PART_CMD

		partCmd = cdGetPartAsInt(part)
		
		if partCmd
			
			SetSpriteDepth(part.spr, depth)
			SetSpriteDepth(part.lt, depth)
			SetSpriteDepth(part.rt, depth)
			
			depth = depth - 2
			ret = depth
			
			tmp = cdSetCmdDepthPtr(ma.cmds[partCmd], depth)
			
			if tmp < ret
				ret = tmp
			endif

		endif
		
	elseif part.typ = PART_IMG

		if part.spr
			SetSpriteDepth(part.spr, depth)
		endif
		
	elseif part.typ = PART_SPRITE_ICON

		if part.spr
			SetSpriteDepth(part.spr, depth)
		endif

		depth = depth - 2
		ret = depth

		if part.icon
			SetSpriteDepth(part.icon, depth)
		endif

	elseif part.typ = PART_FRAME_ICON

		if part.spr
			SetSpriteDepth(part.spr, depth)
		endif
		
		depth = depth - 2
		ret = depth

		if part.icon
			SetSpriteDepth(part.icon, depth)
		endif
		
	elseif part.typ = PART_APP_ICON

		if part.spr
			SetSpriteDepth(part.spr, depth)
		endif

		depth = depth - 2
		ret = depth

		if part.icon
			SetSpriteDepth(part.icon, depth)
		endif

	elseif part.typ = PART_INT or part.typ = PART_FLOAT or part.typ = PART_TXT or part.typ = PART_APP or part.typ = PART_SPRITE or part.typ = PART_FRAME or part.typ = PART_VAR or part.typ = PART_VALUE or part.typ = PART_LIST or part.typ = PART_SOUND or part.typ = PART_VIDEO or part.typ = PART_BOOL or part.typ = PART_COL or part.typ = PART_OBJ

		if part.spr
			
			SetSpriteDepth(part.spr, depth)
			SetSpriteDepth(part.lt, depth)
			SetSpriteDepth(part.rt, depth)

		endif
		
		depth = depth - 2
		ret = depth

		if part.text
			SetTextDepth(part.text, depth)
		endif
		
	elseif part.typ = PART_VAR_NAME or part.typ = PART_SOUND_NAME or part.typ = PART_VIDEO_NAME

		if part.text
			SetTextDepth(part.text, depth)
		endif
				
	elseif part.typ = PART_STR

		if part.text
			SetTextDepth(part.text, depth)
		endif
				
	endif

endfunction ret

//-----------------------------------------------------
//
function cdSetCmdScissor(cmd as integer, x0 as float, y0 as float, x1 as float, y1 as float)
	
	cdSetCmdScissorPtr(ma.cmds[cmd], x0, y0, x1, y1)
	
endfunction

//-----------------------------------------------------
//
function cdSetCmdScissorPtr(cmd ref as Cmd, x0 as float, y0 as float, x1 as float, y1 as float)

	local i as integer

	cmd.x0 = x0
	cmd.y0 = y0
	cmd.x1 = x1
	cmd.y1 = y1
	
	coSetSpriteScissor(cmd.slt, x0, y0, x1, y1)
	coSetSpriteScissor(cmd.srt, x0, y0, x1, y1)
	coSetSpriteScissor(cmd.sbg, x0, y0, x1, y1)

	coSetSpriteScissor(cmd.lt, x0, y0, x1, y1)
	coSetSpriteScissor(cmd.rt, x0, y0, x1, y1)
	coSetSpriteScissor(cmd.bg, x0, y0, x1, y1)

	if cmd.fold
		SetSpriteScissor(cmd.fold, x0, y0, x1, y1)
	endif

	if cmd.check
		SetSpriteScissor(cmd.check, x0, y0, x1, y1)
	endif

	if cmd.sel
		SetSpriteScissor(cmd.sel, x0, y0, x1, y1)
	endif

	if cmd.icon
		SetSpriteScissor(cmd.icon, x0, y0, x1, y1)
	endif

	if cmd.icon2
		SetSpriteScissor(cmd.icon2, x0, y0, x1, y1)
	endif

	if cmd.edge
		SetSpriteScissor(cmd.edge, x0, y0, x1, y1)
	endif
		
	if cmd.sedge
		SetSpriteScissor(cmd.sedge, x0, y0, x1, y1)
	endif

	if cmd.clip
		SetSpriteScissor(cmd.clip, x0, y0, x1, y1)
	endif

	for i = 0 to cmd.parts.length		
		cdSetPartScissor(cmd.parts[i], x0, y0, x1, y1)
	next
	
endfunction

//-----------------------------------------------------
//
function cdSetPartScissor(part ref as Part, x0 as float, y0 as float, x1 as float, y1 as float)

	local partCmd as integer
	
	if part.spr
		SetSpriteScissor(part.spr, x0, y0, x1, y1)
	endif
	
	if part.icon
		SetSpriteScissor(part.icon, x0, y0, x1, y1)
	endif

	if part.lt
		SetSpriteScissor(part.lt, x0, y0, x1, y1)
	endif

	if part.rt
		SetSpriteScissor(part.rt, x0, y0, x1, y1)
	endif

	if part.text
		SettextScissor(part.text, x0, y0, x1, y1)
	endif

	if part.typ = PART_CMD

		partCmd = cdGetPartAsInt(part)
		
		if partCmd
			cdSetCmdScissor(partCmd, x0, y0, x1, y1)
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
//
function cdGetCmdPosX(cmd as integer)

	local x as float
	
	x = cdGetCmdPosXPtr(ma.cmds[cmd])
	
endfunction x

//-----------------------------------------------------
// Get the pos y of a button.
//
function cdGetCmdPosXPtr(cmd ref as Cmd)

endfunction cmd.x// - cmd.ox

//-----------------------------------------------------
//
function cdGetCmdPosY(cmd as integer)

	local y as float
	
	y = cdGetCmdPosYPtr(ma.cmds[cmd])
	
endfunction y

//-----------------------------------------------------
// Get the width of a button.
//
function cdGetCmdPosYPtr(cmd ref as Cmd)

endfunction cmd.y// - cmd.oy

//-----------------------------------------------------
//
function cdGetCmdWidth(cmd as integer)

	local w as float
	
	w = cdGetCmdWidthPtr(ma.cmds[cmd])
	
endfunction w

//-----------------------------------------------------
// Get the pos y of a button.
//
function cdGetCmdWidthPtr(cmd ref as Cmd)

endfunction cmd.w// - cmd.ox

//-----------------------------------------------------
//
function cdGetCmdHeight(cmd as integer)

	local h as float
	
	h = cdGetCmdHeightPtr(ma.cmds[cmd])
	
endfunction h

//-----------------------------------------------------
// Get the cmd height.
//
function cdGetCmdHeightPtr(cmd ref as Cmd)

endfunction cmd.h// - cmd.ox

//-----------------------------------------------------
// Get a sprite width considering zoom.
//
function cdGetSpriteWidth(spr as integer)

	local ret as float

	if spr
		ret = GetSpriteWidth(spr)
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
// Get a sprite width considering zoom.
//
function cdGetSpriteHeight(spr as integer)

	local ret as float

	if spr
		ret = GetSpriteHeight(spr)
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
// Create the edge for the cmd.
//
function cdSetCmdEdge(cmd as integer, dist as float)

	cdSetCmdEdgePtr(ma.cmds[cmd], dist)
	
endfunction

//-----------------------------------------------------
// Create the edge for the cmd.
//
function cdSetCmdEdgePtr(cmd ref as Cmd, dist as float)

	local sc as float
	
	if not cmd.edge
		
		cmd.edge = guiCreateBox("cdSetCmdEdgePtr:cmd.edge", 1, 1	)
		SetSpriteVisible(cmd.edge, cmd.vis)
		//cmd.sedge = guiCreateBox("cdSetCmdEdgePtr:cmd.sedge", 1, 1)
		//SetSpriteVisible(cmd.sedge, false)
		
	endif

	sc = cd.cmdScales[ld.set.cmdSize] * cd.zoomScale
	
	setspritescale(cmd.edge, (CD_CODE_INDENT - CD_CMD_GAP) * sc, dist)
	cosetspritecolor(cmd.edge, coGetSpriteColor(cmd.bg))

	if cmd.sedge
		
		setspritescale(cmd.sedge, (CD_CODE_INDENT - CD_CMD_GAP) * sc, dist)
		cosetspritecolorwithalpha(cmd.sedge, co.black, gui.shadowAlpha)

	endif

	cdSetCmdDepthPtr(cmd, cmd.depth)
	
endfunction

//-----------------------------------------------------
// Create the clip for the cmd.
//
function cdSetCmdClip(cmd as integer, mode as integer, dist as float)

	cdSetCmdClipPtr(ma.cmds[cmd], mode, dist)
	
endfunction

//-----------------------------------------------------
// Create the clip for the cmd.
//
function cdSetCmdClipPtr(cmd ref as Cmd, mode as integer, dist as float)

	local sc as float

	cmd.clipMode = mode
	
	if mode > 0 and not cmd.clip
		
		cmd.clip = guiCreateBox("cmd.clip", 1, 1)
		cosetspritecolor(cmd.clip, coGetSpriteColor(cmd.bg))
			
	elseif mode = 0 and cmd.clip
		
		DeleteSprite(cmd.clip)
		cmd.clip = 0
		//cdSetCmdDepthPtr(cmd, cmd.depth)
		
	endif

	cdSetCmdDepthPtr(cmd, cmd.depth)

	if cmd.clip	
			
		sc = cd.cmdScales[ld.set.cmdSize] * cd.zoomScale	
		//setspritescale(cmd.clip, CD_CMD_GAP * 2 * sc, (cmd.h / 2 + CD_CMD_GAP) * sc)
		//SetSpritePositionByOffset(cmd.clip, getposx(cmd.icon), getposy(cmd.icon) - cdGetSpriteHeight(cmd.clip) / 2 - CD_CMD_GAP / 2)
		setspritescale(cmd.clip, CD_CMD_GAP * 2 * sc, dist)
		SetSpritePositionByOffset(cmd.clip, getposx(cmd.icon), getspritey(cmd.bg) - cdGetSpriteHeight(cmd.clip) / 2)
		SetSpriteVisible(cmd.clip, cmd.vis)
		
	endif
	
endfunction

//-----------------------------------------------------
// Save the cmd pos.
//
function cdSaveCmdPos(cmd as integer)

	cdSaveCmdPosPtr(ma.cmds[cmd])
	
endfunction

//-----------------------------------------------------
// Save the cmd pos.
//
function cdSaveCmdPosPtr(cmd ref as Cmd)

	cmd.xx = cmd.x
	cmd.yy = cmd.y
	
endfunction

//-----------------------------------------------------
// Save the cmd pos.
//
function cdRestoreCmdPos(cmd as integer)

	cdRestoreCmdPosPtr(ma.cmds[cmd])
	
endfunction

//-----------------------------------------------------
// Save the cmd pos.
//
function cdRestoreCmdPosPtr(cmd ref as Cmd)

	cmd.x = cmd.xx
	cmd.y = cmd.yy
	
endfunction

//-----------------------------------------------------
//
function cdSetCmdPos(cmd as integer, x as float, y as float)

	cdSetCmdPosPtr(ma.cmds[cmd], x, y)
	
endfunction

//-----------------------------------------------------
// Set the pos of a cmd.
//
function cdSetCmdPosPtr(cmd ref as Cmd, x as float, y as float)
	
	local i as integer
	local yy as float
	local cmdGap as float
	local shadGap as float
	local textOff as float
	local partCmd as integer
	local spec as integer
	local postSpecX as float
	local sc as float
	local sm as float
	local cx as float
	
	cmdGap = CD_CMD_GAP
	shadGap = CD_CMD_GAP / 2
	textOff = CD_TEXT_OFF

	//if cmd.typ && CMD_SPEC
	//	sm = 1.0
	//else 
		sm = cd.cmdScales[ld.set.cmdSize]
	//endif
	
	sc = sm * cd.zoomScale		
	cmdGap = cmdGap * sc
	shadGap = shadGap * sc
	textOff = textOff * sc
	
	spec = false
	postSpecX = 0

	cmd.x = x
	cmd.y = y
	
	x = cmd.x
	y = cmd.y
	yy = y

	if cmd.sel
		SetSpritePosition(cmd.sel, x - cmdGap * 2, y - cmdGap * 2)
	endif

	if cmd.edge
		SetSpritePositionByOffset(cmd.edge, x + cdGetSpriteWidth(cmd.edge) / 2, y + getspriteheight(cmd.edge) / 2 + cmd.h / 2)
	endif

	if cmd.sedge
		SetSpritePositionByOffset(cmd.sedge, x + cdGetSpriteWidth(cmd.sedge) / 2 + shadGap, y + getspriteheight(cmd.sedge) / 2 + cmd.h / 2 + shadGap)
	endif
	
	if cmd.lt
		SetSpritePositionByOffset(cmd.lt, x + cdGetSpriteWidth(cmd.lt) / 2, y + cmd.h / 2)
	endif
	
	if cmd.lt and cmd.slt	
		SetSpritePositionByOffset(cmd.slt, x + cdGetSpriteWidth(cmd.lt) / 2 + shadGap, y + cmd.h / 2 + shadGap)
	endif
	
	if cmd.lt
		x = x + cdGetSpriteWidth(cmd.lt)
	endif
	
	if cmd.bg
		SetSpritePositionByOffset(cmd.bg, x + cdGetSpriteWidth(cmd.bg) / 2, y + cmd.h / 2)
	endif

	if cmd.bg and cmd.sbg
		SetSpritePositionByOffset(cmd.sbg, x + cdGetSpriteWidth(cmd.bg) / 2 + shadGap, y + cmd.h / 2 + shadGap)
	endif

	if cmd.check and cmd.checkAlignment = CD_CHECK_LEFT
		
		SetSpritePositionByOffset(cmd.check, x + cdGetSpriteWidth(cmd.check) / 2, y + cmd.h / 2)
		x = x + cdGetSpriteWidth(cmd.check) + cmdGap
		
	endif

	if cmd.fold and cmd.foldAlignment = CD_FOLD_LEFT
		
		SetSpritePositionByOffset(cmd.fold, x + cdGetSpriteWidth(cmd.fold) / 2, y + cmd.h / 2)
		x = x + cdGetSpriteWidth(cmd.fold) + cmdGap
		
	endif

	if cmd.check and cmd.checkAlignment = CD_CHECK_AFTER_FOLD
		
		SetSpritePositionByOffset(cmd.check, x + cdGetSpriteWidth(cmd.check) / 2, y + cmd.h / 2)
		x = x + cdGetSpriteWidth(cmd.check) + cmdGap
		
	endif
	
	if cmd.icon
		
		cx =  x - cmdGap + cdGetSpriteWidth(cmd.icon) / 2
		
		SetSpritePositionByOffset(cmd.icon, cx, y + cmd.h / 2)

		if cmd.icon2			
			SetSpritePositionByOffset(cmd.icon2, x + cdGetSpriteWidth(cmd.icon2) / 2, y + cmd.h / 2)
		endif

		x = x + cdGetSpriteWidth(cmd.icon) //- cmdGap

	endif

	if cmd.clip
		//SetSpritePositionByOffset(cmd.clip, getposx(cmd.icon), getposy(cmd.icon) - cdGetSpriteHeight(cmd.clip) / 2 - CD_CMD_GAP / 2)
		SetSpritePositionByOffset(cmd.clip, getposx(cmd.icon), getspritey(cmd.bg) - cdGetSpriteHeight(cmd.clip) / 2)
	endif

	for i = 0 to cmd.parts.length

		if cmd.parts[i].typ = PART_STR
			
			if cmd.parts[i].text
				if (cmd.typ && CMD_SPEC)
					SettextPosition(cmd.parts[i].text, x, y)
				else
					SettextPosition(cmd.parts[i].text, x, y + cmd.h / 2 - cmd.parts[i].h / 2 - textOff)
				endif
			endif
				
		elseif cmd.parts[i].typ = PART_VAR_NAME or cmd.parts[i].typ = PART_SOUND_NAME or cmd.parts[i].typ = PART_VIDEO_NAME
			
			SettextPosition(cmd.parts[i].text, x, y + cmd.h / 2 - cmd.parts[i].h / 2 - textOff)
			
		elseif cmd.parts[i].typ = PART_IMG
			
			//if (cmd.typ && CMD_THING) or (cmd.typ && CMD_APP)
			if cmd.parts[i].spr
				if (cmd.typ && CMD_SPEC)
					SetSpritePositionByOffset(cmd.parts[i].spr, x + cmd.parts[i].w / 2, y + cmd.parts[i].h / 2)
				else
					SetSpritePositionByOffset(cmd.parts[i].spr, x + cmd.parts[i].w / 2, y + cmd.h / 2)
				endif
			endif
			
		elseif cmd.parts[i].typ = PART_APP_ICON or cmd.parts[i].typ = PART_SPRITE_ICON or cmd.parts[i].typ = PART_FRAME_ICON

			SetSpritePositionByOffset(cmd.parts[i].spr, x + cmd.parts[i].w / 2, y + cmd.h / 2)
			if cmd.parts[i].icon
				setpos(cmd.parts[i].icon, x + cmd.parts[i].w / 2, y + cmd.h / 2)
			endif

			spec = true
			postSpecX = x + GetSpriteWidth(cmd.parts[i].spr)
			
		elseif cmd.parts[i].typ = PART_INT or cmd.parts[i].typ = PART_FLOAT or cmd.parts[i].typ = PART_TXT or cmd.parts[i].typ = PART_APP or cmd.parts[i].typ = PART_SPRITE or cmd.parts[i].typ = PART_FRAME or cmd.parts[i].typ = PART_VAR or cmd.parts[i].typ = PART_VALUE or cmd.parts[i].typ = PART_LIST or cmd.parts[i].typ = PART_SOUND or cmd.parts[i].typ = PART_VIDEO or cmd.parts[i].typ = PART_OBJ

			SetSpritePositionByOffset(cmd.parts[i].lt, x + cdGetSpriteWidth(cmd.parts[i].lt) / 2, y + cmd.h / 2)
			SetSpritePositionByOffset(cmd.parts[i].spr, x + cmd.parts[i].w / 2, y + cmd.h / 2)
			SetSpritePositionByOffset(cmd.parts[i].rt, x + cmd.parts[i].w - cdGetSpriteWidth(cmd.parts[i].rt) / 2, y + cmd.h / 2)
			SettextPosition(cmd.parts[i].text, x + cdGetSpriteWidth(cmd.parts[i].lt), y + cmd.h / 2 - cmd.parts[i].h / 2 - textOff)

		elseif cmd.parts[i].typ = PART_BOOL or cmd.parts[i].typ = PART_COL

			SetSpritePositionByOffset(cmd.parts[i].lt, x + cdGetSpriteWidth(cmd.parts[i].lt) / 2, y + cmd.h / 2)
			SetSpritePositionByOffset(cmd.parts[i].spr, x + cmd.parts[i].w / 2, y + cmd.h / 2)
			SetSpritePositionByOffset(cmd.parts[i].rt, x + cmd.parts[i].w - cdGetSpriteWidth(cmd.parts[i].rt) / 2, y + cmd.h / 2)
			//SettextPosition(cmd.parts[i].text, x + cdGetSpriteWidth(cmd.parts[i].lt), y + cmd.h / 2 - cmd.parts[i].h / 2 - textOff)

		elseif cmd.parts[i].typ = PART_CMD

			partCmd = cdGetPartAsInt(cmd.parts[i])
			
			if partCmd
							
				//cdSetCmdPos(partCmd, x, y + cmdGap)
				cdSetCmdPos(partCmd, x, y + cmd.h / 2 - ma.cmds[partCmd].h / 2)
				SetSpritePositionByOffset(cmd.parts[i].lt, x - cmdGap / 2 + cdGetSpriteWidth(cmd.parts[i].lt) / 2, y + cmd.h / 2)
				SetSpritePositionByOffset(cmd.parts[i].spr, x + cmd.parts[i].w / 2, y + cmd.h / 2)
				SetSpritePositionByOffset(cmd.parts[i].rt, x + cmd.parts[i].w + cmdGap / 2 - cdGetSpriteWidth(cmd.parts[i].rt) / 2, y + cmd.h / 2)
				
			endif
			
		endif
		
		x = x + cmd.parts[i].w		
		
	next

	if cmd.check and cmd.checkAlignment = CD_CHECK_RIGHT
		
		x = x + cmdGap
		SetSpritePositionByOffset(cmd.check, x + cdGetSpriteWidth(cmd.check) / 2, y + cmd.h / 2)
		x = x + cdGetSpriteWidth(cmd.check) //+ cmdGap
		
	endif

	if cmd.fold and cmd.foldAlignment = CD_FOLD_RIGHT

		if spec
			
			SetSpritePositionByOffset(cmd.fold, cmdGap + postSpecX + cmdGap + cdGetSpriteWidth(cmd.fold) / 2, y + cmd.h / 2)
			x = x + cmd.foldExtra //+ cmdGap
			
		else
				
			x = x + cmdGap //* 2
			SetSpritePositionByOffset(cmd.fold, x + cdGetSpriteWidth(cmd.fold) / 2, y + cmd.h / 2)
			x = x + cdGetSpriteWidth(cmd.fold) //+ cmdGap
			
		endif

		
	endif

	if cmd.rt
		SetSpritePositionByOffset(cmd.rt, x + cdGetSpriteWidth(cmd.rt) / 2, yy + cmd.h / 2)
	endif
	
	if cmd.srt
		SetSpritePositionByOffset(cmd.srt, x + cdGetSpriteWidth(cmd.srt) / 2 + shadGap, yy + cmd.h / 2 + shadGap)
	endif
	
endfunction

//-----------------------------------------------------
//
function cdSetCmdScale(cmd as integer)

	cdSetCmdScalePtr(ma.cmds[cmd])
	
endfunction

//-----------------------------------------------------
// Set the scale of a cmd.
//
function cdSetCmdScalePtr(cmd ref as Cmd)

	local i as integer
	local sw as float
	local sh as float
	local childCmd as integer
	local s as float

	for i = 0 to cmd.parts.length

		if cmd.parts[i].typ = PART_CMD
			
			childCmd = cdGetPartAsInt(cmd.parts[i])

			if childCmd
				cdSetCmdScale(childCmd)
			endif

		else

			// Force a refresh.
			cdClearPart(cmd.parts[i])
			cdSetPart(cmd.parts[i], cmd.parts[i].info)

		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Show/hide cmd.
//
function cdGetCmdVisible(cmd as integer)

	local ret as integer
	
	ret = cdGetCmdVisiblePtr(ma.cmds[cmd])
	
endfunction ret

//-----------------------------------------------------
// Show/hide cmd.
//
function cdGetCmdVisiblePtr(cmd ref as Cmd)

endfunction cmd.vis

//-----------------------------------------------------
// Show/hide cmd.
//
function cdSetCmdVisible(cmd as integer, vis as integer)

	cdSetCmdVisiblePtr(ma.cmds[cmd], vis)
	
endfunction

//-----------------------------------------------------
// Show/hide cmd by ptr.
//
function cdSetCmdVisiblePtr(cmd ref as Cmd, vis as integer)

	local i as integer
	local partCmd as integer

	if not cmd.active
		exitfunction
	endif
	
	cmd.vis = vis

	if cmd.lt
		SetSpriteVisible(cmd.lt, vis)
	endif
	
	if cmd.rt
		SetSpriteVisible(cmd.rt, vis)
	endif
	
	if cmd.bg
		SetSpriteVisible(cmd.bg, vis)
	endif

	if cmd.fold
		SetSpriteVisible(cmd.fold, vis and cmd.foldable)
	endif

	if cmd.check
		SetSpriteVisible(cmd.check, vis and cmd.checkable)
	endif
	
	if cmd.sel
		if cmd.selected
			SetSpriteVisible(cmd.sel, vis)
		else
			SetSpriteVisible(cmd.sel, false)
		endif
	endif
	
	if cmd.icon
		SetSpriteVisible(cmd.icon, vis)
	endif

	if cmd.icon2
		SetSpriteVisible(cmd.icon2, vis)
	endif

	if cmd.edge
		SetSpriteVisible(cmd.edge, vis)
	endif

	if cmd.clip
		SetSpriteVisible(cmd.clip, vis)
	endif
	
	for i = 0 to cmd.parts.length
		cdSetPartVisible(cmd.parts[i], vis)		
	next

	if not vis
		
		cdSetCmdShadowVisiblePtr(cmd, vis) // Cmd invisible implies shadow invisible.
		cdSetCmdHoverPtr(cmd, vis) // Cmd invisible implies selected invisible.

	endif
		
endfunction

//-----------------------------------------------------
// Set alpha.
//
function cdSetCmdAlpha(cmd as integer, alpha as integer)

	cdSetCmdAlphaPtr(ma.cmds[cmd], alpha)
	
endfunction

//-----------------------------------------------------
// Show/hide cmd by ptr.
//
function cdSetCmdAlphaPtr(cmd ref as Cmd, alpha as integer)

	local i as integer
	local partCmd as integer
	
	cmd.alpha = alpha

	if cmd.lt then SetSpriteColorAlpha(cmd.lt, alpha)	
	if cmd.rt then SetSpriteColorAlpha(cmd.rt, alpha)
	if cmd.bg then SetSpriteColorAlpha(cmd.bg, alpha)

	if cmd.check
		SetSpriteColorAlpha(cmd.check, alpha)
	endif

	if cmd.fold
		SetSpriteColorAlpha(cmd.fold, alpha)
	endif

	if cmd.sel
		SetSpriteColorAlpha(cmd.sel, alpha)
	endif

	if cmd.icon
		SetSpriteColorAlpha(cmd.icon, alpha)
	endif

	if cmd.icon2
		SetSpriteColorAlpha(cmd.icon2, alpha)
	endif

	if cmd.edge
		SetSpriteColorAlpha(cmd.edge, alpha)
	endif

	if cmd.clip
		SetSpriteColorAlpha(cmd.clip, alpha)
	endif
	
	for i = 0 to cmd.parts.length
		cdSetPartAlpha(cmd.parts[i], alpha)
	next
		
endfunction

//-----------------------------------------------------
// Set alpha for a single cmd part.
//
function cdSetCmdPartAlpha(cmd as integer, partIdx as integer, alpha as integer)

	cdSetCmdPartAlphaPtr(ma.cmds[cmd], partIdx, alpha)
	
endfunction

//-----------------------------------------------------
// Set the alpha for a single cmd part by ptr.
//
function cdSetCmdPartAlphaPtr(cmd ref as Cmd, partIdx as integer, alpha as integer)

	local i as integer
	
	for i = 0 to cmd.parts.length

		if i = partIdx
			
			cdSetPartAlpha(cmd.parts[i], alpha)
			exit
			
		endif
		
	next
		
endfunction

//-----------------------------------------------------
// Set the alpha for a part.
//
function cdSetPartAlpha(part ref as Part, alpha as integer)

	if part.lt
		SetSpriteColorAlpha(part.lt, alpha)
	endif

	if part.rt
		SetSpriteColorAlpha(part.rt, alpha)
	endif

	if part.spr
		SetSpriteColorAlpha(part.spr, alpha)
	endif

	if part.icon
		SetSpriteColorAlpha(part.icon, alpha)
	endif
	
	if part.text
		SetTextColorAlpha(part.text, alpha)
	endif

	if part.typ = PART_CMD
		cdSetCmdAlpha(cdGetPartAsInt(part), alpha)
	endif

endfunction

//-----------------------------------------------------
// Color cmd.
//
function cdSetCmdColor(cmd as integer, col as integer)

	cdSetCmdColorPtr(ma.cmds[cmd], col)
	
endfunction

//-----------------------------------------------------
// Color cmd by ptr.
//
function cdSetCmdColorPtr(cmd ref as Cmd, col as integer)

	coSetSpriteColor(cmd.lt, col)
	coSetSpriteColor(cmd.rt, col)
	coSetSpriteColor(cmd.bg, col)

	if cmd.edge
		coSetSpriteColor(cmd.edge, col)
	endif

	if cmd.clip
		coSetSpriteColor(cmd.clip, col)
	endif
	
endfunction

//-----------------------------------------------------
// Show/hide highlight.
//
function cdSetCmdHover(cmd as integer, sel as integer)

	cdSetCmdHoverPtr(ma.cmds[cmd], sel)
	
endfunction

//-----------------------------------------------------
// Show/hide highlight by ptr.
//
function cdSetCmdHoverPtr(cmd ref as Cmd, dir as integer)

	local x as float
	local y as float
	local partTyp as integer
	local cmdTyp as integer
	local col as integer
	local s as float
	local depth as integer
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local panel as integer
	local sc as float

	sc = cd.cmdScales[ld.set.cmdSize] * CD_CMD_GAP
	
	if dir
		
		cd.attachCmd = cmd.idx
		cd.attachDir = dir

		col = co.black
		x = GetSpriteXByOffset(cmd.bg)
		y = GetSpriteYByOffset(cmd.bg)
		depth = getspritedepth(cmd.bg) // Slot in between bg and edge depth.

		if cd.cmdSelLt
			
			coDeleteSprite("cdSetCmdHoverPtr:cd.cmdSelLt", cd.cmdSelLt)
			cd.cmdSelLt = 0
			
		endif
		
		cd.cmdSelLt = coclonesprite("cdSetCmdHoverPtr:cd.cmdSelLt", cmd.lt)
		cosetspritecolor(cd.cmdSelLt, col)
		SetSpriteDepth(cd.cmdSelLt, depth + 1)

		if cd.cmdSelRt
			
			coDeleteSprite("cdSetCmdHoverPtr:cd.cmdSelRt", cd.cmdSelRt)
			cd.cmdSelRt = 0
			
		endif

		cd.cmdSelRt = coclonesprite("cdSetCmdHoverPtr:cd.cmdSelRt", cmd.rt)
		cosetspritecolor(cd.cmdSelRt, col)
		SetSpriteDepth(cd.cmdSelRt, depth + 1)
		
		cosetspritecolor(cd.cmdSelMid, col)
		//SetSpriteScale(cd.cmdSelMid, getspritewidth(ma.cmds[cmd].parts[partIdx].spr) + CD_CMD_GAP * 2, getspriteheight(ma.cmds[cmd].parts[partIdx].spr) + CD_CMD_GAP * 2)
		SetSpriteScale(cd.cmdSelMid, getspritewidth(cmd.bg) + sc, getspriteheight(cmd.bg) + sc * 2)
		SetSpriteDepth(cd.cmdSelMid, depth + 1)
		
		// Calculate the relative size increase for the selection.
		//s = GetSpriteHeight(ma.cmds[cmd].parts[partIdx].spr) / GetSpriteHeight(cd.cmdSelLt)
		s = (GetSpriteHeight(cmd.bg) + sc * 2) / GetImageHeight(cd.edgeImgs[cmdTyp])
		SetSpriteScale(cd.cmdSelLt, s, s)
		SetSpriteScale(cd.cmdSelRt, s, s)
		SetSpritePositionByOffset(cd.cmdSelLt, x - GetSpriteWidth(cd.cmdSelMid) / 2 - GetSpriteWidth(cd.cmdSelLt) / 2, y)
		SetSpritePositionByOffset(cd.cmdSelMid, x, y)
		SetSpritePositionByOffset(cd.cmdSelRt, x + GetSpriteWidth(cd.cmdSelMid) / 2 + GetSpriteWidth(cd.cmdSelRt) / 2, y)
		
		x0 = cd.codePanel.vx
		y0 = cd.codePanel.vy
		x1 = x0 + cd.codePanel.vw - 1
		y1 = y0 + cd.codePanel.vh - 1
		
		SetSpriteScissor(cd.cmdSelLt, x0, y0, x1, y1)
		SetSpriteScissor(cd.cmdSelMid, x0, y0, x1, y1)
		SetSpriteScissor(cd.cmdSelRt, x0, y0, x1, y1)

		SetSpriteVisible(cd.cmdSelLt, true)
		SetSpriteVisible(cd.cmdSelMid, true)
		SetSpriteVisible(cd.cmdSelRt, true)

	endif
	
endfunction

//-----------------------------------------------------
// Show/hide highlight for a part.
//
function cdSetPartSelected(cmd as integer, partIdx as integer)

	local x as float
	local y as float
	local partTyp as integer
	local cmdTyp as integer
	local col as integer
	local s as float
	local depth as integer
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local panel as integer
	local sc as float

	sc = cd.cmdScales[ld.set.cmdSize] * CD_CMD_GAP

	cd.attachCmd = cmd
	cd.attachPartIdx = partIdx

	partTyp = ma.cmds[cmd].parts[partIdx].typ
	
	if partTyp = PART_BOOL
		cmdTyp = CMD_COND
	elseif partTyp <> PART_STR
		cmdTyp = CMD_OPER
	else
		cmdTyp = -1
	endif

	if cmdTyp > -1

		col = co.black
		x = GetSpriteXByOffset(ma.cmds[cmd].parts[partIdx].spr)
		y = GetSpriteYByOffset(ma.cmds[cmd].parts[partIdx].spr)
		depth = getspritedepth(ma.cmds[cmd].parts[partIdx].spr)

		if cd.cmdSelLt
			
			coDeleteSprite("cdSetPartSelected:cd.cmdSelLt", cd.cmdSelLt)
			cd.cmdSelLt = 0
			
		endif
		
		cd.cmdSelLt = coclonesprite("cdSetPartSelected:cd.cmdSelLt", ma.cmds[cmd].parts[partIdx].lt)
		cosetspritecolor(cd.cmdSelLt, col)
		SetSpriteDepth(cd.cmdSelLt, depth + 1)

		if cd.cmdSelRt
			
			coDeleteSprite("cdSetPartSelected:cd.cmdSelRt", cd.cmdSelRt)
			cd.cmdSelRt = 0
			
		endif

		cd.cmdSelRt = coclonesprite("cdSetPartSelected:cd.cmdSelRt", ma.cmds[cmd].parts[partIdx].rt)
		cosetspritecolor(cd.cmdSelRt, col)
		SetSpriteDepth(cd.cmdSelRt, depth + 1)
		
		cosetspritecolor(cd.cmdSelMid, col)
		//SetSpriteScale(cd.cmdSelMid, getspritewidth(ma.cmds[cmd].parts[partIdx].spr) + CD_CMD_GAP * 2, getspriteheight(ma.cmds[cmd].parts[partIdx].spr) + CD_CMD_GAP * 2)
		SetSpriteScale(cd.cmdSelMid, getspritewidth(ma.cmds[cmd].parts[partIdx].spr) + sc, getspriteheight(ma.cmds[cmd].parts[partIdx].spr) + sc * 2)
		SetSpriteDepth(cd.cmdSelMid, depth + 1)

		// Calculate the relative size increase for the selection.
		//s = GetSpriteHeight(ma.cmds[cmd].parts[partIdx].spr) / GetSpriteHeight(cd.cmdSelLt)
		s = (GetSpriteHeight(ma.cmds[cmd].parts[partIdx].spr) + sc * 2) / GetImageHeight(cd.edgeImgs[cmdTyp])
		SetSpriteScale(cd.cmdSelLt, s, s)
		SetSpriteScale(cd.cmdSelRt, s, s)
		SetSpritePositionByOffset(cd.cmdSelLt, x - GetSpriteWidth(cd.cmdSelMid) / 2 - GetSpriteWidth(cd.cmdSelLt) / 2, y)
		SetSpritePositionByOffset(cd.cmdSelMid, x, y)
		SetSpritePositionByOffset(cd.cmdSelRt, x + GetSpriteWidth(cd.cmdSelMid) / 2 + GetSpriteWidth(cd.cmdSelRt) / 2, y)
		
		x0 = cd.codePanel.vx
		y0 = cd.codePanel.vy
		x1 = x0 + cd.codePanel.vw - 1
		y1 = y0 + cd.codePanel.vh - 1
		
		SetSpriteScissor(cd.cmdSelLt, x0, y0, x1, y1)
		SetSpriteScissor(cd.cmdSelMid, x0, y0, x1, y1)
		SetSpriteScissor(cd.cmdSelRt, x0, y0, x1, y1)

		SetSpriteColorAlpha(cd.cmdSelLt, 255)
		SetSpriteColorAlpha(cd.cmdSelMid, 255)
		SetSpriteColorAlpha(cd.cmdSelRt, 255)
		
		SetSpriteVisible(cd.cmdSelLt, true)
		SetSpriteVisible(cd.cmdSelMid, true)
		SetSpriteVisible(cd.cmdSelRt, true)

	endif

endfunction cd.attachDir

//-----------------------------------------------------
// Show/hide highlight for a part.
//
function cdSetButtonIconSelected(but ref as Button)

	local x as float
	local y as float
	local col as integer
	local depth as integer

	col = co.black
	x = GetSpriteXByOffset(but.icon)
	y = GetSpriteYByOffset(but.icon)
	depth = getspritedepth(but.icon)

	if cd.cmdSelLt
		
		coDeleteSprite("cdSetPartSelected:cd.cmdSelLt", cd.cmdSelLt)
		cd.cmdSelLt = 0
		
	endif
	
	if cd.cmdSelRt
		
		coDeleteSprite("cdSetPartSelected:cd.cmdSelRt", cd.cmdSelRt)
		cd.cmdSelRt = 0
		
	endif
	
	cosetspritecolor(cd.cmdSelMid, col)
	//SetSpriteScale(cd.cmdSelMid, getspritewidth(ma.cmds[cmd].parts[partIdx].spr) + CD_CMD_GAP * 2, getspriteheight(ma.cmds[cmd].parts[partIdx].spr) + CD_CMD_GAP * 2)
	SetSpriteScale(cd.cmdSelMid, getspritewidth(but.icon) + CD_CMD_GAP * 2, getspriteheight(but.icon) + CD_CMD_GAP * 2)
	SetSpriteDepth(cd.cmdSelMid, depth + 1)	
	SetSpriteColorAlpha(cd.cmdSelMid, 255)
	SetSpritePositionByOffset(cd.cmdSelMid, x, y)
	SetSpriteVisible(cd.cmdSelMid, true)

endfunction

//-----------------------------------------------------
// Show/hide highlight.
//
function cdHideCmdHover()

	cd.attachCmd = 0
	cd.attachPartIdx = -1
	cd.attachDir = 0
	
	if cd.cmdSelLt
		SetSpriteVisible(cd.cmdSelLt, false)
	endif
	
	if cd.cmdSelMid
		SetSpriteVisible(cd.cmdSelMid, false)
	endif
	
	if cd.cmdSelRt
		SetSpriteVisible(cd.cmdSelRt, false)
	endif
	
endfunction

//-----------------------------------------------------
// Show/hide highlight.
//
function cdHideThingHover()

	SetSpriteVisible(cd.thingSel, false)
	SetSpriteVisible(cd.thingSelArr, false)
	
endfunction

//-----------------------------------------------------
// Show/hide highlight.
//
function cdSetThingHover(cmd as integer, dir as integer, panel ref as Panel)

	cdSetThingHoverPtr(ma.cmds[cmd], dir, panel)
	
endfunction

//-----------------------------------------------------
// Show/hide highlight by ptr.
//
function cdSetThingHoverPtr(cmd ref as Cmd, dir as integer, panel ref as Panel)

	local x as float
	local y as float
	local depth as integer
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local size as float
	local sc as float
	local sm as float

	sm = cd.cmdScales[ld.set.cmdSize]
	sc = sm * CD_CMD_GAP
	
	if dir
		
		cd.attachCmd = cmd.idx
		cd.attachDir = dir

		x = GetSpriteXByOffset(cmd.bg)
		y = GetSpriteYByOffset(cmd.bg)
		depth = getspritedepth(cmd.bg) // Slot in between bg and edge depth.
		SetSpriteDepth(cd.thingSel, depth + 1)
		SetSpriteDepth(cd.thingSelArr, depth + 2)

		if cmd.typ && CMD_SPEC
			
			size = sc * 4
			SetSpriteScale(cd.thingSelArr, sm * 1.0, sm * 1.0)
			
		else
			
			size = sc * 2
			SetSpriteScale(cd.thingSelArr, sm * 0.6, sm * 0.6)

		endif
		
		SetSpriteScale(cd.thingSel, cmd.w + size, cmd.h + size)
		SetSpritePositionByOffset(cd.thingSel, x, y)

		if dir = DIR_N

			SetSpriteAngle(cd.thingSelArr, 0)
			//SetSpritePositionByOffset(cd.thingSelArr, x, y - getspriteheight(cd.thingSel) / 2)
			SetSpritePositionByOffset(cd.thingSelArr, x - GetSpriteWidth(cd.thingSel) / 2 + GetSpriteWidth(cd.thingSelArr) / 3, y - getspriteheight(cd.thingSel) / 2)

		elseif dir = DIR_S

			SetSpriteAngle(cd.thingSelArr, 180)
			//SetSpritePositionByOffset(cd.thingSelArr, x, y + getspriteheight(cd.thingSel) / 2)
			SetSpritePositionByOffset(cd.thingSelArr, x - GetSpriteWidth(cd.thingSel) / 2 + GetSpriteWidth(cd.thingSelArr) / 3, y + getspriteheight(cd.thingSel) / 2)

		endif

		//SetSpriteScale(cd.thingSel, cmd.w + CD_CMD_GAP * 4, CD_CMD_GAP * 2)

		//if dir = DIR_N
		//	SetSpritePositionByOffset(cd.thingSel, x, cmd.y - co.bs / 8 - CD_CMD_GAP)
		//elseif dir = DIR_S
		//	SetSpritePositionByOffset(cd.thingSel, x, cmd.y + cmd.h + co.bs / 8 + CD_CMD_GAP)
		//endif
		
		x0 = panel.vx
		y0 = panel.vy
		x1 = x0 + panel.vw - 1
		y1 = y0 + panel.vh - 1
		
		SetSpriteScissor(cd.thingSel, x0, y0, x1, y1)
		SetSpriteVisible(cd.thingSel, true)
		SetSpriteScissor(cd.thingSelArr, x0, y0, x1, y1)
		SetSpriteVisible(cd.thingSelArr, true)

	endif
	
endfunction

//-----------------------------------------------------
// Show/hide cmd.
//
function cdSetCmdShadowVisible(cmd as integer, vis as integer)

	cdSetCmdShadowVisiblePtr(ma.cmds[cmd], vis)
	
endfunction

//-----------------------------------------------------
// Show/hide cmd by ptr.
//
function cdSetCmdShadowVisiblePtr(cmd ref as Cmd, vis as integer)

	cmd.shadowVis = vis

	if cmd.slt
		SetSpriteVisible(cmd.slt, vis)
	endif
	
	if cmd.srt
		SetSpriteVisible(cmd.srt, vis)
	endif
	
	if cmd.sbg
		SetSpriteVisible(cmd.sbg, vis)
	endif

	if cmd.sedge
		SetSpriteVisible(cmd.sedge, vis)
	endif
	
endfunction

//-----------------------------------------------------
// Set the command parent for folding.
//
function cdSetCmdParent(cmd as integer, parent as integer)

	cdSetCmdParentPtr(ma.cmds[cmd], parent)
	
endfunction

//-----------------------------------------------------
// Set the command parent for folding.
//
function cdSetCmdParentPtr(cmd ref as Cmd, parent as integer)

	cmd.parent = parent
	
endfunction

//-----------------------------------------------------
// Set the command selected color.
//
function cdSetCmdSelectedColor(cmd as integer, col as integer)

	cdSetCmdSelectedColorPtr(ma.cmds[cmd], col)
	
endfunction

//-----------------------------------------------------
// Select the command selected color.
//
function cdSetCmdSelectedColorPtr(cmd ref as Cmd, col as integer)

	cmd.selCol = col
	cosetspritecolor(cmd.sel, cmd.selCol)
	
endfunction

//-----------------------------------------------------
// Get the command selection.
//
function cdGetCmdSelected(cmd as integer)

	local ret as integer
	
	ret = cdGetCmdSelectedPtr(ma.cmds[cmd])
	
endfunction ret

//-----------------------------------------------------
// Get the command selection.
//
function cdGetCmdSelectedPtr(cmd ref as Cmd)

	local ret as integer

	ret = cmd.selected

endfunction ret

//-----------------------------------------------------
// Select the command.
//
function cdSetCmdSelected(cmd as integer, sel as integer)

	cdSetCmdSelectedPtr(ma.cmds[cmd], sel)
	
endfunction

//-----------------------------------------------------
// Select the command.
//
function cdSetCmdSelectedPtr(cmd ref as Cmd, sel as integer)

	local sc as float

	sc = cd.cmdScales[ld.set.cmdSize] * CD_CMD_GAP
	
	cmd.selected = sel

	if cmd.selected and not cmd.sel

		cmd.sel = guiCreateBox("cdSetCmdSelectedPtr:cmd.sel", 1, 1)
		cosetspritecolor(cmd.sel, cmd.selCol)
		SetSpriteScale(cmd.sel, cmd.w + sc * 4, cmd.h + sc * 4)
		
		if cmd.sbg
			cdSetCmdDepthPtr(cmd, GetSpriteDepth(cmd.sbg))
		endif
		
		cdSetCmdPosPtr(cmd, cmd.x, cmd.y)
		
	endif

	cdSetCmdVisiblePtr(cmd, cmd.vis)
	
endfunction

//-----------------------------------------------------
// Select the command.
//
function cdSetCmdFoldable(cmd as integer, foldable as integer)

	cdSetCmdFoldablePtr(ma.cmds[cmd], foldable)
	
endfunction

//-----------------------------------------------------
// Select the command is foldable.
//
function cdSetCmdFoldablePtr(cmd ref as Cmd, foldable as integer)

	local img as integer
	local sc as float
	
	cmd.foldable = foldable
	
	if cmd.foldable and not cmd.fold

		if cmd.foldImg
			img = cmd.foldImg
		else
			img = cd.foldImg
		endif
		
		cmd.fold = coCreateSprite("cdSetCmdFoldablePtr:cmd.fold", img)

		sc = cd.cmdScales[ld.set.cmdSize]
		
		if cmd.typ && CMD_SPEC
			SetSpriteScale(cmd.fold, sc * 0.75, sc * 0.75)
		else 
			SetSpriteScale(cmd.fold, sc * 0.5, sc * 0.5)
		endif
		
		//cdSetCmdDepthPtr(cmd, GetSpriteDepth(cmd.sbg))
		cdSetCmdDepthPtr(cmd, cmd.depth)
		cdSetCmdPosPtr(cmd, cmd.x, cmd.y)		

	elseif (not cmd.foldable) and cmd.fold

		coDeleteSprite("cdSetCmdFoldablePtr:cmd.fold", cmd.fold)
		cmd.fold = 0
		
	endif

	cdUpdateCmdSizePtr(cmd)
	cdSetCmdVisiblePtr(cmd, cmd.vis)
	
endfunction

//-----------------------------------------------------
// Get if the command folded.
//
function cdGetCmdFolded(cmd as integer)

	local ret as integer
	
	ret = cdGetCmdFoldedPtr(ma.cmds[cmd])
	
endfunction ret

//-----------------------------------------------------
// Get if the command folded.
//
function cdGetCmdFoldedPtr(cmd ref as Cmd)

endfunction cmd.folded

//-----------------------------------------------------
// Select the command.
//
function cdSetCmdFolded(cmd as integer, folded as integer)

	cdSetCmdFoldedPtr(ma.cmds[cmd], folded)
	
endfunction

//-----------------------------------------------------
// Select the command folded.
//
function cdSetCmdFoldedPtr(cmd ref as Cmd, folded as integer)

	cmd.folded = folded

	if cmd.fold

		if cmd.folded
			SetSpriteAngle(cmd.fold, -90)
		else
			SetSpriteAngle(cmd.fold, 0)
		endif
				
	endif
	
endfunction

//-----------------------------------------------------
// Set the folded img.
//
function cdSetCmdFoldImg(cmd as integer, foldImg as integer)

	cdSetCmdFoldImgPtr(ma.cmds[cmd], foldImg)
	
endfunction

//-----------------------------------------------------
// Select the fold img.
//
function cdSetCmdFoldImgPtr(cmd ref as Cmd, foldImg as integer)

	cmd.foldImg = foldImg
	
endfunction

//-----------------------------------------------------
// Get if the command checked.
//
function cdGetCmdChecked(cmd as integer)

	local ret as integer
	
	ret = cdGetCmdCheckedPtr(ma.cmds[cmd])
	
endfunction ret

//-----------------------------------------------------
// Get if the command checked.
//
function cdGetCmdCheckedPtr(cmd ref as Cmd)

endfunction cmd.checked

//-----------------------------------------------------
// Select the check alignment.
//
function cdSetCmdCheckAlignment(cmd as integer, checkAlignment as integer)

	cdSetCmdCheckAlignmentPtr(ma.cmds[cmd], checkAlignment)
	
endfunction

//-----------------------------------------------------
// Select the command check alignment.
// checkAlignment:
// 0 for very left/before anything
// 1 = after fold / before icon
// 2 = very end / after all parts.
//
function cdSetCmdCheckAlignmentPtr(cmd ref as Cmd, checkAlignment as integer)

	cmd.checkAlignment = checkAlignment
	
endfunction

//-----------------------------------------------------
// Select the fold alignment.
//
function cdSetCmdFoldAlignment(cmd as integer, foldAlignment as integer)

	cdSetCmdFoldAlignmentPtr(ma.cmds[cmd], foldAlignment)
	
endfunction

//-----------------------------------------------------
// Select the command fold alignment.
// checkAlignment:
// 0 for very left/before anything
// 1 = very end / after all parts.
//
function cdSetCmdFoldAlignmentPtr(cmd ref as Cmd, foldAlignment as integer)

	cmd.foldAlignment = foldAlignment
	
endfunction

//-----------------------------------------------------
// Set the command icon.
//
function cdSetCmdIcon(cmd as integer, iconImg as integer)

	cdSetCmdIconPtr(ma.cmds[cmd], iconImg)
	
endfunction

//-----------------------------------------------------
// Set the command icon.
//
function cdSetCmdIconPtr(cmd ref as Cmd, iconImg as integer)

	local sc as float

	sc = cd.cmdScales[ld.set.cmdSize] * cd.zoomScale
	
	if cmd.icon		
		coDeleteSprite("cdSetCmdIconPtr:cmd.icon", cmd.icon)
	endif

	cmd.icon = coCreateSprite("cdSetCmdIconPtr:cmd.icon", iconImg)

	if not (cmd.typ && CMD_BUT)

		if cmd.code = CODE_VAR_GET //or cmd.code = CODE_VAR_RUN
			if cmd.icon then setspritescale(cmd.icon, sc * 0.6, sc * 0.6)
		else 	
			if cmd.icon then setspritescale(cmd.icon, sc * 0.5, sc * 0.5)
		endif
		
	endif
	
	cdUpdateCmdSizePtr(cmd)	
	cdSetCmdPosPtr(cmd, cmd.x, cmd.y)
	cdSetCmdDepthPtr(cmd, cmd.depth)
	cdSetCmdVisiblePtr(cmd, cmd.vis)
	
endfunction

//-----------------------------------------------------
// Set the command icon2.
//
function cdSetCmdIcon2(cmd as integer, iconImg as integer)

	cdSetCmdIcon2Ptr(ma.cmds[cmd], iconImg)
	
endfunction

//-----------------------------------------------------
// Set the command icon2.
//
function cdSetCmdIcon2Ptr(cmd ref as Cmd, iconImg as integer)

	local sc as float

	sc = cd.cmdScales[ld.set.cmdSize] * cd.zoomScale

	if cmd.icon2	
		coDeleteSprite("cdSetCmdIconPtr:cmd.icon2", cmd.icon2)
	endif

	cmd.icon2 = coCreateSprite("cdSetCmdIconPtr:cmd.icon2", iconImg)
	coSetSpriteColor(cmd.icon2, coGetSpriteColor(cmd.bg))
	if not (cmd.typ && CMD_BUT)
		if cmd.icon2 then setspritescale(cmd.icon2, sc * 0.4, sc * 0.4)		
	endif
	
	cdUpdateCmdSizePtr(cmd)	
	cdSetCmdPosPtr(cmd, cmd.x, cmd.y)
	//cdSetCmdDepthPtr(cmd, GUI_SHADOW_DEPTH)
	cdSetCmdDepthPtr(cmd, cmd.depth)
	cdSetCmdVisiblePtr(cmd, cmd.vis)
	
endfunction

//-----------------------------------------------------
// Select the command.
//
function cdSetCmdChecked(cmd as integer, checked as integer)

	cdSetCmdCheckedPtr(ma.cmds[cmd], checked)
	
endfunction

//-----------------------------------------------------
// Select the command checked, i.e. with a checkbox.
//
function cdSetCmdCheckedPtr(cmd ref as Cmd, checked as integer)

	cmd.checked = checked

	if cmd.check

		if cmd.checked
			SetSpriteImage(cmd.check, cd.tickOnImg)
		else
			SetSpriteImage(cmd.check, cd.tickOffImg)
		endif

		cdUpdateCmdSizePtr(cmd)
		cdSetCmdVisiblePtr(cmd, cmd.vis)
		
	endif
	
endfunction

//-----------------------------------------------------
// Select the command.
//
function cdSetCmdCheckable(cmd as integer, checkable as integer)

	cdSetCmdCheckablePtr(ma.cmds[cmd], checkable)
	
endfunction

//-----------------------------------------------------
// Select the command is foldable.
//
function cdSetCmdCheckablePtr(cmd ref as Cmd, checkable as integer)

	cmd.checkable = checkable
	
	if cmd.checkable and not cmd.check

		cmd.check = coCreateSprite("cdSetCmdCheckablePtr:cmd.check", cd.tickOffImg)
		//cdSetCmdDepthPtr(cmd, GetSpriteDepth(cmd.sbg))
		//cdSetCmdPosPtr(cmd, cmd.x, cmd.y)		

	elseif not cmd.checkable and cmd.check

		coDeleteSprite("cdSetCmdCheckablePtr:cmd.check", cmd.check)
		cmd.check = 0
		
	endif

	//cdSetCmdDepthPtr(cmd, GetSpriteDepth(cmd.sbg))
	cdSetCmdDepthPtr(cmd, cmd.depth)
	cdUpdateCmdSizePtr(cmd)
	cdSetCmdPosPtr(cmd, cmd.x, cmd.y)		
	cdSetCmdVisiblePtr(cmd, cmd.vis)
	
endfunction

//-----------------------------------------------------
// Recalc the size of the cmd.
//
function cdUpdateCmdSize(cmd as integer)

	cdUpdateCmdSizePtr(ma.cmds[cmd])

endfunction

//-----------------------------------------------------
// Show/hide cmd by ptr.
//
function cdUpdateCmdSizePtr(cmd ref as Cmd)

	local i as integer
	local s as float
	local sw as float
	local sh as float
	local typ as integer
	local partCmd as integer
	local partTyp as integer
	local spec as integer
	local postSpecX as float
	local fw as float
	local gap as float
	local is as float
	local sc as float
	local sf as float
	local sm as float

	cmd.w = 0
	cmd.h = 0
	cmd.dragLX = 0
	cmd.dragRX = 0
 	spec = false
	postSpecX = 0

	sm = cd.cmdScales[ld.set.cmdSize]
	sc = sm * cd.zoomScale
	sf = sm * cd.zoomFontSize
	gap = CD_CMD_GAP * sc

	typ = cmd.typ && (CMD_STMT || CMD_OPER || CMD_COND)

	if cmd.check and cmd.checkAlignment = CD_CHECK_LEFT
		
		SetSpriteScale(cmd.check, sc, sc)		
		cmd.w = cmd.w + GetSpriteWidth(cmd.check) + gap
		cmd.dragLX = cmd.w
		
	endif

	if cmd.fold and cmd.foldAlignment = CD_FOLD_LEFT

		//SetSpriteScale(cmd.fold, sc, sc)		

		if cmd.typ && CMD_SPEC
			SetSpriteScale(cmd.fold, sc * 0.75, sc * 0.75)
		else 
			SetSpriteScale(cmd.fold, sc * 0.5, sc * 0.5)
		endif

		cmd.w = cmd.w + GetSpriteWidth(cmd.fold) + gap
		cmd.dragLX = cmd.w

	endif

	if cmd.check and cmd.checkAlignment = CD_CHECK_AFTER_FOLD
		
		SetSpriteScale(cmd.check, sc, sc)		
		cmd.w = cmd.w + GetSpriteWidth(cmd.check) + gap
		cmd.dragLX = cmd.w

	endif

	if cmd.icon

		SetSpriteScale(cmd.icon, cmd.iconScale * sc, cmd.iconScale * sc)		
		cmd.w = cmd.w + GetSpriteWidth(cmd.icon) //- gap
		cmd.h = GetSpriteHeight(cmd.icon) //+ gap * 2
		
	endif

	if cmd.icon2

		SetSpriteScale(cmd.icon2, (cmd.iconScale / 3 * 2) * sc, (cmd.iconScale / 3 * 2) * sc)		
		cmd.h = GetSpriteHeight(cmd.icon2) //+ gap * 2
		
	endif

	// First rx point, could now be adjusted by parts.
	cmd.dragRX = cmd.w
	
	for i = 0 to cmd.parts.length

		if cmd.parts[i].typ = PART_CMD

			partCmd = cdGetPartAsInt(cmd.parts[i])

			cdUpdateCmdSize(partCmd)
			
			cmd.parts[i].w = ma.cmds[partCmd].w
			cmd.parts[i].h = ma.cmds[partCmd].h

			if not cmd.parts[i].spr
							
				cmd.parts[i].spr = guicreatebox("cdUpdateCmdSizePtr.cmd.parts.spr", 1, 1)
				SetSpriteVisible(cmd.parts[i].spr, cmd.vis)
				
			endif

			partTyp = ma.cmds[partCmd].typ && (CMD_STMT || CMD_OPER || CMD_COND)
			
			setspritescale(cmd.parts[i].spr, cmd.parts[i].w - (GetSpriteWidth(ma.cmds[partCmd].lt) + GetSpriteWidth(ma.cmds[partCmd].rt)) + gap, cmd.parts[i].h + gap)
			cosetspritecolor(cmd.parts[i].spr, cd.grpCols[ma.cmds[partCmd].grp])
			cdCreatePartEdges(cmd.parts[i], partTyp)

			cmd.parts[i].h = ma.cmds[partCmd].h + gap

		elseif cmd.code = CODE_SPRITE_PART or cmd.code = CODE_FRAME_PART

			if cmd.parts[i].typ = PART_SPRITE_ICON or cmd.parts[i].typ = PART_FRAME_ICON

				is = cdIconScale(ld.set.thingIconSize) // * cd.zoomScale
				
				if cmd.parts[i].spr
					
					SetSpriteScale(cmd.parts[i].spr, cmd.parts[i].sprScale * is, cmd.parts[i].sprScale * is)
					cmd.parts[i].w = GetSpriteWidth(cmd.parts[i].spr)
					cmd.parts[i].h = GetSpriteheight(cmd.parts[i].spr)
					
				endif

				if cmd.parts[i].icon
					SetSpriteScale(cmd.parts[i].icon, cmd.parts[i].iconScale * is, cmd.parts[i].iconScale * is)
				endif
				
			endif
			
		endif
		
		cmd.w = cmd.w + cmd.parts[i].w

		if cmd.parts[i].typ = PART_APP_ICON or cmd.parts[i].typ = PART_SPRITE_ICON or cmd.parts[i].typ = PART_FRAME_ICON

			spec = true
			postSpecX = cmd.w

		endif

		// If we don't have a drag icon, and this is the first part, i.e. the command
		// first string, then calculate the drag "handle" area.
		
		if (i = 0 and (cmd.parts[i].typ = PART_STR or cmd.parts[i].typ = PART_VAR_NAME or cmd.parts[i].typ = PART_SOUND_NAME or cmd.parts[i].typ = PART_VIDEO_NAME))

			// Don't make the drag area bigger than a certain amount.
			if cmd.w - cmd.dragRX > co.bs
				cmd.dragRX = cmd.dragRX + co.bs
			else 
				cmd.dragRX = cmd.w
			endif
			
		elseif cmd.parts[i].typ = PART_APP_ICON or cmd.parts[i].typ = PART_SPRITE_ICON or cmd.parts[i].typ = PART_FRAME_ICON

			cmd.dragRX = cmd.w

		endif

		if cmd.h < cmd.parts[i].h + gap * 2
			cmd.h = cmd.parts[i].h + gap * 2
		endif
		
	next

	if cmd.check and cmd.checkAlignment = CD_CHECK_RIGHT

		SetSpriteScale(cmd.check, sc, sc)		
		cmd.w = cmd.w + gap + GetSpriteWidth(cmd.check) //+ gap

	endif

	if cmd.fold and cmd.foldAlignment = CD_FOLD_RIGHT

		//SetSpriteScale(cmd.fold, sc, sc)		

		if cmd.typ && CMD_SPEC
			SetSpriteScale(cmd.fold, sc * 0.75, sc * 0.75)
		else 
			SetSpriteScale(cmd.fold, sc * 0.5, sc * 0.5)
		endif

		fw = gap + GetSpriteWidth(cmd.fold) //+ gap
		
		if spec

			if (cmd.w - postSpecX) < fw
				
				cmd.foldExtra = (fw - (cmd.w - postSpecX))
				cmd.w = cmd.w + cmd.foldExtra

			else

				cmd.foldExtra = 0
				
			endif
			
		else
			
			cmd.w = cmd.w + fw

		endif

	endif

	if cmd.edge
		setspritescale(cmd.edge, sc, sc)		
	endif

	if cmd.sedge
		setspritescale(cmd.sedge, sc, sc)		
	endif

	if cmd.clip
		setspritescale(cmd.clip, sc, sc)		
	endif
	
	if cmd.bg
		SetSpriteScale(cmd.bg, cmd.w, cmd.h)
	endif
	
	if cmd.sbg
		SetSpriteScale(cmd.sbg, cmd.w, cmd.h)
	endif

	sh = cmd.h / getimageheight(cd.edgeImgs[typ])

	if (cmd.typ && CMD_SPEC)
		sw = sh * 0.25
	else
		sw = sh
	endif
	
	if cmd.lt
		setspritescale(cmd.lt, sw, sh)
	endif
	
	if cmd.rt
		setspritescale(cmd.rt, sw, sh)
	endif
	
	if cmd.slt
		setspritescale(cmd.slt, sw, sh)
	endif
	
	if cmd.srt
		setspritescale(cmd.srt, sw, sh)
	endif

	if cmd.lt and cmd.rt
		cmd.w = cmd.w + GetSpriteWidth(cmd.lt) + GetSpriteWidth(cmd.rt)
	endif
	
endfunction


//-----------------------------------------------------
// Get the icon scale from the size.
//
function cdIconScale(iconSize as integer)

	local ret as float

	ret = iconSize * 0.25
	
endfunction ret

//-----------------------------------------------------
// Show/hide grp.
//
function cdSetGrpContentSizes()

	local i as integer
	local x0 as float // Very left.
	local y0 as float // Very top.
	local x1 as float // Very right.
	local y1 as float // Very bottom.
	local tx as float
	local ty as float
	local grp as integer
	local cmd as integer
	local gap as float

	gap = co.bs / 8

	for grp = GRP_BEGIN to GRP_DATA
		
		// Opposite side, so that we actually adjust to minimum size.
		x1 = getspritex(cd.cmdPanels[grp].panel)
		x0 = x1 + getspritewidth(cd.cmdPanels[grp].panel)
		y1 = getspritey(cd.cmdPanels[grp].panel)
		y0 = y1 + GetSpriteHeight(cd.cmdPanels[grp].panel)
	
		for i = 0 to cd.selCmds.length

			cmd = cd.selCmds[i]
			
			if ma.cmds[cmd].grp = grp
				
				if ma.cmds[cmd].code <> 0
						
					if ma.cmds[cmd].x < x0
						x0 = ma.cmds[cmd].x
					endif

					if ma.cmds[cmd].y < y0
						y0 = ma.cmds[cmd].y
					endif
					
					tx = ma.cmds[cmd].x + ma.cmds[cmd].w	 - 1	
					if tx > x1
						x1 = tx
					endif

					ty = ma.cmds[cmd].y + ma.cmds[cmd].h - 1
					if ty > y1
						y1 = ty
					endif
					
				endif
				
			endif
			
		next

		guiSetPanelColor(cd.cmdPanels[grp], cd.grpCols[grp], cd.barCols[grp], cd.dragCols[grp])	
		guiSetPanelContentSize(cd.cmdPanels[grp], x0 - gap, y0 - gap, x1 + gap, y1 + gap)
		//guiSetPanelContentSize(cd.cmdPanels[grp], x0, y0, x1, y1)

		for i = 0 to cd.selCmds.length

			cmd = cd.selCmds[i]
			
			if ma.cmds[cmd].grp = grp
				cdSetCmdScissor(cmd, cd.cmdPanels[ma.cmds[cmd].grp].vx, cd.cmdPanels[ma.cmds[cmd].grp].vy, cd.cmdPanels[ma.cmds[cmd].grp].vx + cd.cmdPanels[ma.cmds[cmd].grp].vw - 1, cd.cmdPanels[ma.cmds[cmd].grp].vy + cd.cmdPanels[ma.cmds[cmd].grp].vh - 1)
			endif

		next
		
	next
			
endfunction

//-----------------------------------------------------
// Show/hide grp.
//
function cdDestroyGrpContentSizes()

	local grp as integer
	
	for grp = GRP_BEGIN to GRP_DATA		
		guiDeletePanel(cd.cmdPanels[grp])			
	next
	
	cd.cmdPanels.length = -1

endfunction

//-----------------------------------------------------
// Show/hide thing panels.
//
function cdSetThingsVisible(s as string, vis as integer)

//colog("cdSetThingsVisible: s=" + s)

	local i as integer
	local j as integer
	local k as integer
	local varIdx as integer
	local idx as integer
	
	if cd.thingTab = -1
		
		for i = GRP_SPRITE to GRP_VIDEO // GRP_VAR

			idx = i - GRP_SPRITE
			guiSetButtonDepth(cd.thingBar.buts[idx], cd.panelDepth)
			guiSetButtonShadowVisible(cd.thingBar.buts[idx], false)
			guiSetPanelVisible(cd.cmdPanels[i], false)
			
		next
		
		// Set all tabs invisible.
		cdSetSpritesVisible(false, 0)
		cdSetSoundsVisible(false)
		cdSetVideosVisible(false)
		cdSetVarsVisible(false)

	elseif cd.thingTab = GRP_SPRITE

		cdSetSpritesVisible(vis, 0)
				
	elseif cd.thingTab = GRP_SOUND

		cdSetSoundsVisible(vis)

	elseif cd.thingTab = GRP_VIDEO

		cdSetVideosVisible(vis)

	elseif cd.thingTab = GRP_VAR

		cdSetVarsVisible(vis)

	endif
		
	if cd.thingTab > -1 and vis

		idx = cd.thingTab - GRP_SPRITE
		guiSetButtonDepth(cd.thingBar.buts[idx], cd.panelDepth - 2)
		guiSetButtonShadowVisible(cd.thingBar.buts[idx], true)
		guiSetPanelVisible(cd.cmdPanels[cd.thingTab], true)
			
	endif
			
endfunction


//-----------------------------------------------------
// Show/hide settings.
//
function cdSetSettingsVisible(s as string, vis as integer)

	//guiSetBarVisible(cd.settingsBar, vis)
	//guiSetPanelVisible(cd.settingsPanel, vis)

	//SetTextVisible(cd.settingsTitle1, vis)
	//SetTextVisible(cd.settingsTitle2, vis)
	//SetTextVisible(cd.settingsTitle3, vis)
	//SetTextVisible(cd.settingsTitle4, vis)

	//cdSetSettingsButtons()
	
endfunction

//-----------------------------------------------------
// Set all the settings buttons.
//
function cdSetSettingsButtons()
	
	cdSetSettingsAutoNamingButton()
	cdSetSettingsLibrariesButton()
	cdSetSettingsAutoAcceptButton()

endfunction

//-----------------------------------------------------
// Show/hide grp.
//
function cdSetGrpVisible(vis as integer)

	local i as integer
	local j as integer
	local k as integer
	local varIdx as integer
	
	if cd.grpTab = -1
		
		for i = GRP_BEGIN to GRP_DATA

			guiSetButtonDepth(cd.grpBar.buts[i], cd.panelDepth)
			guiSetButtonShadowVisible(cd.grpBar.buts[i], false)
			guiSetPanelVisible(cd.cmdPanels[i], false)
			
		next
		
	endif

	//if cd.grpTab = GRP_VAR
	//	cdProcessVars(cd.thingIdx)		
	//endif
		
	for i = 0 to cd.selCmds.length
		
		if cd.grpTab = -1

			cdSetCmdVisible(cd.selCmds[i], false)

		elseif ma.cmds[cd.selCmds[i]].grp = cd.grpTab

			if ma.cmds[cd.selCmds[i]].var

				varIdx = ma.cmds[cd.selCmds[i]].var
				
				if ma.vars[varIdx].appIdx = cd.appIdx and (ma.vars[varIdx].thingIdx = -1 or ma.vars[varIdx].thingIdx = cd.thingIdx)
					cdSetCmdVisible(cd.selCmds[i], vis)
				else
					cdSetCmdVisible(cd.selCmds[i], false)
				endif
							
			elseif ma.cmds[cd.selCmds[i]].code <> 0
							
				cdSetCmdVisible(cd.selCmds[i], vis)
				
			endif
			
		endif
		
	next

	if cd.grpTab > -1 and vis
		
		guiSetButtonDepth(cd.grpBar.buts[cd.grpTab], cd.panelDepth - 2)
		guiSetButtonShadowVisible(cd.grpBar.buts[cd.grpTab], true)
		guiSetPanelVisible(cd.cmdPanels[cd.grpTab], true)
			
	endif
			
endfunction

//-----------------------------------------------------
// Show/hide sprites or code for the selected sprite.
//
function cdSetTabVisible(s as string, vis as integer)

//colog("cdSetTabVisible, s=" + s)

	local i as integer
	local idx as integer
	local grpTab as integer
	local thingTab as integer

	if cd.maintab = CD_TAB_APP

		cdSetAppsVisible(vis)

		guiSetBarVisible(cd.thingBar, false)
		thingTab = cd.thingTab
		cd.thingTab = -1
		cdSetThingsVisible("e", false)
		cd.thingTab = thingTab
		//cdSetThingsVisible(false, 0)
		
		guiSetBarVisible(cd.grpBar, false)
		grpTab = cd.grpTab
		cd.grpTab = -1
		cdSetGrpVisible(false)
		cd.grpTab = grpTab
		
		//guiSetPanelVisible(cd.appPanel, vis)		

		cdSetSettingsVisible("e", false)

		//guiSetButtonDepth(cd.settingsBut, cd.tabDepth)
		guiSetButtonDepth(cd.appBut, cd.panelDepth)
		guiSetButtonDepth(cd.thingBut, cd.tabDepth)
		guiSetButtonDepth(cd.cmdBut, cd.tabDepth)
		//guiSetButtonShadowVisible(cd.settingsBut, false)
		guiSetButtonShadowVisible(cd.appBut, vis)
		guiSetButtonShadowVisible(cd.thingBut, false)
		guiSetButtonShadowVisible(cd.cmdBut, false)
		
		cdSetToolbarVisible(vis)
		
		//coSetSpriteColor(cd.libraryBut.bg, cd.tabCols[CD_TAB_APP_LIBRARY])
		guiSetButtonBgCol(cd.libraryBut, cd.tabCols[CD_TAB_APP_LIBRARY])
		guiSetButtonVisible(cd.libraryBut, vis)

		cdSetFileTabVisible(s + ":cd.mainTab:APP", vis)

		//guiSetPanelColor(cd.appPanel, cd.tabCols[cd.maintab], cd.tabBarCols[cd.maintab], cd.tabPipCols[cd.maintab])
		
	elseif cd.maintab = CD_TAB_THING

		cdSetAppsVisible(false)

		guiSetBarVisible(cd.thingBar, vis)

		thingTab = cd.thingTab
		cd.thingTab = -1
		cdSetThingsVisible("f", false)
		cd.thingTab = thingTab
		cdSetThingsVisible("g", vis)
		
		guiSetBarVisible(cd.grpBar, false)
		grpTab = cd.grpTab
		cd.grpTab = -1
		cdSetGrpVisible(false)
		cd.grpTab = grpTab
		
		//cdSetSettingsVisible("e", false)

		//guiSetButtonDepth(cd.settingsBut, cd.tabDepth)
		guiSetButtonDepth(cd.appBut, cd.tabDepth)
		guiSetButtonDepth(cd.thingBut, cd.panelDepth)
		guiSetButtonDepth(cd.cmdBut, cd.tabDepth)
		//guiSetButtonShadowVisible(cd.settingsBut, false)
		guiSetButtonShadowVisible(cd.appBut, false)
		guiSetButtonShadowVisible(cd.thingBut, vis)
		guiSetButtonShadowVisible(cd.cmdBut, false)

		cdSetToolbarVisible(vis)

		if cd.thingTab = GRP_SPRITE

			//coSetSpriteColor(cd.libraryBut.bg, cd.tabCols[CD_TAB_SPRITE_LIBRARY])
			guiSetButtonBgCol(cd.libraryBut, cd.tabCols[CD_TAB_SPRITE_LIBRARY])

		elseif cd.thingTab = GRP_SOUND

			//coSetSpriteColor(cd.libraryBut.bg, cd.tabCols[CD_TAB_SOUND_LIBRARY])
			guiSetButtonBgCol(cd.libraryBut, cd.tabCols[CD_TAB_SOUND_LIBRARY])

		elseif cd.thingTab = GRP_VIDEO

			//coSetSpriteColor(cd.libraryBut.bg, cd.tabCols[CD_TAB_VIDEO_LIBRARY])
			guiSetButtonBgCol(cd.libraryBut, cd.tabCols[CD_TAB_VIDEO_LIBRARY])

		elseif cd.thingTab = GRP_VAR

			//coSetSpriteColor(cd.libraryBut.bg, cd.tabCols[CD_TAB_NAME_LIBRARY])
			guiSetButtonBgCol(cd.libraryBut, cd.tabCols[CD_TAB_NAME_LIBRARY])

		endif
		
		guiSetButtonVisible(cd.libraryBut, vis)

		cdSetFileTabVisible(s + ":cd.mainTab:THING", vis)
		
	elseif cd.maintab = CD_TAB_CMD

		cdSetAppsVisible(false)

		guiSetBarVisible(cd.thingBar, false)
		thingTab = cd.thingTab
		cd.thingTab = -1
		cdSetThingsVisible("h", false)
		cd.thingTab = thingTab
		//cdSetThingsVisible(false, 0)
		
		guiSetBarVisible(cd.grpBar, vis)
		cdSetGrpVisible(vis)
		
		//cdSetSettingsVisible("e", false)

		//guiSetButtonDepth(cd.settingsBut, cd.tabDepth)
		guiSetButtonDepth(cd.appBut, cd.tabDepth)
		guiSetButtonDepth(cd.thingBut, cd.tabDepth)
		guiSetButtonDepth(cd.cmdBut, cd.panelDepth)
		//guiSetButtonShadowVisible(cd.settingsBut, false)
		guiSetButtonShadowVisible(cd.appBut, false)
		guiSetButtonShadowVisible(cd.thingBut, false)
		guiSetButtonShadowVisible(cd.cmdBut, vis)

		cdSetToolbarVisible(vis)

		guiSetButtonVisible(cd.libraryBut, false)

		if cd.fileTab <> CD_FILE_TAB_HELP
			cd.fileTab = CD_FILE_TAB_CODE
		endif
		
		cdSetFileTabVisible(s + ":cd.mainTab:CMD", vis)
		
	elseif cd.maintab = CD_TAB_SETTINGS

		cdSetAppsVisible(false)
		
		guiSetBarVisible(cd.thingBar, false)
		thingTab = cd.thingTab
		cd.thingTab = -1
		cdSetThingsVisible("i", false)
		cd.thingTab = thingTab
		//cdSetThingsVisible(false, 0)

		guiSetBarVisible(cd.grpBar, false)
		grpTab = cd.grpTab
		cd.grpTab = -1
		cdSetGrpVisible(false)
		cd.grpTab = grpTab
		
		//cdSetSettingsVisible("e", vis)

		//guiSetButtonDepth(cd.settingsBut, cd.panelDepth)
		guiSetButtonDepth(cd.appBut, cd.tabDepth)
		guiSetButtonDepth(cd.thingBut, cd.tabDepth)
		guiSetButtonDepth(cd.cmdBut, cd.tabDepth)
		//guiSetButtonShadowVisible(cd.settingsBut, vis)
		guiSetButtonShadowVisible(cd.appBut, false)
		guiSetButtonShadowVisible(cd.thingBut, false)
		guiSetButtonShadowVisible(cd.cmdBut, false)

		//guiSetBarVisible(cd.toolBar, vis)
		cdSetToolbarVisible(vis)

		guiSetButtonVisible(cd.libraryBut, false)

		cd.fileTab = CD_FILE_TAB_CODE
		cdSetFileTabVisible(s + ":cd.mainTab:SETTINGS", vis)

		//guiSetPanelColor(cd.settingsPanel, cd.tabCols[cd.maintab], cd.tabBarCols[cd.maintab], cd.tabPipCols[cd.maintab])
		
	endif

	guiSetPanelColor(cd.mainPanel, cd.tabCols[cd.maintab], cd.tabBarCols[cd.maintab], cd.tabPipCols[cd.maintab])
	
endfunction

//-----------------------------------------------------
// Show or hide the toolbar.
//
function cdSetToolbarVisible(vis as integer)

	local idx as integer
	
	guiSetBarVisible(cd.toolBar, vis)

	if vis
		
		idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_UNDO)
		guiSetButtonActive(cd.toolBar.buts[idx], cd.undos.length > -1)
		idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_REDO)
		guiSetButtonActive(cd.toolBar.buts[idx], cd.redos.length > -1)
		idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_DESIGN)
		guiSetButtonActive(cd.toolBar.buts[idx], cd.appIdx > -1)
		idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_RUN)
		guiSetButtonActive(cd.toolBar.buts[idx], cd.appIdx > -1)

	endif
	
endfunction

//-----------------------------------------------------
// Show/hide sprites or code for the selected sprite.
//
function cdSetFileTabVisible(s as string, vis as integer)

	local i as integer
	local idx as integer
	local showFrameBut as integer
	local pos as integer

	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_UNDO)
	guiSetButtonVisible(cd.toolBar.buts[idx], false)
	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_REDO)
	guiSetButtonVisible(cd.toolBar.buts[idx], false)

	if cd.fileTab = CD_FILE_TAB_CODE
/*
		// Can't switch to code but, a thing is not active.
		if cdIsEditToolActive()

			idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
			guiSetButtonVisible(cd.toolBar.buts[idx], false)
				
			guiSetButtonDepth(cd.codeBut, cd.panelDepth)
			guiSetButtonDepth(cd.libraryBut, cd.tabDepth)
			guiSetButtonDepth(cd.helpBut, cd.tabDepth)
			guiSetButtonShadowVisible(cd.codeBut, vis)
			guiSetButtonShadowVisible(cd.libraryBut, false)
			guiSetButtonShadowVisible(cd.helpBut, vis)
			guiSetPanelVisible(cd.codePanel, false)
			guiSetPanelVisible(cd.loadPanel, false)
			cdSetDetailedHelpVisible(false)			
			cdShowCode("bb", false)
*/
		if cd.mainTab = CD_TAB_SETTINGS or cd.thingIdx > -1

			//cd.subMode = CD_SUBMODE_NONE
			guiSetPanelVisible(cd.loadPanel, false)
			//guiSetPanelVisible(cd.helpPanel, false)
			cdSetDetailedHelpVisible(false)
			cdHideLibItems(ld.libItems)
			idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
			guiSetButtonVisible(cd.toolBar.buts[idx], false)
			
			guiSetButtonDepth(cd.codeBut, cd.panelDepth)
			guiSetButtonDepth(cd.libraryBut, cd.tabDepth)
			guiSetButtonDepth(cd.helpBut, cd.tabDepth)
			guiSetButtonShadowVisible(cd.codeBut, vis)
			guiSetButtonShadowVisible(cd.libraryBut, false)
			guiSetButtonShadowVisible(cd.helpBut, false)
			
			guiSetPanelVisible(cd.codePanel, vis)
			cdShowCode("bbb", vis)

			if cd.thingIdx > -1
				
				idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_UNDO)
				guiSetButtonVisible(cd.toolBar.buts[idx], vis)
				idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_REDO)
				guiSetButtonVisible(cd.toolBar.buts[idx], vis)

				guiSetPanelAlpha(cd.codePanel, 255)

			else

				guiSetPanelAlpha(cd.codePanel, gui.inactiveAlpha)
				
			endif

		else

			cd.fileTab = CD_FILE_TAB_LIBRARY
			cd.submode = CD_SUBMODE_PRELOAD

			// Drop through to below.
			
		endif
		
	endif
	
	if cd.fileTab = CD_FILE_TAB_LIBRARY

		// Hack from caller to force reload.
		if cd.subMode = CD_SUBMODE_PRELOAD and vis

			cdLoadFileTab()
			cd.submode = CD_SUBMODE_NONE
			
		endif

		guiSetButtonDepth(cd.codeBut, cd.tabDepth)
		guiSetButtonDepth(cd.libraryBut, cd.panelDepth)
		guiSetButtonDepth(cd.helpBut, cd.tabDepth)
		guiSetButtonShadowVisible(cd.helpBut, false)
		guiSetButtonShadowVisible(cd.codeBut, false)
		guiSetButtonShadowVisible(cd.libraryBut, vis)
		guiSetPanelVisible(cd.codePanel, false)
		//guiSetPanelVisible(cd.helpPanel, false)
		cdSetDetailedHelpVisible(false)
		cdShowCode("bb", false)

		if cd.mainTab = CD_TAB_THING

			if cd.thingTab = GRP_SPRITE

				guiSetPanelColor(cd.loadPanel, cd.tabCols[CD_TAB_SPRITE_LIBRARY], cd.tabbarCols[CD_TAB_SPRITE_LIBRARY], cd.tabpipCols[CD_TAB_SPRITE_LIBRARY])
				idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
				guiSetButtonText(cd.toolBar.buts[idx], "import")
				guiSetButtonIcon(cd.toolBar.buts[idx], cd.findImg)
				//coSetSpriteColor(cd.toolBar.buts[idx].bg, cd.tabpipCols[CD_TAB_SPRITE_LIBRARY])
				guiSetButtonBgCol(cd.toolBar.buts[idx], cd.tabpipCols[CD_TAB_SPRITE_LIBRARY])

				//if cd.imageFolder <> "" // = "/" + CD_FOLDER_MY_SPRITES					
				//	if cdCheckAppStatus(cd.imageFolder, LD_STATUS_BUILTIN)
						guiSetButtonVisible(cd.toolBar.buts[idx], vis)
				//	else 
				//		guiSetButtonVisible(cd.toolBar.buts[idx], false)
				//	endif					
				//else					
				//	guiSetButtonVisible(cd.toolBar.buts[idx], false)					
				//endif

				showFrameBut = false
				
				if cd.thingIdx > -1
					if ma.things[cd.thingIdx].imgIdx > -1
						showFrameBut = true
					endif
				endif

				idx = guiFindBarButtonById(cd.imageItemBar, BUT_CODER_IMAGE_NEW)
				guiSetButtonActive(cd.imageItemBar.buts[idx], showFrameBut)
				idx = guiFindBarButtonById(cd.imageBlankItemBar, BUT_CODER_IMAGE_NEW)
				guiSetButtonActive(cd.imageBlankItemBar.buts[idx], showFrameBut)

			elseif cd.thingTab = GRP_SOUND
				
				guiSetPanelColor(cd.loadPanel, cd.tabCols[CD_TAB_SOUND_LIBRARY], cd.tabbarCols[CD_TAB_SOUND_LIBRARY], cd.tabpipCols[CD_TAB_SOUND_LIBRARY])
				idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
				guiSetButtonText(cd.toolBar.buts[idx], "import")
				guiSetButtonIcon(cd.toolBar.buts[idx], cd.findImg)
				//coSetSpriteColor(cd.toolBar.buts[idx].bg, cd.tabpipCols[CD_TAB_SOUND_LIBRARY])
				guiSetButtonBgCol(cd.toolBar.buts[idx], cd.tabpipCols[CD_TAB_SOUND_LIBRARY])

				//if cd.soundFolder <> "" // = "/" + CD_FOLDER_MY_SOUNDS
				//	if cdCheckAppStatus(cd.soundFolder, LD_STATUS_BUILTIN)
						guiSetButtonVisible(cd.toolBar.buts[idx], vis)
				//	else 
				//		guiSetButtonVisible(cd.toolBar.buts[idx], false)
				//	endif
				//else
				//	guiSetButtonVisible(cd.toolBar.buts[idx], false)
				//endif

			elseif cd.thingTab = GRP_VIDEO
				
				guiSetPanelColor(cd.loadPanel, cd.tabCols[CD_TAB_VIDEO_LIBRARY], cd.tabbarCols[CD_TAB_VIDEO_LIBRARY], cd.tabpipCols[CD_TAB_VIDEO_LIBRARY])
				idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
				guiSetButtonText(cd.toolBar.buts[idx], "import")
				guiSetButtonIcon(cd.toolBar.buts[idx], cd.findImg)
				//coSetSpriteColor(cd.toolBar.buts[idx].bg, cd.tabpipCols[CD_TAB_VIDEO_LIBRARY])
				guiSetButtonBgCol(cd.toolBar.buts[idx], cd.tabpipCols[CD_TAB_VIDEO_LIBRARY])

				//if cd.videoFolder <> "" // = "/" + CD_FOLDER_MY_VIDEOS
				//	if cdCheckAppStatus(cd.videoFolder, LD_STATUS_BUILTIN)
						guiSetButtonVisible(cd.toolBar.buts[idx], vis)
				//	else 
				//		guiSetButtonVisible(cd.toolBar.buts[idx], false)
				//	endif
				//else
				//	guiSetButtonVisible(cd.toolBar.buts[idx], false)
				//endif

			elseif cd.thingTab = GRP_VAR
				
				guiSetPanelColor(cd.loadPanel, cd.tabCols[CD_TAB_NAME_LIBRARY], cd.tabbarCols[CD_TAB_NAME_LIBRARY], cd.tabpipCols[CD_TAB_NAME_LIBRARY])
				idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
				guiSetButtonVisible(cd.toolBar.buts[idx], false)
								
			endif
			
		elseif cd.mainTab = CD_TAB_APP

			guiSetPanelColor(cd.loadPanel, cd.tabCols[CD_TAB_APP_LIBRARY], cd.tabbarCols[CD_TAB_APP_LIBRARY], cd.tabpipCols[CD_TAB_APP_LIBRARY])
			idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
			guiSetButtonVisible(cd.toolBar.buts[idx], false)

		endif

		if vis
			cdShowLibItems(ld.libItems)
		else
			cdHideLibItems(ld.libItems)
		endif
		
		guiSetPanelVisible(cd.loadPanel, vis)

	elseif cd.fileTab = CD_FILE_TAB_HELP

		idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
		guiSetButtonVisible(cd.toolBar.buts[idx], false)
			
		guiSetButtonDepth(cd.codeBut, cd.tabDepth)
		guiSetButtonDepth(cd.libraryBut, cd.tabDepth)
		guiSetButtonDepth(cd.helpBut, cd.panelDepth)
		guiSetButtonShadowVisible(cd.codeBut, false)
		guiSetButtonShadowVisible(cd.libraryBut, false)
		guiSetButtonShadowVisible(cd.helpBut, vis)
		guiSetPanelVisible(cd.codePanel, false)
		guiSetPanelVisible(cd.loadPanel, false)
		//guiSetPanelVisible(cd.helpPanel, vis)

		cdHideLibItems(ld.libItems)
		
		if cd.helpDetails.pageIdx = -1
			cdShowDetailedHelp(CD_HELP_MAIN, -1)
		else
			cdSetDetailedHelpVisible(true)
		endif
		
		cdShowCode("bb", false)

	endif
		
endfunction

//-----------------------------------------------------
// Checks if the app with name has the passed status.
//
function cdCheckAppStatus(appName as string, status as integer)

	local pos as integer
	local appIdx as integer
	local valid as integer

	appIdx = maFindAppByFolder(appName)

	valid = true
	
	if appIdx > -1
		if ma.apps[appIdx].status && status
			valid = false
		endif
	else
		valid = false
	endif

/*

	valid = true
	
	if cd.appIdx > -1
		if ma.apps[cd.appIdx].status && status
			valid = false
		endif
	else
		valid = false
	endif
*/
	
endfunction valid

//-----------------------------------------------------
// Load built-in things.
//
function cdHideLibItems(libItems ref as LibItem[])

	local i as integer

	for i = 0 to libItems.length
		cdSetLibItemVisible(libItems[i], false)
	next
	
endfunction

//-----------------------------------------------------
// Make the lib items and panel alpha.
//
function cdSetLibItemsAlpha(libItems ref as LibItem[], alpha as integer)

	local i as integer

	guiSetPanelAlpha(cd.loadPanel, alpha)
	
	for i = 0 to libItems.length
		cdSetLibItemAlpha(libItems[i], alpha)
	next
	
endfunction

//-----------------------------------------------------
// Load built-in things.
//
function cdShowLibItems(libItems ref as LibItem[])

	local i as integer
	local x as float
	local y as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local px as float
	local py as float
	local tx as float
	local ty as float
	local pos as integer
	local folder as string 

	px = getspritex(cd.loadPanel.panel)
	py = getspritey(cd.loadPanel.panel)
	x0 = px + GetSpriteWidth(cd.loadPanel.panel) / 2
	y0 = py + GetSpriteHeight(cd.loadPanel.panel) / 2
	x1 = x0
	y1 = y0

	x = px + co.bs / 4
	y = py + co.bs / 4
		
	for i = 0 to libItems.length

		cdCreateLibItem(libItems[i])
		cdSetLibItemVisible(libItems[i], false)
		cdSetlibItemPos(libItems[i], x, y)
		
		libItems[i].ox = libItems[i].x - px
		libItems[i].oy = libItems[i].y - py

		if libItems[i].x < x0
			x0 = libItems[i].x
		endif

		if libItems[i].y < y0
			y0 = libItems[i].y
		endif

		tx = libItems[i].x + libItems[i].w - 1
		if tx > x1
			x1 = tx
		endif

		ty = libItems[i].y + libItems[i].h - 1
		if ty > y1
			y1 = ty
		endif

		if mod(i + 1, CD_ITEMS_PER_ROW) = 0

			x = px + co.bs / 4
			y = y + libItems[i].h + co.bs / 4 // CD_CMD_GAP
			
		else
			
			x = x + libItems[i].w + co.bs / 4
			
		endif
		
	next

	guiSetPanelContentSize(cd.loadPanel, x0, y0, x1 + co.bs / 4, y1 + co.bs / 4)
	guiSetPanelBarsVisible(cd.loadPanel, true)

	for i = 0 to libItems.length

		if x0 < px
			libItems[i].ox = libItems[i].ox + (px - x0)
		endif

		if y0 < py
			libItems[i].oy = libItems[i].oy + (py - y0)
		endif

		cdSetLibItemScissor(libItems[i], true, cd.loadPanel)

	next

	for i = 0 to libItems.length
		cdSetLibItemVisible(libItems[i], true)
	next
	
endfunction

//-----------------------------------------------------
// Draw the lib item at the drag position.
//
function cdDrawLibItem(libItem ref as LibItem, x as float, y as float)

	cdSetLibItemPos(libItem, x - cd.offX, y - cd.offY)		

endfunction

//-----------------------------------------------------
// Make a lib item.
//
function cdCreateLibItem(libItem ref as LibItem)

	local w as float
	local h as float
	local s as string
	local folder as string
	local pos as integer
	local text2 as string
	local b as float
	local sc as float
	
	if not libItem.bg
		
		//libItem.bg = guicreatebox("cdShowLibItem:libItem.bg", co.bs * 2, co.bs * 2)
		libItem.bg = guicreatebox("cdShowLibItem:libItem.bg", co.bs * 1.3, co.bs * 1.3)
		cosetspritecolor(libItem.bg, co.white)
		
	endif

	if not libItem.border
		
		libItem.border = guicreatebox("cdShowLibItem:libItem.bg", co.bs * 2, co.bs * 2)

/*
	cd.grpCols.insert(co.pink[2])
	cd.cmdCols.insert(co.pink[6])
	cd.barCols.insert(co.pink[2])
	cd.dragCols.insert(co.pink[6])
	cd.selCols.insert(co.pink[9])

*/
		if libItem.typ && LD_ITEM_SPRITE_LIB
			cosetspritecolor(libItem.border, cd.itemCols[GRP_SPRITE])
		elseif libItem.typ && LD_ITEM_SOUND_LIB 
			cosetspritecolor(libItem.border, cd.itemCols[GRP_SOUND])
		elseif libItem.typ && LD_ITEM_VIDEO_LIB
			cosetspritecolor(libItem.border, cd.itemCols[GRP_VIDEO])
		elseif libItem.typ && LD_ITEM_VAR_SPRITE or libItem.typ && LD_ITEM_VAR_APP or libItem.typ && LD_ITEM_LIST_APP or libItem.typ && LD_ITEM_LIST_SPRITE or libItem.typ && LD_ITEM_VAR_VALUE
			cosetspritecolor(libItem.border, cd.itemCols[GRP_VAR])
		elseif libItem.typ && LD_ITEM_SUB_FOLDER or libItem.typ && LD_ITEM_PARENT_FOLDER
			cosetspritecolor(libItem.border, cd.grpCols[GRP_APP])
		elseif libItem.typ && LD_ITEM_APP_LIB	
			cosetspritecolor(libItem.border, cd.itemCols[GRP_APP])
		endif
		
	endif

	if not libItem.sel
		
		//libItem.sel = guicreatebox("cdShowLibItem:libItem.sel", getspritewidth(libItem.bg) + CD_CMD_GAP * 2, getspriteheight(libItem.bg) + CD_CMD_GAP * 2)
		libItem.sel = guicreatebox("cdShowLibItem:libItem.sel", getspritewidth(libItem.border), getspriteheight(libItem.border))
		cosetspritecolor(libItem.sel, co.black)
		setspritecoloralpha(libItem.sel, gui.shadowAlpha)
		SetSpriteVisible(libItem.sel, false)
		
	endif

	if not libItem.icon

		if not libItem.img
			
			if libItem.typ = LD_ITEM_SOUND_LIB //or libItem.typ = LD_ITEM_SOUND_BUILTIN or libItem.typ = LD_ITEM_SOUND_SHARED	

				libItem.img = cd.soundImg

			elseif libItem.typ = LD_ITEM_VIDEO_LIB //or libItem.typ = LD_ITEM_VIDEO_BUILTIN or libItem.typ = LD_ITEM_VIDEO_SHARED	

				libItem.img = cd.videoImg

			elseif libItem.typ && LD_ITEM_SUB_FOLDER

				//if libItem.typ && LD_ITEM_APP_LIB
					libItem.img = cd.subFolderImg
				//else
				//	libItem.img = cd.appImg
				//endif

			elseif libItem.typ && LD_ITEM_PARENT_FOLDER

				libItem.img = cd.upImg // cd.backImg

			endif

			if libItem.img
				libItem.sharedImg = true
			endif
			
		endif
		
		libItem.icon = cdCreateLibItemIcon(libItem)

		b = GetSpriteWidth(libItem.bg) - co.bs / 8
		w = GetSpriteWidth(libItem.icon)
		h = GetSpriteHeight(libItem.icon)
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

		SetSpriteScaleByOffset(libItem.icon, sc, sc)

		if libItem.typ && LD_ITEM_SUB_FOLDER or libItem.typ && LD_ITEM_PARENT_FOLDER
			coSetSpriteColor(libItem.icon, co.black)
		endif
		
	endif

	if not libItem.tag
		libItem.tag = cdCreateLibItemTag(libItem)
	endif

	if not libItem.tag2
		libItem.tag2 = cdCreateLibItemTag2(libItem)
	endif

	if not libItem.tag3
		libItem.tag3 = cdCreateLibItemTag3(libItem)
	endif

	w = GetSpriteWidth(libItem.border)

	if not libItem.text

		s = libItem.name
		libItem.text = guicreatetext(s, gui.nameFontSize)

		guiSetTextToWidth(libItem.text, s, w)		
		SetTextAlignment(libItem.text, 1)
		coSetTextColor(libItem.text, co.black)
		
	endif
	
	if not libItem.text2
		
		if libItem.typ = LD_ITEM_APP_LIB
			text2 = "project"
		elseif libItem.typ = LD_ITEM_SPRITE_LIB
			text2 = "image"
		elseif libItem.typ = LD_ITEM_SOUND_LIB
			text2 = "sound"
		elseif libItem.typ = LD_ITEM_VIDEO_LIB
			text2 = "video"
		elseif libItem.typ = LD_ITEM_VAR_APP
			text2 = "project value var"
		elseif libItem.typ = LD_ITEM_VAR_SPRITE
			text2 = "sprite value var"
		elseif libItem.typ = LD_ITEM_LIST_APP
			text2 = "project list var"
		elseif libItem.typ = LD_ITEM_LIST_SPRITE
			text2 = "sprite list var"
		elseif libItem.typ = LD_ITEM_VAR_VALUE
			text2 = "list item"
		elseif libItem.typ && LD_ITEM_SUB_FOLDER
			text2 = "folder"
		elseif libItem.typ && LD_ITEM_PARENT_FOLDER
			text2 = "parent folder"
		endif

		libItem.text2 = guicreatetext(text2, gui.nameFontSize)
		guiSetTextToWidth(libItem.text2, text2, w)		
		SetTextAlignment(libItem.text2, 1)
		coSetTextColor(libItem.text2, co.black)

	endif
	
	//cdSetLibItemDepth(libItem, GUI_SHADOW_DEPTH)
	cdSetLibItemDepth(libItem, GetSpriteDepth(cd.loadPanel.panel) - 2)

endfunction

//-----------------------------------------------------
// Create an icon for a lib item with the correct scale.
//
function cdCreateLibItemIcon(libItem ref as LibItem)

	local b as float
	local w as float
	local h as float
	local s as float
	local img as integer
	local spr as integer

	spr = 0
	
	if libItem.img
		
		spr = coCreateSprite("coCreateLibItemIcon:spr", libItem.img)
		//coResizeSprite(spr, co.bs * 1.25)
		
	elseif libItem.file <> "" // Avoid loading a lot of big images.

		libItem.img = coloadimage("cdCreateLibItemIcon:img", libItem.file)
		libItem.sharedImg = false
		//coResizeImage(libItem.img, co.bs * 1.25)		
		spr = coCreateSprite("coCreateLibItemIcon:spr", libItem.img)

	endif
	
endfunction spr

//-----------------------------------------------------
// Create a tag (icon) for a lib item to indicate builtin, shared up or down.
//
function cdCreateLibItemTag(libItem ref as LibItem)

	local spr as integer

	if not (libItem.typ && LD_ITEM_SUB_FOLDER) and not (libItem.typ && LD_ITEM_PARENT_FOLDER) and not (libItem.status && LD_STATUS_BLANK)
		if libItem.status && LD_STATUS_LOCKED
			spr = coCreateSprite("lockedtag", cd.smallBuiltinImg)
		else
			spr = 0
		endif
	endif
	
endfunction spr

//-----------------------------------------------------
// Create a tag (icon) for a lib item to indicate builtin, shared up or down.
//
function cdCreateLibItemTag3(libItem ref as LibItem)

	local spr as integer

	if not (libItem.typ && LD_ITEM_SUB_FOLDER) and not (libItem.typ && LD_ITEM_PARENT_FOLDER) and not (libItem.status && LD_STATUS_BLANK)
		if libItem.status && LD_STATUS_SHARED_TO_YOU
			spr = coCreateSprite("sharedtoyoutag", cd.sharedToYouImg)
		elseif libItem.status && LD_STATUS_SHARED_BY_YOU
			spr = coCreateSprite("sharedbyyoutag", cd.sharedByYouImg)
		elseif libItem.status && LD_STATUS_PURCHASED
			spr = coCreateSprite("purchasedtag", cd.purchasedImg)
		elseif libItem.status && LD_STATUS_FOR_SALE
			spr = coCreateSprite("forSaletag", cd. forSaleImg)
		else
			spr = 0
		endif
	endif
	
endfunction spr

//-----------------------------------------------------
// Create a tag2 (icon) for a lib item to indicate opened or otherwise.
//
function cdCreateLibItemTag2(libItem ref as LibItem)

	local spr as integer
	local appIdx as integer 

	if libItem.typ && LD_ITEM_APP_LIB
		if libItem.appIdx > -1
			if ma.apps[libItem.appIdx].loaded
				spr = coCreateSprite("opentag", cd.loadedIconImg)
			endif			
		endif		
	endif
	
endfunction spr

//-----------------------------------------------------
// Load shared things.
//
function cdShowSharedItems(show as integer)
endfunction

//-----------------------------------------------------
// Load files dialog.
//
function cdGetThingFiles()
endfunction

//-----------------------------------------------------
// Show/hide apps.
//
function cdSetAppsVisible(vis as integer)

	local i as integer
	//local tab as integer
	local x as float
	local y as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local px as float
	local py as float
	local pw as float
	local ph as float
	local tx as float
	local ty as float
	local ox as float
	local oy as float
	local cmd as integer
	local part as Part
	local img as integer
	local spr as integer
	local idx as integer
	local gap as float
	local cx as float
	local cy as float
	local a as integer
	local o as StrOrder
	local order as StrOrder[]

	cx = cd.appPanel.cx
	cy = cd.appPanel.cy

	cd.appPanel.cx = 0
	cd.appPanel.cy = 0
	cdMoveApps()

	px = getspritex(cd.appPanel.panel)
	py = getspritey(cd.appPanel.panel)
	pw = getspritewidth(cd.appPanel.panel)
	ph = getspriteheight(cd.appPanel.panel)
	x0 = px + pw / 2
	y0 = py + ph / 2
	x1 = x0
	y1 = y0
	gap = co.bs / 4

	//tab = cd.appTab
	x = px + co.bs / 4
	y = py + co.bs / 4
		
	for i = 0 to ma.apps.length
		
		o.name = ma.apps[i].name
		o.idx = i
		order.insertsorted(o)
		
	next
		
	for a = 0 to order.length

		i = order[a].idx
		
		if not ma.apps[i].loaded
			continue
		endif

		if ma.apps[i].status && LD_STATUS_LIBRARY
			continue
		endif
			
		cmd = ma.apps[i].cmd
		
		if not cmd

			ma.apps[i].cmd = cdCreateCmd(CODE_APP_BASE)
			cmd = ma.apps[i].cmd
			ma.cmds[cmd].codeTab = false
			cdAddCmdPart(cmd, cdCreatePartApp(i))
			part = cdCreatePart(PART_STR, " " + ma.apps[i].name)
			cdAddCmdPart(cmd, part)
			cdSetCmdFoldAlignment(cmd, CD_FOLD_RIGHT)
			
			if ma.apps[i].status && LD_STATUS_LOCKED
				cdSetCmdFoldImg(cmd, cd.builtinImg)
			else 
				cdSetCmdFoldImg(cmd, cd.loadedImg)
			endif
			
			cdSetCmdFoldable(cmd, true)
			//cdSetCmdSelectedColor(cmd, co.grey[5])
			cdSetCmdSelectedColor(cmd, cd.selCols[ma.cmds[cmd].grp])
			
		endif

		if i = cd.appIdx
			cdSetCmdSelected(ma.apps[i].cmd, vis)
		else
			cdSetCmdSelected(ma.apps[i].cmd, false)
		endif

		cdSetCmdFoldable(cmd, ma.apps[i].loaded)
		cdSetCmdPos(cmd, x, y)
		//cdSetCmdDepth(cmd, GUI_SHADOW_DEPTH)
		cdSetCmdDepth(cmd, getspritedepth(cd.appPanel.panel) - 2)
		cdSetCmdVisible(cmd, vis)
		
		ma.cmds[cmd].ox = ma.cmds[cmd].x - px
		ma.cmds[cmd].oy = ma.cmds[cmd].y - py

		if ma.cmds[cmd].x < x0
			x0 = ma.cmds[cmd].x
		endif

		if ma.cmds[cmd].y < y0
			y0 = ma.cmds[cmd].y
		endif

		tx = ma.cmds[cmd].x + ma.cmds[cmd].w - 1
		if tx > x1
			x1 = tx
		endif

		ty = ma.cmds[cmd].y + ma.cmds[cmd].h - 1
		if ty > y1
			y1 = ty
		endif
			
		y = y + ma.cmds[cmd].h + co.bs / 4 + co.bs / 8 // CD_CMD_GAP 
		
	next

	x0 = x0 - gap
	y0 = y0 - gap
	x1 = x1 + gap
	y1 = y1 + gap

	guiSetPanelContentSize(cd.appPanel, x0, y0, x1, y1)
	guiSetPanelVisible(cd.appPanel, vis)		
	guiSetPanelBarsVisible(cd.appPanel, vis)

	for i = 0 to ma.apps.length

		cmd = ma.apps[i].cmd

		if x0 < px
			ma.cmds[cmd].ox = ma.cmds[cmd].ox + (px - x0)
		endif

		if y0 < py
			ma.cmds[cmd].oy = ma.cmds[cmd].oy + (py - y0)
		endif

		cdSetCmdScissor(cmd, cd.appPanel.vx, cd.appPanel.vy, cd.appPanel.vx + cd.appPanel.vw - 1, cd.appPanel.vy + cd.appPanel.vh - 1)

	next

	cd.appPanel.cx = cx
	cd.appPanel.cy = cy
	cdMoveApps()
	
endfunction

//-----------------------------------------------------
// Show/hide things.
//
function cdSetSpritesVisible(vis as integer, startCmd as integer)

	local i as integer
	local j as integer
	local tab as integer
	local x as float
	local y as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local px as float
	local py as float
	local pw as float
	local ph as float
	local tx as float
	local ty as float
	local part as Part
	local cmd as integer
	local thingIdx as integer
	local cmds as integer[]
	local parentCmd as integer
	local startIdx as integer
	local ox as float
	local oy as float
	local gap as float
	local spr as integer
	local cx as float
	local cy as float
	local sc as float
	local partIdx as integer

	if cd.appIdx = -1
		exitfunction
	endif

	sc = cd.cmdScales[ld.set.cmdSize]

	cx = cd.cmdPanels[GRP_SPRITE].cx
	cy = cd.cmdPanels[GRP_SPRITE].cy

	cd.cmdPanels[GRP_SPRITE].cx = 0
	cd.cmdPanels[GRP_SPRITE].cy = 0
	cdMoveSprites()
	
	//tab = cd.thingTab
	px = getspritex(cd.cmdPanels[GRP_SPRITE].panel)
	py = getspritey(cd.cmdPanels[GRP_SPRITE].panel)
	pw = GetSpriteWidth(cd.cmdPanels[GRP_SPRITE].panel)
	ph = GetSpriteHeight(cd.cmdPanels[GRP_SPRITE].panel)
	x0 = px + pw / 2
	y0 = py + ph / 2
	x1 = x0
	y1 = y0
	gap = co.bs / 4

	x = px + gap
	y = py + gap

	startIdx = 0
	startCmd = 0

	if startCmd > 0

		for i = 0 to ma.apps[cd.appIdx].sprites.length

			thingIdx = ma.apps[cd.appIdx].sprites[i]
			cmd = ma.things[thingIdx].cmd

			//if cmd = startCmd
			if cmd > 0

				x = cdGetCmdPosX(cmd)
				y = cdGetCmdPosY(cmd)
				startIdx = i
				exit

			endif
			
		next

	endif

	cmds.length = -1
	
	for i = startIdx to ma.apps[cd.appIdx].sprites.length

		thingIdx = ma.apps[cd.appIdx].sprites[i]

		// Freaky code. Do images, but start with -1 for the thing so we create that cmd first.
		for j = -1 to ma.things[thingIdx].imgs.length

			if j = -1
				
				cmd = ma.things[thingIdx].cmd

				if not cmd

					ma.things[thingIdx].cmd = cdCreateCmd(CODE_SPRITE_BASE)
					cmd = ma.things[thingIdx].cmd
					ma.cmds[cmd].codeTab = false
					//cdAddCmdPart(cmd, cdCreatePartSprite(thingIdx))
					cdAddCmdPart(cmd, cdCreatePartSprite(ma.things[thingIdx].id))
					part = cdCreatePart(PART_STR, " " + ma.things[thingIdx].name)
					cdAddCmdPart(cmd, part)
					cdSetCmdFoldAlignment(cmd, CD_FOLD_RIGHT)
					cdSetCmdFoldable(cmd, true)
					cdSetCmdFolded(cmd, true)
					cdSetCmdSelectedColor(cmd, cd.selCols[ma.cmds[cmd].grp])

				endif
				
				if ma.things[thingIdx].id = cd.thingId
					cdSetCmdSelected(cmd, vis)
				else
					cdSetCmdSelected(cmd, false)
				endif

				cdSetCmdPos(cmd, x, y)
				//cdSetCmdDepth(cmd, GUI_SHADOW_DEPTH)
				cdSetCmdDepth(cmd, getspritedepth(cd.cmdPanels[GRP_SPRITE].panel) - 2)
				cdSetCmdVisible(cmd, vis)

				parentCmd = cmd

			else // Images.

				cmd = ma.things[thingIdx].imgs[j].cmd

				if not cmd

					ma.things[thingIdx].imgs[j].cmd = cdCreateCmd(CODE_FRAME_BASE)
					cmd = ma.things[thingIdx].imgs[j].cmd
					ma.cmds[cmd].codeTab = false
					cdSetCmdParent(cmd, parentCmd)
					cdAddCmdPart(cmd, cdCreatePartFrame(ma.things[thingIdx].imgs[j].id))
					part = cdCreatePart(PART_STR, " " + str(j + 1))
					cdAddCmdPart(cmd, part)
					// TODO:
					cdSetCmdSelectedColor(cmd, cd.selCols[ma.cmds[cmd].grp])
				
				endif

				if ma.things[thingIdx].imgIdx = j
					
					cdSetCmdSelected(cmd, vis)

					partIdx = cdFindPartByType(parentCmd, PART_SPRITE_ICON)

					if partIdx > -1
						
						cdClearPart(ma.cmds[parentCmd].parts[partIdx])
						//cdSetPartThing(ma.cmds[parentCmd].parts[partIdx], thingIdx)
						cdSetPartThing(ma.cmds[parentCmd].parts[partIdx], ma.things[thingIdx].id)
						cdSetCmdDepth(parentCmd, getspritedepth(cd.cmdPanels[GRP_SPRITE].panel) - 2)
						cdSetCmdVisible(parentCmd, vis)

					endif

				else
					
					cdSetCmdSelected(cmd, false)
					
				endif

				cdSetCmdPos(cmd, x + co.bs / 2, y)
				//cdSetCmdDepth(cmd, GUI_SHADOW_DEPTH)
				cdSetCmdDepth(cmd, getspritedepth(cd.cmdPanels[GRP_SPRITE].panel) - 2)

				if cdGetCmdFolded(parentCmd)
					cdSetCmdVisible(cmd, false)
				else
					cdSetCmdVisible(cmd, vis)
				endif

			endif

			cmds.insert(cmd)

			if cdGetCmdVisible(cmd)
								
				ma.cmds[cmd].ox = ma.cmds[cmd].x - px
				ma.cmds[cmd].oy = ma.cmds[cmd].y - py

				if ma.cmds[cmd].x < x0
					x0 = ma.cmds[cmd].x
				endif

				if ma.cmds[cmd].y < y0
					y0 = ma.cmds[cmd].y
				endif

				tx = ma.cmds[cmd].x + ma.cmds[cmd].w - 1
				if tx > x1
					x1 = tx
				endif

				ty = ma.cmds[cmd].y + ma.cmds[cmd].h - 1
				if ty > y1
					y1 = ty
				endif

				y = y + ma.cmds[cmd].h + (co.bs / 4 + co.bs / 8) * sc

			endif
			
		next
		
	next

	// Added.
	x0 = x0 - gap
	y0 = y0 - gap	
	x1 = x1 + gap
	y1 = y1 + gap
	
	//
	// Push cmds down, if after folding the reduction in size causes a gap at the bottom.
	//
	
	ox = 0
	oy = 0
	
	//if x0 < cd.thingPanel.vx and x1 < cd.thingPanel.vx + cd.thingPanel.vw - 1
	if x0 < px and x1 < px + pw - 1
		
		//ox = cd.thingPanel.vx + cd.thingPanel.vw - 1 - x1
		ox = px + pw - 1 - x1

		//if x0 + ox > cd.thingPanel.vx /*+ gap*/
		if x0 + ox > px
			//ox = ox - ((x0 + ox) - (cd.thingPanel.vx /*+ gap*/))
			ox = ox - ((x0 + ox) - px)
		endif

		x0 = x0 + ox
		x1 = x1 + ox

	endif

	//if y0 < cd.thingPanel.vy and y1 < cd.thingPanel.vy + cd.thingPanel.vh - 1
	if y0 < py and y1 < py + ph - 1
		
		//oy = cd.thingPanel.vy + cd.thingPanel.vh - 1 - y1
		oy = py + ph - 1 - y1

		//if y0 + oy > cd.thingPanel.vy /*+ gap*/
		if y0 + oy > py /*+ gap*/
			//oy = oy - ((y0 + oy) - (cd.thingPanel.vy/* + gap*/))
			oy = oy - ((y0 + oy) - py)
		endif
		
		y0 = y0 + oy
		y1 = y1 + oy
		
	endif

	// Adjust for overflow when folding, to ensure there is not a big gap at the bottom.
	if ox > 0 or oy > 0
		
		for i = 0 to cmds.length

			cmd = cmds[i]
			ma.cmds[cmd].x = ma.cmds[cmd].x + ox
			ma.cmds[cmd].y = ma.cmds[cmd].y + oy
			ma.cmds[cmd].ox = ma.cmds[cmd].x - px
			ma.cmds[cmd].oy = ma.cmds[cmd].y - py
			
		next
		
	endif

	guiSetPanelContentSize(cd.cmdPanels[GRP_SPRITE], x0, y0, x1, y1)
	guiSetPanelColor(cd.cmdPanels[GRP_SPRITE], cd.grpCols[GRP_SPRITE], cd.barCols[GRP_SPRITE], cd.dragCols[GRP_SPRITE])	
	guiSetPanelBarsVisible(cd.cmdPanels[GRP_SPRITE], vis)

	for i = 0 to cmds.length

		cmd = cmds[i]

		if x0 < px
			ma.cmds[cmd].ox = ma.cmds[cmd].ox + (px - x0)
		endif

		if y0 < py
			ma.cmds[cmd].oy = ma.cmds[cmd].oy + (py - y0)
		endif

		cdSetCmdScissor(cmd, cd.cmdPanels[GRP_SPRITE].vx, cd.cmdPanels[GRP_SPRITE].vy, cd.cmdPanels[GRP_SPRITE].vx + cd.cmdPanels[GRP_SPRITE].vw - 1, cd.cmdPanels[GRP_SPRITE].vy + cd.cmdPanels[GRP_SPRITE].vh - 1)

	next

	cd.cmdPanels[GRP_SPRITE].cx = cx
	cd.cmdPanels[GRP_SPRITE].cy = cy
	cdMoveSprites()

endfunction

//-----------------------------------------------------
// Show/hide sounds.
//
function cdSetSoundsVisible(vis as integer)

	local i as integer
	//local tab as integer
	local x as float
	local y as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local px as float
	local py as float
	local pw as float
	local ph as float
	local tx as float
	local ty as float
	local ox as float
	local oy as float
	local cmd as integer
	local part as Part
	local img as integer
	local spr as integer
	local idx as integer
	local gap as float
	local cx as float
	local cy as float
	local soundIdx as integer
	local o as StrOrder
	local order as StrOrder[]

	if cd.appIdx = -1
		exitfunction
	endif

	cx = cd.cmdPanels[GRP_SOUND].cx
	cy = cd.cmdPanels[GRP_SOUND].cy

	cd.cmdPanels[GRP_SOUND].cx = 0
	cd.cmdPanels[GRP_SOUND].cy = 0
	cdMoveSounds()

	px = getspritex(cd.cmdPanels[GRP_SOUND].panel)
	py = getspritey(cd.cmdPanels[GRP_SOUND].panel)
	pw = getspritewidth(cd.cmdPanels[GRP_SOUND].panel)
	ph = getspriteheight(cd.cmdPanels[GRP_SOUND].panel)
	x0 = px + pw / 2
	y0 = py + ph / 2
	x1 = x0
	y1 = y0
	gap = co.bs / 4

	//tab = cd.appTab
	x = px + co.bs / 4
	y = py + co.bs / 4
		
	for i = 0 to ma.apps[cd.appIdx].sounds.length

		o.idx = ma.apps[cd.appIdx].sounds[i]
		o.name = ma.sounds[o.idx].name
		order.insertsorted(o)
		
	next
	
	//for i = 0 to ma.apps[cd.appIdx].sounds.length
	for i = 0 to order.length

		//soundIdx = ma.apps[cd.appIdx].sounds[i]
		soundIdx = order[i].idx 
		cmd = ma.sounds[soundIdx].cmd
		
		if not cmd

			ma.sounds[soundIdx].cmd = cdCreateCmd(CODE_SOUND_BASE)
			cmd = ma.sounds[soundIdx].cmd
			ma.cmds[cmd].codeTab = false
			//cdAddCmdPart(cmd, cdCreatePartSound(soundIdx))
			cdAddCmdPart(cmd, cdCreatePartSound(ma.sounds[soundIdx].id))
			//part = cdCreatePart(PART_STR, " " + ma.sounds[ma.apps[cd.appIdx].sounds[i]].name)
			//cdAddCmdPart(cmd, part)
			
		endif

		//cdSetCmdFoldable(cmd, ma.apps[i].loaded)
		cdSetCmdPos(cmd, x, y)
		//cdSetCmdDepth(cmd, GUI_SHADOW_DEPTH)
		cdSetCmdDepth(cmd, getspritedepth(cd.cmdPanels[GRP_SOUND].panel) - 2)
		cdSetCmdVisible(cmd, vis)
		
		ma.cmds[cmd].ox = ma.cmds[cmd].x - px
		ma.cmds[cmd].oy = ma.cmds[cmd].y - py

		if ma.cmds[cmd].x < x0
			x0 = ma.cmds[cmd].x
		endif

		if ma.cmds[cmd].y < y0
			y0 = ma.cmds[cmd].y
		endif

		tx = ma.cmds[cmd].x + ma.cmds[cmd].w - 1
		if tx > x1
			x1 = tx
		endif

		ty = ma.cmds[cmd].y + ma.cmds[cmd].h - 1
		if ty > y1
			y1 = ty
		endif
			
		y = y + ma.cmds[cmd].h + co.bs / 8 // CD_CMD_GAP
		
	next

	x0 = x0 - gap
	y0 = y0 - gap
	x1 = x1 + gap
	y1 = y1 + gap

	guiSetPanelContentSize(cd.cmdPanels[GRP_SOUND], x0, y0, x1, y1)
	guiSetPanelColor(cd.cmdPanels[GRP_SOUND], cd.grpCols[GRP_SOUND], cd.barCols[GRP_SOUND], cd.dragCols[GRP_SOUND])	
	guiSetPanelBarsVisible(cd.cmdPanels[GRP_SOUND], vis)

	for i = 0 to ma.apps[cd.appIdx].sounds.length

		cmd = ma.sounds[ma.apps[cd.appIdx].sounds[i]].cmd

		if x0 < px
			ma.cmds[cmd].ox = ma.cmds[cmd].ox + (px - x0)
		endif

		if y0 < py
			ma.cmds[cmd].oy = ma.cmds[cmd].oy + (py - y0)
		endif

		cdSetCmdScissor(cmd, cd.cmdPanels[GRP_SOUND].vx, cd.cmdPanels[GRP_SOUND].vy, cd.cmdPanels[GRP_SOUND].vx + cd.cmdPanels[GRP_SOUND].vw - 1, cd.cmdPanels[GRP_SOUND].vy + cd.cmdPanels[GRP_SOUND].vh - 1)

	next

	cd.cmdPanels[GRP_SOUND].cx = cx
	cd.cmdPanels[GRP_SOUND].cy = cy
	cdMoveSounds()
	
endfunction

//-----------------------------------------------------
// Show/hide videos.
//
function cdSetVideosVisible(vis as integer)

	local i as integer
	//local tab as integer
	local x as float
	local y as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local px as float
	local py as float
	local pw as float
	local ph as float
	local tx as float
	local ty as float
	local ox as float
	local oy as float
	local cmd as integer
	local part as Part
	local img as integer
	local spr as integer
	local idx as integer
	local gap as float
	local cx as float
	local cy as float
	local videoIdx as integer
	local o as StrOrder
	local order as StrOrder[]

	if cd.appIdx = -1
		exitfunction
	endif

	cx = cd.cmdPanels[GRP_VIDEO].cx
	cy = cd.cmdPanels[GRP_VIDEO].cy

	cd.cmdPanels[GRP_VIDEO].cx = 0
	cd.cmdPanels[GRP_VIDEO].cy = 0
	cdMoveVideos()

	px = getspritex(cd.cmdPanels[GRP_VIDEO].panel)
	py = getspritey(cd.cmdPanels[GRP_VIDEO].panel)
	pw = getspritewidth(cd.cmdPanels[GRP_VIDEO].panel)
	ph = getspriteheight(cd.cmdPanels[GRP_VIDEO].panel)
	x0 = px + pw / 2
	y0 = py + ph / 2
	x1 = x0
	y1 = y0
	gap = co.bs / 4

	//tab = cd.appTab
	x = px + co.bs / 4
	y = py + co.bs / 4
		
	for i = 0 to ma.apps[cd.appIdx].videos.length

		o.idx = ma.apps[cd.appIdx].videos[i]
		o.name = ma.videos[o.idx].name
		order.insertsorted(o)

	next
	
	//for i = 0 to ma.apps[cd.appIdx].videos.length
	for i = 0 to order.length

		//videoIdx = ma.apps[cd.appIdx].videos[i]
		videoIdx = order[i].idx
		cmd = ma.videos[videoIdx].cmd
		
		if not cmd

			ma.videos[videoIdx].cmd = cdCreateCmd(CODE_VIDEO_BASE)
			cmd = ma.videos[videoIdx].cmd
			ma.cmds[cmd].codeTab = false
			//cdAddCmdPart(cmd, cdCreatePartVideo(videoIdx))
			cdAddCmdPart(cmd, cdCreatePartVideo(ma.videos[videoIdx].id))
			
		endif

		//cdSetCmdFoldable(cmd, ma.apps[i].loaded)
		cdSetCmdPos(cmd, x, y)
		//cdSetCmdDepth(cmd, GUI_SHADOW_DEPTH)
		cdSetCmdDepth(cmd, getspritedepth(cd.cmdPanels[GRP_VIDEO].panel) - 2)
		cdSetCmdVisible(cmd, vis)
		
		ma.cmds[cmd].ox = ma.cmds[cmd].x - px
		ma.cmds[cmd].oy = ma.cmds[cmd].y - py

		if ma.cmds[cmd].x < x0
			x0 = ma.cmds[cmd].x
		endif

		if ma.cmds[cmd].y < y0
			y0 = ma.cmds[cmd].y
		endif

		tx = ma.cmds[cmd].x + ma.cmds[cmd].w - 1
		if tx > x1
			x1 = tx
		endif

		ty = ma.cmds[cmd].y + ma.cmds[cmd].h - 1
		if ty > y1
			y1 = ty
		endif
			
		y = y + ma.cmds[cmd].h + co.bs / 8 // CD_CMD_GAP
		
	next

	x0 = x0 - gap
	y0 = y0 - gap
	x1 = x1 + gap
	y1 = y1 + gap

	guiSetPanelContentSize(cd.cmdPanels[GRP_VIDEO], x0, y0, x1, y1)
	guiSetPanelColor(cd.cmdPanels[GRP_VIDEO], cd.grpCols[GRP_VIDEO], cd.barCols[GRP_VIDEO], cd.dragCols[GRP_VIDEO])	
	guiSetPanelBarsVisible(cd.cmdPanels[GRP_VIDEO], vis)

	for i = 0 to ma.apps[cd.appIdx].videos.length

		cmd = ma.videos[ma.apps[cd.appIdx].videos[i]].cmd

		if x0 < px
			ma.cmds[cmd].ox = ma.cmds[cmd].ox + (px - x0)
		endif

		if y0 < py
			ma.cmds[cmd].oy = ma.cmds[cmd].oy + (py - y0)
		endif

		cdSetCmdScissor(cmd, cd.cmdPanels[GRP_VIDEO].vx, cd.cmdPanels[GRP_VIDEO].vy, cd.cmdPanels[GRP_VIDEO].vx + cd.cmdPanels[GRP_VIDEO].vw - 1, cd.cmdPanels[GRP_VIDEO].vy + cd.cmdPanels[GRP_VIDEO].vh - 1)

	next

	cd.cmdPanels[GRP_VIDEO].cx = cx
	cd.cmdPanels[GRP_VIDEO].cy = cy
	cdMoveVideos()
	
endfunction

//-----------------------------------------------------
// Show/hide vars.
//
function cdSetVarsVisible(vis as integer)

	local i as integer
	//local tab as integer
	local x as float
	local y as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local px as float
	local py as float
	local pw as float
	local ph as float
	local tx as float
	local ty as float
	local ox as float
	local oy as float
	local cmd as integer
	local part as Part
	local img as integer
	local spr as integer
	local idx as integer
	local gap as float
	local cx as float
	local cy as float
	local varIdx as integer
	local cmds as integer[]
	local pt as Point

	if cd.appIdx = -1
		exitfunction
	endif

	cx = cd.cmdPanels[GRP_VAR].cx
	cy = cd.cmdPanels[GRP_VAR].cy

	cd.cmdPanels[GRP_VAR].cx = 0
	cd.cmdPanels[GRP_VAR].cy = 0
	cdMoveVars()

	px = getspritex(cd.cmdPanels[GRP_VAR].panel)
	py = getspritey(cd.cmdPanels[GRP_VAR].panel)
	pw = getspritewidth(cd.cmdPanels[GRP_VAR].panel)
	ph = getspriteheight(cd.cmdPanels[GRP_VAR].panel)
	x0 = px + pw / 2
	y0 = py + ph / 2
	x1 = x0
	y1 = y0
	gap = co.bs / 4

	//tab = cd.appTab
	x = px + co.bs / 4
	y = py + co.bs / 4

	cmds.length = -1

	pt.x = x
	pt.y = y
	
	cdSetVarsVisibleSub(ma.apps[cd.appIdx].vars, cmds, pt, vis)

	if cd.thingIdx > -1
		cdSetVarsVisibleSub(ma.things[cd.thingIdx].vars, cmds, pt, vis)
	endif
	
	for i = 0 to cmds.length

		cmd = cmds[i]

		if cdGetCmdVisible(cmd)

			ma.cmds[cmd].ox = ma.cmds[cmd].x - px
			ma.cmds[cmd].oy = ma.cmds[cmd].y - py
			
			if ma.cmds[cmd].x < x0
				x0 = ma.cmds[cmd].x
			endif

			if ma.cmds[cmd].y < y0
				y0 = ma.cmds[cmd].y
			endif

			tx = ma.cmds[cmd].x + ma.cmds[cmd].w - 1
			if tx > x1
				x1 = tx
			endif

			ty = ma.cmds[cmd].y + ma.cmds[cmd].h - 1
			if ty > y1
				y1 = ty
			endif

		endif
		
	next
	
	x0 = x0 - gap
	y0 = y0 - gap
	x1 = x1 + gap
	y1 = y1 + gap

	guiSetPanelContentSize(cd.cmdPanels[GRP_VAR], x0, y0, x1, y1)
	guiSetPanelColor(cd.cmdPanels[GRP_VAR], cd.grpCols[GRP_VAR], cd.barCols[GRP_VAR], cd.dragCols[GRP_VAR])	
	guiSetPanelBarsVisible(cd.cmdPanels[GRP_VAR], vis)

	for i = 0 to cmds.length

		cmd = cmds[i]

		if x0 < px
			ma.cmds[cmd].ox = ma.cmds[cmd].ox + (px - x0)
		endif

		if y0 < py
			ma.cmds[cmd].oy = ma.cmds[cmd].oy + (py - y0)
		endif

		cdSetCmdScissor(cmd, cd.cmdPanels[GRP_VAR].vx, cd.cmdPanels[GRP_VAR].vy, cd.cmdPanels[GRP_VAR].vx + cd.cmdPanels[GRP_VAR].vw - 1, cd.cmdPanels[GRP_VAR].vy + cd.cmdPanels[GRP_VAR].vh - 1)
		
	next

	cd.cmdPanels[GRP_VAR].cx = cx
	cd.cmdPanels[GRP_VAR].cy = cy
	cdMoveVars()
	
endfunction

//-----------------------------------------------------
// Do the grunt work for laying our vars from the passed list.
// Return the last y pos.
//
function cdSetVarsVisibleSub(vars ref as integer[], cmds ref as integer[], pt ref as Point, vis as integer)

	local i as integer
	local j as integer
	local var as integer
	local cmd as integer
	local folded as integer
	local o as StrOrder
	local order as StrOrder[]

	for i = 0 to vars.length

		o.idx = vars[i]
		o.name = ma.vars[o.idx].name
		order.insertsorted(o)
		
	next
	
	//for i = 0 to vars.length
	for i = 0 to order.length

		//var = vars[i]
		var = order[i].idx
		cmd = ma.vars[var].cmd
		
		if not cmd

			ma.vars[var].cmd = cdCreateVarCmd(var)
			cmd = ma.vars[var].cmd
			
		endif								

		cmds.insert(cmd)

		cdSetCmdPos(cmd, pt.x, pt.y)
		//cdSetCmdDepth(cmd, GUI_SHADOW_DEPTH)
		cdSetCmdDepth(cmd, getspritedepth(cd.cmdPanels[GRP_VAR].panel) - 2)
		cdSetCmdVisible(cmd, vis)

		pt.y = pt.y + ma.cmds[cmd].h + co.bs / 8 // CD_CMD_GAP
					
		if ma.vars[var].typ = VAR_TYPE_LIST or ma.vars[var].typ = VAR_TYPE_OBJECT

			if ma.vars[var].list.length = -1

				if not cdGetCmdFolded(ma.vars[var].cmd)
					cdSetCmdFolded(ma.vars[var].cmd, true)
				endif

			else
				
				pt.x = pt.x + co.bs / 4

				for j = 0 to ma.vars[var].list.length
					
					cmd = ma.vars[var].list[j].cmd
					
					if not cmd

						ma.vars[var].list[j].cmd = cdCreateVarItemCmd(var, j, CODE_VAR_VALUE)
						cmd = ma.vars[var].list[j].cmd

					else

						cdCheckVarItemCmd(var, j)
						
					endif								

					cmds.insert(cmd)

					if not cdGetCmdFolded(ma.vars[var].cmd)
				
						cdSetCmdPos(cmd, pt.x, pt.y)
						//cdSetCmdDepth(cmd, GUI_SHADOW_DEPTH)
						cdSetCmdDepth(cmd, getspritedepth(cd.cmdPanels[GRP_VAR].panel) - 2)
						cdSetCmdVisible(ma.vars[var].list[j].cmd, vis)

						pt.y = pt.y + ma.cmds[cmd].h + co.bs / 8 // CD_CMD_GAP

					else

						cdSetCmdVisible(ma.vars[var].list[j].cmd, false)
						
					endif

				next

				pt.x = pt.x - co.bs / 4

			endif
			
		endif
		
	next

endfunction

//-----------------------------------------------------
// Show/hide code.
//
function cdSetCodeVisible(vis as integer)

	local i as integer

	if cd.thingIdx > -1
		
		for i = 0 to ma.things[cd.thingIdx].cmds.length			
			cdSetCmdVisible(ma.things[cd.thingIdx].cmds[i], vis)			
		next

	endif
		
endfunction

//-----------------------------------------------------
//
function cdShowAppBar(xx as float, yy as float)

	local x as float
	local y as float
	local w as float
	local h as float
	local spr as integer

	if cd.appIdx > -1

		w = co.bs
		h = co.bs
		x = xx - co.bs / 2
		y = yy - co.bs / 2
		
		guiPopupBar(cd.appBar, x, y, w, h)

	endif
	
endfunction

//-----------------------------------------------------
//
function cdShowThingBar(xx as float, yy as float)

	local x as float
	local y as float
	local w as float
	local h as float
	local spr as integer

	if cd.thingIdx > -1

		w = co.bs
		h = co.bs
		x = xx - co.bs / 2
		y = yy - co.bs / 2
		
		guiPopupBar(cd.spriteBar, x, y, w, h)

	endif
	
endfunction

//-----------------------------------------------------
//
function cdSetEditTitle(title as string)

	SetTextString(cd.editTitle, title)
	
endfunction

//-----------------------------------------------------
//
function cdSetEditBlankAllowed(editBlankAllowed as integer)

	cd.editBlankAllowed = editBlankAllowed
		
endfunction

//-----------------------------------------------------
// Checks where the user have clicked to place the cursor.
// Returns the cursor pos.
//
function cdSetEditClick(x as float)

	local s as string
	local t as string 
	local dx as float
	local i as integer
	local lx as float // The left position of cd.editText.
	local x0 as float
	local x1 as float
	local pos as integer

	s = cdGetEditText()
	lx = gettextx(cd.editText)
	pos = -1
	x0 = lx

	for i = 0 to len(s)

		t = left(s, i)
		SetTextString(cd.editText, t)
		dx = GetTextTotalWidth(cd.editText)

		if i > 0
			x0 = x1
		endif
		
		x1 = lx + dx

		if x1 > x
			
			pos = i

			// Check whether we are on the left side of the char, then go back 1.
			if x < x1 - (x1 - x0) / 2
				if pos > 0
					dec pos
				endif
			endif
				
			exit

		endif

	next

	SetTextString(cd.editText, s)

	if pos = -1
		pos = len(s)
	endif
	
	cdSetEditCursor(pos)
	
endfunction pos

//-----------------------------------------------------
// Highlight the cursor selection.
// pos is the second cursor pos, while cd.editClickPos is the first.
// If vis = true, and edClickPos1 > -1, then highlight the selection, otherwise clear it.
//
function cdSetEditCursorSelection(vis as integer)

	local s as string
	local cx1 as float
	local cx2 as float
	local d as float
	local x as float
	local p as integer

	if vis
		
		s = cdGetEditText()
		
		p = cd.editClickPos1

		// Calculate the x pixel position of where the cursor should be.
		SetTextString(cd.editText, left(s, p))
		cx1 = gettextx(cd.editText) + GetTextTotalWidth(cd.editText)

		p = cd.editClickPos2

		SetTextString(cd.editText, left(s, p))
		cx2 = gettextx(cd.editText) + GetTextTotalWidth(cd.editText)

		// Restore text.
		SetTextString(cd.editText, s)
		
		d = abs(cx1 - cx2)
		//SetSpriteScale(cd.editSelection, d, getheight(cd.cursorObj))
		SetSpriteScale(cd.editSelection, d, getspriteheight(cd.cursorObj))

		if cx1 < cx2
			x = cx1
		else
			x = cx2
		endif
		
		if cd.editClickPos1 > -1 and abs(cd.editClickPos2 - cd.editClickPos1) > 0

			//SetSpritePosition(cd.editSelection, x, getposy(cd.cursorObj) - getheight(cd.cursorObj) / 2)
			SetSpritePosition(cd.editSelection, x, GetSpriteYByOffset(cd.cursorObj) - getspriteheight(cd.cursorObj) / 2)
			SetSpriteVisible(cd.editSelection, true)
			//setvisible(cd.cursorObj, false)
			setspritevisible(cd.cursorObj, false)
			
		else
			
			SetSpriteVisible(cd.editSelection, false)
			//setvisible(cd.cursorObj, true)
			setspritevisible(cd.cursorObj, true)
			
		endif

	elseif not ld.set.trueEdit

		cd.editClickPos1 = -1
		cd.editClickPos2 = -1
		SetSpriteVisible(cd.editSelection, false)
		//setvisible(cd.cursorObj, true)
		setspritevisible(cd.cursorObj, true)

	endif

	if not ld.set.trueEdit	
		if getspritevisible(cd.cursorObj)
			cdOnObjTimer(cd.cursorObj)
		else
			cd.cursorObjTimer = 0
		endif
	endif
	
endfunction

//-----------------------------------------------------
//
function cdSetEditCursor(pos as integer)

	local s as string
	local dx as float
	local i as integer
	local x as float

	s = cdGetEditText()
	dx = 0

	if pos = -1 // Put cursor at end of text.
		cd.cursorPos = len(s)
	else
		cd.cursorPos = pos
	endif

	if ld.set.trueEdit

		if cd.editBox then SetEditBoxCursorPosition(cd.editBox, cd.cursorPos)

	else

		if cd.cursorPos >= 0

			// Calculate the x pixel position of where the cursor should be.
			SetTextString(cd.editText, left(s, cd.cursorPos))
			dx = GetTextTotalWidth(cd.editText)
			SetTextString(cd.editText, s)

		endif

		x = gettextx(cd.editText) + dx
		dx = 0
		
		if x - GetSpriteWidth(cd.cursorObj) < getspritex(cd.editBox)
			
			dx = getspritex(cd.editBox) - (x - GetSpriteWidth(cd.cursorObj))
			x = x + dx
						
		elseif x + GetSpriteWidth(cd.cursorObj) > getspritex(cd.editBox) + GetSpriteWidth(cd.editBox)

			dx = (getspritex(cd.editBox) + GetSpriteWidth(cd.editBox)) - (x + GetSpriteWidth(cd.cursorObj))
			x = x + dx
			
		endif
		
		SetTextPosition(cd.editText, gettextx(cd.editText) + dx, gettexty(cd.editText))		
		//setpos(cd.cursorObj, x, GetSpriteYByOffset(cd.editBox))
		SetSpritePositionByOffset(cd.cursorObj, x, GetSpriteYByOffset(cd.editBox))
		
	endif
	
endfunction

//-----------------------------------------------------
//
function cdSetEditText(txt as string)
	
	if ld.set.trueEdit		
		SetEditBoxText(cd.editBox, txt)
	else
		SetTextString(cd.editText, txt)
	endif

endfunction

//-----------------------------------------------------
//
function cdSetColorEditBoxText(idx as integer, col as integer)

	local t as string
	local s as string
	
	if cd.colorEditBox[idx].text
		if ld.set.trueEdit
			t = GetEditBoxText(cd.colorEditBox[idx].box)
		else
			t = GetTextString(cd.colorEditBox[idx].text)
		endif
	endif
	
	if left(t, 1) = "#"
		s = coColorSegmentToHex(col, 0)
	else
		s = coColorSegmentToDec(col, 0)
	endif

	if cd.colorEditBox[idx].text
		if ld.set.trueEdit		
			SetEditBoxText(cd.colorEditBox[idx].box, s)
		else
			SetTextString(cd.colorEditBox[idx].text, s)
		endif
	endif

endfunction

//-----------------------------------------------------
//
function cdSetColorEditText(txt as string)

	local col as integer
	local s as string 

	col = coMakeColor(txt)

	cdSetColorEditBoxText(0, GetColorRed(col))
	cdSetColorEditBoxText(1, GetColorGreen(col))
	cdSetColorEditBoxText(2, GetColorBlue(col))
	cdSetColorEditBoxText(3,coGetColorAlpha(col))

	// If col = 0, then can't accept, otherwise ok.
	guiSetButtonActive(cd.acceptBut, col)
	
endfunction

//-----------------------------------------------------
//
function cdSetResizeEditBoxText(idx as integer, s as string)

	if ld.set.trueEdit		
		SetEditBoxText(cd.resizeEditBox[idx].text, s)
	else
		SetTextString(cd.resizeEditBox[idx].text, s)
	endif

endfunction

//-----------------------------------------------------
//
function cdSetResizeEditText()

	local w as integer
	local h as integer

	if cd.edi.resizedSpr
		
		w = GetSpriteWidth(cd.edi.resizedSpr)
		h = GetSpriteHeight(cd.edi.resizedSpr)

	else

		w = GetSpriteWidth(cd.edi.origSpr)
		h = GetSpriteHeight(cd.edi.origSpr)

	endif
	
	cdSetResizeEditBoxText(0, str(w))
	cdSetResizeEditBoxText(1, str(h))

endfunction

//-----------------------------------------------------
//
function cdGetEditText()

	local ret as string
		
	if ld.set.trueEdit
		if cd.editBox
			ret = GetEditBoxText(cd.editBox)
		else 
			ret = ""
		endif
	else
		ret = GetTextString(cd.editText)
	endif
	
endfunction ret

//-----------------------------------------------------
//
function cdGetColorEditText()

	local ret as string
	local tmp as string
	local r as integer
	local g as integer
	local b as integer
	local a as integer
	local col as integer

	if ld.set.trueEdit
		
		tmp = GetEditBoxText(cd.colorEditBox[0].box)
		r = coMakeColorSegment(tmp)
		tmp = GetEditBoxText(cd.colorEditBox[1].box)
		g = coMakeColorSegment(tmp)
		tmp = GetEditBoxText(cd.colorEditBox[2].box)
		b = coMakeColorSegment(tmp)
		tmp = GetEditBoxText(cd.colorEditBox[3].box)
		a = coMakeColorSegment(tmp)
		col = MakeColor(r, g, b)
		col = coSetColorAlpha(col, a)
		ret = coColorToDec(col)
		
	else
		
		tmp = GetTextString(cd.colorEditBox[0].text)
		r = coMakeColorSegment(tmp)
		tmp = GetTextString(cd.colorEditBox[1].text)
		g = coMakeColorSegment(tmp)
		tmp = GetTextString(cd.colorEditBox[2].text)
		b = coMakeColorSegment(tmp)
		tmp = GetTextString(cd.colorEditBox[3].text)
		a = coMakeColorSegment(tmp)
		col = MakeColor(r, g, b)
		col = coSetColorAlpha(col, a)
		ret = coColorToDec(col)
		
	endif
	
endfunction ret

//-----------------------------------------------------
//
function cdGetResizeEditText(idx as integer)

	local ret as float

	if ld.set.trueEdit
		ret = val(GetEditBoxText(cd.resizeEditBox[idx].text)	)
	else
		ret = val(GetTextString(cd.resizeEditBox[idx].text))
	endif

endfunction ret

//-----------------------------------------------------
//
function cdCheckEditChanged()

	local ret as integer

	if ld.set.trueEdit
		
		if cd.editBox
			
			ret = GetEditBoxChanged(cd.editBox)
	
			if ret
				//SetEditBoxFocus(cd.editBox, true)			
			endif
			
		else 
			
			ret = false
		
		endif

	else

		ret = false
		
	endif

endfunction ret

//-----------------------------------------------------
//
function cdSetEditVisible(vis as integer)

	local helpMsg as string
	local msg as string 
	local i as integer
	local editText as integer

	guiSetButtonVisible(cd.acceptBut, vis)
	guiSetButtonVisible(cd.cancelBut, vis)

	if not vis
		guiSetButtonVisible(cd.autoAcceptBut, false)
	endif
	
	if cd.editMode = CD_EDIT_TAGS

		SetTextVisible(cd.editTitle, vis)
		guiSetButtonActive(cd.acceptBut, true)
		
	else
			
		SetTextVisible(cd.editTitle, vis)

		if not vis

			for i = 0 to cd.colorEditBox.length
				SetTextVisible(cd.colorEditbox[i].title, vis)
			next

			for i = 0 to cd.resizeEditBox.length
				SetTextVisible(cd.resizeEditbox[i].title, vis)
			next

		elseif cd.editMode = CD_EDIT_COLOR

			for i = 0 to cd.colorEditBox.length
				SetTextVisible(cd.colorEditbox[i].title, vis)
			next

		elseif cd.subMode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE

			for i = 0 to cd.resizeEditBox.length
				SetTextVisible(cd.resizeEditbox[i].title, vis)
			next
			
		endif

		if vis
			
			guiSetButtonActive(cd.acceptBut, true)

			helpMsg = cdGetEditHelpMsg()
			
			if helpMsg <> ""

				// TODO: Doesn't work with real EditBox.
				guiShowTip(gui.tip, cd.editBox, helpMsg, TIP_WARN, 0)
				cdReposEditBoxTip()
				guiSetButtonActive(cd.acceptBut, false)

			endif		

		endif
	
		if ld.set.trueEdit
			
			//SetSpriteVisible(cd.editBg, vis)
			setEditBoxVisible(cd.editBox, vis)

			if vis

				SetEditBoxFocus(cd.editBox, true)
				SetEditBoxCursorPosition(cd.editBox, len(GetEditBoxText(cd.editBox)))
				
			endif

			// Set the cursor well offscreen so we don't see it.
			//setpos(cd.cursorObj, -100, -100)
			if cd.cursorObj then SetSpritePositionByOffset(cd.cursorObj, -100, -100)

			if not vis

				for i = 0 to cd.colorEditBox.length
					if cd.colorEditbox[i].box then SetEditBoxVisible(cd.colorEditbox[i].box, vis)
				next

				for i = 0 to cd.resizeEditBox.length
					if cd.resizeEditbox[i].box then SetEditBoxVisible(cd.resizeEditbox[i].box, vis)
				next

			elseif cd.editMode = CD_EDIT_COLOR

				for i = 0 to cd.colorEditBox.length
					if cd.colorEditbox[i].box then SetEditBoxVisible(cd.colorEditbox[i].box, vis)
				next
				
			elseif cd.subMode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE

				for i = 0 to cd.resizeEditBox.length
					if cd.resizeEditbox[i].box then SetEditBoxVisible(cd.resizeEditbox[i].box, vis)
				next

			endif
			
		else
				
			SetSpriteScissor(cd.editBox, GetSpriteX(cd.editBox), getspritey(cd.editBox), getspritex(cd.editBox) + GetSpriteWidth(cd.editBox) - 1, getspritey(cd.editBox) + getspriteheight(cd.editBox) - 1)
			SetTextScissor(cd.editText, GetSpriteX(cd.editBox), getspritey(cd.editBox), getspritex(cd.editBox) + GetSpriteWidth(cd.editBox) - 1, getspritey(cd.editBox) + getspriteheight(cd.editBox) - 1)
			SetSpriteScissor(cd.editSelection, GetSpriteX(cd.editBox), getspritey(cd.editBox), getspritex(cd.editBox) + GetSpriteWidth(cd.editBox) - 1, getspritey(cd.editBox) + getspriteheight(cd.editBox) - 1)
			
			SetSpriteVisible(cd.editBox, vis)
			SetTextVisible(cd.editText, vis)

			if not vis

				for i = 0 to cd.colorEditBox.length
					
					SetSpriteVisible(cd.colorEditbox[i].lt, vis)
					SetSpriteVisible(cd.colorEditbox[i].rt, vis)
					SetSpriteVisible(cd.colorEditbox[i].box, vis)
					SetTextVisible(cd.colorEditbox[i].text, vis)
					
				next

				for i = 0 to cd.resizeEditBox.length
					
					SetSpriteVisible(cd.resizeEditbox[i].box, vis)
					SetTextVisible(cd.resizeEditbox[i].text, vis)
					
				next

			elseif cd.editMode = CD_EDIT_COLOR

				for i = 0 to cd.colorEditBox.length
					
					SetSpriteVisible(cd.colorEditbox[i].lt, vis)
					SetSpriteVisible(cd.colorEditbox[i].rt, vis)

					SetSpriteVisible(cd.colorEditbox[i].box, vis)
					SetSpriteScissor(cd.colorEditbox[i].box, GetSpriteX(cd.colorEditbox[i].box), getspritey(cd.colorEditbox[i].box), getspritex(cd.colorEditbox[i].box) + GetSpriteWidth(cd.colorEditbox[i].box) - 1, getspritey(cd.colorEditbox[i].box) + getspriteheight(cd.colorEditbox[i].box) - 1)

					SetTextVisible(cd.colorEditbox[i].text, vis)
					SetTextScissor(cd.colorEditbox[i].text, GetSpriteX(cd.colorEditbox[i].box), getspritey(cd.colorEditbox[i].box), getspritex(cd.colorEditbox[i].box) + GetSpriteWidth(cd.colorEditbox[i].box) - 1, getspritey(cd.colorEditbox[i].box) + getspriteheight(cd.colorEditbox[i].box) - 1)
					
				next

			elseif cd.subMode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE

				for i = 0 to cd.resizeEditBox.length
					
					SetSpriteVisible(cd.resizeEditbox[i].box, vis)
					SetSpriteScissor(cd.resizeEditbox[i].box, GetSpriteX(cd.resizeEditbox[i].box), getspritey(cd.resizeEditbox[i].box), getspritex(cd.resizeEditbox[i].box) + GetSpriteWidth(cd.resizeEditbox[i].box) - 1, getspritey(cd.resizeEditbox[i].box) + getspriteheight(cd.resizeEditbox[i].box) - 1)

					SetTextVisible(cd.resizeEditbox[i].text, vis)
					SetTextScissor(cd.resizeEditbox[i].text, GetSpriteX(cd.resizeEditbox[i].box), getspritey(cd.resizeEditbox[i].box), getspritex(cd.resizeEditbox[i].box) + GetSpriteWidth(cd.resizeEditbox[i].box) - 1, getspritey(cd.resizeEditbox[i].box) + getspriteheight(cd.resizeEditbox[i].box) - 1)
					
				next
				
			endif
		
			cd.editClickPos1 = -1
			cd.editClickPos2 = -1
			SetSpriteVisible(cd.editSelection, false)

			//setvisible(cd.cursorObj, vis)
			setspritevisible(cd.cursorObj, vis)

			if vis		
				cdOnObjTimer(cd.cursorObj)			
			else			
				cd.cursorObjTimer = 0
			endif
				
		endif

	endif
	
	cd.partFlashDelta = -5
	cd.partFlashAlpha = 255

	if vis		
		cdOnObjTimer(cd.partFlashObj)
	else
		cd.partFlashObjtimer =  0
	endif		

endfunction

//-----------------------------------------------------
// object update.
//
function cdOnObjUpdate(obj as integer)

	if obj = 0 then exitfunction // 0=junk, 1=cursor

endfunction

//-----------------------------------------------------
// Timer tick.
//
function cdOnObjTimer(obj as integer)

	//if obj = 0 then exitfunction // 0=junk

	local vis as integer

	if obj = cd.cursorObj

		vis = GetSpriteVisible(cd.cursorObj)
		setspritevisible(cd.cursorObj, not vis)
		
		if cdIsEditActive()
			cd.cursorObjTimer = CD_CURSOR_TIMER
		endif

	elseif obj = cd.partFlashObj

		if cd.cmdSelLt
			SetSpriteColorAlpha(cd.cmdSelLt, cd.partFlashAlpha)
		endif
		
		if cd.cmdSelMid
			SetSpriteColorAlpha(cd.cmdSelMid, cd.partFlashAlpha)
		endif
		
		if cd.cmdSelRt
			SetSpriteColorAlpha(cd.cmdSelRt, cd.partFlashAlpha)
		endif

		cd.partFlashAlpha = cd.partFlashAlpha + cd.partFlashDelta

		if cd.partFlashAlpha = cd.partFlashMin or cd.partFlashAlpha = cd.partFlashMax
			cd.partFlashDelta = -cd.partFlashDelta
		endif

		if cdIsEditActive()
			cd.partFlashObjTimer = CD_PART_FLASH_TIMER
		endif
/*
	elseif obj = cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].spr

		setspritecoloralpha(cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].spr, cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].alpha)
		
		cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].alpha = cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].alpha + cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].delta

		if cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].alpha <= cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].min 

			cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].alpha = cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].min
			cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].delta = -cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].delta

		elseif cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].alpha >= cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].max

			cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].alpha = cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].max
			cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].delta = -cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].delta

		endif
				
		if cd.helpInter.howTo and cd.helpInter.animtaskIdx > -1
			cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].timer = CD_ANIM_TIMER
		endif		
*/		
	//elseif obj = cd.pingObj

	//	cdPingTimer()
		
	endif
	
endfunction

//-----------------------------------------------------
//
function cdIsEditActive()

	local ret as integer

	//ret = GetSpriteVisible(cd.acceptBut.bg)
	if cd.editMode <> CD_EDIT_NONE
		
		if not cd.pressed
			
			if cd.editMode = CD_EDIT_END
				
				ret = false			
				cd.editMode = CD_EDIT_NONE
			
			else
	
				ret = true
			
			endif
			
		else
			
			ret = true
			
		endif
		
	else
		
		ret = false
		
	endif
	
endfunction ret

/*
//-----------------------------------------------------
//
function cdIsEditToolActive()

	local ret as integer

	ret = GetSpriteVisible(cd.edimg.ctrlPanel.panel)
	
endfunction ret
*/

//-----------------------------------------------------
// Returns 0 if cancelled, 1 if accepted, -1 for not action.
//
function cdIsEditPressed(x as float, y as float)

	local ret as integer

	if guiGetButtonPressed(cd.acceptBut, x, y, 1)		
		ret = 1
	elseif guiGetButtonPressed(cd.cancelBut, x, y, 1)
		ret = 0
	else
		ret = -1
	endif
	
endfunction ret

//-----------------------------------------------------
// Move / touch down.
//
function cdHandleKeyboard(x as float, y as float)

	local i as integer
	local scanCode as integer
	local butIdx as integer
	local c as string
	local m as integer
	
	if cd.kbdIdx = -1
		exitfunction
	endif

	for i = 0 to cd.keyBar[cd.kbdIdx].buts.length

		if guiGetButtonPressed(cd.keyBar[cd.kbdIdx].buts[i], x, y, 1)

			cdAddKeyPress(cd.kbdIdx, i)
			
			scanCode = cd.keyBar[cd.kbdIdx].buts[i].id
			butIdx = guiFindBarButtonById(cd.keybar[cd.kbdIdx], scanCode)

			if inIsScanControl(scanCode)
				c = ""
			elseif scanCode > 0
				if cd.keybar[cd.kbdIdx].buts[butIdx].text
					c = gettextstring(cd.keybar[cd.kbdIdx].buts[butIdx].text)
				else 
					c = ""
				endif
			elseif scanCode < 0
				c = gettextstring(cd.keybar[cd.kbdIdx].buts[butIdx].icon)
			endif

			m = GetMilliseconds()
				
			if cd.key <> "" and cd.key = c // Handle repeat.

				if m - cd.keyRepeatTime >= cd.keyWaitTime

					cd.keyRepeatTime = m
					cd.keyWaitTime = KEY_REPEAT_TIME
					OnKeyAction(scanCode, c)

				endif
								
			elseif cd.scanCode <> 0 and cd.scanCode = scanCode // Handle repeat.

				if scanCode = KEY_BACK or scanCode = KEY_CTRL_LEFT or scanCode = KEY_CTRL_RIGHT
					
					if m - cd.keyRepeatTime >= cd.keyWaitTime

						cd.keyRepeatTime = m
						cd.keyWaitTime = KEY_REPEAT_TIME
						OnKeyAction(scanCode, c)

					endif

				endif
				

			else // Press.

				cd.keyRepeatTime = m
				cd.keyWaitTime = KEY_WAIT_TIME
				OnKeyAction(scanCode, c)
				
			endif

			//OnKeyAction(scanCode, c)
			
			exit
			
		endif

	next
	
endfunction

//-----------------------------------------------------
// Fix the tip for the edit box.
//
function cdReposEditBoxTip()

	local gap as float
	local ox as float
	local oy as float
	local i as integer
	local spr as integer
	
	gap = co.bs / 4 //- 4

	if cd.editMode = CD_EDIT_COLOR
		spr = cd.colorEditBox[0].box
	else 
		if cd.submode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE
			spr = cd.resizeEditBox[0].box
		else
			spr = cd.editBox
		endif
	endif
	
	setspriteangle(gui.tip.Arrow, 90)
	SetSpritePositionByOffset(gui.tip.Arrow, getspritex(spr) - gap / 2, GetSpriteYByOffset(spr))

	if gui.tip.arrowShadow

		setspriteangle(gui.tip.Arrowshadow, 90)
		SetSpritePositionByOffset(gui.tip.Arrowshadow, getspritex(spr) - gap / 2 + CD_CMD_GAP, GetSpriteYByOffset(spr) + CD_CMD_GAP)

	endif

	ox = GetSpriteXByOffset(gui.tip.Box)
	oy = GetSpriteYByOffset(gui.tip.Box)
	
	if gui.tip.border
		
		SetSpritePositionByOffset(gui.tip.Border, getspritex(spr) - GetSpriteWidth(gui.tip.Border) / 2 - gap, GetSpriteYByOffset(spr))
		SetSpritePositionByOffset(gui.tip.Box, getspritex(spr) - GetSpriteWidth(gui.tip.Border) / 2 - gap, GetSpriteYByOffset(spr))
		ox = ox - GetSpriteXByOffset(gui.tip.Border)
		oy = oy - GetSpriteYByOffset(gui.tip.Border)
	
		SetSpritePositionByOffset(gui.tip.Shadow, getspritex(spr) - GetSpriteWidth(gui.tip.Border) / 2 + CD_CMD_GAP - gap, GetSpriteYByOffset(spr) + CD_CMD_GAP)

	else 
		
		SetSpritePositionByOffset(gui.tip.Box, getspritex(spr) - GetSpriteWidth(gui.tip.box) / 2 - gap, GetSpriteYByOffset(spr))
		ox = ox - GetSpriteXByOffset(gui.tip.box)
		oy = oy - GetSpriteYByOffset(gui.tip.box)
	
		SetSpritePositionByOffset(gui.tip.Shadow, getspritex(spr) - GetSpriteWidth(gui.tip.box) / 2 + CD_CMD_GAP - gap, GetSpriteYByOffset(spr) + CD_CMD_GAP)
	
	endif

/*
	for i = 0 to gui.tip.Text.length
		SetTextPosition(gui.tip.Text[i], gettextx(gui.tip.Text[i]) - ox, gettexty(gui.tip.Text[i]) - oy)
	next
*/

	//SetTextPosition(gui.tip.Text2, gettextx(gui.tip.Text2) - ox, gettexty(gui.tip.Text2) - oy)
	SetTextPosition(gui.tip.Text2, GetSpriteXByOffset(gui.tip.box), GetSpriteYByOffset(gui.tip.box) - GetTextTotalHeight(gui.tip.text2) / 2)
	SetTextScissor(gui.tip.text2, getspritex(gui.tip.box), getspritey(gui.tip.box), getspritex(gui.tip.box) + GetSpriteWidth(gui.tip.box) - 1, getspritey(gui.tip.box) + GetSpriteHeight(gui.tip.box) - 1)

endfunction

//-----------------------------------------------------
// Fix the tip for the edit box.
//
function cdReposCodePanelTip()

	local gap as float
	local ox as float
	local oy as float
	local i as integer
	local spr as integer
	local y as float
	
	gap = co.bs / 4
	spr = cd.codePanel.panel
	
	if gui.tip.border
		y = GetSpriteY(spr) + GetSpriteHeight(gui.tip.Border) / 2
	else 
		y = GetSpriteY(spr) + GetSpriteHeight(gui.tip.box) / 2
	endif
	
	setspriteangle(gui.tip.Arrow, 90)
	SetSpritePositionByOffset(gui.tip.Arrow, getspritex(spr) - gap / 2, y)

	if gui.tip.arrowShadow

		setspriteangle(gui.tip.Arrowshadow, 90)
		SetSpritePositionByOffset(gui.tip.Arrowshadow, getspritex(spr) - gap / 2 + CD_CMD_GAP, y + CD_CMD_GAP)

	endif
	
	ox = GetSpriteXByOffset(gui.tip.Box)
	oy = GetSpriteYByOffset(gui.tip.Box)
	
	if gui.tip.border
		
		SetSpritePositionByOffset(gui.tip.Border, getspritex(spr) - GetSpriteWidth(gui.tip.Border) / 2 - gap, y)
		SetSpritePositionByOffset(gui.tip.Box, getspritex(spr) - GetSpriteWidth(gui.tip.Border) / 2 - gap, y)
		ox = ox - GetSpriteXByOffset(gui.tip.Border)
		oy = oy - GetSpriteYByOffset(gui.tip.Border)
		SetSpritePositionByOffset(gui.tip.Shadow, getspritex(spr) - GetSpriteWidth(gui.tip.Border) / 2 + CD_CMD_GAP - gap, y + CD_CMD_GAP)
		
	else 

		SetSpritePositionByOffset(gui.tip.Box, getspritex(spr) - GetSpriteWidth(gui.tip.box) / 2 - gap, y)
		ox = ox - GetSpriteXByOffset(gui.tip.box)
		oy = oy - GetSpriteYByOffset(gui.tip.box)
		SetSpritePositionByOffset(gui.tip.Shadow, getspritex(spr) - GetSpriteWidth(gui.tip.box) / 2 + CD_CMD_GAP - gap, y + CD_CMD_GAP)

	endif


	SetTextPosition(gui.tip.Text2, GetSpriteXByOffset(gui.tip.box), GetSpriteYByOffset(gui.tip.box) - GetTextTotalHeight(gui.tip.text2) / 2)
	SetTextScissor(gui.tip.text2, getspritex(gui.tip.box), getspritey(gui.tip.box), getspritex(gui.tip.box) + GetSpriteWidth(gui.tip.box) - 1, getspritey(gui.tip.box) + GetSpriteHeight(gui.tip.box) - 1)
	
endfunction

//-----------------------------------------------------
// Key was released.
//
function OnKeyAction(scanCode as integer, c as string)

	local valid as integer
	local s as string
	local t as string
	local t2 as string 
	local pos as integer
	local helpMsg as string
	local col as integer
	local colorEditBoxIdx as integer
	local resizeEditBoxIdx as integer
	local i as integer
	//local i as integer
	//local msg as string
	//local editText as integer

	if cd.kbdIdx = -1
		exitfunction
	endif
	
	valid = false
	
	if c <> "" and len(c) = 1 // Single key.
		
		if findstring(cd.keySet[cd.keySetIdx].normSet, c) > 0

			if findstring(cd.keySet[cd.keySetIdx].hiddenSet, c) > 0
				valid = false
			else 
				valid = true
			endif

		elseif cd.keySet[cd.keySetIdx].helpMsg <> ""

			helpMsg = "Key not allowed. " + cd.keySet[cd.keySetIdx].helpMsg

			guiShowTip(gui.tip, cd.editBox, helpMsg, TIP_WARN, 0)
			cdReposEditBoxTip()

		endif
		
	else
		
		valid = true
		
	endif

	// Don't process the key if it is not valid for this keyboard.
	if not valid
		exitfunction
	endif
	
	if c <> "" // Visible chr.

		guiHideTip(gui.tip)
		guiSetButtonActive(cd.acceptBut, true)

		cd.scanCode = 0
		cd.key = c
		s = cdGetEditText()

		if cd.editClickPos1 <> cd.editClickPos2

			t = left(s, cd.editClickPos1) + c + mid(s, cd.editClickPos2 + 1, -1)
			//t2 = cdGetValidTextEntry(t)

			//if t2 <> t				
			//	valid = false				
			//endif
			
			if valid

				cdSetEditText(t)
				//cdSetEditCursor(cd.editClickPos1 + 1)
				cdSetEditCursor(cd.editClickPos1 + len(c))
				cdSetEditCursorSelection(false)

			elseif cd.keySet[cd.keySetIdx].helpMsg <> ""
				
				guiShowTip(gui.tip, cd.editBox, cd.keySet[cd.keySetIdx].helpMsg, TIP_WARN, 0)
				cdReposEditBoxTip()
				guiSetButtonActive(cd.acceptBut, false)

			endif
			
		else
			
			t = left(s, cd.cursorPos) + c + mid(s, cd.cursorPos + 1, -1)
			//t2 = cdGetValidTextEntry(t)

			//if t2 <> t
			//	valid = false							
			//endif

			if valid
				
				cdSetEditText(t)
				//cdSetEditCursor(cd.cursorPos + 1)
				cdSetEditCursor(cd.cursorPos + len(c))

			elseif cd.keySet[cd.keySetIdx].helpMsg <> ""

				guiShowTip(gui.tip, cd.editBox, cd.keySet[cd.keySetIdx].helpMsg, TIP_WARN, 0)
				cdReposEditBoxTip()
				guiSetButtonActive(cd.acceptBut, false)

			endif

		endif
		
	else

		cd.scanCode = scanCode
		cd.key = ""
		
		if scanCode = KEY_ESCAPE

			cdSetEditCursorSelection(false)			
			cdEditEnd(false)

		elseif scanCode = KEY_ENTER

			if cd.acceptBut.active

				cdSetEditCursorSelection(false)			
				cdEditAccept()
				cdEditEnd(true)

			endif
			
		elseif scanCode = KEY_BACK

			guiHideTip(gui.tip)
			guiSetButtonActive(cd.acceptBut, true)

			if cd.editClickPos1 <> cd.editClickPos2

				s = cdGetEditText()
				t = left(s, cd.editClickPos1) + mid(s, cd.editClickPos2 + 1, -1)
				cdSetEditText(t)
				cdSetEditCursor(cd.editClickPos1)			
				cdSetEditCursorSelection(false)			

			elseif cd.cursorPos > 0
				
				s = cdGetEditText()
				t = left(s, cd.cursorPos - 1) + mid(s, cd.cursorPos + 1, -1)			
				cdSetEditText(t)
				cdSetEditCursor(cd.cursorPos - 1)			
				
			endif
			
		elseif scanCode = KEY_TAB

			if cd.editMode = CD_EDIT_COLOR

				colorEditBoxIdx = -1
				
				for i = 0 to cd.colorEditBox.length

					if cd.editBox = cd.colorEditBox[i].box

						colorEditBoxIdx = i
						exit

					endif
					
				next

				if colorEditBoxIdx > -1
					
					inc colorEditBoxIdx
					
					if colorEditBoxIdx > cd.colorEditBox.length
						colorEditBoxIdx = 0
					endif

					cd.editBox = cd.colorEditBox[colorEditBoxIdx].box
					cd.editText = cd.colorEditBox[colorEditBoxIdx].text
					cdSetEditCursor(-1)
					cdSetEditVisible(true)

				endif
				
			elseif cd.subMode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE

				resizeEditBoxIdx = -1
				
				for i = 0 to cd.resizeEditBox.length

					if cd.editBox = cd.resizeEditBox[i].box

						resizeEditBoxIdx = i
						exit

					endif
					
				next

				if resizeEditBoxIdx > -1
					
					inc resizeEditBoxIdx
					
					if resizeEditBoxIdx > cd.resizeEditBox.length
						resizeEditBoxIdx = 0
					endif

					cd.editBox = cd.resizeEditBox[resizeEditBoxIdx].box
					cd.editText = cd.resizeEditBox[resizeEditBoxIdx].text
					cdSetEditCursor(-1)
					cdSetEditVisible(true)

				endif
				
			endif

		elseif scanCode = KEY_CTRL_LEFT

			if cd.editClickPos1 <> cd.editClickPos2

				cdSetEditCursor(cd.editClickPos1)			
				cdSetEditCursorSelection(false)			
			
			elseif cd.cursorPos > 0
				
				cdSetEditCursor(cd.cursorPos - 1)
						
			endif

		elseif scanCode = KEY_CTRL_RIGHT

			if cd.editClickPos1 <> cd.editClickPos2

				cdSetEditCursor(cd.editClickPos2)			
				cdSetEditCursorSelection(false)			

			else

				s = cdGetEditText()

				if cd.cursorPos < len(s)			
					cdSetEditCursor(cd.cursorPos + 1)			
				endif

			endif
			
		elseif scanCode = KEY_SHIFT
			
			if cd.kbdIdx = CD_KBD_LOWER
				cd.kbdIdx = CD_KBD_UPPER
			endif
			
			cdSetKeyboardVisible(cd.kbdIdx)
			
		elseif scanCode = KEY_CTRL_UNSHIFT

			if cd.kbdIdx = CD_KBD_UPPER
				cd.kbdIdx = CD_KBD_LOWER
			endif
			
			cdSetKeyboardVisible(cd.kbdIdx)

		elseif scanCode = KEY_CTRL_123

			if cd.kbdIdx = CD_KBD_UPPER or cd.kbdIdx = CD_KBD_LOWER or cd.kbdIdx = CD_KBD_SYM2
				cd.kbdIdx = CD_KBD_NUMSYM
			endif

			cdSetKeyboardVisible(cd.kbdIdx)

		elseif scanCode = KEY_CTRL_ABC
			
			if cd.kbdIdx = CD_KBD_NUMSYM or cd.kbdIdx = CD_KBD_SYM2
				cd.kbdIdx = CD_KBD_LOWER
			endif

			cdSetKeyboardVisible(cd.kbdIdx)

		elseif scanCode = KEY_CTRL_SYM
			
			if cd.kbdIdx = CD_KBD_NUMSYM
				cd.kbdIdx = CD_KBD_SYM2
			endif

			cdSetKeyboardVisible(cd.kbdIdx)

		endif
		
	endif

	if cd.acceptBut.active

		helpMsg = cdGetEditHelpMsg()
		
		if helpMsg <> ""

			guiShowTip(gui.tip, cd.editBox, helpMsg, TIP_WARN, 0)
			cdReposEditBoxTip()
			guiSetButtonActive(cd.acceptBut, false)

		elseif cd.kbdIdx = CD_KBD_COLOR

			s = cdGetColorEditText()
			col = coMakeColor(s)

			if cd.editMode = CD_EDIT_COLOR

				if cd.submode = CD_SUBMODE_EDIT_IMAGE_COLOR or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL

					coSetSpriteColor(cd.editBut.icon2, col)
							
					if col = 0
						
						helpMsg = "Color (ret = 0, green = 0, blue = 0, alpha = 0) is not a valid drawing color."
						guiShowTip(gui.tip, cd.editBox, helpMsg, TIP_WARN, 0)
						cdReposEditBoxTip()
						guiSetButtonActive(cd.acceptBut, false)

					endif

				else
					
					coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].spr, col)
					coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].lt, col)
					coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].rt, col)

				endif
				
			endif
			
		elseif cd.editMode = CD_EDIT_TEXT

			if cd.submode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE
				cdShowEditResizeSpr()
			endif
			
		endif		
		
	endif
	
endfunction

//-----------------------------------------------------
// Get the help msg for the current text value. Handles specialisation for color.
//
function cdGetEditHelpMsg()

	local i as integer
	local msg as string
	local editText as integer
	local s as string
	local helpMsg as string
	local w as integer
	local h as integer
	local col as integer

	helpMsg = ""
	
	if cd.editMode = CD_EDIT_COLOR
		
		editText = cd.editText
		msg = ""
		
		for i = 0 to cd.colorEditBox.length

			cd.editText = cd.colorEditBox[i].text
			s = cdGetEditText()

			//if s = "" and not cd.editBlankAllowed
			//	guiSetButtonActive(cd.acceptBut, false)
			//endif

			msg = cdGetValidTextRules(s)

			if msg <> ""

				if helpMsg = ""
					helpMsg = msg
				endif
				
				helpMsg = helpMsg + chr(10) + cd.colorEditBox[i].err
				
			endif

		next
		
		cd.editText = editText

	elseif cd.submode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE

		w = cdGetResizeEditText(0)
		h = cdGetResizeEditText(1)

		if w <= 0 or h <= 0 or w > co.w or h > co.h
			helpMsg = "Image width must be between 1 and " + str(round(co.w)) + ", and height must be between 1 and " + str(round(co.h)) + "."
		endif
		
	else
	
		s = cdGetEditText()
		
//		if s = "" and not cd.editBlankAllowed
//			guiSetButtonActive(cd.acceptBut, false)
//		endif

		helpMsg = cdGetValidTextRules(s)

	endif

endfunction helpMsg

//-----------------------------------------------------
// Check the value of the edit text to see if it matches rule.
//
function cdCheckEditText()

	local s as string
	local col as integer
	local helpMsg as string 

	guiHideTip(gui.tip)
	guiSetButtonActive(cd.acceptBut, true)
	
	//s = cdGetEditText()

//	if s = "" and not cd.editBlankAllowed
//		guiSetButtonActive(cd.acceptBut, false)
//	endif
	
	//helpMsg = cdGetValidTextRules(s)
	helpMsg = cdGetEditHelpMsg()

	if helpMsg <> ""

		guiShowTip(gui.tip, cd.editBox, helpMsg, TIP_WARN, 0)
		cdReposEditBoxTip()
		guiSetButtonActive(cd.acceptBut, false)

	endif		
	
endfunction helpMsg = ""

//-----------------------------------------------------
// End editing.
//
function cdEditEnd(editState as integer)
	
	guiHideTip(gui.tip)

	//if cdIsEditToolActive()
	//	guiSetBarAlpha(cd.edimg.toolbar, 255)
	//else
		cdSetAllAlpha(255)
	//endif
	
	cd.editMode = CD_EDIT_END
	cdSetEditVisible(false)
		
	SetTextVisible(cd.editCmdTitle, false)
	cdSetKeyboardVisible(-1)
	guiSetPanelVisible(cd.keyPanel, false)
	cdHideCmdHover()
	cdClearLibItem(cd.currLibItem)
	cdShowColorEditor(false)
	cdHideObjEditor()
	cdHidePrevEditValues(false)
	
	// Restore edit position.
	//guiSetPanelPos(cd.keyPanel, cd.keypanelx, cd.keypanely)
	
	if cd.editCmd
		
		ma.cmds[cd.editCmd].x = cd.editCmdX
		ma.cmds[cd.editCmd].y = cd.editCmdY

		cdDrawCode("d", 0)

	elseif cd.editBut.active

		cdHideEditColor()

	elseif cd.submode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE

		cdHideEditResize()
				
	endif

	if not editState
		if cd.submode = CD_SUBMODE_EDIT_EDITOR_COL		
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_COLOR)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_LINE_SIZE
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_LINE_SIZE)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_POLY_SIZE
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_POLY_SIDES)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_TEXT_FONT
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_TEXT_FONT)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_TEXT_SIZE
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_TEXT_SIZE)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_TEXT_EDIT
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_TEXT_EDIT)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_GRID_COLS
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_GRID_COLS)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_GRID_ROWS
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_GRID_ROWS)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_GRID_WIDTH
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_GRID_WIDTH)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_GRID_HEIGHT
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_GRID_HEIGHT)
		elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_RESIZE
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_RESIZE)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_BG_COLOR
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_BG_COLOR)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_BOX_COL
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_BOX_COL)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_ALIGN
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TEXT_ALIGN)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_COL
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TEXT_COL)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_FONT
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TEXT_FONT)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_FONT_SIZE
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TEXT_FONT_SIZE)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_ALIGN
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TITLE_ALIGN)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_COL
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TITLE_COL)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_FONT
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TITLE_FONT)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_FONT_SIZE
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TITLE_FONT_SIZE)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_POS
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_TITLE_POS)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_VARBG_COL
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_VARBG_COL)
		elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_SCREEN
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_SCREEN)
		elseif cd.submode = CD_SUBMODE_EDIT_SETTINGS_GRID_WIDTH
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_GRID_WIDTH)
		elseif cd.submode = CD_SUBMODE_EDIT_SETTINGS_GRID_HEIGHT
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_GRID_HEIGHT)
		elseif cd.submode = CD_SUBMODE_EDIT_SETTINGS_GRID_COLS
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_GRID_COLS)
		elseif cd.submode = CD_SUBMODE_EDIT_SETTINGS_GRID_ROWS
			OnButtonAction(BUT_DESIGN_CANCEL_EDIT, BUT_DESIGN_GRID_ROWS)
		endif
	endif
		
	cd.submode = CD_SUBMODE_NONE

endfunction

//-----------------------------------------------------
// Load library of things into cd.libThings
//
function cdLoadAppLibraryItems(items ref as LibItem[])

	local idx as integer
	local i as integer
	
	cdClearLibItems(items)

	// If libsOn is turned off, but we are in the libraries folder, go up.
	if not ld.set.libsOn

		if findstring(cd.appFolder, "/" + CD_FOLDER_LIBRARIES, true, 1) = 1
			cd.appFolder = ""
		endif
	endif
	
	// Add the parent folder.
	if cd.appFolder = ""
		
		idx = ldCreateLibItem(items, LD_ITEM_APP_LIB || LD_ITEM_SUB_FOLDER, CD_FOLDER_MY_PROJECTS, -2)
		items[idx].status = items[idx].status || LD_STATUS_LOCKED
		idx = ldCreateLibItem(items, LD_ITEM_APP_LIB || LD_ITEM_SUB_FOLDER, CD_FOLDER_EXAMPLES, -2)
		items[idx].status = items[idx].status || LD_STATUS_LOCKED

		if ld.set.libsOn
			
			idx = ldCreateLibItem(items, LD_ITEM_APP_LIB || LD_ITEM_SUB_FOLDER, CD_FOLDER_LIBRARIES, -2)
			items[idx].status = items[idx].status || LD_STATUS_LOCKED

		endif

		//idx = ldCreateLibItem(items, LD_ITEM_APP_LIB || LD_ITEM_SUB_FOLDER, CD_FOLDER_SHARED_TO_YOU, -2)
		//items[idx].status = items[idx].status || LD_STATUS_LOCKED
		
	elseif findstring(cd.appFolder, "/" + CD_FOLDER_MY_PROJECTS, true, 1) = 1

		for i = 0 to ma.apps.length			
			if not (ma.apps[i].status && LD_STATUS_LIBRARY) and not (ma.apps[i].status && LD_STATUS_EXAMPLE)
				idx = ldCreateAppLibItem(items, i, -1)
			endif				
		next

	elseif findstring(cd.appFolder, "/" + CD_FOLDER_EXAMPLES, true, 1) = 1

		for i = 0 to ma.apps.length			
			if ma.apps[i].status && LD_STATUS_EXAMPLE
				idx = ldCreateAppLibItem(items, i, -1)
			endif				
		next

	elseif findstring(cd.appFolder, "/" + CD_FOLDER_LIBRARIES, true, 1) = 1

		for i = 0 to ma.apps.length			
			if ma.apps[i].status && LD_STATUS_LIBRARY
				idx = ldCreateAppLibItem(items, i, -1)
			endif				
		next
/*
	elseif findstring(cd.appFolder, "/" + CD_FOLDER_SHARED_TO_YOU, true, 1) = 1

		colog("Error: Shared to you projects not implemented yet")
*/		
	endif

	// Add a parent folder item for sub-folders.
	if cd.appFolder <> ""

		idx = ldCreateLibItem(items, LD_ITEM_APP_LIB || LD_ITEM_PARENT_FOLDER, cd.appFolder, 0)
		items[idx].status = items[idx].status || LD_STATUS_LOCKED

	endif
	
	idx = ldCreateLibItem(items, 0, LD_MEDIA_DIR + "/gfx/ProjectBlackIcon.png", 0)

	// Don't pass LD_ITEM_APP_LIB (where 0 is) above, as it activates logic.
	items[idx].typ = LD_ITEM_APP_LIB
	items[idx].name = chr(34) + "new" + chr(34)
	items[idx].status = items[idx].status || LD_STATUS_LOCKED
	items[idx].status = items[idx].status || LD_STATUS_BLANK

endfunction

//-----------------------------------------------------
// Load library of things into cd.libThings
//
function cdLoadThingLibraryItems(items ref as LibItem[], subFolder as string, thingTyp as integer)

	local idx as integer
	local i as integer
	local j as integer
	local appIdx as integer
	local pos as integer
	local itemIdx as integer
	local apps as integer[]
	local a as integer

	cdClearLibItems(items)

	// Add the parent folder.

	apps = maFindAppsByStatus(LD_STATUS_LIBRARY)

	for a = 0 to apps.length

		appIdx = apps[a]
		
		if thingTyp = LD_ITEM_SPRITE_LIB

			for i = 0 to ma.apps[appIdx].sprites.length

				idx = ma.apps[appIdx].sprites[i]
				itemIdx = ldCreateLibItem(items, LD_ITEM_SPRITE_LIB, ma.things[idx].name, -1)
				//items[itemIdx].img = ma.things[idx].imgs[ma.things[idx].imgIdx].img
				items[itemIdx].img = ma.things[idx].imgs[ma.things[idx].imgIdx].thumb
				items[itemIdx].sharedImg = true
				items[itemIdx].file = ma.apps[appIdx].folder + LD_SPRITE_DIR + "/" + ma.things[idx].imgs[ma.things[idx].imgIdx].id + LD_GFX_FILE_SUFFIX
				items[itemIdx].appIdx = appIdx
				items[itemIdx].idx = idx

			next
			
		elseif thingTyp = LD_ITEM_SOUND_LIB

			for i = 0 to ma.apps[appIdx].sounds.length

				idx = ma.apps[appIdx].sounds[i]
				itemIdx = ldCreateLibItem(items, LD_ITEM_SOUND_LIB, ma.sounds[idx].name, -1)
				items[itemIdx].file = ma.apps[appIdx].folder + LD_SOUND_DIR + "/" + ma.sounds[idx].id + LD_WAV_FILE_SUFFIX
				items[itemIdx].ext = ma.sounds[idx].ext
				items[itemIdx].appIdx = appIdx
				items[itemIdx].idx = idx
				
			next
			
		elseif thingTyp = LD_ITEM_VIDEO_LIB

			for i = 0 to ma.apps[appIdx].videos.length

				idx = ma.apps[appIdx].videos[i]
				itemIdx = ldCreateLibItem(items, LD_ITEM_VIDEO_LIB, ma.videos[idx].name, -1)
				items[itemIdx].file = ma.apps[appIdx].folder + LD_VIDEO_DIR + "/" + ma.videos[idx].id + LD_MP4_FILE_SUFFIX
				items[itemIdx].ext = ma.videos[idx].ext
				items[itemIdx].appIdx = appIdx
				items[itemIdx].idx = idx

			next
			
		endif

	next
						
	if thingTyp = LD_ITEM_SPRITE_LIB

		idx = ldCreateLibItem(items, thingTyp, LD_MEDIA_DIR + "/gfx/SpriteBlackIcon.png", 0)

		items[idx].name = chr(34) + "new" + chr(34)
		items[idx].status = items[idx].status || LD_STATUS_LOCKED
		items[idx].status = items[idx].status || LD_STATUS_BLANK

	endif
	
endfunction

//-----------------------------------------------------
// Load library of vars.
//
function cdLoadVarLibraryItems(items ref as LibItem[])

	local idx as integer
	
	cdClearLibItems(items)
	
	idx = ldCreateLibItem(items, LD_ITEM_VAR_APP, LD_MEDIA_DIR + "/gfx/ProjectBlackIcon.png", 0)
	items[idx].name = chr(34) + "new" + chr(34)
	items[idx].status = items[idx].status || LD_STATUS_LOCKED
	items[idx].status = items[idx].status || LD_STATUS_BLANK
	items[idx].help = "Add this variable to the project. Project variables are shared across all sprites in a project."

	if cd.thingIdx > -1
		
		idx = ldCreateLibItem(items, LD_ITEM_VAR_SPRITE, LD_MEDIA_DIR + "/gfx/SpriteBlackIcon.png", 1)
		items[idx].name = chr(34) + "new" + chr(34)
		items[idx].status = items[idx].status || LD_STATUS_LOCKED
		items[idx].status = items[idx].status || LD_STATUS_BLANK
		items[idx].help = "Add this variable to the current sprite. Sprite variables belong to a specific sprite, but can be later promoted to project variables."

	endif
	
	idx = ldCreateLibItem(items, LD_ITEM_LIST_APP, LD_MEDIA_DIR + "/gfx/ProjectBlackIcon.png", 2)
	items[idx].name = chr(34) + "new" + chr(34)
	items[idx].status = items[idx].status || LD_STATUS_LOCKED
	items[idx].status = items[idx].status || LD_STATUS_BLANK
	items[idx].help = "Add this list to the project. Project lists are shared across all sprites in a project."

	if cd.thingIdx > -1
		
		idx = ldCreateLibItem(items, LD_ITEM_LIST_SPRITE, LD_MEDIA_DIR + "/gfx/SpriteBlackIcon.png", 3)
		items[idx].name = chr(34) + "new" + chr(34)
		items[idx].status = items[idx].status || LD_STATUS_LOCKED
		items[idx].status = items[idx].status || LD_STATUS_BLANK
		items[idx].help = "Add this list to the current sprite. Sprite lists belong to a specific sprite, but can be later promoted to project variables."

	endif

	idx = ldCreateLibItem(items, LD_ITEM_VAR_VALUE, LD_MEDIA_DIR + "/gfx/ChildBlackIcon.png", 4)
	items[idx].name = chr(34) + "new" + chr(34)
	items[idx].status = items[idx].status || LD_STATUS_LOCKED
	items[idx].status = items[idx].status || LD_STATUS_BLANK
	items[idx].status = items[idx].status || LD_STATUS_NEED_PARENT
	items[idx].help = "Add an item to a list. Drag over a list to append to list, or over a list item to insert within the list."
	
endfunction

//-----------------------------------------------------
// Select the lib item.
//
function cdSetLibItemSelected(libItem ref as LibItem, selected as integer)

	libItem.selected = selected
	//cdSetLibItemVisible(libItem, libItem.visible)
	
endfunction

//-----------------------------------------------------
// Position a lib item.
//
function cdSetLibItemPos(libItem ref as LibItem, x as float, y as float)

	local th as float
	
	libItem.x = x
	libItem.y = y

	th = GetTextTotalHeight(libItem.text)
		
	SetSpritePositionByOffset(libItem.border, x + libItem.w / 2, y + libItem.h / 2)
	SetSpritePositionByOffset(libItem.bg, x + libItem.w / 2, y + libItem.h / 2)
	//SetSpritePositionByOffset(libItem.sel, x + libItem.w / 2, y + libItem.h / 2)
	SetSpritePositionByOffset(libItem.sel, x + libItem.w / 2 + CD_CMD_GAP, y + libItem.h / 2 + CD_CMD_GAP)
	SetSpritePositionByOffset(libItem.icon, x + libItem.w / 2, y + libItem.h / 2)
	SetTextPosition(libItem.text, x + libItem.w / 2, y + libItem.h - th)

	if libItem.text2
		SetTextPosition(libItem.text2, x + libItem.w / 2, y - co.bs / 32)
	endif
	
	if libItem.tag
		SetSpritePositionByOffset(libItem.tag, x + libItem.w - GetSpriteWidth(libItem.tag) / 2, y + GetSpriteHeight(libItem.tag) / 2)
	endif

	if libItem.tag2
		SetSpritePositionByOffset(libItem.tag2, x + GetSpriteWidth(libItem.tag2) / 2, y + GetSpriteHeight(libItem.tag2) / 2)
	endif

	if libItem.tag3
		SetSpritePositionByOffset(libItem.tag3, x + libItem.w - GetSpriteWidth(libItem.tag3) / 2, y + libItem.h - GetSpriteHeight(libItem.tag3) / 2)
	endif
	
endfunction

//-----------------------------------------------------
// Set the lib item depth.
//
function cdSetLibItemDepth(libItem ref as LibItem, depth as integer)

	SetSpriteDepth(libItem.sel, depth)

	depth = depth - 1
	SetSpriteDepth(libItem.border, depth)

	depth = depth - 1
	SetSpriteDepth(libItem.bg, depth)
	
	depth = depth - 1
	SetSpriteDepth(libItem.icon, depth)
	
	if libItem.text
		SetTextDepth(libItem.text, depth)
	endif
	
	if libItem.text2
		SetTextDepth(libItem.text2, depth)
	endif
	
	if libItem.tag
		SetSpriteDepth(libItem.tag, depth)		
	endif

	if libItem.tag2
		SetSpriteDepth(libItem.tag2, depth)		
	endif

	if libItem.tag3
		SetSpriteDepth(libItem.tag3, depth)		
	endif
	
endfunction

//-----------------------------------------------------
// Position a lib item.
//
function cdSetLibItemScissor(libItem ref as LibItem, on as integer, panel ref as Panel)

	if on
		
		SetSpriteScissor(libItem.border, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)
		SetSpriteScissor(libItem.bg, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)
		SetSpriteScissor(libItem.icon, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)
		SetSpriteScissor(libItem.sel, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)
		SetTextScissor(libItem.text, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)

		if libITem.text2
			SetTextScissor(libItem.text2, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)
		endif
		
		if libItem.tag
			SetSpriteScissor(libItem.tag, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)
		endif

		if libItem.tag2
			SetSpriteScissor(libItem.tag2, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)
		endif

		if libItem.tag3
			SetSpriteScissor(libItem.tag3, panel.vx, panel.vy, panel.vx + panel.vw - 1, panel.vy + panel.vh - 1)
		endif
		
	else

		SetSpriteScissor(libItem.border, 0, 0, 0, 0)
		SetSpriteScissor(libItem.bg, 0, 0, 0, 0)
		SetSpriteScissor(libItem.icon, 0, 0, 0, 0)
		SetSpriteScissor(libItem.sel, 0, 0, 0, 0)
		SetTextScissor(libItem.text, 0, 0, 0, 0)

		if libItem.text2
			SetTextScissor(libItem.text2, 0, 0, 0, 0)
		endif

		if libItem.tag
			SetSpriteScissor(libItem.tag, 0, 0, 0, 0)
		endif

		if libItem.tag2
			SetSpriteScissor(libItem.tag2, 0, 0, 0, 0)
		endif

		if libItem.tag3
			SetSpriteScissor(libItem.tag3, 0, 0, 0, 0)
		endif
		
	endif

endfunction

//-----------------------------------------------------
// Set the visibility of the libitem.
//
function cdSetLibItemVisible(libItem ref as LibItem, visible as integer)

	libItem.visible = visible
	
	SetSpriteVisible(libItem.border, libItem.visible)
	SetSpriteVisible(libItem.bg, libItem.visible)
	SetSpriteVisible(libItem.icon, libItem.visible)
	SetTextVisible(libItem.text, libItem.visible)
	SetSpriteVisible(libItem.sel, libItem.visible and libItem.selected)

	if libItem.text2
		SettextVisible(libItem.text2, libItem.visible)
	endif

	if libItem.tag
		SetSpriteVisible(libItem.tag, libItem.visible)
	endif

	if libItem.tag2
		SetSpriteVisible(libItem.tag2, libItem.visible)
	endif

	if libItem.tag3
		SetSpriteVisible(libItem.tag3, libItem.visible)
	endif
	
endfunction

//-----------------------------------------------------
// Set the visibility of the libitem.
//
function cdSetLibItemAlpha(libItem ref as LibItem, alpha as integer)

	SetSpriteColorAlpha(libItem.border, alpha)
	SetSpriteColorAlpha(libItem.bg, alpha)
	SetSpriteColorAlpha(libItem.icon, alpha)
	SetTextColorAlpha(libItem.text, alpha)
	SetSpriteColorAlpha(libItem.sel, alpha)

	if libItem.text2
		SetTextColorAlpha(libItem.text2,alpha)
	endif

	if libItem.tag
		SetSpriteColorAlpha(libItem.tag, alpha)
	endif

	if libItem.tag2
		SetSpriteColorAlpha(libItem.tag2, alpha)
	endif

	if libItem.tag3
		SetSpriteColorAlpha(libItem.tag3, alpha)
	endif
	
endfunction

//-----------------------------------------------------
// Load shared things into cd.libThings
//
function cdFileDialog()

	local file as string
	local libAppIdx as integer
	local libItem as LibItem
	
	if cd.mainTab = CD_TAB_THING

		if cd.thingTab = GRP_SPRITE
			
			cd.choosingImage = true
			ShowChooseImageScreen()

		elseif cd.thingTab = GRP_SOUND

			file = ChooseRawFile("*" + LD_WAV_FILE_SUFFIX)

			if file <> "" and right(file, len(LD_WAV_FILE_SUFFIX)) = LD_WAV_FILE_SUFFIX

				libItem.typ = LD_ITEM_SOUND_LIB
				libItem.file = file
				ldCreateImportLibItem(libItem)
				cdSetCurrLibItem(libItem)
				cd.currLibItem.status = cd.currLibItem.status || LD_STATUS_IMPORT
				cd.currLibItem.visible = true
				cd.fileIdx = -1
				cdNewThing(GRP_SOUND)

			endif
			
		elseif cd.thingTab = GRP_VIDEO

			file = ChooseRawFile("*" + LD_MP4_FILE_SUFFIX)

			if file <> "" and right(file, len(LD_MP4_FILE_SUFFIX)) = LD_MP4_FILE_SUFFIX

				libItem.typ = LD_ITEM_VIDEO_LIB
				libItem.file = file
				ldCreateImportLibItem(libItem)
				cdSetCurrLibItem(libItem)
				cd.currLibItem.status = cd.currLibItem.status || LD_STATUS_IMPORT
				cd.currLibItem.visible = true
				cd.fileIdx = -1
				cdNewThing(GRP_VIDEO)	

			endif

		endif

	endif

endfunction

//-----------------------------------------------------
// Set the press state.
//
function cdSetPressState(mode as integer, x as float, y as float)

	cd.waitStart = GetMilliseconds()
	cd.waitX = x
	cd.waitY = y
	cd.mode = mode

endfunction

//-----------------------------------------------------
// Move / touch down.
//
function cdWheel(x as float, y as float)
	
	local delta as float
	
	if cd.choosingImage or cd.delete.tab or cdIsEditActive() or ma.helpInter.howTo or cd.zoomActive
		exitfunction
	endif

	delta = in.mouseWheelDelta * 20
		
	if cd.mainTab = CD_TAB_APP

		guiPanelPressed(cd.appPanel, x, y, GUI_PANEL_PAN)			
		guiPanelMoved(cd.appPanel, x, y + delta)
		guiPanelPoll(cd.appPanel, x, y + delta)
		cdMoveApps()
		guiPanelReleased(cd.appPanel, x, y + delta)

	elseif cd.mainTab = CD_TAB_THING

		guiPanelPressed(cd.cmdPanels[cd.thingTab], x, y, GUI_PANEL_PAN)			
		guiPanelMoved(cd.cmdPanels[cd.thingTab], x, y + delta)
		guiPanelPoll(cd.cmdPanels[cd.thingTab], x, y + delta)
		cdMoveThings()
		guiPanelReleased(cd.cmdPanels[cd.thingTab], x, y + delta)

	elseif cd.mainTab = CD_TAB_CMD
	
		guiPanelPressed(cd.cmdPanels[cd.grpTab], x, y, GUI_PANEL_PAN)			
		guiPanelMoved(cd.cmdPanels[cd.grpTab], x, y + delta)
		guiPanelPoll(cd.cmdPanels[cd.grpTab], x, y + delta)
		cdMoveCmds()
		guiPanelReleased(cd.cmdPanels[cd.grpTab], x, y + delta)
		
	endif

	if cd.fileTab = CD_FILE_TAB_LIBRARY

		guiPanelPressed(cd.loadPanel, x, y, GUI_PANEL_PAN)			
		guiPanelMoved(cd.loadPanel, x, y + delta)
		guiPanelPoll(cd.loadPanel, x, y + delta)
		cdMoveLibItems()
		guiPanelReleased(cd.loadPanel, x, y + delta)
		
	elseif cd.fileTab = CD_FILE_TAB_CODE
		
		//if not cd.zoomActive
			
			guiPanelPressed(cd.codePanel, x, y, GUI_PANEL_PAN)			
			guiPanelMoved(cd.codePanel, x, y + delta)
			guiPanelPoll(cd.codePanel, x, y + delta)
			cdMoveCode()
			guiPanelReleased(cd.codePanel, x, y + delta)
			
		//endif
		
	elseif cd.fileTab = CD_FILE_TAB_HELP
		
		guiPanelPressed(cd.helpPanel, x, y, GUI_PANEL_PAN)			
		guiPanelMoved(cd.helpPanel, x, y + delta)
		guiPanelPoll(cd.helpPanel, x, y + delta)
		cdMoveHelp()
		guiPanelReleased(cd.helpPanel, x, y + delta)

	endif

endfunction

//-----------------------------------------------------
// Move / touch down.
//
function cdPressed(x as float, y as float)
	
	local editState as integer
	local keyState as integer
	local idx as integer
	local spr as integer
	local i as integer
	local j as integer
	local w as float
	local h as float
	local cmd as integer
	local press as CmdPress
	local thingIdx as integer
	local checked as integer
	local checkKeys as integer
	local colIdx as integer
	local col as integer
	local s as string
	local single as integer
	local keepIdx as integer
	local pageIdx as integer
	local appIdx as integer
	local butId as integer
	local colorEditBoxIdx as integer
	local resizeEditBoxIdx as integer
	local resizedArrowIdx as integer
	local img as integer
	local var as integer
	local trail as integer[]
	local trailIdx as integer
	local lt as integer
	local col2 as integer
	local sx as float
	local sy as float
	local sw as float
	local sh as float
	local sw3 as float
	local sh3 as float
	local acceptVis as integer
	local cmds as integer[]
	
	if cd.pressed
		exitfunction
	endif
	
	cd.pressed = true
	cd.pressInterHelp = false
	cd.mode = CD_MODE_NONE
	cd.waitIdx = -1
	cd.waitIdx2 = -1

	//coFindDbgSpr(x, y)
	
	if cd.choosingImage
		
		exitfunction

	elseif cd.delete.tab

		if guiGetButtonPressed(cd.delete.yesBut, x, y, 1)

			if cd.delete.tab = GRP_APP
				cdRemoveApp(cd.delete.appIdx, true)
			elseif cd.delete.tab = GRP_FRAME
				cdRemoveImage(cd.delete.idx, cd.delete.idx2)
			elseif cd.delete.item
				cdDeleteLibThing(cd.delete.idx)
			else		
				cdRemoveThing(cd.delete.tab, cd.delete.appIdx, cd.delete.idx, cd.delete.idx2)
			endif
			
			cdHideDelete()
			exitfunction
				
		elseif guiGetButtonPressed(cd.delete.noBut, x, y, 1)

			cdHideDelete()
			exitfunction
			
		endif
		
		exitfunction

	elseif ma.helpInter.howTo

		if coLeftPress()
			if maCheckHelpInterPress(cd.mode, x, y)
				exitfunction
			endif
		endif

	elseif not cdIsEditActive() and GetSpriteVisible(cd.helpPanel.panel)

		appIdx = -1
		
		for i = 0 to cd.helpDetails.buts.length

			if guiGetButtonPressed(cd.helpDetails.buts[i], x, y, 1)

				appIdx = cd.helpDetails.buts[i].id
				exit
				
			endif

		next

		if appIdx > -1

			//cdClearDetailedHelp(true)
			if coLeftPress()
	
				cdButtonAction(BUT_CODER_APP_OPEN_FROM_HELP, appIdx)
				exitfunction
				
			endif

		elseif appIdx < -1 // Copy code cmd.

			cd.tmpClip.cmds.length = -1
			
			cmds.length = -1
			idx = -appIdx - 10
			
			for i = idx to cd.helpDetails.cmds.length
				cmds.insert(cd.helpDetails.cmds[i])
			next 
			
			cdCloneCmds(cmds, cd.tmpClip.cmds)
			cd.tmpClip.attachCmd = 0
			cd.tmpClip.attachPartIdx = -1
			cd.tmpClip.attachDir = 0
			cd.tmpClip.isRoot = false
			cdSaveCmds(CD_CLIP_COPY)
//xx This is flipping to coding panel.

		else

			pageIdx = -999999
			
			for i = 0 to cd.helpDetails.texts.length

				if cd.helpDetails.texts[i].text and cd.helpDetails.texts[i].spr

					if coLeftPress()
						if coGetSpriteHitTest(cd.helpDetails.texts[i].spr, x, y, 0)
	
							pageIdx = cd.helpDetails.texts[i].idx
							trailIdx = cd.helpDetails.texts[i].trailIdx
							
							exit
	
						endif
					endif
					
				endif

			next

			if pageIdx >= 0

				for i = 0 to cd.helpDetails.trail.length
					trail.insert(cd.helpDetails.trail[i])
				next
				
				cdClearDetailedHelp(false)

				if trailIdx = 0 // Not a trail link, i.e. a link somewhere else on the page.
					trailIdx = trail.length
				else
					trailIdx = trailIdx - 2
				endif

				// Only put back what's before the one just pressed.
				for i = 0 to trailIdx
					cdAddHelpTrail(trail[i])
				next

				cdShowDetailedHelp(CD_HELP_MAIN, pageIdx)
				exitfunction
				
			elseif pageIdx > -999999 and pageIdx < 0 // Interactive help.
				
				cd.pressInterHelp = true
				maShowInterHelp(-pageIdx)
				exitfunction
				
			elseif guiPanelPressed(cd.helpPanel, x, y, GUI_PANEL_ALL)

				cd.mode = CD_MODE_HELP_PANEL
				exitfunction

			endif
			
		endif

	endif
	
	if cdIsEditActive()

		// accept or cancel pressed, or, enter or esc.
		if coLeftPress()
			editState = cdIsEditPressed(x, y)
		endif

		if editState > -1
			
			if editState = 1 // Accepted.
					
				cdEditAccept()
				
			else // Cancel.

				//elseif cd.kbdIdx = CD_KBD_COLOR
				if cd.editMode = CD_EDIT_COLOR

					if cd.submode = CD_SUBMODE_EDIT_IMAGE_COLOR or cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BOX_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_VARBG_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BG_COLOR  

						coSetSpriteColor(cd.editBut.icon2, col)

					elseif cd.submode = CD_SUBMODE_EDIT_PART
						
						// Reset the color back to the original.
						coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].spr, cd.editOrigCol)
						coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].lt, cd.editOrigCol)
						coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].rt, cd.editOrigCol)

					endif
					
				elseif cd.editMode = CD_EDIT_TAGS

					// Reset tags.
					
				endif
				
			endif

			cdEditEnd(editState)

		elseif cd.editMode = CD_EDIT_TEXT

			if not ld.set.trueEdit

				if coPointWithinRect(x, y, getspritex(cd.editBox), getspritey(cd.editBox), getspritewidth(cd.editBox), getspriteheight(cd.editBox))

					if coLeftPress()
						cd.editClickPos1 = cdSetEditClick(x)	
					endif
					
					if cd.editClickCount = 0
									
						cd.editClickTime = GetMilliseconds()
						cd.editClickTimePos = cd.editClickPos1
						
					endif

				elseif cd.submode = CD_SUBMODE_EDIT_RESIZE or cd.subMode = CD_SUBMODE_EDIT_EDITOR_RESIZE

					// Check if there is a press in another resize edit box.
					resizeEditBoxIdx = -1
					
					for i = 0 to cd.resizeEditBox.length

						if cd.editBox <> cd.resizeEditBox[i].box

							if coPointWithinRect(x, y, getspritex(cd.resizeEditBox[i].box), getspritey(cd.resizeEditBox[i].box), getspritewidth(cd.resizeEditBox[i].box), getspriteheight(cd.resizeEditBox[i].box))

								if coLeftPress()

									resizeEditBoxIdx = i
									exit
									
								endif
																
							endif

						endif
						
					next

					if resizeEditBoxIdx > -1

						cd.editBox = cd.resizeEditBox[resizeEditBoxIdx].box
						cd.editText = cd.resizeEditBox[resizeEditBoxIdx].text
						cdSetEditCursor(-1)
						cdSetEditVisible(true)
/*
					else // Check if a resize arrow is pressed.

						resizedArrowIdx = -1

						for i = 0 to cd.edimg.resizedArrow.length
							
							if guiGetButtonPressed(cd.edimg.resizedArrow[i], x, y)
															
								resizedArrowIdx = i
								exit
								
							endif
							
						next

						if resizedArrowIdx = -1 // Arrow not pressed, check image.
							
							if coGetSpriteHitTest(cd.edimg.resizedSpr2, x, y, 0)
								
								sx = getspritex(cd.edimg.resizedSpr2)
								sy = getspritey(cd.edimg.resizedSpr2)
								sw = GetSpriteWidth(cd.edimg.resizedSpr2)
								sh = GetSpriteHeight(cd.edimg.resizedSpr2)
								sw3 = sw / 3
								sh3 = sh / 3
								
								if y >= sy and y < sy + sh3
									if x >= sx and x < sx + sw3
										resizedArrowIdx = 0
									elseif x >= sx + sw3 and x < sx + sw3 + sw3
										resizedArrowIdx = 1																
									elseif x >= sx + sw - sw3 and x < sx + sw
										resizedArrowIdx = 2
									endif
								elseif y >= sy + sh3 and y < sy + sh3 + sh3																
									if x >= sx and x < sx + sw3
										resizedArrowIdx = 7
									elseif x >= sx + sw3 and x < sx + sw3 + sw3
										resizedArrowIdx = -1																
									elseif x >= sx + sw - sw3 and x < sx + sw
										resizedArrowIdx = 3
									endif
								elseif y >= sy + sh - sh3 and y < sy + sh
									if x >= sx and x < sx + sw3
										resizedArrowIdx = 6
									elseif x >= sx + sw3 and x < sx + sw3 + sw3
										resizedArrowIdx = 5												
									elseif x >= sx + sw - sw3 and x < sx + sw
										resizedArrowIdx = 4
									endif
								endif

								for i = 0 to cd.edimg.resizedArrow.length
									guiSetButtonSelected(cd.edimg.resizedArrow[i], false)
								next
								
								cd.edimg.resizedArrowIdx = resizedArrowIdx

								if cd.edimg.resizedArrowIdx > -1
									guiSetButtonSelected(cd.edimg.resizedArrow[cd.edimg.resizedArrowIdx], true)
								endif

								cdShowEditResizeSpr()
								
								resizedArrowIdx = -1 // Don't drop through.
								
							endif

						endif
						
						if resizedArrowIdx > -1

							for i = 0 to cd.edimg.resizedArrow.length
								guiSetButtonSelected(cd.edimg.resizedArrow[i], false)
							next

							if cd.edimg.resizedArrowIdx > -1								
								if resizedArrowIdx = cd.edimg.resizedArrowIdx
									resizedArrowIdx = -1
								endif
							endif

							cd.edimg.resizedArrowIdx = resizedArrowIdx

							if cd.edimg.resizedArrowIdx > -1
								guiSetButtonSelected(cd.edimg.resizedArrow[cd.edimg.resizedArrowIdx], true)
							endif

							cdShowEditResizeSpr()
													
						else 
							
							cdHandleKeyboard(x, y)
							
						endif
*/
					endif

				elseif guiGetButtonPressed(cd.autoAcceptBut, x, y, 1)
					
					cdToggleAutoAccept()
					cdSetSettingsAutoAcceptButton()
					
				else
					
					if coLeftPress()
						idx = cdCheckPrevValuePressed(x, y)
					endif
					
					if idx > -1

						// Apply value to edit field.	
						cdSetEditPrevValue(idx)

						if ld.set.autoAccept
							
							cdEditAccept()
							cdEditEnd(0)
							
						endif
										
					else 
						
						cdHandleKeyboard(x, y)
	
					endif
					
				endif

			endif
			
		elseif cd.editMode = CD_EDIT_COLOR

			if not ld.set.trueEdit

				if coPointWithinRect(x, y, getspritex(cd.editBox), getspritey(cd.editBox), getspritewidth(cd.editBox), getspriteheight(cd.editBox))

					if coLeftPress()
						cd.editClickPos1 = cdSetEditClick(x)
					endif

					if cd.editClickCount = 0
						
						cd.editClickTime = GetMilliseconds()
						cd.editClickTimePos = cd.editClickPos1
						
					endif
					
				else

					// Check if there is a press in another color edit box.
					colorEditBoxIdx = -1
					
					for i = 0 to cd.colorEditBox.length

						if cd.editBox <> cd.colorEditBox[i].box

							if coPointWithinRect(x, y, getspritex(cd.colorEditBox[i].box), getspritey(cd.colorEditBox[i].box), getspritewidth(cd.colorEditBox[i].box), getspriteheight(cd.colorEditBox[i].box))

								if coLeftPress()
									 
									colorEditBoxIdx = i
									exit
									
								endif
															
							endif

						endif
						
					next

					if colorEditBoxIdx > -1

						cd.editBox = cd.colorEditBox[colorEditBoxIdx].box
						cd.editText = cd.colorEditBox[colorEditBoxIdx].text
						cdSetEditCursor(-1)
						cdSetEditVisible(true)

					else // Check arrows, keyboard and color boxes.
						
						colorEditBoxIdx = cdIncColorEditBox(x, y)
						
						if colorEditBoxIdx > -1
							
							cd.waitStart = GetMilliseconds()
							cd.colInc = true
							
						endif
						
						if colorEditBoxIdx = -1 // Pressed color arrow.
								
							checkKeys = true
							
							if cd.kbdIdx = CD_KBD_COLOR
							
								if coLeftPress()
									colIdx = cdCheckColorPressed(x, y)
								endif
								
								if colIdx > -1
	
									img = getspriteimageid(cd.colorBoxes[colIdx])
									
									//if img = cd.coltransImg
									//	col = 0
									//else
										col = coGetSpriteColor(cd.colorBoxes[colIdx])
									//endif
	
									s = coColorToDec(col)
									cdSetColorEditText(s)
									cdSetEditCursor(-1)	
	
									if cdCheckEditText()
	
										if cd.editMode = CD_EDIT_COLOR
	
											if cd.submode = CD_SUBMODE_EDIT_IMAGE_COLOR or cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BOX_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_VARBG_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BG_COLOR
												
												coSetSpriteColor(cd.editBut.icon2, col)
	
											elseif cd.submode = CD_SUBMODE_EDIT_PART 
	
												coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].spr, col)
												coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].lt, col)
												coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].rt, col)
	
											endif
											
										endif
										
									endif
									
									checkKeys = false
									
								endif
							
							endif
							
							if checkKeys 
	
								cdHandleKeyboard(x, y)
	
							endif
							
						endif

					endif
					
				endif

			else 

				cdTrueEditColor(x, y)
				
			endif
			
		elseif cd.editMode = CD_EDIT_TAGS

			var = cd.objVars[cd.editObjIdx]
			single = val(ma.vars[var].value)
			keepIdx = -1
			
			for i = 0 to ma.vars[var].list.length

				cmd = ma.vars[var].list[i].cmd
					
				if cdPointWithinCmd(ma.cmds[cmd], x, y)

					if coLeftPress()
						
						if cdGetCmdSelected(cmd)
							
							//if not single // Deselect for multi-select.
								cdSetCmdSelected(cmd, false)
							//endif
							
						else
							
							cdSetCmdSelected(cmd, true)
							keepIdx = i
							
						endif
	
						exit
						
					endif
						
				endif
				
			next

			// Clear other selections if we have changed to a new item.
			if single and keepIdx > -1

				for i = 0 to ma.vars[var].list.length

					cmd = ma.vars[var].list[i].cmd
					
					if i <> keepIdx
						cdSetCmdSelected(cmd, false)
					endif

				next

			endif
			
			if not single
				
				if guiGetButtonPressed(cd.allBut, x, y, 1)

					for i = 0 to ma.vars[var].list.length

						cmd = ma.vars[var].list[i].cmd
						cdSetCmdSelected(cmd, true)
						
					next
					
				elseif guiGetButtonPressed(cd.noneBut, x, y, 1)

					for i = 0 to ma.vars[var].list.length

						cmd = ma.vars[var].list[i].cmd
						cdSetCmdSelected(cmd, false)
						
					next
										
				endif

			endif
			
			if single

				if guiGetButtonPressed(cd.autoAcceptBut, x, y, 1)

					cdToggleAutoAccept()
					cdSetSettingsAutoAcceptButton()
					
				else
				
					acceptVis = false
					
					for i = 0 to ma.vars[var].list.length
		
						cmd = ma.vars[var].list[i].cmd
							
						if cdGetCmdSelected(cmd)
							
							acceptVis = true 
							exit
							
						endif
						
					next
					
					guiSetButtonActive(cd.acceptBut, acceptVis)
					
				endif
				
			endif
			
			if ld.set.autoAccept and single and keepIdx > -1
					
				cdEditAccept()
				cdEditEnd(0)

			endif
			
		endif

		exitfunction

	elseif cd.subMode = CD_SUBMODE_EDIT_EDITOR_IMAGE
		
		if GetSpriteVisible(cd.loadPanel.panel)

			for i = 0 to ld.libItems.length
				
				if GetSpriteHitTest(ld.libItems[i].border, x, y)

					cd.fileItemIdx = i
					cdSetPressState(CD_MODE_WAIT_ITEM, x, y)
					exit
					
				endif

			next

			if cd.mode = CD_MODE_NONE

				idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)

				if idx > -1
						
					if guiGetButtonPressed(cd.toolBar.buts[idx], x, y, 1)
						
						cd.waitIdx = idx
						cdSetPressState(CD_MODE_TOOL_BAR, x, y)
						
					endif
					
				endif
				
			endif

//xxx	
			if cd.mode = CD_MODE_NONE					
				if guiPanelPressed(cd.loadPanel, x, y, GUI_PANEL_ALL)
					cd.mode = CD_MODE_LOAD_PANEL
				endif
			endif

			exitfunction
			
		endif
		
	elseif cd.zoomActive // cd.zoomScale < 1.0

		//if coPointWithinRect(x, y, getspritex(cd.codePanel.panel), getspritey(cd.codePanel.panel), GetSpriteWidth(cd.codePanel.panel), GetSpriteHeight(cd.codePanel.panel))
		if coPointWithinRect(x, y, getspritex(cd.codeScroll), getspritey(cd.codeScroll), GetSpriteWidth(cd.codeScroll), GetSpriteHeight(cd.codeScroll))
			cdZoomIn(x, y)		
		endif
		
		exitfunction

	endif
	
	//
	// Reduce the check zone.
	//
	
	if x < getspritex(cd.codePanel.panel) // app/thing/cmd panels.

		if cd.mode = CD_MODE_NONE

			if guiGetButtonPressed(cd.appBut, x, y, 1)

				cdSetPressState(CD_MODE_APP_BUT, x, y)
				
			elseif guiGetButtonPressed(cd.thingBut, x, y, 1)

				cdSetPressState(CD_MODE_THING_BUT, x, y)
				
			elseif guiGetButtonPressed(cd.cmdBut, x, y, 1)

				cdSetPressState(CD_MODE_CMD_BUT, x, y)
				
			//elseif guiGetButtonPressed(cd.settingsBut, x, y)

			//	cdSetPressState(CD_MODE_SETTING_BUT, x, y)

			endif

		endif

		if cd.mode = CD_MODE_NONE

			guiHideTip(gui.tip)

			if cd.mainTab = CD_TAB_APP

				if cd.mode = CD_MODE_NONE					
					if guiPanelPressed(cd.appPanel, x, y, GUI_PANEL_BARS)
						cd.mode = CD_MODE_APP_PANEL
					endif
				endif

				// App selection.
				if cd.mode = CD_MODE_NONE					
					
					guiHideBar(cd.appBar)

					for i = 0 to ma.apps.length

						if cdGetCmdGfxPressed(ma.cmds[ma.apps[i].cmd], x, y)

							cd.waitIdx = i
							cd.waitIdx2 = -1
							cdSetPressState(CD_MODE_WAIT_APP, x, y)
							exit
							
						endif

					next

				endif

				if not WIN_MODE
					if cd.mode = CD_MODE_NONE					
						if guiPanelPressed(cd.appPanel, x, y, GUI_PANEL_PAN)
							cd.mode = CD_MODE_APP_PANEL
						endif
					endif
				endif
				
			elseif cd.mainTab = CD_TAB_THING

				// Thing tabs.
				if cd.mode = CD_MODE_NONE

					for i = 0 to cd.thingBar.buts.length

						if guiGetButtonPressed(cd.thingBar.buts[i], x, y, 1)

							cd.waitIdx = i + GRP_SPRITE
							cdSetPressState(CD_MODE_THING, x, y)
							exit
							
						endif

					next

				endif

				if cd.mode = CD_MODE_NONE					
					if guiPanelPressed(cd.cmdPanels[cd.thingTab], x, y, GUI_PANEL_BARS)
						cd.mode = CD_MODE_THING_PANEL
					endif
				endif

				// Thing selection.
				if cd.mode = CD_MODE_NONE					
				
					guiHideBar(cd.spriteBar)
					guiHideBar(cd.soundBar)
					guiHideBar(cd.videoBar)
					guiHideBar(cd.varBar)

					if cd.thingTab = GRP_SPRITE
						
						for i = 0 to ma.apps[cd.appIdx].sprites.length

							thingIdx = ma.apps[cd.appIdx].sprites[i]
							cmd = ma.things[thingIdx].cmd
							
							spr = cdGetCmdGfxPressed(ma.cmds[cmd], x, y)

							if spr
								
								if spr = ma.cmds[cmd].fold

									if coLeftPress()
										
										cdSetCmdFolded(cmd, not cdGetCmdFolded(cmd))
										cdSetSpritesVisible(true, cmd)
										
									endif
										
								else
									
									cd.waitIdx = thingIdx
									cd.waitIdx2 = -1
									cdSetPressState(CD_MODE_WAIT_SPRITE, x, y)
									
								endif

								exit

							else // Check frames.

								for j = 0 to ma.things[thingIdx].imgs.length

									cmd = ma.things[thingIdx].imgs[j].cmd
									
									spr = cdGetCmdGfxPressed(ma.cmds[cmd], x, y)

									if spr
																				
										cd.waitIdx = thingIdx
										cd.waitIdx2 = j
										cdSetPressState(CD_MODE_WAIT_FRAME, x, y)
										exit

									endif

								next
								
							endif
							
						next

					elseif cd.thingTab = GRP_SOUND
						
						for i = 0 to ma.apps[cd.appIdx].sounds.length

							idx = ma.apps[cd.appIdx].sounds[i]
							cmd = ma.sounds[idx].cmd
							
							spr = cdGetCmdGfxPressed(ma.cmds[cmd], x, y)

							if spr
																	
								cd.waitIdx = idx
								cd.waitIdx2 = -1
								cdSetPressState(CD_MODE_WAIT_SOUND, x, y)
								exit

							endif
							
						next

					elseif cd.thingTab = GRP_VIDEO
						
						for i = 0 to ma.apps[cd.appIdx].videos.length

							idx = ma.apps[cd.appIdx].videos[i]
							cmd = ma.videos[idx].cmd
							
							spr = cdGetCmdGfxPressed(ma.cmds[cmd], x, y)

							if spr
																	
								cd.waitIdx = idx
								cd.waitIdx2 = -1
								cdSetPressState(CD_MODE_WAIT_VIDEO, x, y)
								exit

							endif
							
						next

					elseif cd.thingTab = GRP_VAR

						//if coLeftPress()
							
							cdCheckVarCmdsPressed(ma.apps[cd.appIdx].vars, x, y)
	
							// Not an app var, check thing.
							if cd.waitIdx = -1
								if cd.thingIdx > -1
									cdCheckVarCmdsPressed(ma.things[cd.thingIdx].vars, x, y)								
								endif							
							endif
							
						//endif
						
					endif
					
				endif

				if not WIN_MODE
					if cd.mode = CD_MODE_NONE					
						if guiPanelPressed(cd.cmdPanels[cd.thingTab], x, y, GUI_PANEL_PAN)
							cd.mode = CD_MODE_THING_PANEL
						endif
					endif
				endif
				
			elseif cd.mainTab = CD_TAB_CMD

				if cd.mode = CD_MODE_NONE					
					if guiPanelPressed(cd.cmdPanels[cd.grpTab], x, y, GUI_PANEL_BARS)
						cd.mode = CD_MODE_CMD_PANEL
					endif
				endif
// yyy
				// Command group tabs.
				if cd.mode = CD_MODE_NONE

					for i = 0 to cd.grpBar.buts.length

						if guiGetButtonPressed(cd.grpBar.buts[i], x, y, 1)

							cd.waitIdx = i
							cdSetPressState(CD_MODE_GRP, x, y)
							exit
							
						endif

					next

				endif

				// Command selection or folding.
				if cd.mode = CD_MODE_NONE
					
					for i = 0 to cd.selCmds.length
						
						spr = cdGetCmdGfxPressed(ma.cmds[cd.selCmds[i]], x, y)

						if spr

							if spr = ma.cmds[cd.selCmds[i]].fold

								if coLeftPress()
									cdSetCmdFolded(cd.selCmds[i], not cdGetCmdFolded(cd.selCmds[i]))
								endif
								
							else
								
								cd.waitIdx = i
								cdSetPressState(CD_MODE_WAIT_CMD, x, y)

							endif

							exit
							
						endif

					next

				endif
//xxx
				if not WIN_MODE
					if cd.mode = CD_MODE_NONE					
						if guiPanelPressed(cd.cmdPanels[cd.grpTab], x, y, GUI_PANEL_PAN)
							cd.mode = CD_MODE_CMD_PANEL
						endif
					endif
				endif

			elseif cd.mainTab = CD_TAB_SETTINGS

				if cd.mode = CD_MODE_NONE					

					/*
					for i = 0 to cd.settingsBar.buts.length

						if guiGetButtonPressed(cd.settingsBar.buts[i], x, y)

							cd.waitIdx = i
							cdSetPressState(CD_MODE_SETTINGS_BAR, x, y)
							exit
							
						endif

					next
					*/
				
				endif

				//if cd.mode = CD_MODE_NONE					
				//	if guiPanelPressed(cd.settingsPanel, x, y)
				//		cd.mode = CD_MODE_SETTINGS_PANEL
				//	endif
				//endif
				
			endif

		endif
				
	else // Code panel side.

		if guiGetButtonPressed(cd.codeBut, x, y, 1)

			cdSetPressState(CD_MODE_CODE_BUT, x, y)

		elseif guiGetButtonPressed(cd.libraryBut, x, y, 1)

			cdSetPressState(CD_MODE_LIB_BUT, x, y)
											
		elseif guiGetButtonPressed(cd.helpBut, x, y, 1)

			cdSetPressState(CD_MODE_HELP_BUT, x, y)

		endif

		// Tool activation, e.g. Run, Undo, Redo, etc.
		if cd.mode = CD_MODE_NONE

			for i = 0 to cd.toolBar.buts.length

				if guiGetButtonPressed(cd.toolBar.buts[i], x, y, 1)

					if cd.toolBar.buts[i].id = BUT_CODER_MORE
						
						cd.waitIdx = i
						cdSetPressState(CD_MODE_MORE_BAR, x, y)
						guiPopupBar(cd.moreBar, getspritex(cd.toolBar.buts[i].bg), getspritey(cd.toolBar.buts[i].bg), getspritewidth(cd.toolBar.buts[i].bg), getspriteheight(cd.toolBar.buts[i].bg))

					else
						
						cd.waitIdx = i
						cdSetPressState(CD_MODE_TOOL_BAR, x, y)

					endif
					
					exit
					
				elseif guiGetButtonPressed(cd.toolBar.buts[i], x, y, 2)

					if cd.toolBar.buts[i].id = BUT_CODER_RUN
						
						cd.waitIdx = i
						cdSetPressState(CD_MODE_TOOL_BAR, x, y)
						
					endif
					
					exit
					
				endif

			next

		endif

		// Code selection, i.e. dragging, popup, parts, etc.
		if cd.mode = CD_MODE_NONE

			if cd.fileTab = CD_FILE_TAB_CODE // Code

				if cd.thingIdx > -1
					
					for i = 0 to ma.things[cd.thingIdx].cmds.length

						cmd = ma.things[cd.thingIdx].cmds[i]
						press.cmd = cmd
						press.partIdx = -1
						press.parentCmd = 0

						cdGetCmdPressed(false, press, x, y, co.bs / 16)

						if press.cmd > -1 // Cmd pressed.
							
							/*
							if ma.cmds[press.cmd].code = CODE_SPRITE_PART
								
								cdFindThingRootCmd(cd.thingIdx, press)
								
								if press.partIdx > -1
									press.cmd = press.parentCmd
								endif
								
							endif
							*/
							
							if press.partIdx > -1 // But is a part pressed?

								cd.editPress = press
								cdSetPressState(CD_MODE_WAIT_PART, x, y)
									
							else

								cdSetPressState(CD_MODE_WAIT_CODE, x, y)

								if maIsCloseCode(ma.cmds[press.cmd].code)
									cd.waitIdx = ma.cmds[press.cmd].openCmd						
								else
									cd.waitIdx = press.cmd
								endif

							endif
							
						endif

					next

				endif

			elseif cd.fileTab = CD_FILE_TAB_LIBRARY
	
				if cd.mode = CD_MODE_NONE					
					if guiPanelPressed(cd.loadPanel, x, y, GUI_PANEL_BARS)
						cd.mode = CD_MODE_LOAD_PANEL
					endif
				endif
				
				for i = 0 to ld.libItems.length
					
					if GetSpriteHitTest(ld.libItems[i].border, x, y)

						cd.fileItemIdx = i
						cdSetPressState(CD_MODE_WAIT_ITEM, x, y)
						exit
						
					endif

				next
//xxx
				if not WIN_MODE
					if cd.mode = CD_MODE_NONE					
						if guiPanelPressed(cd.loadPanel, x, y, GUI_PANEL_PAN)
							cd.mode = CD_MODE_LOAD_PANEL
						endif
					endif
				endif

			endif

		endif

		if cd.mode = CD_MODE_NONE					
			if guiPanelPressed(cd.codePanel, x, y, GUI_PANEL_BARS)
				cd.mode = CD_MODE_CODE_PANEL
			endif
		endif

		//if not WIN_MODE
			if cd.mode = CD_MODE_NONE
	
				if coPointWithinRect(x, y, cd.codePanel.vx, cd.codePanel.vy, cd.codePanel.vw, cd.codePanel.vh)
					cdSetPressState(CD_MODE_WAIT_CODE_PANEL, x, y)
				//elseif guiPanelPressed(cd.codePanel, x, y)
				//	cd.mode = CD_MODE_CODE_PANEL
				endif
			endif
		//endif

	endif

	//cdProcessInterHelpPressed(cd.mode, x, y)
		
endfunction

//-----------------------------------------------------
// Handled true edit of color.
//
function cdTrueEditColor(x as float, y as float)

	local i as integer
	local colorEditBoxIdx as integer
	local col as integer
	local s as string
	local colIdx as integer
	local img as integer
	
	//if not GetEditBoxHasFocus(cd.editBox)				

	// Check if there is a press in another color edit box.
	colorEditBoxIdx = -1
	
	for i = 0 to cd.colorEditBox.length

		if cd.editBox <> cd.colorEditBox[i].box

			if GetEditBoxHasFocus(cd.colorEditBox[i].box)

				colorEditBoxIdx = i
				exit
											
			endif

		endif
		
	next

	if colorEditBoxIdx > -1

		cd.editBox = cd.colorEditBox[colorEditBoxIdx].box
		cd.editText = cd.colorEditBox[colorEditBoxIdx].text
		cdSetEditVisible(true)

	else // Check arrows, keyboard and color boxes.
		
		colorEditBoxIdx = cdIncColorEditBox(x, y)
		
		if colorEditBoxIdx > -1
			
			cd.waitStart = GetMilliseconds()
			cd.colInc = true
			
		endif
		
		if colorEditBoxIdx = -1 // Pressed color arrow.
							
			if cd.kbdIdx = CD_KBD_COLOR
			
				colIdx = cdCheckColorPressed(x, y)
				
				if colIdx > -1

					img = getspriteimageid(cd.colorBoxes[colIdx])
					
					//if img = cd.coltransImg
					//	col = 0
					//else
						col = coGetSpriteColor(cd.colorBoxes[colIdx])
					//endif

					s = coColorToDec(col)
					cdSetColorEditText(s)
					cdSetEditCursor(-1)	

					if cdCheckEditText()

						if cd.editMode = CD_EDIT_COLOR

							if cd.submode = CD_SUBMODE_EDIT_IMAGE_COLOR or cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BOX_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_VARBG_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BG_COLOR
								
								coSetSpriteColor(cd.editBut.icon2, col)

							elseif cd.submode = CD_SUBMODE_EDIT_PART 

								coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].spr, col)
								coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].lt, col)
								coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].rt, col)

							endif
							
						endif
						
					endif
					
				endif
			
			endif
						
		endif

	endif
	
//endif
				
endfunction
	
//-----------------------------------------------------
// Toggle the auto accept feature.
//
function cdToggleAutoAccept()
	
	if ld.set.autoAccept 
		ld.set.autoAccept = false
	else 
		ld.set.autoAccept = true 
	endif
	
	ldSaveSettings()
	
endfunction

//-----------------------------------------------------
// Set the auto accept button state.
//
function cdSetSettingsAutoAcceptButton()
	
	if ld.set.autoAccept
		guiSetButtonIcon2(cd.autoAcceptBut, gui.onImg)		
	else
		guiSetButtonIcon2(cd.autoAcceptBut, gui.offImg)
	endif
	
endfunction

//-----------------------------------------------------
// Check if a prev value was pressed, return the idx.
//
function cdCheckPrevValuePressed(x as float, y as float)
	
	local i as integer
	local idx as integer
	
	idx = -1
	
	for i = 0 to cd.prevValues.length

		if cdGetCmdGfxPressed(ma.cmds[cd.prevValues[i].cmd], x, y)
			
			idx = i
			exit
			
		endif 
		
	next

endfunction idx

//-----------------------------------------------------
// Set the prev value.
//
function cdSetEditPrevValue(idx as integer)

	local s as string 
	
	if idx > -1
		
		s = cdGetEditText()
		cd.editClickPos1 = 0
		cd.editClickPos2 = len(s) + 1
		OnKeyAction(0, cd.prevValues[idx].info)
		
	endif

endfunction

//-----------------------------------------------------
// Get the offset of the press location 'pos' vs. the corner of the box.
//
function cdIncColorEditBox(x as float, y as float)

	local lt as integer
	local colorEditBoxIdx as integer
	local i as integer
	local s as string
	local col as integer
	local col2 as integer
	
	lt = true
	colorEditBoxIdx = -1
	
	for i = 0 to cd.colorEditBox.length

		if coGetSpriteHitTest2(cd.colorEditBox[i].lt, x, y, 0, 0)
				
			colorEditBoxIdx = i
			exit
												
		elseif coGetSpriteHitTest2(cd.colorEditBox[i].rt, x, y, 0, 0)
					
			lt = false
			colorEditBoxIdx = i
			exit
												
		endif
			
	next

	if colorEditBoxIdx > -1 // Pressed color arrow.
		
		s = cdGetColorEditText()
		col = coMakeColor(s)

		if colorEditBoxIdx = 0 // Red.
			
			col2 = getcolorred(col)

			if lt
				
				dec col2
				if col2 < 0 then col2 = 0
				
			else
				
				inc col2
				if col2 > 255 then col2 = 255
				
			endif
			
			col = makecolor(col2, getcolorgreen(col), getcolorblue(col))
			col = coSetColorAlpha(col, coGetColorAlpha(col))
			s = coColorToDec(col)

		elseif colorEditBoxIdx = 1 // Green.
			
			col2 = GetColorGreen(col)

			if lt
				
				dec col2
				if col2 < 0 then col2 = 0
				
			else
				
				inc col2
				if col2 > 255 then col2 = 255
				
			endif
			
			col = makecolor(getcolorred(col), col2, getcolorblue(col))
			col = coSetColorAlpha(col, coGetColorAlpha(col))
			s = coColorToDec(col)
		
		elseif colorEditBoxIdx = 2 // Blue.
			
			col2 = GetColorBlue(col)

			if lt
				
				dec col2
				if col2 < 0 then col2 = 0
				
			else
				
				inc col2
				if col2 > 255 then col2 = 255
				
			endif
			
			col = makecolor(getcolorred(col), getcolorgreen(col), col2)
			col = coSetColorAlpha(col, coGetColorAlpha(col))
			s = coColorToDec(col)

		elseif colorEditBoxIdx = 3 // Alpha.
			
			col2 = coGetColorAlpha(col)

			if lt
				
				dec col2
				if col2 < 0 then col2 = 0
				
			else
				
				inc col2
				if col2 > 255 then col2 = 255
				
			endif
			
			col = makecolor(getcolorred(col), getcolorgreen(col), getcolorblue(col))
			col = coSetColorAlpha(col, col2)
			s = coColorToDec(col)

		endif

		if cd.submode = CD_SUBMODE_EDIT_IMAGE_COLOR or cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BOX_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_VARBG_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL												
		
			coSetSpriteColor(cd.editBut.icon2, col)	
		
		elseif cd.submode = CD_SUBMODE_EDIT_PART 
				
			coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].spr, col)
			coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].lt, col)
			coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].rt, col)
			
		endif								
										
		//coSetSpriteColor(cd.editBut.icon2, col)
		cdSetColorEditText(s)
		cdSetEditCursor(-1)
		
	endif

endfunction colorEditBoxIdx

//-----------------------------------------------------
// Check the list of vars for a press.
//
function cdCheckVarCmdsPressed(vars ref as integer[], x as float, y as float)

	local i as integer
	local j as integer
	local idx as integer
	local cmd as integer
	local spr as integer
	local checked as integer
	local folded as integer
	
	for i = 0 to vars.length

		idx = vars[i]
		cmd = ma.vars[idx].cmd
		
		spr = cdGetCmdGfxPressed(ma.cmds[cmd], x, y)

		if spr

			if spr = ma.cmds[cmd].check

				checked = not cdGetCmdChecked(cmd)
				cdSetCmdChecked(cmd, checked)

				if ma.cmds[cmd].var
					
					ma.vars[ma.cmds[cmd].var].vis = checked

					//if not checked
					//	maInitVarView(ma.vars[ma.cmds[cmd].var].v)
					//endif
					
					maSave()
					
				endif

			elseif spr = ma.cmds[cmd].fold

				folded = not cdGetCmdFolded(cmd)
				cdSetCmdFolded(cmd, folded)

				//if not folded
				//	cdHideFoldedVarHierarchy(idx)
				//endif

				cdSetVarsVisible(true)
				
			else
				
				cd.waitIdx = idx
				cd.waitIdx2 = -1
				cdSetPressState(CD_MODE_WAIT_VAR, x, y)

			endif

		elseif ma.vars[idx].typ = VAR_TYPE_LIST or ma.vars[idx].typ = VAR_TYPE_OBJECT

			for j = 0 to ma.vars[idx].list.length

				cmd = ma.vars[idx].list[j].cmd
				
				spr = cdGetCmdGfxPressed(ma.cmds[cmd], x, y)

				if spr
						
					cd.waitIdx = idx
					cd.waitIdx2 = j
					cdSetPressState(CD_MODE_WAIT_VAR_VALUE, x, y)

				endif

			next

		endif

		if cd.waitIdx > -1
			exit
		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Fold down all sub-folded vars.
//
function cdHideFoldedVarHierarchy(var as integer)

	local i as integer
	
	if ma.vars[var].typ = VAR_TYPE_VALUE

		cdSetCmdVisible(ma.vars[var].cmd, false)

	elseif ma.vars[var].typ = VAR_TYPE_LIST or ma.vars[var].typ = VAR_TYPE_OBJECT

		for i = 0 to ma.vars[var].list.length						
			//cdHideFoldedVarHierarchy(ma.vars[var].list[i])			
			cdSetCmdVisible(ma.vars[var].list[i].cmd, false)
		next
		
	endif

endfunction

//-----------------------------------------------------
// Check if a color was pressed.
//
function cdCheckColorPressed(x as float, y as float)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to cd.colorBoxes.length

		if coPointWithinRect(x, y, getspritex(cd.colorBoxes[i]), getspritey(cd.colorBoxes[i]), GetSpriteWidth(cd.colorBoxes[i]), GetSpriteHeight(cd.colorBoxes[i]))

			ret = i
			exit
			
		endif

	next
	
endfunction ret

//-----------------------------------------------------
// A part has been selected for edit.
//
function cdEditPartBegin(cmd as integer, partIdx as integer)

	local s as string
	local title as string
	local i as integer
	local pos as integer
	local y as float
	local yy as float
	local selIdx as integer
	local name as string
	local acceptVis as integer[1]

	cd.submode = CD_SUBMODE_EDIT_PART
	cd.editMode = CD_EDIT_TEXT

	cd.editCmd = cmd
	cd.editPartIdx = partIdx
	cd.editObjIdx = -1

	cdSetAllAlpha(gui.inactiveAlpha)
	
	acceptVis[0] = true
	
	if ma.cmds[cmd].parts[partIdx].typ = PART_INT
		
		s = ma.cmds[cmd].parts[partIdx].info
		
		if ma.cmds[cmd].code = CODE_LOOK_SET_COLOR_PARTS

			title = "Enter a color as 0 to 255 or hex #0 to #ff"
			cdSetKeySet(CD_KEYSET_COLOR)
			yy = cdSetKeyboardVisible(CD_KBD_COLOR)

		else
			 
			title = "Enter a whole number"
			cdSetKeySet(CD_KEYSET_INTEGER)
			yy = cdSetKeyboardVisible(CD_KBD_NUMONLY)
	
		endif 
		
		y = cdSetEditPosition()
		cdShowPrevEditValues(PART_INT, yy)
		
	elseif ma.cmds[cmd].parts[partIdx].typ = PART_FLOAT

		s = ma.cmds[cmd].parts[partIdx].info
		title = "Enter a decimal number"
		cdSetKeySet(CD_KEYSET_DECIMAL)
		yy = cdSetKeyboardVisible(CD_KBD_NUMONLY)
		y = cdSetEditPosition()
		cdShowPrevEditValues(PART_FLOAT, yy)
				
	elseif ma.cmds[cmd].parts[partIdx].typ = PART_TXT
		
		s = ma.cmds[cmd].parts[partIdx].info
		
		if ma.cmds[cmd].code = CODE_FLOW_COMMENT
			s = coReplaceNewLines(s)
		endif
		
		title = "Enter text"
		cdSetKeySet(CD_KEYSET_ALL)
		yy = cdSetKeyboardVisible(CD_KBD_LOWER)
		y = cdSetEditPosition()
		cdShowPrevEditValues(PART_TXT, yy)
	
	elseif ma.cmds[cmd].parts[partIdx].typ = PART_VALUE or ma.cmds[cmd].parts[partIdx].typ = PART_VAR

		s = ma.cmds[cmd].parts[partIdx].info
		cdSetKeyboardVisible(-1)		
		cd.editMode = CD_EDIT_TAGS
		y = cdSetEditPosition()

		selIdx = cdFindSelCmdIdx(ma.cmds[cmd].code)
		//name = ma.cmds[cd.selCmds[selIdx]].parts[partIdx].info		
		//cdCreateObjVarVar()
		//y = cdShowObjEditor(cdGetEmptyPartValue(PART_VALUE), s, y, acceptVis)
		y = cdShowObjEditor(cdGetEmptyPartValue(ma.cmds[cmd].parts[partIdx].typ), s, y, acceptVis)

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_LIST

		s = ma.cmds[cmd].parts[partIdx].info
		cdSetKeyboardVisible(-1)		
		cd.editMode = CD_EDIT_TAGS
		y = cdSetEditPosition()

		selIdx = cdFindSelCmdIdx(ma.cmds[cmd].code)
		//name = ma.cmds[cd.selCmds[selIdx]].parts[partIdx].info		
		//cdCreateObjVarList()
		y = cdShowObjEditor(cdGetEmptyPartValue(PART_LIST), s, y, acceptVis)

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_COL
		
		s = ma.cmds[cmd].parts[partIdx].info
		//title = "Enter a color as hex #rrggbb or decimal rrrgggbbb"
		cdSetKeySet(CD_KEYSET_COLOR)
		cdSetKeyboardVisible(CD_KBD_COLOR)
		cdShowColorEditor(true)
		cd.editMode = CD_EDIT_COLOR
		cd.editOrigCol = coGetSpriteColor(ma.cmds[cmd].parts[partIdx].spr)
		y = cdSetEditPosition()

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_OBJ
		
		s = ma.cmds[cmd].parts[partIdx].info
		cdSetKeyboardVisible(-1)		
		cd.editMode = CD_EDIT_TAGS
		y = cdSetEditPosition()

		selIdx = cdFindSelCmdIdx(ma.cmds[cmd].code)
		name = ma.cmds[cd.selCmds[selIdx]].parts[partIdx].info
		y = cdShowObjEditor(name, s, y, acceptVis)

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_SPRITE
		
		s = ma.cmds[cmd].parts[partIdx].info
		cdSetKeyboardVisible(-1)		
		cd.editMode = CD_EDIT_TAGS
		y = cdSetEditPosition()

		selIdx = cdFindSelCmdIdx(ma.cmds[cmd].code)
		//name = ma.cmds[cd.selCmds[selIdx]].parts[partIdx].info
		y = cdShowObjEditor(cdGetEmptyPartValue(PART_SPRITE), s, y, acceptVis)

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_FRAME
		
		s = ma.cmds[cmd].parts[partIdx].info
		cdSetKeyboardVisible(-1)		
		cd.editMode = CD_EDIT_TAGS
		y = cdSetEditPosition()

		selIdx = cdFindSelCmdIdx(ma.cmds[cmd].code)
		//name = ma.cmds[cd.selCmds[selIdx]].parts[partIdx].info
		y = cdShowObjEditor(cdGetEmptyPartValue(PART_FRAME), s, y, acceptVis)

	else
		
		s = ""	
			
	endif
	
	if ld.set.trueEdit
		
		cdSetCmdPartAlpha(cd.editCmd, cd.editPartIdx, 255)
		cdSetPartSelected(cd.editCmd, cd.editPartIdx)
		cd.attachCmd = 0
		cd.attachPartIdx = -1
		
	endif

	//guiSetBarVisible(cd.Toolbar, false)

	if cd.editMode <> CD_EDIT_TAGS

		if cd.editMode = CD_EDIT_COLOR

			cdSetColorEditText(s)

		else
			
			cdSetEditTitle(title)
			cdSetEditText(s)
			
		endif
		
		cd.prevEditText = s
		cdSetEditBlankAllowed(true)
		cdSetEditCursor(-1)

	endif
	
	cdSetEditVisible(true)
	
	if not acceptVis[0]
		guiSetButtonActive(cd.acceptBut, false)
	endif

	
endfunction

//-----------------------------------------------------
// Show the color editor.
//
function cdShowColorEditor(show as integer)
	
	if cd.editColorEditor = 1
		cdShowColorEditor1(show)
	elseif cd.editColorEditor = 2
		cdShowColorEditor2(show)
	endif
	
endfunction

//-----------------------------------------------------
// Show the color editor.
//
function cdShowColorEditor1(show as integer)

	local i as integer
	local x as float
	local y as float
	local yy as float
	local count as integer
	
	x = getspritex(cd.keyPanel.panel) + co.bs / 9
	yy = getspritey(cd.keyPanel.panel) + co.bs * 6 - co.bs / 4 //- co.bs / 16
	y = yy
	
	for i = 0 to cd.colorBoxes.length

		SetSpritePosition(cd.colorBoxes[i], x, y)
		//y = y + ysize
		y = y + GetSpriteHeight(cd.colorBoxes[i])
		
		if mod(i + 1, 10) = 0
			
			//x = x + xsize
			x = x + GetSpriteWidth(cd.colorBoxes[i])
			y = yy
			
		endif

		SetSpriteDepth(cd.colorBoxes[i], GetSpriteDepth(cd.keyPanel.panel) - 2)
		SetSpriteVisible(cd.colorBoxes[i], show)
		
	next
	
endfunction

//-----------------------------------------------------
// Show the color editor2, with the slider of color range and box of selection.
//
function cdShowColorEditor2(show as integer)
endfunction

//-----------------------------------------------------
// Show the tag editor, where a bunch of properties from an obj var are shown for selection.
//
function cdShowObjEditor(objName as string, objValue as string, y as float, acceptVis ref as integer[])

	local i as integer
	local x as float
	local xx as float
	local cmd as integer
	local gap as float
	local s as string
	local pos as integer
	local token as string 
	local tokens as string[]
	local j as integer
	local single as integer
	local var as integer
	local no as NbrOrder
	local nos as NbrOrder[]
	local k as integer
	local imgId as string
	local varName as string
	local varId as string
	local sprName as string
	local sprId as string
	local cmdCol as integer
	local w as float
	local part as Part
	local resel as integer
	local toks as string[]

	gap = co.bs / 4 + co.bs / 8	
	xx = getspritex(cd.keyPanel.panel) + co.bs / 4
	x = xx
	y = y + co.bs / 8
	cmdCol = cd.grpCols[GRP_APP] // For actual OBJ values.
	cd.editObjIdx = -1
	tokens.length = -1
	resel = false // If this gets set, we activale the "Accept" but.

	coSplitString(toks, objName, "|")
	
	if toks.length > 0 and objValue = objName
		objValue = toks[1]
	endif

	objName = toks[0]
			
	cd.editObjIdx = cdGetObjVarIndex(objName)
	
	if cd.editObjIdx > -1

		var = cd.objVars[cd.editObjIdx]
		single = val(ma.vars[var].value)

		if single
			
			cdSetEditTitle("Select one")
			guiSetButtonVisible(cd.allBut, false)
			guiSetButtonVisible(cd.noneBut, false)
			guiSetButtonVisible(cd.autoAcceptBut, true)
			
		else
			
			cdSetEditTitle("Select zero or more")
			guiSetButtonVisible(cd.allBut, true)
			guiSetButtonVisible(cd.noneBut, true)
			guiSetButtonVisible(cd.autoAcceptBut, false)

		endif

		if objName = OBJ_VAR_SPRITE

			s = ma.vars[var].value 
			cdClearVar(var)
			ma.vars[var].value = s
			
			for i = 0 to ma.apps[cd.appIdx].sprites.length
				
				sprName = ma.things[ma.apps[cd.appIdx].sprites[i]].name
				//sprId = str(ma.things[ma.apps[cd.appIdx].sprites[i]].idx)
				sprId = ma.things[ma.apps[cd.appIdx].sprites[i]].id
				maSetObjValue(var, sprName, sprId)
				
			next

			objValue = cdGetObjVarVals(objName, objValue, false)
			cmdCol = cd.cmdCols[GRP_SPRITE]
			
		elseif objName = OBJ_VAR_FRAME

			s = ma.vars[var].value 
			cdClearVar(var)
			ma.vars[var].value = s
			
			for i = 0 to ma.things[cd.thingIdx].imgs.length

				imgId = ma.things[cd.thingIdx].imgs[i].id
				maSetObjValue(var, str(i + 1), imgId)

			next

			objValue = cdGetObjVarVals(objName, objValue, false)
			cmdCol = cd.cmdCols[GRP_SPRITE]
			
		elseif objName = OBJ_VAR_VAR
					
			s = ma.vars[var].value 
			cdClearVar(var)
			ma.vars[var].value = s

			for i = 0 to ma.apps[cd.appIdx].vars.length

				if ma.vars[ma.apps[cd.appIdx].vars[i]].typ = VAR_TYPE_VALUE
					
					varName = ma.vars[ma.apps[cd.appIdx].vars[i]].name
					varId = str(ma.apps[cd.appIdx].vars[i])
					maSetObjValue(var, varName, varId)
					
				endif

			next

			for i = 0 to ma.things[cd.thingIdx].vars.length

				if ma.vars[ma.things[cd.thingIdx].vars[i]].typ = VAR_TYPE_VALUE
					
					varName = ma.vars[ma.things[cd.thingIdx].vars[i]].name
					varId = str(ma.things[cd.thingIdx].vars[i])
					maSetObjValue(var, varName, varId)
					
				endif

			next

			for i = 0 to ma.apps[cd.appIdx].vars.length

				if ma.vars[ma.apps[cd.appIdx].vars[i]].typ = VAR_TYPE_LIST

					varName = ma.vars[ma.apps[cd.appIdx].vars[i]].name
					varId = str(ma.apps[cd.appIdx].vars[i])
					maSetObjValue(var, varName, varId)
					
				endif

			next
			
			for i = 0 to ma.things[cd.thingIdx].vars.length

				if ma.vars[ma.things[cd.thingIdx].vars[i]].typ = VAR_TYPE_LIST

					varName = ma.vars[ma.things[cd.thingIdx].vars[i]].name
					varId = str(ma.things[cd.thingIdx].vars[i])
					maSetObjValue(var, varName, varId)
					
				endif

			next
			
			objValue = cdGetObjVarVals(objName, objValue, false)
			cmdCol = cd.cmdCols[GRP_VAR]
			
		elseif objName = OBJ_VAR_VALUE
					
			s = ma.vars[var].value 
			cdClearVar(var)
			ma.vars[var].value = s

			for i = 0 to ma.apps[cd.appIdx].vars.length

				if ma.vars[ma.apps[cd.appIdx].vars[i]].typ = VAR_TYPE_VALUE
					
					varName = ma.vars[ma.apps[cd.appIdx].vars[i]].name
					varId = str(ma.apps[cd.appIdx].vars[i])
					maSetObjValue(var, varName, varId)
					
				endif

			next

			for i = 0 to ma.things[cd.thingIdx].vars.length

				if ma.vars[ma.things[cd.thingIdx].vars[i]].typ = VAR_TYPE_VALUE
					
					varName = ma.vars[ma.things[cd.thingIdx].vars[i]].name
					varId = str(ma.things[cd.thingIdx].vars[i])
					maSetObjValue(var, varName, varId)
					
				endif

			next

			objValue = cdGetObjVarVals(objName, objValue, false)
			cmdCol = cd.cmdCols[GRP_VAR]
				
		elseif objName = OBJ_VAR_LIST

			s = ma.vars[var].value 
			cdClearVar(var)
			ma.vars[var].value = s

			for i = 0 to ma.apps[cd.appIdx].vars.length

				if ma.vars[ma.apps[cd.appIdx].vars[i]].typ = VAR_TYPE_LIST

					varName = ma.vars[ma.apps[cd.appIdx].vars[i]].name
					varId = str(ma.apps[cd.appIdx].vars[i])
					maSetObjValue(var, varName, varId)
					
				endif

			next

			
			for i = 0 to ma.things[cd.thingIdx].vars.length

				if ma.vars[ma.things[cd.thingIdx].vars[i]].typ = VAR_TYPE_LIST

					varName = ma.vars[ma.things[cd.thingIdx].vars[i]].name
					varId = str(ma.things[cd.thingIdx].vars[i])
					maSetObjValue(var, varName, varId)
					
				endif

			next
					
			objValue = cdGetObjVarVals(objName, objValue, false)
			cmdCol = cd.cmdCols[GRP_VAR]

		endif

		for i = 1 to CountStringTokens(objValue, ",")
			
			token = GetStringToken(objValue, ",", i)			
			tokens.insert(token)

			if single
				exit
			endif
			
		next
			
		for i = 0 to ma.vars[var].list.length

			if ma.vars[var].list[i].index > 0
				
				no.nbr = ma.vars[var].list[i].index
				no.idx = i
				nos.insertsorted(no)
				
			endif
			
		next

		for i = 0 to ma.vars[var].list.length

			if ma.vars[var].list[i].index = 0
				
				no.nbr = 0
				no.idx = i
				nos.insert(no) // Just append.
				
			endif
			
		next
		
		for k = 0 to nos.length

			i = nos[k].idx
			
			cmd = ma.vars[var].list[i].cmd
			
			if not cmd

				if objName = OBJ_VAR_SPRITE
					cmd = cdCreateCmd(CODE_SPRITE_PART)
				else 
					cmd = cdCreateVarItemCmd(var, i, CODE_VAR_TAG)
				endif

				if objName = OBJ_VAR_SPRITE

					//cdAddCmdPart(cmd, cdCreatePartSprite(val(ma.vars[var].list[i].value)))
					cdAddCmdPart(cmd, cdCreatePartSprite(ma.vars[var].list[i].value))
					cdAddCmdPart(cmd, cdCreatePart(PART_STR, " " + ma.vars[var].list[i].name))
					cdSetCmdSelectedColor(cmd, cd.selCols[ma.cmds[cmd].grp])
				
					//cdSetPartThing(ma.cmds[cmd].parts[0], val(objValue))
					cdUpdateCmdSize(cmd)

				//elseif objName = OBJ_VAR_FRAME
				
					//cdSetPart(ma.cmds[cmd].parts[0], cdMakePartFrameInfo(cd.thingIdx, objValue))
					//cdUpdateCmdSize(cmd)
					
				elseif objName = OBJ_VAR_VAR
			
					cdSetCmdIcon(cmd, cd.varButImg)
					ma.cmds[cmd].iconScale = 1.0
	
					if ma.cmds[cmd].icon
	
						ma.cmds[cmd].iconScale = ma.cmds[cmd].iconScale * 0.6
						setspritescale(ma.cmds[cmd].icon, ma.cmds[cmd].iconScale, ma.cmds[cmd].iconScale)
	
					endif

					if ma.vars[var].thingIdx = -1
						cdSetCmdIcon2(cmd, cd.appVarImg)
					else
						cdSetCmdIcon2(cmd, cd.spriteVarImg)
					endif

				elseif objName = OBJ_VAR_VALUE
			
					cdSetCmdIcon(cmd, cd.varButImg)
					ma.cmds[cmd].iconScale = 1.0
	
					if ma.cmds[cmd].icon
	
						ma.cmds[cmd].iconScale = ma.cmds[cmd].iconScale * 0.6
						setspritescale(ma.cmds[cmd].icon, ma.cmds[cmd].iconScale, ma.cmds[cmd].iconScale)
	
					endif

					if ma.vars[var].thingIdx = -1
						cdSetCmdIcon2(cmd, cd.appVarImg)
					else
						cdSetCmdIcon2(cmd, cd.spriteVarImg)
					endif
	
				elseif objName = OBJ_VAR_LIST
	// VAR VAR				
					cdSetCmdIcon(cmd, cd.varButImg)
					ma.cmds[cmd].iconScale = 1.0
	
					if ma.cmds[cmd].icon
	
						ma.cmds[cmd].iconScale = ma.cmds[cmd].iconScale * 0.6
						setspritescale(ma.cmds[cmd].icon, ma.cmds[cmd].iconScale, ma.cmds[cmd].iconScale)
	
					endif

					if ma.vars[var].thingIdx = -1
						cdSetCmdIcon2(cmd, cd.appVarImg)
					else
						cdSetCmdIcon2(cmd, cd.spriteVarImg)
					endif
						
				endif

				ma.vars[var].list[i].cmd = cmd
				
			endif

			w = cdGetCmdWidth(cmd)
						
			if y < getspritey(cd.acceptBut.bg) + GetSpriteHeight(cd.acceptBut.bg)
				
				if x + w > getspritex(cd.acceptBut.bg) - co.bs / 2
					
					x = xx
					y = y + cdGetCmdHeight(cmd) + gap
					
				endif

			elseif GetSpriteVisible(cd.allBut.bg) and y < getspritey(cd.allBut.bg) + GetSpriteHeight(cd.allBut.bg)

				if x + w > getspritex(cd.allBut.bg) - co.bs / 2
					
					x = xx
					y = y + cdGetCmdHeight(cmd) + gap
					
				endif

			elseif GetSpriteVisible(cd.autoAcceptBut.bg) and y < getspritey(cd.autoAcceptBut.bg) + GetSpriteHeight(cd.autoAcceptBut.bg)

				if x + w > getspritex(cd.autoAcceptBut.bg) - co.bs / 2
					
					x = xx
					y = y + cdGetCmdHeight(cmd) + gap
					
				endif

			elseif x + w > getspritex(cd.keyPanel.panel) + GetSpriteWidth(cd.keyPanel.panel)

				x = xx
				y = y + cdGetCmdHeight(cmd) + gap

			endif

			cdSetCmdColor(cmd, cmdCol)
			cdSetCmdDepth(cmd, GetSpriteDepth(cd.keyPanel.panel) - 2)
			cdSetCmdPos(cmd, x, y)
			cdSetCmdSelected(cmd, false)
			
			// Reselect based on value in text.
			for j = 0 to tokens.length

				if tokens[j] = ma.vars[var].list[i].name
					
					cdSetCmdSelected(cmd, true)
					//exit
					resel = true
					
				endif
				
			next

			cdSetCmdVisible(cmd, true)

			x = x + cdGetCmdWidth(cmd) + gap
		
		next
				
	endif
	
	if acceptVis.length > -1
		if single and not resel
			acceptVis[0] = false
		else 
			acceptVis[0] = true
		endif
	endif
		
endfunction y

//-----------------------------------------------------
// Show the a list of previous cmd values.
//
function cdHidePrevEditValues(clearList as integer)
	
	local i as integer
	
	SetTextVisible(cd.prevValueTitle, false)
	
	if clearList
		
		for i = 0 to cd.prevValues.length
			if cd.prevValues[i].cmd
				cddeletecmd(cd.prevValues[i].cmd)
			endif
		next 
		
		cd.prevValues.length = -1
	
	else 

		for i = 0 to cd.prevValues.length
			if cd.prevValues[i].cmd
				cdSetCmdVisible(cd.prevValues[i].cmd, false)
			endif
		next 
		
	endif
	
endfunction

//-----------------------------------------------------
// Show the a list of previous cmd values.
//
function cdShowPrevEditValues(typ as integer, y as float)

	local i as integer
	local x as float
	local xx as float
	local cmd as integer
	local gap as float
	local s as string
	local t as string
	local pos as integer
	local cmdCol as integer
	local w as float
	local mw as float
	local part as Part

	cdHidePrevEditValues(false)

	if cd.prevValues.length = -1
		exitfunction 0
	endif
		
	gap = co.bs / 4 + co.bs / 8
	xx = getspritex(cd.keyPanel.panel) + co.bs / 4
	x = xx
	y = y + co.bs / 8 + co.bs / 4

	SetTextPosition(cd.prevValueTitle, x, y)
	SetTextVisible(cd.prevValueTitle, true)

	guiSetButtonPos(cd.autoAcceptBut, GetSpriteXByOffset(cd.cancelBut.bg), y + co.bs / 2)
	guiSetButtonVisible(cd.autoAcceptBut, true)
	
	y = y + co.bs / 2
	
	cmdCol = cd.grpCols[GRP_DATA] // For actual OBJ values.
		
	for i = 0 to cd.prevValues.length

		if cd.prevValues[i].typ = typ
		
			if not cd.prevValues[i].cmd

				w = 0
				s = cd.prevValues[i].info
				t = ""
				mw = GetSpriteWidth(cd.keyPanel.panel) - co.bs / 2
				
				while w <= mw
					
					cmd = cdCreateCmd(CODE_VAR_TAG)
					part = cdCreatePart(PART_STR, s + t)
					cdAddCmdPart(cmd, part)
					w = cdGetCmdWidth(cmd)

					if w > mw
						
						cddeletecmd(cmd)
						cmd = 0
						s = mid(s, 1, len(s) - 1)
						t = "..."
						w = 0
						
					else 
						
						exit
						
					endif
	
				endwhile
								
				cd.prevValues[i].cmd = cmd

			else 
				
				cmd = cd.prevValues[i].cmd	
				w = cdGetCmdWidth(cmd)
							
			endif
							
			if y < getspritey(cd.acceptBut.bg) + GetSpriteHeight(cd.acceptBut.bg)
				
				if x + w > getspritex(cd.acceptBut.bg) - co.bs / 2
					
					x = xx
					y = y + cdGetCmdHeight(cmd) + gap
					
				endif
	
			elseif GetSpriteVisible(cd.allBut.bg) and y < getspritey(cd.allBut.bg) + GetSpriteHeight(cd.allBut.bg)
	
				if x + w > getspritex(cd.allBut.bg) - co.bs / 2
					
					x = xx
					y = y + cdGetCmdHeight(cmd) + gap
					
				endif
	
			elseif GetSpriteVisible(cd.autoAcceptBut.bg) and y < getspritey(cd.autoAcceptBut.bg) + GetSpriteHeight(cd.autoAcceptBut.bg)
	
				if x + w > getspritex(cd.autoAcceptBut.bg) - co.bs / 2
					
					x = xx
					y = y + cdGetCmdHeight(cmd) + gap
					
				endif

			elseif x + w > getspritex(cd.keyPanel.panel) + GetSpriteWidth(cd.keyPanel.panel) - co.bs / 2
					
				x = xx
				y = y + cdGetCmdHeight(cmd) + gap
	
			endif
	
			// Ensure we don't show too many items.
			if y - cdGetCmdHeight(cmd) < getspritey(cd.keyPanel.panel) + GetSpriteheight(cd.keyPanel.panel) - gap
				
				cdSetCmdColor(cmd, cmdCol)
				cdSetCmdDepth(cmd, GetSpriteDepth(cd.keyPanel.panel) - 2)
				cdSetCmdPos(cmd, x, y)
				cdSetCmdSelected(cmd, false)
				cdSetCmdVisible(cmd, true)
		
				x = x + cdGetCmdWidth(cmd) + gap
				
			endif
			
		endif
	
	next

endfunction y

//-----------------------------------------------------
// Show the tag editor, where a bunch of properties from an obj var are shown for selection.
//
function cdHideObjEditor()

	local i as integer
	local cmd as integer

	if cd.editObjIdx > -1

		if ma.vars[cd.objVars[cd.editObjIdx]].name = OBJ_VAR_SPRITE or ma.vars[cd.objVars[cd.editObjIdx]].name = OBJ_VAR_FRAME or ma.vars[cd.objVars[cd.editObjIdx]].name = OBJ_VAR_VALUE or ma.vars[cd.objVars[cd.editObjIdx]].name = OBJ_VAR_LIST or ma.vars[cd.objVars[cd.editObjIdx]].name = OBJ_VAR_VAR

			cdClearVarItems(cd.objVars[cd.editObjIdx])

		else
			
			for i = 0 to ma.vars[cd.objVars[cd.editObjIdx]].list.length

				cmd = ma.vars[cd.objVars[cd.editObjIdx]].list[i].cmd

				if cmd
					cdSetCmdVisible(cmd, false)
				endif
				
			next

		endif

		cd.editObjIdx = -1

	endif

	guiSetButtonVisible(cd.allBut, false)
	guiSetButtonVisible(cd.noneBut, false)
	guiSetButtonVisible(cd.autoAcceptBut, false)

endfunction

//-----------------------------------------------------
// Get the index into the obj list of the obj var with name.
//
function cdGetObjVarIndex(name as string)

	local idx as integer
	local i as integer
	
	idx = -1
	
	for i = 0 to cd.objVars.length
		
		if ma.vars[cd.objVars[i]].name = name
			
			idx = i
			exit
			
		endif
		
	next

endfunction idx

//-----------------------------------------------------
// If toValue is true, convert a obj var CSV list to value,
// e.g. LEFT for "alignment" would return "0"
// If toValues is true, it converts from names to values, otherwise the opposite.
//
function cdGetObjVarVals(objName as string, s as string, toValues as integer)

	local objIdx as integer
	local count as integer
	local ret as string
	local i as integer
	local j as integer
	local cmd as integer
	local token as string
	local var as integer
	local toks as string[]

	ret = ""
	
	coSplitString(toks, s, "|")
	
	if toks.length > 0
		s = toks[1]
	endif
	
	objIdx = cdGetObjVarIndex(objName)
	
	if objIdx > -1

		var = cd.objVars[objIdx]
		count = CountStringTokens2(s, ",")

		for j = 1 to count

			token = GetStringToken2(s, ",", j)
			
			for i = 0 to ma.vars[var].list.length

				if toValues
					
					if ma.vars[var].list[i].name = token

						if ret <> ""
							ret = ret + ","
						endif
						
						ret = ret + ma.vars[var].list[i].value
						exit
						
					endif

				else

					if ma.vars[var].list[i].value = token

						if ret <> ""
							ret = ret + ","
						endif
						
						ret = ret + ma.vars[var].list[i].name
						exit
						
					endif

				endif
				
			next

		next

	endif

endfunction ret

//-----------------------------------------------------
// Get a string from an object var.
//
function cdGetEditObjVarStr(getName as integer)

	local i as integer
	local cmd as integer
	local s as string
	local t as string

	s = ""
	
	if cd.editObjIdx > -1

		if getName
			s = ma.vars[cd.objVars[cd.editObjIdx]].name
		else
			s = ma.vars[cd.objVars[cd.editObjIdx]].value
		endif
		
		t = ""
		
		for i = 0 to ma.vars[cd.objVars[cd.editObjIdx]].list.length

			cmd = ma.vars[cd.objVars[cd.editObjIdx]].list[i].cmd

			if cmd
				
				if cdGetCmdSelected(cmd)

					if t <> ""
						t = t + ","
					endif

					if getName
						t = t + ma.vars[cd.objVars[cd.editObjIdx]].list[i].name
					else 
						t = t + ma.vars[cd.objVars[cd.editObjIdx]].list[i].value
					endif
					
				endif
				
			endif
			
		next

		if t <> ""
			s = t // s = s + "[" + t + "]"
		endif
		
	endif

endfunction s

//-----------------------------------------------------
// Create an app.
//
function cdCreateApp(name as string, img as integer)

	local appIdx as integer
	
	appIdx = maCreateApp("")
	ma.apps[appIdx].name = name
	ma.apps[appIdx].folder = LD_BASE_DIR + LD_APP_DIR + "/" + ma.apps[appIdx].id
	ma.apps[appIdx].img = img
	
endfunction appIdx

//-----------------------------------------------------
// Create a thing, and save it.
//
function cdCreateThing(name as string)

	local thingIdx as integer
	
	thingIdx = maCreateThing("")
	ma.things[thingIdx].name = name
	//ma.things[thingIdx].dir = ma.things[thingIdx].id + "_" + ma.things[thingIdx].name
	ma.things[thingIdx].x = co.w / 2
	ma.things[thingIdx].y = co.h / 2

endfunction thingIdx

//-----------------------------------------------------
// Create a sound, and save it.
//
function cdCreateSound(name as string)

	local idx as integer
	
	idx = maCreateSound("")
	ma.sounds[idx].name = name

endfunction idx

//-----------------------------------------------------
// Create a video, and save it.
//
function cdCreateVideo(name as string)

	local idx as integer
	
	idx = maCreateVideo("")
	ma.videos[idx].name = name

endfunction idx

//-----------------------------------------------------
// Create a var, and save it.
//
function cdCreateVar(typ as integer, name as string)

	local idx as integer
	
	idx = maCreateVar(typ)
	ma.vars[idx].name = name

endfunction idx

//-----------------------------------------------------
// Clear a variable value.
//
function cdClearVar(var as integer)

	cdClearVarItems(var)
	
	ma.vars[var].value = ""

	if ma.vars[var].cmd
		
		cdDeleteCmd(ma.vars[var].cmd)
		ma.vars[var].cmd = 0
		
	endif

endfunction

//-----------------------------------------------------
// Load the app.
//
function cdAddApp(libItemIdx as integer)

	if libItemIdx = 0 // New project.

		cdNewApp(CD_SUBMODE_NEW_APP)

	else

		cdLoadApp(ld.libItems[libItemIdx].id)
		cdSetTabVisible("a", true)

	endif
			
endfunction

//-----------------------------------------------------
// Add an image to a thing.
//
function cdAddThingImage(appIdx as integer, thingIdx as integer, file as string, attachCmd as integer, attachDir as integer)

	local newImg as Image
	local imgIdx as integer
	local idx as integer

	newImg.id = ldGetNextImageId()
	newImg.img = coloadimage("cdAddThingImage:img", file)

	if attachCmd

		idx = maFindFrameByCmd(thingIdx, attachCmd)

		if attachDir = DIR_S
			inc idx
		endif
			
		if idx > -1 and idx <= ma.things[thingIdx].imgs.length

			ma.things[thingIdx].imgs.insert(newImg, idx)
			imgIdx = idx
		
		else
						
			ma.things[thingIdx].imgs.insert(newImg)
			imgIdx = ma.things[thingIdx].imgs.length

		endif
	
	else
		
		ma.things[thingIdx].imgs.insert(newImg)
		imgIdx = ma.things[thingIdx].imgs.length

	endif
	
	// Set imgIdx to this image, if it is the first.
	if ma.things[thingIdx].imgs.length > -1

		ma.things[thingIdx].imgIdx = imgIdx
		ldSaveThingImage(appIdx, thingIdx, imgIdx)

	else

		ma.things[thingIdx].imgIdx = -1

	endif	

endfunction

//-----------------------------------------------------
// Add a sound to a project.
//
function cdAddSound(appIdx as integer, soundIdx as integer, libItem ref as LibItem)

	ma.sounds[soundIdx].file = libItem.file
	ma.sounds[soundIdx].ext = libItem.ext
	ma.apps[appIdx].sounds.insert(soundIdx)
	ldSaveSound(appIdx, soundIdx)
	
endfunction

//-----------------------------------------------------
// Add a video to a project.
//
function cdAddVideo(appIdx as integer, videoIdx as integer, libItem ref as LibItem)

	ma.videos[videoIdx].file = libItem.file
	ma.videos[videoIdx].ext = libItem.ext
	ma.apps[appIdx].videos.insert(videoIdx)
	ldSaveVideo(appIdx, videoIdx)
	
endfunction

//-----------------------------------------------------
// Copies the shell of an app.
//
function cdCopyAppShell(srcAppIdx as integer, newName as string)

	local destAppIdx as integer
	
	destAppIdx = cdCreateApp(newName, cd.appImg)

	ma.apps[destAppIdx].sprites = ma.apps[srcAppIdx].sprites 
	ma.apps[destAppIdx].sprId = ma.apps[srcAppIdx].sprId 
	ma.apps[destAppIdx].sounds = ma.apps[srcAppIdx].sounds 
	ma.apps[destAppIdx].videos = ma.apps[srcAppIdx].videos 
	ma.apps[destAppIdx].vars = ma.apps[srcAppIdx].vars 

endfunction destAppIdx

//-----------------------------------------------------
// Complete an accepted edit.
//
function cdEditAccept()

	local s as string
	local appIdx as integer
	local thingIdx as integer
	local soundIdx as integer
	local videoIdx as integer
	local name as string
	local idx as integer
	local press as CmdPress
	local dir as string 
	local varIdx as integer
	local blkIdx as integer
	local cmd as integer
	local appId as string
	local unloadApp as integer
	local newAppIdx as integer
	local col as integer
	local w as float
	local h as float
	local pos as integer
	local ret as integer
	local img as integer
	local spr as integer
	local cols as integer
	local rows as integer

	if cd.submode = CD_SUBMODE_NEW_APP or cd.submode = CD_SUBMODE_NEW_THING

		s = cdGetEditText()

		if cd.mainTab = CD_TAB_APP

			if s <> ""

				if ld.set.quickNaming
					name = cdGetUniqueAppName(s)
				else
					name = s
				endif
				
				appIdx = cdCreateApp(name, cd.appImg)
				ldSaveApp(ma.apps[appIdx].id)
				cdLoadApp(ma.apps[appIdx].id)
				cdClearLibItem(cd.currLibItem)
				cdHideThingHover()
				cd.fileItemIdx = -1
				cd.fileIdx = -1
				cd.subMode = CD_SUBMODE_PRELOAD
				cdSetTabVisible("o", true)

			endif
			
		elseif cd.mainTab = CD_TAB_THING
			
			if s <> ""

				if cd.thingTab = GRP_SPRITE

					if cd.currLibItem.visible // Via drag-n-drop.

						if cd.currLibItem.status && LD_STATUS_IMPORT

							appIdx = cd.currLibItem.appIdx
							cd.subMode = CD_SUBMODE_PRELOAD // Force a reload.

						else

							appIdx = cd.appIdx
							
						endif

						name = cdGetUniqueThingName(appIdx, s)
						thingIdx = cdCreateThing(name)
						maSetThingVisible(thingIdx, false)

						if cd.attachCmd

							idx = maFindThingByCmd(appIdx, cd.attachCmd)

							if cd.attachDir = DIR_N
								
								ma.apps[appIdx].sprites.insert(thingIdx, idx)
														
							else

								// Append if at the end.
								if idx = ma.apps[appIdx].sprites.length
									ma.apps[appIdx].sprites.insert(thingIdx)
								else
									ma.apps[appIdx].sprites.insert(thingIdx, idx + 1)
								endif
														
							endif
							
						else

							ma.apps[appIdx].sprites.insert(thingIdx)

						endif

						cdAddThingImage(appIdx, thingIdx, cd.currLibItem.file, 0, 0)

					else // Via popup menu - new sprite.

						appIdx = cd.appIdx
						name = cdGetUniqueThingName(appIdx, s)
						thingIdx = cdCreateThing(name)
						maSetThingVisible(thingIdx, false)
						ma.apps[appIdx].sprites.insert(thingIdx)
						cdAddThingImage(appIdx, thingIdx, ld.libItems[cd.fileItemIdx].file, 0, 0)

					endif

					if appIdx = cd.appIdx
						cdSelectThing(thingIdx) // Assuming this saves.			
					else						
						//maSave()						
						ldSaveApp(ma.apps[appIdx].id)
					endif

					if cd.currLibItem.status && LD_STATUS_IMPORT
						cdSetTabVisible("import", true)
					endif

				elseif cd.thingTab = GRP_SOUND

					if cd.currLibItem.status && LD_STATUS_IMPORT

						appIdx = cd.currLibItem.appIdx
						cd.subMode = CD_SUBMODE_PRELOAD // Force a reload.

					else

						appIdx = cd.appIdx
						
					endif

					name = cdGetUniqueSoundName(appIdx, s)
					soundIdx = cdCreateSound(name)

					if cd.currLibItem.visible // Via drag-n-drop.						
						cdAddSound(appIdx, soundIdx, cd.currLibItem)
					else // Via popup menu - new sprite.
						cdAddSound(appIdx, soundIdx, ld.libItems[cd.fileItemIdx])
					endif

					//maSave()
					ldSaveApp(ma.apps[appIdx].id)
					cdSetTabVisible("new sound", true)
				
				elseif cd.thingTab = GRP_VIDEO

					if cd.currLibItem.status && LD_STATUS_IMPORT

						appIdx = cd.currLibItem.appIdx
						cd.subMode = CD_SUBMODE_PRELOAD // Force a reload.

					else

						appIdx = cd.appIdx
						
					endif
					
					name = cdGetUniqueVideoName(appIdx, s)
					videoIdx = cdCreateVideo(name)

					if cd.currLibItem.visible // Via drag-n-drop.
						cdAddVideo(appIdx, videoIdx, cd.currLibItem)
					else // Via popup menu - new sprite.
						cdAddVideo(appIdx, videoIdx, ld.libItems[cd.fileItemIdx])
					endif

					//maSave()
					ldSaveApp(ma.apps[appIdx].id)
					cdSetTabVisible("new video", true)
				
				elseif cd.thingTab = GRP_VAR

					if cd.currLibItem.visible // Via drag-n-drop.
						cdAddVar(s, cd.currLibItem)
					else // Via popup menu - new var.
						cdAddVar(s, ld.libItems[cd.fileItemIdx])						
					endif

					maSave()
					cdSetTabVisible("new var", true)
				
				endif
				
			endif

			cdClearLibItem(cd.currLibItem)
			cdHideThingHover()
			cd.fileItemIdx = -1
			cd.fileIdx = -1
			//cdSetTabVisible("s", true)

		endif

	elseif cd.submode = CD_SUBMODE_DUP_APP or cd.submode = CD_SUBMODE_DUP_LIB_APP

		s = cdGetEditText()

		if cd.mainTab = CD_TAB_APP

			if s <> ""

				unloadApp = false
				
				if cd.submode = CD_SUBMODE_DUP_LIB_APP and not ma.apps[cd.editIdx].loaded

					appId = ma.apps[cd.editIdx].id
					unloadApp = true
					ldLoadApp(appId)
					cdSetTidyCode(appId)
							
				endif
				
				name = cdGetUniqueAppName(s)
				newAppIdx = cdCopyAppShell(cd.editIdx, name)
				ldSaveApp(ma.apps[newAppIdx].id)
				ldCopyAppMedia(cd.editIdx, newAppIdx)

				// Remove the shell, don't want to delete otherwise will kill original app.
				ldUnloadApp(ma.apps[newAppIdx].id)
				
				if cd.submode = CD_SUBMODE_DUP_LIB_APP
					if unloadApp
						cdUnloadApp(cd.editIdx)
					endif
				else // Make it the current app.
					cdLoadApp(ma.apps[newAppIdx].id)
				endif
				
				cdClearLibItem(cd.currLibItem)
				cdHideThingHover()
				cd.fileItemIdx = -1
				cd.fileIdx = -1
				cd.editIdx = -1
				cd.subMode = CD_SUBMODE_PRELOAD
				cdSetTabVisible("o", true)

			else

				colog("Error: app name not set")
				
			endif

		endif
			
	elseif cd.submode = CD_SUBMODE_DUP_THING

		s = cdGetEditText()

		if cd.thingTab = GRP_VAR
			cdDuplicateThing2(cd.thingTab, cd.editIdx, cd.varValueIdx, s)
		else
			cdDuplicateThing2(cd.thingTab, cd.editIdx, cd.editImgIdx, s)
		endif
			
	elseif cd.submode = CD_SUBMODE_DUP_LIB_THING

		s = cdGetEditText()

		cdDuplicateLibThing2(cd.thingTab, cd.editIdx, s)

	elseif cd.submode = CD_SUBMODE_COPY_THING_TO_LIB

		s = cdGetEditText()

		cdCopyThingToLib2(cd.thingTab, cd.editIdx, cd.editImgIdx, s)

	elseif cd.submode = CD_SUBMODE_NEW_VALUE

		s = cdGetEditText()

		if s <> ""

			if ma.vars[cd.editIdx].typ = VAR_TYPE_LIST

				if cd.varValueIdx > -1
					
					// Make it 1 based, not 0.
					inc cd.varValueIdx

					// Inc if south side of insert.
					if cd.attachDir = DIR_S
						inc cd.varValueIdx
					endif

				endif
				
				cdAddItemToList(cd.editIdx, s, cd.varValueIdx)
				
			elseif ma.vars[cd.editIdx].typ = VAR_TYPE_OBJECT
				
				// TODO: Fix to have name and value.
				cdAddItemToObject(cd.editIdx, s, s)
				
			endif

			maSave()
			
			cdClearLibItem(cd.currLibItem)
			cdHideThingHover()
			cd.fileItemIdx = -1
			cd.fileIdx = -1
			cd.editIdx = -1
			cd.varValueIdx = -1
			//cd.subMode = CD_SUBMODE_PRELOAD
			cdSetTabVisible("ooo", true)

		endif

	elseif cd.submode = CD_SUBMODE_EDIT_VAR_VALUE

		s = cdGetEditText()

		if s <> ""

			if ma.vars[cd.editIdx].typ = VAR_TYPE_LIST

				ma.vars[cd.editIdx].list[cd.varValueIdx].value = s
				cdDeleteCmd(ma.vars[cd.editIdx].list[cd.varValueIdx].cmd)
				ma.vars[cd.editIdx].list[cd.varValueIdx].cmd = 0
				
			elseif ma.vars[cd.editIdx].typ = VAR_TYPE_OBJECT
				
				colog("Editing var value object property not supported yet")
				
			endif

			maSave()
			
			//cdClearLibItem(cd.currLibItem)
			//cdHideThingHover()
			cd.fileItemIdx = -1
			cd.fileIdx = -1
			cd.editIdx = -1
			cd.varValueIdx = -1
			cdSetTabVisible("vv", true)

		endif

	elseif cd.submode = CD_SUBMODE_EDIT_VAR_VALUE_NAME

		s = cdGetEditText()

		if s <> ""

			if ma.vars[cd.editIdx].typ = VAR_TYPE_LIST

				ma.vars[cd.editIdx].list[cd.varValueIdx].name = s
				cdDeleteCmd(ma.vars[cd.editIdx].list[cd.varValueIdx].cmd)
				ma.vars[cd.editIdx].list[cd.varValueIdx].cmd = 0
				
			elseif ma.vars[cd.editIdx].typ = VAR_TYPE_OBJECT
				
				colog("Editing var value name property not supported yet")
				
			endif

			maSave()
			
			//cdClearLibItem(cd.currLibItem)
			//cdHideThingHover()
			cd.fileItemIdx = -1
			cd.fileIdx = -1
			cd.editIdx = -1
			cd.varValueIdx = -1
			cdSetTabVisible("vvn", true)

		endif

	elseif cd.submode = CD_SUBMODE_RENAME_APP or cd.submode = CD_SUBMODE_RENAME_THING 

		s = cdGetEditText()

		if cd.mainTab = CD_TAB_APP

			if s <> ""
				
				name = cdGetUniqueAppName(s)
				//ldRenameApp(cd.appIdx, name)
				ma.apps[cd.editIdx].name = name
				maSave()
				cdDeleteCmd(ma.apps[cd.editIdx].cmd)
				ma.apps[cd.editIdx].cmd = 0
			
			endif

			cd.editIdx = -1
			cd.subMode = CD_SUBMODE_PRELOAD
			cdSetTabVisible("t", true)
			//cdSetAppsVisible(true)

		elseif cd.mainTab = CD_TAB_THING

			if s <> ""

				if cd.thingTab = GRP_SPRITE
						
					name = cdGetUniqueThingName(cd.appIdx, s)
					//ldRenameThing(ma.apps[cd.appIdx].dir, ma.apps[cd.appIdx].dir, cd.editIdx, name)
					cd.origName = ma.things[cd.editIdx].name
					ma.things[cd.editIdx].name = name
					maSave()
					cdDeleteCmd(ma.things[cd.editIdx].cmd)
					ma.things[cd.editIdx].cmd = 0
					//cdReplaceCodeThings(cd.thingIdx, PART_SPRITE, cd.editIdx, cd.editIdx)
					cdReplaceImageParts(cd.editIdx, PART_SPRITE, str(cd.editIdx), "-2")
					guiSetButtonText(cd.codeBut, name)
					coSetTextColor(cd.codeBut.text, co.black)

				elseif cd.thingTab = GRP_SOUND
						
					name = cdGetUniqueSoundName(cd.appIdx, s)
					//ldRenameSound(ma.apps[cd.appIdx].dir, ma.apps[cd.appIdx].dir, cd.editIdx, name)
					ma.sounds[cd.editIdx].name = name
					maSave()
					cdDeleteCmd(ma.sounds[cd.editIdx].cmd)
					ma.sounds[cd.editIdx].cmd = 0
					cdReplaceCodeThings(cd.thingIdx, PART_SOUND_NAME, cd.editIdx, cd.editIdx)
					
				elseif cd.thingTab = GRP_VIDEO
						
					name = cdGetUniqueVideoName(cd.appIdx, s)
					//ldRenameVideo(ma.apps[cd.appIdx].dir, ma.apps[cd.appIdx].dir, cd.editIdx, name)
					ma.videos[cd.editIdx].name = name
					maSave()
					cdDeleteCmd(ma.videos[cd.editIdx].cmd)
					ma.videos[cd.editIdx].cmd = 0
					cdReplaceCodeThings(cd.thingIdx, PART_VIDEO_NAME, cd.editIdx, cd.editIdx)

				elseif cd.thingTab = GRP_VAR

					//if ma.vars[cd.editIdx].thingIdx = -1
					//	name = cdGetUniqueAppVarName(cd.appIdx, s)
					//else
					//	name = cdGetUniqueThingVarName(ma.vars[cd.editIdx].thingIdx, s)
					//endif

					name = cdGetUniqueVarName(cd.appIdx, s)

					ma.vars[cd.editIdx].name = name
					maSave()
					cdDeleteCmd(ma.vars[cd.editIdx].cmd)
					ma.vars[cd.editIdx].cmd = 0
					cdReplaceCodeThings(cd.thingIdx, PART_VAR_NAME, cd.editIdx, cd.editIdx)

				endif
				
			endif

			cd.subMode = CD_SUBMODE_PRELOAD
			cd.editIdx = -1
			cdSetTabVisible("u", true)
			//cdSetThingsVisible(true, 0)

		endif

	elseif cd.submode = CD_SUBMODE_RENAME_ITEM_FOLDER

		s = cdGetEditText()

		if cd.mainTab = CD_TAB_THING

			if s <> ""

				if cd.thingTab = GRP_SPRITE
						
					name = ldGetUniqueLibFolderName(s)
					ldRenameLibFolder(ld.libItems[cd.fileItemIdx], name)

				elseif cd.thingTab = GRP_SOUND
						
					name = ldGetUniqueLibFolderName(s)
					ldRenameLibFolder(ld.libItems[cd.fileItemIdx], name)

				elseif cd.thingTab = GRP_VIDEO
						
					name = ldGetUniqueLibFolderName(s)
					ldRenameLibFolder(ld.libItems[cd.fileItemIdx], name)

				endif
				
			endif

			cd.fileItemIdx = -1
			cd.subMode = CD_SUBMODE_PRELOAD
			cdSetTabVisible("uuuuu", true)

		endif

	elseif cd.submode = CD_SUBMODE_RENAME_ITEM

		s = cdGetEditText()

		if cd.mainTab = CD_TAB_THING

			if s <> ""

				if cd.thingTab = GRP_SPRITE
						
					name = ldGetUniqueLibItemName(s)
					ldRenameLibItem(ld.libItems[cd.fileItemIdx], name, LD_SPRITE_DIR)

				elseif cd.thingTab = GRP_SOUND
						
					name = ldGetUniqueLibItemName(s)
					ldRenameLibItem(ld.libItems[cd.fileItemIdx], name, LD_SOUND_DIR)

				elseif cd.thingTab = GRP_VIDEO
						
					name = ldGetUniqueLibItemName(s)
					ldRenameLibItem(ld.libItems[cd.fileItemIdx], name, LD_VIDEO_DIR)

				// Rename var cannot happen, yet.
				//elseif cd.thingTab = GRP_VAR
						
				//	name = ldGetUniqueLibItemName(s)
				//	ldRenameLibItem(ld.libItems[cd.fileItemIdx], name, LD_VIDEO_DIR)

				endif
				
			endif

			cd.fileItemIdx = -1
			cd.subMode = CD_SUBMODE_PRELOAD
			cdSetTabVisible("u", true)

		endif

	elseif cd.submode = CD_SUBMODE_EDIT_PART // Editing a part.

		cdHideCmdHover()

		ma.cmds[cd.editCmd].x = cd.editCmdX
		ma.cmds[cd.editCmd].y = cd.editCmdY

		if cd.editMode = CD_EDIT_TAGS			
			s = cdGetEditObjVarStr(true)			
		elseif cd.editMode = CD_EDIT_COLOR			
			s = cdGetColorEditText()		
		else 			
			s = cdGetEditText()
		endif
		
		cdApplyPartEdit(cd.editCmd, cd.editPartIdx, s, true)
		
		cd.editCmd = 0
		cd.editPartIdx = -1

		//ma.things[cd.thingIdx].saved = false
		maSave()
/*
	elseif cd.submode = CD_SUBMODE_EDIT_IMAGE_COLOR

		s = cdGetColorEditText()			
		cd.edimg.col = coMakeColor(s)

		ld.set.editCol = coColorToHex(cd.edimg.col)
		ldSaveSettings()

		cdSetEditColorButton()		
*/
/*
	elseif cd.submode = CD_SUBMODE_EDIT_RESIZE

		cdResizeEditImage()
		cdDrawEditArea()
		cdHideEditGrid()
		cdShowEditGrid()
		cdSetEditImageDetails()		
		SetTextVisible(cd.edimg.title1, true)
		SetTextVisible(cd.edimg.title2, true)
*/
		
	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_POS

		s = cdGetEditObjVarStr(true)
		s = cdGetObjVarVals(OBJ_VAR_EDGE, s, true) // Should only return 1 item.
		OnButtonAction(BUT_DESIGN_TITLE_POS, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_FONT_SIZE

		//s = cdGetEditObjVarStr(true)
		//s = cdGetObjVarVals(OBJ_VAR_FONT_SIZE, s, true) // Should only return 1 item.
		s = cdGetEditText()
		OnButtonAction(BUT_DESIGN_TITLE_FONT_SIZE, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_FONT

		s = cdGetEditObjVarStr(true)
		s = cdGetObjVarVals(OBJ_VAR_FONT, s, true) // Should only return 1 item.
		OnButtonAction(BUT_DESIGN_TITLE_FONT, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_FONT_SIZE

		//s = cdGetEditObjVarStr(true)
		//s = cdGetObjVarVals(OBJ_VAR_FONT_SIZE, s, true) // Should only return 1 item.
		s = cdGetEditText()
		OnButtonAction(BUT_DESIGN_TEXT_FONT_SIZE, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_FONT

		s = cdGetEditObjVarStr(true)
		s = cdGetObjVarVals(OBJ_VAR_FONT, s, true) // Should only return 1 item.
		OnButtonAction(BUT_DESIGN_TEXT_FONT, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_VARBG_COL

		s = cdGetColorEditText()			
		col = coMakeColor(s)
		OnButtonAction(BUT_DESIGN_VARBG_COL, col)

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_COL

		s = cdGetColorEditText()			
		col = coMakeColor(s)
		OnButtonAction(BUT_DESIGN_TITLE_COL, col)

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_BOX_COL

		s = cdGetColorEditText()			
		col = coMakeColor(s)
		OnButtonAction(BUT_DESIGN_BOX_COL, col)

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_RESIZE
	
		if cd.edi.resizedSpr2

			img = GetSpriteImageID(cd.edi.resizedSpr2)
			deletesprite(cd.edi.resizedSpr2)
			deleteimage(img)
			cd.edi.resizedSpr2 = 0
			
		endif

		if cd.edi.resizedSpr
			
			// Grab sprite, and clear resizedSpr so it doesn't get cleared.
			spr = cd.edi.resizedSpr
			cd.edi.resizedSpr = 0
			
		endif
		
		if spr
			
			img = GetSpriteImageID(spr)
			deletesprite(spr)
			
		else 
			
			img = 0
		
		endif

		OnButtonAction(BUT_EDITOR_RESIZE, img)

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_BG_COLOR

		s = cdGetColorEditText()			
		ld.set.deBgCol = coMakeColor(s)
		ldSaveSettings()
		OnButtonAction(BUT_DESIGN_BG_COLOR, ld.set.deBgCol)

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_COL

		s = cdGetColorEditText()			
		col = coMakeColor(s)
		OnButtonAction(BUT_EDITOR_COLOR, col)

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_LINE_SIZE

		s = cdGetEditText()
		OnButtonAction(BUT_EDITOR_LINE_SIZE, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_POLY_SIZE

		s = cdGetEditText()
		OnButtonAction(BUT_EDITOR_POLY_SIDES, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_TEXT_FONT

		s = cdGetEditObjVarStr(true)
		s = cdGetObjVarVals(OBJ_VAR_FONT, s, true) // Should only return 1 item.
		OnButtonAction(BUT_EDITOR_TEXT_FONT, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_TEXT_SIZE

		s = cdGetEditText()
		OnButtonAction(BUT_EDITOR_TEXT_SIZE, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_TEXT_EDIT

		s = cdGetEditText()
		ma.passedStrs.insert(s)
		idx = ma.passedStrs.length
		OnButtonAction(BUT_EDITOR_TEXT_EDIT, idx)

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_GRID_ROWS

		s = cdGetEditText()
		OnButtonAction(BUT_EDITOR_GRID_ROWS, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_GRID_COLS

		s = cdGetEditText()
		OnButtonAction(BUT_EDITOR_GRID_COLS, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_GRID_WIDTH

		s = cdGetEditText()
		OnButtonAction(BUT_EDITOR_GRID_WIDTH, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_GRID_HEIGHT

		s = cdGetEditText()
		OnButtonAction(BUT_EDITOR_GRID_HEIGHT, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_COL

		s = cdGetColorEditText()				
		col = coMakeColor(s)
		OnButtonAction(BUT_DESIGN_TEXT_COL, col)

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_ALIGN

		s = cdGetEditObjVarStr(true)
		s = cdGetObjVarVals(OBJ_VAR_TITLE_ALIGN, s, true) // Should only return 1 item.
		OnButtonAction(BUT_DESIGN_TITLE_ALIGN, val(s))

	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_ALIGN

		//if cd.editMode = CD_EDIT_TAGS
		s = cdGetEditObjVarStr(true)
		s = cdGetObjVarVals(OBJ_VAR_TEXT_ALIGN, s, true)
		OnButtonAction(BUT_DESIGN_TEXT_ALIGN, val(s))

/*	
	elseif cd.submode = CD_SUBMODE_EDIT_IMAGE_TEXT

		guiSetBarAlpha(cd.edimg.toolbar, 255)
		
		s = cdGetEditText()			
		cd.edimg.text = s

		if cd.edimg.text <> ""

			cdHideEditSel()
			cdDrawEditText(cd.edimg.waitX, cd.edimg.waitY)
			cd.edimg.mode = CD_EDIT_MODE_SELECT
			cdMakeEditSpr(false)
			cdBurnEditSel(0)
			cdShowEditSel()
			cdSetEditButtons()

		endif
*/
/*		
	elseif cd.submode = CD_SUBMODE_EDIT_IMAGE_GRID_COLS

		guiSetBarAlpha(cd.edimg.toolbar, 255)

		s = cdGetEditText()		
		cd.edimg.gridCols = val(s)

		if cd.edimg.gridCols < 0
			cd.edimg.gridCols = 1
		elseif cd.edimg.gridCols > 128
			cd.edimg.gridCols = 128
		endif

		ld.set.editGridCols = cd.edimg.gridCols
		ldSaveSettings()

		cdHideEditGrid()
		cdShowEditGrid()
		cdSetEditColsButton()
		
	elseif cd.submode = CD_SUBMODE_EDIT_IMAGE_GRID_ROWS

		guiSetBarAlpha(cd.edimg.toolbar, 255)

		s = cdGetEditText()			
		cd.edimg.gridRows = val(s)
		
		if cd.edimg.gridRows < 0
			cd.edimg.gridRows = 1
		elseif cd.edimg.gridRows > 128
			cd.edimg.gridRows = 128
		endif

		ld.set.editGridRows = cd.edimg.gridRows
		ldSaveSettings()
			
		cdHideEditGrid()
		cdShowEditGrid()
		cdSetEditRowsButton()

	elseif cd.submode = CD_SUBMODE_EDIT_IMAGE_SIZE

		guiSetBarAlpha(cd.edimg.toolbar, 255)

		s = cdGetEditText()			
		cd.edimg.size = val(s)

		if cd.edimg.size < 0
			cd.edimg.size = 1
		elseif cd.edimg.size > CD_DRAW_SIZE_MAX
			cd.edimg.size = CD_DRAW_SIZE_MAX
		endif

		ld.set.editLineSize = cd.edimg.size
		ldSaveSettings()
		
		cdSetEditSizeButton()

	elseif cd.submode = CD_SUBMODE_EDIT_IMAGE_TEXT_SIZE

		guiSetBarAlpha(cd.edimg.toolbar, 255)

		s = cdGetEditText()			
		cd.edimg.textSize = val(s)

		if cd.edimg.textSize < 0
			cd.edimg.textSize = 1
		elseif cd.edimg.textSize > CD_TEXT_SIZE_MAX
			cd.edimg.textSize = CD_TEXT_SIZE_MAX
		endif

		ld.set.editTextSize = cd.edimg.textSize
		ldSaveSettings()
		
		cdSetEditSizeButton()
*/
	elseif cd.submode = CD_SUBMODE_EDIT_SETTINGS_GRID_COLS

		s = cdGetEditText()
		ld.set.gridCols = val(s)
		ld.set.gridCols = coRoundImageSize(ld.set.gridCols, 2, 128)
		
		if ld.set.gridCols < 1
			ld.set.gridCols = 1
		elseif ld.set.gridCols > ED_GRID_COLS_MAX
			ld.set.gridCols = ED_GRID_COLS_MAX
		endif
		
		//ed.gfx.gridWidth = ed.gfx.cols.w / ed.gfx.gridCols
		ld.set.gridWidth = co.w / ld.set.gridCols
	
		ldSaveSettings()
		//cdSetSettingsGridColsButton()
		OnButtonAction(BUT_DESIGN_GRID_COLS, 0)

	elseif cd.submode = CD_SUBMODE_EDIT_SETTINGS_GRID_WIDTH

		s = cdGetEditText()
		ld.set.gridWidth = val(s)
		
		if ld.set.gridWidth < 1
			ld.set.gridWidth = 1
		elseif ld.set.gridWidth > co.w
			ld.set.gridWidth = co.w
		endif
	
		ldSaveSettings()
		OnButtonAction(BUT_DESIGN_GRID_WIDTH, 0)
		
	elseif cd.submode = CD_SUBMODE_EDIT_SETTINGS_GRID_ROWS

		s = cdGetEditText()
		ld.set.gridRows = val(s)
		ld.set.gridRows = coRoundImageSize(ld.set.gridRows, 2, 128)
		
		if ld.set.gridCols < 1
			ld.set.gridCols = 1
		elseif ld.set.gridCols > ED_GRID_ROWS_MAX
			ld.set.gridCols = ED_GRID_ROWS_MAX
		endif
		
		ld.set.gridHeight = co.h / ld.set.gridCols
		
		ldSaveSettings()
		//cdSetSettingsGridRowsButton()
		OnButtonAction(BUT_DESIGN_GRID_ROWS, 0)

	elseif cd.submode = CD_SUBMODE_EDIT_SETTINGS_GRID_HEIGHT

		s = cdGetEditText()
		ld.set.gridHeight = val(s)
		
		if ld.set.gridHeight < 1
			ld.set.gridHeight = 1
		elseif ld.set.gridHeight > co.h
			ld.set.gridHeight = co.h
		endif
	
		ldSaveSettings()
		OnButtonAction(BUT_DESIGN_GRID_HEIGHT, 0)
	
	elseif cd.submode = CD_SUBMODE_EDIT_DESIGN_SCREEN

		s = cdGetEditObjVarStr(true)
		s = cdGetObjVarVals(OBJ_VAR_SCREEN, s, true)
		OnButtonAction(BUT_DESIGN_SCREEN, val(s))

		//s = cdGetEditText()
		//ma.apps[cd.appIdx].status = ma.apps[cd.appIdx].status && !(LD_STATUS_MOB_LAND || LD_STATUS_MOB_PORT)
		//ma.apps[cd.appIdx].status = ma.apps[cd.appIdx].status || (val(s) << 16)
			
		//ldSaveSettings()
		//OnButtonAction(BUT_DESIGN_SCREEN, 0)
		
	endif
	
endfunction

//-----------------------------------------------------
// Hide the edit color panel.
//
function cdHideEditColor()

	guiDeleteButton(cd.editBut)

endfunction

//-----------------------------------------------------
// Convert a var to specific typ.
// If the var is already that type, no action is taken.
//
function cdConvertVar(var as integer, typ as integer)

	if ma.vars[var].typ <> typ

		ma.vars[var].typ = typ
		cdClearVar(var)
		
	endif
	
endfunction

//-----------------------------------------------------
// Add a value to a list var, convert if necessary.
// listIdx is 1 based.
//
function cdAddItemToList(var as integer, value as string, listIdx as integer)

	local itemVar as integer
	local item as VarItem

	cdConvertVar(var, VAR_TYPE_LIST)
	
	item.name = ""
	item.value = value
	item.parent = var	
		
	if listIdx < 0
		listIdx = ma.vars[var].list.length - listIdx
	endif
		
	if listIdx > 0
		
		if (listIdx - 1) <= ma.vars[var].list.length			
			ma.vars[var].list.insert(item, listIdx - 1)		
		else			
			listIdx = 0 // Append.			
		endif
	endif
					
	if listIdx = 0 // Append.
		ma.vars[var].list.insert(item)
	endif			
	
endfunction

//-----------------------------------------------------
// Add a value to an object var, convert if necessary.
//
function cdAddItemToObject(var as integer, name as string, value as string)

	local itemVar as integer
	local item as VarItem

	cdConvertVar(var, VAR_TYPE_OBJECT)
	
	item.name = name
	item.value = value
	item.parent = var	
		
	ma.vars[var].list.insertsorted(item)
	
endfunction

//-----------------------------------------------------
// insert a new var depending on its typ.
// s is the starting name.
//
function cdAddVar(s as string, libItem ref as LibItem)

	local name as string
	local varIdx as integer
	
	if libItem.typ = LD_ITEM_VAR_APP
		
		//name = cdGetUniqueAppVarName(cd.appIdx, s)
		name = cdGetUniqueVarName(cd.appIdx, s)
		varIdx = cdCreateVar(VAR_TYPE_VALUE, name)
		ma.vars[varIdx].appIdx = cd.appIdx
		ma.vars[varIdx].thingIdx = -1
		maInsertVar(ma.apps[cd.appIdx].vars, varIdx)

	elseif libItem.typ = LD_ITEM_LIST_APP
		
		//name = cdGetUniqueAppVarName(cd.appIdx, s)
		name = cdGetUniqueVarName(cd.appIdx, s)
		varIdx = cdCreateVar(VAR_TYPE_LIST, name)
		ma.vars[varIdx].appIdx = cd.appIdx
		ma.vars[varIdx].thingIdx = -1
		maInsertVar(ma.apps[cd.appIdx].vars, varIdx)

	elseif libItem.typ = LD_ITEM_VAR_SPRITE

		//name = cdGetUniqueThingVarName(cd.thingIdx, s)
		name = cdGetUniqueVarName(cd.appIdx, s)
		varIdx = cdCreateVar(VAR_TYPE_VALUE, name)
		ma.vars[varIdx].appIdx = cd.appIdx
		ma.vars[varIdx].thingIdx = cd.thingIdx
		maInsertVar(ma.things[cd.thingIdx].vars, varIdx)

	elseif libItem.typ = LD_ITEM_LIST_SPRITE

		//name = cdGetUniqueThingVarName(cd.thingIdx, s)
		name = cdGetUniqueVarName(cd.appIdx, s)
		varIdx = cdCreateVar(VAR_TYPE_LIST, name)
		ma.vars[varIdx].appIdx = cd.appIdx
		ma.vars[varIdx].thingIdx = cd.thingIdx
		maInsertVar(ma.things[cd.thingIdx].vars, varIdx)

	endif

endfunction

//-----------------------------------------------------
// Apply part edit.
// save = true puts the change into the undo buffer.
//
function cdApplyPartEdit(cmd as integer, partIdx as integer, s as string, save as integer)

	local idx as integer
	local press as CmdPress
	local cmds as integer[]
	local varCmd as integer
	local sf as integer[]
	local newCmd as integer
	local selIdx as integer

	if save
		
		cd.tmpClip.attachCmd = cmd
		cd.tmpClip.attachPartIdx = partIdx
		cd.tmpClip.cmds.length = -1
		cd.tmpClip.part = ma.cmds[cmd].parts[partIdx]
		cdSaveCmds(CD_CLIP_EDIT)

	endif
	
	cdClearPart(ma.cmds[cmd].parts[partIdx])

	if ma.cmds[cmd].parts[partIdx].typ = PART_SPRITE
		
		s = cdGetObjVarVals(OBJ_VAR_SPRITE, s, true) // Should only return 1 item.
		
		if s <> ""
						
			newCmd = cdCreateCmd(CODE_SPRITE_PART)
			//idx = val(s)
			//cdAddCmdPart(newCmd, cdCreatePartSprite(idx))
			cdAddCmdPart(newCmd, cdCreatePartSprite(s))
			cdSetCmdSelectedColor(newCmd, cd.selCols[ma.cmds[newCmd].grp])
	
			cd.currCmds.insert(newCmd)
			cdFixDragSpec(cd.currCmds[0])
			cd.attachCmd = cmd
			cd.attachPartIdx = partIdx
			cdDropCmd()
			cd.currCmds.length = -1
			
		endif
			 			 
	elseif ma.cmds[cmd].parts[partIdx].typ = PART_FRAME

		s = cdGetObjVarVals(OBJ_VAR_FRAME, s, true) // Should only return 1 item.
		
		if s <> ""
			
			cdFindFrameIdxById(-1, s, sf)
	
			//newCmd = cdCloneCmd(ma.things[sf[0]].imgs[sf[1]].cmd)
			newCmd = cdCreateCmd(CODE_FRAME_PART)
			cdAddCmdPart(newCmd, cdCreatePartFrame(ma.things[sf[0]].imgs[sf[1]].id))
			cdSetCmdSelectedColor(cmd, cd.selCols[ma.cmds[newCmd].grp])
	
			cd.currCmds.insert(newCmd)
			cdFixDragSpec(cd.currCmds[0])
			cd.attachCmd = cmd
			cd.attachPartIdx = partIdx
			cdDropCmd()
			cd.currCmds.length = -1
			
		endif

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_VAR
		
		s = cdGetObjVarVals(OBJ_VAR_VAR, s, true) // Should only return 1 item.
		
		if s <> ""
			
			idx = val(s)
			
			newCmd = cdCreateVarCmd(idx)
	
			cd.currCmds.insert(newCmd)
			cdFixDragSpec(cd.currCmds[0])
			cd.attachCmd = cmd
			cd.attachPartIdx = partIdx
			cdDropCmd()
			cd.currCmds.length = -1
			
		endif

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_VALUE
		
		s = cdGetObjVarVals(OBJ_VAR_VALUE, s, true) // Should only return 1 item.
		
		if s <> ""
			
			idx = val(s)
			
			newCmd = cdCreateVarCmd(idx)
	
			cd.currCmds.insert(newCmd)
			cdFixDragSpec(cd.currCmds[0])
			cd.attachCmd = cmd
			cd.attachPartIdx = partIdx
			cdDropCmd()
			cd.currCmds.length = -1
			
		endif

	//elseif ma.cmds[cmd].code = CODE_FLOW_COMMENT

	//	s = coReplaceTildes(s, chr(10))
	//	cdSetPart(ma.cmds[cmd].parts[partIdx], s)

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_LIST
		
		s = cdGetObjVarVals(OBJ_VAR_LIST, s, true) // Should only return 1 item.
		
		if s <> ""
			
			idx = val(s)
			
			newCmd = cdCreateVarCmd(idx)
	
			cd.currCmds.insert(newCmd)
			cdFixDragSpec(cd.currCmds[0])
			cd.attachCmd = cmd
			cd.attachPartIdx = partIdx
			cdDropCmd()
			cd.currCmds.length = -1
			
		endif

	elseif ma.cmds[cmd].parts[partIdx].typ = PART_BOOL

		if AGK_BUILD			
			selIdx = cdFindSelCmdName("true")
		else 			
			selIdx = cdFindSelCmdIdx(CODE_SENSE_TRUE)
		endif

        	newCmd = cdCloneCmd(cd.selCmds[selIdx])
		cd.currCmds.insert(newCmd)
		cdFixDragSpec(cd.currCmds[0])
		cd.attachCmd = cmd
		cd.attachPartIdx = partIdx
		cdDropCmd()
		cd.currCmds.length = -1

	else

		cdSetPart(ma.cmds[cmd].parts[partIdx], s)
		cdAddPrevValue(ma.cmds[cmd].parts[partIdx], s)

	endif
	
	cdFixPluralCmd(cmd)

	idx = cdFindThingCmd(cd.thingIdx, cmd, 0)
	
	if idx = -1 // Not on a root cmd.

		press.cmd = cmd
		cdFindThingRootCmd(cd.thingIdx, press)
		cdUpdateCmdSize(press.parentCmd)

	else

		cdUpdateCmdSize(cmd)
		
	endif

	cdSetCmdPos(cmd, ma.cmds[cmd].x, ma.cmds[cmd].y)

	cmds.insert(cd.editCmd)
	cdRestoreCmds(cmds)
	cdDrawCode("part edit", 0)
	
endfunction

//-----------------------------------------------------
// Fix a cmd that has plural options.
//
function cdFixPluralCmd(cmd as integer)
	
	local vi as integer
	local vf as float
	
		// TODO: Super hack!
	if ma.cmds[cmd].code = CODE_FLOW_REPEAT_TIMES
		
		vi = cdGetPartAsInt(ma.cmds[cmd].parts[1])
		cdClearPart(ma.cmds[cmd].parts[2])

		if vi = 1				
			cdSetPart(ma.cmds[cmd].parts[2], " time")
		else
			cdSetPart(ma.cmds[cmd].parts[2], " times")
		endif
		
	elseif ma.cmds[cmd].code = CODE_FLOW_WAIT_SECS
		
		vf = cdGetPartAsFloat(ma.cmds[cmd].parts[1])
		cdClearPart(ma.cmds[cmd].parts[2])

		if vf = 1				
			cdSetPart(ma.cmds[cmd].parts[2], " second")
		else
			cdSetPart(ma.cmds[cmd].parts[2], " seconds")
		endif

	elseif ma.cmds[cmd].code = CODE_LOOK_PRINT_FOR_TIME
		
		vf = cdGetPartAsFloat(ma.cmds[cmd].parts[3])
		cdClearPart(ma.cmds[cmd].parts[4])

		if vf = 1				
			cdSetPart(ma.cmds[cmd].parts[4], " second")
		else
			cdSetPart(ma.cmds[cmd].parts[4], " seconds")
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Save a previous value for a part type, so it can be used in the next edit.
//
function cdAddPrevValue(part ref as Part, s as string)

	local pv as PrevValue
	local lastIdx as integer
	local count as integer
	local i as integer

	for i = cd.prevValues.length to 0 step -1
		
		if cd.prevValues[i].typ = part.typ // Only look for same type.
			
			if lastIdx = -1
				
				lastIdx = i // This would be one to remove if we exceed count.
				
			elseif cd.prevValues[i].info = s
				
				lastIdx = i // However, if we find the same value, we'll remove that instead.
				count = CD_PREV_VALUES_MAX // Force the remove.
				
			endif
			
			inc count
			
		endif
		
	next
			
	// Need to remove one, too many.
	if count >= CD_PREV_VALUES_MAX
		
		if cd.prevValues[lastIdx].cmd
			cddeletecmd(cd.prevValues[lastIdx].cmd)
		endif
		
		cd.prevValues.remove(lastIdx)
		
	endif
	
	// Add the new one to the end.
	pv.typ = part.typ
	pv.info = s
	pv.cmd = 0
	
	if cd.prevValues.length > -1
		cd.prevValues.insert(pv, 0)
	else 
		cd.prevValues.insert(pv) // Append, AGK bug!
	endif
		
endfunction

//-----------------------------------------------------
// Check that the text entry is valid compared to a rule.
//
function cdGetValidTextRules(s as string)

	local i as integer
	local j as integer
	local typ as integer
	local pat as string
	local dashcount as integer
	local dotcount as integer
	local valid as integer
	local msg as string
	local c as string
	local v as integer

	msg = ""

	if cd.keySetIdx = -1
		exitfunction ""
	endif
	
	if cd.keySet[cd.keySetIdx].rules.length > -1

		for i = 0 to cd.keySet[cd.keySetIdx].rules.length

			if cd.keySet[cd.keySetIdx].rules[i].typ = CD_KEYRULE_INTEGER

				dashcount = 0
				valid = true
				
				for j = 1 to len(s)

					c = mid(s, j, 1)
					
					if c = "-"
						inc dashcount
					elseif findstring(cd.digits, c) = 0
						valid = false
					endif

					if not valid
						exit
					endif
					
				next

				if valid
					if dashcount > 1 or (dashcount = 1 and left(s, 1) <> "-") // Too many dashs, or dash is not on left.
						valid = false
					endif
				endif
				
			elseif cd.keySet[cd.keySetIdx].rules[i].typ = CD_KEYRULE_DECIMAL

				dashcount = 0
				dotcount = 0
				valid = true
				
				for j = 1 to len(s)

					c = mid(s, j, 1)

					if c = "-"
						inc dashcount
					elseif c = "."
						inc dotcount 
					elseif findstring(cd.digits, c) = 0
						valid = false
					endif

					if not valid
						exit
					endif
					
				next

				if valid
					if dotcount > 1 or (dotcount = 1 and len(s) = 1) // Too many dots, or only dot.
						valid = false
					elseif dashcount > 1 or (dashcount = 1 and left(s, 1) <> "-") // Too many dashes, or dash is not on left.
						valid = false
					endif
				endif
				
			elseif cd.keySet[cd.keySetIdx].rules[i].typ = CD_KEYRULE_COLOR

				valid = true
				
				if left(s, 1) <> "#"

					if valid
						
						for j = 1 to len(s)
							
							if findstring(cd.digits, mid(s, j, 1)) = 0
								
								valid = false
								exit
								
							endif
							
						next

					endif
					
					if valid // Valid chars, check len.
						//if len(s) <> 3
						if len(s) < 1
							valid = false
						endif
					endif

					if valid // Right length, with right digits, check values.

						v = val(s) // val(mid(s, 1, 3))
						
						if v < 0 or v > 255
							valid = false
						endif
						
					endif

				else // Hex if left = "#"
					
					//if left(s, 1) <> "#"
					//	valid = false
					//endif

					if valid
						
						for j = 2 to len(s)
							
							if findstring(cd.digits + "abcdefABCDEF", mid(s, j, 1)) = 0
								
								valid = false
								exit
								
							endif
							
						next

					endif
					
					if valid // Valid chars, check len.
						//if len(s) <> 3
						if len(s) < 2 // Need at least # and one digit/letter.
							valid = false
						endif
					endif

					if valid // Proper len, check hex values.

						v = coHexToInt(mid(s, 2, -1))

						if v < 0 or v > 255
							valid = false
						endif
						
					endif

				endif

			elseif cd.keySet[cd.keySetIdx].rules[i].typ = CD_KEYRULE_NAME

				valid = true
				
				for j = 1 to len(s)

					c = mid(s, j, 1)

					if j = 1
						if findstring(cd.alphas, c) = 0
							valid = false
						endif
					else
						if findstring(cd.alphas + cd.digits + "-_ ", c) = 0
							valid = false
						endif						
					endif
						
					if not valid
						exit
					endif
					
				next
				
			endif

			if valid
				if s = "" and not cd.editBlankAllowed
					valid = false
				endif
			endif

			if not valid
				
				msg = cd.keySet[cd.keySetIdx].rules[i].helpMsg
				exit
				
			endif

		next
		
	endif

endfunction msg

//-----------------------------------------------------
// Get a unique var name for a thing.
//
function xxxcdGetUniqueThingVarName(thingIdx as integer, s as string)

	local i as integer
	local nu as nameUnique
	
	nu.suffix = 0
	nu.name = s
	nu.unique = false
	
	while not nu.unique

		nu.unique = true
		
		for i = 0 to ma.things[thingIdx].vars.length
			
			if ma.vars[ma.things[thingIdx].vars[i]].name = nu.name

				coGetUniqueName(nu)
				exit

			endif

		next

	endwhile

endfunction nu.name

//-----------------------------------------------------
// Get a unique var name for an app.
//
function xxxcdGetUniqueAppVarName(appIdx as integer, s as string)

	local i as integer
	local nu as nameUnique
	
	nu.suffix = 0
	nu.name = s
	nu.unique = false
	
	while not nu.unique

		nu.unique = true
		
		for i = 0 to ma.apps[appIdx].vars.length
			
			if ma.vars[ma.apps[appIdx].vars[i]].name = nu.name

				coGetUniqueName(nu)
				exit

			endif

		next

	endwhile

endfunction nu.name

//-----------------------------------------------------
// Get a unique var name across the board.
//
function cdGetUniqueVarName(appIdx as integer, s as string)

	local i as integer
	local j as integer
	local k as integer
	local nu as nameUnique
	local vars as integer[]
	local thingIdx as integer
	
	for i = 0 to ma.apps[appIdx].vars.length		
		vars.insert(ma.apps[appIdx].vars[i])
	next
		
	for j = 0 to ma.apps[appIdx].sprites.length
		
		thingIdx = ma.apps[appIdx].sprites[j]
		
		for k = 0 to ma.things[thingIdx].vars.length				
			vars.insert(ma.things[thingIdx].vars[k])
		next 
		
	next 
	
	nu.suffix = 0
	nu.name = s
	nu.unique = false
	
	while not nu.unique

		nu.unique = true
		
		for i = 0 to vars.length
			
			if ma.vars[vars[i]].name = nu.name

				coGetUniqueName(nu)
				exit

			endif

		next

	endwhile

endfunction nu.name

//-----------------------------------------------------
// Find the selcmd, that points to var.
//
function cdFindVarCmd(var as integer)

	local i as integer
	local idx as integer

	idx = -1
	
	for i = 0 to cd.selCmds.length

		if ma.cmds[cd.selCmds[i]].var = var
			
			idx = i
			exit
			
		endif
		
	next
	
endfunction idx

//-----------------------------------------------------
// Add a var cmd to the sel cmds.
//
function cdCreateVarCmd(var as integer)

	local cmd as integer
	local part as Part

	cmd = cdCreateCmd(CODE_VAR_GET)

	if ma.vars[var].thingIdx = -1
		cdSetCmdIcon2(cmd, cd.appVarImg)
	else
		cdSetCmdIcon2(cmd, cd.spriteVarImg)
	endif
			
	cdSetCmdCheckable(cmd, true)
	cdSetCmdCheckAlignment(cmd, CD_CHECK_RIGHT)

	if ma.vars[var].typ = VAR_TYPE_LIST or ma.vars[var].typ = VAR_TYPE_OBJECT
		
		cdSetCmdFoldable(cmd, true)
		cdSetCmdFoldAlignment(cmd, CD_FOLD_RIGHT)
		cdSetCmdFolded(cmd, true)
		
	endif

	part = cdCreatePartVar(var)
	cdAddCmdPart(cmd, part)
		
	if ma.vars[var].vis
		cdSetCmdChecked(cmd, true)
	endif
	
	ma.cmds[cmd].var = var
	ma.cmds[cmd].codeTab = false

endfunction cmd

//-----------------------------------------------------
// Create a cmd for a var item.
//
//function cdCreateVarItemCmd(var as integer, varItem ref as VarItem)
function cdCreateVarItemCmd(var as integer, listIdx as integer, typ as integer)

	local cmd as integer
	local part as Part
	local s as string 

	cmd = cdCreateCmd(typ)

	if ma.vars[var].typ = VAR_TYPE_LIST
		
		//s = varItem.value
		//s = ma.vars[var].list[listIdx].value

		// Add the number.
		s = str(listIdx + 1) + " : "		
		part = cdCreatePart(PART_STR, s)
		cdAddCmdPart(cmd, part)

		// Add the value.
		s = ma.vars[var].list[listIdx].value		
		part = cdCreatePart(PART_STR, s)
		cdAddCmdPart(cmd, part)

		if ma.vars[var].list[listIdx].name <> ""
			
			// Add the name.
			s = " (" + ma.vars[var].list[listIdx].name	 + ")"	
			part = cdCreatePart(PART_STR, s)
			cdAddCmdPart(cmd, part)
			
		endif

	elseif ma.vars[var].typ = VAR_TYPE_OBJECT
		
		//s = varItem.name
		s = ma.vars[var].list[listIdx].name
		part = cdCreatePart(PART_STR, s)
		cdAddCmdPart(cmd, part)
		
	endif
		
	ma.cmds[cmd].codeTab = false

endfunction cmd

//-----------------------------------------------------
// Ensure the part values are displaying the correct value.
//
function cdCheckVarItemCmd(var as integer, listIdx as integer)

	local cmd as integer
	local part as Part
	local v as integer
	local s as string 

	//cmd = cdCreateCmd(typ)
	cmd = ma.vars[var].list[listIdx].cmd
	
	if ma.vars[var].typ = VAR_TYPE_LIST
		
		v = cdGetPartAsInt(ma.cmds[cmd].parts[0])

		if v <> listIdx + 1

			cdClearPart(ma.cmds[cmd].parts[0])
			s = str(listIdx + 1) + " : "		
			cdSetPart(ma.cmds[cmd].parts[0], s)
			cdUpdateCmdSize(cmd)
			
		endif
				
	endif
		
	ma.cmds[cmd].codeTab = false

endfunction cmd

//-----------------------------------------------------
// Get a unique thing name.
//
function cdGetUniqueThingName(appIdx as integer, s as string)

	local i as integer
	local nu as nameUnique
	
	nu.suffix = 0
	nu.name = s
	nu.unique = false
	
	while not nu.unique

		nu.unique = true
		
		for i = 0 to ma.apps[appIdx].sprites.length
			
			if ma.things[ma.apps[appIdx].sprites[i]].name = nu.name

				coGetUniqueName(nu)
				exit

			endif

		next

	endwhile

endfunction nu.name

//-----------------------------------------------------
// Get a unique sound name.
//
function cdGetUniqueSoundName(appIdx as integer, s as string)

	local i as integer
	local nu as nameUnique
	
	nu.suffix = 0
	nu.name = s
	nu.unique = false
	
	while not nu.unique

		nu.unique = true
		
		for i = 0 to ma.apps[appIdx].sounds.length
			
			if ma.sounds[ma.apps[appIdx].sounds[i]].name = nu.name

				coGetUniqueName(nu)
				exit

			endif

		next

	endwhile

endfunction nu.name

//-----------------------------------------------------
// Get a unique text name.
//
function cdGetUniqueVideoName(appIdx as integer, s as string)

	local i as integer
	local nu as nameUnique
	
	nu.suffix = 0
	nu.name = s
	nu.unique = false
	
	while not nu.unique

		nu.unique = true
		
		for i = 0 to ma.apps[appIdx].videos.length
			
			if ma.videos[ma.apps[appIdx].videos[i]].name = nu.name

				coGetUniqueName(nu)
				exit

			endif

		next

	endwhile

endfunction nu.name

//-----------------------------------------------------
// Get a unique app name.
//
function cdGetUniqueAppName(s as string)

	local i as integer
	local nu as nameUnique
	
	nu.suffix = 0
	nu.name = s
	nu.unique = false
	
	while not nu.unique

		nu.unique = true
		
		for i = 0 to ma.apps.length
			
			if ma.apps[i].name = nu.name

				coGetUniqueName(nu)
				exit

			endif

		next

	endwhile

endfunction nu.name

//-----------------------------------------------------
// A part has been selected for edit.
//
function cdSetAllAlpha(alpha as integer)

	local i as integer
	local j as integer
	
	//for i = 0 to cd.sprs.length
	//	SetSpriteColorAlpha(cd.sprs[i], alpha)
	//next

	if cd.thingIdx > -1
		for i = 0 to ma.things[cd.thingIdx].cmds.length			
			cdSetCmdAlpha(ma.things[cd.thingIdx].cmds[i], alpha)
		next
	endif
	
	for i = 0 to cd.selCmds.length
		cdSetCmdAlpha(cd.selCmds[i], alpha)
	next

	for i = 0 to ma.apps.length
		if ma.apps[i].cmd
			cdSetCmdAlpha(ma.apps[i].cmd, alpha)
		endif
	next

	for i = 0 to ma.things.length
		
		if ma.things[i].cmd
			cdSetCmdAlpha(ma.things[i].cmd, alpha)
		endif

		for j = 0 to ma.things[i].imgs.length
			if ma.things[i].imgs[j].cmd
				cdSetCmdAlpha(ma.things[i].imgs[j].cmd, alpha)
			endif
		next
		
	next

	for i = 0 to ma.sounds.length
		if ma.sounds[i].cmd
			cdSetCmdAlpha(ma.sounds[i].cmd, alpha)
		endif
	next

	for i = 0 to ma.videos.length
		if ma.videos[i].cmd
			cdSetCmdAlpha(ma.videos[i].cmd, alpha)
		endif
	next

	for i = 0 to ma.vars.length
		
		if ma.vars[i].cmd
			
			cdSetCmdAlpha(ma.vars[i].cmd, alpha)

			if ma.vars[i].typ = VAR_TYPE_LIST or ma.vars[i].typ = VAR_TYPE_OBJECT

				for j = 0 to ma.vars[i].list.length

					if ma.vars[i].list[j].cmd
						cdSetCmdAlpha(ma.vars[i].list[j].cmd, alpha)
					endif
					
				next
				
			endif
			
		endif
	next

	guiSetBarAlpha(cd.grpBar, alpha)
	guiSetBarAlpha(cd.thingBar, alpha)
	guiSetBarAlpha(cd.toolBar, alpha)
	guiSetBarAlpha(cd.cmdBar, alpha)
	guiSetBarAlpha(cd.appBar, alpha)
	guiSetBarAlpha(cd.varBar, alpha)
	guiSetBarAlpha(cd.codeBar, alpha)
	guiSetBarAlpha(cd.helpBar, alpha)
	guiSetBarAlpha(cd.spriteBar, alpha)
	
	guiSetButtonAlpha(cd.appBut, alpha)
	guiSetButtonAlpha(cd.thingBut, alpha)
	guiSetButtonAlpha(cd.cmdBut, alpha)
	//guiSetButtonAlpha(cd.settingsBut, alpha)
	guiSetButtonAlpha(cd.codeBut, alpha)
	guiSetButtonAlpha(cd.libraryBut, alpha)
	guiSetButtonAlpha(cd.helpBut, alpha)

	guiSetPanelAlpha(cd.mainPanel, alpha)
	guiSetPanelAlpha(cd.appPanel, alpha)
	guiSetPanelAlpha(cd.codePanel, alpha)
	//guiSetPanelAlpha(cd.settingsPanel, alpha)

	for i = GRP_SPRITE to GRP_VIDEO // GRP_VAR
		guiSetPanelAlpha(cd.cmdPanels[i], alpha)
	next

	for i = GRP_BEGIN to GRP_DATA
		guiSetPanelAlpha(cd.cmdPanels[i], alpha)
	next

	if cd.thingSel
		SetSpriteColorAlpha(cd.thingSel, alpha)
	endif
	
	if cd.thingSelArr
		SetSpriteColorAlpha(cd.thingSelArr, alpha)
	endif
	
	if cd.fileTab = CD_FILE_TAB_LIBRARY
		cdSetLibItemsAlpha(ld.libItems, alpha)
	endif
	
endfunction

//-----------------------------------------------------
// Check if cmd bg is pressed, or cmd part is pressed, or press.parentCmd is dragged over cmd.
//
function cdGetCmdPressed(drag as integer, press ref as CmdPress, x as float, y as float, extra as float)

	local i as integer
	local cmd as integer
	local subPress as CmdPress
	local partTyp as integer
	local spr as integer
	local xx as float
	local yy as float
	local ww as float
	local hh as float
	local closestDist as float
	local dist as float

	closestDist = 0xffffff
	spr = 0
	cmd = press.cmd

	xx = cdGetCmdPosX(press.parentCmd)
	yy = cdGetCmdPosY(press.parentCmd)
	ww = cdGetCmdWidth(press.parentCmd)
	hh = cdGetCmdHeight(press.parentCmd)

	for i = 0 to ma.cmds[cmd].parts.length

		partTyp = ma.cmds[cmd].parts[i].typ
		
		if partTyp = PART_INT or partTyp = PART_FLOAT or partTyp = PART_COL or partTyp = PART_TXT or partTyp = PART_BOOL or partTyp = PART_SPRITE or partTyp = PART_FRAME or partTyp = PART_APP or partTyp = PART_VAR or partTyp = PART_VALUE or partTyp = PART_LIST or partTyp = PART_SOUND or partTyp = PART_VIDEO or partTyp = PART_OBJ

			if drag
				
				if cdGetRectOverPart(ma.cmds[cmd].parts[i], xx, yy, ww, hh)

					dist = coDist(x, y, GetSpriteXByOffset(ma.cmds[cmd].parts[i].spr), GetSpriteYByOffset(ma.cmds[cmd].parts[i].spr))

					//if dist < closestDist

					//	closestDist = dist
					//	press.partIdx = i

					//endif

					press.partIdx = i
					exit // Can't exit here, might not be the closest part to the pointer.
					
				endif

			else

				if cdGetPartGfxPressed(ma.cmds[cmd].parts[i], x, y, extra)
				
					press.partIdx = i
					exit

				endif
				
			endif

		elseif partTyp = PART_CMD

			subPress.cmd = cdGetPartAsInt(ma.cmds[cmd].parts[i])
			subPress.partIdx = -1
			subPress.parentCmd = press.parentCmd
			
			cdGetCmdPressed(drag, subPress, x, y, extra)

			if subPress.cmd > -1 // A sub cmd was pressed, or one of its parts.

				//colog("sub command pressed")
				press.cmd = subPress.cmd
				press.partIdx = subPress.partIdx
				exit // ADDED.
				
			endif
			
		endif
		
	next

	if press.cmd = cmd and press.partIdx = -1 // Not a part press, check for a cmd.

		spr = cdGetCmdGfxPressed(ma.cmds[press.cmd], x, y)
		
		if not spr
			press.cmd = -1 // Command not pressed.
		endif

	endif
	
endfunction spr

//-----------------------------------------------------
// Check if a cmd was pressed.
//
function cdGetCmdGfxPressed(cmd ref as Cmd, x as float, y as float)

	local ret as integer

	ret = 0

	if cmd.active
		if cogetspritevisible(cmd.fold) and coGetSpriteHitTest(cmd.fold, x, y, 5)		
			ret = cmd.fold
		elseif cogetspritevisible(cmd.check) and coGetSpriteHitTest(cmd.check, x, y, 5)
			ret = cmd.check
		elseif cmd.typ && CMD_BUT			
			if cogetspritevisible(cmd.lt) and GetSpriteHitTest(cmd.lt, x, y)
				ret = cmd.lt
			elseif cogetspritevisible(cmd.bg) and GetSpriteHitTest(cmd.bg, x, y)		
				ret = cmd.bg
			elseif cogetspritevisible(cmd.rt) and GetSpriteHitTest(cmd.rt, x, y)
				ret = cmd.rt
			endif
		elseif cmd.typ && CMD_SPEC
			if cmd.parts.length > -1
				if cdGetPartGfxPressed(cmd.parts[0], x, y, 0)
					ret = cmd.bg
				elseif cmd.fold and GetSpriteHitTest(cmd.bg, x, y)
					if cmd.parts[1].typ = PART_STR
						if (x >= gettextx(cmd.parts[1].text))
							ret = cmd.fold
						endif
					endif
				endif	
			endif		
		elseif cdPointWithinCmd(cmd, x, y)
			ret = cmd.bg
		endif

	endif

endfunction ret

//-----------------------------------------------------
// Check if a cmd lt, icon and first part if PART_STR was pressed.
//
function cdPointWithinCmd(cmd ref as Cmd, x as float, y as float)

	local ret as integer

	if cogetspritevisible(cmd.lt) and coGetSpriteHitTest(cmd.lt, x, y, 0)
		ret = true
	elseif cogetspritevisible(cmd.bg) and coGetSpriteHitTest(cmd.bg, x, y, 0)		
		ret = true
	elseif cogetspritevisible(cmd.rt) and coGetSpriteHitTest(cmd.rt, x, y, 0)
		ret = true
	else
		ret = false
	endif

/*
	if getspritevisible(cmd.bg) and x >= cmd.x + cmd.dragLX and x <= cmd.x + cmd.dragRX and y >= cmd.y and y < cmd.y + cmd.h
		ret = true
	else
		ret = false
	endif
*/
		
endfunction ret

//-----------------------------------------------------
// Check if a part was pressed.
//
function cdGetPartGfxPressed(part ref as Part, x as float, y as float, extra as integer)

	local ret as integer

	ret = false
	
	if GetSpriteVisible(part.spr)
		if coGetSpriteHitTest(part.spr, x, y, extra)		
			ret = true
		elseif coGetSpriteHitTest(part.lt, x, y, extra)
			ret = true
		elseif coGetSpriteHitTest(part.rt, x, y, extra)
			ret = true
		endif
	endif

endfunction ret

//-----------------------------------------------------
// Check if rect is over the part.
//
function cdGetRectOverPart(part ref as Part, x as float, y as float, w as float, h as float)

	local ret as integer

	ret = false

	if cdGetRectOverSpr(part.spr, x, y, w, h)
		ret = true
	elseif cdGetRectOverSpr(part.lt, x, y, w, h)
		ret = true
	elseif cdGetRectOverSpr(part.rt, x, y, w, h)
		ret = true
	endif
	
endfunction ret

//-----------------------------------------------------
// Check if rect is over the spr.
//
function cdGetRectOverSpr(spr as integer, x as float, y as float, w as float, h as float)

	local ret as integer

	ret = false
	
	if GetSpriteVisible(spr)
		if y >= getspritey(spr) and y < getspritey(spr) + GetSpriteHeight(spr)
		//if y < getspritey(spr) + GetSpriteHeight(spr) and y + h - 1 > getspritey(spr)
			if x < getspritex(spr) + GetSpriteWidth(spr) and x + w - 1 > getspritex(spr)
				ret = true
			endif
		endif
	endif

endfunction ret

//-----------------------------------------------------
// Action a button.
//
function cdButtonAction(butId as integer, obj as integer)

	local appIdx as integer
	local appId as string
	local thingId as string
	local name as string
	local idx as integer
	local w as integer
	local h as integer
	local oldImg as integer
	local img as integer
	local s as string
	local zs as integer
	local file as string

	if butId = -1
		
		cd.fileItemIdx = -1
		cd.waitIdx = -1
		cd.waitIdx2 = -1
		cd.editIdx = -1
		
		exitfunction

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_IMAGE
		
		if butId = BUT_CODER_FILES // Cancelled selection of image for editor.

			cd.submode = CD_SUBMODE_NONE

			guiSetPanelVisible(cd.loadPanel, false)
			cdHideLibItems(ld.libItems)
			idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
			guiSetButtonVisible(cd.toolBar.buts[idx], false)			
			guiSetButtonVisible(cd.libraryBut, false)
			guiSetBarAlpha(cd.toolbar, 255)						
			OnButtonAction(BUT_EDITOR_CANCEL_EDIT, BUT_EDITOR_IMAGE)
				
		endif

	elseif butId = BUT_CODER_APP_OPEN_FROM_HELP

		appId = ma.apps[obj].id
		cdLoadApp(appId)
		cd.mainTab = CD_TAB_APP
		cd.fileTab = CD_FILE_TAB_CODE
		cdSetTabVisible("c", true)
		cdSetApp(appId)

	elseif butId = BUT_CODER_APP_OPEN

		if ld.libItems[obj].status && LD_STATUS_BLANK

			cd.editIdx = -1
			cdNewApp(CD_SUBMODE_NEW_APP)

		else 

			appId = ld.libItems[obj].id
			appIdx = maFindAppById(appId)
				
			if not ma.apps[appIdx].loaded
				cdLoadApp(appId)
			endif
			
			cdSetTabVisible("c", true)

		endif

		cd.fileItemIdx = -1
						
	elseif butId = BUT_CODER_APP_INFO

		if cd.fileItemIdx > -1

			appId = ld.libItems[obj].id
			appIdx = maFindAppById(appId)
	
		else
			
			appIdx = obj
			appId = ma.apps[appIdx].id	

		endif
			
		cd.fileTab = CD_FILE_TAB_HELP
		cdSetFileTabVisible("appinfo", true)
		cdClearDetailedHelp(true)
		cdShowDetailedHelp(CD_HELP_APP, appIdx)
		
		cd.fileItemIdx = -1
	
	elseif butId = BUT_CODER_APP_CLOSE

		if cd.fileItemIdx > -1
			
			appId = ld.libItems[obj].id
			appIdx = maFindAppById(appId)

		else
			
			appIdx = obj
			appId = ma.apps[appIdx].id	

		endif

		cd.fileItemIdx = -1

		if appIdx > -1
			if ma.apps[appIdx].loaded
				
				cdUnloadApp(appIdx)
				cd.submode = CD_SUBMODE_PRELOAD
				
			endif
		endif
		
		cdSetTabVisible("cc", true)
				
	elseif butId = BUT_CODER_APP_DUP

		cdDuplicateApp(obj)
		
	elseif butId = BUT_CODER_LIB_APP_DUP

		cdDuplicateLibApp(obj)

	elseif butId = BUT_CODER_APP_ADDLIB

		cdAddAppToLib(obj)

	elseif butId = BUT_CODER_APP_ADDEX

		cdAddAppToEx(obj)

	elseif butId = BUT_CODER_APP_REMLIB

		appIdx = ld.libItems[obj].appIdx
		cdRemAppToLib(appIdx)

	elseif butId = BUT_CODER_APP_RENAME

		if cd.fileItemIdx > -1
			
			appId = ld.libItems[obj].id
			appIdx = maFindAppById(appId)

		else
			
			appIdx = obj

		endif

		cd.fileItemIdx = -1
		cdRenameApp(appIdx)

	elseif butId = BUT_CODER_APP_DELETE

		if cd.fileItemIdx > -1
			
			appId = ld.libItems[obj].id
			appIdx = maFindAppById(appId)

		else
			
			appIdx = obj

		endif
		
		cd.fileItemIdx = -1
		cdRemoveAppConfirm(appIdx, true)

	elseif butId = BUT_CODER_THING_NEW

		cd.fileIdx = -1
		cdNewThing(cd.thingTab)

	elseif butId = BUT_CODER_THING_ADDLIB

		cdCopyThingToLib(cd.thingTab, obj, -1)

	elseif butId = BUT_CODER_THING_RENAME

		if cd.thingTab = GRP_VAR and cd.waitIdx2 > -1
			cdEditVarValueName(cd.waitIdx, cd.waitIdx2, CD_SUBMODE_EDIT_VAR_VALUE_NAME)			
		else 			
			cdRenameThing(cd.thingTab, obj)			
		endif

	elseif butId = BUT_CODER_THING_REMOVE

		cdRemoveThingConfirm(cd.thingTab, cd.appIdx, obj, -1)

	elseif butId = BUT_CODER_VAR_CLEAR

		cdClearVarConfirm(cd.thingTab, cd.appIdx, obj)

	elseif butId = BUT_CODER_VAR_REMOVE

		cdRemoveThingConfirm(cd.thingTab, cd.appIdx, obj, cd.waitIdx2)
		//cdRemoveVar(obj, cd.waitIdx2)

	elseif butId = BUT_CODER_THING_DUP
			
		if cd.thingTab = GRP_VAR
			cdDuplicateThing(cd.thingTab, obj, cd.waitIdx2)
		else 
			cdDuplicateThing(cd.thingTab, obj, -1)
		endif
		
	elseif butId = BUT_CODER_IMAGE_NEW

		cd.fileIdx = cd.thingIdx
		
		if cd.fileIdx > -1 // Adding an frame to this thing.

			cdAddThingImage(cd.appIdx, cd.fileIdx, ld.libItems[obj].file, 0, 0)
			cdSortImages(cd.fileIdx)
			maSave()
			cdSetSprite(ma.things[cd.fileIdx].id)
			
		endif

		cd.fileIdx = -1

	elseif butId = BUT_CODER_IMAGE_REMOVE

		cdRemoveThingConfirm(GRP_FRAME, cd.appIdx, cd.waitIdx, obj)
		//cdRemoveImage(cd.waitIdx, obj)
		
	elseif butId = BUT_CODER_IMAGE_VIEW

		// waitIdx not used. obj = libItem index
		cdShowEditImage(cd.waitIdx, obj, false)

	elseif butId = BUT_CODER_THING_EDIT

		if cd.thingTab = GRP_VAR

			cdEditVarValue(cd.waitIdx, cd.waitIdx2, CD_SUBMODE_EDIT_VAR_VALUE)			

		elseif cd.thingTab = GRP_SPRITE

			obj = ma.things[cd.waitIdx].imgIdx
			cdShowEditImage(cd.waitIdx, obj, true)

		endif

	elseif butId = BUT_CODER_IMAGE_EDIT

		cdShowEditImage(cd.waitIdx, obj, true)

	elseif butId = BUT_CODER_IMAGE_ADDLIB

		cdCopyThingToLib(cd.thingTab, cd.waitIdx, obj)

	elseif butId = BUT_CODER_IMAGE_DUP

		cdDuplicateThing(cd.thingTab, cd.waitIdx, obj)
		
	elseif butId = BUT_CODER_FILES

		cdFileDialog()			

	//elseif butId = BUT_CODER_HELP_MAIN

	//	cdShowDetailedHelp(CD_HELP_MAIN, 0)		

	elseif butId = BUT_CODER_ITEM_FOLDER_RENAME

		cdRenameFolder(obj)

	elseif butId = BUT_CODER_ITEM_RENAME

		cdRenameLibThing(obj)
		
	elseif butId = BUT_CODER_ITEM_DELETE

		cdRemoveItemConfirm(cd.thingTab, cd.appIdx, obj)
		//cdDeleteLibThing(obj)

	//elseif butId = BUT_CODER_ITEM_DUP

		//cdDuplicateLibThing(cd.thingTab, obj)
		
	elseif butId = BUT_CODER_ITEM_PLAY

		if cd.thingTab = GRP_SOUND

			idx = ld.libitems[obj].idx
			//idx = maFindSoundById(cd.appIdx, ma.sounds[idx].id)
			cdShowSoundPlayer(idx, ld.libItems[obj].file)
			
		elseif cd.thingTab = GRP_VIDEO

			idx = ld.libitems[obj].idx
			//idx = maFindVideoById(cd.appIdx, ma.videos[idx].id)
			cdShowVideoPlayer(obj, ld.libItems[obj].file)
			
		endif

	elseif butId = BUT_CODER_THING_PLAY

		if cd.thingTab = GRP_SOUND

			cdShowSoundPlayer(obj, "")
			
		elseif cd.thingTab = GRP_VIDEO

			cdShowVideoPlayer(obj, "")
			
		endif

	elseif butId = BUT_CODER_APP_SHARE

//colog("share")

	elseif butId = BUT_CODER_APP_UNSHARE

//colog("unshare")

	elseif butId = BUT_CODER_VAR_SHARE

		cdAdjustVar(cd.waitIdx)
		
	elseif butId = BUT_CODER_VAR_ADD

		cdEditVarValue(cd.waitIdx, -1, CD_SUBMODE_NEW_VALUE)

	elseif butId = BUT_CODER_VAR_ADD_ABOVE

		idx = cd.waitIdx2
		//if idx < 0 then idx = 0
		cdEditVarValue(cd.waitIdx, idx, CD_SUBMODE_NEW_VALUE)

	elseif butId = BUT_CODER_VAR_ADD_BELOW

		cd.attachDir = DIR_S
		cdEditVarValue(cd.waitIdx, cd.waitIdx2, CD_SUBMODE_NEW_VALUE)

	elseif butId = BUT_CODER_VAR_TO_LIST

		cd.editIdx = cd.waitIdx
		cdConvertVar(cd.editIdx, VAR_TYPE_LIST)
		maSave()
		cdSetVarsVisible(true)

	elseif butId = BUT_CODER_VAR_TO_OBJECT

		cd.editIdx = cd.waitIdx
		cdConvertVar(cd.editIdx, VAR_TYPE_OBJECT)
		maSave()
		cdSetVarsVisible(true)

	elseif butId = BUT_CODER_HELP_QUICK

		// Nothing to do here, popup has help.
		
	elseif butId = BUT_CODER_HELP_DETAILS

		cd.fileTab = CD_FILE_TAB_HELP
		cdSetFileTabVisible("dh", true)
		cdClearDetailedHelp(true)
		cdShowDetailedHelp(CD_HELP_CMD, obj)
					
	elseif butId = BUT_CODER_DESIGN

		OnButtonAction(butId, cd.thingIdx)		

	elseif butId = BUT_CODER_RUN

		OnButtonAction(butId, cd.appIdx)		

	elseif butId = BUT_CODER_CUT

		cdClipCut(cd.waitIdx, CD_CLIP_CUT, 0) // -1)
		cdDrawCode("bb", 0)
		maSave()
		
	elseif butId = BUT_CODER_COPY

		cdClipCopy(cd.waitIdx)

	elseif butId = BUT_CODER_DELETE

		cdClipCut(cd.waitIdx, CD_CLIP_CUT_DEL, 0) // -1)
		cdDrawCode("ff", 0)
		maSave()

	elseif butId = BUT_CODER_PASTE

		cdClipPaste(cd.waitX, cd.waitY)
		cdDrawCode("aa", 0)
		maSave()
		
	elseif butId = BUT_CODER_PASTE_PART

		cdClipPasteToPart(cd.editPress.cmd, cd.editPress.partIdx)
		cdDrawCode("CPP", 0)
		maSave()
		
	elseif butId = BUT_CODER_UNDO

		cdUndo()
		
	elseif butId = BUT_CODER_REDO

		cdRedo()
		
	elseif butId = BUT_CODER_ZOOM_OUT

		cdZoomOut()

	elseif butId = BUT_CODER_TIDY

		//cd.trimWhite = true
		//cd.tidyCode = true
		ma.things[cd.thingIdx].trimWhite = true
		ma.things[cd.thingIdx].tidyCode = true
		cdDrawCode("tidy", 0)

	elseif butId = BUT_CODER_AUTO_NAMING

		cdSaveSettingsAutoNaming()
		cdSetSettingsAutoNamingButton()

	elseif butId = BUT_CODER_LIBRARIES

		cdSaveSettingsLibraries()
		cdSetSettingsLibrariesButton()

	elseif butId = BUT_CODER_CMD_SIZE

		cdSaveSettingsCmdSize()
		cdSetSettingsCmdSizeButton()

	elseif butId = BUT_CODER_HELP_SIZE

		cdSaveSettingsHelpSize()
		cdSetSettingsHelpSizeButton()

	elseif butId = BUT_TITLE_SHOW

		OnButtonAction(BUT_TITLE_SHOW, 0)
		
	elseif butId = BUT_RUNNER_AUTO_RUN

		cdSaveSettingsAutoRun()
		//cdSetSettingsAutoRunButton()
		OnButtonAction(butId, 0)

	elseif butId = BUT_DESIGN_TITLE_POS
		
		s = cdGetObjVarVals(OBJ_VAR_EDGE, str(ma.vars[obj].v.titleDir), false)
		cdShowEditMode(CD_SUBMODE_EDIT_DESIGN_TITLE_POS, s)

	elseif butId = BUT_DESIGN_TITLE_FONT_SIZE
		
		//s = cdGetObjVarVals(OBJ_VAR_FONT_SIZE, str(ma.vars[obj].v.titleFontSize), false)
		s = str(ma.vars[obj].v.titleFontSize)
		cdShowEditMode(CD_SUBMODE_EDIT_DESIGN_TITLE_FONT_SIZE, s)

	elseif butId = BUT_DESIGN_TITLE_FONT
		
		s = cdGetObjVarVals(OBJ_VAR_FONT, str(ma.vars[obj].v.titleFont), false)
		cdShowEditMode(CD_SUBMODE_EDIT_DESIGN_TITLE_FONT, s)

	elseif butId = BUT_DESIGN_TEXT_FONT_SIZE
		
		//s = cdGetObjVarVals(OBJ_VAR_FONT_SIZE, str(ma.vars[obj].v.textFontSize), false)
		s = str(ma.vars[obj].v.textFontSize)
		cdShowEditMode(CD_SUBMODE_EDIT_DESIGN_TEXT_FONT_SIZE, s)

	elseif butId = BUT_DESIGN_TEXT_FONT
		
		s = cdGetObjVarVals(OBJ_VAR_FONT, str(ma.vars[obj].v.textFont), false)
		cdShowEditMode(CD_SUBMODE_EDIT_DESIGN_TEXT_FONT, s)

	elseif butId = BUT_DESIGN_VARBG_COL

		cdShowEditColor(CD_SUBMODE_EDIT_DESIGN_VARBG_COL, ma.vars[obj].v.bgCol)

	elseif butId = BUT_DESIGN_TITLE_COL

		cdShowEditColor(CD_SUBMODE_EDIT_DESIGN_TITLE_COL, ma.vars[obj].v.titleCol)

	elseif butId = BUT_DESIGN_BOX_COL

		cdShowEditColor(CD_SUBMODE_EDIT_DESIGN_BOX_COL, ma.vars[obj].v.boxCol)

	elseif butId = BUT_DESIGN_BG_COLOR

		cdShowEditColor(CD_SUBMODE_EDIT_DESIGN_BG_COLOR, obj)

	elseif butId = BUT_EDITOR_COLOR

		cdShowEditColor(CD_SUBMODE_EDIT_EDITOR_COL, obj)

	elseif butId = BUT_EDITOR_RESIZE

		cdShowEditResize(BUT_EDITOR_RESIZE, obj)

	elseif butId = BUT_EDITOR_LINE_SIZE
		
		s = str(obj)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_LINE_SIZE, s)

	elseif butId = BUT_EDITOR_POLY_SIDES
		
		s = str(obj)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_POLY_SIZE, s)

	elseif butId = BUT_EDITOR_TEXT_FONT
		
		s = cdGetObjVarVals(OBJ_VAR_FONT, str(obj), false)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_TEXT_FONT, s)

	elseif butId = BUT_EDITOR_TEXT_SIZE
		
		s = str(obj)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_TEXT_SIZE, s)

	elseif butId = BUT_EDITOR_TEXT_EDIT
		
		s = ma.passedStrs[obj]
		ma.passedStrs.remove(obj)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_TEXT_EDIT, s)

	elseif butId = BUT_EDITOR_IMAGE

		cdShowEditLibrary(CD_SUBMODE_EDIT_EDITOR_IMAGE)

	elseif butId = BUT_EDITOR_GRID_ROWS
		
		s = str(obj)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_GRID_ROWS, s)

	elseif butId = BUT_EDITOR_GRID_COLS
		
		s = str(obj)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_GRID_COLS, s)

	elseif butId = BUT_EDITOR_GRID_WIDTH
		
		s = str(obj)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_GRID_WIDTH, s)

	elseif butId = BUT_EDITOR_GRID_HEIGHT
		
		s = str(obj)
		cdShowEditMode(CD_SUBMODE_EDIT_EDITOR_GRID_HEIGHT, s)

	elseif butId = BUT_EDITOR_SAVE
		
		oldImg = ma.things[cd.edi.thingIdx].imgs[cd.edi.frameIdx].img
		img = obj						
		ma.things[cd.edi.thingIdx].imgs[cd.edi.frameIdx].img = img			
		ldSaveThingImage(cd.appIdx, cd.edi.thingIdx, cd.edi.frameIdx)
		cddeletecmd(ma.things[cd.edi.thingIdx].imgs[cd.edi.frameIdx].cmd)
		ma.things[cd.edi.thingIdx].imgs[cd.edi.frameIdx].cmd = 0			
		cddeletecmd(ma.things[cd.edi.thingIdx].cmd)
		ma.things[cd.edi.thingIdx].cmd = 0			
		thingId = ma.things[cd.edi.thingIdx].id
		//cdHideEditImage()
		cdSetSpritesVisible(true, 0)
		cdSetSprite(thingId)
		
	elseif butId = BUT_DESIGN_TEXT_COL

		cdShowEditColor(CD_SUBMODE_EDIT_DESIGN_TEXT_COL, ma.vars[obj].v.textCol)

	elseif butId = BUT_DESIGN_TITLE_ALIGN
		
		s = cdGetObjVarVals(OBJ_VAR_TITLE_ALIGN, str(ma.vars[obj].v.titleAlign), false)
		cdShowEditMode(CD_SUBMODE_EDIT_DESIGN_TITLE_ALIGN, s)

	elseif butId = BUT_DESIGN_TEXT_ALIGN

		s = cdGetObjVarVals(OBJ_VAR_TEXT_ALIGN, str(ma.vars[obj].v.textAlign), false)
		cdShowEditMode(CD_SUBMODE_EDIT_DESIGN_TEXT_ALIGN, s)

	elseif butId = BUT_DESIGN_GRID_ROWS

		cdShowEditMode(CD_SUBMODE_EDIT_SETTINGS_GRID_ROWS, str(ld.set.gridRows))

	elseif butId = BUT_DESIGN_GRID_WIDTH

		cdShowEditMode(CD_SUBMODE_EDIT_SETTINGS_GRID_WIDTH, str(ld.set.gridWidth))

	elseif butId = BUT_DESIGN_GRID_COLS

		cdShowEditMode(CD_SUBMODE_EDIT_SETTINGS_GRID_COLS, str(ld.set.gridCols))

	elseif butId = BUT_DESIGN_GRID_HEIGHT

		cdShowEditMode(CD_SUBMODE_EDIT_SETTINGS_GRID_HEIGHT, str(ld.set.gridHeight))
		
	elseif butId = BUT_DESIGN_SCREEN
		
		if WIN_MODE
			
			w = ma.apps[cd.appIdx].screen
			
		else 
			
			if ma.apps[cd.appIdx].status && LD_STATUS_MOB_LAND
				w = 2
			elseif ma.apps[cd.appIdx].status && LD_STATUS_MOB_PORT
				w = 5
			else 
				w = 0
			endif
			
		endif
		
		s = cdGetObjVarVals(OBJ_VAR_SCREEN, str(w), false)
		cdShowEditMode(CD_SUBMODE_EDIT_DESIGN_SCREEN, s)

	elseif butId = BUT_DESIGN_GRID_SNAP

		cdSaveSettingsGridSnap()
		OnButtonAction(butId, 0)
		
	elseif butId = BUT_CODER_EDITOR_POS

		cdSaveSettingsEditorPos()
		OnButtonAction(butId, 0)

	elseif butId = BUT_DESIGN_MENU_POS

		cdSaveSettingsDesignPos()
		OnButtonAction(butId, 0)

	elseif butId = BUT_RUNNER_MENU_POS

		cdSaveSettingsRunPos()
		OnButtonAction(butId, 0)
		
	elseif butId = BUT_DESIGN_NAMES

		cdSaveSettingsNames()
		OnButtonAction(butId, 0)
				
	else
		
		OnButtonAction(butId, 0)

	endif
	
endfunction

//-----------------------------------------------------
// Show delete confirm dialog.
//
function cdShowDeleteConfirm()

	local gap as float
	local s as string
	local name as string
	
	gap = co.bs / 2

	if cd.delete.item

		if cd.delete.tab = GRP_APP
			
			s = "project"
			name = ld.libItems[cd.delete.appIdx].name
	
		elseif cd.delete.tab = GRP_SPRITE
			
			s = "library image"
			name = ld.libItems[cd.delete.idx].name
			
		elseif cd.delete.tab = GRP_SOUND
			
			s = "library sound"
			name = ld.libItems[cd.delete.idx].name
			
		elseif cd.delete.tab = GRP_VIDEO
			
			s = "library video"
			name = ld.libItems[cd.delete.idx].name
			
		endif
			
	else 
			
		if cd.delete.tab = GRP_APP
			
			s = "project"
			name = ma.apps[cd.delete.appIdx].name
	
		elseif cd.delete.tab = GRP_SPRITE
			
			s = "sprite"
			name = ma.things[cd.delete.idx].name
			
		elseif cd.delete.tab = GRP_FRAME
			
			s = "frame"
			name = str(cd.delete.idx2 + 1) // ma.things[cd.delete.idx].imgs[cd.delete.idx2].id
	
		elseif cd.delete.tab = GRP_SOUND
			
			s = "sound"
			name = ma.sounds[cd.delete.idx].name
			
		elseif cd.delete.tab = GRP_VIDEO
			
			s = "video"
			name = ma.videos[cd.delete.idx].name
			
		elseif cd.delete.tab = GRP_VAR

			if cd.delete.idx2 = -999999

				s = "all values from this list"
				name = ""
				
			elseif cd.delete.idx2 > -1
				
				s = "list item"
				name = ma.vars[cd.delete.idx].list[cd.delete.idx2].value
				
				if ma.vars[cd.delete.idx].list[cd.delete.idx2].name <> ""
					name = name + " (" + ma.vars[cd.delete.idx].list[cd.delete.idx2].name + ")"
				endif

			else 
				
				//s = "variable"
				if ma.vars[cd.delete.idx].typ = VAR_TYPE_VALUE
					s = "value"
				elseif ma.vars[cd.delete.idx].typ = VAR_TYPE_LIST
					s = "list"
				endif
				
				name = ma.vars[cd.delete.idx].name
					
			endif
			
		endif
		
	endif
					
	s = "Are you sure you want to delete " + s
	
	if name <> ""
		s = s + " '" + name + "'"
	endif

	s = s + "?"
	
	cd.delete.text = guiCreateText(s, 2)
	SetTextMaxWidth(cd.delete.text, co.bs * 4)
	SetTextDepth(cd.delete.text, FRONT_DEPTH - 2)
	coSetTextColor(cd.delete.text, co.black)
							
	cd.delete.yesBut = guiCreateButton("Yes", BUT_BG_NORMAL, "gfx/DoneIcon.png", co.runCol)
	guiSetButtonDepth(cd.delete.yesBut, FRONT_DEPTH - 2)
	cd.delete.noBut = guiCreateButton("No", BUT_BG_NORMAL, "gfx/CancelIcon.png", co.deleteCol)
	guiSetButtonDepth(cd.delete.noBut, FRONT_DEPTH - 2)

	cd.delete.bg = guiCreateBox("delete", gap + GetTextTotalWidth(cd.delete.text) + gap, gap + GetTextTotalHeight(cd.delete.text) + gap + GetSpriteHeight(cd.delete.yesBut.bg) + gap)
	SetSpriteDepth(cd.delete.bg, FRONT_DEPTH)
	cd.delete.shdw = guiCreateBox("deleteshdw", GetSpriteWidth(cd.delete.bg), GetSpriteHeight(cd.delete.bg))
	coSetSpriteColor(cd.delete.shdw, co.black)
	SetSpriteColorAlpha(cd.delete.shdw, 127)
	SetSpriteDepth(cd.delete.shdw, FRONT_DEPTH + 2)

	cdSetAllAlpha(gui.inactiveAlpha)
	
	SetSpritePositionByOffset(cd.delete.bg, co.w2, co.h2)
	SetSpritePositionByOffset(cd.delete.shdw, co.w2 + 8, co.h2 + 8)

	SetTextPosition(cd.delete.text, getspritex(cd.delete.bg) + gap, getspritey(cd.delete.bg) + gap)
		
	guiSetButtonPos(cd.delete.yesBut, GetSpriteX(cd.delete.bg) + gap + GetSpriteWidth(cd.delete.yesBut.bg) / 2, getspritey(cd.delete.bg) + GetSpriteHeight(cd.delete.bg) - getspriteheight(cd.delete.yesBut.bg) / 2 - gap)
	guiSetButtonVisible(cd.delete.yesBut, true)	
	guiSetButtonPos(cd.delete.noBut, GetSpriteX(cd.delete.bg) + getspritewidth(cd.delete.bg) - getspritewidth(cd.delete.noBut.bg) / 2 - gap, getspritey(cd.delete.bg) + GetSpriteHeight(cd.delete.bg) - getspriteheight(cd.delete.noBut.bg) / 2 - gap)
	guiSetButtonVisible(cd.delete.noBut, true)	
	
endfunction

//-----------------------------------------------------
// Play a sound to see what it sounds like.
//
function cdShowSoundPlayer(soundIdx as integer, file as string)

	local gap as float
	
	gap = co.bs / 2
	
	cd.player.idx = soundIdx
	
	cd.player.cmd = cdCreateCmd(CODE_SOUND_BASE)
	cdAddCmdPart(cd.player.cmd, cdCreatePartSound(ma.sounds[soundIdx].id))
	cdSetCmdDepth(cd.player.cmd, FRONT_DEPTH - 2)
								
	cd.player.bg = guiCreateBox("player", cdGetCmdWidth(cd.player.cmd) + gap * 2, co.bs * 3)
	SetSpriteDepth(cd.player.bg, FRONT_DEPTH)
	cd.player.shdw = guiCreateBox("deleteshdw", GetSpriteWidth(cd.player.bg), GetSpriteHeight(cd.player.bg))
	coSetSpriteColor(cd.player.shdw, co.black)
	SetSpriteColorAlpha(cd.player.shdw, 127)
	SetSpriteDepth(cd.player.shdw, FRONT_DEPTH + 2)
		
	cd.player.stopBut = guiCreateButton("stop", BUT_BG_NORMAL, "gfx/StopIcon.png", co.deleteCol)
	guiSetButtonDepth(cd.player.stopBut, FRONT_DEPTH - 2)

	cdSetAllAlpha(gui.inactiveAlpha)
	
	SetSpritePositionByOffset(cd.player.bg, co.w2, co.h2)
	SetSpritePositionByOffset(cd.player.shdw, co.w2 + 8, co.h2 + 8)

	cdSetCmdPos(cd.player.cmd, GetSpriteXByOffset(cd.player.bg) - cdGetCmdWidth(cd.player.cmd) / 2, getspritey(cd.player.bg) + gap)
	cdSetCmdVisible(cd.player.cmd, true)
	
	guiSetButtonPos(cd.player.stopBut, GetSpriteXByOffset(cd.player.bg), getspritey(cd.player.bg) + GetSpriteHeight(cd.player.bg) - getspriteheight(cd.player.stopBut.bg) / 2 - gap)
	guiSetButtonVisible(cd.player.stopBut, true)	
	
	if file <> ""
		cd.player.file = file
	else 
		cd.player.file = ma.apps[cd.appIdx].folder + LD_SOUND_DIR + "/" + ma.sounds[soundIdx].file
	endif
	
	cd.player.loadId = LoadSound(cd.player.file)
	
	if cd.player.loadId
		cd.player.playId = PlaySound(cd.player.loadId)
	endif
	
	cd.player.typ = CODE_SOUND_BASE

endfunction

//-----------------------------------------------------
// Play a video to see what it looks like.
//
function cdShowVideoPlayer(videoIdx as integer, file as string)

	local gap as float
	local w as float
	local h as float
	
	gap = co.bs / 2
	
	cd.player.idx = videoIdx
	
	cd.player.cmd = cdCreateCmd(CODE_VIDEO_BASE)
	cdAddCmdPart(cd.player.cmd, cdCreatePartVideo(ma.videos[videoIdx].id))
	cdSetCmdDepth(cd.player.cmd, FRONT_DEPTH - 2)

	cd.player.stopBut = guiCreateButton("stop", BUT_BG_NORMAL, "gfx/StopIcon.png", co.deleteCol)
	guiSetButtonDepth(cd.player.stopBut, FRONT_DEPTH - 2)

	//cd.player.file = ma.apps[cd.appIdx].folder + LD_VIDEO_DIR + "/" + ma.videos[videoIdx].file
	//cd.player.loadId = LoadVideo(cd.player.file)
	cd.player.loadId = maLoadVideo(cd.appIdx, videoIdx, file)
								
	w = cdGetCmdWidth(cd.player.cmd)
	h = gap + cdGetCmdHeight(cd.player.cmd) + gap + ma.videos[videoIdx].h + gap + getspriteheight(cd.player.stopBut.bg) + gap
	
	if ma.videos[videoIdx].w > w
		w = ma.videos[videoIdx].w
	endif
	
	cd.player.bg = guiCreateBox("player", w + gap * 2, h)
	SetSpriteDepth(cd.player.bg, FRONT_DEPTH)
	cd.player.shdw = guiCreateBox("deleteshdw", GetSpriteWidth(cd.player.bg), GetSpriteHeight(cd.player.bg))
	coSetSpriteColor(cd.player.shdw, co.black)
	SetSpriteColorAlpha(cd.player.shdw, 127)
	SetSpriteDepth(cd.player.shdw, FRONT_DEPTH + 2)
		
	cdSetAllAlpha(gui.inactiveAlpha)
	
	SetSpritePositionByOffset(cd.player.bg, co.w2, co.h2)
	SetSpritePositionByOffset(cd.player.shdw, co.w2 + 8, co.h2 + 8)

	cdSetCmdPos(cd.player.cmd, GetSpriteXByOffset(cd.player.bg) - cdGetCmdWidth(cd.player.cmd) / 2, getspritey(cd.player.bg) + gap)
	cdSetCmdVisible(cd.player.cmd, true)
	
	guiSetButtonPos(cd.player.stopBut, GetSpriteXByOffset(cd.player.bg), getspritey(cd.player.bg) + GetSpriteHeight(cd.player.bg) - getspriteheight(cd.player.stopBut.bg) / 2 - gap)
	guiSetButtonVisible(cd.player.stopBut, true)	
	
	//cd.player.playId = PlaySound(cd.player.loadId)
	PlayVideo()
	
	cd.player.typ = CODE_VIDEO_BASE

endfunction

//-----------------------------------------------------
// Hide the player.
//
function cdHidePlayer()
	
	if cd.player.typ
		
		if cd.player.playId
			
			if cd.player.typ = CODE_SOUND_BASE				
				StopSoundInstance(cd.player.playId)
			elseif cd.player.typ = CODE_VIDEO_BASE				
				StopVideo()				
			endif

			cd.player.playId = 0
			
		endif
		
		if cd.player.loadId
			
			if cd.player.typ = CODE_SOUND_BASE				
				DeleteSound(cd.player.loadId)
			elseif cd.player.typ = CODE_VIDEO_BASE		
				maUnloadVideo(cd.player.idx)
			endif		

			cd.player.loadId = 0
			
		endif
		
		if cd.player.bg
			
			deletesprite(cd.player.bg)
			cd.player.bg = 0
			
		endif

		if cd.player.shdw
			
			deletesprite(cd.player.shdw)
			cd.player.shdw = 0
			
		endif
		
		if cd.player.cmd
			
			cddeletecmd(cd.player.cmd)
			cd.player.cmd = 0
			
		endif
		
		guiDeleteButton(cd.player.stopBut)
		
		cd.player.file = ""
		cd.player.idx = -1
		cd.player.typ = 0
		
		cdSetAllAlpha(255)
		
	endif
	
endfunction

//-----------------------------------------------------
// Hide the dleete dialog.
//
function cdHideDelete()
	
	if cd.delete.tab
				
		if cd.delete.bg
			
			deletesprite(cd.delete.bg)
			cd.delete.bg = 0
			
		endif

		if cd.delete.shdw
			
			deletesprite(cd.delete.shdw)
			cd.delete.shdw = 0
			
		endif

		if cd.delete.text
			
			deletetext(cd.delete.text)
			cd.delete.text = 0
			
		endif
				
		guiDeleteButton(cd.delete.yesBut)
		guiDeleteButton(cd.delete.noBut)
		
		cd.delete.tab = 0
		
		cdSetAllAlpha(255)
		
	endif
	
endfunction

//-----------------------------------------------------
// Save the auto run button settings.
//
function cdSaveSettingsAutoRun()

	if not ld.set.autoRun
		
		ld.set.autoRun = true
		ldSaveSettings()
		
	else

		ld.set.autoRun = false
		ldSaveSettings()

	endif

endfunction

//-----------------------------------------------------
// Save the auto naming value.
//
function cdSaveSettingsAutoNaming()

	local grpTab as integer
	
	if not ld.set.quickNaming
		
		ld.set.quickNaming = true
		ldSaveSettings()
		
	else

		ld.set.quickNaming = false
		ldSaveSettings()

	endif
	
endfunction

//-----------------------------------------------------
// Set the naming button in settings to the current setting value.
//
function cdSetSettingsAutoNamingButton()

	local idx as integer

	idx = guiFindBarButtonById(cd.morebar, BUT_CODER_AUTO_NAMING)

	if ld.set.quickNaming
		guiSetButtonIcon2(cd.morebar.buts[idx], gui.onImg)		
	else
		guiSetButtonIcon2(cd.morebar.buts[idx], gui.offImg)
	endif

endfunction

//-----------------------------------------------------
// Save the libraries value.
//
function cdSaveSettingsLibraries()

	local saved as integer

	saved = false
	
	if not ld.set.libsOn
		
		ld.set.libsOn = true
		saved = true
		
	else

		ld.set.libsOn = false
		saved = true

	endif

	if saved

		ldSaveSettings()
		
		if cd.mainTab = CD_TAB_APP and cd.fileTab = CD_FILE_TAB_LIBRARY //and cd.appFolder = ""

			cd.subMode = CD_SUBMODE_PRELOAD
			cdSetTabVisible("reloadAppFolder", true)
			
		endif

	endif
	
endfunction

//-----------------------------------------------------
// Set the libraries button in settings to the current setting value.
//
function cdSetSettingsLibrariesButton()

	local idx as integer

	idx = guiFindBarButtonById(cd.morebar, BUT_CODER_LIBRARIES)

	if ld.set.libsOn
		guiSetButtonIcon2(cd.morebar.buts[idx], gui.onImg)		
	else
		guiSetButtonIcon2(cd.morebar.buts[idx], gui.offImg)
	endif

endfunction

//-----------------------------------------------------
// Save the cmd size value.
//
function cdSaveSettingsCmdSize()

	local grpTab as integer
	
	inc ld.set.cmdSize

	if ld.set.cmdSize >= LD_CMD_SIZE_MAX
		ld.set.cmdSize = 0
	endif

	ldSaveSettings()

	cdResizeSelCmds()

	cd.oldCmdSize = ld.set.cmdSize
	
endfunction

//-----------------------------------------------------
// Save the help size value.
//
function cdSaveSettingsHelpSize()

	local grpTab as integer
	
	inc ld.set.helpSize

	if ld.set.helpSize >= LD_HELP_SIZE_MAX
		ld.set.helpSize = 0
	endif

	ldSaveSettings()

	cdClearDetailedHelp(true)
	cdUpdateHelp()
	
endfunction

//-----------------------------------------------------
// Set the cmd size settings to the current setting value.
//
function cdSetSettingsCmdSizeButton()

	local idx as integer
	local s as string

	idx = guiFindBarButtonById(cd.morebar, BUT_CODER_CMD_SIZE)
	SetSpriteScaleByOffset(cd.moreBar.buts[idx].icon, cd.cmdScales[ld.set.cmdSize], cd.cmdScales[ld.set.cmdSize])

	s = "cmds (" + str(ld.set.cmdSize + 1) + ")"
	SetTextString(cd.moreBar.buts[idx].text, s)
	
endfunction

//-----------------------------------------------------
// Set the cmd size settings to the current setting value.
//
function cdSetSettingsHelpSizeButton()

	local idx as integer
	local s as string

	idx = guiFindBarButtonById(cd.morebar, BUT_CODER_HELP_SIZE)
	SetSpriteScaleByOffset(cd.moreBar.buts[idx].icon, cd.cmdScales[ld.set.helpSize], cd.cmdScales[ld.set.helpSize])

	s = "help (" + str(ld.set.helpSize + 1) + ")"
	SetTextString(cd.moreBar.buts[idx].text, s)
	
endfunction

//-----------------------------------------------------
// Save the snap to grid value.
//
function cdSaveSettingsGridSnap()

	if not ld.set.snapToGrid
		
		ld.set.snapToGrid = true
		ldSaveSettings()
		
	else

		ld.set.snapToGrid = false
		ldSaveSettings()

	endif

endfunction

//-----------------------------------------------------
// Save the names setting.
//
function cdSaveSettingsNames()

	if not ld.set.showLayoutNames
		
		ld.set.showLayoutNames = true
		ldSaveSettings()
		
	else

		ld.set.showLayoutNames = false
		ldSaveSettings()

	endif

endfunction

//-----------------------------------------------------
// Save the editpr pos.
//
function cdSaveSettingsEditorPos()

	if ld.set.editorButPos = DIR_NE		
		ld.set.editorButPos = DIR_SE
	elseif ld.set.editorButPos = DIR_SE		
		ld.set.editorButPos = DIR_SW
	elseif ld.set.editorButPos = DIR_SW		
		ld.set.editorButPos = DIR_NW
	elseif ld.set.editorButPos = DIR_NW		
		ld.set.editorButPos = DIR_NE
	endif

	ldSaveSettings()

endfunction

//-----------------------------------------------------
// Save the design pos.
//
function cdSaveSettingsDesignPos()

	if ld.set.designButPos = DIR_NE		
		ld.set.designButPos = DIR_SE
	elseif ld.set.designButPos = DIR_SE		
		ld.set.designButPos = DIR_SW
	elseif ld.set.designButPos = DIR_SW		
		ld.set.designButPos = DIR_NW
	elseif ld.set.designButPos = DIR_NW		
		ld.set.designButPos = DIR_NE
	endif

	ldSaveSettings()

endfunction

//-----------------------------------------------------
// Save the names setting.
//
function cdSaveSettingsRunPos()

	if ld.set.runButPos = DIR_NE		
		ld.set.runButPos = DIR_SE
	elseif ld.set.runButPos = DIR_SE		
		ld.set.runButPos = DIR_SW
	elseif ld.set.runButPos = DIR_SW		
		ld.set.runButPos = DIR_NW
	elseif ld.set.runButPos = DIR_NW		
		ld.set.runButPos = DIR_NE
	endif

	ldSaveSettings()

endfunction

//-----------------------------------------------------
// Show the sprite library for selection.
//
function cdShowEditLibrary(subMode as integer)

	local idx as integer

	cd.submode = subMode

	//if submode <> CD_SUBMODE_EDIT_EDITOR_IMAGE
	//	cdShowEditImageData(false)
	//endif
	
	//guiSetBarAlpha(cd.edimg.toolbar, gui.inactiveAlpha)
	
	//coSetSpriteColor(cd.libraryBut.bg, cd.tabCols[CD_TAB_SPRITE_LIBRARY])
	guiSetButtonBgCol(cd.libraryBut, cd.tabCols[CD_TAB_SPRITE_LIBRARY])
	guiSetButtonAlpha(cd.libraryBut, 255)
	guiSetButtonVisible(cd.libraryBut, true)

	guiSetPanelColor(cd.loadPanel, cd.tabCols[CD_TAB_SPRITE_LIBRARY], cd.tabbarCols[CD_TAB_SPRITE_LIBRARY], cd.tabpipCols[CD_TAB_SPRITE_LIBRARY])

	idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
	guiSetButtonText(cd.toolBar.buts[idx], "cancel")
	guiSetButtonIcon(cd.toolBar.buts[idx], cd.cancelImg)
	//coSetSpriteColor(cd.toolBar.buts[idx].bg, co.deleteCol)
	guiSetbuttonBgCol(cd.toolBar.buts[idx], co.deleteCol)
	guiSetButtonVisible(cd.toolBar.buts[idx], true)
	
	if subMode = CD_SUBMODE_EDIT_EDITOR_IMAGE
		
		guiSetPanelDepth(cd.loadPanel, FRONT_DEPTH)
		guiSetButtonDepth(cd.libraryBut, FRONT_DEPTH - 10)
		cdLoadSpriteItems(CD_FILE_TAB_LIBRARY) // Force load.
				
	else		

		guiSetPanelDepth(cd.loadPanel, cd.panelDepth - 2)
		guiSetButtonDepth(cd.libraryBut, cd.panelDepth)
		cdLoadSpriteItems(cd.fileTab)
						
	endif

	cdShowLibItems(ld.libItems)
		
	guiSetPanelVisible(cd.loadPanel, true)

endfunction

//-----------------------------------------------------
// Show the color selector panel for editing.
//
function cdShowEditColor(subMode as integer, col as integer)

	local s as string
	local title as string
	//local img as integer

	//cd.submode = CD_SUBMODE_EDIT_IMAGE_COLOR
	cd.submode = subMode
	
	//guiSetBarAlpha(cd.edimg.toolbar, gui.inactiveAlpha)
	cd.editMode = CD_EDIT_COLOR

	cd.editBut = guiCreateButton("", BUT_BG_NORMAL, "", co.white)
	guiSetButtonIcon(cd.editBut, cd.transImg)
	guiSetButtonIcon2(cd.editBut, co.pixImg)
	SetSpriteScale(cd.editBut.icon2, 96, 96)
	//coSetSpriteColor(cd.editBut.icon, cd.edimg.col)
	//col = coSetColorAlpha(col, 64)
	coSetSpriteColor(cd.editBut.icon2, col)
	
	//s = coColorToHex(cd.edimg.col)	
	s = coColorToHex(col)	
	cdSetKeySet(CD_KEYSET_COLOR)
	cdSetKeyboardVisible(CD_KBD_COLOR)
	cdHideKeyPresses()
	cdShowColorEditor(true)
	//cd.editOrigCol = cd.edimg.col
	cd.editOrigCol = col

	//title = "Enter a color as hex #rrggbb or decimal rrrgggbbb, or select below"
	//cdSetEditTitle(title)
	cdSetEditPosition()
	cd.prevEditText = s
	cdSetEditBlankAllowed(true)
	cdSetColorEditText(s)
	cdSetEditCursor(-1)
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
//
function cdHideEditResize()

	local i as integer
	local img as integer

	cdHideEditResizeSpr()

	// Clean up.
	if cd.edi.origSpr

		//img = GetSpriteImageID(cd.edimg.origSpr)
		deletesprite(cd.edi.origSpr)
		//deleteimage(img)
		cd.edi.origSpr = 0
		
	endif

	if cd.edi.resizedArrow.length > -1
		
		for i = 0 to cd.edi.resizedArrow.length
			guiDeleteButton(cd.edi.resizedArrow[i])
		next

		cd.edi.resizedArrow.length = -1

	endif

	if cd.edi.resizedBorderSpr.length > -1

		for i = 0 to cd.edi.resizedBorderSpr.length
			deletesprite(cd.edi.resizedBorderSpr[i])
		next

		cd.edi.resizedBorderSpr.length = -1

	endif
	
endfunction

//-----------------------------------------------------
// Show the edit text panel with an image to resize.
// subMode = CD_SUBMODE_EDIT_...
// title is obvious
// s = starting value.
//
function cdShowEditResize(butId as integer, obj as integer)

	local keySet as integer
	local kbd as integer
	local title as string
	local b as float
	local s as float
	local w as float
	local h as float
	local x as float
	local y as float
	local xx as float
	local yy as float
	local spr as integer
	local depth as integer
	local col as integer
	local size as float
	local i as integer

	if butId = BUT_EDITOR_RESIZE

		cd.edi.origSpr = obj
		cd.submode = CD_SUBMODE_EDIT_EDITOR_RESIZE
/*		
	else

		if cd.edimg.undos.length = -1
			exitfunction
		endif

		cd.edimg.origSpr = clonesprite(cd.edimg.undos[0].spr)
		cd.submode = CD_SUBMODE_EDIT_RESIZE
*/
	endif
	
	cd.edi.resizedArrowIdx = -1 // Centre.
	
	cd.editMode = CD_EDIT_TEXT
				
	keySet = CD_KEYRULE_INTEGER
	kbd = CD_KBD_NUMONLY
		
	cdSetAllAlpha(gui.inactiveAlpha)
	//guiSetBarAlpha(cd.edimg.toolbar, gui.inactiveAlpha)

	cdSetKeySet(keySet)
	cdSetKeyboardVisible(kbd)
	cdHideKeyboardKey(kbd, "-")	

	cdSetEditPosition()
	cd.prevEditText = str(w) + "," + str(h)
	cdSetResizeEditText()	
	cdSetEditBlankAllowed(true)
	cdSetEditCursor(-1)
	cdSetEditVisible(true)

	cdShowEditResizeSpr()
	
endfunction

//-----------------------------------------------------
// Hide the edit resize sprs.
//
function cdHideEditResizeSpr()

	local img as integer
	local i as integer

	// Clean up.
	if cd.edi.resizedSpr

		img = GetSpriteImageID(cd.edi.resizedSpr)
		deletesprite(cd.edi.resizedSpr)
		deleteimage(img)
		cd.edi.resizedSpr = 0
		
	endif

	// Clean up.
	if cd.edi.resizedSpr2

		img = GetSpriteImageID(cd.edi.resizedSpr2)
		deletesprite(cd.edi.resizedSpr2)
		deleteimage(img)
		cd.edi.resizedSpr2 = 0
		
	endif

	if cd.edi.resizedBorderSpr.length > -1

		for i = 0 to cd.edi.resizedBorderSpr.length
			deletesprite(cd.edi.resizedBorderSpr[i])
		next

		cd.edi.resizedBorderSpr.length = -1

	endif

endfunction

//-----------------------------------------------------
// Update the resize spr and border.
//
function cdShowEditResizeSpr()

	local b as float
	local s as float
	local x as float
	local y as float
	local w as float
	local h as float
	local ox as float
	local oy as float
	local ow as float
	local oh as float
	local nx as float
	local ny as float
	local nw as float
	local nh as float
	local tx as float
	local ty as float
	local dx as float
	local dy as float
	local spr as integer
	local depth as integer
	local col as integer
	local size as float
	local i as integer
	local img as integer
	local origMb as MemBlock
	local resizedMb as MemBlock
	local viewMb as MemBlock
	local tmpMb as MemBlock
	local arrTitle as string[]
	local arrPosX as integer[]
	local arrPosY as integer[]
	local arrAng as float[]
	local but as Button
	local dir as integer

	// Get the top-left of the grid.
	col = co.lightblue[3]
	col = coSetColorAlpha(col, 127)
	size = 8	
	b = co.bs * 4
	s = 1.0

	cdHideEditResizeSpr()

	// First scale the actual image to fit the max size.
	ow = GetSpriteWidth(cd.edi.origSpr)
	oh = GetSpriteHeight(cd.edi.origSpr)
	nw = cdGetResizeEditText(0)
	nh = cdGetResizeEditText(1)

	// Calc size of the largest of the original and resize for viewing purposes.
	if nw > ow
		w = nw
	else
		w = ow
	endif

	if nh > oh
		h = nh
	else
		h = oh
	endif
	
	dx = 0 // 8
	dy = 0 // 8

	// Create a space for largest of the original and resied.
	coMemCreate(viewMb, w + dx * 2, h + dy * 2)
	coMemSetBlend(viewMb, false)
	
	// Grab the original so we can grab the resized part.
	coMemFromImage(GetSpriteImageID(cd.edi.origSpr), origMb)

	// Grab the bit of the original image that we are keeping.
	dir = cdGetResizedDir()
	
	if dir && DIR_W and dir && DIR_N
		
		coMemGrab(origMb, tmpMb, 0, 0, nw, nh)
		tx = 0
		ty = 0
		ox = 0
		oy = 0
		nx = 0
		ny = 0
		
	elseif dir && DIR_E and dir && DIR_N
		
		coMemGrab(origMb, tmpMb, origMb.w - nw, 0, nw, nh)
		tx = w - tmpMb.w
		ty = 0
		ox = w - origMb.w
		oy = 0
		nx = w - nw
		ny = 0
		
	elseif dir && DIR_W and dir && DIR_S
		
		coMemGrab(origMb, tmpMb, 0, origMb.h - nh, nw, nh)		
		tx = 0
		ty = h - tmpMb.h
		ox = 0
		oy = h - origMb.h
		nx = 0
		ny = h - nh
		
	elseif dir && DIR_E and dir && DIR_S

		coMemGrab(origMb, tmpMb, origMb.w - nw, origMb.h - nh, nw, nh)		
		tx = w - tmpMb.w
		ty = h - tmpMb.h
		ox = w - origMb.w
		oy = h - origMb.h
		nx = w - nw
		ny = h - nh

	elseif dir && DIR_N
		
		coMemGrab(origMb, tmpMb, origMb.w / 2 - nw / 2, 0, nw, nh)		
		tx = w / 2 - tmpMb.w / 2
		ty = 0
		ox = w / 2 - origMb.w / 2
		oy = 0
		nx = w / 2 - nw / 2
		ny = 0

	elseif dir && DIR_S

		coMemGrab(origMb, tmpMb, origMb.w / 2 - nw / 2, origMb.h - nh, nw, nh)		
		tx = w / 2 - tmpMb.w / 2
		ty = h - tmpMb.h
		ox = w / 2 - origMb.w / 2
		oy = h - origMb.h
		nx = w / 2 - nw / 2
		ny = h - nh

	elseif dir && DIR_W
		
		coMemGrab(origMb, tmpMb, 0, origMb.h / 2 - nh / 2, nw, nh)		
		tx = 0
		ty = h / 2 - tmpMb.h / 2
		ox = 0
		oy = h / 2 - origMb.h / 2
		nx = 0
		ny = h / 2 - nh / 2

	elseif dir && DIR_E

		coMemGrab(origMb, tmpMb, origMb.w - nw, origMb.h / 2 - nh / 2, nw, nh)		
		tx = w - tmpMb.w
		ty = h / 2 - tmpMb.h / 2
		ox = w - origMb.w
		oy = h / 2 - origMb.h / 2
		nx = w - nw
		ny = h / 2 - nh / 2

	else // Centre.

		coMemGrab(origMb, tmpMb, origMb.w / 2 - nw / 2, origMb.h / 2 - nh / 2, nw, nh)		
		tx = w / 2 - tmpMb.w / 2
		ty = h / 2 - tmpMb.h / 2
		ox = w / 2 - origMb.w / 2
		oy = h / 2 - origMb.h / 2
		nx = w / 2 - nw / 2
		ny = h / 2 - nh / 2

	endif	

	depth = GetSpriteDepth(cd.keyPanel.panel)
	x = GetSpriteXByOffset(cd.keyPanel.panel)
	y = GetSpriteYByOffset(cd.keyPanel.panel) + co.bs * 2 - co.bs / 8

	// Paste it into the visible area.
	coMemPaste(origMb, viewMb, ox + dx, oy + dy) // TODO: Make transparent.
	coMemApplyAlphaWH(viewMb, 0, 0, viewMb.w, viewMb.h, -127)
	coMemDelete(origMb)	

	coMemPaste(tmpMb, viewMb, tx + dx, ty + dy)
	coMemDelete(tmpMb)	

	// Save the resizes image.
	coMemGrab(viewMb, tmpMb, nx + dx, ny + dy, nw, nh)		
	img = coMemToImage(tmpMb)
	coMemDelete(tmpMb)	
	cd.edi.resizedSpr = coCreateSprite("resizedSpr", img)
	
	//coMemSetBlend(viewMb, true)
	//coMemDrawRectWH(viewMb, nx, ny, nw + dx * 2, nh + dy * 2, col, dx)
	
	img = coMemToImage(viewMb)
	SetImageMinFilter(img, 0)
	SetImageMagFilter(img, 0)		
	cd.edi.resizedSpr2 = coCreateSprite("resized2Spr", img) // The display sprite.

	SetSpriteVisible(cd.edi.origSpr, false)
	SetSpriteVisible(cd.edi.resizedSpr, false)

	s = 1.0
	
	if h > w 
		//if h > b
			s = b / h
		//endif
	else
		//if w > b
			s = b / w
		//endif
	endif
	
	//SetSpriteColorAlpha(cd.edimg.resizedSpr, 127)
	SetSpriteScale(cd.edi.resizedSpr2, s, s)
	SetSpriteDepth(cd.edi.resizedSpr2, depth - 2)
	SetSpritePositionByOffset(cd.edi.resizedSpr2, x, y)
	SetSpriteVisible(cd.edi.resizedSpr2, true)

	dx = 8
	dy = 8
//colog("s=" + str(s) + ", nx=" + str(nx) + ", ny=" + str(ny) + ", nw=" + str(nw) + ", nh=" + str(nh) + ", x=" + str(x) + ", y=" + str(y))

	spr = guiCreateBox("resSprT", nw * s + dx * 2, dy)
	coSetSpriteColor(spr, col)
	SetSpriteDepth(spr, depth - 3)
	//SetSpritePosition(spr, getspritex(cd.edimg.resizedSpr2) + nx * s - dx, getspritey(cd.edimg.resizedSpr2) + ny * s - dy)
	SetSpritePosition(spr, getspritex(cd.edi.resizedSpr2) + nx * s - dx, getspritey(cd.edi.resizedSpr2) + ny * s - dy)
	SetSpriteVisible(spr, true)
	cd.edi.resizedBorderSpr.insert(spr)

	spr = guiCreateBox("resSprB", nw * s + dx * 2, dy)
	coSetSpriteColor(spr, col)
	SetSpriteDepth(spr, depth - 3)
	SetSpritePosition(spr, getspritex(cd.edi.resizedSpr2) + nx * s - dx, getspritey(cd.edi.resizedSpr2) + (ny + nh) * s)
	SetSpriteVisible(spr, true)
	cd.edi.resizedBorderSpr.insert(spr)

	//spr = guiCreateBox("resSprL", dx, nh * s + dy * 2)
	spr = guiCreateBox("resSprL", dx, nh * s)
	coSetSpriteColor(spr, col)
	SetSpriteDepth(spr, depth - 3)
	//SetSpritePosition(spr, getspritex(cd.edimg.resizedSpr2) + nx * s - dx, getspritey(cd.edimg.resizedSpr2) + ny * s - dy)
	SetSpritePosition(spr, getspritex(cd.edi.resizedSpr2) + nx * s - dx, getspritey(cd.edi.resizedSpr2) + ny * s)
	SetSpriteVisible(spr, true)
	cd.edi.resizedBorderSpr.insert(spr)

	//spr = guiCreateBox("resSprR", dx, nh * s + dy * 2)
	spr = guiCreateBox("resSprL", dx, nh * s)
	coSetSpriteColor(spr, col)
	SetSpriteDepth(spr, depth - 3)
	//SetSpritePosition(spr, getspritex(cd.edimg.resizedSpr2) + (nx + nw) * s, getspritey(cd.edimg.resizedSpr2) + ny * s - dy)
	SetSpritePosition(spr, getspritex(cd.edi.resizedSpr2) + (nx + nw) * s, getspritey(cd.edi.resizedSpr2) + ny * s)
	SetSpriteVisible(spr, true)
	cd.edi.resizedBorderSpr.insert(spr)
	
	if cd.edi.resizedArrow.length = -1

		arrTitle = ["top-left", "top", "top-right", "right", "bot-right", "bottom", "bot-left", "left"]
		arrPosX = [-1,  0,  1, 1, 1, 0, -1, -1]
		arrPosY = [-1, -1, -1, 0, 1, 1,  1,  0]
		arrAng = [45, 90, 135, 180, 225, 270, 315, 0]

		for i = 0 to arrTitle.length

			but = guiCreateButton(arrTitle[i], BUT_BG_NORMAL, "", co.bluegrey[2])
			but.id = BUT_CODER_EDIT_RESIZE_TL + i
			guiSetButtonIcon(but, cd.backImg)
			SetSpriteAngle(but.icon, arrAng[i])
			guiSetButtonDepth(but, depth - 2)
			guiSetButtonPos(but, x + (b / 2 + co.bs / 2 + co.bs / 8) * arrPosX[i], y + (b / 2 + co.bs / 2 + co.bs / 8) * arrPosY[i])
			cd.edi.resizedArrow.insert(but)
			
		next
		
	endif

endfunction

//-----------------------------------------------------
// Convert the resized button to a dir.
//
function cdGetResizedDir()

	local dir as integer
	local butId as integer
	
	if cd.edi.resizedArrowIdx > -1

		butId = cd.edi.resizedArrow[cd.edi.resizedArrowIdx].id

		if butId = BUT_CODER_EDIT_RESIZE_TL
			dir = DIR_N || DIR_W
		elseif butId = BUT_CODER_EDIT_RESIZE_TP
			dir = DIR_N
		elseif butId = BUT_CODER_EDIT_RESIZE_TR
			dir = DIR_N || DIR_E
		elseif butId = BUT_CODER_EDIT_RESIZE_RT
			dir = DIR_E
		elseif butId = BUT_CODER_EDIT_RESIZE_BR
			dir = DIR_S || DIR_E
		elseif butId = BUT_CODER_EDIT_RESIZE_BT
			dir = DIR_S
		elseif butId = BUT_CODER_EDIT_RESIZE_BL
			dir = DIR_S || DIR_W
		elseif butId = BUT_CODER_EDIT_RESIZE_LT
			dir = DIR_W
		endif
		
	else

		dir = 0

	endif

endfunction dir

//-----------------------------------------------------
// Show the edit text panel.
// subMode = CD_SUBMODE_EDIT_...
// title is obvious
// s = starting value.
//
function cdShowEditMode(subMode as integer, s as string)

	local keySet as integer
	local kbd as integer
	local title as string
	local wholeOnly as integer
	local y as float
	local name as string 
	local acceptVis as integer[1]

	cd.submode = subMode
	wholeOnly = false
	cd.editMode = CD_EDIT_TEXT
	
	acceptVis[0] = true

	if subMode = CD_SUBMODE_EDIT_IMAGE_TEXT or submode = CD_SUBMODE_EDIT_EDITOR_TEXT_EDIT

		kbd = CD_KBD_LOWER
		keySet = CD_KEYSET_ALL
		title = "Enter text"
		
	elseif submode = CD_SUBMODE_EDIT_IMAGE_GRID_ROWS or submode = CD_SUBMODE_EDIT_SETTINGS_GRID_ROWS or submode = CD_SUBMODE_EDIT_EDITOR_GRID_ROWS
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the number of layout view grid rows"
		wholeOnly = true
		
	elseif submode = CD_SUBMODE_EDIT_IMAGE_GRID_COLS or submode = CD_SUBMODE_EDIT_SETTINGS_GRID_COLS or submode = CD_SUBMODE_EDIT_EDITOR_GRID_COLS
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the number of layout view grid columns"
		wholeOnly = true

	elseif submode = CD_SUBMODE_EDIT_EDITOR_GRID_WIDTH or submode = CD_SUBMODE_EDIT_SETTINGS_GRID_WIDTH
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the width of the grid in pixels"
		wholeOnly = true
		
	elseif submode = CD_SUBMODE_EDIT_EDITOR_GRID_HEIGHT or submode = CD_SUBMODE_EDIT_SETTINGS_GRID_HEIGHT
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the height of the grid in pixels"
		wholeOnly = true

	elseif submode = submode = CD_SUBMODE_EDIT_EDITOR_GRID_HEIGHT
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the height of the grid in pixels"
		wholeOnly = true

	elseif submode = CD_SUBMODE_EDIT_IMAGE_SIZE
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the size of drawing tools (1 to 50)"
		wholeOnly = true

	elseif submode = CD_SUBMODE_EDIT_EDITOR_LINE_SIZE
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the size of drawing tools (1 to 10)"
		wholeOnly = true

	elseif submode = CD_SUBMODE_EDIT_EDITOR_POLY_SIZE
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the number of polygon sides (3 to 20)"
		wholeOnly = true

	elseif submode = CD_SUBMODE_EDIT_IMAGE_TEXT_SIZE or submode = CD_SUBMODE_EDIT_EDITOR_TEXT_SIZE
		
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the size of text font (" + str(LD_TEXT_SIZE_MIN) + " to " + str(LD_TEXT_SIZE_MAX) + ")"
		wholeOnly = true

	elseif submode = CD_SUBMODE_EDIT_EDITOR_TEXT_FONT

		cd.editMode = CD_EDIT_TAGS
		title = "Select the font for the text"
		name = OBJ_VAR_FONT // "font"

	elseif submode = CD_SUBMODE_EDIT_DESIGN_TITLE_POS

		cd.editMode = CD_EDIT_TAGS
		title = "Select the position of the variable name"
		name = OBJ_VAR_EDGE // "edge"

	elseif submode = CD_SUBMODE_EDIT_DESIGN_TITLE_FONT_SIZE

		//cd.editMode = CD_EDIT_TAGS
		//title = "Select the font size for the variable name"
		//name = OBJ_VAR_FONT_SIZE // "font"
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the size of variable name font (" + str(LD_TEXT_SIZE_MIN) + " to " + str(LD_TEXT_SIZE_MAX) + ")"
		wholeOnly = true

	elseif submode = CD_SUBMODE_EDIT_DESIGN_TITLE_FONT

		cd.editMode = CD_EDIT_TAGS
		title = "Select the font for the variable name"
		name = OBJ_VAR_FONT // "font"

	elseif submode = CD_SUBMODE_EDIT_DESIGN_TEXT_FONT_SIZE

		//cd.editMode = CD_EDIT_TAGS
		//title = "Select the font size for the variable value"
		//name = OBJ_VAR_FONT_SIZE // "font"
		keySet = CD_KEYRULE_INTEGER
		kbd = CD_KBD_NUMONLY
		title = "Enter the size of variable value font (" + str(LD_TEXT_SIZE_MIN) + " to " + str(LD_TEXT_SIZE_MAX) + ")"
		wholeOnly = true

	elseif submode = CD_SUBMODE_EDIT_DESIGN_TEXT_FONT

		cd.editMode = CD_EDIT_TAGS
		title = "Select the font for the variable value"
		name = OBJ_VAR_FONT // "font"

	elseif submode = CD_SUBMODE_EDIT_DESIGN_TITLE_ALIGN

		cd.editMode = CD_EDIT_TAGS
		title = "Select the text alignment of the variable name"
		name = OBJ_VAR_TITLE_ALIGN // "align"

	elseif submode = CD_SUBMODE_EDIT_DESIGN_TEXT_ALIGN

		cd.editMode = CD_EDIT_TAGS
		title = "Select the text alignment of the variable value"
		name = OBJ_VAR_TEXT_ALIGN // "align"

	elseif submode = CD_SUBMODE_EDIT_DESIGN_SCREEN

		cd.editMode = CD_EDIT_TAGS
		title = "Select the runtime screen resolution W x H"
		name = OBJ_VAR_SCREEN // "align"

	endif
		
	cdSetAllAlpha(gui.inactiveAlpha)
	//guiSetBarAlpha(cd.edimg.toolbar, gui.inactiveAlpha)

/* don't need this changed way design shows screen size.
	if ma.view = VIEW_DESIGNER // Calling from designer.
		if getspritex(cd.keypanel.panel) + getspritewidth(cd.keypanel.panel) > de.w
			guiSetPanelPos(cd.keyPanel, de.w - getspritewidth(cd.keypanel.panel), cd.keypanely)
		endif
	endif
*/

	if cd.editMode = CD_EDIT_TEXT
		
		cdSetKeySet(keySet)
		cdSetKeyboardVisible(kbd)

		if wholeOnly
			cdHideKeyboardKey(kbd, "-")
		endif

		cd.prevEditText = s		
		cdSetEditPosition()
		cdSetEditText(s)
		cdSetEditBlankAllowed(true)
		cdSetEditCursor(-1)

	elseif cd.editMode = CD_EDIT_TAGS

		cdSetKeyboardVisible(-1)
		y = cdSetEditPosition()
		y = cdShowObjEditor(name, s, y, acceptVis)
			
	//cdSetEditPosition()

	endif
	
	cdSetEditTitle(title)	
	cdSetEditVisible(true)
	
	if not acceptVis[0]
		guiSetButtonActive(cd.acceptBut, false)
	endif

endfunction

//-----------------------------------------------------
// Show an image for editing or viewing.
//
function cdShowEditImage(thingIdx as integer, frameIdx as integer, edit as integer)

	//
	// New image editor.
	//
	
	local img as integer

	cd.edi.thingIdx = thingIdx
	cd.edi.frameIdx = frameIdx
	
	if thingIdx = -1 // From lib
		
		img = LoadImage(ld.libItems[frameIdx].file)
		
	else // Frame.
		
		ldLoadThingImage(cd.appIdx, thingIdx, frameIdx, LD_MODE_IMAGE)	
		img = ma.things[thingIdx].imgs[frameIdx].img
				
	endif

	// Activate the image editor.
	if edit
		OnButtonAction(BUT_CODER_EDIT_IMAGE, img)	
	else 
		OnButtonAction(BUT_CODER_VIEW_IMAGE, img)	
	endif	
			
endfunction

//-----------------------------------------------------
// Remove an app with confirm.
//
function cdRemoveAppConfirm(appIdx as integer, delete as integer)
	
	cd.delete.appIdx = appIdx
	cd.delete.tab = GRP_APP
	cd.delete.idx = -1
	cd.delete.idx2 = -1
	cd.delete.item = false
	
	cdShowDeleteConfirm()

endfunction

//-----------------------------------------------------
// Remove an app.
//
function cdRemoveApp(appIdx as integer, delete as integer)

	if appIdx > -1

		if delete
			
			cdDeleteApp(appIdx)
			ldDeleteApp(ma.apps[appIdx].id)
			ma.apps.remove(appIdx)	

		else

			cdClearApp(appIdx)
			
		endif
		
		if cd.appIdx = appIdx
					
			cd.appIdx = -1 // No longer a project loaded.
			cdSetApp("")
			ld.set.prevLoadedAppId = ""
			ldSaveSettings()

		else //if cd.appIdx >= idx
					
			cd.appIdx = maFindAppById(cd.appId) // Fix appIdx.
					
		endif

		cd.subMode = CD_SUBMODE_PRELOAD
		cdSetTabVisible("y", true)

	endif

endfunction

//-----------------------------------------------------
// Remove a frame.
//
function cdRemoveImage(thingIdx as integer, imgIdx as integer)

	if imgIdx > -1 and imgIdx <= ma.things[thingIdx].imgs.length

		//ldDeleteImage(cd.appIdx, ma.things[thingIdx].id, ma.things[thingIdx].imgs[imgIdx])
		ldDeleteImage(cd.appIdx, ma.things[thingIdx].imgs[imgIdx])
		cdDeleteImage(thingIdx, imgIdx)
		
		ma.things[thingIdx].imgs.remove(imgIdx)

		if ma.things[thingIdx].imgs.length > -1
			ma.things[thingIdx].imgIdx = 0
		else 
			ma.things[thingIdx].imgIdx = -1
		endif

		cdSortImages(thingIdx)		
		ldSaveApp(ma.apps[cd.appIdx].id)
		cdSetSprite(ma.things[thingIdx].id)
		cdUpdateImageCmds(thingIdx)		
					
	else

		colog("imgIdx not valid = " + str(imgIdx))
		
	endif
	
endfunction

//-----------------------------------------------------
// Clear a var with a confirm dialog first.
//
function cdClearVarConfirm(tab as integer, appIdx as integer, idx as integer)

	cd.delete.tab = tab
	cd.delete.appIdx = appIdx
	cd.delete.idx = idx
	cd.delete.idx2 = -999999
	cd.delete.item = false
	
	cdShowDeleteConfirm()
	
endfunction

//-----------------------------------------------------
// Remove a thing with a confirm dialog first.
//
function cdRemoveThingConfirm(tab as integer, appIdx as integer, idx as integer, idx2 as integer)

	cd.delete.tab = tab
	cd.delete.appIdx = appIdx
	cd.delete.idx = idx
	cd.delete.idx2 = idx2
	cd.delete.item = false
	
	cdShowDeleteConfirm()
	
endfunction

//-----------------------------------------------------
// Remove an item with a confirm dialog first.
//
function cdRemoveItemConfirm(tab as integer, appIdx as integer, idx as integer)

	cd.delete.tab = tab
	cd.delete.appIdx = appIdx
	cd.delete.idx = idx
	cd.delete.idx2 = -1
	cd.delete.item = true
	
	cdShowDeleteConfirm()
	
endfunction

//-----------------------------------------------------
// Remove a thing.
//
function cdRemoveThing(tab as integer, appIdx as integer, idx as integer, idx2 as integer)

	if tab = GRP_SPRITE
		cdRemoveSprite(appIdx, idx)
	elseif tab = GRP_SOUND
		cdRemoveSound(appIdx, idx)
	elseif tab = GRP_VIDEO
		cdRemoveVideo(appIdx, idx)
	elseif tab = GRP_VAR
		cdRemoveVar(appIdx, idx, idx2)
	endif

endfunction

//-----------------------------------------------------
// Remove a thing.
//
function cdRemoveSprite(appIdx as integer, thingIdx as integer)

	local i as integer
	local idx as integer

	idx = -1
	
	for i = 0 to ma.apps[appIdx].sprites.length

		if ma.apps[appIdx].sprites[i] = thingIdx
			
			idx = i
			exit
			
		endif
		
	next
	
	if idx > -1

		cdReplaceAllImageParts(appIdx, PART_SPRITE, str(thingIdx), "-1")

		ldDeleteSprite(appIdx, ma.things[thingIdx].id)
		cdDeleteSprite(thingIdx)

		ma.apps[appIdx].sprites.remove(idx)	
		ldSaveApp(ma.apps[appIdx].id)

		if appIdx = cd.appIdx
			
			if cd.thingIdx = thingIdx

				cd.thingIdx = -1 // Selected sprite, no longer!
				cdSetSprite("")
						
			else //if cd.thingIdx >= idx

				//thingIdx = cdFindThingById(cd.appIdx, cd.thingId) // Fix thingIdx.
				cd.thingIdx = -1
				cdSetSprite(cd.thingId)
				
			endif

		endif

	endif

endfunction

//-----------------------------------------------------
// Remove a sound.
//
function cdRemoveSound(appIdx as integer, soundIdx as integer)

	local i as integer
	local idx as integer
	local thingidx as integer

	idx = -1
	
	for i = 0 to ma.apps[appIdx].sounds.length

		if ma.apps[appIdx].sounds[i] = soundIdx
			
			idx = i
			exit
			
		endif
		
	next
	
	if idx > -1

		// Clear all cmds that are using this sound.
		for i = 0 to ma.apps[appIdx].sprites.length

			thingIdx = ma.apps[appIdx].sprites[i]
			cdReplaceCodeThings(thingIdx, PART_SOUND_NAME, soundIdx, -1)

		next
		
		ldDeleteSound(appIdx, ma.sounds[soundIdx].id)
		cdDeleteSound(soundIdx)

		ma.apps[appIdx].sounds.remove(idx)	
		ldSaveApp(ma.apps[appIdx].id)

		//cdSetSoundsVisible(true)
		cdSetTabVisible("removesound", true)
		
	endif

endfunction

//-----------------------------------------------------
// Remove a video.
//
function cdRemoveVideo(appIdx as integer, videoIdx as integer)

	local i as integer
	local idx as integer
	local thingIdx as integer

	idx = -1
	
	for i = 0 to ma.apps[appIdx].videos.length

		if ma.apps[appIdx].videos[i] = videoIdx
			
			idx = i
			exit
			
		endif
		
	next
	
	if idx > -1

		// Clear all cmds that are using this sound.
		for i = 0 to ma.apps[appIdx].sprites.length

			thingIdx = ma.apps[appIdx].sprites[i]
			cdReplaceCodeThings(thingIdx, PART_VIDEO_NAME, videoIdx, -1)

		next

		ldDeleteVideo(appIdx, ma.videos[videoIdx].id)
		cdDeleteVideo(videoIdx)

		ma.apps[appIdx].videos.remove(idx)	
		ldSaveApp(ma.apps[appIdx].id)

		//cdSetVideosVisible(true)
		cdSetTabVisible("removevideo", true)

	endif

endfunction

//-----------------------------------------------------
// Remove a var.
//
function cdRemoveVar(appIdx as integer, varIdx as integer, listIdx as integer)

	local i as integer
	local idx as integer

	idx = -1

	if ma.vars[varIdx].thingIdx = -1
		
		for i = 0 to ma.apps[appIdx].vars.length

			if ma.apps[appIdx].vars[i] = varIdx
				
				idx = i
				exit
				
			endif
			
		next

	else

		for i = 0 to ma.things[cd.thingIdx].vars.length

			if ma.things[cd.thingIdx].vars[i] = varIdx
				
				idx = i
				exit
				
			endif
			
		next

	endif
	
	if idx > -1

		if listIdx = -1
			
			// Clear all cmds that are using this var.
			cdReplaceCodeThings(cd.thingIdx, PART_VAR_NAME, varIdx, -1)
	
			cdDeleteVar(varIdx)
	
			if ma.vars[varIdx].thingIdx = -1
				ma.apps[appIdx].vars.remove(idx)
			else
				ma.things[cd.thingIdx].vars.remove(idx)
			endif

		elseif listIdx = -999999
			
			for i = 0 to ma.vars[varIdx].list.length				
				cddeletecmd(ma.vars[varIdx].list[i].cmd)
			next 
			
			ma.vars[varIdx].list.length = -1
			
		else 
			
			if ma.vars[varIdx].list[listIdx].cmd
				cddeletecmd(ma.vars[varIdx].list[listIdx].cmd)
			endif
			
			ma.vars[varIdx].list.remove(listIdx)
			
		endif
		
		maSave()

		//cdSetVideosVisible(true)
		cdSetTabVisible("removevar", true)

	endif

endfunction

//-----------------------------------------------------
// Adjust a var, i.e. promote it.
//
function cdAdjustVar(varIdx as integer)

	local i as integer
	local idx as integer

	idx = -1

	// Shouldn't need this check because can only promote thing var, but just in case.
	if ma.vars[varIdx].thingIdx > -1

		// Delete cmd so it can be recreated.
		cdDeleteCmd(ma.vars[varIdx].cmd)
		ma.vars[varIdx].cmd = 0

		for i = 0 to ma.things[cd.thingIdx].vars.length

			if ma.things[cd.thingIdx].vars[i] = varIdx
				
				idx = i
				exit
				
			endif
			
		next

		// Switch the var from thing to app.
		ma.things[cd.thingIdx].vars.remove(idx)
		ma.vars[varIdx].thingIdx = -1
		
		maInsertVar(ma.apps[cd.appIdx].vars, varIdx)
		maSave()
		
		// Update all cmds that are using this var.
		cdReplaceCodeThings(cd.thingIdx, PART_VAR_NAME, varIdx, varIdx)
		
		//cdSetVideosVisible(true)
		cdSetTabVisible("adjustvar", true)

	endif

endfunction

//-----------------------------------------------------
// Remove a thing.
//
function cdDeleteLibThing(idx as integer)

	local obj as integer
	local libAppIdx as integer
	
	obj = ld.libItems[idx].idx
	cdRemoveThing(cd.thingTab, ld.libItems[idx].appIdx, obj, -1)

	cdClearLibItem(ld.libItems[idx])
	ldDeleteLibItem(idx)
	cdSetTabVisible("deletelibitem", true)

endfunction

//-----------------------------------------------------
// Duplicate an app.
//
function cdDuplicateApp(appIdx as integer)

	if ma.apps[appIdx].loaded

		cd.editIdx = appIdx

		if ld.set.quickNaming
											
			cdSetEditText(ma.apps[appIdx].name)
			cd.subMode = CD_SUBMODE_DUP_APP
			cdEditAccept()

		else
			
			cdNewApp(CD_SUBMODE_DUP_APP)

		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Add the app to the library.
//
function cdAddAppToLib(appIdx as integer)

	if ma.apps[appIdx].loaded

		ma.apps[appIdx].status = ma.apps[appIdx].status || LD_STATUS_LIBRARY
		ldSaveApp(ma.apps[appIdx].id)

		cdRemoveApp(appIdx, false)

		cd.subMode = CD_SUBMODE_PRELOAD
		cdSetTabVisible("addAppLib", true)
		
	endif
	
endfunction

//-----------------------------------------------------
// Add the app to the examples.
//
function cdAddAppToEx(appIdx as integer)

	if ma.apps[appIdx].loaded

		ma.apps[appIdx].status = ma.apps[appIdx].status || LD_STATUS_EXAMPLE
		ma.apps[appIdx].status = ma.apps[appIdx].status || LD_STATUS_LOCKED
		ma.apps[appIdx].id = ldGetNextExId()
		ldSaveAppAlways(ma.apps[appIdx].id) // Override

		//cdRemoveApp(appIdx, false)

		cd.subMode = CD_SUBMODE_PRELOAD
		cdSetTabVisible("addAppLib", true)
		
	endif
	
endfunction

//-----------------------------------------------------
// Add the app to the library.
//
function cdRemAppToLib(appIdx as integer)

	if ma.apps[appIdx].loaded

		ma.apps[appIdx].status = !(!ma.apps[appIdx].status || LD_STATUS_LIBRARY)
		ldSaveApp(ma.apps[appIdx].id)
		
		cd.subMode = CD_SUBMODE_PRELOAD
		cdSetTabVisible("remAppLib", true)

	endif
	
endfunction

//-----------------------------------------------------
// Duplicate an app in the library.
//
function cdDuplicateLibApp(idx as integer)

	local appIdx as integer
	
	appIdx = ld.libItems[idx].appIdx
	cd.editIdx = appIdx

	if ld.set.quickNaming
										
		cdSetEditText(ma.apps[appIdx].name)
		cd.subMode = CD_SUBMODE_DUP_LIB_APP
		cdEditAccept()

	else
		
		cdNewApp(CD_SUBMODE_DUP_LIB_APP)
		
	endif
	
endfunction

//-----------------------------------------------------
// Duplicate a lib thing.
//
function cdDuplicateLibThing(tab as integer, idx as integer)
	
	local s as string
	local title as string
	local i as integer
	local press as CmdPress
	local showCmd as integer
	local name as string

	cd.subMode = CD_SUBMODE_DUP_LIB_THING

	if tab = GRP_SPRITE
		name = "image"
	elseif tab = GRP_SOUND
		name = "sound"
	elseif tab = GRP_VIDEO
		name = "video"
	elseif tab = GRP_VAR
		//name = "variable"
		if ma.vars[idx].typ = VAR_TYPE_VALUE
			name = "value"
		elseif ma.vars[idx].typ = VAR_TYPE_LIST
			name = "list"
		endif
	endif

	title = "Enter a name for the duplicated library " + name
	cdSetKeySet(CD_KEYSET_NAME)
	cdSetKeyboardVisible(CD_KBD_LOWER)

	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif

	//guiSetBarVisible(cd.toolbar, false)
	//guiSetButtonVisible(cd.currThingBut, false)
	cd.editIdx = idx

	if tab = GRP_SPRITE
		s = cdGetUniqueThingName(ld.libItems[idx].appIdx, ld.libItems[idx].name)
	elseif tab = GRP_SOUND
		s = cdGetUniqueSoundName(ld.libItems[idx].appIdx, ld.libItems[idx].name)
	elseif tab = GRP_VIDEO
		s = cdGetUniqueVideoName(ld.libItems[idx].appIdx, ld.libItems[idx].name)
	elseif tab = GRP_VAR
		//if ma.vars[idx].thingIdx > -1
		//	s = cdGetUniqueThingVarName(ma.vars[idx].thingIdx, ld.libItems[idx].name)
		//else 
		//	s = cdGetUniqueAppVarName(ld.libItems[idx].appIdx, ld.libItems[idx].name)
		//endif		
		s = cdGetUniqueVarName(ld.libItems[idx].appIdx, ld.libItems[idx].name)
	endif

	cd.prevEditText = s
	cdSetEditBlankAllowed(false)
	cdSetEditText(s)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// Duplicate a thing from the library.
// idx into libitems structure.
// imgIdx used for dup'ing sprites.
//
function cdDuplicateLibThing2(tab as integer, idx as integer, toName as string)

	local thingIdx as integer

	thingIdx = ld.libItems[idx].idx

	if tab = GRP_SPRITE
		cdDuplicateSprite(thingIdx, -1, ld.libItems[idx].appIdx, toName)
	elseif tab = GRP_SOUND
		cdDuplicateSound(thingIdx, ld.libItems[idx].appIdx, toName)
	elseif tab = GRP_VIDEO
		cdDuplicateVideo(thingIdx, ld.libItems[idx].appIdx, toName)
	elseif tab = GRP_VAR
		cdDuplicateVar(thingIdx, -1, ld.libItems[idx].appIdx, toName)
	endif

	cd.subMode = CD_SUBMODE_PRELOAD
	cdSetFileTabVisible("d", true)
	
endfunction

//-----------------------------------------------------
// Duplicate a thing.
//
function cdDuplicateThing(tab as integer, idx as integer, subIdx as integer)
	
	local s as string
	local title as string
	local i as integer
	local press as CmdPress
	local showCmd as integer
	local name as string

	cd.subMode = CD_SUBMODE_DUP_THING
	cd.editIdx = idx

	//cd.attachCmd = ma.things[idx].cmd
	cd.attachDir = DIR_S
	
	if tab = GRP_SPRITE
		
		name = "sprite"
		cd.editImgIdx = subIdx
		s = cdGetUniqueThingName(cd.appIdx, ma.things[idx].name)
		cd.attachCmd = ma.things[idx].cmd
		
	elseif tab = GRP_SOUND
		
		name = "sound"
		s = cdGetUniqueSoundName(cd.appIdx, ma.sounds[idx].name)
		cd.attachCmd = ma.sounds[idx].cmd
		
	elseif tab = GRP_VIDEO
		
		name = "video"
		s = cdGetUniqueVideoName(cd.appIdx, ma.videos[idx].name)
		
	elseif tab = GRP_VAR
		
		cd.varValueIdx = subIdx

		if cd.varValueIdx > -1

			name = "list item"
			s = ma.vars[idx].list[cd.varValueIdx].value
			cd.attachCmd = ma.vars[idx].list[cd.varValueIdx].cmd

		else

			//name = "variable"
			
			if ma.vars[idx].typ = VAR_TYPE_VALUE
				name = "value"
			elseif ma.vars[idx].typ = VAR_TYPE_LIST
				name = "list"
			endif
							
			//if ma.vars[idx].thingIdx > -1
			//	s = cdGetUniqueThingVarName(ma.vars[idx].thingIdx, ma.vars[idx].name)
			//else 
			//	s = cdGetUniqueAppVarName(cd.appIdx, ma.vars[idx].name)
			//endif 
			
			s = cdGetUniqueVarName(cd.appIdx, ma.vars[idx].name)
			
			cd.attachCmd = ma.vars[idx].cmd

		endif
		
	endif

	cdSetEditText(s)

	if ld.set.quickNaming

		cdEditAccept()
		exitfunction
		
	endif

	title = "Enter a name for the duplicated " + name
	cdSetKeySet(CD_KEYSET_NAME)
	cdSetKeyboardVisible(CD_KBD_LOWER)

	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif

	cd.prevEditText = s
	cdSetEditBlankAllowed(false)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// Duplicate a thing.
// idx into ma.apps structures, i.e. sprites, sounds, etc.
// imgIdx used for dup'ing sprites.
//
function cdDuplicateThing2(tab as integer, idx as integer, subIdx as integer, toName as string)

	if tab = GRP_SPRITE
		cdDuplicateSprite(idx, subIdx, cd.appIdx, toName)
	elseif tab = GRP_SOUND
		cdDuplicateSound(idx, cd.appIdx, toName)
	elseif tab = GRP_VIDEO
		cdDuplicateVideo(idx, cd.appIdx, toName)
	elseif tab = GRP_VAR
		cdDuplicateVar(idx, subIdx, cd.appIdx, toName)
	endif

	cdSetTabVisible("d", true)
	
endfunction

//-----------------------------------------------------
// Duplicate a thing to the library.
//
function cdCopyThingToLib(tab as integer, idx as integer, imgIdx as integer)
	
	local s as string
	local title as string
	local i as integer
	local press as CmdPress
	local showCmd as integer
	local name as string

	cd.subMode = CD_SUBMODE_COPY_THING_TO_LIB

	if tab = GRP_SPRITE
		name = "image"
	elseif tab = GRP_SOUND
		name = "sound"
	elseif tab = GRP_VIDEO
		name = "video"
	elseif tab = GRP_VAR
		//name = "variable"
		if ma.vars[idx].typ = VAR_TYPE_VALUE
			name = "value"
		elseif ma.vars[idx].typ = VAR_TYPE_LIST
			name = "list"
		endif
	endif

	title = "Enter a name for the new library " + name
	cdSetKeySet(CD_KEYSET_NAME)
	cdSetKeyboardVisible(CD_KBD_LOWER)

	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif

	//guiSetBarVisible(cd.toolbar, false)
	//guiSetButtonVisible(cd.currThingBut, false)
	cd.editIdx = idx
	cd.editImgIdx = imgIdx

	if tab = GRP_SPRITE
		s = ma.things[idx].name
	elseif tab = GRP_SOUND
		s = ma.sounds[idx].name
	elseif tab = GRP_VIDEO
		s = ma.videos[idx].name
	elseif tab = GRP_VAR
		s = ma.vars[idx].name
	endif

	cd.prevEditText = s
	cdSetEditBlankAllowed(false)
	cdSetEditText(s)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// Duplicate a thing.
// idx into ma.apps structures, i.e. sprites, sounds, etc.
//
function cdCopyThingToLib2(tab as integer, idx as integer, subIdx as integer, toName as string)

	local apps as integer[]
	local libAppIdx as integer

	apps = maFindAppsByStatus(LD_STATUS_MASTER_LIB)

	if apps.length > -1
		
		libAppIdx = apps[0]
		
		if tab = GRP_SPRITE
			cdDuplicateSprite(idx, subIdx, libAppIdx, toName)		
		elseif tab = GRP_SOUND
			cdDuplicateSound(idx, libAppIdx, toName)
		elseif tab = GRP_VIDEO
			cdDuplicateVideo(idx, libAppIdx, toName)
		elseif tab = GRP_VAR
			cdDuplicateVar(idx, subIdx, libAppIdx, toName)
		endif

		cd.subMode = CD_SUBMODE_PRELOAD
		cdSetFileTabVisible("d", true)

	endif
	
endfunction

//-----------------------------------------------------
// Duplicate a sprite or just the image of a sprite.
// Copy the thing to the the toAppIdx app.
// If thingIdx > -1 and imgIdx > -1, then copying an image as a sprite if toAppIdx <> cd.appIdx, or just dup'ing the image.
// If thingIdx > -1 and imgIdx = -1, then duping a sprite (to same app or another).
//
function cdDuplicateSprite(thingIdx as integer, imgIdx as integer, toAppIdx as integer, toName as string)

	local i as integer
	local newThingIdx as integer
	//local libItem as LibItem
	local name as string
	local imgPath as string
	local idx as integer
	local file as string 

	// Clone sprite or image part.

	// If imgIdx > -1 and we're in the same app, we dup'ing the image, other dup'ing a sprite.
	if imgIdx > -1 and toAppIdx = cd.appIdx

		newThingIdx = thingIdx
		
	else

		newThingIdx = maCloneSprite(thingIdx)

		if toName = ""
			toName = ma.things[thingIdx].name
		endif

		ma.things[newThingIdx].name = cdGetUniqueThingName(toAppIdx, toName)		
		ma.things[newThingIdx].imgs.length = -1

	endif
		

	// Clone images.

	if imgIdx > -1 and toAppIdx = cd.appIdx
	
		//libItem.file = GetImageFilename(ma.things[thingIdx].imgs[imgIdx].img)
		imgPath = ma.apps[cd.appIdx].folder + LD_SPRITE_DIR + "/"
		file = imgPath + ma.things[thingIdx].imgs[imgIdx].id + LD_GFX_FILE_SUFFIX
		cdAddThingImage(toAppIdx, newThingIdx, file, 0, 0)

	else
		
		for i = 0 to ma.things[thingIdx].imgs.length

			//libItem.file = GetImageFilename(ma.things[thingIdx].imgs[i].img)
			imgPath = ma.apps[cd.appIdx].folder + LD_SPRITE_DIR + "/"
			file = imgPath + ma.things[thingIdx].imgs[i].id + LD_GFX_FILE_SUFFIX
			cdAddThingImage(toAppIdx, newThingIdx, file, 0, 0)
			
		next

	endif

	if imgIdx = -1 and toAppIdx <> cd.appIdx
		ma.things[newThingIdx].imgIdx = ma.things[thingIdx].imgIdx
	else
		ma.things[newThingIdx].imgIdx = 0
	endif

	if imgIdx = -1 or toAppIdx <> cd.appIdx

		name = ma.things[newThingIdx].name
		
		// Clone cmds.				
		for i = 0 to ma.things[thingIdx].cmds.length
			
			ma.things[newThingIdx].cmds[i] = cdCloneCmd(ma.things[thingIdx].cmds[i])
			ma.cmds[ma.things[newThingIdx].cmds[i]].root = ma.cmds[ma.things[thingIdx].cmds[i]].root
			cdSetCmdVisible(ma.things[newThingIdx].cmds[i], false)
			
		next

		// Clone vars.		
		for i = 0 to ma.things[thingIdx].vars.length
			
			ma.things[newThingIdx].vars[i] = maCloneVar(ma.things[thingIdx].vars[i], false)
			ma.vars[ma.things[newThingIdx].vars[i]].name = ma.vars[ma.things[thingIdx].vars[i]].name			
			cdReplaceCodeThings(newThingIdx, PART_VAR_NAME, ma.things[thingIdx].vars[i], ma.things[newThingIdx].vars[i])
			
		next

		cdSetCodeTab(ma.things[newThingIdx].cmds, true)
		
		//ma.apps[toAppIdx].sprites.insert(newThingIdx)

		if cd.appIdx = toAppIdx

			idx = -1
			
			for i = 0 to ma.apps[cd.appIdx].sprites.length
				
				if ma.apps[cd.appIdx].sprites[i] = thingIdx
					
					idx = i
					exit
					
				endif
				
			next

			if idx > -1
				
				// Append if at the end.
				if idx = ma.apps[toAppIdx].sprites.length
					ma.apps[toAppIdx].sprites.insert(newThingIdx)
				else
					ma.apps[toAppIdx].sprites.insert(newThingIdx, idx + 1)
				endif

			else

				ma.apps[toAppIdx].sprites.insert(newThingIdx)

			endif
			
		else

			ma.apps[toAppIdx].sprites.insert(newThingIdx)
			
		endif
		
	endif
	
	ldSaveApp(ma.apps[toAppIdx].id)

endfunction

//-----------------------------------------------------
// Duplicate a sound.
//
function cdDuplicateSound(soundIdx as integer, toAppIdx as integer, toName as string)

	local i as integer
	local idx as integer
	local newSoundIdx as integer

	idx = -1
	
	for i = 0 to ma.apps[cd.appIdx].sounds.length

		if ma.apps[cd.appIdx].sounds[i] = soundIdx
			
			idx = i
			exit
			
		endif
		
	next
	
	if idx = -1
		
		colog("Error: Sound to duplicate not found")
		exitfunction
		
	endif

	// Clone main part.
	
	newSoundIdx = maCreateSound("")

	if toName = ""
		toName = ma.sounds[soundIdx].name
	endif
	
	ma.sounds[newSoundIdx].name = cdGetUniqueSoundName(toAppIdx, toName)
	
	ma.sounds[newSoundIdx].file = ma.sounds[soundIdx].file
	ma.sounds[newSoundIdx].ext = ma.sounds[soundIdx].ext
	
	//ma.apps[toAppIdx].sounds.insert(newSoundIdx)

	// Append if at the end.
	if cd.appIdx = toAppIdx
		
		if idx = ma.apps[toAppIdx].sounds.length
			ma.apps[toAppIdx].sounds.insert(newSoundIdx)
		else
			ma.apps[toAppIdx].sounds.insert(newSoundIdx, idx + 1)
		endif

	else

		ma.apps[toAppIdx].sounds.insert(newSoundIdx)

	endif
	
	ldSaveSound(toAppIdx, newSoundIdx)
	ldSaveApp(ma.apps[toAppIdx].id)
	//maSave()

	//cdSetTabVisible("dupSound", true)

endfunction

//-----------------------------------------------------
// Duplicate a sound.
//
function cdDuplicateVideo(videoIdx as integer, toAppIdx as integer, toName as string)

	local i as integer
	local idx as integer
	local newVideoIdx as integer

	idx = -1
	
	for i = 0 to ma.apps[cd.appIdx].videos.length

		if ma.apps[cd.appIdx].videos[i] = videoIdx
			
			idx = i
			exit
			
		endif
		
	next
	
	if idx = -1

		colog("Error: Video to duplicate not found")
		exitfunction

	endif

	// Clone main part.
	
	newVideoIdx = maCreateVideo("")

	if toName = ""
		toName = ma.videos[videoIdx].name
	endif
	
	ma.videos[newVideoIdx].name = cdGetUniqueVideoName(toAppIdx, toName)
	
	ma.videos[newVideoIdx].file = ma.videos[videoIdx].file
	ma.videos[newVideoIdx].ext = ma.videos[videoIdx].ext
	
	//ma.apps[toAppIdx].videos.insert(newVideoIdx)

	// Append if at the end.
	if cd.appIdx = toAppIdx
		
		if idx = ma.apps[toAppIdx].videos.length
			ma.apps[toAppIdx].videos.insert(newVideoIdx)
		else
			ma.apps[toAppIdx].videos.insert(newVideoIdx, idx + 1)
		endif

	else

		ma.apps[toAppIdx].videos.insert(newVideoIdx)

	endif

	ldSaveVideo(toAppIdx, newVideoIdx)
	ldSaveApp(ma.apps[toAppIdx].id)
	//maSave()
	
	//cdSetTabVisible("dupVideo", true)

endfunction

//-----------------------------------------------------
// Duplicate a sound.
//
function cdDuplicateVar(varIdx as integer, varValueIdx as integer, toAppIdx as integer, toName as string)

	local i as integer
	local idx as integer
	local newVarIdx as integer
	local newVarItem as VarItem

	idx = -1

	if ma.vars[varIdx].thingIdx = -1
	
		for i = 0 to ma.apps[cd.appIdx].vars.length

			if ma.apps[cd.appIdx].vars[i] = varIdx
				
				idx = i
				exit
				
			endif
			
		next

		if idx = -1

			colog("Error: Var to duplicate not found on app " + ma.apps[cd.appIdx].name)
			exitfunction

		endif

	elseif cd.appIdx = toAppIdx

		for i = 0 to ma.things[ma.vars[varIdx].thingIdx].vars.length

			if ma.things[ma.vars[varIdx].thingIdx].vars[i] = varIdx
				
				idx = i
				exit
				
			endif
			
		next

		if idx = -1

			colog("Error: Var to duplicate not found on sprite " + ma.things[ma.vars[varIdx].thingIdx].name)
			exitfunction

		endif

	else

		colog("Error: Cannot duplicate sprite var " + ma.things[ma.vars[varIdx].thingIdx].name + " to different app")
		exitfunction 

	endif
	
	// Clone main part.

	if varValueIdx = -1
		
		newVarIdx = maCreateVar(ma.vars[varIdx].typ)

		if toName = ""
			toName = ma.vars[varIdx].name
		endif
		
		//if ma.vars[varIdx].thingIdx = -1
		//	ma.vars[newVarIdx].name = cdGetUniqueAppVarName(toAppIdx, toName)
		//else
		//	ma.vars[newVarIdx].name = cdGetUniqueThingVarName(ma.vars[varIdx].thingIdx, toName)
		//endif
		
		ma.vars[newVarIdx].name = cdGetUniqueVarName(toAppIdx, toName)

		if ma.vars[varIdx].typ = VAR_TYPE_LIST

			for i = 0 to ma.vars[varIdx].list.length

				newVarItem.name = ma.vars[varIdx].list[i].name
				newVarItem.value = ma.vars[varIdx].list[i].value
				newVarItem.cmd = 0
				newVarItem.parent = varIdx
				ma.vars[newVarIdx].list.insert(newVarItem)
				
			next
			
		endif

		if ma.vars[varIdx].thingIdx = -1

			if cd.appIdx = toAppIdx
		
				// Append if at the end.
				if idx = ma.apps[toAppIdx].vars.length
					ma.apps[toAppIdx].vars.insert(newVarIdx)
				else
					ma.apps[toAppIdx].vars.insert(newVarIdx, idx + 1)
				endif
				
			else

				ma.apps[toAppIdx].vars.insert(newVarIdx)

			endif

		else
			
			//ma.things[ma.vars[varIdx].thingIdx].vars.insert(newVarIdx)

			if cd.appIdx = toAppIdx

				// Append if at the end.
				if idx = ma.apps[toAppIdx].vars.length
					ma.things[ma.vars[varIdx].thingIdx].vars.insert(newVarIdx)
				else
					ma.things[ma.vars[varIdx].thingIdx].vars.insert(newVarIdx, idx + 1)
				endif

			else
				
				ma.things[ma.vars[varIdx].thingIdx].vars.insert(newVarIdx)

			endif
			
		endif

	else // Duplicating a list var item.

		newVarItem.name = ma.vars[varIdx].list[varValueIdx].name
		newVarItem.value = ma.vars[varIdx].list[varValueIdx].value
		newVarItem.cmd = 0
		newVarItem.parent = varIdx

		//ma.vars[varIdx].list.insert(newVarItem)

		if cd.appIdx = toAppIdx

			// Append if at the end.
			if varValueIdx = ma.vars[varIdx].list.length
				ma.vars[varIdx].list.insert(newVarItem)
			else
				ma.vars[varIdx].list.insert(newVarItem, varValueIdx + 1)
			endif

		else

			ma.vars[varIdx].list.insert(newVarItem)

		endif
					
	endif
	
	ldSaveApp(ma.apps[toAppIdx].id)
	//maSave()

	//cdSetTabVisible("dupSound", true)

endfunction

//-----------------------------------------------------
// Replace var cmds from code.
// If newVar = 0, then it deletes the var.
//
function cdReplaceCodeThings(thingIdx as integer, typ as integer, idx as integer, newIdx as integer)

	local i as integer
	local j as integer
	local cmd as integer
	local tIdx as integer
	
	for j = 0 to ma.apps[cd.appIdx].sprites.length
		
		tIdx = ma.apps[cd.appIdx].sprites[j]
		
		if thingIdx = -1 or thingIdx = tIdx
			
			for i = 0 to ma.things[tIdx].cmds.length
		
				cmd = ma.things[tIdx].cmds[i]
				cdReplaceCodeThingCmd(tIdx, typ, idx, newIdx, cmd)
						
			next
			
		endif
		
	next

endfunction

//-----------------------------------------------------
// Recurse into a cmd, to find thing parts to rename or remove.
//
function cdReplaceCodeThingCmd(thingIdx as integer, typ as integer, idx as integer, newIdx as integer, cmd as integer)

	local i as integer
	local j as integer
	local subCmd as integer
	local rootCmd as integer
	local press as CmdPress
	local code as integer
	local info as string 
	local found as string
	
	if typ = PART_VAR_NAME
		code = CODE_VAR_GET
	elseif typ = PART_SOUND_NAME
		code = CODE_SOUND_BASE
	elseif typ = PART_VIDEO_NAME
		code = CODE_VIDEO_BASE
	elseif typ = PART_SPRITE_ICON
		code = CODE_SPRITE_BASE
	endif
	
	for i = 0 to ma.cmds[cmd].parts.length

		if ma.cmds[cmd].parts[i].typ = PART_CMD

			subCmd = cdGetPartAsInt(ma.cmds[cmd].parts[i])

			//if ma.cmds[subCmd].code = CODE_NAME_GET
			if ma.cmds[subCmd].code = code

				for j = 0 to ma.cmds[subCmd].parts.length

					if ma.cmds[subCmd].parts[j].typ = typ

						found = ""
						
						if typ = PART_VAR_NAME
							
							code = CODE_VAR_GET
							
							if cdGetPartAsInt(ma.cmds[subCmd].parts[j]) = idx
								found = "true"
							endif
								
						elseif typ = PART_SOUND_NAME
							
							code = CODE_SOUND_BASE
							
							if cdGetPartAsString(ma.cmds[subCmd].parts[j]) = ma.sounds[idx].id
								if newIdx > -1
									found = ma.sounds[newIdx].id
								endif
							endif
						
						elseif typ = PART_VIDEO_NAME
							
							code = CODE_VIDEO_BASE

							if cdGetPartAsString(ma.cmds[subCmd].parts[j]) = ma.videos[idx].id
								if newIdx > -1
									found = ma.videos[newIdx].id
								endif
							endif
							
						elseif typ = PART_SPRITE_ICON
							
							code = CODE_SPRITE_BASE

							if cdGetPartAsString(ma.cmds[subCmd].parts[j]) = ma.things[idx].id
								if newIdx > -1
									found = ma.things[newIdx].id
								endif
							endif

						endif
						
						//if cdGetPartAsInt(ma.cmds[subCmd].parts[j]) = idx
						if found <> "" or newIdx = -1

							press.cmd = subCmd
							cdFindThingRootCmd(thingIdx, press)

							cdClearPart(ma.cmds[subCmd].parts[j])

							if newIdx > -1

								if typ = PART_VAR_NAME
									
									cdSetPartVar(ma.cmds[subCmd].parts[j], newIdx)

									if ma.vars[newIdx].thingIdx = -1
										cdSetCmdIcon2Ptr(ma.cmds[subCmd], cd.appVarImg)
									else
										cdSetCmdIcon2Ptr(ma.cmds[subCmd], cd.spriteVarImg)
									endif

								elseif typ = PART_SOUND_NAME
									
									//cdSetPartSound(ma.cmds[subCmd].parts[j], newIdx)
									cdSetPartSound(ma.cmds[subCmd].parts[j], found)
									
								elseif typ = PART_VIDEO_NAME
									
									//cdSetPartVideo(ma.cmds[subCmd].parts[j], newIdx)
									cdSetPartVideo(ma.cmds[subCmd].parts[j], found)
									
								elseif typ = PART_SPRITE_ICON
									
									//cdSetPartVideo(ma.cmds[subCmd].parts[j], newIdx)
									cdSetPartSprite(ma.cmds[subCmd].parts[j], found)
										
								endif

							else

								cdDeleteCmd(subCmd)
								cdRevertPart(thingIdx, cmd, i)

							endif
							
							cdUpdateCmdSize(press.parentCmd)
							cdSetCmdPos(press.parentCmd, ma.cmds[press.parentCmd].x, ma.cmds[press.parentCmd].y)
							cdSetCmdVisible(press.parentCmd, false)
							//cdDrawCode("replace thing", 0)
															
						endif
						
					endif
					
				next
			
			else

				cdReplaceCodeThingCmd(thingIdx, typ, idx, newIdx, subCmd)
				
			endif
/*							
		elseif ma.cmds[cmd].parts[i].typ = typ

			info = cdGetPartAsString(ma.cmds[cmd].parts[i])

			if info = cd.origName

				if typ = PART_SPRITE
						
					cdClearPart(ma.cmds[cmd].parts[i])
					cdSetPartSprite(ma.cmds[cmd].parts[i], newIdx)
					cdUpdateCmdSize(cmd)
					cdSetCmdPos(cmd, ma.cmds[cmd].x, ma.cmds[cmd].y)
					cdSetCmdVisible(cmd, false)

				endif

			endif
*/
		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Unload all apps.
//
function cdUnloadApps()
	
	local i as integer
	
	for i = 0 to ma.apps.length
		cdUnloadApp(i)
	next 
	
endfunction

//-----------------------------------------------------
// Unload an app and set it.
//
function cdUnloadApp(appIdx as integer)

	local idx as integer
	
	cdDeleteApp(appIdx)
	ldUnloadThingImages(appIdx, LD_MODE_THUMB || LD_MODE_IMAGE)
	ldUnloadApp(ma.apps[appIdx].id)
	
	if appIdx > -1
		
		//cdSetCmdFoldable(ma.apps[appIdx].cmd, false)
		//cdSetCmdVisible(ma.apps[appIdx].cmd, false)

		if cd.appIdx = appIdx
			
			cdSetApp("")
			ld.set.prevLoadedAppId = ""
			ldSaveSettings()
			
		endif

	endif

	//cdSetTabVisible("z", true)

endfunction

//-----------------------------------------------------
// Load an app and set it.
//
function cdLoadApp(appId as string)

	local idx as integer
	local appIdx as integer
	local loaded as integer

	appIdx = maFindAppById(appId)

	if appIdx > -1
		
		//coProgressStart(1)
		loaded = ldLoadApp(appId)
		//ldLoadThingImages(appIdx, LD_MODE_THUMB)
		cdSetTidyCode(appId)		
		//coProgressEnd()
		
		if loaded
		
			if not ma.apps[appIdx].status && LD_STATUS_LIBRARY
				
				//if not ma.apps[appIdx].status && LD_STATUS_EXAMPLE

					ld.set.prevLoadedAppId = appId
					ldSaveSettings()
															
				//endif

				cdSetApp(appId)
				
			else

				cdSetApp("")
				
			endif
			
		endif
					
	endif
	
endfunction

//-----------------------------------------------------
// Show the fake edit details.
// mode = CD_EDIT_TEXT, CD_EDIT_COLOR, etc.
// oy is an offset for the editCmd.
//
function cdSetEditPosition()

	local x as float
	local y as float
	local w as float
	local i as integer
	local yy as float
	local tmp as float
	
	x = cd.keyPanel.vx
	x = x - 4 + co.bs / 8
	y = cdSetEditCmdPosition()

	if cd.editMode = CD_EDIT_COLOR

		SetTextVisible(cd.masterEditBox.title, false)
		SetSpriteVisible(cd.masterEditBox.box, false)
		if cd.masterEditBox.text then SetTextVisible(cd.masterEditBox.text, false)

		w = co.bs * 3
		x = x - co.bs / 8

		for i = 0 to cd.colorEditBox.length

			cd.editTitle = cd.colorEditBox[i].title
			cd.editBox = cd.colorEditBox[i].box
			cd.editText = cd.colorEditBox[i].text

			SetSpritePosition(cd.colorEditBox[i].lt, x, y + GetTextTotalHeight(cd.editTitle) - co.bs / 16)
			x = x + getspritewidth(cd.colorEditBox[i].lt) //+ co.bs / 16
						
			tmp = cdSetEditBoxPosition(x, y, w)

			if i = 0
				yy = tmp
			endif

			if ld.set.trueEdit
				x = x + GetEditBoxWidth(cd.editBox) // + co.bs / 4	
			else
				x = x + GetSpriteWidth(cd.editBox) // + co.bs / 4	
			endif	
			//x = x + co.bs / 16
						
			SetSpritePosition(cd.colorEditBox[i].rt, x, y + GetTextTotalHeight(cd.editTitle) - co.bs / 16)
			x = x + getspritewidth(cd.colorEditBox[i].rt) //+ co.bs / 16		
			x = x - co.bs / 16	

			//x = x + co.bs / 16
			
		next

		// Start in the red one.
		cd.editTitle = cd.colorEditBox[0].title
		cd.editBox = cd.colorEditBox[0].box
		cd.editText = cd.colorEditBox[0].text

		y = yy

	elseif cd.subMode = CD_SUBMODE_EDIT_RESIZE or cd.submode = CD_SUBMODE_EDIT_EDITOR_RESIZE

		SetTextVisible(cd.masterEditBox.title, false)
		SetSpriteVisible(cd.masterEditBox.box, false)
		SetTextVisible(cd.masterEditBox.text, false)

		w = co.bs * 3

		for i = 0 to cd.resizeEditBox.length

			cd.editTitle = cd.resizeEditBox[i].title
			cd.editBox = cd.resizeEditBox[i].box
			cd.editText = cd.resizeEditBox[i].text
			
			tmp = cdSetEditBoxPosition(x, y, w)

			if i = 0
				yy = tmp
			endif

			x = x + GetSpriteWidth(cd.editBox) + co.bs / 4
			
		next

		// Start in the red one.
		cd.editTitle = cd.resizeEditBox[0].title
		cd.editBox = cd.resizeEditBox[0].box
		cd.editText = cd.resizeEditBox[0].text

		y = yy

	else //if not ld.set.trueEdit

		for i = 0 to cd.colorEditBox.length

			SetTextVisible(cd.colorEditBox[i].title, false)
			if cd.colorEditBox[i].box then SetSpriteVisible(cd.colorEditBox[i].box, false)
			if cd.colorEditBox[i].text then SetTextVisible(cd.colorEditBox[i].text, false)

		next 

		for i = 0 to cd.resizeEditBox.length

			SetTextVisible(cd.resizeEditBox[i].title, false)
			if cd.resizeEditBox[i].box then SetSpriteVisible(cd.resizeEditBox[i].box, false)
			if cd.resizeEditBox[i].text then SetTextVisible(cd.resizeEditBox[i].text, false)

		next 

		// Start in the red one.
		cd.editTitle = cd.masterEditBox.title
		cd.editBox = cd.masterEditBox.box
		cd.editText = cd.masterEditBox.text
		
		w = co.bs * 9 + co.bs / 2
		y = cdSetEditBoxPosition(x, y, w)

	endif
	
endfunction y

//-----------------------------------------------------
// Set the position of the edit cmd.
//
function cdSetEditCmdPosition()

	local x as float
	local y as float
	local press as CmdPress
	local showCmd as integer
	local dx as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local w as float
	local cy as float
	
	x0 = cd.keyPanel.vx
	y0 = cd.keyPanel.vy + co.bs / 8
	x1 = getspritex(cd.acceptBut.bg) - co.bs / 8 // x0 + cd.keyPanel.vw - 1
	y1 = cd.keyPanel.vh - 1
	x0 = x0 + co.bs / 8
	x1 = x1 - co.bs / 8
	x = x0
	y = y0

	if cd.editCmd

		SetTextString(cd.editCmdTitle, "Editing this command value")		
		SetTextPosition(cd.editCmdTitle, x, y)
		cy = y
		SetTextVisible(cd.editCmdTitle, true)
		y = y + GetTextTotalHeight(cd.editCmdTitle) + co.bs / 16
		
		press.cmd = cd.editCmd
		cdFindThingRootCmd(cd.thingIdx, press)
		showCmd = press.parentCmd

		cd.editCmdX = ma.cmds[showCmd].x
		cd.editCmdY = ma.cmds[showCmd].y
		
		cdSetCmdDepth(showCmd, GetSpriteDepth(cd.keyPanel.panel) - 2)
		cdSetCmdAlpha(showCmd, 255)
		cdSetCmdPos(showCmd, x, y)
		cdSetPartSelected(cd.editCmd, cd.editPartIdx)

		if getspritex(cd.cmdSelRt) + GetSpriteWidth(cd.cmdSelRt) > x1

			// First enough to bring it back to view.
			dx = (getspritex(cd.cmdSelRt) + GetSpriteWidth(cd.cmdSelRt)) - x1
				
			// Do it again, just in case it was moved.
			cdSetCmdPos(showCmd, x - dx, y)
			cdSetPartSelected(cd.editCmd, cd.editPartIdx)
						
		endif

		cdSetCmdScissor(showCmd, x0, y0, x1, y1)

		SetSpriteScissor(cd.cmdSelLt, x0, y0, x1, y1)
		SetSpriteScissor(cd.cmdSelMid, x0, y0, x1, y1)
		SetSpriteScissor(cd.cmdSelRt, x0, y0, x1, y1)

		if ma.cmds[showCmd].edge
			setspritevisible(ma.cmds[showCmd].edge, false)
		endif

		if ma.cmds[showCmd].clip
			setspritevisible(ma.cmds[showCmd].clip, false)
		endif
		
		cd.attachCmd = 0
		cd.attachPartIdx = -1

		y = y + ma.cmds[showCmd].h + co.bs / 4 + co.bs / 8

	elseif cd.editBut.active
		
		SetTextString(cd.editCmdTitle, "Editing this color")		
		SetTextPosition(cd.editCmdTitle, x, y)
		cy = y
		SetTextVisible(cd.editCmdTitle, true)
		y = y + GetTextTotalHeight(cd.editCmdTitle) + co.bs / 16

		guiSetButtonDepth(cd.editBut, GetSpriteDepth(cd.keyPanel.panel) - 2)
		guiSetButtonPos(cd.editBut, x + GetSpriteWidth(cd.editBut.bg) / 2, y + GetSpriteHeight(cd.editBut.bg) / 2)
		cdSetButtonIconSelected(cd.editBut)
		
		y = y + getspriteheight(cd.editBut.bg) + co.bs / 4 + co.bs / 8
		
	endif

	guiSetButtonPos(cd.acceptBut, x + GetSpriteWidth(cd.keyPanel.panel) - co.bs - co.bs + co.bs / 4, GetSpritey(cd.keyPanel.panel) + co.bs / 8 + co.bs / 2)
	guiSetButtonPos(cd.cancelBut, GetSpriteXByOffset(cd.acceptBut.bg) + GetSpriteWidth(cd.acceptBut.bg), GetSpriteYByOffset(cd.acceptBut.bg))
	guiSetButtonPos(cd.allBut, GetSpriteXByOffset(cd.acceptBut.bg), GetSpriteYByOffset(cd.acceptBut.bg) + GetSpriteHeight(cd.acceptBut.bg))
	guiSetButtonPos(cd.noneBut, GetSpriteXByOffset(cd.cancelBut.bg), GetSpriteYByOffset(cd.cancelBut.bg) + GetSpriteHeight(cd.cancelBut.bg))
	guiSetButtonPos(cd.autoAcceptBut, GetSpriteXByOffset(cd.acceptBut.bg), GetSpriteYByOffset(cd.acceptBut.bg) + GetSpriteHeight(cd.acceptBut.bg))

endfunction y

//-----------------------------------------------------
// Set the position of the edit box.
//
function cdSetEditBoxPosition(x as float, y as float, w as float)

	local x0 as float
	local rtx as float
	local tx as float

	x0 = x

	tx = x
	rtx = getspritex(cd.keyPanel.panel) + GetSpriteWidth(cd.keyPanel.panel)
	
	while tx + GetTextTotalWidth(cd.editTitle) > rtx - co.bs / 8
		tx = tx - co.bs / 16
	endwhile

	SetTextPosition(cd.editTitle, tx, y)		
	coSetTextColor(cd.editTitle, co.black)
	SetTextVisible(cd.editTitle, true)
	y = y + GetTextTotalHeight(cd.editTitle) + 4

	if cd.editMode <> CD_EDIT_TAGS
		
		if not ld.set.trueEdit

			// Avoid colliding with the accept but.
			if y < getspritey(cd.acceptBut.bg) + GetSpriteHeight(cd.acceptBut.bg)
				
				if x + w > getspritex(cd.acceptBut.bg)
					w = w - ((x + w) - getspritex(cd.acceptBut.bg) + co.bs / 8)
				endif
				
				SetSpriteScale(cd.editBox, w, co.bs / 2)

			endif
			
			SetSpritePosition(cd.editBox, x, y)
			coSetSpriteColor(cd.editBox, co.white)
			SetspriteVisible(cd.editBox, true)
			y = y + GetSpriteHeight(cd.editBox) + co.bs / 2

			cd.editTextX = getspritex(cd.editBox) + co.bs / 16
			SetTextPosition(cd.editText, cd.editTextX, getspritey(cd.editBox))
			SetTextVisible(cd.editText, true)

			cdSetKeyboardPos(y)

		elseif cd.editBox

			if y < getspritey(cd.acceptBut.bg) + GetSpriteHeight(cd.acceptBut.bg)
				
				if x + w > getspritex(cd.acceptBut.bg)
					w = w - ((x + w) - getspritex(cd.acceptBut.bg) + co.bs / 8)
				endif
				
				SetEditBoxSize(cd.editBox, w, co.bs / 2)

			endif
			
			SetEditBoxPosition(cd.editBox, x, y)
			SetEditBoxScissor(cd.editBox, geteditboxx(cd.editBox), geteditboxy(cd.editBox), geteditboxx(cd.editBox) + GetEditBoxWidth(cd.editBox) - 1, geteditboxy(cd.editBox) + GetEditBoxHeight(cd.editBox) - 1)
			y = y + GetSpriteHeight(cd.editBox) + co.bs / 2

		endif

		//if not ld.set.trueEdit
		//	cdSetKeyboardPos(y)
		//endif

	else

		//guiSetButtonPos(cd.allBut, x + GetSpriteWidth(cd.keyPanel.panel) - co.bs - co.bs + co.bs / 4, y + GetSpriteHeight(cd.allBut.bg) / 4)
		//guiSetButtonPos(cd.noneBut, GetSpriteXByOffset(cd.allBut.bg) + GetSpriteWidth(cd.allBut.bg), GetSpriteYByOffset(cd.allBut.bg))

	endif
	
endfunction y

//-----------------------------------------------------
// New app.
//
function cdNewApp(subMode as integer)
	
	local s as string
	local title as string
	local i as integer
	local press as CmdPress
	local showCmd as integer

	cd.subMode = subMode

	if cd.editIdx > -1
		s = ma.apps[cd.editIdx].name
	elseif ld.set.quickNaming
		s = "project"
	else
		s = ""
	endif

	cdSetEditText(s)

	if ld.set.quickNaming

		cdEditAccept()
		exitfunction
		
	endif
	
	title = "enter a name for the new project"
	cdSetKeySet(CD_KEYSET_NAME)
	cdSetKeyboardVisible(CD_KBD_LOWER)
	
	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif
	
	cd.prevEditText = s
	cdSetEditBlankAllowed(false)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// Select an app.
//
function cdSelectApp(appIdx as integer)

	local appId as string

	if ma.apps[appIdx].loaded
		appId = ma.apps[appIdx].id
	else
		appId = ""		
	endif

	cdSetApp(appId)

	ld.set.prevLoadedAppId = appId
	ldSaveSettings()

endfunction

//-----------------------------------------------------
// Select a thing.
//
function cdSelectThing(thingIdx as integer)

	local thingId as string
	
	thingId = ma.things[thingIdx].id
	ma.apps[cd.appIdx].sprId = thingId
	maSave()
	cdSetSprite(thingId)

endfunction

//-----------------------------------------------------
// Select a thing.
//
function cdSelectThingImage(thingIdx as integer, imgIdx as integer)

	local thingId as string

	if ma.things[thingIdx].imgIdx > -1
		cdSetCmdSelected(ma.things[thingIdx].imgs[ma.things[thingIdx].imgIdx].cmd, false)
	endif
	
	ma.things[thingIdx].imgIdx = imgIdx
	maSave()

	if ma.things[thingIdx].imgIdx > -1
		
		cdSetCmdSelected(ma.things[thingIdx].imgs[ma.things[thingIdx].imgIdx].cmd, true)
		cdSetCmdScissor(ma.things[thingIdx].imgs[ma.things[thingIdx].imgIdx].cmd, cd.cmdPanels[GRP_SPRITE].vx, cd.cmdPanels[GRP_SPRITE].vy, cd.cmdPanels[GRP_SPRITE].vx + cd.cmdPanels[GRP_SPRITE].vw - 1, cd.cmdPanels[GRP_SPRITE].vy + cd.cmdPanels[GRP_SPRITE].vh - 1)	
		//cdReplaceAllImageParts(cd.appIdx, PART_SPRITE, str(cd.thingIdx), "-2")

	endif

	thingId = ma.things[thingIdx].id
	cdSetSprite(thingId)

endfunction

//-----------------------------------------------------
// Rename an app.
//
function cdRenameApp(appIdx as integer)
	
	local s as string
	local title as string
	local i as integer
	local press as CmdPress
	local showCmd as integer

	cd.submode = CD_SUBMODE_RENAME_APP

	title = "Enter a new name for the project"
	cdSetKeySet(CD_KEYSET_NAME)
	cdSetKeyboardVisible(CD_KBD_LOWER)

	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif

	s = ma.apps[appIdx].name
	cd.editIdx = appIdx
	cd.prevEditText = s
	cdSetEditBlankAllowed(false)
	cdSetEditText(s)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// Rename a thing.
//
function cdRenameThing(tab as integer, idx as integer)
	
	local s as string
	local title as string
	local i as integer
	local press as CmdPress
	local showCmd as integer
	local name as string

	cd.subMode = CD_SUBMODE_RENAME_THING

	if tab = GRP_SPRITE
		name = "sprite"
	elseif tab = GRP_SOUND
		name = "sound"
	elseif tab = GRP_VIDEO
		name = "video"
	elseif tab = GRP_VAR
		//name = "variable"
		if ma.vars[idx].typ = VAR_TYPE_VALUE
			name = "value"
		elseif ma.vars[idx].typ = VAR_TYPE_VALUE
			name = "list"
		endif
	endif

	title = "Enter a new name for the " + name
	cdSetKeySet(CD_KEYSET_NAME)
	cdSetKeyboardVisible(CD_KBD_LOWER)

	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif

	//guiSetBarVisible(cd.toolbar, false)
	//guiSetButtonVisible(cd.currThingBut, false)
	cd.editIdx = idx

	if tab = GRP_SPRITE
		s = ma.things[idx].name
	elseif tab = GRP_SOUND
		s = ma.sounds[idx].name
	elseif tab = GRP_VIDEO
		s = ma.videos[idx].name
	elseif tab = GRP_VAR
		s = ma.vars[idx].name
	endif

	cd.prevEditText = s
	cdSetEditBlankAllowed(false)
	cdSetEditText(s)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// Navigate down into a sub folder, or up to a parent folder.
//
function cdNavigateFolder(idx as integer)

	local pos as integer

	if cd.mainTab = CD_TAB_APP

		if ld.libItems[idx].typ && LD_ITEM_SUB_FOLDER

			cd.appFolder = cd.appFolder + "/" + ld.libItems[idx].name
			cdLoadAppItems()
			cdSetFileTabVisible("nav5", true)
			
		elseif ld.libItems[idx].typ && LD_ITEM_PARENT_FOLDER

			pos = FindStringReverse(cd.appFolder, "/")

			if pos > 0
				cd.appFolder = mid(cd.appFolder, 1, pos - 1)
			endif

			cdLoadAppItems()
			cdSetFileTabVisible("nav6", true)

		endif

	elseif cd.mainTab = CD_TAB_THING
		
		if cd.thingTab = GRP_SPRITE
		
			if ld.libItems[idx].typ && LD_ITEM_SUB_FOLDER

				cd.imageFolder = cd.imageFolder + "/" + ld.libItems[idx].name
				cdLoadSpriteItems(cd.fileTab)
				cdSetFileTabVisible("nav1", true)
				
			elseif ld.libItems[idx].typ && LD_ITEM_PARENT_FOLDER

				pos = FindStringReverse(cd.imageFolder, "/")

				if pos > 0
					cd.imageFolder = mid(cd.imageFolder, 1, pos - 1)
				endif

				cdLoadSpriteItems(cd.fileTab)
				cdSetFileTabVisible("nav2", true)

			endif

		elseif cd.thingTab = GRP_SOUND
		
			if ld.libItems[idx].typ && LD_ITEM_SUB_FOLDER

				cd.soundFolder = cd.soundFolder + "/" + ld.libItems[idx].name
				cdLoadSoundItems()
				cdSetFileTabVisible("nav3", true)
				
			elseif ld.libItems[idx].typ && LD_ITEM_PARENT_FOLDER

				pos = FindStringReverse(cd.soundFolder, "/")

				if pos > 0
					cd.soundFolder = mid(cd.soundFolder, 1, pos - 1)
				endif

				cdLoadSoundItems()
				cdSetFileTabVisible("nav4", true)

			endif

		elseif cd.thingTab = GRP_VIDEO
		
			if ld.libItems[idx].typ && LD_ITEM_SUB_FOLDER

				cd.videoFolder = cd.videoFolder + "/" + ld.libItems[idx].name
				cdLoadVideoItems()
				cdSetFileTabVisible("nav3", true)
				
			elseif ld.libItems[idx].typ && LD_ITEM_PARENT_FOLDER

				pos = FindStringReverse(cd.videoFolder, "/")

				if pos > 0
					cd.videoFolder = mid(cd.videoFolder, 1, pos - 1)
				endif

				cdLoadVideoItems()
				cdSetFileTabVisible("nav4", true)

			endif

		endif

	endif
	
endfunction

//-----------------------------------------------------
// Rename a thing.
//
function cdRenameFolder(idx as integer)
	
	local s as string
	local title as string
	local i as integer
	local press as CmdPress
	local showCmd as integer
	local name as string

	cd.subMode = CD_SUBMODE_RENAME_ITEM_FOLDER

	if cd.mainTab = CD_TAB_THING
		if cd.thingTab = GRP_SPRITE
			name = "sprite"
		elseif cd.thingTab = GRP_SOUND
			name = "sound"
		elseif cd.thingTab = GRP_VIDEO
			name = "video"
		endif
	else
		name = "UNKNOWN"
	endif
	
	title = "Enter a new name for the " + name + " folder"
	cdSetKeySet(CD_KEYSET_NAME)
	cdSetKeyboardVisible(CD_KBD_LOWER)

	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif

	//guiSetBarVisible(cd.toolbar, false)
	//guiSetButtonVisible(cd.currThingBut, false)
	cd.editIdx = idx

	s = ld.libItems[idx].name

	cd.prevEditText = s
	cdSetEditBlankAllowed(false)
	cdSetEditText(s)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// Rename a thing.
//
function cdRenameLibThing(idx as integer)

	local obj as integer
	
	obj = ld.libItems[idx].idx
	cdRenameThing(cd.thingTab, obj)

endfunction

//-----------------------------------------------------
// New text, sound and video.
//
function cdNewThing(tab as integer)
	
	local s as string
	local title as string
	local i as integer
	local press as CmdPress
	local showCmd as integer
	local name as string
	local status as integer
	local typ as integer

	cd.subMode = CD_SUBMODE_NEW_THING

	if cd.currLibItem.visible

		name = cd.currLibItem.name
		status = cd.currLibItem.status
		typ = cd.currLibItem.typ

	else

		name = ld.libItems[cd.fileItemIdx].name
		status = ld.libItems[cd.fileItemIdx].status
		typ = ld.libItems[cd.fileItemIdx].typ

	endif
	
	if tab = GRP_SPRITE
		title = "sprite"
	elseif tab = GRP_SOUND
		title = "sound"
	elseif tab = GRP_VIDEO
		title = "video"
	elseif tab = GRP_VAR
		//title = "variable"
		if typ = LD_ITEM_VAR_APP or typ = LD_ITEM_VAR_SPRITE
			title = "value"
		elseif typ = LD_ITEM_LIST_APP or typ = LD_ITEM_LIST_SPRITE
			title = "list"
		endif
	endif
		
	if not (status && LD_STATUS_BLANK)
		
		s = name
/*
		if tab = GRP_SPRITE
			s = cdGetUniqueThingName(cd.appIdx, s)
		elseif tab = GRP_SOUND
			s = cdGetUniqueSoundName(cd.appIdx, s)
		elseif tab = GRP_VIDEO
			s = cdGetUniqueVideoName(cd.appIdx, s)
		elseif tab = GRP_VAR
			//if typ = LD_ITEM_VAR_APP or typ = LD_ITEM_LIST_APP
			//	s = cdGetUniqueAppVarName(cd.appIdx, s)
			//elseif typ = LD_ITEM_VAR_SPRITE or typ = LD_ITEM_LIST_SPRITE
			//	s = cdGetUniqueThingVarName(cd.thingIdx, s)
			//endif
			s = cdGetUniqueVarName(cd.appIdx, s)
		endif
*/
	elseif ld.set.quickNaming

		s = title

	else

		s = ""
		
	endif

	if s <> ""
		
		if tab = GRP_SPRITE
			s = cdGetUniqueThingName(cd.appIdx, s)
		elseif tab = GRP_SOUND
			s = cdGetUniqueSoundName(cd.appIdx, s)
		elseif tab = GRP_VIDEO
			s = cdGetUniqueVideoName(cd.appIdx, s)
		elseif tab = GRP_VAR
			//if typ = LD_ITEM_VAR_APP or typ = LD_ITEM_LIST_APP
			//	s = cdGetUniqueAppVarName(cd.appIdx, s)
			//elseif typ = LD_ITEM_VAR_SPRITE or typ = LD_ITEM_LIST_SPRITE
			//	s = cdGetUniqueThingVarName(cd.thingIdx, s)
			//endif
			s = cdGetUniqueVarName(cd.appIdx, s)
		endif
		
	endif

	cdSetEditText(s)

	if ld.set.quickNaming

		cdEditAccept()
		exitfunction
		
	endif

	title = "Enter a name for the new " + title
	cdSetKeySet(CD_KEYSET_NAME)
	cdSetKeyboardVisible(CD_KBD_LOWER)

	cdSetAllAlpha(gui.inactiveAlpha)
	
	cd.editMode = CD_EDIT_TEXT

	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif
	
	cd.prevEditText = s
	cdSetEditBlankAllowed(false)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// New value for a variable.
//
function cdEditVarValue(varIdx as integer, varValueIdx as integer, subMode as integer)
	
	local s as string
	local title as string
	local i as integer
	local j as integer
	local press as CmdPress
	local showCmd as integer

	cd.subMode = subMode
	
	title = "Enter a value for this variable list item"
	cdSetKeySet(CD_KEYSET_ALL)
	cdSetKeyboardVisible(CD_KBD_LOWER)
	
	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif

	cd.editIdx = varIdx
	cd.varValueIdx = varValueIdx
		
	if subMode = CD_SUBMODE_EDIT_VAR_VALUE_NAME and varValueIdx > -1
		s = ma.vars[varIdx].list[varValueIdx].value
	endif

	cd.prevEditText = s	
	cdSetEditBlankAllowed(false)
	cdSetEditText(s)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// New value for a variable.
//
function cdEditVarValueName(varIdx as integer, varValueIdx as integer, subMode as integer)
	
	local s as string
	local title as string
	local i as integer
	local j as integer
	local press as CmdPress
	local showCmd as integer

	cd.subMode = subMode
	
	title = "Enter a name for this variable list item"
	cdSetKeySet(CD_KEYSET_ALL)
	cdSetKeyboardVisible(CD_KBD_LOWER)
	
	cdSetAllAlpha(gui.inactiveAlpha)

	cd.editMode = CD_EDIT_TEXT
	
	if not ld.set.trueEdit

		cd.editCmd = 0
		cdSetEditPosition()
		
	endif

	cd.editIdx = varIdx
	cd.varValueIdx = varValueIdx
		
	if varValueIdx > -1
		s = ma.vars[varIdx].list[varValueIdx].name
	endif

	cd.prevEditText = s	
	cdSetEditBlankAllowed(false)
	cdSetEditText(s)
	cdSetEditTitle(title)
	cdSetEditCursor(-1)	
	cdSetEditVisible(true)

endfunction

//-----------------------------------------------------
// Find an app.
//
function cdLoadAppItems()
	
	if cd.fileTab = CD_FILE_TAB_LIBRARY
		cdLoadAppLibraryItems(ld.libItems)
	endif
		
endfunction

//-----------------------------------------------------
// Find a sprite.
//
function cdLoadSpriteItems(fileTab as integer)
	
	//if cd.fileTab = CD_FILE_TAB_LIBRARY
	if fileTab = CD_FILE_TAB_LIBRARY
		cdLoadThingLibraryItems(ld.libItems, cd.imageFolder, LD_ITEM_SPRITE_LIB)
	endif
	
endfunction

//-----------------------------------------------------
// Find a sound.
//
function cdLoadSoundItems()

	local showFrameBut as integer
	local idx as integer
	
	if cd.fileTab = CD_FILE_TAB_LIBRARY
		cdLoadThingLibraryItems(ld.libItems, cd.soundFolder, LD_ITEM_SOUND_LIB)
	endif
	
endfunction

//-----------------------------------------------------
// Find a video.
//
function cdLoadVideoItems()

	local showFrameBut as integer
	local idx as integer
	
	if cd.fileTab = CD_FILE_TAB_LIBRARY
		cdLoadThingLibraryItems(ld.libItems, cd.videoFolder, LD_ITEM_VIDEO_LIB)
	endif
	
endfunction

//-----------------------------------------------------
// Find a var.
//
function cdLoadVarItems()

	local showFrameBut as integer
	local idx as integer
	
	if cd.fileTab = CD_FILE_TAB_LIBRARY
		cdLoadVarLibraryItems(ld.libItems)
	endif
	
endfunction

//-----------------------------------------------------
// Lift the command.
//
function cdLiftCmd(cmd as integer, x as float, y as float)

	cdLiftCmdPtr(ma.cmds[cmd], x, y)

endfunction

//-----------------------------------------------------
// Lift the command ptr.
// DON'T REMOVE ROOT flags.
//
function cdLiftCmdPtr(cmd ref as Cmd, x as float, y as float)

	local currCmd as integer
	local elseCmd as integer
	local closeCmd as integer
	local i as integer
	local oppCode as integer
	local elCode as integer
	local selIdx as integer

	cd.currCmds.length = -1
	closeCmd = 0

	if not cmd.codeTab

		currCmd = cdCloneCmdPtr(cmd)
		cd.currCmds.insert(currCmd)

		// Clone close cmd for an open cmd.
		if maIsOpenCode(ma.cmds[currCmd].code)

			if ma.cmds[currCmd].code = CODE_FLOW_IF_ELSE 

				// If an else is required, add that too.
				selIdx = cdFindSelCmdIdx(CODE_FLOW_ELSE)
				elseCmd = cdCloneCmd(cd.selCmds[selIdx])
				cdSetCmdVisible(elseCmd, false)
				ma.cmds[elseCmd].codeTab = false
				cd.currCmds.insert(elseCmd)

			else // check by open/close cmd
			
				// If an else is required, add that too.
				elCode = cdGetElseCode(ma.cmds[currCmd].code)
				
				if elCode
					
					selIdx = cdFindSelCmdIdx(elCode)
					
					if selIdx > -1
						
						elseCmd = cdCloneCmd(cd.selCmds[selIdx])
						cdSetCmdVisible(elseCmd, false)
						ma.cmds[elseCmd].codeTab = false
						cd.currCmds.insert(elseCmd)
						
					endif
					
				endif

			endif

			// Add the opposite cmd as well, but make it invisible.
			oppCode = cdGetOppositeCode(ma.cmds[currCmd].code)
		
			if oppCode
				
				selIdx = cdFindSelCmdIdx(oppCode)
				
				if selIdx > -1
					
					closeCmd = cdCloneCmd(cd.selCmds[selIdx])
					cdSetCmdVisible(closeCmd, false)
					ma.cmds[closeCmd].codeTab = false
					cd.currCmds.insert(closeCmd)
					
				endif
					
			endif

		endif

		cdClearAttach()
		
	elseif not (cmd.code = CODE_FLOW_ENDIF or cmd.code = CODE_FLOW_ELSE or cmd.code = CODE_FLOW_REPEAT_END or maIsCloseCode(cmd.code) or maIsElseCode(cmd.code))

		// Make sure we don't lift end cmds.				
		cdGrabCmd(cmd.idx, -1)
		
	endif

	if cd.currCmds.length > -1

		for i = 0 to cd.currCmds.length

			if i = 0

				cd.offX = x - cmd.x
				cd.offY = y - cmd.y
				//cdSetCmdClip(cd.currCmds[i], 0, 0)	

			endif

			cdSetCmdDepth(cd.currCmds[i], GUI_SHADOW_DEPTH)
			cdSetCmdScissor(cd.currCmds[i], 0, 0, 0, 0)
			
			// Don't show else or close cmd on drag.
			if cmd.codeTab or i = 0

				cdSetCmdVisible(cd.currCmds[i], true)
				cdSetCmdShadowVisible(cd.currCmds[i], true)

			endif

		next

	endif

endfunction

//-----------------------------------------------------
// Clear library.
//
function cdClearLibItems(items ref as LibItem[])

	local i as integer
	
	for i = 0 to items.length
		cdClearLibItem(items[i])
	next

	items.length = -1
	
endfunction

//-----------------------------------------------------
// Clear library.
//
function cdClearLibItem(libItem ref as LibItem)

	if libItem.border
		
		deletesprite(libItem.border)
		libItem.border = 0
		
	endif

	if libItem.bg
		
		deletesprite(libItem.bg)
		libItem.bg = 0
		
	endif

	if libItem.icon
		
		deletesprite(libItem.icon)
		libItem.icon = 0
		
	endif

	if libItem.tag
		
		deletesprite(libItem.tag)
		libItem.tag = 0
		
	endif

	if libItem.tag2
		
		deletesprite(libItem.tag2)
		libItem.tag2 = 0
		
	endif

	if libItem.tag3
		
		deletesprite(libItem.tag3)
		libItem.tag3 = 0
		
	endif

	if libItem.sel
		
		deletesprite(libItem.sel)
		libItem.sel = 0
		
	endif
	
	if libItem.text
		
		deletetext(libItem.text)
		libItem.text = 0
		
	endif

	if libItem.text2
		
		deletetext(libItem.text2)
		libItem.text2 = 0
		
	endif

	if libItem.img

		if not libItem.sharedImg		
			deleteimage(libItem.img)
		endif
		
		libItem.img = 0
		
	endif

	libItem.id = ""
	libItem.name = ""
	libItem.file = ""
	libItem.visible = false
	libItem.selected = false
	libItem.w = 0
	libItem.h = 0
	libItem.x = 0
	libItem.y = 0
	
endfunction

//-----------------------------------------------------
// Set the current lib item.
//
function cdSetCurrLibItem(libItem ref as LibItem)

	// Make sure there nothing left of a previous lib item.
	cdClearLibItem(cd.currLibItem)
	
	cd.currLibItem.id = libItem.id
	cd.currLibItem.typ = libItem.typ
	cd.currLibItem.name = libItem.name
	cd.currLibItem.folder = libItem.folder
	cd.currLibItem.file = libItem.file
	cd.currLibItem.ext = libItem.ext
	cd.currLibItem.visible = false
	cd.currLibItem.selected = false
	cd.currLibItem.status = libItem.status
	cd.currLibItem.appIdx = libItem.appIdx
	cd.currLibItem.idx = libItem.idx

	if libItem.sharedImg
		
		cd.currLibItem.img = libItem.img
		cd.currLibItem.sharedImg = true

	endif

endfunction

//-----------------------------------------------------
// Lift the item.
//
function cdLiftLibItem(libItem ref as LibItem, x as float, y as float)

	cdSetCurrLibItem(libItem)

	cd.currLibItem.w = libItem.w
	cd.currLibItem.h = libItem.h
	cd.currLibItem.x = libItem.x
	cd.currLibItem.y = libItem.y

	cdCreateLibItem(cd.currLibItem)
	
	cdSetLibItemScissor(cd.currLibItem, false, cd.loadPanel)
	cdSetLibItemSelected(cd.currLibItem, true)
	cdSetLibItemPos(cd.currLibItem, cd.currLibItem.x, cd.currLibItem.y)
	cdSetLibItemVisible(cd.currLibItem, true)
	cdSetLibItemDepth(cd.currLibItem, GUI_SHADOW_DEPTH)

	cd.offX = x - cd.currLibItem.x
	cd.offY = y - cd.currLibItem.y

endfunction

//-----------------------------------------------------
// Give an open cmd, return the close cmd.
//
function cdGetOppositeCode(code as integer)

	local ret as integer
	local selIdx as integer
	local cmd as integer
	
	if code = CODE_FLOW_IF or code = CODE_FLOW_IF_ELSE
		ret = CODE_FLOW_ENDIF
	elseif code = CODE_FLOW_REPEAT_TIMES or code = CODE_FLOW_REPEAT_FOREVER or code = CODE_FLOW_REPEAT_UNTIL or code = CODE_FLOW_REPEAT_WHILE
		ret = CODE_FLOW_REPEAT_END
	else
		ret = 0
	endif

	if not ret

		selIdx = cdFindSelCmdIdx(code)
		
		if selIdx > -1
			
			cmd = cd.selCmds[selIdx]

			if ma.cmds[cmd].closeCmd
				ret = ma.cmds[ma.cmds[cmd].closeCmd].code
			endif

		endif
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Given an open cmd, return the else cmd.
//
function cdGetElseCode(code as integer)

	local ret as integer
	local cmd as integer
	local i as integer
	local opp as integer // Close cmd.
			
	if code = CODE_FLOW_IF_ELSE
		ret = CODE_FLOW_ELSE
	else
		ret = 0
	endif
	
	if not ret
		
		opp = cdGetOppositeCode(code) // Get close.
	
		if opp
			
			for i = 0 to cd.selCmds.length
				
				if ma.cmds[ma.cmds[cd.selCmds[i]].openCmd].code = code // If cmd open points to code.
		
					if ma.cmds[ma.cmds[cd.selCmds[i]].closeCmd].code = opp // Then close needs to point to opp.
					
						//ret = cd.selCmds[i]
						ret = ma.cmds[cd.selCmds[i]].code
						exit
						
					endif
					
				endif
				
			next
			
		endif
				
	endif

endfunction ret

//-----------------------------------------------------
// Grab the commands ready for a drag.
// count - the number of cmds to grab. -1 to grab based on normal lift.
//
function cdGrabCmd(cmd as integer, count as integer)

	local idx as integer
	local detachCmd as integer
	local i as integer
	local ind as integer // Indent of open and close cmds.
	local press as CmdPress
	
	cd.currCmds.length = -1
	
	i = 0
	ind = 0
	idx = cdFindThingCmd(cd.thingIdx, cmd, 0)

	if idx = -1 // Part.

		press.parentCmd = 0
		press.cmd = cmd
		press.partIdx = -1
		
		cdFindThingPartCmd(cd.thingIdx, press)

		if press.partIdx > -1
			
			cd.detachCmd = press.parentCmd
			cd.detachPartIdx = press.partIdx
			cd.currCmds.insert(press.cmd)

		endif
		
	else
		
		while idx <= ma.things[cd.thingIdx].cmds.length
			
			detachCmd = ma.things[cd.thingIdx].cmds[idx]

			if maIsCloseCode(ma.cmds[detachCmd].code)
				dec ind
			elseif maIsElseCode(ma.cmds[detachCmd].code)
				dec ind
			endif
				
			if i > 0 // Always need to grab first command, but check subsequent.

				if ma.cmds[detachCmd].root or ind < 0
					exit
				endif
				
			endif

			if maIsOpenCode(ma.cmds[detachCmd].code)
				inc ind
			elseif maIsElseCode(ma.cmds[detachCmd].code)
				inc ind
			endif
			
			cd.currCmds.insert(detachCmd)

			if count > -1
					
				dec count

				if count = 0
					exit
				endif

			endif
			
			//ma.things[cd.thingIdx].cmds.remove(idx)
			inc idx

			inc i

		endwhile

	endif

	if cd.currCmds.length > -1
		
		cd.tmpClip.grabX = ma.cmds[cd.currCmds[0]].x
		cd.tmpClip.grabY = ma.cmds[cd.currCmds[0]].y

	endif
	
endfunction

//-----------------------------------------------------
// Remove the currCmds from it's location.
//
function cdDetachCmds(cmds ref as integer[])

	local idx as integer
	local i as integer
	local cmd as integer

	if cmds.length > -1

		cd.tmpClip.cmds = cmds

		// Clean up part.
		if cd.detachPartIdx > -1

			if cd.detachCmd > 0
				cdRevertPart(cd.thingIdx, cd.detachCmd, cd.detachPartIdx)
			endif

			if ma.cmds[cd.currCmds[0]].code = CODE_SPRITE_PART
				ma.cmds[cd.currCmds[0]].code = CODE_SPRITE_BASE
			elseif ma.cmds[cd.currCmds[0]].code = CODE_FRAME_PART
				ma.cmds[cd.currCmds[0]].code = CODE_FRAME_BASE
			endif
	
			cd.tmpClip.attachCmd = cd.detachCmd
			cd.tmpClip.attachPartIdx = cd.detachPartIdx
			cd.tmpClip.attachDir = 0
			cd.tmpClip.isRoot = false
			
			cdClearAttach()

		else // Not a part, need to detach cmds.
			
			cmd = cmds[0]
			cdSetCmdClip(cmd, 0, 0) // Clear clip.
			idx = cdFindThingCmd(cd.thingIdx, cmd, 0)

			// Remove cmds from thing.
			
			for i = 0 to cmds.length
				if idx <= ma.things[cd.thingIdx].cmds.length
					if ma.things[cd.thingIdx].cmds[idx] = cmds[i]
						ma.things[cd.thingIdx].cmds.remove(idx)
					endif
				endif					
			next

			//
			// Remember the detact point, for undo.
			//
			
			if ma.things[cd.thingIdx].cmds.length > -1 and idx > 0 and not ma.cmds[cmd].root

				cd.detachCmd = ma.things[cd.thingIdx].cmds[idx - 1]
				cd.detachDir = DIR_S

			else

				cd.detachCmd = 0
				cd.detachDir = 0

				// If we have lifted a single cmd, and left a dangling not-root, make it a root.
				if ma.things[cd.thingIdx].cmds.length >= idx
					if not ma.cmds[ma.things[cd.thingIdx].cmds[idx]].root
						ma.cmds[ma.things[cd.thingIdx].cmds[idx]].root = true
					endif
				endif
				
			endif

			cd.detachPartIdx = -1

			cd.tmpClip.attachCmd = cd.detachCmd
			cd.tmpClip.attachPartIdx = cd.detachPartIdx
			cd.tmpClip.attachDir = cd.detachDir
			cd.tmpClip.isRoot = ma.cmds[cmd].root
			cd.tmpClip.grabX = ma.cmds[cmd].x
			cd.tmpClip.grabY = ma.cmds[cmd].y
			
			ma.cmds[cmd].root = false			

		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Check if over the code panel.
//
function cdCheckOverCodePanel(x as float, y as float)

	local ret as integer
	
	if coPointWithinRect(x, y, getspritex(cd.codePanel.panel), getspritey(cd.codePanel.panel), getspritewidth(cd.codePanel.panel), GetSpriteHeight(cd.codePanel.panel))
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Check if the currCmd is dragging over a cmd in the passed list.
//
function cdCheckOverCode(x as float, y as float)

	local i as integer
	local over as integer
	local cmd as integer
	
	cdHideCmdHover()
	cdHideThingHover()

	over = false

	// Over activate attach if ptr is within codepanel area.
	if cdCheckOverCodePanel(x, y)
		
		if cd.thingIdx > -1 and cd.currCmds.length > -1
			
			for i = 0 to ma.things[cd.thingIdx].cmds.length

				cmd = ma.things[cd.thingIdx].cmds[i]
				over = cdCheckOverCodeCmd(ma.cmds[cmd], x, y)

				if over
					exit
				endif

			next

		endif

	endif
	
endfunction over

//-----------------------------------------------------
// Check if we are within the edge of the thing area, to see if we need to scroll.
//
function cdCheckThingScroll(x as float, y as float)

	local vx as float
	local vy as float
	local vw as float
	local vh as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local ce2 as float
	local d as float
	local cx as float
	local cy as float
	local cw as float
	local ch as float
	local i as integer
	local cmd as integer
	local dx as float
	local dy as float
	local tx as float
	local ty as float
	
	vx = getspritex(cd.cmdPanels[cd.thingTab].panel) // cd.cmdPanels[cd.thingTab].vx
	vy = getspritey(cd.cmdPanels[cd.thingTab].panel) // cd.cmdPanels[cd.thingTab].vy
	vw = GetSpriteWidth(cd.cmdPanels[cd.thingTab].panel) // cd.cmdPanels[cd.thingTab].vw
	vh = GetSpriteHeight(cd.cmdPanels[cd.thingTab].panel)  // cd.cmdPanels[cd.thingTab].vh
	ce2 = CD_CODE_EDGE * 2
		
	if cd.currCmds.length > -1

		if coPointWithinRect(x, y, vx, vy, vw, vh) and not coPointWithinRect(x, y, vx + CD_CODE_EDGE, vy + CD_CODE_EDGE, vw - ce2, vh - ce2)

			if not cd.scrollZone
				
				if x < vx + CD_CODE_EDGE
					cd.scrollZone = cd.scrollZone + DIR_W
				elseif x > vx + vw - CD_CODE_EDGE
					cd.scrollZone = cd.scrollZone + DIR_E
				endif
					
				if y < vy + CD_CODE_EDGE
					cd.scrollZone = cd.scrollZone + DIR_N
				elseif y > vy + vh - CD_CODE_EDGE
					cd.scrollZone = cd.scrollZone + DIR_S
				endif

				cd.scrollTime = GetMilliseconds() + CD_CODE_SCROLL_WAIT

			endif
			
			if cd.scrollZone and GetMilliseconds() > cd.scrollTime
				
				setspritescale(cd.codeScroll, getspritewidth(cd.cmdPanels[cd.thingTab].panel) - CD_CODE_EDGE * 2, GetSpriteHeight(cd.cmdPanels[cd.thingTab].panel) - CD_CODE_EDGE * 2)
				SetSpritePositionByOffset(cd.codeScroll, GetSpriteXByOffset(cd.cmdPanels[cd.thingTab].panel), GetSpriteYByOffset(cd.cmdPanels[cd.thingTab].panel))				
				coSetSpriteColor(cd.codeScroll, co.grey[3])
				SetSpriteDepth(cd.codeScroll, GetSpriteDepth(cd.cmdPanels[cd.thingTab].panel) - 2)
				SetSpriteVisible(cd.codeScroll, true)

				cx = cd.cmdPanels[cd.thingTab].cx
				cy = cd.cmdPanels[cd.thingTab].cy
				cw = cd.cmdPanels[cd.thingTab].cw
				ch = cd.cmdPanels[cd.thingTab].ch

				dx = 0
				dy = 0
				
				if cd.scrollZone && DIR_W

					cdScrollThingPanel(cd.thingTab, x, y, -CD_CODE_SCROLL_DIST, 0)

				endif
				
				if cd.scrollZone && DIR_E

					cdScrollThingPanel(cd.thingTab, x, y, CD_CODE_SCROLL_DIST, 0)

				endif

				if cd.scrollZone && DIR_N

					cdScrollThingPanel(cd.thingTab, x, y, 0, CD_CODE_SCROLL_DIST)

				endif

				if cd.scrollZone && DIR_S

					cdScrollThingPanel(cd.thingTab, x, y, 0, -CD_CODE_SCROLL_DIST)
										
				endif

				cd.scrollTime = GetMilliseconds() + CD_CODE_SCROLL_TIME
				
			endif
			
		else

			cd.scrollZone = 0
			
		endif

	else

		cd.scrollZone = 0
		
	endif

	if not cd.scrollZone		
		SetSpriteVisible(cd.codeScroll, false)
	endif
	
endfunction

//-----------------------------------------------------
// SCroll the thing panel while dragging.
//
function cdScrollThingPanel(thingTab as integer, x as float, y as float, dx as float, dy as float)

	guiPanelPressed(cd.cmdPanels[cd.thingTab], x, y, GUI_PANEL_ALL)
	guiPanelMoved(cd.cmdPanels[cd.thingTab], x + dx, y + dy)
	guiPanelPoll(cd.cmdPanels[cd.thingTab], x + dx, y + dy)
	cdMoveThings()
	guiPanelReleased(cd.cmdPanels[cd.thingTab], x + dx, y + dy)

endfunction

//-----------------------------------------------------
// Check if the currLibItem is dragging over a thing in the thing list.
//
function cdCheckOverThings(x as float, y as float)

	local over as integer
	
	over = 0
	cd.attachCmd = 0
	cd.attachDir = 0
	cdHideCmdHover()
	cdHideThingHover()
	cd.fileIdx = -1 // For sprite.
	cd.varValueIdx = -1 // For frame.
	cd.varThingIdx = -1

	if cd.mainTab = CD_TAB_THING and cdIsDragingThingVisible() and cd.appIdx > -1

		if cd.thingTab = GRP_SPRITE
			
			over = cdCheckOverSprites(x, y)

		elseif cd.thingTab = GRP_VAR

			over = cdCheckOverVars(ma.apps[cd.appIdx].vars, x, y)

			if not over and cd.thingIdx > -1
				
				over = cdCheckOverVars(ma.things[cd.thingIdx].vars, x, y)

				if over
					cd.varThingIdx = cd.thingIdx
				endif
				
			endif
			
		endif
		
	endif

endfunction over

//-----------------------------------------------------
// Check if currLibItem is dragged over a var.
//
function cdCheckOverSprites(x as float, y as float)

	local i as integer
	local j as integer
	local thingIdx as integer
	local idx as integer
	local over as integer

	over = 0
	
	for i = 0 to ma.apps[cd.appIdx].sprites.length

		thingIdx = ma.apps[cd.appIdx].sprites[i]

		if ma.things[thingIdx].cmd
			
			over = cdCheckOverSprite(ma.cmds[ma.things[thingIdx].cmd], x, y)

			if over

				cd.fileIdx = thingIdx
				cd.varValueIdx = -1
				cd.attachDir = over
				cd.attachCmd = ma.things[thingIdx].cmd

				cdSetThingHover(ma.things[thingIdx].cmd, over, cd.cmdPanels[GRP_SPRITE])

				exit

			// Only a frame can drag over another frame.
			elseif not cdGetCmdFolded(ma.things[thingIdx].cmd)
					
				for j = 0 to ma.things[thingIdx].imgs.length
					
					if ma.things[thingIdx].imgs[j].cmd

						over = cdCheckOverSprite(ma.cmds[ma.things[thingIdx].imgs[j].cmd], x, y)

						if over

							cd.fileIdx = thingIdx
							cd.varValueIdx = j
							cd.attachDir = over
							cd.attachCmd = ma.things[thingIdx].imgs[j].cmd

							cdSetThingHover(ma.things[thingIdx].imgs[j].cmd, over, cd.cmdPanels[GRP_SPRITE])

							exit
							
						endif
							
					endif
					
				next

				if over
					exit
				endif
				
			endif

		endif
		
	next

endfunction over

//-----------------------------------------------------
// Check if currLibItem is dragged over a thing.
//
function cdCheckOverSprite(cmd ref as Cmd, x as float, y as float)

	local ret as integer
	local i as integer
	local j as integer
	local thingIdx as integer

	ret = 0
	
	if cd.currLibItem.visible

		//if coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y, cmd.x, cmd.y, cmd.w, cmd.h)
		if coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y + cd.currLibItem.h / 2, cmd.x, cmd.y, cmd.w, cmd.h)
		//if coPointWithinRect(x, y, cmd.x, cmd.y, cmd.w, cmd.h)

			//if cd.currLibItem.y < cmd.y + cmd.h / 2
			if cd.currLibItem.y + cd.currLibItem.h / 2 < cmd.y + cmd.h / 2
			//if y < cmd.y + cmd.h / 2
				ret = DIR_N
			else
				ret = DIR_S
			endif
			
		endif

	elseif cd.currCmds.length > -1

		if (ma.cmds[cd.currCmds[0]].code = CODE_SPRITE_BASE and cmd.code = CODE_SPRITE_BASE) or ma.cmds[cd.currCmds[0]].code = CODE_FRAME_BASE

			//if coPointWithinRect(x, y, cmd.x, cmd.y, cmd.w, cmd.h)
			if coPointWithinRect(ma.cmds[cd.currCmds[0]].x, ma.cmds[cd.currCmds[0]].y, cmd.x, cmd.y, cmd.w, cmd.h)

				if ma.cmds[cd.currCmds[0]].y < cmd.y + cmd.h / 2
				//if y < cmd.y + cmd.h / 2
					ret = DIR_N
				else
					ret = DIR_S
				endif

			endif

		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// Check if currLibItem is dragged over a var.
//
function cdCheckOverVars(vars as integer[], x as float, y as float)

	local i as integer
	local j as integer
	local var as integer
	local over as integer

	over = 0
	cd.attachCmd = 0
	cd.attachDir = 0

	cdHideThingHover()

	cd.fileIdx = -1	
	cd.varValueIdx = -1

	for i = 0 to vars.length

		var = vars[i]

		if ma.vars[var].cmd

			over = cdCheckOverVar(var, x, y)
			
			if over

				cd.fileIdx = var
				cd.attachDir = over
				cd.attachCmd = ma.vars[var].cmd

				cdSetThingHover(ma.vars[var].cmd, over, cd.cmdPanels[GRP_VAR])

				exit

			elseif (ma.vars[var].typ = VAR_TYPE_LIST or ma.vars[var].typ = VAR_TYPE_OBJECT) and not cdGetCmdFolded(ma.vars[var].cmd)

				for j = 0 to ma.vars[var].list.length
					
					if ma.vars[var].list[j].cmd

						over = cdCheckOverVarValue(var, ma.vars[var].list[j], x, y)

						if over

							cd.fileIdx = var
							cd.varValueIdx = j
							cd.attachDir = over
							cd.attachCmd = ma.vars[var].list[j].cmd

							cdSetThingHover(ma.vars[var].list[j].cmd, over, cd.cmdPanels[GRP_VAR])

							exit
							
						endif
							
					endif
					
				next

				if over
					exit
				endif
				
			endif

		endif
		
	next

endfunction over

//-----------------------------------------------------
// Check if currLibItem is dragged over a thing.
//
function cdIsDragingThingVisible()

	local ret as integer

	ret = false
	
	if cd.currLibItem.visible
		ret = true
	elseif cd.currCmds.length > -1
		if cd.thingTab = GRP_SPRITE
			if cdIsSpriteOrFrameCmd(cd.currCmds[0])
				ret = true
			endif
		elseif cd.thingTab = GRP_VAR
			if cdIsVarOrValueCmd(cd.currCmds[0])
				ret = true
			endif
		endif
	endif
	
endfunction ret

//-----------------------------------------------------
// Check if currLibItem is dragged over a var.
//
function cdCheckOverVar(var as integer, x as float, y as float)

	local ret as integer
	local i as integer
	local j as integer
	local cmd as integer

	ret = 0
	cmd = ma.vars[var].cmd
	
	if cd.currLibItem.visible

		if cd.currLibItem.typ = LD_ITEM_VAR_VALUE and (ma.vars[var].typ = VAR_TYPE_LIST or ma.vars[var].typ = VAR_TYPE_OBJECT)

			//if coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h) //or coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y + cd.currLibItem.h - 1, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			//if coPointWithinRect(x, y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			if coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y + cd.currLibItem.h / 2, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
				
				//if cd.currLibItem.y < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
				//	ret = DIR_N
				//else
					ret = DIR_S
				//endif
	
			endif

		endif
		
	elseif cd.currCmds.length > -1

		if ma.cmds[cd.currCmds[0]].code = CODE_VAR_VALUE and (ma.vars[var].typ = VAR_TYPE_LIST or ma.vars[var].typ = VAR_TYPE_OBJECT)

			//if coPointWithinRect(ma.cmds[cd.currCmds[0]].x, ma.cmds[cd.currCmds[0]].y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			//if coPointWithinRect(x, y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			if coPointWithinRect(ma.cmds[cd.currCmds[0]].x, ma.cmds[cd.currCmds[0]].y + ma.cmds[cd.currCmds[0]].w / 2, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)

				//if ma.cmds[cd.currCmds[0]].y < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
				//	ret = DIR_N
				//else
					ret = DIR_S
				//endif

			endif

		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// Check if currLibItem that is a value is dragged over a var.
//
function cdCheckOverVarValue(var as integer, varItem ref as VarItem, x as float, y as float)

	local ret as integer
	local i as integer
	local j as integer
	local cmd as integer

	ret = 0
	cmd = varItem.cmd
	
	if cd.currLibItem.visible

		if cd.currLibItem.typ = LD_ITEM_VAR_VALUE and (ma.vars[var].typ = VAR_TYPE_LIST or ma.vars[var].typ = VAR_TYPE_OBJECT)
		
			//if coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h) 
			//if coPointWithinRect(x, y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			if coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y + cd.currLibItem.h / 2, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
				
				//if cd.currLibItem.y < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
				//if y < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
				if cd.currLibItem.y + cd.currLibItem.h / 2 < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
					ret = DIR_N
				else
					ret = DIR_S
				endif

/*				
			elseif coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y + cd.currLibItem.h, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			//if coPointWithinRect(x, y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			//if coPointWithinRect(cd.currLibItem.x, cd.currLibItem.y + cd.currLibItem.h / 2, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
				
				if cd.currLibItem.y + cd.currLibItem.h - 1 < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
				//if y < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
				//if cd.currLibItem.y + cd.currLibItem.h / 2 < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
					ret = DIR_N
				else
					ret = DIR_S
				endif
*/				
			endif

		endif
		
	elseif cd.currCmds.length > -1

		if ma.cmds[cd.currCmds[0]].code = CODE_VAR_VALUE and (ma.vars[var].typ = VAR_TYPE_LIST or ma.vars[var].typ = VAR_TYPE_OBJECT)

			//if coPointWithinRect(ma.cmds[cd.currCmds[0]].x, ma.cmds[cd.currCmds[0]].y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			//if coPointWithinRect(x, y, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)
			if coPointWithinRect(ma.cmds[cd.currCmds[0]].x, ma.cmds[cd.currCmds[0]].y + ma.cmds[cd.currCmds[0]].h / 2, ma.cmds[cmd].x, ma.cmds[cmd].y, ma.cmds[cmd].w, ma.cmds[cmd].h)

				//if ma.cmds[cd.currCmds[0]].y < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
				//if y < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
				if ma.cmds[cd.currCmds[0]].y + ma.cmds[cd.currCmds[0]].h / 2 < ma.cmds[cmd].y + ma.cmds[cmd].h / 2
					ret = DIR_N
				else
					ret = DIR_S
				endif

			endif

		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// Check if we are within the edge of the code area, to see if we need to scroll.
//
function cdCheckCodeScroll(x as float, y as float)

	local vx as float
	local vy as float
	local vw as float
	local vh as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local ce2 as float
	local d as float
	local cx as float
	local cy as float
	local cw as float
	local ch as float
	local i as integer
	local cmd as integer
	local dx as float
	local dy as float
	local tx as float
	local ty as float
	
	vx = getspritex(cd.codePanel.panel) // cd.codePanel.vx
	vy = getspritey(cd.codePanel.panel) // cd.codePanel.vy
	vw = GetSpriteWidth(cd.codePanel.panel) // cd.codePanel.vw
	vh = GetSpriteHeight(cd.codePanel.panel)  // cd.codePanel.vh
	ce2 = CD_CODE_EDGE * 2
		
	if cd.currCmds.length > -1

		if coPointWithinRect(x, y, vx, vy, vw, vh) and not coPointWithinRect(x, y, vx + CD_CODE_EDGE, vy + CD_CODE_EDGE, vw - ce2, vh - ce2)

			if not cd.scrollZone
				
				if x < vx + CD_CODE_EDGE
					cd.scrollZone = cd.scrollZone + DIR_W
				elseif x > vx + vw - CD_CODE_EDGE
					cd.scrollZone = cd.scrollZone + DIR_E
				endif
					
				if y < vy + CD_CODE_EDGE
					cd.scrollZone = cd.scrollZone + DIR_N
				elseif y > vy + vh - CD_CODE_EDGE
					cd.scrollZone = cd.scrollZone + DIR_S
				endif

				cd.scrollTime = GetMilliseconds() + CD_CODE_SCROLL_WAIT

			endif
			
			if cd.scrollZone and GetMilliseconds() > cd.scrollTime

				setspritescale(cd.codeScroll, getspritewidth(cd.codePanel.panel) - CD_CODE_EDGE * 2, GetSpriteHeight(cd.codePanel.panel) - CD_CODE_EDGE * 2)
				SetSpritePositionByOffset(cd.codeScroll, GetSpriteXByOffset(cd.codePanel.panel), GetSpriteYByOffset(cd.codePanel.panel))				
				coSetSpriteColor(cd.codeScroll, co.grey[3])
				SetSpriteDepth(cd.codeScroll, GetSpriteDepth(cd.codePanel.panel) - 2)
				SetSpriteVisible(cd.codeScroll, true)

				cx = cd.codePanel.cx
				cy = cd.codePanel.cy
				cw = cd.codePanel.cw
				ch = cd.codePanel.ch

				dx = 0
				dy = 0
				
				if cd.scrollZone && DIR_W
					
					cx = cx + CD_CODE_SCROLL_DIST

					if cx > 0

						dx = CD_CODE_SCROLL_DIST
						cx = cx - CD_CODE_SCROLL_DIST

					endif
					
				endif
				
				if cd.scrollZone && DIR_E
					
					cx = cx - CD_CODE_SCROLL_DIST
					cw = cw + CD_CODE_SCROLL_DIST

				endif

				if cd.scrollZone && DIR_N
					
					cy = cy + CD_CODE_SCROLL_DIST

					if cy > 0

						dy = CD_CODE_SCROLL_DIST
						cy = cy - CD_CODE_SCROLL_DIST

					endif

				endif

				if cd.scrollZone && DIR_S
					
					cy = cy - CD_CODE_SCROLL_DIST
					ch = ch + CD_CODE_SCROLL_DIST

				endif

				if dx > 0 or dy > 0
					
					for i = 0 to ma.things[cd.thingIdx].cmds.length

						cmd = ma.things[cd.thingIdx].cmds[i]
						ma.cmds[cmd].ox = ma.cmds[cmd].ox + dx
						ma.cmds[cmd].oy = ma.cmds[cmd].oy + dy

					next

				endif

				cd.codePanel.cx = cx
				cd.codePanel.cy = cy
				cd.codePanel.cw = cw
				cd.codePanel.ch = ch
				cdMoveCode()

				guiSetPanelBarsVisible(cd.codePanel, false)
				
				//cdDrawCode("x", 0) // Because scrollZone is non-zero, this will consider it in the draw.
				cd.scrollTime = GetMilliseconds() + CD_CODE_SCROLL_TIME
				
			endif
			
		else

			cd.scrollZone = 0
			
		endif

	else

		cd.scrollZone = 0
		
	endif

	if not cd.scrollZone		
		SetSpriteVisible(cd.codeScroll, false)
	endif
	
endfunction

//-----------------------------------------------------
// Check if currCmd is dragged over cmd.
//
function cdCheckOverCodeCmd(cmd ref as Cmd, x as float, y as float)

	local over as integer
	local press as CmdPress
	local typ as integer
	local code as integer
	local partTyp as integer
	local thingIdx as integer
	local varIdx as integer
	local tc as AgkTmpCmd

	over = 0
	code = ma.cmds[cd.currCmds[0]].code
	typ = ma.cmds[cd.currCmds[0]].typ && (CMD_STMT || CMD_OPER || CMD_COND)
	
	if cmd.codeTab
		
		if cdIsCodeCmdVisiblePtr(cmd)

			if typ = CMD_STMT
				
				over = cdIsOverCodeCmdPtr(ma.cmds[cd.currCmds[0]], cmd)

				if over
					cdSetCmdHoverPtr(cmd, over)
				endif

			elseif typ = CMD_OPER

				press.cmd = cmd.idx
				press.partIdx = -1
				press.parentCmd = cd.currCmds[0] // The one to check if over cmd.

				cdGetCmdPressed(true, press, x, y, 0)

				if press.cmd > -1 and press.partIdx > -1

					partTyp = ma.cmds[press.cmd].parts[press.partIdx].typ
					
					if partTyp <> PART_BOOL // Can only drop conds on bools.

						if partTyp = PART_APP
							
							if code = CODE_APP_BASE
								over = cdSetPartSelected(press.cmd, press.partIdx)
							endif
							
						elseif partTyp = PART_SPRITE

							if code = CODE_SPRITE_BASE
								over = cdSetPartSelected(press.cmd, press.partIdx)
							endif
							
						elseif partTyp = PART_FRAME

							if code = CODE_FRAME_BASE

								thingIdx = cdGetPartFrameThing(ma.cmds[cd.currCmds[0]].parts[0].info)

								if thingIdx = cd.thingIdx
									over = cdSetPartSelected(press.cmd, press.partIdx)
								endif

							endif
							
						elseif partTyp = PART_SOUND

							if code = CODE_SOUND_BASE
								over = cdSetPartSelected(press.cmd, press.partIdx)
							endif

						elseif partTyp = PART_VIDEO

							if code = CODE_VIDEO_BASE
								over = cdSetPartSelected(press.cmd, press.partIdx)
							endif
							
						elseif partTyp = PART_VAR

							if code = CODE_VAR_GET
								varIdx = cdGetPartAsInt(ma.cmds[cd.currCmds[0]].parts[0])
								if ma.vars[varIdx].typ = VAR_TYPE_VALUE
									over = cdSetPartSelected(press.cmd, press.partIdx)
								elseif ma.vars[varIdx].typ = VAR_TYPE_LIST
									over = cdSetPartSelected(press.cmd, press.partIdx)
								endif
							elseif ld.set.tmpVarsAllowed
								if code = CODE_DATA_GET_TMP_VAR
									//varIdx = cdGetPartAsInt(ma.cmds[cd.currCmds[0]].parts[0])
									//if ma.vars[varIdx].typ = VAR_TYPE_VALUE
										over = cdSetPartSelected(press.cmd, press.partIdx)
									//endif
								endif	
							endif							

						elseif partTyp = PART_VALUE

							if code = CODE_VAR_GET
								varIdx = cdGetPartAsInt(ma.cmds[cd.currCmds[0]].parts[0])
								if ma.vars[varIdx].typ = VAR_TYPE_VALUE
									over = cdSetPartSelected(press.cmd, press.partIdx)
								endif
							elseif AGK_BUILD
								if agAgkFindTmpCmd(code, 0, tc) // if ag.tmpCmds[0] and code = ma.cmds[ag.tmpCmds[0]].code				
									over = cdSetPartSelected(press.cmd, press.partIdx)
								endif
							elseif ld.set.tmpVarsAllowed
								if code = CODE_DATA_GET_TMP_VAR
									//varIdx = cdGetPartAsInt(ma.cmds[cd.currCmds[0]].parts[0])
									//if ma.vars[varIdx].typ = VAR_TYPE_VALUE
										over = cdSetPartSelected(press.cmd, press.partIdx)
									//endif
								endif								
							endif

						elseif partTyp = PART_LIST

							if code = CODE_VAR_GET
								varIdx = cdGetPartAsInt(ma.cmds[cd.currCmds[0]].parts[0])
								if ma.vars[varIdx].typ = VAR_TYPE_LIST
									over = cdSetPartSelected(press.cmd, press.partIdx)
								endif
							elseif AGK_BUILD
								if agAgkFindTmpCmd(code, 1, tc) // if ag.tmpCmds[1] and code = ma.cmds[ag.tmpCmds[1]].code		
									over = cdSetPartSelected(press.cmd, press.partIdx)
								endif
							elseif ld.set.tmpVarsAllowed
								if code = CODE_DATA_GET_TMP_LIST
									//varIdx = cdGetPartAsInt(ma.cmds[cd.currCmds[0]].parts[0])
									//if ma.vars[varIdx].typ = VAR_TYPE_LIST
										over = cdSetPartSelected(press.cmd, press.partIdx)
									//endif
								endif	
							endif

						elseif partTyp = PART_OBJ

							//if code = CODE_VAR_GET
							//	over = cdSetPartSelected(press.cmd, press.partIdx)
							//endif
							// Do nothing.

						elseif not (ma.cmds[cd.currCmds[0]].typ && CMD_SPEC) /*and code <> CODE_VAR_GET*/ and code <> CODE_SOUND_BASE and code <> CODE_VIDEO_BASE

							// If drag cmd is spec, it can only go over certain parts.
							over = cdSetPartSelected(press.cmd, press.partIdx)								

						endif
												
					endif
									
				endif

			elseif typ = CMD_COND

				press.cmd = cmd.idx
				press.partIdx = -1
				press.parentCmd = cd.currCmds[0] // The one to check if over cmd.
				
				cdGetCmdPressed(true, press, x, y, 0)

				if press.cmd > -1 and press.partIdx > -1
					if ma.cmds[press.cmd].parts[press.partIdx].typ = PART_BOOL
						over = cdSetPartSelected(press.cmd, press.partIdx)
					endif
				endif
				
			endif

		else

			// Possible scroll required.
			
		endif

	endif

endfunction over

//-----------------------------------------------------
// Check if the passed cmd in the code panel is visible.
//
function cdIsCodeCmdVisiblePtr(cmd ref as Cmd)

	local ret as integer
	
	// Make sure the cmd being dragged over is visible.
	if GetSpriteCollision(cmd.bg, cd.codePanel.panel)
		ret = true
	else
		ret = false
	endif

endfunction ret

//-----------------------------------------------------
// Check if the cmd1 overlaps cmd2.
// ret = 0 for no overlap, 1 for top half, 2 for bottom half.
//
function cdIsOverCodeCmdPtr(cmd1 ref as Cmd, cmd2 ref as Cmd)

	local ret as integer
	local gap as float

	gap = CD_CMD_GAP

	if coRectOverlapsRect(cmd1.x, cmd1.y, cmd1.w, cmd1.h, cmd2.x - gap, cmd2.y - gap, cmd2.w + gap * 2, cmd2.h + gap * 2)

		if cmd1.y + cmd1.h / 2 < cmd2.y + cmd2.h / 2
			ret = 1
		else
			ret = 2
		endif

		//if cmd1.grp = GRP_BEGIN
		//	ret = 0
		//endif
		
	else

		ret = 0

	endif

endfunction ret

//-----------------------------------------------------
// Check if the cmd overlaps code panel.
//
function cdIsCmdOverCodePanel()

	local ret as integer
	local x as float
	local y as float
	local cmd as integer

	ret = false

	if cd.currCmds.length > -1 and cd.fileTab = CD_FILE_TAB_CODE

		cmd = cd.currCmds[0]

		// If we have somewhere selected for attachment, it's good.
		if cd.attachCmd and ma.cmds[cd.attachCmd].codeTab

			ret = true

		else
			
			x = in.ptrX
			y = in.ptrY

			if coPointWithinRect(x, y, getspritex(cd.codePanel.panel), getspritey(cd.codePanel.panel), getspritewidth(cd.codePanel.panel), GetSpriteHeight(cd.codePanel.panel))
				ret = true
			endif

		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// Check if a libitem overlaps thing panel.
//
function cdIsLibItemOverThingPanel(x as float, y as float)

	local ret as integer
	//local x as float
	//local y as float

	ret = false

	if cd.currLibItem.visible

		//x = cd.currLibItem.x
		//y = cd.currLibItem.y

		if coPointWithinRect(x, y, getspritex(cd.cmdPanels[cd.thingTab].panel), getspritey(cd.cmdPanels[cd.thingTab].panel), getspritewidth(cd.cmdPanels[cd.thingTab].panel), GetSpriteHeight(cd.cmdPanels[cd.thingTab].panel))
			ret = true
		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// Check if a thing overlaps the thing panel.
//
function cdIsThingOverThingPanel(x as float, y as float)

	local ret as integer
	//local x as float
	//local y as float
	local cmd as integer

	ret = false

	if cd.currCmds.length > -1
			
		//x = in.ptrX
		//y = in.ptrY

		if coPointWithinRect(x, y, getspritex(cd.cmdPanels[cd.thingTab].panel), getspritey(cd.cmdPanels[cd.thingTab].panel), getspritewidth(cd.cmdPanels[cd.thingTab].panel), GetSpriteHeight(cd.cmdPanels[cd.thingTab].panel))
			if cd.thingTab = GRP_SPRITE and cdIsSpriteOrFrameCmd(cd.currCmds[0])
				ret = true
			elseif cd.thingTab = GRP_VAR and cdIsVarOrValueCmd(cd.currCmds[0])
				ret = true
			endif
		endif
		
	endif

endfunction ret

//-----------------------------------------------------
// Check if the cmd is a sprite or frame cmd.
//
function cdIsSpriteOrFrameCmd(cmd as integer)

	local ret as integer
	
	if (ma.cmds[cmd].code = CODE_SPRITE_BASE or ma.cmds[cmd].code = CODE_FRAME_BASE) and not ma.cmds[cmd].codeTab
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Check if the cmd is a var or var value cmd.
//
function cdIsVarOrValueCmd(cmd as integer)

	local ret as integer
	
	if (ma.cmds[cmd].code = CODE_VAR_GET or ma.cmds[cmd].code = CODE_VAR_VALUE) and not ma.cmds[cmd].codeTab
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Returns true if the key is repeatable.
//
function cdIsKeyRepeatable(scanCode as integer)

	local rep as integer
	
	if scanCode = KEY_SHIFT or scanCode = KEY_CTRL_UNSHIFT or scanCode = KEY_CTRL_123 or scanCode = KEY_CTRL_ABC or scanCode = KEY_CTRL_SYM
		rep = false
	else
		rep = true
	endif

endfunction rep

//-----------------------------------------------------
// Enact the double-tap code selection action, i.e. reduce selected cmds to 1 only.
//
function cdDoubleTapCode()

	local m as integer
	local cmd as integer
	local cmd2 as integer
	local cmds as integer[]
	
	if cd.currCmds.length > -1
		
		// Flush and reset to one cmd only.
		cmd = cd.currCmds[0]

		if maIsOpenCode(ma.cmds[cmd].code)
			
			cmd2 = ma.cmds[cmd].closeCmd

			// Allow grabbing a loop/if construct, if it has no code inside it.
			if cd.currCmds[1] <> cmd2
				cmd = 0 // Has code inside, disable doubletap.
			endif
						
		endif

		if cmd
			
			cd.currCmds.remove(0)

			if cmd2
				cd.currCmds.remove(0)
			endif

			cdRestoreCmds(cd.currCmds)			
			cd.currCmds.length = -1
			cd.currCmds.insert(cmd)

			if cmd2
				cd.currCmds.insert(cmd2)
			endif

		endif

	endif

endfunction

//-----------------------------------------------------
// Move command.
//
function cdMoved(x as float, y as float)

	local pos as integer
	local w as float
	local h as float
	local press as CmdPress
	local info as string
	local selCmdIdx as integer
	local typ as integer
	local idx as integer
	local i as integer
	local m as integer
	local dt as integer
	local appIdx as integer
	local over as integer
	local clip as integer
	local cmd as integer
	local doubleTap as integer
	local valid as integer
	local xx as float
	local yy as float
	local ww as float
	local hh as float
	local zs as float
	local varIdx as integer
	local tc as AgkTmpCmd
	
	if cd.choosingImage
		exitfunction
	endif

	m = GetMilliseconds()
	dt = m - cd.waitStart
	
	if cdIsEditActive()

		if cd.editMode <> CD_EDIT_TAGS
			
			if not ld.set.trueEdit

				if cd.editClickPos1 > -1
					
					cd.editClickPos2 = cdSetEditClick(x)
					cdSetEditCursorSelection(true)
					
				else

					if cdIsKeyRepeatable(cd.scanCode)

						// Only need for repeat.
						cdHandleKeyboard(x, y)

					endif
						
				endif

				if cd.editMode = CD_EDIT_COLOR
		
					if cd.colInc	
						if dt > CD_CODE_HOLD_TIME												
							cdIncColorEditBox(x, y)					
						endif			
					endif
				
				endif

			endif

		endif
		
		exitfunction

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_IMAGE

//xxx
		if coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST
				
			guiPanelPressed(cd.loadPanel, cd.waitX, cd.waitY, GUI_PANEL_ALL)
			cd.mode = CD_MODE_LOAD_PANEL

		endif

	endif
		
	//if cd.mode = CD_MODE_TAB

	if cd.mode = CD_MODE_DRAG_CMD

		cdDrawCmds(cd.currCmds, x, y)
		cdCheckOverCode(x, y)
		cdCheckCodeScroll(x, y)

	elseif cd.mode = CD_MODE_DRAG_CODE

		cdDrawCmds(cd.currCmds, x, y)
		cdCheckOverCode(x, y)
		cdCheckCodeScroll(x, y)

	elseif cd.mode = CD_MODE_DRAG_SPRITE

		cdDrawCmds(cd.currCmds, x, y)

		if cdCheckOverCodePanel(x, y)
			
			cdCheckOverCode(x, y)			
			cdCheckCodeScroll(x, y)

		else
			
			cdCheckOverThings(x, y)
			cdCheckThingScroll(x, y)

		endif

	elseif cd.mode = CD_MODE_DRAG_SOUND

		cdDrawCmds(cd.currCmds, x, y)
		cdCheckOverCode(x, y)
		cdCheckCodeScroll(x, y)

	elseif cd.mode = CD_MODE_DRAG_VIDEO

		cdDrawCmds(cd.currCmds, x, y)
		cdCheckOverCode(x, y)
		cdCheckCodeScroll(x, y)

	elseif cd.mode = CD_MODE_DRAG_VAR

		cdDrawCmds(cd.currCmds, x, y)
		cdCheckOverCode(x, y)
		cdCheckCodeScroll(x, y)

	elseif cd.mode = CD_MODE_DRAG_VAR_VALUE

		cdDrawCmds(cd.currCmds, x, y)			
		cdCheckOverThings(x, y)
		cdCheckThingScroll(x, y)

	elseif cd.mode = CD_MODE_DRAG_FRAME

		cdDrawCmds(cd.currCmds, x, y)

		if cdCheckOverCodePanel(x, y)
			
			cdCheckOverCode(x, y)			
			cdCheckCodeScroll(x, y)

		else
			
			cdCheckOverThings(x, y)
			cdCheckThingScroll(x, y)

		endif

	elseif cd.mode = CD_MODE_DRAG_ITEM

		cdDrawLibItem(cd.currLibItem, x, y)
		cdCheckOverThings(x, y)
		cdCheckThingScroll(x, y)

	elseif cd.mode = CD_MODE_HELP_BAR

		guiCheckBarPressed(cd.helpBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_VAR_BAR

		guiCheckBarPressed(cd.varBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_VAR_VALUE_BAR

		guiCheckBarPressed(cd.varValueBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_CODE_BAR

		guiCheckBarPressed(cd.cmdBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_CODE_PANEL_BAR

		guiCheckBarPressed(cd.codeBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_APP_BAR

		guiCheckBarPressed(cd.appBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_SPRITE_BAR

		guiCheckBarPressed(cd.spriteBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_FRAME_BAR

		guiCheckBarPressed(cd.frameBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_SOUND_BAR

		guiCheckBarPressed(cd.soundBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_VIDEO_BAR

		guiCheckBarPressed(cd.videoBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_IMAGE_ITEM_BAR

		guiCheckBarPressed(cd.imageItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_IMAGE_BLANK_ITEM_BAR

		guiCheckBarPressed(cd.imageBlankItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_FOLDER_ITEM_BAR

		guiCheckBarPressed(cd.folderItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_SOUND_ITEM_BAR

		guiCheckBarPressed(cd.soundItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_VIDEO_ITEM_BAR

		guiCheckBarPressed(cd.videoItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_VAR_ITEM_BAR

		guiCheckBarPressed(cd.varItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_VAR_VALUE_ITEM_BAR

		guiCheckBarPressed(cd.varValueItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_PROJ_ITEM_BAR

		guiCheckBarPressed(cd.projItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_PROJ_BLANK_ITEM_BAR

		guiCheckBarPressed(cd.projBlankItemBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_PART_BAR

		guiCheckBarPressed(cd.partBar, in.ptrX, in.ptrY, 2)

	elseif cd.mode = CD_MODE_WAIT_APP

		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			If not WIN_MODE and dt <= CD_CODE_DRAG_TIME
				
				guiPanelPressed(cd.appPanel, cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_APP_PANEL

			elseif cd.currCmds.length > -1
				
				cd.mode = CD_MODE_DRAG_APP

			endif
	
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)
			
			cd.mode = CD_MODE_APP_BAR
			x = cdGetCmdPosX(ma.apps[cd.waitIdx].cmd)
			y = cdGetCmdPosY(ma.apps[cd.waitIdx].cmd)
			w = ma.cmds[ma.apps[cd.waitIdx].cmd].w
			h = ma.cmds[ma.apps[cd.waitIdx].cmd].h

			valid = true
			
			if ma.apps[cd.waitIdx].status && LD_STATUS_LOCKED
				valid = false
			endif

			idx = guiFindBarButtonById(cd.appBar, BUT_CODER_APP_ADDLIB)

			if idx > -1								
				guiSetButtonActive(cd.appBar.buts[idx], valid)
			endif

			idx = guiFindBarButtonById(cd.appBar, BUT_CODER_APP_ADDEX)

			if idx > -1								
				guiSetButtonActive(cd.appBar.buts[idx], valid)
			endif
	
			idx = guiFindBarButtonById(cd.appBar, BUT_CODER_APP_DUP)
			guiSetButtonActive(cd.appBar.buts[idx], valid || (ma.apps[cd.waitIdx].status && LD_STATUS_EXAMPLE))
		
			idx = guiFindBarButtonById(cd.appBar, BUT_CODER_APP_RENAME)
			guiSetButtonActive(cd.appBar.buts[idx], valid)
			idx = guiFindBarButtonById(cd.appBar, BUT_CODER_APP_DELETE)
			guiSetButtonActive(cd.appBar.buts[idx], valid)
			idx = guiFindBarButtonById(cd.appBar, BUT_CODER_APP_CLOSE)
			guiSetButtonActive(cd.appBar.buts[idx], true)
				
			guiPopupBar(cd.appBar, x, y, w, h)
				
		endif
		
	elseif cd.mode = CD_MODE_WAIT_SPRITE

		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.things[cd.waitIdx].cmd, x, y)
				endif
			endif
	
			if cd.currCmds.length > -1
				
				cd.mode = CD_MODE_DRAG_SPRITE
				cdFixDragSpec(cd.currCmds[0])

			elseif not WIN_MODE // If dt <= CD_CODE_DRAG_TIME
				
				guiPanelPressed(cd.cmdPanels[GRP_SPRITE], cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_THING_PANEL

			endif
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.things[cd.waitIdx].cmd, x, y)
				endif
			endif

			cd.mode = CD_MODE_SPRITE_BAR
			x = cdGetCmdPosX(ma.things[cd.waitIdx].cmd)
			y = cdGetCmdPosY(ma.things[cd.waitIdx].cmd)
			w = ma.cmds[ma.things[cd.waitIdx].cmd].w
			h = ma.cmds[ma.things[cd.waitIdx].cmd].h
			
			if ma.apps[cd.appIdx].status && LD_STATUS_LOCKED

				idx = guiFindBarButtonById(cd.spriteBar, BUT_CODER_THING_EDIT)
				guiSetButtonActive(cd.spriteBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.spriteBar, BUT_CODER_THING_DUP)
				guiSetButtonActive(cd.spriteBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.spriteBar, BUT_CODER_THING_REMOVE)
				guiSetButtonActive(cd.spriteBar.buts[idx], false)

			else 

				idx = guiFindBarButtonById(cd.spriteBar, BUT_CODER_THING_EDIT)
				guiSetButtonActive(cd.spriteBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.spriteBar, BUT_CODER_THING_DUP)
				guiSetButtonActive(cd.spriteBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.spriteBar, BUT_CODER_THING_REMOVE)
				guiSetButtonActive(cd.spriteBar.buts[idx], true)
								
			endif
						
			guiPopupBar(cd.spriteBar, x, y, w, h)
				
		elseif coAnyDown2() // if dt > CD_CODE_DRAG_TIME

			if cd.currCmds.length = -1
				cdLiftCmd(ma.things[cd.waitIdx].cmd, x, y)
			endif
			
		endif
		
	elseif cd.mode = CD_MODE_WAIT_FRAME
				
		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.things[cd.waitIdx].imgs[cd.waitIdx2].cmd, x, y)
				endif
			endif

			if cd.currCmds.length > -1
					
				cd.mode = CD_MODE_DRAG_FRAME
				cdFixDragSpec(cd.currCmds[0])

			elseif not WIN_MODE // If dt <= CD_CODE_DRAG_TIME
				
				guiPanelPressed(cd.cmdPanels[GRP_SPRITE], cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_THING_PANEL

			endif
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.things[cd.waitIdx].imgs[cd.waitIdx2].cmd, x, y)
				endif
			endif

			cd.mode = CD_MODE_FRAME_BAR
			x = cdGetCmdPosX(ma.things[cd.waitIdx].imgs[cd.waitIdx2].cmd)
			y = cdGetCmdPosY(ma.things[cd.waitIdx].imgs[cd.waitIdx2].cmd)
			w = ma.cmds[ma.things[cd.waitIdx].imgs[cd.waitIdx2].cmd].w
			h = ma.cmds[ma.things[cd.waitIdx].imgs[cd.waitIdx2].cmd].h
			
			if ma.apps[cd.appIdx].status && LD_STATUS_LOCKED

				idx = guiFindBarButtonById(cd.frameBar, BUT_CODER_IMAGE_EDIT)
				guiSetButtonActive(cd.frameBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.frameBar, BUT_CODER_IMAGE_DUP)
				guiSetButtonActive(cd.frameBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.frameBar, BUT_CODER_IMAGE_REMOVE)
				guiSetButtonActive(cd.frameBar.buts[idx], false)

			else 

				idx = guiFindBarButtonById(cd.frameBar, BUT_CODER_IMAGE_EDIT)
				guiSetButtonActive(cd.frameBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.frameBar, BUT_CODER_IMAGE_DUP)
				guiSetButtonActive(cd.frameBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.frameBar, BUT_CODER_IMAGE_REMOVE)
				guiSetButtonActive(cd.frameBar.buts[idx], true)
								
			endif

			idx = guiFindBarButtonById(cd.frameBar, BUT_CODER_IMAGE_REMOVE)

			if idx > -1
				// If only one frame, don't allow delete of it.
				guiSetButtonActive(cd.frameBar.buts[idx], ma.things[cd.waitIdx].imgs.length > 0)
			endif
			
			guiPopupBar(cd.frameBar, x, y, w, h)
				
		elseif coAnyDown2() // if dt > CD_CODE_DRAG_TIME

			if cd.currCmds.length = -1
				cdLiftCmd(ma.things[cd.waitIdx].imgs[cd.waitIdx2].cmd, x, y)
			endif
			
		endif
				
	elseif cd.mode = CD_MODE_WAIT_SOUND

		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.sounds[cd.waitIdx].cmd, x, y)
				endif
			endif

			if cd.currCmds.length > -1
				
				cd.mode = CD_MODE_DRAG_SOUND
				cdFixDragSpec(cd.currCmds[0])

			elseif not WIN_MODE // If dt <= CD_CODE_DRAG_TIME
				
				guiPanelPressed(cd.cmdPanels[GRP_SOUND], cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_THING_PANEL

			endif
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.sounds[cd.waitIdx].cmd, x, y)
				endif
			endif

			cd.mode = CD_MODE_SOUND_BAR
			x = cdGetCmdPosX(ma.sounds[cd.waitIdx].cmd)
			y = cdGetCmdPosY(ma.sounds[cd.waitIdx].cmd)
			w = ma.cmds[ma.sounds[cd.waitIdx].cmd].w
			h = ma.cmds[ma.sounds[cd.waitIdx].cmd].h
			
			if ma.apps[cd.appIdx].status && LD_STATUS_LOCKED

				idx = guiFindBarButtonById(cd.soundBar, BUT_CODER_THING_PLAY)
				guiSetButtonActive(cd.soundBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.soundBar, BUT_CODER_THING_DUP)
				guiSetButtonActive(cd.soundBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.soundBar, BUT_CODER_THING_REMOVE)
				guiSetButtonActive(cd.soundBar.buts[idx], false)

			else 

				idx = guiFindBarButtonById(cd.soundBar, BUT_CODER_THING_PLAY)
				guiSetButtonActive(cd.soundBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.soundBar, BUT_CODER_THING_DUP)
				guiSetButtonActive(cd.soundBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.soundBar, BUT_CODER_THING_REMOVE)
				guiSetButtonActive(cd.soundBar.buts[idx], true)
								
			endif
	
			guiPopupBar(cd.soundBar, x, y, w, h)
				
		elseif coAnyDown2() // if dt > CD_CODE_DRAG_TIME

			if cd.currCmds.length = -1
				cdLiftCmd(ma.sounds[cd.waitIdx].cmd, x, y)
			endif
			
		endif
		
	elseif cd.mode = CD_MODE_WAIT_VIDEO

		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.videos[cd.waitIdx].cmd, x, y)
				endif
			endif
			
			if cd.currCmds.length > -1
				
				cd.mode = CD_MODE_DRAG_VIDEO
				cdFixDragSpec(cd.currCmds[0])

			elseif not WIN_MODE // If dt <= CD_CODE_DRAG_TIME
				
				guiPanelPressed(cd.cmdPanels[GRP_VIDEO], cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_THING_PANEL

			endif
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.videos[cd.waitIdx].cmd, x, y)
				endif
			endif

			cd.mode = CD_MODE_VIDEO_BAR
			x = cdGetCmdPosX(ma.videos[cd.waitIdx].cmd)
			y = cdGetCmdPosY(ma.videos[cd.waitIdx].cmd)
			w = ma.cmds[ma.videos[cd.waitIdx].cmd].w
			h = ma.cmds[ma.videos[cd.waitIdx].cmd].h
			
			if ma.apps[cd.appIdx].status && LD_STATUS_LOCKED

				idx = guiFindBarButtonById(cd.videoBar, BUT_CODER_THING_EDIT)
				guiSetButtonActive(cd.videoBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.videoBar, BUT_CODER_THING_DUP)
				guiSetButtonActive(cd.videoBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.videoBar, BUT_CODER_THING_REMOVE)
				guiSetButtonActive(cd.videoBar.buts[idx], false)

			else 

				idx = guiFindBarButtonById(cd.videoBar, BUT_CODER_THING_EDIT)
				guiSetButtonActive(cd.videoBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.videoBar, BUT_CODER_THING_DUP)
				guiSetButtonActive(cd.videoBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.videoBar, BUT_CODER_THING_REMOVE)
				guiSetButtonActive(cd.videoBar.buts[idx], true)
								
			endif
	
			guiPopupBar(cd.videoBar, x, y, w, h)
				
		elseif coAnyDown2() // if dt > CD_CODE_DRAG_TIME

			if cd.currCmds.length = -1
				cdLiftCmd(ma.videos[cd.waitIdx].cmd, x, y)
			endif
			
		endif
		
	elseif cd.mode = CD_MODE_WAIT_VAR

		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.vars[cd.waitIdx].cmd, x, y)
				endif
			endif
			
			if cd.currCmds.length > -1
				
				cd.mode = CD_MODE_DRAG_VAR
				cdFixDragSpec(cd.currCmds[0])

			elseif not WIN_MODE // If dt <= CD_CODE_DRAG_TIME
				
				guiPanelPressed(cd.cmdPanels[GRP_VAR], cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_THING_PANEL

			endif
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.vars[cd.waitIdx].cmd, x, y)
				endif
			endif

			cd.mode = CD_MODE_VAR_BAR
			x = cdGetCmdPosX(ma.vars[cd.waitIdx].cmd)
			y = cdGetCmdPosY(ma.vars[cd.waitIdx].cmd)
			w = ma.cmds[ma.vars[cd.waitIdx].cmd].w
			h = ma.cmds[ma.vars[cd.waitIdx].cmd].h

			if ma.vars[cd.waitIdx].thingIdx = -1
				
				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_SHARE)

				if idx > -1
					guiSetButtonActive(cd.varBar.buts[idx], false)
				endif

				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_THING_ADDLIB)

				if idx > -1
					guiSetButtonActive(cd.varBar.buts[idx], true)
				endif

			else

				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_SHARE)

				if idx > -1
					guiSetButtonActive(cd.varBar.buts[idx], true)
				endif

				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_THING_ADDLIB)

				if idx > -1
					guiSetButtonActive(cd.varBar.buts[idx], false)
				endif

			endif

			if ma.vars[cd.waitIdx].typ = VAR_TYPE_LIST

				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_ADD)
				guiSetButtonActive(cd.varBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_CLEAR)
				guiSetButtonActive(cd.varBar.buts[idx], true)

				// TODO: Not ready for this yet.
				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_TO_OBJECT)
				if idx > -1
					guiSetButtonActive(cd.varBar.buts[idx], true)
				endif
				
			elseif ma.vars[cd.waitIdx].typ = VAR_TYPE_OBJECT

				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_ADD)
				guiSetButtonActive(cd.varBar.buts[idx], true)
				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_CLEAR)
				guiSetButtonActive(cd.varBar.buts[idx], true)

				// TODO: Not ready for this yet.
				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_TO_OBJECT)
				if idx > -1
					guiSetButtonActive(cd.varBar.buts[idx], false)
				endif

			elseif ma.vars[cd.waitIdx].typ = VAR_TYPE_VALUE

				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_ADD)
				guiSetButtonActive(cd.varBar.buts[idx], false)
				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_CLEAR)
				guiSetButtonActive(cd.varBar.buts[idx], false)

				// TODO: Not ready for this yet.
				idx = guiFindBarButtonById(cd.varBar, BUT_CODER_VAR_TO_OBJECT)
				if idx > -1
					guiSetButtonActive(cd.varBar.buts[idx], true)
				endif

			endif
			
			guiPopupBar(cd.varBar, x, y, w, h)
				
		elseif coAnyDown2() // if dt > CD_CODE_DRAG_TIME

			if cd.currCmds.length = -1
				cdLiftCmd(ma.vars[cd.waitIdx].cmd, x, y)
			endif
			
		endif
		
	elseif cd.mode = CD_MODE_WAIT_VAR_VALUE

		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.vars[cd.waitIdx].list[cd.waitIdx2].cmd, x, y)
				endif
			endif

			//If dt <= CD_CODE_DRAG_TIME
				
			//	guiPanelPressed(cd.cmdPanels[GRP_VAR], cd.waitX, cd.waitY, GUI_PANEL_ALL)
			//	cd.mode = CD_MODE_THING_PANEL

			//elseif cd.currCmds.length > -1
			if cd.currCmds.length > -1
				
				cd.mode = CD_MODE_DRAG_VAR_VALUE
				cdFixDragSpec(cd.currCmds[0])

			elseif not WIN_MODE // If dt <= CD_CODE_DRAG_TIME
				
				guiPanelPressed(cd.cmdPanels[GRP_VAR], cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_THING_PANEL

			endif
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(ma.vars[cd.waitIdx].list[cd.waitIdx2].cmd, x, y)
				endif
			endif

			cd.mode = CD_MODE_VAR_VALUE_BAR
			x = cdGetCmdPosX(ma.vars[cd.waitIdx].list[cd.waitIdx2].cmd)
			y = cdGetCmdPosY(ma.vars[cd.waitIdx].list[cd.waitIdx2].cmd)
			w = ma.cmds[ma.vars[cd.waitIdx].list[cd.waitIdx2].cmd].w
			h = ma.cmds[ma.vars[cd.waitIdx].list[cd.waitIdx2].cmd].h
			
			guiPopupBar(cd.varValueBar, x, y, w, h)
				
		elseif coAnyDown2() // if dt > CD_CODE_DRAG_TIME

			if cd.currCmds.length = -1
				cdLiftCmd(ma.vars[cd.waitIdx].list[cd.waitIdx2].cmd, x, y)
			endif
			
		endif

	elseif cd.mode = CD_MODE_WAIT_ITEM

		if cd.submode = CD_SUBMODE_EDIT_EDITOR_IMAGE
		
			// Do nothing.
				
		elseif coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if not cd.currLibItem.visible
					if not (ld.libItems[cd.fileItemIdx].typ && LD_ITEM_SUB_FOLDER) and not (ld.libItems[cd.fileItemIdx].typ && LD_ITEM_PARENT_FOLDER)
						cdLiftLibItem(ld.libItems[cd.fileItemIdx], x, y)
					endif
				endif
			endif

			if cd.currLibItem.visible

				cd.mode = CD_MODE_DRAG_ITEM

			elseif not WIN_MODE // If dt <= CD_CODE_DRAG_TIME
				
				guiPanelPressed(cd.loadPanel, cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_LOAD_PANEL
			
			endif

		elseif coRightDown(dt > CD_CODE_HOLD_TIME)
			
			if WIN_MODE
				if not cd.currLibItem.visible
					if not (ld.libItems[cd.fileItemIdx].typ && LD_ITEM_SUB_FOLDER) and not (ld.libItems[cd.fileItemIdx].typ && LD_ITEM_PARENT_FOLDER)
						cdLiftLibItem(ld.libItems[cd.fileItemIdx], x, y)
					endif
				endif
			endif

			if cd.mainTab = CD_TAB_APP

				if ld.libItems[cd.fileItemIdx].typ && LD_ITEM_SUB_FOLDER or ld.libItems[cd.fileItemIdx].typ && LD_ITEM_PARENT_FOLDER
					cd.mode = CD_MODE_FOLDER_ITEM_BAR
				else
					cd.mode = CD_MODE_PROJ_ITEM_BAR
				endif
				
				x = ld.libItems[cd.fileItemIdx].x
				y = ld.libItems[cd.fileItemIdx].y
				w = ld.libItems[cd.fileItemIdx].w
				h = ld.libItems[cd.fileItemIdx].h

				if cd.mode = CD_MODE_FOLDER_ITEM_BAR

					idx = guiFindBarButtonById(cd.folderItemBar, BUT_CODER_ITEM_FOLDER_RENAME)

					if idx > -1
						if ld.libItems[cd.fileItemIdx].status && LD_STATUS_LOCKED
							guiSetButtonActive(cd.folderItemBar.buts[idx], false)
						else
							guiSetButtonActive(cd.folderItemBar.buts[idx], true)
						endif
					endif
						
					guiPopupBar(cd.folderItemBar, x, y, w, h)

				elseif cd.mode = CD_MODE_PROJ_ITEM_BAR

					if ld.libItems[cd.fileItemIdx].status && LD_STATUS_BLANK

						cd.mode = CD_MODE_PROJ_BLANK_ITEM_BAR
						guiPopupBar(cd.projBlankItemBar, x, y, w, h)
						
					else

						//appIdx = maFindAppById(ld.libItems[cd.fileItemIdx].id)
						appIdx = ld.libItems[cd.fileItemIdx].appIdx

						if appIdx > -1
							
							idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_ADDLIB)

							if idx > -1
								
								cd.projItemBar.buts[idx].id = BUT_CODER_APP_OPEN
								
							else							

								idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_REMLIB)

								if idx > -1
									
									cd.projItemBar.buts[idx].id = BUT_CODER_APP_OPEN

								else

									idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_CLOSE)

									if idx > -1
										cd.projItemBar.buts[idx].id = BUT_CODER_APP_OPEN								
									endif
																	
								endif

							endif


							// Always reset to "open".
							idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_OPEN)

							if idx > -1

								guiSetButtonText(cd.projItemBar.buts[idx], "open")				
								guiSetButtonIcon(cd.projItemBar.buts[idx], cd.openImg)
								cd.projItemBar.buts[idx].help = cd.openAppHelp
								guiSetButtonActive(cd.projItemBar.buts[idx], true)

								if ma.apps[appIdx].loaded

									if (ld.libItems[cd.fileItemIdx].status && LD_STATUS_LIBRARY)

										guiSetButtonText(cd.projItemBar.buts[idx], "rem lib")				
										guiSetButtonIcon(cd.projItemBar.buts[idx], cd.removeImg)
										cd.projItemBar.buts[idx].id = BUT_CODER_APP_REMLIB
										cd.projItemBar.buts[idx].help = cd.remLibAppHelp

										if (ld.libItems[cd.fileItemIdx].status && LD_STATUS_MASTER_LIB)
											guiSetButtonActive(cd.projItemBar.buts[idx], false)
										else 
											guiSetButtonActive(cd.projItemBar.buts[idx], true)
										endif
										
									else
										
										guiSetButtonText(cd.projItemBar.buts[idx], "close")
										guiSetButtonIcon(cd.projItemBar.buts[idx], cd.closeImg)
										cd.projItemBar.buts[idx].id = BUT_CODER_APP_CLOSE
										cd.projItemBar.buts[idx].help = cd.closeAppHelp
										guiSetButtonActive(cd.projItemBar.buts[idx], true)
										
									endif
										
								endif

							endif

						endif

						idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_LIB_APP_DUP)
						guiSetButtonActive(cd.projItemBar.buts[idx], true)
						
						if not (ld.libItems[cd.fileItemIdx].status && LD_STATUS_LOCKED)
				
							idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_RENAME)
							guiSetButtonActive(cd.projItemBar.buts[idx], true)
							idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_DELETE)
							guiSetButtonActive(cd.projItemBar.buts[idx], true)
							idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_SHARE)
							if idx > -1
								guiSetButtonActive(cd.projItemBar.buts[idx], true)
							endif

							guiPopupBar(cd.projItemBar, x, y, w, h)

						else

							idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_RENAME)
							guiSetButtonActive(cd.projItemBar.buts[idx], false)
							idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_DELETE)
							guiSetButtonActive(cd.projItemBar.buts[idx], false)
							idx = guiFindBarButtonById(cd.projItemBar, BUT_CODER_APP_SHARE)
							if idx > -1
								guiSetButtonActive(cd.projItemBar.buts[idx], false)
							endif

							guiPopupBar(cd.projItemBar, x, y, w, h)
							
						endif

					endif

				endif

			elseif cd.mainTab = CD_TAB_THING

				if ld.libItems[cd.fileItemIdx].typ && LD_ITEM_SUB_FOLDER or ld.libItems[cd.fileItemIdx].typ && LD_ITEM_PARENT_FOLDER
					cd.mode = CD_MODE_FOLDER_ITEM_BAR
				elseif cd.thingTab = GRP_SPRITE
					cd.mode = CD_MODE_IMAGE_ITEM_BAR
				elseif cd.thingTab = GRP_SOUND
					cd.mode = CD_MODE_SOUND_ITEM_BAR
				elseif cd.thingTab = GRP_VIDEO
					cd.mode = CD_MODE_VIDEO_ITEM_BAR
				elseif cd.thingTab = GRP_VAR
					cd.mode = CD_MODE_VAR_ITEM_BAR
				endif
					
				x = ld.libItems[cd.fileItemIdx].x
				y = ld.libItems[cd.fileItemIdx].y
				w = ld.libItems[cd.fileItemIdx].w
				h = ld.libItems[cd.fileItemIdx].h

				//if cd.fileItemIdx > 0
	
				if cd.mode = CD_MODE_FOLDER_ITEM_BAR

					idx = guiFindBarButtonById(cd.folderItemBar, BUT_CODER_ITEM_FOLDER_RENAME)

					if idx > -1
						if ld.libItems[cd.fileItemIdx].status && LD_STATUS_LOCKED
							guiSetButtonActive(cd.folderItemBar.buts[idx], false)
						else
							guiSetButtonActive(cd.folderItemBar.buts[idx], true)
						endif
					endif
					
					guiPopupBar(cd.folderItemBar, x, y, w, h)

				elseif cd.mode = CD_MODE_IMAGE_ITEM_BAR
						
					if ld.libItems[cd.fileItemIdx].status && LD_STATUS_BLANK

						cd.mode = CD_MODE_IMAGE_BLANK_ITEM_BAR
						guiPopupBar(cd.imageBlankItemBar, x, y, w, h)

					elseif not (ld.libItems[cd.fileItemIdx].status && LD_STATUS_LOCKED) //and ld.libItems[cd.fileItemIdx].typ <> LD_ITEM_IMAGE_BUILTIN

						idx = guiFindBarButtonById(cd.imageItemBar, BUT_CODER_ITEM_DELETE)
						guiSetButtonActive(cd.imageItemBar.buts[idx], true)
						idx = guiFindBarButtonById(cd.imageItemBar, BUT_CODER_ITEM_RENAME)
						guiSetButtonActive(cd.imageItemBar.buts[idx], true)
						//idx = guiFindBarButtonById(cd.imageItemBar, BUT_CODER_ITEM_DUP)
						//guiSetButtonActive(cd.imageItemBar.buts[idx], true)

						guiPopupBar(cd.imageItemBar, x, y, w, h)

					else
						
						idx = guiFindBarButtonById(cd.imageItemBar, BUT_CODER_ITEM_DELETE)
						guiSetButtonActive(cd.imageItemBar.buts[idx], false)
						idx = guiFindBarButtonById(cd.imageItemBar, BUT_CODER_ITEM_RENAME)
						guiSetButtonActive(cd.imageItemBar.buts[idx], false)
						//idx = guiFindBarButtonById(cd.imageItemBar, BUT_CODER_ITEM_DUP)
						//guiSetButtonActive(cd.imageItemBar.buts[idx], false)

						guiPopupBar(cd.imageItemBar, x, y, w, h)

					endif
				
				elseif cd.mode = CD_MODE_SOUND_ITEM_BAR
					
					if not (ld.libItems[cd.fileItemIdx].status && LD_STATUS_LOCKED) //and ld.libItems[cd.fileItemIdx].typ <> LD_ITEM_SOUND_BUILTIN

						idx = guiFindBarButtonById(cd.soundItemBar, BUT_CODER_ITEM_DELETE)
						guiSetButtonActive(cd.soundItemBar.buts[idx], true)
						idx = guiFindBarButtonById(cd.soundItemBar, BUT_CODER_ITEM_RENAME)
						guiSetButtonActive(cd.soundItemBar.buts[idx], true)
						//idx = guiFindBarButtonById(cd.soundItemBar, BUT_CODER_ITEM_DUP)
						//guiSetButtonActive(cd.soundItemBar.buts[idx], true)

					else

						idx = guiFindBarButtonById(cd.soundItemBar, BUT_CODER_ITEM_DELETE)
						guiSetButtonActive(cd.soundItemBar.buts[idx], false)
						idx = guiFindBarButtonById(cd.soundItemBar, BUT_CODER_ITEM_RENAME)
						guiSetButtonActive(cd.soundItemBar.buts[idx], false)
						//idx = guiFindBarButtonById(cd.soundItemBar, BUT_CODER_ITEM_DUP)
						//guiSetButtonActive(cd.soundItemBar.buts[idx], false)

					endif

					guiPopupBar(cd.soundItemBar, x, y, w, h)
					
				elseif cd.mode = CD_MODE_VIDEO_ITEM_BAR

					if not (ld.libItems[cd.fileItemIdx].status && LD_STATUS_LOCKED) //and ld.libItems[cd.fileItemIdx].typ <> LD_ITEM_VIDEO_BUILTIN

						idx = guiFindBarButtonById(cd.videoItemBar, BUT_CODER_ITEM_DELETE)
						guiSetButtonActive(cd.videoItemBar.buts[idx], true)
						idx = guiFindBarButtonById(cd.videoItemBar, BUT_CODER_ITEM_RENAME)
						guiSetButtonActive(cd.videoItemBar.buts[idx], true)
						//idx = guiFindBarButtonById(cd.videoItemBar, BUT_CODER_ITEM_DUP)
						//guiSetButtonActive(cd.videoItemBar.buts[idx], true)

					else

						idx = guiFindBarButtonById(cd.videoItemBar, BUT_CODER_ITEM_DELETE)
						guiSetButtonActive(cd.videoItemBar.buts[idx], false)
						idx = guiFindBarButtonById(cd.videoItemBar, BUT_CODER_ITEM_RENAME)
						guiSetButtonActive(cd.videoItemBar.buts[idx], false)
						//idx = guiFindBarButtonById(cd.videoItemBar, BUT_CODER_ITEM_DUP)
						//guiSetButtonActive(cd.videoItemBar.buts[idx], false)

					endif

					guiPopupBar(cd.videoItemBar, x, y, w, h)
				
				elseif cd.mode = CD_MODE_VAR_ITEM_BAR

					if ld.libItems[cd.fileItemIdx].typ = LD_ITEM_VAR_VALUE

						cd.mode = CD_MODE_VAR_VALUE_ITEM_BAR

						idx = guiFindBarButtonById(cd.varValueItemBar, BUT_CODER_HELP_QUICK)

						if idx > -1
							cd.varValueItemBar.buts[idx].help = ld.libItems[cd.fileItemIdx].help
						endif

						guiPopupBar(cd.varValueItemBar, x, y, w, h)
						
					else
						
						idx = guiFindBarButtonById(cd.varItemBar, BUT_CODER_THING_NEW)

						if idx > -1
							cd.varItemBar.buts[idx].help = ld.libItems[cd.fileItemIdx].help
						endif

						guiPopupBar(cd.varItemBar, x, y, w, h)

					endif
					
				endif
				
			endif
			
		elseif coLeftDown2() // TEST fast drag if dt > CD_CODE_DRAG_TIME

			if not cd.currLibItem.visible
				if not (ld.libItems[cd.fileItemIdx].typ && LD_ITEM_SUB_FOLDER) and not (ld.libItems[cd.fileItemIdx].typ && LD_ITEM_PARENT_FOLDER)
					cdLiftLibItem(ld.libItems[cd.fileItemIdx], x, y)
				endif
			endif
			
		endif
		
	elseif cd.mode = CD_MODE_WAIT_CMD

		if not (ma.cmds[cd.selCmds[cd.waitIdx]].typ && CMD_BUT) and coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(cd.selCmds[cd.waitIdx], x, y)
				endif
			endif

			if cd.currCmds.length > -1

				cd.mode = 2

				if ma.cmds[cd.currCmds[0]].code = CODE_VAR_GET
					cdSetCmdCheckable(cd.currCmds[0], false)
				endif

			elseif not WIN_MODE // If dt <= CD_CODE_DRAG_TIME
								
				guiPanelPressed(cd.cmdPanels[cd.grpTab], cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_CMD_PANEL
				
			endif

		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(cd.selCmds[cd.waitIdx], x, y)
				endif
			endif
			
			if ma.cmds[cd.selCmds[cd.waitIdx]].code = CODE_VAR_GET

				cd.mode = CD_MODE_VAR_BAR
				x = cdGetCmdPosX(cd.selCmds[cd.waitIdx])
				y = cdGetCmdPosY(cd.selCmds[cd.waitIdx])
				w = ma.cmds[cd.selCmds[cd.waitIdx]].w
				h = ma.cmds[cd.selCmds[cd.waitIdx]].h
				guiPopupBar(cd.varBar, x, y, w, h)

			else

				cd.mode = CD_MODE_HELP_BAR
				x = cdGetCmdPosX(cd.selCmds[cd.waitIdx])
				y = cdGetCmdPosY(cd.selCmds[cd.waitIdx])
				w = ma.cmds[cd.selCmds[cd.waitIdx]].w
				h = ma.cmds[cd.selCmds[cd.waitIdx]].h
				cd.helpBar.buts[0].help = ma.cmds[cd.selCmds[cd.waitIdx]].help
				guiPopupBar(cd.helpBar, x, y, w, h)

			endif
			
		elseif coAnyDown2() // TEST immediate drag of cmd // if dt > CD_CODE_DRAG_TIME

			if cd.currCmds.length = -1
				cdLiftCmd(cd.selCmds[cd.waitIdx], x, y)
			endif
			
		endif
				
	elseif cd.mode = CD_MODE_WAIT_CODE

		doubleTap = false
		
		if cd.lastWaitCodeTime > 0

			m = GetMilliseconds()
			
			if m - cd.lastWaitCodeTime < CD_CODE_DOUBLE_TAP_TIME
				doubleTap = true
			endif
			
		endif
	
//xxx need to put back leftdown without code, but add elseif coLeftPress2()  code with left and right ifs			
		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(cd.waitIdx, x, y)
				endif
			endif

			if cd.currCmds.length > -1

				if doubleTap
					cdDoubleTapCode()
				endif
				
				cdDetachCmds(cd.currCmds)
				cdSaveCmds(CD_CLIP_LIFT)

				cd.mode = CD_MODE_DRAG_CODE
				cdDrawCode("eee", 0)

			elseif not WIN_MODE
				
				guiPanelPressed(cd.cmdPanels[cd.grpTab], cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_CMD_PANEL

			endif
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			if doubleTap
				cdDoubleTapCode()
			endif

			if WIN_MODE
				if cd.currCmds.length = -1
					cdLiftCmd(cd.waitIdx, x, y)
				endif
			endif

			if cd.waitIdx > -1
				
				cd.mode = CD_MODE_CODE_BAR
				x = cdGetCmdPosX(cd.waitIdx)
				y = cdGetCmdPosY(cd.waitIdx)
				w = ma.cmds[cd.waitIdx].w
				h = ma.cmds[cd.waitIdx].h
				guiPopupBar(cd.cmdBar, x, y, w, h)

			endif
			
		elseif coAnyDown2() // TEST faster select // if dt > CD_CODE_DRAG_TIME

			if doubleTap
				cdDoubleTapCode()
			endif

			if cd.currCmds.length = -1
				cdLiftCmd(cd.waitIdx, x, y)
			endif
			
		endif

	elseif cd.mode = CD_MODE_WAIT_CODE_PANEL

		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			if guiPanelPressed(cd.codePanel, x, y, GUI_PANEL_BARS)
				cd.mode = CD_MODE_CODE_PANEL			
			elseif not WIN_MODE and guiPanelPressed(cd.codePanel, cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_CODE_PANEL
			endif		
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			cd.mode = CD_MODE_CODE_PANEL_BAR
			cdShowTarget(x, y, 255)
			x = getspritex(cd.target)
			y = getspritey(cd.target)
			w = GetSpriteWidth(cd.target)
			h = GetSpriteHeight(cd.target)

			idx = guiFindBarButtonById(cd.codeBar, BUT_CODER_PASTE)
			guiSetButtonActive(cd.codeBar.buts[idx], cd.clipFull)

			guiPopupBar(cd.codeBar, x, y, w, h)
							
		endif

	elseif cd.mode = CD_MODE_LIB_BUT

		if coRightDown(dt > CD_CODE_HOLD_TIME)

			cd.mode = CD_MODE_NONE

			if cd.mainTab = CD_TAB_APP
				cd.libraryBut.help = "This tab shows all projects in the library on your device. Press and hold on a project for options, or drag to the 'projects' panel."
			elseif cd.mainTab = CD_TAB_THING
				cd.libraryBut.help = "This tab shows all sprite images in the library on your device. Press and hold on a sprite for options, or drag to the 'sprites' panel."
			endif

			guiShowTip(gui.tip, cd.libraryBut.bg, cd.libraryBut.help, TIP_INFO, 0)
				
		endif

/*
	elseif cd.mode = CD_MODE_FILES_BUT

		if dt > CD_CODE_HOLD_TIME
			
			cd.mode = CD_MODE_NONE

			idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
			//if cd.subMode = CD_SUBMODE_NEW_APP
			if cd.subMode = CD_TAB_APP
				cd.toolBar.buts[idx].help = "This button should not be available."
			//elseif cd.subMode = CD_SUBMODE_NEW_THING
			elseif cd.mainTab = CD_TAB_THING
				cd.toolBar.buts[idx].help = "Open a dialog to select images from your device and save them into your library."
			endif

			guiShowTip(gui.tip, cd.toolBar.buts[idx].bg, cd.toolBar.buts[idx].help, TIP_INFO)
				
		endif
*/

/*
	elseif cd.mode = CD_MODE_SETTING_BUT

		if dt > CD_CODE_HOLD_TIME
			
			cd.mode = CD_MODE_NONE
			cd.settingsBut.help = "This tab shows settings for '" + co.appName + "'." 
			guiShowTip(gui.tip, cd.settingsBut.bg, cd.settingsBut.help, TIP_INFO)
				
		endif
*/
	elseif cd.mode = CD_MODE_APP_BUT

		if coRightDown(dt > CD_CODE_HOLD_TIME)
			
			cd.mode = CD_MODE_NONE
			//cd.appBut.help = "This tab shows open projects. Press and hold on a project for options." 
			guiShowTip(gui.tip, cd.appBut.bg, cd.appBut.help, TIP_INFO, 0)
				
		endif

	elseif cd.mode = CD_MODE_THING_BUT

		if coRightDown(dt > CD_CODE_HOLD_TIME)
			
			cd.mode = CD_MODE_NONE
			//cd.thingBut.help = "This tab shows sprites and frames used in this project. Press and hold on a sprite or frame for options." 
			guiShowTip(gui.tip, cd.thingBut.bg, cd.thingBut.help, TIP_INFO, 0)
				
		endif

	elseif cd.mode = CD_MODE_CMD_BUT

		if coRightDown(dt > CD_CODE_HOLD_TIME)
			
			cd.mode = CD_MODE_NONE
			//cd.cmdBut.help = "This tab shows commands you can use in your project. Press and hold on a command for help." 
			guiShowTip(gui.tip, cd.cmdBut.bg, cd.cmdBut.help, TIP_INFO, 0)
				
		endif

	elseif cd.mode = CD_MODE_CODE_BUT

		if coRightDown(dt > CD_CODE_HOLD_TIME)
			
			cd.mode = CD_MODE_NONE
			//cd.codeBut.help = "This tab shows code for the displayed sprite." 
			guiShowTip(gui.tip, cd.codeBut.bg, cd.codeBut.help, TIP_INFO, 0)
				
		endif

	elseif cd.mode = CD_MODE_HELP_BUT

		if coRightDown(dt > CD_CODE_HOLD_TIME)
			
			cd.mode = CD_MODE_NONE
			//cd.codeBut.help = "This tab shows code for the displayed sprite." 
			guiShowTip(gui.tip, cd.helpBut.bg, cd.helpBut.help, TIP_INFO, 0)
				
		endif

	elseif cd.mode = CD_MODE_MORE_BAR

		guiCheckBarPressed(cd.moreBar, in.ptrX, in.ptrY, 1)

	elseif cd.mode = CD_MODE_TOOL_BAR

		if coRightDown(dt > CD_CODE_HOLD_TIME)

			if cd.toolBar.buts[cd.waitIdx].id = BUT_CODER_RUN
				
			else 
				
				cd.mode = CD_MODE_NONE
	
				idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
	
				if cd.mainTab = CD_TAB_THING
					if cd.thingTab = GRP_SPRITE
						cd.toolBar.buts[idx].help = "Open a dialog to select images from your device and save them into your library."
					elseif cd.thingTab = GRP_SOUND
						cd.toolBar.buts[idx].help = "Open a dialog to select sounds from your device and save them into your library."
					elseif cd.thingTab = GRP_VIDEO
						cd.toolBar.buts[idx].help = "Open a dialog to select videos from your device and save them into your library."
					endif
				endif
				
				guiShowTip(gui.tip, cd.toolBar.buts[cd.waitIdx].bg, cd.toolBar.buts[cd.waitIdx].help, TIP_INFO, 0)
				
			endif
				
		endif

/*
	elseif cd.mode = CD_MODE_SETTINGS_BAR

		if dt > CD_CODE_HOLD_TIME

			cd.mode = CD_MODE_NONE			
			guiShowTip(gui.tip, cd.settingsBar.buts[cd.waitIdx].bg, cd.settingsBar.buts[cd.waitIdx].help, TIP_INFO)
				
		endif
*/
	elseif cd.mode = CD_MODE_THING

		if coRightDown(dt > CD_CODE_HOLD_TIME)
			
			cd.mode = CD_MODE_NONE
			guiShowTip(gui.tip, cd.thingBar.buts[cd.waitIdx - GRP_SPRITE].bg, cd.thingBar.buts[cd.waitIdx - GRP_SPRITE].help, TIP_INFO, 0)
				
		endif
	
	elseif cd.mode = CD_MODE_GRP

		if coRightDown(dt > CD_CODE_HOLD_TIME)
			
			cd.mode = CD_MODE_NONE
			guiShowTip(gui.tip, cd.grpBar.buts[cd.waitIdx].bg, cd.grpBar.buts[cd.waitIdx].help, TIP_INFO, 0)
				
		endif
	
	elseif cd.mode = CD_MODE_WAIT_PART

		if coLeftDown(coDist(cd.waitX, cd.waitY, x, y) > CD_CODE_HOLD_DIST)

			If not WIN_MODE and dt <= CD_CODE_DRAG_TIME

				guiPanelPressed(cd.codePanel, cd.waitX, cd.waitY, GUI_PANEL_ALL)
				cd.mode = CD_MODE_CODE_PANEL

			endif
			
		elseif coRightDown(dt > CD_CODE_HOLD_TIME)

			cd.mode = CD_MODE_PART_BAR
			x = getspritex(ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].spr)
			y = getspritey(ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].spr)
			w = getspritewidth(ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].spr)
			h = getspriteheight(ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].spr)

			cd.partBar.buts[1].help = cdGetPartHelp(ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx])

			clip = false

			if cd.clipFull
				
				if ma.cmds[cd.clip.cmds[0]].typ && CMD_OSTR

					typ = ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ
					
					if typ = PART_TXT or typ = PART_STR or typ = PART_COL
						clip = true
					endif
					
				elseif ma.cmds[cd.clip.cmds[0]].typ && CMD_OPER
					
					typ = ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ
					
					if typ = PART_INT or typ = PART_FLOAT or typ = PART_TXT or typ = PART_COL or typ = PART_FRAME
						
						clip = true
						
					elseif typ = PART_VAR
						
						if AGK_BUILD and (agAgkFindTmpCmd(ma.cmds[cd.clip.cmds[0]].code, 0, tc) or agAgkFindTmpCmd(ma.cmds[cd.clip.cmds[0]].code, 1, tc)) // ma.cmds[cd.clip.cmds[0]].code = ma.cmds[ag.tmpCmds[0]].code

						elseif ma.cmds[cd.clip.cmds[0]].code = CODE_DATA_GET_TMP_VAR or ma.cmds[cd.clip.cmds[0]].code = CODE_DATA_GET_TMP_LIST

							clip = true
							
						elseif ma.cmds[cd.clip.cmds[0]].code = CODE_VAR_GET
							
							varIdx = cdGetPartAsInt(ma.cmds[cd.clip.cmds[0]].parts[0])
							
							if ma.vars[varIdx].typ = VAR_TYPE_VALUE or ma.vars[varIdx].typ = VAR_TYPE_LIST
								clip = true
							endif
							
						endif

					elseif typ = PART_VALUE
						
						if AGK_BUILD and agAgkFindTmpCmd(ma.cmds[cd.clip.cmds[0]].code, 0, tc) // ma.cmds[cd.clip.cmds[0]].code = ma.cmds[ag.tmpCmds[0]].code
	
							clip = true
	
						elseif ma.cmds[cd.clip.cmds[0]].code = CODE_DATA_GET_TMP_VAR

							clip = true
							
						elseif ma.cmds[cd.clip.cmds[0]].code = CODE_VAR_GET
							
							varIdx = cdGetPartAsInt(ma.cmds[cd.clip.cmds[0]].parts[0])
							
							if ma.vars[varIdx].typ = VAR_TYPE_VALUE
								clip = true
							endif
							
						endif
						
					elseif typ = PART_LIST
						
						if AGK_BUILD and agAgkFindTmpCmd(ma.cmds[cd.clip.cmds[0]].code, 1, tc) // ma.cmds[cd.clip.cmds[0]].code = ma.cmds[ag.tmpCmds[1]].code
	
							clip = true
	
						elseif ma.cmds[cd.clip.cmds[0]].code = CODE_DATA_GET_TMP_LIST
	
							clip = true
	
						elseif ma.cmds[cd.clip.cmds[0]].code = CODE_VAR_GET
							
							varIdx = cdGetPartAsInt(ma.cmds[cd.clip.cmds[0]].parts[0])
							
							if ma.vars[varIdx].typ = VAR_TYPE_LIST
								clip = true
							endif
							
						endif
						
					endif
					
				elseif ma.cmds[cd.clip.cmds[0]].typ && CMD_COND

					typ = ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ
					
					if typ = PART_BOOL
						clip = true
					endif
					
				endif
				
			endif
					
			idx = guiFindBarButtonById(cd.partBar, BUT_CODER_PASTE_PART)
			guiSetButtonActive(cd.partBar.buts[idx], clip)
			guiPopupBar(cd.partBar, x, y, w, h)
							
		endif
				
	elseif cd.mode = CD_MODE_CMD_PANEL
							
		guiPanelMoved(cd.cmdPanels[cd.grpTab], x, y)

	elseif cd.mode = CD_MODE_CODE_PANEL

		guiPanelMoved(cd.codePanel, x, y)

	elseif cd.mode = CD_MODE_APP_PANEL

		guiPanelMoved(cd.appPanel, x, y)

	elseif cd.mode = CD_MODE_LOAD_PANEL

		guiPanelMoved(cd.loadPanel, x, y)

	elseif cd.mode = CD_MODE_THING_PANEL

		guiPanelMoved(cd.cmdPanels[cd.thingTab], x, y)

	elseif cd.mode = CD_MODE_HELP_PANEL

		guiPanelMoved(cd.helpPanel, x, y)

	//elseif cd.mode = CD_MODE_SETTINGS_PANEL

	//	guiPanelMoved(cd.settingsPanel, x, y)

	endif
	
endfunction

//-----------------------------------------------------
// Return quick help for the part.
//
function cdGetPartHelp(part ref as Part)

	local info as string
	
	if part.typ = PART_INT
		info = "This command value requires a whole number. Press to edit"
	elseif part.typ = PART_FLOAT
		info = "This command value requires a decimal number. Press to edit"
	elseif part.typ = PART_BOOL
		info = "This command value requires a boolean. Place a command here that returns true or false"
	elseif part.typ = PART_TXT
		info = "This command value requires arbitrary text. Press to edit"
	elseif part.typ = PART_COL
		info = "This command value requires a color. Place a command here that returns a color, or press to select a color"
	elseif part.typ = PART_APP
		info = "This command value requires a project. Place a project here"
	elseif part.typ = PART_SPRITE
		info = "This command value requires a sprite. Place a sprite here"
	elseif part.typ = PART_FRAME
		info = "This command value requires a frame. Place a frame here"
	elseif part.typ = PART_VALUE
		info = "This command value requires a value variable. Place a value variable here"
	elseif part.typ = PART_LIST
		info = "This command value requires a list variable. Place a list variable here"
	elseif part.typ = PART_SOUND
		info = "This command value requires a sound. Place a sound here"
	elseif part.typ = PART_VIDEO
		info = "This command value requires a video. Place a video here"
	else
		info = "Unknown part, no help"
	endif

endfunction info

//-----------------------------------------------------
// Remove all the parts around a spec cmd, for dragging.
//
function cdFixDragSpec(cmd as integer)

	local i as integer
	
	cdSetCmdFoldable(cmd, false)

	if ma.cmds[cmd].typ && CMD_SPEC // App, thing, etc.

		// Remove all extranious parts for drag.
		for i = ma.cmds[cmd].parts.length to 0 step -1
			
			if not (ma.cmds[cmd].parts[i].typ = PART_APP_ICON or ma.cmds[cmd].parts[i].typ = PART_SPRITE_ICON or ma.cmds[cmd].parts[i].typ = PART_FRAME_ICON)

				cdClearPart(ma.cmds[cmd].parts[i])
				ma.cmds[cmd].parts.remove(i)
				
			endif

			cdUpdateCmdSize(cmd)
			cdSetCmdPos(cmd, ma.cmds[cmd].x, ma.cmds[cmd].y)

		next

	elseif ma.cmds[cmd].code = CODE_VAR_GET

		cdSetCmdCheckable(cmd, false)
		
	endif

endfunction

//-----------------------------------------------------
// Show the target for code panel bar.
//
function cdShowTarget(x as float, y as float, alpha as integer)

	SetSpritePositionByOffset(cd.target, x, y)
	setspritecoloralpha(cd.target, alpha)
	SetSpriteDepth(cd.target, GUI_VALUE_DEPTH - 2)
	setspritevisible(cd.target, true)

endfunction

//-----------------------------------------------------
// Hide the thing.
//
function cdHideTarget()

	setspritevisible(cd.target, false)

endfunction

//-----------------------------------------------------
// Apply a lib item load for the passed file tab type.
//
function cdLoadFileTab()

	if cd.mainTab = CD_TAB_APP

		//cd.fileIdx = -1
		cdLoadAppItems()
		
	elseif cd.mainTab = CD_TAB_THING

		if cd.thingTab = GRP_SPRITE
			cdLoadSpriteItems(cd.fileTab)
		elseif cd.thingTab = GRP_SOUND
			cdLoadSoundItems()
		elseif cd.thingTab = GRP_VIDEO
			cdLoadVideoItems()
		elseif cd.thingTab = GRP_VAR
			cdLoadVarItems()
		endif
		
	endif

endfunction

//-----------------------------------------------------
// Released.
//
function cdReleased(x as float, y as float)

	local keyIdx as integer
	local t as integer
	local butId as integer
	local endCmd as integer
	local currCmd as integer
	local doSave as integer
	local code as integer
	local appIdx as integer
	local thingIdx as integer
	local imgIdx as integer
	local img as integer
	local mb as MemBlock
	local col as integer
	local w as float
	local h as float
	local x0 as float
	local y0 as float
	local idx as integer
	local prevEditErase as integer
	local selIdx as integer

	cd.pressed = false
	
	if cd.choosingImage
		
		exitfunction
	
	elseif cdIsEditActive()

		if cd.editMode <> CD_EDIT_TAGS
			
			cd.key = ""
			cd.scanCode = 0

			// Handle multiple clicks within timeframe, actual effect will be handled in cdUpdate.
			if cd.editClickTime > 0	
				if GetMilliseconds() - cd.editClickTime <= CO_EDIT_CLICK_DOUBLE_TAP_TIME
					inc cd.editClickCount
				endif
			endif
			
			if cd.editClickPos1 <> cd.editClickPos2

				if cd.editClickPos1 > cd.editClickPos2
					
					t = cd.editClickPos2
					cd.editClickPos2 = cd.editClickPos1
					cd.editClickPos1 = t

				endif

			else

				cdSetEditCursorSelection(false)
				
			endif
		
			cd.colInc = false

		endif
		
		exitfunction

	elseif cd.submode = CD_SUBMODE_EDIT_EDITOR_IMAGE

		if cd.mode = CD_MODE_WAIT_ITEM // Selected an image from editor.

			guiSetPanelVisible(cd.loadPanel, false)
			cdHideLibItems(ld.libItems)
			idx = guiFindBarButtonById(cd.toolBar, BUT_CODER_FILES)
			guiSetButtonVisible(cd.toolBar.buts[idx], false)			
			guiSetButtonVisible(cd.libraryBut, false)

			ma.passedStrs.insert(ld.libItems[cd.fileItemIdx].file)
			idx = ma.passedStrs.length	
			OnButtonAction(BUT_EDITOR_IMAGE, idx)
			cd.submode = CD_SUBMODE_NONE
			//cd.fileItemIdx = -1

		elseif cd.mode = CD_MODE_TOOL_BAR

			cdButtonAction(cd.toolBar.buts[cd.waitIdx].id, 0)

		endif
		
	elseif cd.mode = CD_MODE_SETTING_BUT

		if cd.mainTab <> CD_TAB_SETTINGS
		
			cd.mainTab = CD_TAB_SETTINGS
			cdSetTabVisible("k", true)

		endif

	elseif cd.mode = CD_MODE_APP_BUT

		if cd.mainTab <> CD_TAB_APP
		
			cd.mainTab = CD_TAB_APP
			cd.subMode = CD_SUBMODE_PRELOAD
			cdSetTabVisible("l", true)

		endif

	elseif cd.mode = CD_MODE_THING_BUT

		if cd.mainTab <> CD_TAB_THING
			
			if cd.appIdx > -1
				
				cd.mainTab = CD_TAB_THING
				cd.subMode = CD_SUBMODE_PRELOAD
				cdSetTabVisible("m", true)
				
			endif

		endif

	elseif cd.mode = CD_MODE_CMD_BUT

		if cd.mainTab <> CD_TAB_CMD
			
			cd.mainTab = CD_TAB_CMD
			cdSetTabVisible("n", true)

		endif

	elseif cd.mode = CD_MODE_HELP_BUT

		if cd.fileTab <> CD_FILE_TAB_HELP

			cd.fileTab = CD_FILE_TAB_HELP
			cdSetTabVisible("hhhh", true)

		endif
		
	elseif cd.mode = CD_MODE_CODE_BUT

		if cd.fileTab <> CD_FILE_TAB_CODE
	
			cd.fileTab = CD_FILE_TAB_CODE
			cdSetTabVisible("h", true)

		endif

	elseif cd.mode = CD_MODE_LIB_BUT

		if cd.fileTab <> CD_FILE_TAB_LIBRARY

			cd.fileTab = CD_FILE_TAB_LIBRARY			
			cd.subMode = CD_SUBMODE_PRELOAD
			cdSetTabVisible("hh", true)

		endif

	elseif cd.mode = CD_MODE_DRAG_ITEM

		cd.scrollZone = 0
		
		if cdIsLibItemOverThingPanel(x, y)
			
			cdDropLibItem()
			//doSave = true
			//cdSetTabVisible("dropLibItem", true)

		else // Drop not on thing panel.

			cdClearLibItem(cd.currLibItem)
			
		endif

		cdHideCmdHover()

	elseif cd.mode = CD_MODE_DRAG_CMD
			
		cd.scrollZone = 0
		
		if not GetSpriteVisible(cd.helpPanel.panel) and cdIsCmdOverCodePanel()
			
			cdDropCmd()
			doSave = true
			cdDrawCode("f", 0)

		else

			cdDeleteCmds(cd.currCmds)

		endif

		cdHideCmdHover()
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_DRAG_CODE

		cd.scrollZone = 0
		
		if cdIsCmdOverCodePanel()

			cdDropCmd()
			cdDrawCode("g", 0)
			doSave = true

		else

			cdClipDelete()
			doSave = true // Because we have just deleted commands.

		endif

		cdHideCmdHover()
		cd.currCmds.length = -1
		
	elseif cd.mode = CD_MODE_DRAG_SPRITE

		cd.scrollZone = 0
		SetSpriteVisible(cd.codeScroll, false)

		if cdIsCmdOverCodePanel()

			cdDropCmd()
			doSave = true
			cdDrawCode("h", 0)

		elseif cdIsThingOverThingPanel(x, y)

			cdDropLibItem()
			doSave = true
			//cdDrawCode("hh", 0)
			cdSetTabVisible("hh", true)

		else

			cdDeleteCmds(cd.currCmds)

		endif

		cdHideCmdHover()
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_DRAG_FRAME

		cd.scrollZone = 0
		SetSpriteVisible(cd.codeScroll, false)
			
		if cdIsCmdOverCodePanel()
			
			cdDropCmd()
			doSave = true
			cdDrawCode("i", 0)

		elseif cdIsThingOverThingPanel(x, y)

			cdDropLibItem()
			doSave = true
			//cdDrawCode("ii", 0)
			cdSetTabVisible("ii", true)

		else

			cdDeleteCmds(cd.currCmds)

		endif
		
		cdHideCmdHover()
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_DRAG_SOUND

		cd.scrollZone = 0
		SetSpriteVisible(cd.codeScroll, false)

		if cdIsCmdOverCodePanel()
			
			cdDropCmd()
			doSave = true
			cdDrawCode("sound", 0)

		else

			cdDeleteCmds(cd.currCmds)

		endif

		cdHideCmdHover()
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_DRAG_VIDEO

		cd.scrollZone = 0
		SetSpriteVisible(cd.codeScroll, false)

		if cdIsCmdOverCodePanel()
			
			cdDropCmd()
			doSave = true
			cdDrawCode("sound", 0)

		else

			cdDeleteCmds(cd.currCmds)

		endif

		cdHideCmdHover()
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_DRAG_VAR

		cd.scrollZone = 0
		SetSpriteVisible(cd.codeScroll, false)

		if cdIsCmdOverCodePanel()
			
			cdDropCmd()
			doSave = true
			cdDrawCode("var", 0)

		else

			cdDeleteCmds(cd.currCmds)

		endif

		cdHideCmdHover()
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_DRAG_VAR_VALUE

		cd.scrollZone = 0
		SetSpriteVisible(cd.codeScroll, false)

/*
		if cdIsCmdOverCodePanel()

			// TODO: Need to drop parent var, but set list item to this value.
			cdDropCmd()
			doSave = true
			cdDrawCode("var", 0)
*/
		if cdIsThingOverThingPanel(x, y)

			cdDropLibItem()
			doSave = true
			//cdDrawCode("vv", 0)
			cdSetTabVisible("vv", true)

		else

			cdDeleteCmds(cd.currCmds)

		endif

		cdHideCmdHover()
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_WAIT_CMD

		if ma.cmds[cd.selCmds[cd.waitIdx]].typ && CMD_BUT

			// Do nothing.
			
		else

			if cd.currCmds.length > -1
				cdDeleteCmds(cd.currCmds)
			else 
				cdRestoreCmds(cd.currCmds)
			endif
			
			cd.currCmds.length = -1

		endif

	elseif cd.mode = CD_MODE_WAIT_CODE

		cdRestoreCmds(cd.currCmds)
		cd.currCmds.length = -1
		cdDrawCode("wait code", 0)

		cd.lastWaitCodeTime = GetMilliseconds()
		
	elseif cd.mode = CD_MODE_WAIT_CODE_PANEL

		cdHideTarget()
		// Do nothing.
		
	elseif cd.mode = CD_MODE_WAIT_APP

		if ma.apps[cd.waitIdx].loaded

			appIdx = cd.waitIdx
			cdSelectApp(appIdx)

		endif

	elseif cd.mode = CD_MODE_WAIT_SPRITE

		if cd.currCmds.length > -1
			cdDeleteCmds(cd.currCmds)
		else 
			cdRestoreCmds(cd.currCmds)
		endif
		
		cd.currCmds.length = -1

		thingIdx = cd.waitIdx
		cdSelectThing(thingIdx)
		cdSetTabVisible("v", true)

	elseif cd.mode = CD_MODE_WAIT_FRAME

		if cd.currCmds.length > -1
			cdDeleteCmds(cd.currCmds)
		else 
			cdRestoreCmds(cd.currCmds)
		endif

		cd.currCmds.length = -1

		thingIdx = cd.waitIdx
		imgIdx = cd.waitIdx2
		cdSelectThingImage(thingIdx, imgIdx)
		cdSetTabVisible("w", true)

	elseif cd.mode = CD_MODE_WAIT_VAR

		if cd.currCmds.length > -1
			cdDeleteCmds(cd.currCmds)
		else 
			cdRestoreCmds(cd.currCmds)
		endif
		
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_WAIT_VAR_VALUE

		if cd.currCmds.length > -1
			cdDeleteCmds(cd.currCmds)
		else 
			cdRestoreCmds(cd.currCmds)
		endif
		
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_WAIT_SOUND

		if cd.currCmds.length > -1
			cdDeleteCmds(cd.currCmds)
		else 
			cdRestoreCmds(cd.currCmds)
		endif
		
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_WAIT_VIDEO

		if cd.currCmds.length > -1
			cdDeleteCmds(cd.currCmds)
		else 
			cdRestoreCmds(cd.currCmds)
		endif
		
		cd.currCmds.length = -1

	elseif cd.mode = CD_MODE_WAIT_ITEM

		if ld.libItems[cd.fileItemIdx].typ && LD_ITEM_SUB_FOLDER or ld.libItems[cd.fileItemIdx].typ && LD_ITEM_PARENT_FOLDER			
			
			cdNavigateFolder(cd.fileItemIdx)			
		
		elseif ld.libItems[cd.fileItemIdx].status && LD_STATUS_BLANK and not (ld.libItems[cd.fileItemIdx].status && LD_STATUS_NEED_PARENT)
				
			if cd.mainTab = CD_TAB_APP
					
				cd.editIdx = -1		
				cdNewApp(CD_SUBMODE_NEW_APP)

			else 
				
				cd.fileIdx = -1
				cdNewThing(cd.thingTab)
				
			endif

		else
					
			cdClearLibItem(cd.currLibItem)
			
		endif

		cd.fileItemIdx = -1
		
	elseif cd.mode = CD_MODE_TOOL_BAR

		cdButtonAction(cd.toolBar.buts[cd.waitIdx].id, 0)

	//elseif cd.mode = CD_MODE_SETTINGS_BAR

	//	cdButtonAction(cd.settingsBar.buts[cd.waitIdx].id, 0)

	elseif cd.mode = CD_MODE_THING

		if cd.thingTab <> cd.waitIdx

			cd.thingTab = -1
			cdSetThingsVisible("d", false)
			cd.thingTab = cd.waitIdx
			//cdSetThingsVisible(true)
			cd.subMode = CD_SUBMODE_PRELOAD
			cdSetTabVisible("mode_thing", true)

		endif

	elseif cd.mode = CD_MODE_GRP

		if cd.grpTab <> cd.waitIdx
			
			cd.grpTab = -1
			cdSetGrpVisible(false)
			cd.grpTab = cd.waitIdx
			cdSetGrpVisible(true)

		endif

	elseif cd.mode = CD_MODE_MORE_BAR

		butId = guiCheckBarReleased(cd.moreBar, x, y, 1)
		guiHideBar(cd.moreBar)
		cdButtonAction(butId, cd.waitIdx)

	elseif cd.mode = CD_MODE_CMD_BAR

		butId = guiCheckBarReleased(cd.cmdBar, x, y, 2)
		guiHideBar(cd.cmdBar)
		cd.waitX = x
		cd.waitY = y
		cdButtonAction(butId, cd.waitIdx)
		
	elseif cd.mode = CD_MODE_PART_BAR

		butId = guiCheckBarReleased(cd.partBar, x, y, 2)
		guiHideBar(cd.partBar)
		cd.waitX = x
		cd.waitY = y
		
		if cd.waitIdx > -1
			
			cdButtonAction(butId, cd.waitIdx)
			
		elseif cd.editpress.cmd
			
			selIdx = cdFindSelCmdIdx(ma.cmds[cd.editpress.cmd].code)
			cdButtonAction(butId, selIdx)
			
		endif

	elseif cd.mode = CD_MODE_HELP_BAR

		cdDeleteCmds(cd.currCmds)
		cd.currCmds.length = -1

		butId = guiCheckBarReleased(cd.helpBar, x, y, 1)
		guiHideBar(cd.helpBar)
		cdButtonAction(butId, cd.waitIdx)

	elseif cd.mode = CD_MODE_CODE_BAR

		cdDrawCode("j", 0)

		butId = guiCheckBarReleased(cd.cmdBar, x, y, 2)
		guiHideBar(cd.cmdBar)

		if butId > -1
			
			cdButtonAction(butId, 0)
			
		else
			
			cdRestoreCmds(cd.currCmds)
			cd.currCmds.length = -1
			cdDrawCode("code bar", 0)

		endif

	elseif cd.mode = CD_MODE_CODE_PANEL_BAR

		butId = guiCheckBarReleased(cd.codeBar, x, y, 2)
		guiHideBar(cd.codeBar)
		cdHideTarget()

		if butId > -1
			
			cdButtonAction(butId, 0)
			
		endif

	elseif cd.mode = CD_MODE_APP_BAR

		appIdx = cd.waitIdx

		butId = guiCheckBarReleased(cd.appBar, x, y, 2)
		guiHideBar(cd.appBar)

		if butId > -1
					
			cdButtonAction(butId, appIdx)

		else

			cdRestoreCmds(cd.currCmds)
			cd.currCmds.length = -1

		endif

	elseif cd.mode = CD_MODE_SPRITE_BAR

		cdDeleteCmds(cd.currCmds)
		cd.currCmds.length = -1

		thingIdx = cd.waitIdx
		butId = guiCheckBarReleased(cd.spriteBar, x, y, 2)		
		guiHideBar(cd.spriteBar)
		cdButtonAction(butId, thingIdx)

	elseif cd.mode = CD_MODE_FRAME_BAR

		cdDeleteCmds(cd.currCmds)
		cd.currCmds.length = -1

		butId = guiCheckBarReleased(cd.frameBar, x, y, 2)		
		guiHideBar(cd.frameBar)
		cdButtonAction(butId, cd.waitIdx2)

	elseif cd.mode = CD_MODE_SOUND_BAR

		cdDeleteCmds(cd.currCmds)
		cd.currCmds.length = -1

		thingIdx = cd.waitIdx
		butId = guiCheckBarReleased(cd.soundBar, x, y, 2)		
		guiHideBar(cd.soundBar)
		cdButtonAction(butId, thingIdx)

	elseif cd.mode = CD_MODE_VIDEO_BAR

		cdDeleteCmds(cd.currCmds)
		cd.currCmds.length = -1

		thingIdx = cd.waitIdx
		butId = guiCheckBarReleased(cd.videoBar, x, y, 2)		
		guiHideBar(cd.videoBar)
		cdButtonAction(butId, thingIdx)

	elseif cd.mode = CD_MODE_VAR_BAR

		cdDeleteCmds(cd.currCmds)
		cd.currCmds.length = -1
		
		butId = guiCheckBarReleased(cd.varBar, x, y, 2)
		guiHideBar(cd.varBar)
		cdButtonAction(butId, cd.waitIdx)

	elseif cd.mode = CD_MODE_VAR_VALUE_BAR

		cdDeleteCmds(cd.currCmds)
		cd.currCmds.length = -1
		
		butId = guiCheckBarReleased(cd.varValueBar, x, y, 2)
		guiHideBar(cd.varValueBar)
		cdButtonAction(butId, cd.waitIdx)

	elseif cd.mode = CD_MODE_FOLDER_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.folderItemBar, x, y, 2)		
		guiHideBar(cd.folderItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1
		
	elseif cd.mode = CD_MODE_IMAGE_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.imageItemBar, x, y, 2)		
		guiHideBar(cd.imageItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1

	elseif cd.mode = CD_MODE_IMAGE_BLANK_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.imageBlankItemBar, x, y, 2)		
		guiHideBar(cd.imageBlankItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1

	elseif cd.mode = CD_MODE_SOUND_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.soundItemBar, x, y, 2)		
		guiHideBar(cd.soundItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1

	elseif cd.mode = CD_MODE_VIDEO_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.videoItemBar, x, y, 2)		
		guiHideBar(cd.videoItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1

	elseif cd.mode = CD_MODE_VAR_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.varItemBar, x, y, 2)		
		guiHideBar(cd.varItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1

	elseif cd.mode = CD_MODE_VAR_VALUE_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.varValueItemBar, x, y, 2)		
		guiHideBar(cd.varValueItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1

	elseif cd.mode = CD_MODE_PROJ_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.projItemBar, x, y, 2)		
		guiHideBar(cd.projItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1

	elseif cd.mode = CD_MODE_PROJ_BLANK_ITEM_BAR

		cdClearLibItem(cd.currLibItem)
		
		butId = guiCheckBarReleased(cd.projBlankItemBar, x, y, 2)		
		guiHideBar(cd.projBlankItemBar)
		cdButtonAction(butId, cd.fileItemIdx)
		//cd.fileItemIdx = -1

	elseif cd.mode = CD_MODE_CMD_PANEL

		guiPanelReleased(cd.cmdPanels[cd.grpTab], x, y)

	elseif cd.mode = CD_MODE_CODE_PANEL

		guiPanelReleased(cd.codePanel, x, y)

	elseif cd.mode = CD_MODE_APP_PANEL

		guiPanelReleased(cd.appPanel, x, y)

	elseif cd.mode = CD_MODE_THING_PANEL

		guiPanelReleased(cd.cmdPanels[cd.thingTab], x, y)

	elseif cd.mode = CD_MODE_LOAD_PANEL

		guiPanelReleased(cd.loadPanel, x, y)

	//elseif cd.mode = CD_MODE_SETTINGS_PANEL

	//	guiPanelReleased(cd.settingsPanel, x, y)

	elseif cd.mode = CD_MODE_HELP_PANEL

		guiPanelReleased(cd.helpPanel, x, y)

	elseif cd.mode = CD_MODE_WAIT_PART

		cd.mode = CD_MODE_EDIT_PART
		
		// Still over the part? edit it.
		if cdGetPartGfxPressed(ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx], x, y, co.bs / 16)

			// Make sure we only edit parts that can be edited.
			if cd.editpress.cmd > -1 and cd.editpress.partIdx > -1

				if ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ = PART_APP
					cd.editpress.cmd = -1
				//elseif ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ = PART_SPRITE
					//cd.editpress.cmd = -1
				//elseif ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ = PART_FRAME
					//cd.editpress.cmd = -1
				elseif ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ = PART_BOOL
					cdApplyPartEdit(cd.editpress.cmd, cd.editpress.partIdx, "", false)
					cd.editpress.cmd = -1					
					maSave()
				// TODO: Uncom 2 lines.
				//elseif ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ = PART_VAR
				//	cd.editpress.cmd = -1
				elseif ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ = PART_SOUND
					cd.editpress.cmd = -1
				elseif ma.cmds[cd.editpress.cmd].parts[cd.editpress.partIdx].typ = PART_VIDEO
					cd.editpress.cmd = -1
				endif

			endif

			if cd.editpress.cmd > -1 and cd.editpress.partIdx > -1
				cdEditPartBegin(cd.editpress.cmd, cd.editpress.partIdx)
			endif
			
		endif

	elseif not cd.zoomActive // Mode deactivated.

		guiHideTip(gui.tip)
		
	endif

	if ma.helpInter.howTo and not cd.pressInterHelp
		maProcessInterHelpReleased(cd.mode)
	endif

	cd.mode = CD_MODE_NONE
	cd.pressInterHelp = false
	//guiHideTip(gui.tip)

	if doSave
		maSave()
	endif
	
endfunction

/*
//-----------------------------------------------------
// Start a ping.
//
function cdPingStart(x as float, y as float)

	setscale(cd.pingObj, 1.0 / CD_PING_COUNT)
	setalpha(cd.pingObj, 255)
	setpos(cd.pingObj, x, y)
	setvisible(cd.pingObj, true)
	settimer(cd.pingObj, CD_PING_TIMER)

	cd.pingCounter = CD_PING_COUNT - 1
	
endfunction

//-----------------------------------------------------
// Start a ping.
//
function cdPingStop()

	setvisible(cd.pingObj, false)
	settimer(cd.pingObj, 0)
	
endfunction

//-----------------------------------------------------
// Continue the ping.
//
function cdPingTimer()

	local sc as float
	local al as integer
	
	if cd.pingCounter > 0
		
		sc = (CD_PING_COUNT - cd.pingCounter) * 0.1
		setscale(cd.pingObj, sc)

		al = cd.pingCounter * (256 / CD_PING_COUNT) - 1
		setalpha(cd.pingObj, al)

		dec cd.pingCounter

		settimer(cd.pingObj, CD_PING_TIMER)

	else

		cdPingStop()
		
	endif
	
endfunction
*/

//-----------------------------------------------------
// Remove a part, and replace it will the parts standard default.
//
function cdRevertPart(thingIdx as integer, cmd as integer, partIdx as integer)

	local press as CmdPress
	local selCmdIdx as integer
	local typ as integer
	local info as string 
	
	cdClearPart(ma.cmds[cmd].parts[partIdx])

	if ma.cmds[cmd].code <> CODE_VAR_GET
		selCmdIdx = cdFindSelCmdIdx(ma.cmds[cmd].code)
	else
	endif

	if selCmdIdx > -1
		
		typ = ma.cmds[cd.selCmds[selCmdIdx]].parts[partIdx].typ
		info = ma.cmds[cd.selCmds[selCmdIdx]].parts[partIdx].info
		ma.cmds[cmd].parts[partIdx].typ = typ
		cdSetPart(ma.cmds[cmd].parts[partIdx], info)
		
		press.cmd = cmd
		cdFindThingRootCmd(thingIdx, press)
		cdUpdateCmdSize(press.parentCmd)

	endif
	
	//cdDrawCode()

endfunction

//-----------------------------------------------------
// Restore lift state back to dropped.
// If newDepth <> 0, reset to the top of the cmd depth stack.
// Otherwise, set back to its current depth.
//
function cdRestoreCmds(cmds ref as integer[])

	local i as integer
	
	// Clear offsets and shadows for all curr cmds.
	for i = 0 to cmds.length

		ma.cmds[cmds[i]].depth = ma.cmds[cmds[i]].prevDepth
		cdSetCmdDepth(cmds[i], ma.cmds[cmds[i]].depth)

		cdSetCmdVisible(cmds[i], true)
		cdSetCmdShadowVisible(cmds[i], false)
		
	next

	//cdDrawCode("restore", 0)
	
endfunction

//-----------------------------------------------------
// Drop the curr lib item, and slot it in appropriately.
//
function cdDropLibItem()

	local fromIdx as integer
	local fromSubIdx as integer
	local toIdx as integer
	local toSubIdx as integer
	local doSprite as integer

	//cdHideCmdHover()
	cdHideThingHover()

	if cd.currLibItem.visible

		if cd.mainTab = CD_TAB_APP

			cdSetLibItemScissor(cd.currLibItem, true, cd.appPanel)

			//if cd.fileItemIdx = 0
			if cd.currLibItem.status && LD_STATUS_BLANK

				cd.editIdx = -1		
				cdNewApp(CD_SUBMODE_NEW_APP)
				
			else

				cdClearLibItem(cd.currLibItem)
				cdButtonAction(BUT_CODER_APP_OPEN, cd.fileItemIdx)
				//cd.fileItemIdx = -1
				
			endif

		elseif cd.mainTab = CD_TAB_THING

			//if cd.thingTab = GRP_SPRITE
			if cd.thingTab = GRP_SPRITE

				if cd.currLibItem.visible

					cdSetLibItemScissor(cd.currLibItem, true, cd.cmdPanels[GRP_SPRITE])

					doSprite = false
					
					if cd.fileIdx > -1 // Adding an image to this thing.

						cdHideThingHover()

						if cd.varValueIdx > -1
							
							cdAddThingImage(cd.appIdx, cd.fileIdx, cd.currLibItem.file, cd.attachCmd, cd.attachDir)
							cdClearLibItem(cd.currLibItem)
							cdSortImages(cd.fileIdx)
							maSave()
							cdSetSprite(ma.things[cd.fileIdx].id)
							cdUpdateImageCmds(cd.fileIdx)

						else

							doSprite = true
														
						endif

					else

						doSprite = true
						
					endif
						
					if doSprite
						cdNewThing(GRP_SPRITE)
					endif
					
				endif
				
			elseif cd.thingTab = GRP_SOUND
				
				if cd.currLibItem.visible

					cdSetLibItemScissor(cd.currLibItem, true, cd.cmdPanels[GRP_SOUND])
					cdNewThing(GRP_SOUND)
					cdClearLibItem(cd.currLibItem)
					
				endif

			elseif cd.thingTab = GRP_VIDEO
				
				if cd.currLibItem.visible

					cdSetLibItemScissor(cd.currLibItem, true, cd.cmdPanels[GRP_VIDEO])
					cdNewThing(GRP_VIDEO)
					cdClearLibItem(cd.currLibItem)
					
				endif

			elseif cd.thingTab = GRP_VAR
				
				cdSetLibItemScissor(cd.currLibItem, true, cd.cmdPanels[GRP_VAR])					

				if cd.currLibItem.visible

					if cd.fileIdx > -1 // Adding a value to this var.

						cdEditVarValue(cd.fileIdx, -1, CD_SUBMODE_NEW_VALUE)
						cdHideThingHover()
						
					else

						// Must be dropping on a var for var value.
						if cd.currLibItem.typ = LD_ITEM_VAR_VALUE
							cdClearLibItem(cd.currLibItem)
						else
							cdNewThing(GRP_VAR)
						endif

					endif

				endif
				
			endif
			
		endif

	elseif cd.currCmds.length > -1
		
		if cd.mainTab = CD_TAB_THING

			if cd.thingTab = GRP_SPRITE

				if cdIsSpriteOrFrameCmd(cd.currCmds[0])

					cdDeleteCmds(cd.currCmds)

					if cd.fileIdx > -1
						
						fromIdx = cdGetSpriteIdx(cd.waitIdx)
						fromSubIdx = cd.waitIdx2
						toIdx = cdGetSpriteIdx(cd.fileIdx)
						toSubIdx = cd.varValueIdx

						if fromIdx = toIdx
							
							if fromSubIdx > -1
								
								if toSubIdx > -1
									
									// Frame dropped to same spot, do nothing.
									if fromSubIdx = toSubIdx or (toSubIdx = fromSubIdx - 1 and cd.attachDir = DIR_S) or (toSubIdx = fromSubIdx + 1 and cd.attachDir = DIR_N)

										// Do nothing.

									else // Different spot, reorder.

										if cd.attachDir = DIR_S
											inc toSubIdx
										endif

										cdReorderSprites(fromIdx, fromSubIdx, toIdx, toSubIdx)
										
									endif
									
								elseif fromSubIdx > 0 // Dropping frame on same sprite.
									
									cdReorderSprites(fromIdx, fromSubIdx, toIdx, 0)
																
								endif

							endif
							
						else

							// Moving a frame, just do it.
							if fromSubIdx > -1

								cdReorderSprites(fromIdx, fromSubIdx, toIdx, toSubIdx)
								
							elseif (toIdx = fromIdx - 1 and cd.attachDir = DIR_S) or (toIdx = fromIdx + 1 and cd.attachDir = DIR_N)

								// Moving a sprite to exactly the same place, do nothing.

							else // Different spot, reorder.

								if cd.attachDir = DIR_S
									inc toIdx
								endif

								cdReorderSprites(fromIdx, -1, toIdx, -1)
								
							endif
												
						endif

					endif
					
				endif

			elseif cd.thingTab = GRP_VAR
				
				if cdIsVarOrValueCmd(cd.currCmds[0])

					cdDeleteCmds(cd.currCmds)

					if cd.fileIdx > -1
						
						fromIdx = cdGetVarIdx(cd.waitIdx)
						fromSubIdx = cd.waitIdx2
						toIdx = cdGetVarIdx(cd.fileIdx)
						toSubIdx = cd.varValueIdx					

						if fromIdx = toIdx

							if fromSubIdx > -1 // Should always be the case.

								if toSubIdx > -1
									
									// Value dropped to same spot, do nothing.
									if fromSubIdx = toSubIdx or (toSubIdx = fromSubIdx - 1 and cd.attachDir = DIR_S) or (toSubIdx = fromSubIdx + 1 and cd.attachDir = DIR_N)

										// Do nothing.
										
									else // Different spot, reorder.

										if cd.attachDir = DIR_S
											inc toSubIdx
										endif
										
										cdReorderVarsPre(cd.waitIdx, fromSubIdx, cd.fileIdx, toSubIdx)
										
									endif
									
								elseif fromSubIdx > 0 // Dropping value on same var.

									cdReorderVarsPre(cd.waitIdx, fromSubIdx, cd.fileIdx, 0)
																
								endif
						
							endif
							
						else

							if cd.attachDir = DIR_S
								inc toSubIdx
							endif

							cdReorderVarsPre(cd.waitIdx, fromSubIdx, cd.fileIdx, toSubIdx)
										
						endif

						if cdGetCmdFolded(ma.vars[toIdx].cmd)
							cdSetCmdFolded(ma.vars[toIdx].cmd, false)
						endif

					endif
					
				endif
				
			endif
			
		endif
		
	endif
	
	cd.offX = 0
	cd.offY = 0	
		
	//cdClearAttach()

	setspritevisible(cd.codeScroll, false)

endfunction

//-----------------------------------------------------
// Fix the image cmds for a thing.
//
function cdUpdateImageCmds(thingIdx as integer)

	local imgIds as string[]
	local idStr as String
	local i as integer
	
	imgIds.length = -1

	for i = 0 to ma.things[thingIdx].imgs.length

		idStr = cdMakePartFrameInfo(thingIdx, ma.things[thingIdx].imgs[i].id)
		imgIds.insert(idStr)

	next

	idStr = imgIds.toJSON()
	cdReplaceImageParts(thingIdx, PART_FRAME, idStr, "-2")

endfunction

//-----------------------------------------------------
// Get sprite idx within the current app.
//
function cdGetSpriteIdx(sprIdx as integer)

	local i as integer
	local ret as integer
	
	for i = 0 to ma.apps[cd.appIdx].sprites.length
		
		if ma.apps[cd.appIdx].sprites[i] = sprIdx
			
			ret = i
			exit

		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Get var idx within the current app.
//
function cdGetVarIdx(varIdx as integer)

	local i as integer
	local ret as integer
	local thingIdx as integer

	if ma.vars[varIdx].thingIdx = -1
		
		for i = 0 to ma.apps[cd.appIdx].vars.length
			
			if ma.apps[cd.appIdx].vars[i] = varIdx
				
				ret = i
				exit

			endif
			
		next

	else

		thingIdx = ma.vars[varIdx].thingIdx
		
		for i = 0 to ma.things[thingIdx].vars.length
			
			if ma.things[thingIdx].vars[i] = varIdx
				
				ret = i
				exit

			endif
			
		next

	endif
	
endfunction ret

//-----------------------------------------------------
// Move a sprite or frame to another sprite or frame location.
//
// 1 to 0 dir = N
//
function cdReorderSprites(fromIdx as integer, fromSubIdx as integer, toIdx as integer, toSubIdx as integer)

	local i as integer
	local cmd as integer
	local fromImgId as string
	local toImgId as string
	local fromImgIdx as integer
	local toImgIdx as integer
	local moved as integer
	local info as string
	local thingIdx as integer
	local repImgId as string
	
	moved = false

	thingIdx = ma.apps[cd.appIdx].sprites[fromIdx]
			
	if fromSubIdx > -1 // Moving frame.

		// Only move frame if there are more than one. A sprite has to have at least one!
		if ma.things[ma.apps[cd.appIdx].sprites[fromIdx]].imgs.length > 0

			fromImgIdx = ma.things[ma.apps[cd.appIdx].sprites[fromIdx]].imgIdx
			fromImgId = ma.things[ma.apps[cd.appIdx].sprites[fromIdx]].imgs[fromImgIdx].id
			repImgId = fromImgId
			toImgIdx = ma.things[ma.apps[cd.appIdx].sprites[toIdx]].imgIdx
			toImgId = ma.things[ma.apps[cd.appIdx].sprites[toIdx]].imgs[toImgIdx].id
			
			if toSubIdx <= ma.things[ma.apps[cd.appIdx].sprites[toIdx]].imgs.length

				// Handle drop of frame to DIR_S of sprite.
				if toSubIdx = -1
					toSubIdx = 0
				endif

				ma.things[ma.apps[cd.appIdx].sprites[toIdx]].imgs.insert(ma.things[ma.apps[cd.appIdx].sprites[fromIdx]].imgs[fromSubIdx], toSubIdx)
				
				if fromIdx = toIdx and toSubIdx < fromSubIdx
					inc fromSubIdx // Adjist for insertion ro ensure removal of right from idx.
				endif
				
			else
				
				ma.things[ma.apps[cd.appIdx].sprites[toIdx]].imgs.insert(ma.things[ma.apps[cd.appIdx].sprites[fromIdx]].imgs[fromSubIdx])

			endif

			// Remove original frame location.
			moved = true
			ma.things[ma.apps[cd.appIdx].sprites[fromIdx]].imgs.remove(fromSubIdx)
			
		endif
		
	else // Moving sprite.

		if toIdx <= ma.apps[cd.appIdx].sprites.length

			ma.apps[cd.appIdx].sprites.insert(ma.apps[cd.appIdx].sprites[fromIdx], toIdx)

			if toIdx < fromIdx
				inc fromIdx // Adjust for removing of from.
			endif
			
		else
			
			ma.apps[cd.appIdx].sprites.insert(ma.apps[cd.appIdx].sprites[fromIdx])
			
		endif

		// Remove original sprite location.
		moved = true
		ma.apps[cd.appIdx].sprites.remove(fromIdx)
		
	endif

	// Fix frame numbers and selected frames.

	if moved

		if fromSubIdx > -1

			thingIdx = ma.apps[cd.appIdx].sprites[fromIdx]
			
			for i = 0 to ma.things[thingIdx].imgs.length

				cmd = ma.things[thingIdx].imgs[i].cmd
				//cdClearPart(ma.cmds[cmd].parts[0])
				info = cdMakePartFrameInfo(thingIdx, ma.things[thingIdx].imgs[i].id)
				//cdSetPart(ma.cmds[cmd].parts[0], info)
				cdClearPart(ma.cmds[cmd].parts[1])
				cdSetPart(ma.cmds[cmd].parts[1], " " + str(i + 1))

				if fromImgId <> "" and ma.things[thingIdx].imgs[i].id = fromImgId			

					ma.things[thingIdx].imgIdx = i
					fromImgId = ""
					
				endif

			next

			cdUpdateImageCmds(thingIdx)		

			// Didn't find fromImgId, reset it to 0.
			if fromImgId <> ""
				ma.things[thingIdx].imgIdx = 0
			endif

		endif

		// Only update the to idx, if we are on a different sprite,
		// or didn't do above update for the same sprite.
		//
		if toSubIdx > -1 and (fromIdx <> toIdx or fromSubIdx = -1)

			thingIdx = ma.apps[cd.appIdx].sprites[toIdx]

			for i = 0 to ma.things[thingIdx].imgs.length

				cmd = ma.things[thingIdx].imgs[i].cmd
				//cdClearPart(ma.cmds[cmd].parts[0])
				info = cdMakePartFrameInfo(thingIdx, ma.things[thingIdx].imgs[i].id)
				//cdSetPart(ma.cmds[cmd].parts[0], info)
				cdClearPart(ma.cmds[cmd].parts[1])
				cdSetPart(ma.cmds[cmd].parts[1], " " + str(i + 1))

				if toImgId <> "" and ma.things[thingIdx].imgs[i].id = toImgId			

					ma.things[thingIdx].imgIdx = i
					toImgId = ""
					
				endif
			
			next

			cdUpdateImageCmds(thingIdx)		

			// Didn't find toImgId, reset it to 0.
			if toImgId <> ""
				ma.things[thingIdx].imgIdx = 0
			endif

		endif

	endif
	
endfunction

//-----------------------------------------------------
// Move a var value to another var or var value location.
//
// 1 to 0 dir = N
//
function cdReorderVarsPre(fromVarIdx as integer, fromSubIdx as integer, toVarIdx as integer, toSubIdx as integer)

	if ma.vars[fromVarIdx].thingIdx = -1 and ma.vars[toVarIdx].thingIdx = -1
		cdReorderVars(ma.apps[cd.appIdx].vars, cdGetVarIdx(fromVarIdx), fromSubIdx, ma.apps[cd.appIdx].vars, cdGetVarIdx(toVarIdx), toSubIdx)
	elseif ma.vars[fromVarIdx].thingIdx = -1
		cdReorderVars(ma.apps[cd.appIdx].vars, cdGetVarIdx(fromVarIdx), fromSubIdx, ma.things[ma.vars[toVarIdx].thingIdx].vars, cdGetVarIdx(toVarIdx), toSubIdx)
	elseif ma.vars[toVarIdx].thingIdx = -1
		cdReorderVars(ma.things[ma.vars[fromVarIdx].thingIdx].vars, cdGetVarIdx(fromVarIdx), fromSubIdx, ma.apps[cd.appIdx].vars, cdGetVarIdx(toVarIdx), toSubIdx)
	else 
		cdReorderVars(ma.things[ma.vars[fromVarIdx].thingIdx].vars, cdGetVarIdx(fromVarIdx), fromSubIdx, ma.things[ma.vars[toVarIdx].thingIdx].vars, cdGetVarIdx(toVarIdx), toSubIdx)
	endif
	
endfunction

//-----------------------------------------------------
// Move a var value to another var or var value location.
//
// 1 to 0 dir = N
//
function cdReorderVars(fromVars ref as integer[], fromIdx as integer, fromSubIdx as integer, toVars ref as integer[], toIdx as integer, toSubIdx as integer)

	if fromSubIdx > -1 // Moving var values.
		
		if toSubIdx <= ma.vars[toVars[toIdx]].list.length

			ma.vars[toVars[toIdx]].list.insert(ma.vars[fromVars[fromIdx]].list[fromSubIdx], toSubIdx)

			if fromIdx = toIdx and toSubIdx < fromSubIdx
				inc fromSubIdx // Adjist for insertion ro ensure removal of right from idx.
			endif
			
		else
			
			ma.vars[toVars[toIdx]].list.insert(ma.vars[fromVars[fromIdx]].list[fromSubIdx])

		endif

		// Remove original frame location.
		ma.vars[fromVars[fromIdx]].list.remove(fromSubIdx)

	endif	
		
endfunction

//-----------------------------------------------------
// Drop the curr cmd, insert into right list, and create end if needed.
//
function cdDropCmd()

	local closeCmd as integer
	local cmd as integer
	local i as integer
	local idx as integer
	local press as CmdPress
	local attached as integer
	local typ as integer
	local partIdx as integer
	local spr as integer

	if cd.currCmds.length > -1

		typ = ma.cmds[cd.currCmds[0]].typ && (CMD_STMT || CMD_OPER || CMD_COND)

		// Make the cmds normal depth and no shadows.
		cdRestoreCmds(cd.currCmds)

		// We have a part drop point.
		if cd.attachPartIdx > -1

			if cd.attachCmd > 0

				cdClearPart(ma.cmds[cd.attachCmd].parts[cd.attachPartIdx])

				// Convert thing and frame types to differentiate with Thing/frame tab.
				if ma.cmds[cd.currCmds[0]].code = CODE_SPRITE_BASE
					ma.cmds[cd.currCmds[0]].code = CODE_SPRITE_PART
				elseif ma.cmds[cd.currCmds[0]].code = CODE_FRAME_BASE
					ma.cmds[cd.currCmds[0]].code = CODE_FRAME_PART
				endif					

				cdSetPartCmd(ma.cmds[cd.attachCmd].parts[cd.attachPartIdx], cd.currCmds[0])

				idx = cdFindThingCmd(cd.thingIdx, cd.attachCmd, 0)

				if idx = -1 // Not on a root cmd.

					press.cmd = cd.attachCmd
					cdFindThingRootCmd(cd.thingIdx, press)
					cdUpdateCmdSize(press.parentCmd)

				else

					cdUpdateCmdSize(cd.attachCmd)
					
				endif

				cd.tmpClip.cmds = cd.currCmds
				cd.tmpClip.attachCmd = cd.attachCmd
				cd.tmpClip.attachPartIdx = cd.attachPartIdx
				cd.tmpClip.attachDir = 0
				cd.tmpClip.isRoot = false
				cdSaveCmds(CD_CLIP_SNAP)
				
			else

				cdDeleteCmd(cd.currCmds[0])

				if ma.cmds[cd.currCmds[0]].codeTab
					cdSaveCmds(CD_CLIP_DROP_DEL)
				endif

			endif
			
		else //if typ = CMD_STMT

			// DIR_N or DIR_S
			ma.cmds[cd.currCmds[0]].x = cdGetCmdPosX(cd.currCmds[0])
			ma.cmds[cd.currCmds[0]].y = cdGetCmdPosY(cd.currCmds[0])

			// This code is yucky.
			if not ma.cmds[cd.currCmds[0]].codeTab
				
				// Clear the else when dropping an if/then/else select cmd.
				if ma.cmds[cd.currCmds[0]].code = CODE_FLOW_IF_ELSE
					
					cdClearPart(ma.cmds[cd.currCmds[0]].parts[ma.cmds[cd.currCmds[0]].parts.length])
					ma.cmds[cd.currCmds[0]].parts.remove(ma.cmds[cd.currCmds[0]].parts.length)
					cdUpdateCmdSize(cd.currCmds[0])
					
				endif

			endif

			cdAttachCmd(cd.thingIdx, cd.currCmds, cd.attachCmd, cd.attachDir)
/*
		else // Operator or Condition is mid-air, delete.

			cdDeleteCmd(cd.currCmds[0])

			// If the cmds were lifted from the code tab, save to undo.
			if ma.cmds[cd.currCmds[0]].codeTab
				cdSaveCmds(CD_CLIP_DROP_DEL)
			endif
*/
			
		endif

		cdSetCodeTab(cd.currCmds, true)
		
	endif

	cd.offX = 0
	cd.offY = 0	

	cdClearAttach()

	setspritevisible(cd.codeScroll, false)
	
endfunction attached

//-----------------------------------------------------
// Loop through all cmds and mark then as codeTab.
//
function cdSetCodeTab(cmds ref as integer[], codeTab as integer)

	local i as integer
	local j as integer
	local cmd as integer
	local subCmds as integer[0]
	
	// Do this last because it determines if the cmd is from sel list or code.
	for i = 0 to cmds.length
		
		ma.cmds[cmds[i]].codeTab = codeTab

		for j = 0 to ma.cmds[cmds[i]].parts.length

			// TODO: Can VAR actually fire?
			if ma.cmds[cmds[i]].parts[j].typ = PART_CMD or ma.cmds[cmds[i]].parts[j].typ = PART_VAR or ma.cmds[cmds[i]].parts[j].typ = PART_VALUE or ma.cmds[cmds[i]].parts[j].typ = PART_LIST

				cmd = cdGetPartAsInt(ma.cmds[cmds[i]].parts[j])
				subCmds[0] = cmd
				cdSetCodeTab(subCmds, codeTab)
				
			endif

		next
		
	next

endfunction

//-----------------------------------------------------
// Clear all attach settings.
//
function cdClearAttach()

	cd.detachCmd = 0
	cd.detachDir = 0
	cd.detachPartIdx = -1
	cd.attachCmd = 0
	cd.attachDir = 0
	cd.attachPartIdx = -1

endfunction

//-----------------------------------------------------
// Find the first partTyp in the passed cmd.
//
function cdFindFirstCmdPart(cmd as integer, partTyp as integer)

	local ret as integer
	local i as integer

	ret = -1
	
	for i = 0 to ma.cmds[cmd].parts.length

		if ma.cmds[cmd].parts[i].typ = partTyp
			
			ret = i
			exit

		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Find a cmd in a list in a thing.
//
function cdFindSelCmdIdx(code as integer)

//xxx something weird about looking up cmds, seems to return the wroing value.arr

	local i as integer
	local ret as integer

	ret = -1

	for i = 0 to cd.selCmds.length
		
		if ma.cmds[cd.selCmds[i]].code = code
			
			ret = i
			exit
			
		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Find a cmd in a list by name.
//
function cdFindSelCmdName(name as string)

	local i as integer
	local ret as integer

	ret = -1

	for i = 0 to cd.selCmds.length
		
		if ma.cmds[cd.selCmds[i]].parts.length > -1
			if ma.cmds[cd.selCmds[i]].parts[0].info = name
				
				ret = i
				exit
				
			endif
		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Find a cmd in a list in a thing.
// idx is the start point in the list.
//
function cdFindThingCmd(thing as integer, cmd as integer, idx as integer)

	local i as integer
	local ret as integer

	ret = -1

	if thing > -1

		for i = idx to ma.things[thing].cmds.length

			if ma.things[thing].cmds[i] = cmd
				
				ret = i
				exit
				
			endif
			
		next

	endif
	
endfunction ret

//-----------------------------------------------------
// Find the root cmd of the press.cmd, and return in parentCmd.
//
function cdFindThingRootCmd(thing as integer, press ref as CmdPress)

	local i as integer

	if thing > -1
		
		for i = 0 to ma.things[thing].cmds.length

			press.parentCmd = ma.things[thing].cmds[i]
			if press.parentCmd = press.cmd

				exit
				
			else
				
				press.partIdx = -1 // Just being used to determine found.
				
				cdFindRootPartCmd(press)

				if press.partIdx > -1
					exit
				endif
				
			endif
			
		next

	endif
	
endfunction

//-----------------------------------------------------
// Find press.cmd as a part.
//
function cdFindRootPartCmd(press ref as CmdPress)

	local i as integer
	local subPress as CmdPress

	for i = 0 to ma.cmds[press.parentCmd].parts.length

		if ma.cmds[press.parentCmd].parts[i].typ = PART_CMD

			if cdGetPartAsInt(ma.cmds[press.parentCmd].parts[i]) = press.cmd

				press.partIdx = i
				exit

			else

				subPress.parentCmd = cdGetPartAsInt(ma.cmds[press.parentCmd].parts[i])
				subPress.cmd = press.cmd
				subPress.partIdx = -1
				
				cdFindRootPartCmd(subPress)

				if subPress.partIdx > -1
					
					press.partIdx = subPress.partIdx
					exit

				endif
				
			endif
			
		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Find a part cmd with cmd.id = press.cmd.
//
function cdFindThingPartCmd(thing as integer, press ref as CmdPress)

	local i as integer
	local j as integer
	local subPress as CmdPress
	local cmd as integer
	local ret as integer

	ret = -1
	
	if thing > -1
		
		for i = press.idx to ma.things[thing].cmds.length

			press.parentCmd = ma.things[thing].cmds[i]
			press.partIdx = -1

			cdFindThingPartSubCmd(press)

			if press.partIdx > -1

				ret = i
				exit
				
			endif
			
		next

	endif
	
endfunction ret

//-----------------------------------------------------
// Find a cmd in in a part.
// If found, parentCmd and partIdx will be set to the found cmd and part.
//
function cdFindThingPartSubCmd(press ref as CmdPress)

	local i as integer
	local subPress as CmdPress
	local partCmd as integer

	for i = 0 to ma.cmds[press.parentCmd].parts.length

		if ma.cmds[press.parentCmd].parts[i].typ = PART_CMD
				
			partCmd = cdGetPartAsInt(ma.cmds[press.parentCmd].parts[i])

			if press.cmd
				
				if partCmd = press.cmd

					press.partIdx = i
					exitfunction

				endif

			elseif press.code

				if ma.cmds[partCmd].code = press.code

					press.partIdx = i
					exitfunction

				endif

			endif

			subPress.parentCmd = partCmd
			subPress.cmd = press.cmd
			subPress.partIdx = -1

			cdFindThingPartSubCmd(subPress)

			if subPress.partIdx > -1

				press.parentCmd = subPress.parentCmd
				press.partIdx = subPress.partIdx
				exit
				
			endif
						
		endif

	next

endfunction

//-----------------------------------------------------
// Draw all code.
//
function cdDrawCode(s as string, callDepth as integer)

//colog("cdDrawCode, s=" + s)

	local i as integer
	local j as integer
	local cmd as integer
	local pen as CodePen
	local depth as integer
	local tx as float
	local ty as float
	local x0 as float // Very left.
	local y0 as float // Very top.
	local x1 as float // Very right.
	local y1 as float // Very bottom.
	local px as float
	local py as float
	local count as integer
	local vw as float
	local vh as float
	local drawStack as StackItem[]
	local openCmds as StackItem[]
	local si as StackItem
	local openCmd as integer
	local closeCmd as integer
	local dist as float
	local ind as float
	local gap as float
	local cmds as integer[]
	local cx as float
	local cy as float
	local edge as float
	local col as integer
	local cw as float
	local ch as float
	local dx as float
	local dy as float
	local ox as float
	local oy as float
	local x as float
	local y as float
	local w as float
	local h as float
	local nextPenDepth as integer
	local sc as float
	local o as NbrOrder
	local order as NbrOrder[]
	local seenRoot as integer
	local prevCmdCentY as float
	local selCmd as integer
	
	if cd.thingIdx = -1
		exitfunction
	endif
	
	selCmd = cd.selCmds[0]

	px = cd.codePanel.vx
	py = cd.codePanel.vy
	
	// Start in opposite corners.
	x0 = 0xffffff //px + GetSpriteWidth(cd.codePanel.panel)
	y0 = 0xffffff // py + GetSpriteHeight(cd.codePanel.panel)
	x1 = - 0xffffff // px
	y1 = - 0xffffff // py
	
	//cd.topDepth = GUI_SHADOW_DEPTH
	//cd.topDepth = getspritedepth(cd.codePanel.panel) - 2
	pen.x = 0
	pen.y = 0
	count = 0
	sc = cd.cmdScales[ld.set.cmdSize] * cd.zoomScale
	ind = CD_CODE_INDENT * sc
	gap = CD_CMD_GAP * sc
	edge = CD_CMD_GAP * 2 * sc
	
	drawStack.length = -1
	openCmds.length = -1

	ox = 0
	oy = 0
	
	if ma.things[cd.thingIdx].trimWhite
			
		tx = x0
		ty = y0
				
		if ma.things[cd.thingIdx].cmds.length > -1
			
			// If makes sure tx, ty are set.
			
			for i = 0 to ma.things[cd.thingIdx].cmds.length
	
				cmd = ma.things[cd.thingIdx].cmds[i]
	
				if ma.cmds[cmd].root
	
					if ma.cmds[cmd].x < tx
								
						tx = ma.cmds[cmd].x
						ox = (px - tx)
	
					endif
					
					if ma.cmds[cmd].y < ty
						
						ty = ma.cmds[cmd].y
						oy = (py - ty)
	
					endif
	
				endif
				
			next
				
			// Adjust to put in top-right.
			for i = 0 to ma.things[cd.thingIdx].cmds.length
	
				cmd = ma.things[cd.thingIdx].cmds[i]
				ma.cmds[cmd].x = ma.cmds[cmd].x + ox
				ma.cmds[cmd].y = ma.cmds[cmd].y + oy
				ma.cmds[cmd].ox = 0
				ma.cmds[cmd].oy = 0
	
			next 
			
		endif
		
		// OVerride, hard-wired to force top-left.
		pen.x = px + edge
		pen.y = py + edge
		ox = 0
		oy = 0
		ox = ox + edge
		oy = oy + edge

	endif

	//if cd.tidyCode
	if ma.things[cd.thingIdx].tidyCode

		for i = 0 to ma.things[cd.thingIdx].cmds.length

			cmd = ma.things[cd.thingIdx].cmds[i]

			if ma.cmds[cmd].root
				
				o.nbr = ma.cmds[cmd].y
				o.idx = i
				order.insertsorted(o)
				
			endif
			
		next

		cmds.length = -1

		// Reorder cmds based on y position.
		for i = 0 to order.length

			seenRoot = false
			
			for j = order[i].idx to ma.things[cd.thingIdx].cmds.length

				cmd = ma.things[cd.thingIdx].cmds[j]

				if ma.cmds[cmd].root
					if not seenRoot
						seenRoot = true
					else
						exit
					endif
				endif
				
				cmds.insert(cmd)
				
			next
			
		next

	else

		cmds.length = -1

		for i = 0 to ma.things[cd.thingIdx].cmds.length

			cmd = ma.things[cd.thingIdx].cmds[i]
			cmds.insert(cmd)

		next
		
	endif
	
	// Now position code.

	nextPenDepth = GetSpriteDepth(cd.codePanel.panel) - 2
	prevCmdCentY = 0
	
	for i = 0 to cmds.length

		cmd = cmds[i]
		inc count

		if ma.cmds[cmd].root

			// Top level with no previous link.
			//if i = 0 or not ma.things[cd.thingIdx].tidyCode
			if not ma.things[cd.thingIdx].tidyCode

				x = cdGetCmdPosX(cmd)	
				y = cdGetCmdPosY(cmd)
				pen.x = (x + ox) * cd.zoomScale
				pen.y = (y + oy) * cd.zoomScale

			elseif i > 0

				//pen.y = pen.y + ma.cmds[cmd].h + gap
				pen.y = pen.y + ma.cmds[selCmd].h + gap
				
			endif
								
			pen.indent = 0
			pen.depth = nextPenDepth
			
			cdSetCmdClip(cmd, 0, 0)
			
		endif
										
		if maIsCloseCode(ma.cmds[cmd].code)					
			dec pen.indent
		elseif maIsElseCode(ma.cmds[cmd].code) //and i > 0			
			dec pen.indent			
		endif

		if ma.cmds[cmd].edge
			SetSpriteVisible(ma.cmds[cmd].edge, true)
		endif
		
		cdSetCmdPos(cmd, (pen.x + pen.indent * ind), pen.y)

		if ma.cmds[cmd].grp <> GRP_BEGIN and not ma.cmds[cmd].root and not maIsCloseCode(ma.cmds[cmd].code) and not maIsElseCode(ma.cmds[cmd].code)							
			//cdSetCmdClip(cmd, 1, pen.y - prevCmdCentY)
			cdSetCmdClip(cmd, 1, gap)
		endif		

		prevCmdCentY = pen.y
		
		if not cd.zoomActive // cd.zoomScale = 1.0					
			cdSaveCmdPos(cmd)
		endif
				
		cdSetCmdAlpha(cmd, 255)
		ma.cmds[cmd].ox = ma.cmds[cmd].x - px
		ma.cmds[cmd].oy = ma.cmds[cmd].y - py
		
		depth = cdSetCmdDepth(cmd, pen.depth)

		if depth < nextPenDepth
			nextPenDepth = depth
		endif
				
		pen.y = pen.y + ma.cmds[cmd].h + gap

		if maIsOpenCode(ma.cmds[cmd].code)
			inc pen.indent					
		elseif maIsElseCode(ma.cmds[cmd].code)							
			inc pen.indent			
		endif

		if maIsOpenCode(ma.cmds[cmd].code)

			si.openIdx = i
			si.closeIdx = -1
			cdPushCmd(drawStack, si)
			
		elseif maIsCloseCode(ma.cmds[cmd].code)

			si = cdPopCmd(drawStack)
			si.closeIdx = i
			openCmds.insert(si)
			
		endif

		if ma.cmds[cmd].x < x0			
			x0 = ma.cmds[cmd].x
		endif

		if ma.cmds[cmd].y < y0
			y0 = ma.cmds[cmd].y
		endif

		tx = (ma.cmds[cmd].x + ma.cmds[cmd].w) - 1

		if tx > x1
			x1 = tx
		endif
		
		ty = (ma.cmds[cmd].y + ma.cmds[cmd].h) - 1

		if ty > y1
			y1 = ty
		endif
		
	next

	x0 = x0 - edge
	y0 = y0 - edge
	x1 = x1 + edge
	y1 = y1 + edge
		
	if cd.zoomActive

		tx = (px - x0)
		ty = (py - y0)

		//w = (x1 - x0) + 1
		//h = (y1 - y0) + 1
		w = cd.gw * cd.zoomScale
		h = cd.gh * cd.zoomScale
		
		SetSpriteScale(cd.codeScroll, w, h)
		SetSpritePosition(cd.codeScroll, px, py)
		SetSpriteVisible(cd.codeScroll, true)
		coSetSpriteColor(cd.codeScroll, co.white)
		coSetSpriteColor(cd.codePanel.panel, co.grey[5])		

		guiSetPanelContentSize(cd.codePanel, px, py, px + GetSpriteWidth(cd.codePanel.panel) - 1, py + getspriteheight(cd.codePanel.panel) - 1)

	else		

		guiSetPanelContentSize(cd.codePanel, x0, y0, x1, y1)

		cd.gw = (x1 - x0) + 1		
		cd.gh = (y1 - y0) + 1
		
	endif

	// Add edges to open cmds.
	
	for i = 0 to openCmds.length

		closeCmd = cmds[openCmds[i].closeIdx]
		openCmd = cmds[openCmds[i].openIdx]
		ma.cmds[openCmd].closeCmd = closecmd
		ma.cmds[closeCmd].openCmd = opencmd
		dist = (ma.cmds[closeCmd].y + ma.cmds[closeCmd].h / 2) - (ma.cmds[openCmd].y + ma.cmds[openCmd].h / 2)
		cdSetCmdEdge(openCmd, dist)			
		cdSetCmdPos(openCmd, ma.cmds[openCmd].x, ma.cmds[openCmd].y)

	next
		
	guiSetPanelBarsVisible(cd.codePanel, true)

	// Fix scissors of cmds.
	
	for i = 0 to ma.things[cd.thingIdx].cmds.length

		cmd = ma.things[cd.thingIdx].cmds[i]

		if cd.zoomActive // cd.zoomScale < 1.0
			
			cdSetCmdPos(cmd, ma.cmds[cmd].x + tx, ma.cmds[cmd].y + ty)
			cdSetCmdScissor(cmd, getspritex(cd.codeScroll), getspritey(cd.codeScroll), getspritex(cd.codeScroll) + GetSpriteWidth(cd.codeScroll) - 1, getspritey(cd.codeScroll) + GetSpriteHeight(cd.codeScroll) - 1)

		else

			if x0 < px
				ma.cmds[cmd].ox = ma.cmds[cmd].ox + (px - x0)
			endif

			if y0 < py
				ma.cmds[cmd].oy = ma.cmds[cmd].oy + (py - y0)
			endif

			cdSetCmdScissor(cmd, cd.codePanel.vx, cd.codePanel.vy, cd.codePanel.vx + cd.codePanel.vw - 1, cd.codePanel.vy + cd.codePanel.vh - 1)

		endif
				
	next
	
	//cd.trimWhite = false
	ma.things[cd.thingIdx].trimWhite = false

	//if cd.tidyCode
	if ma.things[cd.thingIdx].tidyCode

		// Save, as we may have adjusted positions.
		ldSaveApp(ma.apps[cd.appIdx].id)
		//cd.tidyCode = false
		ma.things[cd.thingIdx].tidyCode = false

	endif
	
endfunction

//-----------------------------------------------------
// Push a cmd.
//
function cdPushCmd(stack ref as StackItem[], si ref as StackItem)
	
	if stack.length > -1
		stack.insert(si, 0)
	else
		stack.insert(si)
	endif
	
endfunction

//-----------------------------------------------------
// Pop a cmd.
//
function cdPopCmd(stack ref as StackItem[])

	local si as StackItem

	if stack.length > -1
		
		si = stack[0]
		stack.remove(0)
		
	else
		
		si.openIdx = -1
		si.closeIdx = -1
		
	endif
	
endfunction si

/*
//-----------------------------------------------------
// Move edit data.
//
function cdMoveEditData()

	local px as float
	local py as float
	local x as float
	local y as float

	px = cd.edimg.dataPanel.vx
	py = cd.edimg.dataPanel.vy
	
	x = px + cd.edimg.sprOx + cd.edimg.dataPanel.cx
	y = py + cd.edimg.sprOy + cd.edimg.dataPanel.cy
	//SetSpritePosition(cd.edimg.undos[0].spr, x, y)
	SetSpritePositionByOffset(cd.edimg.undos[0].spr, x, y)

	if cd.edsel.spr
		
		x = px + cd.edsel.sprOx + cd.edimg.dataPanel.cx
		y = py + cd.edsel.sprOy + cd.edimg.dataPanel.cy
		//SetSpritePosition(cd.edsel.spr, x, y)
		SetSpritePositionByOffset(cd.edsel.spr, x, y)

		//cdShowEditSel()	

	elseif cd.edsel.vis

		//cdShowEditSel()	

	endif

	if cd.edimg.mode <> CD_EDIT_MODE_NONE

		
	endif

	//cdMoveEditSel()
	cdShowEditSel()

	//cdMoveEditGrid()
	cdShowEditGrid()
	
endfunction
*/

//-----------------------------------------------------
// Move all help by the delta.
//
function cdMoveHelp()

	local i as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.helpPanel.panel)
	py = getspritey(cd.helpPanel.panel)
	
	for i = 0 to cd.helpDetails.cmds.length

		cmd = cd.helpDetails.cmds[i]		
		x = px + ma.cmds[cmd].ox + cd.helpPanel.cx
		y = py + ma.cmds[cmd].oy + cd.helpPanel.cy
		cdSetCmdPos(cmd, x, y)

	next

	for i = 0 to cd.helpDetails.texts.length

		x = px + cd.helpDetails.texts[i].ox + cd.helpPanel.cx
		y = py + cd.helpDetails.texts[i].oy + cd.helpPanel.cy
		
		if cd.helpDetails.texts[i].text
			SetTextPosition(cd.helpDetails.texts[i].text, x, y)
		endif

		if cd.helpDetails.texts[i].spr
			SetSpritePosition(cd.helpDetails.texts[i].spr, x, y)
		endif
		
	next

	for i = 0 to cd.helpDetails.sprs.length

		x = px + cd.helpDetails.sprs[i].ox + cd.helpPanel.cx
		y = py + cd.helpDetails.sprs[i].oy + cd.helpPanel.cy
		
		if cd.helpDetails.sprs[i].spr
			SetSpritePosition(cd.helpDetails.sprs[i].spr, x, y)
		endif

	next

	for i = 0 to cd.helpDetails.buts.length

		x = px + cd.helpDetails.buts[i].ox + cd.helpPanel.cx
		y = py + cd.helpDetails.buts[i].oy + cd.helpPanel.cy
		guiSetButtonPos(cd.helpDetails.buts[i], x, y)

	next
	
endfunction

//-----------------------------------------------------
// Move all commands by the delta.
//
function cdMoveCmds()

	local i as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.cmdPanels[cd.grpTab].panel)
	py = getspritey(cd.cmdPanels[cd.grpTab].panel)
	
	for i = 0 to cd.selCmds.length

		cmd = cd.selCmds[i]

		if ma.cmds[cmd].grp = cd.grpTab

			x = px + ma.cmds[cmd].ox + cd.cmdPanels[cd.grpTab].cx
			y = py + ma.cmds[cmd].oy + cd.cmdPanels[cd.grpTab].cy
			cdSetCmdPos(cmd, x, y)

		endif

	next
	
endfunction

//-----------------------------------------------------
// Move all commands by the delta.
//
function cdMoveCode()

	local i as integer
	local j as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = cd.codePanel.vx // getspritex(cd.codePanel.panel)
	py = cd.codePanel.vy // getspritey(cd.codePanel.panel)
		
	if cd.thingIdx > -1

		for i = 0 to ma.things[cd.thingIdx].cmds.length

			cmd = ma.things[cd.thingIdx].cmds[i]

			if not ma.cmds[cmd].vis
				exit
			endif
			
			x = px + ma.cmds[cmd].ox + cd.codePanel.cx
			y = py + ma.cmds[cmd].oy + cd.codePanel.cy
			cdSetCmdPos(cmd, x, y)

		next

	endif
	
endfunction

//-----------------------------------------------------
// Move apps.
//
function cdMoveApps()

	local i as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.appPanel.panel)
	py = getspritey(cd.appPanel.panel)
	
	for i = 0 to ma.apps.length

		cmd = ma.apps[i].cmd

		if cmd > 0
		
			//cdSetCmdPos(cmd, ma.cmds[cmd].x + dx, ma.cmds[cmd].y + dy)
			x = px + ma.cmds[cmd].ox + cd.appPanel.cx
			y = py + ma.cmds[cmd].oy + cd.appPanel.cy
			cdSetCmdPos(cmd, x, y)

		endif
		
	next

	//SetSpritePosition(cd.apppanel.spr, cd.apppanel.vx + cd.apppanel.cx, cd.apppanel.vy + cd.apppanel.cy)
	
endfunction

//-----------------------------------------------------
// Move things.
//
function cdMoveThings()

	if cd.thingTab = GRP_SPRITE
		cdMoveSprites()
	elseif cd.thingTab = GRP_SOUND
		cdMoveSounds()
	elseif cd.thingTab = GRP_VIDEO
		cdMoveVideos()
	elseif cd.thingTab = GRP_VAR
		cdMoveVars()
	endif

endfunction

//-----------------------------------------------------
// Move sounds.
//
function cdMoveSounds()

	local i as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.cmdPanels[GRP_SOUND].panel)
	py = getspritey(cd.cmdPanels[GRP_SOUND].panel)
	
	for i = 0 to ma.apps[cd.appIdx].sounds.length

		cmd = ma.sounds[ma.apps[cd.appIdx].sounds[i]].cmd
		//cdSetCmdPos(cmd, ma.cmds[cmd].x + dx, ma.cmds[cmd].y + dy)
		x = px + ma.cmds[cmd].ox + cd.cmdPanels[GRP_SOUND].cx
		y = py + ma.cmds[cmd].oy + cd.cmdPanels[GRP_SOUND].cy
		cdSetCmdPos(cmd, x, y)

	next
	
endfunction

//-----------------------------------------------------
// Move videos.
//
function cdMoveVideos()

	local i as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.cmdPanels[GRP_VIDEO].panel)
	py = getspritey(cd.cmdPanels[GRP_VIDEO].panel)
	
	for i = 0 to ma.apps[cd.appIdx].videos.length

		cmd = ma.videos[ma.apps[cd.appIdx].videos[i]].cmd
		//cdSetCmdPos(cmd, ma.cmds[cmd].x + dx, ma.cmds[cmd].y + dy)
		x = px + ma.cmds[cmd].ox + cd.cmdPanels[GRP_VIDEO].cx
		y = py + ma.cmds[cmd].oy + cd.cmdPanels[GRP_VIDEO].cy
		cdSetCmdPos(cmd, x, y)

	next
	
endfunction

//-----------------------------------------------------
// Move names.
//
function cdMoveVars()

	local i as integer
	local j as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.cmdPanels[GRP_VAR].panel)
	py = getspritey(cd.cmdPanels[GRP_VAR].panel)
	
	for i = 0 to ma.apps[cd.appIdx].vars.length

		cmd = ma.vars[ma.apps[cd.appIdx].vars[i]].cmd
		//cdSetCmdPos(cmd, ma.cmds[cmd].x + dx, ma.cmds[cmd].y + dy)
		x = px + ma.cmds[cmd].ox + cd.cmdPanels[GRP_VAR].cx
		y = py + ma.cmds[cmd].oy + cd.cmdPanels[GRP_VAR].cy
		cdSetCmdPos(cmd, x, y)

		if ma.vars[ma.apps[cd.appIdx].vars[i]].typ = VAR_TYPE_LIST or ma.vars[ma.apps[cd.appIdx].vars[i]].typ = VAR_TYPE_OBJECT

			for j = 0 to ma.vars[ma.apps[cd.appIdx].vars[i]].list.length

				cmd = ma.vars[ma.apps[cd.appIdx].vars[i]].list[j].cmd
				//cdSetCmdPos(cmd, ma.cmds[cmd].x + dx, ma.cmds[cmd].y + dy)
				x = px + ma.cmds[cmd].ox + cd.cmdPanels[GRP_VAR].cx
				y = py + ma.cmds[cmd].oy + cd.cmdPanels[GRP_VAR].cy
				cdSetCmdPos(cmd, x, y)

			next

		endif

	next

	if cd.thingIdx > -1
		
		for i = 0 to ma.things[cd.thingIdx].vars.length

			cmd = ma.vars[ma.things[cd.thingIdx].vars[i]].cmd
			//cdSetCmdPos(cmd, ma.cmds[cmd].x + dx, ma.cmds[cmd].y + dy)
			x = px + ma.cmds[cmd].ox + cd.cmdPanels[GRP_VAR].cx
			y = py + ma.cmds[cmd].oy + cd.cmdPanels[GRP_VAR].cy
			cdSetCmdPos(cmd, x, y)

			if ma.vars[ma.things[cd.thingIdx].vars[i]].typ = VAR_TYPE_LIST or ma.vars[ma.things[cd.thingIdx].vars[i]].typ = VAR_TYPE_OBJECT

				for j = 0 to ma.vars[ma.things[cd.thingIdx].vars[i]].list.length

					cmd = ma.vars[ma.things[cd.thingIdx].vars[i]].list[j].cmd
					//cdSetCmdPos(cmd, ma.cmds[cmd].x + dx, ma.cmds[cmd].y + dy)
					x = px + ma.cmds[cmd].ox + cd.cmdPanels[GRP_VAR].cx
					y = py + ma.cmds[cmd].oy + cd.cmdPanels[GRP_VAR].cy
					cdSetCmdPos(cmd, x, y)

				next

			endif

		next

	endif
	
endfunction

//-----------------------------------------------------
// Move apps.
//
function cdMoveSprites()

	local i as integer
	local j as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.cmdPanels[GRP_SPRITE].panel)
	py = getspritey(cd.cmdPanels[GRP_SPRITE].panel)
	
	for i = 0 to ma.things.length

		cmd = ma.things[i].cmd
		x = px + ma.cmds[cmd].ox + cd.cmdPanels[GRP_SPRITE].cx
		y = py + ma.cmds[cmd].oy + cd.cmdPanels[GRP_SPRITE].cy
		cdSetCmdPos(cmd, x, y)

		for j = 0 to ma.things[i].imgs.length

			cmd = ma.things[i].imgs[j].cmd
			x = px + ma.cmds[cmd].ox + cd.cmdPanels[GRP_SPRITE].cx
			y = py + ma.cmds[cmd].oy + cd.cmdPanels[GRP_SPRITE].cy
			cdSetCmdPos(cmd, x, y)

		next

	next
	
endfunction

/*
//-----------------------------------------------------
// Move apps.
//
function cdMoveSettings()

	local i as integer
	local cmd as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.settingsPanel.panel)
	py = getspritey(cd.settingsPanel.panel)

//	
	for i = 0 to ma.apps.length

		cmd = ma.apps[i].cmd
		//cdSetCmdPos(cmd, ma.cmds[cmd].x + dx, ma.cmds[cmd].y + dy)
		x = px + ma.cmds[cmd].ox + cd.appPanel.cx
		y = py + ma.cmds[cmd].oy + cd.appPanel.cy
		cdSetCmdPos(cmd, x, y)

	next
//
	
endfunction
*/

//-----------------------------------------------------
// Move apps.
//
function cdMoveLibItems()

	local i as integer
	local px as float
	local py as float
	local x as float
	local y as float

	px = getspritex(cd.loadPanel.panel)
	py = getspritey(cd.loadPanel.panel)
	
	for i = 0 to ld.libItems.length

		if not GetSpriteVisible(ld.libItems[i].border)
			exit
		endif

		x = px + ld.libItems[i].ox + cd.loadPanel.cx
		y = py + ld.libItems[i].oy + cd.loadPanel.cy

		cdSetLibItemPos(ld.libItems[i], x, y)

	next
	
endfunction

//-----------------------------------------------------
// Draw all code for a cmd.
//
function cdDrawCmds(cmds ref as integer[], x as float, y as float)

	local pen as CodePen
	local depth as integer
	local i as integer
	local ind as integer

	ind = CD_CODE_INDENT * cd.cmdScales[ld.set.cmdSize]
	pen.x = x - cd.offX
	pen.y = y - cd.offY
	pen.indent = 0

	for i = 0 to cmds.length

		if maIsCloseCode(ma.cmds[cmds[i]].code)			
			dec pen.indent
		elseif maIsElseCode(ma.cmds[cmds[i]].code) and i > 0
			dec pen.indent
		endif

		cdSetCmdPos(cmds[i], pen.x + pen.indent * ind, pen.y)		
		pen.y = pen.y + ma.cmds[cmds[i]].h + CD_CMD_GAP * cd.cmdScales[ld.set.cmdSize]

		if maIsOpenCode(ma.cmds[cmds[i]].code)			
			inc pen.indent			
		elseif maIsElseCode(ma.cmds[cmds[i]].code)			
			inc pen.indent
		endif

	next

endfunction

//-----------------------------------------------------
// Scan backwards from cmd to see if we are within an if block.
//
function cdIsWithinIfCmd(checkCmd ref as Cmd)

	local savedIdx as integer
	local idx as integer
	local ret as integer
	local cmd as integer
	
	savedIdx = cdFindThingCmd(cd.thingIdx, checkCmd.idx, 0)
	ret = false
	
	if savedIdx > -1

		idx = savedIdx
		
		while idx >= 0

			cmd = ma.things[cd.thingIdx].cmds[idx]
							
			if ma.cmds[cmd].code = CODE_FLOW_IF

				ret = true
				exit
				
			elseif ma.cmds[cmd].root or ma.cmds[cmd].code = CODE_FLOW_ELSE

				exit
				
			endif

			dec idx
			
		endwhile

	endif
	
	if ret // Found if, now find endif.

		ret = false
		idx = savedIdx
			
		while idx <= ma.things[cd.thingIdx].cmds.length

			cmd = ma.things[cd.thingIdx].cmds[idx]
			
			if ma.cmds[cmd].code = CODE_FLOW_ENDIF
				
				ret = true
				exit
								
			elseif idx > savedIdx and ma.cmds[cmd].root or ma.cmds[cmd].code = CODE_FLOW_ELSE

				exit

			endif

			inc idx
			
		endwhile
		
	endif
	
endfunction ret

//-----------------------------------------------------
//
function cdFindCrapSpr(x as float, y as float)

	local spr as integer
	local i as integer
	local name as string
	
	spr = getspritehit(x, y)

	if spr
		
		for i = 0 to co.sprs.length		
			if spr = co.sprs[i]
				name = co.sprNames[i]
				exit
			endif
		next 
			
		colog("spr=" + str(spr) + ",name = " + name + ", w=" + str(getspritewidth(spr)) + ", h=" + str(getspriteheight(spr)))
	endif
	
endfunction

//-----------------------------------------------------
//
function cdClearAllSprites()
	
	local spr as integer
	local name as string
	
	while co.sprs.length > -1	
			
		spr = co.sprs[co.sprs.length]
		name = co.sprNames[co.sprNames.length]
		colog("spr=" + str(spr) + ",name = " + name + ", w=" + str(getspritewidth(spr)) + ", h=" + str(getspriteheight(spr)))
		deletesprite(spr)
		co.sprs.remove()
		co.sprNames.remove()
		exit

	endwhile 
				
endfunction


//-----------------------------------------------------
//
function cdUpdate(delta as float)

	local s as string
	local t as string 
	local helpMsg as string
	local img as integer
	local libItem as LibItem
	local libAppIdx as integer
	local file as string
	local taskIdx as integer
	local i as integer
	//local lastChar as integer  
	local col as integer
	local colorEditBoxIdx as integer

	if cd.player.typ

		if cd.player.typ = CODE_SOUND_BASE		
			if GetSoundInstancePlaying(cd.player.playId)
				if in.ptrPressed			
					if guiGetButtonPressed(cd.player.stopBut, in.ptrX, in.ptrY, 1)
						cdHidePlayer()
					endif
				endif
			else 
				cdHidePlayer()
			endif
		elseif cd.player.typ = CODE_VIDEO_BASE		
			if GetVideoPlaying()				
				if in.ptrPressed			
					if guiGetButtonPressed(cd.player.stopBut, in.ptrX, in.ptrY, 1)
						cdHidePlayer()
					endif
				endif
			else 
				cdHidePlayer()
			endif
		endif
		
		exitfunction

	elseif cd.choosingImage

		if not IsChoosingImage() // User has finished selecting, stop choosing now.
			
			cd.choosingImage = false
			img = GetChosenImage()

			if img

				libitem.file = GetImageFilename(img)
				deleteimage(img)
				libitem.typ = LD_ITEM_SPRITE_LIB
				ldCreateImportLibItem(libItem)				
				cdSetCurrLibItem(libItem)
				cd.currLibItem.status = cd.currLibItem.status || LD_STATUS_IMPORT
				cd.currLibItem.visible = true
				cd.fileIdx = -1
				cdNewThing(GRP_SPRITE)
	
			endif

		endif
		
		exitfunction
		
	endif

	if in.ptrPressed
		
		//cdFindCrapSpr(in.ptrX, in.ptrY)
		//cdClearAllSprites()
		cdPressed(in.ptrX, in.ptrY)

	elseif in.ptrDown

		cdMoved(in.ptrX, in.ptrY)
		
	elseif in.ptrReleased

		cdReleased(in.ptrX, in.ptrY)

	//elseif not ld.set.trueEdit and cdIsEditActive()

	//	t = cdGetEditText()
	//	inKeys()
	
	elseif in.mouseWheelDelta <> 0
		
		cdWheel(in.ptrX, in.ptrY)
				
	endif

	if cdIsEditActive() // cd.mode = CD_MODE_MAIN_BAR or cd.fileItemIdx > -1

		if not ld.set.trueEdit

			t = cdGetEditText()
			inKeys()

		endif

		s = cdGetEditText()

		if ld.set.trueEdit
					
			if cdCheckEditChanged() //or not GetEditBoxHasFocus(cd.editBox)
								
				cd.prevEditText = s
				
				if cd.editMode = CD_EDIT_COLOR
					cdTrueEditColor(in.ptrx, in.ptry)
				endif
/*
				if cd.editMode = CD_EDIT_COLOR

					s = cdGetColorEditText()
					col = coMakeColor(s)

					colorEditBoxIdx = -1
					
					for i = 0 to cd.colorEditBox.length

						if cd.editBox <> cd.colorEditBox[i].box

							if GetEditBoxHasFocus(cd.colorEditBox[i].box)

								colorEditBoxIdx = i
								exit
															
							endif

						endif
						
					next

					if colorEditBoxIdx > -1

						cd.editBox = cd.colorEditBox[colorEditBoxIdx].box
						cd.editText = cd.colorEditBox[colorEditBoxIdx].text

					else 
						
						cd.editBox = 0
						cd.editText = 0
						
					endif
										
					if cd.submode = CD_SUBMODE_EDIT_IMAGE_COLOR or cd.submode = CD_SUBMODE_EDIT_DESIGN_TITLE_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BOX_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_TEXT_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_VARBG_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL or cd.submode = CD_SUBMODE_EDIT_EDITOR_COL or cd.submode = CD_SUBMODE_EDIT_DESIGN_BG_COLOR
						
						coSetSpriteColor(cd.editBut.icon2, col)

					elseif cd.submode = CD_SUBMODE_EDIT_PART 

						coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].spr, col)
						coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].lt, col)
						coSetSpriteColor(ma.cmds[cd.editCmd].parts[cd.editPartIdx].rt, col)

					endif
					
				endif
*/

/*				
				if lastChar = KEY_ESCAPE

					cdEditEnd()

				elseif lastChar = KEY_ENTER

					if cd.acceptBut.active

						cdEditAccept()
						cdEditEnd()

					endif

				endif
*/
			endif
			
		elseif s <> t

			cd.prevEditText = s
			
		endif

		if cd.cursorObjTimer > 0.0
			 
			dec cd.cursorObjTimer, delta
			
			if cd.cursorObjTimer <= 0.0
				cdOnObjTimer(cd.cursorObj)
			endif
			
		endif

		if cd.partFlashObjTimer > 0.0
			 
			dec cd.partFlashObjTimer, delta
			
			if cd.partFlashObjTimer <= 0.0
				cdOnObjTimer(cd.partFlashObj)
			endif
			
		endif

		cdCheckKeyPresses(delta)

		if cd.editClickTime > 0
			cdCheckDoubleTapSelection()
		endif
/*		
	elseif cdIsEditToolActive()

		if cd.fileTab = CD_FILE_TAB_HELP
		//if cd.mode = CD_MODE_HELP_PANEL

//xxx needs work scrolling help. also need to still allow tool panel actions.
//xxx maybe consider only showing help for the editing panel?

			guiPanelPoll(cd.helpPanel, in.ptrX, in.ptrY)
			cdMoveHelp()

		elseif cd.edimg.mode = CD_EDIT_MODE_PANEL
			
			guiPanelPoll(cd.edimg.dataPanel, in.ptrX, in.ptrY)
			cdMoveEditData()

		endif
*/
	elseif ma.helpInter.howTo
		
		maUpdateHelpInterAnim(delta)
/*
		if cd.helpInter.animtaskIdx > -1
								
			if cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].timer > 0.0
			 
				dec cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].timer, delta
				
				if cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].timer <= 0.0
					maOnObjTimer(cd.helpInter.tasks[cd.helpInter.animtaskIdx].anims[0].spr)
				endif
				
			endif
			
		endif
*/			
	else //if not WIN_MODE

		if cd.mainTab = CD_TAB_CMD
			
			guiPanelPoll(cd.cmdPanels[cd.grpTab], in.ptrX, in.ptrY)
			cdMoveCmds()

		elseif cd.mainTab = CD_TAB_THING

			//guiPanelPoll(cd.cmdPanels[GRP_SPRITE])
			guiPanelPoll(cd.cmdPanels[cd.thingTab], in.ptrX, in.ptrY)
			cdMoveThings()

		elseif cd.mainTab = CD_TAB_APP

			guiPanelPoll(cd.appPanel, in.ptrX, in.ptrY)
			cdMoveApps()

		//elseif cd.mainTab = CD_TAB_SETTINGS

		//	guiPanelPoll(cd.settingsPanel, in.ptrX, in.ptrY)
		//	cdMoveSettings()

		endif

		if cd.fileTab = CD_FILE_TAB_CODE

			if not cd.zoomActive //and not cd.scrollZone

				if WIN_MODE
					guiPanelPoll(cd.codePanel, cd.codePanel.originX, cd.codePanel.originY)
				else 
					guiPanelPoll(cd.codePanel, in.ptrX, in.ptrY)
				endif
				
				cdMoveCode()

			endif

		elseif cd.fileTab = CD_FILE_TAB_LIBRARY

			guiPanelPoll(cd.loadPanel, in.ptrX, in.ptrY)
			cdMoveLibItems()

		elseif cd.fileTab = CD_FILE_TAB_HELP

			guiPanelPoll(cd.helpPanel, in.ptrX, in.ptrY)
			cdMoveHelp()

		endif
		
	endif
	
endfunction

//
//
//
