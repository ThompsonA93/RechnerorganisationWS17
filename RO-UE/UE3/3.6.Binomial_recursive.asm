	
.data
	request: .asciiz "Gebe zwei Zahlen für n und k ein.\n"
	error_1: .asciiz "Eingegebenes K ist zu groß. Terminere.\n"
	error_2: .asciiz "Eingegebenes N ist nicht positiv. Terminiere.\n"

.text
############################
# Main procedure Frame
############################

main:
  # Print Request
	li $v0, 4
	la $a0, request
	syscall
  # Read and save first integer
	li $v0, 5
	syscall
	move $a0, $v0
  # Read and save second integer
	li $v0, 5
	syscall
	move $a1, $v0
  # Exception Handling
  	# Case n!= Positive
  	blt $a0, $zero, nTooSmall
  	# Case k > n 
  	bgt $a1, $a0, kTooBig
  # Jal Funct
  	jal bin
  
  	move $a0, $v0
  	li $v0, 1
  	syscall

  	j exit
  exit:
  	li $v0, 10
  	syscall

  kTooBig:
  	li $v0, 4
  	la $a0, error_1
  	syscall
  	li $v0, 10
  	syscall

  nTooSmall:
  	li $v0, 4
  	la $a0, error_2
  	syscall 
  	li $v0, 10
  	syscall

####################################
# Binom Procedure Frame
####################################
  bin:
  	addi $sp, $sp, -20
  	sw $ra, 0($sp)	# RA
  	sw $a0, 4($sp)	# n
  	sw $a1, 8($sp)	# k
  	sw $s0, 12($sp)
  	sw $s1, 16($sp)

  	beqz $a1, return1	# k==0
  	beq $a0, $a1, return1	# k==n

  	addi $a0, $a0, -1

  	jal bin
  	move $s0, $v0		# f(n-1, k)

  	addi $a1, $a1, -1
  	jal bin
  	move $s1, $v0		# f(n-1, k-1)

  	add $v0, $s0, $s1

  bin_exit:
  	lw $ra, 0($sp)
  	lw $a0, 4($sp)
  	lw $a1, 8($sp)
  	lw $s0, 12($sp)
  	lw $s1, 16($sp)
  	addi $sp, $sp, 20
  	jr $ra

  return1:
  	li $v0, 1
  	j bin_exit
