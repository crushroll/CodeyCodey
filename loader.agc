#option_explicit

//-----------------------------------------------------
// Lib item types.
//
#constant LD_ITEM_APP_LIB 0x001
#constant LD_ITEM_SPRITE_LIB 0x002
#constant LD_ITEM_SOUND_LIB 0x004
#constant LD_ITEM_VIDEO_LIB 0x008
#constant LD_ITEM_VAR_APP 0x010
#constant LD_ITEM_VAR_SPRITE 0x020
#constant LD_ITEM_LIST_APP 0x040
#constant LD_ITEM_LIST_SPRITE 0x080
#constant LD_ITEM_PARENT_FOLDER 0x100
#constant LD_ITEM_SUB_FOLDER 0x200
#constant LD_ITEM_VAR_VALUE 0x400

//-----------------------------------------------------
// Folder and file settings.
//
#constant LD_BASE_DIR = "/codeycodey"
#constant LD_CONFIG_DIR = "/config"
#constant LD_APP_DIR "/projects"
#constant LD_THUMB_DIR "/_thumbs"
#constant LD_SPRITE_DIR "/sprites"
#constant LD_SOUND_DIR "/sounds"
#constant LD_VIDEO_DIR "/videos"
#constant LD_MEDIA_DIR "/media"
#constant LD_EXAMPLE_DIR "/examples"

#constant LD_PROJECT_PREFIX "P"
#constant LD_EXAMPLE_PREFIX "E"
#constant LD_SPRITE_PREFIX "S"
#constant LD_IMAGE_PREFIX "I"
#constant LD_SOUND_PREFIX "N"
#constant LD_VIDEO_PREFIX "V"
#constant LD_COMMAND_PREFIX "C"
#constant LD_TEXT_PREFIX "T"

#constant LD_SETTINGS_FILE "settings.json"
#constant LD_CONFIG_FILE "config.json"
#constant LD_CODE_FILE "code.json"
#constant LD_AGK_FILE "agk.json"
#constant LD_ICON_FILE "icon.png"
#constant LD_CMD_HELP_FILE "cmdhelp.txt"
#constant LD_PAGE_HELP_FILE "pagehelp.txt"
#constant LD_AGK_CMD_FILE "agkcommands.tsv"

#constant LD_GFX_FILE_SUFFIX ".png"
#constant LD_WAV_FILE_SUFFIX ".wav"
#constant LD_MP4_FILE_SUFFIX ".mp4"

//-----------------------------------------------------
// Item statuses.
//
#constant LD_STATUS_SHARED_TO_YOU 0x001 // The item is shared from another user to you.
#constant LD_STATUS_FOR_SALE 0x002 // The item is available for purchase.
#constant LD_STATUS_PURCHASED 0x004 // The item was purchased by you.
#constant LD_STATUS_SHARED_BY_YOU 0x008 // The item is shared from you to other users.
#constant LD_STATUS_LOCKED 0x010 // Not editable, usually used for examples and shared.
#constant LD_STATUS_BLANK 0x020 // A template item for creating a new project or sprite.
#constant LD_STATUS_MASTER_LIB 0x040 // The project is the master library, can only be one.
#constant LD_STATUS_LIBRARY 0x080 // The project is the library.
#constant LD_STATUS_IMPORT 0x100 // Flag to denote the libitem was an import.
#constant LD_STATUS_EXAMPLE 0x200 // Flag to denote an example.
#constant LD_STATUS_NEED_PARENT 0x400 // The item need a parent to attach to, so can't activate on press.
#constant LD_STATUS_MOB_LAND 0x1000 // Set the mobile sizing for land.
#constant LD_STATUS_MOB_PORT 0x2000 // Set the mobile sizing for port.
#constant LD_STATUS_HACK 0x8000 // For internal stuff.

// Determines the loadmethod for ldLoadThingImage.
// If both provided, both a loaded.

#constant LD_MODE_THUMB 0x1 // load a thumbnail.
#constant LD_MODE_IMAGE 0x2 // Load the image.

#constant LD_ID_MAX 2147483600 // Slightly less than max int.
#constant LD_CMD_SIZE_MAX 6
#constant LD_HELP_SIZE_MAX 5
#constant LD_TEXT_SIZE_MIN 24
#constant LD_TEXT_SIZE_MAX 300

//-----------------------------------------------------
//
global ld as Loader

//-----------------------------------------------------
//
type Loader

	libItems as LibItem[]
	set as Settings
	cfg as Config
	nextId as integer
	loadingAppIdx as integer
	cmdHelp as string[]
	pageHelp as string[]
	
endtype

// For loaded things.

type LibItem

	name as string
	typ as integer
	file as string
	ext as string // The original extension.
	folder as string 
	id as string
	sel as integer // Selector.
	bg as integer
	border as integer
	img as integer // For icon.
	sharedImg as integer // Flag to indicate we don't delete the img.
	icon as integer
	tag as integer
	tag2 as integer
	tag3 as integer
	text as integer
	text2 as integer // Top text in the box.
	x as float
	y as float
	w as float
	h as float
	ox as float
	oy as float
	visible as integer
	selected as integer
	status as integer // Bit pattern: LD_STATUS_LOCKED, LD_STATUS_SHARED, etc.
	help as string
	appIdx as integer // The app this item is for.
	idx as integer // The index into an app arr (if id is non-null), e.g. sprites, sounds, videos.
	uid as integer // For looking up a name, that might not be unique.
	
endtype

// User savable.

type Settings

	trueEdit as integer
	prevLoadedAppId as string // The previously loaded app.
	autoLoadPrevApp as integer // Auto load previous app.
	gridCols as integer // Designer grid cols, just for calcing width.
	gridRows as integer // Designer grid rows, just for calcing height.
	gridWidth as integer // Designer grid width.
	gridHeight as integer // Designer grid height.
	snapToGrid as integer // Snap to designed grid.
	snapGridHoriz as integer // 0 = left, 1 = mid, 2 = right
	snapGridVert as integer // 0 = top, 1 = mid, 2 = bottom
	tmpVarsAllowed as integer // Allow complex temp vars.
	showLayoutNames as integer // Show thing names in the designer by default.
	thingIconSize as integer // The size of things and images on commands, 1=1/4, 2=2/4, 3=3/4, 4=4/4
	projIconSize as integer // The size of the proj icon to save on a "Snap", 1, 2, 3, 4.
	runButPos as integer // The pos for run button on run screen, etc. TL, TR, BL, BR.
	quickNaming as integer // Don't ask for names, just use a unique name.
	designButPos as integer // The position of the more button on designer.
	autoRun as integer // Flag to automatically run when entering the runtime view from coder.
	titleOn as integer
	libsOn as integer // Turn on showing library projects.
	cmdSize as integer // Size of cmds.
	editLineSize as integer // Thickness of lines in editor.
	editTextSize as integer // Text size.
	editSnapToGrid as integer
	editGridRows as integer
	editGridCols as integer
	editErase as integer // Whether the color button is chosen, or erase.
	editCol as string // The selected color.
	editZoomLevel as integer // The level number, e.g. 0 to 10.
	helpSize as integer // The default help text size.
	editorButPos as integer // The position of the more button on editor.
	editLineStyle as integer // The style of the line.
	editDrawShape as integer // The shape.
	editShapeSameWH as integer // The shape w=h.
	editShapeFilled as integer // Obvious.
	editPolySides as integer // Number of sides of the poly.
	editSelShape as integer // The selection style.
	editGridWidth as integer
	editGridHeight as integer
	editTextFont as integer
	autoAccept as integer // The state of the auto accept button.
	panOn as integer
	deBgCol as integer
	agkCompiler as string
	
endtype

type Config

	nextAppId as integer
	nextThingId as integer
	nextImageId as integer
	nextCmdId as integer
	nextTextId as integer
	nextSoundId as integer
	nextVideoId as integer
	nextExId as integer
		
endtype

type CachedImage

	file as string
	img as integer

endtype

//-----------------------------------------------------
// 
function ldInit()
	
	ld.set.trueEdit = true
	ld.set.prevloadedAppId = ""
	ld.set.autoLoadPrevApp = true
	ld.set.gridRows = co.bs / 2
	ld.set.gridCols = co.bs / 2
	ld.set.gridWidth = 128
	ld.set.gridHeight = 128
	ld.set.gridCols = floor(co.w / ld.set.gridWidth)
	ld.set.gridRows = floor(co.h / ld.set.gridHeight)
	ld.set.snapToGrid = true
	ld.set.snapGridVert = 0 // Left.
	ld.set.snapGridHoriz = 0 // Top.
	ld.set.thingIconSize = 2
	ld.set.projIconSize = 1
	ld.set.runButPos = DIR_NE
	ld.set.showLayoutNames = false
	ld.set.quickNaming = true
	ld.set.designButPos = DIR_NE
	ld.set.autoRun = true
	ld.set.titleOn = true
	ld.set.libsOn = false
	ld.set.cmdSize = 4
	ld.set.editGridRows = 4
	ld.set.editGridCols = 4
	ld.set.editSnapToGrid = false
	ld.set.editCol = coColorToHex(co.black)
	ld.set.editLineSize = 10
	ld.set.editTextSize = 48
	ld.set.editZoomLevel = 2
	ld.set.editErase = false
	ld.set.helpSize = 1 // CD_DEF_HELP_FONT
	ld.set.editorButPos = DIR_NE
	ld.set.autoAccept = false
	ld.set.panOn = true
	ld.set.deBgCol = co.yellow[0]

	ld.set.editTextFont = 0
	ld.set.editLineStyle = CO_LINE_CIRC
	ld.set.editDrawShape = CO_SHAPE_RECT
	ld.set.editShapeSameWH = false
	ld.set.editShapeFilled = false
	ld.set.editPolySides = 3
	ld.set.editSelShape = CO_SEL_RECT
	ld.set.editGridWidth = 128
	ld.set.editGridHeight = 128
	
	ld.set.agkCompiler = ""

	ldLoadSettings()

	ld.set.trueEdit = false
	ld.set.tmpVarsAllowed = true
	ld.set.libsOn = false
	
	ld.cfg.nextAppId = 1
	ld.cfg.nextThingId = 1
	ld.cfg.nextImageId = 1
	ld.cfg.nextCmdId = 1	
	ld.cfg.nextTextId = 1	
	ld.cfg.nextSoundId = 1	
	ld.cfg.nextVideoId = 1
	ld.cfg.nextExId = 1

	ld.nextId = 1
	ld.loadingAppIdx = -1
		
	ldLoadConfig()
	ldLoadHelp()

	ldClearApps()	
	ldLoadAppList(LD_BASE_DIR + LD_APP_DIR)
	ldLoadAppList(LD_MEDIA_DIR + LD_EXAMPLE_DIR)
	
endfunction

//-----------------------------------------------------
// Load the list of file apps.
//
function ldLoadAppList(appFolder as string)

	local fh as integer
	local appId as string
	local appIdx as integer
	local img as integer
	local origFolder as string
	local s as string 
	local pos as integer
	local name as string
	local folder as string
	local app as App
	
	//ldClearApps()

	origFolder = GetCurrentDir()
	
	if setfolder(appFolder)
		
		//colog("writepath=" + GetWritePath() + getfolder())
		
		folder = GetFirstFolder()

		while folder <> ""

			//colog("folder=" + folder)
			
			appId = folder
			appIdx = maCreateApp(appId)
			ma.apps[appIdx].folder = appFolder + "/" + folder
			//colog("app folder=" + ma.apps[appIdx].folder)

			s = ldLoadCodeFile(ma.apps[appIdx].folder)
			
			if s <> ""
				
				ldDecodeAppHeader(app, s)
				
				ma.apps[appIdx].name = app.name
				ma.apps[appIdx].versionNbr = app.versionNbr
				ma.apps[appIdx].status = app.status
				ma.apps[appIdx].loaded = false
				//colog("ma.apps[" + str(appIdx) + "].name=" + ma.apps[appIdx].name + ", id=" + ma.apps[appIdx].id + ", status=" + hex(ma.apps[appIdx].status))
				
				if GetFileExists(folder + "/" + LD_ICON_FILE)				
					ma.apps[appIdx].img = loadImage(folder + "/" + LD_ICON_FILE)
				endif
				
			endif
			
			folder = GetNextFolder()

		endwhile
		
		setfolder("/" + origFolder)
		
	endif
	
endfunction

//-----------------------------------------------------
// Get a unique id so we find it in a search of the items list.
//
function ldNextLibItemId()

	local ret as integer
	
	ret = ld.nextId
	inc ld.nextId

	if ld.nextId > LD_ID_MAX
		ld.nextId = 1
	endif
	
endfunction ret

