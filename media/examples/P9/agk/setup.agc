#renderer "Basic"

#option_explicit

//-----------------------------------------------------------------
// Create constants.
//
#constant AGK_FROM_BACK = 0

//-----------------------------------------------------------------
// Create types.
//

type Animation
	
	active as integer
	w as float
	h as float
	count as integer
	frame as integer
	
endtype

type Image
	
	imgs as integer[]
	idx as integer

endtype

type Clone 
	
	idxs as integer[]
	ofIdx as integer
	name as string
	activeIdx as integer
	
endtype

type Collision 
	
	collidable as integer[] // Sprites to collide with.
	collided as CollEvent[] // The sprites that collided.
	
endtype

type CollEvent
	
	idx as integer
	typ as integer
	otherIdx as integer
	otherTyp as integer
	
endtype

type Sprite

	spr as integer // The sprite itself.
	name as string
	img as Image
	clone as Clone
	anim as Animation
	coll as Collision
	deleted as integer // Flag to set it's deleted.
	active as integer // Flag to indicate that clones are active for this cycle.

endtype

type Item
	
	name as string
	value as string

endtype

type Var

	name as string // Name.
	typ as integer // 0 = value, 1 = list.
	value as string // String value.
	items as Item[] // If it's a list.
	text as Text  // Text.
	cfg as TextConfig
	deleted as integer

endtype

type TmpVar
	
	name as string
	typ as integer // 0 = value, 1 = list.
	varIdx as integer // index into __vars array.
	sprIdx as integer // The spr to call as.
	sentMsg as string // If non "", then sent in a message, don't delete.
	
endtype

type Msg
	
	msg as string
	sprIdx as integer
	varIdx as integer // The list.
	toMe as integer
	asMe as integer
	wait as integer
	active as integer // For message loop.
	
endtype
	
type TextConfig
	
	// Designer / runtime settings.
	name as string
	//value as string // tmp holding area for efficiency.
	x as float // Position in designer / runtime.
	y as float
	w as float
	h as float
	mw as float
	mh as float
	bgCol as integer // The color of run cmd.
	bgVis as integer
	titleVis as integer // Whether the title is visible.
	titleFont as integer // The title font.
	titleFontSize as integer // The title font sizr.
	titleCol as integer // The color of run cmd title, i.e. var text.
	titleDir as integer // The position of the title, DIR_
	titleAlign as integer // Left, mid, right.
	textFont as integer // The text font.
	textFontSize as integer // The text font size.
	textCol as integer // The color of text in cmd.
	textAlign as integer // Left, Mid, Right
	textSecret as integer // Text is secret for passwords.
	boxCol as integer // The color of text box in cmd.
	boxVis as integer
	depth as integer
	offX as float
	offY as float
	xas as integer // for lists, 0=value, 1=name, 2=name:value

endtype

type Text // A variable as a text block.
	
	// Designer / runtime gfx.
	bg as integer
	title as integer
	box as integer
	text as integer
	edit as integer // EditBox.
	vis as integer // If set by the show/hide var.
	deleted as integer // Flag to set it's deleted.

endtype

type Helper

	img as integer // For manipulating images.
	spr as integer // For manipulating sprites.
	tmp as integer // For whatever.
	list as Var
	item as Item // For adding to lists.
	i as integer // For loops.
	j as integer
	x as float // x positions.
	y as float // y positions.
	col as integer // Color.
	idx as integer // The list value for lists.
	entryIdx as integer // The idx then entered this on{start|update} so it can be restored on a set clone cmd.
	flag as integer

endtype

//-----------------------------------------------------------------
// Create globals.
//

global __sprs as Sprite[]
global __freeSprs as integer[]
global __vars as Var[]
global __freeVars as integer[]
global __tmpVars as TmpVar[]
global __msgs as Msg[]
global __onmsgs as Item[]
global __colls as CollEvent[]
global __delta as float
global __h as Helper
global __col as integer // The current drawing color.
global __editVarIdx as integer = 0

//-----------------------------------------------------------------
// run.
//
function _agkRun(name as string, w as float, h as float)

	local x as float
	local y as float
	local m as float
	local ww as float
	local hh as float
	
	SetErrorMode(2)
	SetWindowTitle(name)
	SetOrientationAllowed(1, 1, 1, 1)
	SetSyncRate(60, 0)
	SetScissor(0, 0, 0, 0)
	UseNewDefaultFonts(1)

	setVirtualResolution(w, h) // Set working res, must start like this.
	coInit()
	inInit()
	
	m = 100
	x = GetMaxDeviceWidth() - m
	y = GetMaxDeviceHeight() - m

	// Determine the maximum size.
	
	if x - w < 0
		ww = x
	else
		ww = w
	endif

	if y - h < 0
		hh = y
	else
		hh = h
	endif
	
	// Now adjust to fit.
	
	if x - ww < y - hh
		
		m = x - ww
		ww = x - m
		hh = ww * (h / w)
		
	else
		
		m = y - hh
		hh = y - m
		ww = hh * (w / h)

	endif
		
	SetWindowSize(ww, hh, false)
	//SetWindowAllowResize(true)
	SetWindowPosition(x / 2 - ww / 2, y / 2 - hh / 2)
	coSetBorderColor(co.red[5])
	SetPhysicsDebugOn()
	
	// Init sprites.
	
	local idx as integer
	
	idx = _agkMakeSprite(0) // Waste the 0 spot to ensure we can safely check for 1.	
	__sprs[idx].spr = CreateDummySprite()

	idx = _agkMakeVar(0, 0) // Waste the 0 spot to ensure we can safely check for 1.	
	
	// Initial color.
	__col = coDecToColor("255255255255")
	
	onstartAll()

	// Go!
	
	do

		//Print( ScreenFPS() )
		__delta = GetFrameTime() * 60
		
		if __editVarIdx
			_agkCheckEditVar(__editVarIdx)
		endif
		
		inUpdate()
		
		if in.keyPressed = KEY_ESCAPE
			TerminateApp(0)
		endif
		
		onupdateAll()
		onmessageAll("")
		//_agkCheckAllSpriteCollisions()	

		Sync()

	loop

endfunction

//-----------------------------------------------------
// Dummy fn to make calls call if a fn name wasn't found.
//
function _agkDummyFn(idx as integer, list as integer)
endfunction

//-----------------------------------------------------
// Create a sprite placeholder.
//
function _agkDeltaAdd(v as float, a as float)
	
	local ret as float
	
	ret = v + (a * __delta)
			
endfunction ret

//-----------------------------------------------------
// Create a sprite placeholder.
//
function _agkMakeSprite(sprIdx as integer)

	local i as integer
	local idx as integer = -1
	local spr as Sprite

	if sprIdx > 0
		
		// See if its in the free list first.
		for i = 0 to __freeSprs.length
			if __freeSprs[i] = sprIdx
				
				idx = __freeSprs[i]
				__freeSprs.remove(i)
				exit
				
			endif
		next
		
		if idx = -1 // Still not found, nowe force it in the main list.
						
			// Create a gap with freevars.
			while __sprs.length < sprIdx - 1
				
				__sprs.insert(spr)
				_agkRemoveSprite(__sprs.length)
				
			endwhile
	
			// Now add the one we want.
			__sprs.insert(spr)
			idx = __sprs.length
		
		endif
		
	else // varIdx not set, take the next one avail.

		if __freeSprs.length >= 0
			
			idx = __freeSprs[0]
			__freeSprs.remove(0)
	
		else
			
			__sprs.insert(spr)
			idx = __sprs.length
	
		endif
		
	endif

	_agkInitSprite(idx)
	__sprs[idx].deleted = false

endfunction idx

//-----------------------------------------------------
// Clean up the sprite if necessary.
//
function _agkInitSprite(idx as integer)
	
	__sprs[idx].spr = 0
	__sprs[idx].img.imgs.length = -1
	__sprs[idx].img.idx = -1
	__sprs[idx].clone.idxs.length = -1
	__sprs[idx].clone.ofIdx = 0
	__sprs[idx].clone.name = ""
	__sprs[idx].clone.activeIdx = -1 // This should never be used.

	__sprs[idx].anim.active = false
	__sprs[idx].anim.w = 0
	__sprs[idx].anim.h = 0
	__sprs[idx].anim.count = 0
	__sprs[idx].anim.frame = 0

	__sprs[idx].coll.collidable.length = -1
	__sprs[idx].coll.collided.length = -1

endfunction

