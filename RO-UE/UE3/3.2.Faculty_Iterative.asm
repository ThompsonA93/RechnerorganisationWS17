# Implementiere die Funktion f(n) = n! als nicht-rekursive Assembler-Funktion.
# Berechne die Werte von 0 .. 10 und gebe sie am Bildschirm ausgibt
.data
	request: .asciiz "Enter a Value for n.\n"
	nl: .asciiz "\n"
.text	
#######################################################################################
############### Setup for Programm ####################################################
  main:	
  	# Request n
  	li $v0, 4
  	la $a0, request
  	syscall
 	
 	# Fetch & Save n
 	li $v0, 5
 	syscall
 	move $a0, $v0 	
  	
	beqz $a0, caseZero
	
	jal faculty		# Jump to Function
	j exit			# Terminate Program
	
 # Case 0!	
 caseZero:
	li $v0, 1
	la $a0, 1
	syscall
	j exit
############### End of Setting up for Program #########################################
#######################################################################################
############### Start of Funct ########################################################
  faculty:
  setupRegister:
  	li $t0, 1		# Starting-Val
  	li $t1, 1		# Multiplicator, never set 0
  	add $t2, $a0, $zero	# Max iteration = n	
  	
  	addi $sp, $sp, -4
  	sw $ra, 0($sp)
  	
  calculate:
  # Do faculty
  	mul $t0, $t0, $t1	# Mult: 1*1 = 1 *2 = 2 *3 = 6 *4 =24 ...
  	addi $t1, $t1, 1	# Increase multiplicator
  # Print current value
  	add $a0, $zero, $t0	# Setup for Print
  	jal printVal		#   and Print
  # While ...
  	ble $t1, $t2, calculate	# while Mult != n
  # otherwise Return		
  	lw $ra, 0($sp)	
  	addi $sp, $sp, 4
  	jr $ra	 
  	 
  printVal:
  	li $v0, 1
  	syscall
  	li $v0, 4
  	la $a0, nl
  	syscall
  	jr $ra
########################## End of Faculty ####################################
##############################################################################

	exit: 				# Just terminate
	li $v0, 10
	syscall
