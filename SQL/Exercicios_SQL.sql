

SELECT *  FROM [ITENS NOTAS FISCAIS] 
WHERE [QUANTIDADE] > 60 AND [PREÇO] <= 3

SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'Rio de Janeiro'

SELECT TOP 3 * FROM [dbo].[NOTAS FISCAIS] WHERE [DATA] = '2017-01-01'

/* Primeira consulta para obter o código do Produto */
SELECT * FROM [TABELA DE PRODUTOS] 
WHERE [NOME DO PRODUTO] = 'Linha Refrescante - 1 Litro - Morango/Limão'

/* Segunda consulta para obter a maior quantidade já vendida deste produto */
SELECT * FROM [ITENS NOTAS FISCAIS]
WHERE [CODIGO DO PRODUTO] = '1101035'
ORDER BY QUANTIDADE DESC

/* Quantos itens de venda existem com a maior quantidade de venda para o produto '1101035'? */
SELECT COUNT(*) FROM [ITENS NOTAS FISCAIS]
WHERE [CODIGO DO PRODUTO] = '1101035'
AND QUANTIDADE = 99

/* Quais são os clientes que fizeram mais de 2000 compras em 2016? */
SELECT CPF, COUNT(*) FROM [NOTAS FISCAIS] 
WHERE YEAR(DATA) = 2016 
GROUP BY CPF 
HAVING COUNT(*) > 2000

select [NOME],
case 
    when year([DATA DE NASCIMENTO]) < 1990 then 'Adulto'
    when year([DATA DE NASCIMENTO]) between 1990 and 1995 then 'Jovem'
    else 'Criança' end as [Classificação Etária]
 from [TABELA DE CLIENTES]