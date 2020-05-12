.data 
	num1: .word 1
	num2: .word 2
	mes1: .asciiz "The sum of "
	mes2: .asciiz " and "
	mes3: .asciiz " is "
.text
	lw $t0, num1
	lw $t1, num2
	add $t2, $t1, $t0
	
	li $v0, 4
	la $a0, mes1 # the sum of
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, mes2 # is 
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, mes3
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 10
	syscall
	