	AREA myData, DATA
myID EQU 9731701 
	
	AREA myCode, CODE, READONLY
	ENTRY
	EXPORT __main
	
__main
	LDR R0, =myID           ;initial R0 with myID
	MOV R1, #0			    ;initial R1 with 0 and this is the counter of 111
	MOV R2, #24             ;initial R2 with 24 and this is the counter of loop
	MOV R3, #0              ;initial R3 with 0 and this for holding three LSB bits of R0

loop
	SUBS R2, R2, #1         ;R2 = R2 - 1 and set the flags
	BMI here2               ;if R2 < 0  then branch to here2 and finish
	AND R3, R0, #2_111      ;we want to save three LSB bits of R0 in R3
	CMP R3, #2_111          ;compare the three bits that we save recently in R3 with 111 in binary
	LSR R0, R0, #1          ;shift R0 one bit to right 
	BEQ	here1               ;if the the value of R3 equals to 111 then branch to here1 
	B loop
		
here1
	ADD R1, R1, #1          ;R1 = R1 + 1 and this is the counter of 111 patern
	B loop
	
here2 B here2
	END