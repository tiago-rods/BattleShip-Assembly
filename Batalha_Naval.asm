; INCLUDE macros.asm
;---------------MACRO DE PUSH ALL-------------
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
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
ENDM

;-------------MACRO DE FIM DE LINHA---------------------
ENDL MACRO
    PUSH AX
    PUSH CX

    MOV AH, 2   
    MOV DL, 13  ; Carriage Return
    INT 21h        
    MOV DL, 10  ; Line Feed
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
;-----------MACRO PARA PRINT STRING----------
PRINTS MACRO STRING
    PUSH DX
    PUSH AX

    LEA DX, STRING      
    MOV AH, 9      
    INT 21h 

    POP AX
    POP DX         
ENDM

;-----------MACRO PARA PRINT CHAR------------
PRINTC MACRO CHAR
    PUSH DX
    PUSH AX
    MOV AH, 2
    MOV DL, CHAR
    INT 21h
    POP AX
    POP DX
ENDM

;---------------MACRO PARA IMPRIMIR MATRIZ------------- 
PRINT_MATRIZ MACRO MATRIZ, CONTADOR, FIM_LINHA, ULTIMA_POS
    PUSH_ALL

    XOR BX, BX
    XOR SI, SI
    XOR DX, DX
    
    MOV CX, CONTADOR

    MOSTRAR_MATRIZ:
    XOR DX, DX
    MOV DX, MATRIZ[BX][SI]

    MOV AH, 2
    INT 21H

    ADD SI, 2

    CMP SI, FIM_LINHA
    JA NOVA_LINHA

    LOOP MOSTRAR_MATRIZ

    NOVA_LINHA:
    ENDL
    ADD BX, FIM_LINHA + 2
    XOR SI, SI 
    CMP BX, ULTIMA_POS

    JA CONTINUAR
    JMP MOSTRAR_MATRIZ



    CONTINUAR:

    POP_ALL
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

PPC MACRO 
    PUSH AX
    MOV AH, 7
    INT 21H
    POP AX
ENDM

.MODEL SMALL
.STACK 100H

.DATA
;======================================= CONSTANTES 
    LINHAS EQU 15
    COLUNAS EQU 15
;======================================= VETORES PARA DESENHO DE LOGO
; L0 A L5 ESCREVEM A PALAVRA "BATALHA"
    L0 DB 0C9h, 37 DUP(0CDh),0BBh, 13,10,"$"
    L1 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 32,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 32,0DBh,32, 32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh, 32,32, 32,0DBh,32, 32,32, 0BAh ,13,10, "$"
    L2 DB 0BAh, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh, 32,32,  0BAh  ,13,10, "$"
    L3 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 32,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,32,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,0DBh,0DBh, 32,32, 0BAh ,13,10, "$"
    L4 DB 0BAh, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,0DBh, 32,32, 0BAh  ,13,10, "$"
    L5 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,0DBh, 32,32, 0BAh,13,10, "$"
    L  DB 0BAh, 37 DUP(32), 0BAh, 13,10, "$"
; L6 A L9 ESCREVEM A PALAVRA "NAVAL"
    L6 DB 0BAh, 4 DUP(32), 0DBh,32,32,0DBh,    32,32,  32,0DBh,0DBh,32,    32,32,  0DBh,32,32,0DBh, 32,32, 32,0DBh,0DBh,32, 32,32,  0DBh,32,32,32,  5 DUP(32), 0BAh, 13,10, "$"
    L7 DB 0BAh, 4 DUP(32), 0DBh,0DBh,32,0DBh,  32,32,  0DBh,32,32,0DBh,   32,32,  0DBh,32,32,0DBh, 32,32, 0DBh,32,32,0DBh, 32,32,  0DBh,32,32,32,  5 DUP(32), 0BAh, 13,10, "$"
    L8 DB 0BAh, 4 DUP(32), 0DBh,32,0DBh,0DBh,  32,32,  0DBh,0DBh,0DBh,0DBh,   32,32,  0DBh,32,32,0DBh,  32,32, 0DBh,0DBh,0DBh,0DBh,   32,32,   0DBh,32,32,32, 5 DUP(32), 0BAh, 13,10, "$"
    L9 DB 0BAh, 4 DUP(32), 0DBh,32,32,0DBh,    32,32,  0DBh,32,32,0DBh,    32,32, 32,0DBh,0DBh,32, 32,32, 0DBh,32,32,0DBh, 32,32,   0DBh,0DBh,0DBh,0DBh, 5 DUP(32), 0BAh, 13,10, "$"
   L10 DB 0C8h, 37 DUP(0CDh), 0BCh,  13,10, "$"
;=================================== DEFINIÇÃO DE EMBARCAÇÕES
    ENCOURACADO DW 1,1,1,1

    FRAGATA     DW 1,1,1

    SUBMARINO   DW 1,1

    HIDROAVAO   DW 1,1,1
                DW 0,1,0
   
;======================================= MATRIZ PARA DESENHO DE TABULEIRO
  TABULEIRO DW 0C9h, 10 DUP(0CDh), 0BBh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0BAh, 10 DUP(30H), 0BAh
            DW 0C8h, 10 DUP(0CDh), 0BCh        
;======================================= OUTRAS STRINGS

   PTC DB "Pressione qualquer tecla para continuar ... $"

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL TELA_INICIAL


    CLEAR_SCREEN
    ENDL
    PRINT_MATRIZ TABULEIRO, 144, 22, 264

    ;TODO:
    ;ADICIONAR ALEATORIAMENTE AS EMBARCAÇÕES NO TABULEIRO
    ;FAZER SISTEMA DE VERIFICAR SE A EMBARCAÇÃO ESTÁ A PELO MENOS UM QUADRADO DE DISTÂNCIA DA OUTRA
    ;FAZER LOOP DE EXIBIÇÃO DE MATRIZ APÓS CADA JOGADA 
    ;CONTABILIZAR ACERTO E ERRO DE EMBARCAÇÕES

FIM: 
    MOV AH, 4CH
    INT 21H
MAIN ENDP

TELA_INICIAL PROC
        CLEAR_SCREEN

    POS_CURSOR 5, 18
    PRINTS L0
    POS_CURSOR 6, 18
    PRINTS L1
    POS_CURSOR 7, 18
    PRINTS L2
    POS_CURSOR 8, 18
    PRINTS L3
    POS_CURSOR 9, 18
    PRINTS L4
    POS_CURSOR 10, 18
    PRINTS L5
    POS_CURSOR 11, 18
    PRINTS L
    POS_CURSOR 12, 18
    PRINTS L6
    POS_CURSOR 13, 18
    PRINTS L7
    POS_CURSOR 14, 18
    PRINTS L8
    POS_CURSOR 15, 18
    PRINTS L9
    POS_CURSOR 16, 18
    PRINTS L10

    POS_CURSOR 17, 18
    PRINTS PTC
    PPC

    RET
TELA_INICIAL ENDP

END MAIN