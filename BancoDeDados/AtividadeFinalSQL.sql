create database atividade
go
use atividade
go

------------------------- CREATE SCHEMAS ------------------------------------
create schema escola
go
create schema secretaria
go
create schema adm
go

------------------------- CREATE TABLES ------------------------------------

create table escola.aluno(id int primary key not null identity(1,1), nome varchar(max), cpf varchar(max), data_nascimento datetime, ativo bit)
go
create table escola.professor(id int primary key not null identity(1,1), nome varchar(max), cpf varchar(max), ativo bit)
go
create table escola.curso(id int primary key not null identity(1,1), nome varchar(max), ativo bit)
go
create table escola.disciplina(id int primary key not null identity(1,1), nome varchar(max), ativo bit)
go
create table escola.disciplinaXcurso(id int primary key not null identity(1,1), ativo bit, id_curso int foreign key references escola.curso(id), id_disciplina int foreign key references escola.disciplina(id))
go
create table escola.turma(id int primary key not null identity(1,1), nota1 decimal(5,2), nota2 decimal(5,2), nota3 decimal(5,2), nota4 decimal(5,2), notafinal decimal(5,2), ativo bit, id_aluno int foreign key references escola.aluno(id), id_professor int foreign key references escola.professor(id), id_disciplina_curso int foreign key references escola.disciplinaXcurso(id))
go
create table secretaria.pagamentos(id int primary key not null identity(1,1), boleto datetime, situacao varchar(max) ,id_aluno int foreign key references escola.aluno(id))
go
create table secretaria.inadimplentes(id int primary key not null identity(1,1), data_registro datetime, id_aluno int foreign key references escola.aluno(id))
go
create table adm.log(id int primary key not null identity(1,1), tabela varchar(max), comando varchar(max), mensagem_de_erro varchar(max), data_erro date)
go


------------------------- INSERTS ------------------------------------

INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Macy Bass','569.575.437-13','2023-09-03',0)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Michelle Tyler','703.786.296-42','2022-07-21',0)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Clark Walker','837.575.643-81','2023-05-04',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Fleur Oneal','336.593.898-32','2022-03-04',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Dolan Moody','385.426.186-51','2022-05-19',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Kelsie Baird','175.817.538-61','2023-02-01',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Kevyn Fisher','167.395.213-52','2022-05-25',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Mallory Reyes','634.148.494-22','2022-11-08',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Reece Berg','142.033.744-62','2022-04-12',1)
INSERT INTO escola.aluno (nome,cpf,data_nascimento,ativo) VALUES ('Sawyer Carroll','368.511.862-44','2022-10-23',0)
go

INSERT INTO escola.professor (nome,cpf) VALUES ('Rhoda Webb','846.358.468-43')
INSERT INTO escola.professor (nome,cpf) VALUES ('Damon Hogan','297.365.977-87')
INSERT INTO escola.professor (nome,cpf) VALUES ('Burton Vaughan','786.834.423-62')
INSERT INTO escola.professor (nome,cpf) VALUES ('Emery Tyson','948.642.765-65')
INSERT INTO escola.professor (nome,cpf) VALUES ('Mariko Osborne','212.133.663-33')
INSERT INTO escola.professor (nome,cpf) VALUES ('Alice Delacruz','683.372.796-68')
INSERT INTO escola.professor (nome,cpf) VALUES ('Brody Bell','841.747.638-82')
INSERT INTO escola.professor (nome,cpf) VALUES ('Hayes Wright','244.589.357-86')
INSERT INTO escola.professor (nome,cpf) VALUES ('Kenyon Clemons','912.345.394-17')
INSERT INTO escola.professor (nome,cpf) VALUES ('Todd Emerson','693.427.177-84')
go

INSERT INTO escola.curso (nome,ativo) VALUES ('Fort Laird',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Kungälv',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Alphen aan den Rijn',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Otukpo',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Hong Kong',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Naushahro Firoze',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Waiheke Island',1)
INSERT INTO escola.curso (nome,ativo) VALUES ('Calapan',0)
INSERT INTO escola.curso (nome,ativo) VALUES ('Kotamobagu',0)
INSERT INTO escola.curso (nome,ativo) VALUES ('Hollabrunn',1)
go 

INSERT INTO escola.disciplina (nome,ativo) VALUES ('Osogbo',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Ghizer',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Tampa',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Tomaszów Mazowiecki',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Emalahleni',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Kashmore',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Gary',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Mount Gambier',1)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Máfil',0)
INSERT INTO escola.disciplina (nome,ativo) VALUES ('Haarlem',1)
go 

INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (1,1,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (2,2,0)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (3,3,0)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (4,4,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (5,5,0)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (6,6,0)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (7,7,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (8,8,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (9,9,1)
INSERT INTO escola.disciplinaXcurso (id_curso,id_disciplina,ativo) VALUES (10,10,0)
go

INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (1,1,1,10,5,3,5,4,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (2,2,2,6,9,2,8,3,1)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (3,3,3,4,7,4,6,9,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (4,4,4,0,2,7,2,3,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (5,5,5,10,6,6,4,1,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (6,6,6,6,3,7,9,6,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (7,7,7,6,1,6,7,4,1)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (8,8,8,3,4,3,8,7,0)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (9,9,9,1,3,4,9,6,1)
INSERT INTO escola.turma (id_aluno,id_professor,id_disciplina_curso,nota1,nota2,nota3,nota4,notafinal,ativo) VALUES (10,10,10,3,0,4,1,5,1)
go

INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) values ('2022-11-09', 'pendente', 1)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) values ('2022-11-10', 'pendente', 2)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) values ('2022-11-11', 'pendente', 3)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) values ('2022-11-12', 'pendente', 4)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) values ('2022-11-08', 'pendente', 5)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) values ('2022-12-01', 'pendente', 6)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) values ('2022-10-20', 'pendente', 7)
INSERT INTO secretaria.pagamentos (boleto, situacao, id_aluno) values ('2022-12-09', 'pendente', 1)
go

INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (1,'2022-01-01')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (2,'2023-09-15')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (3,'2022-11-24')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (4,'2023-10-15')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (5,'2023-04-18')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (6,'2023-05-28')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (7,'2022-11-08')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (8,'2023-01-13')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (9,'2022-02-03')
INSERT INTO secretaria.inadimplentes (id_aluno,data_registro) VALUES (10,'2023-02-04')
go


------------------------- FUNÇÕES ------------------------------------

create function verificaIdade(@data_nascimento datetime)
returns bit
begin
	declare @idade int
	set @idade = floor(datediff(day, @data_nascimento, getdate()) / 365.25)

	if (@idade > 18) 
		return(1)
	return(0)
end
go


------------------------- PROCEDURES DE INSERT ------------------------------------

--ALUNO--
create procedure insereAluno
@nome varchar(max), @cpf varchar(max), @data_nascimento date
as
begin
	begin try
		declare @data datetime
		declare @verificacao_idade bit

		exec @verificacao_idade = verificaIdade @data_nascimento
	
		if (@verificacao_idade = 1)
			insert into escola.aluno(nome, cpf, data_nascimento, ativo) values (@nome, @cpf, @data_nascimento, 1)
		else
			print 'Aluno menor de idade'
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('aluno', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--PROFESSOR--
create procedure insereProfessor
@nome varchar(max), @cpf varchar(max), @ativo bit
as
begin
	begin try
		insert into escola.professor(nome, cpf, ativo) values (@nome, @cpf, @ativo)
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('professor', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--CURSO--
create procedure insereCurso
@nome varchar(max), @ativo bit
as
begin
	begin try
		insert into escola.curso(nome, ativo) values (@nome, @ativo)
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('curso', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--DISCIPLINA--
create procedure insereDisciplina
@nome varchar(max), @ativo bit
as
begin
	begin try
		insert into escola.disciplina(nome, ativo) values (@nome, @ativo)
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('disciplina', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--DISCIPLINA_CURSO--
create procedure insereDisciplinaXCurso
@ativo bit, @id_curso int , @id_disciplina int
as
begin
	begin try
		insert into escola.disciplinaXcurso(ativo, id_curso, id_disciplina) values (@ativo, @id_curso, @id_disciplina)
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('disciplinaXcurso', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--TURMA--
create procedure insereTurma
@nota1 decimal(5,2), @nota2 decimal(5,2), @nota3 decimal(5,2), @nota4 decimal(5,2), @notafinal decimal(5,2), @ativo bit , @id_aluno int, @id_professor int, @id_disciplina_curso int
as
begin
	begin try
		insert into escola.turma (nota1, nota2, nota3, nota4, notafinal, ativo, id_aluno, id_professor, id_disciplina_curso) values (@nota1, @nota2, @nota3, @nota4, @notafinal, @ativo, @id_aluno, @id_professor, @id_disciplina_curso)
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('turma', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--PAGAMENTOS--
create procedure inserePagamento
@boleto datetime, @id_aluno int
as
begin
	begin try
		insert into secretaria.pagamentos(boleto, situacao, id_aluno) values (@boleto, 'pendente', @id_aluno)
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('pagamentos', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--INADIMPLENTES--
create procedure insereInadimplentes
@id_aluno int
as
begin
	begin try
		insert into secretaria.inadimplentes (data_registro, id_aluno) values (GETDATE(), @id_aluno)
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('inadimplentes', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go




------------------------- PROCEDURES DE DELETE ------------------------------------

--ALUNO--
create procedure deleteAluno
@id int
as
begin
	begin try
		update escola.aluno set ativo = 0 where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('aluno', 'delete', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--PROFESSOR--
create procedure deleteProfessor
@id int
as
begin
	begin try
		update escola.professor set ativo = 0 where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('professor', 'delete', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--CURSO--
create procedure deleteCurso
@id int
as
begin
	begin try
		update escola.curso set ativo = 0 where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('curso', 'delete', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--DISCIPLINA--
create procedure deleteDisciplina
@id int
as
begin
	begin try
		update escola.disciplina set ativo = 0 where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('disciplina', 'delete', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--DISCIPLINA_CURSO--
create procedure deleteDisciplinaXCurso
@id int
as
begin
	begin try
		update escola.disciplinaXcurso set ativo = 0 where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('disciplinaXcurso', 'delete', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--TURMA--
create procedure deleteTurma
@id int
as
begin
	begin try
		update escola.turma set ativo = 0 where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('turma', 'delete', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--PAGAMENTOS--
create procedure deletePagamentos
@id_aluno int
as
begin
	begin try
		delete from secretaria.pagamentos where id_aluno = @id_aluno
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('pagamentos', 'delete', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--INADIMPLENTES--
create procedure deleteInadimplentes
@id_aluno int
as
begin
	begin try
		delete from secretaria.inadimplentes where id_aluno = @id_aluno
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('inadimplentes', 'delete', ERROR_MESSAGE(), GETDATE())
	end catch
end
go



------------------------- PROCEDURES DE UPDATE ------------------------------------

--ALUNO--
create procedure updateAluno
@nome varchar(max), @cpf varchar(max), @data_nascimento date, @ativo int
as
begin
	begin try
		declare @data datetime
		declare @idade int
		declare @temp bit
		set @idade = floor(datediff(day, @data_nascimento, getdate()) / 365.25)
	
		exec @temp = verificaIdade @idade
	
		if (@temp = 1)
			update escola.aluno set nome = @nome, data_nascimento = @data_nascimento, ativo = @ativo where cpf = @cpf
		else
			print 'Aluno menor de idade'
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('aluno', 'update', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--PROFESSOR--
create procedure updateProfessor
@nome varchar(max), @cpf varchar(max), @ativo bit
as
begin
	begin try
		update escola.professor set nome = @nome, ativo = @ativo where cpf = @cpf
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('professor', 'update', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--CURSO--
create procedure updateCurso
@nome varchar(max), @ativo bit, @id int
as
begin
	begin try
		update escola.curso set nome = @nome, ativo = @ativo where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('curso', 'update', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--DISCIPLINA--
create procedure updateDisciplina
@nome varchar(max), @ativo bit, @id int
as
begin
	begin try
		update escola.disciplina set nome = @nome, ativo = @ativo where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('disciplina', 'update', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--DISCIPLINA_CURSO--
create procedure updateDisciplinaXCurso
@ativo bit, @id_curso int , @id_disciplina int, @id int
as
begin
	begin try
		update escola.disciplinaXcurso set ativo = @ativo, id_curso = @id_curso, id_disciplina = @id_disciplina where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('disciplinaXcurso', 'update', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--TURMA--
create procedure updateTurma
@nota1 decimal(5,2), @nota2 decimal(5,2), @nota3 decimal(5,2), @nota4 decimal(5,2), @notafinal decimal(5,2), @ativo bit , @id_aluno int, @id_professor int, @id_disciplina_curso int, @id int
as
begin
	begin try
		update escola.turma set nota1 = @nota1, nota2 = @nota2, nota3 = @nota3, nota4 = @nota4, notafinal = @notafinal, ativo = @ativo, id_aluno = @id_aluno, id_professor = @id_professor, id_disciplina_curso = @id_disciplina_curso where id = @id
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('turma', 'update', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--PAGAMENTO--
create procedure updatePagamento
@boleto datetime, @id_aluno int, @situacao varchar(max)
as
begin
	begin try
		update secretaria.pagamentos set boleto = @boleto, situacao = @situacao where id_aluno = @id_aluno
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('pagamentos', 'update', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

--INADIMPLENTES--
create procedure updateInadimplentes
@id_aluno int
as
begin
	begin try
		update secretaria.inadimplentes set data_registro = GETDATE() where id_aluno = @id_aluno
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('inadimplentes', 'update', ERROR_MESSAGE(), GETDATE())
	end catch
end
go





------------------------- TRIGGERS EXERCICIO 03 ------------------------------------

create trigger trg_update_curso
on escola.curso
after update
as
begin
	declare @situacao bit
	declare @id int
	if update(ativo)
	begin
		select @situacao = ativo from inserted
		select @id = id from inserted
		if(@situacao=0)
		begin
			update escola.disciplinaXcurso set ativo=@situacao where id_curso=@id
		end
	end
end
go

create trigger trg_update_disciplina
on escola.disciplina
after update
as
begin
	declare @situacao bit
	declare @id int
	if update(ativo)
	begin
		select @situacao = ativo from inserted
		select @id = id from inserted
		if(@situacao=0)
		begin
			update escola.disciplinaXcurso set ativo=@situacao where id_curso=@id
		end
	end
end
go

create trigger trg_update_disciplinaXcurso
on escola.disciplinaXcurso
after update
as
begin
	declare @situacao bit
	declare @id int
	if update(ativo)
	begin
		select @situacao = ativo from inserted
		select @id = id from inserted
		if(@situacao=0)
		begin
			update escola.turma set ativo=@situacao where id_disciplina_curso=@id
		end
	end
end
go

--EXERCICIO04--

create procedure update_situacao_pagamento
as
begin
	begin transaction
		begin try
			update secretaria.pagamentos set situacao = 'em atraso' where boleto > GETDATE() and situacao = 'pendente'

			insert into secretaria.inadimplentes (id_aluno,data_registro) select id_aluno, GETDATE() from secretaria.pagamentos group by id_aluno having SUM(CASE WHEN situacao = 'em atraso' THEN 1 ELSE 0 END) > 3
		end try
		begin catch
			insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('pagamentos', 'update', ERROR_MESSAGE(), GETDATE())

			IF @@TRANCOUNT > 0  -- if para verificar se há transação aberta
				ROLLBACK TRANSACTION;  -- se entro no catch, executa um rollback para desfazer
		end catch
		
		IF @@TRANCOUNT > 0  -- if para verificar se há transação aberta. Caso tenha entrado no catch acima, terá sido executado o rollback, não existirá mais transação aberta e não entrará nesse if
			COMMIT TRANSACTION; 
	end
end
go



--EXERCICIO05--
CREATE VIEW notas_alunos as (
	select escola.aluno.Nome as 'Nome aluno', escola.disciplina.nome as 'Nome disciplina', Nota1, Nota2, Nota3, Nota4, NotaFinal 
	from escola.turma 
	inner join escola.aluno on escola.aluno.id = id_aluno 
	inner join escola.disciplinaXcurso on escola.disciplinaXcurso.id = id_disciplina_curso 
	inner join escola.disciplina on escola.disciplina.id = id_disciplina
)
go
select * from notas_alunos order by [Nome aluno]


CREATE VIEW alunos_inadimplentes as (
	select escola.aluno.nome as 'Nome Aluno' 
from secretaria.inadimplentes 
inner join escola.aluno on escola.aluno.id = id_aluno
)
go
select * from alunos_inadimplentes order by [Nome aluno]


--EXERCICIO06--
Create function alunos_turma (@id_disciplina int, @id_curso int)
returns table
as
return
	select escola.aluno.Nome as 'Nome aluno' 
	from escola.turma 
	inner join escola.aluno on escola.aluno.id = id_aluno
	inner join escola.disciplinaXcurso on escola.disciplinaXcurso.id = id_disciplina_curso
	where escola.disciplinaXcurso.id_curso = @id_curso and escola.disciplinaXcurso.id_disciplina = @id_disciplina



Alter function disciplinas_aluno (@id_aluno int)
returns table
as
return
	select escola.disciplina.Nome as 'Nome aluno' 
	from escola.turma 
	inner join escola.aluno on escola.aluno.id = id_aluno
	inner join escola.disciplinaXcurso on escola.disciplinaXcurso.id = id_disciplina_curso
	inner join escola.disciplina on escola.disciplina.id = escola.disciplinaXcurso.id_disciplina
	where id_aluno = @id_aluno



--EXERCICIO07--
CREATE NONCLUSTERED INDEX IDX_UF ON clientes (UF) 
--  Temos o nome do indice, a tabela onde ele será criado e para qual coluna será criado



--EXERCICIO08--

create login user1 with password='123456789123'
create user user1 from login user1

create login user2 with password='123456789123'
create user user2 from login user2

create login user3 with password='123456789123'
create user user3 from login user3


grant all to user1
grant alter, execute, view definition to user2 
grant select, insert, update, delete on SCHEMA :: escola to user3



--EXERCICIO09--


