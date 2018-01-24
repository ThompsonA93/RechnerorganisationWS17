### Implementing recursive Function calls in MIPS
# 1. Base case first
# 2. Allocate stack frame
# 3. Save return adress
# For-each:
#	Save any registers needed after the call
#	Compute arguments
#	reCall function
#	Restore any registers needed after the call
#	consume return value
#	Deallocate stack frame and return

.data
	arg: .word 5
.text
  main:
  	lw $a0, arg($zero)
	jal fib
	j exit
	
  exit:
  	li $v0, 10
  	syscall

##################################################################################

  fib:
	bgt $a0, 1, fib_recursive	# if (n<=1)
	move $v0, $a0						
	jr $ra				
	
  fib_recursive:
	sub $sp, $sp, 12		
	sw $ra, 0($sp)			# save RA
	
	sw $a0, 4($sp)			# save n    ->	#
	addi $a0, $a0, -1		# Calc n-1	#
	jal fib				 		# 
	lw $a0, 4($sp)			# Restore n <-	#
	sw $v0, 8($sp)			# Return-Value of n-1
	addi $a0, $a0, -2
	
	jal fib
	
	lw $s0, 8($sp)			# Dont load into v0
	add $v0, $s0, $v0		# n-1 + n-2 = Return val
	
	lw $ra, 0($sp)			# Reload Jump
	add $sp, $sp, 12		# Restore stack
	
	jr $ra