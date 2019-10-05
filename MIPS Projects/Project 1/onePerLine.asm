# Who:		Lutfi Haji-Cheteh
# What: 	onePerLine.asm
# Why:		Project 01: A program that 
#		reads an array of 20 int
#		to store and print.
# When: 	Created on: 19 April 2018
#		Due date: 25 April 2018

 .data
	array: .space 80 #4 bytes per int of 20 integers
	msg1: .asciiz "\nPlease enter 20 integers, one at a time: "
	msg2: .asciiz "Our array: " #print array
	space: .asciiz " " #our space between numbers
			
.text
.globl main

main:	# program entry
	la $a1, array #load base address
	li $s0, 0 #init with 0
	li $t5, 0 
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
	la $a0, msg2
	li $v0, 4
syscall

	write:
	blez $s0, end #end if less or equl to 0
	li $v0, 1
	lw $a0, 0($a1)
syscall	
	la $a0, space
	li $v0, 4
syscall
	addi $a1, $a1, 4
	addi $s0, $s0, -4
	j write #loop back to write if not all values are printed
																			
	end:	
	li $v0, 10 # terminate the program
syscall
