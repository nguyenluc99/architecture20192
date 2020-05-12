.data
	prompt: .asciiz "\nplease enter an integer : "
	result: .asciiz "\nyou entered : "
	
.text
main:
	la $a0, prompt
	jal PrintString
	li $v0, 5
	syscall
	move $s0, $v0
	# print the value back to the user
	jal PrintNewLine
	la $a0, result
	move $a1, $s0
	jal PrintInt
	jal Exit
	
.data
	__PNL__newline: .asciiz "\n"
.text
PrintNewLine:
	li $v0, 4
	la $a0, __PNL__newline
	syscall
	jr $ra
	
.text
PrintInt:
	li $v0, 4
	syscall
	move $a0, $a1
	li $v0, 1
	syscall
	jr $ra

.text
PrintString:
	addi $v0, $zero, 4
	syscall
	jr $ra
	
.text
Exit: 
	li $v0, 10
	syscall