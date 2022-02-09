	AREA myData, DATA 
PIO_PER EQU 0x400E0E00     ;(PIOA)-> PIO Enable Register
PIO_OER EQU 0x400E0E10     ;(PIOA)-> PIO Output Enable Register
PIO_SODR EQU 0x400E0E30    ;(PIOA)-> PIO Set Output Data Register 
PIO_CODR EQU 0x400E0E34    ;(PIOA)-> PIO Clear Output Data Register
PIO_ISR EQU 0x400E104C     ;(PIOB)-> PIO Interrupt Status Register
;determin the delay value of LEDs
LED1_delay EQU 0x000C0000  ;set the delay value for LED1(left LED)
LED2_delay EQU 0x00030000  ;set the delay value for LED2(middle LED)
LED3_delay EQU 0x0000A000  ;set the delay value for LED2(right LED)
;assign a name to some registers
LED1_toggle RN R8          ;hold the toggle value of LED1 in R8(if R8==1 : LED1->on // if R8==0 : -> LED1->off)
LED2_toggle RN R9          ;hold the toggle value of LED1 in R8(if R9==1 : LED1->on // if R9==0 : -> LED2->off)
LED3_toggle RN R10         ;hold the toggle value of LED1 in R8(if R10==1 : LED1->on // if R10==0 : -> LED3->off)
	
	AREA myCode, code, READONLY
	export __main
	entry
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;define a MACRO for managing the on or off process of each LED
;$ARG1-> select wich pio must be on or off 
;$ARG2-> delay of related LED 
;$ARG3-> register that hold the delay value of related LED and we want to restor it
;$ARG4-> register that hold the toggle value(we understand the led would be on or off)
	MACRO
$lbl myhandler $ARG1, $ARG2, $ARG3, $ARG4    
	BEQ $lbl.continue                       ;SUBS set the flags. if the result of sub was 0 we can go to continue label of macro
	B $lbl.finish	                        ;if the sub result wasn't 0 we should exit from MACRO
$lbl.continue                               
	LDR $ARG3, =$ARG2                       ;restore the register that holds delay value
	EOR $ARG4, $ARG4, #1                    ;xor the LED#_toggle with 1 for handling toggle
	CMP $ARG4, #1                           ;compare LED#_toggle with 1
	BEQ $lbl.led_on                         ;if LED#_toggle==1 : turn on the LED#
	B $lbl.led_off							;if LED#_toggle==0 : turn on the LED#
$lbl.led_on									;*** (this section set the SODR register to turn on the LED)***;
	MOV R4, $ARG1                           
	LDR R5, =PIO_SODR
	STR R4, [R5]
	B $lbl.finish
$lbl.led_off								;*** (this section set the CODR register to turn off the LED)***;
	MOV R4, $ARG1
	LDR R5, =PIO_CODR
	STR R4, [R5]
$lbl.finish	
	MEND
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
__main

	MOV LED1_toggle, #1                     ;initialize R8(LED1_toggle) with 1
	MOV LED2_toggle, #1						;initialize R9(LED2_toggle) with 1
	MOV LED3_toggle, #1						;initialize R10(LED3_toggle) with 1
	
	LDR R1, =LED1_delay                     ;initialize R1 with LED1_delay
	LDR R2, =LED2_delay						;initialize R2 with LED2_delay
	LDR R3, =LED3_delay						;initialize R3 with LED3_delay
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pushButton1

	LDR R6, =PIO_ISR                        ;load the address of PIO_ISR reg in R6
	LDR R4, [R6]                            ;load the value of PIO_ISR reg in R4
	AND R5, R4, #2_1                        ;check the value in first bit of PIO_ISR in PIOB
	CMP R5, #0								;compare that bit with 0
	BEQ pushButton1                         ;if R5==0(if the button isn`t pushed) we should wait and check interrupt again
	BL enable_pio                           ;if the button is pushed we should enable the pio pins
	BL leds_on                              ;then we should turn on all of LEDs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mainLoop
	
	BL pushButton2								  ;we should check push button2 interrupt
	SUBS R1, R1, #1                               ;a downward counter for creating delay for LED1
LED1 myhandler #2_1, LED1_delay, R1, LED1_toggle  ;call macro and if the result of SUBS is 0 the flags are set and do a suitable job related to LED1

	BL pushButton2								  ;we should check push button2 interrupt
	SUBS R2, R2, #1								  ;a downward counter for creating delay for LED2
LED2 myhandler #2_10, LED2_delay, R2, LED2_toggle ;call macro and if the result of SUBS is 0 the flags are set and do a suitable job related to LED2

	BL pushButton2								  ;we should check push button2 interrupt
	SUBS R3, R3, #1								  ;a downward counter for creating delay for LED3
LED3 myhandler #2_100, LED3_delay, R3, LED3_toggle;call macro and if the result of SUBS is 0 the flags are set and do a suitable job related to LED3	
	 
	B mainLoop                              	  ;else we should continue to our work and return to mainLoop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pushButton2									;***(this section checks if an interrupt comes from pushButton2 we shoud turn LEDs off)***;

	LDR R6, =PIO_ISR						;load the address of PIO_ISR reg in R6
	LDR R4, [R6]							;load the value of PIO_ISR reg in R4
	AND R5, R4, #2_10						;check the value in second bit of PIO_ISR in PIOB
	CMP R5, #2_10							;compare that bit with 0
	BEQ leds_off							;if R5==2_10(if the button is pushed) we should turn off the LEDs
	BX LR
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enable_pio									;***(this section enable the PIOs that we want to use)***;

	MOV R4, #2_111                          ;move the value 2_111 to R4
	
	LDR R5, =PIO_PER                        ;load the address of PIO_PER reg in R5
	STR R4, [R5]                            ;store 2_111 in PIO_PER
	
	LDR R5, =PIO_OER						;load the address of PIO_OER reg in R5
	STR R4, [R5]							;store 2_111 in PIO_OER
	
	BX LR									;retun to location that we were first(brach to where link reg is point to that)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
leds_on										;***(this section turn on all LEDs)***;
											;(NOTE) we call this if the push button1 is pushed
	MOV R4, #2_111							;move the value 2_111 to R4
	LDR R5, =PIO_SODR						;load the address of PIO_SODR reg in R5
	STR R4, [R5]							;store 2_111 in PIO_SODR
	BX LR									;retun to location that we were first(brach to where link reg is point to that)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
leds_off									;***(this section turn off all LEDs)***;
											;(NOTE) we call this if the push button2 is pushed
	MOV R4, #2_111							;move the value 2_111 to R4
	LDR R5, =PIO_CODR						;load the address of PIO_SODR reg in R5
	STR R4, [R5]							;store 2_111 in PIO_SODR
	B __main								;return to __main and wait for comming an interrupt from push button1
		
	END
	