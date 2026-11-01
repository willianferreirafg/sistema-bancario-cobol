
       IDENTIFICATION DIVISION.
           PROGRAM-ID. SB-LOGIN.
           AUTHOR. "WILLIAN FERREIRA GONÇALVES"
           DATE-WRITTEN. "01/11/2026"
           DATE-COMPILED. "01/11/2026"
           REMARKS. "Sistema Bancário"

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SB-CONTAS-ARQUIVO
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
           05 CONTAS-ID    PIC X(6).
           05 CONTAS-SALDO PIC S9(7)V99.

       WORKING-STORAGE SECTION.
       01 WS-STATUS            PIC XX.
       01 OPERACAO-SELECIONADA PIC X.
       01 VOLTAR-SAIR          PIC X.
       01 VALOR-DEPOSITO       PIC 9(7)V99.
       01 VALOR-SAQUE          PIC 9(7)V99.
       01 WS-ENCERRAR          PIC X VALUE "N".

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM ABRIR-ARQUIVO

           IF WS-STATUS = "00"
               PERFORM MENU-E-SISTEMA
               PERFORM FECHAR-ARQUIVO
           END-IF

           STOP RUN.

       ABRIR-ARQUIVO.
           DISPLAY "--------< CARREGANDO >--------"

           OPEN I-O SB-CONTAS-ARQUIVO

           IF WS-STATUS = "00"
               DISPLAY "--------< BEM-VINDO >--------"
           ELSE
               DISPLAY "--------< ERRO DE ACESSO >--------"
               DISPLAY "CODIGO: " WS-STATUS
           END-IF.

       MENU-E-SISTEMA.
           PERFORM UNTIL WS-ENCERRAR = "S"

               PERFORM PERGUNTA-INICIO

               READ SB-CONTAS-ARQUIVO
                   KEY IS CONTAS-ID

                   INVALID KEY
                       DISPLAY "--------< NAO ENCONTRADO >--------"

                   NOT INVALID KEY
                       PERFORM MENU-OPERACOES

               END-READ

           END-PERFORM.

       PERGUNTA-INICIO.
           DISPLAY "Entre com seu ID:"
           ACCEPT CONTAS-ID.

       MENU-OPERACOES.
           PERFORM UNTIL WS-ENCERRAR = "S"

               DISPLAY "----------------------------------"
               DISPLAY "CONTA: " CONTAS-ID
               DISPLAY "SALDO: " CONTAS-SALDO
               DISPLAY "----------------------------------"

               DISPLAY "1 - Consultar saldo"
               DISPLAY "2 - Depositar saldo"
               DISPLAY "3 - Sacar saldo"
               DISPLAY "4 - Sair"

               ACCEPT OPERACAO-SELECIONADA

               EVALUATE OPERACAO-SELECIONADA

                   WHEN "1"
                       PERFORM CONSULTAR-SALDO

                   WHEN "2"
                       PERFORM DEPOSITAR-SALDO

                   WHEN "3"
                       PERFORM SACAR-SALDO

                   WHEN "4"
                       DISPLAY "--------< SAINDO... >--------"
                       MOVE "S" TO WS-ENCERRAR

                   WHEN OTHER
                       DISPLAY "--------< OPCAO INVALIDA >--------"

               END-EVALUATE

           END-PERFORM.

       CONSULTAR-SALDO.
           DISPLAY "--------< CONSULTA DE SALDO >--------"
           DISPLAY "CONTA: " CONTAS-ID
           DISPLAY "SALDO: " CONTAS-SALDO.

       DEPOSITAR-SALDO.
           DISPLAY "--------< DEPOSITO >--------"
           DISPLAY "Digite o valor do deposito:"
           ACCEPT VALOR-DEPOSITO

           IF VALOR-DEPOSITO > ZERO

               ADD VALOR-DEPOSITO TO CONTAS-SALDO

               REWRITE CONTAS-REGISTRO

               IF WS-STATUS = "00"
                   DISPLAY "-----------------------------"
                   DISPLAY "DEPOSITO REALIZADO!"
                   DISPLAY "NOVO SALDO: " CONTAS-SALDO
                   DISPLAY "VALOR DEPOSITADO: "
                           VALOR-DEPOSITO
                   DISPLAY "-----------------------------"
               ELSE
                   DISPLAY "ERRO AO ATUALIZAR CONTA"
                   DISPLAY "CODIGO: " WS-STATUS
               END-IF

           ELSE
               DISPLAY "VALOR DE DEPOSITO INVALIDO"
           END-IF.

       SACAR-SALDO.
           DISPLAY "--------< SAQUE >--------"
           DISPLAY "Digite o valor do saque:"
           ACCEPT VALOR-SAQUE

           IF VALOR-SAQUE > ZERO

               IF CONTAS-SALDO >= VALOR-SAQUE

                   SUBTRACT VALOR-SAQUE FROM CONTAS-SALDO

                   REWRITE CONTAS-REGISTRO

                   IF WS-STATUS = "00"
                       DISPLAY "-----------------------------"
                       DISPLAY "SAQUE REALIZADO!"
                       DISPLAY "NOVO SALDO: " CONTAS-SALDO
                       DISPLAY "VALOR SACADO: " VALOR-SAQUE
                       DISPLAY "-----------------------------"
                   ELSE
                       DISPLAY "ERRO AO ATUALIZAR CONTA"
                       DISPLAY "CODIGO: " WS-STATUS
                   END-IF

               ELSE
                   DISPLAY "SALDO INSUFICIENTE!"
               END-IF

           ELSE
               DISPLAY "VALOR DE SAQUE INVALIDO"
           END-IF.

       FECHAR-ARQUIVO.
           CLOSE SB-CONTAS-ARQUIVO.

       END PROGRAM SB-LOGIN.
