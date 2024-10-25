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
    PUSH CX

    MOV AH, 2   
    MOV DL, 13  ; Carriage Return
    INT 21h        
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

;----------MACRO PARA IMPRIMIR MATRIZ--------{
;
;  FUNÇÃO DO MACRO: IMPRIMIR MATRIZ DE 16BITS,(DW)
;
;  ONDE USAR: QUANDO QUISER IMPRIMIR UMA MATRIZ DW
;
;  COMO USAR: CHAMAR O MACRO, PASSAR A MATRIZ, TAMANHO
;  DA MATRIZ, TAMANHO DA LINHA E A ULTIMA POSIÇÃO DA MATRIZ
;
;  EXEMPLO DE USO: PRINT_MATRIZ MATRIZ, 4, 2, 8
;
;  NOME: PRINT_MATRIZ
;
;----------MACRO PARA IMPRIMIR MATRIZ--------}
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

;-----------MACRO PARA POSICIONAR CURSOR------------{
;
;  POSICIONA O CURSOR NA TELA
;
;   : LINHA, COLUNA
;
;
;
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
    MSG_ATAQUE_LINHA DB "Digite o numero da linha para o ataque: $"
    MSG_ATAQUE_COLUNA DB "Digite o numero da coluna para o ataque: $"
    POS_LINHA DW ? ;LINHA É DW POR CAUSA DO MAPA SER DW
    POS_COLUNA DW ?  ;COLUNA É DW POR CAUSA DO MAPA SER DW
    VET_TIRO DW ?, ?
    MSG_ERRO_MAPA DB "Coordenada inválidas, digite uma coordenada dentro do limite do mapa"
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

    ;adicionar as embarcações no mapa
    ;verificar se as embarcações estão no mesmo lugar / estão separadas por 1 casa
    ;pedir ao player digitar as coordenadas de tiro


    PEGAR_COORDENADAS:

    ;ATACAR LINHA 
    MOV AX, 09H
    LEA DX, MSG_ATAQUE_LINHA ;mensagem de pegar coordenadas na tela
    INT 21H
    
    MOV AX, 01H ;pega o caractere
    INT 21H
    
    ; Verifica se a linha está dentro do limite (0 a 9)
    CMP POS_LINHA, "0"
    JL FORA_DO_MAPA  ; Linha menor que 0, fora do mapa
    CMP POS_LINHA, "9"
    JG FORA_DO_MAPA  ; Linha maior que 9, fora do mapa

    SUB AL, 29H ;converte para um valor numerico entre 1 e 10
    ;agora, será necessário multiplicar por 24 para que ele entre de acordo com o valor da matriz
    MOV BX, 24 ;multiplica por 24 pq EX: 1x24= 24, 2x24=48, e isso ocorre pq a matriz entra, de fato na posição 24, 48, 72, etc
    MUL BX ;DX:AX -> AX.BX

    MOV POS_LINHA, AX ; joga a coordenada de tiro do jogador na variavel DE LINHA, mesmo estando em AL, precisa ser assim pq é 16 bits p 16 bits

    XOR AX, AX
    XOR BX, BX

    ;ATACAR COLUNA
    MOV AX, 09H
    LEA DX, MSG_ATAQUE_COLUNA ;mensagem de pegar coordenadas na tela
    INT 21h
    
    MOV AX, 01H ;pega o caractere
    INT 21h

    ; Verifica se a coluna está dentro do limite (A a J)
    CMP POS_COLUNA, "A"
    JL FORA_DO_MAPA  ; Coluna menor que A, fora do mapa
    CMP POS_COLUNA, "J"
    JG FORA_DO_MAPA  ; Coluna maior que J, fora do mapa

    SUB AL, 40H  ;tira 40h para realizar as contas
    MOV BX, 2   ;multiplica por 2 para que ele entre de acordo com o valor da matriz -> EX: A=(41h-40).2 = 2; B=4, C=6, isso ocorre pq a matriz vai de 2 em 2 e ela começa no 2
    MUL BX

    MOV POS_COLUNA, AX ; joga a coordenada de tiro do jogador na variavel DE COLUNA, mesmo estando em AL, precisa ser assim pq é 16 bits p 16 bits

    ;COM ISSO FEITO, É POSSÍVEL ACESSAR A MATRIZ POR TABULEIRO[POS_LINHA][POS_COLUNA]

    ; Se as coordenadas estão no limite do mapa, continue
    JMP VERIFICAR_ATAQUE

    FORA_DO_MAPA:
    ; Mensagem de erro e solicitação de novas coordenadasDAS
    LEA DX, MSG_ERRO_MAPA
    MOV AH, 9
    INT 21H
    JMP PEGAR_COORDENADAS  ; Volta para pegar novas coordenadas

    VERIFICAR_ATAQUE:
    ; Calcula o deslocamento dentro da matriz 10x10
    PUSH_ALL

    ; Verifica se a célula contém uma embarcação (por exemplo, valor 1)
    MOV BX, POS_LINHA
    MOV DI, POS_COLUNA
    CMP TABULEIRO[BX][DI], 1
    JE ACERTOU              ; Se for 1, acertou a embarcação
    JMP ERROU               ; Se não, errou


    ;######CONTINUAR DAQUI#######
ACERTOU:
    ; Atualiza o mapa para mostrar o acerto (marcar com outro símbolo, ex: 'X')
    MOV [SI], 'X'           ; Marcar acerto com 'X'
    JMP FIM_VERIFICACAO

ERROU:
    ; Atualiza o mapa para mostrar o erro (marcar com outro símbolo, ex: 'O')
    MOV [SI], 'O'           ; Marcar erro com 'O'

FIM_VERIFICACAO:
    ; Exibe o mapa atualizado
    CALL MOSTRAR_TABULEIRO
    JMP PEGAR_COORDENADAS ;vai para o próximo tiro
    ;RETOMA O LOOP

PROXIMO_TIRO:
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


ALEATORIO PROC
    MOV AH, 0H                     ; Chama a interrupção 1Ah para obter o número de ticks
    INT 1AH

    MOV AX, DX                     ; Coloca o valor do timer em AX
    MOV DX, 0                      ; Limpa DX para a divisão
    MOV BX, 10                     ; O divisor é 10 para limitar o valor de 0 a 9
    DIV BX                         ; Divide AX por 10
    MOV NUM_ALEATORIO, DL          ; Armazena o resto (0-9) em RANDOMNUM

    MOV AL, NUM_ALEATORIO          ; Move o número aleatório para AL
    MOV BL, 24                     ; Multiplicador
    MUL BL                         ; Multiplica AL (número aleatório) por BL (24)

    MOV RESULTADO, AL               ; Armazena o resultado em RESULT
    RET

ALEATORIO ENDP

END MAIN
