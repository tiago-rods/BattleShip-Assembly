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
    
    MOV AH, 2
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
    MOV DX, CHAR
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

;--------------MACRO PARA VERIFICAR SE EMBARCAÇÃO AFUNDOU--------------{
;
;   FUNÇÃO DO MACRO: VERIFICAR SE CARACTER DA EMBARCAÇÃO AINDA ESTA PRE
;   SENTE NO TABULEIRO
;
;   ONDE USAR: VERIFICAR SE EMBARCAÇÃO AFUNDOU
;
;   COMO USAR: CHAMAR MACRO, PASSAR O TAMANHO DA MATRIZ, A LETRA QUE QUER
;   VERIFICAR E A MATRIZ QUE QUER VERIFICAR
;
;   NOME --> AFUNDOU
;
;--------------MACRO PARA VERIFICAR SE EMBARCAÇÃO AFUNDOU--------------}
AFUNDOU MACRO COUNTER, COMPARADO, STRING

    MOV CX, COUNTER
    MOV AX, COMPARADO
    MOV DI, OFFSET STRING
    REPNE SCASW

ENDM
;------------MACRO PARA MUDAR COR DE STRING-------------{
;   
;   FUNÇÃO DO MACRO: MUDAR COR DE STRINGS TERMINADAS EM $
;
;   COMO USAR: CHAMAR MACRO, PASSAR A STRING QUE QUER MUDAR A 
;   COR E A COR PARA QUAL QUER MUDAR, EM BL É ARMAZENADA A COR
;   E EM [SI] A STRING
;
;   NOME --> PRINT_COR
;
;------------MACRO PARA MUDAR COR DE STRING-------------}
PRINT_COR MACRO STRING, COR
PRINT_COR MACRO STRING, COR
PUSH SI
PUSH BX 

    LEA SI, STRING
    MOV BL, COR
    CALL MUDA_COR

POP BX
POP SI
ENDM

;----------------MACRO PARA TABULAÇÃ0------------------{
;
;   FUNÇÃO DO MACRO: TABULAÇÃO, CRIAR ESPAÇOS EM BRANCO
;
;   COMO USAR: CHAMAR MACRO MAIS NUMERO DE VEZES QUE QUER QUE
;   A TABULAÇÃO SEJA APLICADA
;   
;   NOME --> TAB
;
;----------------MACRO PARA TABULAÇÃ0------------------}

TAB MACRO N                 
    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
        
    MOV AH, 3
    MOV BH, 0
    INT 10h
        
    MOV AH, 2
    ADD DL, N 
    INT 10h   
        
    POP DX
    POP CX
    POP BX
    POP AX
ENDM



.MODEL SMALL
.STACK 100H
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                  SEGMENTO DE DADOS
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
.DATA
;======================================= CONSTANTES

    LINHAS_COLUNAS  EQU 10

;===============================================CONTANTES DE CORES

    VERDE           EQU 0010b
    VERMELHO        EQU 0100b
    AZUL            EQU 0001b
    CINZA_CLARO     EQU 0111b
    CINZA_ESCURO    EQU 1000b               
    CIANO           EQU 0011b
    MAGENTA         EQU 0101b
    LARANJA         EQU 110110b


;==========================================TAGLINES

    BY       DB "DESENVOLVIDO POR: $"
    TIAGO    DB "TIAGO ALVES RODRIGUES$"
    RAFAEL   DB "RAFAEL MARTINIANO NOGUEIRA FILHO$"
    ARTUR    DB "ARTUR YANO CONTARELLI$"

;======================================= VETORES PARA DESENHO DE LOGO
; L0 A L5 ESCREVEM A PALAVRA "BATALHA"
    L0 DB 0C9h, 37 DUP(0CDh),0BBh,"$"
    L1 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 32,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 32,0DBh,32, 32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh, 32,32, 32,0DBh,32, 32,32, 0BAh, "$"
    L2 DB 0BAh, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh, 32,32,  0BAh,  "$"
    L3 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 32,0DBh,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,32,32, 32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,0DBh,0DBh, 32,32, 0BAh, "$"
    L4 DB 0BAh, 32,32, 0DBh,32,0DBh, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,0DBh, 32,32, 0BAh,  "$"
    L5 DB 0BAh, 32,32, 0DBh,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 32,0DBh,32, 32,32, 0DBh,32,0DBh,  32,32, 0DBh,0DBh,0DBh,   32,32, 0DBh,32,0DBh,  32,32, 0DBh,32,0DBh, 32,32, 0BAh,"$"
; L É APENAS PARA DESENHO ENTRE PALAVRAS
    L  DB 0BAh, 37 DUP(32), 0BAh, "$"
