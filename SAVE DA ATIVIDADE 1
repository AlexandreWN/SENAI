/*
CREATE DATABASE Loja;
GO

USE Loja;
GO


/* Tabelas */

CREATE TABLE Produto(
	Id INT IDENTITY PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	DataValidade DATE NOT NULL,
	Preco DECIMAL(9, 3) NOT NULL
);

CREATE TABLE Estoque(
	Id INT IDENTITY PRIMARY KEY,
	Quantidade INT NOT NULL,
	ProdutoId INT FOREIGN KEY REFERENCES Produto(Id)
);

CREATE TABLE Cliente(
	Id INT IDENTITY PRIMARY KEY,
	Nome VARCHAR(MAX) NOT NULL,
	Cpf VARCHAR(11) NOT NULL
);

CREATE TABLE Vendedor(
	Id INT IDENTITY PRIMARY KEY,
	Nome VARCHAR(MAX) NOT NULL,
	Cpf VARCHAR(11) NOT NULL,
	DataDeAdmissao DATE,
	Ativo BIT
);

CREATE TABLE Comissao(
	Id INT IDENTITY PRIMARY KEY,
	Mes INT NOT NULL,
	Ano INT NOT NULL,
	ValorComissao DECIMAL(19,3),
	VendedorId INT NOT NULL FOREIGN KEY REFERENCES Vendedor(Id)
);

CREATE TABLE Venda(
	Id INT IDENTITY PRIMARY KEY,
	Quantidade  INT NOT NULL,
	DataVenda DATE NOT NULL,
	PrecoFinal DECIMAL(19,3),
	ProdutoId INT FOREIGN KEY REFERENCES Produto(Id),
	VendedorId INT NOT NULL FOREIGN KEY REFERENCES Vendedor(Id),
	ClienteId INT NOT NULL FOREIGN KEY REFERENCES Vendedor(Id),
);
*/

