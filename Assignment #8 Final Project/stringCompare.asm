# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# compares two null terminated Strings. ($t2 is set to 0 is not equal and 1 if the strings are equal)

.globl stringCompare

.text

stringCompare:	li	$t3, 0			# initialize counter.
stringCompareLoop:	add	$t4, $a1, $t3		# calculate the address of the character being pulled from the inputed token.
		add	$t5, $a2, $t3		# calculate the address of the character being pulled from the token from the table.
		lb	$t6, 0($t4)		# load the inputed token into $t6.
		lb	$t7, 0($t5)		# load the token taken from the table into $t7.
		bne	$t7, $t6, charsNotEqual	# if not equal, go back to executeCommand.asm and keep looking.
		beq	$t6, 0, charsEqual		# reaching null char while both chars are null indicates that the strs are equal.
		addi	$t3, $t3, 1		# increment counter.
		j	stringCompareLoop		# keep looping until end of the strings is reached or when characters are not equal.
		
charsNotEqual:	li	$t2, 0			# set $t2 to zero to indicate that the strings are not equal.
		j	continue			# go back to executeCommand.asm.
		
charsEqual:	li	$t2, 1			# set $t2 to 1 to indicate the the strings are equal.
		j 	continue			# go back to executeCommand.asm.
		