//-----------------------------------------------------
// Create a lib item, and save it.
// insert at 'insert' location. If -1 then sorted insert, if -2 then append.
//
function ldCreateLibItem(items ref as LibItem[], typ as integer, file as string, insert as integer)

	local libItem as LibItem
	local pos as integer
	local pos2 as integer
	local img as integer
	local i as integer
	local s as string

	// Save original path.
	libItem.uid = ldNextLibItemId()
	libItem.img = 0
	libItem.sharedImg = true
	libItem.id = ""
	libItem.typ = typ
	libItem.file = file
	libItem.folder = ""

	// Remove the path now.
	pos = FindStringReverse(file, "/")

	if pos > 0
		
		libItem.folder = mid(file, 1, pos - 1)
		file = mid(file, pos + 1, -1)
		
	endif

	pos2 = FindStringReverse(file, ".")

	if pos2 > 0
		
		libItem.name = mid(file, 1, pos2 - 1)
		libItem.ext = mid(file, pos2, -1)
		
	else

		libItem.name = file
		libItem.ext = ""

	endif

	libItem.w = co.bs * 2
	libItem.h = co.bs * 2
	libItem.visible = true
	libItem.selected = false
	libItem.status = 0
	libItem.tag = 0
	libItem.tag2 = 0
	libItem.tag3 = 0
	libItem.appIdx = -1
	
	if insert = -2
		
		items.insert(libItem)
		insert = items.length
		
	elseif insert = -1
		
		items.insertsorted(libItem)

		// Find the insert point.
		for i = 0 to items.length
			
			if items[i].uid = libItem.uid
				
				insert = i
				exit

			endif
			
		next
		
	elseif items.length >= insert
		
		items.insert(libItem, insert)
		
	else
		
		items.insert(libItem)
		insert = items.length
		
	endif
	
endfunction insert

//-----------------------------------------------------
// Create a lib item, and save it.
// insert at 'insert' location. If -1 then sorted insert, if -2 then append.
//
function ldCreateAppLibItem(items ref as LibItem[], appIdx as integer, insert as integer)

	local libItem as LibItem
	local i as integer

	// Save original path.
	libItem.img = 0
	libItem.sharedImg = true
	libItem.id = ma.apps[appIdx].id
	libItem.name = ma.apps[appIdx].name
	libItem.typ = LD_ITEM_APP_LIB
	libItem.folder = ma.apps[appIdx].folder
	libItem.file = libItem.folder + "/icon.png"
	libItem.w = co.bs * 2
	libItem.h = co.bs * 2
	libItem.visible = true
	libItem.selected = false
	libItem.tag = 0
	libItem.tag2 = 0
	libItem.tag3 = 0
	libItem.appIdx = appIdx
	libItem.idx = -1

	libItem.status = ma.apps[appIdx].status
	//libItem.status = 0
	
	if insert = -2
		
		items.insert(libItem)
		insert = items.length
		
	elseif insert = -1
		
		items.insertsorted(libItem)

		for i = 0 to items.length
			
			if items[i].name = libItem.name
				
				insert = i
				exit

			endif
			
		next
		
	elseif items.length >= insert
		
		items.insert(libItem, insert)
		
	else
		
		items.insert(libItem)
		insert = items.length
		
	endif
	
endfunction insert

//-----------------------------------------------------
//
function ldClearApps()

	local i as integer
	
	for i = 0 to ma.apps.length
		ldClearApp(i)		
	next

	ma.apps.length = -1
	
endfunction

//-----------------------------------------------------
//
function ldClearApp(appIdx as integer)

	if ma.apps[appIdx].img
		
		deleteimage(ma.apps[appIdx].img)
		ma.apps[appIdx].img = 0
		
	endif

	if ma.apps[appIdx].cmd
		
		cdDeleteCmd(ma.apps[appIdx].cmd)
		ma.apps[appIdx].cmd = 0
		
	endif
	
endfunction

//-----------------------------------------------------
// Remove an app from being loaded.
//
function ldUnloadApp(appId as string)

	local appIdx as integer
	
	appIdx = maFindAppById(appId)

	if appIdx > -1

		// Assuming that before calling this, all associated gfx has been unloaded.
		ma.apps[appIdx].vars.length = -1
		ma.apps[appIdx].sprites.length = -1
		ma.apps[appIdx].sounds.length = -1
		ma.apps[appIdx].videos.length = -1
		ma.apps[appIdx].sprId = ""
		ma.apps[appIdx].loaded = false
		
	endif
	
endfunction

//-----------------------------------------------------
// Delete an app, files, images, code, etc.
//
function ldDeleteApp(appId as string)

	local appIdx as integer
	local path as string
	local folder as string
	local dir as string
	local appFolder as string
	
	folder = GetCurrentDir()

	appIdx = maFindAppById(appId)
	//appFolder = ma.apps[appIdx].id + "_" + ma.apps[appIdx].name
	appFolder = ma.apps[appIdx].id

	if SetFolder(LD_BASE_DIR + LD_APP_DIR)

		deletefolder(appFolder)
		setfolder(folder)

	endif

endfunction

//-----------------------------------------------------
// Delete a frame.
//
function ldDeleteImage(appIdx as integer, img ref as Image)

	local thingIdx as integer
	local folder as string
	local appFolder as string
	local thingFolder as string
	local imgFile as string
	local prefix as string
	local newFolder as string

	folder = GetFolder()
	appFolder = ma.apps[appIdx].id	
	newFolder = LD_BASE_DIR + LD_APP_DIR + "/" + appFolder + LD_SPRITE_DIR
	
	if SetFolder(newFolder)

		imgFile = img.id + LD_GFX_FILE_SUFFIX
		deletefile(imgFile)
			

		setfolder(folder)
		
	endif

endfunction


//-----------------------------------------------------
// Delete a thing.
// Assumes already in "sprites" folder, and will go into "thingId" folder, delete, and jump out.
//
function ldDeleteSprite(appIdx as integer, thingId as string)

	local thingIdx as integer
	local i as integer
			
	thingIdx = maFindThingById(appIdx, thingId)

	for i = 0 to ma.things[thingIdx].imgs.length
		ldDeleteImage(appIdx, ma.things[thingIdx].imgs[i])
	next

endfunction

//-----------------------------------------------------
// Delete a lib item.
//
function ldDeleteLibItem(idx as integer)

	local newFile as string 
	local oldFile as string
	local dir as string 

	oldFile = ld.libItems[idx].file
	DeleteFile(oldFile)
	ld.libItems.remove(idx)

endfunction

//-----------------------------------------------------
// Rename a lib video.
//
function ldGetLibItemDir(libItem ref as LibItem)

	local ret as string
	
	if libItem.typ = LD_ITEM_APP_LIB
		ret = LD_APP_DIR
	elseif libItem.typ = LD_ITEM_SPRITE_LIB
		ret = LD_SPRITE_DIR
	elseif libItem.typ = LD_ITEM_SOUND_LIB
		ret = LD_SOUND_DIR
	elseif libItem.typ = LD_ITEM_VIDEO_LIB
		ret = LD_VIDEO_DIR
	else
		ret = ""
	endif
	
endfunction ret

//-----------------------------------------------------
// Delete a sound.
//
function ldDeleteSound(appIdx as integer, soundId as string)

	local soundIdx as integer
	local path as string

	soundIdx = maFindSoundById(appIdx, soundId)
	path = ma.apps[appIdx].folder + LD_SOUND_DIR + "/"
	deletefile(path + ma.sounds[soundIdx].file)

endfunction

//-----------------------------------------------------
// Delete a video.
//
function ldDeleteVideo(appIdx as integer, videoId as string)

	local videoIdx as integer
	local path as string

	videoIdx = maFindVideoById(appIdx, videoId)
	path = ma.apps[appIdx].folder + LD_VIDEO_DIR + "/"
	deletefile(path + ma.videos[videoIdx].file)

endfunction

//-----------------------------------------------------
// Load the code file as a string.
//
function ldLoadHelp()

	local fh as integer
	local s as string

	ld.cmdhelp.length = -1
	
	fh = OpenToRead(LD_MEDIA_DIR + "/help/" + LD_CMD_HELP_FILE)

	while not FileEOF(fh)
		
		s = ReadLine(fh)
		ld.cmdhelp.insert(s)
		
	endwhile
		
	closefile(fh)

	ld.pagehelp.length = -1

	fh = OpenToRead(LD_MEDIA_DIR + "/help/" + LD_PAGE_HELP_FILE)

	while not FileEOF(fh)
		
		s = ReadLine(fh)
		ld.pagehelp.insert(s)
		
	endwhile
		
	closefile(fh)

endfunction

//-----------------------------------------------------
// Load an app's code.
//
function ldLoadApp(appId as string)

	local s as string
	local i as integer
	local appIdx as integer

	s = ""
	appIdx = maFindAppById(appId)
	ld.loadingAppIdx = appIdx
	
	if appIdx > -1
			
		// Don't load if already loaded.
		if ma.apps[appIdx].loaded
			exitfunction true
		endif
		
		coProgressStart(1)
		//colog("folder=" + ma.apps[appIdx].folder)
		s = ldLoadCodeFile(ma.apps[appIdx].folder)
		coProgressEnd()

		if s = ""
			exitfunction false
		endif
	
		ldDecodeApp(appIdx, s)
	
	endif

	ld.loadingAppIdx = -1
	
	// Set the current app.
	ma.apps[appIdx].loaded = true
	ma.apps[appIdx].saved = true
	//cd.trimWhite = true
	
endfunction true

//-----------------------------------------------------
// Load the code file as a string.
//
function ldLoadCodeFile(appFolder as string)

	local folder as string
	local fh as integer
	local s as string
	local t as string
	local name as string
	local pos as integer

	s = ""

	folder = GetFolder()
	
	//if SetFolder(LD_BASE_DIR + LD_APP_DIR + "/" + appId)
	if SetFolder(appFolder)

		if AGK_BUILD
			name = LD_AGK_FILE
		else 
			name = LD_CODE_FILE
		endif
		
		if GetFileExists(name)
			
			fh = OpenToRead(name)

			if fh
				
				//s = readstring2(fh)
				s = readline(fh)
				
				if s = "{" // Expanded file, maybe formatted in a tool outside of codey codey.
				
					while not FileEOF(fh)
						
						t = readline(fh)
						s = s + trimstring(t, " ")
						
					endwhile					
					
				//else
				
				//	closefile(fh)
				//	fh = OpenToRead(name)
				//	s = ReadString(fh)
					
				endif
				
				closefile(fh)
				
			endif
			
		else 

			pos = findstring(name, ".")
			
			if pos > 0
				name = mid(name, 1, pos - 1) + "2" + mid(name, pos, -1)
			endif
			
			if GetFileExists(name)
				
				fh = OpenToRead(name)
	
				if fh
					
					s = readstring2(fh)
					//s = ReadString(fh)
					
					closefile(fh)
					
				endif
				
			endif
			
		endif
		
		setfolder("/" + folder)
		
	endif

endfunction s

//-----------------------------------------------------
// Decode the app header.
// Used for initiate project list, and called from DecodeApp full.
//
function ldDecodeAppHeader(app ref as App, s as string)

	local v as JsonValue

	if s <> ""
		
		v = jsonParse("appHdr", s)
		ldDecodeAppHeaderJson(app, v)

	//else

		//colog("Error: decode app, s is blank, check caller")
		
	endif
	
endfunction

//-----------------------------------------------------
// Decode the app header.
// Used for initiate project list, and called from DecodeApp full.
//
function ldDecodeAppHeaderJson(app ref as App, v ref as JsonValue)

	local tmp as JsonValue

	tmp = jsonGetByName(v, "nm")
	app.name = jsonGetString(tmp)

	tmp = jsonGetByName(v, "oid")
	app.ownerId = jsonGetStringDef(tmp, "")

	tmp = jsonGetByName(v, "onm")
	app.ownerName = jsonGetStringDef(tmp, "")

	tmp = jsonGetByName(v, "ver")
	app.versionNbr = jsonGetStringDef(tmp, VER_NBR)

	//tmp = jsonGetByName(v, "versionDate")
	//app.versionDate = jsonGetStringDef(tmp, "")

	tmp = jsonGetByName(v, "byp")
	app.buyPrice = jsonGetFloatDef(tmp, 0)

	tmp = jsonGetByName(v, "byd")
	app.buyDate = jsonGetStringDef(tmp, "")

	tmp = jsonGetByName(v, "sap")
	app.salePrice = jsonGetFloatDef(tmp, 0)

	//tmp = jsonGetByName(v, "shared")
	//app.shared = jsonGetStringDef(tmp, "")

	tmp = jsonGetByName(v, "st")
	app.status = jsonGetIntDef(tmp, 0)

	tmp = jsonGetByName(v, "scr")
	app.screen = jsonGetIntDef(tmp, 0)

	// Force status onto library or example projects to be locked, i.e. no change.
	if (app.status && LD_STATUS_LIBRARY) or (app.status && LD_STATUS_EXAMPLE)
		app.status = app.status || LD_STATUS_LOCKED
	endif
	
	//app.status = !(!app.status || LD_STATUS_MOB_PORT)
	
endfunction

//-----------------------------------------------------
// Decode the app.
// If headerOnly is true, then don't decode things.
//
function ldDecodeApp(appIdx as integer, s as string)

	local v as JsonValue
	local tmp as JsonValue
	local i as integer
	local varIdx as integer

	if appIdx < 0
		exitfunction
	endif
	
	coProgressStep()
	
	v = jsonParse("decApp", s)
	ldDecodeAppHeaderJson(ma.apps[appIdx], v)

	tmp = jsonGetByName(v, "sprId")

	if tmp.typ <> JSON_NULL
		ma.apps[appIdx].sprId = jsonGetString(tmp)
	else
		ma.apps[appIdx].sprId = ""
	endif

	tmp = jsonGetByName(v, "vars")
	ldDecodeVars(appIdx, -1, ma.apps[appIdx].vars, tmp)

	tmp = jsonGetByName(v, "snds")
	ldDecodeSounds(appIdx, ma.apps[appIdx].sounds, tmp)

	tmp = jsonGetByName(v, "vids")
	ldDecodeVideos(appIdx, ma.apps[appIdx].videos, tmp)

	ldDecodeThings(appIdx, v)

	coProgressStep()
	
endfunction

