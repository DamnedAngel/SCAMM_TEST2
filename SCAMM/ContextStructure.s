; Context Structure - Offset

; Start of definitions

CONTEXT_STRUCTURE						.equ	#0x0000	; 0 marker  # 0 # Context structure
CONTEXT_STRUCTURE_SIZE					.equ	#0x0000	; 2 Int16 Automatic # 0 # Context Structure Size
CONTEXT_P_PARENT_CONTEXT				.equ	#0x0002	; 2 PContext Runtime # 0 # Pointer to First Context (Root)
CONTEXT_P_CHILD_CONTEXT					.equ	#0x0004	; 2 PContext Runtime # 0 # Pointer to Child Context (Leaf)
CONTEXT_P_NAME							.equ	#0x0006	; 2 PStr Editable # SCAMM Game # Pointer to Name of the Game
CONTEXT_P_DESCRIPTION					.equ	#0x0008	; 2 PStr Editable # This is an awesome SCAMM Game. # Pointer to the description of the game
CONTEXT_P_OBJECT_LIST					.equ	#0x000A	; 2 PObjectList Editable # 0 # Pointer to List of Objects available thoughout the game
CONTEXT_P_ON_TICK						.equ	#0x000C	; 2 PEventHandler Editable # ret # On Tick event handler
CONTEXT_P_ON_PICK						.equ	#0x000E	; 2 PEventHandler Editable # ret # On Pick event handler
CONTEXT_P_ON_DROP						.equ	#0x0010	; 2 PEventHandler Editable # ret # On Drop event handler
CONTEXT_P_ON_WALK						.equ	#0x0012	; 2 PEventHandler Editable # ret # On Walk event handler
CONTEXT_P_ON_ACTION						.equ	#0x0014	; 2 PEventHandler Editable # ret # On Action event handler
CONTEXT_P_ON_LOAD_CONTEXT				.equ	#0x0016	; 2 PEventHandler Editable # ret # On Start Game event handler
CONTEXT_P_ON_SAVE_GAME					.equ	#0x0018	; 2 PEventHandler Editable # ret # On Save Game event handler
CONTEXT_P_ON_LOAD_GAME					.equ	#0x001A	; 2 PEventHandler Editable # ret # On Load Game event handler
CONTEXT_P_ON_DEATH						.equ	#0x001C	; 2 PEventHandler Editable # ret # On Death event handler
CONTEXT_P_ON_WIN						.equ	#0x001E	; 2 PEventHandler Editable # ret # On Win event handler