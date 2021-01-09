assume cs:code

data segment
    db 10 dup (0)
data ends

code segment

start:
    mov ax, 12666
    mov bx, data
    mov ds, bx
    mov si, 0
    call dtoc

    mov dh, 8
    mov dl, 3
    mov cl, 2
    call show_str

    mov ax, 4C00H
    int 21H

dtoc:
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    mov si, 0
    mov di, 0  ;di用于记录字符个数
    mov bx, 10 ;除数是10

dtoc1:
    mov dx, 0
    div bx
    add dx, 30H ;dx是余数，加30H是数字对应的ascii码
    push dx     ;当前字符入栈
    inc di      ;字符个数+1
    mov cx, ax  ;商赋值给cx
    jcxz dtoc2  ;如果商即cx不为0，则跳出dtoc1循环
    jmp dtoc1   ;继续循环dtoc1

dtoc2:
    mov cx, di

dtoc3:
    pop dx
    mov [si], dl
    inc si
    loop dtoc3
    mov dl, 0
    mov [si], dl

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret

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