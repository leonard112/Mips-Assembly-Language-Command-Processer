# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# writes text to the display that explains the commands to the user.

.data
help:	.asciiz	"Enter 'echo' followed by a space and a string to echo.\nEnter 'help' for help.\nEnter 'exit' to exit.\n"
helpExt:	.asciiz	"Enter 'add' followed by the following syntax to add two positive single digit numbers:\nx,x (x is an integer from 0 to 9)\n"
.globl Help 

.text

Help:	la 	$a0, help  	# load the string in the adress location of help into $a0
	jal	writeString	# print out help message.
	la	$a0, helpExt	# load the string in the address location of helpExt into $a0
	jal	writeString	# print out help message.
    	j	main 