; L6 A L9 ESCREVEM A PALAVRA "NAVAL"
    L6 DB 0BAh, 4 DUP(32), 0DBh,32,32,0DBh,    32,32,  32,0DBh,0DBh,32,    32,32,  0DBh,32,32,0DBh, 32,32, 32,0DBh,0DBh,32, 32,32,  0DBh,32,32,32,  5 DUP(32), 0BAh,"$"
    L7 DB 0BAh, 4 DUP(32), 0DBh,0DBh,32,0DBh,  32,32,  0DBh,32,32,0DBh,   32,32,  0DBh,32,32,0DBh, 32,32, 0DBh,32,32,0DBh,  32,32,  0DBh,32,32,32,  5 DUP(32), 0BAh,"$"
    L8 DB 0BAh, 4 DUP(32), 0DBh,32,0DBh,0DBh,  32,32,  0DBh,0DBh,0DBh,0DBh,   32,32,  0DBh,32,32,0DBh,  32,32, 0DBh,0DBh,0DBh,0DBh,   32,32,   0DBh,32,32,32, 5 DUP(32), 0BAh,"$"
    L9 DB 0BAh, 4 DUP(32), 0DBh,32,32,0DBh,    32,32,  0DBh,32,32,0DBh,    32,32, 32,0DBh,0DBh,32, 32,32, 0DBh,32,32,0DBh, 32,32,   0DBh,0DBh,0DBh,0DBh, 5 DUP(32), 0BAh,"$"
   L10 DB 0C8h, 37 DUP(0CDh), 0BCh, "$"


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


TABULEIRO_AUX  DW 0C9h, 14 DUP(0CDh), 0BBh
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
               DW ?,?,?,?,?,?
 
;==========================================================TABULEIROS ALEATÓRIOS
TABULEIRO_0    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH,    32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 73H,30H,30H,30H,30H,30H,61H,61H,61H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 73H,30H,30H,30H,30H,30H,30H,61H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 66H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 66H, 30H,30H,53H,53H,30H,30H,68H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 66H, 30H,30H,30H,30H,30H,68H,68H,68H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32,65H,65H,65H,65H, 30H ,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_1    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH,    32, 0BAH
               DW 0BAH, 32, 30H, 32,53H ,53H ,30H,30H,30H,61H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,30H,30H,61H,61H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 73H,30H,30H,30H,61H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 73H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,30H,30H,30H,30H,68H,30h,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,30H,68H,68H,68H,30h,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,66H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 65H,65H,65H,65H,30H,30H,30H,30H,66H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,66H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_2    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH,    32, 0BAH
               DW 0BAH, 32, 30H, 32, 61H, 30H,30H,30H,68H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 61H, 61H,30H,68H,68H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 61H, 30H,30h,30H,68H,30H,30H,30H,30H,30H  , 32, 0BAh 
               DW 0BAH, 32, 33H, 32, 30H, 30H,66H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,66H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,66H,30H,30H,30H,73H,73H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,65H,65H,65H,65H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_3    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,61H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 61H,61H,61H,30H,30H,30H,65H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,30H,30H,30H,30H,30H,65H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,30H,30H,30H,65H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,30H,30H,30H,30H,30H,65H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32,73H,73H, 30H ,30H,53H,30H,30H,30H,30H,68H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,53H,30H,30H,30H,68H,68H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,68H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,30H,30H,66H,66H,66H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh

TABULEIRO_4    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,61H,30H,73H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,61H,61H,30H,73H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,61H,30H,30H,30H,68H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,30H,30H,30H,30H,68H,68H,68H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 66H, 30H,30h,30h,30h,30h,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 66H, 30H,65H,65H,65H,65H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 66H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,30H,30H,53H,53H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 


TABULEIRO_5    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32,  66H,66H,66H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,30H,30H,30H,68H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,68H,68H,68H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,65H,30H,30H,30H,30H,30H,53H,53H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,65H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,65H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,65H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 73H, 30h,30H,30H,30H,61H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 73H, 30H,30H,30H,61H,61H,61H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh

TABULEIRO_6    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,61H,61H,61H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 65H, 65H,65H,65H,30H,30H,30H,30H,61H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,30H,30H,30H,66H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,30H,66H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,53H,53H,30H,66H,30H,30H,30H,30H  , 32, 0BAH
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
               DW 0BAH, 32, 32H, 32, 30H, 53H,53H,30H,30H,73H,30H,66H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,30H,30H,30H,30H,66H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 68H, 68H,68H,30H,30H,30H,30H,66H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 68H,30H,30H,30H,61H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,61H,61H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,61H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 65H, 65H,65H,65H,30h,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 

TABULEIRO_8    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,65H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,65H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,30H,30H,61H,30H,30H,30H,30H,65H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,30H,61H,61H,61H,30H,30H,30H,65H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,30H,30H,30H,30H,30H,68H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,30H,30H,53H,30H,30H,68H,68H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,53H,30H,30H,68H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 73H, 73H,30H,30H,30H,30H,30H,30H,30H,66H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,66H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,66H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh 


TABULEIRO_9    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 30H, 30H,30H,30H,30H,30H,68H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 31H, 32, 30H, 30H,30H,30H,30H,68H,68H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 32H, 32, 30H, 30H,66H,30H,30H,30H,68H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 33H, 32, 30H, 30H,66H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 34H, 32, 30H, 30H,66H,30H,30H,30H,30H,73H,73H,30H  , 32, 0BAH
               DW 0BAH, 32, 35H, 32, 30H, 30H,30H,30h,30h,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 36H, 32, 30H, 30H,30H,30H,30H,65H,65H,65H,65H,30H  , 32, 0BAH
               DW 0BAH, 32, 37H, 32, 30H, 30H,30H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 38H, 32, 30H, 61H,30H,30H,30H,53H,53H,30H,30H,30H  , 32, 0BAH
               DW 0BAH, 32, 39H, 32, 61H, 61H,61H,30H,30H,30H,30H,30H,30H,30H  , 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh   
