#option_explicit

//-----------------------------------------------------
// Constants

#constant AG_CODE_FOLDER "agk"
#constant AG_MEDIA_FOLDER "media"
#constant AG_GFX_FOLDER "gfx"
#constant AG_FONTS_FOLDER "fonts"
#constant AG_CODE_FILE "main.agc"

#constant AG_ENTRY_FN 1
#constant AG_ENTRY_FN_START 2
#constant AG_ENTRY_FN_UPDATE 4
#constant AG_ENTRY_FN_MESSAGE 8

//-----------------------------------------------------
// Init.
//
global ag as AgkBuild
global _compilerPath as string = "C:\Program Files (x86)\The Game Creators\AGK2\Tier 1\Compiler\AGKCompiler.exe"

//
// The build data.
//

type AgkBuild
	
	agkCmds as AgkCmd[] // All loaded cmds from the AGKCommands table.
	agkGrps as AgkGrp[] // Group names for the left tabs.
	cmdHelp as string[]
	//tmpCmds as integer[]
	tmpCmds as AgkTmpCmd[]

endtype

// Each agk cmd will be one of these.

type AgkCmd

	sort as integer // Sort key.
	code as integer
	seq as integer
	typ as string
	grp as string
	subGrp as string
	doc as string // Original agk cmd.
	agk as string // Output string.
	codey as string // Codey input string.
	tabName as string
	tabNbr as integer
	retValue as integer
	open as string
	close as string
	show as integer
	entry as integer // A cmd container, e.g. on or fuction that is checked for code when generating.
	spec as string // For special cmd.
	specCol1 as string
	specCol2 as string
	text as integer // CMD_TEXT
	fn as integer // If true, then the cmd only runs in a function, and needs to be output as is.
	help as string
	tmpVar as integer // 1 = value, 2 = list.
	
	// Decoded cmd for easier output.
	params as AgkParam[]
	cmd as integer // The created cmd.
	
endtype

type AGKParam
	
	typ as integer
	value as string
	idx as integer // Index into Codey Cmd.
	spec as integer // Special action on the value.
	
endtype

// Cmd panels names.

type AgkGrp
	
	nbr as integer
	name as string
	iconName as string
	help as string
	
endtype

// 
// Gen code.
//

// The app to build.

type AGKTmpName
	
	name as string
	value as string
	typ as integer // 0 = var, 1 = fn, 2 = message.
	
endtype

type AGKTmpCmd
	
	cmd as integer
	typ as integer // 0 = var, 1 = list, 2 = message.
	agkIdx as integer
	
endtype

type AGKApp
	
	appIdx as integer
	code as string[]
	vars as string[]
	sounds as string[]
	videos as string[]
	sprs as AGKSprite[]
	allfns as string[]
	uname as integer[3] // 4 chars, 0-3
	tmpVars as string[10] // Allow for 10 temp vars in a cmd.
	tmpNames as AGKTmpName[]
	
endtype

// A sprite as part of an app.

type AGKSprite
	
	name as string
	sprIdx as integer
	imgs as string[]
	imgIdx as integer
	vars as string[]
	cmds as string[]
	onfns as string[]
	colls as string[] // Sprites that need to be added to the sprites collidable list.

endtype

type AgkOut
	
	strs as string[]
	indent as integer
	
endtype

//
// AGK builder code.
//

//-----------------------------------------------------
// Load the commands file.
//
function agAgkLoadCmds()

	local fh as integer
	local s as string
	local t as string
	local cols as string
	local agkCmd as AgkCmd
	local agkGrp as AgkGrp
	local count as integer
	local tab as string
	local i as integer
	local j as integer
	local ln as integer
	local found as integer
	local show as string
	local spec as string
	local help as string
	
	tab = chr(9)

	ag.agkcmds.length = -1
	ag.agkgrps.length = -1
	
	fh = OpenToRead(LD_MEDIA_DIR + "/agk/AGKCommands.tsv")
	while not FileEOF(fh)
		
		s = ReadLine(fh)	
			
		inc ln
		
		if ln = 1
			
			//ag.agkcmds.insert(agkCmd) // Throw in a black to make sure the agk cmds line up with the ma.cmds.
			continue
			
		endif
		
		count = CountStringTokens2(s, tab)
		
		i = 0
		agkCmd.code = 0
		inc i // Seq.
		agkCmd.seq = val(GetStringToken2(s, tab, i))
		inc i
		agkCmd.typ = GetStringToken2(s, tab, i)
		inc i
		agkCmd.grp = GetStringToken2(s, tab, i)
		inc i
		agkCmd.subGrp = GetStringToken2(s, tab, i)
		inc i
		agkCmd.doc = GetStringToken2(s, tab, i)
		agkCmd.doc = ReplaceString(agkCmd.doc, _Q, "", -1)
		inc i
		agkCmd.agk = GetStringToken2(s, tab, i)
		inc i
		agkCmd.codey = GetStringToken2(s, tab, i)
		inc i
		agkCmd.tabName = GetStringToken2(s, tab, i)
		inc i
		agkCmd.tabNbr = val(GetStringToken2(s, tab, i))
		inc i
		agkCmd.retValue = val(GetStringToken2(s, tab, i))
		inc i
		// Skip manual ret value override.
		inc i
		agkCmd.open = GetStringToken2(s, tab, i)
		inc i
		agkCmd.close = GetStringToken2(s, tab, i)
		inc i
		show = GetStringToken2(s, tab, i)
		inc i
		agkCmd.spec = GetStringToken2(s, tab, i)
		inc i
		agkCmd.specCol1 = GetStringToken2(s, tab, i)
		inc i
		agkCmd.specCol2 = GetStringToken2(s, tab, i)
		inc i
		agkCmd.help = GetStringToken2(s, tab, i)
		
		agkCmd.entry = false
		agkCmd.text = false
		agkCmd.show = true
		agkCmd.fn = false
		agkCmd.tmpVar = -1 // None.
		
		if show = "X"
			agkCmd.show = false			
		elseif show = "E"		
			agkCmd.entry = AG_ENTRY_FN		
		elseif show = "S"		
			agkCmd.entry = (AG_ENTRY_FN || AG_ENTRY_FN_START)
		elseif show = "U"		
			agkCmd.entry = (AG_ENTRY_FN || AG_ENTRY_FN_UPDATE)
		elseif show = "M"		
			agkCmd.entry = (AG_ENTRY_FN || AG_ENTRY_FN_MESSAGE)
		elseif show = "T"		
			agkCmd.text = true			
		elseif show = "F"		
			agkCmd.fn = true			
		elseif show = "P"		
			agkCmd.tmpVar = 21 // List
			agkCmd.fn = true			
		elseif show = "V"		
			agkCmd.tmpVar = 0 // Value
		elseif show = "L"		
			agkCmd.tmpVar = 1 // List
		elseif show = "Q1"		
			agkCmd.tmpVar = 11 // Quick list.
		elseif show = "Q2"		
			agkCmd.tmpVar = 12 // Quick list.
		elseif show = "Q3"		
			agkCmd.tmpVar = 13 // Quick list.
		elseif show = "Q4"		
			agkCmd.tmpVar = 14 // Quick list.
		endif

		if agkCmd.typ = "Language"
			agkCmd.typ = "L" // Short for quicker cmd.			
		elseif agkCmd.typ = "Command"
			agkCmd.typ = "C" // Short for quicker cmd.			
		else
			agkCmd.typ = "" // No other types valid.	
		endif
				
		found = false
		
		if ag.agkgrps.length > -1
			
			for j = 0 to ag.agkgrps.length
				if ag.agkgrps[j].nbr = agkcmd.tabNbr
					
					found = true
					exit
					
				endif
			next
			
		endif
		
		if not found
			
			agkGrp.nbr = agkCmd.tabNbr
			agkGrp.name = agkCmd.tabName
			agkGrp.iconName = "gfx/" + agkCmd.tabName + "Icon.png"
			ag.agkGrps.insert(agkGrp)
			
		endif
		
		agkCmd.sort = agkCmd.seq // (agkCmd.tabNbr << 8) + agkCmd.order
		
		ag.agkcmds.insert(agkCmd)
		
	endwhile
		
	closefile(fh)
	
	agAgkLoadHelp()
	cdSetupCmdHelp(ag.cmdhelp)

endfunction

//-----------------------------------------------------
// Load the code file as a string.
//
function agAgkLoadHelp()

	local fh as integer
	local s as string

	ag.cmdhelp.length = -1
	
	fh = OpenToRead(LD_MEDIA_DIR + "/agk/" + LD_CMD_HELP_FILE)

	if fh
		
		while not FileEOF(fh)
			
			s = ReadLine(fh)
			ag.cmdhelp.insert(s)
			
		endwhile
			
		closefile(fh)
		
	endif

endfunction

