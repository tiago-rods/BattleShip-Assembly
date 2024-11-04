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
;=================================== DEFINIÇÃO DE EMBARCAÇÕES
    ENCOURACADO DW 31H,31H,31H,31H

    FRAGATA     DW 31H,31H,31H

    SUBMARINO   DW 31H,31H

    HIDROAVAO   DW 1,1,1
                DW 0,1,0
   
;==================================== VARIÁVEIS DE CONTROLE PARA IMPRIMIR A MATRIZ
    CONTADOR EQU 208
    FIM_LINHA EQU 30
    ULTIMA_POS EQU 400

;==================================== MATRIZ PARA DESENHO DE TABULEIRO
  TABULEIRO    DW 0C9h, 14 DUP(0CDh), 0BBh
               DW 0BAH, 32, 32, 32, 41H,42H,43H,44H,45H,46H,47H,48H,49H,4AH, 32, 0BAH
               DW 0BAH, 32, 30H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 31H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 32H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 33H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 34H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 35H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 36H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 37H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 38H, 32, 10 DUP(30H), 32, 0BAH
               DW 0BAH, 32, 39H, 32, 10 DUP(30H), 32, 0BAH
               DW 0C8h, 14 DUP(0CDh), 0BCh       
;======================================= OUTRAS STRINGS

    PTC DB "Pressione qualquer tecla para continuar ... $" ;PTC VEM DE PRESS TO CONTINUE

;======================================= STRINGS PARA PROCEDIMENTO "PEGAR COORDENADAS PROC"

    MSG_ATAQUE_LINHA  DB 10, 13, "Digite o numero da linha para o ataque: $"
    MSG_ATAQUE_COLUNA DB 10, 13, "Digite o numero da coluna para o ataque: $"
    POS_LINHA         DW ? ;LINHA É DW POR CAUSA DO MAPA SER DW
    POS_COLUNA        DW ?  ;COLUNA É DW POR CAUSA DO MAPA SER DW
    MSG_ERRO_MAPA     DB 10, 13, "Coordenada inválidas, digite uma coordenada dentro do limite do mapa $"
;==================================== VARIÁVEIS DE CONTROLE PARA IMPRIMIR A MATRIZ
    CONTADOR EQU 208
    FIM_LINHA EQU 30
    ULTIMA_POS EQU 400
;====================================== STRING PARA PROCEDIMENTO "ALEATORIO"

    NUM_ALEATORIO DW ?
    RESULTADO     DW ?

;====================================== STRING PARA PROCEDIMENTO "ALEATORIO_LINHA"

    NUM_ALEATORIO_LINHA DW ?
    RESULTADO_LINHA     DW ?

;====================================== STRING PARA PROCEDIMENTO "ALEATORIO_MODULO2"
    ;MOD2_ALEATORIO
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



;----------PROCEDIMENTO PARA IMPRIMIR MATRIZ--------{
;
;  FUNÇÃO DO PROCEDIMENTO: IMPRIMIR MATRIZ DE 16BITS,(DW)
;
;  ONDE USAR: QUANDO QUISER IMPRIMIR UMA MATRIZ DW
;
;  COMO USAR: CHAMAR O PROCEDIMENTO
;
;  NOME: PRINT_MATRIZ
;
;----------PROCEDIMENTO PARA IMPRIMIR MATRIZ--------}
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

    MOV RESULTADO, AX              ; Armazena o resultado em RESULTADO
    RET

ALEATORIO ENDP

