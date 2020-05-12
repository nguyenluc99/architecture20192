.data 
	output1: .asciiz "\nValid input  "
	output2: .asciiz "\nInvalid input  "
	
.text
.globl main

main:
	ori $v0, $zero, 4 # = li $vo, 4
	la $a0, output1
	syscall
	
	ori $t0, $zero, 0x41 # $ 0x41 = 0100 0001(2)  = t0 
	addi $a0, $t0, 0x20 # $a0 = 0100 0001 + 0010 0000 = 0110 0001 = 97
 	ori $v0, $zero, 11 # $v0 = 11 => print character in $a0 = 97 => print 'a'
	syscall
	
	ori $v0, $zero, 4 #print string
	la $a0, output2 #print output2
	syscall
	
	ori $t0, $zero, 0x61
	addi $a0, $t0, 0x20
	ori $v0, $zero, 11 # print character in 0x81 => a square
	syscall
	
	ori  $v0, $zero, 4 # = li $vo, 4
	la $a0, output1 # print output1
	syscall
	
	ori $t0, $zero, 0x41
	ori $a0, $t0, 0x20
	ori $v0, $zero, 11 # print 'a'
	syscall
	
	ori $v0, $zero, 4
	la $a0, output1
	syscall
	
	ori $t0, $zero, 0x61
	ori $a0, $t0, 0x20 # ori 0x61 = 0110 0001,
	#			 0x20 = 0010 0000 
	#		       => ori = 0110 0001 = 97 = 0x61 = 'a'
	ori $v0, $zero, 11
	syscall
	
	ori $v0, $zero, 4
	la $a0, output1
	syscall
	
	ori $v0,  $zero, 10
	syscall
	
	
