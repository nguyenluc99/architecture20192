.data 
	
.text
main:
	li $v0, 5
	syscall
	move $s0, $v0
	li $v0, 10
	syscall
	
	