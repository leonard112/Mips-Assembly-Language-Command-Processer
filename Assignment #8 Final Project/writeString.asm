# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# writes a string to the display.

# Memory mapped addresses of device fields.
.eqv kbInCtl 0xFFFF0000	# 0xFFFF0000 rcv contrl
.eqv kbInData 0xFFFF0004	# 0xFFFF0004 rcv data
.eqv dispOutCtl 0xFFFF0008	# 0xFFFF0008 tx contrl
.eqv dispOutData 0xFFFF000C	# 0xFFFF000c tx data	

# buffer address in $a0
# number of characters to output in $a1
.globl writeString
writeString:		

	la      	$t1,dispOutCtl	# set up register for output control word
	la	$t5,dispOutData
	li	$t2, 0		# initialize counter
	li	$a1, 0		# character being looked for to tell the program when to stop displaying characters.
	
# loop until last character written out
loop:	lw	$t3,0($t1)	# read disp ctrl
	andi	$t3,$t3,0x0001  	# extract ready bit 
	beq	$t3,$0,loop 	# poll till ready for next character
output:	add 	$t4, $a0, $t2	# calculate output byte address
	lbu	$t6, 0($t4)	# move byte to output field
	sw	$t6, ($t5)	
	addi 	$t2, $t2, 1	# increment counter
	bne	$t6, $a1, loop	# keep looping until null ascii character is found.
	jr	$ra		# return
	
