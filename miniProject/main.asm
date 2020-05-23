.data
	n: .word
	promptN: .asciiz "Input the  number of elements of array : "
	printNoMax: .asciiz "No value to find maximum!!! "
	printMax: .asciiz "Maximum element is : "
	printInput : .asciiz "Input the "
	printElement: .asciiz "-th emelent : "
	promptFirst: .asciiz "\nInput m : "
	promptSecond: .asciiz "Input M : "
	promptRangeInvalid: .asciiz "Range (m, M) is invalid, m  < M"
	promptResult1: .asciiz "Number of element in range("
	promptComma: .asciiz ","
	promptResult2: .asciiz ") is : "
.text 
.globl main
main:
	la $a0, promptN
	jal PromptInt
	move $s0, $v0			# original value
	slt $t0, $zero, $s0		# 0 if $s0 <= 0
	beqz $t0, no_element		# exit with no maximum if no elemment
	move $t0, $zero	 		# running index from 0 to n
					## $s1: store maximum value
	move $s2, $sp			# last stack frame
	j loop_max
	no_element:
		la $a0, printNoMax
		jal PrintString
		j quit

loop_max:
	beq $t0, $s0, exit_loop_max
	addi $t1, $t0, 1
	nop
	la $a0, printInput
	move $a1, $t1
	jal PrintInt			# use a0 = string, a1 = int to print
	
	la $a0, printElement
	jal PromptInt
	move $t2, $v0
	# store new value $t2 to stack
		addi $s2, $s2, -4
		sw $t2, 0($s2)
	# end store new value $t2 to stack
	beq $t1, 1, next		# if the first element => no compare
	#now compare
		slt $t3, $s1, $t2 	# 1 if max=$s1 < newValue=$t2
		beqz $t3, next		# dont assign new max if new value is smaller than current max
		move $s1, $t2		# assign new max
	next:
	addi $t0, $t0, 1		# running index run from 0 to n
	j loop_max
	
exit_loop_max:
	# print max here
	la $a0, printMax
	move $a1, $s1
	jal PrintInt
	
	# start loop for range (m, M)
	la $a0, promptFirst
	jal PromptInt
	move $s3, $v0			# store m
	
	la $a0, promptSecond
	jal PromptInt
	move $s4, $v0			# store M
	
	move $t4, $s2			# running address from last to $sp
	slt $t3, $s3, $s4 	 	# check valid range
	add $s5, $zero, $zero		# count the number of element in range (m, M)
	beq $t3, 1, loop_range		# valid range => jump to loop
	la $a0, promptRangeInvalid
	jal PrintString
	j quit
	
loop_range:
	beq $t4, $sp, exit_loop_range
	lw $t5, 0($t4)			# checked element in array
	slt $t3, $s3, $t5		# if s3 < t5: if m < a[i] => 1
	beqz $t3, continue
	slt $t3, $t5, $s4		# if t5 < s4: if a[i] < M => 1
	beqz $t3, continue
	addi $s5, $s5, 1
	continue:
		add $t4, $t4, 4
		j loop_range
	
exit_loop_range:
	la $a0, promptResult1
	move $a1, $s3
	jal PrintInt
	la $a0, promptComma
	move $a1, $s4
	jal PrintInt
	la $a0, promptResult2
	move $a1, $s5
	jal PrintInt

quit:
	#quit the program
	jal Exit
.include "../utils.asm"
