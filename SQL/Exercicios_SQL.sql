

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