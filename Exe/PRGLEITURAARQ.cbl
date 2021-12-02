      ******************************************************************
      * Author: CLAUDIO SANTOS
      * Date: 02/12/2021
      * Purpose: MOSTRAR LEITURA DE ARQUIVOS DO COBOL
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PRGLEITURAARQ.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.


           SELECT ST ASSIGN TO
           'C:\USERS\CLAUDIO\DOCUMENTS\GITHUB\APRENDA-COBOL\EXE\ST.TXT'
           ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD ST.
       01 STUDENT-FILE.
           03 CD-STUDENT               PIC 9(05).
           03 NM-STUDENT               PIC X(20).


       WORKING-STORAGE SECTION.
       01 WS-DADOS                     PIC X(25) VALUE SPACES.
       01 FILLER REDEFINES WS-DADOS.
           03 WS-CD-STUDENT            PIC 9(05).
           03 WS-NM-STUDENT            PIC X(20).
       77 WS-EOF                       PIC A     VALUE SPACES.



       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

            OPEN INPUT ST.

            PERFORM UNTIL WS-EOF = 'F'
               READ ST INTO WS-DADOS
                   AT END MOVE 'F' TO WS-EOF
                       NOT AT END
                           DISPLAY WS-CD-STUDENT ' - ' WS-NM-STUDENT
               END-READ
            END-PERFORM.

            CLOSE ST.



            STOP RUN.
       END PROGRAM PRGLEITURAARQ.
