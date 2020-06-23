#------------------------------------------------------ # col 0x1 col 0x2 col 0x4 col 0x8
#
#row0x1 0 1 2 3
# 0x11 0x21 0x41 0x81 #
#row0x2 4 5 6 7
# 0x12 0x22 0x42 0x82 #
#row0x4 8 9 a b
# 0x14 0x24 0x44 0x84
#
#row0x8 c d e f
# 0x18 0x28 0x48 0x88
#
#------------------------------------------------------
# command row number of hexadecimal keyboard (bit 0 to 3)
# Eg. assign 0x1, to get key button 0,1,2,3
# assign 0x2, to get key button 4,5,6,7
# NOTE must reassign value for this address before reading, # eventhough you only want to scan 1 row
.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
# receive row and column of the key pressed, 0 if not key pressed # Eg. equal 0x11, means that key button 0 pressed.
# Eg. equal 0x28, means that key button D pressed.
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014


.text main:
back_to_polling:
	li $t1, IN_ADRESS_HEXA_KEYBOARD
	li $t2, OUT_ADRESS_HEXA_KEYBOARD
	li $t3, 0x08
pooling:
	sb $t3, 0($t1)
	lb $a0, 0($t2)
print:
	li $v0, 34
	syscall
sleep:
	li $a0, 100
	li $v0, 32
	syscall
back_to_pooling:
	j pooling
# check row 4 with key C, D,
# must reassign expected row
# read scan code of key button # print integer (hexa)
# sleep 100ms
# continue polling