//-----------------------------------------------------
// Remove a sprite from the active list.
// Clean up the sprite if necessary.
//
function _agkRemoveSprite(idx as integer)
	
	if idx > 0 and idx <= __sprs.length
		
		if not __sprs[idx].deleted
	
			_agkDeleteSprite(idx)
			_agkInitSprite(idx)
			__sprs[idx].deleted = True
			__freeSprs.insert(idx)
	
		endif
		
	endif

endfunction

//-----------------------------------------------------
// Delete a sprite, only clones though.
//
function _agkDeleteSprite(idx as integer)
	
	if not __sprs[idx].clone.ofIdx and __sprs[idx].spr	
		if __sprs[idx].spr <> __sprs[0].spr // If not already pointing to dummy, delete it.
			
			deletesprite(__sprs[idx].spr)
			__sprs[idx].spr = __sprs[0].spr // Point towards dummy sprite, just in case it's still accessed.
	
		endif	
	endif

endfunction

//-----------------------------------------------------
// Clone a sprite.
//
function _agkCloneSprite(idx as integer, name as string)

	local parentIdx as integer
	local cloneIdx as integer
	local i as integer
		
	if __sprs[idx].clone.ofIdx
		parentIdx = __sprs[idx].clone.ofIdx
	else
		parentIdx = idx
	endif
	
	cloneIdx = _agkMakeSprite(0)
	__sprs[cloneIdx].spr = clonesprite(__sprs[idx].spr)
	SetSpriteScaleByOffset(__sprs[cloneIdx].spr, GetSpriteScaleX(__sprs[idx].spr), GetSpriteScaleY(__sprs[idx].spr))
	SetSpriteAngle(__sprs[cloneIdx].spr, GetSpriteAngle(__sprs[idx].spr))
	SetSpriteDepth(__sprs[cloneIdx].spr, GetSpriteDepth(__sprs[idx].spr))
	setSpriteShape(__sprs[cloneIdx].spr, 3)
	
	__sprs[cloneIdx].img.imgs.length = -1
	
	for i = 0 to __sprs[parentIdx].img.imgs.length
		__sprs[cloneIdx].img.imgs.insert(__sprs[parentIdx].img.imgs[i])
	next
	
	__sprs[cloneIdx].img.idx = __sprs[idx].img.idx

	__sprs[cloneIdx].anim.active = __sprs[idx].anim.active
	__sprs[cloneIdx].anim.w = __sprs[idx].anim.w
	__sprs[cloneIdx].anim.h = __sprs[idx].anim.h
	__sprs[cloneIdx].anim.count = __sprs[idx].anim.count
	__sprs[cloneIdx].anim.frame = __sprs[idx].anim.frame

	__sprs[cloneIdx].coll.collidable.length = -1
	
	for i = 0 to __sprs[parentIdx].coll.collidable.length
		__sprs[cloneIdx].coll.collidable.insert(__sprs[parentIdx].coll.collidable[i])
	next
	
	__sprs[cloneIdx].clone.ofIdx = parentIdx
	__sprs[cloneIdx].clone.name = name
	
	__sprs[cloneIdx].clone.activeIdx = -1 // This should never be used.
	__sprs[parentIdx].clone.activeIdx = -1
	
	__sprs[parentIdx].clone.idxs.insert(cloneIdx)

endfunction cloneIdx

//-----------------------------------------------------
// Set the active clone.
//
function _agkSetClone(entryIdx as integer, idx as integer, name as string)

	local ret as string
	local activeIdx as integer
	
	if __sprs[idx].clone.ofIdx
		idx = __sprs[idx].clone.ofIdx
	endif
	
	if name <> ""
		
		__sprs[idx].clone.activeIdx = _agkFindClone(idx, name) // Find the request clone, make it active.
		
		if __sprs[idx].clone.activeIdx > -1 // If active, change the idx to that clone.
			idx = __sprs[idx].clone.idxs[__sprs[idx].clone.activeIdx] // Return the clone idx.		
		endif
		
	else
		
		__sprs[idx].clone.activeIdx = -1
		idx = entryIdx

	endif
			
endfunction idx

//-----------------------------------------------------
// Change the clone name.
//
function _agkChangeCloneName(idx as integer, name as string)
	
	local cloneIdx as integer
	
	cloneIdx = idx
	
	if __sprs[idx].clone.ofIdx // This idx is a clone, go to parent.
		idx = __sprs[idx].clone.ofIdx
	endif
	
	if __sprs[idx].clone.activeIdx > -1 // If parent has an active clone, delete that.
		cloneIdx = __sprs[idx].clone.idxs[__sprs[idx].clone.activeIdx] // Return the clone idx.		
	endif

	__sprs[cloneIdx].clone.name = name
				
endfunction

//-----------------------------------------------------
// Get the clone name.
//
function _agkGetClone(idx as integer)
	
	local ret as string
	
	if __sprs[idx].clone.ofIdx // It's a clone, get its name.	
		
		ret = __sprs[idx].clone.name // Save here, this is the name of the clone with passed idx.
		idx = __sprs[idx].clone.ofIdx // Switch to parent to check active clone below.
				
	else
			
		ret = ""	
		
	endif
	
	if __sprs[idx].clone.activeIdx > -1 // If parent has an active clone change to that.
		
		idx = __sprs[idx].clone.idxs[__sprs[idx].clone.activeIdx] // Return the clone idx.		
		ret = __sprs[idx].clone.name

	endif
				
endfunction ret

//-----------------------------------------------------
// Check if myself (if name = "") or a specific name is a clone.
//
function _agkIsClone(idx as integer)
	
	local ret as integer
	
	if __sprs[idx].clone.ofIdx // This idx is a clone, go to parent and scan list.
		ret = true
	else
		ret = false
	endif
		
endfunction ret

//-----------------------------------------------------
// Delete a clone.
//
function _agkDeleteClone(idx as integer)
	
	local cloneIdx as integer
	
	cloneIdx = idx
	
	if __sprs[idx].clone.ofIdx // This idx is a clone, go to parent.
		idx = __sprs[idx].clone.ofIdx
	endif
	
	if __sprs[idx].clone.activeIdx > -1 // If parent has an active clone, delete that.
		cloneIdx = __sprs[idx].clone.idxs[__sprs[idx].clone.activeIdx] // Return the clone idx.		
	endif

	_agkRemoveSprite(cloneIdx)		
		
endfunction

//-----------------------------------------------------
// Find a sprite by name.
//
function _agkFindSprite(name as string)
	
	local i as integer
	local ret as integer
	
	ret = -1

	for i = 0 to __sprs.length
		
		if __sprs[i].name = name
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Find the clone in the list of clones for this sprite.
//
function _agkFindClone(idx as integer, name as string)
	
	local i as integer
	local ret as integer
	
	ret = -1

	if __sprs[idx].clone.ofIdx // This idx is a clone, go to parent.
		idx = __sprs[idx].clone.ofIdx
	endif
	
	for i = 0 to __sprs[idx].clone.idxs.length
		
		if __sprs[__sprs[idx].clone.idxs[i]].clone.name = name
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Find a message.
//
function _agkFindMsg(msg as string, ln as integer)
	
	local i as integer
	
	for i = 0 to ln // __msgs.length
		if __msgs[i].msg = msg
			exitfunction i
		endif
	next
	
endfunction -1

//-----------------------------------------------------
// Clear them.
//
function _agkClearMsgs(ln as integer)

	while ln > -1
		
		__msgs.remove(0)
		dec ln
		
	endwhile
	
endfunction

//-----------------------------------------------------
// Send a message to anyone who cares!
// sprIdx is the calling spr.
// whoTo the recipient, 0=ME, 1=ANY
// asMe if true will call the message as the calling sprite, not the receiving one.
// Wait = true makes it a fn call.
// maSetObjValue(var, "ANY", str(0))
// maSetObjValue(var, "ANY + WAIT", str(1))
// maSetObjValue(var, "ANY + AS ME", str(2))
// maSetObjValue(var, "ANY + AS ME + WAIT", str(3))
// maSetObjValue(var, "ME", str(4))
// maSetObjValue(var, "ME + WAIT", str(5))
//
function _agkSendMsg(sprIdx as integer, msg as string, list as integer, whoTo as integer)
	
	local m as Msg
	local idx as integer
	
	m.sprIdx = sprIdx
	m.msg = msg
	m.varIdx = list
	
	if whoTo >= 4 // ME, ME + WAIT
		
		m.toMe = true
		m.asMe = true
		
		if whoTo = 4
			m.wait = false
		elseif whoTo = 5
			m.wait = true
		endif

	else
		
		m.toMe = false
		
		if whoTo = 0 // ANY
		
			m.asMe = false
			m.wait = false
			
		elseif whoTo = 1 // ANY + WAIT
			
			m.asMe = false
			m.wait = true

		elseif whoTo = 2 // ANY + AS ME
			
			m.asMe = true
			m.wait = false

		elseif whoTo = 3 // ANY + AS ME + WAIT
			
			m.asMe = true
			m.wait = true
			
		endif

	endif
	
	
	idx = _agkFindTempVar(list) // See if it's a temp var.
	
	if idx > -1
		__tmpVars[idx].sentMsg = msg // Ensure it doesn't get trashed before it's delivered.
	endif
	
	__msgs.insert(m)
	
	if m.wait
		onMessageAll(m.msg) // Fire this message now.
	endif
	
