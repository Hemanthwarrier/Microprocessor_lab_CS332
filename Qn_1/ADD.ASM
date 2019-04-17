data segment
message1 db 0ah,0dh,"enter first number,$"
data ends
code segment
assume cs:code,ds:data
start : mov ax,data
mov ds,ax
print message1
int 21h
code ends
end start
