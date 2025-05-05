.data 

orig: .space 100	# In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100

str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded down) with dropped scores removed: "
str6: .asciiz "All scores dropped!"
space: .asciiz " "
newline: .asciiz "\n"

.text 

# This is the main program.
# It first asks user to enter the number of assignments.
# It then asks user to input the scores, one at a time.
# It then calls selSort to perform selection sort.
# It then calls printArray twice to print out contents of the original and sorted scores.
# It then asks user to enter the number of (lowest) scores to drop.
# It then calls calcSum on the sorted array with the adjusted length (to account for dropped scores).
# It then prints out average score with the specified number of (lowest) scores dropped from the calculation.
main: 
	addi $sp, $sp -4
	sw $ra, 0($sp)
	la $a0, str0 
	li $v0, 4 
	syscall 
	li $v0, 5	# Read the number of scores from user
	syscall
	
	# Your code here to handle invalid number of scores (can't be less than 1 or greater than 25)
	
	blt $v0, 1, main
	bgt $v0, 25, main
	
	move $s0, $v0	# $s0 = numScores
	move $t0, $0
	la $s1, orig	# $s1 = orig
	la $s2, sorted	# $s2 = sorted
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	# Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	
	move $a0, $s0
	jal selSort	# Call selSort to perform selection sort in original array
	
	li $v0, 4 
	la $a0, str2 
	syscall
	move $a0, $s1	
	move $a1, $s0
	jal printArray	# Print original scores
	li $v0, 4 
	la $a0, str3 
	syscall 
	move $a0, $s2	
	jal printArray	# Print sorted scores
	
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	# Read the number of (lowest) scores to drop
	syscall
	
	# Your code here to handle invalid number of (lowest) scores to drop (can't be less than 0, or 
	# greater than the number of scores). Also, handle the case when number of (lowest) scores to drop 
	# equals the number of scores. 
	beq $v0, $s0, alldropped
	blt $v0, $zero, dropped
	bgt $v0, $s0, dropped
	
	move $a1, $v0
	sub $a1, $s0, $a1	# numScores - drop
	move $a0, $s2
	jal calcSum	# Call calcSum to RECURSIVELY compute the sum of scores that are not dropped
	
	# Your code here to compute average and print it (you may also end up having some code here to help 
	# handle the case when number of (lowest) scores to drop equals the number of scores
	
	div $v0, $a1
	mflo $a1
	
	li $v0, 4
	la $a0, str5
	syscall
	
	
	li $v0, 1
	la $a0, 0($a1)
	syscall
	
	j end
	
alldropped: 
	li $v0, 4
	la $a0, str6
	syscall
	
	li $v0, 10
	syscall
	
dropped:
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	
	syscall
	
	beq $v0, $s0, alldropped
	blt $v0, $zero, dropped
	bgt $v0, $s0, dropped
	
	move $a1, $v0
	sub $a1, $s0, $a1
	move $a0, $s2
	jal calcSum	
	
	
	div $v0, $a1
	mflo $a1
	
	li $v0, 4
	la $a0, str5
	syscall
	
	la $a0, space
	syscall
	
	li $v0, 1
	la $a0, 0($a1)
	syscall
	
	j end
	
end:	lw $ra, 0($sp)
	addi $sp, $sp 4
	li $v0, 10 
	syscall
	

# printList takes in an array and its size as arguments. 
# It prints all the elements in one line with a newline at the end.
printArray:
	# Your implementation of printList here	
	addi $sp, $sp, -12
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $ra, 0($sp)
	
	li $t5, 0
	move $s1, $a0       # s0 = array address
	printloop: 
		beq $t5, $s0, endprint
		
		addi $sp, $sp, -4
		sw $a0, 0($sp)
		
		sll $t4, $t5, 2
		add $t6, $t4, $s1
		lw $a0, 0($t6)
		
		li $v0, 1
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
		lw $a0, 0($sp)
		addi $sp, $sp, 4
		
		addi $t5, $t5, 1
		j printloop
		
	endprint:
		lw $s0, 8($sp)
		lw $s1, 4($sp)
		lw $ra, 0($sp)
		addi $sp, $sp, 12
		
		li $v0, 4
		la $a0, newline
		syscall
		
		jr $ra
	
	
# selSort takes in the number of scores as argument. 
# It performs SELECTION sort in descending order and populates the sorted array
selSort:
	# Your implementation of selSort here
	li $t7, 0
	li $t0, 0
	copy: 
		sll  $t6, $t7, 2      # Offset in bytes (index * 4)
    		add  $t3, $s1, $t6    # Address of orig[i]
    		lw   $t4, 0($t3)      # Load orig[i] into $t4
    		add  $t5, $s2, $t6    # Address of dest[i]
    		sw   $t4, 0($t5)
    		
    		addi $t7, $t7, 1
		bne $t7, $s0, copy
	finish_copy:
		li $s3, 0   #i = 0

	selloop:
		addi $sp, $sp, -16
    		sw $ra, 0($sp)
    		sw $s2, 4($sp)
    		sw $s3, 8($sp)
    		sw $s4, 12($sp)
	
		beq $s3, $s0, endsel  
		move $s4, $s3  #maxindex = i
	
		addi $t0, $s3, 1 #j = i + 1
		
	findmax: 
		beq $t0, $s0, swap 
		
		sll $t1, $t0, 2
		add $t1, $t1, $s2  
		lw $t2, 0($t1)      #sorted[j]
		
		sll $t1, $s4, 2
		add $t1, $t1, $s2
		lw $t1, 0($t1)    #sorted[maxindex]
		
		ble $t2, $t1, not_max     #sorted[j] <= sorted[maxindex]
		move $s4, $t0
		
	not_max: 
		addi $t0, $t0, 1 #j++
		j findmax
	
	swap: 
		#maybe add base case if not working  (maxindex == i)
		sll $t1, $s3, 2
		add $t1, $t1, $s2 #&sorted[i] 
		lw $t3, 0($t1) #sorted[i]
		
		sll $t2, $s4, 2
		add $t2, $t2, $s2 #&sorted[maxindex]
		lw $t4, 0($t2) #sorted[maxindex]
		
		sw $t3, 0 ($t2) #sorted[maxindex} = sorted[i]
		sw $t4, 0($t1)  #sorted[i] = original sorted[maxindex]
		
		addi $s3, $s3, 1 #i++
		j selloop
	
	endsel: 
		#load back everything
		lw $ra, 0($sp)
    		lw $s2, 4($sp)
    		lw $s3, 8($sp)
    		lw $s4, 12($sp)
    		addi $sp, $sp, 16
		
		jr $ra
	
	
# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
	# Your implementation of calcSum here
	li $t1, 1
	beqz $a1, basecase
	
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	
	addi $a1, $a1, -1
	jal calcSum
	
	lw $a1, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	
	addi $t4, $a1, -1
	sll $t4, $t4, 2
	add $t6, $t4, $a0
	lw $t6, 0($t6) #arr[len -1]
	
	add $v0, $v0, $t6
	
	jr $ra
	
basecase:
	li $v0, 0
	jr $ra
	
