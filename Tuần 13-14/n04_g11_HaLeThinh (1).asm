.data
# --- Postscript1: DCE (24) ---
postscript1: .word  150,2500,0, 180,3200,0, 0,3200,1,  130,700,1, 150,700,1, 180,1200,1, 210,700,1, 235,700,1, 0,3200,0, 90,3000,0, 240,700,1, 210,700,1, 180,1300,1, 150,700,1, 120,700,1, 0,3200,0, 90,2000,0, 270,1000,1, 180,1600,1, 90,1000,1, 270,1000,1, 180,1600,1, 90,1000,1, 270,5500,0						
# --- Mark end of PostcriptList 1---
end1: .word  

# --- Postscript2:  YEN (19) --- 																							
postscript2: .word 170,2500,0, 150,1600,1, 30,1600,1, 210,1600,0, 180,1400,1, 90,3000,0, 0,2800,0, 270,1000,1, 180,1400,1, 90,1000,1, 270,1000,1, 180,1400,1, 90,1000,1, 90,1300,0, 0,2800,1, 150,3200,1, 0,2800,1, 270,7000,0, 180,2800,0
# --- Mark end of PostcriptList 2---
end2: .word  

# --- Postscript4: THINH (27) ---
postscript3: .word 170,2500,0, 90,1400,1, 270,700,0, 180,2800,1, 90,1500,0, 0,2800,1, 180,1400,0, 90,1400,1, 0,1400,1, 180,1400,0, 180,1400,1, 90,1300,0, 0,2800,1, 90,1500,0, 180,2800,1, 0,2800,0, 150,3200,1, 0,2800,1, 90,1500,0, 180,2800,0, 0,2800,1, 180,1400,0, 90,1400,1, 0,1400,1, 180,1400,0, 180,1400,1, 270,11000,0
# --- Mark end of PostcriptList 3---
end3: .word  

MessageError: .asciiz "Please press 0,4,8!"

#----------------------------------------------------------------------------
.eqv HEADING 	0xffff8010	# Direction of MarsBot 
				# Integer: An angle between 0 and 359
				# --- 0    : North (up) ---
				# --- 90   : East (right) ---
				# --- 180  : South (down) ---
				# --- 270  : West (left) ---

.eqv MOVING 	0xffff8050 	# Boolean: whether or not to move 
.eqv LEAVETRACK 0xffff8020 	# Boolean (0 or non-0): whether or not to leave a track 
.eqv WHEREX 	0xffff8030 	# Integer: Current x-location of MarsBot 
.eqv WHEREY 	0xffff8040 	# Integer: Current y-location of MarsBot 

.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012 	# Receive row & column of the key pressed, 0 if not key pressed 
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014 	# Read byte at the address 0xFFFF0014, to detect which key button was pressed 

.text
#--------------------------------------------------------
# --- Main procedure ---
#--------------------------------------------------------
main:
	la   $t4, end1
	la   $t5, end2
	la   $t6, end3
	
	li   $t1, IN_ADDRESS_HEXA_KEYBOARD
	li   $t3, 0x80   	# Bit 7 = 1 to enable 
	sb   $t3, 0($t1)
  	
loop:
sleep:
	addi  $v0,$zero,32 
	li    $a0,300 		# Sleep 300 ms 
	syscall
			
	nop  			# WARNING: nop is mandatory here 
	nop
	nop
	nop
	nop
	b  loop			# Wait for interrupt
 		
#-----------------------------------------------------------------
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#-----------------------------------------------------------------
.ktext 0x80000180 

#--------------------------------------------------------
# Processing
#-------------------------------------------------------- 

get_script_1:
	li  $t1, IN_ADDRESS_HEXA_KEYBOARD
	li  $t3, 0x81				# Check row 1 and re-enable bit 7
	sb  $t3, 0($t1)				# Must reassign expected row 
	li  $t1, OUT_ADDRESS_HEXA_KEYBOARD
	lb  $a0, 0($t1)				# Read scan code of key button
	seq $s1, $a0, 0x00000011		# Check button 0
	beq $s1, $zero, get_script_2
	la  $t1, postscript1
	j goTracking
	
