	.data
str1:	.asciiz "Lager"
str2:	.asciiz "Regal"
str3:	.space 10
	.byte 0xff
	.byte 0xff
	
	.text
	la $a0, str1
	la $a1, str2
	jal strispalindrom

# Routine: Palindrom überprüfen	
strispalindrom:
	move $t0, $a0
 
sp_find_end:
 	lb $t2, 0($a0) # Wert der aktuellen Adresse in t2 speichern
 	beqz $t2, palindrom_check # Falls Wert gleich 0 Determinierungszeichen gefunden und zu swap springe (True)
 	
palindrom_check:	