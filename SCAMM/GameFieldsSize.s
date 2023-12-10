; Game Structure - Size

GAME_STRUCTURE_SIZE	.equ	384	; 
GAME_ENGINE_VERSION_SIZE	.equ	4	; Required Engine Version
GAME_NAME_SIZE	.equ	2	; Pointer to Name of the Game
GAME_ELAPSED_TICKS_SIZE	.equ	4	; Ticks (interrupts) since the beginning of game
GAME_ELAPSED_TIME_SIZE	.equ	4	; Time (in seconds) since the beginning of game
GAME_MAX_SCORE_SIZE	.equ	2	; Max Score
GAME_SCORE_SIZE	.equ	2	; Score
GAME_EGO_SIZE	.equ	2	; Pointer to the Ego object
GAME_EGOS_PREVIOUS_ZONE_SIZE	.equ	1	; Previous Ego's Zone
GAME_EGOS_CURRENT_ZONE_SIZE	.equ	1	; Current Ego's Zone
GAME_LAST_PICK_SIZE	.equ	1	; Last Picked Object
GAME_LAST_DROP_SIZE	.equ	1	; Last Dropped Object
GAME_LAST_COMMAND_SIZE	.equ	32	; 
GAME_ON_TICK_SIZE	.equ	2	; OnTick
GAME_ON_PICK_SIZE	.equ	2	; OnPick
GAME_ON_DROP_SIZE	.equ	2	; OnDrop
GAME_ON_WALK_SIZE	.equ	2	; OnWalk
GAME_ON_ACTION_SIZE	.equ	2	; OnAction
GAME_ON_START_GAME_SIZE	.equ	2	; OnStartGame
GAME_ON_SAVE_GAME_SIZE	.equ	2	; OnSaveGame
GAME_ON_LOAD_GAME_SIZE	.equ	2	; OnLoadGame
GAME_ON_DEATH_SIZE	.equ	2	; OnDeath
GAME_ON_WIN_SIZE	.equ	2	; OnWin
GAME_LAYER0_OBJECTLIST_SIZE	.equ	2	; Pointer to the First Object in Linked List
GAME_LAYER1_OBJECTLIST_SIZE	.equ	2	; Pointer to the First Object in Linked List
GAME_LAYER2_OBJECTLIST_SIZE	.equ	2	; Pointer to the First Object in Linked List
GAME_LAYER3_OBJECTLIST_SIZE	.equ	2	; Pointer to the First Object in Linked List
GAME_LAYER4_OBJECTLIST_SIZE	.equ	2	; Pointer to the First Object in Linked List
GAME_LAYER5_OBJECTLIST_SIZE	.equ	2	; Pointer to the First Object in Linked List
GAME_LAYER6_OBJECTLIST_SIZE	.equ	2	; Pointer to the First Object in Linked List
GAME_NUMBER_OF_INVALIDATED_AREAS_SIZE	.equ	1	; 
GAME_INVALIDATED_AREAS_SIZE	.equ	50	; 10 Invalidated Areas (position (2) + size(2) + start/end layers (1))
GAME_NUMBER_OF_OBJECTS_TO_PAINT_SIZE	.equ	1	; 
GAME_OBJECTS_TO_PAINT_SIZE	.equ	20	; 10 Pointers to objects to be painted
GAME_OBJECT_LIST_SIZE	.equ	2	; Pointer to List of Objects available thoughout the game
GAME_CHAPTER_SIZE	.equ	2	; Pointer to Chapter
GAME_LOCATION_SIZE	.equ	2	; Pointer to Location
GAME_RESERVED_SIZE	.equ	216	; Reserved