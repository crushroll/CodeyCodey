#option_explicit

//-----------------------------------------------------
//
global ti as Title

type Title

	words as Word[]
	cols as integer[]
	wordTime as integer
	wordTimeInc as integer
	wordIdx as integer
	mode as integer
	img as integer
	img1 as integer
	img2 as integer
	
endtype

type Word

	spr1 as integer
	spr2 as integer
	tw1 as integer
	tw2 as integer

endtype

//-----------------------------------------------------
//
function tiInit()

	ti.cols.insert(co.red[8])
	ti.cols.insert(co.orange[8])
	ti.cols.insert(co.amber[7])
	ti.cols.insert(co.green[7])
	ti.cols.insert(co.lightblue[7])
	ti.cols.insert(co.indigo[6])
	ti.cols.insert(co.purple[6])
	ti.cols.insert(co.teal[7])
	ti.cols.insert(co.pink[6])
	ti.cols.insert(co.brown[7])

	ti.wordTime = 0
	ti.wordIdx = 0
	ti.mode = 0
	
endfunction

//-----------------------------------------------------
//
function tiShow()

	local w as Word
	local x as float
	local y as float
	local r as float
	local i as integer
	local col as integer
	local depth as integer

	col = 3
	depth = BACK_DEPTH - 100
	
	coSetClearColor(co.grey[5])

	ti.img = CreateImageColor(0, 0, 0, 0)
	ResizeImage(ti.img, 1024, 512)

	x = co.w / 2 
	y = co.h / 2
	r = 400
	
	for i = 45 to 315 step 10
		
		w = tiCreateWord("codey", 256, 8, ti.cols[col], depth)
		
		SetSpritePositionByOffset(w.spr1, x + cos(i) * r, y + sin(i) * r)
		SetSpriteAngle(w.spr1, i)
		SetSpriteDepth(w.spr1, depth)
		SetSpriteVisible(w.spr1, false)
		
		SetSpritePositionByOffset(w.spr2, x + cos(i) * r, y + sin(i) * r)
		SetSpriteAngle(w.spr2, i)
		SetSpriteDepth(w.spr2, depth + 2)
		SetSpriteVisible(w.spr2, false)
		
		ti.words.insert(w)

		inc col
		dec depth, 10
		
		if col > ti.cols.length
			col = 0
		endif

	next

	DeleteImage(ti.img)
	ti.img = 0
	
	ti.wordTimeInc = 20
	ti.wordTime = GetMilliseconds() + ti.wordTimeInc
	ti.wordIdx = 0
	ti.mode = 1 // Spin.
	
endfunction

//-----------------------------------------------------
//
function tiCreateWord(s as string, size as integer, border as float, col as integer, depth as integer)

	local i as integer
	local w as Word
	local img as integer
	local text as integer
	local texts as integer[]
	local x as float
	local y as float

	if not ti.img1

		img = CopyImage(ti.img, 0, 0, GetImageWidth(ti.img), GetImageHeight(ti.img))
		SetRenderToImage(img, 0)
		SetVirtualResolution(GetImageWidth(img), GetImageHeight(img))
			
		text = CreateText(s)
		texts.insert(text)
		SetTextFont(text, 0)
		SetTextSize(text, size)
		SetTextAlignment(text, 1)
		coSetTextColor(text, co.white)
		//SetTextDepth(text, depth)

		// For rendering.
		x = GetImageWidth(img) / 2
		y = GetImageHeight(img) / 2 - GetTextTotalHeight(text) / 2
		SetTextPosition(text, x, y)
	
		Render()
		SetRenderToScreen()
		SetVirtualResolution(co.w, co.h)

		ti.img1 = img
			
		img = CopyImage(ti.img, 0, 0, GetImageWidth(ti.img), GetImageHeight(ti.img))
		SetRenderToImage(img, 0)
		SetVirtualResolution(GetImageWidth(img), GetImageHeight(img))
		
		for i = 0 to 360 step 8

			text = CreateText(s)
			texts.insert(text)
			SetTextFont(text, 0)
			SetTextSize(text, size)
			SetTextAlignment(text, 1)			
			//SetTextDepth(text, depth + 2)
			coSetTextColor(text, co.black)

			// For rendering.
			SetTextPosition(text, x + cos(i) * border, y + sin(i) * border)
			
		next

		Render()
		SetRenderToScreen()
		SetVirtualResolution(co.w, co.h)

		ti.img2 = img

		for i = 0 to texts.length
			deletetext(texts[i])
		next

		texts.length = -1

	endif

	w.spr1 = createSprite(ti.img1)
	coSetSpriteColor(w.spr1, col)
	w.spr2 = createSprite(ti.img2)
		
endfunction w

