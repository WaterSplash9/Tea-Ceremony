
	#pragma AVRPART ADMIN PART_NAME ATmega328P
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2303
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x08FF
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _firststart=R3
	.DEF _temp11=R5
	.DEF _temp22=R7
	.DEF _temp1=R9
	.DEF _temp2=R11
	.DEF _data=R13

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_conv_delay_G100:
	.DB  0x64,0x0,0xC8,0x0,0x90,0x1,0x20,0x3
_bit_mask_G100:
	.DB  0xF8,0xFF,0xFC,0xFF,0xFE,0xFF,0xFF,0xFF
_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x1C:
	.DB  0x3,0x0,0x1D,0x0,0x1F,0x0
_0x0:
	.DB  0x70,0x77,0x6D,0x3D,0x25,0x69,0x20,0x20
	.DB  0x20,0x20,0x3B,0x0,0x74,0x3D,0x25,0x69
	.DB  0x20,0x43,0x0,0x57,0x72,0x69,0x74,0x65
	.DB  0x20,0x74,0x65,0x6D,0x70,0x31,0x0,0x54
	.DB  0x65,0x6D,0x70,0x31,0x20,0x3D,0x20,0x0
	.DB  0x33,0x30,0x0,0x54,0x65,0x6D,0x70,0x32
	.DB  0x20,0x3D,0x20,0x0,0x33,0x35,0x0,0x54
	.DB  0x68,0x65,0x72,0x6D,0x6F,0x20,0x4F,0x46
	.DB  0x46,0x0,0x54,0x68,0x65,0x72,0x6D,0x6F
	.DB  0x20,0x4F,0x4E,0x0

__GLOBAL_INI_TBL:
	.DW  0x06
	.DW  0x03
	.DW  _0x1C*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x300

	.CSEG
