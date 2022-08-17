DECLARE @cursos TABLE(id int, nome VARCHAR(100));
DECLARE @cursor VARCHAR(100);
DECLARE @id INT;
DECLARE @nome_curso VARCHAR(300);

DECLARE cursor_a CURSOR FOR
	SELECT b.id_curso
	FROM Cursos b;
OPEN cursor_a;

FETCH NEXT FROM cursor_a
INTO @cursor;

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @id = id_curso, @nome_curso = nome_curso FROM Cursos WHERE id_curso = @cursor

	INSERT INTO @cursos VALUES(@id, @nome_curso); 

	FETCH NEXT  FROM cursor_a
	INTO @cursor;
END

CLOSE cursor_a;
DEALLOCATE cursor_a;

--lendo o vetor

select * from @cursos
