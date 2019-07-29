; Class: CSE 313 Machine Organization Lab
; Section: 01
; Instructor: Taline Georgiou
; Term: Fall 2017
; Name(s): George Suarez
; Lab #4: Fibonocci Numbers
; Description: This programs computes F_n, the n-th Fibonacci number. It
; 	       finds the largest F_n such that no overflow occurs, i.e. find
;              n = N such that F_N is the largest Fibonacci number to be 
;	       correctly represented with 16 bits in two's complement format.
;
;	       Inputs:
;			The integer n will be in memory location x3100
;			where n <= N
;
;	       Outputs:
;			x3101 ---- F_n	- n-th Fibonacci number
;			x3102 ---- N    - Largest Fibonacci number count
;			x3103 ---- F_N  - Nth Fibonacci number
;
;	       Implementation:
;			R0 will hold the temp values
;			R1 = a
;			R2 = b
;			R3 = n
;			R4 = F
;			R5 = N

.ORIG x3000

	LDI R3, n
	
	AND R1, R1, #0
	ADD R1, R1, #1		; a = 1 (F_(n-2))
	ADD R2, R1, #0		; b = a (F_(n-1))
	ADD R4, R1, #0		; F = a
	ADD R5, R1, #1		; N = a + 1 = 2 

	ADD R0, R3, #-2
	BRnz STFn		; check if n > 2

FIBLOOP
	ADD R4, R4, #0	
	BRn STBigN		; check if F < 0
	
	ADD R4, R1, R2		; F = a + b (F_n = F_(n-1) + F_(n-2))
	ADD R1, R2, #0		; a = b
	ADD R2, R4, #0		; b = F
	
	ADD R5, R5, #1		; N = N + 1
	
	NOT R0, R3
	ADD R0, R0, #1
	ADD R0, R5, R0		; N - n
	BRz STFn		; check if N = n
	
	BR FIBLOOP

STFn
	STI R2, Fn		; R2 <- MEM[x3101] = b
	BR FIBLOOP

STBigN
	ADD R5, R5, #-1
	STI R5, BigN		; R5 <- MEM[x3102] = N - 1
	STI R1, FBigN		; R1 <- MEM[x3103] = a

	HALT

n	.FILL	x3100
Fn	.FILL	x3101
BigN	.FILL 	x3102
FBigN	.FILL	x3103

	.END