.data 
	result1: .asciiz "\nShift left logical 4 by 2 bits is "
	result2: .asciiz "\nShift right logical 16 by 2 bits is "
	result3: .asciiz "\nShift right arthimetic 34 by 2 bits is "
	result4: .asciiz "\nShift right arthimetic -34 by 2 bits is "
	result5: .asciiz "\nShift right 0xfffffe1 by 2 bits is "
	result6: .asciiz "\nShift left 0xffffffe1 by 2 bits is "
.text
.globl  main
main:
	addi $t0, $zero, 4	 # $t0 = 0000 0100
	sll $s0, $t0, 2		 # $s0 = 0001 0000
	addi $v0, $zero, 4
	la $a0, result1
	syscall
	addi $v0, $zero, 1
	move $a0, $s0
	syscall
	
	addi $t0, $zero, 16	 # $t0 = 0001 0000
	srl $s0, $t0, 2		 # $s0 = 0000 0100
	addi $v0, $zero, 4
	la $a0, result2
	syscall
	addi $v0, $zero, 1
	move $a0, $s0
	syscall
	
	addi $t0, $zero, 34  	# $t0 = 0010 0010
	sra $s0, $t0, 2		# $s0 =   00 1000 = 8
	addi $v0, $zero, 4	
	la $a0, result3
	syscall
	addi $v0, $zero, 1
	move $a0, $s0
	syscall
	
	addi $t0, $zero, -34	# $t0 =  1101 1110
	sra $s0, $t0, 2		# $s0 =  1111 0111 =  -9
	addi $v0, $zero, 4
	la $a0, result4
	syscall
	addi $v0, $zero, 1
	move $a0, $s0
	syscall
	
	addi $t0, $zero, 0xffffffe1	# $t0 = 1111 1111 1111 1111 1111 1111 1110 0001
	ror $s0, $t0, 2 		# $s0 = 0111 1111 1111 1111 1111 1111 1111 1000 = 0x7ffffff8
	li $v0, 4 
	la $a0, result5
	syscall
	li $v0, 34
	move $a0, $s0
	syscall
	
	ori $t0, $zero, 0xffffffe1	# $t0 = 1111 1111 1111 1111 1111 1111 1110 0001
	rol $s0, $t0, 2			# $s0 = 1111 1111 1111 1111 1111 1111 1000 0111 = 0xffffff87
	li $v0, 4
	la $a0, result6
	syscall
	li $v0, 34
	move $a0, $s0
	syscall
	
	
	addi $v0, $zero, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	addi $v0, $zero, 10
	
	
	
	