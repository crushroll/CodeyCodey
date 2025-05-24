#renderer "Basic"

#option_explicit

#include "common.agc"
#include "input.agc"
#include "gui.agc"
#include "designer.agc"
#include "editor.agc"
#include "coder.agc"
#include "runner.agc"
#include "loader.agc"
#include "title.agc"
#include "json.agc"
#include "agkbuild.agc"

//-----------------------------------------------------
// Version
//
#constant VER_NBR "1.0.0" // First version.
#constant WIN_MODE 0
#constant AGK_BUILD 0

//-----------------------------------------------------
//
// Views.
//
#constant VIEW_TITLE 0
#constant VIEW_DESIGNER 1
#constant VIEW_CODER 2
#constant VIEW_RUNNER 3
#constant VIEW_EDITOR 4

//-----------------------------------------------------
// Command type.
//
#constant CMD_STMT 0x00 // Executes a stmt that returns no value.
#constant CMD_OPER 0x01 // Executes a stmt that returns a value.
#constant CMD_COND 0x02 // Executes a condition, and returns a bool.
#constant CMD_SPEC 0x04 // Special cmd, e.g. thing / app.
#constant CMD_BUT 0x08 // A command that is not a cmd, but a button.
#constant CMD_TEXT 0x10 // A command that is not a cmd, but a text only.
#constant CMD_OSTR 0x20 // It's an operator, but returns a string.
#constant CMD_OPEN 0x40 // Is an open cmd.
#constant CMD_CLOSE 0x80 // Is a close cmd.

//-----------------------------------------------------
// Things groups.
//
//#constant THING_SPRITE 0
//#constant THING_SOUND 1
//#constant THING_VIDEO 2

//-----------------------------------------------------
// Cmd groups.
//
#constant GRP_BEGIN 0
#constant GRP_MOVE 1
#constant GRP_LOOK 2
#constant GRP_FLOW 3
#constant GRP_SENSE 4
#constant GRP_EMIT 5
#constant GRP_CALC 6
#constant GRP_DATA 7
#constant GRP_SPRITE 8
#constant GRP_VAR 9
#constant GRP_SOUND 10
#constant GRP_VIDEO 11
#constant GRP_FRAME 12
#constant GRP_APP 13

//-----------------------------------------------------
//
// Codes.
// Format of code value is 6 hex digits: XXYZZZ
// Where:
//        XX = CMD_TYPE - see above
//        Y = grp (0 to F, or 16 possible)
//        ZZZ = id (0 is reserved)
//
#constant CODE_EVENT_BLOCK 0x0001
#constant CODE_EVENT_TIMER 0x0002
#constant CODE_EVENT_RUN 0x0003
#constant CODE_EVENT_COLL_ANY_CLONE 0x0004
#constant CODE_EVENT_COLL_ANY_THING 0x0005
#constant CODE_EVENT_COLL_ANY_EDGE 0x0006
#constant CODE_EVENT_COLL_THING 0x0007
#constant CODE_EVENT_RECEIVED 0x0008
#constant CODE_EVENT_CLONE 0x000A
#constant CODE_EVENT_COLL_EDGE 0x000B
#constant CODE_EVENT_PTR_PRESSED 0x000C
#constant CODE_EVENT_PTR_RELEASED 0x000D
#constant CODE_EVENT_PTR_DOWN 0x000E
#constant CODE_EVENT_SPRITE_PRESSED 0x000F
#constant CODE_EVENT_VAR_PRESSED 0x0010
#constant CODE_EVENT_SPRITE_RELEASED 0x0011
#constant CODE_EVENT_VAR_RELEASED 0x0012
#constant CODE_EVENT_COLL_CLONE 0x0013
#constant CODE_EVENT_UPDATE 0x0014

#constant CODE_MOVE_SET_X 0x1001 //
#constant CODE_MOVE_SET_Y 0x1002 //
#constant CODE_MOVE_MOVE_X 0x1003 //
#constant CODE_MOVE_MOVE_Y 0x1004 //
#constant CODE_MOVE_SET_ANGLE 0x1005 // 
#constant CODE_MOVE_MOVE_ANGLE 0x1006 //
#constant CODE_MOVE_SET_POS 0x1007 //
#constant CODE_MOVE_POINT_AT_POS 0x1008 //
#constant CODE_MOVE_POINT_AT_THING 0x1009 //
#constant CODE_MOVE_GET_X 0x1100A //
#constant CODE_MOVE_GET_Y 0x1100B //
#constant CODE_MOVE_GET_ANGLE 0x1100C //
#constant CODE_MOVE_FORWARD 0x100D //
#constant CODE_MOVE_DIST_TO_POS 0x1100E //
#constant CODE_MOVE_DIST_TO_THING 0x1100F //
#constant CODE_MOVE_WRAP_SCREEN_X 0x1010 //
#constant CODE_MOVE_WRAP_SCREEN_Y 0x1011 //
#constant CODE_MOVE_SET_RANDOM_POS 0x1012 //
#constant CODE_MOVE_CAN_COLL 0x1013 //
#constant CODE_MOVE_EDGE_BOUNCE 0x1014 //
#constant CODE_MOVE_THING_BOUNCE 0x1015 //

#constant CODE_LOOK_SET_COLOR 0x2001 //
#constant CODE_LOOK_SHOW 0x2002 //
#constant CODE_LOOK_HIDE 0x2003 //
#constant CODE_LOOK_GET_FRAME 0x12004 //
#constant CODE_LOOK_SET_FRAME 0x2005 // test
#constant CODE_LOOK_SET_SCALE 0x2006 //
#constant CODE_LOOK_BRING_TO_FRONT 0x2007
#constant CODE_LOOK_SEND_TO_BACK 0x2008
//#constant CODE_LOOK_SET_DEPTH 0x2009
#constant CODE_LOOK_SET_TRANSPARENCY 0x200A //
#constant CODE_LOOK_GET_WIDTH 0x12012 //
#constant CODE_LOOK_GET_HEIGHT 0x12013 //
#constant CODE_LOOK_GET_DEPTH 0x12014
#constant CODE_LOOK_GET_TRANSPARENCY 0x12015 //
#constant CODE_LOOK_GET_COLOR 0x12016 //
#constant CODE_LOOK_GET_SCALE_X 0x12017 //
#constant CODE_LOOK_GET_SCALE_Y 0x12018 //
#constant CODE_LOOK_SET_SCALE_X 0x2019 //
#constant CODE_LOOK_SET_SCALE_Y 0x201A //
#constant CODE_LOOK_CREATE_CLONE 0x201B //
#constant CODE_LOOK_DELETE_CLONE 0x201C // test
#constant CODE_LOOK_CHANGE_SCALE 0x201D
#constant CODE_LOOK_CHANGE_SCALE_X 0x201E
#constant CODE_LOOK_CHANGE_SCALE_Y 0x201F
#constant CODE_LOOK_PREV_FRAME 0x2020 //
#constant CODE_LOOK_NEXT_FRAME 0x2021 //
#constant CODE_LOOK_SET_FRAME_IMAGE 0x2022 // test
#constant CODE_LOOK_GET_VISIBLE 0x22023 // test
#constant CODE_LOOK_PRINT 0x2024
#constant CODE_LOOK_PEN_DOWN 0x2025 // test
#constant CODE_LOOK_PEN_UP 0x2026 // test
#constant CODE_LOOK_SET_PEN_COLOR 0x2027 // test
#constant CODE_LOOK_SET_PEN_SIZE 0x2028 // test
#constant CODE_LOOK_CHANGE_TRANSPARENCY 0x2029
#constant CODE_LOOK_FLIP_X 0x202A
#constant CODE_LOOK_FLIP_Y 0x202B
#constant CODE_LOOK_SET_PRINT_BG_COLOR 0x202C
#constant CODE_LOOK_SET_PRINT_BORDER_COLOR 0x202D
#constant CODE_LOOK_SET_PRINT_TEXT_COLOR 0x202E
#constant CODE_LOOK_DELETE_ALL_CLONES 0x202F
#constant CODE_LOOK_SET_PEN_STYLE 0x2030
#constant CODE_LOOK_SAVE_PEN 0x2031 // test
#constant CODE_LOOK_STAMP_PEN 0x2032 // test
#constant CODE_LOOK_CLEAR_PEN 0x2033 // test
#constant CODE_LOOK_STOP_SAVE_PEN 0x2034 // test
#constant CODE_LOOK_DRAW_OVAL 0x2035 // test
#constant CODE_LOOK_STAMP_SPRITE 0x2036 // test
#constant CODE_LOOK_TILE_BG 0x2037
#constant CODE_LOOK_SET_PIXEL_SCALING 0x2038
#constant CODE_LOOK_ERASE_STAMP_SPRITES 0x2039 // test
#constant CODE_LOOK_PRINT_FOR_TIME 0x2039
#constant CODE_LOOK_SET_COLOR_PARTS 0x0203A //
#constant CODE_LOOK_CHANGE_COLOR_PARTS 0x0203B // test
#constant CODE_LOOK_SET_PRINT_FONT 0x203C
#constant CODE_LOOK_SET_PRINT_FONT_SIZE 0x203D
#constant CODE_LOOK_BRING_FORWARD 0x203E
#constant CODE_LOOK_SEND_BACKWARD 0x203F
#constant CODE_LOOK_GET_OFF_SCREEN 0x22040 // test
#constant CODE_LOOK_UPDATES_OFF 0x2041 // test
#constant CODE_LOOK_UPDATES_ON 0x2042 // test

#constant CODE_FLOW_REPEAT_TIMES 0x3001 //
#constant CODE_FLOW_REPEAT_FOREVER 0x3002 //
#constant CODE_FLOW_REPEAT_UNTIL 0x3003 // test
#constant CODE_FLOW_REPEAT_WHILE 0x3004 // test
#constant CODE_FLOW_IF 0x3005 //
#constant CODE_FLOW_ELSE 0x3006 //
#constant CODE_FLOW_ENDIF 0x3007 //
#constant CODE_FLOW_RESET_TIMER 0x3008 //
#constant CODE_FLOW_GET_TIMER 0x13009 //
#constant CODE_FLOW_WAIT_SECS 0x301E // 
#constant CODE_FLOW_IF_ELSE 0x301F //
#constant CODE_FLOW_CALL_BLOCK 0x3020
#constant CODE_FLOW_SEND_EVENT 0x3021
//#constant CODE_FLOW_REPEAT_WHILE 0x3022 // test
#constant CODE_FLOW_REPEAT_END 0x3022 //
#constant CODE_FLOW_STOP 0x3023
#constant CODE_FLOW_EXIT_LOOP 0x3024
#constant CODE_FLOW_SKIP_LOOP 0x3025
#constant CODE_FLOW_COMMENT 0x3026
#constant CODE_FLOW_WAIT_UNTIL 0x3027
#constant CODE_FLOW_PARAM_VALUE 0x213029
#constant CODE_FLOW_PARAM_BOOL 0x2302A

#constant CODE_SENSE_PTR_X 0x14001 //
#constant CODE_SENSE_PTR_Y 0x14002 //
#constant CODE_SENSE_SPRITE_PRESSED 0x24003 //
#constant CODE_SENSE_SPRITE_INFO 0x14004 //
#constant CODE_SENSE_SPRITE_VIS 0x24005 //
#constant CODE_SENSE_KEY_PRESSED 0x24006
#constant CODE_SENSE_KEY_HELD 0x24007
#constant CODE_SENSE_KEY_RELEASED 0x24008
#constant CODE_SENSE_COLL_THING 0x24009
#constant CODE_SENSE_COLL_EDGE 0x2400A
#constant CODE_SENSE_SET_AS_BG 0x400F
#constant CODE_SENSE_X_MAX 0x14010
#constant CODE_SENSE_Y_MAX 0x14011
#constant CODE_SENSE_VAR_PRESSED 0x24012 //
#constant CODE_SENSE_SPRITE_DOWN 0x24013 //
#constant CODE_SENSE_SPRITE_RELEASED 0x24014 //
#constant CODE_SENSE_VAR_DOWN 0x24015 //
#constant CODE_SENSE_VAR_RELEASED 0x24016 //
#constant CODE_SENSE_PTR_PRESSED 0x24017 //
#constant CODE_SENSE_PTR_DOWN 0x24018 //
#constant CODE_SENSE_PTR_RELEASED 0x24019 //
#constant CODE_SENSE_SPRITE_OFF_SCREEN 0x2401A //
#constant CODE_SENSE_X_MID 0x1401B
#constant CODE_SENSE_Y_MID 0x1401C
#constant CODE_SENSE_TRUE 0x2401D
#constant CODE_SENSE_FALSE 0x2401E
#constant CODE_SENSE_EQ 0x2401F //
#constant CODE_SENSE_NE 0x24020 //
#constant CODE_SENSE_LT 0x24021 //
#constant CODE_SENSE_LE 0x24022 //
#constant CODE_SENSE_GT 0x24023 //
#constant CODE_SENSE_GE 0x24024 //
#constant CODE_SENSE_NOT 0x24025 //
#constant CODE_SENSE_OR 0x24026 //
#constant CODE_SENSE_AND 0x24027 //
#constant CODE_SENSE_AS_BOOL 0x24028 //
#constant CODE_SENSE_COLL_CLONE 0x24029
#constant CODE_SENSE_IAM_CLONE 0x2402A
#constant CODE_SENSE_COLL_ANY_THING 0x2402B
#constant CODE_SENSE_COLL_ANY_CLONE 0x2402C
#constant CODE_SENSE_IAM_SPRITE 0x2402D

