segment .data

fmt_scn: db "%s",0
fmt_print: db "%s",10,0
msg1: db "Palindrome",0
msg2: db "Not a palindrome",0

segment .bss
str1 resb 1000
str2 resb 1000

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt_scn
	mov RSI,str1
	mov RAX,0
	call scanf

	mov RAX,str1
	JMP STR1_LEN

	ML1:
		dec RAX
		push RAX
		mov RAX,str2
		push RAX
		call COPY
		pop RAX
		pop RAX


	mov RDI,fmt_print
	mov RSI,str2
	mov RAX,0
	call printf

	mov RAX,str1
	push RAX
	mov RAX,str2
	push RAX
	call CHECK

	
	pop RAX
	pop RAX
	pop RBP
	ret


STR1_LEN:
	mov R8,[RAX]
	cmp R8,0
	JE ML1
	
	inc RAX
	JMP STR1_LEN


COPY:
	push RBP
	mov RBP,RSP
	
	mov RBX,[RBP+16]	;str2
	mov RAX,[RBP+24]	;str1
	mov RCX,str1
	cmp RAX,RCX
	JL NULL

	mov RCX,[RAX]
	mov [RBX],RCX
	inc RBX
	dec RAX
	push RAX
	push RBX
	call COPY

	CL1:
		leave
		ret


NULL:
	mov R8,0
	mov [RBX],R8
	JMP CL1


CHECK:
	push RBP
	mov RBP,RSP
	
	mov RBX,[RBP+16]	;str2
	mov RAX,[RBP+24]	;str1
	
	mov R8,0
	mov RCX,[RAX]
	cmp RCX,R8
	JE PRINT1

	mov RCX,[RAX]
	mov RDX,[RBX]
	cmp RCX,RDX
	JG PRINT2
	JL PRINT2

	inc RAX
	inc RBX
	push RAX
	push RBX
	call CHECK

	CHL1:
		leave
		ret


PRINT1:
	mov RDI,fmt_print
	mov RSI,msg1
	mov RAX,0
	call printf

	JMP CHL1


PRINT2:
	mov RDI,fmt_print
	mov RSI,msg2
	mov RAX,0
	call printf

	JMP CHL1


