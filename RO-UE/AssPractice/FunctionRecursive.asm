#	if(n<=2)
#	  return 1
#	}else{
#	  int comp = (-3) * f(n-2) + 7*f(n-3) +15;
#	return comp;
#	}
###
# "What does it return."

.data

	enterInt: .asciiz "Enter an Integer: "
	results: .asciiz "\nThe solution is: "
	nl: .asciiz "\n"

.text

  main:
	# Request in
	la $a0, enterInt
	li $v0, 4
	syscall	
	# Fetch input
	li $v0, 5
	syscall
	move $a0, $v0

	# Adjust sp to store ra
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Jal f(n)
	jal function1

	# Adjust sp to load ra	
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	# Save function1 return val
	move $s0, $v0

	# Print res-Text	
	la $a0, results
	li $v0, 4
	syscall

	# move return val into reg
	move $a0, $s0
	# .. and print
	li $v0, 1
	syscall

	la $a0, nl
	li $v0, 4
	syscall

	li $v0, 10
	syscall

function1:
	addi $sp, $sp, -12	# Store stuff you know that will be overwritten
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $s1, 8($sp)

	slti $t0, $a0, 3
	beq $t0, $zero, else
	j return

else:
	addi $a0, $a0, -2	# n-2
	jal function1		# Dont worry about the rest

	addi $t1, $zero, -3	
	mult $t1, $v0
	mflo $s1		# Result to s1
	
	addi $a0, $a0, -1
	jal function1		

	addi $t2, $zero, 7
	mult $t2, $v0
	mflo $t3		

	add $t4, $s1, $t3	
	addi $v0, $t4, 15

return:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $s1, 8($sp)	
	addi $sp, $sp, 12
	
	jr $ra
	
	
