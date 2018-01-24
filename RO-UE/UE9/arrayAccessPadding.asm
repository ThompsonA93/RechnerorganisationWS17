.data

arrA: .space 8192
arrB: .space 8224
arrX: .space 8192

.text
.globl main

main:	
	la      $t0, arrA		
	la      $t1, arrB
	addi	$t2, $zero, 2048	
	addi    $t3, $zero, 0		# i = 0

for1:	beq     $t2, $t3, end1		# while i != 2048

	sw	$t3, 0($t0)		# store arrA[i]
	sub     $t4, $t2, $t3		
	sw      $t4, 0($t1)		# store arrB[i]
	
	addi	$t0, $t0, 4		
	addi    $t1, $t1, 4
	addi    $t3, $t3, 1
	j	for1

end1:	

	addi    $s0, $zero, 0		# s = 0

	la	$t0, arrA
	addi	$t0, $t0, 8188
	la	$t1, arrB
	addi	$t1, $t1, 8188
	la	$t2, arrX
	addi	$t2, $t2, 8188
	addi	$t3, $zero, 2047	# i = N-1

for2:	slt	$t4, $t3, $zero		
	bne     $t4, $zero, end2	# while i >= 0

	lw	$t4, 0($t0)		# load arrA[i]
	add	$s0, $s0, $t4		# s = s + arrA[i]
	lw      $t4, 0($t1)		# load arrB[i]
	sub     $s0, $s0, $t4		# s = s - arrB[i]
	sw      $s0, 0($t2)		# store s to arrX[i]

	addi	$t0, $t0, -4
	addi	$t1, $t1, -4
	addi    $t2, $t2, -4
	addi    $t3, $t3, -1
	j       for2
	
end2:
	
	addi    $v0, $zero, 10
	syscall

