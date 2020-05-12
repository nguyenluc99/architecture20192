
.globl main
main:
	jal BadSubProgram
	la $a0, string3
	jal PrintString
	
	jal Exit
	
BadSubProgram:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $a0, string1
	jal PrintString
	li $v0, 4
	la $a0, string2
	syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

.data
string1: .asciiz "\nIn subprogtam BadSubProgram\n"
string2: .asciiz "After call to PrintString\n"
string3: .asciiz "After call to subprogram\n"

.include "../utils.asm"