//-----------------------------------------------------
//
function tiDeleteWord(w ref as Word)

	if w.spr1
		
		DeleteSprite(w.spr1)
		w.spr1 = 0

	endif

	if w.spr2

		DeleteSprite(w.spr2)
		w.spr2 = 0

	endif

	if w.tw1
		
		DeleteTween(w.tw1)
		w.tw1 = 0

	endif

	if w.tw2
		
		DeleteTween(w.tw2)
		w.tw2 = 0

	endif
	
endfunction

//-----------------------------------------------------
//
function tiHide()

	local i as integer
	
	for i = 0 to ti.words.length
		tiDeleteWord(ti.words[i])
	next

	ti.words.length = -1
	
	if ti.img1
		
		DeleteImage(ti.img1)
		ti.img1 = 0

	endif

	if ti.img2
		
		DeleteImage(ti.img2)
		ti.img2 = 0

	endif
	
endfunction

//-----------------------------------------------------
// 
function tiPressed(x as float, y as float)

	OnButtonAction(BUT_TITLE_EXIT, 0)
	
endfunction

//-----------------------------------------------------
// 
function tiUpdate(delta as float)

	local m as integer
	local x as float
	local y as float
	local a as float
	local ang as float
	local dang as float
	local i as integer
	local al as integer
	local alpha as float
	local dalpha as float
	local h as integer

	if ti.mode = 1 // Spin
		
		if ti.wordTime > 0
			
			m = GetMilliseconds()

			if m >= ti.wordTime

				SetSpriteVisible(ti.words[ti.wordIdx].spr1, true)
				SetSpriteVisible(ti.words[ti.wordIdx].spr2, true)
				
				inc ti.wordIdx
				ti.wordTime = m + ti.wordTimeInc

				if ti.wordIdx > ti.words.length
												
					//inc ti.mode
					inc ti.mode

					h = ti.words.length / 2

					for i = 0 to ti.words.length

						ti.words[i].tw1 = CreateTweenSprite(ti.wordTimeInc)
						ti.words[i].tw2 = CreateTweenSprite(ti.wordTimeInc)

						if i < h
							
							SetTweenSpriteXByOffset(ti.words[i].tw1, GetSpriteXByOffset(ti.words[i].spr1), co.w / 3 + 64, TweenLinear())
							SetTweenSpriteYByOffset(ti.words[i].tw1, GetSpriteYByOffset(ti.words[i].spr1), co.h / 2, TweenLinear())
							SetTweenSpriteAngle(ti.words[i].tw1, GetSpriteAngle(ti.words[i].spr1), 0, TweenLinear())
							SetTweenSpriteXByOffset(ti.words[i].tw2, GetSpriteXByOffset(ti.words[i].spr2), co.w / 3 + 64, TweenLinear())
							SetTweenSpriteYByOffset(ti.words[i].tw2, GetSpriteYByOffset(ti.words[i].spr2), co.h / 2, TweenLinear())
							SetTweenSpriteAngle(ti.words[i].tw2, GetSpriteAngle(ti.words[i].spr2), 0, TweenLinear())

						else

							SetTweenSpriteXByOffset(ti.words[i].tw1, GetSpriteXByOffset(ti.words[i].spr1), co.w - co.w / 3 - 64, TweenLinear())
							SetTweenSpriteYByOffset(ti.words[i].tw1, GetSpriteYByOffset(ti.words[i].spr1), co.h / 2, TweenLinear())
							SetTweenSpriteAngle(ti.words[i].tw1, GetSpriteAngle(ti.words[i].spr1), 0, TweenLinear())
							SetTweenSpriteXByOffset(ti.words[i].tw2, GetSpriteXByOffset(ti.words[i].spr2), co.w - co.w / 3 - 64, TweenLinear())
							SetTweenSpriteYByOffset(ti.words[i].tw2, GetSpriteYByOffset(ti.words[i].spr2), co.h / 2, TweenLinear())
							SetTweenSpriteAngle(ti.words[i].tw2, GetSpriteAngle(ti.words[i].spr2), 0, TweenLinear())

						endif
						
					next

					for i = 0 to ti.words.length
						
						PlayTweenSprite(ti.words[i].tw1, ti.words[i].spr1, 0)
						PlayTweenSprite(ti.words[i].tw2, ti.words[i].spr2, 0)

					next
					
					ti.wordTime = m + 1000
					
				endif

			endif

		endif

	elseif ti.mode = 2 // Slide.

		if ti.wordTime > 0
			
			m = GetMilliseconds()

			if m < ti.wordTime
				UpdateAllTweens(delta)
			else
				inc ti.mode
			endif

		endif

	elseif ti.mode = 3

		m = GetMilliseconds()
		ti.wordTime = m + 2000
		inc ti.mode

	elseif ti.mode = 4

		if ti.wordTime > 0
			
			m = GetMilliseconds()

			if m >= ti.wordTime

				inc ti.mode
				ti.wordTime = 0
				tiPressed(in.ptrX, in.ptrY)
				
			endif

		endif

	endif
	
	if in.ptrPressed

		tiPressed(in.ptrX, in.ptrY)
			
	endif

endfunction
