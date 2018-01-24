### Code in C
#int a; int b;
#/* Unterprogramm binom */
#int binom (int a, int b)
#{ 
#    int tempA, tempB; 
#    if (( b == 0 ) || (a == b)){ 
#        return 1; 
#    } 
#    /* rekursion */
#    else
#    { 
#        tempA = binom (a - 1, b);
#        tempB = binom (a - 1, b - 1);
#        return tempA + tempB; 
#    } 
#}
#/* Hauptprogramm main */
#int main (void)
#   {
#   printf("\nBerechnung des Binomialkoeffizienten a über b");
#   do
#   {
#   printf("\nBitte Wert für a eingeben (a ≥ 0) ");   
#   scanf("%d",&a);
#   } while (a < 0);
#   
#   do
#   {
#   printf("\nBitte Wert für b eingeben (b ≥ 0 und b ≤ a) ");   
#   scanf("%d",&b)#;
#   } while (b < 0 || a < b);#
#   
#
#   printf("\nDer Binomialkoeffizient a über b ist >> %d << !\n", binom (a, b));
#   return 0;
#      }
###

# Schreibe eine MIPS-Assembler-Funktion, die den Binomialkoeffizienten
# n über k rekursiv (Siehe Pascalsches Dreiech) für n,k Element
# ganzer zahlen berechnet.
# Lese dazu n und k über die Tastatur ein und berechne den
# Binomialkoeffizienten

.data
	nl:.asciiz "\n"
	
	promptN: .asciiz "\nEnter a number n:\t"
	n: .word 0
	
	promptK: .asciiz "\nEnter a number k:\t"
	k: .word 0
	
	resultM: .asciiz "\nN nCr K equals:\t"
	nnCrk: .word 1

	faultMessage: .asciiz "\nThere was a faulty entry.\nRepeat your entry for n and k according to the rules of the dbinom."
.text
	main:
	# Order n
	li $v0, 4
	la $a0, promptN
	syscall
	# Enter n
	li $v0, 5
	syscall
	sw $v0, n
	
	# Order k
	li $v0, 4
	la $a0, promptK
	syscall
	# Enter k
	li $v0, 5
	syscall
	sw $v0, k
	
#@param:
#	$s0 : n; a
#	$s1 : k; b
	predef:
	lw $s0, n
	lw $s1, k
	
	# First: Check on faults
	ble $s0, 0, faultExit	# n < 0
	blt $s0, $s1, faultExit # n < k 
	blt $s1, 0, faultExit	# k < 0
	
	
#param:
#	$s0 : n
#	$s1 : k
#	$t0 : tempA
#	$t1 : tempB
#	$t3 : tempA + tempB
#	$t4 : sum of (tempA + tempB)
	binomialkoeffizient:
	# If passed, get calculating

	ble $s1, 0, printAndExit
	beq $s0, $s1, printAndExit
	
	## TODO: Calculate pascals triangle
	subi $t0, $s0, 1	# a-1 = a - 1
	subi $s0, $s0, 1	# 'a'-1
	subi $t1, $s1, 1	# b-1 = b - 1
	subi $s1, $s1, 1	# 'b'-1
	
	add $t3, $t2, $t1
	add $t4, $t4, $t3
	
	sw $t4, nnCrk
	
	# Print result
	li $v0, 1
	lw $a0, nnCrk
	syscall
	
	# Print ,
	li $v0, 11
	la $a0, ','
	syscall
		
	j binomialkoeffizient
	
	printAndExit:
	# Exit Message
	li $v0, 4
	la $a0, resultM
	syscall
	# Print binom
	li $v0, 1
	lw $a0, nnCrk
	syscall
	# Terminate
	li $v0, 10
	syscall
	
	faultExit:
	li $v0, 4
	la $a0, faultMessage
	syscall
	j main