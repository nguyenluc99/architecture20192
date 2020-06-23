addi $t3, $zero, 4294901776 #right display
addi $t4, $zero, 4294901777 #left display
newGame: 
	li $v0, 42
	li $a1, 255
	syscall
	move $t7, $a0
	addi $t6, $zero, 0
	addi $t5, $zero, 7
loop:
	beq $t6, $t5, restart
	li $v0, 5
	syscall
	beq $v0, $t7, success
	blt $v0, $t7, lober
	j higher
nextTry:
	addi $t6, $t6, 1
	j loop

lober: 
	li $t0, 48 # l
	sb $t0, 0($t4)
	li $t0, 92 # o
	sb $t0, 0($t3)
	j nextTry
higher:
	li $t0, 116 # h
	sb $t0, 0($t4)
	li $t0, 16 # i
	sb $t0, 0($t3)
	j nextTry
success:
	j restart

restart:
	li $t0, 128
	li $t1, 0
	sb $t0, 0($t3)
	sb $t0, 0($t4)
	li $a0, 1000
	li $v0 32
	syscall
	sb $t1, 0($t3)
	sb $t1, 0($t4)
	li $a0, 1000
	li $v0 32
	syscall	
	sb $t0, 0($t3)
	sb $t0, 0($t4)
	li $a0, 1000
	li $v0 32
	syscall
	sb $t1, 0($t3)
	sb $t1, 0($t4)
	li $a0, 1000
	li $v0 32
	syscall	
	j newGame