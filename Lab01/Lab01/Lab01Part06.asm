# Mannan Abdul Lab01 Part06

	.text
	li $v0, 4 #Show user the expression and ask input for a
	la $a0, prompt
	syscall
	li $v0, 5 #Take input for b
	syscall
	sw $v0, b #Store the value of b
	
	li $v0, 4 #Ask input for c
	la $a0, cMsg
	syscall
	li $v0, 5 #Take input for c
	syscall
	sw $v0, c #Store input for c
	
	li $v0, 4 #Ask input for d
	la $a0, dMsg
	syscall
	li $v0, 5 #Take input for d
	syscall
	sw $v0, d #Store input for d
	
	#Load all values into argument registers
	lw $a1, b
	lw $a2, c
	lw $a3, d
	
	jal calculateExpression #Go to method to calculate ans
	
	sw $v0, a #Store the ans in x
	
	li $v0, 4 #Show msg for output of ans
	la $a0, msg
	syscall
	
	lw $t0, a #Load ans into $t0
	
	li $v0, 1 #Display the ans
	add $a0, $zero, $t0
	syscall
	
	li $v0, 10 #Program is done
	syscall
	
calculateExpression:
	div $a1, $a2 #$t0 = B / C
	mfhi $t0 #$t0 = B Mod C
	div $t0, $a3 #$t1 = (B Mod C) / D
	mflo $t1
	mul $t2, $a2, $a3 #$t2 = D * C
	add $t3, $t1, $t2 #(B Mod C) / D] + (D * C)
	
	add $v0, $zero, $t3 #Put value into $v0 to return
	
	jr $ra #Go back to main method
		
	.data
a:	.space 4
b: 	.space 4
c:	.space 4
d:	.space 4
prompt:	.asciiz "For the Expression A = [(B Mod C) / D] + (D * C)\n Enter b: "
cMsg:	.asciiz "\n Enter c: "
dMsg:	.asciiz "\n Enter d: "
msg:	.asciiz "\n The answer is: "