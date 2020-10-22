USE [SUCOS_VENDAS_001]
GO

INSERT INTO [dbo].[CLIENTES]
           ([CPF]
           ,[NOME]
           ,[ENDERECO 1]
           ,[ENDERECO 2]
           ,[BAIRRO]
           ,[CIDADE]
           ,[ESTADO]
           ,[CEP]
           ,[DATA DE NASCIMENTO]
           ,[IDADE]
           ,[SEXO]
           ,[LIMITE DE CREDITO]
           ,[VOLUME DE COMPRA]
           ,[PRIMEIRA COMPRA])
     VALUES
           ('29727480971',
		   'ADMILSON DOS SANTOS SOYA'
           ,'Rua dos Manifestantes Imprudentes, 55'
           ,'10º andar - Apto 1010'
           ,'Vila Buarque de Holanda'
           ,'São Paulo'
           ,'SP'
           ,'04550000'
           ,'1990-10-25'
           ,28
           ,'M'
           ,120000.50
           ,1000
           ,1)
GO


