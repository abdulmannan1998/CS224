#Mannan Abdul Lab02 Part01
	.text
	
	jal initializeArray
	
	move $a0, $v0
	move $a1, $v1
	jal bubbleSort
	
	move $a0, $v0
	move $a1, $v1
	jal processArray
	
	li $v0, 10
	syscall
	
initializeArray:
	
	la $a0, msg
	li $v0, 4
	syscall	
	
	li $v0, 5
	syscall
	
	move $s1, $v0
	add $s6, $zero, $s1
	
	mul $s0, $s1, 4
	
	add $a0, $zero, $s0
	li $v0, 9
	syscall
	
	move $s2, $v0
	add $s7, $zero, $s2
createArray:
	
	beqz $s1, done
	
	li $a1, 99999
	li $v0, 42
	syscall	
	
	addi $a0, $a0, 1
	sw $a0, 0($s2)
	
	addi $s1, $s1, -1
	addi $s2, $s2, 4
	
	bgt $s1, $zero, createArray
	
done:	
	move $v0, $s7
	move $v1, $s6
	jr $ra
	
bubbleSort:
	move $s6, $a1
pass:
	move $s0, $a1
	move $s7, $a0
	
	beqz $s0, done
	beq $s0, 1, done
	addi $s0, $s0, -1
	
sorting:
	
	lw $s1, 0($s7) #2nd last element
	lw $s2, 4($s7) #last element
	
	bgt $s1, $s2, swap
next:
	addi $s7, $s7, 4
	addi $s0, $s0, -1
	bgt $s0, $zero, sorting
	addi $s6, $s6, -1
	bgt $s6, $zero, pass
	move $v0, $a0
	move $v1, $a1
	jr $ra
	
swap:
	sw $s1, 4($s7)
	sw $s2, 0($s7)
	j next
	
processArray:
	move $s0, $a1
	addi $s2, $zero, 1
	move $s4, $a0
process:
	lw $s1, 0($s4)
	add $a0, $zero, $s2
	li $v0, 1
	syscall
	 
	li $v0, 4
	la $a0, break
	syscall
	
	add $a0, $zero, $s1
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, break
	syscall
	
	addi $s5, $zero, 0
	add $s7, $zero, $s1
sumDigits:
	div $s7, $s7, 10
	mfhi $s6
	add $s5, $s5, $s6
	bgt $s7, $zero, sumDigits
	
	add $a0, $zero, $s5
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, break
	syscall
	
	addi $s7, $zero, 2
checkPrime:
	div $s5, $s1, $s7
	mfhi $s5
	beqz $s5, notPrime
	addi $s7, $s7, 1
	blt $s7, $s1, checkPrime
	
	li $v0, 4
	la $a0, prime
	syscall
	
nextStep:	
	addi $s4, $s4, 4
	addi $s0, $s0, -1
	addi $s2, $s2, 1
	bgt $s0, $zero, process
	jr $ra
	
notPrime:
	li $v0, 4
	la $a0, nprime
	syscall
	j nextStep
	
	
	
	
	
	
	
	.data
size: 	.word 0
prime:	.asciiz "Yes \n"
nprime:	.asciiz "No \n"
break: 	.asciiz "  "
msg: 	.asciiz "\nEnter the size of the array to be generated: "	
