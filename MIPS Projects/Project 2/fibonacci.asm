# Who:		Lutfi Haji-Cheteh
# What: 	fibnacci.asm
# Why:		Project 02: A program that 
#		calculates nth Fibonacci number.
# When: 	Created on: 1st May 2018
#		Due date: 2nd May 2018

.data
 	fArray: .space 184 #space for 46 numbers
 	prompt: .asciiz "\nEnter a number between 1-46 (0 to end the program): "
 	errorPrompt: .asciiz "\nPlease enter a valid input between 0 to 46\n"
 	space: .asciiz " "
 	arrayPrompt: .asciiz "\nFibonacci series: "
 	
.text
.globl main

main:	#program entry
	li $t5, 46 #maximum number
	li $v0, 4
	la $a0, prompt
syscall
	li $v0, 5 #take input from user
syscall

	blt $v0, $zero, errorInput #error if less than zero
	bgt $v0, $t5, errorInput #error if larger than our maximum
	beq $v0, 0, exit #exit if input 0
	b continue

	errorInput:
	li $v0, 4
	la $a0, errorPrompt
syscall
	b main
	
	continue:
	move $t0, $v0 #store input in $t0
	move $t7, $v0 #store input in $t0
	
	la $t5, fArray #load starting address of array
	li $t1, 0
	sw $t1, 0($t5) #store
	li $t2, 1

	loop:	#until nth number
	beq $t0, 1, print #print if n=1
	add $t4, $t1, $t2
	move $t1, $t2
	move $t2, $t4
	addi $t5, $t5, 4
	sw $t1, 0($t5)
	addi $t0, $t0, -1
	b loop
	
	print: #print the fibonicci number of n
	li $v0, 1
	move $a0, $t1
syscall

	aPrompt: #print the prompt
	la $a0, arrayPrompt
	li $v0, 4
syscall

	printArray: #print the array
	la $t8, fArray
	
	printArrayLoop: #print the integers in the array
	beqz $t7, main
	lw $a0, 0($t8)
	li $v0, 1
syscall
	li $v0, 4
	la $a0, space
syscall
	li $v0, 4
	la $a0, space
syscall
	addi $t8, $t8, 4
	addi $t7, $t7, -1
	b printArrayLoop

exit:
li $v0, 10 # terminate the program
syscall