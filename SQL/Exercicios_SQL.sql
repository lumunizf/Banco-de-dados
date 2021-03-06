

SELECT *  FROM [ITENS NOTAS FISCAIS] 
WHERE [QUANTIDADE] > 60 AND [PRE�O] <= 3

SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'Rio de Janeiro'

SELECT TOP 3 * FROM [dbo].[NOTAS FISCAIS] WHERE [DATA] = '2017-01-01'

/* Primeira consulta para obter o c�digo do Produto */
SELECT * FROM [TABELA DE PRODUTOS] 
WHERE [NOME DO PRODUTO] = 'Linha Refrescante - 1 Litro - Morango/Lim�o'

/* Segunda consulta para obter a maior quantidade j� vendida deste produto */
SELECT * FROM [ITENS NOTAS FISCAIS]
WHERE [CODIGO DO PRODUTO] = '1101035'
ORDER BY QUANTIDADE DESC

/* Quantos itens de venda existem com a maior quantidade de venda para o produto '1101035'? */
SELECT COUNT(*) FROM [ITENS NOTAS FISCAIS]
WHERE [CODIGO DO PRODUTO] = '1101035'
AND QUANTIDADE = 99

/* Quais s�o os clientes que fizeram mais de 2000 compras em 2016? */
SELECT CPF, COUNT(*) FROM [NOTAS FISCAIS] 
WHERE YEAR(DATA) = 2016 
GROUP BY CPF 
HAVING COUNT(*) > 2000

SELECT [NOME],
CASE 
    WHEN YEAR([DATA DE NASCIMENTO]) < 1990 THEN 'Adulto'
    WHEN YEAR([DATA DE NASCIMENTO]) between 1990 and 1995 THEN 'Jovem'
    ELSE 'Crian�a' END AS [Classifica��o Et�ria]
 FROM [TABELA DE CLIENTES]

 /* Faturamento anual: O valor financeiro das vendas consiste em multiplicar a quantidade pelo pre�o */
SELECT YEAR(DATA), SUM (QUANTIDADE * [PRE�O]) AS FATURAMENTO
FROM [NOTAS FISCAIS] NF INNER JOIN [ITENS NOTAS FISCAIS] INF 
ON NF.NUMERO = INF.NUMERO
GROUP BY YEAR(DATA)

/* Exerc�cio usando sub-consulta */
SELECT X.CPF, X.CONTADOR FROM 
(SELECT CPF, COUNT(*) AS CONTADOR FROM [NOTAS FISCAIS]
WHERE YEAR(DATA) = 2016
GROUP BY CPF) X WHERE X.CONTADOR > 2000

/* Consulta que lista o nome do cliente e o endere�o completo (com rua, bairro, cidade e estado) */
SELECT NOME, CONCAT([ENDERECO 1], ' ', BAIRRO, ' ', CIDADE, ' ', ESTADO) AS COMPLETO
FROM [SUCOS_VENDAS].[dbo].[TABELA DE CLIENTES]

/* Consulta que mostra o nome e a idade dos clientes */
SELECT NOME, DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE()) AS IDADE
FROM [dbo].[TABELA DE CLIENTES]

/* C�lculo do valor do imposto pago no ano de 2016, arredondando para o menor inteiro. */
SELECT YEAR(DATA), FLOOR(SUM(IMPOSTO * (QUANTIDADE * PRE�O))) 
FROM [NOTAS FISCAIS] NF
INNER JOIN [ITENS NOTAS FISCAIS] INF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA) = 2016
GROUP BY YEAR(DATA)

/* Consulta cujo resultado � para cada cliente: **"O cliente Jo�o da Silva faturou <valor faturado> no ano de 2016".*/
SELECT CONCAT('O cliente ', TC.NOME, ' faturou ', 
CONVERT(VARCHAR, CONVERT(DECIMAL(15,2), SUM(INF.QUANTIDADE * INF.[PRE�O]))), ' no ano ',   CONVERT(VARCHAR, YEAR(NF.DATA))) AS SENTENCA FROM [NOTAS FISCAIS] NF
INNER JOIN [ITENS NOTAS FISCAIS] INF ON NF.NUMERO = INF.NUMERO
INNER JOIN [TABELA DE CLIENTES] TC ON NF.CPF = TC.CPF
WHERE YEAR(DATA) = 2016
GROUP BY TC.NOME, YEAR(DATA)


/* Consulta para listar somente os clientes com vendas inv�lidas, calculando a diferen�a entre o limite de venda m�ximo e o realizado, em percentuais */
SELECT AUX1.NOME, AUX1.ANO_MES, AUX1.[VOLUME DE COMPRA], AUX1.QUANTIDADE_MES, 
CONVERT(DECIMAL(15,2), (1 - (AUX1.[VOLUME DE COMPRA]/AUX1.QUANTIDADE_MES)) * 100) AS VARIACAO, 
CASE WHEN AUX1.QUANTIDADE_MES <= AUX1.[VOLUME DE COMPRA] THEN 'VENDA V�LIDA'
WHEN AUX1.QUANTIDADE_MES > AUX1.[VOLUME DE COMPRA] THEN 'VENDA INV�LIDA'
END AS STATUS_VENDA
FROM 
(SELECT TC.NOME, CQ.ANO_MES, CQ.QUANTIDADE_MES, TC.[VOLUME DE COMPRA]
FROM
(SELECT NF.CPF, SUBSTRING(CONVERT(VARCHAR, NF.[DATA], 120),1,7) AS ANO_MES, 
SUM(INF.QUANTIDADE) AS QUANTIDADE_MES  FROM [NOTAS FISCAIS] NF
INNER JOIN [ITENS NOTAS FISCAIS] INF
ON NF.NUMERO = INF.NUMERO 
GROUP BY NF.CPF, SUBSTRING(CONVERT(VARCHAR, NF.[DATA], 120),1,7)) CQ
INNER JOIN [TABELA DE CLIENTES] TC ON TC.CPF = CQ.CPF) AUX1
WHERE  AUX1.QUANTIDADE_MES > AUX1.[VOLUME DE COMPRA] 
ORDER BY AUX1.NOME, AUX1.ANO_MES

/* Ranking das vendas por tamanho*/
SELECT AUX1.TAMANHO, AUX1.ANO, CONVERT(DECIMAL(15,2), AUX1.FATURAMENTO) AS FATURAMENTO, 
CONVERT(VARCHAR, CONVERT(DECIMAL(15,2),(AUX1.FATURAMENTO/AUX2.TOTAL) * 100)) + ' %' 
AS PERCENTUAL FROM
(SELECT TP.TAMANHO, YEAR(NF.DATA) AS ANO, SUM (INF.QUANTIDADE * INF.PRE�O) AS FATURAMENTO
FROM [ITENS NOTAS FISCAIS] INF INNER JOIN [TABELA DE PRODUTOS] TP
ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF 
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY TP.TAMANHO, YEAR(NF.DATA)) AUX1
INNER JOIN (SELECT YEAR(NF.DATA) AS ANO, SUM (INF.QUANTIDADE * INF.PRE�O) AS TOTAL
FROM [ITENS NOTAS FISCAIS] INF INNER JOIN [TABELA DE PRODUTOS] TP
ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF 
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY YEAR(NF.DATA)) AUX2
ON AUX1.ANO = AUX2.ANO
ORDER BY AUX1.FATURAMENTO DESC
