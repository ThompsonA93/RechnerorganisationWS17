# Schreibe eine Funktion mit 2 Parametern die den Binomialkoeffizienten berechnet.
# Lese N und K von der Tastatur ein und berechne das Resultat.
### Binomialkoeffizient:
#      n!
# -------------
#  k! * (n-k)!

.data
	request: .asciiz "Gebe zwei Zahlen für n und k ein.\n"
	error_1: .asciiz "Eingegebenes K ist zu groß. Terminiere.\n"
	error_2: .asciiz "Eingegebenes N ist nicht positiv. Terminiere.\n"
.text
#################################################################################
# 	Main-Procedure						
#################################################################################
  main:
  # Print Request
	li $v0, 4
	la $a0, request
	syscall
  # Read and save first Integer	
	li $v0, 5
	syscall
	move $a0, $v0
  # Read and save second Integer
	li $v0, 5
	syscall
	move $a1, $v0
  # Exceptionhandling
    	# Case n != positive
  	blt $a0, $zero, nTooSmall
  	# Case: k > n
  	bgt $a1, $a0, kTooBig
  # Jump to Function & return later
  	jal bin
  # Print Result
  	move $a0, $v0
  	li $v0, 1
  	syscall
  # Terminate
  	j exit
  	
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
  	
#################################################################################
# Procedureframe: Binomialcoefficient
#################################################################################
# $a0 = n; $a1 = k ####### Return in v0
#################################################################################
  bin:	
  # Save Values on Stack
  	addi $sp, $sp, -12
  	sw $ra, 8($sp)	# Store ra
  	sw $a1, 4($sp)	# Store k
  	sw $a0, 0($sp)	# Store n
  	
  # Calculate n! <=> f(n) = $t0
  	lw $a2, 0($sp)		# n
  	jal faculty
  	move $s0, $v0
  # Calculate k! <=> f(k) = $t1
  	lw $a2, 4($sp)		# k
  	jal faculty
  	move $s1, $v0				
  # Calculate (n-k)! <=> f(n-k) = $t2
  	lw $t9, 0($sp)		# n
  	lw $t8, 4($sp)		# k
  	sub $t7, $t9, $t8	# n-k
  	move $a2, $t7
  	jal faculty		# (n-k)!
  	move $s2, $v0
  # Calculate k!*(n-k)!  <=> f(k)*f(n-k) = $t3
	mul $s3, $s1, $s2	# = k! * (n-k)!
	
  # Calculate n! / (k!*(n-k)!) <=> f(n) / f(k)*f(n-k) = $t4
  	div $s4, $s0, $s3	# = n / k!*(n-k)!
  	
  # Store result in Return-Reg $v0, which is $t4
  	move $v0, $s4
  	
  # Reload for jumpback	
  	lw $ra, 8($sp)
  	addi $sp, $sp, 12
  	
  	jr $ra
  
#################################################################################
# Procedureframe
#################################################################################
# $a2 = Value to fac	######## Return in v0
#################################################################################
  faculty:
  setup:
  	addi $sp, $sp, -4
  	sw $ra, 0($sp)
  	
  	li $t0, 0		# Multiplicator
  	li $t1, 1		# Starting Val
  	add $t2, $a2, $zero	# Max count
  	
  calculate:	
  	addi $t0, $t0, 1
  	mul $t1, $t1, $t0	
  	
  	bne $t0, $t2, calculate	# Keep at it until Count = maxcount
  	
  	# Setup for jumpback
  	lw $ra, 0($sp)
  	addi $sp, $sp, 4
  	move $v0, $t1
  	jr $ra
#################################################################################
# Termination
#################################################################################
  exit:
  	li $v0, 10
  	syscall