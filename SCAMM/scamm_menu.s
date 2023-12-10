
;	.include "..\..\..\libs\MSX\msxbios.s"
;	.include "..\..\..\libs\Z80\z80unofficial.s"
;	.include "..\..\..\libs\profiling\OpenMSXProfiling.s"

	.include "scamm_vdp.asm"

	.area _DATA
;
; Menu:
;	Number of items (1)
;   PItemList (2)
;	PSelectedItem (2)
;	PPreviouslySelectedItem (2)
;	Status (1)
;		 - 0: Changed
;
; ItemList:
;	PCaption (2)
;	Width (1)
;	PPrevious (2)
;	PNext (2)
;	PMenu (2)
;	PSubMenu (2)
;	POnClick (2)
;	PositionYX (2)

; GameMenu
_GameMenu:
	.db	#3				;	Number of items (1)
	.dw	#_ScammItem		;   PItemList (2)
	.dw #_FileItem		;	PSelectedItem (2)
	.dw #0				;	PPreviouslySelectedItem (2)
	.db #0				;	Status (1)

_ScammItem:
	.dw #_ScammSTR		;	PCaption (2)
	.db #1				;	Width (1)
	.dw #0				;	PPrevious (2)
	.dw #_FileItem		;	PNext (2)
	.dw #_GameMenu		;	PMenu (2)
	.dw #_ScammMenu		;	PSubMenu (2)
	.dw #0				;	POnClick (2)
	.dw #0x0202			;	PositionYX (2)

_ScammMenu:
		.db	#3					;	Number of items (1)
		.dw	#_AboutScammItem	;   PItemList (2)
		.dw #_AboutScammItem	;	PSelectedItem (2)
		.dw #0					;	PPreviouslySelectedItem (2)
		.db #0					;	Status (1)

_AboutScammItem:
		.dw #_AboutScammSTR		;	PCaption (2)
		.db #12					;	Width (1)
		.dw #0					;	PPrevious (2)
		.dw #_AboutGameItem		;	PNext (2)
		.dw #_ScammMenu			;	PMenu (2)
		.dw #0					;	PSubMenu (2)
		.dw #_AboutScammOnClick	;	POnClick (2)
		.dw #0x0a02				;	PositionYX (2)
		
_AboutGameItem:
		.dw #_AboutGameSTR		;	PCaption (2)
		.db #12					;	Width (1)
		.dw #_AboutScammItem	;	PPrevious (2)
		.dw #_HelpItem			;	PNext (2)
		.dw #_ScammMenu			;	PMenu (2)
		.dw #0					;	PSubMenu (2)
		.dw #_AboutGameOnClick	;	POnClick (2)
		.dw #0x1202				;	PositionYX (2)

_HelpItem:
		.dw #_HelpSTR			;	PCaption (2)
		.db #12					;	Width (1)
		.dw #_AboutGameItem		;	PPrevious (2)
		.dw #0					;	PNext (2)
		.dw #_ScammMenu			;	PMenu (2)
		.dw #0					;	PSubMenu (2)
		.dw #_HelpOnClick		;	POnClick (2)
		.dw #0x1a02				;	PositionYX (2)
		
_FileItem:
	.dw #_FileItemSTR	;	PCaption (2)
	.db #4				;	Width (1)
	.dw #_ScammItem		;	PPrevious (2)
	.dw #_ActionItem	;	PNext (2)
	.dw #_GameMenu		;	PMenu (2)
	.dw #_FileMenu		;	PSubMenu (2)
	.dw #0				;	POnClick (2)
	.dw #0x0212			;	PositionYX (2)

_FileMenu:
		.db	#4					;	Number of items (1)
		.dw	#_SaveGameItem		;   PItemList (2)
		.dw #_SaveGameItem		;	PSelectedItem (2)
		.dw #0					;	PPreviouslySelectedItem (2)
		.db #0					;	Status (1)

_SaveGameItem:
		.dw #_SaveGameSTR		;	PCaption (2)
		.db #13					;	Width (1)
		.dw #0					;	PPrevious (2)
		.dw #_LoadGameItem		;	PNext (2)
		.dw #_FileMenu			;	PMenu (2)
		.dw #0					;	PSubMenu (2)
		.dw #_SaveGameOnClick	;	POnClick (2)
		.dw #0x0a12				;	PositionYX (2)

