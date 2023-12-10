
	.include "Debug\objs/zoo.package.asm"

; ----------------------------------------------------------------
; - Dependencies
; ----------------------------------------------------------------
	.include "I:/Emulator/MSX/DEV/libs/msx/msxbios.s"	; referenced in Class VDP

; ----------------------------------------------------------------
; - EQUs
; ----------------------------------------------------------------
Control.FLAG_ACTIVE		.equ 0b00000001
Control.FLAG_VISIBLE		.equ 0b00000010
Bitmap.VRAMBMPFlag		.equ 0b00000100
Bitmap.TransparentFlag		.equ 0b00001000
VDP.PORT_0		.equ 0x98
VDP.PORT_1		.equ 0x99
VDP.PORT_2		.equ 0x9A
VDP.PORT_3		.equ 0x9B
VDP9938.COMMAND_STOP		.equ 0b00000000
VDP9938.COMMAND_POINT		.equ 0b01000000
VDP9938.COMMAND_PSET		.equ 0b01010000
VDP9938.COMMAND_SRCH		.equ 0b01100000
VDP9938.COMMAND_LINE		.equ 0b01110000
VDP9938.COMMAND_LMMV		.equ 0b10000000
VDP9938.COMMAND_LMMM		.equ 0b10010000
VDP9938.COMMAND_LMCM		.equ 0b10100000
VDP9938.COMMAND_LMMC		.equ 0b10110000
VDP9938.COMMAND_HMMV		.equ 0b11000000
VDP9938.COMMAND_HMMM		.equ 0b11010000
VDP9938.COMMAND_YMMM		.equ 0b11100000
VDP9938.COMMAND_HMMC		.equ 0b11110000
VDP9938.OPERATION_IMP		.equ 0b00000000
VDP9938.OPERATION_AND		.equ 0b00000001
VDP9938.OPERATION_OR		.equ 0b00000010
VDP9938.OPERATION_XOR		.equ 0b00000011
VDP9938.OPERATION_NOT		.equ 0b00000100
VDP9938.OPERATION_TIMP		.equ 0b00001000
VDP9938.OPERATION_TAND		.equ 0b00001001
VDP9938.OPERATION_TOR		.equ 0b00001010
VDP9938.OPERATION_TXOR		.equ 0b00001011
VDP9938.OPERATION_TNOT		.equ 0b00001100

; ----------------------------------------------------------------
; - Properties Offsets/Object Reflection Data
; ----------------------------------------------------------------
Object.pClass.offset	.equ 0	; Size = 2 (1 instances of size 2)

Control.pClass.offset	.equ 0	; Size = 2 (1 instances of size 2)
Control.Flags.offset	.equ 2	; Size = 1 (1 instances of size 1)
Control.X.offset	.equ 3	; Size = 2 (1 instances of size 2)
Control.Y.offset	.equ 5	; Size = 2 (1 instances of size 2)
Control.Width.offset	.equ 7	; Size = 2 (1 instances of size 2)
Control.Height.offset	.equ 9	; Size = 2 (1 instances of size 2)

Bitmap.pClass.offset	.equ 0	; Size = 2 (1 instances of size 2)
Bitmap.Flags.offset	.equ 2	; Size = 1 (1 instances of size 1)
Bitmap.X.offset	.equ 3	; Size = 2 (1 instances of size 2)
Bitmap.Y.offset	.equ 5	; Size = 2 (1 instances of size 2)
Bitmap.Width.offset	.equ 7	; Size = 2 (1 instances of size 2)
Bitmap.Height.offset	.equ 9	; Size = 2 (1 instances of size 2)
Bitmap.XBMP.offset	.equ 11	; Size = 2 (1 instances of size 2)
Bitmap.YBMP.offset	.equ 13	; Size = 2 (1 instances of size 2)
Bitmap.Direction.offset	.equ 15	; Size = 1 (1 instances of size 1)
Bitmap.PaintOperation.offset	.equ 16	; Size = 1 (1 instances of size 1)
Bitmap.TransparentColor.offset	.equ 17	; Size = 1 (1 instances of size 1)

VDP.pClass.offset	.equ 0	; Size = 2 (1 instances of size 2)

VDP9938.pClass.offset	.equ 0	; Size = 2 (1 instances of size 2)