;=================PROCEDIMENTO DE GERAR NÚMERO ALEATÓRIO PARA LINHA================={
;
;  FUNÇÃO: GERAR UM NÚMERO ALEATÓRIO ENTRE 0 E 9, O QUAL É MULTIPLICADO 
;  POR 32 POIS ESTE INDICA O NÚMERO INICIAL DE LINHAS DA MATRIZ TABULEIRO,
;  ASSIM POSICIONA EMBARCAÇÕES DE FORMA ALEATÓRIA ENTRE AS LINHAS DO TABULEIRO
;
;  COMO USAR: CHAMAR QUANDO PRECISAR POSICIONAR EMBARCAÇÕES AO COMEÇO DO JOGO
;
;  COMO FUNCIONA: GERA UM NÚMERO ALEATÓRIO ENTRE 0 E 9 COM A INTERRUPÇÃO 1AH
;  DIVIDE POR 10 PARA GERAR ESTE NÚMERO EX X % 10 = 0<=X<=9 * 32
;
;  PROCEDIMENTOS CHAMADOS: ALEATORIO
;
;  NOME: ALEATORIO_LINHA
; 
;=================PROCEDIMENTO DE GERAR NÚMERO ALEATÓRIO PARA LINHA=================}
ALEATORIO_LINHA PROC
    CALL ALEATORIO

    MOV NUM_ALEATORIO_LINHA, DL    ; Número aleatório (0-9) armazenado em DL
    MOV AL, NUM_ALEATORIO_LINHA    ; Move o número aleatório para AL
    MOV BL, 32                     ; Multiplicador
    MUL BL                         ; Multiplica AL (número aleatório) por BL (32)
    ADD AX, 64

    MOV RESULTADO_LINHA, AX        ; Armazena o resultado em RESULTADO
    RET
ALEATORIO_LINHA ENDP
;=================PROCEDIMENTO DE GERAR NÚMERO ALEATÓRIO EM MÓDULO 2================={
;
;  FUNÇÃO: GERAR UM NÚMERO ALEATÓRIO ENTRE 0 E 1
;
;  COMO USAR: USADO PARA DEFINIR SE A EMBARCAÇÃO TERÁ ORIENTAÇÃO VERTICAL OU HORIZONTAL
;
;  COMO FUNCIONA: GERA UM NÚMERO ALEATÓRIO E DIVIDE POR MODULO 2, EX: X % 2 = 0<=X<=1, NUM NATURAL
;
;  PROCEDIMENTOS CHAMADOS: NENHUM
;
;  NOME: ALEATORIO_MODULO2
; 
;=================PROCEDIMENTO DE GERAR NÚMERO ALEATÓRIO EM MÓDULO 2=================}
ALEATORIO_MODULO2 PROC
    MOV AH, 0H                     ; Chama a interrupção 1Ah para obter o número de ticks
    INT 1AH

    MOV AX, DX                     ; Coloca o valor do timer em AX
    MOV DX, 0                      ; Limpa DX para a divisão
    MOV BX, 2                      ; O divisor é 10 para limitar o valor de 0 a 1
    DIV BX                         ; Divide AX por 2
    MOV MOD2_ALEATORIO, DL   

    RET 
ALEATORIO_MODULO2 ENDP