/*INSERTS*/
/*
INSERT INTO Produto(Nome, DataValidade, Preco) VALUES ('BATATA', GETDATE() + 20, '200')
INSERT INTO Produto(Nome, DataValidade, Preco) VALUES ('POLENTA', GETDATE() + 200, '100')
INSERT INTO Produto(Nome, DataValidade, Preco) VALUES ('FRANGO', GETDATE() + 10, '25')
INSERT INTO Produto(Nome, DataValidade, Preco) VALUES ('SASSAMI', GETDATE() + 5, '36')
INSERT INTO Produto(Nome, DataValidade, Preco) VALUES ('ARROZ', GETDATE() + 9, '42')
INSERT INTO Produto(Nome, DataValidade, Preco) VALUES ('TRIGO', GETDATE() + 8, '52')
INSERT INTO Produto(Nome, DataValidade, Preco) VALUES ('FEIJAO', GETDATE() + 7, '77')
INSERT INTO Produto(Nome, DataValidade, Preco) VALUES ('FAROFA', GETDATE() + 92, '88')
SELECT * FROM Produto

INSERT INTO Estoque(Quantidade, ProdutoId) VALUES (51, 1)
INSERT INTO Estoque(Quantidade, ProdutoId) VALUES (515, 2)
INSERT INTO Estoque(Quantidade, ProdutoId) VALUES (7856, 3)
INSERT INTO Estoque(Quantidade, ProdutoId) VALUES (5781, 4)
INSERT INTO Estoque(Quantidade, ProdutoId) VALUES (7, 5)
INSERT INTO Estoque(Quantidade, ProdutoId) VALUES (86, 6)
INSERT INTO Estoque(Quantidade, ProdutoId) VALUES (782, 7)
INSERT INTO Estoque(Quantidade, ProdutoId) VALUES (782, 8)

INSERT INTO Cliente(Nome, Cpf) VALUES ('Allan Kley', 11235496584)
INSERT INTO Cliente(Nome, Cpf) VALUES ('Alexanrde Nikitin', 56496561898)
INSERT INTO Cliente(Nome, Cpf) VALUES ('Bruno Viotto', 12533654789)

INSERT INTO Vendedor(Nome,Cpf,DataDeAdmissao,Ativo) VALUES ('Allan Kley Vendedor', 11235496585, GETDATE() - 300, 1)
INSERT INTO Vendedor(Nome,Cpf,DataDeAdmissao,Ativo) VALUES ('Alexanrde Nikitin Vendedor', 11235496554, GETDATE() - 350, 1)
INSERT INTO Vendedor(Nome,Cpf,DataDeAdmissao,Ativo) VALUES ('Bruno Viotto Vendedor', 11235496598, GETDATE() - 390, 1)

INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (12,2022,500,1)
INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (11,2022,500,1)
INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (12,2022,500,1)
INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (10,2022,500,2)
INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (8,2022,500,2)
INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (9,2022,500,2)
INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (5,2022,500,3)
INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (7,2022,500,3)
INSERT INTO Comissao(Mes,Ano,ValorComissao,VendedorId) VALUES (9,2022,500,3)

INSERT INTO Venda(Quantidade,DataVenda,PrecoFinal,ProdutoId,VendedorId,ClienteId) VALUES (1, GETDATE(), 200, 1, 1, 1)
INSERT INTO Venda(Quantidade,DataVenda,PrecoFinal,ProdutoId,VendedorId,ClienteId) VALUES (1, GETDATE(), 100, 2, 1, 1)
INSERT INTO Venda(Quantidade,DataVenda,PrecoFinal,ProdutoId,VendedorId,ClienteId) VALUES (1, GETDATE(), 25, 3, 1, 1)
INSERT INTO Venda(Quantidade,DataVenda,PrecoFinal,ProdutoId,VendedorId,ClienteId) VALUES (1, GETDATE(), 36, 4, 2, 2)
INSERT INTO Venda(Quantidade,DataVenda,PrecoFinal,ProdutoId,VendedorId,ClienteId) VALUES (1, GETDATE(), 42, 5, 2, 2)
INSERT INTO Venda(Quantidade,DataVenda,PrecoFinal,ProdutoId,VendedorId,ClienteId) VALUES (1, GETDATE(), 52, 6, 3, 2)
INSERT INTO Venda(Quantidade,DataVenda,PrecoFinal,ProdutoId,VendedorId,ClienteId) VALUES (1, GETDATE(), 77, 7, 3, 3)
INSERT INTO Venda(Quantidade,DataVenda,PrecoFinal,ProdutoId,VendedorId,ClienteId) VALUES (1, GETDATE(), 88, 8, 3, 3)
*/

/* Procedures */
/*
CREATE PROCEDURE QTDVENDIDA
AS
BEGIN
	SELECT produto.Id, produto.nome, SUM(venda.quantidade) AS 'quantidade' FROM produto
	INNER JOIN venda ON venda.ProdutoId = produto.id
	GROUP BY produto.id, produto.nome
END

EXEC QTDVENDIDA


CREATE PROCEDURE VENDASEFETUADAS
AS
BEGIN
	SELECT venda.id AS 'Codigo Produto', cliente.nome AS 'Cliente', precofinal AS 'Total venda', vendedor.nome AS 'Vendedor' FROM venda
	INNER JOIN cliente ON cliente.id = venda.ClienteId
	INNER JOIN vendedor ON vendedor.id = venda.VendedorId
END

EXEC VENDASEFETUADAS
*/
CREATE PROCEDURE COMISSAOVENDEDORES
AS
BEGIN
	SELECT venda.id AS 'Codigo Produto', cliente.nome AS 'Cliente', precofinal AS 'Total venda', vendedor.nome AS 'Vendedor' FROM venda
	INNER JOIN cliente ON cliente.id = venda.ClienteId
	INNER JOIN vendedor ON vendedor.id = venda.VendedorId
END

