# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# terminates the program.

.data

exitMessage:	.asciiz "The program has been terminated."	# messege to let the user know the programe was terminated.

.globl Exit 

.text

Exit: 	la	$a0, exitMessage				# load the exit message into $a0.
	jal	writeString				# write exit message to the display.
	li  	$v0, 10  					# exit
    	syscall