Panel.pClass.offset	.equ 0	; Size = 2 (1 instances of size 2)
Panel.Flags.offset	.equ 2	; Size = 1 (1 instances of size 1)
Panel.X.offset	.equ 3	; Size = 2 (1 instances of size 2)
Panel.Y.offset	.equ 5	; Size = 2 (1 instances of size 2)
Panel.Width.offset	.equ 7	; Size = 2 (1 instances of size 2)
Panel.Height.offset	.equ 9	; Size = 2 (1 instances of size 2)
Panel.Color.offset	.equ 11	; Size = 1 (1 instances of size 1)
Panel.Direction.offset	.equ 12	; Size = 1 (1 instances of size 1)
Panel.PaintOperation.offset	.equ 13	; Size = 1 (1 instances of size 1)


	.area _DATA

; ----------------------------------------------------------------
; - Class Reflection Data/Method References
; ----------------------------------------------------------------
Object._Start::
Object::
Object.pParentClass::	.dw #0
Object.pSProperties::	.dw Object._SProperties
Object.pSMethods::	.dw Object._SMethods
Object.ObjectSize::	.db #2
Object.pConstructor::	.dw Object._Constructor
Object.pDestructor::	.dw Object._Destructor
Object._End::

Control._Start::
Control::
Control.pParentClass::	.dw Object
Control.pSProperties::	.dw Control._SProperties
Control.pSMethods::	.dw Control._SMethods
Control.ObjectSize::	.db #11
Control.pConstructor::	.dw Object._Constructor
Control.pDestructor::	.dw Object._Destructor
Control.pOnPaint::	.dw #0
Control.pPaint::	.dw Control._Paint
Control._End::

Bitmap._Start::
Bitmap::
Bitmap.pParentClass::	.dw Control
Bitmap.pSProperties::	.dw Bitmap._SProperties
Bitmap.pSMethods::	.dw Bitmap._SMethods
Bitmap.ObjectSize::	.db #18
Bitmap.pConstructor::	.dw Object._Constructor
Bitmap.pDestructor::	.dw Object._Destructor
Bitmap.pOnPaint::	.dw Bitmap._OnPaint
Bitmap.pPaint::	.dw Control._Paint
Bitmap.pPaintFromRAM:	.dw Bitmap._PaintFromRAM
Bitmap.pPaintFromVRAM:	.dw Bitmap._PaintFromVRAM
Bitmap._End::

VDP._Start::
VDP::
VDP.pParentClass::	.dw Object
VDP.pSProperties::	.dw VDP._SProperties
VDP.pSMethods::	.dw VDP._SMethods
VDP.ObjectSize::	.db #2
VDP.pConstructor::	.dw Object._Constructor
VDP.pDestructor::	.dw Object._Destructor
VDP._End::

VDP9938._Start::
VDP9938::
VDP9938.pParentClass::	.dw VDP
VDP9938.pSProperties::	.dw VDP9938._SProperties
VDP9938.pSMethods::	.dw VDP9938._SMethods
VDP9938.ObjectSize::	.db #2
VDP9938.pConstructor::	.dw Object._Constructor
VDP9938.pDestructor::	.dw Object._Destructor
VDP9938._End::

Panel._Start::
Panel::
Panel.pParentClass::	.dw Control
Panel.pSProperties::	.dw Panel._SProperties
Panel.pSMethods::	.dw Panel._SMethods
Panel.ObjectSize::	.db #14
Panel.pConstructor::	.dw Object._Constructor
Panel.pDestructor::	.dw Object._Destructor
Panel.pOnPaint::	.dw Panel._OnPaint
Panel.pPaint::	.dw Control._Paint
Panel._End::


; ----------------------------------------------------------------
; - Static Properties
; ----------------------------------------------------------------
Object._SProperties::

Control._SProperties::

Bitmap._SProperties::

VDP._SProperties::

VDP9938._SProperties::

Panel._SProperties::


; ----------------------------------------------------------------
; - Static Methods References
; ----------------------------------------------------------------
Object._SMethods::

Control._SMethods::

Bitmap._SMethods::

VDP._SMethods::
VDP.pSColor::	.dw VDP._SColor
VDP.pRColor::	.dw VDP._RColor
VDP.pBColor::	.dw VDP._BColor
VDP.pSScreen::	.dw VDP._SScreen
VDP.pRScreen::	.dw VDP._RScreen

