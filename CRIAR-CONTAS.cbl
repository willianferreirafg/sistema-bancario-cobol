
       IDENTIFICATION DIVISION.
           PROGRAM-ID. SB-CRIAR-CONTAS.
           AUTHOR. "WILLIAN FERREIRA GONÇALVES"
           DATE-WRITTEN. "01/11/2026"
           DATE-COMPILED. "01/11/2026"
           REMARKS. "Criar 10 contas para testes do Sistema Bancário"

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT SB-CONTAS-ARQUIVO
           ASSIGN TO
           "C:\dev\cobol-arquivos\contas-arquivo.dat"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS SEQUENTIAL
           RECORD KEY IS CONTAS-ID
           FILE STATUS IS WS-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD SB-CONTAS-ARQUIVO.
       01 CONTAS-REGISTRO.
           05 CONTAS-ID    PIC X(6).
           05 CONTAS-SALDO PIC S9(7)V99.

       WORKING-STORAGE SECTION.
       01 WS-STATUS PIC XX.
       01 WS-CONTADOR PIC 99 VALUE ZERO.

       PROCEDURE DIVISION.

       MAIN-LOGIC.

           DISPLAY "------------------------------"
           DISPLAY "  CRIANDO CONTAS BANCARIAS"
           DISPLAY "------------------------------"

           OPEN OUTPUT SB-CONTAS-ARQUIVO

           IF WS-STATUS = "00"

               PERFORM CRIAR-CONTAS

               CLOSE SB-CONTAS-ARQUIVO

               DISPLAY "------------------------------"
               DISPLAY "CONTAS CRIADAS COM SUCESSO!"
               DISPLAY "TOTAL: " WS-CONTADOR
               DISPLAY "------------------------------"

           ELSE

               DISPLAY "ERRO AO CRIAR ARQUIVO!"
               DISPLAY "CODIGO: " WS-STATUS

           END-IF

           STOP RUN.

       CRIAR-CONTAS.

           MOVE "000001" TO CONTAS-ID
           MOVE 1500.00 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000002" TO CONTAS-ID
           MOVE 2500.50 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000003" TO CONTAS-ID
           MOVE 3500.75 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000004" TO CONTAS-ID
           MOVE 5000.00 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000005" TO CONTAS-ID
           MOVE 750.25 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000006" TO CONTAS-ID
           MOVE 10000.00 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000007" TO CONTAS-ID
           MOVE 850.90 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000008" TO CONTAS-ID
           MOVE 1200.00 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000009" TO CONTAS-ID
           MOVE 4500.35 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA

           MOVE "000010" TO CONTAS-ID
           MOVE 20000.00 TO CONTAS-SALDO
           PERFORM GRAVAR-CONTA.

       GRAVAR-CONTA.

           WRITE CONTAS-REGISTRO

               INVALID KEY
                   DISPLAY "ERRO AO GRAVAR CONTA: "
                           CONTAS-ID
                   DISPLAY "CODIGO: " WS-STATUS

               NOT INVALID KEY
                   ADD 1 TO WS-CONTADOR
                   DISPLAY "CONTA CRIADA: " CONTAS-ID

           END-WRITE.

       END PROGRAM SB-CRIAR-CONTAS.
