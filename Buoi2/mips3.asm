.data 

	
.text
main:
	lui $at, 100
	ori $at, $at, 200
	
	
	
	li $v0, 10
	syscall
	
	