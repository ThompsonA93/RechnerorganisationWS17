
.data
	nl: .asciiz "\n"
.text

main:	jal fn
	move $a0, $v0
	li $v0, 1
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	
	move $a0, $v1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall


fn:
	xor $s0, $zero, $zero
	addi $t0, $a0, 600
 outer:	addi $t1, $a1, 200
 inner:	addi $s0, $s0, 1
 	addi $t1, $t1, -1
 	
 	addi $v0, $v0, 1
 	
 	bne $t1, $a1, inner
 	addi $t0, $t0, -2
 	
 	addi $v1, $v1, 1
 	
 	bne $t0, $a0, outer
	jr $ra 	