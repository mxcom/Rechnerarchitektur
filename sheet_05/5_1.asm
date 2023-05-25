	.text
	addiu $4,$0,30	# initalisiere r4/$a0 mit 30
	addiu $5,$0,25	# initalisiere r5/$a1 mit 25
	addu $2,$0,$5	# initalisiere r2/$v0 mit Wert aus r5 = 25 (gemeinsamer Teiler)
	
	beq $4,$0,endless_loop	# Falls r4 = 0 beende den Algorithmus

main:
	beq $5,$0,set_ggT
	
	# Falls r4 < r5:
	slt $t0,$5,$4	   # Falls r5 < r4 speichere 1 in t0, falls nicht 0
	bne $t0,$zero,true # Falls r5 !< r4 wahr ist springe zu true (Also r4 < r5 gilt)

false:
	# Falls r4 !< r5:
	# Entspricht else { ... }
	subu $5,$5,$4
	j marke

# Entspricht demif(r4 < r5) { ... }
true:
	subu $4,$4,$5
	j marke

set_ggT:
	addu $2,$0,$4	# Falls r5 = 0 muss der ggT der Wert von r4 sein
	
endless_loop:
	j endless_loop	# Führt eine endlosschleife aus wenn der Algorithmus beendet ist 
	
	
	