#constant CODE_EMIT_PLAY_SOUND 0x5020
#constant CODE_EMIT_STOP_SOUND 0x5021
#constant CODE_EMIT_STOP_ALL_SOUNDS 0x5022
#constant CODE_EMIT_GET_SOUND_VOLUME 0x15023 //
#constant CODE_EMIT_SET_SOUND_VOLUME 0x5024
#constant CODE_EMIT_SET_CHANNEL_VOLUME 0x5025
#constant CODE_EMIT_PLAY_VIDEO 0x5026
#constant CODE_EMIT_GET_CHANNEL_VOLUME 0x5027
#constant CODE_EMIT_STOP_VIDEO 0x5028
#constant CODE_EMIT_SET_BG_COLOR 0x5029
#constant CODE_EMIT_SET_VAR_TITLE_COLOR 0x502A
#constant CODE_EMIT_SET_VAR_TITLE_POS 0x502B
#constant CODE_EMIT_SET_VAR_TITLE_FONT 0x502C
#constant CODE_EMIT_GET_VIDEO_X 0x1502D
#constant CODE_EMIT_GET_VIDEO_Y 0x1502E
#constant CODE_EMIT_SET_VAR_TITLE_DIR 0x502F
#constant CODE_EMIT_SET_VAR_BOX_COLOR 0x5030
#constant CODE_EMIT_SET_VAR_TEXT_COLOR 0x5031
#constant CODE_EMIT_SET_VAR_TEXT_FONT 0x5032
#constant CODE_EMIT_PRELOAD_SOUND 0x5033 //
#constant CODE_EMIT_UNLOAD_SOUND 0x5034 //
#constant CODE_EMIT_SET_SOUND_LOOPS 0x5035 //
#constant CODE_EMIT_GET_CHANNEL 0x15036 //
#constant CODE_EMIT_PLAY_SOUND_DONE 0x5037 //
#constant CODE_EMIT_SET_VIDEO_POS 0x5038 //
#constant CODE_EMIT_SET_VIDEO_WIDTH 0x5039 //
#constant CODE_EMIT_SET_VIDEO_HEIGHT 0x503A //
#constant CODE_EMIT_SET_VIDEO_VOLUME 0x503B //
#constant CODE_EMIT_LOAD_VIDEO 0x503C //
#constant CODE_EMIT_UNLOAD_VIDEO 0x503D //
#constant CODE_EMIT_PAUSE_VIDEO 0x503E //
#constant CODE_EMIT_GET_VIDEO_DURATION 0x1503F //
#constant CODE_EMIT_PLAY_VIDEO_DONE 0x5040 //
#constant CODE_EMIT_GET_VIDEO_TIME 0x15041 //
#constant CODE_EMIT_SHOW_VIDEO_PANEL 0x5042 //
#constant CODE_EMIT_HIDE_VIDEO_PANEL 0x5043 //
#constant CODE_EMIT_SET_VIDEO_TIME 0x5044 //
#constant CODE_EMIT_SHOW_VIDEO 0x5045 //
#constant CODE_EMIT_HIDE_VIDEO 0x5046 //
#constant CODE_EMIT_MAKE_COLOR 0x215047 // test

#constant CODE_CALC_RANDOM 0x16003 //
#constant CODE_CALC_PLUS 0x16004 //
#constant CODE_CALC_MINUS 0x16005 //
#constant CODE_CALC_MULTIPLY 0x16006 //
#constant CODE_CALC_DIVIDE 0x16007 //
#constant CODE_CALC_MOD 0x16008 //
#constant CODE_CALC_POW 0x16009 //
#constant CODE_CALC_ROUND 0x1600A //
#constant CODE_CALC_SIN 0x1600B //
#constant CODE_CALC_COS 0x1600C //
#constant CODE_CALC_TAN 0x1600D //
#constant CODE_CALC_ASIN 0x1600E //
#constant CODE_CALC_ACOS 0x1600F //
#constant CODE_CALC_ATAN 0x16010 //
#constant CODE_CALC_LOG 0x16011 //
#constant CODE_CALC_SQRT 0x16012 //
#constant CODE_CALC_NEG 0x16013 //
#constant CODE_CALC_RANDOM_FLOAT 0x1602A //
#constant CODE_CALC_RANDOM_X_POS 0x1602B //
#constant CODE_CALC_RANDOM_Y_POS 0x1602C //
#constant CODE_CALC_RANDOM_COLOR 0x21602D //
#constant CODE_CALC_FORMAT_NBR 0x21602E //
#constant CODE_CALC_GET_TIME 0x21602F //
#constant CODE_CALC_GET_DATE 0x216030 //
#constant CODE_CALC_EXTRACT 0x216031 // test.
#constant CODE_CALC_REPLACE 0x216032
#constant CODE_CALC_FIND 0x16033 // test.
#constant CODE_CALC_FIND_REV 0x16034 // test.
#constant CODE_CALC_IGNORE_CASE 0x6035
#constant CODE_CALC_APPEND 0x216036
#constant CODE_CALC_SPLIT_TEXT 0x216037 // test.
#constant CODE_CALC_LEN 0x16038 // test.
#constant CODE_CALC_TRIM 0x216039 // test.
#constant CODE_CALC_GET_DATETIME 0x21603A // test.
#constant CODE_CALC_AS_NBR 0x1603B //
#constant CODE_CALC_AS_TEXT 0x21603C //

#constant CODE_DATA_SET_VAR 0x7001 //
#constant CODE_DATA_ADD_ITEM 0x7002
#constant CODE_DATA_ITEM 0x217003
#constant CODE_DATA_CLEAR_VAR 0x7005
#constant CODE_DATA_JOIN_LIST 0x217006 // test.
#constant CODE_DATA_MAKE_TMP_VAR 0x7008 //
#constant CODE_DATA_SHARE_TMP_VAR 0x7009 //
#constant CODE_DATA_GET_TMP_VAR 0x21700A //
#constant CODE_DATA_REMOVE_ITEM 0x7010
#constant CODE_DATA_CHANGE_VAR 0x7012 //
#constant CODE_DATA_SET_VAR_BG_COLOR 0x7013
#constant CODE_DATA_SET_VAR_X 0x7014
#constant CODE_DATA_SET_VAR_Y 0x7015
#constant CODE_DATA_SET_VAR_TITLE_COLOR 0x7016
#constant CODE_DATA_SET_VAR_TITLE_FONT_SIZE 0x7017
#constant CODE_DATA_SET_VAR_TITLE_DIR 0x7018
#constant CODE_DATA_SET_VAR_TITLE_VIS 0x7019
#constant CODE_DATA_SET_VAR_TEXT_COLOR 0x701A
#constant CODE_DATA_SET_VAR_TEXT_FONT_SIZE 0x701B
#constant CODE_DATA_SET_VAR_BOX_COLOR 0x701C
#constant CODE_DATA_WAIT_INPUT 0x701D //
#constant CODE_DATA_SET_VAR_TITLE_ALIGN 0x701E
#constant CODE_DATA_SET_VAR_TEXT_ALIGN 0x701F
#constant CODE_DATA_SET_VAR_TEXT_SECRET 0x7020
#constant CODE_DATA_MAKE_TMP_LIST 0x7021 //
#constant CODE_DATA_SET_VAR_TITLE_FONT 0x7022
#constant CODE_DATA_SET_VAR_TEXT_FONT 0x7023
#constant CODE_DATA_SHOW_VAR 0x7024
#constant CODE_DATA_HIDE_VAR 0x7025
#constant CODE_DATA_ITEM_VALUE_INDEX 0x17026 // Item idx based on name.
#constant CODE_DATA_SET_ITEM_NAME 0x7027
#constant CODE_DATA_SET_ITEM_VALUE 0x7028
#constant CODE_DATA_ITEM_NAME 0x217029
#constant CODE_DATA_INSERT_ITEM 0x702A
#constant CODE_DATA_ITEM_NAME_INDEX 0x1702B // Item idx based on name.
#constant CODE_DATA_ITEM_BY_NAME 0x21702C
#constant CODE_DATA_ADD_ITEM_BY_NAME 0x702D
#constant CODE_DATA_GET_TMP_LIST 0x21702E //
#constant CODE_DATA_CLEAR_LIST 0x702F
#constant CODE_DATA_SET_VAR_W 0x7032
#constant CODE_DATA_SET_VAR_H 0x7033

#constant CODE_SPRITE_BASE 0x258001
#constant CODE_SPRITE_PART 0x258002

//#constant CODE_VAR_RUN 0x219001 // Runtime version of var, displayed on screen.
#constant CODE_VAR_GET 0x219002
#constant CODE_VAR_VALUE 0x219003 // Item in a list.
#constant CODE_VAR_TAG 0x19004 // Values of an object in a single text cmd.

#constant CODE_SOUND_BASE 0x21A001

#constant CODE_VIDEO_BASE 0x21B001

#constant CODE_FRAME_BASE 0x5C001
#constant CODE_FRAME_PART 0x5C002

#constant CODE_APP_BASE 0x5D001

//-----------------------------------------------------
// Command part constants. Define what is displayed.
//
#constant PART_STR 0 // Just plain text.
#constant PART_INT 1 // Int value.
#constant PART_FLOAT 2 // Float value.
#constant PART_BOOL 3 // Bool value.
#constant PART_TXT 4 // Text editor.
#constant PART_COL 5 // Color as #rrggbbaa
#constant PART_OBJ 6 // An object var as a list of properties.
#constant PART_IMG 7 // Image file name.
#constant PART_CMD 8 // Sub command.
#constant PART_SPRITE 9 // a sprite holder (code_sprite_part) in a cmd.
#constant PART_APP 10 // App part.
#constant PART_FRAME 11 // Frame of a thing.
#constant PART_VAR 12 // A var holder in a cmd for both values and lists, e.g. set variable ...
#constant PART_VAR_NAME 13 // The name part of a var operator / cmd.
#constant PART_SOUND 14 // Sound thing.
#constant PART_SOUND_NAME 15 // Sound thing.
#constant PART_VIDEO 16 // Video thing.
#constant PART_VIDEO_NAME 17 // Video thing.
#constant PART_APP_ICON 18 // The app icon.
#constant PART_SPRITE_ICON 19 // The sprite icon.
#constant PART_FRAME_ICON 20 // The frame icon.
#constant PART_APP_INFO 21 // The app icon, larger for the info screen.
#constant PART_FONT 22 // Font.
#constant PART_LIST 23 // A list holder in a cmd, e.g. set variable ...
#constant PART_VALUE 24 // A value variable.
#constant PART_SPRITE_IDX 25 // Special part for sprite idx in AGK commands.
#constant PART_TMP_CREATE 26 // Create a temp name.
#constant PART_TMP_FIND 27 // Find a temp name.

//-----------------------------------------------------
// Var types.
//
#constant VAR_TYPE_VALUE 0
#constant VAR_TYPE_LIST 1 // Ordered list.
#constant VAR_TYPE_OBJECT 2 // Object.

//-----------------------------------------------------
// Interactive help topic.
//
#constant MA_HOWTO_CREATE_PROJECT1 1 // Blank project.
#constant MA_HOWTO_CREATE_PROJECT2 2 // Blank, after checking for projects to open.
#constant MA_HOWTO_OPEN_PROJECT 3
#constant MA_HOWTO_CREATE_SPRITE 4
#constant MA_HOWTO_CREATE_SPRITE2 5
#constant MA_HOWTO_ADD_SPRITE 6
#constant MA_HOWTO_CREATE_SPRITE_NO_PROJECT 7
#constant MA_HOWTO_ADD_CMD 8
#constant MA_HOWTO_ADD_CMD_NO_SPRITE 9
#constant MA_HOWTO_EDIT_CMD 10
#constant MA_HOWTO_ADD_CMD_VALUE 11
#constant MA_HOWTO_RENAME_PROJECT 12
#constant MA_HOWTO_ADD_FRAME 13
#constant MA_HOWTO_ADD_FRAME2 14

//-----------------------------------------------------
// Items than can be interacted with by help.
//
#constant MA_HELP_ITEM_PROJECTS_TAB 1
#constant MA_HELP_ITEM_THINGS_TAB 2
#constant MA_HELP_ITEM_COMMANDS_TAB 3
#constant MA_HELP_ITEM_HELP_TAB 4
#constant MA_HELP_ITEM_CODE_TAB 5
#constant MA_HELP_ITEM_LIBRARY_TAB 6
#constant MA_HELP_ITEM_EVENT_TAB 7
#constant MA_HELP_ITEM_MOVE_TAB 8
#constant MA_HELP_ITEM_LOOK_TAB 9
#constant MA_HELP_ITEM_FLOW_TAB 10
#constant MA_HELP_ITEM_SENSE_TAB 11
#constant MA_HELP_ITEM_MATH_TAB 12
#constant MA_HELP_ITEM_DATA_TAB 13
#constant MA_HELP_ITEM_SPRITES_TAB 14
#constant MA_HELP_ITEM_VARS_TAB 15
#constant MA_HELP_ITEM_SOUNDS_TAB 16
#constant MA_HELP_ITEM_VIDEOS_TAB 17
#constant MA_HELP_ITEM_BUTTON 18
#constant MA_HELP_ITEM_PROJECT_LIBRARY_ITEM 19
#constant MA_HELP_ITEM_SPRITE_LIBRARY_ITEM 20
#constant MA_HELP_ITEM_SOUND_LIBRARY_ITEM 21
#constant MA_HELP_ITEM_VIDEO_LIBRARY_ITEM 22
#constant MA_HELP_ITEM_SEL_CMD 23
#constant MA_HELP_ITEM_CODE_CMD 24
#constant MA_HELP_ITEM_SPRITE 25
#constant MA_HELP_ITEM_VAR 26
#constant MA_HELP_ITEM_SOUND 27
#constant MA_HELP_ITEM_VIDEO 28
#constant MA_HELP_ITEM_PROJECTS_PANEL 29
#constant MA_HELP_ITEM_SPRITES_PANEL 30
#constant MA_HELP_ITEM_VARS_PANEL 31
#constant MA_HELP_ITEM_SOUNDS_PANEL 32
#constant MA_HELP_ITEM_VIDEO_PANEL 33
#constant MA_HELP_ITEM_CODE_PANEL 34
#constant MA_HELP_ITEM_MY_PROJECTS_FOLDER 35
#constant MA_HELP_ITEM_THINGS_TAB_INACTIVE 36
#constant MA_HELP_ITEM_COMMANDS_TAB_INACTIVE 37
#constant MA_HELP_ITEM_CODE_CMD_PART 38
#constant MA_HELP_ITEM_PROJECT_OPEN 39
#constant MA_HELP_ITEM_SPRITE_LIBRARY_ITEM2 40
#constant MA_HELP_ITEM_SPRITE_EXISTS 41

// Simulated actions, show different help action.
#constant MA_HELP_ACT_PRESS 1 // Show an animation of pressing a button.
#constant MA_HELP_ACT_DRAG 2 // Show animation of dragging.
#constant MA_HELP_ACT_RELEASE 3 // Check if action was a drop.
#constant MA_HELP_ACT_HOLD 4 // Check if action was a press and hold.
#constant MA_HELP_ACT_CHECK 5 // Just check if something exists.
#constant MA_HELP_ACT_END 0x10 // After this fires, stop the task list.

#constant MA_ANIM_LINE_SEGMENTS 20

//-----------------------------------------------------
// Init.
//
global ma as Main

type Main

	delta as float
	view as integer // The current view.
	prevView as integer

	cmds as Cmd[] // All cmds.
	freeCmds as integer[]

	parts as PartKey[] // All parts.
	freeParts as integer[]
	
	things as Thing[] // All things.
	freeThings as integer[]

	sounds as Sound[] // All sounds.
	freeSounds as integer[]

	videos as Video[] // All videos.
	freeVideos as integer[]
	
	vars as Var[] // All vars.
	freeVars as integer[]
	
	apps as App[] // All apps, with no loaded component.

	defvv as VarView // Default values.
	
	passedStrs as string[] // For passing b/n scenes. Yuck!

	helpInter as HelpInter
		
endtype


