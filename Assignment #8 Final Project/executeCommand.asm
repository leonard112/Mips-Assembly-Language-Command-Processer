# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# finds the command specifed by the user in the table and executes it.

.globl executeCommand
.globl continue
.data

CMDNotFound:	.asciiz	"Command not found\n"	# messege to let the user know the command was not found.

.text
executeCommand:	la 	$t0, table		# load start index of table into $t0
		la 	$t1, endTbl		#load end of table into $t1
		
findCommandLoop:	la	$a2, 0($t0)		# load string from the table into $a2.
		j  	stringCompare		# compare token and string in table
continue:		beq	$t2, 1, goToCommand		# if equal, go to the command ($t2 set to 1 if strings are equal)
		addi	$t0, $t0, 12		# increment address for next string in the table.
		bne	$t0, $t1, findCommandLoop	# keep looping until end of table reached.
		
		la	$a0, CMDNotFound		# load CMDNotFound into $a0
		j	writeString		# write the string stored in CMDNotFound.
findCommandExit:	j	main
		
goToCommand:	addi	$t0, $t0, 8		# update index for the adress of the command.
		lw	$a2, 0($t0)		# update the address for the command and store it into $a0
		jalr	$a2			# jump to the command.
	
		