VDP9938._SMethods::
VDP9938.pSColor::	.dw VDP._SColor
VDP9938.pRColor::	.dw VDP._RColor
VDP9938.pBColor::	.dw VDP._BColor
VDP9938.pSScreen::	.dw VDP._SScreen
VDP9938.pRScreen::	.dw VDP._RScreen
VDP9938.pWaitReady::	.dw VDP9938._WaitReady
VDP9938.pHMMV::	.dw VDP9938._HMMV
VDP9938.pRLineRightOrDown::	.dw VDP9938._RLineRightOrDown
VDP9938.pprepareCPUVRamTransfer::	.dw VDP9938._prepareCPUVRamTransfer
VDP9938.pTransparentCPUVRamTransfer::	.dw VDP9938._TransparentCPUVRamTransfer
VDP9938.pCPUVRamTransfer::	.dw VDP9938._CPUVRamTransfer

Panel._SMethods::



.area _CODE

_zoo_call_hl::
	jp (hl)

_zoo_error::
	halt

; ----------------------------------------------------------------
; - Object Methods
; ----------------------------------------------------------------
Object._Constructor::
    ret
  
Object._Destructor::
    ret
  

; ----------------------------------------------------------------
; - Object Static Methods
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Control Methods
; ----------------------------------------------------------------
Control._Constructor		.gblequ Object._Constructor
Control._Destructor		.gblequ Object._Destructor
Control._OnPaint::

Control._Paint::
    Control.GetFlags_IY A
    and #Control.FLAG_ACTIVE | Control.FLAG_VISIBLE
    sub #Control.FLAG_ACTIVE | Control.FLAG_VISIBLE
    ret nz
    Control.OnPaint_IY
    ret
  

; ----------------------------------------------------------------
; - Control Static Methods
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Bitmap Methods
; ----------------------------------------------------------------
Bitmap._Constructor		.gblequ Control._Constructor
Bitmap._Destructor		.gblequ Control._Destructor
Bitmap._OnPaint::
; -------------------------------
; Changes:
;	AF, BC, DE, HL
; -------------------------------
  Bitmap.GetFlags_IY A
  and #Bitmap.VRAMBMPFlag
  jr nz, Bitmap._PaintFromVRAM
  ;jp Bitmap._PaintFromRAM
  
Bitmap._Paint		.gblequ Control._Paint
Bitmap._PaintFromRAM::
; Paints from RAM(XBMP)
  Bitmap.GetXLSB_IY E
  Bitmap.GetYLSB_IY D
  Bitmap.GetHeightLSB_IY B
  exx
  xor A
  Bitmap.GetWidthLSB_IY B
  Bitmap.GetXBMP_IY H, L
  bit 3, Bitmap.Flags.offset(IY)
  jp z, VDP9938._CPUVRamTransfer
  Bitmap.GetTransparentColor_IY E
  jp VDP9938._TransparentCPUVRamTransfer
  
Bitmap._PaintFromVRAM::
; Paints from VRAM(XBMP, YBMP)
  Bitmap.GetXPtrHL_IY
  Bitmap.GetXBMP_IY d, e
  Bitmap.GetYBMP_IY b, c
; jp _vdp_HMMM
  

; ----------------------------------------------------------------
; - Bitmap Static Methods
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - VDP Methods
; ----------------------------------------------------------------
VDP._Constructor		.gblequ Object._Constructor
VDP._Destructor		.gblequ Object._Destructor

; ----------------------------------------------------------------
; - VDP Static Methods
; ----------------------------------------------------------------

VDP._SColor::
; -------------------------------
; Sets screen colors from parameters in Stack.
; -------------------------------
; INPUTS:
;	SP + 02 = foregroung color
;	SP + 03 = background color
;	SP + 04 = border color
; OUTPUTS:
;	AF, BC, DE, HL: Changes
; -------------------------------
    ld hl, #2
    add hl, sp
    ld de, #BIOS_FORCLR
    ld bc, #3
    ldir
    jp VDP._BColor
  

