/*
=============================================================================================
Codey Codey
=============================================================================================
FILE STRUCTURE

/config
  config.json
  settings.json

/projects
  /Pnnn
    code.json - contains 'status' = LOCKED, SHARED_BY_YOU, SHARED_TO_YOU, PURCHASED, etc.
    icon.png
    /sprites
      Innn.png
    /_thumbs
      Innn.png
    /sounds
      Snnn.wav
    /videos
      Vnnn.mp4

-- from here down, created or copied to project by AGK code.
    agk.json - replaces code.json when in AGK_BUILD mode.
    /agk 
      main.agc
      common.agc
      setup.agc
      input.agc
      compile.bat - created by Codey Codey to run the AGK2 compiler over the code and run the .exe
      agk.exe - after compile is complete.
      /media
        /gfx
        /fonts
=============================================================================================
*/



/*
=============================================================================================
// Codey Codey AGK
=============================================================================================
//
// Tool tips for AGK commands, with description link to AGK docs.
// Try gfx editor and see if OpenGL is faster. If still okay, fix bugs.
// -- Resize buttons don't go away.
// Delete a variable (on the vars tab) clears all variables in code, not just the one var.
// Fix editing parts, some scenarios cause the part to stay at the top (where is shows while editing).
// Change the onmessageAll() fn to use a loop for messages and a generate select statement for each message.
// Consider automatically making space as code overlaps other code.
// Add delete key support for WIN_MODE.
// Add Ctrl-C and Ctrl-V support for WIN_MODE.
// Ensure WIN_MODE vs. AGK_BUILD are used correctly.
*/






/*
=============================================================================================
LOADER

Bugs
---------------------------------------------------------------------------------------------
M json processing is really slow, try binary / image save and load
M use jsonvalue for list and object vars

Features
---------------------------------------------------------------------------------------------
=============================================================================================


=============================================================================================
CODER

Bugs
---------------------------------------------------------------------------------------------
H Call Block crashes with array issue
H Resize window crashes

XH Clones are running the when > pressed !!!
XH Back/Run button not activating when using repeat until <>
H REMOVE MAKE EXAMPLE menu item.

XH AGK bug - Video background is grey, can't see anything else. Check if desktop only!!!
XH AGK deficiency - how do I select sounds or videos on a mobile device?
L fix the variable editor (i.e. wait for input), it doesn't seem to allow typing too far before scrolling to the left.
L when in trueedit, not trueedit keyboard and mouse movement are overridding.
L Acceptable - fix zoom - can't find the issue.
L Acceptable - Things as depth > THING_DEPTH_MAX, will all be at the max value and overlap.
L AGK bug - Won't accept first click after loading a sprite from file systems.
L AGK bug - find out why editing is so slow, and can the keyboard style be controlled.
L Tight binding between loader and coder.

Features
---------------------------------------------------------------------------------------------
H Add hash to ensure code is valid.
H Choose the destination platform to adjust screen, i.e. mobile or ipad.
L Buy and/or download projects from the community, including library projects.
L Share and/or sell projects to the community, including library projects.
L The variable 'library' tab will show variables that have been shared with you, e.g. to exchange data between projects in community.
L Share code in library projects
L allow multi lime text editor when editing pure text like for print cmd,. Need to select font, allow 1 of 5, with 5 sizes
L in app purchase, generate deploy able $20, they can put on store. Use consumable in-app purchase, then redeem it to get a package
L Online public or private area, maybe use a back4app backend
L sharing
L editor mobile mode
L how example & community content is pulled in from cloud vs. Free in-app purchases
L graphics packs, purchasable
L add saved blocks tab. Drag a define cmd  onto panel, give it a name. Code is added to it, it gets saved outside of the project.
L allow min and max to be swapped in [random cmd] (for set angle?)
L ‎Get true edit working properly
L parallax scroll
L resizing code area on screen resize (for windows / mac)
L sound packs, purchasable
L allow shared things to be purchased.
L sound editor.
L add version control, and diff.
L save the whole project into an image or maybe a zip.
L scroll bars should jump by a "page" not to the end
L button action. Maybe have shadow on button, when pressed push button down, and when released pops up again
L debugger
L add simple tweens, e.g. jump, bounce, slowdown, etc.
L Better color selector for parts.
L Functional limit license for testing users, eg. Simon and ray
L phone use
-- mobile mode lower res editor eg 1024 with scrolling select cmds and editor area  top, larger buttons, slide out select cmds, auto scrolling b/n left and right, show overlapping area,which causes scroll
-- ‎option for scrolling CMD tabs as headings in a long list, try folding like car list
-- larger cmds
-- larger icons
=============================================================================================


=============================================================================================
IMAGE EDITOR

Bugs
---------------------------------------------------------------------------------------------
H Fix resize so it doesn't automatically change on keypress, just on tab.
L Fix edge width (it isn't wide enough) when zooming to a size that is very close to the visible edit width.

Features
---------------------------------------------------------------------------------------------
M Add scrollbars and panning window.
L add ability to use a sprite sheet, and select a part as a frame
L Future, animation mode, slice edit area and put frames on right side.
L Future, layers.
L Implement edit last (to allow resize and rotate of last drawing).
L Find new edit last icon or remove it.
L See if there are any other functions on the adjust toolbar.

=============================================================================================


=============================================================================================
DESIGNER

Bugs
---------------------------------------------------------------------------------------------

Features
---------------------------------------------------------------------------------------------
H add resize type, i.e. pixel or smooth.
H add tap through to allow drilling down through selecting things in a depth stack.
=============================================================================================


=============================================================================================
RUNNER

Bugs
---------------------------------------------------------------------------------------------
H Hang in runtime! Can't find.

Features
---------------------------------------------------------------------------------------------
H Debugger
-- press debug in run more menu, debug becomes step, reset become resume
-- show coder with red background, can't change anything, step in coder more menu activates,, highlight last executed cmd on each sprite with green border, show values of vars, and parts, eg loops.
-- in main, if ru.rt.debugging call the rustep() function on runner after updateallobjects or maybe updatecollisions - see recode below
H add ability to remove var cmds running by pressing checkbox.
L Add ability to see code running (transparent) for debugging. With pause and step fns.
L add display text cmd with width and height.
L add more button, that pops up extra buttons, eg reset, code, settings
=============================================================================================


=============================================================================================
SOUND EDITOR

Features
---------------------------------------------------------------------------------------------
H volume
H reverse
H clip
M record
=============================================================================================

*/
