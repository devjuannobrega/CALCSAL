IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCSAL.
       AUTHOR. SISTEMA DE FOLHA.
       DATE-WRITTEN. 2025-01-23.
      *****************************************************************
      * PROGRAMA: CALCULADORA DE SALARIO                              *
      * DESCRICAO: CALCULA SALARIO LIQUIDO COM DESCONTOS              *
      *****************************************************************
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-370.
       OBJECT-COMPUTER. IBM-370.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-FUNCIONARIO.
           05  WS-NOME            PIC X(30) VALUE SPACES.
           05  WS-MATRICULA       PIC 9(6)  VALUE ZEROS.
           05  WS-SALARIO-BRUTO   PIC 9(7)V99 VALUE ZEROS.
           05  WS-DESCONTO-INSS   PIC 9(5)V99 VALUE ZEROS.
           05  WS-DESCONTO-IR     PIC 9(5)V99 VALUE ZEROS.
           05  WS-SALARIO-LIQUIDO PIC 9(7)V99 VALUE ZEROS.
       
       01  WS-CONSTANTES.
           05  WS-TAXA-INSS       PIC 9V99 VALUE 0.11.
           05  WS-TAXA-IR         PIC 9V99 VALUE 0.15.
       
       01  WS-COUNTERS.
           05  WS-CONTADOR        PIC 9(3) VALUE ZEROS.
       
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "========================================".
           DISPLAY "   SISTEMA DE CALCULO DE SALARIO      ".
           DISPLAY "========================================".
           
           PERFORM INICIALIZA-DADOS.
           PERFORM CALCULA-DESCONTOS.
           PERFORM CALCULA-SALARIO-LIQUIDO.
           PERFORM EXIBE-RESULTADO.
           
           STOP RUN.
       
       INICIALIZA-DADOS.
           MOVE "JOAO DA SILVA" TO WS-NOME.
           MOVE 123456 TO WS-MATRICULA.
           MOVE 5000.00 TO WS-SALARIO-BRUTO.
           DISPLAY "Dados inicializados com sucesso.".
       
       CALCULA-DESCONTOS.
           COMPUTE WS-DESCONTO-INSS = 
               WS-SALARIO-BRUTO * WS-TAXA-INSS.
           COMPUTE WS-DESCONTO-IR = 
               WS-SALARIO-BRUTO * WS-TAXA-IR.
           DISPLAY "Descontos calculados.".
       
       CALCULA-SALARIO-LIQUIDO.
           COMPUTE WS-SALARIO-LIQUIDO = 
               WS-SALARIO-BRUTO - WS-DESCONTO-INSS - WS-DESCONTO-IR.
       
       EXIBE-RESULTADO.
           DISPLAY " ".
           DISPLAY "FUNCIONARIO: " WS-NOME.
           DISPLAY "MATRICULA: " WS-MATRICULA.
           DISPLAY "SALARIO BRUTO: R$ " WS-SALARIO-BRUTO.
           DISPLAY "DESCONTO INSS: R$ " WS-DESCONTO-INSS.
           DISPLAY "DESCONTO IR: R$ " WS-DESCONTO-IR.
           DISPLAY "SALARIO LIQUIDO: R$ " WS-SALARIO-LIQUIDO.
           DISPLAY " ".
```

## Como Usar

1. **Crie a pasta:**
```
   C:\cobol-test\