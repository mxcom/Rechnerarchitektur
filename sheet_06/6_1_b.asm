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
	
	j end_prog

# Routine: String umkehren
strturnaround:
	move $t0, $a0 # Startadresse
	
sta_find_end:
	lb $t2, 0($a0) # Wert der aktuellen Adresse in t2 speichern
	beqz $t2, sta_swap # Falls Wert gleich 0 Determinierungszeichen gefunden und zu swap springe (True)
	# False
	addiu $a0, $a0, 1 # Aktuelle Addresse um 1 erhöhen, 
	j sta_find_end    # bis Ende gefunden ist

sta_swap:
	subu $t1, $a0, 1 # Um eins dekrementieren, damit man auf letzem Zeichen steht
	
sta_swap_loop:
	bgt $t0, $t1, end
	lb $t2, 0($t0) # Lade Startwert nach t2
	lb $t3, 0($t1) # Lade Endwert   nach t3
	sb $t3, 0($t0) # Lade Endwert    aus t3 nach Startposition
	sb $t2, 0($t1) # Lade Startwert  aus t2 nach Endposotion
	
	addiu $t0, $t0, 1 # Erhöhe Startposition um 1
	subiu $t1, $t1, 1 # Verringere Endposition um 1
	j sta_swap_loop

# Beendet Routine
end:
	jr $ra
	
# Program Ende durch Endlosschleife
end_prog:
	j end_prog
