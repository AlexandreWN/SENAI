CREATE DATABASE BancoSenai

GO

USE BancoSenai

GO

CREATE TABLE Cliente(
	Id INT IDENTITY PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	CPF VARCHAR(11) NOT NULL,
);

CREATE TABLE Conta(
	Id INT IDENTITY PRIMARY KEY,
	NumAgencia VARCHAR(100) NOT NULL,
	ClienteID INT NOT NULL FOREIGN KEY REFERENCES Cliente(Id),
	Saldo DECIMAL(19, 2) NOT NULL,
);

CREATE TABLE Movimentacao(
	Id INT IDENTITY PRIMARY KEY,
	ContaID INT NOT NULL FOREIGN KEY REFERENCES Conta(Id),
	SaldoANT DECIMAL(19, 2) NOT NULL,
	SaldoAT DECIMAL(19, 2) NOT NULL,
	DataMov DATE NOT NULL
);

GO

/*Inserts*/

INSERT INTO Cliente(Nome, CPF) VALUES ('Alexandre Nikitin', '12345678998')
INSERT INTO Cliente(Nome, CPF) VALUES ('Allan Kley', '98214568264')
INSERT INTO Cliente(Nome, CPF) VALUES ('Bruno Viotto', '12564589525')

GO

INSERT INTO Conta(NumAgencia, ClienteID, Saldo) VALUES ('1234756', 1, 1000)
INSERT INTO Conta(NumAgencia, ClienteID, Saldo) VALUES ('1256368', 2, 2000)
INSERT INTO Conta(NumAgencia, ClienteID, Saldo) VALUES ('4668498', 3, 3000)

GO

/*Procedures*/
CREATE PROCEDURE SAQUE
@conta INT, @valor DECIMAL(19, 3)
AS
BEGIN
	DECLARE @saldo DECIMAL(19, 3);
	DECLARE @novoSaldo DECIMAL(19, 3);

	SELECT @saldo = Saldo FROM Conta WHERE Id = @conta
	
	SET @novoSaldo = @saldo - @valor

	UPDATE Conta SET Saldo = @novoSaldo WHERE Id = @conta
END

GO

CREATE PROCEDURE DEPOSITO
@conta INT, @valor DECIMAL(19, 3)
AS
BEGIN
	DECLARE @saldo DECIMAL(19, 3);
	DECLARE @novoSaldo DECIMAL(19, 3);

	SELECT @saldo = Saldo FROM Conta WHERE Id = @conta
	
	SET @novoSaldo = @saldo + @valor

	UPDATE Conta SET Saldo = @novoSaldo WHERE Id = @conta
END

GO

CREATE PROCEDURE MAIORQUEINFORMADO
@valor DECIMAL(19, 3)
AS
BEGIN
	SELECT * FROM Conta WHERE Saldo > @valor
END

GO

CREATE PROCEDURE TRANSFERENCIA
@contaOrigem INT, @contaDestino INT, @valor DECIMAL(19, 3)
AS
BEGIN
	DECLARE @saldo DECIMAL(19, 3);
	DECLARE @saldo2 DECIMAL(19, 3);
	DECLARE @novoSaldo DECIMAL(19, 3);
	DECLARE @novoSaldo2 DECIMAL(19, 3);

	SELECT @saldo = Saldo FROM Conta WHERE Id = @contaOrigem
	SELECT @saldo2 = Saldo FROM Conta WHERE Id = @contaDestino

	IF(@saldo >= @valor)
	BEGIN
		SET @novoSaldo = @saldo - @valor
		SET @novoSaldo2 = @saldo2 + @valor
		UPDATE Conta SET Saldo = @novoSaldo WHERE Id = @contaOrigem
		UPDATE Conta SET Saldo = @novoSaldo2 WHERE Id = @contaDestino
	END
	ELSE
	BEGIN
		PRINT('Não tem saldo patrão')
	END
END

GO
/*Triggers*/

CREATE TRIGGER DELETMOV
ON  Conta
AFTER DELETE
AS
BEGIN
	DECLARE @NumConta INT;

	SELECT @NumConta = Id FROM Conta WHERE Id = (SELECT id FROM deleted)
	DELETE Movimentacao WHERE ContaID = @NumConta
END

GO

CREATE TRIGGER REGISTERMOV
ON  Conta
AFTER INSERT
AS
BEGIN
	DECLARE @NumConta INT;

	SELECT @NumConta = Id FROM Conta WHERE Id = (SELECT id FROM inserted)
	
	INSERT INTO Movimentacao(ContaID, SaldoANT, SaldoAT, DataMov) VALUES (@NumConta,0,0,GETDATE())
END

SELECT * FROM Movimentacao

GO

CREATE TRIGGER REGISTERCONT
ON  Conta
AFTER INSERT
AS
BEGIN
	DECLARE @Saldo INT;

	SELECT @Saldo = Saldo FROM Conta WHERE Id = (SELECT id FROM inserted)

	IF(@Saldo > 0 OR @Saldo < 0)
	BEGIN
		UPDATE Conta SET Saldo = 0 WHERE Id = (SELECT id FROM inserted)
		DELETE FROM Movimentacao WHERE ContaID = (SELECT MAX(Id) FROM Movimentacao)
	END
END

GO

CREATE TRIGGER ZERARCONT
ON  Conta
FOR DELETE
AS
BEGIN
	DECLARE @Conta INT;

	SELECT @Conta = Id FROM deleted

	INSERT INTO Movimentacao VALUES (@Conta,0,0,GETDATE())
END

DELETE Conta WHERE Id = 2

SELECT * FROM Conta
SELECT * FROM Movimentacao

DROP TRIGGER ZERARCONT