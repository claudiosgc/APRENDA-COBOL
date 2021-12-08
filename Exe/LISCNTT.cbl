      ******************************************************************
      * Author: CLAUDIO SANTOS
      * Date: 08/12/2021
      * Purpose: LISTA CONTATOS
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LISCNTT.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.
            INPUT-OUTPUT SECTION.
            FILE-CONTROL.
                SELECT COT ASSIGN TO
           'C:\Users\CLAUDIO\Documents\GitHub\APRENDA-COBOL\Exe\COT.DAT'
                ORGANIZATION IS INDEXED
                ACCESS IS SEQUENTIAL
                RECORD KEY IS ID-CONTATO
                FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD COT.
          COPY FD_CONTT.

       WORKING-STORAGE SECTION.
       01 WS-REGISTRO             PIC X(22) VALUE SPACE.
       01 FILLER REDEFINES WS-REGISTRO.
          03 WS-ID-CONTATO        PIC 9(02).
          03 WS-NM-CONTATO        PIC X(20).
       77 WS-FS                   PIC 99.
          88 FS-OK                VALUE 0.
       77 WS-EOF                  PIC X.
          88 EOF-OK               VALUE 'S' FALSE 'N'.
       77 WS-EXIT                 PIC X.
          88 EXIT-OK              VALUE 'S' FALSE 'N'.
       77 WS-CONT                 PIC 9(003) VALUE ZEROS.


       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
            DISPLAY '**** LISTAR CONTATOS *******'
            SET EXIT-OK           TO FALSE
            PERFORM P300-LISTAR   THRU P300-FIM
            PERFORM P900-FIM
           .

       P300-LISTAR.
            SET EOF-OK            TO FALSE
            SET FS-OK             TO TRUE
            SET WS-CONT           TO 0

            OPEN INPUT COT

            IF FS-OK THEN
                PERFORM UNTIL EOF-OK

                   READ COT INTO WS-REGISTRO
                       AT END
                           SET EOF-OK TO TRUE
                       NOT AT END
                           ADD 1   TO  WS-CONT
                           DISPLAY 'REGISTRO '
                                   WS-CONT
                                   ': '
                                   WS-ID-CONTATO
                                   ' - '
                                   WS-NM-CONTATO
                   END-READ
                END-PERFORM
            ELSE
                DISPLAY 'ERRO AO ABRIR O ARQUIVO DE CONTATOS'
                DISPLAY ' FILE STATUS: ' WS-FS
            END-IF

           CLOSE COT
            .
       P300-FIM.
       P900-FIM.
            STOP RUN.
       END PROGRAM LISCNTT.
