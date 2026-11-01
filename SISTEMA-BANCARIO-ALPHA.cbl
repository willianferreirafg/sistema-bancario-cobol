       IDENTIFICATION DIVISION.
           PROGRAM-ID. SB-LOGIN.
           AUTHOR. "WILLIAN FERREIRA GONÇALVES"
           DATE-WRITTEN. "31/10/2026"
           DATE-COMPILED. "31/10/2026"
           REMARKS. "Sistema Bancário"

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT OPTIONAL SB-CONTAS-ARQUIVO
               ASSIGN TO
               "C:\dev\cobol-arquivos\contas-arquivo.dat"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY IS CONTAS-ID
               FILE STATUS IS WS-STATUS.

           DATA DIVISION.
           FILE SECTION.
           FD SB-CONTAS-ARQUIVO.
               01 CONTAS-REGISTRO.
                   05  CONTAS-ID    PIC X(6).
                   05  CONTAS-SALDO PIC S9(7)V99.

           WORKING-STORAGE SECTION.
           01  WS-STATUS            PIC XX.
           01  OPERACAO-SELECIONADA PIC X.
           01  VOLTAR-SAIR          PIC X.
           01  VALOR-DEPOSITO       PIC S9(7)V99.
           01  VALOR-SAQUE          PIC S9(7)V99.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           PERFORM ABRIR-ARQUIVO
           PERFORM MENU-E-SISTEMA
           PERFORM FECHAR-ARQUIVO
           STOP RUN.

       ABRIR-ARQUIVO.
           IF WS-STATUS = "00"
               DISPLAY "--------< CARREGANDO >--------"
               DISPLAY "--------< BEM-VINDO >--------"
           ELSE
               DISPLAY "--------< ERRO DE ACESSO >--------"
               DISPLAY "CODIGO: " WS-STATUS
           END-IF.

       MENU-E-SISTEMA.
           PERFORM PERGUNTA-INICIO

           READ SB-CONTAS-ARQUIVO
               KEY IS CONTAS-ID

               INVALID KEY
                   DISPLAY "--------< NÃO ENCONTRADO >--------"
                   GO TO PERGUNTA-INICIO
               NOT INVALID KEY
                   PERFORM OPERACAO

       PERGUNTAS.
           PERGUNTA-INICIO.
               DISPLAY "Entre com seu CPF:"
               ACCEPT CONTAS-ID.

           PERGUNTA-OPERACAO.
               DISPLAY "----------------------------------"
               DISPLAY "Conta: " CONTAS-ID
               DISPLAY "----------------------------------"
               DISPLAY ZERO
               DISPLAY "1 - Consultar saldo"
               DISPLAY "2 - Depositar saldo"
               DISPLAY "3 - Sacar saldo"
               ACCEPT OPERACAO-SELECIONADA.

       OPERACAO-VOLTAR-SAIR.
           EVALUATE VOLTAR-SAIR
               WHEN 1
                   PERFORM PERGUNTA-OPERACAO
               WHEN 2
                   DISPLAY "--------< SAINDO... >--------"
                   STOP RUN.
               WHEN DEFAULT
                   DISPLAY "--------< NÃO ENCONTRADO >--------"
                   DISPLAY "--------< RETORNANDO... >--------"
                   PERFORM PERGUNTA-OPERACAO.
           END-EVALUATE.

       OPERACAO.
           EVALUATE OPERACAO-SELECIONADA
               WHEN 1
                   READ SB-CONTAS-ARQUIVO.
                       KEY IS CONTAS-ID
                       DISPLAY "CONTA: " CONTAS-ID
                       DISPLAY "SALDO: " CONTAS-SALDO
                   END-READ.
                   DISPLAY "--------< SELECIONE >--------"
                   DISPLAY "1 - Voltar"
                   DISPLAY "2 - Sair"
                   ACCEPT VOLTAR-SAIR.
                   PERFORM OPERACAO-VOLTAR-SAIR

                   WHEN 2
                   DISPLAY "--------< DEPOSITO >--------"
                   DISPLAY "Digite o valor de deposito:"
                   ACCEPT VALOR-DEPOSITO.
                   WRITE SB-CONTAS-ARQUIVO.
                       KEY IS CONTAS-ID
                       ADD VALOR-DEPOSITO TO CONTAS-SALDO.
                       DISPLAY "-----------------------------"
                       DISPLAY "NOVO SALDO: " CONTAS-SALDO
                       DISPLAY "VALOR DEPOSITADO: " VALOR-DEPOSITO
                       DISPLAY "-----------------------------"
                   END-WRITE.
                   DISPLAY "--------< SELECIONE >--------"
                   DISPLAY "1 - Voltar"
                   DISPLAY "2 - Sair"
                   ACCEPT VOLTAR-SAIR.
                   PERFORM OPERACAO-VOLTAR-SAIR

               WHEN 3
                   DISPLAY "--------< SAQUE >--------"
                   DISPLAY "Digite o valor de saque:"
                   ACCEPT VALOR-SAQUE.
                   WRITE SB-CONTAS-ARQUIVO.
                       KEY IS CONTAS-ID
                       COMPUTE
                       CONTAS-SALDO = CONTAS-SALDO - VALOR-DEPOSITO.
                       DISPLAY "-----------------------------"
                       DISPLAY "NOVO SALDO: " CONTAS-SALDO
                       DISPLAY "VALOR SACADO: " VALOR-SAQUE
                       DISPLAY "-----------------------------"
                   END-WRITE.
                       DISPLAY "--------< SELECIONE >--------"
                       DISPLAY "1 - Voltar"
                       DISPLAY "2 - Sair"
                       ACCEPT VOLTAR-SAIR.
                       PERFORM OPERACAO-VOLTAR-SAIR

               WHEN DEFAULT
                   DISPLAY "--------< NÃO ENCONTRADO >--------"
                   GO TO INICIO-OPERACAO.

           END-EVALUATE OPERACAO.

       FECHAR-ARQUIVO.
           CLOSE SB-CONTAS-ARQUIVO.

       END PROGRAM SISTEMA-BANCARIO.