;/*
;
;
;Chip type               : ATmega328P
;Program type            : Application
;AVR Core Clock frequency: 8,000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*/
;
;#include <mega328p.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif
;#include <ds18b20.h>
;#include <1wire.h>
;// Standard Input/Output functions
;#include <stdio.h>
;#include <delay.h>
;
;int firststart=3;
; int temp11=29;
; int temp22=31;
;int temp1;
;int temp2;
;int data;
;int temp;
;int pwm;
;unsigned char RomCode[2][9];
;// Declare your global variables here
;void setPWM(int temperature)
; 0000 001E {   if(temperature>20&&temperature<35)

	.CSEG
;	temperature -> Y+0
; 0000 001F     {
; 0000 0020     OCR0A=17*temp-20*17;
; 0000 0021     pwm=   17*temp-20*17;
; 0000 0022     printf("pwm=%i    ;",pwm);
; 0000 0023     }
; 0000 0024 else if(temperature<20)
; 0000 0025 OCR0A=0;
; 0000 0026 else
; 0000 0027 OCR0A=255;
; 0000 0028 }
;
;
; void writetemp()
; 0000 002C {
_writetemp:
; 0000 002D                         temp=ds18b20_temperature(0);  //?????? ???????????
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _ds18b20_temperature
	LDI  R26,LOW(_temp)
	LDI  R27,HIGH(_temp)
	CALL __CFD1
	ST   X+,R30
	ST   X,R31
; 0000 002E           if (temp>1000){               //???? ?????? ?????? ?????? 1000
	CALL SUBOPT_0x0
	CPI  R26,LOW(0x3E9)
	LDI  R30,HIGH(0x3E9)
	CPC  R27,R30
	BRLT _0x9
; 0000 002F              temp=4096-temp;            //???????? ?? ?????? 4096
	CALL SUBOPT_0x0
	LDI  R30,LOW(4096)
	LDI  R31,HIGH(4096)
	SUB  R30,R26
	SBC  R31,R27
	STS  _temp,R30
	STS  _temp+1,R31
; 0000 0030              temp=-temp;                //? ?????? ???? "?????"
	CALL __ANEGW1
	STS  _temp,R30
	STS  _temp+1,R31
; 0000 0031           }
; 0000 0032           printf("t=%i C",temp);    //????????? ????? ??? ?????? ??????????? ? ??? ?????
_0x9:
	__POINTW1FN _0x0,12
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_temp
	LDS  R31,_temp+1
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,4
	RCALL _printf
	RJMP _0x2080003
; 0000 0033 
; 0000 0034        //   lcd_clear();                //?????? ??????? ????? ???????
; 0000 0035        //   lcd_puts(lcd_buffer);        //??????? ????? ?? LCD
; 0000 0036         //  delay_ms(500);              //???? 500??
; 0000 0037 }
;
;
;
;void main(void)
; 0000 003C {
_main:
; 0000 003D  int startUDR0=UDR0;
; 0000 003E 
; 0000 003F int i=0;
; 0000 0040 // Declare your local variables here
; 0000 0041 unsigned char devices;
; 0000 0042 
; 0000 0043 devices = w1_init();
;	startUDR0 -> R16,R17
;	i -> R18,R19
;	devices -> R21
	LDS  R30,198
	LDI  R31,0
	MOVW R16,R30
	__GETWRN 18,19,0
	CALL _w1_init
	MOV  R21,R30
; 0000 0044 // Crystal Oscillator division factor: 1
; 0000 0045 #pragma optsize-
; 0000 0046 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0047 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0048 #ifdef _OPTIMIZE_SIZE_
; 0000 0049 #pragma optsize+
; 0000 004A #endif
; 0000 004B 
; 0000 004C // Input/Output Ports initialization
; 0000 004D // Port B initialization
; 0000 004E // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 004F // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 0050 PORTB=0x00;
	OUT  0x5,R30
; 0000 0051 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x4,R30
; 0000 0052 
; 0000 0053 // Port C initialization
; 0000 0054 // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0055 // State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0056 PORTC=0x01;
	LDI  R30,LOW(1)
	OUT  0x8,R30
; 0000 0057 DDRC=0x01;
	OUT  0x7,R30
; 0000 0058 
; 0000 0059 // Port D initialization
; 0000 005A // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 005B // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 005C PORTD=0b00000000;
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 005D DDRD=0b01000000;
	LDI  R30,LOW(64)
	OUT  0xA,R30
; 0000 005E 
; 0000 005F // Timer/Counter 0 initialization
; 0000 0060 // Clock source: System Clock
; 0000 0061 // Clock value: Timer 0 Stopped
; 0000 0062 // Mode: Normal top=0xFF
; 0000 0063 // OC0A output: Disconnected
; 0000 0064 // OC0B output: Disconnected
; 0000 0065 TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 0066 TCCR0B=0x00;
	OUT  0x25,R30
; 0000 0067 TCNT0=0x00;
	OUT  0x26,R30
; 0000 0068 OCR0A=0x00;
	OUT  0x27,R30
; 0000 0069 OCR0B=0x00;
	OUT  0x28,R30
; 0000 006A 
; 0000 006B // Timer/Counter 1 initialization
; 0000 006C // Clock source: System Clock
; 0000 006D // Clock value: Timer1 Stopped
; 0000 006E // Mode: Normal top=0xFFFF
; 0000 006F // OC1A output: Discon.
; 0000 0070 // OC1B output: Discon.
; 0000 0071 // Noise Canceler: Off
; 0000 0072 // Input Capture on Falling Edge
; 0000 0073 // Timer1 Overflow Interrupt: Off
; 0000 0074 // Input Capture Interrupt: Off
; 0000 0075 // Compare A Match Interrupt: Off
; 0000 0076 // Compare B Match Interrupt: Off
; 0000 0077 TCCR1A=0x00;
	STS  128,R30
; 0000 0078 TCCR1B=0x00;
	STS  129,R30
; 0000 0079 TCNT1H=0x00;
	STS  133,R30
; 0000 007A TCNT1L=0x00;
	STS  132,R30
; 0000 007B ICR1H=0x00;
	STS  135,R30
; 0000 007C ICR1L=0x00;
	STS  134,R30
; 0000 007D OCR1AH=0x00;
	STS  137,R30
; 0000 007E OCR1AL=0x00;
	STS  136,R30
; 0000 007F OCR1BH=0x00;
	STS  139,R30
; 0000 0080 OCR1BL=0x00;
	STS  138,R30
; 0000 0081 
; 0000 0082 // Timer/Counter 2 initialization
; 0000 0083 // Clock source: System Clock
; 0000 0084 // Clock value: Timer2 Stopped
; 0000 0085 // Mode: Normal top=0xFF
; 0000 0086 // OC2A output: Disconnected
; 0000 0087 // OC2B output: Disconnected
; 0000 0088 ASSR=0x00;
	STS  182,R30
; 0000 0089 TCCR2A=0x00;
	STS  176,R30
; 0000 008A TCCR2B=0x00;
	STS  177,R30
; 0000 008B TCNT2=0x00;
	STS  178,R30
; 0000 008C OCR2A=0x00;
	STS  179,R30
; 0000 008D OCR2B=0x00;
	STS  180,R30
; 0000 008E 
; 0000 008F // External Interrupt(s) initialization
; 0000 0090 // INT0: Off
; 0000 0091 // INT1: Off
; 0000 0092 // Interrupt on any change on pins PCINT0-7: Off
; 0000 0093 // Interrupt on any change on pins PCINT8-14: Off
; 0000 0094 // Interrupt on any change on pins PCINT16-23: Off
; 0000 0095 EICRA=0x00;
	STS  105,R30
; 0000 0096 EIMSK=0x00;
	OUT  0x1D,R30
; 0000 0097 PCICR=0x00;
	STS  104,R30
; 0000 0098 
; 0000 0099 // Timer/Counter 0 Interrupt(s) initialization
; 0000 009A TIMSK0=0x00;
	STS  110,R30
; 0000 009B 
; 0000 009C // Timer/Counter 1 Interrupt(s) initialization
; 0000 009D TIMSK1=0x00;
	STS  111,R30
; 0000 009E 
; 0000 009F // Timer/Counter 2 Interrupt(s) initialization
; 0000 00A0 TIMSK2=0x00;
	STS  112,R30
; 0000 00A1 
; 0000 00A2 // USART initialization
; 0000 00A3 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00A4 // USART Receiver: On
; 0000 00A5 // USART Transmitter: On
; 0000 00A6 // USART0 Mode: Asynchronous
; 0000 00A7 // USART Baud Rate: 9600
; 0000 00A8 UCSR0A=0x00;
	STS  192,R30
; 0000 00A9 UCSR0B=0x18;
	LDI  R30,LOW(24)
	STS  193,R30
; 0000 00AA UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
; 0000 00AB UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0000 00AC UBRR0L=0x33;
	LDI  R30,LOW(51)
	STS  196,R30
; 0000 00AD 
; 0000 00AE // Analog Comparator initialization
; 0000 00AF // Analog Comparator: Off
; 0000 00B0 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 00B1 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 00B2 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 00B3 DIDR1=0x00;
	STS  127,R30
; 0000 00B4 
; 0000 00B5 // ADC initialization
; 0000 00B6 // ADC disabled
; 0000 00B7 ADCSRA=0x00;
	STS  122,R30
; 0000 00B8 
; 0000 00B9 // SPI initialization
; 0000 00BA // SPI disabled
; 0000 00BB SPCR=0x00;
	OUT  0x2C,R30
; 0000 00BC 
; 0000 00BD // TWI initialization
; 0000 00BE // TWI disabled
; 0000 00BF TWCR=0x00;
	STS  188,R30
; 0000 00C0 
; 0000 00C1 //printf("%u", devices);
; 0000 00C2 
; 0000 00C3 //TCCR0A=0b10100011; //выбираем неинверсный режим шим для обоих светодиодов
; 0000 00C4 //TCCR0B=0b00000001;
; 0000 00C5 printf("Write temp1");
	__POINTW1FN _0x0,19
	CALL SUBOPT_0x1
; 0000 00C6 while (1)
_0xA:
; 0000 00C7 {
; 0000 00C8 
; 0000 00C9 if (firststart==3)
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R3
	CPC  R31,R4
	BRNE _0xD
; 0000 00CA {
; 0000 00CB 
; 0000 00CC    // if(UDR0!=startUDR0)
; 0000 00CD 
; 0000 00CE         firststart--;
	CALL SUBOPT_0x2
; 0000 00CF         delay_ms(10000);
	LDI  R26,LOW(10000)
	LDI  R27,HIGH(10000)
	CALL _delay_ms
; 0000 00D0 
; 0000 00D1 }
; 0000 00D2 else if (firststart==2)
	RJMP _0xE
_0xD:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R3
	CPC  R31,R4
	BRNE _0xF
; 0000 00D3     {
; 0000 00D4   //  temp1=UDR0;
; 0000 00D5    // startUDR0=UDR0;
; 0000 00D6   //  if(UDR0!=startUDR0)
; 0000 00D7 
; 0000 00D8          firststart--;
	CALL SUBOPT_0x2
; 0000 00D9         // printf("30");
; 0000 00DA        //  printf("%d",temp1);
; 0000 00DB 
; 0000 00DC     }
; 0000 00DD else if (firststart==1)
	RJMP _0x10
_0xF:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R3
	CPC  R31,R4
	BRNE _0x11
; 0000 00DE {
; 0000 00DF   //  temp2=UDR0;
; 0000 00E0     firststart--;
	CALL SUBOPT_0x2
; 0000 00E1   //  printf("35");
; 0000 00E2    // printf("%u",temp2);
; 0000 00E3 }
; 0000 00E4 
; 0000 00E5 else
	RJMP _0x12
_0x11:
; 0000 00E6 {
; 0000 00E7 
; 0000 00E8     printf("Temp1 = ");
	__POINTW1FN _0x0,31
	CALL SUBOPT_0x1
; 0000 00E9     printf("30");
	__POINTW1FN _0x0,40
	CALL SUBOPT_0x1
; 0000 00EA     printf("Temp2 = ");
	__POINTW1FN _0x0,43
	CALL SUBOPT_0x1
; 0000 00EB     printf("35");
	__POINTW1FN _0x0,52
	CALL SUBOPT_0x1
; 0000 00EC     while(1)
_0x13:
; 0000 00ED         {
; 0000 00EE         delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	CALL _delay_ms
; 0000 00EF         writetemp();
	RCALL _writetemp
; 0000 00F0               if (temp>temp22)
	CALL SUBOPT_0x0
	CP   R7,R26
	CPC  R8,R27
	BRGE _0x16
; 0000 00F1                 {
; 0000 00F2                     PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x5,R30
; 0000 00F3                     writetemp();
	RCALL _writetemp
; 0000 00F4                     printf("Thermo OFF");
	__POINTW1FN _0x0,55
	RJMP _0x1B
; 0000 00F5                 }
; 0000 00F6 
; 0000 00F7                 else if(temp<temp11)
_0x16:
	CALL SUBOPT_0x0
	CP   R26,R5
	CPC  R27,R6
	BRGE _0x18
; 0000 00F8                 {
; 0000 00F9                     PORTB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x5,R30
; 0000 00FA                     writetemp();
	RCALL _writetemp
; 0000 00FB                     printf("Thermo ON");
	__POINTW1FN _0x0,66
_0x1B:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
; 0000 00FC                 }
; 0000 00FD         }
_0x18:
	RJMP _0x13
; 0000 00FE }
_0x12:
_0x10:
_0xE:
; 0000 00FF 
; 0000 0100 //delay_ms(32000);
; 0000 0101 //PORTB=0xFF;
; 0000 0102 //delay_ms(3000);
; 0000 0103 //PORTB=0x00;
; 0000 0104  //   writetemp(); // ??????? ???????????
; 0000 0105 //    setPWM(temp);
; 0000 0106 /*    data = UDR0; //? data ?????? ???????? ????????-????????? UART
; 0000 0107     if (data=='1')
; 0000 0108 	{
; 0000 0109 		OCR0A=255; //????????????? ???????? ?????
; 0000 010A 	}
; 0000 010B 
; 0000 010C     else if (data=='0')
; 0000 010D 	{
; 0000 010E 		OCR0A=0; //????????????? ???????? ?????
; 0000 010F 	}
; 0000 0110 
; 0000 0111     else
; 0000 0112 	{
; 0000 0113 		setPWM(temp);// ??????????? ? ?????? ???, ??????????? ?? ?????????? ???????????
; 0000 0114 	}
; 0000 0115    */
; 0000 0116 }
	RJMP _0xA
; 0000 0117 /*
; 0000 0118 devices=w1_search( DS18B20_SEARCH_ROM_CMD, RomCode );
; 0000 0119 
; 0000 011A 
; 0000 011B   if( devices )
; 0000 011C   {
; 0000 011D //printf("DS18B20 = ");
; 0000 011E     printf(devices);
; 0000 011F 
; 0000 0120 
; 0000 0121    // lcd_gotoxy( 0,1 ); lcd_puts( LcdBuffDevices ); lcd_gotoxy( 0,0 ); lcd_puts( str1 );
; 0000 0122 
; 0000 0123     ds18b20_init( &RomCode[0][0], 30, 60, DS18B20_12BIT_RES );
; 0000 0124    // ds18b20_init( &RomCode[1][0], 30, 60, DS18B20_12BIT_RES );
; 0000 0125    // printf((int)DS18B20_12BIT_RES);
; 0000 0126 
; 0000 0127 while (1)
; 0000 0128       {
; 0000 0129       data=UDR0;
; 0000 012A         printf("t1 %.2f \xefC", ds18b20_temperature( &RomCode[0][0] ) );
; 0000 012B       if(data=='1')
; 0000 012C       {
; 0000 012D       PORTB=0xFF;
; 0000 012E       putchar('1');
; 0000 012F       printf("Hello, world!");
; 0000 0130       }
; 0000 0131       if(data=='0')
; 0000 0132       {
; 0000 0133       PORTB=0x00;
; 0000 0134         putchar('0');
; 0000 0135       }
; 0000 0136       delay_ms(1000);
; 0000 0137       }
; 0000 0138       }
; 0000 0139       else { printf("No devices");}
; 0000 013A       */
; 0000 013B }
_0x19:
	RJMP _0x19