type App

	name as string // The name of the app.

	// Main data.
	id as string // The unique id outside of the app.
	folder as string // The app dir, including the path.
	sprites as integer[] // idx's into the master ma.things list.
	sprId as string // The current sprite.
	sounds as integer[]
	videos as integer[]
	vars as integer[] // Global vars for this app.
	img as integer // The project icon img loaded from file.
	screen as integer // The screen res for AGK apps.
	//obj as integer // fantom.
	
	// Views.
	vis as integer
	cmd as integer // A CODE_APP_BASE cmd, that holds the sprite and can be dragged.

	// Loader.
	loaded as integer // The currently loaded app.
	saved as integer // Dirty flag.
		
	// Internal use.
	assetDate as string // When was this asset last saved.

	// For internal use and downloaded (purchased or shared to you projects).
	ownerId as string // The id of the owner.
	ownerName as string // Who owns the project.
	versionNbr as string // <yyyy><mm><dd>.<build nbr>
	//versionDate as string // When was this version created.
	status as integer // Bit pattern: LD_STATUS_LOCKED, LD_STATUS_SHARED, etc.
	buyPrice as float // What you paid for the project.
	buyDate as string // The date you bought it.
	salePrice as float // The current sale price.
	shared as string // If non-blank, holds "*" for shared to everyone, or a user ID to share to specific people.

endtype

//
// Image for a thing.
//
type Image

	id as string // Unique id.
	img as integer // Loaded image.
	thumb as integer // Loaded thumbnail.
	cmd as integer // The drag thing.
	penImg as integer // Built with pen.
	bgImg as integer // Built with tile background.
	
endtype

//
// Sprite
//
type Thing

	idx as integer
	deleted as integer

	// Main data.
	//file as string // The name of the image file.
	id as string // unique id outside of app.
	//dir as string // The directory for when this thing is loaded from.
	name as string // Name of this thing.
	cmds as integer[]
	trimWhite as integer // Need to set this to true on load.
	tidyCode as integer
	vars as integer[] // Local vars for this thing.
	imgs as Image[] // Unique ids of images that this sprite can take on.
	imgIdx as integer // Index into the imgs list.
	x as float
	y as float
	w as float // The actual width we want the sprite - loaded.
	h as float // The actual height we want the sprite - loaded.
	sx as float // Scale x.
	sy as float // Scale y.
	ang as float
	//trans as float // Transparency from 0 to 100%
	obj as integer // fantom.
	//depth as integer
	clonedIdx as integer // The index of the master sprite for cloned sprites.
	//collGrp as integer // The collision grp.
	collThings as integer[] // The things collided with.
	collChecked as integer // True if has been checked.
	wrapX as integer
	wrapY as integer
	speed as float
	topDepth as integer // The highest depth of cmd, so dragging starts higher.
	
	// Views.
	//tab as integer // The tab to display on.
	vis as integer
	cmd as integer // A CODE_SPRITE_BASE cmd, that holds the sprite and can be dragged.

	offX as float // For dragging.
	offY as float
	tip as Tip
	pen as Pen

	// Runtimes.
	timer01 as float	
	doPress as integer // Has press events.
	doCollision as integer // Has collision code.
	colWith as integer[] // things it can collide with.
	isBg as integer // Is a background sprite.
	smoothScaling as integer
	rImgIdx as integer // For runtime.
	//moved as integer // If true, the things has bene moved and saved.
	drawSprs as DrawSpr[]
	
endtype

type Depth

	visDepth as integer // The actual sprite depth to set.
	idx as integer
	threadIdxs as integer[]
	
endtype

type Cmd

	idx as integer
	deleted as integer

	// Main data.
	typ as integer // Cmd type, e.g. STMT, OPER, COND
	code as integer // Unique execution code.
	parts as Part[] // Details of command values.
	root as integer // A root node on the panel.
	
	// Views.
	grp as integer // Group for coder.
	codeTab as integer // The screen code, or -1 if a sel cmd.
	lt as integer
	rt as integer
	bg as integer
	slt as integer
	srt as integer
	sbg as integer
	icon as integer
	iconScale as float
	drag as integer // Drag icon.
	icon2 as integer // For variables.
	sel as integer
	fold as integer
	foldImg as integer // Overrides the standard fold icon.
	check as integer
	edge as integer // For group stmts.
	sedge as integer
	clip as integer // Graphic showing a connection to above cmd.
	clipMode as integer // 0=none, 1=created, 2=keep depth low, i.e. in a lift
	x as float
	y as float
	xx as float // Save spot.
	yy as float // Save spot.
	w as float
	h as float
	ox as float
	oy as float
	vis as integer
	shadowVis as integer
	selected as integer
	selCol as integer
	alpha as integer
	depth as integer
	prevDepth as integer
	active as integer
	folded as integer
	foldable as integer
	foldAlignment as integer
	foldExtra as float
	checked as integer
	checkable as integer
	checkAlignment as integer
	parent as integer // The parent command for folding.
	help as string // The simple help in the "Help" button.
	help2 as string[] // The detailed help.
	var as integer // The variable for this cmd, if it's a variable cmd.
	blk as integer // The block for this cmd, if it's a block cmd.
	dragLX as float // The farthest left x point that is detected as within drag area.
	dragRX as float // The farthest right x point that is detected as within drag area.
	x0 as float
	y0 as float
	x1 as float
	y1 as float
	openCmd as integer
	closeCmd as integer
	
endtype

type PartKey

	idx as integer
	deleted as integer

endtype

type Part

	idx as integer
	deleted as integer
	
	// Runtime stuff.
	typ as integer
	info as string // This is the value of the part.
	//var as integer // A temp variable created when evaluated.

	// Coder stuff.
	img as integer // The loaded img.
	lt as integer
	rt as integer
	spr as integer // The sprite for viewing.
	icon as integer // Icon with a part.
	text as integer // The text for viewing.
	w as float
	h as float
	vis as integer
	active as integer
	resized as integer // Flag to note whether a part was resized or not, important for things/images.
	sprScale as float // The scale of the spr for a thing or frame.
	iconScale as float // The scale of the icon for a thing or frame.
	
endtype

type Sound

	name as string

	idx as integer
	deleted as integer

	id as string // unique id outside of app.
	file as string
	ext as string
	loadId as integer // The loaded sound id.
	cmd as integer // The display cmd.
	
endtype

type Video

	name as string 

	idx as integer
	deleted as integer

	id as string // unique id outside of app.
	file as string
	ext as string 
	loaded as integer // Whether the video is loaded.
	lw as float // Loaded width.
	lh as float // Loaded height.
	ratio as float // Aspect ratio.
	x as float
	y as float
	w as float
	h as float
	volume as float
	duration as float
	cmd as integer
	img as integer // The image for this video to render to.
	spr as integer // The sprite of the image created from img.
	
endtype

type VideoPanel

	vis as integer
	panel as integer // control background.
	playImg as integer
	pauseImg as integer
	playBut as integer
	rewBut as integer
	fwdBut as integer
	startBut as integer
	endBut as integer
	timeBut as integer
	timeLine as integer
	startTime as integer
	endTime as integer
	timeDiv as float

endtype

type VarItem

	name as string
	value as string
	cmd as integer
	index as integer // The numerical order if set.
	parent as integer // The parent var.
	
endtype

type Var

	// Main data.
	name as string // First for sorting.

	idx as integer
	deleted as integer

	id as string // The key.
	typ as integer // Data type.
	value as string
	runValue as string // Runtime value.
	list as VarItem[] // Items in the list.
	runList as VarItem[] // Runtime list.
	appIdx as integer // The app for this var.
	thingIdx as integer // The thing for this var.
	vis as integer // Visible on the runtime.
	cmd as integer // The command to display in the vars tab.
	v as VarView
	rv as VarView // The runtime settings.
	
endtype

type VarView

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
	depth as integer
	offX as float
	offY as float
	
	// Designer / runtime gfx.
	bg as integer
	title as integer
	box as integer
	text as integer
	edit as integer // EditBox.
	vis as integer // If set by the show/hide var.

endtype

// For sorting things.
type StrOrder

	name as string
	idx as integer
	
endtype

// For sorting things.
type NbrOrder

	nbr as integer
	idx as integer
	
endtype

type HelpInter // Interactive help.

	howTo as integer // The interactive help, e.g. "Create a project"
	taskIdx as integer // The idx into task. If > tasks.length, we've finished.
	sel as integer // The selected item, i.e. CD_HELP_ITEM_... or 0.
	tasks as HelpTask[] // The tasks (steps).
	ptrImg as integer
	animTaskIdx as integer
	
endtype

type HelpTask // Interactive task.
	
	item as integer // The thing to interact with.
	idx as integer // The number of the thing if relevant, e.g. lib item 0 = <new>, > 0 is a real item.
	act as integer // The action to take.
	switch as integer // A new howTo, if this one can't complete.
	prevCode as integer // The code of a previously added cmd.
	anims as HelpAnim[]
	doEnd as integer
	
endtype

type HelpAnim
	
	item as integer
	msg as string
	spr as integer
	lineSprs as integer[]
	src as integer
	dest as integer
	tip as Tip
	timer as integer
	alpha as integer
	delta as integer
	min as integer
	max as integer
	dir as integer
	ang as float
	linePts as Point[]
	linePtIdx as integer
	
endtype

type HelpData
	
	taskIdx as integer
	ret as integer
	switch as integer
	
endtype

//-----------------------------------------------------
// MAIN LINE CODE.
//

maInit()
maShow()

do
	maLoop()	
loop

maDestroy()

end


//-----------------------------------------------------
//
function maLoop()

	ClearScreen()

	ma.delta = GetFrameTime() * 60
	maUpdate(ma.delta)
	
	coLogPrint()
	
	Sync()

	if GetPaused()
		//colog("paused")
	elseif GetResumed()
		//colog("resumed")
	endif

endfunction

//-----------------------------------------------------
//
function maInit()

	local thing as integer
	local x as float
	local y as float
	local w as float
	local h as float
	local ww as float
	local hh as float
	local m as float
	local obj as integer

	SetOrientationAllowed(0, 0, 1, 1)
	SetWindowTitle("Codey Codey v0.1")
	UseNewDefaultFonts(true)
	SetGlobal3DDepth(10000)
	SetPhysicsMaxPolygonPoints(12)
	//SetPhysicsDebugOn()
	
	if WIN_MODE

		w = 3200
		h = 1536
		setVirtualResolution(w, h) // Set working res, must start like this.
		coInit()
		
		x = GetMaxDeviceWidth()
		y = GetMaxDeviceHeight()
		m = 200
		ww = x - m
		hh = ww * (h / w)
		SetWindowSize(ww, hh, false)
		SetWindowAllowResize(true)
		SetWindowPosition(x / 2 - ww / 2, y / 2 - hh / 2)
		//SetWindowPosition(0, 0)	
	
	else	 // For tablets.
		
		SetVirtualResolution(2048, 1536)
		//SetWindowAllowResize(true)
		coInit()
		//SetWindowSize(co.w, co.h, false)
		//setWindowPosition(GetDeviceWidth() / 2 - GetWindowWidth() / 2, GetDeviceHeight() / 2 - GetWindowHeight() / 2)
		
	endif
		
	//coInit()
	
	//SetWindowSize(co.w, co.h, false)
	//SetWindowPosition(GetDeviceWidth() / 2 - GetWindowWidth() / 2, GetDeviceHeight() / 2 - GetWindowHeight() / 2)
	//SetWindowAllowResize(true)
	//coLogTop(true)

	ma.helpInter.ptrImg = loadimage("help/ptr7.png")

	ma.defvv.x = co.bs / 4
	ma.defvv.y = co.bs / 4
	ma.defvv.w = 0
	ma.defvv.h = 0
	ma.defvv.name = ""
	ma.defvv.bgCol = co.brown[7]
	ma.defvv.titleVis = true
	ma.defvv.titleCol = co.white
	ma.defvv.titleDir = DIR_N
	ma.defvv.titleFont = 0
	ma.defvv.titleFontSize = 40
	ma.defvv.titleAlign = 1 // Centre
	ma.defvv.boxCol = co.white
	ma.defvv.textCol = co.black
	ma.defvv.textFont = 0
	ma.defvv.textFontSize = 40
	ma.defvv.textAlign = 4 // Centre
	ma.defvv.textSecret = false

	coSetClearColor(co.grey[0])
	SetBorderColor(128, 0, 0)

	guiInit()

	// To make sure all ids > 0.
	maCreateCmd(0)
	maCreateVar(0)
	
	if AGK_BUILD
		agAgkLoadCmds()
	endif

	ldInit()
	tiInit()
	
	cdInit()	
	cdHide()

	deInit()
	deHide()

	ruInit()
	ruHide()

	edInit()
	edHide()

	inInit()

	if ld.set.titleOn
		ma.view = VIEW_TITLE
	else
		ma.view = VIEW_CODER
	endif
	
	//ma.view = VIEW_EDITOR
	ma.view = VIEW_CODER
	
endfunction
	
//-----------------------------------------------------
// Print all cmds for a thing.
//
function maSave()

	coProgressStart(1)
	
	if cd.appId <> ""
		ldSaveApp(cd.appId)
	endif

	coProgressEnd()
	
endfunction


//-----------------------------------------------------
//
function maShow()

	//coLogClear()

/*
	if AGK_BUILD
		if ma.view = VIEW_RUNNER
			
			maAgkApp()
			ma.view = ma.prevView // Reset view back so it goes back to view it just came from.
			
		endif
	endif
*/

	if ma.view = VIEW_CODER
		cdShow()		
	elseif ma.view = VIEW_RUNNER
		ruShow()
	elseif ma.view = VIEW_DESIGNER
		deShow()
	elseif ma.view = VIEW_EDITOR
		edShow()
	elseif ma.view = VIEW_TITLE
		tiShow()
	endif

endfunction

//-----------------------------------------------------
//
function maHide()

	cdSetEditVisible(false)
		
	if ma.view = VIEW_DESIGNER
		deHide()
	elseif ma.view = VIEW_CODER
		cdHide()		
	elseif ma.view = VIEW_RUNNER
		ruHide()
	elseif ma.view = VIEW_EDITOR
		edHide()
	elseif ma.view = VIEW_TITLE
		tiHide()
	endif

endfunction

//-----------------------------------------------------
//
function maDestroy()
	
	//cdDestroy()
	//edDestroy()
	//deDestroy()
	//ruDestroy()
	
endfunction

//-----------------------------------------------------
// Create a var.
//
function maCreateVar(typ as integer)

	local idx as integer

	if ma.freeVars.length >= 0
		
		idx = ma.freeVars[0]
		ma.freeVars.remove(0)

	else
		
		local var as Var
		ma.vars.insert(var)
		idx = ma.vars.length

	endif

	ma.vars[idx].idx = idx
	ma.vars[idx].deleted = false
	ma.vars[idx].typ = typ
	ma.vars[idx].name = "" //"v." + str(id) // The dot is not allowed in a regular var name.
	ma.vars[idx].value = ""
	ma.vars[idx].runValue = ""
	ma.vars[idx].list.length = -1
	ma.vars[idx].runList.length = -1
	ma.vars[idx].vis = false
	ma.vars[idx].appIdx = -1
	ma.vars[idx].thingIdx = -1
	ma.vars[idx].cmd = 0

	maInitVarView(ma.vars[idx].v)
	
	if ma.vars[idx].typ = VAR_TYPE_LIST
		ma.vars[idx].v.textAlign = 1 // Default a list to top-centre.
	endif
	
