# Mannan Abdul Lab01 Part01a
	.text
readSize:
	
	la $a0, sizeMsg #Output prompt to get the size from the user
	li $v0, 4
	syscall
	
	li $v0, 5 #We read the user specified size of the array
	syscall
	
	bgt $v0, 20, readSize #Asks the user to enter the array size again if it is larger than 20
	sw $v0, size
	
	la $t0, array #Loads the address of array to $t0
	lw $t1, size #Loads size to $t1
	li $t2, 0 #$t2 will be used to compute the sum of all the integers in the array
	
readArray:
	
	la $a0, msg #Output prompt to get the array element from the user
	li $v0, 4
	syscall
	
	li $v0, 5 #We read the user specified element of the array
	syscall
		
	sw $v0, ($t0) #The array element is saved to the first memory address reserved for the array 
	add $t2, $t2, $v0 #the sum of the integers is incremented
	
	addi $t0, $t0, 4 #Adds 4 to $t0 to update the address to save the next element 
	addi $t1, $t1, -1 #Keeps count so we only make an array of the size specified
	
	bgt $t1, $zero, readArray  #Checks if all values have been taken, else goes back to readArray
	
	la $a0, arrayMsg #Displays array contents one by one after msg
	li $v0, 4
	syscall
	
	la $t0, array #Loads array address to start displaying them
	lw $t1, size #Loads size again to help keep count

print:	
	lw $t3, 0($t0)	#Loads elements to $t3 to display to the user
	
	la $a0, endl #Goes to new line after every element displayed
	li $v0, 4
	syscall
	
	li $v0, 1 #Array element is displayed
	add $a0, $zero, $t3
	syscall
	
	addi $t0, $t0, 4 #Adds 4 to $t0 to update the address to display the next element 
	addi $t1, $t1, -1 #Keeps count to help display the array
	
	bgt $t1, $zero, print #Checks if all elements are displayed, else will keep printing
	
	la $a0, endl #Goes to new line before displaying the sum
	li $v0, 4
	syscall
	
	la $a0, sum #Gives msg that it will display the sum
	li $v0, 4
	syscall
	
	li $v0, 1 #Displays the sum
	add $a0, $zero, $t2
	syscall
	
	li $v0, 10 #Program is done
	syscall
	
	
	
	.data
array: 		.space 80
size: 		.space 4
sizeMsg:	.asciiz "\n Enter the size of the array (size <= 20): " 
msg:		.asciiz "\n Enter the Array Element: " 
arrayMsg:	.asciiz "\n Array Contents: "
endl:		.asciiz "\n "
sum: 		.asciiz "The sum of the contents is: "
	