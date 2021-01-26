# In class example February 12, 2020
	.text
	la	$t0, array
	lw	$t1, size
next:
	lw	$t2, 0($t0)
# Display number
	li	$v0, 4
	la	$a0, msg
	syscall
	li	$v0, 1
	add	$a0, $zero, $t2
	syscall

	#consider the next array element	
	addi	$t0, $t0, 4
	addi	$t1, $t1, -1
# if not do it again for tgis go to next
	bgt	$t1, $zero, next
	li	$v0, 10
	syscall	
		
	.data
array:	.word	10, 20, 30
size:	.word	3
msg:	.asciiz	"\n number:"