	AREA myData, DATA
myAddress EQU 0x000801F8 
myValue EQU 1024
	
	
	AREA myCode, CODE, READONLY
	ENTRY
	EXPORT __main
	
__main
	LDR R10, =myAddress    ;initial R10 with myAddress
	LDR R11, =myValue      ;initial R11 with myValue
	STR R11, [R10]         ;store myValue in the memory cell that myAddress point that
	
	MOV R12, #2			   ;initial R12 with dividor value=2
	UDIV R0, R11, R12      ;R0 = R11/R12
	MOV R12, #4			   ;initial R12 with dividor value=4
	UDIV R1, R11, R12      ;R0 = R11/R12
	MOV R12, #8			   ;initial R12 with dividor value=8
	UDIV R2, R11, R12      ;R0 = R11/R12
	MOV R12, #16		   ;initial R12 with dividor value=16
	UDIV R3, R11, R12      ;R0 = R11/R12
	MOV R12, #32		   ;initial R12 with dividor value=32
	UDIV R4, R11, R12      ;R0 = R11/R12
	MOV R12, #64		   ;initial R12 with dividor value=64
	UDIV R5, R11, R12      ;R0 = R11/R12
	MOV R12, #128		   ;initial R12 with dividor value=128
	UDIV R6, R11, R12      ;R0 = R11/R12
	MOV R12, #256		   ;initial R12 with dividor value=256
	UDIV R7, R11, R12      ;R0 = R11/R12
	MOV R12, #512		   ;initial R12 with dividor value=512
	UDIV R8, R11, R12      ;R0 = R11/R12
	MOV R12, #1024		   ;initial R12 with dividor value=1024
	UDIV R9, R11, R12      ;R0 = R11/R12
		
here B here 
	END