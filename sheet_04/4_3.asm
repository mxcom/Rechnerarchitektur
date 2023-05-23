	.text
	addi $8,$0,0
	addi $9,$0,11
	addi $10,$0,0x1000
	addi $11,$0,-1
	addi $12,$0,-0x8000
	ori $13,$0,0x8000
	lui $14,0xffff		# GPR[14]
	ori $14, $14, 0x0000
	lui $15,0x7fff		# GPR[15]
	ori $15, $15, 0xffff
	addi $24,$0,5322	# GPR[24]
	addi $25,$0,75