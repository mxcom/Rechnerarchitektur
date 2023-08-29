	.data
str1:	.asciiz "Lager"
str2:	.asciiz "Regal"
str3:	.space 10
	.byte 0xff
	.byte 0xff
	
	.text
	
	la $a0, str1
	jal strturnaround
	la $a0, str2
	jal strturnaround
	
	# end program
	li $v0, 10
	syscall

strturnaround:
	move $t1, $a0   # i (counter): copy for start
	move $t2, $a0	#     n (end): copy to find end

# loop to find the end of the string
find_end:
	lb $t3, ($t2)    # load current character
	beq $t3, 0, loop # compare character and branch if null terminator (end) has been found
	addi $t2, $t2, 1 # increment address to find end
	j find_end

# loop to turn the string around
loop:
	subi $t2, $t2, 1
	lb $t3, ($t2)
	lb $t4, ($t1)
	bge $t1, $t2, end
	
	sb $t4, ($t2)
	sb $t3, ($t1)
	
	addi $t1, $t1, 1
	j loop
	
# exit subroutine and return
end:
	jr $ra
