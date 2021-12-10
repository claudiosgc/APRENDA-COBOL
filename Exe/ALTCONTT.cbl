      ******************************************************************
      * Author: CLAUDIO SANTOS
      * Date: 10/12/2021
      * Purpose: ALTERACAO CONTATOS
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ALTCONTT.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.
            INPUT-OUTPUT SECTION.
            FILE-CONTROL.
                SELECT COT ASSIGN TO
           'C:\Users\CLAUDIO\Documents\GitHub\APRENDA-COBOL\Exe\COT.DAT'
                ORGANIZATION IS INDEXED
                ACCESS MODE  IS RANDOM
                RECORD KEY   IS ID-CONTATO
                FILE STATUS  IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD COT.
          COPY FD_CONTT.



       WORKING-STORAGE SECTION.
       01 WS-REGISTRO               PIC X(22) VALUE SPACES.
       01 FILLER REDEFINES WS-REGISTRO.
          03 WS-ID-CONTATO          PIC 9(02).
          03 WS-NM-CONTATO          PIC X(20).

       77 WS-FS                     PIC 99.
          88 FS-OK                  VALUE 0.
       77 WS-EOF                    PIC X.
          88 EOF-OK                 VALUE 'S' FALSE 'N'.
       77 WS-EXIT                   PIC X.
          88 EXIT-OK                VALUE 'F' FALSE 'N'.
       77 WS-CONFIRM                PIC X VALUE SPACES.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

            DISPLAY ' **** ALTERA CONTATOS **** '
            SET EXIT-OK             TO FALSE
            PERFORM P300-ALTERA      THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
            .

       P300-ALTERA.
            SET EOF-OK              TO FALSE
            SET FS-OK               TO TRUE

            MOVE SPACES             TO WS-CONFIRM


            OPEN I-O COT


            IF FS-OK THEN
            DISPLAY 'Informe o numero de identificacao do contato'
            ACCEPT ID-CONTATO

            READ COT INTO WS-REGISTRO
               KEY IS ID-CONTATO
               INVALID KEY
                   DISPLAY 'CONTATO NAO EXISTE'
               NOT INVALID KEY
                   DISPLAY 'Nome atual: ' WS-NM-CONTATO
                   DISPLAY 'Informe novo nome: '
                   ACCEPT  NM-CONTATO
                   DISPLAY 'TECLE: '
                           '<S> PARA CONFIRMAR OU <QUALQUER TECLA>'
                           'para continuar com atual.'
                   ACCEPT WS-CONFIRM
                   IF WS-CONFIRM EQUAL 'S' THEN
                       REWRITE REG-CONTATOS
                       DISPLAY 'Contato atualizado: '
                   ELSE
                       DISPLAY 'Alteracao nao realizada.'
                   END-IF
            END-READ
            ELSE
                DISPLAY 'ERRO AO ABRIR O ARQUIVO DE CONTATOS'
                DISPLAY 'FILE STATUS: ' WS-FS
            END-IF

            CLOSE COT

            DISPLAY
               'TECLE: '
               '<QUALQUER TECLA> para continuar ou <F> para finalizar'
            ACCEPT WS-EXIT
            .

       P300-FIM.
       P900-FIM.

            STOP RUN.
       END PROGRAM ALTCONTT.
