.data
	test: .word 2
	a: .word 2
	b: .word 2
	outa: .asciiz "\na = "
	outb: .asciiz "\nb = "
.text
	la $s0, test
	lw $s1, ($s0)
	
	li $t0, 0
	li $t1, 1
	li $t2, 2
	
	lw $s2, a
	lw $s3, b
	
	beq $s1, $t0, case_0
	beq $s1, $t1, case_1
	beq $s1, $t2, case_2
	b default
	case_0:
		addi $s2, $s2, 1
		b end_switch
	case_1:
		subi $s2, $s2, 1
		b end_switch
	case_2:
		add $s3, $s3, $s3
		b end_switch
	default:
		b end_switch
	end_switch:
		la $a0, outa
		li $v0, 4
		syscall
		la $a0, ($s2)
		li $v0, 1
		syscall
		la $a0, outb
		li $v0, 4
		syscall
		la $a0, ($s3)
		li $v0, 1
		syscall
	li $v0, 10
	syscall