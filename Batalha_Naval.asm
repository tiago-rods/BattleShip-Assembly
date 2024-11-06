;---------------MACRO DE PUSH ALL-------------{
; FUNÇÃO DO MACRO: PRESERVAR CONTEXTO
;
; ONDE USAR: DENTRO DE PROCEDIMENTOS OU MACROS 
; QUE UTILIZAM VARIOS REGISTRADORES
;
; COMO USAR: SOMENTE CHAMAR O MACRO E EM CON-
; TEXTOS NECESSÁRIOS
;
;  NOME: PUSH_ALL
;---------------MACRO DE PUSH ALL-------------}
PUSH_ALL MACRO
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    PUSH BP
ENDM
;--------------MACRO DE POP ALL------------{
; FUNÇÃO DO MACRO: RESTAURAR CONTEXTO
;
; ONDE USAR: DENTRO DE PROCEDIMENTOS OU MACROS
;
; COMO USAR: SOMENTE CHAMAR O MACRO E EM CON-
; TEXTOS NECESSÁRIOS
;
; NOME: POP_ALL
;--------------MACRO DE POP ALL------------}
POP_ALL MACRO
    POP BP
    POP DI
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
ENDM
;-------------MACRO DE FIM DE LINHA---------{
;
; FUNÇÃO DO MACRO: PULAR PARA A PRÓXIMA LINHA
;
; ONDE USAR: QUANDO QUISER PULAR  PARA A PRÓ-
; XIMA LINHA
;
; COMO USAR: SOMENTE CHAMAR O MACRO
;
; NOME: ENDL; VEM DE--> (END LINE)
; 
;-------------MACRO DE FIM DE LINHA---------}
ENDL MACRO
    PUSH AX
    PUSH DX
    
    MOV DL, 10  ; Line Feed
    INT 21h  

    POP AX
    POP DX   
ENDM
;-------------MACRO PARA LIMPAR TELA---------{
;
; FUNÇÃO DO MACRO: LIMPAR TELA
;
; ONDE USAR: QUANDO QUISER LIMPAR TODA A TELA, 
; SEJA DENTRO DE PROCEDIMENTOS OU MACROS
;
; COMO USAR: SOMENTE CHAMAR O MACRO
; 
; NOME: CLEAR_SCREEN
;
;-------------MACRO PARA LIMPAR TELA---------}
CLEAR_SCREEN MACRO
    PUSH_ALL    
    MOV AX, 0600H
    MOV BH, 07H
    MOV CX, 0000H
    MOV DX, 184FH
    INT 10H
    POP_ALL
ENDM
;-----------MACRO PARA EXIBIR STRING----------{
;
; FUNÇÃO DO MACRO: EXIBIR STRING
;
; ONDE USAR: QUANDO QUISER EXIBIR UMA STRING, E
; AO INVES DE USAR AH, 9; INT 21H, USAR ESTE MACRO
;
; COMO USAR: CHAMAR O MACRO, E PASSAR A STRING APÓS
;
; EXEMPLO DE USO: PRINTS STRING, ONDE STRING POSSUI
; UMA STRING
;
; NOME: PRINTS --> (PRINT STRING)
;
;-----------MACRO PARA EXIBIR STRING----------}
PRINTS MACRO STRING
    PUSH DX
    PUSH AX

    LEA DX, STRING      
    MOV AH, 9      
    INT 21h 

    POP AX
    POP DX         
ENDM

;-----------MACRO PARA PRINT CHAR------------{
;
;  FUNÇÃO DO MACRO: EXIBIR CHARACTER
;
;  ONDE USAR: QUANDO QUISER EXIBIR UM CARACTERER
;
;  COMO USAR: CHAMAR O MACRO, E PASSAR O CARACTER
;
;  EXEMPLO DE USO: PRINTC CHAR, ONDE CHAR POSSUI 
;  UM CARACTE
;
;  NOME: PRINTC --> (PRINT CHAR)
;
;-----------MACRO PARA PRINT CHAR------------}
PRINTC MACRO CHAR
    PUSH DX
    PUSH AX
    MOV AH, 2
    MOV DL, CHAR
    INT 21h
    POP AX
    POP DX
ENDM

