      ******************************************************************
      * Author: CLAUDIO SANTOS
      * Date: 06/12/2021
      * Purpose: CADASTRO DE CONTATOS
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CADCONTT.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.

            INPUT-OUTPUT SECTION.
            FILE-CONTROL.
            SELECT COT ASSIGN TO
           'C:\Users\CLAUDIO\Documents\GitHub\APRENDA-COBOL\Exe\COT.TXT'
            ORGANISATION IS SEQUENTIAL
            ACCESS  MODE IS SEQUENTIAL
            FILE STATUS  IS WS-STATUS-FS.


       DATA DIVISION.
       FILE SECTION.
       FD COT.
          COPY FD_CONTT.


       WORKING-STORAGE SECTION.
       01 WS-REGISTRO                      PIC X(22) VALUE SPACE.
       01 FILLER   REDEFINES WS-REGISTRO.
          03 WS-ID-CONTATO                 PIC 9(02).
          03 WS-NM-CONTATO                 PIC X(20).
       77 WS-STATUS-FS                     PIC 99.
          88 STATUS-OK                     VALUE 0.
       77 WS-EOF                           PIC X.
          88 EOF-OK                        VALUE 'S' FALSE 'N'.
       77 WS-EXIT                          PIC X.
          88 EXIT-OK                       VALUE 'F' FALSE 'N'.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

            DISPLAY '*** CADASTRO DE CONTATOS ***'
            SET EXIT-OK              TO FALSE

            PERFORM P300-CADASTRO      THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM

           .

       P300-CADASTRO.
            SET EOF-OK                  TO FALSE
            SET STATUS-OK               TO TRUE

            DISPLAY 'PARA REGISTRAR UM CONTATO INFORME: '
            DISPLAY 'Um numero para a Identificacao: '
            ACCEPT WS-ID-CONTATO
            DISPLAY 'Um nome para o Contato: '
            ACCEPT WS-NM-CONTATO

            OPEN EXTEND COT

            IF WS-STATUS-FS EQUAL 35 THEN
                OPEN OUTPUT COT
            END-IF

            IF STATUS-OK THEN
                MOVE WS-ID-CONTATO           TO ID-CONTATO
                MOVE WS-NM-CONTATO           TO NM-CONTATO

                WRITE REG-CONTATOS
                DISPLAY 'Contato gravado com sucesso'
            ELSE
                DISPLAY 'ERRO AO ABRIR ARQUIVO DE CONTATOS.'
                DISPLAY 'FILE STATUS: ' WS-STATUS-FS
            END-IF

            CLOSE COT
            DISPLAY
            'TECLE: '
            '<QUALQUER TECLA> para continuar, ou <F> para finalizar'
            ACCEPT WS-EXIT

            .
       P300-FIM.
       P900-FIM.


            STOP RUN.
       END PROGRAM CADCONTT.
