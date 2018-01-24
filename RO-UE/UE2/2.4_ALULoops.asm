# Schreiben Sie ein MIPS-Assemblerprogramm, das von der Tastatur eine ganze,
# vorzeichenbehaftete Zahl (32-Bit Integer, wird intern als Zweierkomplement dargestellt) einliest
# und als Ergebnis dessen Hexadezimaldarstellung am Bildschirm ausgibt (ohne Zuhilfenahme
# des in MARS vorhandenen Systemaufrufs Nr. 34).

.data
	hexaNumbers: .byte '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
	request: .asciiz "Enter a value to put into hexadecimal:\t"
	holdMe: .space 255 
	
.text
	main:
	# Request Integerinput
	li $v0, 4
	la $a0, request
	syscall
	li $v0, 5
	syscall
	
	# Put Var into $a0
	add $a0, $v0, $zero
	
#	# Save value & RA on stack
#	addi $sp, $sp, -8
#	sw $ra, 4($sp)
#	sw $a0, 0($sp)
	
	# JAL to process Integer
	jal process

	# Terminate
	j exit
	
	process:
	# Save value & Jumpback to main
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $a0, 0($sp)
	
	# Put value to t0
	add $t0, $a0, $zero
	
	# Div by 16 to determine hexa-char
	div $t0, $t0, 16		
	mfhi $t1			# Whole val to t1
	mflo $t2			# Rest to t2
	
	# Load hexa-Character determined by value in t1 (max. 15 = F)
	lb $t3, hexaNumbers($t1)
	
	# Store that byte into the hexa-Array	
	sb $t3, holdMe($t4)
	# Increment pointer on holdMe
	addi $t4, $t4, 1
	# Old rest = new Val
	add $a0, $t2, $zero		
		
	# If there is still rest, process it
	bnez $a0, process		
	
	# Here, we have processed the Data - Reset temp for consistent jal printArray
	add $t0, $t0, $zero
	add $t1, $t1, $zero
	add $t2, $t2, $zero
	add $t3, $t3, $zero
	add $t4, $t4, $zero
	jal printArray
		
	lw $a0, 0($sp)	# Redundant
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra				# Else jump back
	
	printArray:
	# Increment Pointer on holdMe
	addi $t4, $t4, -1
	# Fetch Char
	lb $a0, holdMe($t4)
	# Print Char in a0	
	li $v0, 11
	syscall
	# Unless char = 0, continue reading
	bnez $a0, printArray
	# Return to process
	jr $ra
	
	exit:
	li $v0, 10
	syscall
