# Leonard Carcaramo (utilizes code from the class examples, and previous programing assignments)
# echos the string following an echo command.

.data

.globl Echo 

.text

Echo: 	addi	$a0, $a0, 5	# increment the adress of user input by 5 to start at the beginning of the string the user wants to echo
	jal	writeString	# print out the string.
    	j	main
