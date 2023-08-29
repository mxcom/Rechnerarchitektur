	.data
str:	.space 50
char:	.space 1
prompt_string: .asciiz "Type a string>"
prompt_char:   .asciiz "Type a char>"
output_number: .asciiz " occurence(s)"

	.text
	
	# take user input
	la $a0, prompt_string
	li $v0, 4
	syscall
	
	la $a0, str	# a0 = address of input buffer
	li $a1, 51	# a1 = max. number of characters to read (51 -> 50 characters allowed)
	li $v0, 8
	syscall
	
	la $a0, prompt_char
	li $v0, 4
	syscall
	
	la $a0, char	# # a0 = address of input buffer
	li $a1, 2	# # a1 = max. number of characters to read (51 -> 50 characters allowed)
	li $v0, 8
	syscall
	
	# subroutine call
	la $a0, str
	la $a1, char
	jal ncstr
	
	move $t6, $v0 # copy number of times character found to t6
		      # to work with v0 for syscalls
	
	# print number of occurences
	move $a0, $t6
	li $v0, 1
	syscall
	
	la $a0, output_number
	li $v0, 4
	syscall
	
	# end program
	j end
	
ncstr:
	move $t0, $a0 # address start of string (increment beginning) 
	move $t1, $a0 # address end of string (increment end) - need to be found
	move $t2, $a1 # address of char to count
	lb $t5, ($t2) # character to count

# used to find the address end of the string
find_end:
	lb $t3, ($t1)
	beqz $t3, loop	 # loop as long as the null character has been found
	addi $t1, $t1, 1 # increment address
	j find_end

# loop to find the characters
loop:
		      # $t1 = address at end
	              # $t0 = address at start/increment 
	lb $t4, ($t0) # $t4 = byte at start start/increment
	beq $t0, $t1, exit
	beq $t4, $t5, increment
	addi $t0, $t0, 1
	j loop
	
# counter incremented when character found
increment:
	addi $t6, $t6, 1 # number of times character found
	addi $t0, $t0, 1
	j loop

# exit subroutine	
exit:
	move $v0, $t6
	jr $ra
	
# end program
end:
	li $v0, 10
	syscall