;program to add two numbers
.model small
.stack 100h
.data
.code
main proc
mov bl,1
add bl,48
mov cl,2
add bl,cl
mov dl,bl
mov ah,2
int 21h
mov ah,4ch
int 21h
main endp
end main