;======================================= OUTRAS STRINGS

    PTC                 DB "Pressione qualquer tecla para continuar ... $" ;PTC VEM DE PRESS TO CONTINUE

;======================================= STRINGS PARA MANUAL DE INSTRUÇÃO

    REGRAS              DB "================BEM-VINDO AO BATALHA NAVAL================== $"
    REGRA1              DB " -> NESTE JOGO EH VOCE CONTRA A CPU $"
    REGRA2              DB " -> EH GERADO UM TABULEIRO 10x10, COM 6 EMBARCACOES $"
    REGRA3              DB " -> SENDO ESTAS 1 ENCOURACADO, 1 FRAGATA, 2 SUBMARINOS E 2 HIDROAVIOES$"
    FORM_E              DB " - ENCOURCADO: 4 BLOCOS, NA HORIZONTAL OU VERTICAL $"
    FORM_F              DB " - FRAGATA: 3 BLOCOS, NA HORIZONTAL OU VERTICAL $"
    FORM_S              DB " - SUBMARINO: 2 BLOCOS, NA HORIZONTAL OU VERTICAL$"
    FORM_H              DB " - HIDROAVIAO: 4 BLOCOS EM FORMATO DE T $"
    REGRA4              DB " -> ACERTOS SAO INDICADOS COM X E ERROS COM ~ $"
    REGRA5              DB " -> O JOGO ACABA QUANDO VOCE AFUNDA-LAS OU ACABAREM SEUS TIROS $"
    REGRA6              DB " -> DIGITE A COORDENADA QUE DESEJA ATACAR, EX: 0C $"

    ; Terminar as regras do jogo



    BAT_NAV DB "===========================BATALHA NAVAL ASSEMBLY X86===========================$"

;======================================= STRINGS PARA PROCEDIMENTO "PEGAR COORDENADAS PROC"

    MSG_ATAQUE_LINHA    DB  "Digite o numero da linha para o ataque: $"
    MSG_ATAQUE_COLUNA   DB  "Digite o numero da coluna para o ataque: $"
    POS_LINHA           DW ? ;LINHA É DW POR CAUSA DO MAPA SER DW
    POS_COLUNA          DW ?  ;COLUNA É DW POR CAUSA DO MAPA SER DW
    MSG_ERRO_MAPA       DB "Coordenada invalidas!! $"
  

;======================================= STRINGS PARA PROCEDIMENTO "VERIFICA FIM DE JOGO"

    ; R é de row
    R0 DB 0C9h, 60 DUP(0CDh),0BBh, "$" 
    R  DB 0BAh, 60 DUP(32), 0BAh, "$" ;R É APENAS PARA espaço ENTRE PALAVRAS
    R10 DB 0C8h, 60 DUP(0CDh), 0BCh,"$"
    TRACINHO DB 0BAh, "$"

    MSG_FIM_JOGO     DB  "Fim de jogo. Deseja jogar novamente (S/N)? $"; 43 CARACTERES
    MSG_ERRO_FIM_JOGO DB  "Opcao invalida. Digite S para sim ou N para nao: $"; 49 CARACTERES
        ; Definição dos caracteres para os navios
    MASTRO     DB 0B3h, "$"   ; Mastro vertical 
    VELA1      DB 0DFh, "$"    ; Parte da vela 
    VELA2      DB 0DCh, "$"   ; Parte da vela 
    VELA3      DB 0DBh, "$"   ; Vela cheia 
    CORDA      DB 0C4h, "$"    ; Corda horizontal 
    CASCO1     DB 0DBh, "$"    ; Bloco cheio para casco 
    CASCO2     DB 0B2h, "$"   ; Bloco parcial 
    CASCO3     DB 0B1h, "$"   ; Bloco leve 
    AGUA       DB 80 DUP(0F7H) ; Ondas



;====================================== STRING PARA PROCEDIMENTO "ALEATORIO"

    NUM_ALEATORIO DW ?
    
;==================================== VARIÁVEIS DE CONTROLE PARA IMPRIMIR A MATRIZ

    CONTADOR            EQU 208
    FIM_LINHA           EQU 30
    ULTIMA_POS          EQU 400

;==================================== CONTADORES PARA VERIICAR SE A EMBARCAÇÃO FOI ATINGIDA POR COMPLETO

    contFragata         DB 3
    contEncouracado     DB 4
    contSubmarinoA      DB 2
    contSubmarinoB      DB 2
    contHidroaviaoA     DB 4
    contHidroaviaoB     DB 4

;=======================MENSAGENS DE AFUNDADO========================

    MSG_COORDENADA_REPETIDA     DB 'ESTA COORDENADA JA FOI ATACADA $'
    ENCOURACADO_AFUNDOU_MSG     DB "Voce afundou o Encouracado!! $"
    FRAGATA_AFUNDOU_MSG         DB "Voce afundou o Fragata!! $"
    SUBMARINO_AFUNDOU_MSG       DB "Voce afundou um Submarino!! $"
    HIDROAVIAO_AFUNDOU_MSG      DB "Voce afundou um Hidroaviao!! $"
    

