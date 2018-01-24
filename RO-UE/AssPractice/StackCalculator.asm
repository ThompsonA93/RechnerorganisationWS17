# Stacktraining
### Assume n! + n
# Only use the stack.

.data
	request: .asciiz "Enter a value to calculate!\n"
.text
###################### Main body
  main:
  	li $v0, 4
  	la $a0, request
  	syscall
  	li $v0, 5
  	syscall
  	move $t0, $v0
  	
  # Store values in Stack
  	addi $sp, $sp, -4
  	sw $t0, 0($sp)
  	
  	jal calculate
  	
  	lw $a0, 0($sp)
  	addi $sp, $sp, 4
  	jal printValue
  	addi $sp, $sp, 4
  	j exit

  printValue:
  	li $v0, 1
  	syscall
  	jr $ra

  exit: 
  	li $v0, 10
  	syscall
      
################################### Subfunc Frame      
  calculate:	
  setup:
  	lw $a0, 0($sp)	
 	li $t0, 0
 	li $t1, 1
 	add $t2, $a0, $zero
 	
 exec:	
 	# calculate n!
 	addi $t0, $t0, 1
 	mul $t1, $t1, $t0
 	bne $t0, $t2, exec
 	
 	add $t1, $t1, $t2
 	
 	addi $sp, $sp, -4
 	sw $t1, 0($sp)
 	
 	jr $ra		
 	
	