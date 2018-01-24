.data
# Schreiben Sie ein MIPS-Assembler-Programm, welches von der Tastatur Werte für die
# Seitenlängen eines Dreiecks (a, b, c) einliest. Sie können davon ausgehen, dass nur positive,
# ganzzahlige Werte eingegeben werden und c der größte Wert ist. Das Programm soll
# überprüfen, ob die Dreiecksungleichung gilt (c <= a + b) und eine entsprechende Meldung
# ausgeben: „Dreiecksungleichung GILT“ oder „Dreiecksungleichung gilt NICHT“. Testen Sie Ihr
# Programm mit dem MIPS-Simulator MARS (siehe Moodle) – dies gilt auch für alle folgenden
# Assembler-Aufgaben!
# Hinweis: Die Ein-/Ausgabe in MARS wird über sogenannte Systemaufrufe (System Calls)
# realisiert. Beachten Sie, dass die Werte in bestimmten Registern ($t0-$t9, $a0-$a3, $v0-$v1)
# während der Ausführung von Systemaufrufen überschrieben werden können.
	msg: .asciiz "Enter 3 integer values for a, b and c.\n"
	gültig: .asciiz "Dreiecksungleichung GILT\n"
	ungültig: .asciiz "Dreiecksungleichung gilt NICHT\n"
	
.text

	main:
	la $a0, msg
	li $v0, 4
	syscall
	
	# Read Values #-# s0 = a, s1 = b, s2 = c
	li $v0, 5
	syscall
	add $s0, $v0, $zero
	
	li $v0, 5
	syscall
	add $s1, $v0, $zero
	
	li $v0, 5
	syscall
	add $s2, $v0, $zero
	
	#  Calculate (c <= a + b)
	add $t0, $s0, $s1 	# a + b
	ble $s2, $t0, printUngültig
	
	# Gültig
	li $v0, 4
	la $a0, gültig
	syscall
	j exit
	
	printUngültig:
	li $v0, 4
	la $a0, ungültig
	syscall
	j exit
	
	exit:
	li $v0, 10
	syscall
