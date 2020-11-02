
SELECT CONVERT(VARCHAR, GETDATE(), 101)

SELECT CONVERT(VARCHAR, GETDATE(), 113)

SELECT CONVERT(VARCHAR, GETDATE(), 130)

SELECT CONVERT(decimal(10,5), 193.57)

SELECT * FROM [TABELA DE PRODUTOS]

/* Consulta ANTES da concatena��o de dados */
SELECT 'O pre�o do produto ' + [NOME DO PRODUTO] + ' � ' +  [PRE�O DE LISTA] 
from [TABELA DE PRODUTOS]

/* Consulta DEPOIS da concatena��o de dados */
SELECT 'O pre�o do produto ' + [NOME DO PRODUTO] + ' � ' +  CONVERT(VARCHAR, [PRE�O DE LISTA]) 
from [TABELA DE PRODUTOS]