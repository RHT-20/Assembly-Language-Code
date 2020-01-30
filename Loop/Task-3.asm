segment .data

fmt_in: db "%lld",0
fmt_out: db "%lld ",10,0
fmt_out2: dq "The 10 numbers are : ",10,0
fmt_found: dq "Number already exists. Give %lld more numbers",10,0
fmt_not_found: dq "Give %lld more numbers",10,0
fmt_nl: dq "",10,0

val: dq 0
cnt: dq 0
req: dq 10

segment .bss
arry: resq 10

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RAX,0
	mov RBX,0
	mov RCX,0

	in:
		cmp RCX,10
		jz end
		mov [cnt],RCX

		mov RAX,0
		mov RBX,0
		mov RDI,fmt_in
		mov RSI,val
		call scanf
		jmp compare
	
	done:
		mov RCX,[cnt]
		jmp in

	compare:
		mov RAX, 0
		mov RBX, 0
		mov RCX, 0
	
		L1:
			cmp RCX, [cnt]
			jz not_found
			mov RAX,[array + RCX*8]
			cmp RAX,[val]
			jz found
			inc RCX
			jmp L1
	
		not_found:
			mov RCX, [cnt]
			mov RAX, [val]
			mov [arry + RCX*8], RAX
			dec qword[req]
			inc RCX
			mov [cnt], RCX
			mov RCX, [req]
			cmp RCX, 0
			jz finish
			mov RDI, fmt_not_found
			mov RSI, [req]
			call printf
			mov RDI, fmt_nl
			call printf
			jmp done

		found:
			mov RDI, fmt_found
			mov RSI, [req]
			call printf

		jmp done

	finish:
		mov RDI,fmt_out2
		call printf
		mov RAX, 0
		mov RBX, 0
		mov RCX, 0

	prnt:
		cmp RCX, 10
		jz exit
		mov [cnt], RCX
		mov RDI, fmt_out
		mov RSI, [array + RCX*8]
		call printf
		mov RCX, [cnt]
		inc RCX
		jmp prnt

	exit:
		mov RDI,fmt_nl
		mov RAX,0
		call printf
	
		pop RBP
		ret