;=======================VARIAVEL QUE DEFINE FIM DE JOGO========================

    VAR_FIM_DE_JOGO DB 0 ;ESSA VARIAVEL DEFINE O FIM DO JOGO, SE ELA FOR ZERO O JOGO ACABA E SE ELA FOR UM O JOGO CONTINUA.


.CODE 

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX

    JOGAR:
    CALL TELA_INICIAL
    CALL MANUAL_INSTRUCAO

    CLEAR_SCREEN ;LIMPA A TELA
    ENDL ;PULA UMA LINHA
    CALL GERA_TABULEIRO ;gera o tabuleiro aleatório das embarcações
    ;MOSTRA A MATRIZ INICIAL NA TELA PARA O USUÁRIO

    ATAQUE:
    CALL PRINT_MATRIZ ;IMPRIME A MATRIZ NA TELA
    CALL PEGAR_COORDENADAS ;PEGA AS COORDENADAS DO ATAQUE DO USUÁRIO
    ENDL
    CALL UPDATE_ATAQUE ;ATUALIZA A MATRIZ COM O ATAQUE DO USUÁRIO
    CLEAR_SCREEN
    ;RETOMA O LOOP DE PEGAR COORDENADAS 
    PROXIMO_TIRO?:
    CALL VERIFICA_AFUNDOU  ;vê se depois de atingida, a embarcação foi afundada
    ;VERIFICAR SE EXISTE AINDA ALGUMA CASA (1), OU SEJA, SE EXISTE EMBARCAÇÃO AINDA, SE N, ENCERRA O JOGO
    ;VERIFICA_FIM_JOGO -->>FAZER UMA VARREDURA DE VERIFICAR SE AINDA EXISTE EMBARCAÇÃO VIVA. OU, PARA CADA EMBARCAÇÃO ATINGIDA ADICIONAR UM COTADOR, E QUANDO O CONTADOR CHEGAR A 6, ACABA
    ;SE NAO TIVER MAIS EMBARCAÇÕES, SAI DESSE LOOP DE ATAQUE
    JMP ATAQUE

    ;SAINDO DO LOOP DE ATAQUE, MOTRA MENSAGEM DE JOGO ACABADO
    ;XOR BX,BX
    ;XOR AX,AX
    ;XOR DX,DX
    ;XOR SI,SI
    ;XOR DI,DI
    ;FINALIZAR_JOGO:
    ;MOSTRA MENSAGEM msgFinalizacao "Deseja jogar novamente (S ou N)? $"
    ;MOV AH, 01
    ;INT 21H
    ;CMP AL, "S"
    ;JE JOGAR
    ;CMP AL, "N"
    ;JE FIM_JOGO
    ;JMP FINALIZAR_JOGO

;TODO:
    ;ADICIONAR ALEATORIAMENTE AS EMBARCAÇÕES NO TABULEIRO
    ;FAZER SISTEMA DE VERIFICAR SE A EMBARCAÇÃO ESTÁ A PELO MENOS UM QUADRADO DE DISTÂNCIA DA OUTRA
    ;FAZER LOOP DE EXIBIÇÃO DE MATRIZ APÓS CADA JOGADA 
    ;CONTABILIZAR ACERTO E ERRO DE EMBARCAÇÕES
    ;adicionar as embarcações no mapa
    ;verificar se as embarcações estão no mesmo lugar / estão separadas por 31H casa
    ;pedir ao player digitar as coordenadas de tiro
    ; Continue o jogo ou finalize se todas as embarcações forem destruídas
    ;verificar se as cordenadas estão dentro do mapa
    ;adicionar isso ao mapa
    ;verificar se o tiro acertou a embarcação ou não
    ;se acertou, marcar com cor diferente a embarcação
    ;se acertou todas, finalizar o jogo
    ;jogar denovo?

    CALL VERIFICA_FIM_JOGO ;VERIFICA SE O JOGO ACABOU, E SE O USUARIO QUISER TERMINAR O JOGO, ELE É ENCERRADO.
    CMP VAR_FIM_DE_JOGO, 1
    JE JOGAR ;SE VAR_FIM_DE_JOGO FOR 1, O JOGO CONTINUA, E SE FOR 0 O JOGO ACABA
    
    FIM_DE_JOGO:
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
    PRINT_COR L0, VERMELHO
    POS_CURSOR 6, 18
    PRINT_COR L1, VERMELHO
    POS_CURSOR 7, 18
    PRINT_COR L2, VERMELHO
    POS_CURSOR 8, 18
    PRINT_COR L3, VERMELHO
    POS_CURSOR 9, 18
    PRINT_COR L4, VERMELHO
    POS_CURSOR 10, 18
    PRINT_COR L5, VERMELHO
    POS_CURSOR 11, 18
    PRINT_COR L, VERMELHO
    POS_CURSOR 12, 18
    PRINT_COR L6, VERMELHO
    POS_CURSOR 13, 18
    PRINT_COR L7, VERMELHO
    POS_CURSOR 14, 18
    PRINT_COR L8, VERMELHO
    POS_CURSOR 15, 18
    PRINT_COR L9, VERMELHO
    POS_CURSOR 16, 18
    PRINT_COR L10, VERMELHO

    POS_CURSOR 18, 25
    PRINT_COR BY, CINZA_ESCURO

    POS_CURSOR 19, 25
    PRINT_COR TIAGO, VERDE

    POS_CURSOR 20, 25
    PRINT_COR RAFAEL, VERDE

    POS_CURSOR 21, 25
    PRINT_COR ARTUR, VERDE



    POS_CURSOR 23, 18
    PRINTS PTC
    PPC

    RET
