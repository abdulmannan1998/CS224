# February 14, 2020 Program in Class
# Define an array with four elements (1, 2, 3, 4) 
# and find the summation of array elements without a loop.
# Clumsy program.
	li	$t0, 0		# $t2: total
	la	$t1, array
	
	lw	$t2, 0($t1) # Load 1st entry to $t2
	add	$t0, $t0, $t2
	
	lw	$t2, 4($t1) # Load 2nd entry to $t2
	add	$t0, $t0, $t2
	
	lw	$t2, 8($t1) # Load 3th entry to $t2
	add	$t0, $t0, $t2
	
	lw	$t2, 12($t1) # Load 4th entry to $t2
	add	$t0, $t0, $t2
	
#==========================================================
#Another way of achieving the same.
	li	$t0, 0		# $t2: total
	la	$t1, array
	
	lw	$t2, 0($t1) # Load 1st entry to $t2
	add	$t0, $t0, $t2
		
	addi	$t1, $t1, 4	# Increment the pointer value/
	lw	$t2, 0($t1) # Load 2nd entry to $t2
	add	$t0, $t0, $t2
	
	addi	$t1, $t1, 4
	lw	$t2, 0($t1) # Load 3th entry to $t2
	add	$t0, $t0, $t2
	
	addi	$t1, $t1, 4
	lw	$t2, 0($t1) # Load 4th entry to $t2
	add	$t0, $t0, $t2
	
# Stop execution.	
	li	$v0, 10
	syscall
	
	.data
array:	.word 	1, 2, 3
	