endfunction idx

//-----------------------------------------------------
// Init a var view.
//
function maInitVarView(vv ref as VarView)

	// Design / runtime settings.
	vv.x = ma.defvv.x
	vv.y = ma.defvv.y
	vv.name = ma.defvv.name
	vv.bgCol = ma.defvv.bgCol
	vv.titleVis = ma.defvv.titleVis
	vv.titleFont = ma.defvv.titleFont
	vv.titleFontSize = ma.defvv.titleFontSize
	vv.titleCol = ma.defvv.titleCol
	vv.titleDir = ma.defvv.titleDir
	vv.titleAlign = ma.defvv.titleAlign
	vv.boxCol = ma.defvv.boxCol
	vv.textFont = ma.defvv.textFont
	vv.textFontSize = ma.defvv.textFontSize
	vv.textCol = ma.defvv.textCol
	vv.textAlign = ma.defvv.textAlign

	// Design / runtime gfx.
	vv.w = 0
	vv.h = 0
	vv.bg = 0
	vv.title = 0
	vv.box = 0
	vv.text = 0

endfunction

//-----------------------------------------------------
// Delete a var view.
//
function maCreateVarView(vv ref as VarView)

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

	gap = co.bs / 8
	gap2 = gap / 2

	if vv.titleVis
		
		if not vv.title
			vv.title = cocreatetext("guiCreateText", vv.name)
		endif

		cosettextfont(vv.title, vv.titleFont)
		//SetTextSize(vv.title, co.fontSizes[vv.titleFontSize])
		SetTextSize(vv.title, vv.titleFontSize)
		
		w1 = gap2 + GetTextTotalWidth(vv.title) + gap2
		h1 = GetTextTotalHeight(vv.title)

	else

		if vv.title
			
			deletetext(vv.title)
			vv.title = 0

		endif

		w1 = 0
		h1 = 0

	endif
	
	if not vv.text
			
		vv.text = cocreatetext("guiCreateText", "0")
		SetTextString(vv.text, " ")	
			
	endif

	cosettextfont(vv.text, vv.textFont)
	//SetTextSize(vv.text, co.fontSizes[vv.textFontSize])
	SetTextSize(vv.text, vv.textFontSize)
	
	// Account for box size.
	w2 = gap * 2 + GetTextTotalWidth(vv.text) + gap * 2
	h2 = GetTextTotalHeight(vv.text)

	//SetTextString(vv.text, " ")
	
	if vv.titleDir = DIR_N or vv.titleDir = DIR_S
			
		if w1 > w2
			ww = w1
		else
			ww = w2
		endif

		w2 = ww // Ensure box is right size.
		
		w = gap + ww + gap

		vv.mw = w

		if vv.w > 0

			if vv.w > w
				
				w = vv.w
				w2 = w - gap - gap
				
			endif
			
		endif
		
		if vv.titleVis
			h = gap2 + h1 + gap2 + h2 + gap
		else 
			h = gap + h2 + gap
		endif

		vv.mh = h

		if vv.h > 0

			if vv.h > h

				h = vv.h

				if vv.titleVis
					h2 = h - gap2 - h1 - gap2 - gap
				else 
					h2 = h - gap - gap
				endif

			endif

		endif
		
	elseif vv.titleDir = DIR_W or vv.titleDir = DIR_E

		if h1 > h2
			hh = h1
		else
			hh = h2
		endif
			
		if vv.titleVis
			w = gap + w1 + gap + w2 + gap
		else
			w = gap + w2 + gap
		endif

		vv.mw = w

		if vv.w > 0

			if vv.w > w
				
				w = vv.w
				w2 = w - gap - w1 - gap - gap
				
			endif

		endif
		
		h = gap + hh + gap

		vv.mh = h

		if vv.h > 0

			if vv.h > h

				h = vv.h
				h2 = h - gap - gap
				
			endif

		endif
		
	endif
	
	if not vv.bg
		vv.bg = guicreatebox("createvar", 1, 1)
	endif

	SetSpriteScale(vv.bg, w, h)

	if not vv.box
		vv.box = guicreatebox("cvar box", 1, 1)
	endif

	SetSpriteScale(vv.box, w2, h2)

	maUpdateVarView(vv)
	
endfunction

//-----------------------------------------------------
// Delete a var view.
//
function maDeleteVarView(vv ref as VarView)

	if vv.bg
		
		deletesprite(vv.bg)
		vv.bg = 0
		
	endif

	if vv.title
		
		deletetext(vv.title)
		vv.title = 0
		
	endif

	if vv.box
		
		deletesprite(vv.box)
		vv.box = 0
		
	endif

	if vv.text
		
		deletetext(vv.text)
		vv.text = 0
		
	endif

	if vv.edit
		
		DeleteEditBox(vv.edit)
		vv.edit = 0

	endif
	
	vv.vis = false // Must set this to make sure it doesn't try to redraw.
	
endfunction

//-----------------------------------------------------
// Make a var view visible.
//
function maSetVarViewVisible(vv ref as VarView, vis as integer)

	if vv.bg		
		SetSpriteVisible(vv.bg, vis)		
	endif

	if vv.title
		SetTextVisible(vv.title, vis)
	endif

	if vv.box		
		SetSpriteVisible(vv.box, vis)		
	endif

	if vv.text
		SetTextVisible(vv.text, vis)
	endif
	
endfunction

//-----------------------------------------------------
// Position a var view.
//
function maSetVarViewDepth(vv ref as VarView, depth as integer)

	local gap as float

	if vv.bg
		SetSpriteDepth(vv.bg, depth)
	endif

	if vv.box
		SetSpriteDepth(vv.box, depth - 1)
	endif

	if vv.title
		SetTextDepth(vv.title, depth - 2)
	endif

	if vv.text
		SetTextDepth(vv.text, depth - 2)
	endif

endfunction

//-----------------------------------------------------
// Update settings like colors.
//
function maUpdateVarView(vv ref as VarView)

	if vv.bg		
		coSetSpriteColor(vv.bg, vv.bgCol)
	endif

	if vv.title
		coSetTextColor(vv.title, vv.titleCol)
	endif

	if vv.text
		coSetTextColor(vv.text, vv.textCol)
	endif

	if vv.box
		coSetSpriteColor(vv.box, vv.boxCol)
	endif

endfunction

//-----------------------------------------------------
// Position a var view.
//
function maSetVarViewPos(vv ref as VarView, x as float, y as float)

	local gap as float
	local gap2 as float
	
	if vv.bg
		
		SetSpritePosition(vv.bg, x, y)
	
		gap = co.bs / 8
		gap2 = gap / 2
		
		if vv.titleDir = DIR_N
	
			if vv.title
								
				SetTextAlignment(vv.title, vv.titleAlign)
		
				if vv.titleAlign = 0
					SetTextPosition(vv.title, x + gap, y + gap2)
				elseif vv.titleAlign = 1
					SetTextPosition(vv.title, x + GetSpriteWidth(vv.bg) / 2, y + gap2)
				elseif vv.titleAlign = 2
					SetTextPosition(vv.title, x + GetSpriteWidth(vv.bg) - gap, y + gap2)
				endif
				
			endif
			
			if vv.box
				SetspritePosition(vv.box, x + gap, y + GetSpriteHeight(vv.bg) - gap - GetspriteHeight(vv.box))
			endif
	
		elseif vv.titleDir = DIR_S
			
			if vv.title
				
				SetTextAlignment(vv.title, vv.titleAlign)
		
				if vv.titleAlign = 0
					SetTextPosition(vv.title, x + gap, y + GetSpriteHeight(vv.bg) - gap2 - GetTextTotalHeight(vv.title))
				elseif vv.titleAlign = 1
					SetTextPosition(vv.title, x + GetSpriteWidth(vv.bg) / 2, y + GetSpriteHeight(vv.bg) - gap2 - GetTextTotalHeight(vv.title))
				elseif vv.titleAlign = 2
					SetTextPosition(vv.title, x + GetSpriteWidth(vv.bg) - gap, y + GetSpriteHeight(vv.bg) - gap2 - GetTextTotalHeight(vv.title))
				endif
			
			endif
			
			if vv.box
				SetspritePosition(vv.box, x + gap, y + gap)
			endif
	
		elseif vv.titleDir = DIR_W	
	
			if vv.title
				
				SetTextAlignment(vv.title, 0) // left.
				SetTextPosition(vv.title, x + gap, y + GetSpriteHeight(vv.bg) / 2 - GetTextTotalHeight(vv.title) / 2)
	
			endif
			
			if vv.box
				SetspritePosition(vv.box, x + GetSpriteWidth(vv.bg) - gap - GetSpriteWidth(vv.box), y + GetSpriteHeight(vv.bg) / 2 - GetSpriteHeight(vv.box) / 2)
			endif
			
		elseif vv.titleDir = DIR_E
	
			if vv.title
				
				SetTextAlignment(vv.title, 2) // right.
				SetTextPosition(vv.title, x + GetSpriteWidth(vv.bg) - gap, y + GetSpriteHeight(vv.bg) / 2 - GetTextTotalHeight(vv.title) / 2)
			
			endif
			
			if vv.box
				SetSpritePosition(vv.box, x + gap, y + GetSpriteHeight(vv.bg) / 2 - GetSpriteHeight(vv.box) / 2)
			endif
			
		endif
	
		if vv.text
			
			SetTextScissor(vv.text, getspritex(vv.box), getspritey(vv.box), getspritex(vv.box) + GetSpriteWidth(vv.box) - 1, getspritey(vv.box) + GetSpriteHeight(vv.box) - 1)

			if vv.textAlign = 0 or vv.textAlign = 3 or vv.textAlign = 6		
				SetTextAlignment(vv.text, 0) // Left.
			elseif vv.textAlign = 2 or vv.textAlign = 5 or vv.textAlign = 8		
				SetTextAlignment(vv.text, 2) // Right;
			else // centre.
				SetTextAlignment(vv.text, 1)
			endif
		
			if vv.textAlign = 0	
				SetTextPosition(vv.text, GetSpriteX(vv.box) + gap2, GetSpriteY(vv.box) + gap2)
			elseif vv.textAlign = 1	
				SetTextPosition(vv.text, GetSpriteXByOffset(vv.box), GetSpriteY(vv.box) + gap2)
			elseif vv.textAlign = 2
				SetTextPosition(vv.text, GetSpriteX(vv.box) + GetSpriteWidth(vv.box) - gap2, GetSpriteY(vv.box) + gap2)
			elseif vv.textAlign = 3	
				SetTextPosition(vv.text, GetSpriteX(vv.box) + gap2, GetSpriteYByOffset(vv.box) - GetTextTotalHeight(vv.text) / 2)
			elseif vv.textAlign = 4	
				SetTextPosition(vv.text, GetSpriteXByOffset(vv.box), GetSpriteYByOffset(vv.box) - GetTextTotalHeight(vv.text) / 2)
			elseif vv.textAlign = 5
				SetTextPosition(vv.text, GetSpriteX(vv.box) + GetSpriteWidth(vv.box) - gap2, GetSpriteYByOffset(vv.box) - GetTextTotalHeight(vv.text) / 2)
			elseif vv.textAlign = 6	
				SetTextPosition(vv.text, GetSpriteX(vv.box) + gap2, GetSpriteY(vv.box) + GetSpriteHeight(vv.box) - gap2 - GetTextTotalHeight(vv.text))
			elseif vv.textAlign = 7	
				SetTextPosition(vv.text, GetSpriteXByOffset(vv.box), GetSpriteY(vv.box) + GetSpriteHeight(vv.box) - gap2 - GetTextTotalHeight(vv.text))
			elseif vv.textAlign = 8
				SetTextPosition(vv.text, GetSpriteX(vv.box) + GetSpriteWidth(vv.box) - gap2, GetSpriteY(vv.box) + GetSpriteHeight(vv.box) - gap2 - GetTextTotalHeight(vv.text))
			endif
			
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Create a var.
//
function maCloneVar(varIdx as integer, runtime as integer)

	local newVarIdx as integer
	local i as integer
	
	newVarIdx = maCreateVar(ma.vars[varIdx].typ)
	maCopyVar(varIdx, newVarIdx, runtime)
	ma.vars[newVarIdx].thingIdx = ma.vars[varIdx].thingIdx
	
endfunction newVarIdx

//-----------------------------------------------------
// Copy src var data to dest.
//
function maCopyVar(srcVarIdx as integer, destVarIdx as integer, runtime as integer)

	local newVarIdx as integer
	local i as integer
	
	if runtime

		if ma.vars[srcVarIdx].typ = VAR_TYPE_VALUE
			
			ma.vars[destVarIdx].runValue = ma.vars[srcVarIdx].runValue
			
		elseif ma.vars[srcvarIdx].typ = VAR_TYPE_LIST
			
			for i = 0 to ma.vars[srcvarIdx].runList.length
				ma.vars[destVarIdx].runList.insert(ma.vars[srcvarIdx].runList[i])
			next 
			
		endif
		
	else 
			
		if ma.vars[srcvarIdx].typ = VAR_TYPE_VALUE
			
			ma.vars[destVarIdx].value = ma.vars[srcvarIdx].value
			
		elseif ma.vars[srcvarIdx].typ = VAR_TYPE_LIST
			
			for i = 0 to ma.vars[srcvarIdx].list.length
				ma.vars[destVarIdx].list.insert(ma.vars[srcvarIdx].list[i])
			next 
			
		endif
		
	endif
	
endfunction

//-----------------------------------------------------
// Delete a var.
//
function maDeleteVar(var as integer)

	if not ma.vars[var].deleted
				
		ma.vars[var].deleted = True
		ma.freeVars.insert(var)

	endif
	
endfunction

//-----------------------------------------------------
// Insert a var into a list of var indexes, i.e. integer[]
//
function maInsertVar(vars ref as integer[], var as integer)

	local i as integer
	local idx as integer

	idx = -1

	if vars.length > -1
		
		for i = 0 to vars.length

			if ma.vars[var].name < ma.vars[vars[i]].name

				idx = i
				vars.insert(var, i)
				exit

			endif
			
		next

	endif
	
	if idx = -1

		// Append.
		vars.insert(var)

	endif
	
endfunction

//-----------------------------------------------------
// Remove a name value pair from the obj var.
//
function maRemoveObjValue(var as integer, name as string)

	local i as integer
	
	// See if we need to remove the named value that is already there.
	for i = 0 to ma.vars[var].list.length
		
		//if ma.vars[var].list[i].value = value
		if ma.vars[var].list[i].name = name

			ma.vars[var].list.remove(i)
			exit

		endif
		
	next

endfunction

