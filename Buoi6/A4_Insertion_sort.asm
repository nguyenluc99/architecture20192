.data # insertion sort algorithm
	A: .word 1, -2, -3, 4, -5, 6
	Aend: .word 99
.text
	la $a0, A		# first element of A
	la $a1, Aend
	subi $a1, $a1, 4	# last element of A
	or $a2, $a0, $zero	# outer running address
	j outer_loop
	nop
	
outer_loop:
	or $a3, $a0, $zero	# inner running address # $a0 < $a3 < $a2 < $a1
	lw $s0, 0($a2)		# considered value
	inner_loop1:
		lw $s1, 0($a3)
		beq $a3, $a2, exit_inner_loop2
		nop
		slt $s2, $s0, $s1	# ascending order
		#slt $s2, $s1, $s0  	# decending order
		beq $s2, 1, exit_inner_loop1
		nop
		addi $a3, $a3, 4	# increase the inner address
		j inner_loop1
		nop
	exit_inner_loop1:
		sw $s0, 0($a3)		
		
	inner_loop2:
		beq $a2, $a3, exit_inner_loop2		# 
		addi $a3, $a3, 4			# increase the inner running address
		# exchange value
		lw $s2, 0($a3)				# s2 <= a3
		sw $s1, 0($a3)				# a3 <= s1
		or $s1, $zero, $s2			# s1 <= s2
			
		j inner_loop2
		nop	
	exit_inner_loop2:
		#sw $s1, 0($a3)
		beq $a2, $a1, exit_outer_loop		# exit if reach the last element
		nop
		addi $a2, $a2, 4			# if not, increase the outer address 
		j outer_loop 
exit_outer_loop:
	li $v0, 10
	syscall
