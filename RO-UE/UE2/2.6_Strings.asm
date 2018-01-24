# Erstellen Sie ein MIPS-Assemblerprogramm, das eine Zeichenkette von der Tastatur einliest,
# alle Kleinbuchstaben der Zeichenkette durch die entsprechenden Großbuchstaben ersetzt und
# das Ergebnis am Bildschirm ausgibt. Sie können davon ausgehen, dass die Länge der
# Zeichenkette nicht größer als 100 (Zeichen) ist.
# Beispiel: Eingabe „32 Register!“ Ausgabe „32 REGISTER!“
# Hinweis: Beachten Sie, wie Groß- und Kleinbuchstaben im ASCII Code angeordnet sind.



.data
	myString: .space 101 # Allowed: 100 Characters + \0
	request: .asciiz "Enter some String to work on. Maximum of 100 Characters allowed\n"
	pre: .asciiz "The entered String was:\t"
	post: .asciiz "The processed String is:\t"
	
.text
	main:
	# Request User-Input
	li $v0, 4
	la $a0, request
	syscall
	
	# Fetch User-Input
	li $v0, 8
	la $a0, myString
	addi $a1, $zero, 101	# Max Length + \0
	syscall
	
	# Re-Print user-Input
	li $v0, 4
	la $a0, pre
	syscall
	li $v0, 4
	la $a0, myString
	syscall
	
	jal fetchChar
	j exit
	
	fetchChar:
	lb $a0, myString($s0)	# Load Character
	addi $s0, $s0, 1	# Increase Count on s0
	bgt $a0, 96, incrementChar

	beqz $a0, exit		# Terminate if nothing was read
	j fetchChar

	incrementChar:
	# from 97..122 to 65 ..90
	bgt $a0, 122, fetchChar	# If not letter <=> Ignore and cont fetching
	sub $a0, $a0, 32
	
	subi $s0, $s0, 1	# Decrement pointer back
	sb $a0, myString($s0)
	addi $s0, $s0, 1	# Increment back
	
	j fetchChar

	exit:
	li $v0, 4
	la $a0, post
	syscall
	
	li $v0, 4
	la $a0, myString
	syscall
	
	li $v0, 10
	syscall
