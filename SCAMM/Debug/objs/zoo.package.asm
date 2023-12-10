; ----------------------------------------------------------------
; - Zoo Engine
; ----------------------------------------------------------------
	.include "I:/Emulator/MSX/DEV/libs/zoo/engine/zoo.reflection.r1_inheritance.asm"
	.include "I:/Emulator/MSX/DEV/libs/zoo/engine/zoo.macros.propertyaccessorsforclasses.asm"
	.include "I:/Emulator/MSX/DEV/libs/zoo/engine/zoo.macros.propertyaccessorsforobjects.asm"
	.include "I:/Emulator/MSX/DEV/libs/zoo/engine/zoo.macros.methodaccessorsforobjects.asm"
	
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
; - Object Size
; ----------------------------------------------------------------
Object._Size	.equ 2
Control._Size	.equ 11
Bitmap._Size	.equ 18
VDP._Size	.equ 2
VDP9938._Size	.equ 2
Panel._Size	.equ 14

; ----------------------------------------------------------------
; - Offsets
; ----------------------------------------------------------------
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


; ----------------------------------------------------------------
; - Methods References/Class Reflection Data
; ----------------------------------------------------------------
Object.pParentClass.offset	.equ 0
Object.pSProperties.offset	.equ 2
Object.pSMethods.offset	.equ 4
Object.ObjectSize.offset	.equ 6
Object._Constructor.offset	.equ 7
Object._Destructor.offset	.equ 9

Control.pParentClass.offset	.equ 0
Control.pSProperties.offset	.equ 2
Control.pSMethods.offset	.equ 4
Control.ObjectSize.offset	.equ 6
Control._Constructor.offset	.equ 7
Control._Destructor.offset	.equ 9
Control._OnPaint.offset	.equ 11
Control._Paint.offset	.equ 13

Bitmap.pParentClass.offset	.equ 0
Bitmap.pSProperties.offset	.equ 2
Bitmap.pSMethods.offset	.equ 4
Bitmap.ObjectSize.offset	.equ 6
Bitmap._Constructor.offset	.equ 7
Bitmap._Destructor.offset	.equ 9
Bitmap._OnPaint.offset	.equ 11
Bitmap._Paint.offset	.equ 13
Bitmap._PaintFromRAM.offset	.equ 15
Bitmap._PaintFromVRAM.offset	.equ 17

VDP.pParentClass.offset	.equ 0
VDP.pSProperties.offset	.equ 2
VDP.pSMethods.offset	.equ 4
VDP.ObjectSize.offset	.equ 6
VDP._Constructor.offset	.equ 7
VDP._Destructor.offset	.equ 9

VDP9938.pParentClass.offset	.equ 0
VDP9938.pSProperties.offset	.equ 2
VDP9938.pSMethods.offset	.equ 4
VDP9938.ObjectSize.offset	.equ 6
VDP9938._Constructor.offset	.equ 7
VDP9938._Destructor.offset	.equ 9

Panel.pParentClass.offset	.equ 0
Panel.pSProperties.offset	.equ 2
Panel.pSMethods.offset	.equ 4
Panel.ObjectSize.offset	.equ 6
Panel._Constructor.offset	.equ 7
Panel._Destructor.offset	.equ 9
Panel._OnPaint.offset	.equ 11
Panel._Paint.offset	.equ 13


; ----------------------------------------------------------------
; - Static Properties
; ----------------------------------------------------------------













; ----------------------------------------------------------------
; - Static Methods References
; ----------------------------------------------------------------



VDP._SColor.offset	.equ 0
VDP._RColor.offset	.equ 2
VDP._BColor.offset	.equ 4
VDP._SScreen.offset	.equ 6
VDP._RScreen.offset	.equ 8

VDP9938._SColor.offset	.equ 0
VDP9938._RColor.offset	.equ 2
VDP9938._BColor.offset	.equ 4
VDP9938._SScreen.offset	.equ 6
VDP9938._RScreen.offset	.equ 8
VDP9938._WaitReady.offset	.equ 10
VDP9938._HMMV.offset	.equ 12
VDP9938._RLineRightOrDown.offset	.equ 14
VDP9938._prepareCPUVRamTransfer.offset	.equ 16
VDP9938._TransparentCPUVRamTransfer.offset	.equ 18
VDP9938._CPUVRamTransfer.offset	.equ 20