endfunction

//-----------------------------------------------------
// Check if a message can be accepted by the onmessage function.
//
function _agkCanAcceptMsg(sprIdx as integer, m ref as Msg)

	if m.toMe // ME
		if m.sprIdx = sprIdx
			exitfunction true
		endif
	else
		exitfunction true
	endif
	
endfunction false

//-----------------------------------------------------
// Check collisions between all sprites.
//
function _agkCheckAllSpriteCollisions()
	
	local i as integer
	local j as integer
	local k as integer
	local coll as CollEvent
		
	__colls.length = -1
	
	for i = 1 to __sprs.length // Skip 0.

		if not __sprs[i].deleted
			
			if GetSpriteVisible(__sprs[i].spr)
			
				for j = 1 to __sprs.length
	
					if i <> j							
																
						if not __sprs[j].deleted
							
							if GetSpriteVisible(__sprs[j].spr)
						
								if GetSpriteCollision(__sprs[i].spr, __sprs[j].spr)
														
									if __sprs[i].clone.ofIdx
										coll.typ = 1 // Clone.
									else
										coll.typ = 0 // Sprite
									endif
									
									coll.idx = i
																								
									if __sprs[j].clone.ofIdx
										coll.otherTyp = 1 // Clone.
									else
										coll.otherTyp = 0 // Sprite
									endif
									
									coll.otherIdx = j
		
									__colls.insert(coll)
										
								endif
								
							endif
							
						endif	
						
					endif
					
				next
				
			endif
		
		endif	
	
	next
				
endfunction

//-----------------------------------------------------
// Check a collision but output the check.
//
function _agkGetAnyCollision(idx as integer)
	
	local i as integer
	
	for i = 0 to __colls.length
		if __colls[i].idx = idx
			exitfunction true
		endif
	next

endfunction false

//-----------------------------------------------------
// Check a collision between a sprite/clone and another sprite by name.
//
function _agkGetSpriteNameCollision(idx as integer, sprName as string)

	local ret as integer
	local otherIdx as integer
	local otherIdxs as integer[]
	local i as integer
	
	if sprName <> "" // This sprite.
			
		otherIdx = _agkFindSprite(sprName)
				
		if otherIdx and otherIdx <> idx
			
			otherIdxs.insert(otherIdx)
			ret = _agkGetSpriteCollision(idx, otherIdxs)
			
		else
			
			ret = false
			
		endif
		
	else // Any sprite.

		for i = 1 to __sprs.length
			if i <> idx		
				otherIdxs.insert(i)
			endif
		next
						
		ret = _agkGetSpriteCollision(idx, otherIdxs)
				
	endif
	
endfunction ret

//-----------------------------------------------------
// Check a collision between a sprite/clone and another sprite by name.
//
function _agkGetCloneNameCollision(idx as integer, sprName as string, cloneName as string)

	local ret as integer
	local otherIdx as integer
	local otherIdxs as integer[]
	local i as integer
	local j as integer
	
	if sprName <> "" // This sprite.
			
		otherIdx = _agkFindSprite(sprName)
				
		if otherIdx and otherIdx <> idx
						
			for i = 0 to __sprs[otherIdx].clone.idxs.length
				if cloneName = "" or __sprs[__sprs[otherIdx].clone.idxs[i]].clone.name = cloneName
					if __sprs[otherIdx].clone.idxs[i] <> idx
						otherIdxs.insert(__sprs[otherIdx].clone.idxs[i])
					endif
				endif
			next
						
			ret = _agkGetSpriteCollision(idx, otherIdxs)
			
		else
			
			ret = false
			
		endif
		
	else // All sprites.
		
		for j = 1 to __sprs.length
			
			if j <> idx
			
				for i = 0 to __sprs[j].clone.idxs.length
					if cloneName = "" or __sprs[__sprs[j].clone.idxs[i]].clone.name = cloneName
						if __sprs[otherIdx].clone.idxs[i] <> idx
							otherIdxs.insert(__sprs[j].clone.idxs[i])
						endif
					endif
				next
				
			endif
			
		next
						
		ret = _agkGetSpriteCollision(idx, otherIdxs)
		
	endif
	
endfunction ret

//-----------------------------------------------------
// Check if the sprite or clone of sprite has hit the otherIdxs.
//
function _agkGetSpriteCollision(idx as integer, otherIdxs as integer[])
	
	local i as integer
	local otherIdx as integer

	if not __sprs[idx].deleted							
		if GetSpriteVisible(__sprs[idx].spr)
			for i = 0 to otherIdxs.length
				
				otherIdx = otherIdxs[i]
				
				if not __sprs[otherIdx].deleted							
					if GetSpriteVisible(__sprs[otherIdx].spr)
						if GetSpriteCollision(__sprs[idx].spr, __sprs[otherIdx].spr)
							exitfunction true
						endif
					endif
				endif
				
			next
		endif
	endif										

endfunction false

//-----------------------------------------------------
// Check the distance to a sprite by name.
//
function _agkGetSpriteNameDistance(idx as integer, name as string)

	local ret as integer
	local otherIdx as integer
	
	otherIdx = _agkFindSprite(name)
	
	if otherIdx	
		ret = GetSpriteDistance(__sprs[idx].spr, __sprs[otherIdx].spr)
	else
		ret = -1
	endif
	
endfunction ret

//-----------------------------------------------------
// Move a sprite in the angle direction..
//
function _agkMoveSprite(idx as integer, dist as float)

	local sx as float
	local sy as float
	local ang as float
	local x as float
	local y as float
	
	//ret = ruEvalPartAsFloat(thread, cmd.parts[1])
	ang = getspriteangle(__sprs[idx].spr)
	sx = Sin(ang) * dist
	sy = -Cos(ang) * dist

	x = GetSpriteXByOffset(__sprs[idx].spr) + sx
	y = GetSpriteYByOffset(__sprs[idx].spr) + sy
	SetSpritePositionByOffset(__sprs[idx].spr, x, y)

endfunction

//-----------------------------------------------------
// Convert a sprite as an animation strip.
//
function _agkSetSpriteAnimation(idx as integer, w as float, h as float, count as integer)
				
	//if __sprs[idx].clone.ofIdx
	//	idx = __sprs[idx].clone.ofIdx
	//endif
		
	__sprs[idx].anim.active = true
	__sprs[idx].anim.w = w
	__sprs[idx].anim.h = h
	__sprs[idx].anim.count = count
		
endfunction

//-----------------------------------------------------
// Set a frame on an animation.
//
function _agkSetSpriteFrame(idx as integer, frame as integer)
						
	if __sprs[idx].anim.active
		if frame > 0 and frame <= __sprs[idx].anim.count
			
			__sprs[idx].anim.frame = frame
			SetSpriteFrame(__sprs[idx].spr, frame)
			
		endif
	endif
				
endfunction

//-----------------------------------------------------
// Fet a frame on an animation.
//
function _agkGetSpriteFrame(idx as integer)
						
	local ret as integer
	
	if __sprs[idx].anim.active
		ret = __sprs[idx].anim.frame
	else
		ret = 0
	endif
				
endfunction ret

//-----------------------------------------------------
// Set the sprite, create if needed.
//
function _agkSetSpriteImage(idx, imgIdx)

	if imgIdx > 0 and imgIdx <= __sprs[idx].img.imgs.length + 1
	
		__sprs[idx].img.idx = imgIdx - 1

		if not __sprs[idx].spr or __sprs[idx].spr = __sprs[0].spr // Dummy.
			__sprs[idx].spr = createsprite(__sprs[idx].img.imgs[__sprs[idx].img.idx])
		else 
			setspriteimage(__sprs[idx].spr, __sprs[idx].img.imgs[__sprs[idx].img.idx])
		endif
	
		setspritesize(__sprs[idx].spr, -1, -1)
		setspriteshape(__sprs[idx].spr, 3)
		
		__sprs[idx].anim.active = false // Turn off anim.
		
	endif

