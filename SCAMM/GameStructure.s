; Game Structure - Offset

; Start of definitions

GAME_STRUCTURE							.equ	#0x0000	; 0 marker  # 0 # Game structure
GAME_STRUCTURE_SIZE						.equ	#0x0000	; 2 Int16 Automatic # 0 # Game structure size
GAME_ENGINE_VERSION						.equ	#0x0002	; 4 Int32 Readonly # 16842753 # Required Engine Version
GAME_P_NAME								.equ	#0x0006	; 2 PStr Editable # SCAMM Game # Pointer to Name of the Game
GAME_P_COMPLETE_NAME					.equ	#0x0008	; 2 PStr Editable # SCAMM Game - The Return of the Ungone # Pointer to the complete version of the name
GAME_P_DESCRIPTION						.equ	#0x000A	; 2 PStr Editable # This is an awesome SCAMM Game. # Pointer to the description of the game
GAME_P_ON_LOAD_GAME						.equ	#0x000C	; 2 PEventHandler Editable # ret # On Load Game event handler