;-----------MACRO PARA POSICIONAR CURSOR------------{
;
;  FUNÇÃO DO MACRO: POSICIONA O CURSOR NA TELA
;
;  ONDE USAR: QUANDO PRECISAR POSICIONAR O CURSOR 
;  EM UMA LINHA E COLUNA ESPECIFICOS DA TELA
;
;  COMO USAR: CHAMAR MACRO E INDICAR PARAMETROS DE
;  LINHA E COLUNA RESPECTIVAMENTE
;
;  EXEMPLO DE USO:  POS_CURSOR 10, 20
;
;  NOME: POS_CURSOR --> (POSICIONAR CURSOR)
;
;-----------MACRO PARA POSICIONAR CURSOR------------}
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
;-------------MACRO DE INPUT SEM ECHO----------{
;
;  FUNÇÃO DO MACRO: FAZ UM INPUT SEM ECHO
;
;  ONDE USAR: QUANDO QUISER QUE O USUÁRIO DIGITE
;  ALGO SEM QUE O CARACTER DIGITADO SEJA ARMAZENADO
;
;  COMO USAR: SOMENTE CHAMAR O MACRO 
;
;  NOME: PPC --> (PRESSIONE PARA CONTINUAR)
;
;-------------MACRO DE INPUT SEM ECHO----------}
PPC MACRO 
    PUSH AX
    MOV AH, 7
    INT 21H
    POP AX
ENDM

.MODEL SMALL
.STACK 100H
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                  SEGMENTO DE DADOS
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.DATA
;======================================= CONSTANTES 
    LINHAS_COLUNAS EQU 10
;======================================= VETORES PARA DESENHO DE LOGO
; L0 A L5 ESCREVEM A PALAVRA "BATALHA"
    L0 DB 0C9h, 37 DUP(0CDh),0BBh, 13,10,"$"
    L1 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 32,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 32,0DBh,32, 32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh, 32,32, 32,0DBh,32, 32,32, 0BAh ,13,10, "$"
    L2 DB 0BAh, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh, 32,32,  0BAh  ,13,10, "$"
    L3 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 32,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,32,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,0DBh,0DBh, 32,32, 0BAh ,13,10, "$"
    L4 DB 0BAh, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,0DBh, 32,32, 0BAh  ,13,10, "$"
    L5 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,0DBh, 32,32, 0BAh,13,10, "$"
; L É APENAS PARA DESENHO ENTRE PALAVRAS
    L  DB 0BAh, 37 DUP(32), 0BAh, 13,10, "$"
; L6 A L9 ESCREVEM A PALAVRA "NAVAL"
    L6 DB 0BAh, 4 DUP(32), 0DBh,32,32,0DBh,    32,32,  32,0DBh,0DBh,32,    32,32,  0DBh,32,32,0DBh, 32,32, 32,0DBh,0DBh,32, 32,32,  0DBh,32,32,32,  5 DUP(32), 0BAh, 13,10, "$"
    L7 DB 0BAh, 4 DUP(32), 0DBh,0DBh,32,0DBh,  32,32,  0DBh,32,32,0DBh,   32,32,  0DBh,32,32,0DBh, 32,32, 0DBh,32,32,0DBh, 32,32,  0DBh,32,32,32,  5 DUP(32), 0BAh, 13,10, "$"
    L8 DB 0BAh, 4 DUP(32), 0DBh,32,0DBh,0DBh,  32,32,  0DBh,0DBh,0DBh,0DBh,   32,32,  0DBh,32,32,0DBh,  32,32, 0DBh,0DBh,0DBh,0DBh,   32,32,   0DBh,32,32,32, 5 DUP(32), 0BAh, 13,10, "$"
    L9 DB 0BAh, 4 DUP(32), 0DBh,32,32,0DBh,    32,32,  0DBh,32,32,0DBh,    32,32, 32,0DBh,0DBh,32, 32,32, 0DBh,32,32,0DBh, 32,32,   0DBh,0DBh,0DBh,0DBh, 5 DUP(32), 0BAh, 13,10, "$"
   L10 DB 0C8h, 37 DUP(0CDh), 0BCh,  13,10, "$"


;==================================== MATRIZ PARA DESENHO DE TABULEIRO
  TABULEIRO    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 31H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 32H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 33H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 34H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 35H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 36H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 37H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 38H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0BAH, 32, 39H, 32, 10 DUP(0B1h), 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh     


