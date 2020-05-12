.data
	output1: .asciiz "\nAfter first xor : "
	output2: .asciiz "\nAfter second xor: "
.text
.globl main
main:
	ori $s0, $zero, 0x01234567 # $s0 = 	    1 0010 0011 0100 0101 0110 0111
	la $a0, output1
	li $v0, 4
	syscall
	xori $s0, $s0, 0xffffffff # 0xffffffff = 1111 1111 1111 1111 1111 1111 1111 1111 => 
	#					 0000 0001 0010 0011 0100 0101 0110 0111
	# 					=1111 1110 1101 1100 1011 1010 1001 1000 = 0xfedcba98
	move $a0, $s0 # 
	li $v0, 34 # print heaxa
	syscall
	
	la $a0, output2
	li $v0,  4
	syscall
	xori $s0, $s0, 0xffffffff # 0xffffffff = 1111 1111 1111 1111 1111 1111 1111 1111 => 
	# 				s0 =     1111 1110 1101 1100 1011 1010 1001 1000 
	# 				s0 =     0000 0001 0010 0011 0100 0101 0110 0111
	move $a0, $s0
	li $v0, 34
	syscall
	
	ori $v0, $zero, 10
	syscall
	
	  