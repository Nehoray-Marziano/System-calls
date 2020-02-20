

extern main

section .data
numbers: DB '0123456789',0
my_string: DB '000000000000000',0

section .text
	
global _start
global read
global write
global open
global close
global strlen
global utoa_s
_start:

	;TODO: handles command line input parameters
	pop eax
	mov ebx,esp
	push ebx
	push eax
	call	main
    mov     ebx,eax
	mov	eax,1
	int 0x80


read:
	push ebp
	mov ebp,esp
	mov eax,3 ;the 3 means reading 'mode'
	push ebx
	push ecx
	push edx
	mov ebx,[ebp+8]; this is where the file descriptor is
	mov ecx,[ebp+12]; this is where the pointer buffer is
	mov edx,[ebp+16]; this is where the buffer size is
	int 0x80; the kernel call
	pop edx
	pop ecx
	pop ebx
	jmp finish

write:
	push ebp
	mov ebp,esp
	mov eax,4 ;the 4 means reading 'mode'
	push ebx
	push ecx
	push edx
	mov ebx,[ebp+8]; this is where the file descriptor is
	mov ecx,[ebp+12]; this is where the pointer buffer is
	mov edx,[ebp+16]; this is where the buffer size is
	int 0x80; the kernel call
	pop edx
	pop ecx
	pop ebx
	jmp finish

open:
	push ebp
	mov ebp,esp
	mov eax,5;the 5 means open 'mode'
	push ebx
	push ecx
	mov ebx,[ebp+8]; this is where the file name is
	mov ecx,[ebp+12];which mode: read/write 
	int 0x80; the kernel call
	pop ecx
	pop ebx
	jmp finish

close:
	push ebp
	mov ebp,esp
	mov eax,6; the 6 means close 'mode'
	push ebx
	mov ebx,[ebp+8];this is where the file descriptor is
	int 0x80; the kernel call
	pop ebx
	jmp finish


strlen:	
	funcA:
	push	ebp
	mov	ebp, esp
	;push ebx
	mov	eax,-1

	.L2:
	add eax, 1
	mov ebx, eax
	add ebx, [ebp+8]
	movzx	ebx, BYTE [ebx]
	test bl,bl
	jne .L2
	;pop ebx
	mov esp, ebp
	pop ebp
	ret

utoa_s:
    push    ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
 
    mov eax,[ebp+8] ;the int input is in ecx
    mov ecx,my_string
 
    add ecx,15
    ;mov BYTE [ecx],0 ;put 0 at the last place
    mov edx,0
    mov ebx, 10
 
Loop:
    mov esi,numbers
    dec ecx
    mov edx,0
    div ebx ;divieds eax by ebx
    add esi,edx
    mov edx,0
    mov dl,[esi]
    mov BYTE [ecx],dl
    test eax,eax ;set ZF to 1 if eax == 0
    jne Loop ;jump if ZF != 1
    mov eax,ecx
 
 
    pop edx
    pop ecx
    pop ebx
 
    jmp finish
 
 
finish:
    mov esp, ebp
    pop ebp
    ret


