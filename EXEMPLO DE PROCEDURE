CREATE PROCEDURE INCLUIR
	@NomeCurso varchar(100),
	@LoginCdastro varchar(100)
AS
BEGIN
	DECLARE @vIdCurso int;
	DECLARE @vExisteCurso int;

	SELECT @vExisteCurso = id_curso from Cursos WHERE nome_curso = @NomeCurso

	IF @vExisteCurso > 0
		BEGIN
			UPDATE Cursos SET login_cadastro = @LoginCdastro, data_cadastro = GETDATE()
			SELECT 'O Curso Foi Atualizado'
		END
	ELSE
		BEGIN
			select @vIdCurso = max(c.id_curso)+1 from Cursos c
			
			INSERT INTO  Cursos (id_curso ,nome_curso, data_cadastro, login_cadastro) VALUES (@vIdCurso, @NomeCurso, GETDATE(), @LoginCdastro)
			SELECT @vIdCurso = id_curso FROM Cursos WHERE id_curso = @vIdCurso;
			SELECT @vIdCurso as Retorno
		END
END

EXEC INCLUIR 'Word Intermediario4', 'aabbcc'

SELECT * FROM Cursos 
