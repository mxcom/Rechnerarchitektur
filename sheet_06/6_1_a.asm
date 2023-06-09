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
	
	j end_prog

# Routine: Großbuchstaben -> Kleinbuchstaben	
strtolower:
	li $t0, 'A'
	li $t1, 'Z'
	
stl_loop:
	lb $t2, 0($a0)	# Aktuelles Zeichen
	
	beq $t2, $zero, end # Falls aktuelles Zeichen NULL beende Routine
	blt $t2, $t0, stl_next	 # Falls aktuelles Zeichen kleiner A gehe zum nächsten Zeichen
	bgt $t2, $t1, stl_next	 # Falls aktuelles Zeichen größer  Z gehe zum nächsten Zeichen
	
	addiu $t2, $t2, 32 # Falls aktuelles Zeichen Großbuchstabe -> +32 um zum kleinen Zeichen zu komme
	sb $t2, 0($a0)	   # Schreibe neuen/kleinen Buchstabe an Stelle in Data Section

# Gehe zum nächsten Zeichen
stl_next:
	addiu $a0, $a0, 1
	j stl_loop


# Beendet Routine	
end:
	jr $ra
	
# Program Ende durch Endlosschleife
end_prog:
	j end_prog