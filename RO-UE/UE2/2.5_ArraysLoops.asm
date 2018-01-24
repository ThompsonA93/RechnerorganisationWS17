#Gegeben sei folgendes Datensegment mit einem Array arr ganzzahliger, positiver Werte und
#einer Variablen arrSize, welche die Arraygröße angibt:
#
#Erstellen Sie ein MIPS-Assemblerprogramm, welches für jedes Arrayelement am Bildschirm
#ausgibt, ob es sich um eine Zweierpotenz handelt oder nicht. Testen Sie Ihr Programm mit
#unterschiedlichen Werten und Arraygrößen.

.data
	arr: .word 17 23 64 1 37 68 128 10 16 256
	arrSize: .word 10
	exec: .asciiz "\n########## Executing check on defined arr ##########\n"
	gültig: .asciiz "\t.. ist eine Zweierpotenz.\n"
	ungültig: .asciiz "\t.. ist keine Zweierpotenz.\n"
.text
	main:
	li $v0, 4
	la $a0, exec
	syscall

	lb $a1, arrSize($zero)		# a1 := 10
	mul $a1, $a1, 4			# a1 := a1*4 <=> 40
	j operate
	
	operate:
	# Check if read is valid	# OutOfBoundsRead if used via read = '0'
	beq $a1, $s0, terminate
	
	# Fetch Data
	lw $a0, arr($s0)
	addi $s0, $s0, 4	

	# Check Data
	add $t0, $a0, $zero	# = NUM
	add $t1, $a0, -1	# = NUM-1
	
	and $t2, $t0, $t1	# := num & (num-1)

	# One of each is executed	
	beqz $t2, istZweierPotenz
	bnez $t2, istKeineZweierPotenz

	istZweierPotenz:
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, gültig
	syscall
	j operate
	
	istKeineZweierPotenz:
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, ungültig
	syscall
	j operate
	
	terminate:
	li $v0, 10
	syscall