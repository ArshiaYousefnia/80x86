.data
scores: 
	.word 95, 87, 98, 100, 100
prompt: 
	.asciiz "result:\n"
sum: 
	.space 4
pi: 
	.double 3.1415
	
.text
	li $v0,3
	l.d $f12,pi
	syscall 
	jal printNewLine
loop:
	li $v0,5
 	syscall
 	
	beq $v0,$zero,end
	add $s1,$s1,$v0
	j loop

end:
	li $v0,4
	la $a0,prompt
	syscall

	li $v0,1
	move $a0,$s1
	syscall
	
	li $v0,10
	syscall

printNewLine:
	li $v0,11
	li $a0,'\n'
	syscall
	jr $ra