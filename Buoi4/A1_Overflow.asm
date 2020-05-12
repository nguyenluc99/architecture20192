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
	bltz $t1, EXIT #If not, exit
	
	slt $t2, $s3, $s1
	bltz $s1, NEGATIVE #Test if $s1 and $s2 is negative?
	beq $t2, $zero, EXIT #s1 and $s2 are positive
	 # if $s3 > $s1 then the result is not overflow
	j OVERFLOW
	NEGATIVE:
	bne $t2,$zero,EXIT #s1 and $s2 are negative
	 # if $s3 < $s1 then the result is not overflow
	OVERFLOW:
		li $t0, 1
	EXIT:
	li $v0, 1
	#print 1 if overflow occurs. 0 otherwise
	move $a0, $t0
	syscall
	li $v0, 10 
	syscall
