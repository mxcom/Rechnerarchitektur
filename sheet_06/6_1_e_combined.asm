	.data
str1:	.asciiz "ReGal"
str2:	.asciiz "Lager"
str3:	.space 10
	.byte 0xff
	.byte 0xff
pal:	.asciiz "Ist ein Palindrom"
nopal:  .asciiz "Ist kein Palindrom"	
	
	.text
	
	la $a0, str1
	jal strtolower
	la $a0, str2
	jal strtolower
	la $a0, str1
	jal strturnaround
	la $a0, str2
	jal strturnaround
	la $a0, str1
	la $a1, str2
	la $a2, str3
	jal strcat
	la $a0, str3
	jal strispalindrom
	
	# Check wheter return value is 1 or 0 to print wheter palindrom or not
	beq $v0, 1, print_pal
	beq $v0, 0, print_nopal
	j end_program
	

# --- String To Lower ---	
strtolower:
	move $t1, $a0  	     # move address of string in $t1
	
loop_lower:
	lb $t3, ($t1)
	beq $t3, 0, end
	
	sle $t4, $t3, 0x5A   # t4 = t3 <= 0x5A ? 1 : 0
	sge $t5, $t3, 0x41   # t4 = t3 >= 0x5A ? 1 : 0
	beq $t4, $t5, format # if character in ascii range of uppercase jump to format
	addi $t1, $t1, 1     # increment by 1 to get to the next byte
	j loop_lower
	
format:
	addi $t3, $t3, 0x20  # convert uppercase to lower case
	sb $t3, ($t1)        # write byte lowercase byte to string
	addi $t1, $t1, 1     # increment by 1 to get to the next byte
	j loop_lower

# --- String Turn Around ---	
strturnaround:
	move $t1, $a0   # i (counter): copy for start
	move $t2, $a0	#     n (end): copy to find end

# loop to find the end of the string
find_end_around:
	lb $t3, ($t2)    # load current character
	beq $t3, 0, loop_around # compare character and branch if null terminator (end) has been found
	addi $t2, $t2, 1 # increment address to find end
	j find_end_around

# loop to turn the string around
loop_around:
	subi $t2, $t2, 1
	lb $t3, ($t2)
	lb $t4, ($t1)
	bge $t1, $t2, end
	
	sb $t4, ($t2)
	sb $t3, ($t1)
	
	addi $t1, $t1, 1
	j loop_around
	
# --- String Cat ---
strcat:
	move $t1, $a0
	move $t2, $a1
	move $t3, $a2
	
# loop to find the end of the first string ($a0)
find_end_1:
	lb $t4, ($a0)    	 # load current character
	beq $t4, 0, write_loop_1 # compare character and branch if null terminator (end) has been found
	addi $a0, $a0, 1 	 # increment address to find end
	j find_end_1

# loop to write the first string at $a2
write_loop_1:
	lb $t5, ($t1)		 # start
	beq $t1, $a0, find_end_2 # if start >= end continue with next string
	
	sb $t5, ($t3)
	addi $t3, $t3, 1
	addi $t1, $t1, 1	 # i++
	j write_loop_1

# loop to find the end of the second string ($a1)
find_end_2:
	lb $t4, ($a1)    	 # load current character
	beq $t4, 0, write_loop_2 # compare character and branch if null terminator (end) has been found
	addi $a1, $a1, 1 	 # increment address to find end
	j find_end_2

# loop to write the second string at $a2	
write_loop_2:
	lb $t5, ($t2)		 # start
	beq $t2, $a1, end	 # if start >= end continue with next string
	
	sb $t5, ($t3)
	addi $t3, $t3, 1
	addi $t2, $t2, 1	 # i++
	j write_loop_2

# --- Palindrom ---
strispalindrom:
	move $t1, $a0   # i (counter): copy for start
	move $t2, $a0	#     n (end): copy to find end
	li $t7, 0xffffffff

# loop to find the end of the string
find_end:
	lb $t3, ($t2)    # load current character
	beq $t3, $t7, loop_pal # compare character and branch if null terminator (end) has been found
	addi $t2, $t2, 1 # increment address to find end
	j find_end

# loop to check wheter palindrom	
loop_pal:
	subi $t2, $t2, 1
	lb $t3, ($t2)
	lb $t4, ($t1)
	bge $t1, $t2, end
	
	bne $t3, $t4, no_palindrom
	
	addi $t1, $t1, 1
	li $v0, 1	# set return value to 1
	j loop_pal

# sets return to 0 if no palindrom
no_palindrom:
	li $v0, 0
	j end
	
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

