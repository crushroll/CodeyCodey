#option_explicit

#include "common.agc"
#include "input.agc"
#include "setup.agc"

function initVars()
	__h.idx = _agkMakeVar(27, 0)
	__vars[__h.idx].name = "name"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(28, 0)
	__vars[__h.idx].name = "timer"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(29, 0)
	__vars[__h.idx].name = "lx"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(30, 0)
	__vars[__h.idx].name = "rx"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(31, 0)
	__vars[__h.idx].name = "yy"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(32, 0)
	__vars[__h.idx].name = "xx"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(33, 0)
	__vars[__h.idx].name = "x"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 64.000000
	__vars[__h.idx].cfg.y = 0.000000
	__vars[__h.idx].cfg.w = 255.000000
	__vars[__h.idx].cfg.h = 113.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(34, 0)
	__vars[__h.idx].name = "y"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 0.000000
	__vars[__h.idx].cfg.y = 127.000000
	__vars[__h.idx].cfg.w = 255.000000
	__vars[__h.idx].cfg.h = 113.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(35, 1)
	__vars[__h.idx].name = "list"
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 1
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(36, 0)
	__vars[__h.idx].name = "piece"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
	__h.idx = _agkMakeVar(37, 0)
	__vars[__h.idx].name = "state"
	__vars[__h.idx].value = ""
	__vars[__h.idx].cfg.x = 32.000000
	__vars[__h.idx].cfg.y = 32.000000
	__vars[__h.idx].cfg.w = 0.000000
	__vars[__h.idx].cfg.h = 0.000000
	__vars[__h.idx].cfg.name = ""
	__vars[__h.idx].cfg.bgCol = -13156259
	__vars[__h.idx].cfg.titleVis = 1
	__vars[__h.idx].cfg.titleCol = -1
	__vars[__h.idx].cfg.titleDir = 1
	__vars[__h.idx].cfg.titleFont = 0
	__vars[__h.idx].cfg.titleFontSize = 40
	__vars[__h.idx].cfg.titleAlign = 1
	__vars[__h.idx].cfg.boxCol = -1
	__vars[__h.idx].cfg.textCol = -16777216
	__vars[__h.idx].cfg.textFont = 0
	__vars[__h.idx].cfg.textFontSize = 40
	__vars[__h.idx].cfg.textAlign = 4
	__vars[__h.idx].cfg.textSecret = 0
	__vars[__h.idx].text.vis = 0
endfunction