//-----------------------------------------------------
// Decode things fro json.
// v is the app object.
//
function ldDecodeThings(appIdx as integer, v ref as JsonValue)

	local i as integer
	local things as JsonValue
	local thing as JsonValue
	local thingIdx as integer
	local tmpThings as integer[]
	local tmpCmds as JsonValue[]

	i = 0
	things = jsonGetByName(v, "sprs") // Should be an array.

	thing = jsonGetByIndex(things, i) // Should be the first thing.

	while thing.typ <> JSON_NULL

		thingIdx = ldDecodeThing(appIdx, thing)
		
		tmpThings.insert(thingIdx)
		tmpCmds.insert(jsonGetByName(thing, "cmds"))

		inc i
		thing = jsonGetByIndex(things, i)
		
	endwhile

	// Post process the commands after all things are done,
	// so that we can handle cross-thing cmds like "(point at sprite)"
	
	//colog("appIdx=" + str(appIdx) + ", things=" + tmpThings.toJSON())
	
	for i = 0 to tmpThings.length
		ldDecodeCmds(appIdx, tmpThings[i], tmpCmds[i])		
	next
	
endfunction

//-----------------------------------------------------
// Decode a thing fro json.
// v is a thing JsonValue.
//
function ldDecodeThing(appIdx as integer, v ref as JsonValue)

	local tmp as JsonValue
	local thingIdx as integer
	local imgId as string
	local i as integer
	local varIdx as integer
	local w as float
	local h as float

	coProgressStep()

	tmp = jsonGetByName(v, "id")
	thingIdx = maCreateThing(jsonGetString(tmp))
	
	if appIdx > -1
		ma.apps[appIdx].sprites.insert(thingIdx)
	endif
	
	tmp = jsonGetByName(v, "nm")
	ma.things[thingIdx].name = jsonGetString(tmp)
	//tmp = jsonGetByName(v, "mv")
	//ma.things[thingIdx].moved = jsonGetbool(tmp)
	tmp = jsonGetByName(v, "x")
	ma.things[thingIdx].x = jsonGetFloat(tmp)
	tmp = jsonGetByName(v, "y")
	ma.things[thingIdx].y = jsonGetFloat(tmp)
	tmp = jsonGetByName(v, "sx")
	ma.things[thingIdx].sx = jsonGetFloat(tmp)
	if ma.things[thingIdx].sx <= DE_SMALLEST_SCALE
		ma.things[thingIdx].sx = DE_SMALLEST_SCALE
	endif
	tmp = jsonGetByName(v, "sy")
	ma.things[thingIdx].sy = jsonGetFloat(tmp)
	if ma.things[thingIdx].sy <= DE_SMALLEST_SCALE
		ma.things[thingIdx].sy = DE_SMALLEST_SCALE
	endif
	tmp = jsonGetByName(v, "an")
	ma.things[thingIdx].ang = jsonGetFloat(tmp)
	tmp = jsonGetByName(v, "sm")
	ma.things[thingIdx].smoothScaling = jsonGetInt(tmp)
/*
	// See if we have w and h.
	w = co.w
	h = co.h
	
	if ma.apps[appIdx].status && LD_STATUS_MOBILE
		
		w = co.mw
		h = co.mh
		
	endif
	
	tmp = jsonGetByName(v, "w")
	if not jsonIsNull(tmp)
		ma.things[thingIdx].w = jsonGetFloat(tmp)
		if ma.things[thingIdx].w > w
			ma.things[thingIdx].w = w
		endif
	else
		ma.things[thingIdx].w = 0
	endif

	tmp = jsonGetByName(v, "h")
	if not jsonIsNull(tmp)
		ma.things[thingIdx].h = jsonGetFloat(tmp)
		if ma.things[thingIdx].h > h
			ma.things[thingIdx].h = h
		endif
	else
		ma.things[thingIdx].h = 0
	endif
*/

	tmp = jsonGetByName(v, "imgId")
	imgId = jsonGetString(tmp)
	tmp = jsonGetByName(v, "imgs")
	
	ldDecodeImgs(appIdx, thingIdx, tmp)

	if imgId <> ""
		
		for i = 0 to ma.things[thingIdx].imgs.length
			
			if ma.things[thingIdx].imgs[i].id = imgId
				
				ma.things[thingIdx].imgIdx = i
				exit
				
			endif
			
		next

	endif

	tmp = jsonGetByName(v, "vars")
	ldDecodeVars(appIdx, thingIdx, ma.things[thingIdx].vars, tmp)
			
endfunction thingIdx

//-----------------------------------------------------
// Decode images.
// v is the list of images.
//
function ldDecodeImgs(appIdx as integer, thingIdx as integer, v ref as JsonValue)

	local i as integer
	local imgV as JsonValue
	local tmp as JsonValue
	local img as Image
	local imgIdx as integer

	i = 0
	imgV = jsonGetByIndex(v, i) // Should be the first cmd.

	while imgV.typ <> JSON_NULL

		coProgressStep()
		
		img.id = jsonGetString(imgV)
		
		if thingIdx > -1
			
			ma.things[thingIdx].imgs.insert(img)
			imgIdx = ma.things[thingIdx].imgs.length
			ldLoadThingImage(appIdx, thingIdx, imgIdx, LD_MODE_THUMB)
			
		endif

		inc i
		imgV = jsonGetByIndex(v, i)
		
	endwhile

endfunction

//-----------------------------------------------------
// Decode cmds from json into a thing cmds list.
// v is the list of cmds.
//
function ldDecodeCmds(appIdx as integer, thingIdx as integer, v ref as JsonValue)

	local i as integer
	local cmdV as JsonValue
	local cmd as integer

	i = 0
	cmdV = jsonGetByIndex(v, i) // Should be the first cmd.

	while cmdV.typ <> JSON_NULL
		
		cmd = ldDecodeCmd(appIdx, thingIdx, cmdV)
		
		if thingIdx > -1
			ma.things[thingIdx].cmds.insert(cmd)
		endif

		inc i
		cmdV = jsonGetByIndex(v, i)
		
	endwhile

endfunction

//-----------------------------------------------------
// Decode cmd from json.
// v is a single cmd.
//
function ldDecodeCmd(appIdx as integer, thingIdx as integer, v ref as JsonValue)

	local tmp as JsonValue
	local i as integer
	local j as integer
	local parts as JsonValue
	local part as JsonValue
	local part2 as JsonValue
	local cmd as integer
	local selCmdIdx as integer
	local selCmd as integer
	local partIdx as integer
	local hcode as string
	local code as integer

	coProgressStep()

	tmp = jsonGetByName(v, "cd")
	hcode = jsonGetString(tmp)
	code = coHexToInt(hcode)
	selCmdIdx = cdFindSelCmdIdx(code)
	
	if selCmdIdx > -1
		
		selCmd = cd.selCmds[selCmdIdx]
		cmd = cdCloneCmd(selCmd)
		//selCmd = 0 // Clear for decode part to use set part, rather than create part.
		
	else 

		cmd = cdCreateCmd(code)	
		selCmd = 0
		
	endif
			
	tmp = jsonGetByName(v, "rt")
	ma.cmds[cmd].root = jsonGetBool(tmp)
	ma.cmds[cmd].codeTab = true

	if ma.cmds[cmd].root
		
		tmp = jsonGetByName(v, "x")
		ma.cmds[cmd].x = jsonGetInt(tmp)
		tmp = jsonGetByName(v, "y")
		ma.cmds[cmd].y = jsonGetInt(tmp)

	endif
			
	parts = jsonGetByName(v, "pts")

	i = 0
	part = jsonGetByIndex(parts, i)

	while part.typ <> JSON_NULL

		tmp = jsonGetByName(part, "ix")
		partIdx = jsonGetInt(tmp)
		
		// Assume that selcmd has all parts.
		//if partIdx <= ma.cmds[cmd].parts.length
		ldDecodePart(appIdx, thingIdx, cmd, part, selCmd, partIdx)

		inc i
		part = jsonGetByIndex(parts, i)

	endwhile
	
	cdFixPluralCmd(cmd)
	cdUpdateCmdSize(cmd)
	cdSetCmdVisible(cmd, false)
	
endfunction cmd

//-----------------------------------------------------
// Decode part from json.
// v is a single part.
//
function ldDecodePart(appIdx as integer, thingIdx as integer, cmd as integer, v ref as JsonValue, selCmd as integer, partIdx as integer)

	local tmp as JsonValue
	local typ as integer
	local part as Part
	local partCmd as integer
	local info as string
	local partThingIdx as integer
	local partSoundIdx as integer
	local partVideoIdx as integer
	local imgId as string
	local pos as integer
	local varIdx as integer
	local varTyp as string // Type of var, s=sprite, p=project
	local varName as string
	local idx as integer
	local refThingIdx as integer

	coProgressStep()
	
	tmp = jsonGetByName(v, "tp") // This will be set for sub-cmds.
	
	if not jsonIsNull(tmp)	
		typ = jsonGetInt(tmp)
	else 
		typ = ma.cmds[cmd].parts[partIdx].typ
	endif 
		
	if typ = PART_STR or typ = PART_IMG

		if ma.cmds[cmd].typ && CMD_SPEC

			if partIdx > 0 // If a thing cmd, name is.
				
				partThingIdx = val(ma.cmds[cmd].parts[partIdx - 1].info)
				info = ma.things[partThingIdx].name
				part = cdCreatePart(typ, info)
				coSetTextColor(part.text, co.black)
				
			endif
			
		elseif selCmd

			info = ma.cmds[selCmd].parts[partIdx].info
			part = cdCreatePart(typ, info)
						
		endif

	elseif typ = PART_CMD

		tmp = jsonGetByName(v, "cmd")		
		partCmd = ldDecodeCmd(appIdx, thingIdx, tmp)
		part = cdCreatePartCmd(partCmd)

	else
		
		tmp = jsonGetByName(v, "in")
		info = jsonGetString(tmp)
		info = coReplaceNewlines(info)
		
		if typ = PART_VAR_NAME

			tmp = jsonGetByName(v, "sc")
			varTyp = jsonGetString(tmp)
			varName = ""
			varIdx = -1

			if varTyp = "p" // Project.

				idx = val(info)
				
				if appIdx > -1
					varIdx = ma.apps[appIdx].vars[idx]
				else 
					varIdx = -1
				endif
				
				cdSetCmdIcon2(cmd, cd.appVarImg)

			elseif varTyp = "s" // Sprite.

				idx = val(info)
				varIdx = -1
				
				if thingIdx > -1					
					if idx <= ma.things[thingIdx].vars.length						
						varIdx = ma.things[thingIdx].vars[idx]						
					endif				
				endif
				
				cdSetCmdIcon2(cmd, cd.spriteVarImg)
				
			endif			

			if varIdx > -1				
				part = cdCreatePartVar(varIdx)				
			endif
			
		elseif typ = PART_SPRITE_ICON
//xxx may need to fix how sprites are referenced in a cmd, does it exist yet?			
/*
			refThingIdx  = val(info)
			
			if appIdx > -1				
				if refThingIdx >= 0 and refThingIdx <= ma.apps[appIdx].sprites.length					
					part = cdCreatePartSprite(refThingIdx)
				endif				
			endif
*/			

			if appIdx > -1				
				if maFindThingById(appIdx, info) > -1				
					part = cdCreatePartSprite(info)
				endif				
			endif
			
		elseif typ = PART_FRAME_ICON

			part = cdCreatePartFrame(info)
		
		elseif typ = PART_SOUND_NAME

			//partSoundIdx = maFindSoundById(appIdx, info)
			//part = cdCreatePartSound(val(info))
			//part = cdCreatePartSound(partSoundIdx)
							
			part = cdCreatePartSound(info)
				
		elseif typ = PART_VIDEO_NAME

			//partVideoIdx = maFindVideoById(appIdx, info)
			//part = cdCreatePartVideo(val(info))
			//part = cdCreatePartVideo(partVideoIdx)			
			part = cdCreatePartVideo(info)

		else

			part = cdCreatePart(typ, info)

		endif

	endif
		
	if not selCmd
		cdAddCmdPart(cmd, part)
	else // if partIdx > -1
		cdSetCmdPart(cmd, part, partIdx)		
	endif
			

endfunction

//-----------------------------------------------------
// Decode vars from json.
// v is the list of vars.
//
function ldDecodeVars(appIdx as integer, thingIdx as integer, vars ref as integer[], v ref as JsonValue)

	local i as integer
	local tmp as JsonValue
	local var as integer

	i = 0
	tmp = jsonGetByIndex(v, i) // Should be the first var.

	while tmp.typ <> JSON_NULL

		coProgressStep()
		
		var = ldDecodeVar(appIdx, thingIdx, tmp)
		//maInsertVar(vars, var)
		// Need to append always on loading to ensure order of indexing in cmds is correct.
		vars.insert(var)
	
		inc i
		tmp = jsonGetByIndex(v, i)
		
	endwhile

endfunction

