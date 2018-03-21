SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data

	msg1 db  0xA,0xD,"el resultado de S(4+3x-3x^2)es: "
	len1 equ $- msg1

segment .bss
	res resb 1
    aux1 resb 1

section  .text
	global _start  ;must be declared for using gcc
_start:  ;tell linker entry point

    mov eax, 2
    mov edx, 2
    mov ecx, 3

    mul edx ;se hace la multiplicacion de 2x2 =4
    mul ecx ; del resultado se le multiplica 3, osea 4x3=12

    mov ecx, 2
    div ecx ; ahora se divide 12/2 = 6

    mov ebx, eax
    mov eax, 4
    mov edx, 2

    mul edx

    add eax, ebx

    mov [aux1], eax

    mov eax, 2
    mov ebx, 2
    mov ecx, 2

    mul ebx
    mul ecx

    mov ebx, [aux1]
    
    sub ebx, eax
    
    add ebx, 48
	mov [res], ebx
	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80

	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, res
	mov edx, 1
	int 0x80


salir:
	mov eax, SYS_SALIDA
	xor ebx, ebx
	int 0x80