function onstart270(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(27)
	_h.img = LoadImage("gfx/I62.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	_h.img = LoadImage("gfx/I63.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	_h.img = LoadImage("gfx/I64.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	_h.img = LoadImage("gfx/I65.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "tet-1"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 357.000000,357.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstart271(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritedepth(__sprs[idx].spr,100)
	setspritevisible(__sprs[idx].spr,false)
	_agkClearTempVars(idx)
endfunction

function onupdate272(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	if _agkGetClone(idx) = "active"
	aaaa(idx,0)
	else
	endif
	_agkClearTempVars(idx)
endfunction

function onmessage273(idx as integer,m ref as Msg)
	local _h as Helper
	_h.entryIdx = idx
	local list as integer
	if not _agkCanAcceptMsg(idx, m) then exitfunction
	list = m.varIdx
	if m.asMe
	idx = m.sprIdx
	_h.entryIdx = idx
	endif
	if not _agkIsClone(idx)
	setspritevisible(__sprs[idx].spr,true)
	if _agkGetListItem(list,0) = "1"
	_agkSetVar(33,str(getspritexbyoffset(__sprs[idx].spr)))
	_agkSetVar(34,str(getspriteybyoffset(__sprs[idx].spr)))
	_agkSetVar(32,__vars[33].value)
	_agkSetVar(31,__vars[34].value)
	_agkSetVar(29,str((valfloat(__vars[33].value) - 3)))
	_agkSetVar(30,str((valfloat(__vars[33].value) + 4)))
	_agkSetVar(27,"active")
	_agkCloneSprite(idx,__vars[27].value)
	setspritevisible(__sprs[idx].spr,false)
	else
	endif
	else
	endif
	_agkClearTempVars(idx)
endfunction

function aaaa(idx as integer,list as integer)
	local _h as Helper
	_h.entryIdx = idx
	if (timer() - valfloat(__vars[28].value)) >= valfloat("1")
	aaab(idx,0)
	_agkSetVar(28,str(timer()))
	else
	endif
	_agkClearTempVars(idx)
endfunction

function onmessage274(idx as integer,m ref as Msg)
	local _h as Helper
	_h.entryIdx = idx
	local list as integer
	if not _agkCanAcceptMsg(idx, m) then exitfunction
	list = m.varIdx
	if m.asMe
	idx = m.sprIdx
	_h.entryIdx = idx
	endif
	if _agkGetClone(idx) = "active"
	aaab(idx,0)
	else
	endif
	_agkClearTempVars(idx)
endfunction

function aaab(idx as integer,list as integer)
	local _h as Helper
	_h.entryIdx = idx
	_agkIncVar(31)
	aaac(idx,0)
	if _agkGetSpriteNameCollision(idx,"bottom")
	_agkDecVar(31)
	aaac(idx,0)
	_agkChangeCloneName(idx,"")
	else
	endif
	_agkClearTempVars(idx)
endfunction

function onmessage275(idx as integer,m ref as Msg)
	local _h as Helper
	_h.entryIdx = idx
	local list as integer
	if not _agkCanAcceptMsg(idx, m) then exitfunction
	list = m.varIdx
	if m.asMe
	idx = m.sprIdx
	_h.entryIdx = idx
	endif
	if _agkGetClone(idx) = "active"
	_agkDecVar(32)
	aaac(idx,0)
	if _agkGetSpriteNameCollision(idx,"left")
	_agkIncVar(32)
	aaac(idx,0)
	else
	endif
	else
	endif
	_agkClearTempVars(idx)
endfunction

function onmessage276(idx as integer,m ref as Msg)
	local _h as Helper
	_h.entryIdx = idx
	local list as integer
	if not _agkCanAcceptMsg(idx, m) then exitfunction
	list = m.varIdx
	if m.asMe
	idx = m.sprIdx
	_h.entryIdx = idx
	endif
	if _agkGetClone(idx) = "active"
	_agkIncVar(32)
	aaac(idx,0)
	if _agkGetSpriteNameCollision(idx,"right")
	_agkDecVar(32)
	aaac(idx,0)
	else
	endif
	else
	endif
	_agkClearTempVars(idx)
endfunction

function onmessage277(idx as integer,m ref as Msg)
	local _h as Helper
	_h.entryIdx = idx
	local list as integer
	if not _agkCanAcceptMsg(idx, m) then exitfunction
	list = m.varIdx
	if m.asMe
	idx = m.sprIdx
	_h.entryIdx = idx
	endif
	if _agkGetClone(idx) = "active"
	_agkMakeTempVar(idx,"image",0)
	_agkSetVar(_agkGetTempVar(idx,"image",0),str(_agkGetSpriteImage(idx)))
	_agkIncVar(_agkGetTempVar(idx,"image",0))
	if valfloat(__vars[_agkGetTempVar(idx,"image",0)].value) > valfloat("4")
	_agkSetVar(_agkGetTempVar(idx,"image",0),"1")
	else
	endif
	_agkSetSpriteImage(idx,val(__vars[_agkGetTempVar(idx,"image",0)].value))
	if _agkGetSpriteNameCollision(idx,"left")
	_agkIncVar(32)
	aaac(idx,0)
	else
	endif
	if _agkGetSpriteNameCollision(idx,"right")
	_agkDecVar(32)
	aaac(idx,0)
	else
	endif
	else
	endif
	_agkClearTempVars(idx)
endfunction

function aaac(idx as integer,list as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritepositionbyoffset(__sprs[idx].spr,(valfloat(__vars[33].value) + ((valfloat(__vars[32].value) - valfloat(__vars[33].value)) * 34)),(valfloat(__vars[34].value) + ((valfloat(__vars[31].value) - valfloat(__vars[34].value)) * 34)))
	_agkClearTempVars(idx)
endfunction


function onstart280(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(28)
	_h.img = LoadImage("gfx/I66.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "l4"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 357.000000,357.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstart281(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritedepth(__sprs[idx].spr,100)
	setspritevisible(__sprs[idx].spr,false)
	_agkClearTempVars(idx)
endfunction


function onstart290(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(29)
	_h.img = LoadImage("gfx/I67.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "s_dn"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 357.000000,357.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstart291(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritedepth(__sprs[idx].spr,100)
	setspritevisible(__sprs[idx].spr,false)
	_agkClearTempVars(idx)
endfunction


function onstart300(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(30)
	_h.img = LoadImage("gfx/I68.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "bl2"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 357.000000,357.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstart301(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritedepth(__sprs[idx].spr,100)
	setspritevisible(__sprs[idx].spr,false)
	_agkClearTempVars(idx)
endfunction


function onstart310(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(31)
	_h.img = LoadImage("gfx/I69.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "z_dn"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 357.000000,357.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstart311(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritedepth(__sprs[idx].spr,100)
	setspritevisible(__sprs[idx].spr,false)
	_agkClearTempVars(idx)
endfunction


function onstart320(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(32)
	_h.img = LoadImage("gfx/I70.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "box"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 374.000000,340.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstart321(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritedepth(__sprs[idx].spr,100)
	setspritevisible(__sprs[idx].spr,false)
	_agkClearTempVars(idx)
endfunction


function onstart330(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(33)
	_h.img = LoadImage("gfx/I71.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "line2"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 374.000000,374.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstart331(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritedepth(__sprs[idx].spr,100)
	setspritevisible(__sprs[idx].spr,false)
	_agkClearTempVars(idx)
endfunction


function onstart340(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(34)
	_h.img = LoadImage("gfx/I73.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "bg"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 374.000000,646.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstart341(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	setspritedepth(__sprs[idx].spr,200)
	in.keyRepeat = 200
	_agkSetVar(36,"1")
	_agkSendMsg(idx,"piece",_agkMakeQuickList1(idx,__vars[36].value),0)
	_agkClearTempVars(idx)
endfunction

function onupdate342(idx as integer)
	local _h as Helper
	_h.entryIdx = idx
	aaad(idx,0)
	_agkClearTempVars(idx)
endfunction

function aaad(idx as integer,list as integer)
	local _h as Helper
	_h.entryIdx = idx
	if (in.keyPressed = 37)
	_agkSendMsg(idx,"left",0,0)
	else
	if (in.keyPressed = 39)
	_agkSendMsg(idx,"right",0,0)
	else
	if (in.keyPressed = 38)
	_agkSendMsg(idx,"rotate",0,0)
	else
	if (in.keyState = 40)
	_agkSendMsg(idx,"down",0,0)
	else
	endif
	endif
	endif
	endif
	_agkClearTempVars(idx)
endfunction


function onstart350(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(35)
	_h.img = LoadImage("gfx/I84.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "right"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 561.000000,629.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction


function onstart360(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(36)
	_h.img = LoadImage("gfx/I85.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "left"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 187.000000,629.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction


function onstart370(idx as integer)
	local _h as Helper
	_h.idx = _agkMakeSprite(37)
	_h.img = LoadImage("gfx/I86.png")
	__sprs[_h.idx].img.imgs.insert(_h.img)
	__sprs[_h.idx].name = "bottom"
	_agkSetSpriteImage(_h.idx, 1)
	SetSpritePositionByOffset(__sprs[_h.idx].spr, 374.000000,1003.000000)
	SetSpriteAngle(__sprs[_h.idx].spr, 0.000000)
	SetSpriteScaleByOffset(__sprs[_h.idx].spr, 1.000000,1.000000)
	SetSpriteShape(__sprs[_h.idx].spr, 3)
	_agkClearTempVars(idx)
endfunction

function onstartAll()
	local _h as Helper
	initVars()
	onstart330(33)
	onstart290(29)
	onstart270(27)
	onstart310(31)
	onstart350(35)
	onstart280(28)
	onstart300(30)
	onstart320(32)
	onstart340(34)
	onstart370(37)
	onstart271(27)
	onstart281(28)
	onstart291(29)
	onstart301(30)
	onstart311(31)
	onstart321(32)
	onstart331(33)
	onstart341(34)
	onstart360(36)
endfunction

function onupdateAll()
	local _h as Helper
	onupdate272(27)
	_h.i = 0
	while _h.i <= __sprs[27].clone.idxs.length
		__sprs[__sprs[27].clone.idxs[_h.i]].active = true
		inc _h.i
	endwhile
	_h.i = 0
	while _h.i <= __sprs[27].clone.idxs.length
		if __sprs[__sprs[27].clone.idxs[_h.i]].active
			onupdate272(__sprs[27].clone.idxs[_h.i])
		endif
		inc _h.i
	endwhile
	onupdate342(34)
	_h.i = 0
	while _h.i <= __sprs[34].clone.idxs.length
		__sprs[__sprs[34].clone.idxs[_h.i]].active = true
		inc _h.i
	endwhile
	_h.i = 0
	while _h.i <= __sprs[34].clone.idxs.length
		if __sprs[__sprs[34].clone.idxs[_h.i]].active
			onupdate342(__sprs[34].clone.idxs[_h.i])
		endif
		inc _h.i
	endwhile
endfunction

function onmessageAll(msg as string)
	local _h as Helper
	if __msgs.length = -1 then exitfunction
	_h.j = 0
	while _h.j <= __msgs.length
		__msgs[_h.j].active = true
		inc _h.j
	endwhile
	_h.j = 0
	while _h.j <= __msgs.length
		_h.flag = false
		if __msgs[_h.j].active
			select __msgs[_h.j].msg
			case "piece"
			if (msg = "" or msg = "piece")
				onmessage273(27,__msgs[_h.j])
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					__sprs[__sprs[27].clone.idxs[_h.i]].active = true
					inc _h.i
				endwhile
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					if __sprs[__sprs[27].clone.idxs[_h.i]].active
						onmessage273(__sprs[27].clone.idxs[_h.i],__msgs[_h.j])
					endif
					inc _h.i
				endwhile
				_agkClearMsgTempVars("piece")
				_h.flag = true
			endif
			endcase
			case "down"
			if (msg = "" or msg = "down")
				onmessage274(27,__msgs[_h.j])
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					__sprs[__sprs[27].clone.idxs[_h.i]].active = true
					inc _h.i
				endwhile
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					if __sprs[__sprs[27].clone.idxs[_h.i]].active
						onmessage274(__sprs[27].clone.idxs[_h.i],__msgs[_h.j])
					endif
					inc _h.i
				endwhile
				_agkClearMsgTempVars("down")
				_h.flag = true
			endif
			endcase
			case "left"
			if (msg = "" or msg = "left")
				onmessage275(27,__msgs[_h.j])
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					__sprs[__sprs[27].clone.idxs[_h.i]].active = true
					inc _h.i
				endwhile
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					if __sprs[__sprs[27].clone.idxs[_h.i]].active
						onmessage275(__sprs[27].clone.idxs[_h.i],__msgs[_h.j])
					endif
					inc _h.i
				endwhile
				_agkClearMsgTempVars("left")
				_h.flag = true
			endif
			endcase
			case "right"
			if (msg = "" or msg = "right")
				onmessage276(27,__msgs[_h.j])
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					__sprs[__sprs[27].clone.idxs[_h.i]].active = true
					inc _h.i
				endwhile
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					if __sprs[__sprs[27].clone.idxs[_h.i]].active
						onmessage276(__sprs[27].clone.idxs[_h.i],__msgs[_h.j])
					endif
					inc _h.i
				endwhile
				_agkClearMsgTempVars("right")
				_h.flag = true
			endif
			endcase
			case "rotate"
			if (msg = "" or msg = "rotate")
				onmessage277(27,__msgs[_h.j])
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					__sprs[__sprs[27].clone.idxs[_h.i]].active = true
					inc _h.i
				endwhile
				_h.i = 0
				while _h.i <= __sprs[27].clone.idxs.length
					if __sprs[__sprs[27].clone.idxs[_h.i]].active
						onmessage277(__sprs[27].clone.idxs[_h.i],__msgs[_h.j])
					endif
					inc _h.i
				endwhile
				_agkClearMsgTempVars("rotate")
				_h.flag = true
			endif
			endcase
			endselect
		endif
		if _h.flag
			__msgs.remove(_h.j)
		else
			inc _h.j
		endif
	endwhile
endfunction

_agkRun("tetris",768.000000,1024.000000)
