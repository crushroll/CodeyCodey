#option_explicit

//-----------------------------------------------------
//
#constant RU_VIDEO_PANEL_HEIGHT 100
#constant RU_VIDEO_IMAGE_ID 100

#constant RU_NONE 0
#constant RU_RUN 1
#constant RU_RESUME 2

#constant RU_PEN_SIZE_MAX 100
#constant RU_VOLUME_MAX 100.0
#constant RU_RUN_TIME 500 // Millis.

global ru as Runner

//-----------------------------------------------------
//
type Runner

	delta as float
	imgs as integer[]
	sprs as integer[]
	runBut as Button
	backBut as Button
	moreBut as Button
	moreBar as Toolbar
	butId as integer
	backImg as integer
	runButImg as integer
	stopButImg as integer
	resumeButImg as integer
	pauseButImg as integer
	startRecordButImg as integer
	endRecordButImg as integer
	recordFile as string
	executing as integer
	appIdx as integer // The app to run.
	rt as Runtime // Build a runtime to execute.
	pressed as integer
	w as float
	h as float
	
endtype

//
// The actual run engine.
//
type Runtime

	debug as integer
	debugIndent as integer
	logToFile as integer
	threadId as integer // The next thread id.
	volume as integer // Default volume.
	soundLoops as integer // Default sound loops.
	channels as Channel[] // Playing sounds.
	freeChannels as integer[]
	lastChannel as integer // The last sound played.
	videoPanel as VideoPanel // The one and only loaded video.
	videoIdx as integer // The loaded video.
	videoVolume as integer // Default video volume.
	vars as integer[] // Vars specific to this run, e.g. volume.
	threads as Thread[] // Parallel executions for a thing.
	frontDepth as integer // The top depth.
	backDepth as integer // The back depth.
	timer as integer // The base value for the timer.
	input as string // The input value from Get input.
	displayBgColor as integer
	displayBorderColor as integer
	displayTextColor as integer
	displayFont as integer
	displayFontSize as integer
	screenBgColor as integer
	vx as float // x position of variables.
	vy as float
	atTips as Tip[] // Print at tips.
	//depths as Depth[] // The depths of things for runtime.
	vardepths as Depth[] // The depths of var views.
	ignoreCase as integer // for Find operations.
	thingPressed as integer // Thing was pressed.
	varPressed as integer // Var was pressed.
	ptrPressed as integer
	ptrDown as integer
	ptrReleased as integer
	thingCount as integer // Optimisation to not have to go through complete list.
	depthDiv as integer // Division of depth by thingCount.
	sortThreads as integer
	
endtype

type DrawSpr 
	
	spr as integer
	x as float
	y as float
	sx as float
	sy as float
	ang as float
	col as integer
	vis as integer // Was it visible at the time.
	
endtype

type Thread

	depth as integer // The thread list depth, used to sort the thread execution order.
	id as integer // unique id for every thread.
	caller as integer // The id of the calling thread for an RECEIVE_EVENT thread.
	parent as integer // The parent thing thread for this cloned thread.
	thingIdx as integer // Index into ma.things.
	event as integer // The event code.
	thingEventCmdIdx as integer // The index into the things cmd list of this event.
	tmpVars as integer[] // Variable specfic to this thread, i.e. runtime.
	idx as integer // The index into the thing.cmds array.
	prvIdx as integer // The idx to the prv cmd, so we can determine if loops need to be reset.
	stack as integer[] // Stack of indexes into stmts, for loops, ifs, etc.
	active as integer // The thread can run.
	reset as integer // The thread needs to reset before executing.
	waitTime as integer // Waiting on a wait.
	waitUntil as integer // Waiting for a boolean expressed.
	waitChannels as integer[] // Play sound done, need to complete.
	waitVideo as integer // Wait for a video to stop playing.
	waitInput as integer // Currently accepting input.
	waitInputChange as integer // After an edit changed event, this is set to allow for another loop.
	waitEvents as integer[] // Wait for an event to complete.
	waitSay as float
	blockTimer as integer // Thread can't run, e.g. it may have run, but now can no longer.
	eventVarIdx as integer // The varIdx name that this thread is in wantEvent for.
	//imgIdx as integer // The thing frame.
	partVars as PartVar[]
	deleted as integer
	turbo as integer // If true, then no yielding until end of code block, or end update.
	argList as integer // A list var that contains a copy of the passed list.
		
endtype

type PartVar

	partIdx as integer
	varIdx as integer
	
endtype

type Pen

	active as integer
	pts as PenPoint[]
	col as integer
	size as float
	style as integer // Round or Square ends.
	spr as integer // Sprite for pen.
	
endtype

type PenPoint

	x0 as float
	y0 as float
	x1 as float
	y1 as float
	col as integer
	size as integer
	style as integer
	depth as integer
	
endtype

type Event

	varIdx as integer // The event id to be send, i.e. a var.
	caller as integer // The thread id of the caller.
	
endtype

type Channel

	id as integer
	deleted as integer	
	playId as integer // The id from PlaySound.
	volume as integer
	soundIdx as integer // The original sound.

endtype

type Edge

	threadIdx as integer
	edges as string // The edges to check, i.e. LRTB
	
endtype

//-----------------------------------------------------
// 
function ruInit()

	local but as Button
	local thing as Thing
	local x as float

	ru.w = co.w
	ru.h = co.h
	
	ru.runButImg = loadimage("gfx/RunBlackIcon.png")
	ru.stopButImg = loadimage("gfx/StopBlackIcon.png")
	ru.resumeButImg = loadimage("gfx/RunIcon.png")
	ru.pauseButImg = loadimage("gfx/PauseIcon.png")
	ru.startRecordButImg = loadimage("gfx/RecordIcon.png")
	ru.endRecordButImg = loadimage("gfx/StopIcon.png")
	ru.backImg = loadimage("gfx/BackIcon.png")
		
	ru.runBut = guiCreateButton("run", BUT_BG_NORMAL, "", co.runCol)
	ru.runBut.id = BUT_RUNNER_RUN
	guiSetButtonDepth(ru.runBut, FRONT_DEPTH)
	
	ru.backBut = guiCreateButton("back", BUT_BG_NORMAL, "gfx/BackBlackIcon.png", co.detailsCol)
	ru.backBut.id = BUT_RUNNER_BACK
	cosettextcolor(ru.backBut.text, co.black)
	guiSetButtonDepth(ru.backBut, FRONT_DEPTH)

	ru.moreBut = guiCreateButton("more", BUT_BG_NORMAL, "gfx/MoreBlackIcon.png", co.moreCol)
	ru.moreBut.id = BUT_RUNNER_MORE
	cosettextcolor(ru.moreBut.text, co.black)
	guiSetButtonDepth(ru.moreBut, FRONT_DEPTH)

	ru.moreBar = guiCreateToolbar()

	but = guiCreateButton("pause", BUT_BG_NORMAL, "gfx/PauseIcon.png", co.editCol)
	but.id = BUT_RUNNER_PAUSE
	but.help = "Pause running. After pausing, press 'resume' to continue running."
	ru.moreBar.buts.insert(but)

	but = guiCreateButton("reset", BUT_BG_NORMAL, "gfx/UndoIcon.png", co.undoCol)
	but.id = BUT_RUNNER_RESET
	but.help = "Reset back to start position."
	ru.moreBar.buts.insert(but)

	but = guiCreateButton("snap icon", BUT_BG_NORMAL, "gfx/PhotoIcon.png", co.special1Col)
	but.id = BUT_RUNNER_SNAP
	but.help = "Snapshot the screen and save it as the project icon."
	ru.moreBar.buts.insert(but)

	but = guiCreateButton("auto run", BUT_BG_NORMAL, "gfx/RunIcon.png", co.special2Col)
	but.id = BUT_RUNNER_AUTO_RUN
	but.help = "Automatically run when the run button is pressed on the layout or coder views. Otherwise, just switch to the runtime view."
	ru.moreBar.buts.insert(but)

	but = guiCreateButton("menu pos", BUT_BG_NORMAL, "", co.special3Col)
	but.id = BUT_RUNNER_MENU_POS
	but.help = "Change the position of the button menu."
	guiSetButtonIcon(but, ru.backImg)
	ru.moreBar.buts.insert(but)

	//but = guiCreateButton("record", BUT_BG_NORMAL, "gfx/RecordIcon.png", co.brown[5])
	//but.id = BUT_RUNNER_START_RECORD
	//but.help = "Record the project screen as it runs, and save as a video. Note: This is limited to 1 minute of recording time."
	//ru.moreBar.buts.insert(but)

	guiHideBar(ru.moreBar)

	//ruSetButPos()
	ruSetSettingsRunPosButton()
	ruSetSettingsAutoRunButton()
	
	// Build the video panel.

	ru.rt.videoPanel.panel = guiCreateBox("video panel", 1, 1) // Adjust when shown.
	coSetSpriteColor(ru.rt.videoPanel.panel, co.grey[1])
	SetSpriteDepth(ru.rt.videoPanel.panel, GUI_TOP_DEPTH)
	ru.rt.videoPanel.playImg = loadimage("gfx/VidPlayIcon.png")
	ru.rt.videoPanel.pauseImg = loadimage("gfx/VidPauseIcon.png")
	ru.rt.videoPanel.playBut = createsprite(ru.rt.videoPanel.playImg)
	SetSpriteDepth(ru.rt.videoPanel.playBut, GUI_TOP_DEPTH - 2)
	ru.rt.videoPanel.rewBut = loadsprite("gfx/VidRewIcon.png")
	SetSpriteDepth(ru.rt.videoPanel.rewBut, GUI_TOP_DEPTH - 2)
	ru.rt.videoPanel.fwdBut = loadsprite("gfx/VidFwdIcon.png")
	SetSpriteDepth(ru.rt.videoPanel.fwdBut, GUI_TOP_DEPTH - 2)
	ru.rt.videoPanel.startBut = loadsprite("gfx/VidStartIcon.png")
	SetSpriteDepth(ru.rt.videoPanel.startBut, GUI_TOP_DEPTH - 2)
	ru.rt.videoPanel.endBut = loadsprite("gfx/VidEndIcon.png")
	SetSpriteDepth(ru.rt.videoPanel.endBut, GUI_TOP_DEPTH - 2)
	ru.rt.videoPanel.timeLine = guiCreateBox("video timeline", 1, 1) // Adjust when shown.
	coSetSpriteColor(ru.rt.videoPanel.timeLine, co.black)
	SetSpriteDepth(ru.rt.videoPanel.timeLine, GUI_TOP_DEPTH - 1)
	//ru.rt.videoPanel.timeBut = loadsprite("gfx/VidTimeIcon.png")
	ru.rt.videoPanel.timeBut = guiCreateBox("video timeBut", 8, co.bs / 4) // Adjust when shown.
	coSetSpriteColor(ru.rt.videoPanel.timeBut, co.black)
	SetSpriteDepth(ru.rt.videoPanel.timeBut, GUI_TOP_DEPTH - 2)
	ru.rt.videoPanel.startTime = guiCreateText2("", 30)
	coSetTextColor(ru.rt.videoPanel.startTime, co.black)
	SetTextDepth(ru.rt.videoPanel.startTime, GUI_TOP_DEPTH - 2)
	SetTextAlignment(ru.rt.videoPanel.starttime, 0)
	ru.rt.videoPanel.endTime = guiCreateText2("", 30)
	coSetTextColor(ru.rt.videoPanel.endTime, co.black)
	SetTextDepth(ru.rt.videoPanel.endTime, GUI_TOP_DEPTH - 2)
	SetTextAlignment(ru.rt.videoPanel.endtime, 2)

	ru.rt.videoIdx = -1
	ru.rt.videoPanel.vis = false
	ruHideVideoPanel()
	
	ru.butId = -1
	ru.executing = RU_NONE
	ru.appIdx = -1
	ru.recordFile = ""
	
	ruHide()
	
endfunction

//-----------------------------------------------------
//
function ruSetButPos()

	local x as float
	local dx as float
	local y as float
	local gap as float

	gap = co.bs / 4

	if ld.set.runButPos && DIR_N
		y = gap + GetSpriteHeight(ru.runBut.bg) / 2
	else
		y = ru.h - gap - GetSpriteHeight(ru.runBut.bg) / 2
	endif

	if ld.set.runButPos && DIR_W
		
		x = gap + GetSpriteWidth(ru.runBut.bg) / 2
		dx = 1
		
	else
		
		x = ru.w - gap - GetSpriteWidth(ru.runBut.bg) / 2
		dx = -1
		
	endif
	
	guiSetButtonPos(ru.runBut, x, y)

	x = x + (GetSpriteWidth(ru.runBut.bg) * dx)
	guiSetButtonPos(ru.backBut, x, y)

	x = x + (GetSpriteWidth(ru.backBut.bg) * dx)
	guiSetButtonPos(ru.moreBut, x, y)

endfunction

//-----------------------------------------------------
//
function ruSetApp(appIdx as integer)

	ru.appIdx = appIdx
	
endfunction

//-----------------------------------------------------
//
function ruShow()

	// if ru.rt.debug then ruDebug(1, "ruShow start")

	local i as integer
	local s as string
	local toks as string[]

	SetSyncRate(60, 0)
	
	setPrintColor(0, 0, 0)
	SetPrintSize(48)
	
	coSetClearColor(co.white)
	coSetBorderColor(co.grey[4])

	ru.w = co.w
	ru.h = co.h

	if WIN_MODE
		
		s = cdGetObjVarVals(OBJ_VAR_SCREEN, str(ma.apps[ru.appIdx].screen), false)		
		coSplitString(toks, s, " ")

		ru.w = valfloat(toks[1]) // co.w
		ru.h = valfloat(toks[3]) // co.h
		
	else 
		
		if ma.apps[ru.appIdx].status && LD_STATUS_MOB_LAND
			
			ru.w = co.mw
			ru.h = co.mh
	
		elseif ma.apps[ru.appIdx].status && LD_STATUS_MOB_PORT
			
			ru.w = co.mh
			ru.h = co.mw
			
		endif
		
	endif
		
	SetVirtualResolution(ru.w, ru.h)
	
	guiSetButtonAlpha(ru.runBut, 127)
	guiSetButtonVisible(ru.runBut, true)

	guiSetButtonAlpha(ru.backBut, 127)
	guiSetButtonVisible(ru.backBut, true)

	guiSetButtonAlpha(ru.moreBut, 127)
	guiSetButtonVisible(ru.moreBut, true)

	ru.pressed = false
	
	ruSetButPos()

	// if ru.rt.debug then ruDebug(1, "ruShow calling ruStop")
	
	ruStop()

	if ld.set.autoRun
		// if ru.rt.debug then ruDebug(1, "ruShow autorun is set, calling ruRun")
		ruRun()
	else
		// if ru.rt.debug then ruDebug(1, "ruShow autorun not set, calling ruReset")
		ruReset()
	endif

	// if ru.rt.debug then ruDebug(1, "ruShow end")
	
	//SetPhysicsDebugOn()
	
endfunction

//-----------------------------------------------------
//
function ruHide()

	local i as integer
	
	guiSetButtonVisible(ru.runBut, false)
	guiSetButtonVisible(ru.backBut, false)
	guiSetButtonVisible(ru.moreBut, false)
	
	ruCleanRuntime()

	//coLogClear()
	
endfunction

//-----------------------------------------------------
// Reset.
//
function ruReset()

	// if ru.rt.debug then ruDebug(1, "ruReset start")

	ru.rt.debug = 0
	ru.rt.debugIndent = 0

	cologclear()

	if ru.rt.debug
		if not ru.rt.logToFile	
			ru.rt.logToFile = OpenToWrite("run_" + GetCurrentDate() + "_" + GetCurrentTime() + ".log")
		endif
	else
		ru.rt.logToFile = 0
	endif

	// if ru.rt.debug then ruDebug(1, "ruReset call clean and init runtime")

	ruCleanRuntime()
	sync()
	ruInitRuntime()

	// if ru.rt.debug then ruDebug(1, "ruReset end")
	
endfunction

//-----------------------------------------------------
// Reset a variable to its starting value.
//
function ruResetVar(var as integer)

	local i as integer

	ma.vars[var].runValue = ma.vars[var].value
	ma.vars[var].runList = ma.vars[var].list

	// Reset visual.
	maDeleteVarView(ma.vars[var].rv)
	ma.vars[var].rv = ma.vars[var].v
	
	// Use the rv.vis flag instead of var.
	ma.vars[var].rv.vis = ma.vars[var].vis
	
	if ma.vars[var].typ = VAR_TYPE_LIST

		for i = 0 to ma.vars[var].runList.length
			ma.vars[var].runList[i].value = ma.vars[var].list[i].value
		next
		
	endif

endfunction

//-----------------------------------------------------
// Clear a variable value.
//
function ruClearVar(var as integer)

	local i as integer
		
	ma.vars[var].runValue = ""
	ma.vars[var].runList.length = -1 // No need to clear cmds, as there won't be any in runtime.

endfunction

//-----------------------------------------------------
// Run.
//
function ruRun()

	// if ru.rt.debug then ruDebug(1, "ruRun start")

	local idx as integer
	local delta as float
	
	ruReset()

	guiSetButtonIcon(ru.runBut, ru.stopButImg)
	guiSetButtonText(ru.runBut, "stop")
	cosettextcolor(ru.runBut.text, co.black)
	coSetSpriteColor(ru.runBut.bg, co.red[5])
	guiSetButtonAlpha(ru.moreBut, 127)
	guiSetButtonAlpha(ru.backBut, 127)
	guiSetButtonAlpha(ru.runBut, 127)
	ru.runBut.id = BUT_RUNNER_STOP

	guiSetButtonDepth(ru.runBut, FRONT_DEPTH - 10)

	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_PAUSE)
	
	if idx > -1		
		guiSetButtonActive(ru.moreBar.buts[idx], true)		
	endif

	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_SNAP)
	
	if idx > -1		
		guiSetButtonActive(ru.moreBar.buts[idx], true)
	endif

	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_START_RECORD)
	if idx > -1
		guiSetButtonActive(ru.moreBar.buts[idx], true)		
	endif
	
	//sync()
	//ruInitRuntime()

	ru.executing = RU_RUN
	
	// Run the start event.
	ruActivateEvent(-1, CODE_EVENT_RUN)

	delta = GetFrameTime() * 60
	ruUpdateAllObjects(delta)

	// if ru.rt.debug then ruDebug(1, "ruRun end")
	
endfunction

//-----------------------------------------------------
// Show the video control, and play appropriately.
//
function ruShowVideoPanel()

	local y as float
	local gap as float
	
	if ru.rt.videoIdx = -1 or not ru.rt.videoPanel.vis

		ruHideVideoPanel()
		exitfunction
		
	endif

	if GetVideoPlaying()
		SetSpriteImage(ru.rt.videoPanel.playBut, ru.rt.videoPanel.pauseImg)
	else
		SetSpriteImage(ru.rt.videoPanel.playBut, ru.rt.videoPanel.playImg)
	endif
	
	SetSpriteScale(ru.rt.videoPanel.panel, ma.videos[ru.rt.videoIdx].w, RU_VIDEO_PANEL_HEIGHT)

	y = ma.videos[ru.rt.videoIdx].y + ma.videos[ru.rt.videoIdx].h + RU_VIDEO_PANEL_HEIGHT / 2
	gap = RU_VIDEO_PANEL_HEIGHT / 4
	
	SetSpritePosition(ru.rt.videoPanel.panel, ma.videos[ru.rt.videoIdx].x, ma.videos[ru.rt.videoIdx].y + ma.videos[ru.rt.videoIdx].h)
	SetSpritePositionByOffset(ru.rt.videoPanel.playBut, ma.videos[ru.rt.videoIdx].x + ma.videos[ru.rt.videoIdx].w / 2, y - gap)
	SetSpritePositionByOffset(ru.rt.videoPanel.rewBut, ma.videos[ru.rt.videoIdx].x + (GetSpriteXByOffset(ru.rt.videoPanel.playBut) - ma.videos[ru.rt.videoIdx].x) / 2, y - gap)
	SetSpritePositionByOffset(ru.rt.videoPanel.fwdBut, GetSpriteXByOffset(ru.rt.videoPanel.playBut) + (GetSpriteXByOffset(ru.rt.videoPanel.playBut) - ma.videos[ru.rt.videoIdx].x) / 2, y - gap)
	SetSpritePositionByOffset(ru.rt.videoPanel.startBut, ma.videos[ru.rt.videoIdx].x + GetSpriteWidth(ru.rt.videoPanel.startBut) / 2, y - gap)
	SetSpritePositionByOffset(ru.rt.videoPanel.endBut, ma.videos[ru.rt.videoIdx].x + ma.videos[ru.rt.videoIdx].w - GetSpriteWidth(ru.rt.videoPanel.startBut) / 2, y - gap)

	ruShowVideoTimes()

	SetSpriteVisible(ru.rt.videoPanel.panel, true)
	SetSpriteVisible(ru.rt.videoPanel.playBut, true)
	SetSpriteVisible(ru.rt.videoPanel.rewBut, true)
	SetSpriteVisible(ru.rt.videoPanel.fwdBut, true)
	SetSpriteVisible(ru.rt.videoPanel.startBut, true)
	SetSpriteVisible(ru.rt.videoPanel.endBut, true)
	SetSpriteVisible(ru.rt.videoPanel.timeBut, true)
	SetSpriteVisible(ru.rt.videoPanel.timeLine, true)
	SettextVisible(ru.rt.videoPanel.startTime, true)
	SettextVisible(ru.rt.videoPanel.endTime, true)
	
endfunction

//-----------------------------------------------------
// Check if any video panel controls are pressed.
//
function ruCheckVideoPanel(x as float, y as float)

	local vpos as float
	local pressed as integer

	pressed = false
	
	if ru.rt.videoIdx > -1 and ru.rt.videoPanel.vis

		pressed = true

		if coGetSpriteHitTest(ru.rt.videoPanel.playBut, x, y, 10)
			if GetVideoPlaying()
				ruPauseVideo()
			else
				ruPlayVideo()
			endif

			ruShowVideoPanel()
			
		elseif coGetSpriteHitTest(ru.rt.videoPanel.startBut, x, y, 10)

			ruSetVideoTime(0.0)
			
		elseif coGetSpriteHitTest(ru.rt.videoPanel.endBut, x, y, 10)

			ruSetVideoTime(ma.videos[ru.rt.videoIdx].duration)
			
		elseif coGetSpriteHitTest(ru.rt.videoPanel.rewBut, x, y, 10)

			vpos = GetVideoPosition()
			//colog("vpos1=" + str(vpos))
			vpos = floor((vpos / ma.videos[ru.rt.videoIdx].duration) * 10) * (ma.videos[ru.rt.videoIdx].duration / 10)
			//colog("vpos2=" + str(vpos))
			ruSetVideoTime(vpos)
			
		elseif coGetSpriteHitTest(ru.rt.videoPanel.rewBut, x, y, 10)

			vpos = GetVideoPosition()
			//colog("vpos1=" + str(vpos))
			vpos = ceil((vpos / ma.videos[ru.rt.videoIdx].duration) * 10) * (ma.videos[ru.rt.videoIdx].duration / 10)
			//colog("vpos2=" + str(vpos))
			ruSetVideoTime(vpos)

		else

			pressed = false
			
		endif

	endif
	
endfunction pressed

//-----------------------------------------------------
// Update the video times.
//
function ruShowVideoTimes()

	local s as string 
	local y as float
	local gap as float
	local w as float
	local vpos as float

	y = ma.videos[ru.rt.videoIdx].y + ma.videos[ru.rt.videoIdx].h + RU_VIDEO_PANEL_HEIGHT / 2
	gap = RU_VIDEO_PANEL_HEIGHT / 4
	vpos = GetVideoPosition()

	s = coTimeToString(vpos * 1000.0, true)
	//s = ReplaceString(s, "00:", "", -1)
	settextstring(ru.rt.videoPanel.starttime, s)
	SettextPosition(ru.rt.videoPanel.startTime, ma.videos[ru.rt.videoIdx].x + co.bs / 16, y + gap - GetTextTotalHeight(ru.rt.videoPanel.starttime) / 2)

	s = "-" + coTimeToString((ma.videos[ru.rt.videoIdx].duration - vpos) * 1000.0, true)
	//s = ReplaceString(s, "00:", "", -1)
	settextstring(ru.rt.videoPanel.endtime, s)
	SettextPosition(ru.rt.videoPanel.endTime, ma.videos[ru.rt.videoIdx].x + ma.videos[ru.rt.videoIdx].w - co.bs / 16, y + gap - GetTextTotalHeight(ru.rt.videoPanel.endtime) / 2)

	w = ma.videos[ru.rt.videoIdx].w - GetTextTotalWidth(ru.rt.videoPanel.starttime) - GetTextTotalWidth(ru.rt.videoPanel.endtime) - gap * 2
	ru.rt.videoPanel.timeDiv = w / ma.videos[ru.rt.videoIdx].duration
	SetSpriteScale(ru.rt.videoPanel.timeLine, w, 2)
	SetSpritePosition(ru.rt.videoPanel.timeLine, ma.videos[ru.rt.videoIdx].x + GetTextTotalWidth(ru.rt.videoPanel.starttime) + gap, y + gap)

	SetSpritePositionByOffset(ru.rt.videoPanel.timeBut, GetSpriteX(ru.rt.videoPanel.timeLine) + vpos * ru.rt.videoPanel.timeDiv, y + gap)

endfunction

//-----------------------------------------------------
// Hide the video control, and play appropriately.
//
function ruHideVideoPanel()

	SetSpriteVisible(ru.rt.videoPanel.panel, false)
	SetSpriteVisible(ru.rt.videoPanel.playBut, false)
	SetSpriteVisible(ru.rt.videoPanel.rewBut, false)
	SetSpriteVisible(ru.rt.videoPanel.fwdBut, false)
	SetSpriteVisible(ru.rt.videoPanel.startBut, false)
	SetSpriteVisible(ru.rt.videoPanel.endBut, false)
	SetSpriteVisible(ru.rt.videoPanel.timeBut, false)
	SetSpriteVisible(ru.rt.videoPanel.timeLine, false)
	SettextVisible(ru.rt.videoPanel.startTime, false)
	SettextVisible(ru.rt.videoPanel.endTime, false)

endfunction

//-----------------------------------------------------
// Take a thing list from coder, and build a runtime out of it.
//
function ruInitRuntime()

	local i as integer
	local thread as Thread
	local thingIdx as integer
	local varIdx as integer
	local td as Depth
	local threadIdxs as integer[]
	local cmd as integer
	
	ru.rt.threadId = 1 // Start new thread ids.
	ru.rt.vx = co.bs / 8
	ru.rt.vy = co.bs / 8

	ru.rt.sortThreads = false // Don't want to sort on first setting.
	
	if ru.appIdx > -1

		// if ru.rt.debug then ruDebug(1, "ruInitRuntime()")		
		ruInitVars(ma.apps[ru.appIdx].vars)
				
		for i = 0 to ma.apps[ru.appIdx].sprites.length

			thingIdx = ma.apps[ru.appIdx].sprites[i]
			//ma.things[thingIdx].collGrp = i + 1						
			ma.things[thingIdx].rImgIdx = ma.things[thingIdx].imgIdx
			ruInitThing(thingIdx)
			ruCreateThingThreads(thingIdx)

		next

		// Set up collisions. Needs to be done after all sprites are created.
/*		
		for i = 0 to ru.rt.threads.length

			if ru.rt.threads[i].event = CODE_EVENT_COLL_THING

				cmd = ma.things[ru.rt.threads[i].thingIdx].cmds[ru.rt.threads[i].thingEventCmdIdx]				
				ruSetupCollision(ru.rt.threads[i].thingIdx, cmd)

			elseif ru.rt.threads[i].event = CODE_EVENT_COLL_ANY_THING
			
				ruSetupCollisionAny(ru.rt.threads[i].thingIdx)
				
			endif

		next

		for i = 0 to ma.apps[ru.appIdx].sprites.length
			
			thingIdx = ma.apps[ru.appIdx].sprites[i]
			ruSetupCollisionCmds(thingIdx)
			
		next
*/	
		// Set the depth div for calculation of a good distribution of depths.
		ruApplyThreadDepths(true)
				
	endif

	// Need to do this here to make sure it picks up app vars and sprite vars.
	ruApplyVarDepths(ru.rt.vardepths)

	ruUnloadVideo()
	ruClearCollisions()

	ru.rt.input = ""
	ru.rt.vars.length = -1
	ru.rt.channels.length = -1
	ru.rt.freeChannels.length = -1
	ru.rt.lastChannel = -1
	ru.rt.volume = 100.0
	ru.rt.soundLoops = 1
	ru.rt.ignoreCase = false
	ru.rt.thingPressed = -1
	ru.rt.ptrPressed = false
	ru.rt.ptrDown = false
	ru.rt.ptrReleased = false
	ru.rt.videoVolume = 100
	
	ru.rt.displayBgColor = co.grey[0]
	ru.rt.displayBorderColor = co.grey[3]
	ru.rt.displayTextColor = co.black
	ru.rt.displayFont = 0
	ru.rt.displayFontSize = co.fontSizes[0]
	ru.rt.screenBgColor = co.white
	ru.rt.timer = GetMilliseconds()

	//ruDrawLine(0, 0, co.w - 1, 0, 255, 0, 0, 1)
	
endfunction //rt

//-----------------------------------------------------
// Reset a thing to its visible state.
//
function ruInitThing(thingIdx as integer)

	local i as integer
	local cmd as integer
	local img as integer
		
	for i = 0 to ma.things[thingIdx].imgs.length
		ldLoadThingImage(ru.appIdx, thingIdx, i, LD_MODE_IMAGE)
	next

	if not ma.things[thingIdx].obj
 
		ma.things[thingIdx].obj = createobject(ma.things[thingIdx].imgs[ma.things[thingIdx].rimgIdx].img)
		//SetColGroup(ma.things[thingIdx].obj, ma.things[thingIdx].collGrp)
	
	endif
	
	ClearSpriteShapes(ma.things[thingIdx].obj)
	SetSpriteShape(ma.things[thingIdx].obj, 3)
	
	// For physics.
	//SetSpritePhysicsOn(ma.things[thingIdx].obj, 2)
	//SetSpriteGroup(ma.things[thingIdx].obj, 1)
	
	//if ma.things[thingIdx].moved
		setpos(ma.things[thingIdx].obj, ma.things[thingIdx].x, ma.things[thingIdx].y)
	//else 
	//	setpos(ma.things[thingIdx].obj, ru.w / 2, ru.h / 2)
	//endif 
	
	setangle(ma.things[thingIdx].obj, ma.things[thingIdx].ang)
	//ruApplyTrans(thingIdx)
	SetAlpha(ma.things[thingIdx].obj, 255)
	setscalex(ma.things[thingIdx].obj, ma.things[thingIdx].sx)
	setscaley(ma.things[thingIdx].obj, ma.things[thingIdx].sy)
	img = GetSpriteImageID(ma.things[thingIdx].obj)
	SetImageMinFilter(img, ma.things[thingIdx].smoothScaling)
	SetImageMagFilter(img, ma.things[thingIdx].smoothScaling)
	setvisible(ma.things[thingIdx].obj, true)

	// Don't reset vars on a clone.
	if ma.things[thingIdx].clonedIdx = -1
		ruInitVars(ma.things[thingIdx].vars)
	endif

	ma.things[thingIdx].isBg = false
	ma.things[thingIdx].doPress = false
	ma.things[thingIdx].doCollision = false
	
	ma.things[thingIdx].drawSprs.length = -1
	ruClearPen(thingIdx)
		
endfunction

//-----------------------------------------------------
// Init vars list.
//
function ruInitVars(vars ref as integer[])
	
	local i as integer
	local varIdx as integer
	local td as Depth
	
	for i = 0 to vars.length
		
		varIdx = vars[i]
		ruResetVar(varIdx)
		ruShowVar(varIdx)
		ruDrawVar(varIdx)

		td.idx = varIdx
		ru.rt.vardepths.insert(td)
		
	next

endfunction

//-----------------------------------------------------
// Reset all thing depths.
//
function ruApplyVarDepths(depths ref as Depth[])

	local i as integer
	local visDepth as integer
	local depthRange as integer
	local depthDiv as integer

	if depths.length > -1
		
		depthRange = (VAR_DEPTH_MAX * VAR_DEPTH_SKIP)	
		depthDiv = depthRange / (depths.length + 1) 
		visDepth = VAR_DEPTH_BASE
		
		for i = 0 to depths.length
			
			visDepth = visDepth + depthDiv
			maSetVarViewDepth(ma.vars[depths[i].idx].rv, visDepth)
			
		next
		
	endif
	
endfunction

//-----------------------------------------------------
// Sort threads based on depth, then calc visDepth.
// sort flag is passed if the thread depths are already set and you need to reoder.
// First call should be set to false to set the depth.
// threadIdxs will be returned.
//
function ruApplyThreadDepths(setDepths as integer)

	local depth as integer
	local i as integer
	local thingIdx as integer
	local prevThingIdx as integer
	local ln as integer
		
	if ru.rt.sortThreads
		
		ru.rt.threads.sort()
		ru.rt.sortThreads = false

	endif

	if not setDepths
		exitfunction
	endif
				
	prevThingIdx = -1
	ru.rt.depthDiv = 0
	ru.rt.thingCount = 0

	ln = ru.rt.threads.length
	
	for i = 0 to ln
		
		thingIdx = ru.rt.threads[i].thingIdx	
		
		// Ensure that threads with the same thing, have the same depth.
		if thingIdx <> prevThingIdx
			inc ru.rt.thingCount
		endif
		
		prevThingIdx = thingIdx
		
	next
			
	ru.rt.depthDiv = co.depthRange / (ru.rt.thingCount + 1)	
	depth = THING_DEPTH_BASE
	prevThingIdx = -1
	
	for i = 0 to ln

		thingIdx = ru.rt.threads[i].thingIdx	
		
		// Ensure that threads with the same thing, have the same depth.
		if thingIdx <> prevThingIdx
			depth = depth + ru.rt.depthDiv
		endif
	
		ru.rt.threads[i].depth = depth		
		SetDepth(ma.things[thingIdx].obj, depth)
		guiSetTipDepth(ma.things[thingIdx].tip, depth)

	next
			
endfunction

//-----------------------------------------------------
// Find the thread at 'depth', which should be the first one. Adjust it, then all others with same thingIdx.
// Set the depth for a single thread.
//
function ruApplyThreadDepth(thread ref as Thread, depth as integer)

	local idx as integer
	
	idx = ru.rt.threads.find(thread.depth)
	
	if idx > -1

		// Set the depth once.
		SetDepth(ma.things[thread.thingIdx].obj, depth)
		guiSetTipDepth(ma.things[thread.thingIdx].tip, depth)
		
		// Loop through threads to set the same depth for sorting.
		while idx <= ru.rt.threads.length
			
			if ru.rt.threads[idx].thingIdx = thread.thingIdx

				ru.rt.threads[idx].depth = depth
				inc idx
				
			else 
				
				exit
				
			endif
			
		endwhile
		
	endif
	
	ru.rt.sortThreads = true

endfunction

//-----------------------------------------------------
// Show a var if it needs to be shown.
//
function ruShowVar(varIdx as integer)
	
	//if ma.vars[varIdx].vis
	if ma.vars[varIdx].rv.vis
		
		ma.vars[varIdx].rv.name = ma.vars[varIdx].name 
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)
		
	endif

endfunction

//-----------------------------------------------------
// Create all thing threads.
//
function ruCreateThingThreads(thingIdx as integer)

	local i as integer
	local cmd as integer
	local threadIdx as integer
	local o as NbrOrder
	local order as NbrOrder[]
	local threadIdxs as integer[]
	
	threadIdxs.length = -1

	// Get the order right based on the position in the panel.
	for i = 0 to ma.things[thingIdx].cmds.length

		cmd = ma.things[thingIdx].cmds[i]
		
		if ma.cmds[cmd].grp = GRP_BEGIN
			
			o.nbr = ma.cmds[cmd].y
			o.idx = i
			order.insertsorted(o)
			
		endif

	next

	for i = 0 to order.length

		cmd = ma.things[thingIdx].cmds[order[i].idx]

		if ma.cmds[cmd].grp = GRP_BEGIN
			
			threadIdx = ruCreateThread(thingIdx, order[i].idx)
			threadIdxs.insert(threadIdx)

		endif

	next

	if threadIdxs.length = -1
		threadIdx = ruCreateThread(thingIdx, -1)
	endif

endfunction threadIdxs

