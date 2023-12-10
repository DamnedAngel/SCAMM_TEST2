; FixedGame Structure

	.area _FIXEDGAME (ABS)

	.org #0x3000


FIXEDGAME_ENGINE_VERSION:
FIXEDGAME_ENGINE_VERSION_BUILD:					; 2 Int16 Readonly # Engine Version: Build
	.dw #1
FIXEDGAME_ENGINE_VERSION_MINOR:					; 1 Int8 Readonly # Engine Version: Minor
	.db #1
FIXEDGAME_ENGINE_VERSION_MAJOR:					; 1 Int8 Readonly # Engine Version: Major
	.db #0
FIXEDGAME_SCORE:								; 2 Int16 Runtime # Score
	.dw #0
FIXEDGAME_ELAPSED_TICKS:						; 4 Int32 Runtime # Ticks (interrupts) since the beginning of game
	.dw #0, #0
FIXEDGAME_ELAPSED_TIME:							; 4 Int32 Runtime # Time (in seconds) since the beginning of game
	.dw #0, #0
FIXEDGAME_EGOS_PREVIOUS_ZONE:					; 1 Int8 Runtime # Previous Ego's Zone
	.db #0
FIXEDGAME_EGOS_CURRENT_ZONE:					; 1 Int8 Runtime # Current Ego's Zone
	.db #0
FIXEDGAME_LAST_PICK:							; 2 PObject Runtime # Last Picked Object
	.dw #0
FIXEDGAME_LAST_DROP:							; 2 PObject Runtime # Last Dropped Object
	.dw #0
FIXEDGAME_LAST_COMMAND:							; 32 Buffer Runtime # Last Command Issued
	.db #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0
FIXEDGAME_LAYERS:
FIXEDGAME_LAYER0_OBJECTLIST:					; 2 PObject Runtime # Pointer to the First Object in Linked List
	.dw #0
FIXEDGAME_LAYER1_OBJECTLIST:					; 2 PObject Runtime # Pointer to the First Object in Linked List
	.dw #0
FIXEDGAME_LAYER2_OBJECTLIST:					; 2 PObject Runtime # Pointer to the First Object in Linked List
	.dw #0
FIXEDGAME_LAYER3_OBJECTLIST:					; 2 PObject Runtime # Pointer to the First Object in Linked List
	.dw #0
FIXEDGAME_LAYER4_OBJECTLIST:					; 2 PObject Runtime # Pointer to the First Object in Linked List
	.dw #0
FIXEDGAME_LAYER5_OBJECTLIST:					; 2 PObject Runtime # Pointer to the First Object in Linked List
	.dw #0
FIXEDGAME_LAYER6_OBJECTLIST:					; 2 PObject Runtime # Pointer to the First Object in Linked List
	.dw #0
FIXEDGAME_NUMBER_OF_INVALIDATED_AREAS:			; 1 Int8 Runtime # Number of invalidated areas
	.db #0
FIXEDGAME_INVALIDATED_AREAS:					; 50 Buffer Runtime # 10 Invalidated Areas (position (2) + size(2) + start/end layers (1))
	.db #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0
FIXEDGAME_NUMBER_OF_OBJECTS_TO_PAINT:			; 1 Int8 Runtime # Number of objects to paint
	.db #0
FIXEDGAME_OBJECTS_TO_PAINT:						; 20 Buffer Runtime # 10 Pointers to objects to be painted
	.db #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0
FIXEDGAME_CHAPTER:								; 2 Pointer Runtime # Pointer to Chapter
	.dw #0
FIXEDGAME_LOCATION:								; 2 Pointer Runtime # Pointer to Location
	.dw #0
FIXEDGAME_RESERVED:								; 114 Buffer Runtime # Reserved
	.db #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0
STACK_AREA:										; 252 Buffer Runtime # SCAMM Stack
	.db #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0, #0
STACK_TOP:										; 2 Buffer Runtime # Last 16-bit position of the stack
	.db #0, #0
STACK_POINTER:									; 2 Buffer Runtime # Stack Pointer
	.db #0, #0