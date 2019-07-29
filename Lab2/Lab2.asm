; Class: CSE 313 Machine Organization Lab
; Section: 01
; Instructor: Taline Georgiou
; Term: Fall 2017
; Name(s): George Suarez
; Lab# 2: Arithmetic Functions
; Description: This program does three tasks:
;		* Compute X - Y
;		* Compute the absolute values of X and Y
;		* Determine if |x| or |Y| is larger, and place 1
;		  at location x3125 if |X| > |Y|, a 2 if |Y| > |X|, or a
;		  0 if |X| == |Y|.
;
;		Inputs:
;			x3120	X
;			x3121	Y
;		Outputs:
;			x3122	X - Y
;			x3123	|X|
;			x3124	|Y|
;			x3125	Z = 1 if R > 0
;				Z = 2 if R < 0
;				Z = 0 if R = 0
;				where R = |X| - |Y|
;
;		Implementation:
;			R0 and R1 will contain X and Y respectively, and later
;			|X| and |Y| will be stored into R0 and R1.
;			R2 will be used as the operation register.
;
;
;		How to run it:
;			X and Y values will need to be filled in a seperate
;			.asm file by using the .FILL instruction, and .ORIG
;			should start at x3120. Then it needs to be assembled
;			, and loaded into the LC-3 simulator. Finally, load
;			the main program into the LC-3 simulator, and jump to
;			x3120 to find the results of the X and Y values that
;			were filled in.	

.ORIG x3000

	LDI R0, X		; R1 -> MEM[(X = x3120)]
	LDI R1, Y		; R2 -> MEM[(Y = x3121)]
	
	; X - Y
	NOT R2, R1		
	ADD R2, R2, #1		; 2's complement of Y
	ADD R2, R2, R0		; R2 <- X + (-Y)
	STI R2, SUB		

	; |X|
	ADD R2, R0, #0		; Set the condition bit to 0
	BRzp ZPX		; if X >= 0
	NOT R2, R2		
	ADD R2, R2, #1		; R2 -> -R2
ZPX	STI R2, ABSX		; ABSX = |X|

	; |Y|
	ADD R2, R1, #0		; Set the condition bit to 0
	BRzp ZPY		; if Y >= 0
	NOT R2, R2		
	ADD R2, R2, #1		; R2 -> -R2
ZPY	STI R2, ABSY		; ABSY = |Y|

	; load |X| and |Y|
	LDI R0, ABSX
	LDI R1, ABSY
				
	AND R2, R2, #0		; Clear R2 to find Z-values
	
	; |X| - |Y|
	NOT R1, R1		
	ADD R1, R1, #1		; R1 = -|Y|
	ADD R1, R1, R0		; R1 = |X| - |Y|
	
	BRp POS			; if |X| - |Y| > 0 
	BRn NEG			; if |X| - |Y| < 0
	BRz ZERO		; if |X| - |Y| = 0

NEG	ADD R2, R2, #1
POS	ADD R2, R2, #1
ZERO	STI R2, Z		 


HALT	

X	.FILL x3120
Y	.FILL x3121
SUB	.FILL x3122
ABSX	.FILL x3123
ABSY	.FILL x3124
Z	.FILL x3125

.END