#Ü 2.B.2 MIPS - Rekursive Funktion:
#Schreiben Sie eine MIPS-Assembler-Funktion, die die MIPS-Assembler-Funktion aus 
#Aufgabe 2.A.4 verwendet, um folgende rekursive ganzzahlige Funktion zu berechnen.
#
#f(x) = 1 .. wenn x < 1
#f(x) = f(x-1) + g(x, floor(x/2)) .. sonstig
#
#Testen Sie Ihre Implementierung mit einem MIPS-Programm, 
#das den Funktionsparameter x von der Tastatur einliest und 
#das Ergebnis am Bildschirm anzeigt.

.data
	nl: .asciiz "\n"
	komma: .asciiz ","
	
	promptX: .asciiz "\nEnter a number for x:\t"
	x: .word 0
	
	resultingMessage: .asciiz "\nThe result is:\t"
	fx: .word 1
	
	gx: .word 1
	fxm1: .word 1
	
.text
	main:
	# Order X
	li $v0, 4
	la $a0, promptX
	syscall
	
	# Enter X
	li $v0, 5
	syscall
	sw $v0, x
	
	predefineVar:
	# As not to store/load them repeatedly
	lw $s0, x	# as x
	div $s1, $s0, 2	# as floor(x/2)
	
#@param of function:
#	$s0 as x
#	$s1 as floor(x/2)
	function:
	# Base Case: x < 1
	ble $s0, 1, printAndExit
	# Else:
	# f(x) = f(x-1) + sum x-i; i=i to floor(x/2)
	# f(0) = f(-1) + .. = 1
	# f(1) = 1
	# f(2) = f(1) + 2-1 = 2
	# f(3) = f(2) + 3-1 = 4
	# f(4) = f(3) + 4-1 + 4-2 = 4 + 3 + 2 = 7
	# f(5) = f(4) + 5-1 + 5-2 = 7 + 4 + 3 = 14
	# f(6) = f(5) + 6-1 + 6-2 + 6-3 = 14 + 5 + 4 + 3 = 19 + 7 = 25
	
#@Param of calculategx:
#	$t0 as i
#	$t1 as x-i
#	$t2 as sum(x-i)
	calculategx:
	addi $t0, $t0, 1	# i++
	sub $t1, $s0, $t0	# x-i
	add $t2, $t2, $t1	# sum = sum + x-i
	
	sw $t2, gx		# Store sum == g(x,y)
######### TODO: We need to recall fxm1 somehow
	beq $t0, $s1, calculatefx
	j calculategx

#@param of calculatefx
#	$t0 as fxm1
#	$t1 as gx
#	$t2 as fx
	calculatefx:
	lw $t0, fxm1
	lw $t1, gx
	# f(x) = f(x-m1 + g(x,y)
	add $t2, $t0, $t1
	sw $t2, fx
	j printAndExit
	
	printAndExit:
	# Print resulting Message
	li $v0, 4
	la $a0, resultingMessage
	syscall
	# Print result
	li $v0, 1
	lw $a0, fx	# Subject to change into fx
	syscall
	# Terminate
	li $v0, 10
	syscall