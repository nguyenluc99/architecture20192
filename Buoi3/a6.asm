.data
	size: .word 6
	arrayA: .word 10, -4, -3, -10, -20, -5
	outStr: .asciiz "Number with the largest absolute value is : "
.text
	#la $s0, size
	lw $s0, size
	
	li $t0, 0  # count index
	li $t1, 0  # count byte
	li $s1, 0  # original value
	li $s2, 0  # absotule value
	loop:
		beq $t0, $s0, exit
		lw $t2, arrayA($t1) #t2 store original value
		slt $t3, $t2, $zero # t2 = 10 positive => go add, t3 = 0
		beqz $t3, go_positive
			#block for negative 
			sub $t4, $zero, $t2
			b go_exit
		go_positive :
			add $t4, $zero, $t2
			b go_exit
		go_exit:
			slt $t5, $s2, $t4
			beq $t5, 1, go_exchange
			b go_out
			go_exchange:
				add $s1, $zero, $t2
				add $s2, $zero, $t4
				b go_out
		go_out:
			addi $t0, $t0, 1
			addi $t1, $t1, 4
			b loop
	exit:
		la $a0, outStr
		li $v0, 4
		syscall
		la $a0, ($s1)
		li $v0, 1
		syscall
	
	li $v0, 10
	syscall