bits 16
%include "sdk/osle.inc"

start:
    mov si, msg
print_loop:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp print_loop

done:
    jmp $ 

msg db 'Pongo version: 1.3 Cupcake', 0
