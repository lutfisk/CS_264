# Who:		Lutfi Haji-Cheteh
# What: 	BinarySearch.asm
# Why:		Project 03: A program that accepts
#		integer values as well as quantity
#		of integers to be read. These values
#		are stored in a stack to print.
# When: 	Created on: 15th May 2018
#		Due date: 25th May 2018

.data
	prompt1: .asciiz "\nEnter the quantity of values to be stored: "
	prompt2: .asciiz "\nEnter integer to add: "
	prompt3: .asciiz "\Enter an integer to sarch for: "
	found: .asciiz " is found at "
	notFound: .asciiz "is not found."
	newLine: .asciiz "\n"
	printPrompt: .asciiz "\nNumbers in sorted order: \n"
	
.text
.globl main

main:	# program entry
	li $t1, 0		#t1 = i
	li $t3, 0		#t3 = temp counter for print
	li $s2, 0		#count of int already added to stack
	la $s3, 0($sp)		#initial position of stack
	
	li $v0, 4
	la $a0, prompt1
syscall
	
	li $v0, 5		#take input from user
syscall	
	
	move $s1, $v0
	move $t0, $s1		#save quantity to s1 and t0(n inputs)
	
	loop: 			#for taking inputs
	bge $t1, $t0, printStack
	li $v0, 4
	la $a0, prompt2
syscall
	li $v0, 5
syscall					
	move $a0, $v0
	jal store		#subroutine call to add numbers to a sorted stack
	addi $t1, $t1, 1	#increment i
	b loop		
				
	printStack: 		#printing stack
	li $v0, 4
	la $a0, printPrompt
syscall

	printNextNum:
	bge $t3, $s1, exit	#print number from stack and increment stack pointer	
	lw $a0, 0($sp)		#print at the top of the stack
	li $v0, 1
syscall
	li $v0, 4
	la $a0, newLine
syscall
	addi $sp, $sp, 4	#move stack pointer to previous
	addi $t3, $t3, 1	#temp counter for printing					
	b printNextNum
	
exit:
li $v0, 10 # terminate the program
syscall																					
	
	store:			#storing in the stack
	addi $sp, $sp, -4	#to make space																														
	sw $a0, 0($sp)		#save number to bottom of the stack
	la $t6,	0($sp)
	addi $s2, $s2, 1	#counter stack size
	li $t3, 0
	
	sort:			#sorting the stack (high to low)
	beq $s3, $sp, return	#if already top of the stack, branch
	lw $t4, 0($sp)		
	lw $t5, 4($sp)		#compare two integers
	ble $t4, $t5, return	#if element in correct position, branch
	sw $t5, 0($sp)		#swap
	sw $t4, 4($sp)		#swap		
	addi $sp, $sp, 4
	b sort	
	
	return:
	move $sp, $t6		#reset stack pointer
	jr $ra			#return to callee	
	
																																																																	
																															
							
