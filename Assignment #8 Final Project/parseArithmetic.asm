# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# parsees the integers specifed by the user in the add command 'add x,x' (x is an integer from 0-9)

.globl parseArithmetic

.data

operandInvalid:	.asciiz	"Error! Invalid operand!\nValid operands include integers 0-9.\n"
syntaxInvalid:	.asciiz	"Error! Invalid syntax! Valid syntax for arithmetic command: x,x (x is and integer from 0 to 9)\n"

.text

parseArithmetic:	addi	$t0, $a0, 5		# calculate the address of the comma
		lb	$t1, 0($t0)		# load the comma character into $t1
		bne	$t1, 44, invalidSyntax	# if the value stored in $t1 is not a comma, syntax is invalid.
		addi	$t0, $a0, 7		# load the address of the new line character at the end of the command into $t0
		lb	$t1, 0($t0)		# load new line charcater into $t1
		bne	$t1, 10, invalidSyntax	# if the value stored in $t1 is not new line character, syntax is invalid.
		addi	$t0, $a0, 4		# calculate the address of operand 1
		lb	$t2, 0($t0)		# pull character from memory.
		jal	isValidOperand		# check to see if the first operand is valid.
		move 	$t1, $t2			# move the operand 1 to $t1
		addi	$t0, $a0, 6		# calculate the address of operand 2.
		lb	$t2, 0($t0)		# pull character from memory.
		jal	isValidOperand		# check to see if the second operand is valid.
		j	continueAdd		# return to add.	

isValidOperand:	slti	$t3, $t2, 48 		# $t3 set to 1 if $t2 is less than 48 (ascii "0"), and 0 otherwise.
		beq	$t3, 1, invalidOperand	# if $t3 is equal to 1, operand is invalid. (less than range of ascii numbers 48-57)
		slti	$t3, $t2, 58		# $t3 set to 1 if $t2 is less than 58 (less than or equal to asccii "9"), and 0 otherwise
		beq	$t3, 0, invalidOperand	# if $t3 is equal to 1, operand is invalid. (greater than range of ascii numbers 48-57)
		jr	$ra
			
invalidOperand:	la	$a0, operandInvalid		# load invalid operand message into $a0
		jal	writeString		# write invalid operand message to the display.
		j	main

invalidSyntax:	la	$a0, syntaxInvalid		# load invalid syntax message into $a0.
		jal	writeString		# write invalid syntax message to the display.
		j	main
