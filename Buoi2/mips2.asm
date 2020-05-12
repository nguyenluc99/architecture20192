.data 
	
.text
main:
	li $v0, 6
	syscall
	move $s0, $v0
	li $v0, 10
	syscall
	
	