endfunction

//-----------------------------------------------------
// Fet a frame on an animation.
//
function _agkGetSpriteImage(idx as integer)
						
	local ret as integer
	
	if __sprs[idx].anim.active
		ret = 0
	else
		ret = __sprs[idx].img.idx + 1
	endif
				
endfunction ret

//-----------------------------------------------------
// Check if the var idx is valid.
//
function _agkIsValidVar(idx as integer)
	
	if idx > 0 and idx <= __vars.length		
		if not __vars[idx].deleted
			exitfunction true
		endif
	endif
	
endfunction false

//-----------------------------------------------------------------
// Inc a variable.
//
function _agkIncVar(idx as integer)

	local ival as integer
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif
	
	ival = val(__vars[idx].value)
	inc ival
	__vars[idx].value = str(ival)
	_agkDrawVar(idx)

endfunction

//-----------------------------------------------------------------
// Dec a variable.
//
function _agkDecVar(idx as integer)

	local ival as integer

	if not _agkIsValidVar(idx)
		exitfunction
	endif
	
	ival = val(__vars[idx].value)
	dec ival
	__vars[idx].value = str(ival)
	_agkDrawVar(idx)

endfunction

//-----------------------------------------------------------------
// set a var
//
function _agkSetVar(idx as integer, value as string)
		
	if not _agkIsValidVar(idx)
		exitfunction
	endif
		
	__vars[idx].value = value
	_agkDrawVar(idx)
	
endfunction

//-----------------------------------------------------------------
// Change a var.
//
function _agkChangeVar(idx as integer, value as string)
		
	if not _agkIsValidVar(idx)
		exitfunction
	endif
	
	__vars[idx].value = str(val(__vars[idx].value) + val(value))
	_agkDrawVar(idx)
	
endfunction

//-----------------------------------------------------------------
// Find a var idx based on name.
//
function _agkGetVarIdx(name as string)
	
	local i as integer
	
	for i = 0 to __vars.length
		if not __vars[i].deleted
			if __vars[i].name = name
				exitfunction i
			endif
		endif
	next
	
endfunction -1

//-----------------------------------------------------------------
// Get an item from a list.
//
function _agkGetList(list as integer)

	local ret as integer
	
	if _agkIsValidVar(list)
		ret = list
	else
		ret = 0
	endif

endfunction ret

//-----------------------------------------------------------------
// Insert or append an item into a list.
//
function _agkInsertListItem(list as integer, value as string, idx as integer)

	local item as Item

	if not _agkIsValidVar(list)
		exitfunction
	endif
	
	if idx = -1 or __vars[list].items.length = -1

		item.value = value
		__vars[list].items.insert(item) // Append.

	else 
	
		if AGK_FROM_BACK
			if idx < -1 // Insert from back.
	
				idx = __vars[list].items.length + 2 + idx
	
				if idx < 0
					idx = 0
				endif
				
			endif
		endif

		item.value = value
	
		if idx > __vars[list].items.length	
			__vars[list].items.insert(item)
		elseif idx > -1
			__vars[list].items.insert(item, idx)
		endif 

	endif

endfunction

//-----------------------------------------------------------------
// Set the value of an item in the list.
//
function _agkSetListItem(list as integer, idx as integer, value as string)

	local item as Item
	
	if _agkValidListIdx(list, idx, __h)
		__vars[list].items[__h.idx].value = value
	endif
	
endfunction

//-----------------------------------------------------------------
// Set the name of a list item in the list.
//
function _agkSetListItemName(list as integer, idx as integer, name as string)

	local item as Item
	
	if _agkValidListIdx(list, idx, __h)
		__vars[list].items[__h.idx].name = name
	endif

endfunction

//-----------------------------------------------------------------
// Get an item from a list.
//
function _agkGetListItem(list as integer, idx as integer)

	local ret as string
	
	if _agkValidListIdx(list, idx, __h)
		ret = __vars[list].items[__h.idx].value
	else
		ret = ""
	endif

endfunction ret

//-----------------------------------------------------------------
// Get a name from a list.
//
function _agkGetListItemName(list as integer, idx as integer)

	local ret as string
	
	if _agkValidListIdx(list, idx, __h)
		ret = __vars[list].items[__h.idx].name
	else
		ret = ""
	endif

endfunction ret

//-----------------------------------------------------------------
// Remove an item from a list.
//
function _agkRemoveListItem(list as integer, idx as integer)

	if _agkValidListIdx(list, idx, __h)
		__vars[list].items.remove(__h.idx)
	endif

endfunction

//-----------------------------------------------------------------
// Find an item in a list, starting from pos, and return the idx.
//
function _agkFindListItem(list as integer, item as string, pos as integer)

	local i as integer
	local idx as integer
	
	idx = -1

	if not _agkIsValidVar(list)
		exitfunction idx
	endif

	if AGK_FROM_BACK
		if pos < 0
			
			pos = __vars[list].items.length + pos
			
			if pos < 0
				pos = 0
			endif
			
		endif
	else
		if pos < 0
			pos = 0
		endif
	endif
	
	for i = pos to __vars[list].items.length

		if __vars[list].items[i].value = item
			
			idx = i
			exit
			
		endif
	
	next

endfunction idx

//-----------------------------------------------------------------
// Find an item in a list, starting from pos, by name, and return the idx.
//
function _agkFindListItemName(list as integer, name as string, pos as integer)

	local i as integer
	local idx as integer
	
	idx = -1

	if not _agkIsValidVar(list)
		exitfunction idx
	endif

	if AGK_FROM_BACK
		if pos < 0
			
			pos = __vars[list].items.length + pos
			
			if pos < 0
				pos = 0
			endif
			
		endif
	endif
	
	for i = pos to __vars[list].items.length

		if __vars[list].items[i].name = name
			
			idx = i
			exit
			
		endif
	
	next

endfunction idx

//-----------------------------------------------------------------
// Get list length.
//
function _agkGetListLen(list as integer)

	local ret as integer

	if not _agkIsValidVar(list)
		exitfunction 0
	endif
	
	ret = __vars[list].items.length + 1
	
endfunction ret

//-----------------------------------------------------------------
// Swap items in the list.
//
function _agkSwapListItems(list as integer, idx1 as integer, idx2 as integer)

	if _agkValidListIdx(list, idx1, __h) 
		
		idx1 = __h.idx
		
		if _agkValidListIdx(list, idx2, __h)
			__vars[list].items.swap(idx1, __h.idx)
		endif
		
	endif
	
endfunction

//-----------------------------------------------------------------
// Sort the list.
//
function _agkSortList(list as integer)

	if not _agkIsValidVar(list)
		exitfunction
	endif

	__vars[list].items.sort()
	
endfunction

//-----------------------------------------------------------------
// Reverse the list.
//
function _agkReversList(list as integer)

	if not _agkIsValidVar(list)
		exitfunction
	endif

	__vars[list].items.reverse()
	
endfunction

//-----------------------------------------------------------------
// Output a list.
// xas = 0 for values, 1 for names and 2 for name:value
//
function _agkJoinList(list as integer, delim as string, xas as integer)

	local i as integer
	local ret as string

	if not _agkIsValidVar(list)
		exitfunction ""
	endif

	for i = 0 to __vars[list].items.length

		if i > 0 then ret = ret + delim
		
		if xas = 1
			ret = ret + __vars[list].items[i].name
		elseif xas = 2
			ret = ret + __vars[list].items[i].name + ":" + __vars[list].items[i].value
		else // xas = 0
			ret = ret + __vars[list].items[i].value
		endif
			
	next

endfunction ret

//-----------------------------------------------------------------
// Split a string into a list.
// xas = 0 for value, 1 for name, 2 for both
//
function _agkSplitToList(list as integer, s as string, delim as string, xas as integer)

	local i as integer
	local count as integer
	local t as string
	local item as Item
	local pos as integer
	local done as integer

	if not _agkIsValidVar(list)
		exitfunction
	endif

	count = countstringtokens2(s, delim)
	
	for i = 1 to count

		t = GetStringToken2(s, delim, i)
		
		if xas = 0 // Values.
			
			item.value = t
			
		elseif xas = 1 // Names.
			
			item.name = t
			
		elseif xas = 2 // Name:value.
			
			pos = 0
			
			repeat
				
				pos = findstring(t, ":", true, pos)
				done = true
				
				if pos > 0
					if pos > 1 // Only check if escaped : if there is a char avaiable before.
						if mid(t, pos - 1, 1) = "\" // escaped, try again.
							
							inc pos
							done = false
							
						endif
					endif
				endif
				
			until done
			
			if pos > 0
				
				item.name = mid(t, 1, pos - 1)
				item.value = mid(t, pos + 1, -1)
				
			endif
			
		endif
		
		__vars[list].items.insert(item)
		
	next

