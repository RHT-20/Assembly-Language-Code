;Problem:	Permutation using backtracking.

segment .data

fmt_scn: db "%d",0
fmt_print: db "%d ",0
fmt_nl: db "",10,0
n: dq 0

segment .bss
arry resq 1000
mark resq 1000

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
	call PERMUTE
	
	pop RAX
	pop RBP
	ret


PERMUTE:
	push RBP
	mov RBP,RSP

	mov RAX,[RBP+16]
	mov RBX,[n]
	cmp RAX,RBX
	JG PL11

	JMP PL21

	PL3:
		leave
		ret


PL11:
	mov RAX,1
	
	PL12:
		mov RBX,[n]
		cmp RAX,RBX
		JG PL13

		mov R8,8
		imul R8,RAX
		mov RBX,arry
		add RBX,R8
		
		push RAX
		mov RDI,fmt_print
		mov RSI,[RBX]
		mov RAX,0
		call printf
		pop RAX
	
		inc RAX
		JMP PL12

	PL13:
		mov RDI,fmt_nl
		mov RAX,0
		call printf
		
	JMP PL3


PL21:
	mov RAX,1

	PL22:
		mov RBX,[n]
		cmp RAX,RBX
		JG PL3
		
		mov R8,8
		imul R8,RAX
		mov RBX,mark
		add RBX,R8
		mov RBX,[RBX]
		mov R8,1
		inc RAX
		cmp RBX,R8
		JE PL22
		dec RAX

		mov RBX,[RBP+16]
		mov R8,8
		imul RBX,R8
		mov RCX,arry
		add RBX,RCX
		mov [RBX],RAX

		mov R8,8
		imul R8,RAX
		mov RBX,mark
		add RBX,R8
		mov R8,1
		mov [RBX],R8
		
		push RAX
		mov RAX,[RBP+16]
		inc RAX
		push RAX

		call PERMUTE
		pop RAX
		pop RAX

		mov R8,8
		imul R8,RAX
		mov RBX,mark
		add RBX,R8
		mov R8,0
		mov [RBX],R8

		inc RAX

		JMP PL22

	JMP PL3

