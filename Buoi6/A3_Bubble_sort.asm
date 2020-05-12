.data # bubble sorting algorithm 
	A: .word 2, -1, 1, 3, -4, 5, 6, 7
	Aend: .word 999
.text
	la $a0, A		# first element of A
	la $a1, Aend
	subi $a1, $a1, 4	# last element of A
	or $a2, $a0, $zero	# outer running address
	or $a3, $a0, $zero	# inner running address
	j outer_loop
	nop
	
outer_loop:
	or $a3, $a0, $zero	# running index # 0 < $a0 < $a3 < $a2 < $a1 
	j inner_loop
	nop
	inner_loop:
		beq $a2, $a3, exit_inner_loop	 # exit if reach the last element
		nop
		lw $s0, 0($a2)		# first value
		lw $s1, 0($a3) 	# load second value to s1
		# ascending
		#slt $s2, $s1, $s0 	# compare two value
		# decending
		slt $s2, $s0, $s1 	# compare two value
		beq $s2, 1, continue
		nop
			#swap here
			sw $s1, 0($a2)
			sw $s0, 0($a3)
		continue:
			addi $a3, $a3, 4	
			j inner_loop
			nop
	exit_inner_loop:
	beq $a2, $a1, exit_outer_loop # exit if reach the last element
	addi $a2, $a2, 4
	j outer_loop
	nop
exit_outer_loop:
	li $v0, 10
	syscall
	
		
