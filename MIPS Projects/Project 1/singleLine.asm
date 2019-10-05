# Who:		Lutfi Haji-Cheteh
# What: 	singleLine.asm
# Why:		Project 01: A program that 
#		reads an array of 20 int
#		to store and print.
# When: 	Created on: 19 April 2018
#		Due date: 25 April 2018

.data
	array: .space 80 #4 bytes per int of 20 integers
	msg1: .asciiz "Please enter 20 integers, one at a time: \n"
	msg2: .asciiz "Our array: \n" #print array
	msg3: .asciiz "Please enter the number of values per line: \n"
	space: .asciiz " "
	newLine: .asciiz "\n"	
					
.text
.globl main

main:	# program entry
	la $a1, array
	li $s0, 0 #init with 0
	li $t5, 0 
	li $t9, 0
	li $t1, 20 #reading 20 integers
	
	readArray:
	beq $t5, $t1, printArray #if there are 20 ints in the array, jump to print
	la $a0, msg1 #promt for ints
	li $v0, 4 #print
syscall
	li $v0, 5 #read int
syscall	
	addi $t5, $t5, 1 #incrementing values
	addi $s0, $s0, 4 #incrementing values
	sw $v0, ($a1) #store
	addi $a1, $a1, 4
	j readArray #loop back to read ints if not read 20
	
	printArray:
	la $a1, array
	li $s4, 0
	la $a0, msg3
	li $v0, 4
syscall
	li $v0, 5
syscall
	move $t8, $v0
	la $a0, msg2
	li $v0, 4
syscall
	
	write:
	blez $s0, end #end if less or equl to 0
	li $v0, 1
	lw $a0, 0($a1)
syscall
	addi $s4, $s4, 1
	beq $s4, $t8, printNewLine
	la $a0, space
	li $v0, 4
syscall

	loop:
	addi $a1, $a1, 4
	addi $s0, $s0, -4
	j write #loop back to write if not all values are printed
	
	printNewLine:
	li $s4, 0
	la $a0, newLine
	li $v0, 4
syscall	
	j loop			
								
	end:
	li $v0, 10 # terminate the program
syscall
