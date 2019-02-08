# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# prints prompt, stores user input into the input buffer, parses the token for the secified command, and executes the command.

.globl main
.globl table
.globl endTbl
.data

table: 	.asciiz 	"help"
	.word  	Help
	.asciiz 	"echo"
	.word 	Echo
	.asciiz 	"exit"
	.word 	Exit
	.asciiz	"add\0\0"
	.word	Addc
endTbl: 	.word 	0

prompt:		.asciiz 	">> "	# CMD prompt
inputBuffer:	.space 	80	# space where user input will be stored.
token:		.space 	80	# space where parsed token will be stored.

.text

main:	la 	$a0, prompt	# load the prompt into $a0
	jal 	writeString	# write prompt to the display.
	la	$a0, inputBuffer	# load the input buffer into $a0
	jal	readString	# read in user input and store it into the input buffer.
	jal	writeString	# write what the user inputed to the display.
	la	$a1, token	# load the token buffer into $a1
	jal	parseString	# parse the command token from input buffer.
	jal	executeCommand	# execute the command specified by the user.
	j	main

	 
