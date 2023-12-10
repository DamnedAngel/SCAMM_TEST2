;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
	.module SCAMM
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _runGame
	.globl _loadScreen
	.globl _loadGame
	.globl _loadConf
	.globl _testmsx2
	.globl _unpackScreen
	.globl _vdp_set_screen0
	.globl _vdp_set_screen8
	.globl _vdp_enable_screen_and_interrupts
	.globl _vdp_disable_screen_and_interrupts
	.globl _vdp_sprite_enable
	.globl _vdp_sprite_disable
	.globl _exit
	.globl _read
	.globl _close
	.globl _open
	.globl _keyboard_chget
	.globl _readFromMainROM
	.globl _printf
	.globl _lastBook
	.globl _book
	.globl _e
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_e::
	.ds 17
_book::
	.ds 2
_lastBook::
	.ds 2
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
;SCAMM.c:33: uint8_t testmsx2() {
;	---------------------------------
; Function testmsx2
; ---------------------------------
_testmsx2::
	dec	sp
;SCAMM.c:34: return readFromMainROM(BIOS_HWVER) >= 1 ? ERR_SUCCESS : ERR_NO_MSX2;
	ld	hl,#0x002d
	push	hl
	call	_readFromMainROM
	pop	af
	ld	a,l
	xor	a, #0x80
	sub	a, #0x81
	jr	C,00103$
	ld	l,#0x00
	jr	00104$
00103$:
	ld	l,#0x01
00104$:
	inc	sp
	ret
;SCAMM.c:37: uint8_t loadConf() {
;	---------------------------------
; Function loadConf
; ---------------------------------
_loadConf::
;SCAMM.c:38: return ERR_SUCCESS;
	ld	l,#0x00
	ret
;SCAMM.c:41: uint8_t loadGame() {
;	---------------------------------
; Function loadGame
; ---------------------------------
_loadGame::
;SCAMM.c:42: return ERR_SUCCESS;
	ld	l,#0x00
	ret
;SCAMM.c:45: uint8_t loadScreen() {
;	---------------------------------
; Function loadScreen
; ---------------------------------
_loadScreen::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-17
	add	hl,sp
	ld	sp,hl
;SCAMM.c:48: char fileName[15] = "book000.sca";
	ld	hl,#0x0000
	add	hl,sp
	ld	c,l
	ld	b,h
	ld	(hl),#0x62
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl),#0x6f
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl),#0x6f
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	(hl),#0x6b
	ld	hl,#0x0004
	add	hl,bc
	ld	(hl),#0x30
	ld	hl,#0x0005
	add	hl,bc
	ld	(hl),#0x30
	ld	hl,#0x0006
	add	hl,bc
	ex	de,hl
	ld	a,#0x30
	ld	(de),a
	ld	hl,#0x0007
	add	hl,bc
	ld	(hl),#0x2e
	ld	hl,#0x0008
	add	hl,bc
	ld	(hl),#0x73
	ld	hl,#0x0009
	add	hl,bc
	ld	(hl),#0x63
	ld	hl,#0x000a
	add	hl,bc
	ld	(hl),#0x61
	ld	hl,#0x000b
	add	hl,bc
	ld	(hl),#0x00
	ld	hl,#0x000c
	add	hl,bc
	ld	(hl),#0x00
	ld	hl,#0x000d
	add	hl,bc
	ld	(hl),#0x00
	ld	hl,#0x000e
	add	hl,bc
	ld	(hl),#0x00
;SCAMM.c:49: fileName[6] = (char) (48 + book++);
	ld	hl,(_book)
	ld	-2 (ix),l
	ld	-1 (ix),h
	ld	iy,#_book
	inc	0 (iy)
	jr	NZ,00127$
	inc	1 (iy)
00127$:
	ld	a,-2 (ix)
	add	a, #0x30
	ld	(de),a
;SCAMM.c:50: if (book > lastBook) {
	ld	hl,#_lastBook
	ld	a,(hl)
	sub	a, 0 (iy)
	inc	hl
	ld	a,(hl)
	sbc	a, 1 (iy)
	jr	NC,00102$
;SCAMM.c:51: book = 0;
	ld	hl,#0x0000
	ld	(_book),hl
00102$:
;SCAMM.c:55: hFile = open(fileName, 0);
	xor	a, a
	push	af
	inc	sp
	push	bc
	call	_open
	pop	af
	inc	sp
	ld	b,l
;SCAMM.c:56: if (hFile == -1) {
	ld	a,b
	inc	a
	jr	NZ,00104$
;SCAMM.c:57: return ERR_NO_FILEOPEN;
	ld	l,#0x02
	jr	00109$
00104$:
;SCAMM.c:60: size = read(hFile, (void *) CHAPTER_START, 0x5000);
	push	bc
	ld	hl,#0x5000
	push	hl
	ld	h, #0x80
	push	hl
	push	bc
	inc	sp
	call	_read
	pop	af
	pop	af
	inc	sp
	pop	bc
;SCAMM.c:61: if (last_error) {
	ld	a,(#_last_error + 0)
	or	a, a
	jr	Z,00106$
;SCAMM.c:62: return ERR_NO_FILEREAD;
	ld	l,#0x04
	jr	00109$
00106$:
;SCAMM.c:65: unpackScreen();
	push	bc
	call	_unpackScreen
	inc	sp
	call	_close
	inc	sp
	ld	a,l
	or	a, a
	jr	Z,00108$
;SCAMM.c:68: return ERR_NO_FILECLOSE;
	ld	l,#0x03
	jr	00109$
00108$:
;SCAMM.c:70: return ERR_SUCCESS;
	ld	l,#0x00
00109$:
	ld	sp, ix
	pop	ix
	ret
;SCAMM.c:73: uint8_t runGame() {
;	---------------------------------
; Function runGame
; ---------------------------------
_runGame::
;SCAMM.c:74: uint8_t err = ERR_SUCCESS;
;SCAMM.c:76: key = 0;
	ld	bc,#0x0000
;SCAMM.c:77: book = 0;
	ld	hl,#0x0000
	ld	(_book),hl
;SCAMM.c:78: lastBook = 1;
	ld	l, #0x01
	ld	(_lastBook),hl
;SCAMM.c:80: while ((key != 27) && (!err))
00102$:
	ld	a,b
	sub	a, #0x1b
	jr	Z,00104$
	ld	a,c
	or	a, a
	jr	NZ,00104$
;SCAMM.c:82: vdp_disable_screen_and_interrupts();
	call	_vdp_disable_screen_and_interrupts
;SCAMM.c:83: err = loadScreen();
	call	_loadScreen
	ld	c,l
;SCAMM.c:84: vdp_enable_screen_and_interrupts();
	push	bc
	call	_vdp_enable_screen_and_interrupts
	call	_keyboard_chget
	pop	bc
	ld	b,l
	jr	00102$
00104$:
;SCAMM.c:88: return err;
	ld	l,c
	ret
;SCAMM.c:91: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;SCAMM.c:94: printf("SCAMM started.\r\n");
	ld	hl,#___str_1
	push	hl
	call	_printf
;SCAMM.c:95: printf("Testing for MSX2... ");
	ld	hl, #___str_2
	ex	(sp),hl
	call	_printf
	pop	af
;SCAMM.c:96: err = testmsx2();
	call	_testmsx2
;SCAMM.c:97: if (!err) {
	ld	a,l
	or	a, a
	jr	NZ,00106$
;SCAMM.c:98: printf("Ok.\r\n");
	ld	hl,#___str_3
	push	hl
	call	_printf
;SCAMM.c:99: printf("Loading game configuration file... ");
	ld	hl, #___str_4
	ex	(sp),hl
	call	_printf
	pop	af
;SCAMM.c:100: err = loadConf();
	call	_loadConf
;SCAMM.c:101: if (!err) {
	ld	a,l
	or	a, a
	jr	NZ,00106$
;SCAMM.c:102: printf("Ok.\r\n");
	ld	hl,#___str_3
	push	hl
	call	_printf
;SCAMM.c:103: printf("Loading game file... ");
	ld	hl, #___str_5
	ex	(sp),hl
	call	_printf
	pop	af
;SCAMM.c:104: err = loadGame();
	call	_loadGame
;SCAMM.c:105: if (!err) {
	ld	a,l
	or	a, a
	jr	NZ,00106$
;SCAMM.c:106: printf("Ok.\r\n");
	ld	hl,#___str_3
	push	hl
	call	_printf
	pop	af
;SCAMM.c:107: vdp_set_screen8();
	call	_vdp_set_screen8
;SCAMM.c:108: vdp_sprite_disable();
	call	_vdp_sprite_disable
;SCAMM.c:110: err = runGame();
	call	_runGame
;SCAMM.c:111: vdp_sprite_enable();
	push	hl
	call	_vdp_sprite_enable
	call	_vdp_set_screen0
	pop	hl
00106$:
;SCAMM.c:120: printf("You've been SCAMMed!\r\n");
	ld	bc,#___str_6+0
	push	hl
	push	bc
	call	_printf
	pop	af
	pop	hl
;SCAMM.c:121: exit(err);
	ld	a,l
	push	af
	inc	sp
	call	_exit
	inc	sp
	ret
___str_1:
	.ascii "SCAMM started."
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_2:
	.ascii "Testing for MSX2... "
	.db 0x00
___str_3:
	.ascii "Ok."
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_4:
	.ascii "Loading game configuration file... "
	.db 0x00
___str_5:
	.ascii "Loading game file... "
	.db 0x00
___str_6:
	.ascii "You've been SCAMMed!"
	.db 0x0d
	.db 0x0a
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
