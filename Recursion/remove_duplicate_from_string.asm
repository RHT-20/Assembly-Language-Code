;Problem:
;	Use recursion to remoe the duplicate occurance of characters in a string.
;	ex: input: aacbcba
;		output:	acb


segment .data

fmt_scn: db "%s",0
fmt_print: db "%s",10,0

segment .bss
str1 resb 100
str2 resb 100
mark resq 100

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
	push RAX
	mov RAX,str2
	push RAX
	call FUNC

	mov RDI,fmt_print
	mov RSI,str2
	mov RAX,0
	call printf
	
	pop RAX
	pop RAX
	pop RBP
	ret

FUNC:
	push RBP
	mov RBP,RSP
	
	mov RBX,[RBP+16]
	mov RAX,[RBP+24]

	JMP CHECK_END

	L1:
		JMP CHECK_DUP

	L2:
		add RAX,1
		push RAX
		push RBX
		call FUNC
 
	L3:
		leave
		ret


CHECK_END:
	mov R8,[RAX]
	cmp R8,0
	JE L3
	JMP L1


CHECK_DUP:			;check the index of the character is already marked or not
	mov RCX,0
	mov CL,[RAX]
	sub RCX,97

	mov RDX,mark
	mov R8,8
	imul RCX,R8
	add RDX,RCX
	mov RDX,[RDX]

	cmp RDX,0
	JE ADD
	JMP L2


ADD:				;if the index of the character is not marked then add it to str2 and mark it's index
	mov RCX,0
	mov CL,[RAX]
	mov [RBX],RCX

	sub RCX,97
	mov RDX,mark
	mov R8,8
	imul RCX,R8
	add RDX,RCX
	mov R8,1
	mov [RDX],R8
	add RBX,1

	JMP L2