endfunction

//-----------------------------------------------------------------
// Check if the list idx is valid.
//
function _agkValidListIdx(list as integer, idx as integer, h ref as Helper)

	local ret as integer
	
	if AGK_FROM_BACK
		if idx < 0		
			idx = __vars[list].items.length + 1 + idx
		endif
	endif
	
	if _agkIsValidVar(list)
		
		ret = true
		h.idx = idx // Set return idx.
		
	else
		
		ret = false

	endif
	
endfunction ret

//-----------------------------------------------------------------
// clear list.
//
function _agkClearList(list as integer)

	if not _agkIsValidVar(list)
		exitfunction
	endif

	__vars[list].items.length = -1
	
endfunction

//-----------------------------------------------------------------
// append list.
//
function _agkAppendList(list as integer, from as integer)

	local i as integer
	local item as Item
	
	if not _agkIsValidVar(list) or not _agkIsValidVar(from)
		exitfunction
	endif

	for i = 0 to __vars[from].items.length

		item.name = __vars[from].items[i].name
		item.value = __vars[from].items[i].value
		__vars[list].items.insert(item)
			
	next
	
endfunction

//-----------------------------------------------------------------
// Get the color value for a sprite.
//
function _agkGetSpriteColor(idx as integer)

	local a as integer
	local r as integer
	local g as integer
	local b as integer
	local col as integer
	
	a = GetSpriteColorAlpha(__sprs[idx].spr)
	r = GetSpriteColorRed(__sprs[idx].spr)
	g = GetSpriteColorGreen(__sprs[idx].spr)
	b = GetSpriteColorBlue(__sprs[idx].spr)
	col = makecolor(r, g, b, a)
	
endfunction col

//-----------------------------------------------------------------
// Convert a bool to a string.
//
function _agkBoolToStr(b as integer)

	if b
		exitfunction "true"
	else
		exitfunction "false"
	endif 

endfunction ""

//-----------------------------------------------------
// Create a var placeholder.
// Force varIdx as idx by ensuring it fits in the list.
//
function _agkMakeVar(varIdx as integer, typ as integer)

	local i as integer
	local idx as integer = -1
	local var as Var

	if varIdx > 0
		
		// See if its in the free list first.
		for i = 0 to __freeVars.length
			if __freeVars[i] = varIdx
				
				idx = __freeVars[i]
				__freeVars.remove(i)
				exit
				
			endif
		next
		
		if idx = -1 // Still not found, nowe force it in the main list.
						
			// Create a gap with freevars.
			while __vars.length < varIdx - 1
				
				__vars.insert(var)
				_agkRemoveVar(__vars.length)
				
			endwhile
	
			// Now add the one we want.
			__vars.insert(var)
			idx = __vars.length
		
		endif
		
	else // varIdx not set, take the next one avail.
		
		if __freeVars.length >= 0
			
			idx = __freeVars[0]
			__freeVars.remove(0)
	
		else
			
			__vars.insert(var)
			idx = __vars.length
	
		endif
		
	endif
	
	_agkInitVar(idx)
	__vars[idx].typ = typ
	__vars[idx].deleted = false

endfunction idx

//-----------------------------------------------------
// Cleanup a var.
//
function _agkInitVar(idx as integer)
	
	__vars[idx].typ = 0
	
	__vars[idx].cfg.x = co.bs / 4
	__vars[idx].cfg.y = co.bs / 4
	__vars[idx].cfg.w = 0
	__vars[idx].cfg.h = 0
	__vars[idx].cfg.name = ""
	__vars[idx].cfg.bgCol = co.brown[7]
	__vars[idx].cfg.bgVis = true
	__vars[idx].cfg.titleVis = true
	__vars[idx].cfg.titleCol = co.white
	__vars[idx].cfg.titleDir = DIR_N
	__vars[idx].cfg.titleFont = 0
	__vars[idx].cfg.titleFontSize = 40
	__vars[idx].cfg.titleAlign = 1 // Centre
	__vars[idx].cfg.boxCol = co.white
	__vars[idx].cfg.boxVis = true
	__vars[idx].cfg.textCol = co.black
	__vars[idx].cfg.textFont = 0
	__vars[idx].cfg.textFontSize = 40
	if __vars[idx].typ = 1 // List
		__vars[idx].cfg.textAlign = 1 // top-Centre
	else
		__vars[idx].cfg.textAlign = 4 // Centre
	endif
	__vars[idx].cfg.textSecret = false
	
	__vars[idx].text.vis = true
	
endfunction

//-----------------------------------------------------
// Create all elements of a text.
//
function _agkCreateVar(idx as integer)

	local ww as float
	local hh as float
	local w1 as float
	local h1 as float
	local w2 as float
	local h2 as float
	local w as float
	local h as float
	local gap as float
	local gap2 as float
	local created as integer = false
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif

	gap = co.bs / 8
	gap2 = gap / 2

	if __vars[idx].cfg.titleVis
		
		if not __vars[idx].text.title
			__vars[idx].text.title = createtext(__vars[idx].cfg.name)
		endif

		cosettextfont(__vars[idx].text.title, __vars[idx].cfg.titleFont)
		//SetTextSize(__vars[idx].cfg.title, co.fontSizes[__vars[idx].cfg.titleFontSize])
		SetTextSize(__vars[idx].text.title, __vars[idx].cfg.titleFontSize)
		
		w1 = gap2 + GetTextTotalWidth(__vars[idx].text.title) + gap2
		h1 = GetTextTotalHeight(__vars[idx].text.title)

	else

		if __vars[idx].text.title
			
			deletetext(__vars[idx].text.title)
			__vars[idx].text.title = 0

		endif

		w1 = 0
		h1 = 0

	endif
	
	if not __vars[idx].text.text
			
		__vars[idx].text.text = createtext("0")
		SetTextString(__vars[idx].text.text, " ")	
			
	endif

	cosettextfont(__vars[idx].text.text, __vars[idx].cfg.textFont)
	//SetTextSize(__vars[idx].cfg.text, co.fontSizes[__vars[idx].cfg.textFontSize])
	SetTextSize(__vars[idx].text.text, __vars[idx].cfg.textFontSize)
	
	// Account for box size.
	w2 = gap * 2 + GetTextTotalWidth(__vars[idx].text.text) + gap * 2
	h2 = GetTextTotalHeight(__vars[idx].text.text)

	//SetTextString(__vars[idx].cfg.text, " ")
	
	if __vars[idx].cfg.titleDir = DIR_N or __vars[idx].cfg.titleDir = DIR_S
			
		if w1 > w2
			ww = w1
		else
			ww = w2
		endif

		w2 = ww // Ensure box is right size.
		
		w = gap + ww + gap

		__vars[idx].cfg.mw = w

		if __vars[idx].cfg.w > 0

			if __vars[idx].cfg.w > w
				
				w = __vars[idx].cfg.w
				w2 = w - gap - gap
				
			endif
			
		endif
		
		if __vars[idx].cfg.titleVis
			h = gap2 + h1 + gap2 + h2 + gap
		else 
			h = gap + h2 + gap
		endif

		__vars[idx].cfg.mh = h

		if __vars[idx].cfg.h > 0

			if __vars[idx].cfg.h > h

				h = __vars[idx].cfg.h

				if __vars[idx].cfg.titleVis
					h2 = h - gap2 - h1 - gap2 - gap
				else 
					h2 = h - gap - gap
				endif

			endif

		endif
		
	elseif __vars[idx].cfg.titleDir = DIR_W or __vars[idx].cfg.titleDir = DIR_E

		if h1 > h2
			hh = h1
		else
			hh = h2
		endif
			
		if __vars[idx].cfg.titleVis
			w = gap + w1 + gap + w2 + gap
		else
			w = gap + w2 + gap
		endif

		__vars[idx].cfg.mw = w

		if __vars[idx].cfg.w > 0

			if __vars[idx].cfg.w > w
				
				w = __vars[idx].cfg.w
				w2 = w - gap - w1 - gap - gap
				
			endif

		endif
		
		h = gap + hh + gap

		__vars[idx].cfg.mh = h

		if __vars[idx].cfg.h > 0

			if __vars[idx].cfg.h > h

				h = __vars[idx].cfg.h
				h2 = h - gap - gap
				
			endif

		endif
		
	endif
	
	if not __vars[idx].text.bg
		__vars[idx].text.bg = cocreatebox(1, 1)
	endif

	SetSpriteScale(__vars[idx].text.bg, w, h)

	if not __vars[idx].text.box
		__vars[idx].text.box = cocreatebox(1, 1)
	endif

	SetSpriteScale(__vars[idx].text.box, w2, h2)

	_agkUpdateVar(idx)
	