TELA_INICIAL ENDP


;=================PROCEDIMENTO DE MANUAL DE INSTRUÇÃO================={
;
;  FUNÇÃO: MOSTRAR O MANUAL DE INTRUÇÃO DO JOGO
;
;  COMO USAR: CHAMAR O PROCEDIMENTO AO INICIO DO CODIGO SOMENTE
;  
;  NOME: MANUAL_INSTRUCAO
;
;=================PROCEDIMENTO DE MANUAL DE INSTRUÇÃO=================}
MANUAL_INSTRUCAO PROC
        CLEAR_SCREEN

        ; IMPRIMIR MANUAL DE INSTRUÇÕES
        POS_CURSOR 3, 5
        PRINT_COR REGRAS, CINZA_ESCURO

        POS_CURSOR 6, 5
        PRINT_COR REGRA1, CINZA_CLARO
        POS_CURSOR 7, 5
        PRINT_COR REGRA2, CINZA_CLARO
        POS_CURSOR 8, 5
        PRINT_COR REGRA3, CINZA_CLARO

            POS_CURSOR 9, 8
            PRINT_COR FORM_E, VERMELHO
            POS_CURSOR 10, 8
            PRINT_COR FORM_F, VERMELHO
            POS_CURSOR 11, 8
            PRINT_COR FORM_S, VERMELHO
            POS_CURSOR 12, 8
            PRINT_COR FORM_H, VERMELHO

        POS_CURSOR 13, 5
        PRINT_COR REGRA4, CINZA_CLARO
        POS_CURSOR 14, 5
        PRINT_COR REGRA5, CINZA_CLARO
        POS_CURSOR 15, 5
        PRINT_COR REGRA6, CINZA_CLARO

        POS_CURSOR 18, 5
        PRINT_COR REGRAS, CINZA_ESCURO

        POS_CURSOR 19,8
        PRINTS PTC
        PPC

        RET
MANUAL_INSTRUCAO ENDP
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
    
    MOV CX, CONTADOR ; CX RECEBE TAMANHO DA MATRIZ

    MOSTRAR_MATRIZ:
    PRINTC TABULEIRO[BX][SI]

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
    POS_CURSOR 0, 0
    PRINT_COR BAT_NAV, AZUL

    POS_CURSOR 15, 20
    PRINT_COR MSG_ATAQUE_LINHA, MAGENTA             ; mensagem de pegar coordenadas na tela
    
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
    POS_CURSOR 16, 20
    PRINT_COR MSG_ATAQUE_COLUNA, CIANO            ; mensagem de pegar coordenadas na tela
    
    MOV AH, 01H                         ; pega o caractere
    INT 21h

    
        ; Verifica se a coluna é uma letra minúscula (a-j)
    CMP AL, "a"
    JL CONTINUAR
    CMP AL, "j"
    JG CONTINUAR

    ; Converte letra minúscula para maiúscula
    SUB AL, 20H

CONTINUAR:

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
;                                       ; Mensagem de erro e solicitação de novas coordenadasdas
    POS_CURSOR 18,20
    PRINT_COR MSG_ERRO_MAPA, VERMELHO
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

    CALL ALEATORIO ;PEGA NUMERO ALEATÓRIO
    MOV AX, NUM_ALEATORIO ;ARMAZENA O NUMERO ALEATÓRIO EM AX

SWITCH:
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

UPDATE_ATAQUE PROC;ATUALIZA A MATRIZ COM O ATAQUE DO USUÁRIO PROC
    PUSH_ALL
    ;DI deve permanescer com o offsets da geração de tabuleiro AUX

    MOV AX, POS_LINHA      ; AX = linha
    ADD AX, POS_COLUNA     ;(deslocamento final)
    
    ; Carregar o valor da posição na matriz
    LEA SI, TABULEIRO      ; SI aponta para o início da MATRIZ NORMAL
    LEA DI, TABULEIRO_AUX  ; DI aponta para o início da MATRIZ AUXILIAR
    ADD SI, AX               ; SI aponta para a posição na matriz normal
    ADD DI, AX              ; DI aponta para o elemento da matriz[linha][coluna] do tabuleiro inimigo
    MOV BX, [DI]            ;COMPARA COM O TABULEIRO AUX, DO INIMIGO
;
    ;verificar se o tiro acertou a embarcação ou não
    ;COMPARA COM CADA UMA EMBARCAÇÃO NA MATRIZ AUX
    CMP BX, "f"
    JE ACERTO_FRAGATA
    CMP BX, "e"
    JE ACERTO_ENCORACADO
    CMP BX, "S"
    JE ACERTO_SUBMARINOA
    CMP BX, "s"
    JE ACERTO_SUBMARINOB
    CMP BX, "a"
    JE ACERTO_HIDROAVIAOA
    CMP BX, "h"
    JE ACERTO_HIDROAVIAOB
    CMP BX, 16h
    JE REPETIDO
    CMP BX, 0F7H
    JE REPETIDO
                          ;Verifica se a célula contém uma embarcação

