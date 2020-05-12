#Laboratory Exercise 5, Home Assignment 3 
.data
	string: .asciiz "tmp string"
	Message1: .asciiz "\nNhap xau: "
	Message2: .asciiz "\nDo dai la "
	Message3: .asciiz "\nXau vua nhap la : "
	inputStr: .space 20
.text
main:
	get_string: # TODO
	li $v0, 4
	la $a0, Message1
	syscall
	
	li $v0, 8
	la $a0, inputStr
	li $a1, 20
	syscall
	
	get_length: 
	la $a0, inputStr # a0 = Address(string[0])
	xor $v0, $zero, $zero # v0 = length = 0
	xor $t0, $zero, $zero # t0 = i = 0
	check_char: 
	add $t1, $a0, $t0 # t1 = a0 + t0
	 #= Address(string[0]+i)
	lb $t2, 0($t1) # t2 = string[i]
	beq $t2,$zero,end_of_str # Is null char?
	beq $t2,10,end_of_str # Is newline char?
	addi $v0, $v0, 1 # v0=v0+1->length=length+1
	addi $t0, $t0, 1 # t0=t0+1->i = i + 1
	j check_char
	end_of_str:
	#end_of_get_length:
	print_length: # TODO
	#print original string
	li $v0, 4
	la $a0, Message3
	syscall
	li $v0, 4
	la $a0, inputStr
	syscall
	#print length
	li $v0, 4
	la $a0, Message2
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall
