	AREA myData, DATA
VAL1 EQU 3 
VAL2 EQU 5  
TEMP RN R3	
		
	AREA myCode, CODE, READONLY
	ENTRY
	EXPORT __main
		
__main
	LDR R1, =VAL1
	LDR R2, =VAL2
	MOV R4, #-1
	B WHILE
	
WHILE
	ADD TEMP, R1, R2
	CMP TEMP, #15
	BHI here
	CMP R1, R2
	BLS __ELSE
	MULS R2, R1, R2
	MULS R1, R4, R1
	B WHILE
__ELSE
	SUB R2, R2, R1
	RSB R1, R2, #1
	B WHILE
	
here B here
	END