;Problem:	Use recursion to find the GCD of two given numbers.

segment .data

fmt_scn: db "%lld",0
fmt_print: db "%lld",10,0
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

	mov RAX,[x]
	push RAX
	mov RAX,[y]
	push RAX

	call GCD
	
	pop RAX
	pop RBX
	pop RBP
	ret

GCD:
	push RBP
	mov RBP,RSP
	
	mov RBX,[RBP+16]	;b
	mov RAX,[RBP+24]	;a

	JMP CHECK

	L1:
		mov RDX,0
		div RBX
		push RBX
		push RDX
		call GCD
 
	L2:
		leave 
		ret

	L3:
		mov RDI,fmt_print
		mov RAX,0
		call printf
		leave
		ret

CHECK:
	mov RSI,RBX
	cmp RAX,0
	JE L3
	mov RSI,RAX
	cmp RBX,0
	JE L3
	JMP L1