//-----------------------------------------------------
// Add a name value pair to the obj var, and also set the index.
//
function maSetObjValueAndIndex(var as integer, name as string, value as string)

	local ret as integer
	local varItem as VarItem
	local v as integer

	if ma.vars[var].typ <> VAR_TYPE_OBJECT
		exitfunction
	endif
	
	varItem.name = name
	varItem.value = value
	varItem.parent = var
	varItem.cmd = 0
	v = val(ma.vars[var].value)
	varItem.index = v
	inc v
	ma.vars[var].value = str(v)

	ma.vars[var].list.insertsorted(varItem)
	
endfunction

//-----------------------------------------------------
// Add a name value pair to the obj var.
//
function maSetObjValue(var as integer, name as string, value as string)

	local ret as integer
	local varItem as VarItem
	local i as integer

	if ma.vars[var].typ <> VAR_TYPE_OBJECT
		exitfunction
	endif

	maRemoveObjValue(var, name)
	
	varItem.name = name
	varItem.value = value
	varItem.parent = var
	varItem.cmd = 0

	ma.vars[var].list.insertsorted(varItem)
	
endfunction

//-----------------------------------------------------
// Set the index of the obj value for integer ordering.
//
function maSetObjValueIndex(var as integer, name as string, index as integer)

	local ret as integer
	local varItem as VarItem
	local i as integer

	if ma.vars[var].typ <> VAR_TYPE_OBJECT
		exitfunction
	endif

	for i = 0 to ma.vars[var].list.length
		
		if ma.vars[var].list[i].name = name

			ma.vars[var].list[i].index = index
			exit

		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Insert a sound into a list of var indexes, i.e. integer[]
//
function maInsertSound(sounds ref as integer[], sound as integer)

	local i as integer
	local idx as integer

	idx = -1

	if sounds.length > -1
		
		for i = 0 to sounds.length

			if ma.sounds[sound].name < ma.sounds[sounds[i]].name

				idx = i
				sounds.insert(sound, i)
				exit

			endif
			
		next

	endif
	
	if idx = -1

		// Append.
		sounds.insert(sound)

	endif
	
endfunction

//-----------------------------------------------------
// Insert a sound into a list of var indexes, i.e. integer[]
//
function maInsertVideo(videos ref as integer[], video as integer)

	local i as integer
	local idx as integer

	idx = -1

	if videos.length > -1
		
		for i = 0 to videos.length

			if ma.videos[video].name < ma.videos[videos[i]].name

				idx = i
				videos.insert(video, i)
				exit

			endif
			
		next

	endif
	
	if idx = -1

		// Append.
		videos.insert(video)

	endif
	
endfunction

//-----------------------------------------------------
// Create a cmd.
//
function maCreateCmd(code as integer)

	local idx as integer

	if ma.freeCmds.length >= 0
		
		idx = ma.freeCmds[0]
		ma.freeCmds.remove(0)

	else
		
		local cmd as Cmd
		ma.cmds.insert(cmd)
		idx = ma.cmds.length

	endif

	maInitCmd(idx, code)
	
endfunction idx

//-----------------------------------------------------
// Delete a cmd.
//
function maDeleteCmd(code as integer)

	if not ma.cmds[code].deleted
				
		ma.cmds[code].deleted = True
		ma.freeCmds.insert(code)

	endif

endfunction

//-----------------------------------------------------
// Create a cmd.
//
function maInitCmd(idx as integer, code as integer)

	ma.cmds[idx].deleted = false
	ma.cmds[idx].idx = idx
	ma.cmds[idx].code = code
	ma.cmds[idx].typ = (code >> 16) && 0xFF
	ma.cmds[idx].grp = (code >> 12) && 0xF
	ma.cmds[idx].codeTab = false // Sel cmd.
	ma.cmds[idx].x = 0
	ma.cmds[idx].y = 0
	ma.cmds[idx].xx = 0
	ma.cmds[idx].yy = 0
	ma.cmds[idx].w = 0
	ma.cmds[idx].h = 0
	ma.cmds[idx].root = false
	ma.cmds[idx].lt = 0
	ma.cmds[idx].bg = 0
	ma.cmds[idx].rt = 0
	ma.cmds[idx].slt = 0
	ma.cmds[idx].sbg = 0
	ma.cmds[idx].srt = 0
	ma.cmds[idx].sel = 0
	ma.cmds[idx].fold = 0
	ma.cmds[idx].check = 0
	ma.cmds[idx].edge = 0
	ma.cmds[idx].sedge = 0
	ma.cmds[idx].clip = 0
	ma.cmds[idx].clipMode = 0
	ma.cmds[idx].selected = 0
	ma.cmds[idx].selCol = co.black
	ma.cmds[idx].vis = false
	ma.cmds[idx].shadowVis = false
	ma.cmds[idx].alpha = 255
	ma.cmds[idx].active = true
	ma.cmds[idx].foldable = false
	ma.cmds[idx].folded = false
	ma.cmds[idx].foldAlignment = CD_FOLD_LEFT
	ma.cmds[idx].foldExtra = 0
	ma.cmds[idx].checkable = false
	ma.cmds[idx].checked = false
	ma.cmds[idx].checkAlignment = CD_CHECK_LEFT
	ma.cmds[idx].x0 = 0
	ma.cmds[idx].y0 = 0
	ma.cmds[idx].x1 = 0
	ma.cmds[idx].y1 = 0
	ma.cmds[idx].depth = 0
	ma.cmds[idx].prevDepth = 0
	ma.cmds[idx].openCmd = 0
	ma.cmds[idx].closeCmd = 0
	ma.cmds[idx].iconScale = 1.0

	//colog("code=" + str(code) + ", typ=" + str(ma.cmds[id].typ) + ", grp=" + str(ma.cmds[id].grp))

endfunction

//-----------------------------------------------------
// Create a part.
//
function maCreatePart()

	local idx as integer

	if ma.freeParts.length >= 0
		
		idx = ma.freeParts[0]
		ma.freeParts.remove(0)

	else
		
		local partKey as PartKey
		ma.parts.insert(partKey) // Dummy value.
		idx = ma.parts.length

	endif

	ma.parts[idx].idx = idx
	ma.parts[idx].deleted = false
	
endfunction idx

//-----------------------------------------------------
// Delete a part.
//
function maDeletePart(part ref as Part)

	if not ma.parts[part.idx].deleted
				
		ma.parts[part.idx].deleted = True
		ma.freeParts.insert(part.idx)

	endif

endfunction

//-----------------------------------------------------
// Create an app.
//
function maCreateApp(appId as string)

	local app as App
	local appIdx as integer

	if appId <> ""
		
		app.id = appId	
		ldFixNextAppId(appId)
				
	else
		
		app.id = ldGetNextAppId()
		
	endif
	
	app.name = ""
	app.versionNbr = "1.0.0"
	app.status = 0
	
	ma.apps.insert(app)
	appIdx = ma.apps.length
	
endfunction appIdx

//-----------------------------------------------------
// Delete a sound.
//
function maDeleteApp(appId as string)

	local i as integer
	local appIdx as integer
	
	appIdx = maFindAppById(appId)

	if appIdx > -1			
		ma.apps.remove(appIdx)
	endif	
	
endfunction


//-----------------------------------------------------
//
function maFindAppById(id as string)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.apps.length

		if ma.apps[i].id = id
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
//
function maFindAppByFolder(name as string)

	local i as integer
	local ret as integer
	local pos as integer

	ret = -1

	// Check if the name came from a folder, if so remove /.
	pos = findstring(name, "/")
	
	if pos > 0
		name = mid(name, pos + 1, -1)
	endif

	ret = maFindAppByName(name)

endfunction ret

//-----------------------------------------------------
//
function maFindAppByName(name as string)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.apps.length

		if ma.apps[i].name = name
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Returns the first app with status.
//
function maFindAppsByStatus(status as integer)

	local i as integer
	local ret as integer[]

	ret.length = -1
	
	for i = 0 to ma.apps.length

		if ma.apps[i].status && status			
			ret.insert(i)						
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Create a thing.
// Returns the index into the ma.things array.
//
function maCreateThing(thingId as string)

	local idx as integer

	if ma.freeThings.length >= 0
		
		idx = ma.freeThings[0]
		ma.freeThings.remove(0)

	else
		
		local thing as Thing
		ma.things.insert(thing)
		idx = ma.things.length

	endif

	ma.things[idx].deleted = false
	ma.things[idx].idx = idx

	if thingId <> ""
		ma.things[idx].id = thingId
	else
		ma.things[idx].id = ldGetNextThingId()
	endif
	
	ma.things[idx].name = ""
	ma.things[idx].x = 0
	ma.things[idx].y = 0
	ma.things[idx].sx = 1
	ma.things[idx].sy = 1
	ma.things[idx].ang = 0
	//ma.things[idx].trans = 255
	ma.things[idx].obj = 0
	ma.things[idx].offX = 0
	ma.things[idx].offY = 0
	ma.things[idx].wrapX = 0
	ma.things[idx].wrapY = 0
	ma.things[idx].speed = 0
	ma.things[idx].imgIdx = -1
	ma.things[idx].rImgIdx = -1
	ma.things[idx].imgs.length = -1
	ma.things[idx].cmds.length = -1
	ma.things[idx].vars.length = -1
	ma.things[idx].clonedIdx = -1
	ma.things[idx].timer01 = -0.01
	//ma.things[idx].doCollision = 0
	//ma.things[idx].colWith.length = -1 
	ma.things[idx].isBg = false
	ma.things[idx].smoothScaling = 1
	//ma.things[idx].moved = false
	
endfunction idx

//-----------------------------------------------------
// Delete a thing.
//
function maDeleteThing(thing as integer)

	if not ma.things[thing].deleted
				
		ma.things[thing].deleted = True
		ma.freeThings.insert(thing)

	endif
	
endfunction

//-----------------------------------------------------
// Delete a sound.
//
function maDeleteSound(sound as integer)

	if not ma.sounds[sound].deleted
				
		ma.sounds[sound].deleted = True
		ma.freeSounds.insert(sound)

	endif
	
endfunction

//-----------------------------------------------------
// Delete a video.
//
function maDeleteVideo(video as integer)

	if not ma.videos[video].deleted
				
		ma.videos[video].deleted = True
		ma.freeVideos.insert(video)

	endif
	
endfunction

//-----------------------------------------------------
// Clone a thing, and return the new thing idx.
//
function maCloneSprite(spriteIdx as integer)

	local newSpriteIdx as integer
	local i as integer
	local cmd as integer
	
	newSpriteIdx = maCreateThing("")

	ma.things[newSpriteIdx].x = ma.things[spriteIdx].x
	ma.things[newSpriteIdx].y = ma.things[spriteIdx].y
	ma.things[newSpriteIdx].sx = ma.things[spriteIdx].sx
	ma.things[newSpriteIdx].sy = ma.things[spriteIdx].sy
	ma.things[newSpriteIdx].ang = ma.things[spriteIdx].ang
	//ma.things[newSpriteIdx].trans = ma.things[spriteIdx].trans
	ma.things[newSpriteIdx].offX = ma.things[spriteIdx].offX
	ma.things[newSpriteIdx].offY = ma.things[spriteIdx].offY
	ma.things[newSpriteIdx].imgIdx = ma.things[spriteIdx].imgIdx
	ma.things[newSpriteIdx].imgs = ma.things[spriteIdx].imgs	
	ma.things[newSpriteIdx].cmds = ma.things[spriteIdx].cmds	
	ma.things[newSpriteIdx].vars = ma.things[spriteIdx].vars	
	ma.things[newSpriteIdx].clonedIdx = spriteIdx
	ma.things[newSpriteIdx].smoothScaling = ma.things[spriteIdx].smoothScaling
	//ma.things[newSpriteIdx].moved = ma.things[spriteIdx].moved
	
	// Clear copied images, so we don't delete them.
	//for i = 0 to ma.things[newSpriteIdx].imgs.length
		
	//	ma.things[newSpriteIdx].imgs[i].img = 0
	//	ma.things[newSpriteIdx].imgs[i].thumb = 0
		
	//next 
	
	//ma.things[newSpriteIdx].depth = ma.things[spriteIdx].depth
	
endfunction newSpriteIdx

//-----------------------------------------------------
// Create a sound.
// Returns the index into the ma.sounds array.
//
function maCreateSound(soundId as string)

	local idx as integer

	if ma.freeSounds.length >= 0
		
		idx = ma.freeSounds[0]
		ma.freeSounds.remove(0)

	else
		
		local sound as Sound
		ma.sounds.insert(sound)
		idx = ma.sounds.length

	endif

	ma.sounds[idx].deleted = false
	ma.sounds[idx].idx = idx

	if soundId <> ""
		ma.sounds[idx].id = soundId
	else
		ma.sounds[idx].id = ldGetNextSoundId()
	endif
	
	ma.sounds[idx].name = ""

endfunction idx

//-----------------------------------------------------
// Create a video.
// Returns the index into the ma.videos array.
//
function maCreateVideo(videoId as string)

	local idx as integer

	if ma.freeVideos.length >= 0
		
		idx = ma.freeVideos[0]
		ma.freeVideos.remove(0)

	else
		
		local video as Video
		ma.videos.insert(video)
		idx = ma.videos.length

	endif

	ma.videos[idx].deleted = false
	ma.videos[idx].idx = idx

	if videoId <> ""
		ma.videos[idx].id = videoId
	else
		ma.videos[idx].id = ldGetNextVideoId()
	endif
	
	ma.videos[idx].name = ""
	
endfunction idx

//-----------------------------------------------------
// Return the thingIdx for a thing based on id.
//
function maFindThingById(appIdx as integer, id as string)

	local i as integer
	local j as integer
	local ret as integer

	ret = -1

	if appIdx = -1

		for j = 0 to ma.apps.length
			
			for i = 0 to ma.apps[j].sprites.length
	
				if ma.things[ma.apps[j].sprites[i]].id = id
					
					ret = ma.apps[j].sprites[i]
					exit
					
				endif
				
			next
			
			if ret > -1
				exit
			endif

		next 
				
	else 
		
		for i = 0 to ma.apps[appIdx].sprites.length
	
			if ma.things[ma.apps[appIdx].sprites[i]].id = id
				
				ret = ma.apps[appIdx].sprites[i]
				exit
				
			endif
			
		next
		
	endif

endfunction ret

//-----------------------------------------------------
// Return the soundIdx for a sound based on id.
//
function maFindSoundById(appIdx as integer, id as string)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.sounds.length

		if ma.sounds[i].id = id

			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Return the soundIdx for a sound based on idx.
