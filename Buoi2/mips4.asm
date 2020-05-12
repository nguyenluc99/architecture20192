.data 
	input: .space 81
	inputSize: .word 80
	inputx: .asciiz "Hay nhap vao x : "
	inputy: .asciiz "Hay nhap vao y : "
	output: .asciiz "2x + y = "
	
.text
main:
	li $v0, 4
	la $a0, inputx
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	li $v0, 4
	la $a0, inputy
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0
	
	add $s2, $s0, $s0
	add $s2, $s2, $s1
	
	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 10
	syscall
	
	