//-----------------------------------------------------
// Clone all threads for a thing to a clone.
//
function ruCloneThingThreads(parentThingIdx as integer, clonedThingIdx as integer)

	local i as integer
	local threadIdx as integer
	local threadIdxs as integer[]
	local ln as integer
	
	threadIdxs.length = -1

	// Make sure we always clone the parent sprite, we need the thread.parent to point to that one.
	if ma.things[parentThingIdx].clonedIdx > -1
		parentThingIdx = ma.things[parentThingIdx].clonedIdx
	endif

	ln = ru.rt.threads.length
	
	for i = 0 to ln // ru.rt.threads.length

		if ru.rt.threads[i].thingIdx = parentThingIdx
					
			threadIdx = ruCreateThread(clonedThingIdx, ru.rt.threads[i].thingEventCmdIdx)
			ru.rt.threads[threadIdx].parent = ru.rt.threads[i].id		
			threadIdxs.insert(threadIdx)	

			//if ma.cmds[cmd].code = CODE_EVENT_COLL_THING
			//	ruSetupCollision(clonedThingIdx, cmd)
			//endif

		endif

	next

	//ruSetupCollisionCmds(clonedThingIdx)

endfunction threadIdxs

/*
//-----------------------------------------------------
// Set up collision cmds.
//
function ruSetupCollisionCmds(thingIdx as integer)

	local press as CmdPress
	local otherThingIdx as integer
	local tmpCmd as integer

	// Check if any "collided with sprite" sense cmds exist.

	press.code = CODE_SENSE_COLL_THING
	press.idx = 0
	
	while press.idx > -1
		
		press.cmd = 0
		press.parentCmd = -1
		press.partIdx = -1
		press.idx = cdFindThingPartCmd(thingIdx, press)

		if press.parentCmd > -1 and press.partIdx > -1

			tmpCmd = cdGetPartAsInt(ma.cmds[press.parentCmd].parts[press.partIdx])
			//otherThingIdx = ruSetupCollision(thingIdx, tmpCmd)
			ruSetupCollision(thingIdx, tmpCmd)
			
			//if otherThingIdx > -1
				//ma.things[thingIdx].colWith.insert(ma.things[otherThingIdx].collGrp)
			//	ruInsertColWith(ma.things[thingIdx].colWith, ma.things[otherThingIdx].collGrp)
			//	ma.things[thingIdx].doCollision = true
				
			//endif
			
			inc press.idx
						
		endif

	endwhile
		
endfunction
*/

/*
//-----------------------------------------------------
// Insert the collGrp into the colWith list, making sure its only insert one.
//
function ruInsertColWith(colWith ref as integer[], collGrp as integer)

	if colWith.find(collGrp) = -1
		colWith.insertsorted(collGrp)
	endif
	
endfunction
*/

/*
//-----------------------------------------------------
// Insert the thingIdx to collide with.
//
function ruInsertColWith(colWith ref as integer[], thingIdx as integer)

	if colWith.find(thingIdx) = -1
		colWith.insertsorted(thingIdx)
	endif
	
endfunction
*/

/*
//-----------------------------------------------------
// Setup the collisition between the passed thing, and the thing in the cmd.
// Not the cmd could be a coll cmd, or a thing cmd, need to check.
//
function ruSetupCollision(thingIdx as integer, cmd as integer)

	local otherThingCmd as integer
	local otherThingIdx as integer

	if ma.cmds[cmd].code = CODE_EVENT_COLL_THING or ma.cmds[cmd].code = CODE_SENSE_COLL_THING
	
		if ma.cmds[cmd].parts[1].typ = PART_CMD
			
			// Both cmds have the thing as part 1, so don't need separate checks.
			otherThingCmd = cdGetPartAsInt(ma.cmds[cmd].parts[1])	
			otherThingIdx = -1
		
		endif

	elseif ma.cmds[cmd].code = CODE_SPRITE_PART

		otherThingCmd = cmd
		
	else 
		
		otherThingCmd = 0			
					
	endif

	if otherThingCmd

		//otherThingIdx = cdGetPartAsInt(ma.cmds[otherThingCmd].parts[0])
		otherThingIdx = maFindThingById(ru.appIdx, cdGetPartAsString(ma.cmds[otherThingCmd].parts[0]))
		ruSetupCollisionThings(thingIdx, otherThingIdx)
	
	endif

endfunction otherThingIdx

//-----------------------------------------------------
// Setup the collisition between the passed thing, and any other thing.
//
function ruSetupCollisionAny(thingIdx as integer)
	
	local otherThingIdx as integer
	local i as integer
	
	if thingIdx > -1 and ru.appIdx > -1
		
		for i = 0 to ma.apps[ru.appIdx].sprites.length
			
			otherThingIdx = ma.apps[ru.appIdx].sprites[i]
			
			if otherThingIdx <> thingIdx
				ruSetupCollisionThings(thingIdx, otherThingIdx)
			endif
			
		next 
		
	endif
	
endfunction

//-----------------------------------------------------
// Setup the collisition between the passed thing, and the other thing.
//
function ruSetupCollisionThings(thingIdx as integer, otherThingIdx as integer)
	
	if otherThingIdx > -1

		// TODO: Is this optimal?
		clearspriteshapes(ma.things[thingIdx].obj)
		SetSpriteShape(getsprite(ma.things[thingIdx].obj), 3)		
		//ma.things[thingIdx].colWith.Insert(ma.things[otherThingIdx].collGrp) 
		//ruInsertColWith(ma.things[thingIdx].colWith, ma.things[otherThingIdx].collGrp)
		ruInsertColWith(ma.things[thingIdx].colWith, otherThingIdx)
		//ma.things[thingIdx].doCollision = True
	
	endif

endfunction
*/

//-----------------------------------------------------
// Create a new thread.
// Returns the index of the thread in the list.
//
function ruCreateThread(thingIdx as integer, thingEventCmdIdx as integer)

	local thread as Thread
	local idx as integer

	thread.id = ruNextThreadId()
	thread.caller = 0 // No callers.
	thread.parent = 0 // Might be the same thread in the parent of a clone.
	thread.thingIdx = thingIdx
	thread.thingEventCmdIdx = thingEventCmdIdx
	if thingEventCmdIdx > -1
		thread.event = ma.cmds[ma.things[thingIdx].cmds[thread.thingEventCmdIdx]].code
	else 
		thread.event = -1 // Fake thread for depth processing.
	endif
	//thread.imgIdx = ma.things[thingIdx].imgIdx
	thread.blockTimer = false
	thread.active = false
	thread.reset = true
	thread.deleted = false
	//ruClearPen(thread)
	
	ru.rt.threads.insert(thread)
	idx = ru.rt.threads.length

endfunction idx

//-----------------------------------------------------
// Create a new thread.
//
function ruResetThread(thread ref as Thread)

	thread.idx = thread.thingEventCmdIdx + 1
	thread.prvIdx = -1
	thread.tmpVars.length = -1
	thread.partVars.length = -1
	thread.stack.length = -1
	thread.waitTime = 0
	//thread.blockTimer = false
	thread.waitUntil = 0
	thread.waitSay = 0
	thread.waitChannels.length = -1
	thread.waitVideo = false
	thread.waitInput = 0
	thread.waitInputChange = false
	thread.waitEvents.length = -1
	thread.eventVarIdx = 0
	thread.reset = false
	thread.turbo = false
	//thread.depth = 0

endfunction

//-----------------------------------------------------
// Get a new thread id.
//
function ruNextThreadId()

	local ret as integer
	
	ret = ru.rt.threadId
	inc ru.rt.threadId
	
endfunction ret

//-----------------------------------------------------
// Cleaup the runtime.
//
function ruCleanRuntime()

	local i as integer
	local thingIdx as integer
	local var as integer

	ruDeleteThingThreads(-1)

	if ru.appIdx > -1

		// Clean up real things.
		for i = 0 to ma.apps[ru.appIdx].sprites.length

			thingIdx = ma.apps[ru.appIdx].sprites[i]			
			ruRemoveThing(thingIdx)

		next

		// Clean visible vars, shown as a command.
		for i = 0 to ma.apps[ru.appIdx].vars.length

			var = ma.apps[ru.appIdx].vars[i]
			ruResetVar(var)
			
		next

	endif

	// Delete runtime vars.
	
	for i = 0 to ru.rt.vars.length
		
		var = ru.rt.vars[i]
		cdDeleteVar(var)
		
	next

	ru.rt.vars.length = -1

	// Clear tips.
	for i = 0 to ru.rt.atTips.length
		guiDeleteTip(ru.rt.atTips[i])
	next

	ru.rt.atTips.length = -1

	ruClearSounds()
	ruUnloadVideo()
	ruClearCollisions()
	
endfunction

//-----------------------------------------------------
// Remove a thing.
//
function ruRemoveThing(thingIdx as integer)

	local i as integer
	local var as integer
	local cmd as integer
	local j as integer
	local img as integer
	
	if ma.things[thingIdx].obj

		img = GetSpriteImageID(ma.things[thingIdx].obj)

		removeobject(ma.things[thingIdx].obj)
		ma.things[thingIdx].obj = 0
		
		if ma.things[thingIdx].clonedIdx = -1
					
			// Reset for next run, only for originals, non-clones.
			SetImageMinFilter(img, ma.things[thingIdx].smoothScaling)
			SetImageMagFilter(img, ma.things[thingIdx].smoothScaling)
			
		endif
				
	endif
	
	// Check whether the thing tip needs cleaning.
	guiDeleteTip(ma.things[thingIdx].tip)

	// If not a clone, clean thing var values and visible cmds.

	if ma.things[thingIdx].clonedIdx = -1

		ldUnloadThingImage(thingIdx, -1, LD_MODE_IMAGE)

		for i = 0 to ma.things[thingIdx].imgs.length
			
			if ma.things[thingIdx].imgs[i].penImg
				
				deleteimage(ma.things[thingIdx].imgs[i].penImg)
				ma.things[thingIdx].imgs[i].penImg = 0

			endif

			if ma.things[thingIdx].imgs[i].bgImg
				
				deleteimage(ma.things[thingIdx].imgs[i].bgImg)
				ma.things[thingIdx].imgs[i].bgImg = 0

			endif

		next
		
		for i = 0 to ma.things[thingIdx].vars.length

			var = ma.things[thingIdx].vars[i]
			ruResetVar(var)
			
		next
		
	else 
		
		// These are dups of the original, don't delete, just clear.
//log("clearing imgs of clone, thingIdx=" + str(thingIdx))
		ma.things[thingIdx].imgs.length = -1

	endif

	ma.things[thingIdx].drawSprs.length = -1
	ruClearPen(thingIdx)
	
endfunction

//-----------------------------------------------------
// Delete all the threads for a thingIdx.
//
function ruDeleteThingThreads(thingIdx as integer)

	local i as integer
	local idx as integer

	i = 0
	
	while i <= ru.rt.threads.length
		
		if thingIdx = -1 or ru.rt.threads[i].thingIdx = thingIdx

			ruDeleteThread(ru.rt.threads[i])
			
			if thingIdx > -1
				
				ru.rt.threads.remove(i)
				continue // Don't allow inc of i.
				
			endif
			
		endif

		inc i

	endwhile

	if thingIdx = -1				
		ru.rt.threads.length = -1
	endif

endfunction

//-----------------------------------------------------
// Delete the inards of a thread.
//
function ruDeleteThread(thread ref as Thread)

	if thread.deleted
		exitfunction
	endif
	
	if ma.things[thread.thingIdx].deleted
		exitfunction
	endif
	
	local i as integer
	local var as integer

	// It's a clone, clean up. This needs to be done here, because the
	// thread is the only place the clone exists. Note, it may call it
	// multiple times (due to multiple threads for the same thing),
	// but that doesn't matter, it has no effect.
	//
	
	// Can't do this here, it breaks clones
	//if ma.things[thread.thingIdx].clonedIdx > -1

	//	ruRemoveThing(thread.thingIdx)
	//	maDeleteThing(thread.thingIdx)
							
	//endif	

	// Delete temp thread vars.
	for i = 0 to thread.tmpVars.length
		
		var = thread.tmpVars[i]
		
		//ruResetVar(thread.tmpVars[i])
		maDeleteVarView(ma.vars[var].rv)
		
		if ma.vars[var].typ = VAR_TYPE_LIST
			for i = 0 to ma.vars[var].runList.length
				if ma.vars[var].runList[i].name = "list"
					cdDeleteVar(val(ma.vars[var].runList[i].value))
				endif
			next
		endif

		cdDeleteVar(var)
		
	next

	thread.tmpVars.length = -1

	// Delete part thread vars.
	for i = 0 to thread.partVars.length
		cdDeleteVar(thread.partVars[i].varIdx)
	next

	thread.partVars.length = -1
	thread.active = false
	thread.deleted = true

	//ruClearPen(thread)
	
endfunction

//-----------------------------------------------------
// Stop running.
//
function ruStop()

	local idx as integer

	// if ru.rt.debug then ruDebug(1, "ruStop start")

	ru.executing = RU_NONE
	
	ruResumeButton() // Just to restore the button to the pause state.
	
	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_PAUSE)
	if idx > -1
		guiSetButtonActive(ru.moreBar.buts[idx], false)
	endif

	//idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_SNAP)
	//guiSetButtonActive(ru.moreBar.buts[idx], false)

	ruEndRecording()
	
	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_START_RECORD)
	if idx > -1
		guiSetButtonActive(ru.moreBar.buts[idx], false)
	endif

	ruClearSounds()
	ruPauseVideo()
			
	guiSetButtonIcon(ru.runBut, ru.runButImg)
	guiSetButtonText(ru.runBut, "run")
	cosettextcolor(ru.runBut.text, co.black)
	coSetSpriteColor(ru.runBut.bg, co.green[5])
	guiSetButtonAlpha(ru.runBut, 127)
	ru.runBut.id = BUT_RUNNER_RUN

	guiSetButtonDepth(ru.runBut, FRONT_DEPTH - 10)

	// if ru.rt.debug then ruDebug(1, "ruStop end")

	if ru.rt.logToFile
		
		CloseFile(ru.rt.logToFile)
		ru.rt.logToFile = 0
		
	endif
	
endfunction

//-----------------------------------------------------
// Pause running.
//
function ruPause()

	ru.executing = RU_NONE
	ruPauseButton()
	
endfunction

//-----------------------------------------------------
// Pause running.
//
function ruPauseButton()

	local idx as integer

	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_PAUSE)

	if idx > -1
		
		guiSetButtonIcon(ru.moreBar.buts[idx], ru.resumeButImg)
		guiSetButtonText(ru.moreBar.buts[idx], "resume")
		coSetSpriteColor(ru.moreBar.buts[idx].bg, co.green[5])
		ru.moreBar.buts[idx].id = BUT_RUNNER_RESUME

	endif
	
endfunction

//-----------------------------------------------------
// Resume running.
//
function ruResume()

	ru.executing = RU_RESUME
	ruResumeButton()
	
endfunction

//-----------------------------------------------------
// Resume running.
//
function ruResumeButton()

	local idx as integer

	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_RESUME)

	if idx > -1
		
		guiSetButtonIcon(ru.moreBar.buts[idx], ru.pauseButImg)
		guiSetButtonText(ru.moreBar.buts[idx], "pause")
		coSetSpriteColor(ru.moreBar.buts[idx].bg, co.orange[5])
		ru.moreBar.buts[idx].id = BUT_RUNNER_PAUSE

	endif
	
endfunction

//-----------------------------------------------------
// Snap a photo for the project.
//
function ruSnap()

	local img as integer
	local spr as integer

	guiHideBar(ru.moreBar)
	guiSetButtonVisible(ru.backBut, false)
	guiSetButtonVisible(ru.runBut, false)
	guiSetButtonVisible(ru.moreBut, false)

	update(0)
	Render()
	img = getimage(0, 0, ru.w, ru.h)
	swap()

	// Force reload of lib.
	cdDeleteCmd(ma.apps[ru.appIdx].cmd)
	ma.apps[ru.appIdx].cmd = 0
	cd.subMode = CD_SUBMODE_PRELOAD
	
	ResizeImage(img, ru.w * ld.set.projIconSize / 4, ru.h * ld.set.projIconSize / 4)

	ldSaveAppIcon(ru.appIdx, img)

	guiSetButtonVisible(ru.backBut, true)
	guiSetButtonVisible(ru.runBut, true)
	guiSetButtonVisible(ru.moreBut, true)
	
endfunction

//-----------------------------------------------------
// Record running.
//
function ruStartRecording()

	local idx as integer

	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_START_RECORD)

	guiSetButtonIcon(ru.moreBar.buts[idx], ru.endRecordButImg)
	guiSetButtonText(ru.moreBar.buts[idx], "recording")
	ru.moreBar.buts[idx].id = BUT_RUNNER_END_RECORD

	ru.recordFile = ldGetRecordFile()
	StartScreenRecording(ru.recordFile, true)
	
endfunction

//-----------------------------------------------------
// Record running.
//
function ruEndRecording()

	local idx as integer

	idx = guiFindBarButtonById(ru.moreBar, BUT_RUNNER_END_RECORD)

	if idx > -1
		
		guiSetButtonIcon(ru.moreBar.buts[idx], ru.startRecordButImg)
		guiSetButtonText(ru.moreBar.buts[idx], "record")
		//coSetSpriteColor(ru.moreBar.buts[idx].bg, co.green[5])
		ru.moreBar.buts[idx].id = BUT_RUNNER_START_RECORD

	endif

	if ru.recordFile <> ""
		StopScreenRecording()
	endif
	
endfunction

//
//*****************************************************
// START RUNTIME and THREAD ENGINE.
//*****************************************************
//

//-----------------------------------------------------
// Activate events.
//
function ruActivateEvent(thingIdx as integer, event as integer)

	if not ru.executing
		exitfunction
	endif
	
	local i as integer
	local idx as integer
	local ln as integer
	
	ln = ru.rt.threads.length
		
	for i = 0 to ln
			
		idx = i
			
		if thingIdx = -1 or ru.rt.threads[idx].thingIdx = thingIdx
			if ru.rt.threads[idx].event = event
				
				// if ru.rt.debug then ruDebug(2, "ruActivateEvent(thingIdx=" + str(thingIdx) + ", event=" + str(event) + ")")
				ru.rt.threads[idx].active = true
				ru.rt.threads[idx].reset = true
				
			endif		
		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Find a thread by id.
//
function ruFindThreadById(id as integer)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ru.rt.threads.length
		
		if ru.rt.threads[i].id = id
			
			ret = i
			exit

		endif
		
	next
	
endfunction ret

//-----------------------------------------------------
// Run thread from an event.
//
function ruExecuteThread(thread ref as Thread)

	local i as integer
	local cmd as integer
	local tmpIdx as integer
	local tmpCmd as integer
	local eval as integer
	local m as integer
	local m2 as integer
	local yield as integer
	local ret as string 
	local count as integer
	local pressed as integer
	local px as float
	local py as float
	local idx as integer
	
	cmd = 0
	yield = false

	// if ru.rt.debug then ruDebug(1, "ruExecuteThread(thingIdx=" + str(thread.thingIdx) + ", name=" + ma.things[thread.thingIdx].name + ", thread.id=" + str(thread.id) + ", event=" + str(thread.event) + ")")
	// if ru.rt.debug then ruDebugIndent(1)

	// Don't execute clone events if this thread is for a master sprite.
	if thread.event = CODE_EVENT_CLONE and ma.things[thread.thingIdx].clonedIdx = -1
		exitfunction
	endif

	if thread.reset
		ruResetThread(thread)
	endif

	// Optimise getting the time.
	m = GetMilliseconds() 
		
	if thread.waitChannels.length > -1 // Playing a sound until done.

		// if ru.rt.debug then ruDebug(1, "ruExecuteThread: there are sounds playing (e.g. waitChannels > -1)")

		i = 0
		
		while i <= thread.waitChannels.length

			// Still playing?
			if GetSoundInstancePlaying(ru.rt.channels[thread.waitChannels[i]].playId)				

				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: sound is still playing")
				inc i

			else

				thread.waitChannels.remove(i)
				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: sound has stopped playing")
				
			endif
			
		endwhile

		// Still not done.
		if thread.waitChannels.length > -1
			
			// if ru.rt.debug then ruDebugIndent(-1)
			// if ru.rt.debug then ruDebug(1, "ruExecuteThread: exiting, there are still sound playing (i.e. waitChannels > -1)")			
			exitfunction
			
		endif
		
	elseif thread.waitTime > 0

		// if ru.rt.debug then ruDebug(1, "ruExecuteThread: thread is executing WAIT_FOR_TIME cmd " + str(thread.waitTime))
		
		//m = GetMilliseconds()
		
		if m >= thread.waitTime
			
			thread.waitTime = 0
			// if ru.rt.debug then ruDebug(1, "ruExecuteThread: waiting is over, will go to next cmd")

		else

			// if ru.rt.debug then ruDebugIndent(-1)
			// if ru.rt.debug then ruDebug(1, "ruExecuteThread: exiting, haven't waited long enough yet, still have millis=" + str(thread.waitTime - m))
			exitfunction // Can't run yet.

		endif
			
	elseif thread.waitUntil // Still sitting on a wait cmd.
		
		ruWaitUntilPtr(thread, ma.cmds[thread.waitUntil])
		
		if thread.waitUntil // Still waiting.
			exitfunction
		endif

	elseif thread.waitInput

		// if ru.rt.debug then ruDebug(1, "ruExecuteThread: waiting for input")

		if thread.waitInputChange

			thread.waitInputChange = false

			// Came off a resume, reset back to waiting for input.
			if ru.executing = RU_RESUME

				if ma.vars[thread.waitInput].rv.edit
					SetEditBoxFocus(ma.vars[thread.waitInput].rv.edit, true)
				endif

			else
			
				ret = GetEditBoxText(ma.vars[thread.waitInput].rv.edit)
				DeleteEditBox(ma.vars[thread.waitInput].rv.edit)
				ma.vars[thread.waitInput].rv.edit = 0

				ruSetVarAsString(ma.vars[thread.waitInput], ret)

				if ma.vars[thread.waitInput].vis
					ruDrawVar(thread.waitInput)
				endif

				thread.waitInput = 0

			endif

		elseif ma.vars[thread.waitInput].rv.edit
			
			if GetEditBoxChanged(ma.vars[thread.waitInput].rv.edit)

				thread.waitInputChange = true
	
				// Waiting, so keep active.
				// if ru.rt.debug then ruDebugIndent(-1)
				// if ru.rt.debug then ruDebug(1, "ruExecuteThread: input has changed, note it for next loop")
				exitfunction
	
			else
	
				// Waiting, so keep active.
				// if ru.rt.debug then ruDebugIndent(-1)
				// if ru.rt.debug then ruDebug(1, "ruExecuteThread: exiting, input hasn't changed, still have to wait for input")
				exitfunction
				
			endif
			
		endif

	elseif thread.waitEvents.length > -1 // Waiting for an event thread to complete.

		// if ru.rt.debug then ruDebugIndent(-1)
		// if ru.rt.debug then ruDebug(1, "ruExecuteThread: thread is waiting for " + str(thread.waitEvents.length) + " (events received) threads to complete")
		exitfunction
		
	elseif thread.waitVideo

		if GetVideoPlaying()				

			// if ru.rt.debug then ruDebugIndent(-1)
			// if ru.rt.debug then ruDebug(1, "ruExecuteThread: video is still playing")
			exitfunction

		else

			thread.waitVideo = false
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: video has stopped playing")
			
		endif

	endif

	if thread.waitSay > 0

		// if ru.rt.debug then ruDebug(1, "ruExecuteThread: thread is executing PRINT_FOR_TIME cmd " + str(thread.waitSay))
		
		if m >= thread.waitSay
			
			// if ru.rt.debug then ruDebug(1, "ruExecuteThread: waiting is over, remove say")
			ruClearPrintPtr(thread)

		endif
		
	endif
	
	//if thread.reset
	//	ruResetThread(thread)
	//endif

	// if ru.rt.debug then ruDebug(1, "ruExecuteThread: entering thread while loop with idx=" + str(thread.idx))

	count = 0
	
	if thread.turbo
		pressed = 0 // Clear the pointer pressed.
	endif
		
	while thread.active and thread.idx > -1 and thread.idx <= ma.things[thread.thingIdx].cmds.length

		if thread.turbo
			
			if not pressed
			
				idx = GetRawFirstTouchEvent(0)
				
				if idx
					
					pressed = true
					px = GetRawTouchCurrentX(idx)
					py = GetRawTouchCurrentY(idx)
					
				elseif GetRawMouseLeftPressed()
					
					pressed = true
					px = GetRawMouseX()
					py = GetRawMouseY()
					
				endif
				
			endif
				
		else 
						
			if count > 0 // Only check on second loop through.
			
				m2 = GetMilliseconds()
				
				if m2 - m >= RU_RUN_TIME
					
					// if ru.rt.debug then ruDebug(1, "ruExecuteThread: exceed max runtime=" + str(m2 - m) + ", idx=" + str(thread.idx))
					exit	 // Yield.			
					
				endif
				
			endif
			
		endif

		// if ru.rt.debug then ruDebug(1, "ruExecuteThread: top of thread while loop with idx=" + str(thread.idx))

		cmd = ma.things[thread.thingIdx].cmds[thread.idx]
		// if ru.rt.debug then ruDebug(1, "ruExecuteThread: cmd=" + maPrintCmd(cmd, ru.rt.debug))

		if ma.cmds[cmd].grp = GRP_BEGIN // ruIsEventCmd(cmd)

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found event cmd, at idx=" + str(thread.idx))			

			// Hit another event, stop now.
			thread.idx = ma.things[thread.thingIdx].cmds.length + 1
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: exiting loop with idx=" + str(thread.idx))			

			// Exit at event cmds.
			thread.turbo = false
			exit

		elseif ma.cmds[cmd].root // Hit another root, stop.

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found cmd root, at idx=" + str(thread.idx))			

			// Hit another event, stop now.
			thread.idx = ma.things[thread.thingIdx].cmds.length + 1
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: exiting loop with idx=" + str(thread.idx))			

			// Exit at root cmds.
			thread.turbo = false
			exit

		elseif ma.cmds[cmd].code = CODE_FLOW_REPEAT_END // ruIsLoopCloseCmd(cmd)

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found loop close at idx=" + str(thread.idx))

			// Hit the close loop, pop the open for next call.
			thread.prvIdx = thread.idx
			thread.idx = ruPeekStackIdx(thread, true)
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: pop stack. jumping to loop open at idx=" + str(thread.idx))

			// Exit because we yield at end of loop for other threads.
			if thread.turbo					
				if ruCheckTurboBreak(pressed, px, py) then exit
			else
				exit // Yield.		
			endif

		elseif ruIsLoopOpenCmd(cmd) // ma.cmds[cmd].code >= CODE_FLOW_REPEAT_TIMES and ma.cmds[cmd].code <= CODE_FLOW_REPEAT_WHILE

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found loop open at idx=" + str(thread.idx))

			// Hit a flow cmd with an end block. Mark it for looping.
			ruPushStackIdx(thread, thread.idx)
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: cmd is loop open, pushing stack, checking reset loop at idx=" + str(thread.idx))

			// If we didn't come from the loop close, then it's the first time here, reset the loop.
			if thread.prvIdx = thread.idx - 1

				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: reseting loop")
				ruResetLoopOpenCmd(thread, cmd)

			endif
			
			//eval = ruEvalCmdAsInt(thread, cmd)
			//eval = ruEvalCmdAsIntPtr(thread, ma.cmds[cmd])
			eval = ruEvalCmdAsFloatPtr(thread, ma.cmds[cmd])
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: loop eval=" + stR(eval))

			if not eval

				ruPeekStackIdx(thread, true) // Pop the stack to go back to loop open.
				thread.idx = ruFindThingCmdCode(thread.thingIdx, CODE_FLOW_REPEAT_END, thread.idx + 1)				
				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: loop eval = false, pop stack, jumping to loop end at idx=" + stR(thread.idx))

			endif

 			thread.prvIdx = thread.idx
			inc thread.idx
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: inc'ing loop end to next cmd, idx now=" + str(thread.idx))
			
		elseif ma.cmds[cmd].code = CODE_FLOW_EXIT_LOOP // ruIsCmd(cmd, CODE_FLOW_EXIT_LOOP)

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found exit close at idx=" + str(thread.idx))

			if thread.stack.length > -1 // Only run if within a loop.

				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: am within loop, finding end of loop.")

				ruPeekStackIdx(thread, true) // Pop the stack to go back to loop open.
				thread.idx = ruFindThingCmdCode(thread.thingIdx, CODE_FLOW_REPEAT_END, thread.idx + 1)				
				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found exit loop, pop stack, jumping to loop end at idx=" + stR(thread.idx))

				thread.prvIdx = thread.idx
				inc thread.idx
				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: inc'ing loop end to next cmd, idx now=" + str(thread.idx))

				if thread.turbo					
					if ruCheckTurboBreak(pressed, px, py) then exit
				else
					exit	 // Yield.			
				endif
				
			endif
			
		elseif ma.cmds[cmd].code = CODE_FLOW_SKIP_LOOP // ruIsCmd(cmd, CODE_FLOW_SKIP_LOOP)

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found skip loop at idx=" + str(thread.idx))

			if thread.stack.length > -1 // Only run if within a loop.

				// Hit the skip loop, like closing so pop the open for next call.
				thread.prvIdx = thread.idx
				thread.idx = ruPeekStackIdx(thread, true)
				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: pop stack. jumping to loop open at idx=" + str(thread.idx))

				// Exit because we yield at end of loop for other threads.
				if thread.turbo					
					if ruCheckTurboBreak(pressed, px, py) then exit
				else
					exit // Yield.			
				endif

			endif

		elseif ma.cmds[cmd].code = CODE_FLOW_IF // ruIsCmd(cmd, CODE_FLOW_IF)
		
			//eval = ruEvalCmdAsIntPtr(thread, ma.cmds[cmd])
			eval = ruEvalCmdAsFloatPtr(thread, ma.cmds[cmd])
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: if eval=" + str(eval))		

			if not eval

				thread.idx = ruFindThingCmdCode(thread.thingIdx, CODE_FLOW_ENDIF, thread.idx + 1)				
				if ru.rt.debug  > 1 then ruDebug(2, "ruExecuteThread: if eval = false, jumping to endif at idx=" + str(thread.idx))		

			endif

			thread.prvIdx = thread.idx
			inc thread.idx
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: inc'ing if to next cmd, idx now=" + str(thread.idx))

		elseif ma.cmds[cmd].code = CODE_FLOW_IF_ELSE // ruIsCmd(cmd, CODE_FLOW_IF_ELSE)

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found if at idx=" + str(thread.idx))
			//eval = ruEvalCmdAsIntPtr(thread, ma.cmds[cmd])
			eval = ruEvalCmdAsFloatPtr(thread, ma.cmds[cmd])
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: eval=" + str(eval))		

			if not eval

				thread.idx = ruFindThingCmdCode(thread.thingIdx, CODE_FLOW_ELSE, thread.idx + 1)				
				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: if eval = false, jumping to else at idx=" + str(thread.idx))		

			endif

			thread.prvIdx = thread.idx
			inc thread.idx
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: inc'ing if/else to next cmd, idx now=" + str(thread.idx))

		elseif ma.cmds[cmd].code = CODE_FLOW_ELSE // ruIsCmd(cmd, CODE_FLOW_ELSE) // Hit an else while executing the IF.

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found else, at end of if block at idx=" + str(thread.idx))
			thread.idx = ruFindThingCmdCode(thread.thingIdx, CODE_FLOW_ENDIF, thread.idx + 1)

			thread.prvIdx = thread.idx
			inc thread.idx			
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: inc'ing else to next cmd, idx now=" + str(thread.idx))

		elseif ma.cmds[cmd].code = CODE_FLOW_ENDIF // ruIsCmd(cmd, CODE_FLOW_ENDIF)

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found endif at idx=" + str(thread.idx))

			thread.prvIdx = thread.idx
			inc thread.idx
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: inc'ing endif to next cmd, idx now=" + str(thread.idx))

		else // If we fallthrough here, execute a cmd.

			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: found cmd, executing")
			yield = ruExecuteCmdPtr(thread, ma.cmds[cmd])

			thread.prvIdx = thread.idx
			inc thread.idx
			// if ru.rt.debug then ruDebug(2, "ruExecuteThread: inc'ing executed cmd to next cmd, idx now=" + str(thread.idx))

			if yield
				
				// if ru.rt.debug then ruDebug(2, "ruExecuteThread: command yielded, exiting loop with idx=" + str(thread.idx))

				// Exit for yielding.
				if thread.turbo and yield = 1 // If yield > 1, then still exit.				
					if ruCheckTurboBreak(pressed, px, py) then exit					
				else
					exit					
				endif

			endif
			
		endif
						
		inc count
	
	endwhile

	// if ru.rt.debug then ruDebug(1, "ruExecuteThread: exiting thread while loop with idx=" + str(Thread.idx))

	if not thread.active
		
		thread.idx = ma.things[thread.thingIdx].cmds.length + 1
		// if ru.rt.debug then ruDebug(1, "ruExecuteThread: last cmd deactivated this thread")			

	endif
		
	// Done.
	if thread.idx > ma.things[thread.thingIdx].cmds.length

		if thread.waitTime > 0 or thread.waitUntil > 0 or thread.waitSay > 0 or thread.waitChannels.length > -1 or thread.waitEvents.length > -1 or thread.waitInput or thread.waitVideo

			if not thread.active

				// if ru.rt.debug then ruDebug(1, "ruExecuteThread: thread was waiting, but needs to clean up.")
				ruClearWaitingThread(thread)
				
			else
				
				// if ru.rt.debug then ruDebug(1, "ruExecuteThread: thread is waiting (time, cound, event or video), keep it active.")

			endif
			
		else
			
			// if ru.rt.debug then ruDebug(1, "ruExecuteThread: deactivated")
			thread.active = false

		endif

	endif

	// if ru.rt.debug then ruDebugIndent(-1)
	// if ru.rt.debug then ruDebug(1, "ruExecuteThread() endfunction")
	
endfunction

//-----------------------------------------------------
// Check if a press occured. If so, check if it's a break.
//
function ruCheckTurboBreak(pressed as integer, x as float, y as float)
		
	local ret as integer

	if pressed // GetPointerPressed()
		
		if guiGetButtonPressed(ru.runBut, x, y, 1)
			
			ru.butId = ru.runBut.id 
			ret = true
			
		elseif guiGetButtonPressed(ru.backBut, x, y, 1)
			
			ru.butId = ru.backBut.id 
			ret = true	
			
		else 
			
			ret = false
			
		endif
		
	else 
		
		ret = false
		
	endif
		
endfunction ret

//-----------------------------------------------------
// Clean all wait... cmds.
//
function ruClearWaitingThread(thread ref as Thread)

	local i as integer
	
	if thread.waitChannels.length > -1 // Playing a sound until done.

		i = 0
		
		while i <= thread.waitChannels.length

			// Still playing?
			if GetSoundInstancePlaying(ru.rt.channels[thread.waitChannels[i]].playId)				

				StopSoundInstance(ru.rt.channels[thread.waitChannels[i]].playId)
				inc i
				
			endif
			
		endwhile

		thread.waitChannels.length = -1

	endif
		
	if thread.waitTime > 0
		thread.waitTime = 0
	endif

	if thread.waitUntil > 0
		thread.waitUntil = 0
	endif
	
	if thread.waitSay > 0
		ruClearPrintPtr(thread)		
	endif
		
	if thread.waitInput
			
		DeleteEditBox(ma.vars[thread.waitInput].rv.edit)
		ma.vars[thread.waitInput].rv.edit = 0
		thread.waitInput = 0
		thread.waitInputChange = false
			
	endif

	if thread.waitEvents.length > -1 // Waiting for an event thread to complete.

		thread.waitEvents.length = -1

	endif
		
	if thread.waitVideo

		if GetVideoPlaying()				

			StopVideo()
			thread.waitVideo = false
			
		endif

	endif

endfunction

