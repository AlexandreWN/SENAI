CREATE PROCEDURE insere_com_mensagem
@nome varchar(max), @dt_nasc date, @sexo varchar(1), @login varchar(max),
@mensagem varchar(max) output
AS
BEGIN
	INSERT INTO Alunos VALUES(5, @nome, @dt_nasc, @sexo, GETDATE(), @login)
	SET @mensagem = 'Inserção feita com sucesso'
END

declare @mensagem VARCHAR(MAX)
SET @mensagem=' '
EXEC insere_com_mensagem 'Alexandre','05/03/2002', 'M','Nikitin', @mensagem output

print(@mensagem)
