;Problem:	Use recursion to search an element in a sorted array using binary search.

segment .data

fmt_scn: db "%lld",0
fmt_print: db "%lld",10,0
fmt_pf: db "index = %lld",10,0
fmt_str: db "%s",10,0
msg: db "NOT FOUND",0
n: dq 0
x: dq 0

segment .bss
arry resq 1000

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt_scn
	mov RSI,n
	mov RAX,0
	call scanf

	mov RAX,1
	push RAX
	JMP INPUT
	pop RAX
	
	L1:
		mov RDI,fmt_scn
		mov RSI,x
		mov RAX,0
		call scanf

		;mov RAX,1
		;push RAX
		;JMP PRINT
		;pop RAX

	L2:
		mov RAX,1
		push RAX
		mov RAX,[n]
		push RAX
		call BINARY_SEARCH


EXIT:
	pop RAX
	pop RAX
	pop RBP
	ret


INPUT:
	pop RAX
	mov RBX,[n]
	cmp RAX,RBX
	JG L1

	inc RAX
	push RAX
	dec RAX

	mov R8,8
	imul RAX,R8
	mov RBX,arry
	add RAX,RBX

	mov RDI,fmt_scn
	mov RSI,RAX
	mov RAX,0
	call scanf

	JMP INPUT


PRINT:
	pop RAX
	mov RBX,[n]
	cmp RAX,RBX
	JG L2

	inc RAX
	push RAX
	dec RAX

	mov R8,8
	imul RAX,R8
	mov RBX,arry
	add RAX,RBX

	mov RDI,fmt_print
	mov RSI,[RAX]
	mov RAX,0
	call printf

	JMP PRINT


BINARY_SEARCH:
	push RBP
	mov RBP,RSP
	
	JMP CHECK_LIMIT

	BS_L1:
		mov RAX,[RBP+24]
		mov RBX,[RBP+16]
		add RAX,RBX
		mov RDX,0
		mov RBX,2
		div RBX

		JMP CHECK_VAL

	BS_L2:
		call BINARY_SEARCH

	BS_L3:
		leave
		ret


CHECK_LIMIT:
	mov RAX,[RBP+24]
	mov RBX,[RBP+16]
	cmp RAX,RBX
	JG NOT_FOUND
	
	JMP BS_L1


CHECK_VAL:
	push RAX
	mov RBX,arry
	mov R8,8
	imul RAX,R8
	add RAX,RBX
	mov RAX,[RAX]
	mov RBX,[x]

	cmp RAX,RBX
	JE FOUND

	cmp RAX,RBX
	JL MOVE_RIGHT
	
	JMP MOVE_LEFT


NOT_FOUND:
	mov RDI,fmt_str
	mov RSI,msg
	mov RAX,0
	call printf	

	JMP BS_L3


FOUND:
	pop RAX
	mov RDI,fmt_pf
	mov RSI,RAX
	mov RAX,0
	call printf
	
	JMP BS_L3


MOVE_RIGHT:
	pop RAX
	inc RAX
	push RAX
	mov RAX,[RBP+16]
	push RAX

	JMP BS_L2


MOVE_LEFT:
	pop RBX
	dec RBX
	mov RAX,[RBP+24]
	push RAX
	push RBX

	JMP BS_L2