VDP._RColor::
; -------------------------------
; Sets screen colors from parameters in Registers.
; -------------------------------
; INPUTS:
;	A = foregroung color
;	H = border color
;	L = background color
; OUTPUTS:
;	AF, BC, DE, HL: Changes
; -------------------------------
    ld	(#BIOS_FORCLR), a
    ld	(#BIOS_BAKCLR), hl
    jp VDP._BColor
  

VDP._BColor::
; -------------------------------
; Sets screen colors from parameters in BIOS Vars.
; -------------------------------
; INPUTS:
;	(BIOS_FORCLR) = foregroung color
;	(BIOS_BAKCLR) = background color
;	(BIOS_BDRCLR) = border color
; OUTPUTS:
;	AF, BC, DE, HL: Changes
; -------------------------------
    Zoo.CallSlot BIOS_CHGCLR
    ret
  

VDP._SScreen::
; -------------------------------
; Changes screen mode from parameters in Stack.
; -------------------------------
; INPUTS:
;	SP + 02 = screen mode
; OUTPUTS:
;	AF, BC, DE, HL: Changes
; -------------------------------
	  ld hl, #2
	  add hl, sp
	  ld a, (hl)
    jp VDP._RScreen
  

VDP._RScreen::
; -------------------------------
; Changes screen mode from parameters in Registers.
; Set page 0 for graphical modes.
; -------------------------------
; INPUTS:
;	a = screen mode
; OUTPUTS:
;	AF, BC, DE, HL: Changes
; -------------------------------
    push af
    Zoo.CallSlot BIOS_CHGMOD
    pop af
    cp #4					        ; if text modes
    ret c					        ;	ret
    ld a,#0x1F				    ;	set page 0 for graphical modes
    out (#VDP.PORT_1),a
    ld a,#0x82
    out (#VDP.PORT_1),a
    ret
  

; ----------------------------------------------------------------
; - VDP9938 Methods
; ----------------------------------------------------------------
VDP9938._Constructor		.gblequ VDP._Constructor
VDP9938._Destructor		.gblequ VDP._Destructor

; ----------------------------------------------------------------
; - VDP9938 Static Methods
; ----------------------------------------------------------------

VDP9938._SColor		.gblequ VDP._SColor

VDP9938._RColor		.gblequ VDP._RColor

VDP9938._BColor		.gblequ VDP._BColor

VDP9938._SScreen		.gblequ VDP._SScreen

VDP9938._RScreen		.gblequ VDP._RScreen

VDP9938._WaitReady::
; --------------------------------
; INPUTS:
;	None
; OUTPUTS:
;	EI
;	a = 143
; --------------------------------
  ld a,#2
  di
  out (#VDP.PORT_1),a				;select s#2
  ld a,#15+#128
  out (#VDP.PORT_1),a
  in a,(#VDP.PORT_1)
  rra								        ; CE in c flag
  ld a,#0							      ;back to s#0, enable ints
  out (#VDP.PORT_1),a
  ld a,#15+#128
  ei
  out (#VDP.PORT_1),a
  jr c,VDP9938._WaitReady				;loop if vdp not ready (CE)
  ret
  

VDP9938._HMMV::
; -------------------------------
; INPUTS:
;	(HL + 00) = X
;	(HL + 02) = Y
;	(HL + 04) = Width
;	(HL + 06) = Height
;	(HL + 07) = Color
; CHANGES:
;	AF, BC, HL
; DI
; -------------------------------
  VDP9938.WaitReady
  ld a, #36
  di
  out (#VDP.PORT_1),a
  ld a, #17+#128
  out (#VDP.PORT_1),a
  ld b, #10
  ld c, #VDP.PORT_3
  otir
  ld a, #VDP9938.COMMAND_HMMV
  out (#VDP.PORT_3), a				; R#46 (Command = HMMV)
  ret
  

VDP9938._RLineRightOrDown::
; --------------------------------
; INPUTS:
;	e = DX (Start Position)
;	d = DY (Start Position)
;	b = NX (pixels)
;	h = Color
;	l = Direction (0: Right, 1: Down)
; OUTPUTS:
;	DI
;	A, C: Changes
;	HL = HL-1
; --------------------------------
  ld c, #VDP.PORT_3
  VDP9938.WaitReady
  ld a, #36
  di
  out (#VDP.PORT_1), a
  ld a, #17+#128
  out (#VDP.PORT_1), a
  out (c), e						      ; R#36 (DX.LSB = e)
  xor a
  out (#VDP.PORT_3), a			  ; R#37 (DX.MSB = 0)
  out (c), d						      ; R#38 (DY.LSB = d)
  out (#VDP.PORT_3), a			  ; R#39 (DY.MSB = 0)
  out (c), b						      ; R#40 (NX.LSB = b)
  out (#VDP.PORT_3), a			  ; R#41 (NX.MSB = 0)
  out (#VDP.PORT_3), a			  ; R#42 (NY.LSB = 0)
  out (#VDP.PORT_3), a			  ; R#43 (NY.MSB = 0)
  out (c), h				          ; R#44 (Color  = h)
  out (c), l				          ; R#45 (Video RAM, down, right, right/down)
  ld a, #VDP9938.COMMAND_LINE
  out (#VDP.PORT_3), a				; R#46 (Command = LINE)
  ret
  

VDP9938._prepareCPUVRamTransfer::
; --------------------------------
; This prepares Direct CPU->VRAM Transfers. This is NOT for HMMC of LMMC.
; This operation is described in V9938 manual under section 1.4.
; INPUTS:
;	ADE = VRAM Start Position (17 bit)
; OUTPUT:
; CHANGES:
;	A, D
; --------------------------------
  rlc	d
  rla
  rlc	d
  rla
  srl	d
  srl	d
  push af
  VDP9938.WaitReady
  pop af
  ; Step 2: Setting the address counter A16 to A14 (R14)
  out	(#VDP.PORT_1),a		; A16 to A14
  ld	a,#14+#128			  ; R14 + Autoincrement
  out	(#VDP.PORT_1),a		; R14 + Autoincrement
  ; Step 3: Setting the address counter A7 to A0
  ld a, e					      ; A7 to A0
  out	(#VDP.PORT_1),a		; A7 to A0
  ; Step 4: Setting the address counter A13 to A8 and operation mode
  ld	a,d					      ; A13 to A8
  or	#64					      ; Write Mode
  out	(#VDP.PORT_1),a		; A13 to A8 and write mode
  ret
  

VDP9938._TransparentCPUVRamTransfer::
; --------------------------------
; Direct CPU->VRAM Transfer (NOT for HMMC of LMMC).
; This operation is described in V9938 manual under section 1.4.
; INPUTS:
;	AD'E' = VRAM Start Position (17 bit)
; B' = Height
; B = Width
; HL = RAM Start Position
; E = Transparent color
; OUTPUT:
; C = VDP.PORT_0
; CHANGES:
;	A, D
; --------------------------------
  ld D, B
  exx
  ld C, A
VDP9938.TransparentCPUVRamTransfer_LinLoop:
  push DE
  ld A, C
  VDP9938.prepareCPUVRamTransfer
  exx 
  ld B, D
VDP9938.TransparentCPUVRamTransfer_ColLoop:
  ld A, (HL)
  inc HL
  cp E  
  jr z, VDP9938.TransparentCPUVRamTransfer_Transparent
  out (#VDP.PORT_0), A
  djnz VDP9938.TransparentCPUVRamTransfer_ColLoop
  jr VDP9938.TransparentCPUVRamTransfer_LinEnd
VDP9938.TransparentCPUVRamTransfer_Transparent:  
  in A, (#VDP.PORT_0)
  djnz VDP9938.TransparentCPUVRamTransfer_ColLoop
VDP9938.TransparentCPUVRamTransfer_LinEnd:
  exx
  pop DE
  inc D
  djnz VDP9938.TransparentCPUVRamTransfer_LinLoop
  ret  
  

VDP9938._CPUVRamTransfer::
; --------------------------------
; Direct CPU->VRAM Transfer (NOT for HMMC of LMMC).
; This operation is described in V9938 manual under section 1.4.
; INPUTS:
;	AD'E' = VRAM Start Position (17 bit)
; B' = Height
; B = Width
; HL = RAM Start Position
; OUTPUT:
; C = VDP.PORT_0
; CHANGES:
;	A, D
; --------------------------------
  ld C, #VDP.PORT_0
  ld D, B
  exx
  ld C, A
VDP9938.CPUVRamTransfer_Loop:
  push DE
  ld A, C
  VDP9938.prepareCPUVRamTransfer
  exx 
  ld B, D
  otir
  exx
  pop DE
  inc D
  djnz VDP9938.CPUVRamTransfer_Loop
  ret
  

; ----------------------------------------------------------------
; - Panel Methods
; ----------------------------------------------------------------
Panel._Constructor		.gblequ Control._Constructor
Panel._Destructor		.gblequ Control._Destructor
Panel._OnPaint::
; -------------------------------
; Changes:
;	AF, BC, HL
; -------------------------------
    GetPropPtrHL_IY Panel, X
    jp VDP9938._HMMV
  
Panel._Paint		.gblequ Control._Paint

; ----------------------------------------------------------------
; - Panel Static Methods
; ----------------------------------------------------------------

