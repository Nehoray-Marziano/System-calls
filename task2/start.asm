extern printf

section .data
   bufsize dw      1024
   first   db      '-'
   second  db      'w'
   space   db      ' '
   counter dd      0
   zerobyte db     '0'
   format db       "There are %d words in the file.",10,0

section .bss
   buf     resb    1024

section  .text              ; declaring our .text segment
  global  _start            ; telling where program execution should start

_start:                     ; this is where code starts getting executed

  ; get the filename in ebx
    mov   ebp,esp           ;for later use (function arguments)
    pop   ebx               ; argc is on top
    pop   ebx               ; argv[0] comes after that
    mov   ebx,[ebp+12]               ; the second real argument, the 'filename'
    mov   esi,[ebp+8]      ; the first argument,  maybe '-w'

  ; open the file
    mov   eax,  5           ; open([the open 'function' and its parameters]
    mov   ecx,  0           ;   read-only mode
    int   80h               ; );

  ; read the file
    mov     eax,  3         ; read( [the read 'function' and its parameters]
    mov     ebx,  eax       ;   file_descriptor,
    mov     ecx,  buf       ;   *buf,
    mov     edx,  bufsize   ;   *bufsize
    int     80h             ; );

.checkIfFirst:
    cmp BYTE [esi], '-' ;chack the first letter
    jne .2a_print
    jmp .checkIfSecond
    

.checkIfSecond:
  inc esi
  cmp BYTE [esi], 'w' ;check the second letter
  jne .2a_print
  jmp .2bloop


.2bloop: ;if -w flag was passed
  mov ecx, buf ; a pointer to the beggining of the buffer
  dec ecx ; we decrease it because we emmidiately increase it back inside the loop 
  mov esi,0
  .loop:
    inc ecx
    cmp BYTE [ecx], 0  ;meaning we reached the end of the string
    je .2b_print
    cmp BYTE [ecx], ' ' ;meaning a full word
    jne .loop ;go to the next char if it is not a space
    inc dword [counter] ; we reached the end of a word!
    jmp .loop



.2a_print:
  ; print to the console
    mov     eax,  4         ; write(
    mov     ebx,  1         ;   STDOUT,
  ; mov     ecx,  buf       ;   *buf
    int     80h             ; );
    jmp .out

.2b_print:
  ; print to the console
    ; print to the console
    inc dword[counter]
    
    push dword [counter]
    push format
    call printf
    add esp,8

  ; exit
.out:
    mov   eax,  1           ; exit(
    mov   ebx,  0           ;   0
    int   80h   


