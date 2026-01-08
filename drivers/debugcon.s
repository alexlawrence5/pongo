bits 16

global debugpb

debugpb:
    mov dx, 0xE9
    out dx, al
    ret
