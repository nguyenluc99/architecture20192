.data
	#i: .word 0
	size: .word 5
	step: .word 1
	arrayA: .word 1, 2, 3, 4, 99
	sumIs: .asciiz "Sum is : "
	
.text
	#lw $s0, i
	lw $s1, size
	lw $s2, step
	
	li $s0, 0  # store sum
	li $t0, 0  # count index
	li $t1, 0  # count byte
	loop:
	
		beq $t0, $s1, exit
		lw $t2, arrayA($t1)
		add $s0, $s0, $t2
		addi $t0, $t0, 1
		addi $t1, $t1, 4
		b loop
	exit:
		la $a0, sumIs
		li $v0, 4
		syscall
		la $a0, ($s0)
		li $v0, 1
		syscall
	li $v0, 10
	syscall
		
