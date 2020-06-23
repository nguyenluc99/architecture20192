#---------------------------Final project assembly---------------------------
#----------------------------------Project 4----------------------------------
#Preprocessing the constant of Marsbot and digital lab sim
.eqv	HEADING		0xffff8010 	# Integer: An angle between 0 and 359
					# 0 : North (up)
					# 90: East (right)
					# 180: South (down)
					# 270: West (left)
.eqv	MOVING		0xffff8050	# boolean value: 0 for not moving, 1 for moving
.eqv	LEAVETRACK 	0xffff8020	# boolean value: 0 for not leaving track, 1 for leaving track
.eqv	WHEREX		0xffff8030	# Integer: Current x-location of MarsBot
.eqv	WHEREY		0xffff8040	# Integer: Current y-location of MarsBot
# Key matrix
#------------------------------------------------------
# 	     col 0x1 col 0x2 col 0x4 col 0x8
#
# row 0x1 	0 	1 	2 	3
#	      0x11    0x21    0x41    0x81	0x01
#
# row 0x2 	4      5       6       7	0x02	
# 	      0x12   0x22    0x42    0x82
#
# row 0x4 	8      9       a       b	0x04
# 	      0x14   0x24    0x44    0x84
#	
# row 0x8 	c      d       e       f	0x08
# 	      0x18   0x28    0x48    0x88
#
#------------------------------------------------------
.eqv	OUT_ADRESS_HEXA_KEYBOARD	0xFFFF0014
.eqv	IN_ADRESS_HEXA_KEYBOARD		0xFFFF0012

.data
# Postscript: DCE - using numpad 0
postscript1: .asciiz "90,3000,0;180,5000,0;180,8000,1;80,600,1;70,600,1;60,600,1;50,600,1;40,600,1;30,600,1;20,600,1;10,600,1;0,1700,1;350,600,1;340,600,1;330,600,1;320,600,1;310,600,1;300,600,1;290,600,1;280,600,1;90,10000,0;270,500,1;260,500,1;250,500,1;240,500,1;230,500,1;220,500,1;210,500,1;200,500,1;190,500,1;180,2500,1;170,500,1;160,500,1;150,500,1;140,500,1;130,500,1;120,500,1;110,500,1;100,500,1;90,1000,1;90,3000,0;90,3000,1;270,3000,0;0,4000,1;90,3000,1;270,3000,0;0,4000,1;90,3000,1;"
# Postscript: GIAP - using numpad 4
postscript2: .asciiz "90,3000,0;180,5000,0;90,3000,0;315,500,1;305,500,1;295,500,1;285,500,1;265,500,1;245,500,1;225,500,1;205,500,1;180,2000,1;160,500,1;150,500,1;140,500,1;130,500,1;120,500,1;110,500,1;100,500,1;90,500,1;0,2200,1;270,1000,1;90,1000,0;90,1000,1;180,2200,0;90,2000,0;90,3000,1;270,1500,0;0,5000,1;270,1500,1;90,1500,0;90,1500,1;90,3000,0;200,5400,1;20,5400,0;160,5400,1;340,2700,0;270,1750,1;90,1750,0;340,2700,0;90,3000,0;180,5000,1;0,5000,0;90,2000,1;100,200,1;110,200,1;120,200,1;130,200,1;140,200,1;150,200,1;160,200,1;170,200,1;180,200,1;190,200,1;200,200,1;210,200,1;220,200,1;230,200,1;240,200,1;250,200,1;260,200,1;270,2000,1;"
# Postscript: LINH - using numpad 8
postscript3: .asciiz "90,3000,0;180,5000,0;180,5000,1;90,2000,1;90,2000,0;90,3000,1;270,1500,0;0,5000,1;270,1500,1;90,1500,0;90,1500,1;90,2000,0;180,5000,1;0,5000,0;160,5400,1;0,5000,1;90,2000,0;180,5000,1;0,2500,0;90,2000,1;0,2500,1;180,2500,0;180,2500,1;"

.text
# $t1 for IN_ADRESS_HEXA_KEYBOARD
# $t2 for OUT_ADRESS_HEXA_KEYBOARD
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t2, OUT_ADRESS_HEXA_KEYBOARD
POLLING:
# $t0 for scan each of 3 rows: row 0x01, row 0x02, row 0x04
# $t3 for storing address of postscript
# case 1: Considering the number pad 0
	li $t0, 0x01
	sb $t0, 0($t1)
	lb $a0, 0($t2)
	beq $a0, 0x11, NUMPAD_0 
