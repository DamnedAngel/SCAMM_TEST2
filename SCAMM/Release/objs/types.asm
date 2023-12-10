;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
	.module types
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _uitoa
	.globl _itoa
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;..\..\..\libs\util\types.c:15: void uitoa(unsigned int value, char* string, int radix)
;	---------------------------------
; Function uitoa
; ---------------------------------
_uitoa::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;..\..\..\libs\util\types.c:22: do {
	ld	-2 (ix),#0x10
00103$:
;..\..\..\libs\util\types.c:23: string[--index] = '0' + (value % radix);
	dec	-2 (ix)
	ld	a,6 (ix)
	add	a, -2 (ix)
	ld	c,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	b,a
	ld	e,8 (ix)
	ld	d,9 (ix)
	push	bc
	push	de
	push	de
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__moduint
	pop	af
	pop	af
	pop	de
	pop	bc
	ld	a,l
	add	a, #0x30
	ld	(bc),a
;..\..\..\libs\util\types.c:24: if (string[index] > '9') string[index] += 'A' - ':';   /* continue with A, B,.. */
	ld	a,(bc)
	ld	l,a
	ld	a,#0x39
	sub	a, l
	jr	NC,00102$
	ld	a,l
	add	a, #0x07
	ld	(bc),a
00102$:
;..\..\..\libs\util\types.c:25: value /= radix;
	push	de
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	__divuint
	pop	af
	pop	af
	ld	4 (ix),l
;..\..\..\libs\util\types.c:26: } while (value != 0);
	ld	5 (ix), h
	ld	a, h
	or	a,4 (ix)
	jr	NZ,00103$
;..\..\..\libs\util\types.c:28: do {
	ld	c,#0x00
	ld	b,-2 (ix)
00106$:
;..\..\..\libs\util\types.c:29: string[i++] = string[index++];
	ld	e,c
	inc	c
	ld	a,6 (ix)
	add	a, e
	ld	e,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	d,a
	ld	-1 (ix),b
	inc	b
	ld	a,6 (ix)
	add	a, -1 (ix)
	ld	l,a
	ld	a,7 (ix)
	adc	a, #0x00
	ld	h,a
	ld	a,(hl)
	ld	(de),a
;..\..\..\libs\util\types.c:30: } while (index < MAX_NUMBER_OF_CONVERTED_DIGITS);
	ld	a,b
	sub	a, #0x10
	jr	C,00106$
;..\..\..\libs\util\types.c:32: string[i] = 0; /* string terminator */
	ld	l,6 (ix)
	ld	h,7 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x00
	ld	sp, ix
	pop	ix
	ret
;..\..\..\libs\util\types.c:35: void itoa(int value, char* string, int radix)
;	---------------------------------
; Function itoa
; ---------------------------------
_itoa::
	push	ix
	ld	ix,#0
	add	ix,sp
;..\..\..\libs\util\types.c:37: if (value < 0 && radix == 10) {
	bit	7, 5 (ix)
	jr	Z,00102$
	ld	a,8 (ix)
	sub	a, #0x0a
	jr	NZ,00102$
	ld	a,9 (ix)
	or	a, a
	jr	NZ,00102$
;..\..\..\libs\util\types.c:38: *string++ = '-';
	ld	l,6 (ix)
	ld	h,7 (ix)
	ld	(hl),#0x2d
	inc	hl
	ld	6 (ix),l
	ld	7 (ix),h
;..\..\..\libs\util\types.c:39: uitoa(-value, string, radix);
	xor	a, a
	sub	a, 4 (ix)
	ld	c,a
	ld	a, #0x00
	sbc	a, 5 (ix)
	ld	b,a
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	push	bc
	call	_uitoa
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
	jr	00105$
00102$:
;..\..\..\libs\util\types.c:42: uitoa(value, string, radix);
	ld	l,8 (ix)
	ld	h,9 (ix)
	push	hl
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_uitoa
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
00105$:
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
