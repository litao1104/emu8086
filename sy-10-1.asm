assume cs:code

data segment
    db 'welcome to masm!', 0
data ends

code segment

start:
    mov dh, 8 ;line8
    mov dl, 3 ;col 3 
    mov cl, 2 ;green

    mov ax, data
    mov ds, ax
    mov si, 0
    call show_str

    mov ax, 4c00h
    int 21h

show_str:
    push cx
    push dx

    mov al, 160
    mul dh
    mov bx, ax

    mov al, 2
    dec dl
    mul dl
    mov di, ax

    mov ax, 0b800h
    mov es, ax     ;设置现存地址，用es段寄存器

    mov ah, cl
display:
    mov cl, ds:[si]
    mov ch, 0
    jcxz ok

    mov al, ds:[si]
    mov es:[bx][di], al
    mov es:[bx][di+1], ah

    add si, 1
    add di, 2

    jmp short display

ok:
    pop dx
    pop cx
    ret

code ends

end start