endfunction

//-----------------------------------------------------
// Remove a text from the active list.
// Clean up the text if necessary.
//
function _agkRemoveVar(idx as integer)
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif
		
	if not __vars[idx].deleted

		_agkDeleteVar(idx)	
		_agkInitVar(idx)
		__vars[idx].deleted = True
		__freeVars.insert(idx)

	endif

endfunction

//-----------------------------------------------------
// Delete all elements of a text.
//
function _agkDeleteVar(idx as integer)
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif
		
	if __vars[idx].text.bg
		
		deletesprite(__vars[idx].text.bg)
		__vars[idx].text.bg = 0
		
	endif

	if __vars[idx].text.title
		
		deletetext(__vars[idx].text.title)
		__vars[idx].text.title = 0
		
	endif

	if __vars[idx].text.box
		
		deletesprite(__vars[idx].text.box)
		__vars[idx].text.box = 0
		
	endif

	if __vars[idx].text.text
		
		deletetext(__vars[idx].text.text)
		__vars[idx].text.text = 0
		
	endif

	if __vars[idx].text.edit
		
		deleteeditbox(__vars[idx].text.edit)
		__vars[idx].text.edit = 0
		
	endif
	
endfunction

//-----------------------------------------------------
// Draw a list var.
//
function _agkDrawVar(idx as integer)
		
	local value as string
		
	if not _agkIsValidVar(idx)
		exitfunction
	endif
			
	if __vars[idx].text.vis
					
		value = __vars[idx].value
		
		if __vars[idx].cfg.textSecret
			value = coRepeatString("*", len(__vars[idx].value))
		endif
		
		if __vars[idx].typ = 1 // List
			value = _agkJoinList(idx, _L, 0)
		endif
		
		//value = coTrimFloatStr(value)
	
		if __vars[idx].text.text
			SetTextString(__vars[idx].text.text, value)
		endif
		
		_agkSetVarPos(idx)
		
	endif
	
endfunction

//-----------------------------------------------------
// Switch the var to edit mode.
//
function _agkEditVar(idx as integer)

	local depth as integer
	local value as string
	local i as integer
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].text.edit = CreateEditBox()
	SetEditBoxSize(__vars[idx].text.edit, GetSpriteWidth(__vars[idx].text.box), GetSpriteHeight(__vars[idx].text.box))
	SetEditBoxPosition(__vars[idx].text.edit, GetSpritex(__vars[idx].text.box), GetSpritey(__vars[idx].text.box))
	SetEditBoxBorderSize(__vars[idx].text.edit, 0)
	//SetEditBoxScissor(__vars[idx].text.edit, GetSpritex(__vars[idx].text.box), GetSpritey(__vars[idx].text.box), GetSpriteWidth(__vars[idx].text.box), GetSpriteHeight(__vars[idx].text.box))
	depth = GetTextDepth(__vars[idx].text.text)
	SetEditBoxDepth(__vars[idx].text.edit, depth - 1)

	if __vars[idx].typ = 0 // Value
		
		value = GetTextString(__vars[idx].text.text)
		
	elseif __vars[idx].typ = 1 // List
		
		value = _agkJoinList(idx, _L, __vars[idx].cfg.xas)
		SetEditBoxMultiLine(__vars[idx].text.edit, true)
		
	endif
	
	SetEditBoxText(__vars[idx].text.edit, value)
	SetEditBoxCursorPosition(__vars[idx].text.edit, len(value))
	
	SetEditBoxCursorColor(__vars[idx].text.edit, 3, 169, 244)
	SetEditBoxCursorWidth(__vars[idx].text.edit, 4)
	SetEditBoxTextColor(__vars[idx].text.edit, GetColorRed(__vars[idx].cfg.textCol), GetColorGreen(__vars[idx].cfg.textCol), GetColorBlue(__vars[idx].cfg.textCol))
	coSetEditBoxFont(__vars[idx].text.edit, __vars[idx].cfg.textFont)
	SetEditBoxTextSize(__vars[idx].text.edit, __vars[idx].cfg.textFontSize)
	SetEditBoxBackgroundColor(__vars[idx].text.edit, GetColorRed(__vars[idx].cfg.boxCol), GetColorGreen(__vars[idx].cfg.boxCol), GetColorBlue(__vars[idx].cfg.boxCol), 255)
	if __vars[idx].cfg.textSecret
		SetEditBoxPasswordMode(__vars[idx].text.edit, true)
	endif
	setEditBoxVisible(__vars[idx].text.edit, true)
	SetEditBoxFocus(__vars[idx].text.edit, true)

	__editVarIdx = idx
	
endfunction

//-----------------------------------------------------------------
// Check if any vars are in edit, and lost focus.
//
function _agkCheckEditVar(idx as integer)

	local i as integer
	local count as integer
	local s as string
	local item as Item
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif
	
	
	if GetEditBoxChanged(__vars[idx].text.edit)
		
		s = GetEditBoxText(__vars[idx].text.edit)
		
		if __vars[idx].text.edit
		
			deleteeditbox(__vars[idx].text.edit)
			__vars[idx].text.edit = 0
			
		endif

		if __vars[idx].typ = 0 // Value

			__vars[idx].value = s
			
		elseif __vars[idx].typ = 1 // List
			
			__vars[idx].items.length = -1
			_agkSplitToList(idx, s, _L, __vars[idx].cfg.xas)
				
		endif
		
		_agkDrawVar(idx)
		__editVarIdx = 0
		
	endif

endfunction

//-----------------------------------------------------
// Create a local var placeholder.
//
function _agkMakeTempVar(sprIdx as integer, name as string, typ as integer)

	local idx as integer = -1
	local tv as TmpVar
	local i as integer
	
	if name <> ""
		
		for i = 0 to __tmpVars.length
			if __tmpVars[i].sprIdx = sprIdx and __tmpVars[i].name = name and __tmpVars[i].typ = typ
				
				idx = i
				exit
				
			endif
		next
		
		if idx = -1
			
			tv.name = name
			tv.typ = typ
			tv.sprIdx = sprIdx
			tv.varIdx = _agkMakeVar(0, typ)
			__tmpVars.insert(tv)
			idx = __tmpVars.length
			
		endif	
		
	endif
		
endfunction idx

//-----------------------------------------------------
// Find a var by varIdx.
//
function _agkFindTempVar(varIdx as integer)

	local i as integer
	
	if not _agkIsValidVar(varIdx)
		exitfunction -1
	endif

	for i = 0 to __tmpVars.length
		if __tmpVars[i].varIdx = varIdx	
			exitfunction i
		endif
	next						
		
endfunction -1

//-----------------------------------------------------
// Create a local var placeholder.
//
function _agkGetTempVar(sprIdx as integer, name as string, typ as integer)

	local idx as integer = 0
	local i as integer
	
	if name <> ""		
		for i = 0 to __tmpVars.length
			if __tmpVars[i].sprIdx = sprIdx and __tmpVars[i].name = name and __tmpVars[i].typ = typ			
				exitfunction __tmpVars[i].varIdx
			endif
		next						
	endif
		
endfunction 0

//-----------------------------------------------------
// Clear all temp vars in this function.
//
function _agkClearTempVars(sprIdx as integer)
	
	local i as integer
	
	while i <= __tmpVars.length
		if __tmpVars[i].sprIdx = sprIdx and __tmpVars[i].sentMsg = "" // Can't clear msg vars.
			__tmpVars.remove(i)
		else
			inc i
		endif
	endwhile
		
endfunction

//-----------------------------------------------------
// Clear temp var for this msg.
//
function _agkClearMsgTempVars(msg as string)
	
	local i as integer
	
	while i <= __tmpVars.length
		if __tmpVars[i].sentMsg = msg
			__tmpVars.remove(i)
		else
			inc i
		endif
	endwhile
		