;

	.CSEG
_ds18b20_select:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	CALL _w1_init
	CPI  R30,0
	BRNE _0x2000003
	LDI  R30,LOW(0)
	LDD  R17,Y+0
	RJMP _0x2080001
_0x2000003:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	SBIW R30,0
	BREQ _0x2000004
	LDI  R26,LOW(85)
	CALL _w1_write
	LDI  R17,LOW(0)
_0x2000006:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R26,R30
	CALL _w1_write
	SUBI R17,-LOW(1)
	CPI  R17,8
	BRLO _0x2000006
	RJMP _0x2000008
_0x2000004:
	LDI  R26,LOW(204)
	CALL _w1_write
_0x2000008:
	LDI  R30,LOW(1)
	LDD  R17,Y+0
	RJMP _0x2080001
_ds18b20_read_spd:
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RCALL _ds18b20_select
	CPI  R30,0
	BRNE _0x2000009
	LDI  R30,LOW(0)
	RJMP _0x2080002
_0x2000009:
	LDI  R26,LOW(190)
	CALL _w1_write
	LDI  R17,LOW(0)
	__POINTWRM 18,19,___ds18b20_scratch_pad
_0x200000B:
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	CALL _w1_read
	POP  R26
	POP  R27
	ST   X,R30
	SUBI R17,-LOW(1)
	CPI  R17,9
	BRLO _0x200000B
	LDI  R30,LOW(___ds18b20_scratch_pad)
	LDI  R31,HIGH(___ds18b20_scratch_pad)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(9)
	CALL _w1_dow_crc8
	CALL __LNEGB1
