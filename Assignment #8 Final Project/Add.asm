# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# adds the two integers (0-9) specifed by the the user in the add command.
# arithmetic is parsed to pull out the two integers.
# the add operation is performed by converting the integer from ascii to integers and then the total is converted back to ascii.

.globl Addc
.globl continueAdd

.data
sum:	.space	4				# the sum of the two intgers is stored here.

.text
Addc:		j	parseArithmetic		# check the syntax of add command, and store the operands into $t1, %t2
continueAdd:	addi	$t1, $t1, -48		# convert operand 1 from ascii to integer by subtracting 48
		addi	$t2, $t2, -48		# convert operand 2 from ascii to integer by subtracting 48
		add	$v0, $t1, $t2		# add operands 1 and 2.
		la	$a0, sum			# load the address where the ascii form of the sum will be stored.
		li	$t4, 1			# start a counter.
		li	$t6, 10			# load 10 into $t6.
		addi	$t7, $v0, 0		# copy the sum from $v0 into $t7.
		
addLoop:		div	$t7, $t6			# divide the sum by 10
		mflo	$t7			# store quotient into $t7
		mfhi	$t3			# store remainder into $t3
		addi	$t3, $t3, 48		# convert to ascii by adding 48
		add	$t5, $a0, $t4		# calculate the store address for ascii number character
		sb	$t3, 0($t5)		# store character into memory.
		addi	$t4, $t4, -1		# decrement counter
		beq	$t4, -1, finnishResults 	# if counter is less than 0, go to finnishResults
		bne 	$t7, 0, addLoop		# loop if quotient is not 0.
		
finnishResults:	addi	$t5, $a0, 2		# calculate the address where new line character will be stored.
		li	$t3, 10			# load new line characrter into $t3
		sb	$t3, 0($t5)		# store new line character at the end.
		addi	$t5, $a0, 3		# calculate the address where null ascii character will be stored.
		li	$t3, 0			# load null character into $t3.
		sb	$t3, 0($t5)		# store null charcater at the end.
		
		slti	$t6, $v0, 10		# if the sum is less than 10 set $t6 to 1
		li	$t7, 1			# load 1 into $t7
		beq	$t6, $t7, advance		# advance the address of the start of the string that contains the sum by 1
continueResults:	jal	writeString		# display results
		j	main
		
advance:		addi	$a0, $a0, 1		#increment the memeory address at $a0 by 1
		j	continueResults
		