; ----------------------------------------------------------------
; - Global symbols
; ----------------------------------------------------------------
; ----------------------------------------------------------------
; - Classes
; ----------------------------------------------------------------
	.globl	Object
	.globl	Control
	.globl	Bitmap
	.globl	VDP
	.globl	VDP9938
	.globl	Panel

; ----------------------------------------------------------------
; - Methods References/Class Reflection Data
; ----------------------------------------------------------------
	.globl	Object.pParentClass
	.globl	Object.pSProperties
	.globl	Object.pSMethods
	.globl	Object.ObjectSize
	.globl	Object._Constructor
	.globl	Object._Destructor

	.globl	Control.pParentClass
	.globl	Control.pSProperties
	.globl	Control.pSMethods
	.globl	Control.ObjectSize
	.globl	Control._Constructor
	.globl	Control._Destructor
	.globl	Control._Paint

	.globl	Bitmap.pParentClass
	.globl	Bitmap.pSProperties
	.globl	Bitmap.pSMethods
	.globl	Bitmap.ObjectSize
	.globl	Bitmap._Constructor
	.globl	Bitmap._Destructor
	.globl	Bitmap._Paint

	.globl	VDP.pParentClass
	.globl	VDP.pSProperties
	.globl	VDP.pSMethods
	.globl	VDP.ObjectSize
	.globl	VDP._Constructor
	.globl	VDP._Destructor

	.globl	VDP9938.pParentClass
	.globl	VDP9938.pSProperties
	.globl	VDP9938.pSMethods
	.globl	VDP9938.ObjectSize
	.globl	VDP9938._Constructor
	.globl	VDP9938._Destructor

	.globl	Panel.pParentClass
	.globl	Panel.pSProperties
	.globl	Panel.pSMethods
	.globl	Panel.ObjectSize
	.globl	Panel._Constructor
	.globl	Panel._Destructor
	.globl	Panel._Paint


; ----------------------------------------------------------------
; - Static Properties
; ----------------------------------------------------------------













; ----------------------------------------------------------------
; - Static Methods References
; ----------------------------------------------------------------



	.globl	VDP._SColor
	.globl	VDP._RColor
	.globl	VDP._BColor
	.globl	VDP._SScreen
	.globl	VDP._RScreen

	.globl	VDP9938._SColor
	.globl	VDP9938._RColor
	.globl	VDP9938._BColor
	.globl	VDP9938._SScreen
	.globl	VDP9938._RScreen
	.globl	VDP9938._WaitReady
	.globl	VDP9938._HMMV
	.globl	VDP9938._RLineRightOrDown
	.globl	VDP9938._prepareCPUVRamTransfer
	.globl	VDP9938._TransparentCPUVRamTransfer
	.globl	VDP9938._CPUVRamTransfer



; ----------------------------------------------------------------
; - Helper Macros symbols
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Methods Calls
; ----------------------------------------------------------------
	.macro	Object.Constructor_IY
	Zoo.CallMethod_IY Object, Constructor
	.endm
	.macro	Object.Destructor_IY
	Zoo.CallMethod_IY Object, Destructor
	.endm

	.macro	Control.Constructor_IY
	Zoo.CallMethod_IY Control, Constructor
	.endm
	.macro	Control.Destructor_IY
	Zoo.CallMethod_IY Control, Destructor
	.endm
	.macro	Control.OnPaint_IY
	Zoo.CallMethod_IY Control, OnPaint
	.endm
	.macro	Control.Paint_IY
	Zoo.CallMethod_IY Control, Paint
	.endm

	.macro	Bitmap.Constructor_IY
	Zoo.CallMethod_IY Bitmap, Constructor
	.endm
	.macro	Bitmap.Destructor_IY
	Zoo.CallMethod_IY Bitmap, Destructor
	.endm
	.macro	Bitmap.OnPaint_IY
	Zoo.CallMethod_IY Bitmap, OnPaint
	.endm
	.macro	Bitmap.Paint_IY
	Zoo.CallMethod_IY Bitmap, Paint
	.endm
	.macro	Bitmap.PaintFromRAM_IY
	Zoo.CallMethod_IY Bitmap, PaintFromRAM
	.endm
	.macro	Bitmap.PaintFromVRAM_IY
	Zoo.CallMethod_IY Bitmap, PaintFromVRAM
	.endm

	.macro	VDP.Constructor_IY
	Zoo.CallMethod_IY VDP, Constructor
	.endm
	.macro	VDP.Destructor_IY
	Zoo.CallMethod_IY VDP, Destructor
	.endm

	.macro	VDP9938.Constructor_IY
	Zoo.CallMethod_IY VDP9938, Constructor
	.endm
	.macro	VDP9938.Destructor_IY
	Zoo.CallMethod_IY VDP9938, Destructor
	.endm

	.macro	Panel.Constructor_IY
	Zoo.CallMethod_IY Panel, Constructor
	.endm
	.macro	Panel.Destructor_IY
	Zoo.CallMethod_IY Panel, Destructor
	.endm
	.macro	Panel.OnPaint_IY
	Zoo.CallMethod_IY Panel, OnPaint
	.endm
	.macro	Panel.Paint_IY
	Zoo.CallMethod_IY Panel, Paint
	.endm


