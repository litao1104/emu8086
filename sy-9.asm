assume cs:code

data segment
    db 'welcome to masm!'
data ends

code segment

start:
    mov ax, data
    mov es, ax
    mov si, 0

    mov ax, 0b800h
    mov ds, ax
    mov bx, 720h
    mov di, 0

    mov cx, 16
line1:
    mov al, es:[si]
    mov [bx][di], al

    mov al, 02h
    mov [bx][di+1], al
    
    add si, 1
    add di, 2
    loop line1

    add bx, 160
    mov si, 0
    mov di, 0
    mov cx, 16
line2:
    mov al, es:[si]
    mov [bx][di], al

    mov al, 24h
    mov [bx][di+1], al
    
    add si, 1
    add di, 2
    loop line2

    add bx, 160
    mov si, 0
    mov di, 0
    mov cx, 16
line3:
    mov al, es:[si]
    mov [bx][di], al

    mov al, 71h
    mov [bx][di+1], al
    
    add si, 1
    add di, 2
    loop line3

    mov ax, 4c00h
    int 21h

code ends

end start