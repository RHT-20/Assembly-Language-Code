segment .data

fmt: db "%s",10,0
msg: db "Hello World",0

segment .text
global main
extern scanf,printf

main:
	push RBP
	mov RDI,fmt
	mov RSI,msg
	mov RAX,0
	call printf
	pop RBP
	ret


;nasm -f elf64 hello.asm
;gcc hello.o -o hello
;./hello