; ----------------------------------------------------------------
; - Static Methods Calls
; ----------------------------------------------------------------



	.macro	VDP.SColor
	call VDP._SColor
	.endm
	.macro	VDP.RColor
	call VDP._RColor
	.endm
	.macro	VDP.BColor
	call VDP._BColor
	.endm
	.macro	VDP.SScreen
	call VDP._SScreen
	.endm
	.macro	VDP.RScreen
	call VDP._RScreen
	.endm

	.macro	VDP9938.SColor
	call VDP9938._SColor
	.endm
	.macro	VDP9938.RColor
	call VDP9938._RColor
	.endm
	.macro	VDP9938.BColor
	call VDP9938._BColor
	.endm
	.macro	VDP9938.SScreen
	call VDP9938._SScreen
	.endm
	.macro	VDP9938.RScreen
	call VDP9938._RScreen
	.endm
	.macro	VDP9938.WaitReady
	call VDP9938._WaitReady
	.endm
	.macro	VDP9938.HMMV
	call VDP9938._HMMV
	.endm
	.macro	VDP9938.RLineRightOrDown
	call VDP9938._RLineRightOrDown
	.endm
	.macro	VDP9938.prepareCPUVRamTransfer
	call VDP9938._prepareCPUVRamTransfer
	.endm
	.macro	VDP9938.TransparentCPUVRamTransfer
	call VDP9938._TransparentCPUVRamTransfer
	.endm
	.macro	VDP9938.CPUVRamTransfer
	call VDP9938._CPUVRamTransfer
	.endm



; ----------------------------------------------------------------
; - Class Property Accessors
; ----------------------------------------------------------------


; ----------------------------------------------------------------
; - Object Object direct accessor
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Accessors
; ----------------------------------------------------------------

	.macro Object._ObjectAccessors object


	.macro object'._SetIY
	Zoo.SetObj object
	.endm

	MethodAccessorsForObjects Object, object, Constructor 
	MethodAccessorsForObjects Object, object, Destructor 

	.endm

; ----------------------------------------------------------------
; - Create
; ----------------------------------------------------------------

	.macro Object._Create object
	Object._ObjectAccessors object

	.area _DATA

	object'._Start::

	object'::
	object'.pClass::	.dw Object	; Size = 2


	.area _CODE

	.endm

; ----------------------------------------------------------------
; - Construct
; ----------------------------------------------------------------

	.macro Object._Construct object

	Object._ObjectAccessors object

	.area _DATA


	object'._Start::

	object'::
	object'.pClass::	.dw Object	; Size = 2


	.area _CODE

	object'.Constructor
	
	.endm


; ----------------------------------------------------------------
; - Control.Flags
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Control, Flags
	PropertyPointersAccessorsForClasses Control, Flags
; ----------------------------------------------------------------
; - Control.X
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Control, X
	PropertyPointersAccessorsForClasses Control, X
; ----------------------------------------------------------------
; - Control.Y
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Control, Y
	PropertyPointersAccessorsForClasses Control, Y
; ----------------------------------------------------------------
; - Control.Width
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Control, Width
	PropertyPointersAccessorsForClasses Control, Width
; ----------------------------------------------------------------
; - Control.Height
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Control, Height
	PropertyPointersAccessorsForClasses Control, Height

