.data
	prompt: .asciiz "\nplease enter an integer : "
	result: .asciiz "\nyou entered : "
	
.text
main:
	la $a0, prompt
	jal PromptInt
	#li $v0, 5
	#syscall
	move $s0, $v0
	# print the value back to the user
	jal PrintNewLine
	la $a0, result
	move $a1, $s0
	jal PrintInt
	jal Exit
	
	
.include "../utils1.asm"

.include "../utils.asm"