_0x2080002:
	CALL __LOADLOCR4
_0x2080003:
	ADIW R28,6
	RET
_ds18b20_temperature:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _ds18b20_read_spd
	CPI  R30,0
	BRNE _0x200000D
	CALL SUBOPT_0x3
	RJMP _0x2080001
_0x200000D:
	__GETB1MN ___ds18b20_scratch_pad,4
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	ANDI R30,LOW(0x3)
	MOV  R17,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _ds18b20_select
	CPI  R30,0
	BRNE _0x200000E
	CALL SUBOPT_0x3
	RJMP _0x2080001
_0x200000E:
	LDI  R26,LOW(68)
	CALL _w1_write
	MOV  R30,R17
	LDI  R26,LOW(_conv_delay_G100*2)
	LDI  R27,HIGH(_conv_delay_G100*2)
	CALL SUBOPT_0x4
	CALL __GETW2PF
	CALL _delay_ms
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	RCALL _ds18b20_read_spd
	CPI  R30,0
	BRNE _0x200000F
	CALL SUBOPT_0x3
	RJMP _0x2080001
_0x200000F:
	CALL _w1_init
	MOV  R30,R17
	LDI  R26,LOW(_bit_mask_G100*2)
	LDI  R27,HIGH(_bit_mask_G100*2)
	CALL SUBOPT_0x4
	CALL __GETW1PF
	LDS  R26,___ds18b20_scratch_pad
	LDS  R27,___ds18b20_scratch_pad+1
	AND  R30,R26
	AND  R31,R27
	CALL __CWD1
	CALL __CDF1
	__GETD2N 0x3D800000
	CALL __MULF12
	LDD  R17,Y+0
	RJMP _0x2080001
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_putchar:
	ST   -Y,R26
