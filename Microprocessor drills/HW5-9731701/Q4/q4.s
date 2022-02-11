	AREA myData, DATA
VAL EQU 5
	
	AREA myCode, CODE, READONLY
	ENTRY
	EXPORT __main
	
__main
	LDR R0, =VAL  ;initial R0 with value that we want to calculate its factoriel
	LDR R1, =1    ;initial R1 with 1 and also we holds the answer inside it
	LDR R2, =1	  ;initial R2 with 1 and also it is my counter	
	
myloop
	MUL R1, R2, R1  ; R1=R2 * R1
	ADD R2, R2, #1  ; R2=R2 + 1
	SUBS R4, R0, R2 ; R4=R0 - R2
	BNE myloop		;if R2 < VAL it rturns to myloop 
	MUL R1, R2, R1  ;after last loop we should calculate R1=R2 * R1 again because now the value of R1 is equal to VAL
	
here B here
	END