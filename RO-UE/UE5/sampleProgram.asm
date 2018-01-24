.data
.text
	addi $t5, $t5, 42
	addi $t0, $a0, 516
  loop:	addi $t0, $t0, -4
  	lw $t1, 0($t0)
  	add $t2, $t1, $t5
  	sw $t2, 0($t0)
  	bne $t0, $a0, loop
  	
  	li $v0, 10
  	syscall