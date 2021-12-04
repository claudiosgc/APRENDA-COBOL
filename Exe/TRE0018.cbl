      ******************************************************************
      * Author: CLAUDIO SANTOS
      * Date:03/12/2021
      * Purpose:ACHAR O MAIOR E MENOR NUMERO DE UMA SERIE DE NUMEROS
      *               POSITIVOS FORNECIDOS POR UM ARQUIVO.
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TRE0018.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT ITREF01
                       ASSIGN ITREF01
                       FILE STATUS AS-STATUS-F001.

      *     'C:USERS\CLAUDIO\DOCUMENTS\GITHUB\COBOL\EXE\ITREF01.TXT'

       DATA DIVISION.
       FILE SECTION.

       FD  ITREF01
               RECORD  3.

       01 REG-ITREF01.
           05 F001-NUMERO              PIC 9(003).

       WORKING-STORAGE SECTION.

       01 AREA-DE-SALVAMENTO.
           05 AS-MAIOR                 PIC 9(003) VALUE ZEROS.
           05 AS-MENOR                 PIC 9(003) VALUE ZEROS.
           05 AS-STATUS-F001           PIC 9(002) VALUE ZEROS.

       01 MSG-ERRO-OPEN.
           05 FILLER                   PIC X(028) VALUE
               'ERRO NA ABERTURA DO ARQUIVO'.
           05 MSG-ERRO-OPEN-ARQUIVO    PIC X(008) VALUE SPACE.
           05 FILLER                   PIC X(011) VALUE
               'COM STATUS'.
           05  MSG-ERRO-OPEN-STATUS    PIC 9(002) VALUE ZEROS.

       01 MSG-ERRO-READ.
           05 FILLER                   PIC X(027) VALUE
               'ERRO NA LEITURA DO ARQUIVO'.
           05 MSG-ERRO-READ-ARQUIVO    PIC X(008) VALUE SPACE.
           05 FILLER                   PIC X(011) VALUE
               'COM STATUS'.
           05 MSG-ERRO-READ-STATUS     PIC 9(002) VALUE ZEROS.

       01 MSG-ERRO-CLOSE.
           05 FILLER                   PIC X(030) VALUE
               'ERRO NO FECHAMENTO DO ARQUIVO'.
           05 MSG-ERRO-CLOSE-ARQUIVO   PIC X(008) VALUE SPACE.
           05 FILLER                   PIC X(011) VALUE
               'COM STATUS'.
           05 MSG-ERRO-CLOSE-STATUS    PIC X(002) VALUE ZEROS.


       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

            PERFORM 1000-INICIALIZA

            PERFORM 2000-PROCESSA

            PERFORM 3000-FINALIZA

            GOBACK.

      ******************************************************************
      ********************** INICIALIZA ********************************
      ******************************************************************

       1000-INICIALIZA               SECTION.

            OPEN INPUT ITREF01

            IF AS-STATUS-F001 NOT EQUAL ZEROS
                MOVE 'ITREF01'       TO MSG-ERRO-OPEN-ARQUIVO
                MOVE AS-STATUS-F001  TO MSG-ERRO-OPEN-STATUS
                DISPLAY MSG-ERRO-OPEN

                PERFORM 9000-CANCELA
            END-IF
            .
       1000-INICIALIZA-EXIT.
               EXIT.
      ******************************************************************
      ********************** PROCESSA **********************************
      ******************************************************************

       2000-PROCESSA                SECTION.


            READ ITREF01

            IF AS-STATUS-F001 NOT EQUAL ZEROS
                MOVE 'ITREF01'       TO MSG-ERRO-READ-ARQUIVO
                MOVE AS-STATUS-F001  TO MSG-ERRO-READ-STATUS
                DISPLAY MSG-ERRO-READ

                PERFORM 9000-CANCELA
            END-IF

               MOVE F001-NUMERO      TO AS-MAIOR
                                        AS-MENOR

            PERFORM UNTIL AS-STATUS-F001 = 10

            IF F001-NUMERO < AS-MENOR
                MOVE F001-NUMERO     TO AS-MENOR
            END-IF

            IF F001-NUMERO > AS-MAIOR
                MOVE F001-NUMERO     TO AS-MAIOR
            END-IF


            READ ITREF01

            IF AS-STATUS-F001 NOT EQUAL ZEROS
            AND AS-STATUS-F001 NOT EQUAL 10
                MOVE 'ITREF01'       TO MSG-ERRO-READ-ARQUIVO
                MOVE AS-STATUS-F001  TO MSG-ERRO-READ-STATUS
                DISPLAY MSG-ERRO-READ
                PERFORM 9000-CANCELA
            END-IF
            END-PERFORM

             DISPLAY 'MENOR = ' AS-MENOR
             DISPLAY 'MAIOR = ' AS-MAIOR
            .
       2000-PROCESSA-EXIT.
               EXIT.

      ******************************************************************
      ********************** FINALIZA **********************************
      ******************************************************************
       3000-FINALIZA                  SECTION.

               CLOSE ITREF01
               IF AS-STATUS-F001 NOT EQUAL ZEROS
                   MOVE 'ITREF01'      TO MSG-ERRO-CLOSE-ARQUIVO
                   MOVE AS-STATUS-F001 TO MSG-ERRO-CLOSE-STATUS
                   DISPLAY MSG-ERRO-CLOSE
               END-IF

               DISPLAY 'TERMINO NORMAL'
           .
       3000-FINALIZA-EXIT.
               EXIT.

      ******************************************************************
      ********************** FIM ANORMAL **********************************
      ******************************************************************
       9000-CANCELA                   SECTION.

               CLOSE ITREF01

               DISPLAY 'TERMINO ANORMAL'
               GOBACK
           .
       9000-CANCELA-EXIT.
               EXIT.



            STOP RUN.
       END PROGRAM TRE0018.