TABULEIRO_AUX DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 31H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 32H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 33H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 34H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 35H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 36H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 37H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 38H, 32, 10 DUP(?), 32, 0BAH
               DW 0BAH, 32, 39H, 32, 10 DUP(?), 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh    
 
;==========================================================TABULEIROS ALEATÓRIOS
TABULEIRO_0    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH,    32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 73H,30H,30H,30H,30H,30H,48H,48H,48H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 73H,30H,30H,30H,30H,30H,30H,48H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 46H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 46H, 30H,30H,53H,53H,30H,30H,68H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 46H, 30H,30H,30H,30H,30H,68H,68H,68H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32,45H,45H,45H,45H, 30H ,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_1    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH,    32, 0BAH
               DW 0BAH, 32, 30H, 32,53H ,53H ,30H,30H,30H,48H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,30H,30H,48H,48H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 73H,30H,30H,30H,48H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 73H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,30H,30H,30H,30H,68H,30h,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,30H,68H,68H,68H,30h,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,46H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 45H,45H,45H,45H,30H,30H,30H,30H,46H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,46H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_2    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH,    32, 0BAH
               DW 0BAH, 32, 30H, 32, 48H, 30H,30H,30H,68H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 48H, 48H,30H,68H,68H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 48H, 30H,30h,30H,68H,30H,30H,30H,30H,30H  , 32, 0BAh 
               DW 0BAH, 32, 33H, 32, 30H, 30H,46H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,46H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,46h,30H,30H,30H,73H,73H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,45H,45H,45H,45H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_3    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,48H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 48H,48H,48H,30H,30H,30H,45H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,30H,30H,30H,30H,30H,45H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,30H,30H,30H,45H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,30H,30H,30H,30H,30H,45H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32,73H,73H, 30H ,30H,53H,30H,30H,30H,30H,68H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,53H,30H,30H,30H,68H,68H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,68H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,30H,30H,46H,46H,46H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh

TABULEIRO_4    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,48H,30H,73H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,48H,48H,30H,73H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,48H,30H,30H,30H,68H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,30H,30H,30H,30H,68H,68H,68H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 46H, 30H,30h,30h,30h,30h,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 46H, 30H,45H,45H,45H,45H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 46H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,30H,30H,53H,53H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 


TABULEIRO_5    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32,  46H,46H,46H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,30H,30H,30H,68H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,68H,68H,68H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,45H,30H,30H,30H,30H,30H,53H,53H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,45H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,45H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,45H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 73H, 30h,30H,30H,30H,48H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 73H, 30H,30H,30H,48H,48H,48H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh

TABULEIRO_6    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,48H,48H,48H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 45H, 45H,45H,45H,30H,30H,30H,30H,48H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,30H,30H,30H,46H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,30H,46H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,53H,53H,30H,46H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,68H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,68H,68H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,68H,30H,30H,73H,73H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_7    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,30H,30H,73H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 53H,53H,30H,30H,73H,30H,46H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,30H,30H,30H,46H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 68H, 68H,68H,30H,30H,30H,30H,46H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 68H,30H,30H,30H,48H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,48H,48H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,48H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 45h, 45H,45H,45H,30h,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_8    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,45H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,45H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,30H,30H,48H,30H,30H,30H,30H,45H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,48H,48H,48H,30H,30H,30H,45H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,30H,30H,30H,30H,30H,68H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,30H,30H,53H,30H,30H,68H,68H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,53H,30H,30H,68H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 73H, 73H,30H,30H,30H,30H,30H,30H,30H,46H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,46H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,46H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 


TABULEIRO_9    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,68H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,30H,30H,68H,68H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,46H,30H,30H,30H,68H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,46H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,46H,30H,30H,30H,30H,73H,73H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,30H,30h,30h,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,30H,45H,45H,45H,45H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 48H,30H,30H,30H,53H,53H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 48H, 48H,48H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh   
;======================================= OUTRAS STRINGS

    PTC DB "Pressione qualquer tecla para continuar ... $" ;PTC VEM DE PRESS TO CONTINUE

