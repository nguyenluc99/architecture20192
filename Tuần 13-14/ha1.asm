.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014
.eqv SEVENSEG_LEFT 0xFFFF0011
.eqv SEVENSEG_RIGHT 0xFFFF0010

.text
main:
	li $a0, 0x8
	jal SHOW_LEFT
	nop
	li $a0, 0x1F
	jal SHOW_RIGHT
	nop
exit:
	li $v0, 10
	syscall
endmain:

SHOW_LEFT:
	li $t0, SEVENSEG_LEFT
	sb $a0, 0($t0)
	nop
	jr $ra
	nop
	
SHOW_RIGHT:
	li $t0, SEVENSEG_RIGHT
	sb $a0, 0($t0)
	nop
	jr $ra
	nop
	
	
	