# case 2: Considering the number pad 4
	NOT_NUMPAD_0:
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
# No in case 0, 4, 8: Return polling
		j POLLING
	NUMPAD_0:
		la $t3, postscript1
		j KICK_OFF
	NUMPAD_4:
		la $t3, postscript2
		j KICK_OFF
	NUMPAD_8:
		la $t3, postscript3
		j KICK_OFF
# Finish read input
KICK_OFF:
	jal GO
# Read data in postscript
#-----------------------------------------------------------
# READ_DATA_FROM_POSTSCRIPT procedure, to read data in postscript
# param[in] string array postscript1, postscript2, postscript3
# param[out] $t4, $t5, $a1 
#-----------------------------------------------------------
READ_DATA_FROM_POSTSCRIPT:
# $t4 for storing angle of rotation
# $t5 for storing moving time
	add $t4, $zero, $zero # to store the angle of rotation
	add $t5, $zero, $zero # to store the value of moving time
	READ_ANGLE_ROTATION:
		# $t6 for storing offset of POSTSCRIPT
		# $t7 for storing address of POSTSCRIPT[offset]
		add $t7, $t3, $t6
		lb $a1, 0($t7)	
		beq $a1, 0, END_AND_PRINT_PRESENT_POSITION		# if read null character then go to END
		nop
		beq $a1, 44, READ_MOVING_TIME #if read ',' then read time
		nop
		subi $a1, $a1, 48	# -48 to read character
		mul $t4, $t4, 10
		add $t4, $t4, $a1
		addi $t6, $t6, 1
		j READ_ANGLE_ROTATION	# read until read the character ','

	READ_MOVING_TIME:
		move $a0, $t4
		jal ROTATE
		addi $t6, $t6, 1
		add $t7, $t3, $t6
		lb $a1, 0($t7)
		beq $a1, 44, READ_TRACK_OR_NOT
		nop
		mul $t5, $t5, 10
		subi $a1, $a1, 48
		add $t5, $t5, $a1
		j READ_MOVING_TIME

	READ_TRACK_OR_NOT:
		addi $v0, $zero, 32	# sleeping the marsbot
		move $a0, $t5	# in time = $t5
		addi $t6, $t6, 1
		add $t7, $t3, $t6
		lb $a1, 0($t7)
		subi $a1, $a1, 48	# -48 to read character
		beq $a1, 0, IS_TRACKED
		nop
		jal UNTRACK
		jal TRACK
		j READ_NEW_DATA
	IS_TRACKED:
		jal UNTRACK
		j READ_NEW_DATA
	READ_NEW_DATA:
		syscall
		addi $t6, $t6, 2	#ignore character ';'
		j READ_DATA_FROM_POSTSCRIPT

#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------
GO:	li $at, MOVING # load the address of MOVING
	addi $k0, $zero,1 # change MOVING port to logic 1,
	sb $k0, 0($at) # to start running
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------
STOP:	li $at, MOVING # load the address of MOVING
	sb $zero, 0($at) # change MOVING port to 0 to stop
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
#-----------------------------------------------------------
TRACK:	li $at, LEAVETRACK # load the address of LEAVETRACK
	addi $k0, $zero,1 # change LEAVETRACK port to logic 1,
	sb $k0, 0($at) # to start tracking
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#-----------------------------------------------------------
UNTRACK:
	li $at, LEAVETRACK # load the address of LEAVETRACK
	sb $zero, 0($at) # change LEAVETRACK port to 0 to stop drawing tail
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: 
	li $at, HEADING # load the address of HEADING port
	sw $a0, 0($at) # to rotate robot
	nop
	jr $ra
	nop
#-----------------------------------------------------------
# END_AND_PRINT_PRESENT_POSITION procedure, to finish and print the present position of Marsbot
# param[in] none
#-----------------------------------------------------------
END_AND_PRINT_PRESENT_POSITION:
	li $at, WHEREX
	lw $a0, 0($at)
	li $v0, 1
	syscall
	li $at, WHEREY
	lw $a0, 0($at)
	li $v0, 1
	syscall
	jal STOP
	li $v0, 10
	syscall
	
		
		
