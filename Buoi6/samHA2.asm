.data
	A: .word -1, 2, -3, 4, -5, 6, -7, 8
	Aend: .word 1
	
.text
	#load data:
	la $a0, A
	la $a1, Aend
	j init
	nop
init: 	#init data
	subi $a1, $a1, 4	# get the address of the last element
	or $a2, $zero, $a0	# running address
	or $a3, $zero, $a0	# address of the max element
loop:
	beq $a0, $a1, exit_loop	# exit if there is one element left
	nop
	
	or $a2, $zero, $a0
	or $a3, $zero, $a0
	j loop2
	nop
	loop2:
		lw $s0, 0($a2)
		lw $s1, 0($a3)
		
		# descending order
		#slt $t3, $s1, $s0	# = => $t3 = 0 => not exchange
		# ascending order
		slt $t3,  $s0, $s1
		beq $t3, 1, continue
		
		nop
			# new max:
			or $a3, $zero, $a2
		continue:
		beq $a2, $a1, exit_loop2
		nop
		addi $a2, $a2, 4
		j loop2
		nop
	exit_loop2:
	# exchange a3 and a1
	lw $s2, 0($a1)
	lw $s3, 0($a3)
	sw $s3, 0($a1)
	sw $s2, 0($a3)

	subi $a1, $a1, 4	# one last element finished
	j loop
	nop
	
exit_loop:
	
	li $v0, 10
	syscall
	