; ----------------------------------------------------------------
; - Control Object direct accessor
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Accessors
; ----------------------------------------------------------------

	.macro Control._ObjectAccessors object
	Property8BitsAccessorsForObjects Control, object, Flags
	Property16BitsAccessorsForObjects Control, object, X
	Property16BitsAccessorsForObjects Control, object, Y
	Property16BitsAccessorsForObjects Control, object, Width
	Property16BitsAccessorsForObjects Control, object, Height


	.macro object'._SetIY
	Zoo.SetObj object
	.endm

	MethodAccessorsForObjects Control, object, Constructor 
	MethodAccessorsForObjects Control, object, Destructor 
	MethodAccessorsForObjects Control, object, Paint 

	.endm

; ----------------------------------------------------------------
; - Create
; ----------------------------------------------------------------

	.macro Control._Create object
	Control._ObjectAccessors object

	.area _DATA

	object'._Start::

	object'::
	object'.pClass::	.dw Control	; Size = 2

	object'.Flags::	.blkb #1	; 1 instances of size 1
	object'.X::	.blkb #2	; 1 instances of size 2
	object'.Y::	.blkb #2	; 1 instances of size 2
	object'.Width::	.blkb #2	; 1 instances of size 2
	object'.Height::	.blkb #2	; 1 instances of size 2

	.area _CODE

	.endm

; ----------------------------------------------------------------
; - Construct
; ----------------------------------------------------------------

	.macro Control._Construct object, Flags, X, Y, Width, Height

	Control._ObjectAccessors object

	.area _DATA


	object'._Start::

	object'::
	object'.pClass::	.dw Control	; Size = 2

	object'.Flags::	.db Flags	; 1 instances of size 1
	object'.X::	.dw X	; 1 instances of size 2
	object'.Y::	.dw Y	; 1 instances of size 2
	object'.Width::	.dw Width	; 1 instances of size 2
	object'.Height::	.dw Height	; 1 instances of size 2

	.area _CODE

	object'.Constructor
	
	.endm


; ----------------------------------------------------------------
; - Bitmap.Flags
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Bitmap, Flags
	PropertyPointersAccessorsForClasses Bitmap, Flags
; ----------------------------------------------------------------
; - Bitmap.X
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Bitmap, X
	PropertyPointersAccessorsForClasses Bitmap, X
; ----------------------------------------------------------------
; - Bitmap.Y
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Bitmap, Y
	PropertyPointersAccessorsForClasses Bitmap, Y
; ----------------------------------------------------------------
; - Bitmap.Width
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Bitmap, Width
	PropertyPointersAccessorsForClasses Bitmap, Width
; ----------------------------------------------------------------
; - Bitmap.Height
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Bitmap, Height
	PropertyPointersAccessorsForClasses Bitmap, Height
; ----------------------------------------------------------------
; - Bitmap.XBMP
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Bitmap, XBMP
	PropertyPointersAccessorsForClasses Bitmap, XBMP
; ----------------------------------------------------------------
; - Bitmap.YBMP
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Bitmap, YBMP
	PropertyPointersAccessorsForClasses Bitmap, YBMP
; ----------------------------------------------------------------
; - Bitmap.Direction
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Bitmap, Direction
	PropertyPointersAccessorsForClasses Bitmap, Direction
; ----------------------------------------------------------------
; - Bitmap.PaintOperation
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Bitmap, PaintOperation
	PropertyPointersAccessorsForClasses Bitmap, PaintOperation
; ----------------------------------------------------------------
; - Bitmap.TransparentColor
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Bitmap, TransparentColor
	PropertyPointersAccessorsForClasses Bitmap, TransparentColor

; ----------------------------------------------------------------
; - Bitmap Object direct accessor
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Accessors
; ----------------------------------------------------------------

	.macro Bitmap._ObjectAccessors object
	Property8BitsAccessorsForObjects Bitmap, object, Flags
	Property16BitsAccessorsForObjects Bitmap, object, X
	Property16BitsAccessorsForObjects Bitmap, object, Y
	Property16BitsAccessorsForObjects Bitmap, object, Width
	Property16BitsAccessorsForObjects Bitmap, object, Height
	Property16BitsAccessorsForObjects Bitmap, object, XBMP
	Property16BitsAccessorsForObjects Bitmap, object, YBMP
	Property8BitsAccessorsForObjects Bitmap, object, Direction
	Property8BitsAccessorsForObjects Bitmap, object, PaintOperation
	Property8BitsAccessorsForObjects Bitmap, object, TransparentColor


	.macro object'._SetIY
	Zoo.SetObj object
	.endm

	MethodAccessorsForObjects Bitmap, object, Constructor 
	MethodAccessorsForObjects Bitmap, object, Destructor 
	MethodAccessorsForObjects Bitmap, object, Paint 

	.endm

