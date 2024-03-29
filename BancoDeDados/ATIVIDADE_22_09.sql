CREATE DATABASE ATIVIDADE
GO
USE ATIVIDADE
GO

CREATE TABLE PRODUTO(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOME VARCHAR(MAX)
);

GO

CREATE TABLE ESTOQUE(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	QUANTIDADE INT,
	PRODUTO_ID INT NOT NULL FOREIGN KEY REFERENCES PRODUTO(ID)
);

GO

CREATE TABLE VENDA(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	QUANTIDADE INT,
	VALOR DECIMAL(6,2),
	DATAVENDA DATE,
	PRODUTO_ID INT NOT NULL FOREIGN KEY REFERENCES PRODUTO(ID)
);

GO

CREATE TABLE TABELALOG(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DATALOG DATE,
	TABELA VARCHAR(MAX),
	COMANDO VARCHAR(MAX),
	MENSAGEM VARCHAR(MAX),
	SEVERIDADE INT
);

GO

INSERT INTO PRODUTO(NOME) VALUES ('Carro')
INSERT INTO PRODUTO(NOME) VALUES ('Casa')
INSERT INTO PRODUTO(NOME) VALUES ('Computador')
INSERT INTO PRODUTO(NOME) VALUES ('Teclado')
INSERT INTO PRODUTO(NOME) VALUES ('Hihi')

INSERT INTO ESTOQUE(QUANTIDADE, PRODUTO_ID) VALUES (20, 1)
INSERT INTO ESTOQUE(QUANTIDADE, PRODUTO_ID) VALUES (25, 2)
INSERT INTO ESTOQUE(QUANTIDADE, PRODUTO_ID) VALUES (28, 3)
INSERT INTO ESTOQUE(QUANTIDADE, PRODUTO_ID) VALUES (29, 4)
INSERT INTO ESTOQUE(QUANTIDADE, PRODUTO_ID) VALUES (10, 5)

GO


BEGIN TRANSACTION VALIDACAO

	CREATE TRIGGER ATTESTOQUE
	ON VENDA AFTER INSERT AS
		DECLARE @ESTOQUEID INT;
		DECLARE @VENDIDO INT;
	BEGIN
		SELECT @ESTOQUEID = E.ID FROM ESTOQUE E 
		INNER JOIN PRODUTO P ON E.PRODUTO_ID = P.ID 
		INNER JOIN INSERTED V ON V.PRODUTO_ID = P.ID

		SELECT @VENDIDO = QUANTIDADE FROM INSERTED
	
		UPDATE ESTOQUE SET QUANTIDADE = QUANTIDADE - @VENDIDO WHERE ID = @ESTOQUEID
	END

	GO

	CREATE PROCEDURE REGVENDAS
		@QUANTIDADEV INT,
		@VALORV DECIMAL(6,2),
		@PRODUTO_IDV INT
	AS
	BEGIN
		BEGIN TRY
			INSERT INTO VENDA(QUANTIDADE,VALOR,DATAVENDA,PRODUTO_ID) VALUES (@QUANTIDADEV,@VALORV,GETDATE(),@PRODUTO_IDV)
		END TRY  
		BEGIN CATCH  
			PRINT('Venda n�o concluida, repita o processo novamente')
			INSERT INTO TABELALOG(DATALOG, TABELA, COMANDO, MENSAGEM, SEVERIDADE) VALUES (GETDATE(), 'VENDA', 'INSERT', ERROR_MESSAGE(), ERROR_SEVERITY())
		END CATCH  
	END

IF @@ERROR = 0
	COMMIT VALIDACAO
ELSE
	ROLLBACK VALIDACAO

GO

CREATE PROCEDURE REGPRODUTO
	@NOMEV VARCHAR(MAX)
AS
	DECLARE @IDPROD INT
BEGIN
	BEGIN TRY
		INSERT INTO PRODUTO(NOME) VALUES (@NOMEV)
		SELECT @IDPROD = MAX(ID) FROM PRODUTO
		INSERT INTO ESTOQUE(QUANTIDADE, PRODUTO_ID) VALUES (0,@IDPROD)
	END TRY  
	BEGIN CATCH  
		PRINT('Insert n�o concluido, repita o processo novamente')
		INSERT INTO TABELALOG(DATALOG, TABELA, COMANDO, MENSAGEM, SEVERIDADE) VALUES (GETDATE(), 'PRODUTO', 'INSERT', ERROR_MESSAGE(), ERROR_SEVERITY())
	END CATCH  
END

GO

CREATE PROCEDURE UPPRODUTO
	@ID INT,
	@NOMEV VARCHAR(MAX)
AS
	DECLARE @IDPROD INT
BEGIN
	BEGIN TRY
		UPDATE PRODUTO SET NOME = @NOMEV WHERE ID = @ID
	END TRY  
	BEGIN CATCH  
		PRINT('Update n�o concluido, repita o processo novamente')
		INSERT INTO TABELALOG(DATALOG, TABELA, COMANDO, MENSAGEM, SEVERIDADE) VALUES (GETDATE(), 'PRODUTO', 'UPDATE', ERROR_MESSAGE(), ERROR_SEVERITY())
	END CATCH  
END

GO

CREATE PROCEDURE DELPRODUTO
	@ID INT
AS
BEGIN
	BEGIN TRY
		DELETE ESTOQUE WHERE PRODUTO_ID = @ID
		DELETE VENDA WHERE PRODUTO_ID = @ID
		DELETE PRODUTO WHERE ID = @ID
	END TRY  
	BEGIN CATCH  
		PRINT('Delete n�o concluido, repita o processo novamente')
		INSERT INTO TABELALOG(DATALOG, TABELA, COMANDO, MENSAGEM, SEVERIDADE) VALUES (GETDATE(), 'PRODUTO', 'DELETE', ERROR_MESSAGE(), ERROR_SEVERITY())
	END CATCH  
END

GO

CREATE PROCEDURE UPESTOQUE
	@ID INT,
	@QUANT INT
AS
	DECLARE @IDPROD INT
BEGIN
	BEGIN TRY
		UPDATE ESTOQUE SET QUANTIDADE = @QUANT WHERE ID = @ID
	END TRY  
	BEGIN CATCH  
		PRINT('Update n�o concluido, repita o processo novamente')
		INSERT INTO TABELALOG(DATALOG, TABELA, COMANDO, MENSAGEM, SEVERIDADE) VALUES (GETDATE(), 'ESTOQUE', 'UPDATE', ERROR_MESSAGE(), ERROR_SEVERITY())
	END CATCH  
END

GO

CREATE PROCEDURE DELESTOQUE
	@ID INT
AS
BEGIN
	BEGIN TRY
		DELETE ESTOQUE WHERE PRODUTO_ID = @ID
	END TRY  
	BEGIN CATCH  
		PRINT('Delete n�o concluido, repita o processo novamente')
		INSERT INTO TABELALOG(DATALOG, TABELA, COMANDO, MENSAGEM, SEVERIDADE) VALUES (GETDATE(), 'ESTOQUE', 'DELETE', ERROR_MESSAGE(), ERROR_SEVERITY())
	END CATCH  
END