//-----------------------------------------------------
// Decode var from json.
// v is a single cmd.
//
function ldDecodeVar(appIdx as integer, thingIdx as integer, v ref as JsonValue)

	local tmp as JsonValue
	local var as integer
	local subVar as integer
	local items as JsonValue
	local item as JsonValue
	local i as integer
	local varItem as VarItem
	local names as string[]

	if appIdx < 0
		exitfunction -1 // No var.
	endif
	
	tmp = jsonGetByName(v, "tp")
	var = maCreateVar(jsonGetInt(tmp))
	tmp = jsonGetByName(v, "nm")
	ma.vars[var].name = jsonGetString(tmp)
	tmp = jsonGetByName(v, "vi")
	ma.vars[var].vis = jsonGetBoolDef(tmp, ma.vars[var].vis)	
	tmp = jsonGetByName(v, "x")
	ma.vars[var].v.x = jsonGetFloatDef(tmp, ma.vars[var].v.x)
	tmp = jsonGetByName(v, "y")
	ma.vars[var].v.y = jsonGetFloatDef(tmp, ma.vars[var].v.y)
	tmp = jsonGetByName(v, "w")
	ma.vars[var].v.w = jsonGetFloatDef(tmp, ma.vars[var].v.w)
	tmp = jsonGetByName(v, "h")
	ma.vars[var].v.h = jsonGetFloatDef(tmp, ma.vars[var].v.h)
	tmp = jsonGetByName(v, "bgc")
	ma.vars[var].v.bgCol = coMakeHexColor(jsonGetStringDef(tmp, coColorToHex(ma.vars[var].v.bgCol)))
	tmp = jsonGetByName(v, "tiv")
	ma.vars[var].v.titleVis = jsonGetBoolDef(tmp, ma.vars[var].v.titleVis)
	tmp = jsonGetByName(v, "tis")
	ma.vars[var].v.titleFontSize = jsonGetIntDef(tmp, ma.vars[var].v.titleFontSize)
	tmp = jsonGetByName(v, "tif")
	ma.vars[var].v.titleFont = jsonGetIntDef(tmp, ma.vars[var].v.titleFont)
	tmp = jsonGetByName(v, "tic")
	ma.vars[var].v.titleCol = coMakeHexColor(jsonGetStringDef(tmp, coColorToHex(ma.vars[var].v.titleCol)))
	tmp = jsonGetByName(v, "tid")
	ma.vars[var].v.titleDir = jsonGetIntDef(tmp, ma.vars[var].v.titleDir)
	tmp = jsonGetByName(v, "tia")
	ma.vars[var].v.titleAlign = jsonGetIntDef(tmp, ma.vars[var].v.titleAlign)
	tmp = jsonGetByName(v, "bxc")
	ma.vars[var].v.boxCol = coMakeHexColor(jsonGetStringDef(tmp, coColorToHex(ma.vars[var].v.boxCol)))
	tmp = jsonGetByName(v, "txs")
	ma.vars[var].v.textFontSize = jsonGetIntDef(tmp, ma.vars[var].v.textFontSize)
	tmp = jsonGetByName(v, "txf")
	ma.vars[var].v.textFont = jsonGetIntDef(tmp, ma.vars[var].v.textFont)
	tmp = jsonGetByName(v, "txc")
	ma.vars[var].v.textCol = coMakeHexColor(jsonGetStringDef(tmp, coColorToHex(ma.vars[var].v.textCol)))
	tmp = jsonGetByName(v, "txa")
	ma.vars[var].v.textAlign = jsonGetIntDef(tmp, ma.vars[var].v.textAlign)
	tmp = jsonGetByName(v, "txx")
	ma.vars[var].v.textSecret = jsonGetIntDef(tmp, ma.vars[var].v.textSecret)
	tmp = jsonGetByName(v, "dp")
	ma.vars[var].v.depth = jsonGetIntDef(tmp, ma.vars[var].v.depth)

	if ma.vars[var].v.titleFontSize < LD_TEXT_SIZE_MIN
		ma.vars[var].v.titleFontSize = LD_TEXT_SIZE_MIN
	elseif ma.vars[var].v.titleFontSize > LD_TEXT_SIZE_MAX // co.fontSizes.length
		ma.vars[var].v.titleFontSize = LD_TEXT_SIZE_MAX // co.fontSizes.length
	endif

	if ma.vars[var].v.titleFont < 0
		ma.vars[var].v.titleFont = 0
	elseif ma.vars[var].v.titleFont > co.fonts.length
		ma.vars[var].v.titleFont = co.fonts.length
	endif

	if ma.vars[var].v.textFontSize < LD_TEXT_SIZE_MIN
		ma.vars[var].v.textFontSize = LD_TEXT_SIZE_MIN
	elseif ma.vars[var].v.textFontSize > LD_TEXT_SIZE_MAX // co.fontSizes.length
		ma.vars[var].v.textFontSize = LD_TEXT_SIZE_MAX // co.fontSizes.length
	endif

	if ma.vars[var].v.textFont < 0
		ma.vars[var].v.textFont = 0
	elseif ma.vars[var].v.textFont > co.fonts.length
		ma.vars[var].v.textFont = co.fonts.length
	endif

	if ma.vars[var].v.titleAlign < 0 or ma.vars[var].v.titleAlign > 2
		ma.vars[var].v.titleAlign = 1 // Default to centre.
	endif

	if ma.vars[var].v.textAlign < 0 or ma.vars[var].v.textAlign > 8
		ma.vars[var].v.textAlign = 1 // Default to centre.
	endif
	
	ma.vars[var].appIdx = appIdx
	ma.vars[var].thingIdx = thingIdx

	if ma.vars[var].typ = VAR_TYPE_VALUE

		tmp = jsonGetByName(v, "val")
		ma.vars[var].value = jsonGetString(tmp)

	elseif ma.vars[var].typ = VAR_TYPE_LIST
		
		ma.vars[var].list.length = -1
		
		items = jsonGetByName(v, "list") // Is an array.		
		i = 0
		item = jsonGetByIndex(items, i)
		
		while item.typ <> JSON_NULL

			//varItem.name = ""
			//varItem.value = jsonGetString(item)
			tmp = jsonGetByName(item, "n")
			varItem.name = jsonGetString(tmp)
			tmp = jsonGetByName(item, "v")
			varItem.value = jsonGetString(tmp)
			varItem.parent = var

			ma.vars[var].list.insert(varItem)
			
			inc i
			item = jsonGetByIndex(items, i)
			
		endwhile

	elseif ma.vars[var].typ = VAR_TYPE_OBJECT
		
		ma.vars[var].list.length = -1
		
		item = jsonGetByName(v, "obj") // Is an array.
		names = jsonGetNames(item)
		
		for i = 0 to names.length
			
			varItem.name = names[i]
			tmp = jsonGetByName(item, names[i])
			varItem.value = jsonGetString(tmp)
			varItem.parent = var

			ma.vars[var].list.insertsorted(varItem)
			
		next

	endif
		
endfunction var

//-----------------------------------------------------
// Decode sounds from json.
// v is the list of sounds.
//
function ldDecodeSounds(appIdx as integer, sounds ref as integer[], v ref as JsonValue)

	local i as integer
	local tmp as JsonValue
	local sound as integer

	if appIdx < 0
		exitfunction 
	endif
	
	i = 0
	tmp = jsonGetByIndex(v, i) // Should be the first var.

	while tmp.typ <> JSON_NULL

		coProgressStep()
		
		sound = ldDecodeSound(appIdx, tmp)
		//maInsertSound(sounds, sound)
		// Need to append always on loading to ensure order of indexing in cmds is correct.
		sounds.insert(sound)
	
		inc i
		tmp = jsonGetByIndex(v, i)
		
	endwhile

endfunction

//-----------------------------------------------------
// Decode var from json.
// v is a single cmd.
//
function ldDecodeSound(appIdx as integer, v ref as JsonValue)

	local tmp as JsonValue
	local sound as integer
	local items as JsonValue
	local item as JsonValue
	local i as integer

	tmp = jsonGetByName(v, "id")
	sound = maCreateSound(jsonGetString(tmp))
	tmp = jsonGetByName(v, "nm")
	ma.sounds[sound].name = jsonGetString(tmp)
	ma.sounds[sound].file = ma.sounds[sound].id + LD_WAV_FILE_SUFFIX
			
endfunction sound

//-----------------------------------------------------
// Decode sounds from json.
// v is the list of sounds.
//
function ldDecodeVideos(appIdx as integer, videos ref as integer[], v ref as JsonValue)

	local i as integer
	local tmp as JsonValue
	local video as integer

	if appIdx < 0
		exitfunction
	endif
	
	i = 0
	tmp = jsonGetByIndex(v, i) // Should be the first var.

	while tmp.typ <> JSON_NULL

		coProgressStep()
		
		video = ldDecodeVideo(appIdx, tmp)
		//maInsertVideo(videos, video)
		// Need to append always on loading to ensure order of indexing in cmds is correct.
		videos.insert(video)

		inc i
		tmp = jsonGetByIndex(v, i)
		
	endwhile

endfunction

//-----------------------------------------------------
// Decode var from json.
// v is a single cmd.
//
function ldDecodeVideo(appIdx as integer, v ref as JsonValue)

	local tmp as JsonValue
	local video as integer
	local items as JsonValue
	local item as JsonValue
	local i as integer

	tmp = jsonGetByName(v, "id")
	video = maCreateVideo(jsonGetString(tmp))
	tmp = jsonGetByName(v, "nm")
	ma.videos[video].name = jsonGetString(tmp)
	tmp = jsonGetByName(v, "ex")
	ma.videos[video].ext = jsonGetString(tmp)
	
	ma.videos[video].file = ma.videos[video].id + ma.videos[video].ext
	
endfunction video

//-----------------------------------------------------
// Save an app's code, check if locked and don't save.
//
function ldSaveApp(appId as string)

	local appIdx as integer

	appIdx = maFindAppById(appId)
	
	if ma.apps[appIdx].status && LD_STATUS_LOCKED and not ma.apps[appIdx].status && LD_STATUS_LIBRARY

		// Don't save locked projects.
		ma.apps[appIdx].saved = true
		exitfunction
		
	endif
	
	ldSaveAppAlways(appId)
	
endfunction

//-----------------------------------------------------
// Save an app's code, always.
//
function ldSaveAppAlways(appId as string)

	local v as JsonValue
	local things as JsonValue
	local vars as JsonValue
	local sounds as JsonValue
	local videos as JsonValue
	local tmp as JsonValue
	local i as integer
	local fh as integer
	local folder as string 
	local appIdx as integer
	local name as string
	local pos as integer

	appIdx = maFindAppById(appId)

	if ma.apps[appIdx].id = ""
		ma.apps[appIdx].id = ldGetNextAppId()
	endif

	// The app.
	
	jsonSetString(tmp, ma.apps[appIdx].id)
	jsonSetByName(v, "id", tmp)
	
	jsonSetString(tmp, ma.apps[appIdx].name)
	jsonSetByName(v, "nm", tmp)
	
	jsonSetString(tmp, ma.apps[appIdx].ownerId)
	jsonSetByName(v, "oid", tmp)
	
	jsonSetString(tmp, ma.apps[appIdx].ownerName)
	jsonSetByName(v, "onm", tmp)
	
	jsonSetString(tmp, ma.apps[appIdx].versionNbr)
	jsonSetByName(v, "ver", tmp)
		
	//jsonSetString(tmp, ma.apps[appIdx].versionDate)
	//jsonSetByName(v, "versionDate", tmp)

	jsonSetFloat(tmp, ma.apps[appIdx].buyPrice)
	jsonSetByName(v, "byp", tmp)

	jsonSetString(tmp, ma.apps[appIdx].buyDate)
	jsonSetByName(v, "byd", tmp)

	jsonSetFloat(tmp, ma.apps[appIdx].salePrice)
	jsonSetByName(v, "sap", tmp)

	//jsonSetString(tmp, ma.apps[appIdx].shared)
	//jsonSetByName(v, "shd", tmp)
	
	jsonSetInt(tmp, ma.apps[appIdx].status)
	jsonSetByName(v, "st", tmp)

	jsonSetInt(tmp, ma.apps[appIdx].screen)
	jsonSetByName(v, "scr", tmp)

	// The current sprite.
	
	if ma.apps[appIdx].sprId <> ""

		jsonSetString(tmp, ma.apps[appIdx].sprId)
		jsonSetByName(v, "sprId", tmp)

	endif

	// Vars.
	
	for i = 0 to ma.apps[appIdx].vars.length

		tmp = ldEncodeVar(ma.vars[ma.apps[appIdx].vars[i]])
		jsonSetByAppend(vars, tmp)
		
	next

	jsonSetByName(v, "vars", vars)

	// Sounds.
	
	for i = 0 to ma.apps[appIdx].sounds.length

		tmp = ldEncodeSound(ma.sounds[ma.apps[appIdx].sounds[i]])
		jsonSetByAppend(sounds, tmp)
		
	next

	jsonSetByName(v, "snds", sounds)

	// Videos.
	
	for i = 0 to ma.apps[appIdx].videos.length

		tmp = ldEncodeVideo(ma.videos[ma.apps[appIdx].videos[i]])
		jsonSetByAppend(videos, tmp)
		
	next

	jsonSetByName(v, "vids", videos)

	// Sprites.
	
	for i = 0 to ma.apps[appIdx].sprites.length

		//tmp = ldEncodeThing(ma.apps[appIdx], ma.things[ma.apps[appIdx].things[i]])
		tmp = ldEncodeThing(appIdx, ma.apps[appIdx].sprites[i])
		jsonSetByAppend(things, tmp)
		
	next

	jsonSetByName(v, "sprs", things)

	// Save code file.

	folder = GetFolder()
	
	//if SetFolder(LD_LIB_BASE + "/" + LD_APP_DIR + "/" + ma.apps[appIdx].folder)
	if SetFolder(ma.apps[appIdx].folder)

		if AGK_BUILD
			name = LD_AGK_FILE
		else
			name = LD_CODE_FILE
		endif
			
		if (false) // true for version 2.

			pos = findstring(name, ".")
			
			if pos > 0
				name = mid(name, 1, pos - 1) + "2" + mid(name, pos, -1)
			endif
	
			fh = OpenToWrite(name)
			
			if fh
				
				//writeline(fh, jsonToString(v))
				writestring2(fh, jsonToString(v))
				closefile(fh)
				
			endif
			
		else 
			
			fh = OpenToWrite(name)
			
			if fh
				
				writeline(fh, jsonToString(v))
				//writestring2(fh, jsonToString(v))
				closefile(fh)
				
			endif
			
		endif

		if ma.apps[appIdx].img
			SaveImage(ma.apps[appIdx].img, LD_ICON_FILE)
		endif

		setfolder("/" + folder)
		
	endif

	ma.apps[appIdx].saved = true
	//ma.apps[appIdx].loaded = true
	
