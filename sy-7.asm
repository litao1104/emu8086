assume cs:code

data segment
db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
db '1993', '1994', '1995'

dd 16,     22,     382,    1356,    2390,    8000,    16000,   24486, 50065,   97479, 
dd 140417, 197514, 345980, 590827, 803530, 1183000, 1843000, 2795000, 3753000, 4649000, 5937000

dw 3,    7,    9,    13,   28,   38,   130,  220,   476,   778
dw 1001, 1442, 2258, 2793, 4037, 5635, 8226, 11542, 14430, 15257, 17800
data ends

table segment
db 21 dup ('year summ ne ?? ')
table ends

code segment
start:

    mov ax, data
    mov ds, ax

    mov ax, table
    mov es, ax

    mov cx, 21 ;行的外层循环
    mov bx, 0
    mov bp, 0

s:
    push cx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov cx, 4
    mov si, 0

s0:
    ;mov es:[bx].0[si], ds:[bp+si]
    mov al, [bx][si]
    mov es:[bp].0[si], al
    inc si
    loop s0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    add bp, 16
    add bx, 4
    pop cx
    loop s

    mov ax, 4c00h
    int 21h

code ends
end start
