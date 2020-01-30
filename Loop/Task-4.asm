segment .data

fmt_in: db "%s",0
fmt_equal: dq "Equal", 10, 0
fmt_not_equal: dq "Not Equal", 10, 0
fmt_nl: dq "",10,0

sz1: dq 0
sz2: dq 0
cnt: dq 0

segment .bss
str1: resq 100
str2: resq 100

segment .text
global main
extern scanf,printf,gets

main:
	push RBP
	mov RDI,fmt_in
	mov RSI,str1
	mov RAX,0
	call scanf

	mov RDI,fmt_in
	mov RSI,str2
	mov RAX,0
	call scanf	

	mov RAX, 0
	mov RCX, 0

	str1_size:
		cmp qword[str1 + RCX], 0
		JZ str1_ok
		inc qword[sz1]
		inc RCX
		JMP str1_size

	str1_ok:
		mov RAX, 0
		mov RCX, 0

	str2_size:
		cmp qword[str2 + RCX], 0
		JZ done
		inc RAX
		cmp RAX, [sz1]
		JG not_equal
		inc RCX
		mov [sz2], RCX
		JMP str2_size

	done:
		cmp RCX, [sz1]
		JNE not_equal
		mov RAX, 0
		mov RBX, 0
		mov RCX, 0

	compare:
		cmp qword[str1 + RCX], 0
		JZ equal
		mov [cnt], RCX
		mov RAX, 0
		mov AL, [str1 + RCX]
		mov RBX, 0
		mov BL, [str2 + RCX]
		cmp RAX, RBX
		JNE not_equal
		mov RCX, [cnt]
		inc RCX
		JMP compare

	equal:
		mov RDI, fmt_equal
		mov RAX,0
		call printf 
		JMP exit

	not_equal:
		mov RDI, fmt_not_equal
		mov RAX,0
		call printf

	exit:
		pop RBP
		ret	