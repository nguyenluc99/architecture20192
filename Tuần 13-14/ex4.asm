# Mars bot
.eqv 	HEADING 	0xffff8010 
.eqv 	MOVING 		0xffff8050
.eqv 	LEAVETRACK 	0xffff8020  
.eqv 	WHEREX 		0xffff8030  
.eqv 	WHEREY 		0xffff8040  
# Key matrix   
.eqv 	OUT_ADDRESS_HEXA_KEYBOARD 	0xFFFF0014  
.eqv 	IN_ADDRESS_HEXA_KEYBOARD 	0xFFFF0012 
 

.data 

# DCE:
pscript1: 	.word 135, 2000, 0, 180, 5800, 1, 90, 500, 1, 80, 500, 1, 70, 500, 1, 60, 500, 1, 50, 500, 1, 40, 500, 1, 30, 500, 1, 20, 500, 1, 10, 500, 1, 0, 500, 1, 350, 500, 1, 340, 500, 1, 330, 500, 1, 320, 500, 1, 310, 500, 1, 300, 500, 1, 290, 500, 1, 280,  500, 1, 270,  500, 1, 90, 7000, 0,  270, 500, 1, 260, 500, 1, 250, 500, 1, 240, 500, 1, 230, 500, 1, 220, 500, 1, 210, 500, 1, 200, 500, 1, 190, 500, 1, 180, 500, 1, 170, 500, 1, 160, 500, 1, 150, 500, 1, 140, 500, 1, 130, 500, 1, 120, 500, 1, 110, 500, 1, 100, 500, 1, 90,  500, 1, 90, 5000, 0, 270, 2900, 1, 0, 2900, 1, 90, 2900, 1, 270, 2900, 0, 0, 2900, 1, 90, 2900, 1, 270, 12000, 0, 180, 6000, 0
end2:		.word
# "ICT"
pscript2: 	.word 135, 2000, 0, 90, 1000, 1, 270, 500, 0, 180, 5800, 1, 270, 500, 0, 90, 1000, 1, 0, 5800, 0, 90, 4000, 0, 270, 500, 1, 260, 500, 1, 250, 500, 1, 240, 500, 1, 230, 500, 1, 220, 500, 1, 210, 500, 1, 200, 500, 1, 190, 500, 1, 180, 500, 1, 170, 500, 1, 160, 500, 1, 150, 500, 1, 140, 500, 1, 130, 500, 1, 120, 500, 1, 110, 500, 1, 100, 500, 1, 90,  500, 1, 90, 4000, 0, 0, 5800, 1, 270, 2000, 0, 90, 4000, 1, 270, 10414, 0, 180, 5800, 0
end1:		.word 
# LUC
pscript3: 	.word 135, 2000, 0, 180, 6000, 1, 90, 3200, 1, 0, 6000, 0, 90, 1500, 0, 180, 4700, 1, 170, 300, 1, 160, 300, 1, 150, 300, 1, 140, 300, 1, 130, 300, 1, 120, 300, 1, 110, 300, 1, 100, 300, 1, 90, 300, 1, 80, 300, 1, 70, 300, 1, 60, 300, 1, 50, 300, 1, 40, 300, 1, 30, 300, 1, 20, 300, 1, 10, 300, 1, 0, 4700, 1, 90, 4000, 0, 270, 500, 1, 260, 500, 1, 250, 500, 1, 240, 500, 1, 230, 500, 1, 220, 500, 1, 210, 500, 1, 200, 500, 1, 190, 500, 1, 180, 500, 1, 170, 500, 1, 160, 500, 1, 150, 500, 1, 140, 500, 1, 130, 500, 1, 120, 500, 1, 110, 500, 1, 100, 500, 1, 90,  500, 1, 270, 10551, 0, 180, 500, 0
end3:		.word
.text
main:	
	#	load the ends of three pscripts
	la	$s1, end1
	la	$s2, end2
	la	$s3, end3
	li 	$t1, IN_ADDRESS_HEXA_KEYBOARD
	li 	$t2, OUT_ADDRESS_HEXA_KEYBOARD
	
polling:  
# case 1: Check if the button is 0
	li 	$t0, 0x01
	sb 	$t0, 0($t1)
	lb 	$a0, 0($t2)
	beq 	$a0, 0x11, NUMPAD_0
# case 2: Check if the button is 4
	#NOT_NUMPAD_0:
	li 	$t0, 0x02
	sb 	$t0, 0($t1)
	lb 	$a0, 0($t2)
	beq 	$a0, 0x12, NUMPAD_4
# case 3: Check if the button is 8
	#NOT_NUMPAD_4: 
	li 	$t0, 0x04
	sb 	$t0, 0($t1)
	lb 	$a0, 0($t2)
	beq 	$a0, 0x14, NUMPAD_8
# casd 4: Check if the button is C to quit: 
	li 	$t0, 0x08
	sb 	$t0, 0($t1)
	lb 	$a0, 0($t2)
	beq 	$a0, 0x18, NUMPAD_C
# Not in case 0, 4, 8: Return polling
		j 	polling 
	NUMPAD_0:
		la 	$t3, pscript1	# load pscript1 if click 0
		j 	PRINT  
	NUMPAD_4:
		la 	$t3, pscript2	# load pscript2 if click 4
		j 	PRINT
	NUMPAD_8:
		la 	$t3, pscript3	# load pscript3 if click 8
		j 	PRINT
	NUMPAD_C:
		li 	$v0, 10		# cancel the program
		syscall
PRINT:	
	li 	$a0, 300
	li 	$v0, 32
	syscall
	nop
	
	jal 	GO
	nop
	
READING:
	jal	UNTRACK 
	nop
	jal	TRACK
	nop  
	lw	$a0, 8($t3)		# get track value 
	li 	$at, LEAVETRACK		# assign track
	sb 	$a0, 0($at) 
	# 
	lw	$a0, 0($t3)		# get angle to rotate
	jal	ROTATE			# rotate
	nop 
	lw	$a0, 4($t3) 		# get time to draw
	jal 	DRAW_LINE		# draw line
	nop
	addi	$t3, $t3, 12		# increase to next line
	# quit if reach the last element
	beq	$t3, $s1, STOP_TRACKING
	nop
	beq	$t3, $s2, STOP_TRACKING
	nop
	beq	$t3, $s3, STOP_TRACKING
	nop
	beq	$t3, $s4, STOP_TRACKING
	nop
	
	j 	READING			# continue reading line
	
DRAW_LINE:
  	addi 	$v0, $zero, 32
  	syscall 			# draw line for the time in $a0
  	jr 	$ra

STOP_TRACKING:
	j 	END_READING
 
UNTRACK_LINE:
	jal 	UNTRACK


END_READING:
	li 	$t0, 0x21
	sb 	$t0, 0($t2)
	jal 	STOP			# 
	j 	polling			# comeback to perform new request

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
	