; ----------------------------------------------------------------
; - Create
; ----------------------------------------------------------------

	.macro Bitmap._Create object
	Bitmap._ObjectAccessors object

	.area _DATA

	object'._Start::

	object'::
	object'.pClass::	.dw Bitmap	; Size = 2

	object'.Flags::	.blkb #1	; 1 instances of size 1
	object'.X::	.blkb #2	; 1 instances of size 2
	object'.Y::	.blkb #2	; 1 instances of size 2
	object'.Width::	.blkb #2	; 1 instances of size 2
	object'.Height::	.blkb #2	; 1 instances of size 2
	object'.XBMP::	.blkb #2	; 1 instances of size 2
	object'.YBMP::	.blkb #2	; 1 instances of size 2
	object'.Direction::	.blkb #1	; 1 instances of size 1
	object'.PaintOperation::	.blkb #1	; 1 instances of size 1
	object'.TransparentColor::	.blkb #1	; 1 instances of size 1

	.area _CODE

	.endm

; ----------------------------------------------------------------
; - Construct
; ----------------------------------------------------------------

	.macro Bitmap._Construct object, Flags, X, Y, Width, Height, XBMP, YBMP, Direction, PaintOperation, TransparentColor

	Bitmap._ObjectAccessors object

	.area _DATA


	object'._Start::

	object'::
	object'.pClass::	.dw Bitmap	; Size = 2

	object'.Flags::	.db Flags	; 1 instances of size 1
	object'.X::	.dw X	; 1 instances of size 2
	object'.Y::	.dw Y	; 1 instances of size 2
	object'.Width::	.dw Width	; 1 instances of size 2
	object'.Height::	.dw Height	; 1 instances of size 2
	object'.XBMP::	.dw XBMP	; 1 instances of size 2
	object'.YBMP::	.dw YBMP	; 1 instances of size 2
	object'.Direction::	.db Direction	; 1 instances of size 1
	object'.PaintOperation::	.db PaintOperation	; 1 instances of size 1
	object'.TransparentColor::	.db TransparentColor	; 1 instances of size 1

	.area _CODE

	object'.Constructor
	
	.endm



; ----------------------------------------------------------------
; - VDP Object direct accessor
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Accessors
; ----------------------------------------------------------------

	.macro VDP._ObjectAccessors object


	.macro object'._SetIY
	Zoo.SetObj object
	.endm

	MethodAccessorsForObjects VDP, object, Constructor 
	MethodAccessorsForObjects VDP, object, Destructor 

	.endm

; ----------------------------------------------------------------
; - Create
; ----------------------------------------------------------------

	.macro VDP._Create object
	VDP._ObjectAccessors object

	.area _DATA

	object'._Start::

	object'::
	object'.pClass::	.dw VDP	; Size = 2


	.area _CODE

	.endm

; ----------------------------------------------------------------
; - Construct
; ----------------------------------------------------------------

	.macro VDP._Construct object

	VDP._ObjectAccessors object

	.area _DATA


	object'._Start::

	object'::
	object'.pClass::	.dw VDP	; Size = 2


	.area _CODE

	object'.Constructor
	
	.endm



; ----------------------------------------------------------------
; - VDP9938 Object direct accessor
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Accessors
; ----------------------------------------------------------------

	.macro VDP9938._ObjectAccessors object


	.macro object'._SetIY
	Zoo.SetObj object
	.endm

	MethodAccessorsForObjects VDP9938, object, Constructor 
	MethodAccessorsForObjects VDP9938, object, Destructor 

	.endm

; ----------------------------------------------------------------
; - Create
; ----------------------------------------------------------------

	.macro VDP9938._Create object
	VDP9938._ObjectAccessors object

	.area _DATA

	object'._Start::

	object'::
	object'.pClass::	.dw VDP9938	; Size = 2


	.area _CODE

	.endm

