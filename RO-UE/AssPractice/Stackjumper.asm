.data

	arr: .word 5 10	15 20 25
	
	echoMain: .asciiz "Echo from Main.\n"
	echoFirst: .asciiz "\tEcho from First.\n"
	echoSecond: .asciiz "\t\tEcho from Second.\n"
	echoThird: .asciiz "\t\t\tEcho from Third.\n"
	echoFourth: .asciiz "\t\t\t\tEcho from Fourth.\n"
.text

# Expected: Main, Echo 
#	-> Jal First, Echo First 
#		-> Jal Second, Echo Second
#			-> Jal Third, Echo Third
#				-> Jal Fourth, Echo Fourth
#			-> JR Third, Echo Third
#		-> JR Second, Echo Second
#	-> JR First, Echo First
# exit

	main:
	addi $sp, $sp, -4
	sw $ra 0($sp)

				li $v0, 4
				la $a0, echoMain
				syscall
		
	jal first
	addi $sp, $sp, 4
	j exit
	
	first:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
				li $v0, 4
				la $a0, echoFirst
				syscall
	
	jal second
	
				li $v0, 4
				la $a0, echoFirst
				syscall

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	second:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
				li $v0, 4
				la $a0, echoSecond
				syscall
	
	jal third
	
				li $v0, 4
				la $a0, echoSecond
				syscall
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	third:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
				li $v0, 4
				la $a0, echoThird
				syscall
	
	jal fourth
	
				li $v0, 4
				la $a0, echoThird
				syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	fourth:
				li $v0, 4
				la $a0, echoFourth
				syscall
	
	jr $ra
	
	exit:
	li $v0, 10
	syscall
	
	
	

	