//
function maFindSoundByIdx(appIdx as integer, idx as integer)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.apps[appIdx].sounds.length

		if ma.sounds[ma.apps[appIdx].sounds[i]].idx = idx

			ret = ma.apps[appIdx].sounds[i]
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Return the videoIdx for a video based on id.
//
function maFindVideoByIdx(appIdx as integer, idx as integer)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.apps[appIdx].videos.length

		if ma.videos[ma.apps[appIdx].videos[i]].idx = idx
			
			ret = ma.apps[appIdx].videos[i]
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Return the videoIdx for a video based on id.
//
function maFindVideoById(appIdx as integer, id as string)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.videos.length

		if ma.videos[i].id = id
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Find the frame with cmd, in the things.imgs array, and return the idx.
//
function maFindFrameByCmd(thingIdx as integer, cmd as integer)

	local i as integer
	local ret as integer

	ret = -1

	for i = 0 to ma.things[thingIdx].imgs.length

		if ma.things[thingIdx].imgs[i].cmd = cmd
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Find the thing with cmd, in the app.things array, and return the idx.
//
function maFindThingByCmd(appIdx as integer, cmd as integer)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.apps[appIdx].sprites.length

		if ma.things[ma.apps[appIdx].sprites[i]].cmd = cmd
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Find the sound with cmd, in the app.sounds array, and return the idx.
//
function maFindSoundByCmd(appIdx as integer, cmd as integer)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.apps[appIdx].sounds.length

		if ma.sounds[ma.apps[appIdx].sounds[i]].cmd = cmd
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

//-----------------------------------------------------
// Find the video with cmd, in the app.videos array, and return the idx.
//
function maFindVideoByCmd(appIdx as integer, cmd as integer)

	local i as integer
	local ret as integer

	ret = -1
	
	for i = 0 to ma.apps[appIdx].videos.length

		if ma.videos[ma.apps[appIdx].videos[i]].cmd = cmd
			
			ret = i
			exit
			
		endif
		
	next

endfunction ret

/*
//-----------------------------------------------------
// Find the depth index for the passed thing.
//
function maGetThingDepthIdx(depths ref as Depth[], thingIdx as integer)

	local idx as integer
	//local i as integer

	idx = ma.things[thingIdx].depthIdx
	
	idx = -1
	
	for i = 0 to depths.length

		if depths[i].idx = thingIdx
			
			idx = i
			exit
			
		endif
		
	next

endfunction idx
*/

//-----------------------------------------------------
// Make initial list of depths from the appIdx things.
//
function maMakeThingDepths(depths ref as Depth[], appIdx as integer)
 
	local i as integer
	local td as Depth
	
	depths.length = -1

	for i = 0 to ma.apps[appIdx].sprites.length

		td.idx = ma.apps[appIdx].sprites[i]
		depths.insert(td)
			
	next
	
endfunction

//-----------------------------------------------------
// Apply depths.
//
function maApplyThingDepths(depths ref as Depth[])

	local i as integer
	local depthDiv as integer
	local visDepth as integer
	local depth as integer
	
	depthDiv = co.depthRange / (depths.length + 1) 
	//depth = THING_DEPTH_BASE
	visDepth = THING_DEPTH_BASE // depthDiv
	
	for i = 0 to depths.length
		
		depths[i].visDepth = visDepth
		SetDepth(ma.things[depths[i].idx].obj, visDepth)
		guiSetTipDepth(ma.things[depths[i].idx].tip, visDepth)
		visDepth = visDepth + depthDiv

	next

endfunction

//-----------------------------------------------------
// Print depths.
//
function maPrintThingDepths(depths ref as Depth[])
	
	local i as integer
	
	for i = 0 to depths.length
		colog("depth[" + str(i) + "]=" + str(depths[i].idx))			
	next

	colog("depthDiv=" + str(ru.rt.depthDiv))

endfunction

//-----------------------------------------------------
// View a thing.
//
function maSetThingVisible(thing as integer, vis as integer)

	ma.things[thing].vis = vis

	if ma.things[thing].obj
		SetVisible(ma.things[thing].obj, vis)
	endif
	
endfunction

//-----------------------------------------------------
// Search for a thing based on the pressed location.
// -1 if not over a thing.
//
function maFindThing(x as float, y as float)

	local idx as integer
	local i as integer

	idx = -1
	
	for i = 0 to ma.things.length

		//if GetspriteHitTest(getsprite(ma.things[i].obj), x, y)
		if GetspriteHitTest(ma.things[i].obj, x, y)
			
			idx = i
			exit
			
		endif

	next
	
endfunction idx

//-----------------------------------------------------
// Get a var.
// If mode is provided, only look there, otherwise scan the stack of modes.
//
function maGetVar(appIdx as integer, thingIdx as integer, name as string)

	local idx as integer
	local i as integer
	local varIdx as integer

	idx = 0

	if thingIdx > -1

		while ma.things[thingIdx].clonedIdx > -1
			thingIdx = ma.things[thingIdx].clonedIdx
		endwhile
		
		for i = 0 to ma.things[thingIdx].vars.length

			varIdx = ma.things[thingIdx].vars[i]
			
			if ma.vars[varIdx].name = name

				idx = varIdx
				exit

			endif
				
		next

	endif

	if idx = 0
		
		if appIdx > -1
			
			for i = 0 to ma.apps[appIdx].vars.length

				varIdx = ma.apps[appIdx].vars[i]

				if ma.vars[varIdx].name = name

					idx = varIdx
					exit

				endif
					
			next

		endif

	endif
	
endfunction idx

//-----------------------------------------------------
// Print a cmd.
//
function maPrintCmd(cmd as integer, debug as integer)

	local s as string
	
	s = maPrintCmdPtr(ma.cmds[cmd], debug)
	
endfunction s

//-----------------------------------------------------
// Print a cmd by ptr.
//
function maPrintCmdPtr(cmd ref as Cmd, debug as integer)

	local s as String
	local i as integer

	if debug > 0

		s = "["

		for i = 0 to cmd.parts.length
				
			if i > 0 and debug > 2 then s = s + ","
			s = s + maPrintPart(cmd.parts[i], debug)
				
		next
			
		s = s + ",code=" + hex(cmd.code)

		if debug >= 2

			s = s + ",id=" + str(cmd.idx)
			s = s + ",grp=" + str(cmd.grp)
			s = s + ",root=" + str(cmd.root)
			s = s + ",x=" + str(cmd.x)
			s = s + ",y=" + str(cmd.y)

		endif
					
		s = s + "]"

	else
		
		s = ""
		
	endif
	
endfunction s

//-----------------------------------------------------
// Print all cmds for a thing.
//
function maPrintCmds(thing as integer)

	local i as integer
	local s as string
	local cmd as integer
	local pen as CodePen

	s = "Code list for thing=" + str(thing) + ":" + chr(10)
	
	for i = 0 to ma.things[thing].cmds.length

		cmd = ma.things[thing].cmds[i]

		// Top level with no previous link.
		if ma.cmds[cmd].root
			
			pen.x = cdGetCmdPosX(cmd)
			pen.y = cdGetCmdPosY(cmd)
			pen.indent = 0

		endif

		//if ma.cmds[cmd].openCmd or ma.cmds[cmd].elseCmd
		//	dec pen.indent
		//endif

		if maIsCloseCode(ma.cmds[cmd].code) or maIsElseCode(ma.cmds[cmd].code)
			dec pen.indent
		endif

		s = s + spaces(pen.indent * 2)
		s = s + "idx=" + str(i) + ",cmd=" + str(cmd) + ","
		s = s + maPrintCmd(cmd, 3)
		s = s + chr(10)
		
		//if ma.cmds[cmd].closecmd // Points to a close cmd, so this is a open cmd.
		if maIsOpenCode(ma.cmds[cmd].code)
			inc pen.indent
		endif
		
	next
	
endfunction s

//-----------------------------------------------------
// Print a var.
//
function maPrintVar(var as integer)

	local s as string
	
	s = maPrintVarPtr(ma.vars[var])
	
endfunction s

//-----------------------------------------------------
// Print a var by ptr.
//
function maPrintVarPtr(var ref as Var)

	local s as String
	local i as integer
	
	s = "["
	s = s + "idx=" + str(var.idx)
	
	if var.typ = VAR_TYPE_VALUE
		
		s = s + ", typ=value"
		s = s + ", value='" + var.value + "'"
		
	elseif var.typ = VAR_TYPE_LIST
		
		s = s + ", typ=list"
		s = s + ", list=["

		for i = 0 to var.list.length
			
			if i > 0 then s = s + ","
			//s = s + cdPrintVarPtr(ma.vars[var.list[i]])
			s = s + str(i + 1) + " : " + var.list[i].value
			
		next

		s = s + "]"
		
	elseif var.typ = VAR_TYPE_OBJECT
		
		s = s + ", typ=obj"
		s = s + ", fields=["

		for i = 0 to var.list.length
			
			if i > 0 then s = s + ","
			//s = s + cdPrintVarPtr(ma.vars[var.list[i]])
			s = s + var.list[i].name + " : " + var.list[i].value
			
		next

		s = s + "]"
		
	endif

	
	s = s + "]"
	
endfunction s

//-----------------------------------------------------
// Print a cmd part
//
function maPrintPart(part ref as Part, debug as integer)

	local s as String

	if debug < 4
		if part.typ = PART_CMD
			s = maPrintCmd(val(part.info), debug)
		elseif part.typ = PART_STR
			s = part.info
		else
			s = "[" + part.info + "]"
		endif
	else
		s = "[typ=" + maPrintPartType(part) + ",info=" + part.info + "]"
	endif
	
endfunction s

//-----------------------------------------------------
// Print a cmd part
//
function maPrintPartType(part ref as Part)

	local ret as string
	
	if part.typ = PART_CMD
		ret = "CMD"
	elseif part.typ = PART_TXT
		ret = "TXT"
	elseif part.typ = PART_INT
		ret = "INT"
	elseif part.typ = PART_FLOAT
		ret = "FLOAT"
	elseif part.typ = PART_BOOL
		ret = "BOOL"
	elseif part.typ = PART_COL
		ret = "COL"
	elseif part.typ = PART_STR
		ret = "STR"
	elseif part.typ = PART_IMG
		ret = "IMG"
	elseif part.typ = PART_SPRITE
		ret = "SPRITE"
	elseif part.typ = PART_SPRITE_ICON
		ret = "SPRITEICON"
	elseif part.typ = PART_FRAME
		ret = "FRAME"
	elseif part.typ = PART_FRAME_ICON
		ret = "FRAMEICON"
	elseif part.typ = PART_APP_ICON
		ret = "APPICON"
	elseif part.typ = PART_APP
		ret = "APP"
	elseif part.typ = PART_VALUE
		ret = "VALUE"
	elseif part.typ = PART_LIST
		ret = "LIST"
	elseif part.typ = PART_VAR_NAME
		ret = "VARNAME"
	elseif part.typ = PART_SOUND
		ret = "SOUND"
	elseif part.typ = PART_SOUND_NAME
		ret = "SOUNDNAME"
	elseif part.typ = PART_VIDEO
		ret = "VIDEO"
	elseif part.typ = PART_VIDEO_NAME
		ret = "VIDEONAME"
	elseif part.typ = PART_OBJ
		ret = "OBJ"
	else
		ret = "UNKNOWN"
	endif
		
endfunction ret

//-----------------------------------------------------
//
function maIsOpenCode(code as integer)

	local ret as integer
	local cmd as integer
	
	if code = CODE_FLOW_IF or code = CODE_FLOW_IF_ELSE or code = CODE_FLOW_REPEAT_FOREVER or code = CODE_FLOW_REPEAT_TIMES or code = CODE_FLOW_REPEAT_UNTIL or code = CODE_FLOW_REPEAT_WHILE
		ret = true
	elseif code && (CMD_OPEN << 16) and not (code && (CMD_CLOSE << 16))
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
//
function maIsElseCode(code as integer)

	local ret as integer
	local cmd as integer
	
	if code = CODE_FLOW_ELSE
		ret = true
	elseif code && (CMD_OPEN << 16) and code && (CMD_CLOSE << 16)
		ret = true
	else
		ret = false
	endif

endfunction ret

//-----------------------------------------------------
//
function maIsCloseCode(code as integer)

	local ret as integer
	local cmd as integer
	
	if code = CODE_FLOW_ENDIF or code = CODE_FLOW_REPEAT_END 
		ret = true
	//elseif code && (CMD_CLOSE << 16)
	elseif code && (CMD_CLOSE << 16) and not (code && (CMD_OPEN << 16))
		ret = true
	else
		ret = false
	endif
	
endfunction ret

//-----------------------------------------------------
// Called when any button is pressed.
//
function OnButtonAction(butId as integer, obj as integer)

	local thingId as string
	local appId as string 
	
	if butId = BUT_DESIGN_BACK

		maHide()
		ma.view = VIEW_CODER
		maShow()

	elseif butId = BUT_DESIGN_RUN

		if AGK_BUILD
			
			agAgkBuild(de.appIdx)
			
		else

			maHide()
			ma.prevView = ma.view
			ma.view = VIEW_RUNNER
			ruSetApp(de.appIdx)
			maShow()
			
		endif

	elseif butId = BUT_CODER_RUN
	
		if AGK_BUILD
			
			agAgkBuild(cd.appIdx)
			
		else
			
			maHide()
			ma.prevView = ma.view
			ma.view = VIEW_RUNNER
			ruSetApp(cd.appIdx)
			maShow()
			
		endif
		
	elseif butId = BUT_CODER_EDIT_IMAGE

		maHide()
		ma.prevView = ma.view
		ma.view = VIEW_EDITOR
		edSetImage(obj, true)
		maShow()

	elseif butId = BUT_CODER_VIEW_IMAGE

		maHide()
		ma.prevView = ma.view
		ma.view = VIEW_EDITOR
		edSetImage(obj, false)
		maShow()

	elseif butId = BUT_EDITOR_SAVE
		
		maHide()
		ma.prevView = ma.view
		ma.view = VIEW_CODER
		cdButtonAction(butId, obj)
		maShow()

	elseif butId = BUT_EDITOR_CANCEL
		
		maHide()
		ma.prevView = ma.view
		ma.view = VIEW_CODER
		maShow()

	elseif butId = BUT_DESIGN_VARBG_COL

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TITLE_FONT_SIZE
		
		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TITLE_FONT
		
		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TEXT_FONT_SIZE
		
		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TEXT_FONT
		
		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TITLE_POS
		
		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TITLE_COL

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_BOX_COL

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TEXT_COL

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TITLE_ALIGN

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TEXT_COL

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_TEXT_ALIGN

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_BG_COLOR
		
		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_CODER_DESIGN

		maHide()
		ma.view = VIEW_DESIGNER
		deSetApp(cd.appIdx)
		deSetThing(obj)
		maShow()

	elseif butId = BUT_RUNNER_BACK

		maHide()
		//ma.view = VIEW_CODER
		ma.view = ma.prevView
		maShow()

	elseif butId = BUT_CODER_EDITOR_POS

		if ma.view = VIEW_EDITOR
			edCallbackFromCoder(butId, 0)
		endif

		elseif butId = BUT_DESIGN_MENU_POS

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, 0)
		endif

	elseif butId = BUT_RUNNER_MENU_POS

		if ma.view = VIEW_RUNNER
			ruCallbackFromCoder(butId)
		endif

	elseif butId = BUT_RUNNER_AUTO_RUN

		if ma.view = VIEW_RUNNER
			ruCallbackFromCoder(butId)
		endif

	elseif butId = BUT_DESIGN_GRID_SNAP

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, 0)
		endif

	elseif butId = BUT_DESIGN_NAMES

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, 0)
		endif

	elseif butId = BUT_DESIGN_GRID_COLS

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, 0)
		endif

	elseif butId = BUT_DESIGN_GRID_WIDTH

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, 0)
		endif

	elseif butId = BUT_DESIGN_GRID_ROWS

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, 0)
		endif

	elseif butId = BUT_DESIGN_GRID_HEIGHT

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, 0)
		endif

	elseif butId = BUT_DESIGN_SCREEN

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, obj)
		endif

	elseif butId = BUT_DESIGN_CANCEL_EDIT

		if ma.view = VIEW_DESIGNER
			deCallbackFromCoder(butId, 0)
		endif

	elseif butId = BUT_TITLE_EXIT

		ld.set.titleOn = false
		ldSaveSettingS()
		
		maHide()
		ma.view = VIEW_CODER
		maShow()

	elseif butId = BUT_TITLE_SHOW
		
		maHide()
		ma.view = VIEW_TITLE
		maShow()

	elseif butId = BUT_EDITOR_COLOR or butId = BUT_EDITOR_LINE_SIZE or butId = BUT_EDITOR_TEXT_SIZE or butId = BUT_EDITOR_GRID_COLS or butId = BUT_EDITOR_GRID_ROWS or butId = BUT_EDITOR_GRID_WIDTH or butId = BUT_EDITOR_GRID_HEIGHT or butId = BUT_EDITOR_CANCEL_EDIT or butId = BUT_EDITOR_TEXT_EDIT or butId = BUT_EDITOR_POLY_SIDES or butId = BUT_EDITOR_IMAGE or butId = BUT_EDITOR_RESIZE or butId = BUT_EDITOR_TEXT_FONT

		if ma.view = VIEW_EDITOR
			edCallbackFromCoder(butId, obj)
		endif

	endif 
		