;=================PROCEDIMENTO PARA PEGAR POSIÇÃO DE ATAQUE DO JOGADOR================={
;
;  FUNÇÃO: PEGAR RESPECTIVAMENTE LINHA E COLUNA A QUAL O JOGADOR DESEJA ATACAR, ADEMAIS
;  VERIFICA SE O LOCAL ESTÁ DENTRO OU FORA DA ÁREA DE ATAQUE
;  
;  COMO USAR: CHAMAR QUANDO O JOGADOR FOR ATACAR
;
;   NOME: PEGAR_COORDENADAS
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
    
ENDP PEGAR_COORDENADAS
;+++++++++PROCEDIMENTOS EM PROGRESSO++++++++++++

;================ PROCEDIMENTO POSICIONAR_EMBARCACOES ================={
;
; FUNÇÃO: POSICIONA EMBARCAÇÕES NO TABULEIRO EM POSIÇÕES ALEATÓRIAS
;
; COMO USAR: CHAMAR AO INÍCIO DO JOGO PARA COLOCAR AS EMBARCAÇÕES
;
; COMO FUNCIONA: PEGA CADA EMBARCAÇÃO E ENVIA PARA OUTRO PROCEDIMENTO 
; O QUAL POSICIONA ALEATÓRIAMENTE ESTA EMBARCAÇÃO
;
; PROCEDIMENTOS CHAMADOS: COLOCAR_EMBARCACAO
;
; NOME: POSICIONAR_EMBARCACOES
;
;================ PROCEDIMENTO POSICIONAR_EMBARCACOES =================}
POSICIONAR_EMBARCACOES PROC
    PUSH_ALL

    ; Posiciona o Encouraçado
    MOV CX, 4
    MOV DI, OFFSET ENCOURACADO         ; Ponteiro para o primeiro bloco do Encouraçado
    CALL COLOCAR_EMBARCACAO

    ; Posiciona a Fragata
    MOV CX, 3
    MOV DI, OFFSET FRAGATA             ; Ponteiro para o primeiro bloco da Fragata
    CALL COLOCAR_EMBARCACAO

    ; Posiciona o Submarino
    MOV CX, 2
    MOV DI, OFFSET SUBMARINO           ; Ponteiro para o primeiro bloco do Submarino
    CALL COLOCAR_EMBARCACAO

    ; Posiciona o Hidroavião
    MOV CX, 6
    MOV DI, OFFSET HIDROAVIAO          ; Ponteiro para o primeiro bloco do Hidroavião
    CALL COLOCAR_EMBARCACAO

    POP_ALL
    RET
POSICIONAR_EMBARCACOES ENDP

;================ PROCEDIMENTO COLOCAR AS EMBARCAÇÕES ================={
;
; FUNÇÃO: COLOCAR UMA EMBARCAÇÃO ESPECIFICADA NO PROCEDIMENTO ANTERIOR
; EM UMA POSIÇÃO ALEATORIA NO TABULEIRO
;
; COMO USAR: PASSAR O NOME DA EMBARCAÇÃO COMO "PARÂMETRO", E CHAMAR
; OUTROS PROCEDIMENTOS OS QUAIS: GEREM UMA COORDENADA ALEATORIA, 
; VERIFICAM A DISPONIBILIDADE DESTA COORDENADA E POSICIONA O BLOCO
; DA EMBARCAÇÃO
;
; COMO FUNCIONA: PEGA O NOME DA EMBARCAÇÃO, GERA UMA COORDENADA, VE-
; RIFICA A COORDENADA DESTA EMBARCAÇÃO E POSICIONA A EMBARCAÇÃO,
; PASSA CX COMO "PARÂMETRO" E ESTE É O TAMANHO DE POSIÇÕES DA EMBARCAÇÃO
;
; PROCEDIMENTOS USADOS: GERAR_COORDENADA_ALEATORIA, VERIFICAR_DISPONIBILIDADE
; POSICIONAR_BLOCOS
;
; NOME: COLOCAR_EMBARCAÇÃO
;
;================ PROCEDIMENTO COLOCAR AS EMBARCAÇÕES =================}

; Procedimento para colocar uma embarcação específica nas coordenadas aleatórias
COLOCAR_EMBARCACAO PROC
PROXIMA_POSICAO:
    CALL GERAR_COORDENADA_ALEATORIA      ; Gera posição aleatória inicial em DX
    CALL POSICIONAR_BLOCOS                ; Posiciona os blocos da embarcação partindo de DI
    CALL VERIFICAR_DISPONIBILIDADE       ; Verifica se a posição inicial é válida

    CMP AX, 1                             ; AX = 1 se posição é válida
    JNE PROXIMA_POSICAO                   ; Tenta outra posição se for inválida

    ; Posiciona a embarcação

    RET
COLOCAR_EMBARCACAO ENDP

;================ PROCEDIMENTO PARA POSICIONAR BLOCOS DAS EMBARCAÇÕES ================={
;
; FUNÇÃO: GERA UMA ORIENTAÇÃO: VERTICAL OU HORIZONTAL, PARA A EMBARCAÇÃO E A POSICIONA
;
; COMO USAR: CHAMA-LA DENTRO DE "COLOCAR_EMBARCACAO" E VERIFICAR SE O POSICIONAMENTO 
; DOS BLOCOS É VALIDO 
;
; COMO FUNCIONA: GERA UM NÚMERO ENTRE 0 E 1, CASO SEJA 0, A ORIENTAÇÃO SERA HORIZONTAL
; CASO CONTRARIO SERÁ VERTICAL, FAZ 2 LOOPS PARA POSICIONAR OS BLOCOS DA EMBARCAÇÃO,
; UM PARA VERTICAL E UM PARA HORIZONTAL
;
; PROCEDIMENTOS USADOS: NENHUM
;
; NOME: POSICIONAR_BLOCOS
;
;================ PROCEDIMENTO PARA POSICIONAR BLOCOS DAS EMBARCAÇÕES =================}

POSICIONAR_BLOCOS PROC
    PUSH SI                ; Salva SI (para preservar o ponteiro do bloco atual)
    PUSH DX                ; Salva DX (coordenada inicial)
    PUSH BX                ; Salva BX (para calcular o deslocamento)
    
    MOV SI, DI             ; SI aponta para o primeiro bloco da embarcação
    MOV BX, DX             ; BX é a posição inicial no tabuleiro

    CALL ALEATORIO_MODULO2
    MOV DIRECAO, DL

    ; Verifica direção de posicionamento
    CMP DIRECAO, 0
    JE POSICAO_HORIZONTAL

POSICAO_VERTICAL:
    ; Posiciona a embarcação verticalmente
    MOV AX, 32             ; 32 bytes para mover para a próxima linha (considerando 32 colunas por linha)

POSICIONAR_LOOP_VERTICAL:
    MOV TABULEIRO[BX], [SI] ; Coloca o bloco da embarcação na posição atual
    ADD BX, AX              ; Move para a próxima linha no tabuleiro (verticalmente)
    ADD SI, 2               ; Avança para o próximo bloco da embarcação
    LOOP POSICIONAR_LOOP_VERTICAL
    JMP FIM_POSICIONAR_BLOCOS

POSICAO_HORIZONTAL:
    ; Posiciona a embarcação horizontalmente
    MOV AX, 2               ; Move uma posição para a direita (2 bytes por posição)

POSICIONAR_LOOP_HORIZONTAL:
    MOV TABULEIRO[BX], [SI] ; Coloca o bloco da embarcação na posição atual
    ADD BX, AX              ; Move para a próxima coluna no tabuleiro (horizontalmente)
    ADD SI, 2               ; Avança para o próximo bloco da embarcação
    LOOP POSICIONAR_LOOP_HORIZONTAL

FIM_POSICIONAR_BLOCOS:
    POP BX
    POP DX
    POP SI
    RET
POSICIONAR_BLOCOS ENDP

;================= PROCEDIMENTO GERAR_COORDENADA_ALEATORIA ================={
;
; FUNÇÃO: GERA COORDENADAS ALEATÓRIAS PARA POSICIONAR AS EMBARCAÇÕES
;
; COMO USAR: CHAMAR QUANDO PRECISAR DE COORDENADAS ALEATÓRIAS
;
; COMO FUNCIONA: GERA UMA LINHA ALEATÓRIA ENTRE 0 E 9 (CADA LINHA COME-
; ÇA COM MÚLTIPLOS DE 32) E COLUNAS ALEATÓRIAS ENTRE 0 E 9 E SOMA AMBAS
; COORDENADAS PARA GERAR UMA POSIÇÃO NA MATRIZ TABULEIRO
; OBS: ALGO PARA INCLUIR, O NÚMERO NÃO PODE SER EQUIVALENTE A NENHUMA 
; DAS 2 PRIMEIRAS LINHAS E NEM A ULTIMA E TAMBÉM NENHUMA DAS 4 PRIMEIRAS 
; COLUNAS NEM NA ULTIMA
;
; PROCEDIMENTOS CHAMADOS: ALEATORIO_LINHA, ALEATORIO.
;
;================= PROCEDIMENTO GERAR_COORDENADA_ALEATORIA =================}
GERAR_COORDENADA_ALEATORIA PROC
    ;TODO: FAZER COM QUE NÃO SEJA NENHUMA DAS 2 PRIMEIRAS LINHAS, NEM A ÚLTIMA E FAZER COM QUE NÃO SEJA NENHUMA DAS 4 PRIMEIRAS LINHAS, NEM A ÚLTIMA
    ; Gera linha aleatória entre 0 e 9
    CALL ALEATORIO_LINHA             ; Chama um procedimento para gerar linha aleatória
    MOV AX, NUM_ALEATORIO_LINHA      ; Resultado da linha está em AX
    
    ; Gera coluna aleatória entre 0 e 9
    CALL ALEATORIO                   ; Chama ALEATORIO para gerar coluna
    ADD AX, 4
    ADD AX, NUM_ALEATORIO            ; Soma com a linha
    
    ; Multiplica por 32 para ajustar a posição correta no tabuleiro
    SHL AX, 5                        ; Multiplica por 32
    MOV DX, AX                       ; Move para DX, que agora contém a posição inicial

    RET
GERAR_COORDENADA_ALEATORIA ENDP

;================= PROCEDIMENTO VERIFICAR_DISPONIBILIDADE =================={
;
; FUNÇÃO: VERIFICA SE A POSIÇÃO ESTÁ DISPONÍVEL, E COMPARA COM AS ADJACEN-
; TES PARA VER SE ESTAS TAMBÉM NÃO ESTÃO OCUPADAS
; OBS: TOMAR CUIDADO PARA NÃO COMPARAR COM POSIÇÃO DA PRÓPRIA EMBARCAÇÃO
; E CAUSAR UM ERRO
;
; COMO USAR: CHAMAR ANTES DE POSICIONAR UMA EMBARCAÇÃO. 
; O ENDEREÇO PARA VERIFICAÇÃO DEVE SER PASSADO POR BP E COLOCADO EM BX.
;
; COMO FUNCIONA: VERIFICA SE A POSIÇÃO ESTÁ OCUPADA, E COMPARA COM AS POSI-
; ÇÕES ADJACENTES, SE NÃO ESTIVER OCUPADA, RETORNA 1, SE ESTIVER OCUPADA RETORNA 0
;
; NOME: VERIFICAR_DISPONIBILIDADE
;
;================= PROCEDIMENTO VERIFICAR_DISPONIBILIDADE ==================}
VERIFICAR_DISPONIBILIDADE PROC
    PUSH BX
    MOV BX, BP                           ; Move valor de BP para BX
    MOV AX, TABULEIRO[BX]                ; Verifica a posição atual

    ; Verifica se a posição está ocupada
    CMP AX, 30H                          ; Se a posição é livre (30H)
    JNE POSICAO_INVALIDA                 ; Se não é livre, posição inválida

    ; Verifica a proximidade
    MOV BX, DX

    ; Verifica todas as posições adjacentes
    ; Superior
    CMP TABULEIRO[BX - 32], 30H         ; Verifica acima (linha anterior)
    JNE POSICAO_INVALIDA

    ; Inferior
    CMP TABULEIRO[BX + 32], 30H         ; Verifica abaixo (linha seguinte)
    JNE POSICAO_INVALIDA

    ; Esquerda
    CMP TABULEIRO[BX - 2], 30H          ; Verifica à esquerda
    JNE POSICAO_INVALIDA

    ; Direita
    CMP TABULEIRO[BX + 2], 30H          ; Verifica à direita
    JNE POSICAO_INVALIDA

    ; Se todas as verificações passarem
POSICAO_VALIDA:
    MOV AX, 1                            ; Posição válida
    JMP FINALIZAR_VERIFICACAO

POSICAO_INVALIDA:
    XOR AX, AX                            ; Posição inválida

FINALIZAR_VERIFICACAO:
    POP DX
    RET
VERIFICAR_DISPONIBILIDADE ENDP


VERIFICAR_ATAQUE PROC
    PUSH_ALL
    MOV AX, POS_LINHA      ; AX = linha
    ADD AX, POS_COLUNA     ;(deslocamento final)

    ; Carregar o valor da posição na matriz
    LEA SI, TABULEIRO      ; SI aponta para o início da matriz
    ADD SI, AX             ; SI aponta para o elemento matriz[linha][coluna]
    MOV BX, [SI]
;                                       ;Verifica se a célula contém uma embarcação (por exemplo, valor 1)
    CMP BX, "1"                         ;compara com o tabuleiro que contém as embarcações (VERIFICAR ISSO DEPOIS PARA QUE SEJA COMPARADO COM OUTRO TABULEIRO)
    JE ACERTOU                          ; Se for 1, acertou a embarcação
    JMP ERROU                           ; Se não, errou

    ;verificar se o tiro acertou a embarcação ou não
    ;se acertou, marcar com cor diferente/X a embarcação
ACERTOU:
    ; Atualiza o mapa para mostrar o acerto (marcar com outro símbolo, ex: 'X')
    MOV WORD PTR [SI], 'X'           ; Marcar acerto com 'X'
    JMP FIM_VERIFICACAO

ERROU:
    ; Atualiza o mapa para mostrar o erro (marcar com outro símbolo, ex: 'O')
    MOV WORD PTR [SI], "O"           ; Marcar erro com 'O'
    POP_ALL
    RET
VERIFICAR_ATAQUE ENDP

END MAIN