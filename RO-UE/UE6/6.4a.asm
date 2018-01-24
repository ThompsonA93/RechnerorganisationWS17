.data

.text
 main:
 	li $t0, 70
 	li $t1, 50
 	jal max
 	
 	move $a0, $v0
 	li $v0, 1
 	syscall
 	
 	li $v0, 10
 	syscall
 
 max:	
 	slt $t3, $t0, $t1
	add $v0, $zero, $t0
	beq $zero, $t3, end
	add $v0, $zero, $t1	
 end:	jr $ra
 	