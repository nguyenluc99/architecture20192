.data 

	
.text
main:
	li $t1, 100
	li $t2, 100
	mult $t1, $t2
	mflo $t0
	
	
	li $v0, 10
	syscall
	
	