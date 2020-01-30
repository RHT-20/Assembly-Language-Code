segment .data

fmt_in: db "%s",0
fmt_out: dq "The String is: %s", 10, 0
fmt_out2: dq "Vowels: %lld, Consonants: %lld", 10, 0

cnt: dq 0
tmp: dq 0
vowel: dq 0
consonant: dq 0

segment .bss
str: resb 100

segment .text
global main
extern scanf,printf,gets

main:
	push RBP
	mov RDI, fmt_in
	mov RSI, str
	mov RAX, 0
	call scanf

	mov RAX, 0
	mov RBX, 0
	mov RCX, 0

	scan_str:
		cmp byte[str + RCX], 0
		JZ print
		mov [cnt], RCX
		mov RAX, 0
		mov AL, [str + RCX]
		mov [tmp], RAX
		mov RAX, qword[tmp]

		mov RBX, 65
		cmp RAX, RBX
		JE inc_vowel
		
		mov RBX, 69
		cmp RAX, RBX
		JE inc_vowel
	
		mov RBX, 73
		cmp RAX, RBX
		JE inc_vowel
	
		mov RBX, 79
		cmp RAX, RBX
		JE inc_vowel
	
		mov RBX, 85
		cmp RAX, RBX
		JE inc_vowel

		JMP inc_consonant

	inc_vowel:
		inc qword[vowel]
		mov RCX, [cnt]
		inc RCX
		JMP scan_str

	inc_consonant:
		inc qword[consonant]
		mov RCX, [cnt]
		inc RCX
		JMP scan_str

	print:
		mov RDI, fmt_out
		mov RSI, str
		mov RAX, 0
		call printf
		mov RDI, fmt_out2
		mov RSI, [vowel]
		mov RDX, [consonant]
		call printf

	exit:
		pop RBP
		ret
