.data # real-instruction to illustrate the absolute operand
	num1: .word -1000
	message0: .asciiz "\nOriginal value is:   "
	message1: .asciiz "\nAbsolute value is:   "
	message2: .asciiz "\nNew value is :       "
	message3: .asciiz "\nInversion value is : "
	message4: .asciiz "\nInversion value is : "
.text  
	lw $t0, num1
	
	li $v0, 4
	la $a0, message0
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	slt $s0, $t0, $zero # s0 = 0 <=>  $t0 positive
	beqz $s0, positive
		sub $t0, $zero, $t0
	positive:
	li $v0, 4
	la $a0, message1
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	# move operand: move $t1, $t0 : t1 <= t0
	or $t1, $t0, $zero
	
	li $v0, 4
	la $a0, message0
	syscall
	
	li $v0, 35
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, message2
	syscall
	
	li $v0, 35
	move $a0, $t1
	syscall
	
	# not operand: $t1 = bit invert ($t0)
	li $t2, 0xffffffff
	xor $t1, $t2, $t0
	
	li $v0, 4
	la $a0, message0
	syscall
	
	li $v0, 35
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, message3
	syscall
	
	li $v0, 35
	move $a0, $t1
	syscall
	
	# ble
	li $t0, 1
	li $t1, 2
	slt $at, $t0, $t1
	beq $at, $zero, label
	
	li $v0, 10
	syscall
	
	