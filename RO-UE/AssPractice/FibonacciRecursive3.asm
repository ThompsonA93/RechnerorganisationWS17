#Schreiben Sie eine MIPS-Assembler-Funktion, die die n-te Fibonacci Zahl F(n) 
#durch Rekursion berechnet. 
#Die Fibonacci Zahlen sind wie folgt definiert 
#F(0) = 1
#F(1) = 1
#F(n) = F(n-1) + F(n-2), n>1
#
#Rufen Sie die Funktion in einem MIPS-Hauptprogramm auf, das den Wert von n über die Tastatur
#einliest und die resultierende Fibonacci Zahl F(n) am Bildschirm ausgibt. Stellen Sie sicher, dass die
#MIPS-Konventionen für Prozeduraufrufe eingehalten werden

.data
	nl: .asciiz "\n"
	komma: .asciiz ","
	promptn: .asciiz "\nGib n ein:\t"
	resMes: .asciiz "\nDie n-te Fibonacci Zahl lautet:\t"
	
	fn: .word 1
	fnm1: .word 1
	fnm2: .word 0
	
.text
#@param of main:
#	$s1 as holder of n
#	$s2 as pre-defined counter for recursive function
	main:
	# Print prompt
	la $a0, promptn
	li $v0, 4
	syscall
	# Take n
	li $v0, 5
	syscall
	move $s1, $v0
	# Pre-Def Counter
	add $s2, $s2, 2
	
#@param of FiboFunc
#	$s1 as holder of n
#	$s2 as counter
#	$t2 as fn-2 -- Not sure if redundant; Kept for safety.
#	$t1 as fn-1
#	$t0 as fn
#	$t3 as temporary holder of result.
	fiboFunc:
	# Base cases: $s1 = 0
	beq $s1, 0, printAndExit
	
	# Base case: $s1 = 1
	beq $s1, 1, printAndExit
	
	# Every other case: $s1 > 1
	# Important: We start with $s2 = 2 as we already checked for
	#	$s2 = 0 and $s1 = 1 via first beq's
	# For Comparisons: http://primzahlen.zeta24.com/de/fibonaccizahlen_liste.php
	
	# Load from RAM
	lw $t0, fn
	lw $t1, fn
	lw $t2, fnm1
	
	# Add to form new fn
	add $t3, $t1, $t2
	
#v * Print number ..
		li $v0, 1
		la $a0, ($t3)
		syscall
	
	# Store the new fn-2, fn-1 and fn values
	sw $t0, fnm1
	sw $t1, fnm2 
	sw $t3, fn
	
	# Exit-Check
	add $s2, $s2, 1
	beq $s1, $s2, printAndExit
	
#^ .. and a komma to display numbers
		li $v0, 4
		la $a0, komma
		syscall
	j fiboFunc
		
	
#@params of printAndExit
#	$v0 and $a0 as values/messages to print
	printAndExit:
	# Print message
	li $v0, 4
	la $a0, resMes
	syscall
	# Print number
	li $v0, 1
	lw $a0, fn # IMPORTANT: LW : Load 4 Bit starting at 'res'
	syscall
	# Terminate
	li $v0, 10
	syscall
