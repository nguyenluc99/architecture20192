.data 
	num: .word 100
	prompt: .asciiz "Nhap vao  1 so: "
	output: .asciiz "Ban vua nhap vao : "
.text
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	sw $t0, num
	
	li $v0, 4
	la $a0, output
	syscall

	li $v0, 1
	la $t0, num
	la $a0, ($t0)
	syscall
		
	li $v0, 10
	syscall
	
	