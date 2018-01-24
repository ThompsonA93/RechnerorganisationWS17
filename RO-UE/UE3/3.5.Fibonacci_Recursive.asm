# Kalkuliere die Fibonacci-Zahl durch Rekursion
# f(1) = 1
# f(2) = 1
# f(n) = f(n-1) + f(n-2) 
###
# Übernehme main von 3.2 <=> Die berechnet Fakultät. ???
# Take 5
##
# N >= 1
#

.data
	msg1: .asciiz "Give a number: "
	error_msg: .asciiz "Entered value negative or 0. Terminating.\n"
	space: .asciiz " | "	
.text
###################################################################################
#		Main procedure frame
###################################################################################	
  main:
	# Request input
	li $v0,  4
    	la $a0,  msg1
    	syscall             
    	
    	# Fetch and store arguement
    	li $v0,  5
    	syscall
	# Check input
	blt $v0, 1, error_1             
    	#move $a0, $v0
    	#jal fib
    	#move $a0, $v0
    
  setupReg:
    	# Repeat faculty until n values
    	li $a0, 1		# Start with 1
    	li $s4, 1		
    	move $s5, $v0
    	
  loopFibo:
  	jal fib
  	# Print return-val
  	add $a0, $v0, $zero
  	li $v0, 1
  	syscall
  	li $v0, 4
  	la $a0, space
  	syscall
  	# Resolve loop
  	addi $s4, $s4, 1
  	add $a0, $s4, $zero	# 1 .. 2 .. 3 ..
  	bge $s5, $s4, loopFibo
  					
  exit:
    	li $v0, 10
    	syscall
    	
  error_1:	# + Terminate
  	li $v0, 4
  	la $a0, error_msg
  	syscall
  	li $v0, 10
  	syscall  	

###################################################################################
#		Main procedure frame
###################################################################################
  fib:
    	# $a0 = n
    	# if (n == 1) return 1;
    	# if (n == 2) return 1;
    	# return fib(n - 1) + fib(n - 2);
    	
	# 1. Store values into Stack. Necessary rather for recursion-steps
    	addi $sp, $sp, -12 
    	sw   $ra, 0($sp)
    	sw   $s0, 4($sp)
    	sw   $s1, 8($sp)

   	add $s0, $a0, $zero		# s0 = n, saved above

	# 2. Check the base cases		
	li $t3, 1			
	li $t4, 2
    	beq  $s0, $t3, return_1		# if n == 1: return 1
    	beq  $s0, $t4, return_1		# if n == 2: return 1

	# 3. For-each other fkn case
	addi $a0, $s0, -1		# Reduce Arguement: n-1
	
    	jal fib				# Repeat & Store
    	add $s1, $zero, $v0         	# Result of this is f(n-1)
    	
    	addi $a0, $s0, -2		# This ones n-2
    	jal fib                     	# Repeat & Store
					# Result of f(n-1)
    	add $v0, $v0, $s1           	# Add up  s0's via exitFib				
	 							 													 											 								 													 				 													 											 								 													 
  exitfib:
        lw   $ra, 0($sp)        # read registers from stack
        lw   $s0, 4($sp)
        lw   $s1, 8($sp)
        addi $sp, $sp, 12       # bring back stack pointer
        jr $ra

  return_1:
        li $v0, 1	
        j exitfib
