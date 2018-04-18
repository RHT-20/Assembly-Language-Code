;Problem:
;	Find the sum of the following series using recursion:
;	2+3+5+8+12+....+n

segment .data

fmt_scn: db "%d",0
fmt_prnt: db "Sum = %d",10,0
n: dq 0
sum: dq 0

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
	mov RBX,2
	mov RCX,1
	push RAX	;n
	push RBX	;cur
	push RCX	;c

	call REC
	
	mov RDI,fmt_prnt
	mov RSI,[sum]
	mov RAX,0
	call printf
	
	pop RCX
	pop RBX
	pop RAX
	
	pop RBP
	ret

REC:
	push RBP
	mov RBP,RSP

	mov RAX,[RBP+24]	;cur
	mov RBX,[RBP+32]	;n
	cmp RAX,RBX
	JG EXIT_REC
	
	mov RBX,RAX
	mov RAX,[sum]
	add RAX,RBX
	mov [sum],RAX

	mov RDX,[RBP+32]
	mov RAX,[RBP+16]
	add RBX,RAX
	inc RAX
	push RDX
	push RBX
	push RAX

	call REC
	
EXIT_REC:
	leave
	ret

