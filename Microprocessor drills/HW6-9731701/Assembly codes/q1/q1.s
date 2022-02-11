	AREA myData, DATA
Const EQU 0xFFFFFFFF 
Power EQU 5               ; in a^b the Power is b
Number EQU -3             ; in a^b the Number is a
		
	AREA myCode, CODE, READONLY
	ENTRY
	EXPORT __main
		
__main
	;...R0 should be positive , R1 can be both positive and negative		
	LDR	R8, =Const        ; R8 has constant 0xFFFFFFFF			
	LDR	R0, =Power        ; R0 example
	LDR	R1, =Number       ; R1 example
	MOV	R3, #1            ; R3 contains final result
	MOV	R10, R0           ; we keep a copy of R0 or Power to check is it even or not
	B absolute            ; first we should calculate the absolute value of Number
	
	;... here we calculate the absolute value of Number
	;... if the Number is negative we should change it to positive
	;... if the Number is negative we assign 1 to R7 to check if the power is Odd then we impact it
absolute
	MOV	R7, #0		      ; intialize R7 with 0
	CMP	R1, #0            ; compare R1 with 0
	BGE	here              ; if (R0 >= 0) then go to here
	EOR	R1, R1, R8        ; R1 = R1 xor R8
	ADD	R1, R1, #1        ; R1 = R1 + 1
	ADD	R7, R7, #1        ; R7++
here B external_loop  ;  go to external_loop
	
	;... in this two loop we calculate |R1|^R0
external_loop
	CMP	R0, #0            ; compare R0 with zero
	BLS	impact_sign       ; if (R0 <= 0) then finish the process of calculation of |R1|^R0 and we should impact the sign in result
	MOV	R4, R3            ; R4 = R3
	SUB	R0, R0, #1        ; R0--
	MOV	R2, #1            ; initial R2 with 1 (R2 = 1)
			
internal_loop
	CMP	R2, R1            ; compare R1 with R2
	BEQ	external_loop     ; if (R2 == R1) then go to external_loop
	ADD	R3, R3, R4        ; R3 += R4
	ADD	R2, R2, #1        ; R2++
	B internal_loop       ; again on internal_loop
	
	;...here we check :
	;......if the Power is odd and the Number is negative --> result is negative
	;......if the Power is even  --> result is positive
impact_sign
	MOV	R9, #0            ; initialize R9 with 0
	
	;...if the power is even the value of R9 is going to 1
loop
	CMP	R10, #0           ; compare R10 with 0
	BNE	here_2            ; if (R10 != 0) then go to here_2
	ADD	R9, R9, #1        ; R9++
	B here_4              ; go to here_4
	
here_2
	CMP	R10, #1           ; compare R10 with 1
	BNE	here_3            ; if (R10 != 1) then go to here_3
	B here_4              ; go to here_4
			
here_3		
	SUB	R10, R10, #2      ; R10--
	B loop                ; go to third_looop

here_4
	CMP	R9, #1            ; compare R9 with 1
	BEQ	done              ; if (R9 == 1) the power is even and the result doesn't need to be changed
	CMP	R7, #1            ; compare R7 with 1
	BNE	done              ; if (R9 == 0) the power is odd and if (R7 != 1) the Number was positive and the result doesn't need to be changed
	EOR	R3, R3, R8        ; R1 = R1 xor R8
	ADD	R3, R3, #1        ; R1 = R1 + 1
	
done B done               ; done , note that final result is in R3
	END		             
			
	