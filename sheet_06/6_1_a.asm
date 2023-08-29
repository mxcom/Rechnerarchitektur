	.data
str1:	.asciiz "Lager"
str2:	.asciiz "Regal"
str3:	.space 10
	.byte 0xff
	.byte 0xff
	
	.text
	
	la $a0, str1
	jal strtolower
	la $a0, str2
	jal strtolower
	
	# exit
	li $v0, 10
	syscall
	
strtolower:
	move $t1, $a0  	     # move address of string in $t1
	
loop:
	lb $t3, ($t1)
	beq $t3, 0, end
	
	sle $t4, $t3, 0x5A   # t4 = t3 <= 0x5A ? 1 : 0
	sge $t5, $t3, 0x41   # t4 = t3 >= 0x5A ? 1 : 0
	beq $t4, $t5, format # if character in ascii range of uppercase jump to format
	addi $t1, $t1, 1     # increment by 1 to get to the next byte
	j loop
	
format:
	addi $t3, $t3, 0x20  # convert uppercase to lower case
	sb $t3, ($t1)        # write byte lowercase byte to string
	addi $t1, $t1, 1     # increment by 1 to get to the next byte
	j loop
	
end:
	jr $ra

