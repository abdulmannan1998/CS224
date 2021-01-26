#Mannan Abdul Lab02 Part01
	.text
	
	jal initializeArray
	jal bubbleSort
	jal processArray
	
	li $v0, 10
	syscall
	
initializeArray:
	
	la $a0, msg
	li $v0, 4
	syscall	
	
	li $v0, 5
	syscall
	
	sw $v0, size
	lw $s0, size
	
createArray:
	
	beqz $s0, done
	
	addi $sp, $sp, -4
	
	li $a1, 99999
	li $v0, 42
	syscall	
	
	addi $a0, $a0, 1
	sw $a0, 0($sp)
	
	addi $s0, $s0, -1
	
	bgt $s0, $zero, createArray
	
done:	
	jr $ra
	
bubbleSort:
	lw $s6, size
pass:
	lw $s0, size
	la $s7, ($sp)
	
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
	j done
	
swap:
	sw $s1, 4($s7)
	sw $s2, 0($s7)
	j next
	
processArray:
	lw $s0, size
	addi $s2, $zero, 1

process:
	lw $s1, 0($sp)
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
	bnez $s5, notPrime
	addi $s7, $s7, 1
	blt $s7, $s1, checkPrime
	
	li $v0, 4
	la $a0, prime
	syscall
	
nextStep:	
	addi $sp, $sp, 4
	addi $s0, $s0, -1
	addi $s2, $s2, 1
	bgt $s0, $zero, process
	j done
	
notPrime:
	li $v0, 4
	la $a0, nprime
	syscall
	j nextStep
	
	
	
	
	
	
	
	.data
prime:	.asciiz "Yes \n"
nprime:	.asciiz "No \n"
break: 	.asciiz "  "
msg: 	.asciiz "\nEnter the size of the array to be generated: "
size: 	.word 0	
