# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# stores the command token specified by the user in the input buffer into the token buffer.

.globl parseString
.text 
parseString:	li	$t1, 0		# initialize counter.
parseLoop:	add	$t2, $a0, $t1	# calculate address where the caracter is being pulled from the input buffer.
		add	$t3, $a1, $t1	# calculate store address for the character being moved from the input buffer to the token buffer.
		lb 	$t4, 0($t2)	# store the character from the input buffer into $t4.
		beq	$t4, 10, parseExit	# go to exit if the character stored in $t4 is new line character.
		beq	$t4, 32, parseExit	# go to exit if the character stored in $t4 is the space character.
		sb	$t4, 0($t3)	# store the character stored in $t4 into the token buffer.
		addi	$t1, $t1, 1	# increment counter.
		j	parseLoop		
	
parseExit:	li	$t4, 0		# store null character into $t4.
		sb	$t4, 0($t3)	# put null character at the end of token.
		jr	$ra		