;======================================= STRINGS PARA PROCEDIMENTO "PEGAR COORDENADAS PROC"

    MSG_ATAQUE_LINHA  DB 10, 13, "Digite o numero da linha para o ataque: $"
    MSG_ATAQUE_COLUNA DB 10, 13, "Digite o numero da coluna para o ataque: $"
    POS_LINHA         DW ? ;LINHA É DW POR CAUSA DO MAPA SER DW
    POS_COLUNA        DW ?  ;COLUNA É DW POR CAUSA DO MAPA SER DW
    MSG_ERRO_MAPA     DB 10, 13, "Coordenada inválidas, digite uma coordenada dentro do limite do mapa $"

;====================================== STRING PARA PROCEDIMENTO "ALEATORIO"

    NUM_ALEATORIO DW ?
    
;==================================== VARIÁVEIS DE CONTROLE PARA IMPRIMIR A MATRIZ

    CONTADOR EQU 208
    FIM_LINHA EQU 30
    ULTIMA_POS EQU 400

.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    CALL TELA_INICIAL


    CLEAR_SCREEN
    ENDL

    ;MOSTRA A MATRIZ INICIAL NA TELA PARA O USUÁRIO
    CALL PRINT_MATRIZ

    ;TODO:
    ;ADICIONAR ALEATORIAMENTE AS EMBARCAÇÕES NO TABULEIRO
    ;FAZER SISTEMA DE VERIFICAR SE A EMBARCAÇÃO ESTÁ A PELO MENOS UM QUADRADO DE DISTÂNCIA DA OUTRA
    ;FAZER LOOP DE EXIBIÇÃO DE MATRIZ APÓS CADA JOGADA 
    ;CONTABILIZAR ACERTO E ERRO DE EMBARCAÇÕES

    ;adicionar as embarcações no mapa
    ;verificar se as embarcações estão no mesmo lugar / estão separadas por 31H casa
    ;pedir ao player digitar as coordenadas de tiro


    ATAQUE:
    CALL PEGAR_COORDENADAS 

    ;pula uma linha 
    ENDL
    CALL VERIFICAR_ATAQUE
    
    FIM_VERIFICACAO:

    ;IMPRIME A MATRIZ ATUALIZADA
    CALL PRINT_MATRIZ

    ;RETOMA O LOOP DE PEGAR COORDENADAS 
    PROXIMO_TIRO?:
    ;VERIFICAR SE EXISTE AINDA ALGUMA CASA (1), OU SEJA, SE EXISTE EMBARCAÇÃO AINDA, SE N, ENCERRA O JOGO
    JMP ATAQUE

    ; Continue o jogo ou finalize se todas as embarcações forem destruídas

    ;verificar se as cordenadas estão dentro do mapa
    ;adicionar isso ao mapa
    ;verificar se o tiro acertou a embarcação ou não
    ;se acertou, marcar com cor diferente a embarcação
    ;se acertou todas, finalizar o jogo
    ;jogar denovo?

FIM: 
    MOV AH, 4CH
    INT 21H
ENDP MAIN

;=================PROCEDIMENTO DE TELA DE INICIAL================={
;
;  FUNÇÃO: MOSTRAR O LOGO "BATALHA NAVAL" AO INICIO DO CÓDIGO
;
;  COMO USAR: CHAMAR O PROCEDIMENTO AO INICIO DO CODIGO SOMENTE
;  
;  NOME: TELA_INICIAL
;
;=================PROCEDIMENTO DE TELA DE INICIAL=================}
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
;===================PROCEDIMENTO PARA IMPRIMIR MATRIZ==================={
;
;  FUNÇÃO DO PROCEDIMENTO: IMPRIMIR MATRIZ DE 16BITS,(DW)
;
;  ONDE USAR: QUANDO QUISER IMPRIMIR UMA MATRIZ DW
;
;  COMO USAR: CHAMAR O PROCEDIMENTO
;
;  NOME: PRINT_MATRIZ
;
;===================PROCEDIMENTO PARA IMPRIMIR MATRIZ===================}
PRINT_MATRIZ PROC
    PUSH_ALL

    XOR BX, BX
    XOR SI, SI
    XOR DX, DX
    
    MOV CX, CONTADOR

    MOSTRAR_MATRIZ:
    MOV DX, TABULEIRO[BX][SI]

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

    JA FIM_PRINT
    JMP MOSTRAR_MATRIZ

    FIM_PRINT:

    POP_ALL
    RET

