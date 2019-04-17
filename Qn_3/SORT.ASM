.MODEL SMALL
.STACK 64
PRINT MACRO ARG
LEA DX,ARG
MOV AX,0900H
INT 21H
ENDM
DATA SEGMENT
  MSG1 DB 0AH,0DH,"ENTER THE LIMIT:$"
  MSG2 DB 0AH,0DH,"ENTER THE NOS:$"
  MSG3 DB ?,"$"
  MSG4 DB 0AH,0DH,"SORTED LIST:$"
  NUM DB 1 DUP(0)
  ARRAY DB 20 DUP(0)
 DATA ENDS
 CODE SEGMENT
 ASSUME CS:CODE,DS:DATA
 START: MOV AX,DATA
        MOV DS,AX
        PRINT MSG1
        MOV AX,0100H
        INT 21H
        SUB AL,30H
        MOV BL,10
        MUL BL
        MOV BL,AL
        MOV AX,0100H
        INT 21H
        SUB AL,30H
        ADD BL,AL
        MOV NUM,BL
        PRINT MSG2
        LEA SI,ARRAY
        CALL READ
        PRINT MSG4
        CALL SORT
        LEA SI,ARRAY
        CALL DISPLAY
        MOV AH,4CH
        INT 21H
        READ PROC NEAR
        MOV CL,NUM
 READ1: MOV AX,0100H
        INT 21H
        SUB AL,30H
        MOV BL,10
        MUL BL
        MOV BL,AL
        MOV AH,01H
        INT 21H
        SUB AL,30H
        ADD BL,AL
        MOV [SI],BL
        INC SI
        PRINT MSG3
        DEC CL
        JNZ READ1
        RET
        READ ENDP
        SORT PROC NEAR
        MOV CL,NUM
 OUTER : LEA SI,ARRAY
         MOV BL,00
 CHECK : MOV DH,[SI]
         INC SI
         MOV DL,[SI]
         DEC SI
         CMP DH,DL
         JL LENS
         MOV [SI],DL
         INC SI
         MOV [SI],DH
         DEC SI
  LENS : INC SI
         INC BL
         CMP BL,NUM
         JNE CHECK
         DEC CL
         JNZ OUTER
         RET
         SORT ENDP
         DISPLAY PROC NEAR
         MOV CL,NUM
         INC SI
 DISP :  MOV AH,00
         MOV AL,[SI]
         MOV BL,10
         DIV BL
         MOV DL,AH
         MOV DH,00
         MOV AH,00
         ADD DX,0030H
         PUSH DX
         MOV BL,10
         DIV BL
         MOV DL,AH
         MOV DH,00
         ADD DX,0300H
         MOV AX,0200H
         INT 21H
         POP DX
         MOV AX,0200H
         INT 21H
         PRINT MSG3
         INC SI
         DEC CL
         JNZ DISP
         RET
         DISPLAY ENDP
  
 END START
CODE ENDS
