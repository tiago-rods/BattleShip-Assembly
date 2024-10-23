;--------------MACRO DE PUSH ALL----------
PUSH_ALL MACRO
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        PUSH SI
        PUSH DI
        PUSH BP
ENDM
;--------------MACRO DE POP ALL------------
POP_ALL MACRO
        POP BP
        POP AX
        POP BX
        POP CX
        POP DX
        POP SI
        POP DI
ENDM

;-------------MACRO DE FIM DE LINHA---------------------
ENDL MACRO
    PUSH AX
    PUSH DX

    MOV AH, 2   
    MOV DL, 10  
    INT 21h        

    MOV AH, 2   
    MOV DL, 13   
    INT 21h    

    POP AX
    POP DX  
ENDM
;-------------MACRO PARA LIMPAR TELA-----------
CLEAR_SCREEN MACRO
    PUSH_ALL
    MOV AX, 0600H
    MOV BH, 07H
    MOV CX, 0000H
    MOV DX, 184FH
    INT 10H
    POP_ALL
ENDM
;-----------MACRO PARA PRINT----------
PRINT MACRO str
    PUSH DX
    PUSH AX
    LEA DX, str      
    MOV AH, 9      
    INT 21h 
    POP AX
    POP DX         
ENDM
        
;-----------MACRO PARA POSICIONAR CURSOR------------
POS_CURSOR MACRO linha, coluna 
    PUSH AX
    PUSH DX
    PUSH BX

    MOV AH, 2 
    MOV BH, 0 
    MOV DH, linha
    MOV DL, coluna
    INT 10H

    POP BX
    POP DX
    POP AX
ENDM