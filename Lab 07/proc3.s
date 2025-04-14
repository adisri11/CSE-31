.data
x: .word 2
y: .word 4
z: .word 6
prompt: .asciiz "p + q: "
newline: .asciiz "\n"

.text
.globl main

main:
    la $t0, x
    lw $s0, 0($t0)      
    la $t0, y
    lw $s1, 0($t0)      
    la $t0, z
    lw $s2, 0($t0)      
    
    move $a0, $s0       
    move $a1, $s1       
    move $a2, $s2       
    jal foo             
    
    add $t0, $s0, $s1   
    add $t0, $t0, $s2   
    add $s2, $t0, $v0   
    
    li $v0, 1
    move $a0, $s2       
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 10
    syscall

foo:
    addi $sp, $sp, -24
    sw $ra, 20($sp)
    sw $s2, 16($sp)
    sw $s1, 12($sp)
    sw $s0, 8($sp)
    sw $a1, 4($sp)
    sw $a0, 0($sp)
    
    move $t0, $a0       
    move $t1, $a1       
    move $t2, $a2       
    
    add $a0, $t0, $t2   
    add $a1, $t1, $t2   
    add $a2, $t0, $t1   
    
    jal bar
    
    move $s0, $v0       
    
    sub $a0, $t0, $t2  
    sub $a1, $t1, $t0   
    add $a2, $t1, $t1   
    
    jal bar
    
    move $s1, $v0       
    
    li $v0, 4
    la $a0, prompt
    syscall
    
    add $t0, $s0, $s1   
    
    li $v0, 1
    move $a0, $t0      
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    move $v0, $t0
    
    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $s0, 8($sp)
    lw $s1, 12($sp)
    lw $s2, 16($sp)
    lw $ra, 20($sp)
    addi $sp, $sp, 24
    
    jr $ra

bar:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)
    
    sub $t0, $a1, $a0   
    sllv $v0, $t0, $a2  
    
    lw $a0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    
    jr $ra