.data
	i: .word -5
	j: .word 8
	x: .word 1
	y: .word 2
	z: .word 3
	m: .word 1
	n: .word 2
	true: .asciiz "True\n"
	false: .asciiz "False\n"
.text # if : i >= j
	lw $t0, i # t0 = 1
	lw $t1, j # t1 = 5
	lw $t2, x
	lw $t3, y
	lw $t4, z
	lw $t6, m
	lw $t7, n
	add $s0, $t0, $t1
	add $s1, $t6, $t7
	slt $s2, $s1, $s0 # s0 = 0
	beq $s2, 0, go_false #false => run go_false
	#true block 
		la $a0, true
		li $v0, 4
		syscall
		add $t2, $t2, 1
		add $t4, $zero, 1
		#sw $t4, 1
		b end_if
	#false block
	go_false: 
		la $a0, false
		li $v0, 4
		syscall
		sub $t3, $t3, 1
		add $t4, $t4, $t4
	end_if:
	li $v0, 10
	syscall