endfunction

//-----------------------------------------------------
// Copy all the assets from src app to dest.
//
function ldCopyAppMedia(srcAppIdx as integer, destAppIdx as integer)

	local i as integer
	local j as integer
	local thingIdx as integer
	local srcFile as string
	local destFile as string 
	
	// Sprites.
	
	for i = 0 to ma.apps[srcAppIdx].sprites.length

		thingIdx = ma.apps[srcAppIdx].sprites[i]

		for j = 0 to ma.things[thingIdx].imgs.length

			srcFile = ma.apps[srcAppIdx].folder + LD_SPRITE_DIR + "/" + ma.things[thingIdx].imgs[j].id + LD_GFX_FILE_SUFFIX
			destFile = ma.apps[destAppIdx].folder + LD_SPRITE_DIR + "/" + ma.things[thingIdx].imgs[j].id + LD_GFX_FILE_SUFFIX
			coCopyMediaFile(srcFile, destFile)

		next
		
	next

	// Sounds.
	
	for i = 0 to ma.apps[srcAppIdx].sounds.length

		thingIdx = ma.apps[srcAppIdx].sounds[i]
		srcFile = ma.apps[srcAppIdx].folder + LD_SOUND_DIR + "/" + ma.sounds[thingIdx].id + LD_WAV_FILE_SUFFIX
		destFile = ma.apps[destAppIdx].folder + LD_SOUND_DIR + "/" + ma.sounds[thingIdx].id + LD_WAV_FILE_SUFFIX
		coCopyMediaFile(srcFile, destFile)
		
	next

	// Videos.
	
	for i = 0 to ma.apps[srcAppIdx].videos.length

		thingIdx = ma.apps[srcAppIdx].videos[i]
		srcFile = ma.apps[srcAppIdx].folder + LD_VIDEO_DIR + "/" + ma.videos[thingIdx].id + LD_MP4_FILE_SUFFIX
		destFile = ma.apps[destAppIdx].folder + LD_VIDEO_DIR + "/" + ma.videos[thingIdx].id + LD_MP4_FILE_SUFFIX
		coCopyMediaFile(srcFile, destFile)
		
	next

endfunction

//-----------------------------------------------------
// Unload all thing images.
// mode = LD_MODE_IMAGE or THUMB
//
function ldUnloadThingImages(appIdx as integer, mode as integer)

	local i as integer
	
	for i = 0 to ma.apps[appIdx].sprites.length
		ldUnloadThingImage(ma.apps[appIdx].sprites[i], -1, mode)
	next
	
endfunction

//-----------------------------------------------------
// Unload a thing sprite.
// mode = LD_MODE_IMAGE or THUMB
// if frameIdx = -1, then the selected img is used.
//
function ldUnloadThingImage(thingIdx as integer, frameIdx as integer, mode as integer)

	local i as integer

	if thingIdx <= -1
		exitfunction
	endif
	
	for i = 0 to ma.things[thingIdx].imgs.length

		if mode && LD_MODE_IMAGE
				
			if ma.things[thingIdx].imgs[i].img

				if frameIdx = -1 or frameIdx = i
					
					deleteimage(ma.things[thingIdx].imgs[i].img)
					ma.things[thingIdx].imgs[i].img = 0

				endif
				
			endif

		endif

		if mode && LD_MODE_THUMB
			
			if ma.things[thingIdx].imgs[i].thumb
				
				if frameIdx = -1 or frameIdx = i
					
					deleteimage(ma.things[thingIdx].imgs[i].thumb)
					ma.things[thingIdx].imgs[i].thumb = 0

				endif
				
			endif

		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Load thumbnails for all things images.
// mode = LD_STATUS_
//
function ldLoadThingImages(appIdx as integer, mode as integer)

	local i as integer
	local j as integer
	local thingIdx as integer
	
	if appIdx > -1
		
		for i = 0 to ma.apps[appIdx].sprites.length
			
			thingIdx = ma.apps[appIdx].sprites[i]
			
			for j = 0 to ma.things[thingIdx].imgs.length
				ldLoadThingImage(appIdx, thingIdx, j, mode)
			next 
			
		next 
		
	endif
	
endfunction

//-----------------------------------------------------
// Load a thing sprite.
// mode = LD_STATUS_
//
function ldLoadThingImage(appIdx as integer, thingIdx as integer, imgIdx as integer, mode as integer)

	local imgFile as string
	local thumbFile as string
	local img as integer
	local imgForThumb as integer

	if not (imgIdx > -1 and imgIdx <= ma.things[thingIdx].imgs.length)

		colog("Error: ldLoadThingImage called with invalid imgIdx=" + str(imgIdx))
		exitfunction
		
	endif
		
	imgForThumb = false
	
	if mode && LD_MODE_THUMB

		if ma.apps[appIdx].status && LD_STATUS_HACK
			thumbFile = LD_MEDIA_DIR + "/gfx/SpriteBlackIcon.png"
		else 		
			thumbFile = ma.apps[appIdx].folder + LD_THUMB_DIR + "/" + ma.things[thingIdx].imgs[imgIdx].id + LD_GFX_FILE_SUFFIX
		endif
		
		if not ma.things[thingIdx].imgs[imgIdx].thumb
			if GetFileExists(thumbFile)		
				ma.things[thingIdx].imgs[imgIdx].thumb = loadimage(thumbFile)
			endif
		endif		

		// Thumb doesn't exist, force image load to create thumb, but then clean up.
		if not ma.things[thingIdx].imgs[imgIdx].thumb
			imgForThumb = true					
		endif

	endif

	if imgForThumb or (mode && LD_MODE_IMAGE)

		imgFile = ma.apps[appIdx].folder + LD_SPRITE_DIR + "/" + ma.things[thingIdx].imgs[imgIdx].id + LD_GFX_FILE_SUFFIX
		
		if not ma.things[thingIdx].imgs[imgIdx].img									
			ma.things[thingIdx].imgs[imgIdx].img = loadimage(imgFile)

		else
			imgForThumb = false // Image is already loaded, so no need to clean up after thumb.
		endif

		if ma.things[thingIdx].imgs[imgIdx].img

			// If image was loaded, but no thumb loaded,
			// create the thumb now and save it.
			//
			if (mode && LD_MODE_THUMB) and not ma.things[thingIdx].imgs[imgIdx].thumb
				
				ldSaveThingThumb(appIdx, thingIdx, imgIdx)

				// Clear up image, if we just loaded it to create the thumb.
				if imgForThumb and ma.things[thingIdx].imgs[imgIdx].img
					
					deleteimage(ma.things[thingIdx].imgs[imgIdx].img)
					ma.things[thingIdx].imgs[imgIdx].img = 0

				endif
				
			endif

		endif
			
	endif
	
endfunction

//-----------------------------------------------------
// Save a thing.
//
function ldSaveThingImage(appIdx as integer, thingIdx as integer, imgIdx as integer)

	local imgPath as string
	local imgFile as string 
	
	imgPath = ma.apps[appIdx].folder + LD_SPRITE_DIR + "/"
	imgFile = imgPath + ma.things[thingIdx].imgs[imgIdx].id + LD_GFX_FILE_SUFFIX
	
	if ma.things[thingIdx].imgs[imgIdx].img
		
		SaveImage(ma.things[thingIdx].imgs[imgIdx].img, imgFile)
		ldSaveThingThumb(appIdx, thingIdx, imgIdx)

		// Don't ever need this image after saving it.
		if ma.things[thingIdx].imgs[imgIdx].img

			deleteimage(ma.things[thingIdx].imgs[imgIdx].img)
			ma.things[thingIdx].imgs[imgIdx].img = 0
			
		endif

	endif

endfunction

//-----------------------------------------------------
// Save a thing.
//
function ldSaveThingThumb(appIdx as integer, thingIdx as integer, imgIdx as integer)

	local thumbPath as string
	local thumbFile as string
	local img as integer

	thumbPath = ma.apps[appIdx].folder + LD_THUMB_DIR + "/"
	thumbFile = thumbPath + ma.things[thingIdx].imgs[imgIdx].id + LD_GFX_FILE_SUFFIX

	// Clean the current thumb, about to recreate from img.
	if ma.things[thingIdx].imgs[imgIdx].thumb
		
		deleteimage(ma.things[thingIdx].imgs[imgIdx].thumb)
		ma.things[thingIdx].imgs[imgIdx].thumb = 0

	endif

	img = ma.things[thingIdx].imgs[imgIdx].img

	if img
		
		ma.things[thingIdx].imgs[imgIdx].thumb = CopyImage(img, 0, 0, GetImageWidth(img), GetImageHeight(img))

		if ma.things[thingIdx].imgs[imgIdx].thumb

			coResizeImage(ma.things[thingIdx].imgs[imgIdx].thumb, co.bs * 1.25)
			SaveImage(ma.things[thingIdx].imgs[imgIdx].thumb, thumbFile)

		endif

	endif

endfunction

//-----------------------------------------------------
// Save a sound.
//
function ldSaveSound(appIdx as integer, soundIdx as integer)

	local newPath as string
	local newFile as string
	local soundId as integer
	local folder as string 
	
	newPath = ma.apps[appIdx].folder + LD_SOUND_DIR + "/"
	newFile = ma.sounds[soundIdx].id + LD_WAV_FILE_SUFFIX
	
	soundId = loadsound(ma.sounds[soundIdx].file)	
	SaveSound(soundId, newPath + newFile)
	ma.sounds[soundIdx].file = newFile

endfunction

//-----------------------------------------------------
// Save a video.
//
function ldSaveVideo(appIdx as integer, videoIdx as integer)

	local newPath as string
	local newFile as string
	local inId as integer
	local outId as integer
	local b as integer
	
	newPath = ma.apps[appIdx].folder + LD_VIDEO_DIR + "/"
	newFile = newPath + ma.videos[videoIdx].id + ma.videos[videoIdx].ext

	coCopyMediaFile(ma.videos[videoIdx].file, newFile)
	ma.videos[videoIdx].file = newFile

endfunction

//-----------------------------------------------------
// Save a video.
//
function ldGetRecordFile()

	local newPath as string
	local newFile as string

	newPath = LD_BASE_DIR + LD_VIDEO_DIR + "/"
	newFile = ldGetNextVideoId() + LD_MP4_FILE_SUFFIX

endfunction newFile

//-----------------------------------------------------
// Rename an app.
//
function ldRenameApp(appIdx as integer, newName as string)

	local i as integer
	local folder as string
	local oldDir as string
	local oldPath as string

	// Rename and save the directory.
	ma.apps[appIdx].name = newName
	ldSaveApp(ma.apps[appIdx].id)
	
endfunction

//-----------------------------------------------------
// Get a unique file system name.
//
function ldGetUniqueFileName(folder as string, file as string)

	local nameUnique as integer
	local suffix as integer
	local name as string
	local i as integer
	local pos as integer
	
	suffix = 0
	name = file
	nameUnique = false
	
	while not nameUnique

		nameUnique = true

		if GetFileExists(folder + "/" + name)

			nameUnique = false
			inc suffix

			pos = FindStringReverse(file, ".")

			if pos > 0
				name = mid(file, 1, pos - 1) + "-" + str(suffix) + mid(file, pos, -1)
			else
				name = file + "-" + str(suffix)
			endif

		endif

	endwhile

endfunction folder + "/" + name

//-----------------------------------------------------
// Get a unique lib item name.
//
function ldGetUniqueLibItemName(s as string)

	local nameUnique as integer
	local suffix as integer
	local name as string
	local i as integer
	
	suffix = 0
	name = s
	nameUnique = false
	
	while not nameUnique

		nameUnique = true
		
		for i = 0 to ld.libItems.length
			
			if ld.libItems[i].name = name

				nameUnique = false
				inc suffix
				name = s + "-" + str(suffix)
				exit

			endif
			
		next

	endwhile
	
endfunction s

//-----------------------------------------------------
// Get a unique lib folder name.
//
function ldGetUniqueLibFolderName(s as string)

	local nameUnique as integer
	local suffix as integer
	local name as string
	local i as integer
	
	suffix = 0
	name = s
	nameUnique = false
	
	while not nameUnique

		nameUnique = true
		
		for i = 0 to ld.libItems.length
			
			if ld.libItems[i].name = name

				nameUnique = false
				inc suffix
				name = s + "-" + str(suffix)
				exit

			endif
			
		next

	endwhile
	
endfunction s

//-----------------------------------------------------
// Rename a lib item.
//
function ldRenameLibItem(libItem ref as LibItem, newName as string, dir as string)

	local newFile as string 
	local oldFile as string

	oldFile = libItem.file
	newFile = LD_BASE_DIR + "/" + dir + "/" + newName + libItem.ext

	coCopyMediaFile(oldFile, newFile)
	DeleteFile(oldFile)
	
	libItem.name = newName
	libItem.name = newFile

