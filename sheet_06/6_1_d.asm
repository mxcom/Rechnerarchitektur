	.data
str1:	.asciiz "Lager"
str2:	.asciiz "Regal"
str3:	.space 10
	.byte 0xff
	.byte 0xff
	
	.text
	
	la $a0, str1
	la $a1, str2
	la $a2, str3
	jal strcat
	
	# end program
	li $v0, 10
	syscall
	
strcat:
	move $t1, $a0
	move $t2, $a1
	move $t3, $a2
	
# loop to find the end of the string
find_end_1:
	lb $t4, ($a0)    	 # load current character
	beq $t4, 0, write_loop_1 # compare character and branch if null terminator (end) has been found
	addi $a0, $a0, 1 	 # increment address to find end
	j find_end_1
	
write_loop_1:
	lb $t5, ($t1)		 # start
	beq $t1, $a0, find_end_2 # if start >= end continue with next string
	
	sb $t5, ($t3)
	addi $t3, $t3, 1
	addi $t1, $t1, 1	 # i++
	j write_loop_1
	
find_end_2:
	lb $t4, ($a1)    	 # load current character
	beq $t4, 0, write_loop_2 # compare character and branch if null terminator (end) has been found
	addi $a1, $a1, 1 	 # increment address to find end
	j find_end_2
	
write_loop_2:
	lb $t5, ($t2)		 # start
	beq $t2, $a1, end	 # if start >= end continue with next string
	
	sb $t5, ($t3)
	addi $t3, $t3, 1
	addi $t2, $t2, 1	 # i++
	j write_loop_2
	
end:
	jr $ra
	