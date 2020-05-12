.data # program to reverse a string whose length <= 20
	inputStr: .space 21
	outputStr: .space 21
	message1: .asciiz "\nInput a string"
	message2: .asciiz "\nLength is : "
	message3: .asciiz "\nReverse string is : "
	tmp: .asciiz "-"
	
	
.text
	li $v0, 4
	la $a0, message1
	syscall
	li $v0, 8
	la $a0, inputStr
	li $a1, 21
	syscall
	
	get_length: 
	la $a1, inputStr # a0 = Address(string[0])
	xor $v0, $zero, $zero # v0 = length = 0
	xor $t0, $zero, $zero # t0 = i = 0
	check_char: 
	add $t1, $a1, $t0 # t1 = a0 + t0
	 #= Address(string[0]+i)
	lb $t2, 0($t1) # t2 = string[i]
	beq $t2,$zero,end_of_str # Is null char?
	beq $t2,10,end_of_str # Is newline char?
	addi $v0, $v0, 1 # v0=v0+1->length=length+1
	addi $t0, $t0, 1 # t0=t0+1->i = i + 1
	j check_char
	end_of_str:
	#reverse string
	or $t3, $zero, $t0
	la $a1, outputStr
	or $t4, $zero, $zero
	start_loop:
		subi $t3, $t3, 1
		add $t1, $a0, $t3
		add $t2, $a1, $t4
		lb $t5, 0($t1)
		#beq $t2, $zero, end_loop
		#or $t2, $t5, $zero
		sb $t5, 0($t2)
		#or 
		addi $t4, $t4, 1
		beqz $t3, end_loop
		j start_loop
	end_loop:
	
	li $v0, 4
	la $a0, message2
	syscall
	
	li $v0, 1
	or $a0, $zero, $t0
	syscall
	
	li $v0, 4
	la $a0, message3
	syscall
	
	li $v0, 4
	or $a0, $zero, $a1
	syscall
	
	li $v0, 10
	syscall
	