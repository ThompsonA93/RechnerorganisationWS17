# Calculate Faculty f(n) recursive
#
# f(0) = 1
# f(n) = n*f(n-1) für n > 0
#
###
# Take 3

.data
	request: .asciiz "N:"
.text
####################################################
# Main Procedure Frame
####################################################
# Request stuff
####################################################
  main:
  	# Request N
  	li $v0, 4
  	la $a0, request
  	syscall
  	# Fetch & Save n
  	li $v0, 5
  	syscall
  	
  	move $a0, $v0	# Save to arg-reg
  	jal faculty
  	move $a0, $v0	# Save from return-reg
  	
  	# Print result
  	li $v0, 1
  	syscall
  exit:
  	li $v0, 10
  	syscall
  	
####################################################
# Faculty Procedure Frame
####################################################
# f(0) = 1 else f(n) = n*f(n-1)
####################################################
  faculty:
  # Save registers after each call
  	addi $sp, $sp, -8
  	sw $s0, 4($sp)		# Saves $s0 of previous call, which is necessary for Mult below
  	sw $ra, 0($sp)		# Saves main-RA aswell as else-RA
  if:		
  	li $v0, 1
  	beqz $a0, faculty_exit
  else:
  	move $s0, $a0		# Set current n to $16
  	sub $a0, $a0, 1		# Reduce n => n-1
  	jal faculty		# Faculty with n-1	       <-
  				#				^	################ Why it works ################
  	mul $v0, $s0, $v0	# Calculate n*(n-1)		^	Due to Jumpbacks, calculates the right values.
  				#				^	v0 = 1 * 1 = 1
  faculty_exit:			#				^		Fetch s0 = 2 from Stack
  	lw $ra, 0($sp)		#	 			^			v0 = 1*2 = 2
  	lw $s0, 4($sp)		#				^			Fetch s0 = 3 from Stack
  	addu $sp, $sp, 8	#				^				v0 = 2*3 = 6
  				#			   	^					and so fourth.
  	jr $ra			# Jumps back to jal faculty 	^	##############################################