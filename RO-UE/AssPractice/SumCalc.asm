# Practice
# Assume Sum(n) = n + n-1 + n-2 ... 0
# Assume Sum(m) = 0 + 1 + ... + m
# Print Sum(n) + Sum(m) for each line
# m and n must be positive: Traphandling
### No Tricks. Implement as above

.data
	request: .asciiz "Enter 2 values for M and N.\n"
	error_n: .asciiz "Error for input N. Terminating."
	error_m: .asciiz "Error for input M. Terminating."
.text

#################################### Main Procedureframe
  main:
	li $v0, 4
	la $a0, request
	syscall
	li $v0, 5
	syscall
	move $a0, $v0,
	li $v0, 5
	syscall
	move $a1, $v0
 # Exceptionhandling
 	blt $a0, 0, failExit_1
 	blt $a1, 0, failExit_2
   
 	jal loopMandN
  	j terminate
  	
  	failExit_1:
  	li $v0, 4
  	la $a0, error_n
  	syscall
  	li $v0, 10
  	syscall
  	
  	failExit_2:
  	li $v0, 4
  	la $a0, error_m
  	syscall
  	li $v0, 10
  	syscall
  	
  	terminate:
  	li $v0, 10
  	syscall
  	
################################### Sub Procedureframe ####################################
# $a0 = n, $a1 = m # Return 0+m, 1+ m-1; ...
###########################################################################################
 calculate:
 setupReg:
  	li $t0, 0	# N-start
  	move $t1, $a1	# M-Start
  	
  	addi $sp, $sp, -12
  	sw $ra, 0($sp)
 
 loopMandN:
 	add $t2, $t0, $t1	# 0 + m, 1 + m-1 ...
 	addi $t0, $t0, 1	# n+1
 	subi $t1, $t1, 1	# m-1
 	
 	move $a0, $t2		# Setup for print: $a0 via $v0 = 1
 	jal printValue
 	
 	lw $a1, 8($sp)		# Reload old M
 	lw $a0, 4($sp)		# Reload old N
 	beqz $t1, contN			# Case-Setups: m = 0
 	beq $t0, $a0, contM		# Case-Setup: n = reached
 	
 	lw $ra, 0($sp)
 	addi $sp, $sp, 12
 	jr $ra
 	 	
 printValue:
 	li $v0, 1
 	syscall
 	jr $ra
 		
 	