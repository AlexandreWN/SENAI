CREATE VIEW aluno_curso
AS
SELECT a.nome, c.nome_curso
FROM Alunos AS a
INNER JOIN AlunosxTurmas AS alt
ON a.id_aluno = alt.id_aluno 
INNER JOIN Turmas t
ON alt.id_turma = t.id_turma
INNER JOIN Cursos c
ON t.id_curso = c.id_curso


select * from aluno_curso
