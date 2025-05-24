#option_explicit

#include "common.agc"
#include "input.agc"
#include "setup.agc"

//-----------------------------------------------------------------
// globals for testing.
//
global list as integer
global out as string[]
global show as integer
global what as integer

show = true
what = 0

//-----------------------------------------------------------------
// test image load.
//
function test_ontartup0(spr as integer)
	
	local _h as Helper
	_h.spr = _agkMakeSprite(0)
	_h.img = LoadImage("face.png")
	__sprs[_h.spr].img.imgs.insert(_h.img)
	_agkSetSpriteImage(_h.spr, 0)
	
endfunction

//-----------------------------------------------------------------
// list tests.
//
function testLists()
		
	_agkInsertListItem(list, "hello", -1)
	testCheck(out, "Append", "hello", printList(list))
	_agkInsertListItem(list, "world", -1)
	testCheck(out, "Append", "hello,world", printList(list))
	_agkInsertListItem(list, "this", -1)
	testCheck(out, "Append", "hello,world,this", printList(list))
	_agkInsertListItem(list, "is", -1)
	testCheck(out, "Append", "hello,world,this,is", printList(list))
	_agkInsertListItem(list, "a", -1)
	testCheck(out, "Append", "hello,world,this,is,a", printList(list))
	_agkInsertListItem(list, "test", -1)
	testCheck(out, "Append", "hello,world,this,is,a,test", printList(list))

	_agkInsertListItem(list, "aaa", 0)
	testCheck(out, "Insert index, 0", "aaa,hello,world,this,is,a,test", printList(list))
	_agkInsertListItem(list, "bbb", 3)
	testCheck(out, "Insert index, 3", "aaa,hello,world,bbb,this,is,a,test", printList(list))
	_agkInsertListItem(list, "ccc", 100)
	testCheck(out, "Insert index, 100", "aaa,hello,world,bbb,this,is,a,test,ccc", printList(list))
	_agkInsertListItem(list, "ddd", -3)
	testCheck(out, "Insert index, -3", "aaa,hello,world,bbb,this,is,a,ddd,test,ccc", printList(list))

	_agkRemoveListItem(list, 0)
	testCheck(out, "Remove index, 0", "hello,world,bbb,this,is,a,ddd,test,ccc", printList(list))
	_agkRemoveListItem(list, 100)
	testCheck(out, "Remove index, 100", "hello,world,bbb,this,is,a,ddd,test,ccc", printList(list))
	_agkRemoveListItem(list, -3)
	testCheck(out, "Remove index, -3", "hello,world,bbb,this,is,a,test,ccc", printList(list))
	_agkRemoveListItem(list, -100)
	testCheck(out, "Remove index, -100", "hello,world,bbb,this,is,a,test,ccc", printList(list))
	_agkRemoveListItem(list, 2)
	testCheck(out, "Remove index, 2", "hello,world,this,is,a,test,ccc", printList(list))
	_agkRemoveListItem(list, -1)
	testCheck(out, "Remove index, -1", "hello,world,this,is,a,test", printList(list))

	_agkSetListItem(list, 0, "joe")
	testCheck(out, "Set 0, joe", "joe,world,this,is,a,test", printList(list))

	_agkSetListItem(list, 3, "peter")
	testCheck(out, "Set 3, peter", "joe,world,this,peter,a,test", printList(list))

	_agkSetListItem(list, -1, "paul")
	testCheck(out, "Set -1, paul", "joe,world,this,peter,a,paul", printList(list))

	_agkSetListItem(list, 100, "frank")
	testCheck(out, "Set 100, frank", "joe,world,this,peter,a,paul", printList(list))

	_agkSetListItem(list, -100, "frank")
	testCheck(out, "Set -100, frank", "joe,world,this,peter,a,paul", printList(list))

	_agkSetListItemName(list, 0, "joe")
	what = 1
	testCheck(out, "Set name 0, joe", "joe,,,,,", printList(list))
	what = 2
	testCheck(out, "Set name 0, joe", "joe:joe,:world,:this,:peter,:a,:paul", printList(list))

	_agkSetListItemName(list, 3, "peter")
	what = 1
	testCheck(out, "Set name 3, peter", "joe,,,peter,,", printList(list))
	what = 2
	testCheck(out, "Set name 3, peter", "joe:joe,:world,:this,peter:peter,:a,:paul", printList(list))

	_agkSetListItemName(list, -1, "paul")
	what = 1
	testCheck(out, "Set name -1, paul", "joe,,,peter,,paul", printList(list))
	what = 2
	testCheck(out, "Set name -1, paul", "joe:joe,:world,:this,peter:peter,:a,paul:paul", printList(list))

	what = 0
	
	local idx as integer
	local s as string
	
	s = "peter"
	idx = _agkFindListItem(list, s, 0)
	testCheck(out, "Find " + s + ", 0", "0", str(idx))

	idx = _agkFindListItem(list, s, 0)
	testCheck(out, "Find " + s + ", 0", "5", str(idx))

	idx = _agkFindListItem(list, s, 3)
	testCheck(out, "Find " + s + ", 3", "5", str(idx))

	idx = _agkFindListItem(list, s, 100)
	testCheck(out, "Find " + s + ", 100", "-1", str(idx))

	idx = _agkFindListItem(list, s, -1)
	testCheck(out, "Find " + s + ", -1", "5", str(idx))

	idx = _agkFindListItem(list, s, -3)
	testCheck(out, "Find " + s + ", -3", "5", str(idx))

	s = "xxx"
	idx = _agkFindListItem(list, s, 0)
	testCheck(out, "Find " + s + ", 0", "-1", str(idx))

	idx = _agkFindListItem(list, s, 0)
	testCheck(out, "Find " + s + ", 0", "-1", str(idx))

	idx = _agkFindListItem(list, s, 3)
	testCheck(out, "Find " + s + ", 3", "-1", str(idx))

	idx = _agkFindListItem(list, s, 100)
	testCheck(out, "Find " + s + ", 100", "-1", str(idx))

	idx = _agkFindListItem(list, s, -1)
	testCheck(out, "Find " + s + ", -1", "-1", str(idx))

	idx = _agkFindListItem(list, s, -3)
	testCheck(out, "Find " + s + ", -3", "-1", str(idx))

	// "hello,world,this,is,a,test" list at this point.

	s = "peter"
	idx = _agkFindListItemName(list, s, 0)
	testCheck(out, "Find By Name " + s + ", 0", "3", str(idx))

	idx = _agkFindListItemName(list, s, 3)
	testCheck(out, "Find By Name " + s + ", 3", "3", str(idx))

	s = "xxx"
	idx = _agkFindListItemName(list, s, 0)
	testCheck(out, "Find By Name " + s + ", 0", "-1", str(idx))

	idx = _agkFindListItemName(list, s, 3)
	testCheck(out, "Find By Name " + s + ", 3", "-1", str(idx))

	local t as string
	
	t = _agkGetListItem(list, 0)
	testCheck(out, "Get 0 ", "hello", t)

	t = _agkGetListItem(list, 3)
	testCheck(out, "Get 3 ", "is", t)

	t = _agkGetListItem(list, -1)
	testCheck(out, "Get -1 ", "test", t)

	t = _agkGetListItem(list, 100)
	testCheck(out, "Get 100 ", "", t)

	t = _agkGetListItem(list, -100)
	testCheck(out, "Get -100 ", "", t)

	t = _agkGetListItemName(list, 0)
	testCheck(out, "Get Name 0 ", "joe", t)
	
	t = _agkGetListItemName(list, 2)
	testCheck(out, "Get Name 2 ", "", t)

	t = _agkGetListItem(list, 3)
	testCheck(out, "Get Name 3 ", "peter", t)

	t = _agkGetListItem(list, -1)
	testCheck(out, "Get Name -1 ", "", t)

	idx = _agkGetListLen(list)
	out.insert(printList(list))
	testCheck(out, "Length ", "6", str(idx))

	_agkClearList(list)
	testCheck(out, "Clear ", "", printList(list))
	
	//_agkSplitToList("hello,world,how,are,you", ",", list)
	//testCheck(out, "Split ", "hello,world,how,are,you", printList(list))
	

endfunction

//-----------------------------------------------------------------
// print the list to a string.
//
function printList(list as integer)
	
	local ret as string
	
	ret = _agkJoinList(list, ",", what) // 2={name}:{value}
	
endfunction ret

//-----------------------------------------------------------------
// validate tests.
//
function testCheck(out ref as string[], name as string, ex as string, ac as string)
	
	local ret as string
	
	if ac = ex
		ret = "PASSED"
	else
		ret = "FAILED"
	endif
	
	out.insert(name + " test " + ret)
	
	if show
		
		out.insert("  expected: " + ex)
		out.insert("    actual: " + ac)
		
	endif

endfunction

//-----------------------------------------------------------------
// init tests.
//
function onStartAll()
	
	testLists()
	
endfunction

//-----------------------------------------------------------------
// keep printing.
//
function onMessageAll(msg as string)
	
endfunction

//-----------------------------------------------------------------
// keep printing.
//
function onUpdateAll()
	
	local i as integer
	local pos as integer
	
	pos = out.length - 20
	
	if pos < 0
		pos = 0
	endif
	
	for i = pos to out.length
		print(out[i])
	next

endfunction

//-----------------------------------------------------------------
// kick off the tests.
//
_agkRun("TEST", 1920, 1080)