//-----------------------------------------------------
// Find a cmd with code in a list in a thing.
// Uses the thread stack to ensure we get the correct match.
// idx is the start point in the list.
//
function ruFindThingCmdCode(thing as integer, code as integer, idx as integer)

	local i as integer
	local ret as integer
	local depth as integer
	local cmd as integer

	ret = -1
	depth = 0

	// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode(thing=" + str(thing) + ", code=" + hex(code) + ", idx=" + stR(idx) + ")")
	// if ru.rt.debug then ruDebugIndent(1)
	
	for i = idx to ma.things[thing].cmds.length

		cmd = ma.things[thing].cmds[i]
		// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: cmd=" + stR(cmd) + ", code=" + hex(ma.cmds[cmd].code))
		
		if code = CODE_FLOW_REPEAT_END

			// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: looking for repeat end")				

			if ma.cmds[cmd].code >= CODE_FLOW_REPEAT_TIMES and ma.cmds[cmd].code <= CODE_FLOW_REPEAT_WHILE // ruIsLoopOpenCmd(cmd)

				inc depth
				// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: loop open, inc depth")				

			elseif ma.cmds[cmd].code = CODE_FLOW_REPEAT_END

				if depth > 0
					
					dec depth
					// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: loop close, dec depth")				
					
				else

					ret = i
					// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: found matching loop end at idx=" + str(ret))
					exit

				endif
				
			endif

		elseif code = CODE_FLOW_ELSE

			// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: looking for else")				

			if ma.cmds[cmd].code = CODE_FLOW_IF // Sub if.

				inc depth
				// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: if, inc depth")				

			elseif ma.cmds[cmd].code = CODE_FLOW_ENDIF // Sub endif.

				dec depth
				// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: endif, dec depth")				

				if depth < 0 // Hit an endif before else, so there is no else.

					ret = i
					// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: hit endif before else at idx=" + str(ret))
					exit
					
				endif
				
			elseif ma.cmds[cmd].code = CODE_FLOW_ELSE

				// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: else")				

				if depth = 0
										
					ret = i
					// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: found matching else at idx=" + str(ret))
					exit

				else

					// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: skipped")

				endif
				
				
			endif

		elseif code = CODE_FLOW_ENDIF

			// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: looking for endif")				

			if ma.cmds[cmd].code = CODE_FLOW_IF // Sub if.

				inc depth
				// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: if, inc depth")				
				
			elseif ma.cmds[cmd].code = CODE_FLOW_ENDIF // Sub endif.

				if depth > 0

					dec depth
					// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode: endif, dec depth")				
					
				else
					
					ret = i
					// if ru.rt.debug then ruDebug(2, "ruFindThingCmdCode: found matching endif at idx=" + str(ret))
					exit

				endif

			endif

		endif
		
	next

	// if ru.rt.debug then ruDebugIndent(-1)
	// if ru.rt.debug then ruDebug(3, "ruFindThingCmdCode, returning ret=" + str(ret))
	
endfunction ret

//-----------------------------------------------------
// Return true if the cmd is an event.
//
function ruIsEventCmd(cmd as integer)

	local ret as integer

	if ma.cmds[cmd].grp = GRP_BEGIN
		exitfunction true // ret = true
	//else
	//	ret = false
	endif

endfunction false // ret

//-----------------------------------------------------
// Reset the counters on the loop.
//
function ruResetLoopOpenCmd(thread ref as Thread, cmd as integer)

	local ret as integer
	
	select ma.cmds[cmd].code

		case CODE_FLOW_REPEAT_TIMES

			// Need to clear the var so we get the original value of the part.
			ruDeleteThreadPartVar(thread, ma.cmds[cmd].parts[1])			
			ret = ruEvalPartAsInt(thread, ma.cmds[cmd].parts[1])			
			//ret = cdGetPartAsInt(ma.cmds[cmd].parts[1])
			ruSetPartAsInt(thread, ma.cmds[cmd].parts[1], ret)

		endcase

	endselect

endfunction

//-----------------------------------------------------
// Return true if the cmd is a loop opener.
//
function ruIsLoopOpenCmd(cmd as integer)

	local ret as integer

	//ret = false

	select ma.cmds[cmd].code

		case CODE_FLOW_REPEAT_TIMES
			ret = true
		endcase

		case CODE_FLOW_REPEAT_FOREVER
			ret = true
		endcase

		case CODE_FLOW_REPEAT_UNTIL
			ret = true
		endcase

		case CODE_FLOW_REPEAT_WHILE
			ret = true
		endcase
		
		case default
			ret = false
		endcase
		
	endselect
	
endfunction ret

//-----------------------------------------------------
// Return true if the cmd is a loop closer.
//
function ruIsLoopCloseCmd(cmd as integer)

	//local ret as integer

	if ma.cmds[cmd].code = CODE_FLOW_REPEAT_END
		exitfunction true //ret = true
	//else
		//ret = false
	endif
	
endfunction false // ret

//-----------------------------------------------------
// Return true if the cmd the same as code passed.
//
function ruIsCmd(cmd as integer, code as integer)

	//local ret as integer

	if ma.cmds[cmd].code = code
		exitfunction true // ret = true
	//else
	//	ret = false
	endif

endfunction false // ret

//-----------------------------------------------------
// Push a loop open onto the stack.
//
function ruPushStackIdx(thread ref as Thread, idx as integer)

	if thread.stack.length > -1
		thread.stack.insert(idx, 0)
	else
		thread.stack.insert(idx)
	endif

endfunction

//-----------------------------------------------------
// Pop or peek a stack idx.
//
function ruPeekStackIdx(thread ref as Thread, pop as integer)

	local idx as integer
	
	if thread.stack.length > -1
		
		idx = thread.stack[0]

		if pop
			thread.stack.remove(0)
		endif

	else

		idx = -1
		
	endif
	
endfunction idx

//-----------------------------------------------------
// 
function ruPressed(x as float, y as float)

	local thing as integer
	local var as integer

	if ru.pressed
		exitfunction
	endif
	
	ru.pressed = true
	
	if guiGetButtonPressed(ru.runBut, x, y, 1)

		ru.butId = ru.runBut.id 

	elseif guiGetButtonPressed(ru.backBut, x, y, 1)

		ru.butId = ru.backBut.id 

	elseif guiGetButtonPressed(ru.moreBut, x, y, 1)

		ru.butId = ru.moreBut.id
		guiPopupBar(ru.moreBar, getspritex(ru.moreBut.bg), getspritey(ru.moreBut.bg), getspritewidth(ru.moreBut.bg), getspriteheight(ru.moreBut.bg))
		
	elseif ru.executing

		ru.butId = -1

		if not ruCheckVideoPanel(x, y)
			
			//ru.rt.ptrPressed = true
			ruActivateEvent(-1, CODE_EVENT_PTR_PRESSED)

			thing = ruFindThing(x, y)
	
			if thing > -1
	
				ru.rt.thingPressed = thing
				ruActivateEvent(thing, CODE_EVENT_SPRITE_PRESSED)
							
			else
	
				var = ruFindVar(x, y)
				
				if var > -1
					
					ru.rt.varPressed = var
					ruActivateEvent(-1, CODE_EVENT_VAR_PRESSED)
		
				endif		
	
			endif
					
		endif		
		
	endif

endfunction

//-----------------------------------------------------
// Search for a thing based on the pressed location and depth.
// -1 if not over a thing.
//
function ruFindThing(x as float, y as float)

	local idx as integer
	local i as integer
	local thingIdx as integer

	idx = -1

	//for i = 0 to ru.rt.depths.length
	for i = 0 to ru.rt.threads.length

		thingIdx = ru.rt.threads[i].thingIdx
		
		//if ru.rt.depths[i].idx > -1
		if thingIdx > -1

			// This could lead to bugs.
			//if ma.things[ru.rt.depths[i].idx].isBg and ma.things[ru.rt.depths[i].idx].doPress

			//	idx = ru.rt.depths[i].idx
			//	exit
				
			//elseif GetspriteHitTest(getsprite(ma.things[ru.rt.depths[i].idx].obj), x, y)
			//if GetspriteHitTest(getsprite(ma.things[ru.rt.depths[i].idx].obj), x, y)
			if GetspriteHitTest(getsprite(ma.things[thingIdx].obj), x, y)

				//idx = ru.rt.depths[i].idx
				idx = thingIdx
				exit
				
			endif

		endif
		
	next

endfunction idx

//-----------------------------------------------------
// Search for a VAR based on the pressed location and depth.
// -1 if not over a VAR.
//
function ruFindVar(x as float, y as float)

	local i as integer
	local j as integer
	local spr as integer
	local idx as integer
	local varIdx as integer
	local thingIdx as integer
	local cmd as integer

	idx = -1
	
	for i = 0 to ru.rt.vardepths.length

		varIdx = ru.rt.vardepths[i].idx

		if ma.vars[varIdx].rv.bg

			if coPointWithinRect(x, y, getspritex(ma.vars[varIdx].rv.bg), getspritey(ma.vars[varIdx].rv.bg), GetSpriteWidth(ma.vars[varIdx].rv.bg), GetSpriteHeight(ma.vars[varIdx].rv.bg))
				
				idx = varIdx
				exit
				
			endif
			
		endif
					
	next
	
endfunction idx

//-----------------------------------------------------
// 
function ruDown(x as float, y as float)

	local thing as integer
	
	if ru.butId = -1 and ru.executing
		
		//if ru.rt.ptrPressed
		if ru.rt.ptrDown
			ruActivateEvent(-1, CODE_EVENT_PTR_DOWN)
		endif

		//if ru.rt.thingPressed > -1
		//	ruActivateEvent(ru.rt.thingPressed, CODE_EVENT_SPRITE_DOWN)			
		//endif
		
	elseif ru.butId = BUT_RUNNER_MORE

		guiCheckBarPressed(ru.moreBar, in.ptrX, in.ptrY, 1)

	endif
	
endfunction

//-----------------------------------------------------
// 
function ruReleased(x as float, y as float)

	local thing as integer
	local butId as integer
	local var as integer
	local i as integer

	if ru.butId > -1

		butId = ru.butId
		ru.butId = -1
		
		if butId = BUT_RUNNER_STOP

			ruStop()
			
		elseif butId = BUT_RUNNER_RUN

			ruRun()

		elseif butId = BUT_RUNNER_MORE
			
			butId = guiCheckBarReleased(ru.moreBar, x, y, 1)
			guiHideBar(ru.moreBar)
			
			ruButtonAction(butId, 0)
				
		else
				
			OnButtonAction(butId, 0)
			
		endif

	elseif ru.executing

		if ru.rt.ptrReleased

			ruActivateEvent(-1, CODE_EVENT_PTR_RELEASED)

			if ru.rt.thingPressed > -1
	
				thing = ru.rt.thingPressed
				ru.rt.thingPressed = -1
				ruActivateEvent(thing, CODE_EVENT_SPRITE_RELEASED)
				
			elseif ru.rt.varPressed
	
				thing = ru.rt.varPressed
				ru.rt.varPressed = 0
				ruActivateEvent(thing, CODE_EVENT_VAR_RELEASED)
	
			endif

/*
			thing = ruFindThing(in.ptrX, in.ptrY)
			// if ru.rt.debug then ruDebug(1, "EventReleased, thing=" + str(thing))
	
			if thing > -1
	
				ruActivateEvent(thing, CODE_EVENT_SPRITE_RELEASED)
				
			else
	
				var = ruFindVar(in.ptrX, in.ptrY)
	
				if var > -1				
					ruActivateEvent(thing, CODE_EVENT_VAR_RELEASED)
				endif
	
			endif
*/
		
		endif

	endif

	ru.pressed = false
	
endfunction

//-----------------------------------------------------
// Do an update loop.
//
function ruUpdate(delta as float)

	ru.rt.ptrPressed = in.ptrPressed
	ru.rt.ptrDown = in.ptrDown
	ru.rt.ptrReleased = in.ptrReleased

	if in.ptrPressed

		ruPressed(in.ptrX, in.ptrY)

	elseif in.ptrDown

		ruDown(in.ptrX, in.ptrY)			
		
	elseif in.ptrReleased

		ruReleased(in.ptrX, in.ptrY)
			
	endif

	if ru.butId = -1 and ru.executing
		ruUpdateAllObjects(delta)
	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetTimer(thingIdx as integer, timeFrame as float)
	
	ma.things[thingIdx].timer01 = timeFrame
	
endfunction

//-----------------------------------------------------
// Called every frame. 
//
function ruUpdateAllObjects(delta as float)
	
	local i as integer
	local j as integer
	local ln as integer
	local idx as integer
	local activeThreads as integer
	local prevThingIdx as integer
	local thingIdx as integer
	local depth as integer
	local skipped as integer
	local deletedThings as integer[]
	local sprLn as integer
	local penLn as integer
	
	// if ru.rt.debug then ruDebug(2, "ruUpdateAllObjects(depths.length=" + str(ru.rt.depths.length) + ")")
	
	ruApplyThreadDepths(false)
	
	activeThreads = 0
	prevThingIdx = -1
	depth = THING_DEPTH_BASE
	skipped = 0
	deletedThings.length = -1
	sprLn = -1
	penLn = -1

/*
	if AGK_BUILD // Do this here to make sure the thread depth is correct above.
		
		agAgkBuild(ru.appIdx)
		ruStop()
		maHide()
		ma.view = ma.prevView
		maShow()
		exitfunction
		
	endif
*/

	ln = ru.rt.threads.length
	
	for i = 0 to ln // Make sure we only update thread as of this loop, i.e. not clones yet.
				
		thingIdx = ru.rt.threads[i].thingIdx

		if not ru.rt.threads[i].deleted //and not ma.things[thingIdx].deleted
		
			if thingIdx <> prevThingIdx // New thingIdx, process it once.

				if not ma.things[thingIdx].deleted
			
					depth = depth + ru.rt.depthDiv
					SetDepth(ma.things[thingIdx].obj, depth)
					guiSetTipDepth(ma.things[thingIdx].tip, depth)
					
				endif
/*
				if ma.things[thingIdx].timer01 > 0.0
				 
					dec ma.things[thingIdx].timer01, delta
					
					if ma.things[thingIdx].timer01 <= 0.0
			
						// Run all explicit event timer blocks. Restart if necessary.
						ruActivateEvent(thingIdx, CODE_EVENT_TIMER)
			
					endif
					
				endif
*/
					
				if ru.rt.videoIdx > -1
							
					if ru.rt.videoPanel.vis
						if GetVideoPlaying()
							// if ru.rt.debug then ruDebug(3, "ruExecuteEvent: video is playing, update times")
							ruShowVideoTimes()
						endif
					endif
			
				endif
				
			endif
	
			ru.rt.threads[i].depth = depth

			if ruUpdateThread(ru.rt.threads[i], delta)
				inc activeThreads
			endif
		
		else 
			
			inc skipped
			
		endif
		
		prevThingIdx = thingIdx
		
	next

	// Draw stamps and pens.
	
	prevThingIdx = -1
	
	for i = 0 to ln // Make sure we only update thread as of this loop, i.e. not clones yet.
				
		thingIdx = ru.rt.threads[i].thingIdx

		if not ru.rt.threads[i].deleted //and not ma.things[thingIdx].deleted
		
			if thingIdx <> prevThingIdx // New thingIdx, process it onces.

				if not ma.things[thingIdx].deleted
									
					if ma.things[thingIdx].drawSprs.length > -1
																
						ruDrawSprites(ma.things[thingIdx].obj, ma.things[thingIdx].drawSprs)
						//drawsprite(ma.things[thingIdx].obj) // Make sure the sprite is above.
						
					endif
			
					if ma.things[thingIdx].pen.pts.length > -1
														
						ruDrawPen(ma.things[thingIdx].pen)
						//drawsprite(ma.things[thingIdx].obj) // Make sure the sprite is above the pen.
	
					endif
					
				endif
				
			endif
			
		endif

		prevThingIdx = thingIdx
		
	next

	// Clean up event received threads.
	i = 0

	while i <= ln // ru.rt.threads.length

		// Thread should be 'event received', inactive and not the master thread,
		// which never gets executed, but is used to clone sub threads (with caller > 0).
		
		if (ru.rt.threads[i].event = CODE_EVENT_RECEIVED or ru.rt.threads[i].event = CODE_EVENT_BLOCK) and not ru.rt.threads[i].active and ru.rt.threads[i].caller > 0

			// if ru.rt.debug then ruDebug(3, "ruExecuteEvent: thread[" + str(i) + "].id=" + str(ru.rt.threads[i].id) + ": found inactive EVENT_RECEIVED cmd, cleaning up")

			// Find the calling thread, i.e. the one waiting on a send event [] until done.
			idx = ruFindThreadById(ru.rt.threads[i].caller)

			if idx > -1
				
				for j = 0 to ru.rt.threads[idx].waitEvents.length
					
					if ru.rt.threads[idx].waitEvents[j] = ru.rt.threads[i].id

						// if ru.rt.debug then ruDebug(3, "ruExecuteEvent: thread[" + str(i) + "].id=" + str(ru.rt.threads[i].id) + ": removing EVENT_RECEIVED from calling thread")
						ru.rt.threads[idx].waitEvents.remove(j)
						exit
						
					endif
					
				next

			endif
			
			// if ru.rt.debug then ruDebug(3, "ruExecuteEvent: thread[" + str(i) + "].id=" + str(ru.rt.threads[i].id) + ": removing thread")
			ruDeleteThread(ru.rt.threads[i])	
			ru.rt.threads.remove(i)
			dec ln

		//elseif ma.things[ru.rt.threads[i].thingIdx].deleted // ru.rt.threads[i].deleted
		elseif ru.rt.threads[i].deleted
			
			ruDeleteThread(ru.rt.threads[i])	
			deletedThings.insert(ru.rt.threads[i].thingIdx)
			ru.rt.threads.remove(i)
			dec ln

		else

			inc i
			
		endif

	endwhile

	//colog("ln=" + str(ln) + ", skipped=" + str(skipped) + ", deleted.len=" + str(deletedThings.length))
	
	// Finally, remove deleted things.
	if deletedThings.length > -1
		
		deletedThings.sort() // Ensure the thingIdx are in order.
		
		prevThingIdx = -1
		
		for i = 0 to deletedThings.length
			
			if deletedThings[i] <> prevThingIdx
				
				ruRemoveThing(deletedThings[i])
				maDeleteThing(deletedThings[i])

				dec ru.rt.thingCount
				ru.rt.depthDiv = co.depthRange / (ru.rt.thingCount + 1)
				ru.rt.sortThreads = true

			endif
			
			prevThingIdx = deletedThings[i]
			
		next 
		
		deletedThings.length = -1
		
	endif
	
	// No threads active.
	if activeThreads = 0 // Need to use count here, not active threads to make sure we complete the last cmds.
		ruStop()		
	else
		ruCheckAllCollisions() // For next loop.
	endif

	if ru.executing = RU_RESUME
		ru.executing = RU_RUN
	endif
 
endfunction

//-----------------------------------------------------
//
function ruDrawSprites(spr as integer, drawSprs ref as DrawSpr[])
	
	local ln as integer
	local i as integer
	
	ln = drawSprs.length
	
	for i = 0 to ln
		
		if drawSprs[i].vis
			
			SetSpritePositionByOffset(spr, drawSprs[i].x, drawSprs[i].y)
			SetSpriteScale(spr, drawSprs[i].sx, drawSprs[i].sy)
			SetSpriteAngle(spr, drawSprs[i].ang)
			coSetSpriteColor(spr, drawSprs[i].col)
			drawsprite(spr)
			
		endif
		
	next 
					
endfunction

//-----------------------------------------------------
//
function ruDrawPen(pen ref as Pen)

	local ln as integer
	local i as integer
	
	ln = pen.pts.length

	if not pen.spr
		pen.spr = createsprite(co.pixImg)
	endif
	
	for i = 0 to ln
		ruDrawPenPoint(pen, pen.pts[i])
	next 
	
endfunction

//-----------------------------------------------------
//
function ruDrawPenPoint(pen ref as Pen, pp ref as PenPoint)
		
	local i as integer
	
	SetSpriteDepth(pen.spr, pp.depth + 1)
	
	// Add 1 to size, because a single line is too thin. Turned off now.
	coDrawFakeSprLine2(pen.spr, pp.x0, pp.y0, pp.x1, pp.y1, pp.col, pp.size, pp.style)
		
endfunction

//-----------------------------------------------------
//
function ruUpdateThread(thread ref as Thread, delta as float)
		
	local thingIdx as integer
	local idx as integer
	local cmd as integer
	local edges as string
	local matchCollEdges as integer
	local actualCollEdges as integer
	local ln as integer
	local active as integer
	local time as integer
	
	thingIdx = thread.thingIdx
	
	// If doing a full event sweep, check for coll edge.
	if not thread.active

		if thread.event = CODE_EVENT_COLL_ANY_EDGE

			// if ru.rt.debug then ruDebug(3, "ruExecuteEvent: thread[" + str(i) + "].id=" + str(ru.rt.threads[i].id) + ": checking edge coll")

			actualCollEdges = ruCheckCollidedEdge(thread, DIR_ALL)

			if actualCollEdges > 0
				
				thread.active = true
				thread.reset = true
				//inc activeThreads
				
				// if ru.rt.debug then ruDebug(3, "ruExecuteEvent: thread[" + str(i) + "].id=" + str(ru.rt.threads[i].id) + ": edge coll found, activing event")

			endif				

		elseif thread.event = CODE_EVENT_COLL_EDGE

			// if ru.rt.debug then ruDebug(3, "ruExecuteEvent: thread[" + str(i) + "].id=" + str(ru.rt.threads[i].id) + ": checking edge coll")

			cmd = ma.things[thingIdx].cmds[thread.thingEventCmdIdx]
			edges = cdGetPartAsString(ma.cmds[cmd].parts[1])
			matchCollEdges = ruGetCollEdgeValue(edges)

			actualCollEdges = ruCheckCollidedEdge(thread, matchCollEdges)

			if actualCollEdges > 0
				
				thread.active = true
				thread.reset = true
				//inc activeThreads
				
				// if ru.rt.debug then ruDebug(3, "ruExecuteEvent: thread[" + str(i) + "].id=" + str(ru.rt.threads[i].id) + ": edge coll found, activing event")

			endif
			
		elseif thread.event = CODE_EVENT_TIMER
			
			cmd = ma.things[thingIdx].cmds[thread.thingEventCmdIdx]
			time = cdGetPartAsInt(ma.cmds[cmd].parts[1])
						
			if not thread.blockTimer and time > 0 and ruGetTimer() >= time
				
				thread.blockTimer = true // Only run once.
				thread.active = true
				thread.reset = true
				
			endif
			
		//elseif thread.event = CODE_EVENT_UPDATE
			
		//	thread.active = true
		//	thread.reset = true						
						
		endif
		
	endif
	
	if thread.active

		active = true
		ruExecuteThread(thread)			

		//if ru.rt.threads[idx].active
		//	inc activeThreads
		//endif

	endif		
	
	if thread.active
		
		If ma.things[thingIdx].wrapX Then ruWrapScreenX(thingIdx)
		If ma.things[thingIdx].wrapY Then ruWrapScreenY(thingIdx)

	endif
	
endfunction active // Return the previous active state.

/*
//-----------------------------------------------------
//
function ruOLDCheckAllCollisions()

	local oc as integer
	local i as integer
	local j as integer
	local colGrp as integer
	local cgL as integer
	local thingIdx as integer
	local otherThingIdx as integer
	//local collThingIdx as integer
	local collThingIdxs as integer[]

	ruClearCollisions()

	//oc = ru.rt.depths.length
	oc = ru.rt.threads.length
	//collThingIdx = -1
	collThingIdxs.length = -1
	
	for i = 0 to oc

		//thingIdx = ru.rt.depths[i].idx
		thingIdx = ru.rt.threads[i].thingIdx
		
		//if ma.things[thingIdx].obj
		if ma.things[thingIdx].obj and not ma.things[thingIdx].collChecked
			
			ma.things[thingIdx].collChecked = true // Avoid multiple checks due to multiple threads.
			
			if getcolgroup(ma.things[thingIdx].obj) and GetspriteActive(ma.things[thingIdx].obj)
				
				if ma.things[thingIdx].doCollision
					
					cgL = ma.things[thingIdx].colWith.length
					
					for colGrp = 0 to cgl
						
						for j = 0 to oc

							//otherThingIdx = ru.rt.depths[j].idx
							otherThingIdx = ru.rt.threads[j].thingIdx
//xx check that colgroup is set correctly on clones
							if getcolgroup(ma.things[otherThingIdx].obj) = ma.things[thingIdx].colWith[colGrp]
								
								if GetSpriteCollision(ma.things[thingIdx].obj, ma.things[otherThingIdx].obj)
									
									//ruOnObjCollision(thingIdx, otherThingIdx)
									//collThingIdx = thingIdx // Save for check below.
									collThingIdxs.insert(otherThingIdx) // Remember the colls.
									
								endif
								
							endif

						next
						
					next
					
				endif

			endif
			
		endif
		
		//if collThingIdx = thingIdx
		//	ruApplyCollision(ru.rt.threads[i], otherThingIdx)
		//endif
		
		if collThingIdxs.length > -1
			for j = 0 to collThingIdxs.length
				ruApplyCollision(ru.rt.threads[i], collThingIdxs[j])
			next
		endif
		
	next
 
endfunction
*/

//-----------------------------------------------------
//
function ruCheckAllCollisions()

	local oc as integer
	local ot as integer
	local i as integer
	local j as integer
	local thingIdx as integer
	local otherThingIdx as integer
	local check as integer

	ruClearCollisions()

	oc = ru.rt.threads.length // Need to go through threads, because clones are not in app.sprite list.

	for i = 0 to oc

		thingIdx = ru.rt.threads[i].thingIdx
		
		if not ma.things[thingIdx].collChecked // Check each sprite only once.

			ma.things[thingIdx].collChecked = true
			
			//if ma.things[thingIdx].clonedIdx = -1 or ma.things[thingIdx].doCollision // Fire if a sprite, or a clone with 'can hit set'.
			if ma.things[thingIdx].doCollision // Fire if a sprite, or a clone with 'can hit set'.
				
				if GetSpriteVisible(ma.things[thingIdx].obj)														

					for j = 0 to oc
					
						otherThingIdx = ru.rt.threads[j].thingIdx
	
						if otherThingIdx <> thingIdx
							//if ma.things[otherThingIdx].clonedIdx = -1 or ma.things[otherThingIdx].doCollision // Fire if a sprite, or a clone with 'can hit set'.
							if ma.things[otherThingIdx].doCollision // Fire if a sprite, or a clone with 'can hit set'.
								if GetSpriteVisible(ma.things[otherThingIdx].obj)
									if GetSpriteCollision(ma.things[thingIdx].obj, ma.things[otherThingIdx].obj)																
										if ma.things[thingIdx].collThings.find(otherThingIdx) = -1
											ma.things[thingIdx].collThings.insertsorted(otherThingIdx)
										endif
										//colog("thingIdx=" + str(thingIdx) + ", clonedIdx=" + stR(ma.things[thingIdx].clonedIdx) + ", collided with " + str(otherThingIdx))							
									endif
								endif
							endif
						endif
						
					next

				endif
						
			endif
			
		endif
				
		if ma.things[thingIdx].collThings.length > -1
			ruApplyCollisionThreads(thingIdx)
		endif
		
	next
 
endfunction

/*
//-----------------------------------------------------
//
function ruCheckAllPhysicsCollisions()

	local oc as integer
	local i as integer
	local j as integer
	local colGrp as integer
	local cgL as integer
	local thingIdx as integer
	local otherThingIdx as integer
	//local collThingIdx as integer
	local collThingIdxs as integer[]

	ruClearCollisions()

	//collThingIdx = -1
	collThingIdxs.length = -1

	//oc = ru.rt.depths.length
	oc = ru.rt.threads.length
	
	for i = 0 to oc

		//thingIdx = ru.rt.depths[i].idx
		thingIdx = ru.rt.threads[i].thingIdx
		
		if ma.things[thingIdx].obj
			
			if GetspriteActive(ma.things[thingIdx].obj)
															
				for j = 0 to oc

					//otherThingIdx = ru.rt.depths[j].idx
					otherThingIdx = ru.rt.threads[j].thingIdx
					
					if otherThingIdx <> thingIdx

						if GetPhysicsCollision(ma.things[thingIdx].obj, ma.things[otherThingIdx].obj)
							
							//ruOnObjCollision(thingIdx, otherThingIdx)
							//collThingIdx = thingIdx // Save for check below.
							collThingIdxs.insert(otherThingIdx) // Remember the colls.
							
						endif
						
					endif

				next
	
			endif
			
		endif

		//if collThingIdx = thingIdx
		//	ruApplyCollision(ru.rt.threads[i], otherThingIdx)
		//endif

		if collThingIdxs.length > -1
			for j = 0 to collThingIdxs.length
				ruApplyCollision(ru.rt.threads[i], collThingIdxs[j])
			next
		endif
		
	next
 
endfunction
*/

//-----------------------------------------------------
//
function ruWrapScreenX(thingIdx as integer)
	
	local posX as integer
	local obj as integer

	obj = ma.things[thingIdx].obj
	posX = GetPosX(obj)

	// PS
	If ma.things[thingIdx].wrapX = 1
	
		if posX > ru.w - 1
			SetPosX(obj, posX - ru.w)
		endif
		if posX < 0
			SetPosX(obj, posX + ru.w)
		endif

	elseif ma.things[thingIdx].wrapX = 2

		if posX - GetWidth(obj) / 2 > ru.w - 1
			SetPosX(obj, posX - ru.w - GetWidth(obj))
		endif
		if posX + GetWidth(obj) / 2 < 0
			SetPosX(obj, posX + ru.w + GetWidth(obj))
		endif

	endif
	
endfunction

//-----------------------------------------------------
//
function ruWrapScreenY(thingIdx as integer)
	
	local posY as integer
	local obj as integer
	
	obj = ma.things[thingIdx].obj
	posY = getposy(obj)

	// PS
	If ma.things[thingIdx].wrapY = 1

		if posY > co.h
			SetPosY(obj, posY-co.h)
		endif
		if posY < 0
			SetPosY(obj, posY+co.h)
		endif

	elseif ma.things[thingIdx].wrapY = 2

		if posY - GetHeight(obj) / 2 > co.h
			SetPosY(obj, posY - co.h - GetHeight(obj))
		endif
		if posY + GetHeight(obj) / 2 < 0
			SetPosY(obj, posY + co.h + GetHeight(obj))
		endif

	endif
	
endfunction

//-----------------------------------------------------
// Clear all collision flags.
//
function ruClearCollisions()

	local i as integer
	
	for i = 0 to ru.rt.threads.length	
			
		ma.things[ru.rt.threads[i].thingIdx].collThings.length = -1
		ma.things[ru.rt.threads[i].thingIdx].collChecked = false
		
	next

endfunction

//-----------------------------------------------------
// Apply the collision logic for the thing.
// yhingIdx is what was hit.
//
function ruApplyCollisionThreads(thingIdx as integer)

	local i as integer
	local oc as integer

	oc = ru.rt.threads.length
		
	for i = 0 to oc		
		if ru.rt.threads[i].thingIdx = thingIdx
			ruApplyCollision(ru.rt.threads[i], ma.things[thingIdx].collThings)
		endif
	next 
	
endfunction

//-----------------------------------------------------
// Apply the collision logic for the thing thread.
// hitThingIdxs is what this thread's thing hit.
//
function ruApplyCollision(thread ref as Thread, hitThingIdxs ref as integer[])

	local cmd as integer
	local selThingIdx as integer
	local hitThingIdx as integer
	local coll as integer
	local i as integer
	local sorc as integer
	
	//if ma.things[thread.thingIdx].clonedIdx > -1
	//	sorc = 2
	//else 
	//	sorc = 1
	//endif
	
	sorc = 1
	
	if sorc = 1

		if thread.event = CODE_EVENT_COLL_ANY_THING
					
			thread.active = true
			thread.reset = true
			
		elseif thread.event = CODE_EVENT_COLL_THING

			cmd = ma.things[thread.thingIdx].cmds[thread.thingEventCmdIdx]
			
			if ma.cmds[cmd].parts[1].typ = PART_CMD
				
				cmd = cdGetPartAsInt(ma.cmds[cmd].parts[1])
				
				if cmd
					
					selThingIdx = maFindThingById(ru.appIdx, cdGetPartAsString(ma.cmds[cmd].parts[0]))
										
					for i = 0 to hitThingIdxs.length
						
						hitThingIdx = hitThingIdxs[i]
						
						if ma.things[hitThingIdx].clonedIdx > -1 // Hit a clone.

							if ma.things[hitThingIdx].clonedIdx = selThingIdx // Is the clone's parent the same as the sel sprite?
		
								thread.active = true
								thread.reset = true
								
							endif

						elseif hitThingIdx = selThingIdx // The hit sprite is a sprite, check against the sel sprite.
							
							thread.active = true
							thread.reset = true							
								
						endif	
												
					next
	
				endif
				
			endif
			
		endif
			
	elseif sorc = 2

		if thread.event = CODE_EVENT_COLL_ANY_CLONE
									
			thread.active = true
			thread.reset = true
			coll = true

		elseif thread.event = CODE_EVENT_COLL_CLONE

			cmd = ma.things[thread.thingIdx].cmds[thread.thingEventCmdIdx]
			
			if ma.cmds[cmd].parts[1].typ = PART_CMD
				
				cmd = cdGetPartAsInt(ma.cmds[cmd].parts[1])
				
				if cmd
					
					selThingIdx = maFindThingById(ru.appIdx, cdGetPartAsString(ma.cmds[cmd].parts[0]))
								
					for i = 0 to hitThingIdxs.length
						
						hitThingIdx = hitThingIdxs[i]
						
						if ma.things[hitThingIdx].clonedIdx > -1 // Hit a clone.

							if ma.things[hitThingIdx].clonedIdx = selThingIdx // Is the clone's parent the same as the sel sprite?
		
								thread.active = true
								thread.reset = true
								
							endif

						elseif hitThingIdx = selThingIdx // The hit sprite is a sprite, check against the sel sprite.
							
							thread.active = true
							thread.reset = true							
								
						endif	
												
					next
	
				endif
				
			endif
						
		endif
		
	endif

endfunction

//-----------------------------------------------------
// 
function ruDebug(level as integer, msg as string)

	if level < ru.rt.debug // if ru.rt.debug >= level

		//msg = left("          ", ru.rt.debugIndent * 2) + msg
		msg = coRepeatString("  ", ru.rt.debugIndent) + msg
		
		if ru.rt.logToFile
			WriteLine(ru.rt.logToFile, msg)
		else
			colog(msg)
		endif

	endif
	
endfunction

//-----------------------------------------------------
// 
function ruDebugIndent(count as integer)

	ru.rt.debugIndent = ru.rt.debugIndent + count

	if 0 >= ru.rt.debugIndent // ru.rt.debugIndent < 0
		ru.rt.debugIndent = 0
	endif
	
endfunction

//-----------------------------------------------------
// 
function ruErr(msg as string)

	message("ERROR:" + msg)
	
endfunction

//
//*****************************************************
// END RUNTIME and THREAD ENGINE.
//*****************************************************
//

//
//*****************************************************
// START EXECUTION and EVALUATION.
//*****************************************************
//

/*
//-----------------------------------------------------
// Evaluate a cmd as a bool.
//
function ruEvalCmdAsBool(thread ref as Thread, cmd as integer)

	local ret as integer
	
	ret = ruEvalCmdAsBoolPtr(thread, ma.cmds[cmd])

endfunction ret
*/

//-----------------------------------------------------
// Evaluate a cmd as a float.
//
function ruEvalCmdAsFloat(thread ref as Thread, cmd as integer)

	local ret as float
	
	ret = ruEvalCmdAsFloatPtr(thread, ma.cmds[cmd])

endfunction ret

//-----------------------------------------------------
// Evaluate a cmd as an int.
//
function ruEvalCmdAsInt(thread ref as Thread, cmd as integer)

	local ret as integer
	
	ret = ruEvalCmdAsIntPtr(thread, ma.cmds[cmd])

endfunction ret	

//-----------------------------------------------------
// Evaluate an if statement via cmd ptr.
//
function ruEvalCmdAsIntPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as integer

	ret = ruEvalCmdAsFloatPtr(thread, cmd)
		
endfunction ret

//-----------------------------------------------------
// Evaluate a cmd as a string.
//
function ruEvalCmdAsString(thread ref as Thread, cmd as integer)

	local ret as string
	
	ret = ruEvalCmdAsStringPtr(thread, ma.cmds[cmd])

endfunction ret