endfunction

//-----------------------------------------------------
// Rename a lib folder.
//
function ldRenameLibFolder(libItem ref as LibItem, newName as string)

	local oldParentFolder as string 
	local oldName as string
	local pos as integer
	local ret as integer
	local oldFolder as string
	local newPath as string
	local origFolder as string
	local file as string
	local oldFile as string
	local newFile as string 

	pos = FindStringReverse(libItem.file, "/")
	ret = true
	
	if pos > 0

		oldFolder = mid(libItem.file, 1, pos - 1)
		oldName = mid(libItem.file, pos + 1, -1)
		newPath = oldFolder + "/" + newName

		if not GetFileExists(newPath)
			MakeFolder(newPath)
		endif

		origFolder = GetFolder()
		
		if SetFolder(libItem.file)

			file = GetFirstFile()

			while file <> ""

				if left(file, 1) <> "."
					
					oldFile = libItem.file + "/" + file
					newFile = newPath + "/" + file

					coCopyMediaFile(oldFile, newFile)
					DeleteFile(oldFile)
					
				endif
							
				file = GetNextFile()

			endwhile

			libItem.file = newPath

			setfolder("..")
			DeleteFolder(oldName)

			setfolder("/" + origFolder)
			
		endif
		
	endif
	
/*
	oldFile = libItem.file
	newFile = LD_LIB_BASE + "/" + folder + "/" + newName + libItem.ext

	coCopyFile(oldFile, newFile)
	DeleteFile(oldFile)
	
	libItem.name = newName
	libItem.name = newFile
*/

endfunction

//-----------------------------------------------------
// Encode a thing.
//
function ldEncodeThing(appIdx as integer, thingIdx as integer)

	local v as JsonValue
	local tmp as JsonValue
	local imgs as JsonValue
	local cmds as JsonValue
	local vars as JsonValue
	local img as JsonValue
	local var as JsonValue
	local i as integer

	// Encode the thing.
	
	jsonSetString(tmp, ma.things[thingIdx].id)
	jsonSetByName(v, "id", tmp)
	jsonSetString(tmp, ma.things[thingIdx].name)
	jsonSetByName(v, "nm", tmp)
	//jsonSetBool(tmp, ma.things[thingIdx].moved)
	//jsonSetByName(v, "mv", tmp)
	jsonSetFloat(tmp, ma.things[thingIdx].x)
	jsonSetByName(v, "x", tmp)
	jsonSetFloat(tmp, ma.things[thingIdx].y)
	jsonSetByName(v, "y", tmp)
	jsonSetFloat(tmp, ma.things[thingIdx].sx)
	jsonSetByName(v, "sx", tmp)
	jsonSetFloat(tmp, ma.things[thingIdx].sy)
	jsonSetByName(v, "sy", tmp)
	jsonSetFloat(tmp, ma.things[thingIdx].ang)
	jsonSetByName(v, "an", tmp)
	jsonSetInt(tmp, ma.things[thingIdx].smoothScaling)
	jsonSetByName(v, "sm", tmp)
	jsonSetFloat(tmp, ma.things[thingIdx].w)
	jsonSetByName(v, "w", tmp)
	jsonSetFloat(tmp, ma.things[thingIdx].h)
	jsonSetByName(v, "h", tmp)

	if ma.things[thingIdx].imgIdx > -1
		
		jsonSetString(tmp, ma.things[thingIdx].imgs[ma.things[thingIdx].imgIdx].id)
		jsonSetByName(v, "imgId", tmp)
		
	endif

	// Encode images.
	
	for i = 0 to ma.things[thingIdx].imgs.length

		jsonSetString(tmp, ma.things[thingIdx].imgs[i].id)
		jsonSetByAppend(imgs, tmp)
		//jsonSetString(tmp, ma.things[thingIdx].imgs[i].id)
		//jsonSetByName(img, "id", tmp)
		//jsonSetByAppend(imgs, img)
		
	next

	jsonSetByName(v, "imgs", imgs)

	// Encode the vars.
	
	for i = 0 to ma.things[thingIdx].vars.length

		tmp = ldEncodeVar(ma.vars[ma.things[thingIdx].vars[i]])
		jsonSetByAppend(vars, tmp)
		
	next

	jsonSetByName(v, "vars", vars)
	
	// Encode cmds.
	
	for i = 0 to ma.things[thingIdx].cmds.length

		//tmp = ldEncodeCmd(app, thing, ma.cmds[ma.things[thingIdx].cmds[i]])
		tmp = ldEncodeCmd(appIdx, thingIdx, ma.cmds[ma.things[thingIdx].cmds[i]])
		jsonSetByAppend(cmds, tmp)
		
	next

	jsonSetByName(v, "cmds", cmds)

endfunction v

//-----------------------------------------------------
// Encode a var.
//
function ldEncodeVar(var ref as Var)

	local v as JsonValue
	local tmp as JsonValue
	local list as JsonValue
	local i as integer
	local pos as integer
	local item as JsonValue

	jsonSetInt(tmp, var.typ)
	jsonSetByName(v, "tp", tmp)
	jsonSetString(tmp, var.name)
	jsonSetByName(v, "nm", tmp)
	jsonSetBool(tmp, var.vis)
	jsonSetByName(v, "vi", tmp)
	
	jsonSetFloat(tmp, var.v.x)
	jsonSetByName(v, "x", tmp)
	jsonSetFloat(tmp, var.v.y)
	jsonSetByName(v, "y", tmp)

	if var.v.w <> ma.defvv.w

		jsonSetFloat(tmp, var.v.w)
		jsonSetByName(v, "w", tmp)

	endif

	if var.v.h <> ma.defvv.h

		jsonSetFloat(tmp, var.v.h)
		jsonSetByName(v, "h", tmp)

	endif
	
	if var.v.bgCol <> ma.defvv.bgCol
		
		jsonSetString(tmp, coColorToHex(var.v.bgCol))
		jsonSetByName(v, "bgc", tmp)

	endif

	if var.v.titleVis <> ma.defvv.titleVis
		
		jsonSetBool(tmp, var.v.titleVis)
		jsonSetByName(v, "tiv", tmp)

	endif

	if var.v.titleCol <> ma.defvv.titleCol
		
		jsonSetString(tmp, coColorToHex(var.v.titleCol))
		jsonSetByName(v, "tic", tmp)

	endif

	if var.v.titleFontSize <> ma.defvv.titleFontSize
		
		jsonSetInt(tmp, var.v.titleFontSize)
		jsonSetByName(v, "tis", tmp)

	endif

	if var.v.titleFont <> ma.defvv.titleFont
		
		jsonSetInt(tmp, var.v.titleFont)
		jsonSetByName(v, "tif", tmp)

	endif

	if var.v.titleDir <> ma.defvv.titleDir
		
		jsonSetInt(tmp, var.v.titleDir)
		jsonSetByName(v, "tid", tmp)

	endif

	if var.v.titleAlign <> ma.defvv.titleAlign
		
		jsonSetInt(tmp, var.v.titleAlign)
		jsonSetByName(v, "tia", tmp)

	endif

	if var.v.boxCol <> ma.defvv.boxCol
		
		jsonSetString(tmp, coColorToHex(var.v.boxCol))
		jsonSetByName(v, "bxc", tmp)

	endif

	if var.v.textFontSize <> ma.defvv.textFontSize
		
		jsonSetInt(tmp, var.v.textFontSize)
		jsonSetByName(v, "txs", tmp)

	endif

	if var.v.textFont <> ma.defvv.textFont
		
		jsonSetInt(tmp, var.v.textFont)
		jsonSetByName(v, "txf", tmp)

	endif

	if var.v.textCol <> ma.defvv.textCol
		
		jsonSetString(tmp, coColorToHex(var.v.textCol))
		jsonSetByName(v, "txc", tmp)

	endif

	if var.v.textAlign <> ma.defvv.textAlign
		
		jsonSetInt(tmp, var.v.textAlign)
		jsonSetByName(v, "txa", tmp)

	endif

	if var.v.textSecret <> ma.defvv.textSecret
		
		jsonSetInt(tmp, var.v.textSecret)
		jsonSetByName(v, "txx", tmp)

	endif

	if var.v.depth <> ma.defvv.depth
		
		jsonSetInt(tmp, var.v.depth)
		jsonSetByName(v, "dp", tmp)

	endif

	if var.typ = VAR_TYPE_VALUE

		jsonSetString(tmp, var.value)
		jsonSetByName(v, "val", tmp)

	elseif var.typ = VAR_TYPE_LIST

		for i = 0 to var.list.length

			jsonSetString(tmp, var.list[i].name)
			jsonSetByName(item, "n", tmp)
			jsonSetString(tmp, var.list[i].value)
			jsonSetByName(item, "v", tmp)

			//jsonSetString(tmp, var.list[i].value)
			//jsonSetByAppend(list, tmp)
			jsonSetByAppend(list, item)
			
		next

		jsonSetByName(v, "list", list)
		
	elseif var.typ = VAR_TYPE_OBJECT

		for i = 0 to var.list.length

			jsonSetString(tmp, var.list[i].value)
			jsonSetByName(list, var.list[i].name, tmp)
			
		next

		jsonSetByName(v, "obj", list)
		
	endif	

endfunction v

//-----------------------------------------------------
// Encode a sound.
//
function ldEncodeSound(sound ref as Sound)

	local v as JsonValue
	local tmp as JsonValue
	
	jsonSetString(tmp, sound.id)
	jsonSetByName(v, "id", tmp)
	jsonSetString(tmp, sound.name)
	jsonSetByName(v, "nm", tmp)

endfunction v

//-----------------------------------------------------
// Encode a video.
//
function ldEncodeVideo(video ref as Video)

	local v as JsonValue
	local tmp as JsonValue

	jsonSetString(tmp, video.id)
	jsonSetByName(v, "id", tmp)
	jsonSetString(tmp, video.name)
	jsonSetByName(v, "nm", tmp)
	jsonSetString(tmp, video.ext)
	jsonSetByName(v, "ex", tmp)

endfunction v

//-----------------------------------------------------
// Encode a cmd.
//
function ldEncodeCmd(appIdx as integer, thingIdx as integer, cmd ref as Cmd)

	local v as JsonValue
	local tmp as JsonValue
	local parts as JsonValue
	local part as JsonValue
	local x as float
	local y as float

	jsonSetString(tmp, hex(cmd.code))
	jsonSetByName(v, "cd", tmp)

	if cmd.root
		
		jsonSetBool(tmp, cmd.root)
		jsonSetByName(v, "rt", tmp)
		x = cmd.x - getspritex(cd.codePanel.panel)
		jsonSetInt(tmp, x)
		jsonSetByName(v, "x", tmp)
		y = cmd.y - getspritey(cd.codePanel.panel)
		jsonSetInt(tmp, y)
		jsonSetByName(v, "y", tmp)

	endif
	
	ldEncodeParts(v, appIdx, thingIdx, cmd)

endfunction v

//-----------------------------------------------------
// Encode the parts for a cmd.
//
function ldEncodeParts(v ref as JsonValue, appIdx as integer, thingIdx as integer, cmd ref as Cmd)

	local count as integer
	local parts as JsonValue
	local part as JsonValue
	local i as integer

	count = 0
	
	for i = 0 to cmd.parts.length
		
		part = ldEncodePart(appIdx, thingIdx, cmd, i, 0)

		if not jsonIsNull(part)
			
			jsonSetByAppend(parts, part)
			inc count
			
		endif
		
	next

	if count
		jsonSetByName(v, "pts", parts)
	endif

endfunction

//-----------------------------------------------------
// Encode a part for a cmd.
//
function ldEncodePart(appIdx as integer, thingIdx as integer, cmd ref as Cmd, partIdx as integer, selCmd as integer)

	local part as JsonValue
	local j as integer
	local varIdx as integer
	local partCmd as integer
	local varInfo as string
	local soundId as string
	local videoId as string
	local varTyp as string
	local tmp as JsonValue
		
	jsonSetNull(part)
		
	if cmd.parts[partIdx].typ <> PART_STR and cmd.parts[partIdx].typ <> PART_IMG

		jsonSetInt(tmp, cmd.parts[partIdx].typ)
		jsonSetByName(part, "tp", tmp)
		jsonSetInt(tmp, partIdx)
		jsonSetByName(part, "ix", tmp)
		
	endif

	if cmd.parts[partIdx].typ = PART_CMD

		partCmd = cdGetPartAsInt(cmd.parts[partIdx])
		tmp = ldEncodeCmd(appIdx, thingIdx, ma.cmds[partCmd])
		jsonSetByName(part, "cmd", tmp)

	elseif cmd.parts[partIdx].typ = PART_VAR_NAME

		varIdx = cdGetPartAsInt(cmd.parts[partIdx])

		if ma.vars[varIdx].thingIdx = -1

			if appIdx > -1
				
				//for j = 0 to app.vars.length
				for j = 0 to ma.apps[appIdx].vars.length

					//if app.vars[j] = varIdx
					if ma.apps[appIdx].vars[j] = varIdx

						// This is an app var.
						varInfo = str(j)
						varTyp = "p"
						exit
						
					endif
					
				next

			endif

		else

			if thingIdx > -1
				
				//for j = 0 to thing.vars.length
				for j = 0 to ma.things[thingIdx].vars.length

					//if thing.vars[j] = varIdx
					if ma.things[thingIdx].vars[j] = varIdx
						
						varInfo = str(j)
						varTyp = "s"
						exit
						
					endif
					
				next

			endif
			
		endif			

		// Insert the var position in the array of the app or thing.
		jsonSetString(tmp, varTyp)
		jsonSetByName(part, "sc", tmp)
		jsonSetString(tmp, varInfo)
		jsonSetByName(part, "in", tmp)

	elseif cmd.parts[partIdx].typ = PART_SOUND_NAME

		//soundIdx = cdGetPartAsInt(cmd.parts[partIdx])
		//jsonSetInt(tmp, soundIdx)
		soundId = cdGetPartAsString(cmd.parts[partIdx])
		jsonSetString(tmp, soundId)
		jsonSetByName(part, "in", tmp)
		
	elseif cmd.parts[partIdx].typ = PART_VIDEO_NAME

		//videoIdx = cdGetPartAsInt(cmd.parts[partIdx])
		//jsonSetInt(tmp, videoIdx)
		videoId = cdGetPartAsString(cmd.parts[partIdx])
		jsonSetString(tmp, videoId)
		jsonSetByName(part, "in", tmp)

	elseif selCmd or (cmd.parts[partIdx].typ <> PART_STR and cmd.parts[partIdx].typ <> PART_IMG)

		jsonSetString(tmp, cmd.parts[partIdx].info)
		jsonSetByName(part, "in", tmp)

	endif
	
