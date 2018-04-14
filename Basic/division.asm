segment .data

fmt_scn: db "%lld",0
fmt_print1: db "%lld / %lld = %lld",10,0
fmt_print2: db "%lld %% %lld = %lld",10,0
x: dq 0
y: dq 0

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt_scn
	mov RSI,x
	mov RAX,0
	call scanf

	mov RDI,fmt_scn
	mov RSI,y
	mov RAX,0
	call scanf

	mov RDX,qword(0)
	mov RAX,[x]
	mov RBX,[y]
	div RBX
	
	mov RSI,[x]
	push RDX
	mov RDX,[y]
	mov RCX,RAX

	mov RDI,fmt_print1
	mov RAX,0
	call printf

	mov RSI,[x]
	mov RDX,[y]
	pop RCX

	mov RDI,fmt_print2
	mov RAX,0
	call printf
	
	pop RBP
	ret

