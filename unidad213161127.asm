SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data
msg1 db "La Conjetura de Collatz es: ", 0xA,0xD
len1 equ $ - msg1
	msg2 db " ",0xA,0xD
	len2 equ $ - msg2

segment .bss
	num1 resb 2

section  .text
	global _start 
_start:  ;tell linker entry point

	mov esi, 6 ; se define el numero que se hara la conjetura

	add esi, '0'
	mov [num1], esi
	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, num1
	mov edx, 2
	int 0x80

	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80
	sub esi, '0'

	while:
		mov eax, esi
		cmp eax, 1
		je salir

		mov eax, esi
		mov edi, 2
		mov edx, 0
		div edi
		cmp edx, 0

		je par

		mov eax, esi
		mov ebx, 3
		mul ebx
		inc eax
		mov esi, eax
          jmp imprime

	par:
		mov eax, esi
		mov edi, 2
		mov edx, 0
		div edi
		mov esi, eax
		jmp imprime

	imprime:
		add esi, '0'
		mov [num1], esi
		mov eax, SYS_PRINT
		mov ebx, STDOUT
		mov ecx, num1
		mov edx, 1
		int 0x80

		mov eax, SYS_PRINT
		mov ebx, STDOUT
		mov ecx, msg2
		mov edx, len2
		int 0x80
		sub esi, '0'
		jmp while

salir:
	mov eax, SYS_SALIDA
	xor ebx, ebx  
	int 0x80