PRINT_MATRIZ ENDP

;=================PROCEDIMENTO DE GERAR NÚMERO ALEATÓRIO================={
;
;  FUNÇÃO: GERAR UM NÚMERO ALEATÓRIO ENTRE 0 E 9
;
;  COMO USAR: CHAMAR QUANDO PRECISAR POSICIONAR EMBARCAÇÕES AO COMEÇO DO JOGO
;
;  COMO FUNCIONA: GERA UM NÚMERO ALEATÓRIO ENTRE 0 E 9 COM A INTERRUPÇÃO 1AH
;  DIVIDE POR 10 PARA GERAR ESTE NÚMERO EX X % 10 = 0<=X<=9
;
;  PROCEDIMENTOS CHAMADOS: NENHUM
;
;  NOME: ALEATORIO
; 
;=================PROCEDIMENTO DE GERAR NÚMERO ALEATÓRIO=================}
ALEATORIO PROC
    MOV AH, 0H                     ; Chama a interrupção 1Ah para obter o número de ticks
    INT 1AH

    MOV AX, DX                     ; Coloca o valor do timer em AX
    MOV DX, 0                      ; Limpa DX para a divisão
    MOV BX, 10                     ; O divisor é 10 para limitar o valor de 0 a 9
    DIV BX                         ; Divide AX por 10
    MOV NUM_ALEATORIO, DX          ; Armazena o resto (0-9) em NUM_ALEATORIO

    RET

ALEATORIO ENDP


;=================PROCEDIMENTO PARA PEGAR POSIÇÃO DE ATAQUE DO JOGADOR================={
;
;  FUNÇÃO: PEGAR RESPECTIVAMENTE LINHA E COLUNA A QUAL O JOGADOR DESEJA ATACAR, ADEMAIS
;  VERIFICA SE O LOCAL ESTÁ DENTRO OU FORA DA ÁREA DE ATAQUE
;  
;  COMO USAR: CHAMAR QUANDO O JOGADOR FOR ATACAR
;
;  NOME: PEGAR_COORDENADAS
;
;=================PROCEDIMENTO PARA PEGAR POSIÇÃO DE ATAQUE DO JOGADOR=================}
PEGAR_COORDENADAS PROC
    ;ATACAR LINHA 
    PRINTS MSG_ATAQUE_LINHA             ; mensagem de pegar coordenadas na tela
    
    MOV AH, 01H                         ; pega o caractere
    INT 21H

;                                       ; Verifica se a linha está dentro do limite (0 a 9)
    CMP AL, "0"
    JL FORA_DO_MAPA                     ; Linha menor que 0, fora do mapa
    CMP AL, "9"
    JG FORA_DO_MAPA                     ; Linha maior que 9, fora do mapa

    XOR AH, AH                          ;REMOVE A PARTE QUE NÃO É NUMERO
    AND AL, 0FH                         ;converte para um valor numerico entre 0 e 9
    ADD AL, 2                           ;ADD 2 PARA FICAR ENTRE VALORES DE 2 A 11, PARA ENCAIXAR NA MULTIPLICAÇÃO DA MATRIZ QUE COMEÇA EM [64,8]
;                                       ; agora, será necessário multiplicar por 24 para que ele entre de acordo com o valor da matriz
    MOV BX, 32                          ; multiplica por 32 pq EX: 2x32=62, 3x32=96
    MUL BX                              ; DX:AX -> AX.BX
    MOV POS_LINHA, AX                   ; joga a coordenada de tiro do jogador na variavel DE LINHA, mesmo estando em AL, precisa ser assim pq é 16 bits p 16 bits

;                                      ;zera ax e bx
    XOR AX, AX
    XOR BX, BX

;                                       ;ATACAR COLUNA
    PRINTS MSG_ATAQUE_COLUNA            ; mensagem de pegar coordenadas na tela
    
    MOV AH, 01H                         ; pega o caractere
    INT 21h

