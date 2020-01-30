segment .data

fmt_in: db "%d",0
fmt_sp: db " ",0
fmt_str: db "*",0
fmt_nl: db "",10,0
n: dq 0

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt_in
	mov RSI,n
	mov RAX,0
	call scanf
	mov RAX,[n]
	
	mov RCX,RAX
	dec RCX
	add RCX,RAX
	push RCX
	mov RCX,RAX
	dec RCX
	
	l1:
		push RAX
		push RCX
		mov RDI,fmt_sp
		mov RAX,0
		call printf
		pop RCX
		pop RAX
		dec RCX
		cmp RCX,0
		JG l1
	
	push RAX
	mov RDI,fmt_str
	mov RAX,0
	call printf
	pop RAX
	
	push RAX
	mov RDI,fmt_nl
	mov RAX,0
	call printf
	pop RAX
	
	dec RAX
	mov RCX,RAX
	dec RAX
	dec RCX
	mov RDX,1
	
	l2:
		push RAX
		push RCX
		push RDX
		
		l3:
			push RCX
			mov RDI,fmt_sp
			mov RAX,0
			call printf
			pop RCX
			dec RCX
			cmp RCX,0
			JG l3
		
		mov RDI,fmt_str
		mov RAX,0
		call printf
		
		pop RDX
		mov RCX,RDX
		add RDX,2
		push RDX
		
		l4:
			push RCX
			mov RDI,fmt_sp
			mov RAX,0
			call printf
			pop RCX
			dec RCX
			cmp RCX,0
			JG l4
			
		mov RDI,fmt_str
		mov RAX,0
		call printf
		
		mov RDI,fmt_nl
		mov RAX,0
		call printf
		
		pop RDX
		pop RCX
		pop RAX
		
		dec RAX
		dec RCX
		
		cmp RAX,0
		JG l2
		
	pop RAX
	l5:
		push RAX
		mov RDI,fmt_str
		mov RAX,0
		call printf
		pop RAX
		dec RAX
		cmp RAX,0
		JG l5
		
	mov RDI,fmt_nl
	mov RAX,0
	call printf
		
	exit:
		pop RBP
		ret
		
