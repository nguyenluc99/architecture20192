.data # find the maximum-sum prefix in the given list
	A: .word -2 -6 -1 3 -2
	
.text
	la $a0, A
	li $a1, 5
	j init
	nop
init:
	or $t0, $zero, $zero # index at max-sum ... e.g.:0, 1, 2, 3
	lw $t1, 0($a0) # recent max-sum prefix 
	or $t2, $zero, $zero # running index ... e.g.:0, 1, 2, 3
	lw $t3, 0($a0) # running sum
	j loop
	nop
loop:
	addi $t2, $t2, 1 	# increase the running index
	beq $t2, $a1, exitLoop	# exit if running index is 5
	sll $t4, $t2, 2 	# find position of next value
	add $t5, $a0, $t4	# store current address
	lw $t6, 0($t5) 		# store current value
	add $t3, $t3, $t6	# calculate the running sum
	slt $s1, $t1, $t3	# check if max sum < running sum, => 1 if true
	beqz $s1, continue
	nop			# if not, assign new max-sum
	or $t0, $zero, $t2	# assign new max-sum index
	or $t1, $zero, $t3	# assign new max-sum
continue:
	j loop
	nop	
exitLoop:
	li $v0, 10
	syscall

