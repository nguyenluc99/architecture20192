# Mars bot
.eqv HEADING 0xffff8010 
.eqv MOVING 0xffff8050
.eqv LEAVETRACK 0xffff8020 
.eqv WHEREX 0xffff8030 
.eqv WHEREY 0xffff8040  
# Key matrix   
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014 
.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012 
 

.data 
str1: .asciiz "string Comeback \n" 
str2: .asciiz "string print \n"
str3: .asciiz "Stop tracking\n"
pscript1: .word 90,2000,0, 180,3000,0, 180,5790,1, 80,500,1, 70,500,1, 60,500,1, 50,500,1, 40,500,1, 30,500,1, 20,500,1, 10,500,1, 0,500,1, 350,500,1, 340,500,1, 330,500,1, 320,500,1, 310,500,1, 300,500,1, 290,500,1, 280,490,1, 90,2000,0, 270,500,1, 260,500,1, 250,500,1, 240,500,1, 230,500,1, 220,500,1, 210,500,1, 200,500,1, 190,500,1, 180,500,1, 170,500,1, 160,500,1, 150,500,1, 140,500,1, 130,500,1, 120,500,1, 110,500,1, 100,500,1, 90,1000,1, 90,5000,0, 270,2000,1, 0,5800,1, 90,2000,1, 180,2900,0, 270,2000,1, 90,3000,0
end1:	.word 
pscript2: .word 90,2000,0, 180,3000,0, 180,5790,1, 80,500,1, 70,500,1, 60,500,1, 50,500,1, 40,500,1, 30,500,1, 20,500,1, 10,500,1, 0,500,1, 350,500,1, 340,500,1, 330,500,1, 320,500,1, 310,500,1, 300,500,1, 290,500,1, 280,490,1, 90,7000,0, 200,6020,1, 90,4160,0, 340,6020,1, 200,3000,0, 90,2000,1, 90,5000,0, 180,2900,0, 0,5500,1, 270,2500,0, 90,5000,1, 90,1000,0
# ps6:  "U"
#pscript6: .word 180, 2000, 1, 170, 100, 1, 160, 100, 1, 150, 100, 1, 140, 100, 1, 130, 100, 1, 120, 100, 1, 110, 100, 1, 100, 100, 1, 90, 100, 1, 80, 100, 1, 70, 100, 1, 60, 100, 1, 50, 100, 1, 40, 100, 1, 30, 100, 1, 20, 100, 1, 10, 100, 1, 0, 2000, 1,
end2:	.word
pscript3: .word 90,2000,0, 180,3000,0, 180,5790,1, 80,500,1, 70,500,1, 60,500,1, 50,500,1, 40,500,1, 30,500,1, 20,500,1, 10,500,1, 0,500,1, 350,500,1, 340,500,1, 330,500,1, 320,500,1, 310,500,1, 300,500,1, 290,500,1, 280,490,1, 90,2000,0, 270,500,1, 260,500,1, 250,500,1, 240,500,1, 230,500,1, 220,500,1, 210,500,1, 200,500,1, 190,500,1, 180,500,1, 170,500,1, 160,500,1, 150,500,1, 140,500,1, 130,500,1, 120,500,1, 110,500,1, 100,500,1, 90,1000,1, 90,5000,0, 270,2000,1, 0,5800,1, 90,2000,1, 180,2900,0, 270,2000,1, 90,3000,0
#pscript5: .word 90, 500, 0, 150, 500, 1
end3:	.word
pscript4: .word	90, 1000, 1, 180, 100, 0
end4:	.word
.text
main:
    #li $s0, IN_ADRESS_HEXA_KEYBOARD  
    #li $s1, OUT_ADRESS_HEXA_KEYBOARD 
    la	$s1, end1
    la	$s2, end2 
    la	$s3, end3
    la	$s4, end4
    #la $a2, pscript2    
    #j PRINT 
	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t2, OUT_ADDRESS_HEXA_KEYBOARD 
	
polling:  
# case 1:
	li $t0, 0x01
	sb $t0, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x11, NUMPAD_0
# case 2: Considering the number pad 4
	#NOT_NUMPAD_0:
	li $t0, 0x02
	sb $t0, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x12, NUMPAD_4
# case 3: Considering the number pad 8
	#NOT_NUMPAD_4:
	li $t0, 0x04
	sb $t0, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x14, NUMPAD_8
# casd 4: consider "C" to quit:  
	li $t0, 0x08
	sb $t0, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x18, NUMPAD_C
# No in case 0, 4, 8: Return polling
		j polling 
	NUMPAD_0:
		la $t3, pscript1
		j PRINT 
	NUMPAD_4:
		la $t3, pscript2
		j PRINT
	NUMPAD_8:
		la $t3, pscript3
		j PRINT
	NUMPAD_C:
		li $v0, 10
		syscall
PRINT:	
	li $v0, 34
	syscall
	la $a0, str2
	li $v0, 4
	syscall
	li $a0, 300
	li $v0, 32
	syscall
	
    jal GO
    nop
    
#   register memories:
# a0: value of number user clicked
# a1: address of postscript
# t0: 
#
	#add	$a2, $a1, $zero		# 
reading:
	jal	UNTRACK 
	nop
	jal	TRACK
	nop  
	lw	$a0, 8($t3)		# get track value 
	li 	$at, LEAVETRACK		# assign track
	sb 	$a0, 0($at) 
	# 
	lw	$a0, 0($t3)
	jal	ROTATE
	nop 
	lw	$a0, 4($t3) 
	jal 	DRAW_LINE
	nop
	addi	$t3, $t3, 12
	beq	$t3, $s1, stop_tracking
	nop
	beq	$t3, $s2, stop_tracking
	nop
	beq	$t3, $s3, stop_tracking
	nop
	beq	$t3, $s4, stop_tracking
	nop
	#slt 	$t0, $a2, $s4 
	#beqz	$a2,  stop_tracking
	#nop
	j 	reading
	
DRAW_LINE:
  	addi $v0, $zero, 32
  	syscall 
  	jr $ra

stop_tracking:
	li $v0, 4
	la $a0, str3
	syscall
	j END_READING
    	#j next_pc

 
UNTRACK_LINE:
    jal 	UNTRACK


END_READING:
	li $t0, 0x21
	sb 	$t0, 0($t2)
	jal STOP
	j polling


# -----    utils   -----
UNTRACK:
	li 	$at, LEAVETRACK
	sb 	$zero, 0($at)
	nop
	jr 	$ra
	nop
	
TRACK:
	li 	$at, LEAVETRACK
	addi 	$k0, $zero, 1
	sb 	$k0, 0($at)
	nop 
	jr 	$ra
	nop
	
STOP:
	li 	$at, MOVING
	sb 	$zero, 0($at)
	nop
	jr 	$ra
	nop

ROTATE:
	li 	$at, HEADING
	sw 	$a0, 0($at)
	nop
	jr 	$ra
	nop
	
GO:
	li 	$at, MOVING
	addi	$k0, $zero, 1
	sb	$k0, 0($at)
	nop
	jr 	$ra
	nop
# -----    utils   -----