//-----------------------------------------------------
// Evaluate a part as a type.
//
function ruEvalPartAsBool(thread ref as Thread, part ref as Part)

	local ret as integer
	local v as integer
	
	v = ruEvalPartAsInt(thread, part)

	if v
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Evaluate a part as a type.
//
function ruEvalPartAsString(thread ref as Thread, part ref as Part)

	local ret as string
	local cmd as integer
	local f as float
	local varIdx as integer
	local partVar as integer

	if part.typ = PART_BOOL or part.typ = PART_INT or /*part.typ = PART_FLOAT or*/ part.typ = PART_TXT or part.typ = PART_STR or part.typ = PART_COL or part.typ = PART_OBJ

		partVar = ruGetThreadPartVar(thread, part)
		
		if partVar
			ret = ruGetVarAsString(ma.vars[partVar])
		else
			ret = cdGetPartAsString(part)
		endif

	elseif part.typ = PART_FLOAT 

		partVar = ruGetThreadPartVar(thread, part)
		
		if partVar
			ret = ruGetVarAsString(ma.vars[partVar])
		else
			ret = cdGetPartAsString(part)
		endif
		
		if coIsValidNbr(ret, true, true)
			ret = coTrimFloatStr(ret)
		endif
		
	elseif part.typ = PART_VAR_NAME

		varIdx = cdGetPartAsInt(part)
		ret = ma.vars[varIdx].name

	elseif part.typ = PART_FRAME

		ret = cdGetPartAsString(part)

	elseif part.typ = PART_VALUE

		varIdx = cdGetPartAsInt(part)
		ret = ruGetVarAsString(ma.vars[varIdx])

	elseif part.typ = PART_LIST

		varIdx = cdGetPartAsInt(part)
		ret = ruGetVarAsString(ma.vars[varIdx])

	elseif part.typ = PART_CMD
		
		cmd = cdGetPartAsInt(part)

		if ma.cmds[cmd].code = CODE_VAR_GET

			ret = ruEvalCmdAsString(thread, cmd)

		elseif ma.cmds[cmd].typ && CMD_OSTR

			ret = ruEvalCmdAsString(thread, cmd)

		elseif ma.cmds[cmd].typ && CMD_OPER

			f = ruEvalCmdAsFloat(thread, cmd)
			ret = str(f)

			if coIsValidNbr(ret, true, true)
				ret = coTrimFloatStr(ret)
			endif
			
		endif

	else

		ret = ""
				
	endif
	
endfunction ret

//-----------------------------------------------------
// Evaluate a part as a type.
//
function ruEvalPartAsInt(thread ref as Thread, part ref as Part)

	local ret as integer

	ret = ruEvalPartAsFloat(thread, part)

endfunction ret

//-----------------------------------------------------
// Evaluate a part as a type.
//
function ruEvalPartAsFloat(thread ref as Thread, part ref as Part)

	local ret as float
	local cmd as integer
	local var as integer
	
	if part.typ = PART_BOOL or part.typ = PART_INT or part.typ = PART_FLOAT or part.typ = PART_TXT or part.typ = PART_STR
		
		var = ruGetThreadPartVar(thread, part)

		if var			
			ret = ruGetVarAsNbr(ma.vars[var])			
		else			
			ret = cdGetPartAsFloat(part)			
		endif
		
	elseif part.typ = PART_SPRITE

		ret = cdGetPartAsInt(part)

	elseif part.typ = PART_CMD

		cmd = cdGetPartAsInt(part)
		ret = ruEvalCmdAsFloat(thread, cmd)

	else
		
		ret = 0.0
				
	endif

endfunction ret

//-----------------------------------------------------
// Evaluate a part as a list.
// If the part is a list, returns the varIdx.
// If the part is a list, and 'copyList' is true, makes a copy of the list as a thread var.
//
function ruEvalPartAsList(thread ref as Thread, part ref as Part, copyList as integer)

	local ret as string
	local cmd as integer
	local varIdx as integer
	local varItem as VarItem
	local tmpIdx as integer
	local partVar as integer

	varIdx = 0
	
	if part.typ <= PART_TXT // part.typ = PART_BOOL or part.typ = PART_INT or part.typ = PART_FLOAT or part.typ = PART_TXT or part.typ = PART_STR
		
		partVar = ruGetThreadPartVar(thread, part)

		if partVar
			
			ret = ruGetVarAsString(ma.vars[partVar])

			varIdx = ruCreateThreadVar(thread, VAR_TYPE_LIST)
			varItem.name = ""
			varItem.value = ret
			varItem.parent = varIdx
			varItem.cmd = 0
			ma.vars[varIdx].runList.insert(varItem)

		endif

	elseif part.typ = PART_CMD

		cmd = cdGetPartAsInt(part)
		varIdx = ruEvalCmdAsListPtr(thread, ma.cmds[cmd], copyList)
		
	endif

endfunction varIdx

//-----------------------------------------------------
// Set the int value of a var.
//
function ruSetPartAsInt(thread ref as Thread, part ref as Part, iNbr as integer)

	ruSetPartAsFloat(thread, part, iNbr)
	
endfunction

//-----------------------------------------------------
// Set the float value of a var.
//
function ruSetPartAsFloat(thread ref as Thread, part ref as Part, fNbr as float)

	local var as integer

	var = ruGetThreadPartVar(thread, part)
	
	if not var
		var = ruCreateThreadPartVar(thread, part, VAR_TYPE_VALUE)
	endif
	
	ruSetVarAsNbr(ma.vars[var], fNbr)

endfunction

//-----------------------------------------------------
// Create a var for this thread and part.
//
function ruCreateThreadPartVar(thread ref as Thread, part ref as Part, typ as integer)

	local partVar as PartVar
	
	partVar.partIdx = part.idx 
	partVar.varIdx = maCreateVar(typ)
	thread.partVars.insert(partVar)

endfunction partVar.varIdx

//-----------------------------------------------------
// Get a var from a thread for this part.
//
function ruGetThreadPartVar(thread ref as Thread, part ref as Part)

	local i as integer
	local var as integer

	var = 0
	
	for i = 0 to thread.partVars.length

		if thread.partVars[i].partIdx = part.idx
			
			var = thread.partVars[i].varIdx
			exit
			
		endif
		
	next
	
endfunction var

//-----------------------------------------------------
// Delete a thread part var.
//
function ruDeleteThreadPartVar(thread ref as Thread, part ref as Part)

	local i as integer
	local var as integer
	
	for i = 0 to thread.partVars.length

		if thread.partVars[i].partIdx = part.idx

			var = thread.partVars[i].varIdx
			thread.partVars.remove(i)
			cdDeleteVar(var)
			exit

		endif
		
	next

endfunction var

//-----------------------------------------------------
// Create a thread var.
//
function ruCreateThreadVar(thread ref as Thread, typ as integer)

	local var as integer
	
	var = maCreateVar(typ)			
	thread.tmpVars.insert(var)

endfunction var

//-----------------------------------------------------
// Create a thread var.
//
function ruDeleteThreadVar(thread ref as Thread, var as integer)

	local i as integer
	
	for i = 0 to thread.tmpVars.length

		if thread.tmpVars[i] = var

			thread.tmpVars.remove(i)
			cdDeleteVar(var)
			exit

		endif
		
	next

endfunction var

//-----------------------------------------------------
// Get a thread var.
//
function ruGetThreadVar(thread ref as Thread, name as string)

	local idx as integer
	local i as integer

	idx = -1

	for i = 0 to thread.tmpVars.length

		if ma.vars[thread.tmpVars[i]].name = name
			
			idx = i
			exit

		endif
			
	next

endfunction idx

//-----------------------------------------------------
// Find a thread var.
//
function ruFindThreadVar(vars ref as integer[], var as integer)

	local found as integer
	local i as integer

	found = false

	for i = 0 to vars.length

		if vars[i] = var
			
			found = true
			exit

		endif
			
	next

endfunction found

//-----------------------------------------------------
// Create an app var.
//
function ruCreateRuntimeVar(typ as integer)

	local var as integer
	
	var = maCreateVar(typ)			
	ru.rt.vars.insert(var)

endfunction var

//-----------------------------------------------------
// Get a runtime var.
//
function ruGetRuntimeVar(name as string)

	local idx as integer
	local i as integer

	idx = -1

	for i = 0 to ru.rt.vars.length

		if ma.vars[ru.rt.vars[i]].name = name
			
			idx = i
			exit

		endif
			
	next

endfunction idx

//-----------------------------------------------------
// Find a runtime var.
//
function ruFindRuntimeVar(var as integer)

	local found as integer
	local i as integer

	found = false

	for i = 0 to ru.rt.vars.length

		if ru.rt.vars[i] = var
			
			found = true
			exit

		endif
			
	next

endfunction found

//-----------------------------------------------------
// Set the value of a var as a nbr.
//
function ruSetVarAsNbr(var ref as Var, nbr as float)

	//if var.runTyp = VAR_TYPE_VALUE
	if var.typ = VAR_TYPE_VALUE
		var.runValue = coTrimFloatStr(str(nbr))
	endif

endfunction

//-----------------------------------------------------
// Get the value of a var as a nbr.
//
function ruGetVarAsNbr(var ref as Var)

	local ret as float

	//if var.runTyp = VAR_TYPE_LIST
	if var.typ = VAR_TYPE_LIST
		ret = var.runList.length
	else
		ret = ValFloat(var.runValue)
	endif
	
endfunction ret

//-----------------------------------------------------
// Set the value of a var as a string.
//
function ruSetVarAsString(var ref as Var, text as string)

	if var.typ = VAR_TYPE_VALUE
		var.runValue = text
	endif
	
endfunction

//-----------------------------------------------------
// Get the value of a var as a nbr.
//
function ruGetVarAsString(var ref as Var)

	local ret as string
	local i as integer
	
	//if var.runTyp = VAR_TYPE_LIST
	if var.typ = VAR_TYPE_LIST

		ret = ""
		
		for i = 0 to var.runList.length
			
			if i > 0
				ret = ret + chr(10) // ","
			endif

			ret = ret + str(i + 1) + " : " + var.runList[i].value
			
			if var.runList[i].name <> ""
				ret = ret + " (" + var.runList[i].name + ")"
			endif
			
		next
		
	else

		ret = var.runValue
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Set the value of a var as a nbr.
//
function ruSetVarAsBool(var ref as Var, bool as integer)

	var.runValue = str(bool)
	
endfunction

//-----------------------------------------------------
// Get the value of a var as a nbr.
//
function ruGetVarAsBool(var ref as Var)

	local ret as integer
	
	if val(var.runValue)
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Run command.
//
function ruExecuteCmd(thread ref as Thread, cmd as integer)

	local yield as integer
	
	yield = ruExecuteCmdPtr(thread, ma.cmds[cmd])
	
endfunction yield

//-----------------------------------------------------
// Run command ptr.
//
function ruExecuteCmdPtr(thread ref as Thread, cmd ref as Cmd)

	local yield as integer

	yield = false
	
	select cmd.code

		case CODE_MOVE_SET_X
			ruSetXPtr(thread, cmd)
		endcase

		case CODE_MOVE_MOVE_X
			ruMoveXPtr(thread, cmd)
		endcase

		case CODE_MOVE_SET_Y
			ruSetYPtr(thread, cmd)
		endcase

		case CODE_MOVE_MOVE_Y
			ruMoveYPtr(thread, cmd)
		endcase

		case CODE_MOVE_SET_POS
			ruSetPosPtr(thread, cmd)
		endcase

		case CODE_MOVE_SET_RANDOM_POS
			ruSetRandomPosPtr(thread, cmd)
		endcase

		case CODE_MOVE_SET_ANGLE
			ruSetAnglePtr(thread, cmd)
		endcase

		case CODE_MOVE_MOVE_ANGLE
			ruMoveAnglePtr(thread, cmd)
		endcase

		case CODE_MOVE_POINT_AT_POS
			ruPointAtPosPtr(thread, cmd)
		endcase

		case CODE_MOVE_POINT_AT_THING
			ruPointAtThingPtr(thread, cmd)
		endcase

		case CODE_MOVE_WRAP_SCREEN_X
			ruWrapScreenXPtr(thread, cmd)
		endcase

		case CODE_MOVE_WRAP_SCREEN_Y
			ruWrapScreenYPtr(thread, cmd)
		endcase

		case CODE_MOVE_FORWARD
			ruMoveForwardPtr(thread, cmd)
		endcase

		case CODE_MOVE_EDGE_BOUNCE
			ruEdgeBouncePtr(thread, cmd)
		endcase

		case CODE_MOVE_THING_BOUNCE
			ruThingBouncePtr(thread, cmd)
		endcase

		case CODE_LOOK_UPDATES_OFF
			thread.turbo = true
		endcase

		case CODE_LOOK_UPDATES_ON
			thread.turbo = false
		endcase

		case CODE_LOOK_SHOW
			setvisible(ma.things[thread.thingIdx].obj, true)	
		endcase

		case CODE_LOOK_HIDE
			setvisible(ma.things[thread.thingIdx].obj, false)	
		endcase

		case CODE_LOOK_TILE_BG
			ruTileBgPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_COLOR
			ruSetColorPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_COLOR_PARTS
			ruSetColorPartsPtr(thread, cmd)
		endcase

		case CODE_LOOK_CHANGE_COLOR_PARTS
			ruChangeColorPartsPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_TRANSPARENCY
			ruSetTransparencyPtr(thread, cmd)
		endcase

		case CODE_LOOK_CHANGE_TRANSPARENCY
			ruChangeTransparencyPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_FRAME
			ruSetFramePtr(thread, cmd)
		endcase

		//case CODE_LOOK_SET_FRAME_IMAGE
		//	ruSetFrameImagePtr(thread, cmd)
		//endcase

		case CODE_LOOK_PREV_FRAME
			ruPrevFramePtr(thread, cmd)
		endcase

		case CODE_LOOK_NEXT_FRAME
			ruNextFramePtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_SCALE
			ruSetScalePtr(thread, cmd)
		endcase

		case CODE_LOOK_CHANGE_SCALE
			ruChangeScalePtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_SCALE_X
			ruSetScaleXPtr(thread, cmd)
		endcase

		case CODE_LOOK_CHANGE_SCALE_X
			ruChangeScaleXPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_SCALE_Y
			ruSetScaleYPtr(thread, cmd)
		endcase

		case CODE_LOOK_CHANGE_SCALE_Y
			ruChangeScaleYPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_PIXEL_SCALING
			ruSetPixelScalingPtr(thread, cmd)
		endcase

		case CODE_MOVE_CAN_COLL
			ruCanCollidePtr(thread, cmd)
		endcase

		case CODE_LOOK_FLIP_X
			ruFlipXPtr(thread, cmd)
		endcase

		case CODE_LOOK_FLIP_Y
			ruFlipYPtr(thread, cmd)
		endcase

		//case CODE_LOOK_SET_DEPTH
		//	ruSetDepthPtr(thread, cmd)
		//endcase

		case CODE_LOOK_BRING_TO_FRONT
			ruBringToFrontPtr(thread, cmd)
		endcase

		case CODE_LOOK_SEND_TO_BACK
			ruSendToBackPtr(thread, cmd)
		endcase

		case CODE_LOOK_BRING_FORWARD
			ruBringForwardPtr(thread, cmd)
		endcase

		case CODE_LOOK_SEND_BACKWARD
			ruSendBackwardPtr(thread, cmd)
		endcase

		case CODE_LOOK_PEN_DOWN
			ruPenDownPtr(thread, cmd)
		endcase

		case CODE_LOOK_PEN_UP
			ruPenUpPtr(thread, cmd)
		endcase

		case CODE_LOOK_DRAW_OVAL
			ruDrawOvalPtr(thread, cmd)
		endcase

		case CODE_LOOK_CLEAR_PEN
			ruClearPenPtr(thread, cmd)
		endcase

		//case CODE_LOOK_SAVE_PEN
		//	ruSavePenPtr(thread, cmd)
		//endcase

		//case CODE_LOOK_STOP_SAVE_PEN
		//	ruStopSavePenPtr(thread, cmd)
		//endcase

		case CODE_LOOK_SET_PEN_COLOR
			ruSetPenColorPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_PEN_SIZE
			ruSetPenSizePtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_PEN_STYLE
			ruSetPenStylePtr(thread, cmd)
		endcase

		//case CODE_LOOK_SET_PEN_SHAPE
		//	ruSetPenShapePtr(thread, cmd)
		//endcase

		case CODE_LOOK_CREATE_CLONE
			ruCloneSpritePtr(thread, cmd)
		endcase

		case CODE_LOOK_DELETE_CLONE
			ruDeleteClonePtr(thread, cmd)
		endcase

		case CODE_LOOK_DELETE_ALL_CLONES
			ruDeleteAllClonesPtr(thread, cmd)
		endcase
			
		case CODE_LOOK_STAMP_SPRITE
			ruStampSpritePtr(thread, cmd)
		endcase

		case CODE_LOOK_ERASE_STAMP_SPRITES
			ruEraseStampSpritesPtr(thread, cmd)
		endcase

		case CODE_FLOW_WAIT_SECS
			ruWaitForSecsPtr(thread, cmd)
			yield = 2
		endcase

		case CODE_FLOW_WAIT_UNTIL
			ruWaitUntilPtr(thread, cmd)
			yield = 2
		endcase
						
		case CODE_FLOW_RESET_TIMER
			ruResetTimerPtr(thread, cmd)
		endcase
			
		//case CODE_SENSE_SET_AS_BG
		//	ma.things[thread.thingIdx].isBg = true
		//endcase

		case CODE_DATA_WAIT_INPUT
			
			if ruWaitVarInputPtr(thread, cmd) // Valid var.
				yield = 2
			endif
			
		endcase

		case CODE_EMIT_PRELOAD_SOUND
			ruLoadSoundPtr(thread, cmd)
		endcase
						
		case CODE_EMIT_UNLOAD_SOUND
			ruUnloadSoundPtr(thread, cmd)
		endcase
						
		case CODE_EMIT_PLAY_SOUND
			ruPlaySoundPtr(thread, cmd)
		endcase
						
		case CODE_EMIT_PLAY_SOUND_DONE
			ruPlaySoundDonePtr(thread, cmd)
			yield = 2
		endcase

		case CODE_EMIT_STOP_SOUND
			ruStopSoundPtr(thread, cmd)
		endcase

		case CODE_EMIT_STOP_ALL_SOUNDS
			ruStopAllSoundsPtr(thread, cmd)
		endcase
			
		case CODE_EMIT_SET_SOUND_VOLUME
			ruSetSoundVolumePtr(thread, cmd)
		endcase
			
		case CODE_EMIT_SET_SOUND_LOOPS
			ruSetSoundLoopsPtr(thread, cmd)
		endcase

		case CODE_EMIT_SET_CHANNEL_VOLUME
			ruSetChannelVolumePtr(thread, cmd)
		endcase

		case CODE_EMIT_LOAD_VIDEO
			ruLoadVideoPtr(thread, cmd)
		endcase
		
		case CODE_EMIT_UNLOAD_VIDEO
			ruUnloadVideoPtr(thread, cmd)
		endcase
			
		case CODE_EMIT_PLAY_VIDEO
			ruPlayVideoPtr(thread, cmd)
		endcase
						
		case CODE_EMIT_PLAY_VIDEO_DONE
			ruPlayVideoDonePtr(thread, cmd)
		endcase

		case CODE_EMIT_STOP_VIDEO
			ruStopVideoPtr(thread, cmd)
		endcase

		case CODE_EMIT_PAUSE_VIDEO
			ruPauseVideoPtr(thread, cmd)
		endcase

		case CODE_EMIT_SHOW_VIDEO
			ruShowVideoPtr(thread, cmd)
		endcase

		case CODE_EMIT_HIDE_VIDEO
			ruHideVideoPtr(thread, cmd)
		endcase

		case CODE_EMIT_SET_VIDEO_VOLUME
			ruSetVideoVolumePtr(thread, cmd)
		endcase

		case CODE_EMIT_SET_VIDEO_POS
			ruSetVideoPosPtr(thread, cmd)
		endcase

		case CODE_EMIT_SET_VIDEO_WIDTH
			ruSetVideoWidthPtr(thread, cmd)
		endcase
		
		case CODE_EMIT_SET_VIDEO_HEIGHT
			ruSetVideoHeightPtr(thread, cmd)
		endcase

		case CODE_EMIT_SHOW_VIDEO_PANEL
			ruShowVideoPanelPtr(thread, cmd)
		endcase

		case CODE_EMIT_HIDE_VIDEO_PANEL
			ruHideVideoPanelPtr(thread, cmd)
		endcase

		case CODE_EMIT_SET_VIDEO_TIME
			ruSetVideoTimePtr(thread, cmd)
		endcase
			
		case CODE_LOOK_PRINT
			ruPrintPtr(thread, cmd)
		endcase

		case CODE_LOOK_PRINT_FOR_TIME
			ruPrintForTimePtr(thread, cmd)
		endcase
			
		//case CODE_LOOK_PRINT_AT
		//	ruPrintAtPtr(thread, cmd)
		//endcase

		case CODE_DATA_SHOW_VAR
			ruShowVarPtr(thread, cmd)
		endcase

		case CODE_DATA_HIDE_VAR
			ruHideVarPtr(thread, cmd)
		endcase
			
		case CODE_EMIT_SET_BG_COLOR
			ruSetBgColorPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_BG_COLOR
			ruSetVarBgColorPtr(thread, cmd)
		endcase
									
		case CODE_DATA_SET_VAR_TITLE_COLOR
			ruSetVarTitleColorPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TITLE_FONT
			ruSetVarTitleFontPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TITLE_FONT_SIZE
			ruSetVarTitleFontSizePtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TITLE_DIR
			ruSetVarTitleDirPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TITLE_ALIGN
			ruSetVarTitleAlignPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TITLE_VIS
			ruSetVarTitleVisPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TEXT_COLOR
			ruSetVarTextColorPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TEXT_FONT
			ruSetVarTextFontPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TEXT_FONT_SIZE
			ruSetVarTextFontSizePtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TEXT_ALIGN
			ruSetVarTextAlignPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_TEXT_SECRET
			ruSetVarTextSecretPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_BOX_COLOR
			ruSetVarBoxColorPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_X
			ruSetVarXPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_Y
			ruSetVarYPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_W
			ruSetVarWPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR_H
			ruSetVarHPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_VAR
			ruSetVarPtr(thread, cmd)
		endcase

		case CODE_DATA_SET_ITEM_NAME
			ruSetListItemNamePtr(thread, cmd)
		endcase

		case CODE_DATA_SET_ITEM_VALUE
			ruSetListItemValuePtr(thread, cmd)
		endcase

		case CODE_DATA_CHANGE_VAR
			ruChangeVarPtr(thread, cmd)
		endcase

		case CODE_DATA_ADD_ITEM
			ruAddListItemPtr(thread, cmd)
		endcase

		case CODE_DATA_ADD_ITEM_BY_NAME
			ruAddListItemByNamePtr(thread, cmd)
		endcase

		case CODE_DATA_INSERT_ITEM
			ruInsertListItemPtr(thread, cmd)
		endcase

		case CODE_DATA_REMOVE_ITEM
			ruRemoveListItemPtr(thread, cmd)
		endcase

		case CODE_DATA_CLEAR_VAR
			ruClearVarPtr(thread, cmd)
		endcase

		case CODE_DATA_CLEAR_LIST
			ruClearVarPtr(thread, cmd)
		endcase

		//case CODE_DATA_SPLIT_TEXT
		//	ruSplitTextPtr(thread, cmd)
		//endcase

		case CODE_LOOK_SET_PRINT_BG_COLOR
			ruSetPrintBgColorPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_PRINT_BORDER_COLOR
			ruSetPrintBorderColorPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_PRINT_TEXT_COLOR
			ruSetPrintTextColorPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_PRINT_FONT
			ruSetPrintFontPtr(thread, cmd)
		endcase

		case CODE_LOOK_SET_PRINT_FONT_SIZE
			ruSetPrintFontSizePtr(thread, cmd)
		endcase

		case CODE_DATA_MAKE_TMP_VAR
			if ld.set.tmpVarsAllowed
				ruMakeTmpVarPtr(thread, cmd)
			endif
		endcase

		case CODE_DATA_MAKE_TMP_LIST
			if ld.set.tmpVarsAllowed
				ruMakeTmpListPtr(thread, cmd)
			endif
		endcase

		case CODE_DATA_SHARE_TMP_VAR
			if ld.set.tmpVarsAllowed
				ruShareTmpVarPtr(thread, cmd)
			endif
		endcase
		
		case CODE_FLOW_SEND_EVENT
			ruSendEventPtr(thread, cmd)
		endcase

		case CODE_FLOW_CALL_BLOCK
			ruSendEventPtr(thread, cmd)
			yield = 1 // Have to yield here, so thread goes out, and blocks of waitEvents.
		endcase

		case CODE_CALC_IGNORE_CASE
			ruSetIgnoreCasePtr(thread, cmd)
		endcase

		case CODE_FLOW_STOP
			ruStopCurrentPtr(thread, cmd)
			yield = 2
		endcase
		
	endselect
	
endfunction yield

//-----------------------------------------------------
// Evaluate an operator via cmd ptr.
//
function ruEvalCmdAsFloatPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float
	local a as float
	local b as float
	local d as integer
	local e as integer
	local s as string
	local t as string
	local count as integer
	local varName as string
	local bool as integer
	local var as integer
	local thing as integer

	ret = 0

	if cmd.typ && CMD_OSTR
		
		s = ruEvalCmdAsStringPtr(thread, cmd)
		ret = valfloat(s)
		exitfunction ret
		
	endif
		
	select cmd.code

		case CODE_FLOW_REPEAT_TIMES
			
			var = ruGetThreadPartVar(thread, cmd.parts[1])

			if not var
				
				ret = ruEvalPartAsInt(thread, cmd.parts[1])
				var = ruCreateThreadPartVar(thread, cmd.parts[1], VAR_TYPE_VALUE)
				ruSetVarAsNbr(ma.vars[var], ret - 1)

			else

				ret = ruGetVarAsNbr(ma.vars[var])

				if ret > 0
					ruSetVarAsNbr(ma.vars[var], ret - 1)					
				endif

			endif
			
		endcase

		case CODE_FLOW_REPEAT_FOREVER
			ret = 1 // Always one.
		endcase

		case CODE_FLOW_REPEAT_UNTIL
			ret = not ruEvalPartAsInt(thread, cmd.parts[1])
		endcase

		case CODE_FLOW_REPEAT_WHILE
			ret = ruEvalPartAsInt(thread, cmd.parts[1])
		endcase

		case CODE_SENSE_PTR_X
			ret = in.ptrX			
		endcase

		case CODE_SENSE_PTR_Y
			ret = in.ptrY			
		endcase

		case CODE_SENSE_X_MAX
			ret = ru.w - 1		
		endcase

		case CODE_SENSE_Y_MAX
			ret = ru.h - 1
		endcase

		case CODE_SENSE_X_MID
			ret = ru.w / 2	
		endcase

		case CODE_SENSE_Y_MID
			ret = ru.h / 2
		endcase

		case CODE_MOVE_GET_X
			ret = getposx(ma.things[thread.thingIdx].obj)		
		endcase

		case CODE_MOVE_GET_Y
			ret = getposy(ma.things[thread.thingIdx].obj)		
		endcase

		case CODE_MOVE_GET_ANGLE
			ret = getangle(ma.things[thread.thingIdx].obj)		
		endcase
		
		case CODE_CALC_PLUS
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			b = ruEvalPartAsfloat(thread, cmd.parts[3])
			ret = a + b
		endcase

		case CODE_CALC_MINUS
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			b = ruEvalPartAsfloat(thread, cmd.parts[3])
			ret = a - b
		endcase

		case CODE_CALC_MULTIPLY
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			b = ruEvalPartAsfloat(thread, cmd.parts[3])
			ret = a * b
		endcase

		case CODE_CALC_DIVIDE
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			b = ruEvalPartAsfloat(thread, cmd.parts[3])
			ret = a / b
		endcase

		case CODE_CALC_MOD
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			b = ruEvalPartAsfloat(thread, cmd.parts[3])
			ret = mod(a, b)
		endcase
		
		case CODE_CALC_POW
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			b = ruEvalPartAsfloat(thread, cmd.parts[3])
			ret = pow(a, b)
		endcase

		case CODE_CALC_RANDOM
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			b = ruEvalPartAsfloat(thread, cmd.parts[3])
			ret = random2(a, b)
		endcase

		case CODE_CALC_RANDOM_FLOAT
			ret = random2(0, 1000000.0)
			ret = ret / 1000000.0
		endcase

		//case CODE_CALC_RANDOM_COLOR_VALUE
		//	ret = random2(0, 255)
		//endcase

		case CODE_CALC_RANDOM_X_POS
			ret = random2(0, ru.w - 1)
		endcase

		case CODE_CALC_RANDOM_Y_POS
			ret = random2(0, ru.h - 1)
		endcase

		case CODE_CALC_ROUND
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = round(a)
		endcase

		case CODE_CALC_SIN
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = sin(a)
		endcase

		case CODE_CALC_COS
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = cos(a)
		endcase
		
		case CODE_CALC_TAN
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = tan(a)
		endcase

		case CODE_CALC_ASIN
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = asin(a)
		endcase

		case CODE_CALC_ACOS
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = acos(a)
		endcase
		
		case CODE_CALC_ATAN
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = atan(a)
		endcase

		case CODE_CALC_LOG
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = log(a)
		endcase

		case CODE_CALC_SQRT
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			ret = sqrt(a)
		endcase

		case CODE_CALC_NEG
			a = ruEvalPartAsfloat(thread, cmd.parts[1])
			if a > 0
				ret = -a
			elseif a < 0
				ret = a
			endif
		endcase

		case CODE_CALC_AS_NBR
			d = ruEvalPartAsbool(thread, cmd.parts[1])
			if d
				ret = 1
			else 
				ret = 0
			endif
		endcase

		case CODE_DATA_ITEM_VALUE_INDEX
			ret = ruGetListItemValueIndexPtr(thread, cmd)
		endcase

		case CODE_DATA_ITEM_NAME_INDEX
			ret = ruGetListItemNameIndexPtr(thread, cmd)
		endcase

		case CODE_CALC_LEN
			ret = ruGetListLenPtr(thread, cmd)
		endcase

		case CODE_CALC_FIND
			ret = ruFindItemPtr(thread, cmd)
		endcase

		//case CODE_CALC_FIND_REV
		//	ret = ruFindItemRevPtr(thread, cmd)
		//endcase

		case CODE_LOOK_GET_COLOR
			ret = cogetspritecolor(getsprite(ma.things[thread.thingIdx].obj	))	
		endcase

		case CODE_LOOK_GET_SCALE_X
			ret = getscalex(ma.things[thread.thingIdx].obj)	
		endcase

		case CODE_LOOK_GET_SCALE_Y
			ret = getscaley(ma.things[thread.thingIdx].obj)	
		endcase

		case CODE_LOOK_GET_WIDTH
			ret = getwidth(ma.things[thread.thingIdx].obj)	
		endcase

		case CODE_LOOK_GET_HEIGHT
			ret = getheight(ma.things[thread.thingIdx].obj)	
		endcase

		case CODE_LOOK_GET_FRAME
			ret = ma.things[thread.thingIdx].rImgIdx + 1
		endcase

		case CODE_LOOK_GET_TRANSPARENCY
			//ret = Floor(((255 - getalpha(ma.things[thread.thingIdx].obj)) * 100.0) / 255.0)
			ret = getalpha(ma.things[thread.thingIdx].obj)
		endcase

		case CODE_FLOW_GET_TIMER
			//ret = GetMilliseconds() - ru.rt.timer
			ret = ruGetTimer()
		endcase

		case CODE_SENSE_SPRITE_INFO
			ret = ruGetOtherSpritePtr(thread, cmd)
		endcase

		case CODE_SENSE_SPRITE_VIS
			ret = ruGetOtherSpriteVisPtr(thread, cmd)
		endcase

		case CODE_SENSE_SPRITE_OFF_SCREEN
			ret = ruGetSpriteOffScreenPtr(thread, cmd)
		endcase
			
		case CODE_EMIT_GET_SOUND_VOLUME
			ret = ruGetSoundVolumePtr(thread, cmd)
		endcase

		case CODE_EMIT_GET_CHANNEL_VOLUME
			ret = ruGetChannelVolumePtr(thread, cmd)
		endcase

		case CODE_EMIT_GET_VIDEO_DURATION
			ret = ruGetVideoDurationPtr(thread, cmd)
		endcase

		case CODE_EMIT_GET_VIDEO_TIME
			ret = ruGetVideoTimePtr(thread, cmd)
		endcase

		case CODE_EMIT_GET_VIDEO_X
			ret = ruGetVideoXPtr(thread, cmd)		
		endcase

		case CODE_EMIT_GET_VIDEO_Y
			ret = ruGetVideoYPtr(thread, cmd)		
		endcase

		case CODE_MOVE_DIST_TO_POS
			ret = ruDistToPosPtr(thread, cmd)
		endcase

		case CODE_MOVE_DIST_TO_THING
			ret = ruDistToThingPtr(thread, cmd)
		endcase

		case CODE_VAR_GET

			if not cmd.var
				cmd.var = cdGetPartAsInt(cmd.parts[0])
			endif

			if cmd.var
				ret = ruGetVarAsNbr(ma.vars[cmd.var])
			endif
			
		endcase
