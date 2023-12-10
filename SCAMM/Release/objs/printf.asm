;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
	.module printf
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sprintf
	.globl _printf
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
;..\..\..\libs\util\printf.c:28: static void printchar(char **str, int c)
;	---------------------------------
; Function printchar
; ---------------------------------
_printchar:
	push	ix
	ld	ix,#0
	add	ix,sp
;..\..\..\libs\util\printf.c:31: if (str) {
	ld	a,5 (ix)
	or	a,4 (ix)
	jr	Z,00102$
;..\..\..\libs\util\printf.c:32: **str = c;
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	l, c
	ld	h, b
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,6 (ix)
	ld	(de),a
;..\..\..\libs\util\printf.c:33: ++(*str);
	ld	l, c
	ld	h, b
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	de
	ld	a,e
	ld	(bc),a
	inc	bc
	ld	a,d
	ld	(bc),a
	jr	00104$
00102$:
;..\..\..\libs\util\printf.c:35: else (void)putchar(c);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	call	_putchar
	pop	af
00104$:
	pop	ix
	ret
;..\..\..\libs\util\printf.c:41: static int prints(char **out, const char *string, int width, int pad)
;	---------------------------------
; Function prints
; ---------------------------------
_prints:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;..\..\..\libs\util\printf.c:43: register int pc = 0, padchar = ' ';
	ld	bc,#0x0000
	ld	hl,#0x0020
	ex	(sp), hl
;..\..\..\libs\util\printf.c:48: for (ptr = string; *ptr; ++ptr) ++len;
	ld	a,6 (ix)
	ld	-2 (ix),a
	ld	a,7 (ix)
	ld	-1 (ix),a
;..\..\..\libs\util\printf.c:45: if (width > 0) {
	xor	a, a
	cp	a, 8 (ix)
	sbc	a, 9 (ix)
	jp	PO, 00179$
	xor	a, #0x80
00179$:
	jp	P,00108$
;..\..\..\libs\util\printf.c:48: for (ptr = string; *ptr; ++ptr) ++len;
	ld	de,#0x0000
	ld	l,-2 (ix)
	ld	h,-1 (ix)
00115$:
	ld	a,(hl)
	or	a, a
	jr	Z,00101$
	inc	de
	inc	hl
	jr	00115$
00101$:
;..\..\..\libs\util\printf.c:49: if (len >= width) width = 0;
	ld	a,e
	sub	a, 8 (ix)
	ld	a,d
	sbc	a, 9 (ix)
	jp	PO, 00180$
	xor	a, #0x80
00180$:
	jp	M,00103$
	ld	8 (ix),#0x00
	ld	9 (ix),#0x00
	jr	00104$
00103$:
;..\..\..\libs\util\printf.c:50: else width -= len;
	ld	a,8 (ix)
	sub	a, e
	ld	8 (ix),a
	ld	a,9 (ix)
	sbc	a, d
	ld	9 (ix),a
00104$:
;..\..\..\libs\util\printf.c:51: if (pad & PAD_ZERO) padchar = '0';
	bit	1, 10 (ix)
	jr	Z,00108$
	ld	hl,#0x0030
	ex	(sp), hl
00108$:
;..\..\..\libs\util\printf.c:53: if (!(pad & PAD_RIGHT)) {
	bit	0, 10 (ix)
	jr	NZ,00136$
	ld	bc,#0x0000
	ld	e,8 (ix)
	ld	d,9 (ix)
00118$:
;..\..\..\libs\util\printf.c:54: for ( ; width > 0; --width) {
	xor	a, a
	cp	a, e
	sbc	a, d
	jp	PO, 00184$
	xor	a, #0x80
00184$:
	jp	P,00140$
;..\..\..\libs\util\printf.c:55: printchar (out, padchar);
	push	bc
	push	de
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_printchar
	pop	af
	pop	af
	pop	de
	pop	bc
;..\..\..\libs\util\printf.c:56: ++pc;
	inc	bc
;..\..\..\libs\util\printf.c:54: for ( ; width > 0; --width) {
	dec	de
	jr	00118$
00140$:
	ld	8 (ix),e
	ld	9 (ix),d
00136$:
	ld	e,-2 (ix)
	ld	d,-1 (ix)
00121$:
;..\..\..\libs\util\printf.c:59: for ( ; *string ; ++string) {
	ld	a,(de)
	or	a, a
	jr	Z,00138$
;..\..\..\libs\util\printf.c:60: printchar (out, *string);
	ld	l,a
	ld	h,#0x00
	push	bc
	push	de
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_printchar
	pop	af
	pop	af
	pop	de
	pop	bc
;..\..\..\libs\util\printf.c:61: ++pc;
	inc	bc
;..\..\..\libs\util\printf.c:59: for ( ; *string ; ++string) {
	inc	de
	jr	00121$
00138$:
	ld	e,8 (ix)
	ld	d,9 (ix)
00124$:
;..\..\..\libs\util\printf.c:63: for ( ; width > 0; --width) {
	xor	a, a
	cp	a, e
	sbc	a, d
	jp	PO, 00185$
	xor	a, #0x80
00185$:
	jp	P,00113$
;..\..\..\libs\util\printf.c:64: printchar (out, padchar);
	push	bc
	push	de
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_printchar
	pop	af
	pop	af
	pop	de
	pop	bc
;..\..\..\libs\util\printf.c:65: ++pc;
	inc	bc
;..\..\..\libs\util\printf.c:63: for ( ; width > 0; --width) {
	dec	de
	jr	00124$
00113$:
;..\..\..\libs\util\printf.c:68: return pc;
	ld	l, c
	ld	h, b
	ld	sp, ix
	pop	ix
	ret
;..\..\..\libs\util\printf.c:74: static int printi(char **out, int i, int b, int sg, int width, int pad, int letbase)
;	---------------------------------
; Function printi
; ---------------------------------
_printi:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-20
	add	hl,sp
	ld	sp,hl
;..\..\..\libs\util\printf.c:78: register int t, neg = 0, pc = 0;
	ld	bc,#0x0000
	ld	hl,#0x0000
	ex	(sp), hl
;..\..\..\libs\util\printf.c:79: register unsigned int u = i;
	ld	e,6 (ix)
	ld	d,7 (ix)
;..\..\..\libs\util\printf.c:81: if (i == 0) {
	ld	a,d
	or	a,e
	jr	NZ,00102$
;..\..\..\libs\util\printf.c:82: print_buf[0] = '0';
	ld	hl,#0x0002
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	(hl),#0x30
;..\..\..\libs\util\printf.c:83: print_buf[1] = '\0';
	ld	e, c
	ld	d, b
	inc	de
	xor	a, a
	ld	(de),a
;..\..\..\libs\util\printf.c:84: return prints (out, print_buf, width, pad);
	ld	l,14 (ix)
	ld	h,15 (ix)
	push	hl
	ld	l,12 (ix)
	ld	h,13 (ix)
	push	hl
	push	bc
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_prints
	pop	af
	pop	af
	pop	af
	pop	af
	jp	00118$
00102$:
;..\..\..\libs\util\printf.c:87: if (sg && b == 10 && i < 0) {
	ld	a,11 (ix)
	or	a,10 (ix)
	jr	Z,00104$
	ld	a,8 (ix)
	sub	a, #0x0a
	jr	NZ,00104$
	ld	a,9 (ix)
	or	a, a
	jr	NZ,00104$
	bit	7, 7 (ix)
	jr	Z,00104$
;..\..\..\libs\util\printf.c:88: neg = 1;
	ld	bc,#0x0001
;..\..\..\libs\util\printf.c:89: u = -i;
	xor	a, a
	sub	a, e
	ld	e,a
	ld	a, #0x00
	sbc	a, d
	ld	d,a
00104$:
;..\..\..\libs\util\printf.c:92: s = print_buf + PRINT_BUF_LEN-1;
	ld	hl,#0x000d
	add	hl,sp
;..\..\..\libs\util\printf.c:93: *s = '\0';
	ld	(hl),#0x00
;..\..\..\libs\util\printf.c:95: while (u) {
	ld	a,16 (ix)
	add	a,#0xc6
	ld	-6 (ix),a
	ld	a,17 (ix)
	adc	a,#0xff
	ld	-5 (ix),a
	ld	-4 (ix),l
	ld	-3 (ix),h
00109$:
	ld	a,d
	or	a,e
	jr	Z,00130$
;..\..\..\libs\util\printf.c:96: t = u % b;
	ld	a,8 (ix)
	ld	-2 (ix),a
	ld	a,9 (ix)
	ld	-1 (ix),a
	push	bc
	push	de
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	push	de
	call	__moduint
	pop	af
	pop	af
	pop	de
	pop	bc
;..\..\..\libs\util\printf.c:97: if( t >= 10 )
	ld	a,l
	sub	a, #0x0a
	ld	a,h
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C,00108$
;..\..\..\libs\util\printf.c:98: t += letbase - '0' - 10;
	ld	a,l
	add	a, -6 (ix)
	ld	l,a
	ld	a,h
	adc	a, -5 (ix)
00108$:
;..\..\..\libs\util\printf.c:99: *--s = t + '0';
	ld	a,-4 (ix)
	add	a,#0xff
	ld	-4 (ix),a
	ld	a,-3 (ix)
	adc	a,#0xff
	ld	-3 (ix),a
	ld	a,l
	add	a, #0x30
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	ld	(hl),a
;..\..\..\libs\util\printf.c:100: u /= b;
	push	bc
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	push	de
	call	__divuint
	pop	af
	pop	af
	ex	de,hl
	pop	bc
	jr	00109$
00130$:
	ld	l,-4 (ix)
	ld	h,-3 (ix)
;..\..\..\libs\util\printf.c:103: if (neg) {
	ld	a,b
	or	a,c
	jr	Z,00117$
;..\..\..\libs\util\printf.c:104: if( width && (pad & PAD_ZERO) ) {
	ld	a,13 (ix)
	or	a,12 (ix)
	jr	Z,00113$
	bit	1, 14 (ix)
	jr	Z,00113$
;..\..\..\libs\util\printf.c:105: printchar (out, '-');
	push	hl
	ld	bc,#0x002d
	push	bc
	ld	c,4 (ix)
	ld	b,5 (ix)
	push	bc
	call	_printchar
	pop	af
	pop	af
	pop	hl
;..\..\..\libs\util\printf.c:106: ++pc;
	ld	-20 (ix),#0x01
	ld	-19 (ix),#0x00
;..\..\..\libs\util\printf.c:107: --width;
	ld	a,12 (ix)
	add	a,#0xff
	ld	12 (ix),a
	ld	a,13 (ix)
	adc	a,#0xff
	ld	13 (ix),a
	jr	00117$
00113$:
;..\..\..\libs\util\printf.c:110: *--s = '-';
	dec	hl
	ld	(hl),#0x2d
00117$:
;..\..\..\libs\util\printf.c:114: return pc + prints (out, s, width, pad);
	ld	c,14 (ix)
	ld	b,15 (ix)
	push	bc
	ld	c,12 (ix)
	ld	b,13 (ix)
	push	bc
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_prints
	pop	af
	pop	af
	pop	af
	pop	af
	pop	de
	push	de
	add	hl,de
00118$:
	ld	sp, ix
	pop	ix
	ret
;..\..\..\libs\util\printf.c:117: static int print(char **out, int *varg)
;	---------------------------------
; Function print
; ---------------------------------
_print:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-19
	add	hl,sp
	ld	sp,hl
;..\..\..\libs\util\printf.c:120: register int pc = 0;
	ld	bc,#0x0000
;..\..\..\libs\util\printf.c:121: register char *format = (char *)(*varg++);
	ld	l,6 (ix)
	ld	h,7 (ix)
	push	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	hl
	inc	hl
	inc	hl
	ld	6 (ix),l
	ld	7 (ix),h
	ld	-8 (ix),e
	ld	-7 (ix),d
;..\..\..\libs\util\printf.c:178: return pc;
00136$:
;..\..\..\libs\util\printf.c:124: for (; *format != 0; ++format) {
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	l,(hl)
	ld	a,l
	or	a, a
	jp	Z,00128$
;..\..\..\libs\util\printf.c:125: if (*format == '%') {
	ld	a,l
	sub	a, #0x25
	jp	NZ,00123$
;..\..\..\libs\util\printf.c:126: ++format;
	inc	-8 (ix)
	jr	NZ,00223$
	inc	-7 (ix)
00223$:
;..\..\..\libs\util\printf.c:127: width = pad = 0;
	ld	de,#0x0000
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
;..\..\..\libs\util\printf.c:124: for (; *format != 0; ++format) {
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	ld	l,(hl)
;..\..\..\libs\util\printf.c:128: if (*format == '\0') break;
	ld	a,l
	or	a, a
	jp	Z,00128$
;..\..\..\libs\util\printf.c:129: if (*format == '%') goto out;
;..\..\..\libs\util\printf.c:130: if (*format == '-') {
	ld	a,l
	cp	a,#0x25
	jp	Z,00123$
	sub	a, #0x2d
	jr	NZ,00149$
;..\..\..\libs\util\printf.c:131: ++format;
	inc	-8 (ix)
	jr	NZ,00227$
	inc	-7 (ix)
00227$:
;..\..\..\libs\util\printf.c:132: pad = PAD_RIGHT;
	ld	de,#0x0001
;..\..\..\libs\util\printf.c:134: while (*format == '0') {
00149$:
	ld	l,-8 (ix)
	ld	h,-7 (ix)
00107$:
	ld	a,(hl)
	sub	a, #0x30
	jr	NZ,00152$
;..\..\..\libs\util\printf.c:135: ++format;
	inc	hl
;..\..\..\libs\util\printf.c:136: pad |= PAD_ZERO;
	set	1, e
	jr	00107$
00152$:
	ld	-15 (ix),l
	ld	-14 (ix),h
00133$:
;..\..\..\libs\util\printf.c:138: for ( ; *format >= '0' && *format <= '9'; ++format) {
	ld	l,-15 (ix)
	ld	h,-14 (ix)
	ld	a,(hl)
	ld	-11 (ix), a
	sub	a, #0x30
	jr	C,00163$
	ld	a,#0x39
	sub	a, -11 (ix)
	jr	C,00163$
;..\..\..\libs\util\printf.c:139: width *= 10;
	push	de
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	pop	de
	ld	-13 (ix),l
	ld	-12 (ix),h
;..\..\..\libs\util\printf.c:140: width += *format - '0';
	ld	a, -11 (ix)
	ld	h, #0x00
	add	a,#0xd0
	ld	l,a
	ld	a,h
	adc	a,#0xff
	ld	h,a
	ld	a,-13 (ix)
	add	a, l
	ld	-2 (ix),a
	ld	a,-12 (ix)
	adc	a, h
	ld	-1 (ix),a
;..\..\..\libs\util\printf.c:138: for ( ; *format >= '0' && *format <= '9'; ++format) {
	inc	-15 (ix)
	jr	NZ,00133$
	inc	-14 (ix)
	jr	00133$
00163$:
	ld	a,-15 (ix)
	ld	-8 (ix),a
	ld	a,-14 (ix)
	ld	-7 (ix),a
;..\..\..\libs\util\printf.c:121: register char *format = (char *)(*varg++);
	ld	a,6 (ix)
	ld	-10 (ix),a
	ld	a,7 (ix)
	ld	-9 (ix),a
;..\..\..\libs\util\printf.c:143: register char *s = *((char **)varg++);
	ld	a,-10 (ix)
	add	a, #0x02
	ld	-4 (ix),a
	ld	a,-9 (ix)
	adc	a, #0x00
	ld	-3 (ix),a
;..\..\..\libs\util\printf.c:142: if( *format == 's' ) {
	ld	a,-11 (ix)
	sub	a, #0x73
	jr	NZ,00112$
;..\..\..\libs\util\printf.c:143: register char *s = *((char **)varg++);
	ld	a,-4 (ix)
	ld	6 (ix),a
	ld	a,-3 (ix)
	ld	7 (ix),a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	a,(hl)
	ld	-19 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-18 (ix),a
	ld	a,-19 (ix)
	ld	-6 (ix),a
	ld	a,-18 (ix)
	ld	-5 (ix),a
;..\..\..\libs\util\printf.c:144: pc += prints (out, s?s:"(null)", width, pad);
	ld	a,-18 (ix)
	or	a,-19 (ix)
	jr	Z,00141$
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	jr	00142$
00141$:
	ld	hl,#___str_0
00142$:
	push	bc
	push	de
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	push	de
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_prints
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
	add	hl,bc
	ld	c,l
	ld	b,h
;..\..\..\libs\util\printf.c:145: continue;
	jp	00127$
00112$:
;..\..\..\libs\util\printf.c:147: if( *format == 'd' ) {
	ld	a,-11 (ix)
	sub	a, #0x64
	jr	NZ,00114$
;..\..\..\libs\util\printf.c:148: pc += printi (out, *varg++, 10, 1, width, pad, 'a');
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	a,(hl)
	ld	-6 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-5 (ix),a
	ld	a,-4 (ix)
	ld	6 (ix),a
	ld	a,-3 (ix)
	ld	7 (ix),a
	push	bc
	ld	hl,#0x0061
	push	hl
	push	de
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	hl,#0x0001
	push	hl
	ld	l, #0x0a
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_printi
	ld	iy,#14
	add	iy,sp
	ld	sp,iy
	pop	bc
	add	hl,bc
	ld	c,l
	ld	b,h
;..\..\..\libs\util\printf.c:149: continue;
	jp	00127$
00114$:
;..\..\..\libs\util\printf.c:151: if( *format == 'x' ) {
	ld	a,-11 (ix)
	sub	a, #0x78
	jr	NZ,00116$
;..\..\..\libs\util\printf.c:152: pc += printi (out, *varg++, 16, 0, width, pad, 'a');
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	a,(hl)
	ld	-6 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-5 (ix),a
	ld	a,-4 (ix)
	ld	6 (ix),a
	ld	a,-3 (ix)
	ld	7 (ix),a
	push	bc
	ld	hl,#0x0061
	push	hl
	push	de
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l, #0x10
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_printi
	ld	iy,#14
	add	iy,sp
	ld	sp,iy
	pop	bc
	add	hl,bc
	ld	c,l
	ld	b,h
;..\..\..\libs\util\printf.c:153: continue;
	jp	00127$
00116$:
;..\..\..\libs\util\printf.c:155: if( *format == 'X' ) {
	ld	a,-11 (ix)
	sub	a, #0x58
	jr	NZ,00118$
;..\..\..\libs\util\printf.c:156: pc += printi (out, *varg++, 16, 0, width, pad, 'A');
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	a,(hl)
	ld	-6 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-5 (ix),a
	ld	a,-4 (ix)
	ld	6 (ix),a
	ld	a,-3 (ix)
	ld	7 (ix),a
	push	bc
	ld	hl,#0x0041
	push	hl
	push	de
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l, #0x10
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_printi
	ld	iy,#14
	add	iy,sp
	ld	sp,iy
	pop	bc
	add	hl,bc
	ld	c,l
	ld	b,h
;..\..\..\libs\util\printf.c:157: continue;
	jp	00127$
00118$:
;..\..\..\libs\util\printf.c:159: if( *format == 'u' ) {
	ld	a,-11 (ix)
	sub	a, #0x75
	jr	NZ,00120$
;..\..\..\libs\util\printf.c:160: pc += printi (out, *varg++, 10, 0, width, pad, 'a');
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	a,(hl)
	ld	-6 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-5 (ix),a
	ld	a,-4 (ix)
	ld	6 (ix),a
	ld	a,-3 (ix)
	ld	7 (ix),a
	push	bc
	ld	hl,#0x0061
	push	hl
	push	de
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	hl,#0x0000
	push	hl
	ld	l, #0x0a
	push	hl
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_printi
	ld	iy,#14
	add	iy,sp
	ld	sp,iy
	pop	bc
	add	hl,bc
	ld	c,l
	ld	b,h
;..\..\..\libs\util\printf.c:161: continue;
	jr	00127$
00120$:
;..\..\..\libs\util\printf.c:163: if( *format == 'c' ) {
	ld	a,-11 (ix)
	sub	a, #0x63
	jr	NZ,00127$
;..\..\..\libs\util\printf.c:165: scr[0] = *varg++;
	ld	hl,#0x0002
	add	hl,sp
	ld	-6 (ix),l
	ld	-5 (ix),h
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	a, (hl)
	inc	hl
	ld	h,(hl)
	ld	l,a
	ld	a,-4 (ix)
	ld	6 (ix),a
	ld	a,-3 (ix)
	ld	7 (ix),a
	ld	a,l
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	ld	(hl),a
;..\..\..\libs\util\printf.c:166: scr[1] = '\0';
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	inc	hl
	ld	(hl),#0x00
;..\..\..\libs\util\printf.c:167: pc += prints (out, scr, width, pad);
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	bc
	push	de
	ld	e,-2 (ix)
	ld	d,-1 (ix)
	push	de
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_prints
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
	add	hl,bc
	ld	c,l
	ld	b,h
;..\..\..\libs\util\printf.c:168: continue;
	jr	00127$
;..\..\..\libs\util\printf.c:172: out:
00123$:
;..\..\..\libs\util\printf.c:173: printchar (out, *format);
	ld	h,#0x00
	push	bc
	push	hl
	ld	l,4 (ix)
	ld	h,5 (ix)
	push	hl
	call	_printchar
	pop	af
	pop	af
	pop	bc
;..\..\..\libs\util\printf.c:174: ++pc;
	inc	bc
00127$:
;..\..\..\libs\util\printf.c:124: for (; *format != 0; ++format) {
	inc	-8 (ix)
	jp	NZ,00136$
	inc	-7 (ix)
	jp	00136$
00128$:
;..\..\..\libs\util\printf.c:177: if (out) **out = '\0';
	ld	a,5 (ix)
	or	a,4 (ix)
	jr	Z,00130$
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	xor	a, a
	ld	(de),a
00130$:
;..\..\..\libs\util\printf.c:178: return pc;
	ld	l, c
	ld	h, b
	ld	sp, ix
	pop	ix
	ret
___str_0:
	.ascii "(null)"
	.db 0x00
;..\..\..\libs\util\printf.c:183: int printf(const char *format, ...)
;	---------------------------------
; Function printf
; ---------------------------------
_printf::
;..\..\..\libs\util\printf.c:185: register int *varg = (int *)(&format);
	ld	hl,#0x0002
	add	hl,sp
;..\..\..\libs\util\printf.c:186: return print(0, varg);
	push	hl
	ld	hl,#0x0000
	push	hl
	call	_print
	pop	af
	pop	af
	ret
;..\..\..\libs\util\printf.c:189: int sprintf(char *out, const char *format, ...)
;	---------------------------------
; Function sprintf
; ---------------------------------
_sprintf::
	push	ix
;..\..\..\libs\util\printf.c:191: register int *varg = (int *)(&format);
	ld	hl,#0x0006
	add	hl,sp
	ld	c,l
	ld	b,h
;..\..\..\libs\util\printf.c:192: return print(&out, varg);
	ld	hl,#0x0004
	add	hl,sp
	push	bc
	push	hl
	call	_print
	pop	af
	pop	af
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
