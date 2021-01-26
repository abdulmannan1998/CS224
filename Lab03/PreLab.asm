#Lab03, Mannan Abdul, Part 2 & 3
	.text
	li $v0, 4
	la $a0, msg
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	move $a0, $t0
	move $a1, $t1
	
	addi $v0, $zero, 0
	jal recursiveMultiplication
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, msg3
	syscall
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	li $v0, 4
	la $a0, msg4
	syscall
	
	li $v0, 5
	syscall
	
	move $a0, $v0
	addi $a1, $zero, 0
	
	addi $v0, $zero, 0
	jal recursiveSummation
	
	move $t1, $v0
	
	li $v0, 4
	la $a0, msg5
	syscall
	
	li $v0, 1
	add $a0, $zero, $t1
	syscall
	
	li $v0, 10
	syscall
		
recursiveMultiplication:
	add $v0, $v0, $a0
	blt $a1, 2, done
	addi $a1, $a1, -1
	j recursiveMultiplication
done:
	jr $ra

recursiveSummation:
	bgt $a1, $a0, done
	add $v0, $v0, $a1
	addi $a1, $a1, 1
	j recursiveSummation







	.data
msg: .asciiz "\nEnter a positive integer: "
msg2:.asciiz "\nEnter a positive integer you want to multiply the first integer with: "
msg3:.asciiz "\nThe product of the 2 integers is: "
msg4:.asciiz "\n\nEnter a positive integer n: "
msg5:.asciiz "\nThe sum of integers from 1 to n is: "