/*
		case CODE_SOUND_BASE
			ret = cdGetPartAsInt(cmd.parts[0])			
		endcase

		case CODE_VIDEO_BASE
			ret = cdGetPartAsInt(cmd.parts[0])
		endcase

		case CODE_SPRITE_PART
			ret = cdGetPartAsInt(cmd.parts[0])
		endcase
*/
		case CODE_FRAME_PART
			ret = cdGetPartAsInt(cmd.parts[0])
		endcase

		case CODE_DATA_GET_TMP_VAR

			if ld.set.tmpVarsAllowed
			
				// The cmd won't have a var yet, because they are looked up by name at runtime.
				if not cmd.var

					// We want to evaluate, to allow for dynamically created names.
					varName = ruEvalPartAsString(thread, cmd.parts[1])
					cmd.var = ruGetTmpVar(thread, varName)
					
				endif

				if cmd.var
					ret = ruGetVarAsNbr(ma.vars[cmd.var])
				else
					ret = 0
				endif

			endif
			
		endcase

		case CODE_DATA_GET_TMP_LIST

			if ld.set.tmpVarsAllowed
			
				// The cmd won't have a var yet, because they are looked up by name at runtime.
				if not cmd.var

					// We want to evaluate, to allow for dynamically created names.
					varName = ruEvalPartAsString(thread, cmd.parts[1])
					
					if varName <> ""
						cmd.var = ruGetTmpVar(thread, varName)
					endif
					
				endif

				if cmd.var
					ret = ruGetVarAsNbr(ma.vars[cmd.var])
				else
					ret = 0
				endif

			endif
			
		endcase
		
		// BOOLRAN operators.
		
		case CODE_FLOW_IF
			ret = ruEvalPartAsBool(thread, cmd.parts[1])
		endcase

		case CODE_FLOW_IF_ELSE
			ret = ruEvalPartAsBool(thread, cmd.parts[1])
		endcase

		case CODE_SENSE_PTR_PRESSED
			ret = ru.rt.ptrPressed
		endcase

		case CODE_SENSE_PTR_DOWN
			ret = ru.rt.ptrDown
		endcase

		case CODE_SENSE_PTR_RELEASED
			ret = ru.rt.ptrReleased
		endcase

		case CODE_SENSE_SPRITE_PRESSED
			//ret = in.ptrPressed

			if ruSpritePressed(thread)
				ret = true
			endif

		endcase

		case CODE_SENSE_SPRITE_DOWN
			
			//ret = in.ptrDown			
			if ruSpriteDown(thread)
				ret = true
			endif

		endcase

		case CODE_SENSE_SPRITE_RELEASED
			
			//ret = in.ptrReleased			
			if ruSpriteReleased(thread)
				ret = true
			endif

		endcase

		case CODE_FLOW_PARAM_BOOL
			ret = ruGetParamBool(thread, cmd)	
		endcase

		case CODE_SENSE_VAR_PRESSED
			//ret = in.ptrPressed
			
			if ruVarPressed(thread, cmd)
				ret = true
			endif			

		endcase

		case CODE_SENSE_VAR_DOWN
			
			if ruVarDown(thread, cmd)
				ret = true
			endif			

		endcase

		case CODE_SENSE_VAR_RELEASED
			
			if ruVarReleased(thread, cmd)
				ret = true
			endif			

		endcase
			
		case CODE_SENSE_COLL_THING
			ret = ruCollidedThing(thread, cmd.parts[1])
		endcase

		case CODE_SENSE_COLL_ANY_THING
			ret = ruCollidedAnyThing(thread, cmd)
		endcase

		case CODE_SENSE_COLL_CLONE
			ret = ruCollidedClone(thread, cmd.parts[1])
		endcase

		case CODE_SENSE_COLL_ANY_CLONE
			ret = ruCollidedAnyClone(thread, cmd)
		endcase

		case CODE_SENSE_IAM_SPRITE`
			ret = ruIamSprite(thread, cmd)
		endcase

		case CODE_SENSE_IAM_CLONE
			ret = ruIamClone(thread, cmd)
		endcase

		case CODE_SENSE_COLL_EDGE
			ret = ruCollidedEdge(thread, cmd.parts[1])
		endcase

		case CODE_SENSE_EQ
			a = ruEvalPartAsFloat(thread, cmd.parts[1])
			b = ruEvalPartAsFloat(thread, cmd.parts[3])

			if a = b
				ret = true
			endif
		endcase

		case CODE_SENSE_NE
			a = ruEvalPartAsFloat(thread, cmd.parts[1])
			b = ruEvalPartAsFloat(thread, cmd.parts[3])

			if a <> b
				ret = true
			endif
		endcase

		case CODE_SENSE_LT
			a = ruEvalPartAsFloat(thread, cmd.parts[1])
			b = ruEvalPartAsFloat(thread, cmd.parts[3])

			if a < b
				ret = true
			endif
		endcase

		case CODE_SENSE_LE
			a = ruEvalPartAsFloat(thread, cmd.parts[1])
			b = ruEvalPartAsFloat(thread, cmd.parts[3])

			if a <= b
				ret = true
			endif
		endcase

		case CODE_SENSE_GT
			a = ruEvalPartAsFloat(thread, cmd.parts[1])
			b = ruEvalPartAsFloat(thread, cmd.parts[3])

			if a > b
				ret = true
			endif
		endcase

		case CODE_SENSE_GE
			a = ruEvalPartAsFloat(thread, cmd.parts[1])
			b = ruEvalPartAsFloat(thread, cmd.parts[3])

			if a >= b
				ret = true
			endif
		endcase

		case CODE_SENSE_NOT
			bool = ruEvalPartAsBool(thread, cmd.parts[1])

			if not bool
				ret = true
			endif
		endcase
		
		case CODE_SENSE_OR
			d = ruEvalPartAsBool(thread, cmd.parts[0])
			e = ruEvalPartAsBool(thread, cmd.parts[2])

			if d or e
				ret = true
			endif
		endcase

		case CODE_SENSE_AND
			d = ruEvalPartAsBool(thread, cmd.parts[0])
			e = ruEvalPartAsBool(thread, cmd.parts[2])

			if d
				if e
					ret = true
				endif
			endif
		endcase

		case CODE_SENSE_TRUE
			ret = true
		endcase

		case CODE_SENSE_FALSE
			ret = false
		endcase

		case CODE_SENSE_AS_BOOL
			bool = ruEvalPartAsBool(thread, cmd.parts[1])
		endcase

		case CODE_LOOK_GET_VISIBLE
			ret = getvisible(ma.things[thread.thingIdx].obj)	
		endcase

		case CODE_LOOK_GET_OFF_SCREEN
			ret = rugetspriteoffscreen(ma.things[thread.thingIdx].obj)	
		endcase

	endselect
	
endfunction ret

//-----------------------------------------------------
//
function ruGetParamBool(thread ref as Thread, cmd ref as Cmd)
	
	local s as string
	local v as integer
	local ret as integer
	
	s = ruGetParamValuePtr(thread, cmd)

	if coIsValidNbr(s, true, true)
		
		v = val(s)
		
		if v
			ret = true
		else
			ret = false
		endif

	elseif s <> ""
		
		ret = true
		
	else 
		
		ret = false
		
	endif	
			
endfunction ret

//-----------------------------------------------------
//
function ruGetTimer()
	
	local ret as integer
	
	ret = GetMilliseconds() - ru.rt.timer
	
endfunction ret

//-----------------------------------------------------
// Evaluate an operator via cmd ptr.
// If the cmd evaluates to a list, and 'copyList' is true, then copies the list.
//
function ruEvalCmdAsListPtr(thread ref as Thread, cmd ref as Cmd, copyList as integer)

	local varIdx as integer

	varIdx = 0
	
	select cmd.code

		case CODE_CALC_SPLIT_TEXT
			varIdx = ruSplitTextListPtr(thread, cmd)
		endcase

		case CODE_VAR_GET

			if not cmd.var
				cmd.var = cdGetPartAsInt(cmd.parts[0])
			endif

			if cmd.var
				if ma.vars[cmd.var].typ = VAR_TYPE_LIST
					if copyList
						varIdx = ruCloneListVar(thread, cmd.var)
					else
						varIdx = cmd.var
					endif
				endif
			endif
			
		endcase

	endselect
	
endfunction varIdx

//-----------------------------------------------------
// Evaluate an operator via cmd ptr.
//
function ruEvalCmdAsStringPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as string
	local d as integer
	local e as integer
	local s as string
	local t as string
	local varName as string 
	local f as float

	if not (cmd.typ && CMD_OSTR)
		
		f = ruEvalCmdAsFloatPtr(thread, cmd)
		ret = str(f)
		ret = coTrimFloatStr(ret)
		
		exitfunction ret
		
	endif

	select cmd.code

		case CODE_CALC_TRIM
			ret = ruTrimStrPtr(thread, cmd)
		endcase

		case CODE_CALC_FORMAT_NBR
			ret = ruFormatNbrPtr(thread, cmd)
		endcase

		case CODE_CALC_RANDOM_COLOR
			ret = ruRandomColorPtr(thread, cmd)
		endcase

		case CODE_EMIT_MAKE_COLOR
			ret = ruMakeColor3Ptr(thread, cmd)
		endcase

		case CODE_CALC_APPEND
			ret = ruAppendStrPtr(thread, cmd)
		endcase

		case CODE_DATA_ITEM_BY_NAME
			ret = ruGetListItemByNamePtr(thread, cmd)
		endcase

		case CODE_CALC_EXTRACT
			ret = ruGetValuePtr(thread, cmd)
		endcase

		case CODE_CALC_REPLACE
			ret = ruReplaceValuePtr(thread, cmd)
		endcase

		case CODE_DATA_ITEM
			ret = ruGetListItemPtr(thread, cmd)
		endcase

		case CODE_FLOW_PARAM_VALUE
			ret = ruGetParamValuePtr(thread, cmd)
		endcase

		case CODE_DATA_ITEM_NAME
			ret = ruGetListItemNamePtr(thread, cmd)
		endcase
		
		case CODE_DATA_JOIN_LIST
			ret = ruJoinListPtr(thread, cmd)
		endcase

		case CODE_CALC_GET_DATETIME
			ret = ruGetDateTimePtr(thread, cmd)
		endcase

		case CODE_CALC_GET_TIME
			//ret = GetCurrentTime()
			ret = ruGetTimePtr(thread, cmd)
		endcase
			
		case CODE_CALC_GET_DATE
			//ret = GetCurrentDate()
			ret = ruGetDatePtr(thread, cmd)
		endcase

		case CODE_CALC_AS_TEXT
			d = ruEvalPartAsbool(thread, cmd.parts[1])
			if d
				ret = "true"
			else 
				ret = "false"
			endif
		endcase

		case CODE_CALC_SPLIT_TEXT
			ret = ruSplitTextStrPtr(thread, cmd)
		endcase

		case CODE_SOUND_BASE
			ret = cdGetPartAsString(cmd.parts[0])			
		endcase

		case CODE_VIDEO_BASE
			ret = cdGetPartAsString(cmd.parts[0])
		endcase

		case CODE_SPRITE_PART
			ret = cdGetPartAsString(cmd.parts[0])
		endcase

		case CODE_VAR_GET

			if not cmd.var
				cmd.var = cdGetPartAsInt(cmd.parts[0])
			endif

			if cmd.var
				ret = ruGetVarAsString(ma.vars[cmd.var])
			endif
			
		endcase

		case CODE_DATA_GET_TMP_VAR

			// The cmd won't have a var yet, because they are looked up by name at runtime.
			if ld.set.tmpVarsAllowed
				
				if not cmd.var
					
						// We want to evaluate, to allow for dynamically created names.
					varName = ruEvalPartAsString(thread, cmd.parts[1])
					
					if varName <> ""
						cmd.var = ruGetTmpVar(thread, varName)
					endif
					
				endif

				if cmd.var
					ret = ruGetVarAsString(ma.vars[cmd.var])
				else
					ret = ""
				endif

			endif
			
		endcase

		case CODE_DATA_GET_TMP_LIST

			// The cmd won't have a var yet, because they are looked up by name at runtime.
			if ld.set.tmpVarsAllowed
				
				if not cmd.var
					
					// We want to evaluate, to allow for dynamically created names.
					varName = ruEvalPartAsString(thread, cmd.parts[1])
					
					if varName <> ""
						cmd.var = ruGetTmpVar(thread, varName)
					endif
					
				endif

				if cmd.var
					ret = ruGetVarAsString(ma.vars[cmd.var])
				else
					ret = ""
				endif

			endif
			
		endcase
		
	endselect		

endfunction ret

//
//*****************************************************
// END EXECUTION and EVALUATION.
//*****************************************************
//

//
//*****************************************************
// START COMMANDS.
//*****************************************************
//

//-----------------------------------------------------
// Get the thingIdx from a cmd expecting a thing.
//
function ruGetThingCmdPtr(thread ref as Thread, cmd ref as Cmd, cmdPartIdx as integer)

	local thingCmd as integer
	local thingIdx as integer
	local name as string

	thingIdx = -1 // Not a valid thing.

	if cmd.parts.length >= cmdPartIdx

		// Should be a var cmd operator, if not, nothing to return.
		if cmd.parts[cmdPartIdx].typ = PART_CMD

			// Get the var cmd.
			thingCmd = cdGetPartAsInt(cmd.parts[cmdPartIdx])

			// If it has var cmd, which should be always, and it's a get var.
			if thingCmd > 0
				//thingIdx = cdGetPartAsInt(ma.cmds[thingCmd].parts[0])
				thingIdx = maFindThingById(ru.appIdx, cdGetPartAsString(ma.cmds[thingCmd].parts[0]))
			endif

		endif

	endif

endfunction thingIdx

//-----------------------------------------------------
// Get the varIdx from a cmd expecting a var.
//
function ruGetVarCmdPtr(thread ref as Thread, cmd ref as Cmd, varCmdPartIdx as integer)

	local varCmd as integer
	local varIdx as integer
	local varName as string

	varIdx = 0 // Not a valid var.

	if cmd.parts.length >= varCmdPartIdx

		// Should be a var cmd operator, if not, nothing to return.
		if cmd.parts[varCmdPartIdx].typ = PART_CMD

			// Get the var cmd.
			varCmd = cdGetPartAsInt(cmd.parts[varCmdPartIdx])

			// If it has var cmd, which should be always, and it's a get var.
			if varCmd

				if ma.cmds[varCmd].code = CODE_VAR_GET

					// See if we have retrieved this var before, for optimising look ups.
					varIdx = ma.cmds[varCmd].var

					if not varIdx

						varIdx = cdGetPartAsInt(ma.cmds[varCmd].parts[0])
						ma.cmds[varCmd].var = varIdx

					endif

				// OTherwise, it could just be a straight var, entered as text.
				elseif ma.cmds[varCmd].code = CODE_DATA_GET_TMP_VAR

					varName = ruEvalPartAsString(thread, ma.cmds[varCmd].parts[1])
					
					if varName <> ""
						varIdx = ruGetTmpVar(thread, varName)
					endif

				elseif ma.cmds[varCmd].code = CODE_DATA_GET_TMP_LIST

					varName = ruEvalPartAsString(thread, ma.cmds[varCmd].parts[1])
					
					if varName <> ""
						varIdx = ruGetTmpVar(thread, varName)
					endif
	
				endif

			endif

		endif

	endif

endfunction varIdx

//-----------------------------------------------------
// Make a tmp sprite variable by cmd.
//
function ruMakeTmpVarPtr(thread ref as Thread, cmd ref as Cmd)

	local varName as string 

	varName = ruEvalPartAsString(thread, cmd.parts[1])
	
	if varName <> ""
		ruMakeTmpVar(thread, varName, VAR_TYPE_VALUE)
	endif
	
endfunction

//-----------------------------------------------------
// Make a tmp sprite list variable by cmd.
//
function ruMakeTmpListPtr(thread ref as Thread, cmd ref as Cmd)

	local varName as string 

	varName = ruEvalPartAsString(thread, cmd.parts[1])
	
	if varName <> ""
		ruMakeTmpVar(thread, varName, VAR_TYPE_LIST)
	endif
	
endfunction

//-----------------------------------------------------
// Make a sprite variable by name.
//
function ruMakeTmpVar(thread ref as Thread, varName as string, typ as integer)

	local ret as string
	local varCmd as integer
	local varIdx as integer
	local name as string

	varIdx = ruCreateThreadVar(thread, typ)
	ma.vars[varIdx].name = varName
	ma.vars[varIdx].v.name = varName
	ma.vars[varIdx].thingIdx = thread.thingIdx

	ruResetVar(varIdx)
	
endfunction varIdx

//-----------------------------------------------------
// Make an app variable.
//
function ruShareTmpVarPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as string
	local varCmd as integer
	local varName as string 
	local varIdx as integer
	local name as string
	local idx as integer
	local i as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx		
		
		// Remove it if there is already a var with this name.
		for i = 0 to ru.rt.vars.length

			if ma.vars[ru.rt.vars[i]].name = varName
				
				ru.rt.vars.remove(i)
				exit
				
			endif
			
		next
		
		ru.rt.vars.insert(varIdx)
		ma.vars[varIdx].thingIdx = -1 // Make it a app var.

		// Get rid if the thread var.
		thread.tmpVars.remove(idx)
		
	endif
	
endfunction

//-----------------------------------------------------
// "S:set variable ,V:,S: to ,T:"
// Sets the value of the variable if it exists.
//
function ruSetVarPtr(thread ref as Thread, cmd ref as Cmd)

	local varName as string 
	local varIdx as integer
	local idx as integer
	local valueIdx as integer
	
	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		valueIdx = ruEvalPartAsList(thread, cmd.parts[3], true)

		if valueIdx

			if ma.vars[varIdx].typ = VAR_TYPE_VALUE
										
				//ma.vars[varIdx].runValue = ruGetVarAsString(ma.vars[valueIdx])
				ruSetVarAsString(ma.vars[varIdx], ruGetVarAsString(ma.vars[valueIdx]))
						
			elseif ma.vars[varIdx].typ = VAR_TYPE_LIST

				ruClearVar(varIdx)			
				ruAddListToList(varIdx, valueIdx, 0)
				
			endif

			ruDeleteThreadVar(thread, valueidx)
			
		else

			if ma.vars[varIdx].typ = VAR_TYPE_VALUE
			
				//ma.vars[varIdx].runValue = ruEvalPartAsString(thread, cmd.parts[3])
				ruSetVarAsString(ma.vars[varIdx], ruEvalPartAsString(thread, cmd.parts[3]))

			elseif ma.vars[varIdx].typ = VAR_TYPE_LIST

				ruClearVar(varIdx)			
				ruAddItemToList(varIdx, "", ruEvalPartAsString(thread, cmd.parts[3]), 1)
				
			endif

		endif

		ruDrawVar(varIdx)
		
	elseif ld.set.tmpVarsAllowed // It is the name of a variable, if we are allowing temp vars.

		varName = ruEvalPartAsString(thread, cmd.parts[1])
		
		if varName <> ""
			varIdx = ruGetTmpVar(thread, varName)
		endif
		
		if varIdx
			//ma.vars[varIdx].runValue = ruEvalPartAsString(thread, cmd.parts[3])
			ruSetVarAsString(ma.vars[varIdx], ruEvalPartAsString(thread, cmd.parts[3]))
		endif

		ruDrawVar(varIdx)
		
	endif
	
endfunction

//-----------------------------------------------------
// change a var by the amount
// Sets the value of the variable if it exists.
//
function ruChangeVarPtr(thread ref as Thread, cmd ref as Cmd)

	local varName as string 
	local varIdx as integer
	local idx as integer
	local value as float
	
	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx
			
		value = ruEvalPartAsFloat(thread, cmd.parts[3])
		value = value + valfloat(ma.vars[varIdx].runValue)
		ruSetVarAsNbr(ma.vars[varIdx], value)

		//if ma.vars[varIdx].vis
		if ma.vars[varIdx].rv.vis
			ruDrawVar(varIdx)
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Get a temp var, first look for thread, then app.
//
function ruIsTmpVar(vars ref as integer[], var as integer)

	local found as integer
	
	if ruFindThreadVar(vars, var)
		found = true
	elseif ruFindRuntimeVar(var)
		found = true		
	else 
		found = false
	endif

endfunction found

//-----------------------------------------------------
// Get a temp var, first look for thread, then app.
//
function ruGetTmpVar(thread ref as Thread, varName as string)

	local idx as integer
	local varIdx as integer
	local i as integer
	
	varIdx = 0
	
	if varName <> ""
		
		//idx = ruGetThreadVar(thread, varName)

		// Find the var in one of the threads for this thread's thingIdx.
		// This is a bit of a glitch because I thought only one thread would
		// need this, but they need to work the same as thing vars.
		
		for i = 0 to ru.rt.threads.length
			if ru.rt.threads[i].thingIdx = thread.thingIdx
				
				idx = ruGetThreadVar(ru.rt.threads[i], varName)
				
				if idx > -1
					
					varIdx = ru.rt.threads[i].tmpVars[idx]
					exit
					
				endif
				
			endif
		next 
	
		if idx > -1 // Is thread var.
	
			//varIdx = thread.tmpVars[idx]
			// Set above.
	
		else // not thread var.
			
			idx = ruGetRuntimeVar(varName)
	
			if idx > -1
	
				varIdx = ru.rt.vars[idx]
	
			endif
			
		endif
		
	endif

endfunction varIdx

//-----------------------------------------------------
// Draw a list var.
//
function ruDrawVar(varIdx as integer)

	local varCmd as integer
	local value as string
	local i as integer

	//if ma.vars[varIdx].vis
	if ma.vars[varIdx].rv.vis
		
		value = ruGetVarAsString(ma.vars[varIdx])
		
		if ma.vars[varIdx].rv.textSecret
			value = coRepeatString("*", len(value))
		endif
		
		SetTextString(ma.vars[varIdx].rv.text, value)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)
		
	endif
	
endfunction

//-----------------------------------------------------
// "S:add ,T:,S: in ,V:"
// Add a text value to a list variable. That is, converts
// this variable to a list, and adds the first item.
//
function ruAddListItemPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local listIdx as integer
	local valueIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 3)

	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction
		endif

		//listIdx = ruEvalPartAsInt(thread, cmd.parts[3])

		//if listIdx < 0
		//	listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
		//endif
		listIdx = 0 // Append.

		valueIdx = ruEvalPartAsList(thread, cmd.parts[1], false)

		if valueIdx
			
			ruAddListToList(varIdx, valueIdx, listIdx)
			ruDeleteThreadVar(thread, valueidx)
			
		else
			
			value = ruEvalPartAsString(thread, cmd.parts[1])
			ruAddItemToList(varIdx, "", value, listIdx)

		endif

		// Draw the var cmd if it's visible.
		//if ma.vars[varIdx].vis
		//if ma.vars[varIdx].rv.vis
			ruDrawVar(varIdx)			
		//endif
						
	endif
	
endfunction

//-----------------------------------------------------
// "S:add ,T:,S: with name ,T:,S: in ,V:"
// Add a text value to a list variable. That is, converts
// this variable to a list, and adds the first item.
//
function ruAddListItemByNamePtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local name as string
	local value as string
	local i as integer
	local idx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 5)

	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction
		endif

		name = ruEvalPartAsString(thread, cmd.parts[3])
		value = ruEvalPartAsString(thread, cmd.parts[1])
		idx = -1
		
		for i = 0 to ma.vars[varIdx].runList.length
			
			if ma.vars[varIdx].runList[i].name = name
				
				idx = i
				exit
				
			endif
			
		next 
		
		if idx > -1
			ma.vars[varIdx].runList[idx].value = value
		else
			ruAddItemToList(varIdx, name, value, 0)			
		endif
		
		ruDrawVar(varIdx)			
						
	endif
	
endfunction

//-----------------------------------------------------
// "S:insert ,T:,S: at ,N:1,S: in ,V:"
// Add a text value to a list variable. That is, converts
// this variable to a list, and adds the first item.
//
function ruInsertListItemPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local listIdx as integer
	local valueIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 5)

	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction
		endif

		listIdx = ruEvalPartAsInt(thread, cmd.parts[3])

		if listIdx < 0
			listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
		endif

		valueIdx = ruEvalPartAsList(thread, cmd.parts[1], false)

		if valueIdx
			
			ruAddListToList(varIdx, valueIdx, listIdx)
			ruDeleteThreadVar(thread, valueidx)
			
		else
			
			value = ruEvalPartAsString(thread, cmd.parts[1])
			ruAddItemToList(varIdx, "", value, listIdx)

		endif

		// Draw the var cmd if it's visible.
		//if ma.vars[varIdx].vis
		//if ma.vars[varIdx].rv.vis
			ruDrawVar(varIdx)			
		//endif
						
	endif
	
endfunction

//-----------------------------------------------------
// "S:set item name ,T:,S: at ,N:1,S: in ,V:"
// Set the name of a list item.
//
function ruSetListItemNamePtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local name as string
	local listIdx as integer
	local valueIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 5)

	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction
		endif

		listIdx = ruEvalPartAsInt(thread, cmd.parts[3])

		if listIdx < 0
			listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
		endif

		name = ruEvalPartAsString(thread, cmd.parts[1])
		ruSetItemNameOnList(varIdx, name, listIdx)

		// Draw the var cmd if it's visible.
		//if ma.vars[varIdx].vis
		//if ma.vars[varIdx].rv.vis
			ruDrawVar(varIdx)			
		//endif
						
	endif
	
endfunction

//-----------------------------------------------------
// "S:set imte value ,T:,S: at ,N:1,S: in list ,V:"
// Set the name of a list item.
//
function ruSetListItemValuePtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local listIdx as integer
	local valueIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 5)

	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction
		endif

		listIdx = ruEvalPartAsInt(thread, cmd.parts[3])

		if listIdx < 0
			listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
		endif

		value = ruEvalPartAsString(thread, cmd.parts[1])
		ruSetItemValueOnList(varIdx, value, listIdx)

		// Draw the var cmd if it's visible.
		//if ma.vars[varIdx].vis
		//if ma.vars[varIdx].rv.vis
			ruDrawVar(varIdx)			
		//endif
						
	endif
	
endfunction

//-----------------------------------------------------
// "S:remove item at ,N:1,S: in list ,V:var"
// Remove an item from the list variable. That is, converts
// this variable to a list, and removes the item.
//
function ruRemoveListItemPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local listIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 3)

	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction
		endif
		
		listIdx = ruEvalPartAsInt(thread, cmd.parts[1])

		if listIdx < 0
			listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
		endif

		ruRemoveItemFromList(varIdx, listIdx)
		
		// Draw the var cmd if it's visible.
		//if ma.vars[varIdx].vis
		//if ma.vars[varIdx].rv.vis
			ruDrawVar(varIdx)			
		//endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Add a value to a list var, convert if necessary.
//
function ruAddItemToList(listVar as integer, name as string, value as string, listIdx as integer)

	local varItem as VarItem
	
	if ma.vars[listVar].typ <> VAR_TYPE_LIST
		exitfunction
	endif

	varItem.name = name
	varItem.value = value
	varItem.parent = listVar				
	
	if listIdx < 0
		listIdx = ma.vars[listVar].runList.length + 2 + listIdx
	endif
		
	if listIdx > 0
		
		if (listIdx - 1) <= ma.vars[listVar].runList.length			
			ma.vars[listVar].runList.insert(varItem, listIdx - 1)			
		else			
			listIdx = 0 // Append.			
		endif
	endif
					
	if listIdx = 0 // Append.
		ma.vars[listVar].runList.insert(varItem)
	endif			

endfunction

//-----------------------------------------------------
// Set the name of a list item.
//
function ruSetItemNameOnList(listVar as integer, name as string, listIdx as integer)

	local varItem as VarItem
	
	if ma.vars[listVar].typ <> VAR_TYPE_LIST
		exitfunction
	endif
	
	if listIdx < 0
		listIdx = ma.vars[listVar].runList.length + 2 + listIdx
	endif
		
	if listIdx > 0		
		if (listIdx - 1) <= ma.vars[listVar].runList.length			
			ma.vars[listVar].runList[listIdx - 1].name = name			
		endif
	endif

endfunction

//-----------------------------------------------------
// Set the name of a list item.
//
function ruSetItemValueOnList(listVar as integer, value as string, listIdx as integer)

	local varItem as VarItem
	
	if ma.vars[listVar].typ <> VAR_TYPE_LIST
		exitfunction
	endif
	
	if listIdx < 0
		listIdx = ma.vars[listVar].runList.length + 2 + listIdx
	endif
		
	if listIdx > 0		
		if (listIdx - 1) <= ma.vars[listVar].runList.length			
			ma.vars[listVar].runList[listIdx - 1].value = value			
		endif
	endif

endfunction

//-----------------------------------------------------
// Add a value to a list var, convert if necessary.
//
function ruAddListToList(listVar as integer, valueVar as integer, listIdx as integer)

	local varItem as VarItem
	local i as integer
	local tmpList as VarItem[]
	
	if ma.vars[listVar].typ <> VAR_TYPE_LIST
		exitfunction
	endif

	if listIdx < 0
		listIdx = ma.vars[listVar].runList.length + 2 + listIdx
	endif

	// Make a copy of the list.
	tmpList = ma.vars[valueVar].runList
	
	for i = 0 to tmpList.length

		varItem.name = tmpList[i].name
		varItem.value = tmpList[i].value
		varItem.parent = listVar
		varItem.cmd = 0				
				
		if listIdx > 0
			
			if (listIdx - 1) <= ma.vars[listVar].runList.length
						
				ma.vars[listVar].runList.insert(varItem, listIdx - 1)
				// Just added one, move the idx for next insert.
				inc listIdx
		
			else
							
				listIdx = 0 // Append.
							
			endif
			
		endif
						
		if listIdx = 0 // Append.
			ma.vars[listVar].runList.insert(varItem)
		endif

	next	

endfunction

//-----------------------------------------------------
// Remove a value from a list var.
//
function ruRemoveItemFromList(listVar as integer, listIdx as integer)

	local itemVar as integer

	if ma.vars[listVar].typ <> VAR_TYPE_LIST
		exitfunction
	endif

	if listIdx < 0
		listIdx = ma.vars[listVar].runList.length + 2 + listIdx
	endif

	if listIdx > 0
		
		if (listIdx - 1) <= ma.vars[listVar].runList.length			
			ma.vars[listVar].runList.remove(listIdx - 1)
		endif
	endif
		
endfunction

//-----------------------------------------------------
// Set case sensitivity for find operations.
//
function ruSetIgnoreCasePtr(thread ref as Thread, cmd ref as Cmd)

	local ignoreCase as integer
	
	ignoreCase = ruEvalPartAsBool(thread, cmd.parts[1])
	ru.rt.ignoreCase = ignoreCase
	
endfunction

//-----------------------------------------------------
// Stop this event.
//
function ruStopCurrentPtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string
	local ival as integer 

	sval = ruEvalPartAsString(thread, cmd.parts[1])
	ival = val(cdGetObjVarVals(OBJ_VAR_STOP, sval, true))

	// if ru.rt.debug then ruDebug(3, "ruStopBlockPtr start, thread.id=" + str(thread.id) + ", thread.thingIdx=" + str(thread.thingIdx) + ", clonedIdx=" + str(ma.things[thread.thingIdx].clonedIdx))

	if ival = 0 // This block.

		thread.active = false
		// if ru.rt.debug then ruDebug(3, "ruStopBlockPtr this thread deactivated")

	elseif ival = 1
		ruStopOtherBlocksPtr(thread, false)
	elseif ival = 2
		ruStopOtherBlocksPtr(thread, true)
	elseif ival = 3
		ruStopAllPtr(thread)
	endif
	
endfunction

//-----------------------------------------------------
// Stop all other blocks except the one passed.
//
function ruStopOtherBlocksPtr(thread ref as Thread, all as integer)

	local i as integer
	local threadIdx as integer
	
	for i = 0 to ru.rt.threads.length

		// if ru.rt.debug then ruDebug(3, "ruStopOthersBlocksPtr: checking thread.id=" + str(ru.rt.threads[i].id) + ", parent=" + str(ru.rt.threads[i].parent) + ", thingIdx=" + str(ru.rt.threads[i].thingIdx) + ", clonedIdx=" + str(ma.things[ru.rt.threads[i].thingIdx].clonedIdx) + ", event=" + str(ru.rt.threads[i].event) + ", active=" + str(ru.rt.threads[i].active))

		if (all or ru.rt.threads[i].id <> thread.id) and ru.rt.threads[i].thingIdx = thread.thingIdx

			if ma.things[thread.thingIdx].clonedIdx > -1
				threadIdx = ruFindThreadById(ru.rt.threads[i].parent)
			else
				threadIdx = i
			endif

			// if ru.rt.debug then ruDebug(3, "ruStopOthersBlocksPtr: threadIdx=" + str(threadIdx))
			
			ru.rt.threads[threadIdx].active = false
			// if ru.rt.debug then ruDebug(3, "ruStopOthersBlocksPtr: set thread to inactive")

		endif

	next
	
endfunction

//-----------------------------------------------------
// Stop all event.
//
function ruStopAllPtr(thread ref as Thread)

	local i as integer
	
	for i = 0 to ru.rt.threads.length
		ru.rt.threads[i].active = false		
	next
	
endfunction

//-----------------------------------------------------
// Find an item in a value or in a list in reverse. Returns the position.
// "S:find ,T:,S: in ,T:,S: start at ,N:1"
//
function ruFindItemPtr(thread ref as Thread, cmd ref as Cmd)

	local rev as integer
	local ret as integer

	rev = ruEvalPartAsBool(thread, cmd.parts[7])

	if rev
		ret = ruFindItemRevPtr(thread, cmd)
	else 
		ret = ruFindItemFwdPtr(thread, cmd)
	endif
	
endfunction ret

//-----------------------------------------------------
// Find an item in a value or in a list in reverse. Returns the position.
// "S:find ,T:,S: in ,T:,S: start at ,N:1"
//
function ruFindItemFwdPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local ret as integer
	local s as string
	local t as string
	local find as string
	local listIdx as integer
	local i as integer

	find = ruEvalPartAsString(thread, cmd.parts[1])
	varIdx = ruEvalPartAsList(thread, cmd.parts[3], false)
	listIdx = ruEvalPartAsInt(thread, cmd.parts[5])

	if varIdx

		if ma.vars[varIdx].typ = VAR_TYPE_LIST

			if listIdx < 0
				listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
			endif

			if listIdx > 0
				dec listIdx
			else
				listIdx = 0
			endif

			ret = 0
			
			for i = listIdx to ma.vars[varIdx].runList.length
				
				if not ru.rt.ignoreCase
					if ma.vars[varIdx].runList[i].value = find
						ret = i + 1
					endif
				else
					if lower(ma.vars[varIdx].runList[i].value) = lower(find)
						ret = i + 1
					endif
				endif
				
			next

		else

			// Not a list, use normal value find below.
			varIdx = 0
			
		endif
		
	endif
	
	if not varIdx
		
		s = ruEvalPartAsString(thread, cmd.parts[3])
		ret = FindString(s, find, ru.rt.ignoreCase, listIdx)
			
	endif
	
endfunction ret

//-----------------------------------------------------
// Find an item in a value or in a list in reverse. Returns the position.
// "S:find rev ,T:,S: in ,T:,S: start at ,N:1"
//
function ruFindItemRevPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local ret as integer
	local s as string
	local t as string
	local find as string
	local listIdx as integer
	local i as integer

	find = ruEvalPartAsString(thread, cmd.parts[1])
	//varIdx = ruGetVarCmdPtr(thread, cmd, 3)
	varIdx = ruEvalPartAsList(thread, cmd.parts[3], false)
	listIdx = ruEvalPartAsInt(thread, cmd.parts[5])

	if varIdx

		if ma.vars[varIdx].typ = VAR_TYPE_LIST

			if listIdx < 0
				listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
			endif

			if listIdx > 0
				dec listIdx
			else
				listIdx = ma.vars[varIdx].runList.length
			endif

			ret = 0
			
			//for i = 0 to ma.vars[varIdx].runList.length
			for i = listIdx to 0 step -1

				if not ru.rt.ignoreCase
					if ma.vars[varIdx].runList[i].value = find
						ret = i + 1
					endif
				else
					if lower(ma.vars[varIdx].runList[i].value) = lower(find)
						ret = i + 1
					endif
				endif
				
			next

		else

			// Not a list, use normal value find below.
			varIdx = 0
			
		endif
		
	endif
	
	if not varIdx
		
		s = ruEvalPartAsString(thread, cmd.parts[3])
		ret = FindStringReverse(s, find, ru.rt.ignoreCase, listIdx)
			
	endif
	
endfunction ret

//-----------------------------------------------------
// Get the list length.
// "S: length ,T:"
//
function ruGetListLenPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local ret as integer
	local s as string 

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	if varIdx

		if ma.vars[varIdx].typ = VAR_TYPE_LIST
			
			ret = ma.vars[varIdx].runList.length + 1
			
		else
			
			// Not a list var, treat as a string.
			varIdx = 0
			
		endif
		
	endif

	if not varIdx
		
		s = ruEvalPartAsString(thread, cmd.parts[1])
		ret = len(s)
			
	endif
	
endfunction ret

//-----------------------------------------------------
// Get the list item at a position.
// "S:item ,N:1,S: in list ,V:"
//
function ruGetListItemPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local listIdx as integer
	local subVar as integer
	local s as string
	local ln as integer
	local count as integer
	local retIdx as integer
	local varItem as VarItem
	
	listIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	varIdx = ruGetVarCmdPtr(thread, cmd, 3)
	//ln = ruEvalPartAsInt(thread, cmd.parts[5])	
	value = ""
	count = 0
	
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction value
		endif
			
		if listIdx < 0
			listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
		endif
			
		if listIdx > 0
			
			if (listIdx - 1) <= ma.vars[varIdx].runList.length
									
				value = ma.vars[varIdx].runList[listIdx - 1].value
			
			endif
						
		endif

	endif
	
endfunction value

//-----------------------------------------------------
//
function ruGetParamValuePtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local name as string
	local listIdx as integer
	local subVar as integer
	local s as string
	local ln as integer
	local count as integer
	local retIdx as integer
	local varItem as VarItem
	local tmpVarIdx as integer
	
	listIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	varIdx = thread.argList
	value = ""
	name = ""
	count = 0
	
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction value
		endif
			
		//if listIdx < 0
		//	listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
		//endif
			
		if listIdx > 0
			
			if (listIdx - 1) <= ma.vars[varIdx].runList.length
									
				name = ma.vars[varIdx].runList[listIdx - 1].name
				value = ma.vars[varIdx].runList[listIdx - 1].value
				
				if name = "list"
					
					tmpVarIdx = val(value)
					value = ma.vars[tmpVarIdx].name

				endif
			
			endif
						
		endif

	endif
	
endfunction value

//-----------------------------------------------------
// Get the list item at a position.
// "S:item name ,N:1,S: in list ,V:"
//
function ruGetListItemNamePtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local name as string
	local listIdx as integer
	local subVar as integer
	local s as string
	local ln as integer
	local count as integer
	local retIdx as integer
	local varItem as VarItem
	
	listIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	varIdx = ruGetVarCmdPtr(thread, cmd, 3)
	//ln = ruEvalPartAsInt(thread, cmd.parts[5])	
	name = ""
	count = 0
	
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction name
		endif
			
		if listIdx < 0
			listIdx = ma.vars[varIdx].runList.length + 2 + listIdx
		endif
			
		if listIdx > 0
			
			if (listIdx - 1) <= ma.vars[varIdx].runList.length
									
				name = ma.vars[varIdx].runList[listIdx - 1].name
			
			endif
						
		endif

	endif
	
endfunction name

//-----------------------------------------------------
// Get the list item index for an item with value.
// "S:index by name,T:,S: in list ,V:"
//
function ruGetListItemValueIndexPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local i as integer
	local idx as integer
	
	value = ruEvalPartAsString(thread, cmd.parts[1])
	varIdx = ruGetVarCmdPtr(thread, cmd, 3)
	idx = 0 // Not found.
	
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction 0
		endif
	
		for i = 0 to ma.vars[varIdx].runList.length
			
			if ma.vars[varIdx].runList[i].value = value
				
				idx = i + 1
				exit
				
			endif
			
		next 

	endif
	
endfunction idx

//-----------------------------------------------------
// Get the list item index for an item with name.
// "S:index by name,T:,S: in list ,V:"
//
function ruGetListItemNameIndexPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local name as string
	local i as integer
	local idx as integer
	
	name = ruEvalPartAsString(thread, cmd.parts[1])
	varIdx = ruGetVarCmdPtr(thread, cmd, 3)
	idx = 0 // Not found.
	
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction 0
		endif
	
		for i = 0 to ma.vars[varIdx].runList.length
			
			if ma.vars[varIdx].runList[i].name = name
				
				idx = i + 1
				exit
				
			endif
			
		next 

	endif
	
endfunction idx

//-----------------------------------------------------
// Get the list item index for an item with name.
// "S:index by name,T:,S: in list ,V:"
//
function ruGetListItemByNamePtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local name as string
	local value as string
	local i as integer
	local idx as integer
	
	name = ruEvalPartAsString(thread, cmd.parts[1])
	value = ""
	varIdx = ruGetVarCmdPtr(thread, cmd, 3)
	idx = 0 // Not found.
	
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction ""
		endif
	
		for i = 0 to ma.vars[varIdx].runList.length
			
			if ma.vars[varIdx].runList[i].name = name
				
				value = ma.vars[varIdx].runList[i].value
				exit
				
			endif
			
		next 

	endif
	
endfunction value

//-----------------------------------------------------
// Do mid$().
// "S:value at ,N:1,S: with len, N:1,S: in ,T:"
//
function ruGetValuePtr(thread ref as Thread, cmd ref as Cmd)

	local idx as integer
	local ln as integer
	local value as string
	local s as string
	
	idx = ruEvalPartAsInt(thread, cmd.parts[1])
	ln = ruEvalPartAsInt(thread, cmd.parts[3])	
	s = ruEvalPartAsString(thread, cmd.parts[5])
	value = ""

	if idx < 0
		idx = len(s) + 1 + idx
	endif

	if idx > 0 and ln > 0
		if idx <= len(s)			
			value = mid(s, idx, ln)
		endif
		
	endif
	
endfunction value

//-----------------------------------------------------
// Do replacestring$().
//
function ruReplaceValuePtr(thread ref as Thread, cmd ref as Cmd)

	local find as string
	local repl as string
	local s as string
	local count as integer
	local pos as integer
	local findLen as integer
	local replLen as integer
	local count2 as integer
	
	find = ruEvalPartAsString(thread, cmd.parts[1])
	findLen = len(find)
	repl = ruEvalPartAsString(thread, cmd.parts[3])
	replLen = len(repl)
	s = ruEvalPartAsString(thread, cmd.parts[5])
	count = ruEvalPartAsInt(thread, cmd.parts[7])
	pos = 1

	if count >= 0
		
		pos = FindString(s, find, ru.rt.ignoreCase, pos)
		count2 = count

		while (count = 0 or count2 > 0) and pos > 0

			s = left(s, pos - 1) + repl + mid(s, pos + findLen, -1)
			pos = pos + replLen
			pos = FindString(s, find, ru.rt.ignoreCase, pos)
			dec count2
			
		endwhile

	endif
	
endfunction s

//-----------------------------------------------------
// Join the list separated by a delimiter.
// "S:join list ,V:,S: by ,T:"
//
function ruJoinListPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local listIdx as integer
	local delim as string
	local i as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)
	value = ""
	
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction value
		endif
			
		delim = ruEvalPartAsString(thread, cmd.parts[3])
		value = ruJoinList(ma.vars[varIdx].runList, delim)
						
	endif
	
endfunction value

//-----------------------------------------------------
// Join a list separated by a delimiter.
//
function ruJoinList(list ref as VarItem[], delim as string)

	local value as string
	local i as integer

	value = ""
	
	for i = 0 to list.length

		if i > 0
			value = value + delim
		endif

		value = value + list[i].value
		
	next

endfunction value

//-----------------------------------------------------
// Clear a list.
// S:clear list ,V:"
//
function ruClearVarPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local listIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)
	value = ""
	
	if varIdx

		ruClearVar(varIdx)
			
		// Draw the var cmd if it's visible.
		//if ma.vars[varIdx].vis
		//if ma.vars[varIdx].rv.vis
			ruDrawVar(varIdx)			
		//endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Split a text into a list var.
// "S:split text ,T:,S: by ,T:,S: into list ,V:"
//
function ruSplitTextListPtr(thread ref as Thread, cmd ref as Cmd)

	local varIdx as integer
	local value as string
	local count as integer
	local text as string
	local delim as string
	local i as integer
	local varItem as VarItem

	varIdx = ruCreateThreadVar(thread, VAR_TYPE_LIST)
	
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_LIST
			exitfunction 0
		endif
		
		text = ruEvalPartAsString(thread, cmd.parts[1])
		delim = ruEvalPartAsString(thread, cmd.parts[3])

		count = CountStringTokens2(text, delim)

		for i = 1 to count

			value = GetStringToken2(text, delim, i)
			
			varItem.name = ""
			varItem.value = value
			varItem.parent = varIdx
			varItem.cmd = 0
			ma.vars[varIdx].runList.insert(varItem) // Append.
			
		next
								
	endif
	
endfunction varIdx

//-----------------------------------------------------
// Copy a list var to another.
//
function ruCloneListVar(thread ref as Thread, fromVarIdx as integer)

	local toVarIdx as integer
	local i as integer
	local varItem as VarItem

	if ma.vars[fromVarIdx].typ <> VAR_TYPE_LIST
		exitfunction 0
	endif

	toVarIdx = ruCreateThreadVar(thread, VAR_TYPE_LIST)
	
	if toVarIdx
		
		for i = 0 to ma.vars[fromVarIdx].runList.length
			
			varItem.name = ""
			varItem.value = ma.vars[fromVarIdx].runList[i].value
			varItem.parent = toVarIdx
			varItem.cmd = 0
			ma.vars[toVarIdx].runList.insert(varItem) // Append.
			
		next
								
	endif
	
endfunction toVarIdx

//-----------------------------------------------------
// Split a text into a list var.
// "S:split text ,T:,S: by ,T:,S: into list ,V:"
//
function ruSplitTextStrPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string
		
	text = ruEvalPartAsString(thread, cmd.parts[1])
	
endfunction text

//-----------------------------------------------------
//
function ruSetPrintBgColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string 
	
	text = ruEvalPartAsString(thread, cmd.parts[1])
	ru.rt.displayBgColor = coMakeColor(text)
	guiSetPrintTipColors(ru.rt.displayBgColor, ru.rt.displayBorderColor, ru.rt.displayTextColor)
	
endfunction

//-----------------------------------------------------
//
function ruSetPrintBorderColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string
	
	text = ruEvalPartAsString(thread, cmd.parts[1])
	ru.rt.displayBorderColor = coMakeColor(text)
	guiSetPrintTipColors(ru.rt.displayBgColor, ru.rt.displayBorderColor, ru.rt.displayTextColor)

endfunction

//-----------------------------------------------------
//
function ruSetPrintTextColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as String
	
	text = ruEvalPartAsString(thread, cmd.parts[1])
	ru.rt.displayTextColor = coMakeColor(text)
	guiSetPrintTipColors(ru.rt.displayBgColor, ru.rt.displayBorderColor, ru.rt.displayTextColor)

endfunction

//-----------------------------------------------------
//
function ruSetPrintFontPtr(thread ref as Thread, cmd ref as Cmd)

	local sval as String
	local ival as integer
	
	sval = ruEvalPartAsString(thread, cmd.parts[1])
	ival = val(cdGetObjVarVals(OBJ_VAR_FONT, sval, true))
	ru.rt.displayFont = ival
	guiSetPrintTipFont(ru.rt.displayFont, ru.rt.displayFontSize)

endfunction

//-----------------------------------------------------
//
function ruSetPrintFontSizePtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	
	ival = ruEvalPartAsInt(thread, cmd.parts[1])
	
	if ival < LD_TEXT_SIZE_MIN
		ival = LD_TEXT_SIZE_MIN
	elseif ival > LD_TEXT_SIZE_MAX
		ival = LD_TEXT_SIZE_MAX
	endif
	
	ru.rt.displayFontSize = ival
	guiSetPrintTipFont(ru.rt.displayFont, ru.rt.displayFontSize)

endfunction

//-----------------------------------------------------
//
function ruGetOtherSpritePtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string
	local ival as integer
	local otherThingIdx as integer
	local ret as integer
	
	sval = ruEvalPartAsString(thread, cmd.parts[0])
	//otherThingIdx = ruEvalPartAsInt(thread, cmd.parts[2])
	otherThingIdx = maFindThingById(ru.appIdx, ruEvalPartAsString(thread, cmd.parts[2]))
	
	if sval <> "" and otherThingIdx > -1

		ival = val(cdGetObjVarVals(OBJ_VAR_INFO, sval, true))

		if ival = CO_INFO_X_POS
			ret = getposx(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_Y_POS
			ret = getposy(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_ANGLE
			ret = getangle(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_FRAME
			ret = ma.things[otherThingIdx].rImgIdx + 1
		elseif ival = CO_INFO_X_SIZE
			ret = getscalex(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_Y_SIZE
			ret = getscaley(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_COLOR
			ret = coGetSpriteColor(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_TRANS
			ret = getalpha(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_WIDTH
			ret = getwidth(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_HEIGHT
			ret = GetHeight(ma.things[otherThingIdx].obj)
		elseif ival = CO_INFO_DEPTH
			ret = getdepth(ma.things[otherThingIdx].obj)
		endif
		
	endif

endfunction ret

//-----------------------------------------------------
//
function ruGetOtherSpriteVisPtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string
	local ival as integer
	local otherThingIdx as integer
	local ret as integer
	
	//otherThingIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	otherThingIdx = maFindThingById(ru.appIdx, ruEvalPartAsString(thread, cmd.parts[1]))
	
	if otherThingIdx > -1
		ret = GetVisible(ma.things[otherThingIdx].obj)
	else 
		ret = false
	
	endif

endfunction ret

//-----------------------------------------------------
// Check if the sprite ( off screen.
//
function ruGetSpriteOffScreenPtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string
	local ival as integer
	local otherThingIdx as integer
	local ret as integer
	
	//otherThingIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	otherThingIdx = maFindThingById(ru.appIdx, ruEvalPartAsString(thread, cmd.parts[1]))
	
	if otherThingIdx > -1
		ret = rugetspriteoffscreen(ma.things[otherThingIdx].obj)
	else 
		ret = false
	
	endif

endfunction ret

//-----------------------------------------------------
// Check if the sprite is completely off screen.
//
function ruGetSpriteOffScreen(spr as integer)
	
	local ret as integer
	
	if getspritex(spr) > co.w or getspritey(spr) > co.h or (getspritex(spr) + getspritewidth(spr)) < 0 or (getspritey(spr) + GetSpriteHeight(spr)) < 0
		ret = true
	else 
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Set the names button in settings to the current setting value.
//
function ruSetSettingsRunPosButton()

	local idx as integer

	idx = guiFindBarButtonById(ru.morebar, BUT_RUNNER_MENU_POS)

	if ld.set.runButPos = DIR_NE

		SetSpriteAngle(ru.morebar.buts[idx].icon, -135)
		//guiSetButtonText(ru.morebar.buts[idx], "top-right")
		ru.morebar.buts[idx].help = "Tap to change the position of toolbar to bottom-right."
		
	elseif ld.set.runButPos = DIR_NW

		SetSpriteAngle(ru.morebar.buts[idx].icon, 135)
		//guiSetButtonText(ru.morebar.buts[idx], "top-left")
		ru.morebar.buts[idx].help = "Tap to change the position of toolbar to top-right."

	elseif ld.set.runButPos = DIR_SE

		SetSpriteAngle(ru.morebar.buts[idx].icon, -45)
		//guiSetButtonText(ru.morebar.buts[idx], "bot-right")
		ru.morebar.buts[idx].help = "Tap to change the position of toolbar to bottom-left."

	elseif ld.set.runButPos = DIR_SW

		SetSpriteAngle(ru.morebar.buts[idx].icon, 45)
		//guiSetButtonText(ru.morebar.buts[idx], "bot-left")
		ru.morebar.buts[idx].help = "Tap to change the position of toolbar to top-left."

	endif

endfunction

//-----------------------------------------------------
// Set the auto run button in settings to the current setting value.
//
function ruSetSettingsAutoRunButton()

	local idx as integer

	idx = guiFindBarButtonById(ru.morebar, BUT_RUNNER_AUTO_RUN)

	if ld.set.autoRun
		guiSetButtonIcon2(ru.morebar.buts[idx], gui.onImg)		
	else
		guiSetButtonIcon2(ru.morebar.buts[idx], gui.offImg)
	endif

endfunction

//-----------------------------------------------------
// Check local buttons, then fire global.
//
function ruButtonAction(butId as integer, obj as integer)

	local resume as integer

	resume = true
	
	if butId = BUT_RUNNER_BACK

		resume = false
		OnButtonAction(butId, 0) // Get out now.
		
	elseif butId = BUT_RUNNER_RESET

		resume = false 
		ruReset()
		
	elseif butId = BUT_RUNNER_PAUSE
		
		ruPause()
		
	elseif butId = BUT_RUNNER_RESUME
		
		ruResume()
		
	elseif butId = BUT_RUNNER_SNAP
		
		ruSnap()
				
	elseif butId = BUT_RUNNER_START_RECORD
		
		ruStartRecording()

	elseif butId = BUT_RUNNER_END_RECORD
		
		ruEndRecording()
				
	elseif butId = BUT_RUNNER_MENU_POS
		
		cdButtonAction(butId, obj)
		
	elseif butId = BUT_RUNNER_AUTO_RUN
		
		cdButtonAction(butId, obj)
		
	endif

	if resume
		if ru.executing = RU_RUN
			ru.executing = RU_RESUME // To trigger resuming funky things, like edit boxes.
		endif
	endif
	
endfunction

//-----------------------------------------------------
// Call back from coder.
//
function ruCallbackFromCoder(butId as integer)

	if butId = BUT_RUNNER_MENU_POS

		ruSetSettingsRunPosButton()
		ruSetButPos()

	elseif butId = BUT_RUNNER_AUTO_RUN

		ruSetSettingsAutoRunButton()

	endif

endfunction

//-----------------------------------------------------
//
function ruSetXPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	setposx(ma.things[thread.thingIdx].obj, ret)

	ruUpdatePrintPtr(thread, cmd)
	ruUpdatePenPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruMoveXPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	addposx(ma.things[thread.thingIdx].obj, ret)

	ruUpdatePrintPtr(thread, cmd)
	ruUpdatePenPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruSetYPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	setposy(ma.things[thread.thingIdx].obj, ret)

	ruUpdatePrintPtr(thread, cmd)
	ruUpdatePenPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruMoveYPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	addposy(ma.things[thread.thingIdx].obj, ret)

	ruUpdatePrintPtr(thread, cmd)
	ruUpdatePenPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruSetPosPtr(thread ref as Thread, cmd ref as Cmd)

	local x as float
	local y as float

	x = ruEvalPartAsFloat(thread, cmd.parts[1])
	y = ruEvalPartAsFloat(thread, cmd.parts[3])

		setposx(ma.things[thread.thingIdx].obj, x)
	setposy(ma.things[thread.thingIdx].obj, y)

	ruUpdatePrintPtr(thread, cmd)
	ruUpdatePenPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruSetRandomPosPtr(thread ref as Thread, cmd ref as Cmd)

	local x as float
	local y as float

	x = random2(0, ru.w - 1)
	y = random2(0, ru.h - 1)
	setposx(ma.things[thread.thingIdx].obj, x)
	setposy(ma.things[thread.thingIdx].obj, y)

	ruUpdatePrintPtr(thread, cmd)
	ruUpdatePenPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruSetAnglePtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	setangle(ma.things[thread.thingIdx].obj, ret)

endfunction

//-----------------------------------------------------
//
function ruMoveAnglePtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	addangle(ma.things[thread.thingIdx].obj, ret)
	
endfunction

//-----------------------------------------------------
//
function ruPointAtPosPtr(thread ref as Thread, cmd ref as Cmd)

	local sx as float
	local sy as float
	local ex as float
	local ey as float
	local ang as float

	sx = getposx(ma.things[thread.thingIdx].obj)
	sy = getposy(ma.things[thread.thingIdx].obj)
	ex = ruEvalPartAsFloat(thread, cmd.parts[1])
	ey = ruEvalPartAsFloat(thread, cmd.parts[3])

	ang = atanfull(ex - sx, ey - sy)
	setangle(ma.things[thread.thingIdx].obj, ang)
	
endfunction

//-----------------------------------------------------
//
function ruPointAtThingPtr(thread ref as Thread, cmd ref as Cmd)

	local sx as float
	local sy as float
	local ex as float
	local ey as float
	local thingIdx as integer
	local ang as float

	sx = getposx(ma.things[thread.thingIdx].obj)
	sy = getposy(ma.things[thread.thingIdx].obj)

	thingIdx = ruGetThingCmdPtr(thread, cmd, 1)

/*
	if cmd.parts[1].info <> ""
		//thingIdx = ruEvalPartAsInt(thread, cmd.parts[1])
		thingIdx = maFindThingById(ru.appIdx, ruEvalPartAsString(thread, cmd.parts[1]))
	else 
		thingIdx = -1
	endif
*/
	
	if thingIdx > -1
		
		ex = getposx(ma.things[thingIdx].obj)
		ey = getposy(ma.things[thingIdx].obj)

		ang = atanfull(ex - sx, ey - sy)
		setangle(ma.things[thread.thingIdx].obj, ang)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruWrapScreenXPtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string
	local ival as integer 

	sval = ruEvalPartAsString(thread, cmd.parts[1])
	ival = val(cdGetObjVarVals(OBJ_VAR_WRAP, sval, true))
	ma.things[thread.thingIdx].wrapX = ival
	
endfunction

//-----------------------------------------------------
//
function ruWrapScreenYPtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string
	local ival as integer 

	sval = ruEvalPartAsString(thread, cmd.parts[1])
	ival = val(cdGetObjVarVals(OBJ_VAR_WRAP, sval, true))
	ma.things[thread.thingIdx].wrapY = ival

endfunction

//-----------------------------------------------------
//
function ruMoveForwardPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float
	local sx as float
	local sy as float
	local ang as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	ruMoveForwardAmtPtr(thread, ret)
	
	/*
	ang = getangle(ma.things[thread.thingIdx].obj)
	sx = Sin(ang) * ret
	sy = -Cos(ang) * ret
	//AddPos(ma.things[thread.thingIdx].obj, sx * ru.delta, sy * ru.delta)	
	AddPos(ma.things[thread.thingIdx].obj, sx, sy)	
	*/
	
	ruUpdatePrintPtr(thread, cmd)
	ruUpdatePenPtr(thread, cmd)

endfunction

//-----------------------------------------------------
//
function ruMoveForwardAmtPtr(thread ref as Thread, ret as float)

	local sx as float
	local sy as float
	local ang as float

	//ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	ang = getangle(ma.things[thread.thingIdx].obj)
	sx = Sin(ang) * ret
	sy = -Cos(ang) * ret
	//AddPos(ma.things[thread.thingIdx].obj, sx * ru.delta, sy * ru.delta)	
	AddPos(ma.things[thread.thingIdx].obj, sx, sy)	

	//ruUpdatePrintPtr(thread, cmd)
	//ruUpdatePenPtr(thread, cmd)

endfunction

//-----------------------------------------------------
//
function ruEdgeBouncePtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string 
	local ival as integer
	local rval as float
	local edges as string
	local matchCollEdges as integer
	local bounds as Bounds

	sval = ruEvalPartAsString(thread, cmd.parts[3])
	ival = val(cdGetObjVarVals(OBJ_VAR_BOUNCE, sval, true)) // The bound type.
	rval = ruEvalPartAsFloat(thread, cmd.parts[5]) // The random angle.

	edges = cdGetPartAsString(cmd.parts[1]) // The edges param.
	matchCollEdges = ruGetCollEdgeValue(edges)	
	
	bounds.x0 = 0
	bounds.y0 = 0
	bounds.x1 = co.w - 1
	bounds.y1 = co.h - 1
	
	ruApplyBounce(thread, bounds, matchCollEdges, ival, rval)
	ruUpdatePrintPtr(thread, cmd)
	ruUpdatePenPtr(thread, cmd)

endfunction

//-----------------------------------------------------
//
function ruThingBouncePtr(thread ref as Thread, cmd ref as Cmd)
	
	local sval as string 
	local ival as integer
	local rval as float
	local edges as string
	local matchCollEdges as integer
	local selThingIdx as integer
	local hitThingIdx as integer
	local sprId as string
	local spr as integer
	local hit as integer // The hit sprite.
	local ang as float
	local nang as float
	local bounds as Bounds
	local match as integer
	local i as integer

	if ma.things[thread.thingIdx].collThings.length = -1 // No collision.
		exitfunction
	endif

	sval = ruEvalPartAsString(thread, cmd.parts[3])
	ival = val(cdGetObjVarVals(OBJ_VAR_BOUNCE, sval, true)) // The bound type.
	rval = ruEvalPartAsFloat(thread, cmd.parts[5]) // The random angle.

	selThingIdx = ruGetThingCmdPtr(thread, cmd, 1)

	//sprId = cdGetPartAsString(cmd.parts[1]) // The sprite param.
	//hitThingIdx = -1
	
	if selThingIdx > -1

		//if ma.things[thread.thingIdx].collThings.find(hitThingIdx) = -1 // Not found, clear it.
		//	hitThingIdx = -1
		//endif
		match = false
		hitThingIdx = -1
		
		for i = 0 to ma.things[thread.thingIdx].collThings.length
			
			hitThingIdx = ma.things[thread.thingIdx].collThings[i]
			
			if ma.things[hitThingIdx].clonedIdx > -1 // Hit a clone.

				if ma.things[hitThingIdx].clonedIdx = selThingIdx // Is the clone's parent the same as the sel sprite?

					match = true
					exit
										
				endif

			elseif hitThingIdx = selThingIdx // The hit sprite is a sprite, check against the sel sprite.
				
				match = true
				exit
									
			endif	
									
		next
		
		if not match
			hitThingIdx = -1
		endif
									
	else 
		
		hitThingIdx = ma.things[thread.thingIdx].collThings[0] // First thing hit.
		
	endif
	
	if hitThingIdx > -1

		spr = getsprite(ma.things[thread.thingIdx].obj)
		ang = getangle(spr)
		nang = mod(ang, 360)	// Convert to 0 to 360 to make the check easier.					
		if nang < 0 then nang = 360 - nang

		hit = getsprite(ma.things[hitThingIdx].obj)
		
		if nang > 0 and nang < 90
			matchCollEdges = DIR_N || DIR_E
		elseif nang > 90 and nang < 180
			matchCollEdges = DIR_E || DIR_S
		elseif nang > 180 and nang < 270
			matchCollEdges = DIR_S || DIR_W
		elseif nang > 270 and nang < 360
			matchCollEdges = DIR_W || DIR_N
		elseif nang = 0
			matchCollEdges = DIR_N
		elseif nang = 90
			matchCollEdges = DIR_E
		elseif nang = 180
			matchCollEdges = DIR_S
		elseif nang = 270
			matchCollEdges = DIR_W
		endif			
		
		if hit
			bounds.x1 = getspritex(hit)
			bounds.x0 = bounds.x1 + GetSpriteWidth(hit)
			bounds.y1 = getspritey(hit)
			bounds.y0 = bounds.y1 + GetSpriteHeight(hit)
		endif
		
		ruApplyBounce(thread, bounds, matchCollEdges, ival, rval)
		ruUpdatePrintPtr(thread, cmd)
		ruUpdatePenPtr(thread, cmd)
		
	endif
	
endfunction

//-----------------------------------------------------
//
function ruApplyBounce(thread ref as Thread, bounds ref as Bounds, matchCollEdges as integer, bounceType as integer, rval as float)

	local ret as float
	local spr as integer
	local ang as float
	local nang as float
	local d as float

	spr = getsprite(ma.things[thread.thingIdx].obj)
	ang = getangle(spr)
	nang = mod(ang, 360)	// Convert to 0 to 360 to make the check easier.					
	if nang < 0 then nang = 360 - nang
				
	if matchCollEdges && DIR_W

		d = getspritex(spr)
	
		if d <= bounds.x0 // 0
			
			d = bounds.x0 - d
			
			ruMoveForwardAmtPtr(thread, -d)

			if nang > 270 // top-left
				
				if bounceType = 0 // right
					
					ang = ang + 90 // mod(ang + 90, 360)
					
				elseif bounceType = 1 // same
					
					ang = ang + ((360 - nang) * 2)
					
				elseif bounceType = 2 // rnd
					
					ang = ang + ((360 - nang) * 2)
					
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif
					
				endif
				
			elseif nang < 270 // bot-left
				
				if bounceType = 0 // right
					
					ang = ang - 90
					
				elseif bounceType = 1 // same
					
					ang = ang - ((nang - 180) * 2)
					
				elseif bounceType = 2 // rnd
					
					ang = ang - ((nang - 180) * 2)
					
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif
					
				endif
				
			else // = 270
				
				ang = ang + 180 // Bounce straight back.

				if bounceType = 2
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif					
				endif				

			endif
								
			setangle(spr, ang)
			ruMoveForwardAmtPtr(thread, d)
							
		endif
		
	endif
	
	if matchCollEdges && DIR_E

		d = getspritex(spr) + GetSpriteWidth(spr)
		
		if d > bounds.x1 // ru.w - 1

			d = d - bounds.x1 // (ru.w - 1)			
			ruMoveForwardAmtPtr(thread, -d)

			if nang < 90 // top-right
				
				if bounceType = 0 // right
					
					ang = ang - 90
					
				elseif bounceType = 1 // same
					
					//ang = ang + 180 + (180 - nang)
					ang = ang - (nang * 2)
					
				elseif bounceType = 2 // rnd
					
					//ang = ang + 180 + (180 - nang)
					ang = ang - (nang * 2)
					
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif
					
				endif
				
			elseif nang > 90 // bot-right
				
				if bounceType = 0 // right
					
					ang = ang + 90
					
				elseif bounceType = 1 // same
					
					ang = ang + ((180 - nang) * 2)
					
				elseif bounceType = 2 // rnd
					
					ang = ang + ((180 - nang) * 2)
					
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif
					
				endif

			else // nang = 90
				
				ang = ang + 180 // Bounce straight back.

				if bounceType = 2
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif					
				endif				

			endif
								
			setangle(spr, ang)
			ruMoveForwardAmtPtr(thread, d)
						
		endif
		
	endif
	
	if matchCollEdges && DIR_N

		d = getspritey(spr)
	
		if d <= bounds.y0 // 0
			
			d = bounds.y0 - d
			
			ruMoveForwardAmtPtr(thread, -d)

			if nang > 270 // top-left
				
				if bounceType = 0 // right
					
					ang = ang - 90
					
				elseif bounceType = 1 // same
					
					//ang = ang + 180 + (360 - nang)
					ang = ang - ((nang - 270) * 2)
					
				elseif bounceType = 2 // rnd
					
					//ang = ang + 180 + (360 - nang)
					ang = ang - ((nang - 270) * 2)
					
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif
					
				endif
				
			elseif nang < 90 // top-right
				
				if bounceType = 0 // right
					
					ang = ang + 90
					
				elseif bounceType = 1 // same
					
					//ang = ang + 90 + (90 - nang)
					ang = ang + ((90 - nang) * 2)
					
				elseif bounceType = 2 // rnd
					
					//ang = ang + 90 + (90 - nang)
					ang = ang + ((90 - nang) * 2)
					
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif
					
				endif
				
			elseif nang = 0

				ang = ang + 180 // Bounce straight back.

				if bounceType = 2
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif					
				endif				

			endif
								
			setangle(spr, ang)
			ruMoveForwardAmtPtr(thread, d)
				
		endif
		
	endif
	
	if matchCollEdges && DIR_S

		d = getspritey(spr) + GetSpriteHeight(spr)
	
		if d > bounds.y1 // ru.h - 1
			
			d = d - bounds.y1 // (ru.h - 1)
			ruMoveForwardAmtPtr(thread, -d)
			
			if nang < 180 // bot-right
				
				if bounceType = 0 // right
					
					ang = ang - 90
					
				elseif bounceType = 1 // same
					
					ang = ang - ((nang - 90) * 2)
					
				elseif bounceType = 2 // rnd
					
					ang = ang - ((nang - 90) * 2)
					
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif
					
				endif
				
			elseif nang > 180 // bot-left
				
				if bounceType = 0 // right
					
					ang = ang + 90
					
				elseif bounceType = 1 // same
					
					ang = ang + ((270 - nang) * 2)
					
				elseif bounceType = 2 // rnd
					
					ang = ang + ((270 - nang) * 2)
					
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif
					
				endif

			else // = 180
				
				ang = ang + 180 // Bounce straight back.

				if bounceType = 2
					if random(1, 2) = 1
						ang = ang - random(0, rval)
					else 
						ang = ang + random(0, rval)
					endif					
				endif				

			endif
								
			setangle(spr, ang)
			ruMoveForwardAmtPtr(thread, d)
		
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
//
function ruTileBgPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as string
	local cols as integer
	local rows as integer
	local img as integer
	local imgIdx as integer
	local size as float
	local sx as float
	local sy as float
	local x as integer
	local y as integer
	local subCmd as integer
	local imgId as string
	local thingIdx as integer
	local idxs as integer[]
	local spr as integer
	
	imgIdx = -1
	
	if cmd.parts[1].typ = PART_CMD
		
		subCmd = cdGetPartAsInt(cmd.parts[1])

		if subCmd > -1
			
			imgId = cdGetPartAsString(ma.cmds[subCmd].parts[0])
			thingIdx = cdGetPartFrameThing(imgId)
			cdFindFrameIdxById(thingIdx, imgId, idxs)
			imgIdx = idxs[1]
				
			if imgIdx < 1 or imgIdx > ma.things[thingIdx].imgs.length
				imgIdx = 0
			endif

		endif

	endif

	cols = ruEvalPartAsInt(thread, cmd.parts[3])
	if cols < 1 then cols = 1
	rows = ruEvalPartAsInt(thread, cmd.parts[5])
	if rows < 1 then rows = 1

	img = CreateImageColor(0, 0, 0, 0)
	ResizeImage(img, ru.w, ru.h)
	
	SetRenderToImage(img, 0)
	SetVirtualResolution(GetImageWidth(img), GetImageHeight(img))

	size = ru.w / cols
	sx = size / GetImageWidth(GetSpriteImageID(ma.things[thread.thingIdx].obj))
	size = ru.h / rows
	sy = size / GetImageHeight(GetSpriteImageID(ma.things[thread.thingIdx].obj))

	spr = CloneSprite(ma.things[thread.thingIdx].obj)
	SetSpriteScale(spr, sx, sy)

	// Reuse sx and sy as the sprite width and height for the below loop.
	sx = GetSpriteWidth(spr)
	sy = GetSpriteHeight(spr)
	
	for y = 0 to rows - 1
		
		for x = 0 to cols - 1

			SetSpritePosition(spr, x * sx, y * sy)
			DrawSprite(spr)
			
		next
		
	next 

	DeleteSprite(spr)
	SetRenderToScreen()
	SetVirtualResolution(ru.w, ru.h)

	// If there's an existing bg, clear it.
	if ma.things[thread.thingIdx].imgs[imgIdx].bgImg
		
		deleteimage(ma.things[thread.thingIdx].imgs[imgIdx].bgImg)
		ma.things[thread.thingIdx].imgs[imgIdx].bgImg = 0
		
	endif

	// Set the bg img.
	ma.things[thread.thingIdx].imgs[imgIdx].bgImg = img

	if imgIdx = ma.things[thread.thingIdx].rImgIdx

		SetSpriteImage(getsprite(ma.things[thread.thingIdx].obj), img)
		SetSpriteSize(getsprite(ma.things[thread.thingIdx].obj), -1, -1)

	endif
	
endfunction

//-----------------------------------------------------
// Stamp the sprite.
//
function ruStampSpritePtr(thread ref as Thread, cmd ref as Cmd)

	local spr as integer
	local ds as DrawSpr 
	
	ds.spr = ma.things[thread.thingIdx].obj
	ds.x = GetSpriteXByOffset(ds.spr)
	ds.y = GetSpriteYByOffset(ds.spr)
	ds.sx = GetSpriteScaleX(ds.spr)
	ds.sy = GetSpriteScaleY(ds.spr)
	ds.ang = GetSpriteAngle(ds.spr)
	ds.col = coGetSpriteColor(ds.spr)
	ds.vis = GetSpriteVisible(ds.spr)
	ma.things[thread.thingIdx].drawSprs.insert(ds)

endfunction

//-----------------------------------------------------
// Erase all stamp sprites.
//
function ruEraseStampSpritesPtr(thread ref as Thread, cmd ref as Cmd)

	ma.things[thread.thingIdx].drawSprs.length = -1
	
endfunction

//-----------------------------------------------------
//
function ruSetColorPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as string
	local col as integer
	
	ret = ruEvalPartAsString(thread, cmd.parts[1])
	//col = coHexToInt(ret)
	col = coMakeColor(ret)
	coSetSpriteColor(ma.things[thread.thingIdx].obj, col)
	
endfunction

//-----------------------------------------------------
// Set the color parts of red, green and blue.
//
function ruSetColorPartsPtr(thread ref as Thread, cmd ref as Cmd)

	local red as integer
	local green as integer
	local blue as integer
	local col as integer
	
	red = ruEvalPartAsInt(thread, cmd.parts[1])
	if red < 0
		red = 0
	elseif red > 255
		red = 255
	endif
	
	green = ruEvalPartAsInt(thread, cmd.parts[3])
	if green < 0
		green = 0
	elseif green > 255
		green = 255
	endif

	blue = ruEvalPartAsInt(thread, cmd.parts[5])
	if blue < 0
		blue = 0
	elseif blue > 255
		blue = 255
	endif
	
	col = MakeColor(red, green, blue)
	coSetSpriteColor(ma.things[thread.thingIdx].obj, col)
	
endfunction

//-----------------------------------------------------
// Change the color parts of red, green and blue.
//
function ruChangeColorPartsPtr(thread ref as Thread, cmd ref as Cmd)

	local red as integer
	local green as integer
	local blue as integer
	local col as integer
	
	col = coGetSpriteColor(ma.things[thread.thingIdx].obj)
	red = GetColorRed(col)
	green = GetColorGreen(col)
	blue = GetColorBlue(col)
	
	red = red + ruEvalPartAsInt(thread, cmd.parts[1])
	if red < 0
		red = 0
	elseif red > 255
		red = 255
	endif
	
	green = green + ruEvalPartAsInt(thread, cmd.parts[3])
	if green < 0
		green = 0
	elseif green > 255
		green = 255
	endif

	blue = blue + ruEvalPartAsInt(thread, cmd.parts[5])
	if blue < 0
		blue = 0
	elseif blue > 255
		blue = 255
	endif
	
	col = MakeColor(red, green, blue)
	coSetSpriteColor(ma.things[thread.thingIdx].obj, col)
	
endfunction

//-----------------------------------------------------
//
function ruSetFramePtr(thread ref as Thread, cmd ref as Cmd)

	local ret as integer
	local img as integer

	ret = ruEvalPartAsInt(thread, cmd.parts[1])

	if ret < 1 or ret > ma.things[thread.thingIdx].imgs.length + 1
		ret = 1
	endif

	ma.things[thread.thingIdx].rImgIdx = ret - 1
	img = ruGetThingImage(thread.thingIdx, ma.things[thread.thingIdx].rimgIdx)				
	
	SetSpriteImage(getsprite(ma.things[thread.thingIdx].obj), img)
	setspritesize(getsprite(ma.things[thread.thingIdx].obj), -1, -1)
	
endfunction

/*
//-----------------------------------------------------
//
function ruSetFrameImagePtr(thread ref as Thread, cmd ref as Cmd)

	local subCmd as integer
	local ret as string
	local thingIdx as integer
	local imgIdx as integer
	local pos as integer
	local imgId as string
	local idxs as integer[]
	local img as integer

	if cmd.parts[1].typ = PART_CMD
		
		subCmd = cdGetPartAsInt(cmd.parts[1])

		if subCmd > -1
			
			imgId = cdGetPartAsString(ma.cmds[subCmd].parts[0])
			thingIdx = cdGetPartFrameThing(imgId)
			//imgIdx = cdFindFrameIdxById(thingIdx, imgId)
			cdFindFrameIdxById(thingIdx, imgId, idxs)
			imgIdx = idxs[1]
				
			if imgIdx < 1
				imgIdx = 0
			elseif imgIdx > ma.things[thingIdx].imgs.length
				imgIdx = 0
			endif

			thread.imgIdx = imgIdx

			img = ruGetThingImage(thingIdx, imgIdx)				
			SetSpriteImage(getsprite(ma.things[thread.thingIdx].obj), img)
			setspritesize(getsprite(ma.things[thread.thingIdx].obj), -1, -1)
			
		endif

	elseif cmd.parts[1].typ = PART_FRAME
		
		imgId = cdGetPartAsString(cmd.parts[1])
		thingIdx = cdGetPartFrameThing(imgId)

		if thingIdx > -1
			
			//imgIdx = cdFindFrameIdxById(thingIdx, imgId)
			cdFindFrameIdxById(thingIdx, imgId, idxs)
			imgIdx = idxs[1]
				
			if imgIdx < 1 and imgIdx > ma.things[thingIdx].imgs.length
				imgIdx = 0
			endif

			thread.imgIdx = imgIdx

			//if ma.things[thingIdx].imgs[thread.imgIdx].penImg
			//	img = ma.things[thingIdx].imgs[thread.imgIdx].penImg
			//else
			//	img = ma.things[thingIdx].imgs[thread.imgIdx].img
			//endif
			
			img = ruGetThingImage(thingIdx, imgIdx)				
			SetSpriteImage(getsprite(ma.things[thread.thingIdx].obj), img)
			setspritesize(getsprite(ma.things[thread.thingIdx].obj), -1, -1)

		endif
		
	endif
			
endfunction
*/

//-----------------------------------------------------
// If the thingIdx imgIdx has special features,
// e.g. bg or pen, see if they should be set.
//
function ruGetThingImage(thingIdx as integer, imgIdx as integer)

	local img as integer
	
	img = 0
	
	//if ma.things[thingIdx].isBg
	//	if ma.things[thingIdx].imgs[imgIdx].bgImg
	//		img = ma.things[thingIdx].imgs[imgIdx].bgImg
	//	endif
	//else
		if ma.things[thingIdx].imgs[imgIdx].penImg
			img = ma.things[thingIdx].imgs[imgIdx].penImg
		endif
	//endif

	if not img
		img = ma.things[thingIdx].imgs[imgIdx].img
	endif

endfunction img

//-----------------------------------------------------
//
function ruPrevFramePtr(thread ref as Thread, cmd ref as Cmd)

	local img as integer
	
	dec ma.things[thread.thingIdx].rimgIdx
	
	if ma.things[thread.thingIdx].rimgIdx < 0
		ma.things[thread.thingIdx].rimgIdx = ma.things[thread.thingIdx].imgs.length
	endif

	img = ruGetThingImage(thread.thingIdx, ma.things[thread.thingIdx].rimgIdx)

/*
	if ma.things[thread.thingIdx].imgs[ma.things[thread.thingIdx].imgIdx].penImg
		img = ma.things[thread.thingIdx].imgs[thread.imgIdx].penImg
	else
		img = ma.things[thread.thingIdx].imgs[thread.imgIdx].img
	endif
*/
	
	SetSpriteImage(getsprite(ma.things[thread.thingIdx].obj), img)
	SetSpriteSize(getsprite(ma.things[thread.thingIdx].obj), -1, -1)
	
endfunction

//-----------------------------------------------------
//
function ruNextFramePtr(thread ref as Thread, cmd ref as Cmd)

	local img as integer
	
	inc ma.things[thread.thingIdx].rimgIdx

	if ma.things[thread.thingIdx].rimgIdx > ma.things[thread.thingIdx].imgs.length				
		ma.things[thread.thingIdx].rimgIdx = 0
	endif

	img = ruGetThingImage(thread.thingIdx, ma.things[thread.thingIdx].rimgIdx)

/*
	if ma.things[thread.thingIdx].imgs[thread.imgIdx].penImg
		img = ma.things[thread.thingIdx].imgs[thread.imgIdx].penImg
	else 		
		img = ma.things[thread.thingIdx].imgs[thread.imgIdx].img
	endif
*/

	SetSpriteImage(getsprite(ma.things[thread.thingIdx].obj), img)
	SetSpriteSize(getsprite(ma.things[thread.thingIdx].obj), -1, -1)
	
endfunction

//-----------------------------------------------------
//
function ruSetTransparencyPtr(thread ref as Thread, cmd ref as Cmd)

	local alpha as integer
	
	alpha = ruEvalPartAsInt(thread, cmd.parts[1])

	if alpha < 0
		alpha = 0
	elseif alpha > 255
		alpha = 255
	endif
		
	setalpha(ma.things[thread.thingIdx].obj, alpha)

endfunction

//-----------------------------------------------------
//
function ruChangeTransparencyPtr(thread ref as Thread, cmd ref as Cmd)

	local alpha as integer

	alpha = GetAlpha(ma.things[thread.thingIdx].obj)
	alpha = alpha + ruEvalPartAsInt(thread, cmd.parts[1])

	if alpha < 0
		alpha = 0
	elseif alpha > 255
		alpha = 255
	endif
		
	setalpha(ma.things[thread.thingIdx].obj, alpha)
	
endfunction

//-----------------------------------------------------
// Convert alpha 0 to 255 to perc 0 to 100.
//
function ruAlphaToPerc(alpha as integer)
	
	local perc as float
	
	perc = (alpha / 255.0) * 100.0
	
	if perc < 0
		perc = 0
	elseif perc > 100
		perc = 100
	endif
	
endfunction perc

//-----------------------------------------------------
// Convert perc 0 to 100% as an alpha 0 to 255.
//
function ruPercToAlpha(perc as float)

	local alpha as integer
	
	alpha = (perc / 100.0) * 255

	if alpha < 0
		alpha = 0
	elseif alpha > 255
		alpha = 255
	endif

endfunction alpha

//-----------------------------------------------------
//
function ruSetScalePtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	setscalexy(ma.things[thread.thingIdx].obj, ret, ret)
	ruUpdatePrintPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruChangeScalePtr(thread ref as Thread, cmd ref as Cmd)

	ruChangeScaleXPtr(thread, cmd)
	ruChangeScaleYPtr(thread, cmd)
	ruUpdatePrintPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruSetScaleXPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	//setscalex(ma.things[thread.thingIdx].obj, ret)
	setscalex(ma.things[thread.thingIdx].obj, ret)

	ruUpdatePrintPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruChangeScaleXPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	//ret = ret / 100.0
	ret = ret + getscalex(ma.things[thread.thingIdx].obj)
	setscalex(ma.things[thread.thingIdx].obj, ret)

	ruUpdatePrintPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruSetScaleYPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	setscaley(ma.things[thread.thingIdx].obj, ret)
	ruUpdatePrintPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
//
function ruChangeScaleYPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	//ret = ret / 100.0
	ret = ret + getscaley(ma.things[thread.thingIdx].obj)
	setscaley(ma.things[thread.thingIdx].obj, ret)

	ruUpdatePrintPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
// If true, pixel scaling makes everything pixelly.
//
function ruSetPixelScalingPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as integer
	local v as integer
	local img as integer

	// Can't do this for clones.
	if ma.things[thread.thingIdx].clonedIdx > -1
		exitfunction
	endif
	
	ret = ruEvalPartAsBool(thread, cmd.parts[1])
	
	if ret
		v = 0
	else 
		v = 1
	endif
	
	img = GetSpriteImageID(ma.things[thread.thingIdx].obj)

	SetImageMinFilter(img, v)
	SetImageMagFilter(img, v)

	ruUpdatePrintPtr(thread, cmd)
	
endfunction

//-----------------------------------------------------
// If true, set the clone to handle collision.
//
function ruCanCollidePtr(thread ref as Thread, cmd ref as Cmd)

	local ret as integer

	// Can only do this for clones.
	//if ma.things[thread.thingIdx].clonedIdx = -1
	//	exitfunction
	//endif
	
	ret = ruEvalPartAsBool(thread, cmd.parts[1])	
	ma.things[thread.thingIdx].doCollision = ret
	
endfunction

//-----------------------------------------------------
//
function ruFlipXPtr(thread ref as Thread, cmd ref as Cmd)

	SetSpriteFlip(getsprite(ma.things[thread.thingIdx].obj), 1, 0)
	
endfunction

//-----------------------------------------------------
//
function ruFlipYPtr(thread ref as Thread, cmd ref as Cmd)

	SetSpriteFlip(getsprite(ma.things[thread.thingIdx].obj), 0, 1)
	
endfunction

/*
//-----------------------------------------------------
//
function ruSetDepthPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	setdepth(ma.things[thread.thingIdx].obj, ret)

	ruUpdatePrintPtr(thread, cmd)
	
endfunction
*/

//-----------------------------------------------------
//
function ruBringToFrontPtr(thread ref as Thread, cmd ref as Cmd)
		
	//thread.depth = THING_DEPTH_BASE // Assume this brings it above the current one in this place.
	ruApplyThreadDepth(thread, THING_DEPTH_BASE)
					
endfunction

//-----------------------------------------------------
//
function ruSendToBackPtr(thread ref as Thread, cmd ref as Cmd)

	// If depth is too high, adust.
	//thread.depth = THING_DEPTH_BASE + co.depthRange
	ruApplyThreadDepth(thread, THING_DEPTH_BASE + co.depthRange)

endfunction

//-----------------------------------------------------
//
function ruBringForwardPtr(thread ref as Thread, cmd ref as Cmd)

	local idx as integer
	local depth as integer
	
	idx = ru.rt.threads.find(thread.depth)
	
	if idx > -1		

		// Keep going until we are on the pre thread that is not thingIdx.
		while idx >= 0	
			
			dec idx	
				
			if ru.rt.threads[idx].thingIdx <> thread.thingIdx
				exit
			endif	
					
		endwhile
				
		if idx > 0
			depth = ru.rt.threads[idx - 1].depth - (THING_DEPTH_SKIP - 1) // Make sure it doesn't go part the next sprite.
		else 
			depth = THING_DEPTH_BASE
		endif		

		ruApplyThreadDepth(thread, depth)
			
	endif
		
endfunction

//-----------------------------------------------------
//
function ruSendBackwardPtr(thread ref as Thread, cmd ref as Cmd)

	local idx as integer
	local depth as integer
	
	idx = ru.rt.threads.find(thread.depth)
	
	if idx > -1	
		
		// Keep going until we are on the next thread that is not thingIdx.
		while idx <= ru.rt.threads.length	
			
			inc idx		

			if ru.rt.threads[idx].thingIdx <> thread.thingIdx
				exit
			endif
			
		endwhile
	
		if idx < ru.rt.threads.length
			depth = ru.rt.threads[idx + 1].depth + 1 // Set depth past the next sprite.
		else 
			depth = THING_DEPTH_BASE + co.depthRange // No sprite, put at the end.
		endif		

		ruApplyThreadDepth(thread, depth)
			
	endif

endfunction

//-----------------------------------------------------
//
function ruSetDepthPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	ret = ruEvalPartAsInt(thread, cmd.parts[1])
	//maFixThingDepth(ru.rt.depths, thread.thingIdx, ret)
	//maInsertThingDepth(ru.rt.depths, thread.thingIdx, ret)
		
endfunction

//-----------------------------------------------------
//
function ruPenDownPtr(thread ref as Thread, cmd ref as Cmd)

	if not ma.things[thread.thingIdx].pen.active

		ma.things[thread.thingIdx].pen.active = true		
		ruAddPenPoint(thread, true, getposx(ma.things[thread.thingIdx].obj), getposy(ma.things[thread.thingIdx].obj))

	endif
	
endfunction

//-----------------------------------------------------
//
function ruDrawOvalPtr(thread ref as Thread, cmd ref as Cmd)

	local w as float
	local h as float
	local ang as float
	local x as float
	local y as float
	local xx as float
	local yy as float
	local a1 as float
	local a2 as float
	local mb as MemBlock
	local img as integer
	local spr as integer
	local sprs as integer[]
	local r as Point
	local a as float
	local dx as float
	local dy as float
	local i as integer
	
	if ma.things[thread.thingIdx].pen.active

		w = ruEvalPartAsFloat(thread, cmd.parts[1])
		h = ruEvalPartAsFloat(thread, cmd.parts[3])
		a1 = ruEvalPartAsFloat(thread, cmd.parts[5])
		a2 = ruEvalPartAsFloat(thread, cmd.parts[7])
		xx = getposx(ma.things[thread.thingIdx].obj)
		yy = getposy(ma.things[thread.thingIdx].obj)

		i = 0
	
		// Draw a single line oval.
		//for a = 0.0 to ang step 5
		for a = a1 to a2 step 5

			x = xx + cos(a - 90.0) * w
			y = yy + sin(a - 90.0) * h

			if i = 0

				dx = xx - x
				dy = yy - y

			endif

			x = x + dx
			y = y + dy
			
			setposx(ma.things[thread.thingIdx].obj, x)
			setposy(ma.things[thread.thingIdx].obj, y)

			ruUpdatePenPtr(thread, cmd)

			inc i

		next
		
	endif
	
endfunction

//-----------------------------------------------------
//
function ruPenUpPtr(thread ref as Thread, cmd ref as Cmd)

	ma.things[thread.thingIdx].pen.active = false
	
endfunction

//-----------------------------------------------------
//
function ruClearPenPtr(thread ref as Thread, cmd ref as Cmd)

	//if not ma.things[thread.thingIdx].pen.active
		ruClearPen(thread.thingIdx)
	//endif
	
endfunction

//-----------------------------------------------------
// Draw another pen line if we have active pen.
//
function ruUpdatePenPtr(thread ref as Thread, cmd ref as Cmd)

	if ma.things[thread.thingIdx].pen.active
		ruAddPenPoint(thread, false, getposx(ma.things[thread.thingIdx].obj), getposy(ma.things[thread.thingIdx].obj))
	endif

endfunction

//-----------------------------------------------------
//
function ruSetPenColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string 

	text = ruEvalPartAsString(thread, cmd.parts[1])
	ma.things[thread.thingIdx].pen.col = coMakeColor(text)
	
endfunction

//-----------------------------------------------------
//
function ruSetPenSizePtr(thread ref as Thread, cmd ref as Cmd)

	ma.things[thread.thingIdx].pen.size = ruEvalPartAsFloat(thread, cmd.parts[1])

	// Check bounds.
	if ma.things[thread.thingIdx].pen.size < 1
		ma.things[thread.thingIdx].pen.size = 1
	elseif ma.things[thread.thingIdx].pen.size > RU_PEN_SIZE_MAX
		ma.things[thread.thingIdx].pen.size = RU_PEN_SIZE_MAX
	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetPenStylePtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string 
	local ival as integer
	
	sval = ruEvalPartAsString(thread, cmd.parts[1])
	ival = val(cdGetObjVarVals(OBJ_VAR_STYLE, sval, true))

	if ival > 0
		ma.things[thread.thingIdx].pen.style = ival
	else
		ma.things[thread.thingIdx].pen.style = CO_LINE_MID_CIRC
	endif

endfunction

//-----------------------------------------------------
//
function ruSetPenShapePtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	//ret = ruEvalPartAsInt(thread, cmd.parts[1])
	//setcolor(ru.rt.pen, GetColorRed(ret), GetColorGreen(ret), GetColorBlue(ret))
	
endfunction

//-----------------------------------------------------
//
function ruDistToPosPtr(thread ref as Thread, cmd ref as Cmd)

	local sx as float
	local sy as float
	local ex as float
	local ey as float
	local thingIdx as integer
	local ret as float

	sx = getposx(ma.things[thread.thingIdx].obj)
	sy = getposy(ma.things[thread.thingIdx].obj)
	//thingIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	//ex = getposx(ma.things[thingIdx].obj)
	//ey = getposy(ma.things[thingIdx].obj)
	ex = ruEvalPartAsFloat(thread, cmd.parts[1])
	ey = ruEvalPartAsFloat(thread, cmd.parts[3])

// TODO: Check this.
	ret = coDist(sx, sy, ex, ey)
	
endfunction ret

//-----------------------------------------------------
//
function ruDistToThingPtr(thread ref as Thread, cmd ref as Cmd)

	local sx as float
	local sy as float
	local ex as float
	local ey as float
	local thingIdx as integer
	local ret as float

	thingIdx = ruGetThingCmdPtr(thread, cmd, 1)
	
	if thingIdx > -1
		
		sx = getposx(ma.things[thread.thingIdx].obj)
		sy = getposy(ma.things[thread.thingIdx].obj)
		ex = getposx(ma.things[thingIdx].obj)
		ey = getposy(ma.things[thingIdx].obj)
		ret = coDist(sx, sy, ex, ey)
		
	else

		ret = 0.0
		
	endif
		
endfunction ret

//-----------------------------------------------------
//
function ruCloneSpritePtr(thread ref as Thread, cmd ref as Cmd)

	local thingIdx as integer
	local threadIdxs as integer[]
	local i as integer
	local idx as integer
	local cmdIdx as integer
	
	//log("cloning thingIdx=" + str(thread.thingIdx))
	thingIdx = maCloneSprite(thread.thingIdx)
	ma.things[thingIdx].rImgIdx = ma.things[thread.thingIdx].rimgIdx
	ruInitThing(thingIdx)
	//SetColGroup(ma.things[thingIdx].obj, ma.things[thread.thingIdx].collGrp)

	setpos(ma.things[thingIdx].obj, getposx(ma.things[thread.thingIdx].obj), getposy(ma.things[thread.thingIdx].obj))
	setangle(ma.things[thingIdx].obj, getangle(ma.things[thread.thingIdx].obj))
	setscalex(ma.things[thingIdx].obj, getscalex(ma.things[thread.thingIdx].obj))
	setscaley(ma.things[thingIdx].obj, getscaley(ma.things[thread.thingIdx].obj))
	coSetSpriteColor(ma.things[thingIdx].obj, coGetSpriteColor(ma.things[thread.thingIdx].obj)) // Sets alpha too.

	threadIdxs = ruCloneThingThreads(thread.thingIdx, thingIdx)

	// Set the depths of all threads to this sprite's depth - 1.
	for i = 0 to threadIdxs.length
		
		idx = threadIdxs[i]		
		ru.rt.threads[idx].depth = thread.depth - (THING_DEPTH_SKIP - 1)
		
		// This is duplicated in the loop for multiple threads, why?
		if i = 0
			
			SetDepth(ma.things[thingIdx].obj, ru.rt.threads[idx].depth)
			guiSetTipDepth(ma.things[thingIdx].tip, ru.rt.threads[idx].depth)
			
		endif

/*		
		// Set up collisions.		
		if ru.rt.threads[idx].event = CODE_EVENT_COLL_THING

			cmdIdx = ma.things[ru.rt.threads[idx].thingIdx].cmds[ru.rt.threads[idx].thingEventCmdIdx]				
			ruSetupCollision(ru.rt.threads[idx].thingIdx, cmdIdx)
			
		elseif ru.rt.threads[idx].event = CODE_EVENT_COLL_ANY_THING
			
			ruSetupCollisionAny(ru.rt.threads[idx].thingIdx)

		endif

		ruSetupCollisionCmds(ru.rt.threads[idx].thingIdx)
*/
		
	next
	
	// Adjust the depth calc, for the next updateAllObjects loop.
	inc ru.rt.thingCount
	ru.rt.depthDiv = co.depthRange / (ru.rt.thingCount + 1)
	ru.rt.sortThreads = true
	
	ruActivateEvent(thingIdx, CODE_EVENT_CLONE)
	
endfunction

//-----------------------------------------------------
//
function ruDeleteClonePtr(thread ref as Thread, cmd ref as Cmd)

	if thread.deleted
		exitfunction
	endif
	
	local i as integer
	
	if ma.things[thread.thingIdx].clonedIdx > -1

		ruRemoveThing(thread.thingIdx)
		thread.active = false
		thread.deleted = true

		// Find all threads with this thing and delete them too.
		for i = 0 to ru.rt.threads.length
			
			if ru.rt.threads[i].thingIdx = thread.thingIdx		
				
				ru.rt.threads[i].active = false	
				ru.rt.threads[i].deleted = true	
				
			endif	
				
		next
			
	endif
		
endfunction

//-----------------------------------------------------
//
function ruDeleteAllClonesPtr(thread ref as Thread, cmd ref as Cmd)

	local thingIdx as integer
	local i as integer
	local clonedIdxs as integer[]

	// Find the parent thing.
	if ma.things[thread.thingIdx].clonedIdx > -1
		thingIdx = ma.things[thread.thingIdx].clonedIdx
	else
		thingIdx = thread.thingIdx
	endif

	// Find all threads with that is a clone of this thing.
	for i = 0 to ru.rt.threads.length
		
		if ma.things[ru.rt.threads[i].thingIdx].clonedIdx = thingIdx		
			
			ruRemoveThing(ru.rt.threads[i].thingIdx)			
			ru.rt.threads[i].active = false	
			ru.rt.threads[i].deleted = true	
			
		endif	
			
	next

endfunction

//-----------------------------------------------------
//
function ruWaitForSecsPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float
	local millis as integer
	
	ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	millis = ret * 1000
	thread.waitTime = GetMilliseconds() + millis
	
endfunction

//-----------------------------------------------------
//
function ruWaitUntilPtr(thread ref as Thread, cmd ref as Cmd)
	
	if ruEvalPartAsBool(thread, cmd.parts[1])
		thread.waitUntil = 0
	else
		thread.waitUntil = cmd.idx
	endif
	
endfunction

//-----------------------------------------------------
//
function ruResetTimerPtr(thread ref as Thread, cmd ref as Cmd)

	local i as integer
	local ln as integer
	
	ru.rt.timer = GetMilliseconds()
	
	ln = ru.rt.threads.length
	
	for i = 0 to ln
		if ru.rt.threads[i].blockTimer
			ru.rt.threads[i].blockTimer = false
		endif
	next
	
endfunction

//-----------------------------------------------------
//
function ruWaitVarInputPtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local varIdx as integer
	local value as string
	local depth as integer
	//local spr as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		if ma.vars[varIdx].typ <> VAR_TYPE_VALUE
			
			varIdx = 0
			exitfunction varIdx
			
		endif
		
		// Already waiting on a var input, kill it.
		if thread.waitInput
			
			if ma.vars[thread.waitInput].rv.edit
				
				DeleteEditBox(ma.vars[thread.waitInput].rv.edit)
				ma.vars[thread.waitInput].rv.edit = 0

			endif

			thread.waitInput = 0
			
		endif
		
		thread.waitInput = varIdx

		if ma.vars[varIdx].rv.bg

			ma.vars[varIdx].rv.edit = CreateEditBox()
			SetEditBoxSize(ma.vars[varIdx].rv.edit, GetSpriteWidth(ma.vars[varIdx].rv.box), GetSpriteHeight(ma.vars[varIdx].rv.box))
			SetEditBoxPosition(ma.vars[varIdx].rv.edit, GetSpritex(ma.vars[varIdx].rv.box), GetSpritey(ma.vars[varIdx].rv.box))
			SetEditBoxBorderSize(ma.vars[varIdx].rv.edit, 0)
			//SetEditBoxScissor(ma.vars[varIdx].rv.edit, GetSpritex(ma.vars[varIdx].rv.box), GetSpritey(ma.vars[varIdx].rv.box), GetSpriteWidth(ma.vars[varIdx].rv.box), GetSpriteHeight(ma.vars[varIdx].rv.box))
			depth = GetTextDepth(ma.vars[varIdx].rv.text)
			SetEditBoxDepth(ma.vars[varIdx].rv.edit, depth - 1)
			//value = GetEditBoxText(ma.vars[varIdx].rv.edit)
			value = GetTextString(ma.vars[varIdx].rv.text)
			SetEditBoxText(ma.vars[varIdx].rv.edit, value)
			SetEditBoxCursorPosition(ma.vars[varIdx].rv.edit, len(value))
			SetEditBoxCursorColor(ma.vars[varIdx].rv.edit, 3, 169, 244)
			SetEditBoxCursorWidth(ma.vars[varIdx].rv.edit, 4)
			SetEditBoxTextColor(ma.vars[varIdx].rv.edit, GetColorRed(ma.vars[varIdx].rv.textCol), GetColorGreen(ma.vars[varIdx].rv.textCol), GetColorBlue(ma.vars[varIdx].rv.textCol))
			coSetEditBoxFont(ma.vars[varIdx].rv.edit, ma.vars[varIdx].rv.textFont)
			SetEditBoxTextSize(ma.vars[varIdx].rv.edit, ma.vars[varIdx].rv.textFontSize)
			SetEditBoxBackgroundColor(ma.vars[varIdx].rv.edit, GetColorRed(ma.vars[varIdx].rv.boxCol), GetColorGreen(ma.vars[varIdx].rv.boxCol), GetColorBlue(ma.vars[varIdx].rv.boxCol), 255)
			if ma.vars[varIdx].rv.textSecret
				SetEditBoxPasswordMode(ma.vars[varIdx].rv.edit, true)
			endif
			setEditBoxVisible(ma.vars[varIdx].rv.edit, true)
			SetEditBoxFocus(ma.vars[varIdx].rv.edit, true)

			//local spr as integer
			//spr = guiCreateBox("edit", GetSpriteWidth(ma.vars[varIdx].rv.box), GetSpriteHeight(ma.vars[varIdx].rv.box))
			//coSetSpriteColor(spr, co.black)
			//SetSpritePosition(spr, GetSpritex(ma.vars[varIdx].rv.box), GetSpritey(ma.vars[varIdx].rv.box))

		endif
		
	endif
	
endfunction varIdx

//-----------------------------------------------------
// Get the current date.
//
function ruGetDatePtr(thread ref as Thread, cmd ref as Cmd)

	//local dt as integer
	local s as string
	
	//dt = ruEvalPartAsInt(thread, cmd.parts[1])
	s = ruEvalPartAsString(thread, cmd.parts[1])
	s = coFormatDate(0, s)

endfunction s

//-----------------------------------------------------
// Get the current date and time.
//
function ruGetDateTimePtr(thread ref as Thread, cmd ref as Cmd)

	local s as string
	
	s = GetCurrentDate() + " " + GetCurrentTime()

endfunction s

//-----------------------------------------------------
// Get the current time.
//
function ruGetTimePtr(thread ref as Thread, cmd ref as Cmd)

	//local dt as integer
	local s as string
	
	//dt = ruEvalPartAsint(thread, cmd.parts[1])
	s = ruEvalPartAsString(thread, cmd.parts[1])
	s = coFormatTime(0, s)

endfunction s

//-----------------------------------------------------
// Trim a string.
//
function ruTrimStrPtr(thread ref as Thread, cmd ref as Cmd)

	local t as string
	local s as string
	local ret as string

	t = ruEvalPartAsString(thread, cmd.parts[1])
	s = ruEvalPartAsString(thread, cmd.parts[3])
	ret = coTrimStr(s, t)

endfunction ret

//-----------------------------------------------------
// Format a number.
//
function ruFormatNbrPtr(thread ref as Thread, cmd ref as Cmd)

	local t as string
	local s as string
	local ret as string
	local d as integer
	local e as integer

	s = ruEvalPartAsString(thread, cmd.parts[1])
	d = ruEvalPartAsInt(thread, cmd.parts[3])
	t = ruEvalPartAsString(thread, cmd.parts[5])
	e = ruEvalPartAsInt(thread, cmd.parts[7])
	ret = coFormatNbr(s, d, t, e)

endfunction ret

//-----------------------------------------------------
// Append str.
//
function ruAppendStrPtr(thread ref as Thread, cmd ref as Cmd)

	local t as string
	local s as string
	local ret as string

	s = ruEvalPartAsString(thread, cmd.parts[1])
	t = ruEvalPartAsString(thread, cmd.parts[3])
	ret = s + t
	
endfunction ret

//-----------------------------------------------------
// Create a channel.
//
function ruCreateChannel()

	local id as integer

	if ru.rt.freeChannels.length >= 0
		
		id = ru.rt.freeChannels[0]
		ru.rt.freeChannels.remove(0)

	else
		
		local ch as Channel
		ru.rt.channels.insert(ch)
		id = ru.rt.channels.length

	endif

	ru.rt.channels[id].deleted = false
	ru.rt.channels[id].id = id
	
endfunction id

//-----------------------------------------------------
// Delete a channel.
//
function ruDeleteChannel(channelIdx as integer)

	local i as integer
	local j as integer
	
	if not ru.rt.channels[channelIdx].deleted
				
		ru.rt.channels[channelIdx].deleted = True
		ru.rt.freeChannels.insert(channelIdx)

		for i = 0 to ru.rt.threads.length
			for j = 0 to ru.rt.threads[i].waitChannels.length
				if ru.rt.threads[i].waitChannels[j] = channelIdx
					
					ru.rt.threads[i].waitChannels.remove(j)
					exitfunction
					
				endif
			next
		next
		
	endif
	
endfunction

//-----------------------------------------------------
// Find the idx of the sound that has channel.
//
function ruFindSoundByChannel(channelIdx as integer)

	local soundIdx as integer

	channelIdx = ruValidChannel(channelIdx)
	
	if channelIdx > -1 and not ru.rt.channels[channelIdx].deleted
		soundIdx = ru.rt.channels[channelIdx].soundIdx
	else
		soundIdx = -1
	endif
	
endfunction soundIdx

//-----------------------------------------------------
// Ensure channel is valid.
//
function ruValidChannel(channelIdx as integer)

	if channelIdx < 0 or channelIdx > ru.rt.channels.length
		channelIdx = -1
	endif

endfunction channelIdx

//-----------------------------------------------------
// Load a sound.
//
function ruLoadSoundPtr(thread ref as Thread, cmd ref as Cmd)

	local appSoundIdx as integer
	local appSoundId as string
	local soundIdx as integer
	
	//appSoundIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	//soundIdx = maFindSoundByIdx(ru.appIdx, appSoundIdx)
	appSoundId = ruEvalPartAsString(thread, cmd.parts[1])
	soundIdx = maFindSoundById(ru.appIdx, appSoundId)
	
	if soundIdx > -1
		ruLoadSound(soundIdx)
	endif
	
endfunction

//-----------------------------------------------------
// Load a sound and add to the list.
//
function ruLoadSound(soundIdx as integer)

	local file as string

	if soundIdx > -1 and not ma.sounds[soundIdx].loadId

		//file = LD_LIB_BASE + "/" + LD_APP_DIR + "/" + ma.apps[ru.appIdx].dir + "/" + LD_SOUND_DIR + "/" + ma.sounds[soundIdx].file
		file = ma.apps[ru.appIdx].folder + LD_SOUND_DIR + "/" + ma.sounds[soundIdx].file
		ma.sounds[soundIdx].loadId = LoadSound(file)

	endif

endfunction soundIdx

//-----------------------------------------------------
// Unload a sound if it is loaded.
//
function ruUnloadSoundPtr(thread ref as Thread, cmd ref as Cmd)

	local soundName as string 
	local appSoundIdx as integer
	local appSoundId as string
	local soundIdx as integer
	local i as integer

	//appSoundIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	//soundIdx = maFindSoundByIdx(ru.appIdx, appSoundIdx)
	appSoundId = ruEvalPartAsstring(thread, cmd.parts[1])
	soundIdx = maFindSoundById(ru.appIdx, appSoundId)
	ruUnloadSound(soundIdx)
	
endfunction

//-----------------------------------------------------
// Unload a sound if it is loaded.
//
function ruUnloadSound(soundIdx as integer)

	local i as integer

	if soundIdx > -1

		for i = 0 to ru.rt.channels.length
			if ru.rt.channels[i].soundIdx = soundIdx
				ruStopSound(i)
			endif
		next

		DeleteSound(ma.sounds[soundIdx].loadId)
		ma.sounds[soundIdx].loadId = 0
		
	endif
	
endfunction

//-----------------------------------------------------
// "S:stop sound on channel ,N:1"
//
function ruStopSoundPtr(thread ref as Thread, cmd ref as Cmd)

	local channelIdx as integer
	
	channelIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	ruStopSound(channelIdx)

endfunction

//-----------------------------------------------------
//
function ruStopSound(channelIdx as integer)

	channelIdx = ruValidChannel(channelIdx)

	if channelIdx > -1 and not ru.rt.channels[channelIdx].deleted

		StopSoundInstance(ru.rt.channels[channelIdx].playId)
		ruDeleteChannel(channelIdx)
		
	endif

endfunction

//-----------------------------------------------------
//
function ruStopAllSoundsPtr(thread ref as Thread, cmd ref as Cmd)

	ruStopAllSounds()
	
endfunction

//-----------------------------------------------------
//
function ruStopAllSounds()

	local i as integer

	for i = 0 to ru.rt.channels.length
		ruStopSound(i)
	next
	
endfunction

//-----------------------------------------------------
// Set the overall volume for next play.
// "S:set volume to ,F:50"
//
function ruSetSoundVolumePtr(thread ref as Thread, cmd ref as Cmd)

	local volume as float
	
	volume = ruEvalPartAsFloat(thread, cmd.parts[1])
	volume = ruValidVolume(volume)
	ru.rt.volume = volume
	
endfunction

//-----------------------------------------------------
// Return a valid volume from the passed one.
//
function ruValidVolume(volume as float)

	if volume < 0.0
		volume = 0.0
	elseif volume > RU_VOLUME_MAX
		volume = RU_VOLUME_MAX
	endif
	
endfunction volume

//-----------------------------------------------------
// "S:set loops to ,N:1, for sound ,T:sound"
//
function ruSetSoundLoopsPtr(thread ref as Thread, cmd ref as Cmd)

	local soundLoops as integer
	
	soundLoops = ruEvalPartAsInt(thread, cmd.parts[1])

	if soundLoops < 0
		soundLoops = 0
	endif

	ru.rt.soundLoops = soundLoops
	
endfunction

//-----------------------------------------------------
//
function ruPlaySoundPtr(thread ref as Thread, cmd ref as Cmd)

	local appSoundIdx as integer
	local soundIdx as integer
	
	appSoundIdx = ruEvalPartAsInt(thread, cmd.parts[1])

	if appSoundIdx <= ma.apps[ru.appIdx].sounds.length
	
		soundIdx = ma.apps[ru.appIdx].sounds[appSoundIdx]
		ruPlaySound(soundIdx)

	endif

endfunction

//-----------------------------------------------------
//
function ruPlaySoundDonePtr(thread ref as Thread, cmd ref as Cmd)

	ruPlaySoundPtr(thread, cmd)
	
	if ru.rt.lastChannel > -1
		thread.waitChannels.insert(ru.rt.lastChannel)
	endif

endfunction

//-----------------------------------------------------
// Returns channelIdx.
// 
function ruPlaySound(soundIdx as integer)
	
	local channelIdx as integer
	local soundLoops as integer
	local playId as integer
	
	//ruLoadSound(soundIdx)
	channelIdx = -1

	if soundIdx > -1 and ma.sounds[soundIdx].loadId

		soundLoops = ru.rt.soundLoops

		// Crazy PlaySound requirement.
		if soundLoops = 0
			soundLoops = 1
		elseif soundLoops = 1
			soundLoops = 0
		endif
		
		// Play and create new channel.
		playId = PlaySound(ma.sounds[soundIdx].loadId, ru.rt.volume, soundLoops)

		if playId > 0
			
			channelIdx = ruCreateChannel()
			ru.rt.channels[channelIdx].playId = playId
			ru.rt.channels[channelIdx].soundIdx = soundIdx
			ru.rt.channels[channelIdx].volume = ru.rt.volume
			ru.rt.lastChannel = channelIdx

		endif
		
	endif
	
endfunction channelIdx

//-----------------------------------------------------
// "S:change volume to ,F:50,S: % for channel ,N:1"
//
function ruSetChannelVolumePtr(thread ref as Thread, cmd ref as Cmd)

	local volume as float
	local channelIdx as integer
	local soundIdx as integer
	
	volume = ruEvalPartAsFloat(thread, cmd.parts[1])
	channelIdx = ruEvalPartAsInt(thread, cmd.parts[3])
	channelIdx = ruValidChannel(channelIdx)

	if channelIdx > -1
		
		ru.rt.channels[channelIdx].volume = volume
		SetSoundInstanceVolume(ru.rt.channels[channelIdx].playId, ru.rt.channels[channelIdx].volume)
		
	endif
	
endfunction

//-----------------------------------------------------
// "S:get volume for sound ,T:sound"
//
function ruGetSoundVolumePtr(thread ref as Thread, cmd ref as Cmd)
	
endfunction ru.rt.volume

//-----------------------------------------------------
// "S:get volume for channel ,N:1"
//
function ruGetChannelVolumePtr(thread ref as Thread, cmd ref as Cmd)

	local volume as float
	local channelIdx as integer
	local soundIdx as integer

	channelIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	channelIdx = ruValidChannel(channelIdx)

	if channelIdx > -1
		volume = ru.rt.channels[channelIdx].volume
	else
		volume = 0.0
	endif
	
endfunction volume

//-----------------------------------------------------
//
function ruLoadVideoPtr(thread ref as Thread, cmd ref as Cmd)
	
	//local dx as float
	//local dy as float
	//local appVideoIdx as integer
	local appVideoId as string
	local videoIdx as integer
	//local file as string

	ruUnloadVideo()	
	
	//appVideoIdx = ruEvalPartAsInt(thread, cmd.parts[1])
	//videoIdx = maFindVideoByIdx(ru.appIdx, appVideoIdx)
	appVideoId = ruEvalPartAsString(thread, cmd.parts[1])
	videoIdx = maFindVideoById(ru.appIdx, appVideoId)

	if videoIdx > -1
				
		/*
		file =  ma.apps[ru.appIdx].folder + LD_VIDEO_DIR + "/" + ma.videos[videoIdx].file

		ma.videos[videoIdx].loaded = Loadvideo(file)

		if ma.videos[videoIdx].loaded

			ma.videos[videoIdx].lw = GetVideoWidth()

			// Wait for video to complete loading. Hack provided by AGK command docs!!!
			if ma.videos[videoIdx].lw <= 0
				
				repeat
					
					Sync()
					ma.videos[videoIdx].lw = GetVideoWidth()
					
				until ma.videos[videoIdx].lw > 0
				
			endif

			ma.videos[videoIdx].lh = GetVideoHeight()
			ma.videos[videoIdx].ratio = ma.videos[videoIdx].lw / ma.videos[videoIdx].lh
			ma.videos[videoIdx].w = ma.videos[videoIdx].lw
			ma.videos[videoIdx].h = ma.videos[videoIdx].lh
			ma.videos[videoIdx].duration = GetVideoDuration()
			ma.videos[videoIdx].img = RU_VIDEO_IMAGE_ID + videoIdx

			dx = ma.videos[videoIdx].w - co.w
			dy = ma.videos[videoIdx].h - co.h

			// If bigger than screen, resize video to max of screen.
			if dx > 0 or dy > 0

				if dx > dy

					ma.videos[videoIdx].w = co.w
					ma.videos[videoIdx].h = ma.videos[videoIdx].w / ma.videos[videoIdx].ratio

				elseif dy > dx

					ma.videos[videoIdx].h = co.h
					ma.videos[videoIdx].w = ma.videos[videoIdx].h * ma.videos[videoIdx].ratio

				endif

			endif

			ma.videos[videoIdx].x = co.w / 2 - ma.videos[videoIdx].w / 2
			ma.videos[videoIdx].y = co.h / 2 - ma.videos[videoIdx].h / 2

			SetVideoDimensions(ma.videos[videoIdx].x, ma.videos[videoIdx].y, ma.videos[videoIdx].w, ma.videos[videoIdx].h)
						
		endif
		*/

		if maLoadVideo(ru.appIdx, videoIdx, "")

			ru.rt.videoIdx = videoIdx
			ruApplyVideoVolume()

		endif
		
	endif
	
endfunction

//-----------------------------------------------------
//
function ruUnloadVideoPtr(thread ref as Thread, cmd ref as Cmd)

	ruUnloadVideo()
	thread.waitVideo = false
	
endfunction

//-----------------------------------------------------
//
function ruUnloadVideo()

	if ru.rt.videoIdx > -1

		if ma.videos[ru.rt.videoIdx].spr
			
			deletesprite(ma.videos[ru.rt.videoIdx].spr)
			ma.videos[ru.rt.videoIdx].spr = 0
			
		endif
/*
		DeleteVideo()
		
		ma.videos[ru.rt.videoIdx].loaded = 0
		ma.videos[ru.rt.videoIdx].x = 0
		ma.videos[ru.rt.videoIdx].y = 0
		ma.videos[ru.rt.videoIdx].w = 0
		ma.videos[ru.rt.videoIdx].h = 0
		ma.videos[ru.rt.videoIdx].duration = 0
		ma.videos[ru.rt.videoIdx].img = 0
*/

		maUnloadVideo(ru.rt.videoIdx)		
		ru.rt.videoIdx = -1
		ruHideVideoPanel()
		
	endif
	
endfunction

//-----------------------------------------------------
//
function ruPlayVideoPtr(thread ref as Thread, cmd ref as Cmd)

	ruPlayVideo()

	if ru.rt.videoIdx > -1		
		thread.waitVideo = false
	endif
	
endfunction

//-----------------------------------------------------
//
function ruPlayVideo()

	local spr as integer
	
	if ru.rt.videoIdx > -1
				
		PlayVideo()
		
		/*
		PlayVideoToImage(ma.videos[ru.rt.videoIdx].img)
		
		if not ma.videos[ru.rt.videoIdx].spr
			
			ma.videos[ru.rt.videoIdx].spr = createsprite(ma.videos[ru.rt.videoIdx].img)
			SetSpritePosition(ma.videos[ru.rt.videoIdx].spr, ma.videos[ru.rt.videoIdx].x, ma.videos[ru.rt.videoIdx].y)
			
		endif
		*/
		
		//spr = guicreatebox("video", ma.videos[ru.rt.videoIdx].w, ma.videos[ru.rt.videoIdx].h)
		//coSetSpriteColor(spr, co.red[5])
		//SetSpritePosition(spr, ma.videos[ru.rt.videoIdx].x, ma.videos[ru.rt.videoIdx].y)

		ruShowVideoPanel()
		
	endif
	
endfunction

//-----------------------------------------------------
//
function ruPlayVideoDonePtr(thread ref as Thread, cmd ref as Cmd)

	ruPlayVideoPtr(thread, cmd)

	if ru.rt.videoIdx > -1		
		thread.waitVideo = true
	endif

endfunction

//-----------------------------------------------------
//
function ruPauseVideoPtr(thread ref as Thread, cmd ref as Cmd)

	ruPauseVideo()
	thread.waitVideo = false
	
endfunction

//-----------------------------------------------------
//
function ruPauseVideo()

	if ru.rt.videoIdx > -1
		PauseVideo()
	endif
		
endfunction

//-----------------------------------------------------
//
function ruStopVideoPtr(thread ref as Thread, cmd ref as Cmd)

	ruStopVideo()

	if ru.rt.videoIdx > -1
		thread.waitVideo = false
	endif
	
endfunction

//-----------------------------------------------------
//
function ruStopVideo()

	if ru.rt.videoIdx > -1
		StopVideo()
	endif

endfunction

//-----------------------------------------------------
//
function ruShowVideoPtr(thread ref as Thread, cmd ref as Cmd)

	ruPlayVideo()
	ruPauseVideo()
	
endfunction

//-----------------------------------------------------
//
function ruHideVideoPtr(thread ref as Thread, cmd ref as Cmd)

	ruStopVideo()
	
endfunction

//-----------------------------------------------------
//
function ruSetVideoVolumePtr(thread ref as Thread, cmd ref as Cmd)

	ru.rt.videoVolume = ruEvalPartAsFloat(thread, cmd.parts[1])
	ruApplyVideoVolume()
	
endfunction

//-----------------------------------------------------
//
function ruGetVideoDurationPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float

	if ru.rt.videoIdx > -1
		ret = ma.videos[ru.rt.videoIdx].duration
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
//
function ruSetVideoTimePtr(thread ref as Thread, cmd ref as Cmd)

	local time as float
	
	if ru.rt.videoIdx > -1
		
		time = ruEvalPartAsFloat(thread, cmd.parts[1])
		ruSetVideoTime(time)
			
	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVideoTime(time as float)

	if ru.rt.videoIdx > -1
		
		setVideoPosition(time)
		ruShowVideoTimes()

	endif

endfunction

//-----------------------------------------------------
//
function ruGetVideoTimePtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float
	
	if ru.rt.videoIdx > -1
		ret = GetVideoPosition()
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
//
function ruApplyVideoVolume()

	if ru.rt.videoIdx > -1
		SetVideoVolume(ma.videos[ru.rt.videoIdx].volume)
	endif
	
endfunction

//-----------------------------------------------------
//
function ruGetVideoXPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float
	
	if ru.rt.videoIdx > -1
		ret = ma.videos[ru.rt.videoIdx].x
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
//
function ruGetVideoYPtr(thread ref as Thread, cmd ref as Cmd)

	local ret as float
	
	if ru.rt.videoIdx > -1
		ret = ma.videos[ru.rt.videoIdx].y
	else
		ret = 0
	endif
	
endfunction ret

//-----------------------------------------------------
//
function ruSetVideoPosPtr(thread ref as Thread, cmd ref as Cmd)

	if ru.rt.videoIdx > -1
			
		ma.videos[ru.rt.videoIdx].x = ruEvalPartAsFloat(thread, cmd.parts[1])
		ma.videos[ru.rt.videoIdx].y = ruEvalPartAsFloat(thread, cmd.parts[3])
		ruApplyVideoSize()

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVideoWidthPtr(thread ref as Thread, cmd ref as Cmd)

	if ru.rt.videoIdx > -1
		
		ma.videos[ru.rt.videoIdx].w = ruEvalPartAsFloat(thread, cmd.parts[1])
		ma.videos[ru.rt.videoIdx].h = ma.videos[ru.rt.videoIdx].w / ma.videos[ru.rt.videoIdx].ratio
		ruApplyVideoSize()

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVideoHeightPtr(thread ref as Thread, cmd ref as Cmd)

	if ru.rt.videoIdx > -1
		
		ma.videos[ru.rt.videoIdx].h = ruEvalPartAsFloat(thread, cmd.parts[1])
		ma.videos[ru.rt.videoIdx].w = ma.videos[ru.rt.videoIdx].h * ma.videos[ru.rt.videoIdx].ratio
		ruApplyVideoSize()

	endif
	
endfunction

//-----------------------------------------------------
//
function ruShowVideoPanelPtr(thread ref as Thread, cmd ref as Cmd)

	if ru.rt.videoIdx > -1
		
		ru.rt.videoPanel.vis = true
		ruShowVideoPanel()

	endif
	
endfunction

//-----------------------------------------------------
//
function ruHideVideoPanelPtr(thread ref as Thread, cmd ref as Cmd)

	ru.rt.videoPanel.vis = false
	ruHideVideoPanel()

endfunction

//-----------------------------------------------------
// Adjust the video size based on the values of w & h.
// Ensuring the video doesn't exceed the screen size.
//
function ruApplyVideoSize()

	if ru.rt.videoIdx > -1
		
		SetVideoDimensions(ma.videos[ru.rt.videoIdx].x, ma.videos[ru.rt.videoIdx].y, ma.videos[ru.rt.videoIdx].w, ma.videos[ru.rt.videoIdx].h)
		ruShowVideoPanel()
		
	endif
	
endfunction

//-----------------------------------------------------
// Called to update the say cmd value if one exists.
// Also overloaded to update the pen if active.
//
function ruUpdatePrintPtr(thread ref as Thread, cmd ref as Cmd)

	local s as String
	
	if ma.things[thread.thingIdx].tip.text2

		if ruIsPosOffScreen(thread)

			guiHideTip(ma.things[thread.thingIdx].tip)
			
		else

			s = GetTextString(ma.things[thread.thingIdx].tip.text2)
			guiShowTip(ma.things[thread.thingIdx].tip, getsprite(ma.things[thread.thingIdx].obj), s, TIP_PRINT, 0)

		endif
		
	endif

endfunction

//-----------------------------------------------------
//
function ruPrintPtr(thread ref as Thread, cmd ref as Cmd)

	local s as String
	local idx as integer
	
	s = ruEvalPartAsString(thread, cmd.parts[1])

	if s <> ""

		if not ma.things[thread.thingIdx].tip.box
			guiCreateTip(ma.things[thread.thingIdx].tip, false)
		endif

		if ruIsPosOffScreen(thread)
			
			guiHideTip(ma.things[thread.thingIdx].tip)
			
		else

			guiShowTip(ma.things[thread.thingIdx].tip, getsprite(ma.things[thread.thingIdx].obj), s, TIP_PRINT, 0)
			guiSetTipDepth(ma.things[thread.thingIdx].tip, thread.depth)

		endif

	elseif ma.things[thread.thingIdx].tip.box

		// Nothing to show.
		//guiHideTip(ma.things[thread.thingIdx].tip)
		ruClearPrintPtr(thread)
		
	endif
	
endfunction

//-----------------------------------------------------
//
function ruClearPrintPtr(thread ref as Thread)

	thread.waitSay = 0

	if ma.things[thread.thingIdx].tip.box
		//guiHideTip(ma.things[thread.thingIdx].tip)
		guiDeleteTip(ma.things[thread.thingIdx].tip)
	endif

endfunction

//-----------------------------------------------------
//
function ruPrintForTimePtr(thread ref as Thread, cmd ref as Cmd)
	
	local ret as float
	local millis as integer
	
	ruPrintPtr(thread, cmd)
	ret = ruEvalPartAsFloat(thread, cmd.parts[3])
	millis = ret * 1000
	thread.waitSay = GetMilliseconds() + millis
		
endfunction

//-----------------------------------------------------
//
function ruPrintAtPtr(thread ref as Thread, cmd ref as Cmd)

	local s as string 
	local x as float
	local y as float
	local v as integer
	local tip as Tip
	
	s = ruEvalPartAsString(thread, cmd.parts[1])
	x = ruEvalPartAsfloat(thread, cmd.parts[3])
	y = ruEvalPartAsfloat(thread, cmd.parts[5])
	v = coMakePoint(x, y)
	
	guiCreateTip(tip, false)
	ru.rt.atTips.insert(tip)

	guiShowTip(tip, v, s, TIP_PRINT_AT, 0)
	
endfunction

//-----------------------------------------------------
//
function ruSetBgColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string

	text = ruEvalPartAsString(thread, cmd.parts[1])
	ru.rt.screenBgColor = coMakeColor(text)
	SetClearColor(getcolorred(ru.rt.screenBgColor), getcolorgreen(ru.rt.screenBgColor), getcolorblue(ru.rt.screenBgColor))
	
endfunction

//-----------------------------------------------------
//
function ruSetVarBgColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		text = ruEvalPartAsString(thread, cmd.parts[3])
		ma.vars[varIdx].rv.bgCol = coMakeColor(text)
		maUpdateVarView(ma.vars[varIdx].rv)
		//maCreateVarView(ma.vars[varIdx].rv)
		//maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTitleColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		text = ruEvalPartAsString(thread, cmd.parts[3])
		ma.vars[varIdx].rv.titleCol = coMakeColor(text)
		maUpdateVarView(ma.vars[varIdx].rv)
		//maCreateVarView(ma.vars[varIdx].rv)
		//maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTitleFontSizePtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		ival = ruEvalPartAsInt(thread, cmd.parts[3])
		ma.vars[varIdx].rv.titleFontSize = ival
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTitleDirPtr(thread ref as Thread, cmd ref as Cmd)

	local sval as string
	local ival as integer
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		//ival = ruEvalPartAsInt(thread, cmd.parts[3])
		sval = ruEvalPartAsString(thread, cmd.parts[3])
		ival = val(cdGetObjVarVals(OBJ_VAR_EDGE, sval, true))
		ma.vars[varIdx].rv.titleDir = ival
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTitleAlignPtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local sval as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		sval = ruEvalPartAsString(thread, cmd.parts[3])
		ival = val(cdGetObjVarVals(OBJ_VAR_TITLE_ALIGN, sval, true))
		ma.vars[varIdx].rv.titleAlign = ival
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTitleFontPtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local sval as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		sval = ruEvalPartAsString(thread, cmd.parts[3])
		ival = val(cdGetObjVarVals(OBJ_VAR_FONT, sval, true))
		ma.vars[varIdx].rv.titleFont = ival
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTitleVisPtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		ival = ruEvalPartAsBool(thread, cmd.parts[3])
		ma.vars[varIdx].rv.titleVis = ival
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTextColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		text = ruEvalPartAsString(thread, cmd.parts[3])
		ma.vars[varIdx].rv.textCol = coMakeColor(text)
		maUpdateVarView(ma.vars[varIdx].rv)
		//maCreateVarView(ma.vars[varIdx].rv)
		//maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruShowVarPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx
		
		if not ma.vars[varIdx].rv.vis
			
			ma.vars[varIdx].rv.vis = true
			ruShowVar(varIdx)
			ruDrawVar(varIdx)
			
		endif

	endif
	
endfunction

//-----------------------------------------------------
//
function ruHideVarPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		if ma.vars[varIdx].rv.vis
			
			ma.vars[varIdx].rv.vis = false
			maDeleteVarView(ma.vars[varIdx].rv)
			
		endif

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTextFontPtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local sval as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		sval = ruEvalPartAsString(thread, cmd.parts[3])
		ival = val(cdGetObjVarVals(OBJ_VAR_FONT, sval, true))
		ma.vars[varIdx].rv.textFont = ival
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTextFontSizePtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		ival = ruEvalPartAsInt(thread, cmd.parts[3])
		ma.vars[varIdx].rv.textFontSize = ival
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTextSecretPtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		ival = ruEvalPartAsInt(thread, cmd.parts[3])
		ma.vars[varIdx].rv.textSecret = ival
		ruDrawVar(varIdx)
		//maCreateVarView(ma.vars[varIdx].rv)
		//maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarTextAlignPtr(thread ref as Thread, cmd ref as Cmd)

	local ival as integer
	local sval as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		sval = ruEvalPartAsString(thread, cmd.parts[3])
		ival = val(cdGetObjVarVals(OBJ_VAR_TEXT_ALIGN, sval, true))
		ma.vars[varIdx].rv.textAlign = ival
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarBoxColorPtr(thread ref as Thread, cmd ref as Cmd)

	local text as string
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		text = ruEvalPartAsString(thread, cmd.parts[3])
		ma.vars[varIdx].rv.boxCol = coMakeColor(text)
		maUpdateVarView(ma.vars[varIdx].rv)
		//maCreateVarView(ma.vars[varIdx].rv)
		//maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction


//-----------------------------------------------------
//
function ruSetVarXPtr(thread ref as Thread, cmd ref as Cmd)

	local fval as float
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		fval = ruEvalPartAsFloat(thread, cmd.parts[3])
		ma.vars[varIdx].rv.x = fval
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarYPtr(thread ref as Thread, cmd ref as Cmd)

	local fval as float
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		fval = ruEvalPartAsFloat(thread, cmd.parts[3])
		ma.vars[varIdx].rv.y = fval
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarWPtr(thread ref as Thread, cmd ref as Cmd)

	local fval as float
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		fval = ruEvalPartAsFloat(thread, cmd.parts[3])
		ma.vars[varIdx].rv.w = fval
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruSetVarHPtr(thread ref as Thread, cmd ref as Cmd)

	local fval as float
	local varIdx as integer

	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	// Do have a var.
	if varIdx

		fval = ruEvalPartAsFloat(thread, cmd.parts[3])
		ma.vars[varIdx].rv.h = fval
		maCreateVarView(ma.vars[varIdx].rv)
		maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

	endif
	
endfunction

//-----------------------------------------------------
//
function ruMakeColor3Ptr(thread ref as Thread, cmd ref as Cmd)

	local r as integer
	local b as integer
	local g as integer
	local c as integer
	local ret as string

	r = ruEvalPartAsfloat(thread, cmd.parts[1])
	b = ruEvalPartAsfloat(thread, cmd.parts[3])
	g = ruEvalPartAsfloat(thread, cmd.parts[5])
	c = MakeColor(r, g, b)
	ret = coColorToDec(c)
	
endfunction ret

//-----------------------------------------------------
//
function ruRandomColorPtr(thread ref as Thread, cmd ref as Cmd)

	local r as integer
	local b as integer
	local g as integer
	local c as integer
	local ret as string

	r = random2(0, 255)
	g = random2(0, 255)
	b = random2(0, 255)
	c = MakeColor(r, g, b)
	ret = coColorToHex(c)
	
endfunction ret

//-----------------------------------------------------
//
function ruSendEventPtr(thread ref as Thread, cmd ref as Cmd)

	local sendVarIdx as integer
	local sendMsg as string
	local receiveMsg as string
	local i as integer
	local j as integer
	local k as integer
	local eventCmd as integer
	local idx as integer
	local turbo as integer
	local value as string
	local listCmd as integer
	local listVar as integer
	local tmpListVar as integer

	sendMsg = ruEvalPartAsString(thread, cmd.parts[1])

	if sendMsg <> ""
		
		// If we got here, then we're not waiting for anything.
		thread.waitEvents.length = -1
		
		for i = 0 to ru.rt.threads.length

			if cmd.code = CODE_FLOW_SEND_EVENT
				
				if ru.rt.threads[i].event = CODE_EVENT_RECEIVED
	
					eventCmd = ma.things[ru.rt.threads[i].thingIdx].cmds[ru.rt.threads[i].thingEventCmdIdx]
					receiveMsg = ruEvalPartAsString(ru.rt.threads[i], ma.cmds[eventCmd].parts[1])
	
					// The event needs to be receiving vars.
					if receiveMsg <> ""
						
						// Only spawn a thread from the master (caller = 0), which never executes.
						if receiveMsg = sendMsg and ru.rt.threads[i].caller = 0
							
							idx = ruCreateThread(ru.rt.threads[i].thingIdx, ru.rt.threads[i].thingEventCmdIdx)
							ru.rt.threads[idx].caller = thread.id
							ru.rt.threads[idx].active = true

							//sendVarIdx = ruGetVarCmdPtr(thread, cmd, 3)
							
							//if sendVarIdx
								
							//	ru.rt.threads[idx].argList = ruCreateThreadVar(ru.rt.threads[idx], VAR_TYPE_LIST)
							//	maCopyVar(sendVarIdx, ru.rt.threads[idx].argList, true)

							//endif
							
							ruResetThread(ru.rt.threads[idx])
															
						endif
	
					endif
					
				endif
				
			elseif cmd.code = CODE_FLOW_CALL_BLOCK
				
				if ru.rt.threads[i].event = CODE_EVENT_BLOCK

					eventCmd = ma.things[ru.rt.threads[i].thingIdx].cmds[ru.rt.threads[i].thingEventCmdIdx]
					receiveMsg = ruEvalPartAsString(ru.rt.threads[i], ma.cmds[eventCmd].parts[1])
					turbo = ruEvalPartAsBool(thread, cmd.parts[3])
	
					// The event needs to be receiving vars.
					if receiveMsg <> ""
						
						// Only spawn a thread from the master (caller = 0), which never executes.
						if receiveMsg = sendMsg and ru.rt.threads[i].caller = 0
							
							idx = ruCreateThread(ru.rt.threads[i].thingIdx, ru.rt.threads[i].thingEventCmdIdx)
							ru.rt.threads[idx].caller = thread.id
							ru.rt.threads[idx].active = true
							//ru.rt.threads[idx].reset = true
							ruResetThread(ru.rt.threads[idx])
							ru.rt.threads[idx].turbo = turbo
/*
							sendVarIdx = ruGetVarCmdPtr(thread, cmd, 5)
						
							if sendVarIdx
								
								// Got a var type, add it.
								ru.rt.threads[idx].argList = ruCreateThreadVar(ru.rt.threads[idx], VAR_TYPE_LIST)
								maCopyVar(sendVarIdx, ru.rt.threads[idx].argList, true)
	
							else 
								
								// Append the value.
								value = ruEvalPartAsString(ru.rt.threads[idx], cmd.parts[j])	
								ru.rt.threads[idx].argList = ruCreateThreadVar(ru.rt.threads[idx], VAR_TYPE_LIST)
								ruAddItemToList(ru.rt.threads[idx].argList, "", value, 0)
																						
							endif
*/
						
							for k = 1 to 3 // 5 was too many.
								
								j = 5 + (k - 1) * 2
								
								if not ru.rt.threads[idx].argList
									ru.rt.threads[idx].argList = ruCreateThreadVar(ru.rt.threads[idx], VAR_TYPE_LIST)
								endif
								
								listVar = 0
								
								if cmd.parts[j].typ = PART_CMD
									
									listCmd = cdGetPartAsInt(cmd.parts[j])
									
									if ma.cmds[listCmd].code = CODE_VAR_GET
										listVar = cdGetPartAsInt(ma.cmds[listCmd].parts[0])	
									endif
									
								endif
									
								// If a list var, then copy the whole list.
								if listVar and ma.vars[listVar].typ = VAR_TYPE_LIST

									tmpListVar = ruCreateThreadVar(ru.rt.threads[idx], VAR_TYPE_LIST)
									ma.vars[tmpListVar].name = "param" + str(k)
									maCopyVar(listVar, tmpListVar, true)
									ruAddItemToList(ru.rt.threads[idx].argList, "list", str(tmpListVar), 0)
																			
								else // Just a value, append the value.
								
									value = ruEvalPartAsString(ru.rt.threads[idx], cmd.parts[j])	
									ruAddItemToList(ru.rt.threads[idx].argList, "", value, 0)
								
								endif
															
							next 
												
							thread.waitEvents.insert(ru.rt.threads[idx].id)
								
						endif
	
					endif
					
				endif
				
			endif
			
		next

	endif
	
endfunction

//-----------------------------------------------------
// Return true if the sprite is pressed.
//
function ruSpritePressed(thread ref as Thread)

	local ret as integer
	
	if ru.rt.ptrPressed
		if GetspriteHitTest(getsprite(ma.things[thread.thingIdx].obj), in.ptrX, in.ptrY)
			ret = true
		else 
			ret = false
		endif
	else 
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if the sprite is down.
//
function ruSpriteDown(thread ref as Thread)

	local ret as integer
	
	if ru.rt.ptrDown
		if GetspriteHitTest(getsprite(ma.things[thread.thingIdx].obj), in.ptrX, in.ptrY)
			ret = true
		else 
			ret = false
		endif
	else 
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if the sprite is released.
//
function ruSpriteReleased(thread ref as Thread)

	local ret as integer
	
	if ru.rt.ptrReleased
		if GetspriteHitTest(getsprite(ma.things[thread.thingIdx].obj), in.ptrX, in.ptrY)
			ret = true
		else 
			ret = false
		endif
	else 
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if a var is pressed.
//
function ruVarPressed(thread ref as Thread, cmd ref as Cmd)

	local ret as integer

	if ru.rt.ptrPressed
		ret = ruVarCheck(thread, cmd)
	else 
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if a var is down.
//
function ruVarDown(thread ref as Thread, cmd ref as Cmd)

	local ret as integer

	if ru.rt.ptrDown
		ret = ruVarCheck(thread, cmd)
	else 
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if a var is pressed.
//
function ruVarReleased(thread ref as Thread, cmd ref as Cmd)

	local ret as integer

	if ru.rt.ptrReleased
		ret = ruVarCheck(thread, cmd)
	else 
		ret = false
	endif
	
endfunction ret
//-----------------------------------------------------
// Return true if a var is pressed.
//
function ruVarCheck(thread ref as Thread, cmd ref as Cmd)

	local ret as integer
	local varIdx as integer

	ret = false
	varIdx = ruGetVarCmdPtr(thread, cmd, 1)

	if varIdx > -1			
		if ma.vars[varIdx].rv.bg
			if coPointWithinRect(in.ptrX, in.ptrY, getspritex(ma.vars[varIdx].rv.bg), getspritey(ma.vars[varIdx].rv.bg), GetSpriteWidth(ma.vars[varIdx].rv.bg), GetSpriteHeight(ma.vars[varIdx].rv.bg))				
				ret = true				
			endif			
		endif	
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if thing in the thread collided with another thing.
//
function ruCollidedThing(thread ref as Thread, part ref as Part)

	local i as integer
	local ret as integer
	local selThingCmd as integer
	local selThingIdx as integer

	ret = false
	
	if ma.things[thread.thingIdx].collThings.length > -1
		
		selThingCmd = cdGetPartAsInt(part)

		if selThingCmd
			
			selThingIdx = maFindThingById(ru.appIdx, cdGetPartAsString(ma.cmds[selThingCmd].parts[0]))

			if selThingIdx > -1
				if ma.things[thread.thingIdx].collThings.find(selThingIdx) > -1
					ret = true
				endif			
			endif

		endif

	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if thing in the thread collided with another thing.
//
function ruCollidedAnyThing(thread ref as Thread, cmd ref as Cmd)

	local i as integer
	local ret as integer
	local thingIdx as integer

	ret = false
	
	if ma.things[thread.thingIdx].collThings.length > -1

		for i = 0 to ma.things[thread.thingIdx].collThings.length
			
			thingIdx = ma.things[thread.thingIdx].collThings[i]
			
			if ma.things[thingIdx].clonedIdx = -1
				
				ret = true
				exit
				
			endif
			
		next 
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if thing in the sprite in this thread collided with a clone of the sprite in the cmd.
//
function ruCollidedClone(thread ref as Thread, part ref as Part)

	local i as integer
	local ret as integer
	local selThingCmd as integer
	local selThingIdx as integer
	local hitThingIdx as integer

	ret = false
	
	if ma.things[thread.thingIdx].collThings.length > -1
		
		selThingCmd = cdGetPartAsInt(part)

		if selThingCmd
			
			//otherThingIdx = cdGetPartAsInt(ma.cmds[otherThingCmd].parts[0])
			selThingIdx = maFindThingById(ru.appIdx, cdGetPartAsString(ma.cmds[selThingCmd].parts[0]))

			if selThingIdx > -1
				
				for i = 0 to ma.things[thread.thingIdx].collThings.length
					
					hitThingIdx = ma.things[thread.thingIdx].collThings[i]
						
					if ma.things[hitThingIdx].clonedIdx > -1
							
						if ma.things[hitThingIdx].clonedIdx = selThingIdx	
											
							ret = true
							exit
							
						endif
						
					endif
					
				next 
				
			endif

		endif
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if thing in the sprite in this thread collided with a clone of the sprite in the cmd.
//
function ruCollidedAnyClone(thread ref as Thread, cmd ref as Cmd)

	local i as integer
	local ret as integer
	local thingIdx as integer

	ret = false
	
	if ma.things[thread.thingIdx].collThings.length > -1
		
		for i = 0 to ma.things[thread.thingIdx].collThings.length
			
			thingIdx = ma.things[thread.thingIdx].collThings[i]
			
			if ma.things[thingIdx].clonedIdx > -1
				
				ret = true
				exit
				
			endif
			
		next 
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if the thing is a sprite.
//
function ruIamSprite(thread ref as Thread, cmd ref as Cmd)

	local ret as integer
	
	ret = ma.things[thread.thingIdx].clonedIdx = -1 
	
endfunction ret

//-----------------------------------------------------
// Return true if the thing is a clone.
//
function ruIamClone(thread ref as Thread, cmd ref as Cmd)

	local ret as integer
	
	ret = ma.things[thread.thingIdx].clonedIdx > -1 
	
endfunction ret

//-----------------------------------------------------
// Return true if thing is total off screen or not.
//
function ruIsPosOffScreen(thread ref as Thread)

	local spr as integer
	local ret as integer
	
	spr = getsprite(ma.things[thread.thingIdx].obj)

	if getspritex(spr) > ru.w - 1 or getspritex(spr) + GetSpriteWidth(spr) < 0 or getspritey(spr) > ru.h - 1 or getspritey(spr) + GetSpriteHeight(spr) < 0
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Return true if thing collided with edge.
//
function ruCheckCollidedEdge(thread ref as Thread, matchCollEdges as integer)

	local spr as integer
	local actualCollEdges as integer

	spr = getsprite(ma.things[thread.thingIdx].obj)
	actualCollEdges = 0

	if matchCollEdges && DIR_W
		if getspritex(spr) <= 0
			actualCollEdges = actualCollEdges || DIR_W
		endif
	endif

	if matchCollEdges && DIR_E
		if getspritex(spr) + GetSpriteWidth(spr) > ru.w - 1
			actualCollEdges = actualCollEdges || DIR_E
		endif
	endif

	if matchCollEdges && DIR_N
		if getspritey(spr) <= 0
			actualCollEdges = actualCollEdges || DIR_N
		endif
	endif

	if matchCollEdges && DIR_S
		if getspritey(spr) + GetSpriteHeight(spr) > ru.h - 1
			actualCollEdges = actualCollEdges || DIR_S
		endif
	endif
	
endfunction actualCollEdges

//-----------------------------------------------------
// Get the bit value of the edges in edges.
//
function ruGetCollEdgeValue(edges as string)

	local i as integer
	local edge as string
	local collEdges as integer
	local count as integer

	collEdges = 0

	count = CountStringTokens2(edges, ",")
	
	for i = 1 to count

		edge = GetStringToken2(edges, ",", i)

		if edge = "left"
			collEdges = collEdges || DIR_W
		endif

		if edge = "right"
			collEdges = collEdges || DIR_E
		endif

		if edge = "top"
			collEdges = collEdges || DIR_N
		endif

		if edge = "bottom"
			collEdges = collEdges || DIR_S
		endif
		
	next
	
endfunction collEdges

//-----------------------------------------------------
// Return true if thing in the thread collided with the specified edge.
//
function ruCollidedEdge(thread ref as Thread, part ref as Part)

	local ret as integer
	local i as integer
	local edges as string
	local edge as string
	local matchCollEdges as integer
	local actualCollEdges as integer
	local count as integer

	//ret = false
	ret = 0
	edges = cdGetPartAsString(part)
	matchCollEdges = ruGetCollEdgeValue(edges)
	actualCollEdges = ruCheckCollidedEdge(thread, matchCollEdges)

	if actualCollEdges > 0

		if matchCollEdges && DIR_W
			if actualCollEdges && DIR_W				
				ret = ret || DIR_W
			endif
		endif

		if matchCollEdges && DIR_E
			if actualCollEdges && DIR_E
				ret = ret || DIR_E
			endif
		endif

		if matchCollEdges && DIR_N
			if actualCollEdges && DIR_N				
				ret = ret || DIR_N
			endif
		endif

		if matchCollEdges && DIR_S
			if actualCollEdges && DIR_S				
				ret = ret || DIR_S
			endif
		endif

	endif
	
endfunction ret

//-----------------------------------------------------
// Get the value for the info.
//
function ruGetInfoValue(info as string)
	
endfunction

//-----------------------------------------------------
// Clear all sounds.
//
function ruClearSounds()

	local i as integer
	
	for i = 0 to ma.sounds.length
		ruUnloadSound(i)
	next

	//ru.rt.sounds.length = -1

endfunction

//-----------------------------------------------------
// Reset the pen.
//
function ruClearPen(thingIdx as integer)
	
	ma.things[thingIdx].pen.active = false
	ma.things[thingIdx].pen.col = co.black
	ma.things[thingIdx].pen.size = 1.0
	ma.things[thingIdx].pen.style = CO_LINE_MID_CIRC
	ma.things[thingIdx].pen.pts.length = -1

	if ma.things[thingIdx].pen.spr
		
		deletesprite(ma.things[thingIdx].pen.spr)
		ma.things[thingIdx].pen.spr = 0
		
	endif
	
endfunction

//-----------------------------------------------------
// 
function ruAddPenPoint(thread ref as Thread, start as integer, x as integer, y as integer)

	local pp as PenPoint

	pp.x1 = x
	pp.y1 = y
	pp.col = ma.things[thread.thingIdx].pen.col
	pp.size = ma.things[thread.thingIdx].pen.size
	pp.style = ma.things[thread.thingIdx].pen.style
	pp.depth = getdepth(ma.things[thread.thingIdx].obj)
	
	if start

		pp.x0 = pp.x1
		pp.y0 = pp.y1
	
	elseif ma.things[thread.thingIdx].pen.pts.length > -1

		// Get last point.
		pp.x0 = ma.things[thread.thingIdx].pen.pts[ma.things[thread.thingIdx].pen.pts.length].x1
		pp.y0 = ma.things[thread.thingIdx].pen.pts[ma.things[thread.thingIdx].pen.pts.length].y1

	else // Need to fall back to first point if no start set and no previous points.

		pp.x0 = pp.x1
		pp.y0 = pp.y1
		
	endif

	ma.things[thread.thingIdx].pen.pts.insert(pp)

endfunction

//
//*****************************************************
// END COMMANDS.
//*****************************************************
//
	

