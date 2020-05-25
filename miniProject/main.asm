.data
	promptN: .asciiz "Input the  number of elements of array : "
	printNoMax: .asciiz "No value to find maximum!!! "
	printMax: .asciiz "Maximum element is : "
	printInputLeft : .asciiz "Input the "
	printInputRight: .asciiz "-th emelent : "
	promptFirst: .asciiz "\nInput m : "
	promptSecond: .asciiz "Input M : "
	promptRangeInvalid: .asciiz "Range (m, M) is invalid, m  < M"
	promptResult1: .asciiz "Number of element in range("
	promptComma: .asciiz ","
	promptResult2: .asciiz ") is : "
.text 
.globl main
main:
	la $a0, promptN			# load prompt string to get number of elements in array
	jal PromptInt			# run the function in utils.asm to get the number of elements in array
	move $s0, $v0			# save the number of elements in array to $s0
	slt $t0, $zero, $s0		# 0 if $s0 <= 0
	beqz $t0, no_element		# exit with no maximum if no elemment (number of elements in array = 0)
	move $t0, $zero	 		# running index from 0 to n
					## $s1: store maximum value
	move $s2, $sp			# store the last stack frame
	j loop_max
	no_element:
		la $a0, printNoMax	# notify that no max value since there is no element
		jal PrintString		# run the function in utils.asm to  print the notification
		j quit			# end the program

loop_max:
	beq $t0, $s0, exit_loop_max	# exit if reach the (last + 1) element
	addi $t1, $t0, 1		# increase the index to print the order (e.g: if index=3, this is the forth (4th) element)
	nop
	# get i-th element
	la $a0, printInputLeft		# load the left path
	move $a1, $t1			# load the order to the request
	jal PrintInt			# # run the function in utils.asm to print (e.g: print the left path: "input the 3")
	
	la $a0, printInputRight		# load the right path: "-th element"
	jal PromptInt			# print the right path: "-th element" and get the input to $v0 (defined by PromptInt in utils.asm)
	move $t2, $v0			# save temporary the i-th value to $t2
	# store new value $t2 to stack
		addi $s2, $s2, -4	# go below the stack frame ($sp)
		sw $t2, 0($s2)		# store new element to stack
	# end store new value $t2 to stack
	beq $t1, 1, assign_new		# if the first element => no compare
	#now compare
		slt $t3, $s1, $t2 	# 1 if max=$s1 < newValue=$t2
		beqz $t3, next		# dont assign new max if new value is smaller than current max
	assign_new:
		move $s1, $t2		# initialize max = the first element
	next:
	addi $t0, $t0, 1		# increase the running index by 1
	j loop_max			# start the loop to find the maximum value
	
exit_loop_max:
	# print max here
	la $a0, printMax		# load string to $a0 to print
	move $a1, $s1			# load max value to print
	jal PrintInt			# print the max value
	
	# start loop for range (m, M)
	la $a0, promptFirst		# get the first number m
	jal PromptInt			# run the function in utils.asm to get the first number m
	move $s3, $v0			# store m
	
	la $a0, promptSecond		# get the second number M
	jal PromptInt			# run the function in utils.asm to get the second number M
	move $s4, $v0			# store M
	
	move $t4, $s2			# running address from last to $sp
	slt $t3, $s3, $s4 	 	# check valid range : m must < M
	add $s5, $zero, $zero		# count the number of element in range (m, M)
	beq $t3, 1, loop_range		# valid range => jump to loop
	la $a0, promptRangeInvalid	# load notification about range invalid
	jal PrintString			# print invalid range if range is invalid
	j quit				# quit the program
	
loop_range:
	beq $t4, $sp, exit_loop_range	# exit if over the last element
	lw $t5, 0($t4)			# checked element in array
	slt $t3, $s3, $t5		# if s3 < t5: if m < a[i] => 1
	beqz $t3, continue		# next loop if value loaded is not satisfied 
	slt $t3, $t5, $s4		# if t5 < s4: if a[i] < M => 1
	beqz $t3, continue		# next loop if value loaded is not satisfied 
	addi $s5, $s5, 1		# if satisfied, increase the counter
	continue:			# go on with next loop
		add $t4, $t4, 4		# increase the pointer to next word value in array
		j loop_range		# come back to loop
	
exit_loop_range:
	la $a0, promptResult1		# load the first path of the output : "Number of element in range("
	move $a1, $s3			# load m
	jal PrintInt			# print "Number of element in range(m"
	la $a0, promptComma		# load the second path: the comma
	move $a1, $s4			# load M
	jal PrintInt			# print "M,"
	la $a0, promptResult2		# load the last path: the close bracket ") is : "
	move $a1, $s5			# load the result: the counter of number in range (m,M), which is greater than m and less than M
	jal PrintInt			# print the final result ") is : <result>"
	j quit
quit:
	#quit the program
	jal Exit			# Quit the program
.include "utils.asm"