;                                       ; Verifica se a coluna está dentro do limite (A a J)
    CMP AL, "A"
    JL FORA_DO_MAPA                     ; Coluna menor que A, fora do mapa
    CMP AL, "J"
    JG FORA_DO_MAPA                     ; Coluna maior que J, fora do mapa

    XOR AH, AH                          ;REMOVE A PARTE QUE NÃO É LETRA
    SUB AL, 41H                         ; tira 41h para transformar em numero de 0 a 9
    ADD AL, 4                           ; add 4 pq o elemento começa agora na posição [64,8], logo o primeiro A=0+4x2=8
    MOV BX, 2                           ; multiplica por 2 para que ele entre de acordo com o valor da matriz -> EX: A=(41h-40).2 = 2; B=4, C=6, isso ocorre pq a matriz vai de 2 em 2 e ela começa no 2
    MUL BX
    MOV POS_COLUNA, AX                  ; joga a coordenada de tiro do jogador na variavel DE COLUNA, mesmo estando em AL, precisa ser assim pq é 16 bits p 16 bits

;                                       ;COM ISSO FEITO, É POSSÍVEL ACESSAR A MATRIZ POR TABULEIRO[POS_LINHA][POS_COLUNA]
;                                       ; Se as coordenadas estão no limite do mapa, continue o programa
    RET
    FORA_DO_MAPA:
;                                       ; Mensagem de erro e solicitação de novas coordenadasDAS
    LEA DX, MSG_ERRO_MAPA
    MOV AH, 9
    INT 21H
    JMP PEGAR_COORDENADAS               ; Volta para pegar novas coordenadas
    
PEGAR_COORDENADAS ENDP

;=================TABULEIRO PSEUDOALEATÓRIO===================={
;
;   O QUE FAZ: GERA UM TABULEIRO COM EMBARCAÇÕES POSICIONADAS 
;   PSEUDOALEATÓRIAMENTE
;   
;   COMO FAZ: GERA UM NUMERO ALEATORIO, E FAZ UM SWITCH CASE, 
;   DEPENDENDO DE QUAL NÚMERO CAIR, USA UM PRESET DIFERENTE
;   DE TABULEIRO
;
;   PROCEDIMENTOS CHAMADOS: ALEATORIO
;
;   NOME: GERA_TABULEIRO 
;
;=================TABULEIRO PSEUDOALEATÓRIO=====================}

GERA_TABULEIRO PROC
    PUSH_ALL

SWITCH:
    CALL ALEATORIO ;PEGA NUMERO ALEATÓRIO

    MOV AX, NUM_ALEATORIO ;ARMAZENA O NUMERO ALEATÓRIO EM AX

    ; COMPARA AX COM 0 A 9, PARA VER QUAL CASO UTILIZAR
    CMP AX, 0
    JZ CASE_0
    CMP AX, 1
    JE CASE_1
    CMP AX, 2
    JE CASE_2
    CMP AX, 3
    JE CASE_3
    CMP AX, 4
    JE CASE_4
    CMP AX, 5
    JE CASE_5
    CMP AX, 6
    JE CASE_6
    CMP AX, 7
    JE CASE_7
    CMP AX, 8
    JE CASE_8
    CMP AX, 9
    JE CASE_9

    ;JMP DEFAULT deixa JE CASE_9 fora de alcance
    ;CASOS DE 0 A 9, CADA CASO UTILIZA UM TABULEIRO DIFERENTE
    ;COMO FAZ ISSO:
    ;MOVE PARA SI STRING A SER COPIADA
    ;MOVE PARA DI STRING QUE RECEBERA A STRING EM SI
    ;CX RECEBE O TAMANHO DA STRING, PARA SABER QUANTOS ELEMENTOS COPIAR
    ;UTILIZA REP MOVSW PARA COPIAR STRING EM OUTRA
CASE_0:
    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_0 
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_1:
    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_1
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_2:

    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_2
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_3:

    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_3
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_4:

    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_4
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_5:

    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_5
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_6:

    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_6
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_7:

    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_7
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_8:

    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_8
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

CASE_9:

    MOV CX, CONTADOR
    MOV SI, OFFSET TABULEIRO_9
    MOV DI, OFFSET TABULEIRO_AUX

    REP MOVSW
    JMP END_SWITCH

;DEFAULT:

;   JMP SWITCH ;FICA FORA DE ALCANCE CASO DEFINIDO, LOGO EVITEI UTILIZAR

END_SWITCH:
    ; FINALIZA O PROCEDIMENTO
    POP_ALL
    RET

GERA_TABULEIRO ENDP

END MAIN