get_script_2:
	li  $t1, IN_ADDRESS_HEXA_KEYBOARD
	li  $t3, 0x82				# Check row 2 and re-enable bit 7
	sb  $t3, 0($t1)				# Must reassign expected row
	li  $t1, OUT_ADDRESS_HEXA_KEYBOARD	
	lb  $a0, 0($t1)				# Read scan code of key button
	seq $s1, $a0, 0x00000012		# Check button 4
	beq $s1, $zero, get_script_3
	la  $t1, postscript2
	j goTracking
	
get_script_3:
	li  $t1, IN_ADDRESS_HEXA_KEYBOARD
	li  $t3, 0x84 				# Check row 3 and re-enable bit 7 
	sb  $t3, 0($t1)				# Must reassign expected row 
	li  $t1, OUT_ADDRESS_HEXA_KEYBOARD
	lb  $a0, 0($t1)				# Read scan code of key button
	seq $s1, $a0, 0x00000014		# Check button 8
	beq $s1, $zero, printError
	la  $t1, postscript3
	j goTracking
	
goTracking:
	jal GO

loopTrack:
	lw   $a1, 8($t1)		# Get Track enable
	jal  TRACK
	lw   $a1, 0($t1)		# Get direction for MarsBot
	jal  ROTATE			 
	lw   $a0, 4($t1)		# Get the Running Time
	jal  SLEEP			# Make MarsBot move 
	jal  UNTRACK			# Make untrack after finish tracking 
	addi $t1, $t1, 12		# Move to next element of array 
		
	sne  $s1, $t1, $t4	# Check finish tracking (postscript1)
	beq  $s1, $zero, stopTracking
	sne  $s1, $t1, $t5	# Check finish tracking (postscript2)
	beq  $s1, $zero, stopTracking
	sne  $s1, $t1, $t6	# Check finish tracking (postscript3)
	beq  $s1, $zero, stopTracking
	j    loopTrack	
stopTracking:
	jal STOP
	j next_pc
   	
#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------
GO:
   	li   $at, MOVING 	# Change MOVING port to logic 1 
  	addi $k0, $zero, 1 	 
  	sb   $k0, 0($at) 	# To Start Running 
  	jr   $ra 
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------
STOP: 
	 li $at, MOVING 	# Change MOVING port to 0
	 sb $zero, 0($at) 	# To stop
	 jr $ra
#-----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
#-----------------------------------------------------------
TRACK: 
  	li $at, LEAVETRACK 	# Change LEAVETRACK port 
  	sw $a1, 0($at) 		# To start tracking 
  	jr $ra
#-----------------------------------------------------------
ROTATE: 
  	li $at, HEADING 	# Change HEADING port 
  	sw $a1, 0($at) 		# To rotate robot 
 	jr $ra
#------------------------------------------------------------
# SLEEP procedure, to make MarsBot track
# param[in] none 
#------------------------------------------------------------  
SLEEP:
  	addi $v0, $zero, 32
  	syscall 
  	jr $ra
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#-----------------------------------------------------------
UNTRACK:
 	li $at, LEAVETRACK 	# Change LEAVETRACK port to 0
 	sb $zero, 0($at) 	# To stop drawing tail
 	jr $ra 

#--------------------------------------------------------
# --- Evaluate the return address of main routine ---
# --- epc <= epc + 4 ---
#--------------------------------------------------------
printError:
	li $v0, 55
	la $a0, MessageError
	li $a1, 0
	syscall

next_pc:
	mfc0  $at, $14 			# $at <= Coproc0.$14 = Coproc0.epc
	addi  $at, $at, 4 		# $at = $at + 4 (next instruction)
	mtc0  $at, $14 			# Coproc0.$14 = Coproc0.epc <= $at


return: eret  				# Return from exception

li $v0, 10
syscall