_0x2020006:
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BREQ _0x2020006
	LD   R30,Y
	STS  198,R30
	ADIW R28,1
	RET
_put_usart_G101:
	ST   -Y,R27
	ST   -Y,R26
	LDD  R26,Y+2
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2080001:
	ADIW R28,3
	RET
__print_G101:
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x202001C:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x202001E
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x2020022
	CPI  R18,37
	BRNE _0x2020023
	LDI  R17,LOW(1)
	RJMP _0x2020024
_0x2020023:
	CALL SUBOPT_0x5
_0x2020024:
	RJMP _0x2020021
_0x2020022:
	CPI  R30,LOW(0x1)
	BRNE _0x2020025
	CPI  R18,37
	BRNE _0x2020026
	CALL SUBOPT_0x5
	RJMP _0x20200CF
_0x2020026:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020027
	LDI  R16,LOW(1)
	RJMP _0x2020021
_0x2020027:
	CPI  R18,43
	BRNE _0x2020028
	LDI  R20,LOW(43)
	RJMP _0x2020021
_0x2020028:
	CPI  R18,32
	BRNE _0x2020029
	LDI  R20,LOW(32)
	RJMP _0x2020021
_0x2020029:
	RJMP _0x202002A
_0x2020025:
	CPI  R30,LOW(0x2)
	BRNE _0x202002B