ERROU:
    ; Atualiza o mapa para mostrar o erro (marcar com outro símbolo, ex: '~')
    MOV WORD PTR [SI], 0F7h          ; Marcar erro com '~' no tabuleiro normal
    MOV WORD PTR [DI], 0F7h         ; Marcar erro com '~' no tabuleiro auxiliar para depois comparar com os novos ataques em CALL VERIFICA AFUNDOU 
    JMP FIM_VERIFICACAO
    
    ;dec os cotadores: contFragata DB 3, contEncouracado DB 4, contSubmarino1 DB 2, contSubmarino2 DB 2, contHidroaviao1 DB 4, contHidroaviao2 DB 4

    ACERTO_FRAGATA:
    ; Atualiza o mapa para mostrar o acerto
    MOV WORD PTR [SI], 16h ;TABULEIRO
    MOV WORD PTR [DI], 16h ;TABULEIRO AUX
    DEC contFragata
    JMP FIM_VERIFICACAO

    ACERTO_ENCORACADO:
    ; Atualiza o mapa para mostrar o acerto
    MOV WORD PTR [SI], 16h   
    MOV WORD PTR [DI], 16h 
    DEC contEncouracado        
    JMP FIM_VERIFICACAO

    ACERTO_SUBMARINOA:
    ; Atualiza o mapa para mostrar o acerto
    MOV WORD PTR [SI], 16h
    MOV WORD PTR [DI], 16h
    DEC contSubmarinoA
    JMP FIM_VERIFICACAO

    ACERTO_SUBMARINOB:
    ; Atualiza o mapa para mostrar o acerto
    MOV WORD PTR [SI], 16h   
    MOV WORD PTR [DI], 16h
    DEC contSubmarinoB
    JMP FIM_VERIFICACAO

    ACERTO_HIDROAVIAOA:
    ; Atualiza o mapa para mostrar o acerto
    MOV WORD PTR [SI], 16h  
    MOV WORD PTR [DI], 16h
    DEC contHidroaviaoA
    JMP FIM_VERIFICACAO

    ACERTO_HIDROAVIAOB:
    ; Atualiza o mapa para mostrar o acerto
    MOV WORD PTR [SI], 16h   
    MOV WORD PTR [DI], 16h       
    DEC contHidroaviaoB   
    JMP FIM_VERIFICACAO

    ;verificar se a cordenada ja foi atacada e mostrar mensagem disso
    REPETIDO:
    POS_CURSOR 5,25
    PRINT_COR MSG_COORDENADA_REPETIDA, VERMELHO
    POS_CURSOR 6, 22
    PRINT_COR PTC, CINZA_ESCURO
    PPC 
    ENDL
    

    FIM_VERIFICACAO:

    ;REVER ESSA PARTE
    POP_ALL
    RET

    ;adicionar uma verificação intermediária para garantir que a posição em 
    ;TABULEIRO_AUX ainda não foi acertada antes, caso queira evitar múltiplos acertos na mesma posição.

UPDATE_ATAQUE ENDP;ATUALIZA A MATRIZ COM O ATAQUE DO USUÁRIO ENDPATUALIZA A MATRIZ COM O ATAQUE DO USUÁRIO ENDP
;=======================PROCEDIMENTO DE VERIFICAR AFUNDADOS====================={
;
;   O QUE FAZ: VERIFICA SE EMBARCAÇÃO AFUNDOU, CASO POSITIVO, MOSTRA MENSAGEM
;   COM O NOME DA EMBARCAÇÃO, AVISANDO QUE ELA FOI AFUNDADA
;
;   COMO FAZ: VERIFICA A MATRIZ BUSCANDO UM ELEMENTO, CASO NÃO O ENCONTRE, 
;   MOSTRA MENSAGEM DE AFUNDADA, CASO ENCONTRE, EMBARCAÇÃO NÃO FOI AFUNDADA
;
;   PROCEDIMENTOS CHAMADOS: NENHUM
;
;   MACROS UTILIZADOS: AFUNDOU E PRINTS
;
;   NOME: VERIFICA_AFUNDOU
;
;=======================PROCEDIMENTO DE VERIFICAR AFUNDADOS=====================}
VERIFICA_AFUNDOU PROC

    SWITCH_AFUNDOU:
    ;compara os cotadores:
    ;contFragata DB 3, contEncouracado DB 4, contSubmarino1 DB 2, contSubmarino2 DB 2, contHidroaviao1 DB 4, contHidroaviao2 DB 4

    CMP contEncouracado, 0
    JE ENCOURACADO_AFUNDOU

    CMP contFragata, 0
    JE FRAGATA_AFUNDOU

    CMP contSubmarinoA, 0
    JE SUBMARINOA_AFUNDOU


    JMP GAMBIARRA
    VOLTA:

    JMP FIM_AFUNDOU

ENCOURACADO_AFUNDOU:
    POS_CURSOR 20,25
    INC contEncouracado ;tem que incrementar o contador toda vez que afudar uma embarcação para que ela não seja afundada repetidamente
    PRINT_COR ENCOURACADO_AFUNDOU_MSG, VERMELHO
    PPC
    ENDL
    JMP PRESSIONE_PARA_CONTINUAR

