#Laboratory Exercise 4, Home Assignment 1
.data
	num1: .word 500000000000
	num2: .word 500000000000
.text
start:
	lw $s1, num1
	lw $s2, num2
	li $t0, 0 #No Overflow is default status
	addu $s3, $s1, $s2 # s3 = s1 + s2
	xor $t1, $s1, $s2 #Test if $s1 and $s2 have the same sign
	slt $t2, $t1, $zero # t2 = 0 if t1 negative = diff sign => always true
	beq $t2, 1, EXIT # 
		xor $t3, $s1, $s3 # test if same size = positive
		slt $t4, $t3, $zero # t4 = 1 if t3 positive
		beq $t4, 1, OVERFLOW
		j EXIT
	OVERFLOW:
		li $t0, 1
	EXIT:
	li $v0, 1
	#print 1 if overflow occurs. 0 otherwise
	move $a0, $t0
	syscall
	li $v0, 10 
	syscall
	
	
	