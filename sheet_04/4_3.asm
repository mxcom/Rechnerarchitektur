	.text
	addi $8,$0,0
	addi $9,$0,11
	addi $10,$0,0x1000
	addi $11,$0,-1
	addi $12,$0,-0x8000	
	ori $13,$0,0x8000
	lui $14,0xffff
	lui $15,0x7fff
	ori $15,$15,0xffff
	addi $24,$0,5322
	addi $25,$0,75
	
	# 4.3
	
	add $2,$10,$9
	sub $3,$10,$9
	
	nor $4,$0,$9	# Komplement von $9 bilden und in $4 speichern
	add $4,$4,$10
	addi $4,$4,1
	
	sll $5,$13,5
	sra $6,$13,5
	sra $7,$12,5
	srl $16,$12,5
	srlv $17,$13,$9
	
	div $24,$25	# Quotient gespeichert in LO Register
			#     Rest gespeichert in HI Register
	mflo $18	# move from lo: Kopiert Inhalt von LO Register (Quotient) in $18
	
	mfhi $19	# move from hi: Kopiert Inhalt von HI Register (Rest) in $19
	
	addiu $20,$15,1
	
	addi $21,$15,1
	
	clo $22,$11
	clo $23,$14
	
	