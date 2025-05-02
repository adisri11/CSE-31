.data 
orig: .space 100	# In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100
str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded down) with dropped scores removed: "
str6: .asciiz "All scores dropped!\n"
str_space: .asciiz " "
str_newline: .asciiz "\n"

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
	addi $sp, $sp -28
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	
input_num_scores:
	la $a0, str0 
	li $v0, 4 
	syscall 
	li $v0, 5	# Read the number of scores from user
	syscall
	
	# Your code here to handle invalid number of scores (can't be less than 1 or greater than 25)
	blez $v0, input_num_scores    # If numScores <= 0, ask again
	li $t0, 25
	bgt $v0, $t0, input_num_scores  # If numScores > 25, ask again
	
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
	move $a0, $s1	# More efficient than la $a0, orig
	move $a1, $s0
	jal printArray	# Print original scores
	li $v0, 4 
	la $a0, str3 
	syscall 
	move $a0, $s2	# More efficient than la $a0, sorted
	move $a1, $s0
	jal printArray	# Print sorted scores
	
input_drop:
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	# Read the number of (lowest) scores to drop
	syscall
	
	# Your code here to handle invalid number of (lowest) scores to drop
	bltz $v0, input_drop     # If drop < 0, ask again
	bgt $v0, $s0, input_drop  # If drop > numScores, ask again
	
	# Handle case when number of scores to drop equals the number of scores
	beq $v0, $s0, all_dropped
	
	move $s3, $v0       # Store drop count in $s3
	sub $s4, $s0, $s3	# $s4 = numScores - drop
	move $a0, $s2
	move $a1, $s4       # Use $s4 for length parameter
	jal calcSum	# Call calcSum to RECURSIVELY compute the sum of scores that are not dropped
	
	# Store sum in $s5
	move $s5, $v0
	
	# Calculate average: sum / (numScores - drop)
	div $s5, $s4
	mflo $t0            # Get quotient (average)
	
	# Print average
	li $v0, 4
	la $a0, str5
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, str_newline  
	syscall
	j end
	
all_dropped:
	li $v0, 4
	la $a0, str6
	syscall
	
end:	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	addi $sp, $sp, 28
	li $v0, 10 
	syscall
	
	
# printArray takes in an array and its size as arguments. 
# It prints all the elements in one line with a newline at the end.
printArray:
	# Save $ra, $s0, $s1 to stack
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	move $s0, $a0       # s0 = array address
	move $s1, $a1       # s1 = size
	
	li $t0, 0           # t0 = counter
print_loop:
	beq $t0, $s1, print_done
	
	# Print the element
	sll $t1, $t0, 2     # t1 = t0 * 4 (byte offset)
	add $t1, $t1, $s0   # t1 = address of array[t0]
	lw $a0, 0($t1)      # a0 = array[t0]
	li $v0, 1
	syscall
	
	# Print a space
	li $v0, 4
	la $a0, str_space
	syscall
	
	addi $t0, $t0, 1    # Increment counter
	j print_loop
	
print_done:
	# Print newline
	li $v0, 4
	la $a0, str_newline
	syscall
	
	# Restore registers
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
	
	jr $ra
	
	
# selSort takes in the number of scores as argument. 
# It performs SELECTION sort in descending order and populates the sorted array
selSort:
	# Save registers
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	
	move $s0, $a0       # s0 = size
	la $s1, orig        # s1 = orig array
	la $s2, sorted      # s2 = sorted array
	
	# First copy orig to sorted
	li $t0, 0           # t0 = i
copy_loop:
	beq $t0, $s0, copy_done
	sll $t1, $t0, 2     # t1 = i * 4
	add $t1, $t1, $s1   # t1 = &orig[i]
	lw $t2, 0($t1)      # t2 = orig[i]
	
	sll $t3, $t0, 2     # t3 = i * 4
	add $t3, $t3, $s2   # t3 = &sorted[i]
	sw $t2, 0($t3)      # sorted[i] = orig[i]
	
	addi $t0, $t0, 1    # i++
	j copy_loop
	
copy_done:
	# Selection sort in descending order
	li $s3, 0           # s3 = i
outer_loop:
	beq $s3, $s0, sort_done
	
	move $s4, $s3       # s4 = maxIndex = i
	addi $t0, $s3, 1    # t0 = j = i + 1
inner_loop:
	beq $t0, $s0, swap
	
	sll $t1, $t0, 2     # t1 = j * 4
	add $t1, $t1, $s2   # t1 = &sorted[j]
	lw $t1, 0($t1)      # t1 = sorted[j]
	
	sll $t2, $s4, 2     # t2 = maxIndex * 4
	add $t2, $t2, $s2   # t2 = &sorted[maxIndex]
	lw $t2, 0($t2)      # t2 = sorted[maxIndex]
	
	ble $t1, $t2, not_greater  # if sorted[j] <= sorted[maxIndex], skip
	move $s4, $t0       # maxIndex = j
	
not_greater:
	addi $t0, $t0, 1    # j++
	j inner_loop
	
swap:
	# Swap sorted[i] and sorted[maxIndex]
	sll $t1, $s3, 2     # t1 = i * 4
	add $t1, $t1, $s2   # t1 = &sorted[i]
	lw $t3, 0($t1)      # t3 = sorted[i]
	
	sll $t2, $s4, 2     # t2 = maxIndex * 4
	add $t2, $t2, $s2   # t2 = &sorted[maxIndex]
	lw $t4, 0($t2)      # t4 = sorted[maxIndex]
	
	sw $t4, 0($t1)      # sorted[i] = sorted[maxIndex]
	sw $t3, 0($t2)      # sorted[maxIndex] = temp
	
	addi $s3, $s3, 1    # i++
	j outer_loop
	
sort_done:
	# Restore registers
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	addi $sp, $sp, 24
	
	jr $ra
	
	
# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
	# Base case: if size == 0, return 0
	beqz $a1, sum_base_case
	
	# Save registers to stack
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	
	# Recursive case: return array[size-1] + calcSum(array, size-1)
	addi $a1, $a1, -1          # size = size - 1
	jal calcSum                 # Calculate sum of first size-1 elements
	
	# Restore registers
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $t0, 8($sp)             # t0 = original size
	addi $sp, $sp, 12
	
	# Calculate address of array[size-1]
	addi $t0, $t0, -1          # t0 = size - 1
	sll $t0, $t0, 2            # t0 = (size - 1) * 4
	add $t0, $a0, $t0          # t0 = address of array[size-1]
	lw $t0, 0($t0)             # t0 = array[size-1]
	
	add $v0, $v0, $t0          # sum = recursive sum + array[size-1]
	jr $ra
	
sum_base_case:
	li $v0, 0                   # Return 0 for empty array
	jr $ra