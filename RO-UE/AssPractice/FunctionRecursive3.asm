############# Function - Recursive:
# f(x) = 1			.. x <= 1
# f(x) = f(x-1) + f(floor[x/2]) .. else

.data
	nl: .asciiz "\n"
.text
##################### Main Procedure Frame
  main:
  loop:
  	addi $t0, $t0, 1
	add $a0, $t0, $zero 

	jal calc
		
	move $a0, $v0
	li $v0, 1
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	
	bne $t0, 20, loop
	j exit
  
  exit:	
  	li $v0, 10
  	syscall
###################### Recursive Procedure Frame
  calc:
  	addi $sp, $sp, -16
  	sw $ra, 12($sp)
  	sw $a0, 8($sp)	# x, probably redundante
  	sw $s0, 4($sp)	# fn(floor(x/2))
  	sw $s1, 0($sp)	# fn(x-1)

	beq $a0, 1, return1	# Standard care
	
	addi $a0, $a0, -1	# calc x-1
	jal calc
	move $s0, $v0		# Save result fn(x-1) to s0
	
	addi $a0, $a0, 1	# reset to x
	div $a0, $a0, 2 	# calc floor(x/2)

	jal calc
	move $s1, $v0		# Save result fn(floor(x/2)) to s1
	
	add $v0, $s0, $s1	# Add the results
	
  calc_exit:
	lw $ra, 12($sp)
	lw $a0, 8($sp)
	lw $s0, 4($sp)
	lw $s1, 0($sp)
	addi $sp, $sp, 16

	jr $ra	
	
  return1:
   	li $v0, 1
   	j calc_exit
	
	
