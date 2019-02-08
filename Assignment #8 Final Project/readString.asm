# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# Reads in a string from the keyboard.

# Memory mapped addresses of device fields.
.eqv kbInCtl 0xFFFF0000	# 0xFFFF0000 rcv contrl
.eqv kbInData 0xFFFF0004	# 0xFFFF0004 rcv data
.eqv dispOutCtl 0xFFFF0008	# 0xFFFF0008 tx contrl
.eqv dispOutData 0xFFFF000c	# 0xFFFF000c tx data		

# buffer address in $a0
# number of characters to read in $a1
.globl readString
.text			
readString:		 
	la     	$t1,kbInCtl		# set up register for input control word
	li	$t2, 0			# initialize counter
	li	$a1, 10			# character being looked for to tell the program that the user is done inputing characters.
	li	$a2, 00			#null character to be added to end of the string.
loop:
	lw	$t3,0($t1)	        	# read rcv ctrl
	andi	$t3,$t3,0x0001		# extract ready bit
	beq	$t3,$0,loop		# keep polling till ready
# move character	
	lb	$t4,kbInData		# read character into temporary register
	beq 	$t4, 8, removePrevious	# if backspace character is entered remove the previous character
	
	add	$t5, $a0, $t2		# calculate store address
	sb 	$t4, 0($t5)		# store each character read in the to the end of the string.
	addi	$t2, $t2, 1		# increment counter
	
	beq	$t2, 78, bufferFilled	# go to bufferFilled if the buffer is two characters away from being full
	bne	$a1, $t4, loop		# test for new line character entered.
	
	add	$t5, $a0, $t2		# calculate store address
	sb 	$a2, 0($t5)		# make string null terminated.
	addi	$t2, $t2, 1		# increment counter
	
	jr	$ra			# if end do return
	
bufferFilled:
	beq	$a1, $t4, nullTerminate	# terminate with null if third to last space in buffer is new line character.
	
	add	$t5, $a0, $t2		# calculate store address
	sb 	$a1, 0($t5)		# add new line character to the end.
	addi	$t2, $t2, 1		# increment counter
nullTerminate:	
	add	$t5, $a0, $t2		# calculate store address
	sb 	$a2, 0($t5)		# make string null terminated
	addi	$t2, $t2, 1		# increment counter
	
	jr	$ra			#return
	
removePrevious:	
	beq	$t2, 0, loop		# if the counter is 0 go back to loop because there is nothing to remove.
	addi	$t2, $t2, -1		# decrement the counter by 1
	j	loop			# go back to loop, previous character will be overwritten with the next character if not backspace.
