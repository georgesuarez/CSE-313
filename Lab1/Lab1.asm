;CSE 313 Machine Organization LAb
;Section 01
;Instructor: Taline Georgiou
;Term: Fall 2017
;Names: Lucas Casillas & George Suarez
;Lab #1: ALU Operations
;Description: This is a program that inputs an X and Y value and does various tasks to the variables.
;Such tasks include Addition, Subtraction, make Negative, and find the Even and Odd. Once these tasks are
;Completed, it places the result onto an address and displays the binary, hex, and decimal of the result.


.ORIG 	x3000

LEA R2, xFF	; R2 < x3000 + x1 + xFF (=x3100)
LDR R1, R2, x0	; R1 < MEM[x3100]
LDR R3, R2, x1	; R3 < MEM[x3100 + x1]
;X + Y
ADD R4, R1, R3  ; R4 = R1 + R3
STR R4, R2, x2	; R4 > MEM[x3100 + x2]
;X AND Y
AND R4, R1, R3	; R4 < R1 And R3
STR R4, R2, x3	; R4 > MEM[x3100 + x3]
;X OR Y
NOT R5, R1	; R5 < NOT(R1)
NOT R6, R3	; R6 < NOT(R3)
AND R4, R5, R6  ; R4 < R5 AND R6
NOT R4, R4	; R4 < NOT(R4)
STR R4, R2, x4	; R4 > MEM[x3100 + x4]
;NOT X
NOT R4, R1	; R4 < /R1
STR R4, R2, x5	; R4 > MEM[x3100 + x5]
;NOT Y
NOT R4, R3	; R4 < /R3
STR R4, R2, x6	; R4 > MEM[x3100 + x6]
;X + 3
ADD R4, R1, x3	; R4 < R1 + 3
STR R4, R2, x7	; R4 > MEM[x3100 + x7]
;Y - 3
ADD R4, R3, x-3 ; R4 < R3 - 3
STR R4, R2, X8	; R4 > MEM[x3100 + x8]
;X even or odd
AND R4, R1, x1	; R4 < R1 and 00..
STR R4, R2, x9	; R4 > MEM[x3100 + x9]
HALT
.END