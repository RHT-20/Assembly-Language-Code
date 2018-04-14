segment .data

fmt_scn: db "%lld",0
fmt_print: db "~ %lld = %lld",10,0
x: dq 0

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt_scn
	mov RSI,x
	mov RAX,0
	call scanf

	mov RSI,[x]
	mov RDX,[x]
	neg RDX

	mov RDI,fmt_print
	mov RAX,0
	call printf
	
	pop RBP
	ret

