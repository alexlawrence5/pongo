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

msg db 'BMCALL TRIGGERED BY THE SYSTEM!', 0

times 510-($-$$) db 0
dw 0xAA55
