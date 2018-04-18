;Problem:
;	Find the sum of the following series using recursion:
;	2+3+5+8+12+....+n

segment .data

fmt_scn: db "%d",0
fmt_prnt: db "Sum = %d",10,0
n: dq 0
sum: dq 0
c: dq 1
cur: dq 2

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt_scn
	mov RSI,n
	mov RAX,0
	call scanf

	call REC
	
	mov RDI,fmt_prnt
	mov RSI,[sum]
	mov RAX,0
	call printf
	
	pop RBP
	ret

REC:
	push RBP
	mov RBP,RSI

	mov RAX,[cur]
	mov RBX,[n]
	cmp RAX,RBX
	JG EXIT_REC
	
	mov RBX,RAX
	mov RAX,[sum]
	add RAX,RBX
	mov [sum],RAX

	mov RAX,[c]
	add RBX,RAX
	mov [cur],RBX
	inc RAX
	mov [c],RAX

	call REC
	
EXIT_REC:
	pop RBP
	ret