_0x202002A:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x202002C
	ORI  R16,LOW(128)
	RJMP _0x2020021
_0x202002C:
	RJMP _0x202002D
_0x202002B:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x2020021
_0x202002D:
	CPI  R18,48
	BRLO _0x2020030
	CPI  R18,58
	BRLO _0x2020031
_0x2020030:
	RJMP _0x202002F
_0x2020031:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x2020021
_0x202002F:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2020035
	CALL SUBOPT_0x6
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x7
	RJMP _0x2020036
_0x2020035:
	CPI  R30,LOW(0x73)
	BRNE _0x2020038
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2020039
_0x2020038:
	CPI  R30,LOW(0x70)
	BRNE _0x202003B
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020039:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x202003C
_0x202003B:
	CPI  R30,LOW(0x64)
	BREQ _0x202003F
	CPI  R30,LOW(0x69)
	BRNE _0x2020040
_0x202003F:
	ORI  R16,LOW(4)
	RJMP _0x2020041
_0x2020040:
	CPI  R30,LOW(0x75)
	BRNE _0x2020042
_0x2020041:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x2020043
_0x2020042:
	CPI  R30,LOW(0x58)
	BRNE _0x2020045
	ORI  R16,LOW(8)
	RJMP _0x2020046
_0x2020045:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x2020077
_0x2020046:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x2020043:
	SBRS R16,2
	RJMP _0x2020048
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020049
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020049:
	CPI  R20,0
	BREQ _0x202004A
	SUBI R17,-LOW(1)
	RJMP _0x202004B
_0x202004A:
	ANDI R16,LOW(251)
_0x202004B:
	RJMP _0x202004C
_0x2020048:
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
_0x202004C:
_0x202003C:
	SBRC R16,0
	RJMP _0x202004D
_0x202004E:
	CP   R17,R21
	BRSH _0x2020050
	SBRS R16,7
	RJMP _0x2020051
	SBRS R16,2
	RJMP _0x2020052
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x2020053
_0x2020052:
	LDI  R18,LOW(48)
_0x2020053:
	RJMP _0x2020054
_0x2020051:
	LDI  R18,LOW(32)
_0x2020054:
	CALL SUBOPT_0x5
	SUBI R21,LOW(1)
	RJMP _0x202004E
_0x2020050:
_0x202004D:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x2020055
_0x2020056:
	CPI  R19,0
	BREQ _0x2020058
	SBRS R16,3
	RJMP _0x2020059
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x202005A
_0x2020059:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x202005A:
	CALL SUBOPT_0x5
	CPI  R21,0
	BREQ _0x202005B
	SUBI R21,LOW(1)
_0x202005B:
	SUBI R19,LOW(1)
	RJMP _0x2020056
_0x2020058:
	RJMP _0x202005C
_0x2020055:
_0x202005E:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x2020060:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2020062
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x2020060
_0x2020062:
	CPI  R18,58
	BRLO _0x2020063
	SBRS R16,3
	RJMP _0x2020064
	SUBI R18,-LOW(7)
	RJMP _0x2020065