_LoadGameItem:
		.dw #_LoadGameSTR		;	PCaption (2)
		.db #13					;	Width (1)
		.dw #_SaveGameItem		;	PPrevious (2)
		.dw #_NewGameItem		;	PNext (2)
		.dw #_FileMenu			;	PMenu (2)
		.dw #0					;	PSubMenu (2)
		.dw #_LoadGameOnClick	;	POnClick (2)
		.dw #0x1202				;	PositionYX (2)

_NewGameItem:
		.dw #_NewGameSTR		;	PCaption (2)
		.db #13					;	Width (1)
		.dw #_LoadGameItem		;	PPrevious (2)
		.dw #_QuitItem			;	PNext (2)
		.dw #_FileMenu			;	PMenu (2)
		.dw #0					;	PSubMenu (2)
		.dw #_NewGameOnClick	;	POnClick (2)
		.dw #0x1a02				;	PositionYX (2)

_QuitItem:
		.dw #_QuitSTR			;	PCaption (2)
		.db #13					;	Width (1)
		.dw #_NewGameItem		;	PPrevious (2)
		.dw #0					;	PNext (2)
		.dw #_FileMenu			;	PMenu (2)
		.dw #0					;	PSubMenu (2)
		.dw #_QuitOnClick		;	POnClick (2)
		.dw #0x2202				;	PositionYX (2)

_ActionItem:
	.dw #_ActionSTR		;	PCaption (2)
	.db #7				;	Width (1)
	.dw #_FileItem		;	PPrevious (2)
	.dw #0				;	PNext (2)
	.dw #_GameMenu		;	PMenu (2)
	.dw #_ActionMenu	;	PSubMenu (2)
	.dw #0				;	POnClick (2)
	.dw #0x023a			;	PositionYX (2)

_ActionMenu:
		.db	#1					;	Number of items (1)
		.dw	#_InventoryItem		;   PItemList (2)
		.dw #_InventoryItem		;	PSelectedItem (2)
		.dw #0					;	PPreviouslySelectedItem (2)
		.db #0					;	Status (1)

_InventoryItem:
		.dw #_InventorySTR		;	PCaption (2)
		.db #14					;	Width (1)
		.dw #0					;	PPrevious (2)
		.dw #0					;	PNext (2)
		.dw #_ActionMenu		;	PMenu (2)
		.dw #0					;	PSubMenu (2)
		.dw #_InventoryOnClick	;	POnClick (2)
		.dw #0x0a3a				;	PositionYX (2)

_ScammSTR:			.db '#', #0
_AboutScammSTR:		.db 'A', 'b', 'o', 'u', 't', ' ', 'S', 'c', 'a', 'm', 'm', #0
_AboutGameSTR:		.db 'A', 'b', 'o', 'u', 't', ' ', 'G', 'a', 'm', 'e', #0
_HelpSTR:			.db 'H', 'e', 'l', 'p', ' ', ' ', ' ', ' ', ' ', 'F', '1', #0
_FileItemSTR:		.db 'F','i','l','e', #0
_SaveGameSTR:		.db 'S', 'a', 'v', 'e', ' ', 'G', 'a', 'm', 'e', ' ', ' ', 'F', '2', #0
_LoadGameSTR:		.db 'L', 'o', 'a', 'd', ' ', 'G', 'a', 'm', 'e', ' ', ' ', 'F', '3', #0
_NewGameSTR:		.db 'N', 'e', 'w', ' ', 'G', 'a', 'm', 'e', ' ', ' ', ' ', 'F', '4', #0
_QuitSTR:			.db 'Q', 'u', 'i', 't', ' ', ' ', ' ', 'C', 't', 'r', 'l', '-', 'Q', #0
_ActionSTR:			.db 'A', 'c', 't', 'i', 'o', 'n', #0
_InventorySTR:		.db 'I', 'n', 'v', 'e', 'n', 't', 'o', 'r', 'y', ' ', ' ', 'T', 'a', 'b', #0

_test:				.db 't', 'e', 's', 't', #0
;	.area _CODE

_AboutScammOnClick:
	ret

_AboutGameOnClick:
	ret

_HelpOnClick:
	ret

_SaveGameOnClick:
	ret

_LoadGameOnClick:
	ret
	
_NewGameOnClick:
	ret

_QuitOnClick:
	ret

_InventoryOnClick:
	ret

_showMenu::
	ld a, #10
	push af
	ld hl, #_test
	push hl
	ld hl, #0x1010
	push hl
	call _vdp_draw_text
	pop hl
	pop hl
	pop hl
	ret
