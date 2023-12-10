	.include "..\..\..\libs\MSX\msxvdp_constants.s"
	.include "..\..\..\libs\MSX\msxvdp.asm"

	.include "..\..\..\libs\Z80\z80unofficial.s"
	.include "..\..\..\libs\profiling\OpenMSXProfiling.s"

	.area _DATA

	.area _CODE

_vdp_prepareVRamTransferFor_unpackScreen_UBMP:
; --------------------------------
; This prepares Direct CPU->VRAM Transfers for UBMP. This is NOT for HMMC of LMMC.
; This operation is described in V9938 manual under section 1.4.
; This should be made outdated when new unpack is implemented.
; INPUTS:
;	ade = Start Position (17 bit)
;	b = bytes - 1
; OUTPUTS:
;	a = 143
;	b = ff
;	c = VDP_PORT0
;	de += b + 1
; --------------------------------
	ld c, d
	rlc	c
	rla
	rlc	c
	rla
	srl	c
	srl	c
	di
; Step 2: Setting the address counter A16 to A14 (R14) 
	out	(#VDP_PORT1),a		; A16 to A14
	ld	a,#14+#128			; R14 + Autoincrement
	out	(#VDP_PORT1),a		; R14 + Autoincrement
; Step 3: Setting the address counter A7 to A0
	ld a, e					; A7 to A0
	out	(#VDP_PORT1),a		; A7 to A0
; Step 4: Setting the address counter A13 to A8 and operation mode
; unpackScreen_UBMP specifics: de += b + 1
	or a					; reset c flag
	adc a, b
	ld e, a
	jr nc, _vdp_prepareVRamTransfer_noLineFeed
	inc d
; </unpackScreen_UBMP specifics>
_vdp_prepareVRamTransfer_noLineFeed:
	ld	a,c					; A13 to A8
	or	#64					; Write Mode
	ei
	out	(#VDP_PORT1),a		; A13 to A8 and write mode
;	jr _vdp_waitReady		; contains ret
	ret


_vdp_horizontalLineToRight:
; --------------------------------
; INPUTS:
;	e = DX (Start Position)
;	d = DY (Start Position)
;	b = NX (pixels - 1)
; OUTPUTS:
;	a = changed
;	c = changed
;	de += b + 1
; --------------------------------
	ld a, b
	cp #VRAM_THRESHOLD
	jr c, _vdp_horizontalLineToRight_VDPLine
	inc b
	xor a
	call _vdp_prepareVRamTransferFor_unpackScreen_UBMP
	ld a, (hl)
	inc hl
	di
_vdp_horizontalLineToRight_VRAM:
	out (#VDP_PORT0), a
	djnz _vdp_horizontalLineToRight_VRAM
	ei
	ret

_vdp_horizontalLineToRight_VDPLine:
	call _vdp_waitReady
	ld a,#36
	di
	out (#VDP_PORT1),a
	ld a,#17+#128
	out (#VDP_PORT1),a
	ld c,#VDP_PORT3
	out (c), e						; R#36 (DX.LSB = e)
	xor a
	out (#VDP_PORT3), a				; R#37 (DX.MSB = 0)
	out (c), d						; R#38 (DY.LSB = d)
	out (#VDP_PORT3), a				; R#39 (DY.MSB = 0)
	inc b
	out (c), b						; R#40 (NX.LSB = b)
	jr nz, _vdp_horizontalLineToRight_NoFullLine
	inc a
	out (#VDP_PORT3), a				; R#41 (NX.MSB = 1)
_vdp_horizontalLineToRight_Linefeed:
	ld e, #0
	inc d
_vdp_horizontalLineToRight_NY:
	xor a
	out (#VDP_PORT3), a				; R#42 (NY.LSB = 0)
	out (#VDP_PORT3), a				; R#43 (NY.MSB = 0)
	outi							; R#44 (Color = (HL))
	out (#VDP_PORT3), a				; R#45 (ARG = 0 (Video RAM, down, right))
	ld a, #VDP_COMMAND_LINE
	ei
	out (#VDP_PORT3), a				; R#46 (Command = LINE)
	ret
_vdp_horizontalLineToRight_NoFullLine:
	out (#VDP_PORT3), a				; R#41 (NX.MSB = 0)
	ld a, b
	adc a, e
	jr c, _vdp_horizontalLineToRight_Linefeed
	ld e, a
	jr _vdp_horizontalLineToRight_NY

_unpackScreen::
	push ix
	Section_Profiling_Start #0
	;ld ix,#0
	;add ix,sp

	ld hl, #CHAPTER_START
	ld de, #SCENE_START

_unpackScreen_Loop:
	ld a, (hl)
	inc hl
	cp #TOKEN_XTRA
	jr nz, _unpackScreen_NoExtra

_unpackScreen_Extra:
	ld a, (hl)
	inc hl
	cp #TOKEN_XTRA_EOF
	jr z, _unpackScreen_end
	jr _unpackScreen_Loop

_unpackScreen_end:
	Section_Profiling_End #0
	pop ix
	ret

_unpackScreen_NoExtra:
	ld b, a
	and #0b11000000
	cp #TOKEN_ARAY
	jr z, _unpackScreen_Array
	cp #TOKEN_LINE
	jr z, _unpackScreen_Line
	cp #TOKEN_UBMP
	jr z, _unpackScreen_UBMP

_unpackScreen_CBMP:					
; 11XXXXXX: Follows compressed bitmap of size XXXXXX + 1
	jr _unpackScreen_Loop

_unpackScreen_UBMP:
; 10XXXXXX: Follows uncompressed bitmap of size XXXXXX + 1
	ld a, b
	and #TOKEN_PARAM
	inc a
	ld b, a
	xor a
	call _vdp_prepareVRamTransferFor_unpackScreen_UBMP
	ld c,#VDP_PORT0
	otir
	jr _unpackScreen_Loop

_unpackScreen_Array:
; 00XXXXXX CCCCCCCC: Fills (XXXXXX + 1) pixels with color CCCCCCCC
	call _vdp_horizontalLineToRight
	jr _unpackScreen_Loop

_unpackScreen_Line:
; 01XXXXXX YYYYYYYY CCCCCCCC: Fill XXXXXX lines (including the current) + (YYYYYYYY + 1) pixels Follows color to array of XXXXXX pixels
	ld a, b
	and #TOKEN_PARAM
	jr z, _unpackScreen_Line_LastLine

; complete fist line
	ld_ixh_a						; ld ixh, a (dd67)
	ld a, e
	xor #0hff
	ld b, a
	inc HL
	call _vdp_horizontalLineToRight
	dec HL

; test block of lines
	ld_a_ixh						; ld a, ixh (dd7c)
	dec a
	jr z, _unpackScreen_Line_DecHLAndLastLine
; build block of lines
	call _vdp_waitReady
	ld a,#36
	di
	out (#VDP_PORT1),a
	ld a,#17+#128
	out (#VDP_PORT1),a
	ld c,#VDP_PORT3
	xor a
	out (#VDP_PORT3), a				; R#37 (DX.LSB = 0)
	out (#VDP_PORT3), a				; R#37 (DX.MSB = 0)
	out (c), d						; R#38 (DY.LSB = d)
	out (#VDP_PORT3), a				; R#39 (DY.MSB = 0)
	xor a
	out (#VDP_PORT3), a				; R#40 (NX.LSB = 0)
	inc a
	out (#VDP_PORT3), a				; R#41 (NX.MSB = 1)
	ld_a_ixh						; ld a, ixh (dd7c)
	dec a
	out (#VDP_PORT3), a				; R#42 (NY.LSB = lines)
	add a, d
	ld d, a
	xor a
	out (#VDP_PORT3), a				; R#43 (NY.MSB = 0)
	outi							; R#44 (Color = (HL))
	out (#VDP_PORT3), a				; R#45 (ARG = 0 (Video RAM, down, right))
	ld a, #VDP_COMMAND_HMMV
	ei
	out (#VDP_PORT3), a				; R#46 (Command = MHHV)
	dec hl

_unpackScreen_Line_DecHLAndLastLine:
	dec hl
_unpackScreen_Line_LastLine:
	ld b, (hl)
	inc hl
	call _vdp_horizontalLineToRight
	jp _unpackScreen_Loop