FRAGATA_AFUNDOU:
    POS_CURSOR 20,25
    INC contFragata
    PRINT_COR FRAGATA_AFUNDOU_MSG, VERMELHO
    
    JMP PRESSIONE_PARA_CONTINUAR

SUBMARINOA_AFUNDOU:
    POS_CURSOR 20,25
    INC contSubmarinoA
    PRINT_COR SUBMARINO_AFUNDOU_MSG, VERMELHO
    
    JMP PRESSIONE_PARA_CONTINUAR

SUBMARINOB_AFUNDOU:
    POS_CURSOR 20,25
    INC contSubmarinoB
    PRINT_COR SUBMARINO_AFUNDOU_MSG, VERMELHO 
    JMP PRESSIONE_PARA_CONTINUAR

HIDROAVIAOA_AFUNDOU:
    POS_CURSOR 20,25
    INC contHidroaviaoA
    PRINT_COR HIDROAVIAO_AFUNDOU_MSG, VERMELHO
    
    JMP PRESSIONE_PARA_CONTINUAR

HIDROAVIAOB_AFUNDOU:
    POS_CURSOR 20,25
    INC contHidroaviaoB
    PRINT_COR HIDROAVIAO_AFUNDOU_MSG,VERMELHO
    JMP PRESSIONE_PARA_CONTINUAR
    
GAMBIARRA:
    CMP contSubmarinoB, 0
    JE SUBMARINOB_AFUNDOU

    CMP contHidroaviaoA, 0
    JE HIDROAVIAOA_AFUNDOU

    CMP contHidroaviaoB, 0
    JE HIDROAVIAOB_AFUNDOU

    JMP VOLTA
    
PRESSIONE_PARA_CONTINUAR:
    ENDL
    PPC
    ENDL

FIM_AFUNDOU:
    RET

VERIFICA_AFUNDOU ENDP

;=================PROCEDIMENTO DE VERIFICAÇÃO DE FIM DE JOGO================={
;
;  FUNÇÃO: VERIFICAR SE AINDA EXISTE EMBARCAÇÃO E SE O JOGADOR DESEJA JOGAR NOVAMENTE
;
;  COMO FAZ: PARA CADA EMBARCAÇÃO ATINGIDA, ADICIONAR UM CONTADOR, E QUANDO O CONTADOR CHEGAR A 6, ACABA. 
;
;  NOME: VERIFICA_FIM_JOGO
;
;=================PROCEDIMENTO DE VERIFICAÇÃO DE FIM DE JOGO=================}  

VERIFICA_FIM_JOGO PROC
PUSH_ALL

    CLEAR_SCREEN
    ; Desenho do primeiro navio (esquerdo)
    ; Mastro principal com cordas
    POS_CURSOR 19, 25
    PRINTS MASTRO
    POS_CURSOR 20, 25
    PRINTS MASTRO
    POS_CURSOR 21, 25
    PRINTS MASTRO
    
    ; Cordas do mastro
    POS_CURSOR 19, 24
    PRINTS CORDA
    POS_CURSOR 19, 26
    PRINTS CORDA
    

    ; Segunda vela
    POS_CURSOR 20, 23
    PRINTS VELA3
    POS_CURSOR 21, 23
    PRINTS VELA2

    ; Casco do primeiro navio
    POS_CURSOR 22, 20
    PRINTS CASCO3
    POS_CURSOR 22, 21
    PRINTS CASCO2
    POS_CURSOR 22, 22
    PRINTS CASCO1
    POS_CURSOR 22, 23
    PRINTS CASCO1
    POS_CURSOR 22, 24
    PRINTS CASCO1
    POS_CURSOR 22, 25
    PRINTS CASCO1
    POS_CURSOR 22, 26
    PRINTS CASCO1
    POS_CURSOR 22, 27
    PRINTS CASCO1
    POS_CURSOR 22, 28
    PRINTS CASCO2
    POS_CURSOR 22, 29
    PRINTS CASCO3

    ; Base do casco primeiro navio
    POS_CURSOR 23, 21
    PRINTS CASCO1
    POS_CURSOR 23, 22
    PRINTS CASCO1
    POS_CURSOR 23, 23
    PRINTS CASCO1
    POS_CURSOR 23, 24
    PRINTS CASCO1
    POS_CURSOR 23, 25
    PRINTS CASCO1
    POS_CURSOR 23, 26
    PRINTS CASCO1
    POS_CURSOR 23, 27
    PRINTS CASCO1
    POS_CURSOR 23, 28
    PRINTS CASCO1

