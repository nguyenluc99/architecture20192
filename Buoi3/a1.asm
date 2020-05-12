.data
	i: .word 5
	j: .word 4
	x: .word 1
	y: .word 2
	z: .word 3
	gr: .asciiz "i is greater than j\n"
	le: .asciiz "i is less than or equal to j\n"
.text
	lw $t0, i # t0 = 5
	lw $t1, j # t1 = 4
	lw $t2, x
	lw $t3, y
	lw $t4, z
	slt $s0, $t1, $t0 # s0 = 1
	#beqz $s0, greater # false => run greater
	beq $s0, 1, greater #false => run greater
	#true block 
		la $a0, le
		li $v0, 4
		syscall
		add $t2, $t2, 1
		add $t4, $zero, 1
		#sw $t4, 1
		b end_if
	#false block
	greater: 
		la $a0, gr
		li $v0, 4
		syscall
		sub $t3, $t3, 1
		add $t4, $t4, $t4
	end_if:
	li $v0, 10
	syscall
