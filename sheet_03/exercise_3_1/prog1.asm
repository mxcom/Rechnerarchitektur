	.text
	#       rt rs immediate
	addi	$8,$0,0 # initalize register $8 with 0
loop:
	#       rt rs immediate
	addi	$8,$8,1 # increase the value of $8 by 1
	j	loop	# jump back to loop
