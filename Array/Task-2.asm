segment .data

fmt1: db "%d",0
fmt2: db "value = %d",10,0
x: dq 0

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
		add RDX,[RAX]
		add RAX,8
		inc RCX
		cmp RCX,10
		JL scn
		
	mov RDI,fmt1
	mov RSI,x
	mov RAX,0
	call scanf
	mov RDX,[x]
	
	mov RDI,fmt2
	mov RAX,arry
	mov RBX,8
	imul RBX,RDX
	add RAX,RBX
	mov RSI,[RAX]
	mov RAX,0
	call printf
	
	pop RBP
	ret