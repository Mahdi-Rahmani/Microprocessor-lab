	AREA myCode, CODE
	ENTRY
	EXPORT __main
		
__main
	LDR R0, =STRING		;R0 points to first Byte of STRING
	MOV R1, #0			;initialize R1 with 0
	MOV R10, #0			;initialize R10 with 0 ( it contains the result at the end)
	
loop
	LDRB R1, [R0]    	;load first byte (or first character)
	CMP R1, #0          ;compare R1 with 0
	BEQ done    		;if (R1==0)it means that we arrive to the end of the string and we should finish the process
	SUB R1, R1, #48    	;R1 = R1 - 48 (this is for chnaging the ASCII code of numbers to the right value of them)
	LSL R10, R10, #4    ;for creating packed BCD we should save each number in BCD in 4 bits so we shift 4 bits to left each time
	ADD R10, R10, R1	;R10 = R10 + R1  
	ADD R0, R0, #1		;R0 = R0 + 1 ( the address increments one unit and points to next byte or character in memory)
	B loop              ;go back to loop again

done B done
	
	ALIGN 4
STRING DCB "6457",0    ;String that contains for character and save in one word of memory

	END