endfunction

//-----------------------------------------------------
// Create an instant list.
//
function _agkMakeQuickList1(sprIdx as integer, item1 as string)

	local idx as integer
	local item as Item
	
	idx = _agkMakeTempVar(sprIdx, coGetUniqueName(), 1)
	
	item.name = ""
	item.value = item1
	__vars[__tmpVars[idx].varIdx].items.insert(item)
	
endfunction __tmpVars[idx].varIdx

//-----------------------------------------------------
// Create an instant list.
//
function _agkMakeQuickList2(sprIdx as integer, item1 as string, item2 as string)

	local idx as integer
	local item as Item
	
	idx = _agkMakeTempVar(sprIdx, coGetUniqueName(), 1)
	
	item.name = ""
	item.value = item1
	__vars[__tmpVars[idx].varIdx].items.insert(item)

	item.name = ""
	item.value = item2
	__vars[__tmpVars[idx].varIdx].items.insert(item)
	
endfunction __tmpVars[idx].varIdx

//-----------------------------------------------------
// Create an instant list.
//
function _agkMakeQuickList3(sprIdx as integer, item1 as string, item2 as string, item3 as string)

	local idx as integer
	local item as Item
	
	idx = _agkMakeTempVar(sprIdx, coGetUniqueName(), 1)
	
	item.name = ""
	item.value = item1
	__vars[__tmpVars[idx].varIdx].items.insert(item)

	item.name = ""
	item.value = item2
	__vars[__tmpVars[idx].varIdx].items.insert(item)

	item.name = ""
	item.value = item3
	__vars[__tmpVars[idx].varIdx].items.insert(item)
	
endfunction __tmpVars[idx].varIdx

//-----------------------------------------------------
// Create an instant list.
//
function _agkMakeQuickList4(sprIdx as integer, item1 as string, item2 as string, item3 as string, item4 as string)

	local idx as integer
	local item as Item
	
	idx = _agkMakeTempVar(sprIdx, coGetUniqueName(), 1)
	
	item.name = ""
	item.value = item1
	__vars[__tmpVars[idx].varIdx].items.insert(item)

	item.name = ""
	item.value = item2
	__vars[__tmpVars[idx].varIdx].items.insert(item)

	item.name = ""
	item.value = item3
	__vars[__tmpVars[idx].varIdx].items.insert(item)

	item.name = ""
	item.value = item4
	__vars[__tmpVars[idx].varIdx].items.insert(item)
	
endfunction __tmpVars[idx].varIdx

//-----------------------------------------------------------------
// Check if a var was pressed.
//
function _agkGetVarPressed(idx as integer)

	if not _agkIsValidVar(idx)
		exitfunction false
	endif
	
	if __vars[idx].text.box
		if in.ptrPressed
			if GetSpriteHitTest(__vars[idx].text.box, in.ptrX, in.ptrY)
				exitfunction true
			endif
		endif
	endif

endfunction false

//-----------------------------------------------------------------
// Check if a var was released.
//
function _agkGetVarReleased(idx as integer)

	if not _agkIsValidVar(idx)
		exitfunction false
	endif
	
	if __vars[idx].text.box
		if in.ptrReleased
			if GetSpriteHitTest(__vars[idx].text.box, in.ptrX, in.ptrY)
				exitfunction true
			endif
		endif
	endif

endfunction false

