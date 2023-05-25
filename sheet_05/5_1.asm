	.text
	addiu $4,$0,30	# Initalisiere r4/$a0 mit 30
	addiu $5,$0,25	# Initalisiere r5/$a1 mit 25
	addu $2,$0,$5	# Initalisiere r2/$v0 mit Wert aus r5 = 25 (gemeinsamer Teiler)
	
	beq $4,$0,endless_loop	# Falls r4 = 0 beende den Algorithmus

main:
	beq $5,$0,set_ggT
	
	slt $t0,$5,$4	   # Falls r5 < r4 speichere 1 in t0, falls nicht 0
	bne $t0,$zero,true # Falls r5 !< r4 wahr ist springe zu true (Also r4 < r5 gilt)

# Entspricht else { ... } (r4 !< r5)
false:
	# Falls r4 !< r5:
	# Entspricht else { ... }
	subu $5,$5,$4
	j main

# Entspricht if(r4 < r5) { ... }
true:
	subu $4,$4,$5
	j main

set_ggT:
	addu $2,$0,$4	# Falls r5 = 0 muss der ggT der Wert von r4 sein
	
endless_loop:
	j endless_loop	# Führt eine endlosschleife aus wenn der Algorithmus beendet ist 
	
	
# a)

# (30,25)
# addiu $4,$0,30	# Initalisiere r4/$a0 mit 30
# addiu $5,$0,25	# Initalisiere r5/$a1 mit 25

# (25,35)
# addiu $4,$0,25	# Initalisiere r4/$a0 mit 25
# addiu $5,$0,35	# Initalisiere r5/$a1 mit 35

# (210,28)
# addiu $4,$0,210	# Initalisiere r4/$a0 mit 210
# addiu $5,$0,28	# Initalisiere r5/$a1 mit 28

# (49,42)
# addiu $4,$0,49	# Initalisiere r4/$a0 mit 49
# addiu $5,$0,42	# Initalisiere r5/$a1 mit 42

# (17,3)
# addiu $4,$0,17	# Initalisiere r4/$a0 mit 17
# addiu $5,$0,3		# Initalisiere r5/$a1 mit 3

# (17,51)
# addiu $4,$0,17	# Initalisiere r4/$a0 mit 17
# addiu $5,$0,51	# Initalisiere r5/$a1 mit 51