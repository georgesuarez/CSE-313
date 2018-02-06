; Class: CSE 313 Machine Organization Lab
; Section: 01
; Instructor: Taline Georgiou
; Term: Fall 2017
; Name(s): George Suarez
; Lab #3: Days of the Week
; Description: This program will prompt for an integer in the range of
;	       0-6, and it will output the corresponding name of the day.
;	       If the input is other than '0' through '6', the program
;	       will exit.
;
;	       Inputs:
;			At the prompt "Please enter a number: " a key is pressed.
;
;	       Outputs:
;			If the key pressed is '0' through '6', the corresponding
;			name of the day of the week appears on the monitor.
;			The following days will be printed given the corresponding
;			code:
;		
;				Code   Day
;				0      Sunday
;				1      Monday
;				2      Tuesday
;                               3      Wednesday
;				4      Thursday
;				5      Friday
;                               6      Sunday
;
;	       Implementation:
;			R0 will handle the string and input operations
;                       R1 will hold the temp values while R0 performs
;			the necessary operations





.ORIG x3000

; Get user input
INPUTLOOP
	LEA R0, PROMPT		; load the prompt string into R0
	PUTS			; print the prompt
	GETC			; R0 contains the ASCII value of input char
	OUT
	ADD R1, R0, #0		; copy the value of R0 into R1
	LD  R0, NEWLINE		; so we can reuse R0
	OUT
	ADD R0, R1, #0

	ADD R0, R0, #-16	; Subtract 48, the ASCII value of 0
	ADD R0, R0, #-16
	ADD R0, R0, #-16	; R0 now contains the actual value

	ADD R1, R0, #-6
	BRp ENDPROGRAM		; Test if R0 <= 6
	ADD R1, R0, #0		
	BRn ENDPROGRAM		; Test if R0 >= 0

	LEA R0, DAYS		; Address of "Sunday" in R0
	ADD R1, R1, #0

; The loop implements R0 <- R0 + 10 * i
LOOP	BRz DISPLAY
	ADD R0, R0, #10		; Go to next day
	ADD R1, R1, #-1		; Decrement loop variable
	BR LOOP

DISPLAY PUTS
	LD R0, NEWLINE
	OUT
	OUT

	BR INPUTLOOP
	
		
ENDPROGRAM
	HALT

PROMPT 	.STRINGZ "Please enter a number: "

DAYS	.STRINGZ "Sunday   "
	.STRINGZ "Monday   "
	.STRINGZ "Tuesday  "
	.STRINGZ "Wednesday"
	.STRINGZ "Thursday "
	.STRINGZ "Friday   "
	.STRINGZ "Saturday "


NEWLINE .FILL 	  x000A

	.END