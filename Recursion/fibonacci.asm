;Problem:	Use recursion to find the nth fibonacci series element.

segment .data

fmt_scn: db "%lld",0
fmt_prnt: db "ans = %lld",10,0

n: dq 0
a: dq 0
b: dq 1
ans: dq 0

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt_scn
	mov RSI,n
	mov RAX,0
	call scanf
	
	mov RAX,[n]
	push RAX	;n
	
	call FIB
	
	mov RDI,fmt_prnt
	mov RSI,[ans]
	mov RAX,0
	call printf

	pop RAX	
	pop RBP
	ret

FIB:
	push RBP
	mov RBP,RSP

	mov RAX,[RBP+16]	;n
	cmp RAX,2
	JLE BASE
	
	dec RAX
	push RAX
	call FIB
	
	mov RAX,[a]
	mov RBX,[b]
	add RAX,RBX
	mov [a],RBX
	mov [b],RAX
	mov [ans],RAX

EXIT_FIB:
	leave
	ret

BASE:
	mov RAX,[a]
	mov RBX,[b]
	add RAX,RBX
	mov [a],RBX
	mov [b],RAX
	mov [ans],RAX
	
	JMP EXIT_FIB


