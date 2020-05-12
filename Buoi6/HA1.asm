.data
	A: .word -2, -6, -1, -3, -2
	message: .asciiz "\nnewline\n"
.text
main:
	 la $a3, A
	 li $a1, 5
	 
	 j mspfx
	 nop	
continue:

end_of_main:
	move $a0, $v0
	li $v0, 1 
	syscall
	li $v0, 4
	la $a0, message
	syscall
	move $a0, $v1
	li $v0, 1
	syscall
	li $v0, 10
	syscall
mspfx: 
	lw $v1, 0($a3) # initial sum = A[0]
	ori $v0, $zero, 1 #initialize length in $v0 to 0 
	#or $v1, $zero, $zero #initialize max sum in $v1 to 0
	ori $t0, $zero, 1 #initialize index i in $t0 to 0
	or $t1, $zero, $v1 #initialize running sum in $t1 to 0
loop: 
	add $t2, $t0, $t0 #put 2i in $t2
	add $t2, $t2, $t2 #put 4i in $t2
	add $t3, $t2, $a3 #put 4i+A (address of A[i]) in $t3

	lw $t4, 0($t3) #load A[i] from mem(t3) into $t4
	add $t1, $t1, $t4 #add A[i] to running sum in $t1
	slt $t5, $v1, $t1 #set $t5 to 1 if max sum < new sum
	bne $t5, $zero, mdfy #if max sum is less, modify results
	j test #done?
mdfy: 
	li $a2, 1
	add $v0, $t0, $a2 #new max-sum prefix has length i+1
	add $v1, $t1, $zero  #new max sum is the running sum
test: 
	add $t0, $t0, $a2 #advance the index i
	slt $t5, $t0, $a1 #set $t5 to 1 if i<n
	bne $t5, $zero, loop #repeat if i<n
done: 
	j continue
mspfx_end:
	j end_of_main