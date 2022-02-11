	AREA myData, DATA
myAddress EQU 0x05000000 
myValue EQU 1024
	
	
	AREA myCode, CODE, READONLY
	ENTRY
	EXPORT __main
	
__main
	LDR R10, =myAddress    ;initial R10 with myAddress
	LDR R11, =myValue      ;initial R11 with myValue
	STR R11, [R10]         ;store myValue in the memory cell that myAddress point that
	
	LSR R0, R11, #1        ;1 bit shifted to right value save in R0 destination Register
	LSR R1, R11, #2        ;2 bit shifted to right value save in R1 destination Register
	LSR R2, R11, #3        ;3 bit shifted to right value save in R2 destination Register
	LSR R3, R11, #4        ;4 bit shifted to right value save in R3 destination Register
	LSR R4, R11, #5        ;5 bit shifted to right value save in R4 destination Register
	LSR R5, R11, #6        ;6 bit shifted to right value save in R5 destination Register
	LSR R6, R11, #7        ;7 bit shifted to right value save in R6 destination Register
	LSR R7, R11, #8        ;8 bit shifted to right value save in R7 destination Register
	LSR R8, R11, #9        ;9 bit shifted to right value save in R8 destination Register
	LSR R9, R11, #10       ;10 bit shifted to right value save in R9 destination Register
		
here B here 
	END