	.text
	addi $8,$0,0
	addi $9,$0,11
	addi $10,$0,0x1000
	addi $11,$0,-1
	addi $12,$0,-0x8000	#  Zweierkomplement: 0x8000 ->         1000 0000 0000 0000
				#                                      0111 1111 1111 1111 (+1)
				# 			               1000 0000 0000 0000
				#  Sign Extension: 1111 1111 1111 1111 1000 0000 0000 0000
				#                  f    f    f    f    8    0    0    0
	
	ori $13,$0,0x8000	# 0x8000 wird bei ori nicht als Zweierkomplement interpretiert
	
	lui $14,0xffff		# Setzt obere Haelfte des Zielregisters (16 Bits von 32 Bits) auf 0xffff
	
	lui $15,0x7fff		# Obere Haelfte auf 0x7fff setzen
	ori $15,$15,0xffff	# Untere Haelfte durch OR Operation auf 0xffff setzen:
				#    7fff0000
				#    0000ffff
				# OR --------
				#    7fffffff
	
	addi $24,$0,5322
	addi $25,$0,75