; Desenho do segundo navio (direito)
    ; Mastro principal com cordas
    POS_CURSOR 19, 45
    PRINTS MASTRO
    POS_CURSOR 20, 45
    PRINTS MASTRO
    POS_CURSOR 21, 45
    PRINTS MASTRO
    
    ; Cordas do mastro
    POS_CURSOR 19, 44
    PRINTS CORDA
    POS_CURSOR 19, 46
    PRINTS CORDA
    
    ; Vela principal
    POS_CURSOR 19, 46
    PRINTS VELA1
    POS_CURSOR 20, 46
    PRINTS VELA3
    POS_CURSOR 21, 46
    PRINTS VELA2

    ; Segunda vela
    POS_CURSOR 20, 43
    PRINTS VELA3
    POS_CURSOR 21, 43
    PRINTS VELA2

    ; Casco do segundo navio
    POS_CURSOR 22, 40
    PRINTS CASCO3
    POS_CURSOR 22, 41
    PRINTS CASCO2
    POS_CURSOR 22, 42
    PRINTS CASCO1
    POS_CURSOR 22, 43
    PRINTS CASCO1
    POS_CURSOR 22, 44
    PRINTS CASCO1
    POS_CURSOR 22, 45
    PRINTS CASCO1
    POS_CURSOR 22, 46
    PRINTS CASCO1
    POS_CURSOR 22, 47
    PRINTS CASCO1
    POS_CURSOR 22, 48
    PRINTS CASCO2
    POS_CURSOR 22, 49
    PRINTS CASCO3

    ; Base do casco segundo navio
    POS_CURSOR 23, 41
    PRINTS CASCO1
    POS_CURSOR 23, 42
    PRINTS CASCO1
    POS_CURSOR 23, 43
    PRINTS CASCO1
    POS_CURSOR 23, 44
    PRINTS CASCO1
    POS_CURSOR 23, 45
    PRINTS CASCO1
    POS_CURSOR 23, 46
    PRINTS CASCO1
    POS_CURSOR 23, 47
    PRINTS CASCO2
    POS_CURSOR 23, 48
    PRINTS CASCO3

        ; Agua
    POS_CURSOR 24, 0
    PRINT_COR AGUA, AZUL
  

    ;MOSTRA MENSAGEM DE JOGO ACABADO
    POS_CURSOR 5, 10
    PRINT_COR R0, AZUL
    POS_CURSOR 6, 10
    PRINT_COR R, AZUL
    POS_CURSOR 7, 10
    PRINT_COR R, AZUL
    POS_CURSOR 8, 10
    PRINT_COR R, AZUL
    POS_CURSOR 9, 10
    PRINT_COR R, AZUL
    POS_CURSOR 11, 10
    PRINT_COR R, AZUL
    POS_CURSOR 12, 10
    PRINT_COR R, AZUL
    POS_CURSOR 13, 10
    PRINT_COR R, AZUL
    POS_CURSOR 14, 10
    PRINT_COR R, AZUL
    POS_CURSOR 15, 10
    PRINT_COR R, AZUL
    POS_CURSOR 16, 10
    PRINT_COR R10, AZUL

    POS_CURSOR 10, 71
    PRINT_COR TRACINHO, AZUL ;PRINTA O FINAL DA BOX EM QUE A MENSAGEM ESTA INSERIDA
    POS_CURSOR 10, 10
    PRINT_COR TRACINHO, AZUL
    POS_CURSOR 10, 19
    PRINT_COR MSG_FIM_JOGO, VERDE;PRINTA A MENSAGEM DE FIM DE JOGO


JMP VERIFICA_RESPOSTA_FIM_JOGO

ERRO_FIM_JOGO:
 
    POS_CURSOR 11, 16
    PRINT_COR MSG_ERRO_FIM_JOGO, CIANO ;PRINTA A MENSAGEM DE ERRO DE FIM DE JOGO

VERIFICA_RESPOSTA_FIM_JOGO:
    MOV AH, 01
    INT 21H

        ; Verifica se a coluna é uma letra minúscula (a-z)
    CMP AL, "a"
    JL CONTINUAR1
    CMP AL, "z"
    JG CONTINUAR1

    ; Converte letra minúscula para maiúscula
    SUB AL, 20H
CONTINUAR1:

    CMP AL, 'S'
    JE CONTINUAR_JOGO
    CMP AL, 'N'
    JE PARAR_JOGO

    JMP ERRO_FIM_JOGO

   PARAR_JOGO:
    MOV VAR_FIM_DE_JOGO, 0
    POP_ALL
    RET

    CONTINUAR_JOGO:
    MOV VAR_FIM_DE_JOGO, 1
    POP_ALL
    RET
VERIFICA_FIM_JOGO ENDP

;====================PROCEDIMENTO PARA MUDAR COR DE STRINGS====================={
;
;   COMO FUNCIONA: SALVA O ENDERECO DA STRING EM SI E DA COR EM BL
;
;   ONDE USAR: QUANDO QUISER COLORIR UM TEXTO
;
;   PROCEDIMENTOS CHAMADOS: NENHUM
;   
;   MACROS USADOS: TAB
;
;====================PROCEDIMENTO PARA MUDAR COR DE STRINGS=====================}
MUDA_COR PROC                  ;Funcao imprime_color
    PUSH AX                         ;Feita para padronizar a impressao de cor ao longo do programa e
    PUSH CX                         ;quando for feita a chamada dela apenas precisa passar o parametro
    PUSH SI                         ;de cor para BL.
    
    XOR BH, BH                      ;Zera bit superior de bx
    MOV CX,1 
    
    REPETE:               
        MOV AH, 9                  ;chama a funcao de colocar o caracter na tela                     
        MOV AL,[SI]                ;incrementa para poder ir para o proximo caracter e imprimir a string totalmente 
        INT 10H 
       
        INC SI 
        TAB 1
        
        MOV AL,[SI]
        CMP AL,'$'
        JNE REPETE                  ;Fim de string marcada com $, logo enuanto for diferente, percorre a string
    
    POP SI
    POP CX
    POP AX    
    RET  
MUDA_COR ENDP



END MAIN