endfunction part
	
//-----------------------------------------------------
// Save an image as a sprite in the library.
//
function ldSaveImage(img as integer)

	local file as string
	local path as string
	local pos as integer
	local newFile as string

	if img
		
		file = GetImageFilename(img)

		pos = FindStringReverse(file, "/")
		
		if pos > 0
			file = mid(file, pos + 1, -1)
		endif
		
		path = LD_BASE_DIR + LD_SPRITE_DIR + "/"
		newFile = ldGetUniqueFileName(path, file)		
		SaveImage(img, newFile)
		
	endif

endfunction

//-----------------------------------------------------
// Create a pretend libitem for dropping into the library.
//
function ldCreateImportLibItem(libItem ref as LibItem)

	local file as string
	local path as string
	local pos as integer
	local pos2 as integer
	local newFile as string
	local apps as integer[]

	//if img
		
		file = libItem.file

		// Remove the path now.
		pos = FindStringReverse(file, "/")

		if pos > 0
			
			libItem.folder = mid(file, 1, pos - 1)
			file = mid(file, pos + 1, -1)
			
		endif

		pos2 = FindStringReverse(file, ".")

		if pos2 > 0
			
			libItem.name = mid(file, 1, pos2 - 1)
			libItem.ext = mid(file, pos2, -1)
			
		else

			libItem.name = file
			libItem.ext = ""

		endif

		// TODO: Why is this here?
		//if left(libItem.name, 3) = "AGK"
		//	libItem.name = ""
		//endif
			
		libItem.visible = false
		libItem.selected = false
		libItem.img = 0
		libItem.sharedImg = false
		libItem.status = 0

		apps = maFindAppsByStatus(LD_STATUS_MASTER_LIB)
		libItem.appIdx = apps[0]

	//endif

endfunction

//-----------------------------------------------------
// Save an image as a sprite in the library.
//
function ldSaveAppIcon(appIdx as integer, img as integer)

	local file as string
	local folder as string 
	
	if img

		deleteimage(ma.apps[appIdx].img)
		ma.apps[appIdx].img = img

		folder = GetFolder()
		
		if SetFolder(ma.apps[appIdx].folder)

			SaveImage(ma.apps[appIdx].img, LD_ICON_FILE)
			setfolder("/" + folder)
			
		endif
		
	endif

endfunction

//-----------------------------------------------------
// Load settings.
//
function ldLoadSettings()

	local fh as integer
	local s as string
	local v as JsonValue
	local tmp as JsonValue
	local i as integer
	local folder as string 

	folder = GetFolder()
	s = ""
	
	if SetFolder(LD_BASE_DIR + LD_CONFIG_DIR)
		
		//colog("dir=" + getwritepath() + GetFolder())

		if GetFileExists(LD_SETTINGS_FILE)
			
			fh = OpenToRead(LD_SETTINGS_FILE)
	
			if fh
				
				while not FileEOF(fh)
					s = s + readline(fh)
				endwhile
				
				closefile(fh)
				
			endif
			
		endif

		setfolder("/" + folder)
			
	endif

	if s = ""

		ldSaveSettings()
		exitfunction
		
	endif

	v = jsonParse("set", s)

	ldDecodeSettings(v)

endfunction

//-----------------------------------------------------
// Save settings.
//
function ldSaveSettings()

	local v as JsonValue
	local tmp as JsonValue
	local fh as integer
	local folder as string
	local i as integer
	local j as integer
	local colStr as string
	
	jsonSetBool(tmp, ld.set.trueEdit)
	jsonSetByName(v, "trueEdit", tmp)
	jsonSetString(tmp, ld.set.prevLoadedAppId)
	jsonSetByName(v, "prevLoadedAppId", tmp)
	jsonSetBool(tmp, ld.set.autoLoadPrevApp)
	jsonSetByName(v, "autoLoadPrevApp", tmp)
	//jsonSetInt(tmp, ld.set.gridRows)
	//jsonSetByName(v, "gridRows", tmp)
	//jsonSetInt(tmp, ld.set.gridCols)
	//jsonSetByName(v, "gridCols", tmp)
	jsonSetInt(tmp, ld.set.gridWidth)
	jsonSetByName(v, "gridWidth", tmp)
	jsonSetInt(tmp, ld.set.gridHeight)
	jsonSetByName(v, "gridHeight", tmp)
	jsonSetBool(tmp, ld.set.snapToGrid)
	jsonSetByName(v, "snapToGrid", tmp)
	jsonSetBool(tmp, ld.set.showLayoutNames)
	jsonSetByName(v, "showLayoutNames", tmp)
	jsonSetInt(tmp, ld.set.thingIconSize)
	jsonSetByName(v, "thingIconSize", tmp)
	jsonSetInt(tmp, ld.set.projIconSize)
	jsonSetByName(v, "projIconSize", tmp)
	jsonSetBool(tmp, ld.set.tmpVarsAllowed)
	jsonSetByName(v, "tmpVarsAllowed", tmp)
	jsonSetInt(tmp, ld.set.runButPos)
	jsonSetByName(v, "runButPos", tmp)
	jsonSetInt(tmp, ld.set.quickNaming)
	jsonSetByName(v, "quickNaming", tmp)
	jsonSetInt(tmp, ld.set.designButPos)
	jsonSetByName(v, "designButPos", tmp)
	jsonSetInt(tmp, ld.set.autoRun)
	jsonSetByName(v, "autoRun", tmp)
	jsonSetInt(tmp, ld.set.titleOn)
	jsonSetByName(v, "titleOn", tmp)
	jsonSetInt(tmp, ld.set.libsOn)
	jsonSetByName(v, "libOn", tmp)
	jsonSetInt(tmp, ld.set.cmdSize)
	jsonSetByName(v, "cmdSize", tmp)
	jsonSetBool(tmp, ld.set.editSnapToGrid)
	jsonSetByName(v, "editSnapToGrid", tmp)
	//jsonSetInt(tmp, ld.set.editGRidRows)
	//jsonSetByName(v, "editGridRows", tmp)
	//jsonSetInt(tmp, ld.set.editGridCols)
	//jsonSetByName(v, "editGridCols", tmp)
	jsonSetString(tmp, ld.set.editCol)
	jsonSetByName(v, "editCol", tmp)
	jsonSetInt(tmp, ld.set.editLineSize)
	jsonSetByName(v, "editLineSize", tmp)
	jsonSetInt(tmp, ld.set.editTextSize)
	jsonSetByName(v, "editTextSize", tmp)
	jsonSetInt(tmp, ld.set.editZoomLevel)
	jsonSetByName(v, "editZoomLevel", tmp)
	jsonSetBool(tmp, ld.set.editErase)
	jsonSetByName(v, "editErase", tmp)
	jsonSetInt(tmp, ld.set.helpSize)
	jsonSetByName(v, "helpSize", tmp)
	jsonSetInt(tmp, ld.set.editorButPos)
	jsonSetByName(v, "editorButPos", tmp)

	jsonSetInt(tmp, ld.set.editTextFont)
	jsonSetByName(v, "editTextFont", tmp)
	jsonSetInt(tmp, ld.set.editLineStyle)
	jsonSetByName(v, "editLineStyle", tmp)
	jsonSetInt(tmp, ld.set.editDrawShape)
	jsonSetByName(v, "editDrawShape", tmp)
	jsonSetBool(tmp, ld.set.editShapeSameWH)
	jsonSetByName(v, "editShapeSameWH", tmp)
	jsonSetBool(tmp, ld.set.editShapeFilled)
	jsonSetByName(v, "editShapeFilled", tmp)
	jsonSetInt(tmp, ld.set.editPolySides)
	jsonSetByName(v, "editPolySides", tmp)
	jsonSetInt(tmp, ld.set.editSelShape)
	jsonSetByName(v, "editSelShape", tmp)
	jsonSetInt(tmp, ld.set.editGridWidth)
	jsonSetByName(v, "editGridWidth", tmp)
	jsonSetInt(tmp, ld.set.editGridHeight)
	jsonSetByName(v, "editGridHeight", tmp)
	jsonSetBool(tmp, ld.set.autoAccept)
	jsonSetByName(v, "autoAccept", tmp)
	jsonSetInt(tmp, ld.set.snapGridHoriz)
	jsonSetByName(v, "snapGridHoriz", tmp)
	jsonSetInt(tmp, ld.set.snapGridVert)
	jsonSetByName(v, "snapGridVert", tmp)
	jsonSetBool(tmp, ld.set.panOn)
	jsonSetByName(v, "panOn", tmp)
	colStr = coColorToHex(ld.set.deBgCol)
	jsonSetString(tmp, colStr)
	jsonSetByName(v, "deBgCol", tmp)
	jsonSetString(tmp, ld.set.agkCompiler)
	jsonSetByName(v, "agkCompiler", tmp)
		
	folder = GetFolder()
	
	if SetFolder(LD_BASE_DIR + LD_CONFIG_DIR)

		fh = OpenToWrite(LD_SETTINGS_FILE)
		writeline(fh, jsonToString(v))
		closefile(fh)

		setfolder("/" + folder)
		
	endif
	
endfunction

//-----------------------------------------------------
// Decode settings.
// v is the loaded JsonValue.
//
/*
	trueEdit as integer
	//insetCols as integer
	prevLoadedAppId as string // The previously loaded app.
	autoLoadPrevApp as integer // Auto load previous app.
	gridSize as integer
	snapToGrid as integer
	//opLeftCheck as integer // Whether operator cmds left or right top corner is used to check part drop point.
	tmpVarsAllowed as integer // Allow complex temp vars.
	showLayoutNames as integer // Show thing names in the designer by default.
	thingIconSize as integer // The size of things and images on commands, 1=1/4, 2=2/4, 3=3/4, 4=4/4
	projIconSize as integer // The size of the proj icon to save on a "Snap", 1, 2, 3, 4.
	runButPos as integer // The pos for run button on run screen, etc. TL, TR, BL, BR.
*/

