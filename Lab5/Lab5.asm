; Class: CSE 313 Machine Organization Lab
; Section: 01
; Instructor: Taline Georgiou
; Term: Fall 2017
; Name(s): George Suarez
; Lab #5: Subroutines: multiplication, division, modulus
; Description: This program computes the product of two integers
;	       X and Y. Then calculates the quotient and modulo
;	       of X and Y.
;
;	       Inputs:
;			x3100---X
;			x3101---Y
;
;	       Outputs:
;			x3102---X * Y			
;			x3103---X / Y (integer division)
;			x3104---X % Y (modulus)
;
;	       Implementation:
;			R1 and R2 will hold the X and Y values respectively where
;			they will be the subroutine parameters for MULT and DIV.
;			R2 is also the subroutine parameter for the subroutine
;			DIV. 
;			
;			R3 will be the subroutine return for MULT. R1 and R2 
;			will be the subroutine return for DIV.
;			
;			R0 holds the check for validity for DIV.
;



	.ORIG x3000

	LDI R1, X		; MEM[x3100] = X
	LDI R2, Y		; MEM[x3101] = Y
	JSR MULT
	STI R4, PRODUCT
	
	LDI R2, Y
	JSR DIV
	STI R1, QUO
	STI R2, MOD

	HALT


MULT	STI R3, SaveRegR3
	AND R3, R3, #0		; clear R3 register
	ADD R3, R3, #1		; sign = 1
	ADD R4, R4, #0		; product = 0
	

CHECK_X	ADD R1, R1, #0
	BRp CHECK_Y
	BRz FinishMult		; check if X < 0
	NOT R1, R1
	ADD R1, R1, #1
	NOT R3, R3
	ADD R3, R3, #1		; sign = -sign
	
CHECK_Y	ADD R2, R2, #0
	BRp SUMLOOP		; check if Y < 0
	BRz FinishMult
	NOT R2, R2
	ADD R2, R2, #1		; Y = -Y
	NOT R3, R3
	ADD R3, R3, #1		; sign = -sign

SUMLOOP ADD R4, R4, R1		; prod = prod + X
	ADD R2, R2, #-1		; Y = Y - 1
	BRp SUMLOOP		; check if Y > 0

	ADD R3, R3, #0
	BRzp FinishMult		; check if the sign is negative
	NOT R4, R4
	ADD R4, R4, #1
  	
FinishMult	
	LDI R3, SaveRegR3	; Restore R3's original value
	RET

SaveRegR3 .FILL	#0



DIV
	STI R3, SaveR3
	STI R4, SaveRegR4
	STI R5, SaveRegR5
	STI R6, SaveRegR6

	AND R4, R4, #0		; (Q)uotient = 0
	AND R5, R5, #0		; (R)emainder = 0
	AND R6, R6, #0		; (V)alid = 0

	ADD R1, R1, #0
	BRn FinishDiv		; check if X < 0
	ADD R2, R2, #0
	BRnz FinishDiv		; check if Y < 0

	ADD R6, R6, #1		; operation is valid
	
	ADD R3, R1, #0		; temp = X
	NOT R2, R2
	ADD R2, R2, #1
DIVLOOP	ADD R4, R4, #1		; Q = Q + 1
	ADD R3, R3, R2		; temp = temp - Y
	BRzp DIVLOOP

SetRemainder
	NOT R2, R2
	ADD R2, R2, #1
	ADD R3, R3, R2		; Fix temp's value
	ADD R4, R4, #-1		; Fix Q's value
	ADD R5, R3, #0		; R = temp

FinishDiv
	ADD R1, R4, #0	
	ADD R2, R5, #0
	ADD R0, R3, #0

	LDI R3, SaveR3
	LDI R4, SaveRegR4
	LDI R5, SaveRegR5
	LDI R6, SaveRegR6
	RET

SaveR3    .FILL   #0
SaveRegR4 .FILL   #0
SaveRegR5 .FILL   #0	
SaveRegR6 .FILL	  #0
	
X 	  .FILL   x3100
Y	  .FILL   X3101
PRODUCT   .FILL   x3102
QUO	  .FILL   x3103
MOD	  .FILL   x3104

	  .END
