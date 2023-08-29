	.data
str1:	.asciiz "Lager"
str2:	.asciiz "Regal"
str3:	.space 10
	.byte 0xff
	.byte 0xff
pal:	 .asciiz "Ist ein Palindrom"
nopal:   .asciiz "Ist kein Palindrom"	

	.text
	
	la $a0, str1
	jal strispalindrom
	move $t1, $v0
	
	# Check wheter return value is 1 or 0 to print wheter palindrom or not
	beq $v0, 1, print_pal
	beq $v0, 0, print_nopal
	j end_program
	
	# la $a0, str2
	# jal strturnaround
	j end_program

strispalindrom:
	move $t1, $a0   # i (counter): copy for start
	move $t2, $a0	#     n (end): copy to find end

# loop to find the end of the string
find_end:
	lb $t3, ($t2)    # load current character
	beq $t3, 0, loop # compare character and branch if null terminator (end) has been found
	addi $t2, $t2, 1 # increment address to find end
	j find_end

# loop to check wheter palindrom	
loop:
	subi $t2, $t2, 1
	lb $t3, ($t2)
	lb $t4, ($t1)
	bge $t1, $t2, end
	
	bne $t3, $t4, no_palindrom
	
	addi $t1, $t1, 1
	li $v0, 1	# set return value to 1
	j loop

# sets return to 0 if no palindrom
no_palindrom:
	li $v0, 0
	j end

# exit subroutine and return	
end:
	jr $ra

# print text if it's a palindrom	
print_pal:
	li $v0, 4	# set up: print string syscall (4)
	la $a0, pal	# argument to print str
	syscall
	j end_program

# print text if it's not a palindrom		
print_nopal:
	li $v0, 4	# set up: print string syscall (4)
	la $a0, nopal	# argument to print str
	syscall
	j end_program

end_program:
	# end program
	li $v0, 10
	syscall
