.data
	num: .word 3
	message0: .asciiz "\nOriginal value  : "
	message1: .asciiz "\nMultipled by 2  : "
	message2: .asciiz "\nMultipled by 4  : "
	message3: .asciiz "\nMultipled by 8  : "
	message4: .asciiz "\nMultipled by 16 : "
	message5: .asciiz "\nMultipled by 32 : "
	
.text
	lw $t0, num
	#print original value
	li $v0, 4
	la $a0, message0
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	# multiple by 2:
	add $t1, $t0, $t0
	li $v0, 4
	la $a0, message1
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	# multiple by 4:
	add $t1, $t1, $t1
	li $v0, 4
	la $a0, message2
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	# multiple by 8:
	add $t1, $t1, $t1
	li $v0, 4
	la $a0, message3
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	# multiple by 16:
	add $t1, $t1, $t1
	li $v0, 4
	la $a0, message4
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	# multiple by 32:
	add $t1, $t1, $t1
	li $v0, 4
	la $a0, message5
	syscall
	li $v0, 1
	move $a0, $t1
	syscall
	#exit
	li $v0, 10
	syscall
	
	