function ldDecodeSettings(v ref as JsonValue)

	local tmp as JsonValue
	local colStr as string

	tmp = jsonGetByName(v, "trueEdit")
	ld.set.trueEdit = jsonGetBoolDef(tmp, ld.set.trueEdit)
	tmp = jsonGetByName(v, "prevLoadedAppId")
	ld.set.prevLoadedAppId = jsonGetStringDef(tmp, ld.set.prevLoadedAppId)
	tmp = jsonGetByName(v, "autoLoadPrevApp")
	ld.set.autoLoadPrevApp = jsonGetBoolDef(tmp, ld.set.autoLoadPrevApp)
	//tmp = jsonGetByName(v, "gridRows")
	//ld.set.gridRows = jsonGetIntDef(tmp, ld.set.gridRows)
	//tmp = jsonGetByName(v, "gridCols")
	//ld.set.gridCols = jsonGetIntDef(tmp, ld.set.gridCols)
	tmp = jsonGetByName(v, "gridWidth")
	ld.set.gridWidth = jsonGetIntDef(tmp, ld.set.gridWidth)
	tmp = jsonGetByName(v, "gridHeight")
	ld.set.gridHeight = jsonGetIntDef(tmp, ld.set.gridHeight)
	tmp = jsonGetByName(v, "snapToGrid")
	ld.set.snapToGrid = jsonGetBoolDef(tmp, ld.set.snapToGrid)
	tmp = jsonGetByName(v, "tmpVarsAllowed")
	ld.set.tmpVarsAllowed = jsonGetIntDef(tmp, ld.set.tmpVarsAllowed)
	tmp = jsonGetByName(v, "showLayoutNames")
	ld.set.showLayoutNames = jsonGetBoolDef(tmp, ld.set.showLayoutNames)
	tmp = jsonGetByName(v, "thingIconSize")
	ld.set.thingIconSize = jsonGetIntDef(tmp, ld.set.thingIconSize)
	tmp = jsonGetByName(v, "projIconSize")
	ld.set.projIconSize = jsonGetIntDef(tmp, ld.set.projIconSize)
	tmp = jsonGetByName(v, "runButPos")
	ld.set.runButPos = jsonGetIntDef(tmp, ld.set.runButPos)
	tmp = jsonGetByName(v, "quickNaming")
	ld.set.quickNaming = jsonGetIntDef(tmp, ld.set.quickNaming)
	tmp = jsonGetByName(v, "designButPos")
	ld.set.designButPos = jsonGetIntDef(tmp, ld.set.designButPos)
	tmp = jsonGetByName(v, "autoRun")
	ld.set.autoRun = jsonGetIntDef(tmp, ld.set.autoRun)
	tmp = jsonGetByName(v, "titleOn")
	ld.set.titleOn = jsonGetIntDef(tmp, ld.set.titleOn)
	tmp = jsonGetByName(v, "libOn")
	ld.set.libsOn = jsonGetIntDef(tmp, ld.set.libsOn)
	tmp = jsonGetByName(v, "cmdSize")
	ld.set.cmdSize = jsonGetIntDef(tmp, ld.set.cmdSize)
	tmp = jsonGetByName(v, "editSnapToGrid")
	ld.set.editSnapToGrid = jsonGetBoolDef(tmp, ld.set.editSnapToGrid)
	//tmp = jsonGetByName(v, "editGridRows")
	//ld.set.editGridRows = jsonGetIntDef(tmp, ld.set.editGridRows)
	//tmp = jsonGetByName(v, "editGridCols")
	//ld.set.editGridCols = jsonGetIntDef(tmp, ld.set.editGridCols)
	tmp = jsonGetByName(v, "editCol")
	ld.set.editCol = jsonGetStringDef(tmp, ld.set.editCol)
	tmp = jsonGetByName(v, "editLineSize")
	ld.set.editLineSize = jsonGetIntDef(tmp, ld.set.editLineSize)
	tmp = jsonGetByName(v, "editTextSize")
	ld.set.editTextSize = jsonGetIntDef(tmp, ld.set.editTextSize)
	tmp = jsonGetByName(v, "editZoomLevel")
	ld.set.editZoomLevel = jsonGetIntDef(tmp, ld.set.editZoomLevel)
	//tmp = jsonGetByName(v, "editErase")
	//ld.set.editErase = jsonGetBoolDef(tmp, ld.set.editErase)
	tmp = jsonGetByName(v, "helpSize")
	ld.set.helpSize = jsonGetIntDef(tmp, ld.set.helpSize)
	tmp = jsonGetByName(v, "editorButPos")
	ld.set.editorButPos = jsonGetIntDef(tmp, ld.set.editorButPos)

	tmp = jsonGetByName(v, "editTextFont")
	ld.set.editTextFont = jsonGetIntDef(tmp, ld.set.editTextFont)
	tmp = jsonGetByName(v, "editLineStyle")
	ld.set.editLineStyle = jsonGetIntDef(tmp, ld.set.editLineStyle)
	tmp = jsonGetByName(v, "editDrawShape")
	ld.set.editDrawShape = jsonGetIntDef(tmp, ld.set.editDrawShape)
	tmp = jsonGetByName(v, "editShapeSameWH")
	ld.set.editShapeSameWH = jsonGetBoolDef(tmp, ld.set.editShapeSameWH)
	tmp = jsonGetByName(v, "editShapeFilled")
	ld.set.editShapeFilled = jsonGetBoolDef(tmp, ld.set.editShapeFilled)
	tmp = jsonGetByName(v, "editPolySides")
	ld.set.editPolySides = jsonGetIntDef(tmp, ld.set.editPolySides)
	tmp = jsonGetByName(v, "editSelShape")
	ld.set.editSelShape = jsonGetIntDef(tmp, ld.set.editSelShape)
	tmp = jsonGetByName(v, "editGridWidth")
	ld.set.editGridWidth = jsonGetIntDef(tmp, ld.set.editGridWidth)
	tmp = jsonGetByName(v, "editGridHeight")
	ld.set.editGridHeight = jsonGetIntDef(tmp, ld.set.editGridHeight)
	tmp = jsonGetByName(v, "autoAccept")
	ld.set.autoAccept = jsonGetBoolDef(tmp, ld.set.autoAccept)
	tmp = jsonGetByName(v, "snapGridHoriz")
	ld.set.snapGridHoriz = jsonGetIntDef(tmp, ld.set.snapGridHoriz)
	tmp = jsonGetByName(v, "snapGridVert")
	ld.set.snapGridVert = jsonGetIntDef(tmp, ld.set.snapGridVert)
	tmp = jsonGetByName(v, "panOn")
	ld.set.panOn = jsonGetBoolDef(tmp, ld.set.panOn)
	tmp = jsonGetByName(v, "deBgCol")
	colStr = coColorToHex(ld.set.deBgCol)
	colStr = jsonGetStringDef(tmp, colStr)
	ld.set.deBgCol = coMakeColor(colStr)
	tmp = jsonGetByName(v, "agkCompiler")
	ld.set.agkCompiler = jsonGetStringDef(tmp, ld.set.agkCompiler)

	// Validate.
	
	if ld.set.runButPos <> DIR_NE and ld.set.runButPos <> DIR_NW and ld.set.runButPos <> DIR_SE and ld.set.runButPos <> DIR_SW
		ld.set.runButPos = DIR_NE
	endif

	if ld.set.designButPos <> DIR_NE and ld.set.designButPos <> DIR_NW and ld.set.designButPos <> DIR_SE and ld.set.designButPos <> DIR_SW
		ld.set.designButPos = DIR_NE
	endif

	if ld.set.editorButPos <> DIR_NE and ld.set.editorButPos <> DIR_NW and ld.set.editorButPos <> DIR_SE and ld.set.editorButPos <> DIR_SW
		ld.set.editorButPos = DIR_NE
	endif

	ld.set.gridCols = floor(co.w / ld.set.gridWidth)
	ld.set.gridRows = floor(co.h / ld.set.gridHeight)

	if ld.set.cmdSize < 0 or ld.set.cmdSize >= LD_CMD_SIZE_MAX
		ld.set.cmdSize = 0
	endif

	if ld.set.helpSize < 0 or ld.set.helpSize >= LD_HELP_SIZE_MAX
		ld.set.helpSize = 0
	endif
	
endfunction

//-----------------------------------------------------
// Load config for internal, e.g. id generators.
//
function ldLoadConfig()

	local fh as integer
	local s as string
	local v as JsonValue
	local tmp as JsonValue
	local i as integer
	local folder as string 

	folder = GetFolder()
	s = ""
	
	if SetFolder(LD_BASE_DIR + LD_CONFIG_DIR)

		if GetFileExists(LD_CONFIG_FILE)
			
			fh = OpenToRead(LD_CONFIG_FILE)
	
			if fh
				
				while not FileEOF(fh)
					s = s + readline(fh)
				endwhile
				
				closefile(fh)
				
			endif
			
		endif

		setfolder("/" + folder)
		
	endif

	if s = ""

		ldSaveConfig()
		exitfunction
		
	endif

	v = jsonParse("cfg", s)

	ldDecodeConfig(v)

endfunction

//-----------------------------------------------------
// Save settings.
//
function ldSaveConfig()

	local v as JsonValue
	local tmp as JsonValue
	local fh as integer
	local folder as string 

	jsonSetInt(tmp, ld.cfg.nextAppId)
	jsonSetByName(v, "nextAppId", tmp)
	jsonSetInt(tmp, ld.cfg.nextThingId)
	jsonSetByName(v, "nextThingId", tmp)
	jsonSetInt(tmp, ld.cfg.nextImageId)
	jsonSetByName(v, "nextImageId", tmp)
	jsonSetInt(tmp, ld.cfg.nextCmdId)
	jsonSetByName(v, "nextCmdId", tmp)
	jsonSetInt(tmp, ld.cfg.nextTextId)
	jsonSetByName(v, "nextTextId", tmp)
	jsonSetInt(tmp, ld.cfg.nextSoundId)
	jsonSetByName(v, "nextSoundId", tmp)
	jsonSetInt(tmp, ld.cfg.nextVideoId)
	jsonSetByName(v, "nextVideoId", tmp)
	jsonSetInt(tmp, ld.cfg.nextExId)
	jsonSetByName(v, "nextExId", tmp)

	folder = GetFolder()
	
	if SetFolder(LD_BASE_DIR + LD_CONFIG_DIR)

		fh = OpenToWrite(LD_CONFIG_FILE)
		writeline(fh, jsonToString(v))
		closefile(fh)

		setfolder("/" + folder)
		
	endif
	
endfunction

//-----------------------------------------------------
// Decode settings.
// v is the loaded JsonValue.
//
function ldDecodeConfig(v ref as JsonValue)

	local tmp as JsonValue

	tmp = jsonGetByName(v, "nextAppId")
	ld.cfg.nextAppId = jsonGetInt(tmp)
	tmp = jsonGetByName(v, "nextThingId")
	ld.cfg.nextThingId = jsonGetInt(tmp)
	tmp = jsonGetByName(v, "nextImageId")
	ld.cfg.nextImageId = jsonGetInt(tmp)
	tmp = jsonGetByName(v, "nextCmdId")
	ld.cfg.nextCmdId = jsonGetInt(tmp)
	tmp = jsonGetByName(v, "nextTextId")
	ld.cfg.nextTextId = jsonGetInt(tmp)
	tmp = jsonGetByName(v, "nextSoundId")
	ld.cfg.nextSoundId = jsonGetInt(tmp)
	tmp = jsonGetByName(v, "nextVideoId")
	ld.cfg.nextVideoId = jsonGetInt(tmp)
	tmp = jsonGetByName(v, "nextExId")
	ld.cfg.nextExId = jsonGetInt(tmp)

//colog("nextAppId=" + str(ma.cfg.nextAppId))
//colog("nextThingId=" + str(ma.cfg.nextThingId))
//colog("nextCmdId=" + str(ma.cfg.nextCmdId))

endfunction

//-----------------------------------------------------
// Fix the app prefix.
//
function ldFixNextAppId(appId as string)
	
	local nbr as integer
	
	if left(appId, len(LD_EXAMPLE_PREFIX)) = LD_EXAMPLE_PREFIX
		
		nbr = val(mid(appId, 1 + len(LD_EXAMPLE_PREFIX), -1))
		
		if ld.cfg.nextExId <= nbr
			
			ld.cfg.nextExId = nbr + 1
			ldSaveConfig()
			
		endif
		
	endif

endfunction

//-----------------------------------------------------
// Get the next app id.
//
function ldGetNextAppId()

	local ret as string 
	
	ret = LD_PROJECT_PREFIX + str(ld.cfg.nextAppId)
	inc ld.cfg.nextAppId
	ldSaveConfig()

endfunction ret

//-----------------------------------------------------
// Get the next ex id.
//
function ldGetNextExId()

	local ret as string 

	ret = LD_EXAMPLE_PREFIX + str(ld.cfg.nextExId)
	inc ld.cfg.nextExId
	ldSaveConfig()

endfunction ret

//-----------------------------------------------------
// Get the next thing id.
//
function ldGetNextThingId()

	local ret as string 

	ret = LD_SPRITE_PREFIX + str(ld.cfg.nextThingId)
	inc ld.cfg.nextThingId
	ldSaveConfig()

endfunction ret

//-----------------------------------------------------
// Get the next text id.
//
function ldGetNextTextId()

	local ret as string 

	ret = LD_TEXT_PREFIX + str(ld.cfg.nextTextId)
	inc ld.cfg.nextTextId
	ldSaveConfig()

endfunction ret

//-----------------------------------------------------
// Get the next sound id.
//
function ldGetNextSoundId()

	local ret as string 

	ret = LD_SOUND_PREFIX + str(ld.cfg.nextSoundId)
	inc ld.cfg.nextSoundId
	ldSaveConfig()

endfunction ret

//-----------------------------------------------------
// Get the next video id.
//
function ldGetNextVideoId()

	local ret as string 

	ret = LD_VIDEO_PREFIX + str(ld.cfg.nextVideoId)
	inc ld.cfg.nextVideoId
	ldSaveConfig()

endfunction ret

//-----------------------------------------------------
// Get the next image id.
//
function ldGetNextImageId()

	local ret as string 

	ret = LD_IMAGE_PREFIX + str(ld.cfg.nextImageId)
	inc ld.cfg.nextImageId
	ldSaveConfig()

endfunction ret

//-----------------------------------------------------
// Get the next cmd id.
//
function ldGetNextCmdId()

	local ret as string 

	ret = LD_COMMAND_PREFIX + str(ld.cfg.nextCmdId)
	inc ld.cfg.nextCmdId
	ldSaveConfig()

endfunction ret

//-----------------------------------------------------
// Delete a cached image if we can, otherwise delete a loaded image.
// Returns the img if it was cached and remove, otherwise 0.
//
function ldDeleteImageCached(img as integer, cache ref as CachedImage[])

	local ret as integer
	local i as integer

	ret = 0
	
	for i = 0 to cache.length

		if cache[i].img = img

			ret = img
			cache.remove(i)
			exit

		endif
		
	next

	if not ret
		deleteimage(img)
	endif
	
endfunction ret

//-----------------------------------------------------
// Check if the loaded image is cached in cd.partImgs
// Otherwise load and add to cache.
//
function ldLoadImageCached(file as string, cache ref as CachedImage[])

	local i as integer
	local img as integer
	local cachedImage as CachedImage

	img = -1
	
	for i = 0 to cache.length

		if cache[i].file = file
			
			img = cache[i].img
			exit

		endif
		
	next

	if img = -1

		cachedImage.file = file
		cachedImage.img = loadimage(file)
		img = cachedImage.img
		cache.insert(cachedImage)

	endif
	
endfunction img

//-----------------------------------------------------
//
function ldUpdate()

endfunction

//
// END.
//
