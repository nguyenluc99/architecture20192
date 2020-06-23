.eqv	HEADING		0xffff8010
.eqv	MOVING		0xffff8050
.eqv	LEAVETRACK	0xffff8020
.eqv	WHEREX		0xffff8030
.eqv	WHEREY		0xffff8040
#	to run:
#	$a0, angle -> jump to ROTATE
#	$a0, time -> syscall 32
#	UNTRACK then TRACK
.text
main:
	jal 	GO			# keep going
	nop
	
	
	#	offset
	jal 	UNTRACK			# dont draw
	nop
	addi 	$a0, $zero, 180		#go down
	jal 	ROTATE
	nop
	
	addi 	$v0, $zero, 32
	li	$a0, 4000		#go for 400ms
	syscall
	jal 	UNTRACK
	nop
	jal 	TRACK
	nop
	#	first line
	addi	$a0, $zero, 37		# 37º
	jal 	ROTATE
	nop
	
	addi 	$v0, $zero, 32
	li	$a0, 5000		# draw line length = 5
	syscall
	
	jal 	UNTRACK
	nop
	jal 	TRACK
	nop
	
	#	second line
	addi	$a0, $zero, 143		# 37º
	jal 	ROTATE
	nop
	
	addi 	$v0, $zero, 32
	li	$a0, 5000		# draw line length = 5
	syscall
	
	jal 	UNTRACK
	nop
	#jal 	TRACK
	#nop 
	
	# offset	# go left
	addi	$a0, $zero, 323		# go back
	jal 	ROTATE
	nop
	
	addi	$v0, $zero, 32
	li 	$a0, 2500
	syscall
	
	#jal 	UNTRACK
	#nop
	
	jal 	TRACK
	nop
	# mid line
	addi 	$a0, $zero, 270
	jal 	ROTATE
	nop
	
	addi 	$v0, $zero, 32
	li 	$a0, 3000
	syscall
	jal 	UNTRACK
	nop
	jal 	TRACK
	nop
	
	
	
	
	jal STOP
	nop
	
#goDown:
#	addi	$a0, $zero, 180		#
	li 	$v0, 10
	syscall
		
	
	
	
	
#### _____useful function_____

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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	