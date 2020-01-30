segment .data

fmt1: db "%d",0
fmt2: db "First odd value = %d",10,0
fmt3: db "Second odd value = %d",10,0

segment .bss
arry: resq 10

segment .text
extern scanf,printf
global main

main:
	push RBP
	mov RDI,fmt1
	mov RSI,0
	mov RAX,arry
	mov RCX,0
	
	scn:
		push RAX
		push RCX
		mov RDI,fmt1
		mov RSI,RAX
		mov RAX,0
		call scanf
		pop RCX
		pop RAX
		add RAX,8
		inc RCX
		cmp RCX,10
		JL scn
		
	mov RAX,arry
	mov RCX,0
	
	frst:
		mov RDX,1
		mov RSI,[RAX]
		TEST RSI,RDX
		JNZ p1
		add RAX,8
		inc RCX
		cmp RCX,10
		JL frst
	
	process:
		mov RAX,arry
		mov RDX,8
		imul RDX,9
		add RAX,RDX
		mov RCX,0
	
	scnd:
		mov RDX,1
		mov RSI,[RAX]
		TEST RSI,RDX
		JNZ p2
		sub RAX,8
		inc RCX
		cmp RCX,10
		JL scnd
	
	exit:
		pop RBP
		ret
	
	p1:
		mov RDI,fmt2
		mov RSI,[RAX]
		mov RAX,0
		call printf
		JMP process
		
	p2:
		mov RDI,fmt3
		mov RSI,[RAX]
		mov RAX,0
		call printf
		JMP exit