//-----------------------------------------------------
// Create the cmds.
//
function agAgkCreateCmds(x as float, y as float)

	local cmd as integer
	local tabNbr as integer
	local i as integer
	local order as integer
	local tmpCmd as AgkTmpCmd

	cd.qx = x
	cd.qy = y
			
	tabNbr = -1
	order = 1

	// Now add extra codes.
	for i = 0 to ag.agkcmds.length

		ag.agkcmds[i].code = ag.agkcmds[i].tabNbr * 0x1000 + order // + ag.agkcmds[i].order
		inc order
		
		if ag.agkcmds[i].retValue = 1 // Operator.
			ag.agkcmds[i].code = ag.agkcmds[i].code || (CMD_OPER << 16)
		elseif ag.agkcmds[i].retValue = 2 // Bool.
			ag.agkcmds[i].code = ag.agkcmds[i].code || (CMD_COND << 16)
		endif

		if ag.agkcmds[i].retValue = 3 // String.
			ag.agkcmds[i].code = ag.agkcmds[i].code || (CMD_OPER << 16) || (CMD_OSTR << 16)
		endif

		if ag.agkcmds[i].open <> "" and ag.agkcmds[i].close <> ""
			
			ag.agkcmds[i].code = ag.agkcmds[i].code || (CMD_OPEN << 16)
			ag.agkcmds[i].code = ag.agkcmds[i].code || (CMD_CLOSE << 16)
			
		elseif ag.agkcmds[i].open <> ""
			
			ag.agkcmds[i].code = ag.agkcmds[i].code || (CMD_CLOSE << 16)
			
		elseif ag.agkcmds[i].close <> ""
			
			ag.agkcmds[i].code = ag.agkcmds[i].code || (CMD_OPEN << 16)
			
		endif
		
		if ag.agkcmds[i].text
			ag.agkcmds[i].code = ag.agkcmds[i].code || (CMD_TEXT << 16)
		endif
				
		if ag.agkcmds[i].tabNbr <> tabNbr
			
			tabNbr = ag.agkcmds[i].tabNbr
			cd.qy = y
			order = 1 // Restart.

		endif

		agAgkMakeCmd(ag.agkcmds[i])

		if ag.agkcmds[i].show
					
			cmd = cdBuildCmdQuick(ag.agkcmds[i].code, ag.agkcmds[i].codey)	
			ma.cmds[cmd].help = ag.agkcmds[i].help

			ag.agkcmds[i].cmd = cmd
			
			if ag.agkCmds[i].tmpVar > -1
				
				if ag.agkCmds[i].tmpVar >= 11 and ag.agkCmds[i].tmpVar <= 14 // 11-14 is a quick list 1.
					
					ag.agkCmds[i].tmpVar = 1
					tmpCmd.agkIdx = i
					
				elseif ag.agkCmds[i].tmpVar = 21 // 21 is a param list .

					ag.agkCmds[i].tmpVar = 1
					tmpCmd.agkIdx = i

				endif

				tmpCmd.cmd = cmd
				tmpCmd.typ = ag.agkCmds[i].tmpVar
				ag.tmpCmds.insert(tmpCmd)
				
			endif
							
			cdSetSelCmdPos(cmd)
			cd.selCmds.insert(cmd)
							
			if ag.agkcmds[i].open <> "" or ag.agkcmds[i].codey = "" or not ag.agkcmds[i].show // This is a close or else cmd, hide it.
				
				cdSetCmdVisible(cmd, false)
				ma.cmds[cmd].active = false
			
			else 
				
				cd.qy = cd.qy + ma.cmds[cmd].h + CD_CMD_GAP * cd.cmdScales[ld.set.cmdSize]
	
			endif
			
		endif
	
	next 

	//ag.agkcmds.sort() 
	
	// Now build the open/close pairs.
	
	for i = 0 to ag.agkcmds.length
		
		if ag.agkcmds[i].open <> ""		
			ma.cmds[ag.agkcmds[i].cmd].openCmd = agAgkFindCmdByDoc(ag.agkcmds[i].open)
		endif

		if ag.agkcmds[i].close <> ""	
			ma.cmds[ag.agkcmds[i].cmd].closeCmd = agAgkFindCmdByDoc(ag.agkcmds[i].close)			
		endif

	next
	
endfunction

//-----------------------------------------------------
// Find a cmd by the seq number.
//
function agAgkFindCmdBySeq(seq as integer)

	local i as integer
	local selIdx as integer
	local cmd as integer
	
	cmd = 0
	
	for i = 0 to ag.agkcmds.length
		if ag.agkcmds[i].seq = seq
			
			selIdx = cdFindSelCmdIdx(ag.agkcmds[i].code)
			
			if selIdx > -1
			
				cmd = cd.selCmds[selIdx]
				exit
				
			endif
						
		endif
	next
		
endfunction cmd

//-----------------------------------------------------
// Find an agk cmd from a built cmd.
//
function agAgkFindCmdByCode(code as integer)
	
	local i as integer
	
	for i = 0 to ag.agkcmds.length
		if ag.agkcmds[i].code = code
			exitfunction i	
		endif
	next

endfunction -1

//-----------------------------------------------------
// Find a cmd by the doc value.
//
function agAgkFindCmdByDoc(doc as string)

	local i as integer
	local selIdx as integer
	local cmd as integer
	
	cmd = 0
	
	for i = 0 to ag.agkcmds.length
		if ag.agkcmds[i].doc = doc
			
			selIdx = cdFindSelCmdIdx(ag.agkcmds[i].code)
			
			if selIdx > -1
			
				cmd = cd.selCmds[selIdx]
				exit
				
			endif
						
		endif
	next
		
endfunction cmd

//-----------------------------------------------------
// Build a "fix" command for output.
//
function agAgkMakeCmd(agkCmd ref as AgkCmd)

	local cmd as integer
	local s as string
	local t as string
	local k as string
	local v as string
	local i as integer
	local count as integer
	local id as integer
	local typ as integer
	local def as string
	
	//cmd = cdCreateCmd(code)
	def = replacestring(agkCmd.agk, "S:,", "S:\c", -1) // Hack to fix comma split below.
	def = replacestring(def, "S::", "S:\o", -1) // Hack to fix colon split below.
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
		
		agAgkMakeParam(agkCmd, s)

	next
		
endfunction cmd

//-----------------------------------------------------
// Scan an AGK cmd and rip the name and parameters
// NOTE: S: can't have , or : in it. If you need that use a special S:: or S:,,
//
function agAgkMakeParam(agkCmd ref as AgkCmd, tok as string)
	
	local count as integer
	local s as string
	local param as AgkParam
	
	count = CountStringTokens2(tok, ":")
	
	if count > 0
		
		s = GetStringToken2(tok, ":", 1)
		param.typ = cdGetPartTypFromQuickCode(s)
		
	else 
		
		param.typ = PART_STR
		
	endif

	if count > 1	
		
		s = GetStringToken2(tok, ":", 2)
		
		if param.typ = PART_STR // Hack, override string type.
			
			param.idx = -1 // No need for string type.
			param.value = s
			
		else 
			
			if s <> ""
				param.idx = val(s)
			else 
				param.idx = -1
			endif

			//if param.typ = PART_SPRITE 
			//	param.value = str(param.idx) // Hack, add 0 if sprIdx lookup, not sprite.	
			//endif
			
		endif
		
	else 
		
		param.idx = -1
		
	endif

	if count > 2 // Convert to a different type.
		
		s = GetStringToken2(tok, ":", 3)

		if s = "N"
			param.spec = PART_INT
		elseif s = "F"
			param.spec = PART_FLOAT
		elseif s = "T"
			param.spec = PART_TXT
		elseif s = "L"
			param.spec = PART_LIST
		elseif s = "J"
			param.spec = PART_OBJ
		elseif s = "X"
			param.spec = PART_TMP_CREATE
		elseif s = "Y"
			param.spec = PART_TMP_FIND
		else 
			param.spec = PART_VAR
		endif
		
	endif
	
	if count > 3 // Grab the value.	
		param.value = GetStringToken2(tok, ":", 4)
	endif
		
	agkCmd.params.insert(param)
	
endfunction

