.data
	###
	# Not Buildable since Values for labels are not allowed
	###
	# Simulates simple for
	#	for(j = 0; j < 10; j++){ b = b + j}
	# 	.. with $s5 = j, $s6 = b
.text
	addi $s5, $s0, 0		# j <- 0+0
	addi $s5, $s0, 10		# $s1 <- 0 + 10 -- Abbruchbed.
	beq $s1, $s0, 3			# $ if(j == 10) goto '24'
	add $s6, $s6, $s5		# b <- b + j
	addi $s5, $s5, 1		# j <- j + 1
	j 2				# goto 8
	
	li $v0, 10			# $v0 = 10 
	syscall				# if $v0 <=> End of Programm
	
		# Beq in 11 issues the following:	# J in 14 issues the following:
# PC		#	11				#	14
#  +4		#+ 		4			#+	2|00
# SE&SLL	#+ 0	   '3' 00			#vvvvvvvvvvvvvvvv
#		#-----------------			#--------------------
# NewPC		#    24 Bit + 00			#	'8'	00
#		# PC = 11+4+(3<<2)			#