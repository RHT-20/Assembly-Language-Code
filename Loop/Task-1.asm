segment .data

fmt_in: db "%d",0
fmt_out: db "%d ",0
fmt_dif: db "Difference = %d",10,0
fmt_nl: db "",10,0

n: dq 0
m: dq 0
sz: dq 0
odd: dq 0
even: dq 0

segment .text
global main
extern scanf,printf

main:
	push RBP
	
	frst:
		mov RDI,fmt_in
		mov RSI,n
		mov RAX,0
		call scanf
		mov RAX,[n]
	
		cmp RAX,1
		JE one
	
	scnd:
		push RAX
	
		mov RDI,fmt_in
		mov RSI,m
		mov RAX,0
		call scanf
		pop RAX
		mov RBX,[m]
		push RAX
		push RBX
	
	l1:
		pop RBX
		pop RAX
		
		cmp RAX,RBX
		JG exit
		
		mov RCX,RAX
		inc RAX
		push RAX
		push RBX
		
		mov RAX,2
		mov RDX,RCX
		push RAX
		push RDX
		
		l2:
			pop RDX
			pop RAX
			
			cmp RAX,RDX
			JE prime
			
			inc RAX
			push RAX
			push RDX
			dec RAX
			
			mov RBX,RDX
			mov RDX,0
			XCHG RAX,RBX
			idiv RBX
			cmp RDX,0
			JE not_prime
			
			JMP l2
	
	exit:
		mov RDI,fmt_nl
		mov RAX,0
		call printf
		
		mov RAX,odd
		mov RBX,even
		mov RCX,[RAX]
		mov RDX,[RBX]
		
		sub RDX,RCX
		mov RDI,fmt_dif
		mov RSI,RDX
		mov RAX,0
		call printf
		pop RBP
		ret
		
	one:
		inc RAX
		JMP scnd
		
	prime:
		push RDX
		mov RDI,fmt_out
		mov RSI,RDX
		mov RAX,0
		call printf
		pop RDX
		mov RAX,sz
		mov RBX,[RAX]
		inc RBX
		mov [RAX],RBX
		TEST RBX,1
		JZ	even_sum
		JMP odd_sum
		
	not_prime:
		pop RDX
		pop RAX	
		
		JMP l1
		
	odd_sum:
		mov RAX,odd
		mov RBX,[RAX]
		add RBX,RDX
		mov [RAX],RBX
		JMP l1
		
	even_sum:
		mov RAX,even
		mov RBX,[RAX]
		add RBX,RDX
		mov [RAX],RBX
		JMP l1
		
