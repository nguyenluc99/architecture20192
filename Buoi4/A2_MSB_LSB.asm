.data
	num1: .word 0x12345678
	MSB: .asciiz "\nExtract MSB : "
	LSB: .asciiz "\nClear LSB : "
	SetLSB: .asciiz "\nSet LSB of $s0 to 1: "
	ClearS0: .asciiz "\nClear $s0 : "
	
	
.text
	lw $s0, num1
	li $t0, 0xff000000
	and $s1, $s0, $t0
	srl $s1, $s1, 24
	# extract MSB
	li $v0, 34
	move $a0,  $s0
	syscall
	li $v0, 4
	la $a0, MSB
	syscall
	li $v0, 34
	move $a0,  $s1
	syscall
	# Clear LSB
	li $t1, 0xffffff00
	and $s2, $s0, $t1
	li $v0, 4
	la $a0, LSB
	syscall
	li $v0, 34
	move $a0,  $s2
	syscall
	# Set LSB to 1
	li $t2, 0x000000ff
	or $s3, $s0, $t2
	li $v0, 4
	la $a0, SetLSB
	syscall
	li $v0, 34
	move $a0,  $s3
	syscall
	# Clear $s0
	li $t3, 0x00000000
	and $s0, $s0, $t3
	li $v0, 4
	la $a0, ClearS0
	syscall
	li $v0, 34
	move $a0,  $s0
	syscall
	