//-----------------------------------------------------
// Execute AGKCompiler to build and run.
//
function agAgkBuild(appIdx as integer)
	
	local agkApp as AgkApp
	local comp as string
	
	agkApp.appIdx = appIdx
	
	if AGK_BUILD
		
		if (in.leftMouseReleased and ld.set.agkCompiler = "") or in.rightMouseReleased
						
			comp = ChooseRawFile("*.exe", true)
			
			if comp <> ""
				
				ld.set.agkCompiler = ReplaceString(comp, "\", "/", -1)
				ldSaveSettings()
				
			endif
			
		else 
			
			comp = "xxx" // Just to fire below.
			
		endif
		
	else 
		
		comp = "xxx" // Just to fire below.
		
	endif
		
	if comp <> ""
		
		coLogClear()
		
		//maAgkAppFolder()
		agAgkGenApp(agkApp)
		agAgkWriteCode(agkApp)
		//maAgkAppMedia()
		agAgkAppCompileAndRun(agkApp)
		
	endif
	
endfunction

//-----------------------------------------------------
// AGK build - Compile and run.
//
function agAgkCompileAndRun()
	
endfunction

//-----------------------------------------------------
// Build an app's code as AGK.
//
function agAgkGenApp(aa ref as AgkApp)

	local i as integer
	local s as string
		
	// App vars.
	
	for i = 0 to ma.apps[aa.appIdx].vars.length	
		agAgkGenVar(aa, aa.vars, ma.apps[aa.appIdx].vars[i])
	next

	// Sounds.
	
	for i = 0 to ma.apps[aa.appIdx].sounds.length
		agAgkGenSound(aa, ma.sounds[ma.apps[aa.appIdx].sounds[i]])
	next

	// Videos.
	
	for i = 0 to ma.apps[aa.appIdx].videos.length
		agAgkGenVideo(aa, ma.videos[ma.apps[aa.appIdx].videos[i]])		
	next

	// Sprites.
	
	for i = 0 to ma.apps[aa.appIdx].sprites.length	
		agAgkGenSprite(aa, ma.apps[aa.appIdx].sprites[i])
	next
		
endfunction
	
//-----------------------------------------------------
// Gen AGK sound.
//
function agAgkGenSound(aa ref as AgkApp, sound ref as Sound)
	
	local s as string
	
	s = ""
	
endfunction

//-----------------------------------------------------
// Gen AGK video.
//
function agAgkGenVideo(aa ref as AgkApp, video ref as Video)
	
	local s as string
	
	s = ""
	
endfunction

//-----------------------------------------------------
// Gen AGK sprite.
//
function agAgkGenSprite(aa ref as AgkApp, thingIdx as integer)

	local i as integer
	local j as integer
	local spr as AGKSprite
	local s as string
	local t as string
	local selIdx as integer
	local o as NbrOrder
	local order as NbrOrder[]
	local cmd as integer
	local checkCmd as integer
	local closeCmd as integer
	local agkIdx as integer
	local infn as integer
	local suf as string
	local pos as integer
	local pos2 as integer
	local off as integer

	spr.sprIdx = thingIdx // sprIdx
	spr.name = ma.things[thingIdx].name
	spr.imgIdx = ma.things[thingIdx].imgIdx

	// Encode images.
	spr.imgs.insert("local _h as Helper")
	spr.imgs.insert("_h.idx = _agkMakeSprite(" + agAgkGetSpriteIdx(spr) + ")")
			
	// TODO.
	for i = 0 to ma.things[thingIdx].imgs.length
		agAgkGenImage(aa, spr, ma.things[thingIdx].imgs[i])
	next

	// Inject sprite setup.	
	spr.imgs.insert("__sprs[_h.idx].name = \q" + spr.name + "\q")
	spr.imgs.insert("_agkSetSpriteImage(_h.idx, " + str(spr.imgIdx + 1) + ")")
	spr.imgs.insert("SetSpritePositionByOffset(__sprs[_h.idx].spr, " + str(ma.things[thingIdx].x) + "," + str(ma.things[thingIdx].y) + ")")
	spr.imgs.insert("SetSpriteAngle(__sprs[_h.idx].spr, " + str(ma.things[thingIdx].ang) + ")")
	spr.imgs.insert("SetSpriteScaleByOffset(__sprs[_h.idx].spr, " + str(ma.things[thingIdx].sx) + "," + str(ma.things[thingIdx].sy) + ")")
	spr.imgs.insert("SetSpriteShape(__sprs[_h.idx].spr, 3)")
	
	// Encode the vars.
	
	for i = 0 to ma.things[thingIdx].vars.length
		agAgkGenVar(aa, spr.vars, ma.things[thingIdx].vars[i])
	next
	
	// Gen a fake init images block.
	
	off = 0
	suf = agAgkGetSpriteIdx(spr) + str(off)
	inc off
	
	for i = 0 to ag.agkCmds.length
		if ag.agkCmds[i].entry && AG_ENTRY_FN_START
			
			selIdx = cdFindSelCmdIdx(ag.agkcmds[i].code)
			s = agAgkGenCmd(aa, spr, ma.cmds[cd.selcmds[selIdx]])
			agAgkClearTmpVars(aa)
			
			if suf <> ""
				
				//s = s + suf
				pos = FindString(s, "(")
					
				if pos > 0
					s = mid(s, 1, pos - 1) + suf + mid(s, pos, -1)
				endif
	
			endif	

			spr.imgs.insert(s, 0)
			spr.imgs.insert("endfunction")
			
		endif
	next
	
	// Put the fake onstart into the cmd list at the top.
	
	for i = 0 to spr.imgs.length
		spr.cmds.insert(spr.imgs[i])
	next
	
	// Get the order right based on the position in the panel.
	
	for i = 0 to ma.things[thingIdx].cmds.length

		cmd = ma.things[thingIdx].cmds[i]
		agkIdx = agAgkFindCmdByCode(ma.cmds[cmd].code)
		
		if agkIdx > -1
			if ag.agkCmds[agkIdx].entry && AG_ENTRY_FN
				
				o.nbr = ma.cmds[cmd].y
				o.idx = i
				order.insertsorted(o)
				
			endif
		endif

	next
	
	infn = false
	
	for j = 0 to order.length

		// Encode cmds.
			
		for i = order[j].idx to ma.things[thingIdx].cmds.length
										
			cmd = ma.things[thingIdx].cmds[i]			
			selIdx = cdFindSelCmdIdx(ma.cmds[cmd].code)
			checkCmd = cd.selCmds[selIdx]
			
			suf = ""
			
			if i = order[j].idx // Opening fn.
				
				closeCmd = ma.cmds[checkCmd].closeCmd				
				agkIdx = agAgkFindCmdByCode(ma.cmds[cmd].code)
			
				// Are we in a fn, but not an on... type?
				if (ag.agkCmds[agkIdx].entry && AG_ENTRY_FN) 
					if ag.agkCmds[agkIdx].entry && AG_ENTRY_FN_START or ag.agkCmds[agkIdx].entry && AG_ENTRY_FN_UPDATE or ag.agkCmds[agkIdx].entry && AG_ENTRY_FN_MESSAGE

						suf = agAgkGetSpriteIdx(spr) + str(off)
						inc off
						
					else
						
						inFn = true
						
					endif					
				endif
	
			endif
			
			s = agAgkGenCmd(aa, spr, ma.cmds[cmd])	
			agAgkClearTmpVars(aa)
			
			if suf <> ""
								
				pos = FindString(s, "(")
					
				if pos > 0
					s = mid(s, 1, pos - 1) + suf + mid(s, pos, -1)
				endif
	
			endif	
								
			if not infn and ag.agkCmds[agkIdx].fn // If we must be in a function to use this cmd, don't output it.
				s = ""
			endif
							
			if s <> ""			
				spr.cmds.insert(s)
			endif
			
			if i = order[j].idx
							
				spr.cmds.insert("local _h as Helper")
				spr.cmds.insert("_h.entryIdx = idx")
				
				if ag.agkCmds[agkIdx].entry && AG_ENTRY_FN_MESSAGE
					
					spr.cmds.insert("local list as integer")
					spr.cmds.insert("if not _agkCanAcceptMsg(idx, m) then exitfunction") // For me, but not my sprite.
					spr.cmds.insert("list = m.varIdx")
					spr.cmds.insert("if m.asMe") // As me, replace the idx to the calling sprite.
					spr.cmds.insert("idx = m.sprIdx")
					spr.cmds.insert("_h.entryIdx = idx")
					spr.cmds.insert("endif")

				endif
				
			endif
	
			if checkCmd = closeCmd // But we've hit the end cmd, turn off entry.				
				exit // Stop if not in entry code.					
			endif
			
		next
		
	next

	aa.sprs.insert(spr)
	
endfunction

//-----------------------------------------------------
// Clear temp vars.
//
function agAgkClearTmpVars(aa ref as AgkApp)

	local i as integer
				
	for i = 0 to aa.tmpVars.length
		aa.tmpVars[i] = ""
	next
	
endfunction

//-----------------------------------------------------
// Gen image.
//
function agAgkGenImage(aa ref as AgkApp, spr ref as AgkSprite, img ref as Image)
	
	spr.imgs.insert("_h.img = LoadImage(\qgfx/" + img.id + LD_GFX_FILE_SUFFIX + "\q)")
	spr.imgs.insert("__sprs[_h.idx].img.imgs.insert(_h.img)")
	
endfunction

//-----------------------------------------------------
// Gen AGK var.
//
function agAgkGenVar(aa ref as AgkApp, vars ref as String[], varIdx as integer)
	
	local i as integer
	local name as string
	local typ as string
	local idx as integer
	
	name = ReplaceString(ma.vars[varIdx].name, "-", "_", -1)
	
	if ma.vars[varIdx].typ = VAR_TYPE_VALUE
		
		vars.insert("__h.idx = _agkMakeVar(" + str(varIdx) + ", 0)")
		vars.insert("__vars[__h.idx].name = \q" + name + "\q")
		vars.insert("__vars[__h.idx].value = \q" + ma.vars[varIdx].value + "\q")
	
	elseif ma.vars[varIdx].typ = VAR_TYPE_LIST
			
		vars.insert("__h.idx = _agkMakeVar(" + str(varIdx) + ", 1)")
		vars.insert("__vars[__h.idx].name = \q" + name + "\q")
		
		for i = 0 to ma.vars[varIdx].list.length
			
			vars.insert("__h.item.value = \q" + ma.vars[varIdx].list[i].value + "\q")
			
			if ma.vars[varIdx].list[i].name <> ""
				vars.insert("__h.item.name = \q" + ma.vars[varIdx].list[i].name + "\q")
			endif

			vars.insert("__vars[__h.idx].items.insert(__h.item)")

		next
		
	endif
	
	vars.insert("__vars[__h.idx].cfg.x = " + str(ma.vars[varIdx].v.x))
	vars.insert("__vars[__h.idx].cfg.y = " + str(ma.vars[varIdx].v.y))
	vars.insert("__vars[__h.idx].cfg.w = " + str(ma.vars[varIdx].v.w))
	vars.insert("__vars[__h.idx].cfg.h = " + str(ma.vars[varIdx].v.h))
	vars.insert("__vars[__h.idx].cfg.name = \q" + ma.vars[varIdx].v.name + "\q")
	vars.insert("__vars[__h.idx].cfg.bgCol = " + str(ma.vars[varIdx].v.bgCol))
	vars.insert("__vars[__h.idx].cfg.titleVis = " + str(ma.vars[varIdx].v.titleVis))
	vars.insert("__vars[__h.idx].cfg.titleCol = " + str(ma.vars[varIdx].v.titleCol))
	vars.insert("__vars[__h.idx].cfg.titleDir = " + str(ma.vars[varIdx].v.titleDir))
	vars.insert("__vars[__h.idx].cfg.titleFont = " + str(ma.vars[varIdx].v.titleFont))
	vars.insert("__vars[__h.idx].cfg.titleFontSize = " + str(ma.vars[varIdx].v.titleFontSize))
	vars.insert("__vars[__h.idx].cfg.titleAlign = " + str(ma.vars[varIdx].v.titleAlign))
	vars.insert("__vars[__h.idx].cfg.boxCol = " + str(ma.vars[varIdx].v.boxCol))
	vars.insert("__vars[__h.idx].cfg.textCol = " + str(ma.vars[varIdx].v.textCol))
	vars.insert("__vars[__h.idx].cfg.textFont = " + str(ma.vars[varIdx].v.textFont))
	vars.insert("__vars[__h.idx].cfg.textFontSize = " + str(ma.vars[varIdx].v.textFontSize))
	vars.insert("__vars[__h.idx].cfg.textAlign = " + str(ma.vars[varIdx].v.textAlign))
	vars.insert("__vars[__h.idx].cfg.textSecret = " + str(ma.vars[varIdx].v.textSecret))
	vars.insert("__vars[__h.idx].text.vis = " + str(ma.vars[varIdx].v.vis))
	
	if ma.vars[varIdx].vis
		
		vars.insert("_agkShowVar(__h.idx, 0)")
		vars.insert("_agkDrawVar(__h.idx)")
		
	endif
	//_agkSetTextDepth(i, i)
		
endfunction

//-----------------------------------------------------
// Gen AGK cmd.
//
function agAgkGenCmd(aa ref as AgkApp, spr ref as AgkSprite, cmd ref as Cmd)

	local idx as integer
	local idx2 as integer
	local param as AgkParam
	local s as string = ""
	local t as string
	local i as integer
	local fromSeq as integer
	local toSeq as integer
	local doc as string
	local count as integer
	local cmdIdx as integer
	local collIdx as integer = -1
		
	idx = agAgkGetCmdByCode(cmd.code)
	
	// Check for special alternate commands. That is, if a value is special
	// then it is of the form: spec={part typ}:{part idx} speccol1={from cmd idx} speccol2={to cmd idx}
	// We look up the value of the part, then scan the cmds from fromIdx to toIdx to find a replacement agk.
	//
	if ag.agkCmds[idx].spec <> ""
		
		t = GetStringToken2(ag.agkCmds[idx].spec, ":", 1)
		param.typ = cdGetPartTypFromQuickCode(t)
		param.idx = val(GetStringToken2(ag.agkCmds[idx].spec, ":", 2))	
		
		if param.typ = PART_OBJ
			
			doc = agAgkGenParam(aa, spr, cmd, param)	
			
			if doc <> ""
				
				fromSeq = val(ag.agkCmds[idx].specCol1)
				toSeq = val(ag.agkCmds[idx].specCol2)
				
				// Find the cmd that matches the the value.
				for i = 0 to ag.agkCmds.length
					if ag.agkCmds[i].seq >= fromSeq and ag.agkCmds[i].seq <= toSeq
						if ag.agkCmds[i].doc = doc
							if ag.agkCmds[i].agk <> ""
							
								idx = i
								exit 
							
							endif						
						endif
					endif
				next
				
			endif
			
		elseif param.typ = PART_SPRITE_IDX
			
			if ag.agkCmds[idx].specCol1 = "C" // Collision.
				collIdx = val(ag.agkCmds[idx].specCol2)
			endif
			
		endif
			
	endif

	// Build the cmd output.
		
	for i = 0 to ag.agkCmds[idx].params.length	
		
		t = agAgkGenParam(aa, spr, cmd, ag.agkCmds[idx].params[i])	
		
		if collIdx = i
			spr.colls.insert(t)
		endif		

		s = s + t
		
	next

	// Clear vars.
				
	//for i = 0 to aa.tmpVars.length
	//	aa.tmpVars[i] = ""
	//next
	
endfunction s

//-----------------------------------------------------
// Get a an agk command by code.
//
function agAgkGetCmdByCode(code as integer)
	
	local i as integer
	
	for i = 0 to ag.agkCmds.length
		if ag.agkcmds[i].code = code
			exitfunction i
		endif
	next 
	
endfunction -1

//-----------------------------------------------------
// Get the idx for the sprite.
//
function agAgkGetSpriteIdx(spr ref as AgkSprite)
	
	local ret as string
	ret = str(spr.sprIdx + 1)
	
endfunction ret

//-----------------------------------------------------
// Get a populated param.
// pidx is the index into the agkparams array.
//
function agAgkGenParam(aa ref as AgkApp, spr ref as AgkSprite, cmd ref as Cmd, param ref as AgkParam)
	
	local s as string
	local name as string
		
	s = ""	
	
	if param.typ = PART_SPRITE
		
		s = "__sprs[" + agAgkGetSpriteIdx(spr) + "].spr"
		
	elseif param.typ = PART_SPRITE_IDX and param.idx <= 0
		
		if param.spec = PART_TXT
			s = s + param.value
		endif
		
		s = s + agAgkGetSpriteIdx(spr)
		
	elseif param.typ = PART_TMP_CREATE
		
		if param.spec > 0
			
			if aa.tmpVars[param.idx] = "" // Create.
				
				aa.tmpVars[param.idx] = agAgkCreateTempName(aa)
				name = aa.tmpVars[param.idx]
		
				if param.spec = PART_INT
					s = "local " + name + " as integer"		
				elseif param.spec = PART_FLOAT
					s = "local " + name + " as float"		
				elseif param.spec = PART_TXT
					s = "local " + name + " as string"		
				elseif param.spec = PART_COL
					s = "local " + name + " as Color"		
				elseif param.spec = PART_VAR		
					s = "local " + name + " as integer : " + name + " = _agkMakeVar(0, 0)"
				elseif param.spec = PART_LIST			
					s = "local " + name + " as integer : " + name + " = _agkMakeVar(0, 1)"
				endif
				
			else // Delete.

				if param.spec = PART_INT
					// Do nothing.
				elseif param.spec = PART_FLOAT
					// Do nothing.
				elseif param.spec = PART_TXT
					// Do nothing.
				elseif param.spec = PART_COL
					// Do nothing.
				elseif param.spec = PART_VAR		
					s = "_agkRemoveVar(" + aa.tmpVars[param.idx] + ")"
				elseif param.spec = PART_LIST			
					s = "_agkRemoveVar(" + aa.tmpVars[param.idx] + ")"
				endif
				
			endif
			
		else
			
			s = aa.tmpVars[param.idx]
			
		endif
				
	elseif param.idx > -1	
		
		s = agAgkPartAsString(aa, spr, param, cmd.parts[param.idx])
		
	elseif param.value <> ""
		
		s = param.value
		
	endif
		
endfunction s

//-----------------------------------------------------
// Find the name a unique name.
//
function agAgkFindTempName(aa ref as AgkApp, name as string, typ as integer)

	local i as integer
	
	for i = 0 to aa.tmpNames.length
		if aa.tmpNames[i].name = name and aa.tmpNames[i].typ = typ
			exitfunction i
		endif
	next 
	
endfunction -1

//-----------------------------------------------------
// Create a temp name.
//
function agAgkCreateTempName(aa ref as AgkApp)
	
	local i as integer
	local s as string
	local t as string
	local ln as integer

	ln = len(CO_LOWERS$)
	
	if aa.uname[0] = 0 // Hasn't been initialised yet.
		
		for i = 0 to aa.uname.length
			aa.uname[i] = 1
		next

	else 
			
		for i = aa.uname.length to 0 step -1
			
			inc aa.uname[i]
			
			if aa.uname[i] > ln
				aa.uname[i] = 1
			else 
				exit 
			endif
			
		next
		
	endif

	s = ""
		
	for i = 0 to aa.uname.length
		
		t = mid(CO_LOWERS$, aa.uname[i], 1)
		s = s + t
		
	next
	
endfunction s

//-----------------------------------------------------
// Find a temp cmd matching the cmd code.
//
function agAgkFindTmpCmd(code as integer, typ as integer, tc ref as AgkTmpCmd)
	
	local i as integer
	
	for i = 0 to ag.tmpCmds.length
		if ma.cmds[ag.tmpCmds[i].cmd].code = code and ag.tmpCmds[i].typ = typ
			
			tc.agkIdx = ag.tmpCmds[i].agkIdx
			tc.cmd = ag.tmpCmds[i].cmd
			tc.typ = ag.tmpCmds[i].typ
			exitfunction true
					
		endif
	next 
	
endfunction false

//-----------------------------------------------------
// Evaluate a part as a type.
//
// Get the part type from a code.
// i.e.
// A:<vAr> - either a simple var or list.
// B:<Bool>
// C:<Color>
// F:<Float>
// G:sprite idx for agk code.
// H:<tHing> - sprite.
// I:<cmd Id>
// J:<obJect var properies>, i.e. a list of items, e.g. edges.
// K:<Key, 1 to 127>
// L:<List> - a var list.
// M:<iMage>
// N:<iNteger>
// O:<videO>
// P:<Percentage>
// R:<fRame>
// S:<String>
// T:<Text>
// U:<soUnd>
// V:<Value> - a simple var.
// X:<Temp Var> - for agk generation code.
// Y:<temp name>
//
function agAgkPartAsString(aa ref as AgkApp, spr ref as AgkSprite, param ref as AgkParam, part ref as Part)

	local ret as string
	local cmd as integer
	local f as float
	local varIdx as integer
	local partVar as integer
	local agkIdx as integer
	local name as string
	local tn as AgkTmpName
	local idx as integer
	local selIdx as integer
	local cmdIdx as integer
	local s as string
	local tc as AgkTmpCmd

	if part.typ = PART_BOOL or part.typ = PART_INT or part.typ = PART_FLOAT or part.typ = PART_TXT or part.typ = PART_STR or part.typ = PART_COL or part.typ = PART_OBJ

		ret = cdGetPartAsString(part)

		if ret = ""
			
			if part.typ = PART_BOOL
				ret = "false"
			elseif part.typ = PART_INT
				ret = "0"
			elseif part.typ = PART_FLOAT
				ret = "0.0"
			elseif part.typ = PART_TXT
				if param.spec = PART_VAR
				elseif param.spec = PART_TMP_CREATE
					ret = agAgkCreateTempName(aa)
				else 
					ret = "\q\q"
				endif
			elseif part.typ = PART_STR
				ret = "\q\q"
			elseif part.typ = PART_COL
				if param.typ = PART_INT or param.typ = PART_FLOAT
					ret = "coDecToColor(\q" + ret + "\q)"
				else
					ret = "\q#000000\q"
				endif
			elseif part.typ = PART_OBJ
				if param.typ = PART_INT or param.typ = PART_FLOAT
					ret = "-1"
				else 
					ret = "\q\q"
				endif
			endif
			
		else
								
			if part.typ = PART_INT or part.typ = PART_FLOAT
				if param.typ = PART_TXT
					ret = "str(" + ret + ")"
				endif
			elseif part.typ = PART_TXT
				
				if param.spec = PART_VAR
					
					// Do nothing, just return as is.
						
				elseif param.spec = PART_TMP_CREATE
					
					if param.spec = PART_FLOAT
						tn.typ = 1
					elseif param.spec = PART_INT
						tn.typ = 2
					endif

					idx = agAgkFindTempName(aa, ret, tn.typ)
					
					if idx > -1 // Already found, override to point to new function.
						
						aa.tmpNames[idx].value = agAgkCreateTempName(aa)
						aa.tmpNames[idx].typ = tn.typ
						ret = aa.tmpNames[idx].value
						
					else 
						
						// Store the real fn name against a unique for later lookups.
						tn.name = agAgkGetSpriteIdx(spr) + ":" + ret
						tn.value = agAgkCreateTempName(aa)												
						aa.tmpNames.insert(tn)
						ret = tn.value
						
					endif
					
				elseif param.spec = PART_TMP_FIND
					
					// Insert a lookup into the front of the function to find later.
					if param.spec = PART_FLOAT
						ret = "[\q1:" + ret + "\q]"
					elseif param.spec = PART_INT
						ret = "[\q2:" + ret + "\q]"
					else
						ret = "[\q0:" + ret + "\q]"
					endif

				else
					if param.typ = PART_INT
						ret = "val(\q" + ret + "\q)"
					elseif param.typ = PART_FLOAT
						ret = "valfloat(\q" + ret + "\q)"
					elseif param.typ = PART_TXT
						ret = "\q" + ret + "\q"
					endif
				endif
				
			elseif part.typ = PART_COL
				if param.typ = PART_INT or param.typ = PART_FLOAT
					ret = "coDecToColor(\q" + ret + "\q)"
				else
					ret = "\q" + ret + "\q"
				endif
			elseif part.typ = PART_OBJ
				if param.typ = PART_INT or param.typ = PART_FLOAT
					if param.spec = PART_OBJ
						if param.value <> ""
							ret = cdGetObjVarVals(param.value, ret, true)
						else 
							ret = "-1"
						endif
					else 
						ret = "-1"
					endif
				endif
			endif
	
		endif

	elseif part.typ = PART_VAR_NAME

		//varIdx = cdGetPartAsInt(part)
		//ret = ma.vars[varIdx].name

	elseif part.typ = PART_FRAME

		ret = cdGetPartAsString(part)

	elseif part.typ = PART_VALUE

		varIdx = cdGetPartAsInt(part)

		if varIdx
				
			name = replacestring(ma.vars[varIdx].name, "-", "_", -1)

			if ma.vars[varIdx].thingIdx > -1
				name = name + agAgkGetSpriteIdx(spr)
			endif

			if param.typ = PART_INT
				ret = "val(__vars[" + str(varIdx) + "].value)"			
			elseif param.typ = PART_FLOAT			
				ret = "valfloat(__vars[" + str(varIdx) + "].value)"			
			elseif param.typ = PART_TXT			
				ret = "__vars[" + str(varIdx) + "].value" // Make it a string.								
			else		
				ret = str(varIdx)
			endif
			
		else 
			
			ret = "0"
						
		endif

	elseif part.typ = PART_LIST

		varIdx = cdGetPartAsInt(part)

		if varIdx
				
			name = replacestring(ma.vars[varIdx].name, "-", "_", -1)

			if ma.vars[varIdx].thingIdx > -1
				name = name + agAgkGetSpriteIdx(spr)
			endif

			if param.typ = PART_INT or param.typ = PART_FLOAT				
				ret = "__vars[" + str(varIdx) + "].items.length"				
			elseif param.typ = PART_TXT
				ret = "_agkJoinList(" + str(varIdx) + ", \q,\q, 0)" // Make it a string.								
			else		
				ret = str(varIdx)
			endif
		
		else 
			
			ret = "0"
						
		endif

	elseif part.typ = PART_CMD
		
		//cmd = cdGetPartAsInt(part)
		//ret = agAgkGenCmd(aa, spr, ma.cmds[cmd])

		cmd = cdGetPartAsInt(part)

		if ma.cmds[cmd].code = CODE_VAR_GET
				
			varIdx = cdGetPartAsInt(ma.cmds[cmd].parts[0])
			
			if varIdx
				
				name = replacestring(ma.vars[varIdx].name, "-", "_", -1)
				
				if ma.vars[varIdx].thingIdx > -1
					name = name + agAgkGetSpriteIdx(spr)
				endif
				
				if ma.vars[varIdx].typ = VAR_TYPE_VALUE					

						if param.typ = PART_INT
							ret = "val(__vars[" + str(varIdx) + "].value)"			
						elseif param.typ = PART_FLOAT			
							ret = "valfloat(__vars[" + str(varIdx) + "].value)"			
						elseif param.typ = PART_TXT			
							ret = "__vars[" + str(varIdx) + "].value" // Make it a string.								
						else		
							ret = str(varIdx)
						endif
					
//					endif
					
				elseif ma.vars[varIdx].typ = VAR_TYPE_LIST

					if param.typ = PART_INT or param.typ = PART_FLOAT				
						ret = "__vars[" + str(varIdx) + "].items.length"				
					elseif param.typ = PART_TXT
						ret = "_agkJoinList(" + str(varIdx) + ", \q,\q, 0)" // Make it a string.								
					else		
						ret = str(varIdx)
					endif
					
				endif
				
			else 
				
				ret = "0"

			endif

		elseif agAgkFindTmpCmd(ma.cmds[cmd].code, 0, tc) // = ma.cmds[ag.tmpCmds[0]].code // Value
			
			s = cdGetPartAsString(ma.cmds[cmd].parts[1]) // Get the var name.
			//ret = "_agkGetTempVar(" + agAgkGetSpriteIdx(spr) + ",\q" + s + "\q,0)"			
			//ret = "_agkGetTempVar(idx,\q" + s + "\q,0)"			

			if param.typ = PART_INT
				ret = "val(__vars[_agkGetTempVar(idx,\q" + s + "\q,0)].value)"			
			elseif param.typ = PART_FLOAT			
				ret = "valfloat(__vars[_agkGetTempVar(idx,\q" + s + "\q,0)].value)"			
			elseif param.typ = PART_TXT			
				ret = "__vars[_agkGetTempVar(idx,\q" + s + "\q,0)].value"			
			else		
				ret = "_agkGetTempVar(idx,\q" + s + "\q,0)"			
			endif

		elseif agAgkFindTmpCmd(ma.cmds[cmd].code, 1, tc) // = ma.cmds[ag.tmpCmds[1]].code // List

			if tc.agkIdx > 0

				ret = agAgkGenCmd(aa, spr, ma.cmds[cmd])
				
			else 
							
				s = cdGetPartAsString(ma.cmds[cmd].parts[1]) // Get the list name.
				//ret = "_agkGetTempVar(" + agAgkGetSpriteIdx(spr) + ",\q" + s + "\q,1)"
				//ret = "_agkGetTempVar(idx,\q" + s + "\q,1)"
	
				if param.typ = PART_INT or param.typ = PART_FLOAT				
					ret = "__vars[_agkGetTempVar(idx,\q" + s + "\q,1)].items.length"			
				elseif param.typ = PART_TXT
					ret = "_agkJoinList(_agkGetTempVar(idx,\q" + s + "\q,1), \q,\q, 0)" // Make it a string.								
				else		
					ret = "_agkGetTempVar(idx,\q" + s + "\q,1)"
				endif
			
			endif

		elseif ma.cmds[cmd].code = CODE_SPRITE_PART
				
			//cmdIdx = cdGetPartAsInt(cmd.parts[1])
			s = cdGetPartAsString(ma.cmds[cmd].parts[0]) // ma.cmds[cmdIdx].parts[0])
			selIdx = maFindThingById(aa.appIdx, s)
			ret = str(selIdx + 1)

		elseif ma.cmds[cmd].code = CODE_FRAME_PART
		elseif ma.cmds[cmd].code = CODE_SOUND_BASE
		elseif ma.cmds[cmd].code = CODE_VIDEO_BASE
			
		else // General cmd.
	
			ret = agAgkGenCmd(aa, spr, ma.cmds[cmd])

			if ma.cmds[cmd].typ && CMD_OSTR
				
				agkIdx = agAgkFindCmdByCode(ma.cmds[cmd].code)
		
				if not ag.agkCmds[agkIdx].fn	
					if param.typ = PART_INT
						ret = "val(" + ret + ")"
					elseif param.typ = PART_FLOAT
						ret = "valfloat(" + ret + ")"
					elseif param.spec =PART_TXT // <> PART_VAR
						ret = "\q" + ret + "\q"
					endif	
				endif
				
			elseif ma.cmds[cmd].typ && CMD_OPER
				
				if param.typ = PART_TXT
					ret = "str(" + ret + ")"
				elseif param.typ = PART_LIST
					ret = param.value
				endif
				
			endif
			
		endif

	elseif part.typ = PART_SPRITE // H: slot with no sprite.
		
		ret = "0"
		
	else 

		ret = ""
			
	endif
	
endfunction ret

//-----------------------------------------------------
// Write app code.
//
function agAgkWriteCode(aa ref as AgkApp)
	
	local folder as string
	local fh as integer
	local out as AgkOut
	local i as integer
	local fontDir as string
	local file as string
	local files as string[]
	local toks as string[]
	
	// Save code file.

	out.indent = 0
	agAgkWriteApp(out, aa)

	folder = GetFolder()
	
	if SetFolder(ma.apps[aa.appIdx].folder)
		
		if not GetFileExists(AG_CODE_FOLDER)
			MakeFolder(AG_CODE_FOLDER)
		endif

		if SetFolder(AG_CODE_FOLDER)
	
			fh = OpenToWrite(AG_CODE_FILE)	
			
			for i = 0 to out.strs.length
				writeline(fh, out.strs[i])
			next
						
			closefile(fh)

			coCopyTextFile(LD_MEDIA_DIR + "/" + AG_CODE_FOLDER + "/input.agc", "input.agc")			
			coCopyTextFile(LD_MEDIA_DIR + "/" + AG_CODE_FOLDER + "/setup.agc", "setup.agc")			
			coCopyTextFile(LD_MEDIA_DIR + "/" + AG_CODE_FOLDER + "/common.agc", "common.agc")	
			coCopyTextFile(LD_MEDIA_DIR + "/" + AG_CODE_FOLDER + "/test.txt", ma.apps[aa.appIdx].name + ".agk")	
			
			MakeFolder(AG_MEDIA_FOLDER)			
			setfolder(AG_MEDIA_FOLDER)
			MakeFolder("gfx")
			setfolder("gfx")

			coCopyMediaFile(LD_MEDIA_DIR + "/" + AG_CODE_FOLDER + "/media/gfx/pix.png", "pix.png")
			coCopyMediaFile(LD_MEDIA_DIR + "/" + AG_CODE_FOLDER + "/media/gfx/circle.png", "circle.png")
			
			setfolder("..")
			
			fontDir = LD_MEDIA_DIR + "/" + AG_CODE_FOLDER + "/media/fonts/" // source folder.
					
			coGetFiles(fontDir + "Abril_Fatface", files)
			coGetFiles(fontDir + "Acme", files)
			coGetFiles(fontDir + "Chilanka", files)
			coGetFiles(fontDir + "Crimson_Text", files)
			coGetFiles(fontDir + "Lobster", files)
			coGetFiles(fontDir + "Muli", files)
			coGetFiles(fontDir + "Orbitron", files)
			coGetFiles(fontDir + "Oswald", files)
			coGetFiles(fontDir + "Parisienne", files)
			coGetFiles(fontDir + "Press_Start_2P", files)

			MakeFolder("fonts")
			setfolder("fonts")
			
			for i = 0 to files.length
				
				if left(files[i], 1) <> "."

					toks.length = -1
					coSplitString(toks, files[i], "/")
					
					fontDir = toks[toks.length - 1]
					file = toks[toks.length]
					
					MakeFolder(fontDir)
	
					coCopyMediaFile(files[i], fontDir + "/" + file)
					
				endif
				
			next
			
			setfolder("..")
			setfolder("..")			
			agAgkCopyAppMedia(aa.appIdx)

		endif
	
		setfolder("/" + folder)
		
	endif
	
endfunction

//-----------------------------------------------------
// Fix quotes.
//
function agAgkOutput(out ref as AgkOut, s as string)
	
	local i as integer
	local toks as string[]
	
	s = coRepeatString("\t", out.indent) + s
	s = ReplaceString(s, "\q", _Q, -1)
	s = ReplaceString(s, "\t", _T, -1)
	s = ReplaceString(s, "\c", ",", -1)
	s = ReplaceString(s, "\o", ":", -1)
	
	if FindString(s, "\n") > 0
		
		coSplitString(toks, s, "\n")
		
		for i = 0 to toks.length
			out.strs.insert(toks[i])			
		next
		
	else
		
		//s = ReplaceString(s, "\n", _N, -1)
		out.strs.insert(s)
		
	endif
	
endfunction

//-----------------------------------------------------
// Write app.
//
function agAgkWriteApp(out ref as AgkOut, aa ref as AgkApp)

	local i as integer
	local j as integer
	local k as integer
	local ln as integer
	local s as string
	local t as string
	local allfns as string[]
	local pos as integer
	local pos2 as integer
	local onfns as string[]
	local onfnparams as string[]
	local spronfn as string
	local t1 as string
	local t2 as string
	local w as float
	local h as float
	local toks as string[]
	local onstarts as string[]
	
	onfns = [ "onstart", "onupdate", "onmessage" ]
	onfnparams = [ "All()", "All()", "All(msg as string)" ]
	
	// Write app code.
	for i = 0 to aa.code.length
		agAgkOutput(out, aa.code[i])
	next

	// App header.
	
	agAgkOutput(out, "#option_explicit")
	agAgkOutput(out, "")
	agAgkOutput(out, "#include \qcommon.agc\q")
	agAgkOutput(out, "#include \qinput.agc\q")
	agAgkOutput(out, "#include \qsetup.agc\q")
	agAgkOutput(out, "")
		
	// App vars.
	//for i = 0 to aa.vars.length		
	//	agAgkOutput(out, aa.vars[i])
	//next

	agAgkOutput(out, "function initVars()")
	inc out.indent
	
	for i = 0 to aa.vars.length				
		agAgkOutput(out, aa.vars[i])
	next

	for i = 0 to aa.sprs.length			
		for j = 0 to aa.sprs[i].vars.length
			agAgkOutput(out, aa.sprs[i].vars[j])
		next
	next 

	dec out.indent
	agAgkOutput(out, "endfunction")

	agAgkOutput(out, "")

	// Sounds.
	for i = 0 to aa.sounds.length		
		agAgkOutput(out, aa.sounds[i])
	next

	agAgkOutput(out, "")
	
	// Videos.
	for i = 0 to aa.videos.length		
		agAgkOutput(out, aa.videos[i])
	next
	
	agAgkOutput(out, "")

	// Output sprite function.
		
	for i = 0 to aa.sprs.length	
		
		// Make vars for the sprite actually global, so all functions can see them.
		//for j = 0 to aa.sprs[i].vars.length
		//	agAgkOutput(out, aa.sprs[i].vars[j])
		//next
	
		agAgkOutput(out, "")
		agAgkWriteSprite(out, aa, aa.sprs[i])
		
	next
		
	// Output master All function.
	
	for i = 0 to onfns.length
		
		agAgkOutput(out, "function " + onfns[i] + onfnparams[i])
		inc out.indent

		agAgkOutput(out, "local _h as Helper")	

		if onfns[i] = "onstart"

			agAgkOutput(out, "initVars()")
			
			for j = 0 to aa.sprs.length	

				t1 = agAgkGetSpriteIdx(aa.sprs[j])
	
				for k = 0 to aa.sprs[j].onfns.length
					
					spronfn = aa.sprs[j].onfns[k]
									
					if left(spronfn, 9 + len(onfns[i])) = "function " + onfns[i]
																											
						s = agAgkFnDefToCall(spronfn)					
						s = agAgkReplaceFnParam(s, 0, t1)
						onstarts.insert(s)
						//agAgkOutput(out, s)
	
					endif
									
				next
				
			next
		
			agAgkSortOnfns(onstarts)
			
			for j = 0 to onstarts.length
				agAgkOutput(out, onstarts[j])
			next
			
		elseif onfns[i] = "onupdate"
													
			for j = 0 to aa.sprs.length	

				t1 = agAgkGetSpriteIdx(aa.sprs[j])
	
				for k = 0 to aa.sprs[j].onfns.length
					
					spronfn = aa.sprs[j].onfns[k]
									
					if left(spronfn, 9 + len(onfns[i])) = "function " + onfns[i]
														
						// Do a call to the actual sprite.
						s = agAgkFnDefToCall(spronfn)
						s = agAgkReplaceFnParam(s, 0, t1)
						agAgkOutput(out, s)

						// Make all clones active right now.
						agAgkOutput(out, "_h.i = 0")	
						agAgkOutput(out, "while _h.i <= __sprs[" + t1 + "].clone.idxs.length")					
						inc out.indent
						agAgkOutput(out, "__sprs[__sprs[" + t1 + "].clone.idxs[_h.i]].active = true")					
						agAgkOutput(out, "inc _h.i")
						dec out.indent	
						agAgkOutput(out, "endwhile")
										
						// Loop clones and call active ones. Anything created during this call won't be included.
						agAgkOutput(out, "_h.i = 0")					
						agAgkOutput(out, "while _h.i <= __sprs[" + t1 + "].clone.idxs.length")					
						inc out.indent
						agAgkOutput(out, "if __sprs[__sprs[" + t1 + "].clone.idxs[_h.i]].active")					
						inc out.indent
						s = agAgkFnDefToCall(spronfn)
						s = agAgkReplaceFnParam(s, 0, "__sprs[" + t1 + "].clone.idxs[_h.i]")
						agAgkOutput(out, s)
						dec out.indent
						agAgkOutput(out, "endif")
						agAgkOutput(out, "inc _h.i")
						dec out.indent	
						agAgkOutput(out, "endwhile")
		
					endif
									
				next
				
			next

		elseif onfns[i] = "onmessage"

			agAgkOutput(out, "if __msgs.length = -1 then exitfunction") // Short cut.
			agAgkOutput(out, "_h.j = 0")
			agAgkOutput(out, "while _h.j <= __msgs.length")
			inc out.indent
			agAgkOutput(out, "__msgs[_h.j].active = true")
			agAgkOutput(out, "inc _h.j")
			dec out.indent
			agAgkOutput(out, "endwhile")
			agAgkOutput(out, "_h.j = 0")
			agAgkOutput(out, "while _h.j <= __msgs.length")
			inc out.indent
			agAgkOutput(out, "_h.flag = false")
			agAgkOutput(out, "if __msgs[_h.j].active")
			inc out.indent
			agAgkOutput(out, "select __msgs[_h.j].msg")
			
			for j = 0 to aa.sprs.length	

				t1 = agAgkGetSpriteIdx(aa.sprs[j])
	
				for k = 0 to aa.sprs[j].onfns.length
					
					spronfn = aa.sprs[j].onfns[k]
									
					if left(spronfn, 9 + len(onfns[i])) = "function " + onfns[i]
																											
						s = agAgkFnDefToCall(spronfn)
						
						pos = findstring(s, "[\q")
						
						if pos > 0
							
							pos2 = findstring(s, "\q]", true, pos + 3)
							
							if pos2 > 0
								
								t = mid(s, pos + 3, pos2 - pos - 3) // The message.
								s = mid(s, 1, pos - 1) + mid(s, pos2 + 3, -1)
								
							endif
							
						endif
						
						if t <> ""
							
							agAgkOutput(out, "case \q" + t + "\q")
							agAgkOutput(out, "if (msg = \q\q or msg = \q" + t + "\q)")
							inc out.indent
							s = agAgkReplaceFnParam(s, 0, t1)
							s = agAgkReplaceFnParam(s, 1, "__msgs[_h.j]")
							agAgkOutput(out, s)
							
							// Make all clones active right now, to make sure if additional clones are created they are ignored.
							agAgkOutput(out, "_h.i = 0")	
							agAgkOutput(out, "while _h.i <= __sprs[" + t1 + "].clone.idxs.length")					
							inc out.indent
							agAgkOutput(out, "__sprs[__sprs[" + t1 + "].clone.idxs[_h.i]].active = true")					
							agAgkOutput(out, "inc _h.i")
							dec out.indent	
							agAgkOutput(out, "endwhile")
							
							// Loop clones and call active ones. Anything created during this call won't be included.
							agAgkOutput(out, "_h.i = 0")	
							agAgkOutput(out, "while _h.i <= __sprs[" + t1 + "].clone.idxs.length")					
							inc out.indent
							agAgkOutput(out, "if __sprs[__sprs[" + t1 + "].clone.idxs[_h.i]].active")					
							inc out.indent
							s = agAgkReplaceFnParam(s, 0, "__sprs[" + t1 + "].clone.idxs[_h.i]")
							agAgkOutput(out, s)
							dec out.indent
							agAgkOutput(out, "endif")
							agAgkOutput(out, "inc _h.i")
							dec out.indent	
							agAgkOutput(out, "endwhile")
							agAgkOutput(out, "_agkClearMsgTempVars(\q" + t + "\q)")
							agAgkOutput(out, "_h.flag = true")
							dec out.indent
							agAgkOutput(out, "endif")
							agAgkOutput(out, "endcase")
							
						endif
	
					endif
									
				next
				
			next
			
			agAgkOutput(out, "endselect")
			dec out.indent
			agAgkOutput(out, "endif")
			agAgkOutput(out, "if _h.flag")
			inc out.indent
			agAgkOutput(out, "__msgs.remove(_h.j)")
			dec out.indent
			agAgkOutput(out, "else")
			inc out.indent
			agAgkOutput(out, "inc _h.j")
			dec out.indent
			agAgkOutput(out, "endif")
			dec out.indent
			agAgkOutput(out, "endwhile")
					
		endif

		dec out.indent
		agAgkOutput(out, "endfunction")
		agAgkOutput(out, "")
		
	next
	
	if WIN_MODE
		
		s = cdGetObjVarVals(OBJ_VAR_SCREEN, str(ma.apps[aa.appIdx].screen), false)
		
	else 
		
		if ma.apps[aa.appIdx].status && LD_STATUS_MOB_LAND
			i = 2
		elseif ma.apps[aa.appIdx].status && LD_STATUS_MOB_PORT
			i = 5
		else 
			i = 0	
		endif
	
		s = cdGetObjVarVals(OBJ_VAR_SCREEN, str(i), false)
		
	endif

	coSplitString(toks, s, " ")

	w = valfloat(toks[1]) // co.w
	h = valfloat(toks[3]) // co.h

	agAgkOutput(out, "_agkRun(\q" + ma.apps[aa.appIdx].name + "\q," + str(w) + "," + str(h) + ")")
			
endfunction

//-----------------------------------------------------
// Sort the functions, but bring funcs with name 0( to the top.
//
function agAgkSortOnfns(list ref as string[])
	
	local i as integer
	local pos as integer
	local s as string
	
	i = list.length
	
	while i >= 0

		pos = FindString(list[i], "0(") // Find the artificial onstart.
		
		if pos > 0
			
			s = list[i]
			list.remove(i)
			list.insert(s, 0)
		
		endif
		
		dec i
		
	endwhile 
	
endfunction

//-----------------------------------------------------
// Convert a fn definition to a call, e.g. function onupdate0(delta as float) to onupdate0(delta)
//
function agAgkFnDefToCall(s as string)

	s = ReplaceString(s, "function ", "", -1)
	s = ReplaceString(s, " as ", "", -1)
	s = ReplaceString(s, "integer", "", -1)
	s = ReplaceString(s, "float", "", -1)
	s = ReplaceString(s, "string", "", -1)
	s = ReplaceString(s, "[]", "", -1)

endfunction s

//-----------------------------------------------------
// Replace a fn param.
//
function agAgkReplaceFnParam(s as string, idx as integer, p as string)

	local pos as integer
	local pos2 as integer
	local params as string
	local toks as string[]
	
	pos = findstring(s, "(")
	
	if pos > 0
		
		pos2 = FindStringReverse(s, ")")
		
		if pos2 > 0
			
			params = mid(s, pos + 1, pos2 - pos - 1)
			coSplitString(toks, params, "\c")
			toks[idx] = p
			p = coJoinList(toks, "\c")
			s = mid(s, 1, pos) + p + mid(s, pos2, -1)
			
		endif
		
	endif
	
endfunction s

//-----------------------------------------------------
// Replace a fn param.
//
function agAgkInsertFnParam(s as string, p as string)

	local pos as integer
	local pos2 as integer
	local ret as string
	
	pos = findstring(s, "(")
	
	if pos > 0
		
		pos2 = FindStringReverse(s, ")")		
		ret = mid(s, 1, pos) + p

		if pos2 > pos + 1 // If there was something between the (), then add a ,
			ret = ret + ","
		endif
		
		ret = ret + mid(s, pos + 1, -1) // Put back the rest.
		
	else 
		
		ret = s
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Write spr.
//
function agAgkWriteSprite(out ref as AgkOut, aa ref as AgkApp, spr ref as AgkSprite)
	
	local i as integer
	local j as integer
	local cmds as string[]
	local s as string
	local t as string
	local pos as integer
	local pos2 as integer

	i = 0
	
	while i <= spr.cmds.length
		
		if left(spr.cmds[i], 8) = "function" // Takes care of all functions.			
			i = agAgkWriteFn(aa, spr, cmds, i, false)		
		else		 					
			i = i + 1						
		endif
		
	endwhile
	
	// Output fn cmds.
	for i = 0 to cmds.length

		s = cmds[i]
		
		if left(s, 11) = "endfunction"

			if spr.colls.length > -1
				
				for j = 0 to spr.colls.length
					agAgkOutput(out, "__sprs[_h.idx].coll.collidable.insert(" + str(agAgkFindSprite(aa, spr.colls[j])) + ")")	
				next
				
				spr.colls.length = -1
				
			endif
			
			agAgkOutput(out, "_agkClearTempVars(idx)")				
			
			dec out.indent
			agAgkOutput(out, s)
			agAgkOutput(out, "")	
			
		elseif left(s, 8) = "function"

			spr.onfns.insert(s)

			// Fix functions.
			
			pos = findstring(s, "[\q")
			
			if pos > 0
				
				pos2 = findstring(s, "\q]", true, pos + 3)
				
				if pos2 > 0
					
					t = mid(s, pos + 3, pos2 - pos - 3)
					s = mid(s, 1, pos - 1) + mid(s, pos2 + 3, -1)
					
				endif
				
			endif

			agAgkOutput(out, s)
			inc out.indent
						
		else
			
			agAgkOutput(out, s)

		endif
		
	next

endfunction

//-----------------------------------------------------
// Find a sprite ny name.
//
function agAgkFindSprite(aa ref as AgkApp, name as string)
	
	local i as integer
	
	for i = 0 to aa.sprs.length		
		if aa.sprs[i].name = name
			exitfunction i
		endif
	next 
	
endfunction -1

//-----------------------------------------------------
// Find s in list.
// If found, the idx of the list returned, otherwise -1
// pos is the starting pos.
//
function agAgkFindStr(list as string[], s as string, pos as integer)
	
	local i as integer
	
	for i = pos to list.length
		if list[i] = s
			exitfunction i
		endif
	next 
	
endfunction -1

//-----------------------------------------------------
// Write spr.
//
function agAgkWriteFn(aa ref as AgkApp, spr ref as AgkSprite, cmds ref as string[], i as integer, ignore as integer)

	local subcmds as string[]
	local j as integer
	local exitFn as integer
	local pos as integer
	local pos2 as integer
	local pos3 as integer
	local pos4 as integer
	local s as string
	local name as string
	local value as string
	local idx as integer
	local sprIdx as integer
	local origSprIdx as integer
	local toks as string[]
	local tn as AGKTmpName

	if not ignore	
		cmds.insert(spr.cmds[i]) // Output the function.	
	endif
	
	i = i + 1
	
	exitFn = false

	while i <= spr.cmds.length
		
		if left(spr.cmds[i], 8) = "function" // Inner function.
						
			i = agAgkWriteFn(aa, spr, subcmds, i, true)
			
		else
			 
			if not ignore
				
				s = spr.cmds[i]
				
				// See if we need to map out actual name with uniq id.
					
				pos = FindString(s, "[\q", true, 0)
				
				if pos > 0
					
					pos2 = findstring(s, "\q]", true, pos + 1)
					
					if pos2 > 0
						
						name = mid(s, pos + 3, pos2 - pos - 3)
						pos3 = FindString(s, "(", true, pos2 + 3)
						
						if pos3 > 0
							
							pos4 = FindString(s, "\c", true, pos3 + 1)
							
							if pos4 > 0
								
								sprIdx = val(mid(s, pos3 + 1, pos4 - pos3 - 1))
								origSprIdx = sprIdx
								
								if sprIdx = 0
									sprIdx = val(agAgkGetSpriteIdx(spr))
								endif
								
								coSplitString(toks, name, ":")								
								//name = str(sprIdx) + ":" + name
								name = str(sprIdx) + ":" + toks[1]
								tn.typ = val(toks[0])
								idx = agAgkFindTempName(aa, name, tn.typ)
								
								if idx > -1
									value = aa.tmpNames[idx].value
								else 
									value = "_agkDummyFn"
								endif
								
								//s = mid(s, 1, pos - 1) + value + mid(s, pos2 + 3, -1)
								s = mid(s, 1, pos - 1) + value + "(" + mid(s, pos4 + 2, -1)
								
								if origSprIdx <> 0
									
									pos = findstring(s, "(idx\c")
									
									if pos > 0
										s = mid(s, 1, pos) + str(sprIdx) + mid(s, pos + 4, -1)
									endif
									
								endif
								
							endif
							
						endif
						
					endif
					
				endif
				
				cmds.insert(s)
				
			endif

			if left(spr.cmds[i], 11) = "endfunction"	
				exitFn = true						
			endif

			i = i + 1		
			
		endif
		
		if exitFn			
			exit 			
		endif
		
	endwhile

	// Put inside fns on the end.
	for j = 0 to subcmds.length
		cmds.insert(subcmds[j])
	next

endfunction i

//-----------------------------------------------------
// Copy all the assets from src app to dest.
// assumed to be in the code folder when we enter this.
//
function agAgkCopyAppMedia(appIdx as integer)

	local i as integer
	local j as integer
	local thingIdx as integer
	local srcFile as string
	local destFile as string 
	local gfxs as string[]
	local fonts as string[]
	
	// Sprites.
	
	for i = 0 to ma.apps[appIdx].sprites.length

		thingIdx = ma.apps[appIdx].sprites[i]

		for j = 0 to ma.things[thingIdx].imgs.length

			srcFile = ma.apps[appIdx].folder + LD_SPRITE_DIR + "/" + ma.things[thingIdx].imgs[j].id + LD_GFX_FILE_SUFFIX
			destFile = AG_MEDIA_FOLDER + "/gfx/" + ma.things[thingIdx].imgs[j].id + LD_GFX_FILE_SUFFIX
			coCopyMediaFile(srcFile, destFile)

		next
		
	next

	// Sounds.
	
	for i = 0 to ma.apps[appIdx].sounds.length

		thingIdx = ma.apps[appIdx].sounds[i]
		srcFile = ma.apps[appIdx].folder + LD_SOUND_DIR + "/" + ma.sounds[thingIdx].id + LD_WAV_FILE_SUFFIX
		destFile = AG_MEDIA_FOLDER + "/sounds/" + ma.sounds[thingIdx].id + LD_WAV_FILE_SUFFIX
		coCopyMediaFile(srcFile, destFile)
		
	next

	// Videos.
	
	for i = 0 to ma.apps[appIdx].videos.length

		thingIdx = ma.apps[appIdx].videos[i]
		srcFile = ma.apps[appIdx].folder + LD_VIDEO_DIR + "/" + ma.videos[thingIdx].id + LD_MP4_FILE_SUFFIX
		destFile = AG_MEDIA_FOLDER + "/videos/" + ma.videos[thingIdx].id + LD_MP4_FILE_SUFFIX
		coCopyMediaFile(srcFile, destFile)
		
	next

endfunction

//-----------------------------------------------------
// Compile the AGK main file. I'm already in the folder.
//
function agAgkAppCompileAndRun(aa ref as AgkApp)
	
	local app as integer
	local run as integer
	local i as integer
	local compiler as string
	local path as string
	local folder as string
	local exec as string
	local fh as integer
	local s as string
	
	folder = GetFolder()

	if SetFolder(ma.apps[aa.appIdx].folder + "/" + AG_CODE_FOLDER)

		compiler = "compile.bat"
		fh = OpenToWrite("compile.bat")				
		writeline(fh, "cd %1")
		//writeline(fh, _Q + _compilerPath + _Q + " -run main.agc > log.txt") 
		writeline(fh, _Q + ld.set.agkCompiler + _Q + " -run main.agc > log.txt") 
		closefile(fh)

		folder = GetFolder()
		
		path = GetWritePath() + folder
		exec = path + compiler
		app = RunApp(exec, path)
		//coLog("RunApp=" + str(app))
		//coLog("path for compile.bat: " + path)

		setfolder("/" + folder)

	endif
		
	if app
		
		for i = 1 to 5
			
			Sleep(1000)
			run = GetAppRunning(app)
			
			if run
				coLog("#" + str(i) + ": app is still running")
			else 
				exit
			endif
			
		next

		fh = opentoread("log.txt")
		
		if fh
			
			s = ReadString(fh)
			closefile(fh)
			
			if s <> ""
				coLog(s)
			endif
			
		endif
		
	endif

	folder = GetFolder()

endfunction

//-----------------------------------------------------
// Save a thing.
//
function agSaveThingImage(appIdx as integer, thingIdx as integer, imgIdx as integer)

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
// Save a sound.
//
function agSaveSound(appIdx as integer, soundIdx as integer)

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
function agSaveVideo(appIdx as integer, videoIdx as integer)

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

//
// End.
//