endfunction

//-----------------------------------------------------
//
function maUpdate(delta as float)

	inUpdate()

	if ma.view = VIEW_CODER
		cdUpdate(delta)
	elseif ma.view = VIEW_RUNNER
		ruUpdate(delta)
	elseif ma.view = VIEW_DESIGNER
		deUpdate(delta)
	elseif ma.view = VIEW_EDITOR
		edUpdate(delta)
	elseif ma.view = VIEW_TITLE
		tiUpdate(delta)
	endif
	
endfunction

//-----------------------------------------------------
//
function AddAngle(obj as integer, angle#)

	SetAngle(obj, angle#+GetAngle(obj))

endfunction
	
//-----------------------------------------------------
//
function AddPos(obj as integer, xPos#, yPos#)

	xPos# = xPos# + GetPosX(obj)
	yPos# = yPos# + GetPosY(obj)
	SetPos(obj,xpos#,ypos#)
	
endfunction
//-----------------------------------------------------
//
function AddPosX(obj as integer, xPos#)
	
	xPos# = xPos# + GetPosX(obj)
	SetPosX(obj,xpos#)
	
endfunction

//-----------------------------------------------------
//
function AddPosY(obj as integer, yPos#)
	
	yPos# = yPos# + GetPosY(obj)
	SetPosY(obj,ypos#)
	
endfunction

//-----------------------------------------------------
//
function GetAlpha(obj as integer)
	
	local retVal as integer
	retVal = GetSpriteColorAlpha(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function GetAngle(obj as integer)
	
	local retVal as float
	retVal = GetSpriteAngle(obj)
	
endfunction retVal

//-----------------------------------------------------
function GetHeight(obj as integer)
	
	local retVal as integer
	retVal = GetSpriteHeight(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function GetPosX(obj as integer)
	
	local retVal as float
	retVal = GetSpriteXByOffset(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function GetPosY(obj as integer)
	
	local retVal as float
	retVal = GetSpriteYByOffset(obj)
	
endfunction retVal

//-----------------------------------------------------
function GetScaleX(obj as integer)
	
	local retVal as float
	retVal = GetSpriteScaleX(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function GetScaleY(obj as integer)
	
	local retVal as float
	retVal = GetSpriteScaleY(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function GetVisible(obj as integer)
	
	local retVal as integer
	retVal = GetSpriteVisible(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function GetWidth(obj as integer)
	
	local retVal as integer
	retVal = GetSpriteWidth(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function SetAlpha(obj as integer, alpha)
	
	SetSpriteColorAlpha(obj, alpha)
	
endfunction

//-----------------------------------------------------
//
function SetAngle(obj as integer, angle#)
	
	SetSpriteAngle(obj, angle#)
	
endfunction

//-----------------------------------------------------
//
function SetPos(obj as integer, xpos#, ypos#)
	
	SetSpritePositionbyOffset(obj,xpos#,ypos#)
	
endfunction

//-----------------------------------------------------
//
function SetPosX(obj as integer, xpos#)
	
	SetSpritePositionByOffset(obj,xpos#,GetSpriteYByOffset(obj))
	
endfunction

//-----------------------------------------------------
//
function SetPosY(obj as integer, ypos#)
	
	SetSpritePositionByOffset(obj,GetSpriteXByOffset(obj), ypos#)
	
endfunction

//-----------------------------------------------------
function SetScale(obj as integer, scale#)
	
	SetSpriteScaleByOffset(obj, scale#, scale#)

endfunction

//-----------------------------------------------------
// PS
function SetScaleXY(obj as integer, scaleX#, scaleY#)
	
	SetSpriteScaleByOffset(obj, scaleX#, scaleY#)

endfunction

//-----------------------------------------------------
// PS
function SetScaleX(obj as integer, scaleX#)
	
	SetSpriteScaleByOffset(obj, scaleX#, GetSpriteScaleY(obj))

endfunction

//-----------------------------------------------------
// PS
function SetScaleY(obj as integer, scaleY#)
	
	SetSpriteScaleByOffset(obj, GetSpriteScaleX(obj), scaleY#)

endfunction

//-----------------------------------------------------
//
function RemoveObject(obj as integer)

/*	
	if GetTween(obj) > 0 
		StopTweenSprite(ftObjList[obj].tweenID,ftObjList[obj].spr)
		DeleteTween(ftObjList[obj].tweenID)
	endif
*/

	DeleteSprite(obj)

endfunction

//-----------------------------------------------------
//
function CreateObject(img as integer)

	local retval as integer

		retval = CreateSprite(img)

endfunction retval

//-----------------------------------------------------
//
function SetVisible(obj as integer, flag)
	
	SetSpriteVisible(obj,flag)
	
endfunction

//-----------------------------------------------------
//
function SetDepth(obj as integer, depth)

if not obj
	obj = obj
endif
	
	SetSpriteDepth(obj,depth)
	
endfunction

//-----------------------------------------------------
//
function GetDepth(obj as integer)
	
	local retVal as integer
	retVal = GetSpriteDepth(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function GetSprite(obj as integer)
	
endfunction obj
	
//-----------------------------------------------------
//
function SetColGroup(obj as integer, group as integer)
	
	SetSpriteGroup(obj, group) 
	
endfunction

//-----------------------------------------------------
//
function GetColGroup(obj as integer)
	
	local retVal as integer
	retVal = GetSpriteGroup(obj)
	
endfunction retVal

//-----------------------------------------------------
//
function SetColor(obj as integer, red, green, blue)
	
	SetSpriteColor(obj,red, green, blue, GetSpriteColorAlpha(obj))
	
endfunction

//-----------------------------------------------------
function SetColType(obj as integer, typ as integer)
	
	SetSpriteShape(obj, typ)
	
endfunction

//-----------------------------------------------------
// Load a video based the videoIdx.
//
function maLoadVideo(appIdx as integer, videoIdx as integer, file as string)

	local dx as float
	local dy as float
	local appVideoIdx as integer
	//local appVideoId as string
	//local videoIdx as integer
	//local file as string

	if file = ""
		file =  ma.apps[appIdx].folder + LD_VIDEO_DIR + "/" + ma.videos[videoIdx].file
	endif

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
		
endfunction ma.videos[videoIdx].loaded

//-----------------------------------------------------
//
function maUnloadVideo(videoIdx as integer)
	
	DeleteVideo()
	
	ma.videos[videoIdx].loaded = 0
	ma.videos[videoIdx].x = 0
	ma.videos[videoIdx].y = 0
	ma.videos[videoIdx].w = 0
	ma.videos[videoIdx].h = 0
	ma.videos[videoIdx].duration = 0
	ma.videos[videoIdx].img = 0

endfunction

//-----------------------------------------------------
// Show interactive help, that guides the user through the steps.
// Execute a set of tasks as below. If a task has been done, it is skipped. 
// It is safe to rerun the task list, only the task that hasn't been done is executed.
//
function maShowInterHelp(howTo as integer)

	maInitInterHelp(howTo)	
	maRunInterHelp()
	
endfunction

//-----------------------------------------------------
// Start a new inter task.
//
function maInitInterHelp(howTo as integer)
	
	maHideInterHelp()
	
	ma.helpInter.howTo = 0 // How to not set yet.
	ma.helpInter.taskIdx = 0 // Start of task list.
	ma.helpInter.sel = 0 // No selection.
	ma.helpInter.tasks.length = -1
	ma.helpInter.animTaskIdx = -1 // No anim yet.

	if howTo = MA_HOWTO_CREATE_PROJECT1 or howTo = MA_HOWTO_CREATE_PROJECT2
	
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask(MA_HELP_ITEM_PROJECTS_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_LIBRARY_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_PROJECT_LIBRARY_ITEM, 0, MA_HELP_ACT_DRAG)
		//maAddHelpTask(CD_MODE_DRAG_ITEM, 0, MA_HELP_ACT_RELEASE)
		//maAddHelpTask(CD_MODE_WAIT_ITEM, 0, MA_HELP_ACT_HOLD)
		
	elseif howTo = MA_HOWTO_OPEN_PROJECT
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask(MA_HELP_ITEM_PROJECTS_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_LIBRARY_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_MY_PROJECTS_FOLDER, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask2(MA_HELP_ITEM_PROJECT_LIBRARY_ITEM, 2, MA_HELP_ACT_DRAG || MA_HELP_ACT_END, MA_HOWTO_CREATE_PROJECT2)
		//maAddHelpTask(CD_MODE_DRAG_ITEM, 0, MA_HELP_ACT_RELEASE)
		//maAddHelpTask(CD_MODE_WAIT_ITEM, 0, MA_HELP_ACT_HOLD)

	elseif howTo = MA_HOWTO_RENAME_PROJECT
	
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask(MA_HELP_ITEM_PROJECTS_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_PROJECT_OPEN, 0, MA_HELP_ACT_PRESS || MA_HELP_ACT_END)

	elseif howTo = MA_HOWTO_ADD_SPRITE
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask2(MA_HELP_ITEM_THINGS_TAB, 0, MA_HELP_ACT_PRESS, MA_HOWTO_CREATE_SPRITE_NO_PROJECT)
		maAddHelpTask(MA_HELP_ITEM_LIBRARY_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask2(MA_HELP_ITEM_SPRITE_LIBRARY_ITEM, 1, MA_HELP_ACT_DRAG, MA_HOWTO_CREATE_SPRITE2)

	elseif howTo = MA_HOWTO_ADD_FRAME
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask2(MA_HELP_ITEM_THINGS_TAB, 0, MA_HELP_ACT_PRESS, MA_HOWTO_CREATE_SPRITE_NO_PROJECT)
		maAddHelpTask(MA_HELP_ITEM_LIBRARY_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask2(MA_HELP_ITEM_SPRITE_EXISTS, 0, MA_HELP_ACT_CHECK, MA_HOWTO_CREATE_SPRITE2)
		maAddHelpTask2(MA_HELP_ITEM_SPRITE_LIBRARY_ITEM2, 1, MA_HELP_ACT_DRAG, MA_HOWTO_ADD_FRAME2)
		
	elseif howTo = MA_HOWTO_ADD_FRAME2
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask2(MA_HELP_ITEM_THINGS_TAB, 0, MA_HELP_ACT_PRESS, MA_HOWTO_CREATE_SPRITE_NO_PROJECT)
		maAddHelpTask(MA_HELP_ITEM_LIBRARY_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask2(MA_HELP_ITEM_SPRITE_EXISTS, 0, MA_HELP_ACT_CHECK, MA_HOWTO_CREATE_SPRITE2)
		maAddHelpTask2(MA_HELP_ITEM_SPRITE_LIBRARY_ITEM2, 0, MA_HELP_ACT_DRAG, MA_HOWTO_ADD_FRAME2)

	elseif howTo = MA_HOWTO_CREATE_SPRITE or howTo = MA_HOWTO_CREATE_SPRITE2
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask2(MA_HELP_ITEM_THINGS_TAB, 0, MA_HELP_ACT_PRESS, MA_HOWTO_CREATE_SPRITE_NO_PROJECT)
		maAddHelpTask(MA_HELP_ITEM_LIBRARY_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_SPRITE_LIBRARY_ITEM, 0, MA_HELP_ACT_DRAG)

	elseif howTo = MA_HOWTO_CREATE_SPRITE_NO_PROJECT

		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask(MA_HELP_ITEM_THINGS_TAB_INACTIVE, 0, MA_HELP_ACT_PRESS)
	
	elseif howTo = MA_HOWTO_ADD_CMD_NO_SPRITE
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask(MA_HELP_ITEM_COMMANDS_TAB_INACTIVE, 0, MA_HELP_ACT_PRESS)

	elseif howTo = MA_HOWTO_ADD_CMD
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask2(MA_HELP_ITEM_COMMANDS_TAB, 0, MA_HELP_ACT_PRESS, MA_HOWTO_ADD_CMD_NO_SPRITE)
		maAddHelpTask(MA_HELP_ITEM_CODE_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_SEL_CMD, CODE_EVENT_RUN, MA_HELP_ACT_DRAG)
		maAddHelpTask3(MA_HELP_ITEM_SEL_CMD, CODE_MOVE_SET_X, MA_HELP_ACT_DRAG, 0, CODE_EVENT_RUN)
		
	elseif howTo = MA_HOWTO_EDIT_CMD
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask2(MA_HELP_ITEM_COMMANDS_TAB, 0, MA_HELP_ACT_PRESS, MA_HOWTO_ADD_CMD_NO_SPRITE)
		maAddHelpTask(MA_HELP_ITEM_CODE_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_SEL_CMD, CODE_EVENT_RUN, MA_HELP_ACT_DRAG)
		maAddHelpTask3(MA_HELP_ITEM_SEL_CMD, CODE_MOVE_SET_X, MA_HELP_ACT_DRAG, 0, CODE_EVENT_RUN)
		maAddHelpTask2(MA_HELP_ITEM_CODE_CMD_PART, CODE_MOVE_SET_X, MA_HELP_ACT_PRESS, 1)

	elseif howTo = MA_HOWTO_ADD_CMD_VALUE
		
		ma.helpInter.howTo = howTo // Now valid.
		maAddHelpTask2(MA_HELP_ITEM_COMMANDS_TAB, 0, MA_HELP_ACT_PRESS, MA_HOWTO_ADD_CMD_NO_SPRITE)
		maAddHelpTask(MA_HELP_ITEM_CODE_TAB, 0, MA_HELP_ACT_PRESS)
		maAddHelpTask(MA_HELP_ITEM_SEL_CMD, CODE_EVENT_RUN, MA_HELP_ACT_DRAG)
		maAddHelpTask3(MA_HELP_ITEM_SEL_CMD, CODE_MOVE_SET_X, MA_HELP_ACT_DRAG, 0, CODE_EVENT_RUN)
		maAddHelpTask3(MA_HELP_ITEM_SEL_CMD, CODE_CALC_RANDOM_X_POS, MA_HELP_ACT_DRAG, 1, CODE_MOVE_SET_X)

	endif

endfunction

//-----------------------------------------------------
// Add an interaction task.
//
function maAddHelpTask(item as integer, idx as integer, act as integer)

	maAddHelpTask2(item, idx, act, 0)
	
endfunction

//-----------------------------------------------------
// Add an interaction task with switch.
//
function maAddHelpTask2(item as integer, idx as integer, act as integer, switch as integer)
	
	maAddHelpTask3(item, idx, act, switch, 0)
	
endfunction

//-----------------------------------------------------
// Add an interaction task with codeIdx, i.e. the index of the codes to snap under.
//
function maAddHelpTask3(item as integer, idx as integer, act as integer, switch as integer, prevCode as integer)

	local task as HelpTask

	task.item = item
	task.idx = idx
	task.act = act
	task.switch = switch
	task.prevCode = prevCode
	task.doEnd = false

	if task.act && MA_HELP_ACT_END
		
		task.doEnd = true
		task.act = !(!task.act || MA_HELP_ACT_END) // Remove it.
	
	endif
	
	ma.helpInter.tasks.insert(task)

endfunction

//-----------------------------------------------------
// Run the next inter task until it hits the end, or user cancels.
//
function maRunInterHelp()
	
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
	local hd as HelpData
	
	if not ma.helpInter.howTo
		exitfunction
	endif
		
	//if ma.helpInter.tasks[ma.helpInter.taskIdx].doEnd
		
	//	maHideInterHelp() // All done.
	//	exitfunction
		
	//endif
				
	taskIdx = 0 // ma.helpInter.taskIdx // Restart, make sure all actions are taken.
	
	while taskIdx <= ma.helpInter.tasks.length

		hd.taskIdx = taskIdx
		hd.switch = 0
		hd.ret = false
		
		if ma.view = VIEW_CODER		
			cdRunInterHelp(hd)			
		endif

		if hd.ret
			exit
		else			
			//taskIdx = ma.helpInter.tasks.length	
			inc taskIdx
		endif		
		
	endwhile
	
	if taskIdx <= ma.helpInter.tasks.length
		ma.helpInter.taskIdx = taskIdx	 // Save the curr task.
	else 
		maHideInterHelp() // All done.
	endif
	
	if hd.switch
		maShowInterHelp(hd.switch)
	endif
		
endfunction

//-----------------------------------------------------
// Check if the help close icon has been pressed.
//
function maInterHelpClosed(x as float, y as float)

	local ret as integer
	local i as integer
	
	ret = false 
	
	for i = 0 to ma.helpInter.tasks.length		
		if ma.helpInter.tasks[i].anims.length > -1
			if coGetSpriteHitTest3(ma.helpInter.tasks[i].anims[0].tip.cross, x, y, co.bs / 4, 0, co.bs / 4, 0)
				ret = true
				exit
			endif
		endif		
	next
	
endfunction ret

//-----------------------------------------------------
// Process a user input to see if they actioned a help request.
//
function maProcessInterHelpPressed(mode as integer, x as float, y as float)
	
	local i as integer

	for i = 0 to ma.helpInter.tasks.length

		if ma.helpInter.tasks[i].anims.length > -1
				
			maClearHelpAnims(i)			
			exit
				
		endif
		
	next
	
endfunction

//-----------------------------------------------------
// Process a user input to see if they actioned a help request.
//
function maProcessInterHelpReleased(mode as integer)

	if ma.helpInter.tasks[ma.helpInter.taskIdx].doEnd		
		maHideInterHelp() // All done.
	else 		
		maRunInterHelp()	
	endif
	
endfunction

//-----------------------------------------------------
// Show a drag animation from the sprite to the dest.
// item is the sprite to associate the press with.
// msg is what to show in the message box.
// dir is side of the ptr, i.e. DIR_W or DIR_E, and the position of the test, i.e. DIR_N or DIR_S
// src sprite for the start of the line
// dest sprite for the end of the line
//
function maSetHelpPress(taskIdx as integer, item as integer, msg as string, dir as integer, src as integer, dest as integer)
	
	local anim as HelpAnim
	local gapx as float
	local gapy as float
	local pt as Point
	local div as integer
	local idx as integer
	local i as integer
	
	gapx = getspritewidth(item) / 4
	gapy = GetSpriteHeight(item) / 4

	anim.dir = dir // Need to save this for later draw.
	
	if dir < -1
		
		dir = -dir
		gapx = 0
		gapy = 0

	endif
	
	maClearHelpAnims(taskIdx)
	
	anim.item = item
	anim.msg = msg
	anim.src = src
	anim.dest = dest
	anim.linePtIdx = -1
	anim.linePts.length = -1
	anim.ang = 0
	
	anim.spr = CreateSprite(ma.helpInter.ptrImg)

	if anim.item
		
		if dir && DIR_EE
			gapx = GetSpriteWidth(anim.item) / 2
		elseif dir && DIR_WW
			gapx = -GetSpriteWidth(anim.item) / 2
		endif
	
		if dir && DIR_SS
			gapy = GetSpriteHeight(anim.item) / 2
		elseif dir && DIR_NN
			gapy = -GetSpriteHeight(anim.item) / 2
		endif

	endif

	dir = !(!dir || (DIR_NN || DIR_SS || DIR_EE || DIR_WW))
		
	if dir && DIR_E
		
		SetSpriteFlip(anim.spr, true, false)
		SetSpritePositionByOffset(anim.spr, GetSpriteXByOffset(anim.item) + gapx, GetSpriteYByOffset(anim.item) + gapy)

	else
		
		SetSpritePositionByOffset(anim.spr, GetSpriteXByOffset(anim.item) - gapx, GetSpriteYByOffset(anim.item) + gapy)
	
	endif

	SetSpriteDepth(anim.spr, FRONT_DEPTH)
	
	guiCreateTip(anim.tip, true)
	guiSetTipClose(anim.tip, co.grey[5])
	guiShowTip(anim.tip, anim.spr, anim.msg, TIP_HELP, dir)

	if anim.src and anim.dest	

		// Create a guide line.			
		if dir && DIR_E
			coDrawSprLine(anim.linesprs, GetSpriteXByOffset(anim.src) - gapx, GetSpriteYByOffset(anim.src) + gapy, GetSpriteXByOffset(anim.dest), GetSpriteYByOffset(anim.dest), co.black, 1, true)
		else 
			coDrawSprLine(anim.linesprs, GetSpriteXByOffset(anim.src) + gapx, GetSpriteYByOffset(anim.src) + gapy, GetSpriteXByOffset(anim.dest), GetSpriteYByOffset(anim.dest), co.black, 1, true)
		endif	

		//anim.dir = dir
		anim.ang = atanfull(GetSpriteXByOffset(anim.dest) - (GetSpriteXByOffset(anim.src) - gapx), GetSpriteYByOffset(anim.dest) - (GetSpriteYByOffset(anim.src) + gapy))

		// Add last point.
		pt.x = GetSpriteXByOffset(anim.dest)
		pt.y = GetSpriteYByOffset(anim.dest)
		anim.linepts.insert(pt)

		anim.lineptidx = 0
		
		maClearAnimLine(anim)
		maDrawAnimLine(anim)
	
	endif

	anim.timer = CD_ANIM_TIMER
	anim.alpha = 250
	anim.delta = -10
	anim.min = 0
	anim.max = 250

	ma.helpInter.tasks[taskIdx].anims.insert(anim)

	ma.helpInter.animtaskIdx = taskIdx
	
endfunction

//-----------------------------------------------------
// Draw the anim line.
//
function maClearAnimLine(anim ref as HelpAnim)

	local i as integer
	
	// Clear the previous line.
	for i = 0 to anim.linesprs.length
		deletesprite(anim.linesprs[i])
	next 
	
	anim.linesprs.length = -1
	
endfunction

//-----------------------------------------------------
// Draw the anim line.
//
function maDrawAnimLine(anim ref as HelpAnim)

	local i as integer
	local ang as float
	local x0 as float
	local y0 as float
	local x1 as float
	local y1 as float
	local arr as float
	local gapx as float
	local gapy as float
	local size as integer
	local dx as float
	local dy as float
	local dir as integer

	size = 20
	arr = size * 2
	gapx = GetSpriteWidth(anim.src) / 4
	gapy = GetSpriteHeight(anim.src) / 4
	dir = anim.dir
	
	if dir < -1
		
		gapx = 0
		gapy = 0
		dir = -dir
	
	endif
	
	maClearAnimLine(anim)
	
	if anim.linePtIdx = -1
		exitfunction
	endif
	
	dx = anim.linePts[anim.linePtIdx].x
	dy = anim.linePts[anim.linePtIdx].y
	
	inc anim.linePtIdx
	if anim.linePtIdx > anim.linePts.length
		anim.linePtIdx = 0
	endif

	// Black outer line.			
	if dir && DIR_E
		maDrawSprLine(anim.linesprs, GetSpriteXByOffset(anim.src) - gapx, GetSpriteYByOffset(anim.src) + gapy, dx, dy, co.black, size, true)
	else 
		maDrawSprLine(anim.linesprs, GetSpriteXByOffset(anim.src) + gapx, GetSpriteYByOffset(anim.src) + gapy, dx, dy, co.black, size, true)
	endif	
	
	// Arrow head.		
	//ang = atanfull(GetSpriteXByOffset(anim.dest) - (GetSpriteXByOffset(anim.item) - gap), GetSpriteYByOffset(anim.dest) - (GetSpriteYByOffset(anim.item) + gap))
	ang = anim.ang - 180
	ang = ang - 45
	x0 = dx + cos(ang) * arr
	y0 = dy + sin(ang) * arr
	maDrawSprLine(anim.linesprs, dx, dy, x0, y0, co.black, size, true)

	ang = ang - 90
	x1 = dx + cos(ang) * arr
	y1 = dy + sin(ang) * arr
	maDrawSprLine(anim.linesprs, dx, dy, x1, y1, co.black, size, true)

	// White line overlay.
	if dir && DIR_E
		maDrawSprLine(anim.linesprs, GetSpriteXByOffset(anim.src) - gapx, GetSpriteYByOffset(anim.src) + gapy, dx, dy, co.white, size / 2, false)
	else 
		maDrawSprLine(anim.linesprs, GetSpriteXByOffset(anim.src) + gapx, GetSpriteYByOffset(anim.src) + gapy, dx, dy, co.white, size / 2, false)
	endif	

	maDrawSprLine(anim.linesprs, dx, dy, x0, y0, co.white, size / 2, false)
	maDrawSprLine(anim.linesprs, dx, dy, x1, y1, co.white, size / 2, false)

endfunction

//-----------------------------------------------------
// Draw line wrapper so can switch b/n modes.
//
function maDrawSprLine(sprs ref as integer[], x0 as float, y0 as float, x1 as float, y1 as float, col as integer, size as integer, smooth as integer)
	
	coDrawSprLine(sprs, x0, y0, x1, y1, col, size, smooth)
	
endfunction

//-----------------------------------------------------
// Hide the inter help.
//
function maHideInterHelp()
	
	local i as integer
	
	ma.helpInter.howTo = 0 // How to not set yet.
	ma.helpInter.taskIdx = 0 // Start of task list.
	ma.helpInter.sel = 0 // No selection.

	for i = 0 to ma.helpInter.tasks.length
		maClearHelpAnims(i)
	next

	ma.helpInter.tasks.length = -1
	ma.helpInter.animtaskIdx = -1

endfunction

//-----------------------------------------------------
// Clear all help animations.
//
function maClearHelpAnims(taskIdx as integer)

	local i as integer
	
	for i = 0 to ma.helpInter.tasks[taskIdx].anims.length
		maClearHelpAnim(ma.helpInter.tasks[taskIdx].anims[i])
	next 

	ma.helpInter.tasks[taskIdx].anims.length = -1

	if taskIdx = ma.helpInter.animtaskIdx
		ma.helpInter.animtaskIdx = -1
	endif
	
endfunction

//-----------------------------------------------------
// Clear an anim.
//
function maClearHelpAnim(anim ref as HelpAnim)
	
	local i as integer
	
	if anim.spr
		
		deletesprite(anim.spr)
		anim.spr = 0
		
	endif
	
	if anim.tip.text2
		guiDeleteTip(anim.tip)
	endif
	
	if anim.lineSprs.length > -1
		
		for i = 0 to anim.lineSprs.length
			deletesprite(anim.lineSprs[i])
		next
		
		anim.lineSprs.length = -1
		
	endif
	
	anim.dest = 0
	anim.timer = 0
	anim.alpha = 250
	anim.delta = -10
	anim.min = 0
	anim.max = 250

endfunction

//-----------------------------------------------------
// Timer tick.
//
function maOnObjTimer(obj as integer)

	//if obj = 0 then exitfunction // 0=junk

	local vis as integer

	if obj = ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].spr

		setspritecoloralpha(ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].spr, ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].alpha)
		
		ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].alpha = ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].alpha + ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].delta

		if ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].alpha <= ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].min 

			ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].alpha = ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].min
			ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].delta = -ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].delta

		elseif ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].alpha >= ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].max

			ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].alpha = ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].max
			ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].delta = -ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].delta

		endif
				
		if ma.helpInter.howTo and ma.helpInter.animtaskIdx > -1
			ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].timer = CD_ANIM_TIMER
		endif		
				
	endif
	
endfunction

//-----------------------------------------------------
// Check if the help inter should be closed.
//
function maCheckHelpInterPress(mode as integer, x as float, y as float)
	
	local doExit as integer
	
	doExit = false
	
	if maInterHelpClosed(x, y)
		
		maHideInterHelp()			
		//exitfunction
		doExit = true
		
	else 		
			
		maProcessInterHelpPressed(mode, x, y)		
		// Don't exit, we still want the press to activate below.
			
	endif
	
endfunction doExit

//-----------------------------------------------------
// Update the help anim.
//
function maUpdateHelpInterAnim(delta as float)

	if ma.helpInter.animtaskIdx > -1
								
		if ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].timer > 0.0
		 
			dec ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].timer, delta
			
			if ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].timer <= 0.0
				maOnObjTimer(ma.helpInter.tasks[ma.helpInter.animtaskIdx].anims[0].spr)
			endif
			
		endif
		
	endif
	
endfunction

//
//
//
