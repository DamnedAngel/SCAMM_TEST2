#include "scamm_config.h"
#include "debug.h"

#include <stdbool.h>
#include "printf.h"

#include "msxbios.h"
#include "msxbiostools.h"
#include "msxkeyboard.h"
#include "msxvdp.h"

#include "dos2.h"

#include "errors.h"
#include "scamm_unpackscreen.h"
#include "scamm_menu.h"

#include "msx_fusion.h"

#define CHAPTER_START	0x8000

#define CUSTOMFONT_BASE		0x4000 - 0x0300 - 4
#define CUSTOMFONT_FIRST	0x4000 - 0x0300 - 2
#define CUSTOMFONT_FIRSTOUT	0x4000 - 0x0300 - 1
#define CUSTOMFONT_START	0x4000 - 0x0300

const char * const quitMsg = "Do you really wantto quit?\r\r   [Y]es   [N]o";

int8_t e[MAX_NUMBER_OF_CONVERTED_DIGITS + 1];
unsigned int book;
unsigned int lastBook;

bool endGame = false;

uint8_t testmsx2() {
	return readFromMainROM(BIOS_HWVER) >= 1 ? ERR_SUCCESS : ERR_NO_MSX2;
}

uint8_t loadConf() {
	return ERR_SUCCESS;
}

uint8_t setGameState() {
	return ERR_SUCCESS;
}

uint8_t loadGame() {
	return ERR_SUCCESS;
}

uint8_t loadFont() {
	uint16_t *gfb = (uint16_t*) CUSTOMFONT_BASE;
	uint16_t *gfs = (uint16_t*) CUSTOMFONT_START;
	uint8_t *gff = (uint8_t*) CUSTOMFONT_FIRST;

	int8_t hFile;
	int16_t size;
	char fileName[15] = "font.sca";
	debug2("Opening %s.", fileName);
	hFile = open(fileName, 0);
	if (hFile == -1) {
		return ERR_NO_FILEOPEN;
	}

	size = read(hFile, ((void *) CUSTOMFONT_FIRST), 0x302);
	if (last_error) {
		return ERR_NO_FILEREAD;
	}
	gfb[0] = (uint16_t) gfs - (gff[0]*8);

	if (close(hFile)) {
		return ERR_NO_FILECLOSE;
	}
	return ERR_SUCCESS;
}

uint8_t installInterruptHandler() {
	return ERR_SUCCESS;
}

uint8_t uninstallInterruptHandler() {
	return ERR_SUCCESS;
}

uint8_t loadScreen() {
	int8_t hFile;
	int16_t size;
	char fileName[15] = "book000.sca";
	fileName[6] = (char) (48 + book++);
	if (book > lastBook) {
		book = 0;
	}

	debug2("Opening %s.", fileName);
	hFile = open(fileName, 0);
	if (hFile == -1) {
		return ERR_NO_FILEOPEN;
	}

	size = read(hFile, (void *) CHAPTER_START, 0x5000);
	if (last_error) {
		return ERR_NO_FILEREAD;
	}

	vdp_disable_screen_and_interrupts();
	unpackScreen();
	vdp_enable_screen_and_interrupts();

	if (close(hFile)) {
		return ERR_NO_FILECLOSE;
	}
	return ERR_SUCCESS;
}


uint8_t runDemo() {
	uint8_t err = ERR_SUCCESS;
	uint8_t key;
	key = 0;
	book = 0;
	lastBook = 1;

	while ((key != 27) && (!err))
	{
		err = loadScreen();
		key = keyboard_chget();
	}
	return err;
}

void disableClick() {
	__asm
	xor a
		ld(#BIOS_CLIKSW), a
		__endasm;
}

void enableClick() {
	__asm
	ld a, #1
		ld(#BIOS_CLIKSW), a
		__endasm;
}

uint8_t runGame() {
	uint8_t err = ERR_SUCCESS;
	uint8_t key = 0;

	disableClick();
	vdp_color(255, 0, 0);
	vdp_screen(8);
	vdp_sprite_disable();

	loadFont();
	installInterruptHandler();
	
	endGame = false;
	lastBook = 1;
	book = 0;
	while (!endGame && (!err))
	{
		err = loadScreen();
		key = keyboard_chget();
		if (key == 27)
		{
			messageBoxCenter(quitMsg, 18, 4, 0, 255);
			key = keyboard_chget();
			endGame = key == 121;
			if (!endGame)
			{
				//showMenu();
			}
		}
	}
	uninstallInterruptHandler();

	vdp_sprite_enable();
	vdp_color(15, 4, 4);
	vdp_screen(0);
	enableClick();

	return err;
}

void main(void) {
	uint8_t err = ERR_SUCCESS;
	printf("SCAMM started.\r\n");
	printf("Testing for MSX2... ");
	err = testmsx2();
	if (!err) {
		printf("Ok.\r\n");
		printf("Loading game configuration file... ");
		err = loadConf();
		if (!err) {
			printf("Ok.\r\n");
			printf("Loading game file... ");
			err = loadGame();
			if (!err) {
				printf("Ok.\r\n");
				err = runGame();
			}
		}
	}

	if (err) {
		error2("Error %d .Aborting game.\r\n", err);
	}
	
	printf("You've been SCAMMed!\r\n");
	exit(err);
}
