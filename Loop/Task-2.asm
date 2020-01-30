segment .data

fmt_in: db "%s",0
fmt_out: db "%s",10,0
fmt_pal: db "Palindrome",10,0
fmt_not_pal: db "Not Palindrome",10,0
out: db "%c",10,0
sz: dq 0
temp: dq 0

segment .bss
str: resq 100

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt_in
	mov RSI,str
	mov RAX,0
	call scanf
	
	l1:
		mov RAX,0
		mov RCX,0
		JMP lower
	
	l2:
		mov RAX,0
		mov RCX,0
		str_size
		
	l3:
		mov RAX,0
		mov RBX,[sz]
		mov RCX,0
		dex RBX
		JMP compare
	
	exit:
		pop RBP
		ret
	
	print:
		mov RSI,[RAX]
		cmp RSI,0
		JE l1
		
		push RAX
		mov RDI,out
		mov RAX,0
		call printf
		pop RAX
		add RAX,1
		JMP print
				
	lower:
		cmp qword[str+RCX],0
		JZ l2
		
		mov RAX,0
		mov AL,[str+RCX]
		cmp RAX,97
		JL process

		DO:
			inc RCX
			JMP lower
		
	process:
		mov RAX,0
		mov AL,[str+RCX]
		add RAX,32d
		mov [str+RCX],RAX
		JMP DO		

	str_size:
		cmp qword[str+RCX],0
		JZ l3
		inc qword[sz]
		inc RCX
		JMP str_size
	
	compare:
		cmp qword[str+RCX],0
		JZ pal
		mov [temp],RCX
		mov RAX,0
		mov AL,[str+RCX]
		mov RDX,0
		mov DL,[str+RBX]
		cmp RAX,RDX
		JNZ not_pal
		mov RCX,[temp]
		inc RCX
		dec RBX
		JMP compare

	pal:
		mov RDI,fmt_pal
		call printf
		JMP exit
	
	not_pal:
		mov RDI,fmt_not_pal
		call printf
		JMP exit