_0x2020064:
	SUBI R18,-LOW(39)
_0x2020065:
_0x2020063:
	SBRC R16,4
	RJMP _0x2020067
	CPI  R18,49
	BRSH _0x2020069
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020068
_0x2020069:
	RJMP _0x20200D0
_0x2020068:
	CP   R21,R19
	BRLO _0x202006D
	SBRS R16,0
	RJMP _0x202006E
_0x202006D:
	RJMP _0x202006C
_0x202006E:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x202006F
	LDI  R18,LOW(48)
_0x20200D0:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2020070
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x7
	CPI  R21,0
	BREQ _0x2020071
	SUBI R21,LOW(1)
_0x2020071:
_0x2020070:
_0x202006F:
_0x2020067:
	CALL SUBOPT_0x5
	CPI  R21,0
	BREQ _0x2020072
	SUBI R21,LOW(1)
_0x2020072:
_0x202006C:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x202005F
	RJMP _0x202005E
_0x202005F:
_0x202005C:
	SBRS R16,0
	RJMP _0x2020073
_0x2020074:
	CPI  R21,0
	BREQ _0x2020076
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x7
	RJMP _0x2020074
_0x2020076:
_0x2020073:
_0x2020077:
_0x2020036:
_0x20200CF:
	LDI  R17,LOW(0)
_0x2020021:
	RJMP _0x202001C
_0x202001E:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	CALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_usart_G101)
	LDI  R31,HIGH(_put_usart_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G101
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET

	.CSEG

	.CSEG
_strlen:
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.DSEG
___ds18b20_scratch_pad:
	.BYTE 0x9
_temp:
	.BYTE 0x2
_pwm:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDS  R26,_temp
	LDS  R27,_temp+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _printf
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	__GETW1R 3,4
	SBIW R30,1
	__PUTW1R 3,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	__GETD1N 0xC61C3C00
	LDD  R17,Y+0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x5:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

	.equ __w1_port=0x0B
	.equ __w1_bit=0x07

_w1_init:
	clr  r30
	cbi  __w1_port,__w1_bit
	sbi  __w1_port-1,__w1_bit
	__DELAY_USW 0x3C0
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x25
	sbis __w1_port-2,__w1_bit
	ret
	__DELAY_USB 0xCB
	sbis __w1_port-2,__w1_bit
	ldi  r30,1
	__DELAY_USW 0x30C
	ret

__w1_read_bit:
	sbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x5
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x1D
	clc
	sbic __w1_port-2,__w1_bit
	sec
	ror  r30
	__DELAY_USB 0xD5
	ret

__w1_write_bit:
	clt
	sbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x5
	sbrc r23,0
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0x23
	sbic __w1_port-2,__w1_bit
	rjmp __w1_write_bit0
	sbrs r23,0
	rjmp __w1_write_bit1
	ret
__w1_write_bit0:
	sbrs r23,0
	ret
__w1_write_bit1:
	__DELAY_USB 0xC8
	cbi  __w1_port-1,__w1_bit
	__DELAY_USB 0xD
	set
	ret

_w1_read:
	ldi  r22,8
	__w1_read0:
	rcall __w1_read_bit
	dec  r22
	brne __w1_read0
	ret

_w1_write:
	mov  r23,r26
	ldi  r22,8
	clr  r30
__w1_write0:
	rcall __w1_write_bit
	brtc __w1_write1
	ror  r23
	dec  r22
	brne __w1_write0
	inc  r30
__w1_write1:
	ret

_w1_dow_crc8:
	clr  r30
	tst  r26
	breq __w1_dow_crc83
	mov  r24,r26
	ldi  r22,0x18
	ld   r26,y
	ldd  r27,y+1
__w1_dow_crc80:
	ldi  r25,8
	ld   r31,x+
__w1_dow_crc81:
	mov  r23,r31
	eor  r23,r30
	ror  r23
	brcc __w1_dow_crc82
	eor  r30,r22
__w1_dow_crc82:
	ror  r30
	lsr  r31
	dec  r25
	brne __w1_dow_crc81
	dec  r24
	brne __w1_dow_crc80
__w1_dow_crc83:
	adiw r28,2
	ret

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__LNEGB1:
	TST  R30
	LDI  R30,1
	BREQ __LNEGB1F
	CLR  R30
__LNEGB1F:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETW2PF:
	LPM  R26,Z+
	LPM  R27,Z
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
