	.data
str:	.asciiz "Hello, World"
char:	.byte 'l'
text:   .asciiz "l found: "

	.text
	la $a0, str
	la $a1, char
	jal ncstr
	
	move $t6, $v0 # copy number of times character found to t6
		      # to work with v0 for syscalls
	
	la $a0, text
	li $v0, 4
	syscall
	
	move $a0, $t6
	li $v0, 1
	syscall
	
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