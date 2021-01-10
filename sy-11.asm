assume cs:codesg

datasg segment
    db "Beginner's All-purpose Symbolic Instruction Code.", 0
datasg ends

codesg segment

begin:
    mov ax, datasg
    mov ds, ax
    mov si, 0
    call letterc

    mov ax, 4C00H
    int 21H

letterc:

    cmp byte ptr [si], 0
    je finish

    cmp byte ptr [si], 'a'
    jb next

    cmp byte ptr [si], 'z'
    ja next

    and byte ptr [si], 11011111B

next:
    inc si
    jmp letterc

finish:
    ret

codesg ends

end begin