//-----------------------------------------------------
// Make a var view visible.
//
function _agkSetVarVisible(idx as integer, vis as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	if __vars[idx].text.bg		
		SetSpriteVisible(__vars[idx].text.bg, vis)		
	endif

	if __vars[idx].text.title
		SetTextVisible(__vars[idx].text.title, vis)
	endif

	if __vars[idx].text.box		
		SetSpriteVisible(__vars[idx].text.box, vis)		
	endif

	if __vars[idx].text.text
		SetTextVisible(__vars[idx].text.text, vis)
	endif
	
endfunction

//-----------------------------------------------------
// Position a var view.
//
function _agkSetVarDepth(idx as integer, depth as integer)

	local gap as float
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif

	if __vars[idx].text.bg
		SetSpriteDepth(__vars[idx].text.bg, depth)
	endif

	if __vars[idx].text.box
		SetSpriteDepth(__vars[idx].text.box, depth - 1)
	endif

	if __vars[idx].text.title
		SetTextDepth(__vars[idx].text.title, depth - 2)
	endif

	if __vars[idx].text.text
		SetTextDepth(__vars[idx].text.text, depth - 2)
	endif

endfunction

//-----------------------------------------------------
// Update settings like colors.
//
function _agkUpdateVar(idx as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif
	
	if __vars[idx].text.bg		
		coSetSpriteColor(__vars[idx].text.bg, __vars[idx].cfg.bgCol)
	endif
	
	if __vars[idx].text.title
		coSetTextColor(__vars[idx].text.title, __vars[idx].cfg.titleCol)
	endif

	if __vars[idx].text.text
		coSetTextColor(__vars[idx].text.text, __vars[idx].cfg.textCol)
	endif

	if __vars[idx].text.box
		coSetSpriteColor(__vars[idx].text.box, __vars[idx].cfg.boxCol)
	endif
	
	setspritevisible(__vars[idx].text.bg, __vars[idx].cfg.bgVis)
	setspritevisible(__vars[idx].text.box, __vars[idx].cfg.boxVis)


endfunction

//-----------------------------------------------------
// Position a text
//
function _agkSetVarPos(idx as integer)

	local gap as float
	local gap2 as float
	local x as float
	local y as float
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif

	x = __vars[idx].cfg.x
	y = __vars[idx].cfg.y
	
	if __vars[idx].text.bg
		
		SetSpritePosition(__vars[idx].text.bg, x, y)
	
		gap = co.bs / 8
		gap2 = gap / 2
		
		if __vars[idx].cfg.titleDir = DIR_N
	
			if __vars[idx].text.title
								
				SetTextAlignment(__vars[idx].text.title, __vars[idx].cfg.titleAlign)
		
				if __vars[idx].cfg.titleAlign = 0
					SetTextPosition(__vars[idx].text.title, x + gap, y + gap2)
				elseif __vars[idx].cfg.titleAlign = 1
					SetTextPosition(__vars[idx].text.title, x + GetSpriteWidth(__vars[idx].text.bg) / 2, y + gap2)
				elseif __vars[idx].cfg.titleAlign = 2
					SetTextPosition(__vars[idx].text.title, x + GetSpriteWidth(__vars[idx].text.bg) - gap, y + gap2)
				endif
				
			endif
			
			if __vars[idx].text.box
				SetspritePosition(__vars[idx].text.box, x + gap, y + GetSpriteHeight(__vars[idx].text.bg) - gap - GetspriteHeight(__vars[idx].text.box))
			endif
	
		elseif __vars[idx].cfg.titleDir = DIR_S
			
			if __vars[idx].text.title
				
				SetTextAlignment(__vars[idx].text.title, __vars[idx].cfg.titleAlign)
		
				if __vars[idx].cfg.titleAlign = 0
					SetTextPosition(__vars[idx].text.title, x + gap, y + GetSpriteHeight(__vars[idx].text.bg) - gap2 - GetTextTotalHeight(__vars[idx].text.title))
				elseif __vars[idx].cfg.titleAlign = 1
					SetTextPosition(__vars[idx].text.title, x + GetSpriteWidth(__vars[idx].text.bg) / 2, y + GetSpriteHeight(__vars[idx].text.bg) - gap2 - GetTextTotalHeight(__vars[idx].text.title))
				elseif __vars[idx].cfg.titleAlign = 2
					SetTextPosition(__vars[idx].text.title, x + GetSpriteWidth(__vars[idx].text.bg) - gap, y + GetSpriteHeight(__vars[idx].text.bg) - gap2 - GetTextTotalHeight(__vars[idx].text.title))
				endif
			
			endif
			
			if __vars[idx].text.box
				SetspritePosition(__vars[idx].text.box, x + gap, y + gap)
			endif
	
		elseif __vars[idx].cfg.titleDir = DIR_W	
	
			if __vars[idx].text.title
				
				SetTextAlignment(__vars[idx].text.title, 0) // left.
				SetTextPosition(__vars[idx].text.title, x + gap, y + GetSpriteHeight(__vars[idx].text.bg) / 2 - GetTextTotalHeight(__vars[idx].text.title) / 2)
	
			endif
			
			if __vars[idx].text.box
				SetspritePosition(__vars[idx].text.box, x + GetSpriteWidth(__vars[idx].text.bg) - gap - GetSpriteWidth(__vars[idx].text.box), y + GetSpriteHeight(__vars[idx].text.bg) / 2 - GetSpriteHeight(__vars[idx].text.box) / 2)
			endif
			
		elseif __vars[idx].cfg.titleDir = DIR_E
	
			if __vars[idx].text.title
				
				SetTextAlignment(__vars[idx].text.title, 2) // right.
				SetTextPosition(__vars[idx].text.title, x + GetSpriteWidth(__vars[idx].text.bg) - gap, y + GetSpriteHeight(__vars[idx].text.bg) / 2 - GetTextTotalHeight(__vars[idx].text.title) / 2)
			
			endif
			
			if __vars[idx].text.box
				SetSpritePosition(__vars[idx].text.box, x + gap, y + GetSpriteHeight(__vars[idx].text.bg) / 2 - GetSpriteHeight(__vars[idx].text.box) / 2)
			endif
			
		endif
	
		if __vars[idx].text.text
			
			SetTextScissor(__vars[idx].text.text, getspritex(__vars[idx].text.box), getspritey(__vars[idx].text.box), getspritex(__vars[idx].text.box) + GetSpriteWidth(__vars[idx].text.box) - 1, getspritey(__vars[idx].text.box) + GetSpriteHeight(__vars[idx].text.box) - 1)

			if __vars[idx].cfg.textAlign = 0 or __vars[idx].cfg.textAlign = 3 or __vars[idx].cfg.textAlign = 6		
				SetTextAlignment(__vars[idx].text.text, 0) // Left.
			elseif __vars[idx].cfg.textAlign = 2 or __vars[idx].cfg.textAlign = 5 or __vars[idx].cfg.textAlign = 8		
				SetTextAlignment(__vars[idx].text.text, 2) // Right;
			else // centre.
				SetTextAlignment(__vars[idx].text.text, 1)
			endif
		
			if __vars[idx].cfg.textAlign = 0	
				SetTextPosition(__vars[idx].text.text, GetSpriteX(__vars[idx].text.box) + gap2, GetSpriteY(__vars[idx].text.box) + gap2)
			elseif __vars[idx].cfg.textAlign = 1	
				SetTextPosition(__vars[idx].text.text, GetSpriteXByOffset(__vars[idx].text.box), GetSpriteY(__vars[idx].text.box) + gap2)
			elseif __vars[idx].cfg.textAlign = 2
				SetTextPosition(__vars[idx].text.text, GetSpriteX(__vars[idx].text.box) + GetSpriteWidth(__vars[idx].text.box) - gap2, GetSpriteY(__vars[idx].text.box) + gap2)
			elseif __vars[idx].cfg.textAlign = 3	
				SetTextPosition(__vars[idx].text.text, GetSpriteX(__vars[idx].text.box) + gap2, GetSpriteYByOffset(__vars[idx].text.box) - GetTextTotalHeight(__vars[idx].text.text) / 2)
			elseif __vars[idx].cfg.textAlign = 4	
				SetTextPosition(__vars[idx].text.text, GetSpriteXByOffset(__vars[idx].text.box), GetSpriteYByOffset(__vars[idx].text.box) - GetTextTotalHeight(__vars[idx].text.text) / 2)
			elseif __vars[idx].cfg.textAlign = 5
				SetTextPosition(__vars[idx].text.text, GetSpriteX(__vars[idx].text.box) + GetSpriteWidth(__vars[idx].text.box) - gap2, GetSpriteYByOffset(__vars[idx].text.box) - GetTextTotalHeight(__vars[idx].text.text) / 2)
			elseif __vars[idx].cfg.textAlign = 6	
				SetTextPosition(__vars[idx].text.text, GetSpriteX(__vars[idx].text.box) + gap2, GetSpriteY(__vars[idx].text.box) + GetSpriteHeight(__vars[idx].text.box) - gap2 - GetTextTotalHeight(__vars[idx].text.text))
			elseif __vars[idx].cfg.textAlign = 7	
				SetTextPosition(__vars[idx].text.text, GetSpriteXByOffset(__vars[idx].text.box), GetSpriteY(__vars[idx].text.box) + GetSpriteHeight(__vars[idx].text.box) - gap2 - GetTextTotalHeight(__vars[idx].text.text))
			elseif __vars[idx].cfg.textAlign = 8
				SetTextPosition(__vars[idx].text.text, GetSpriteX(__vars[idx].text.box) + GetSpriteWidth(__vars[idx].text.box) - gap2, GetSpriteY(__vars[idx].text.box) + GetSpriteHeight(__vars[idx].text.box) - gap2 - GetTextTotalHeight(__vars[idx].text.text))
			endif
			
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarBgColor(idx as integer, col as integer)
	
	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.bgCol = col
	_agkUpdateVar(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarTitleColor(idx as integer, col as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.titleCol = col
	_agkUpdateVar(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarTitleFontSize(idx as integer, size as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.titleFontSize = size
	_agkCreateVar(idx)
	_agkSetVarPos(idx)

endfunction

//-----------------------------------------------------
//
function _agkSetVarTitleDir(idx as integer, dir as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.titleDir = dir
	_agkCreateVar(idx)
	_agkSetVarPos(idx)

endfunction

//-----------------------------------------------------
//
function _agkSetVarTitleAlign(idx as integer, align as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.titleAlign = align
	_agkCreateVar(idx)
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarTitleFont(idx as integer, font as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.titleFont = font
	_agkCreateVar(idx)
	_agkSetVarPos(idx)

endfunction

//-----------------------------------------------------
//
function _agkSetVarTitleVis(idx as integer, vis as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.titleVis = vis
	_agkCreateVar(idx)
	_agkSetVarPos(idx)

endfunction

//-----------------------------------------------------
//
function _agkSetVarBgVis(idx as integer, vis as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.bgVis = vis
	_agkCreateVar(idx)
	_agkSetVarPos(idx)

endfunction

//-----------------------------------------------------
//
function _agkSetVarBoxVis(idx as integer, vis as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.boxVis = vis
	_agkCreateVar(idx)
	_agkSetVarPos(idx)

endfunction

//-----------------------------------------------------
//
function _agkSetVarTextColor(idx as integer, col as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.textCol = col
	_agkUpdateVar(idx)
	//maCreateVarView(ma.vars[varIdx].rv)
	//maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)

endfunction

//-----------------------------------------------------
//
// xas = 0 for value, 1 for name, 2 for both
//
function _agkShowVar(idx as integer, xas as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	if not __vars[idx].text.vis
		
		__vars[idx].text.vis = true
		__vars[idx].cfg.xas = xas
		_agkCreateVar(idx)
		_agkSetVarPos(idx)
		_agkDrawVar(idx)
		
	endif
	
endfunction

//-----------------------------------------------------
//
function _agkHideVar(idx as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	if __vars[idx].text.vis
		
		__vars[idx].text.vis = false
		_agkDeleteVar(idx)
		
	endif
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarTextFont(idx as integer, font as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.textFont = font
	_agkCreateVar(idx)
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarTextFontSize(idx as integer, size as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.textFontSize = size
	_agkCreateVar(idx)
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarTextSecret(idx as integer, secret as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.textSecret = secret
	_agkDrawVar(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarTextAlign(idx as integer, align as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.textAlign = align
	_agkCreateVar(idx)
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarBoxColor(idx as integer, col as integer)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.boxCol = col
	_agkUpdateVar(idx)
	//maCreateVarView(ma.vars[varIdx].rv)
	//maSetVarViewPos(ma.vars[varIdx].rv, ma.vars[varIdx].rv.x, ma.vars[varIdx].rv.y)
	
endfunction


//-----------------------------------------------------
//
function _agkSetVarX(idx as integer, x as float)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.x = x
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarY(idx as integer, y as float)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.y = y
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarXY(idx as integer, x as float, y as float)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.x = x
	__vars[idx].cfg.y = y
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarW(idx as integer, w as float)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.w = w
	_agkCreateVar(idx)
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarH(idx as integer, h as float)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.h = h
	_agkCreateVar(idx)
	_agkSetVarPos(idx)
	
endfunction

//-----------------------------------------------------
//
function _agkSetVarWH(idx as integer, w as float, h as float)

	if not _agkIsValidVar(idx)
		exitfunction
	endif

	__vars[idx].cfg.w = w
	__vars[idx].cfg.h = h
	_agkCreateVar(idx)
	_agkSetVarPos(idx)
	
endfunction

//
// End setup.
//



