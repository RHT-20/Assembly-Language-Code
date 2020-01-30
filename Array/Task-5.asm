segment .data

fmt_in: db "%lld",0
fmt_out: db "%lld",10,0
fmt_max: dq "The largest number at index %lld is: %lld", 10, 0
fmt_min: dq "The smallest number at index %lld is: %lld", 10, 0

mx: dq 0
mn: dq 0
cnt: dq 0

segment .bss
arry1: resq 100
arry2: resq 100

segment .text
global main
extern scanf,printf,gets

main:
	push RBP
	mov RSI,0
	mov RAX,arry1
	mov RBX,arry2
	mov RCX, 0

	in:
		cmp RCX, 5
		JGE end_in
		push RAX
		push RBX
		push RCX
		mov RDI, fmt_in
		mov RSI,RAX
		mov RAX,0
		call scanf
		pop RCX
		pop RBX
		pop RAX
		add RAX,8
		add RBX,8
		inc RCX	
		JMP in
	
	end_in:
		mov RAX, 0
		mov RCX, 0
		mov RBX, 0

	l_out:
		cmp RCX, 5
		JGE end_l_out
		mov [cnt], RCX
		mov RAX, [arry1+RCX*8]

	l_in:
		inc RCX
		cmp RCX, 5
		JGE end_l_in
		cmp RAX, [arry1+RCX*8]
		JLE l_in
		XCHG RAX, [arry1+RCX*8]
		JMP l_in

	end_l_in:
		mov RCX, [cnt]
		mov [arry1+RCX*8], RAX
		inc RCX
		JMP l_out

	end_l_out:
		mov RCX, 0
		mov RAX, [arry1+RCX*8]
		mov [mn], RAX

		mov RCX, 4
		mov RAX, [arry1+RCX*8]
		mov [mx], RAX
	
		mov RCX, 0
		mov RAX, 0
		mov RBX, 0

	find_mx:
		cmp RCX, 5
		mov [cnt], RCX
		jGE print_mx
		mov RAX, [mx]
		mov RBX, [arry2+RCX*8]
		cmp RAX, RBX
		JE print_mx
		mov RCX, [cnt]
		inc RCX
		JMP find_mx

	print_mx:
		mov RAX, [mx]
		mov RDI, fmt_max
		mov RSI, RCX
		mov RDX, RAX
		call printf
		mov RCX, 0
		mov RAX, 0
		mov RBX, 0

	find_mn:
		cmp RCX, 5
		mov [cnt], RCX	
		JGE print_mn
		mov RAX, [mn]
		mov RBX, [arry2+RCX*8]
		cmp RAX, RBX
		JE print_mn
		mov RCX, [cnt]
		inc RCX
		JMP find_mn

	print_mn:
		mov RAX, [mn]
		mov RDI, fmt_min
		mov RSI, RCX
		mov RDX, RAX
		call printf
	exit:
		pop RBP
		ret	