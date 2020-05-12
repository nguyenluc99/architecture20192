#Laboratory Exercise 7, Home Assignment 2
.text
main: 
	li $a0, 2 #load test input
	li $a1, 6
	li $a2, 9
	jal max #call max procedure
	nop
endmain:
	li $v0, 10
	syscall
#---------------------------------------------------------------------
#Procedure max: find the largest of three integers
#param[in] $a0 integers
#param[in] $a1 integers
#param[in] $a2 integers
#return $v0 the largest value
#---------------------------------------------------------------------
max: 
	add $v1,$a0,$zero #copy (a0) in v0; largest so far
	slt $t0,$a1,$v1 #compute (a1)-(v0)bltz $t0,okay #if (a1)-(v0)<0 then no change
	beq $t0, 1, okay
	nop
	add $v1,$a1,$zero #else (a1) is largest thus far
okay: 
	slt $t0,$a2,$v1 #compute (a2)-(v0)
	bltz $t0,done #if (a2)-(v0)<0 then no change
	nop
	add $v1,$a2,$zero #else (a2) is largest overall
done:
	jr $ra #return to calling program