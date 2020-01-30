segment .data

fmt1: db "%d",0
fmt2: db "sum = %d",10,0
fmt3: db "value = %d",10,0

segment .bss
arry: resq 20

segment .text
extern scanf,printf
global main

main:
	push RBP
	mov RDI,fmt1
	mov RSI,0
	mov RAX,arry
	mov RCX,0
	mov RDX,0
	
	scn:
		push RAX
		push RCX
		push RDX
		mov RDI,fmt1
		mov RSI,RAX
		mov RAX,0
		call scanf
		pop RDX
		pop RCX
		pop RAX
		add RDX,[RAX]
		add RAX,8
		inc RCX
		cmp RCX,20
		JL scn
		
	mov RDI,fmt2
	mov RSI,RDX
	mov RAX,0
	call printf
	
	mov RAX,arry
	mov RCX,0
	
	prnt:
		push RAX
		push RCX
		mov RDI,fmt3
		mov RSI,[RAX]
		mov RAX,0
		call printf
		pop RCX
		pop RAX
		add RAX,8
		inc RCX
		cmp RCX,20
		JL prnt
		
	pop RBP
	ret