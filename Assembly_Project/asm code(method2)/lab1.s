PIO_PER EQU 0x400E0E00  ;(PIOA)
PIO_OER EQU 0x400E0E10  ;(PIOA)
PIO_SODR EQU 0x400E0E30 ;(PIOA)
PIO_CODR EQU 0x400E0E34 ;(PIOA)
PIO_ISR EQU 0x400E104C  ;(PIOB)
	
	AREA myCode, code, READONLY
	export __main
	entry
	
__main
	LDR R6, =PIO_ISR
	LDR R2, [R6]
	AND R3, R2, #2_1
	CMP R3, #0
	BEQ __main
	BL enable_pio
	
mainLoop
	BL led1_on
	BL led2_on
	BL led3_on
	BL delay
	BL led3_off
	BL delay
	BL led3_on
	BL led2_off
	BL delay
	BL led3_off
	BL delay
	BL led3_on
	BL led2_on
	BL led1_off
	BL delay
	BL led3_off
	BL delay
	BL led3_on
	BL led2_off
	BL delay
	BL led3_off
	BL delay

	B mainLoop

enable_pio
	MOV R4, #2_111
	
	LDR R5, =PIO_PER
	STR R4, [R5]
	
	LDR R5, =PIO_OER
	STR R4, [R5]
	
	BX LR
	
led1_on
	MOV R4, #2_1
	LDR R5, =PIO_SODR
	STR R4, [R5]
	BX LR
	
led1_off
	MOV R4, #2_1
	LDR R5, =PIO_CODR
	STR R4, [R5]
	BX LR

led2_on
	MOV R4, #2_10
	LDR R5, =PIO_SODR
	STR R4, [R5]
	BX LR
	
led2_off
	MOV R4, #2_10
	LDR R5, =PIO_CODR
	STR R4, [R5]
	BX LR

led3_on
	MOV R4, #2_100
	LDR R5, =PIO_SODR
	STR R4, [R5]
	BX LR
	
led3_off
	MOV R4, #2_100
	LDR R5, =PIO_CODR
	STR R4, [R5]
	BX LR
	
leds_off
	MOV R4, #2_111
	LDR R5, =PIO_CODR
	STR R4, [R5]
	B __main
	
delay
	; first we should check push button 2 interrupt
	LDR R2, [R6]
	AND R3, R2, #2_10
	CMP R3, #2_10
	BEQ leds_off
	; set the registers for create delay
	MOV R4, #0
	LDR R5, =0x00060000
	
delay_loop
	ADD R4, R4, #1
	CMP R4, R5
	BNE delay_loop
	BX LR
	
	END
