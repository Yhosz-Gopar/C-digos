segment .data
arre db 0,0
len equ $-arre

arre2 db 0,0
len2 equ $-arre2

ln db 10,13
lenln equ $-ln

msg db "ingresa un numero FELIZ =)",0xA
lenm equ $-msg

msg2 db " ",0xA
lenm2 equ $-msg2

segment .bss
  dato resb 1
  num1 resb 1
  num2 resb 1
  resultado resb 1

segment .text
global _start
_start:

mov eax, 4
mov ebx, 0
mov ecx, msg
mov edx, lenm
int 80h

mov esi,arre
mov edi,0

mov eax,3
mov ebx,0
mov ecx,dato
mov edx,2
int 0x80

mov al,[dato+edi]
sub al,'0'
mov [esi+edi],al
add edi,1

mov al,[dato+edi]
sub al,'0'
mov [esi+edi],al

mov ebp, arre
mov edi,0

elevar:
;obtenemos el valor 1 y lo elevamos
mov al, [ebp+edi]
mul al

;add al, '0'
;el resultado del cuadrado se guarda en num1
mov [num1], al
add edi,1

;obteneos el valor 2 y lo elevamos
mov al, [ebp+edi]
mul al

;el resultado del cuadrado se guarda en num2
mov [num2], al

;se realiza la suma
mov eax, [num1]
mov ebx, [num2]
add eax, ebx

mov [resultado], eax

mov ah,0
;comparacion de salida
mov al, [resultado]
cmp al,1
je salir

mov dl, 10
div dl

mov [arre2+0], al

mov [arre2+1], ah

mov ebp, arre2
mov edi,0

impresion:
mov al, [ebp+edi]
add al, '0'
mov [dato], al
add edi,1

mov eax, 4
mov ebx, 0
mov ecx, dato
mov edx, 1
int 80h 

cmp edi,len
jb impresion

mov eax, 4
mov ebx, 0
mov ecx, msg2
mov edx, lenm2
int 80h

mov ebp, arre2
mov edi,0

salir:
mov eax, 1
xor ebx, ebx
int 0x80