; ----------------------------------------------------------------
; - Construct
; ----------------------------------------------------------------

	.macro VDP9938._Construct object

	VDP9938._ObjectAccessors object

	.area _DATA


	object'._Start::

	object'::
	object'.pClass::	.dw VDP9938	; Size = 2


	.area _CODE

	object'.Constructor
	
	.endm


; ----------------------------------------------------------------
; - Panel.Flags
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Panel, Flags
	PropertyPointersAccessorsForClasses Panel, Flags
; ----------------------------------------------------------------
; - Panel.X
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Panel, X
	PropertyPointersAccessorsForClasses Panel, X
; ----------------------------------------------------------------
; - Panel.Y
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Panel, Y
	PropertyPointersAccessorsForClasses Panel, Y
; ----------------------------------------------------------------
; - Panel.Width
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Panel, Width
	PropertyPointersAccessorsForClasses Panel, Width
; ----------------------------------------------------------------
; - Panel.Height
; ----------------------------------------------------------------
	Property16BitsAccessorsForClasses Panel, Height
	PropertyPointersAccessorsForClasses Panel, Height
; ----------------------------------------------------------------
; - Panel.Color
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Panel, Color
	PropertyPointersAccessorsForClasses Panel, Color
; ----------------------------------------------------------------
; - Panel.Direction
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Panel, Direction
	PropertyPointersAccessorsForClasses Panel, Direction
; ----------------------------------------------------------------
; - Panel.PaintOperation
; ----------------------------------------------------------------
	Property8BitsAccessorsForClasses Panel, PaintOperation
	PropertyPointersAccessorsForClasses Panel, PaintOperation

; ----------------------------------------------------------------
; - Panel Object direct accessor
; ----------------------------------------------------------------

; ----------------------------------------------------------------
; - Accessors
; ----------------------------------------------------------------

	.macro Panel._ObjectAccessors object
	Property8BitsAccessorsForObjects Panel, object, Flags
	Property16BitsAccessorsForObjects Panel, object, X
	Property16BitsAccessorsForObjects Panel, object, Y
	Property16BitsAccessorsForObjects Panel, object, Width
	Property16BitsAccessorsForObjects Panel, object, Height
	Property8BitsAccessorsForObjects Panel, object, Color
	Property8BitsAccessorsForObjects Panel, object, Direction
	Property8BitsAccessorsForObjects Panel, object, PaintOperation


	.macro object'._SetIY
	Zoo.SetObj object
	.endm

	MethodAccessorsForObjects Panel, object, Constructor 
	MethodAccessorsForObjects Panel, object, Destructor 
	MethodAccessorsForObjects Panel, object, Paint 

	.endm

; ----------------------------------------------------------------
; - Create
; ----------------------------------------------------------------

	.macro Panel._Create object
	Panel._ObjectAccessors object

	.area _DATA

	object'._Start::

	object'::
	object'.pClass::	.dw Panel	; Size = 2

	object'.Flags::	.blkb #1	; 1 instances of size 1
	object'.X::	.blkb #2	; 1 instances of size 2
	object'.Y::	.blkb #2	; 1 instances of size 2
	object'.Width::	.blkb #2	; 1 instances of size 2
	object'.Height::	.blkb #2	; 1 instances of size 2
	object'.Color::	.blkb #1	; 1 instances of size 1
	object'.Direction::	.blkb #1	; 1 instances of size 1
	object'.PaintOperation::	.blkb #1	; 1 instances of size 1

	.area _CODE

	.endm

; ----------------------------------------------------------------
; - Construct
; ----------------------------------------------------------------

	.macro Panel._Construct object, Flags, X, Y, Width, Height, Color, Direction, PaintOperation

	Panel._ObjectAccessors object

	.area _DATA


	object'._Start::

	object'::
	object'.pClass::	.dw Panel	; Size = 2

	object'.Flags::	.db Flags	; 1 instances of size 1
	object'.X::	.dw X	; 1 instances of size 2
	object'.Y::	.dw Y	; 1 instances of size 2
	object'.Width::	.dw Width	; 1 instances of size 2
	object'.Height::	.dw Height	; 1 instances of size 2
	object'.Color::	.db Color	; 1 instances of size 1
	object'.Direction::	.db Direction	; 1 instances of size 1
	object'.PaintOperation::	.db PaintOperation	; 1 instances of size 1

	.area _CODE

	object'.Constructor
	
	.endm


