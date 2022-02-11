	AREA myData, DATA
Power EQU 5                ; in 4^x the Power is x
		
	AREA myCode, CODE, READONLY
	ENTRY
	EXPORT __main
		
__main
	;...R0 contains the Result , R1 contains The Power		
	MOV	R0, #1            	; initialize R0 with 1 and contains final result 
	LDR	R1, =Power        	; R1 contains Power. we want to calculate 4^R1
	MOV R4, R1				; make a copy from R1
	
	;... in this two loop we calculate 4^R1		
external_loop
	CMP	R4, #0 				; compare R4 with zero
	BLS	done 				; if (R1 <= 0) then finish
	MOV	R3, R0 				; R3 = R0
	MOV	R2, #1 				; initial R2 with 1 (R2 = 1)
	SUB	R4, R4, #1 			; R4--
			
internal_loop
	CMP	R2, #4 				; compare R2 with 2
	BEQ	external_loop 		; if (R2 == 2) then go to external_loop
	ADD	R0, R0, R3 			; R0 = R0 + R3
	ADD	R2, R2, #1 			; R2++
	B internal_loop 		; again on internal_loop
						
done B done					; done , note that final result is in R0
	END		