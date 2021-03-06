	.text

main:
	li $v0, 4
	la $a0, Menu
	syscall
	
	li $v0, 4
	la $a0, prompt1
	syscall
	
	li $v0, 4
	la $a0, prompt2
	syscall
	
	li $v0, 4
	la $a0, prompt4
	syscall
	
	li $v0, 4
	la $a0, prompt5
	syscall
	
	li $v0, 4
	la $a0, prompt6
	syscall
	
	li $v0, 4
	la $a0, prompt7
	syscall
	
	li $v0, 4
	la $a0, prompt9
	syscall
	
	li $v0, 4
	la $a0, prompt8
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0, 1, GetArraySize
	beq $v0, 2, InitializeArray
	beq $v0, 3, ShowArrayElement
	beq $v0, 4, RowMajorAdd
	beq $v0, 5, ColumnMajorAdd
	beq $v0, 6, ShowROrC
	beq $v0, 7, Exit
			
GetArraySize:
	li $v0, 4
	la $a0, prompt10
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0 #save N in $s0
	
	j Done
InitializeArray:
	mul $s1, $s0, $s0 #save no of elements in $s1
	mul $t1, $s1, 4
	li $t0, 0
			
	li $v0, 9
	move $a0, $t1
	syscall
	
	move $s2, $v0 #the starting address of the array
	move $t2, $s2
initial:
	sw $t0, ($t2)
	addi $t0, $t0, 1
	addi $t2, $t2, 4
	bne $t0, $s1, initial	
	
	j Done

	
ShowArrayElement:
	li $v0, 4
	la $a0, prompt11
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, prompt12
	syscall
	
	li $v0, 5
	syscall
	
	move $t1, $v0
	
	addi $t0, $t0, -1
	addi $t1, $t1, -1
	mul $t2, $s0, 4
	mul $t1, $t1, $t2
	mul $t0, $t0, 4
	add $t3, $t0, $t1
	add $t3, $s2, $t3
	
	li $v0, 4
	la $a0, prompt13
	syscall
	
	li $v0, 1
	lw $a0, ($t3)
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	j Done
	
RowMajorAdd:
	li $t0, 1 #i = 1
	li $t1, 1 #j = 1
	li $t5, 0 #to compare with Nj
	li $t4, 0 #to comare with Ni
	li $t7, 0 #sum
computeRowMajor:	
	addi $t0, $t0, -1
	addi $t1, $t1, -1
	mul $t2, $s0, 4
	mul $t1, $t1, $t2
	mul $t0, $t0, 4
	add $t3, $t0, $t1
	add $t3, $s2, $t3
	lw $t6, ($t3)
	add $t7, $t7, $t6
	
	addi $t5, $t5, 1
	addi $t1, $t5, 1
	addi $t0, $t4, 1
	bne $s0, $t5, computeRowMajor
	addi $t4, $t4, 1
	li $t5, 0
	addi $t1, $t5, 1
	addi $t0, $t4, 1
	bne $s0, $t4, computeRowMajor
	
	li $v0, 4
	la $a0, prompt14
	syscall
	
	li $v0, 1
	move $a0, $t7
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	j Done
	
	
ColumnMajorAdd:
	li $t0, 0 #sum
	move $t1, $s2 #starting address of array
	li $t3, 0 #compare with no of elements
	
computeColumnMajor:	
	lw $t2, ($t1)
	add $t0, $t0, $t2
	addi $t1, $t1, 4
	addi $t3, $t3, 1
	bne $s1, $t3, computeColumnMajor
	
	li $v0, 4
	la $a0, prompt15
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall
	
	j Done
	
ShowROrC:
	li $v0, 4
	la $a0, prompt16
	syscall
	
	li $v0, 5
	syscall
	
	move $s4, $v0 #row or column
	
	li $v0, 4
	la $a0, prompt17
	syscall
	
	li $v0, 5
	syscall
	
	move $s3, $v0 #row or column number
	bgt $s3, $s0, error
	bnez $s4, displayRow
	j displayColumn
displayRow:
	move $t0, $s3#row number, i = $t0
	li $t1, 1 #j = 1
	li $t4, 0#to compare with N
	
computeDisplayRow:
	addi $t0, $t0, -1
	addi $t1, $t1, -1
	mul $t2, $s0, 4
	mul $t1, $t1, $t2
	mul $t0, $t0, 4
	add $t3, $t0, $t1
	add $t3, $s2, $t3
	lw $t6, ($t3)	
	 
	li $v0, 1
	move $a0, $t6
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $t4, $t4, 1
	addi $t1, $t4, 1
	move $t0, $s3 
	bne $t4, $s0, computeDisplayRow
	
	li $v0, 4
	la $a0, newline
	syscall	
	
	j Done
	 
	 
displayColumn:
	move $t0, $s3#j = $t0
	li $t7, 0#to compare with N
	addi $t0, $t0, -1
	mul $t1, $s0, 4
	mul $t0, $t0, $t1
	add $t2, $s2, $t0
computeDisplayColumn:
	lw $t3, ($t2)
	
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, newline
	syscall	
	
	addi $t7, $t7, 1
	addi $t2, $t2, 4
	
	bne $t7, $s0, computeDisplayColumn
	
	j Done
error:
	li $v0, 4
	la $a0, prompt18
	syscall	
	
	li $v0, 4
	la $a0, newline
	syscall	
	
	j Done
Done:
	j main
Exit:
	li $v0, 10
	syscall
	
	
	
	
	
	
	
	
	
	
	.data
newline: .asciiz "\n"
space: .asciiz "  "
colon: .asciiz ": "
Menu: .asciiz "                  Menu              \n"
prompt1: .asciiz "1: Enter the size of the matrix in terms of its dimensions (N)\n"
prompt2: .asciiz "2: Enter the elements of the array colunmwise\n"
prompt3: .asciiz "\nEnter element "
prompt4: .asciiz "3: See element at position in Matrix[i,j] \n"
prompt5: .asciiz "4: Obtain row by row summation of matrix elements\n"
prompt6: .asciiz "5: Obtain column by column summation of matrix elements\n"
prompt7: .asciiz "6: Display a certain row or column, range should be within N\n"
prompt8: .asciiz "Choose your option by entering its number: "
prompt9: .asciiz "7: Exit\n"
prompt10: .asciiz "N = "
prompt11: .asciiz "i = "
prompt12: .asciiz "j = "
prompt13: .asciiz "\nM[i,j] = "
prompt14: .asciiz "\nRow major addition will give us: "
prompt15: .asciiz "\nColumn major addition will give us: "
prompt16: .asciiz "\nEnter 0 for column, 1 for row: "
prompt17: .asciiz "\nEnter row/column number: "
prompt18: .asciiz "\nrow/column number is out of bounds! "
