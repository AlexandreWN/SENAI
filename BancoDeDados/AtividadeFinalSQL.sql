create database atividade
go
use atividade
go

create schema escola
go
create schema secretaria
go
create schema adm
go

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


create function verificaIdade(@idade int)
returns bit
begin
	if (@idade > 18) 
		return(1)
	return(0)
end
go


--PROCEDURES DE INSERT--
create procedure insereAluno
@nome varchar(max), @cpf varchar(max), @data_nascimento date
as
begin
	begin try
		declare @data datetime
		declare @idade int
		declare @temp bit
		set @idade = floor(datediff(day, @data_nascimento, getdate()) / 365.25)
	
		exec @temp = verificaIdade @idade
	
		if (@temp = 1)
			insert into escola.aluno(nome, cpf, data_nascimento, ativo) values (@nome, @cpf, @data_nascimento, 1)
		else
			print 'Aluno menor de idade'
	end try
	begin catch
		insert into adm.log(tabela, comando, mensagem_de_erro, data_erro) values ('aluno', 'insert', ERROR_MESSAGE(), GETDATE())
	end catch
end
go

exec insereAluno 'alexandre','12345678998','2000-12-12'
go

select * from escola.aluno
go

select * from adm.log
go

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

exec inserePagamento '2022-11-11',1
select * from secretaria.pagamentos
go

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

exec insereProfessor 'Lemos', '542546869574', 1
select * from escola.professor
go

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

exec insereCurso 'TI', 1
select * from escola.curso
go

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

exec insereDisciplina 'BD', 1
select * from escola.disciplina
go

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

exec insereDisciplinaXCurso 1, 1, 1
select * from escola.disciplinaXcurso
go

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

exec insereTurma 0,0,0,0,0,1,1,1,1
select * from escola.turma
go

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

exec insereInadimplentes 1
select * from secretaria.inadimplentes
go


--PROCEDURES DE DELETE--
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

exec deleteAluno 1
go

select * from escola.aluno
go

select * from adm.log
go

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

exec deleteProfessor 1
select * from escola.professor
go

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

exec deleteCurso 1
select * from escola.curso
go

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

exec deleteDisciplina 1
select * from escola.disciplina
go

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

exec deleteDisciplinaXCurso 1
select * from escola.disciplinaXcurso
go

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

exec deleteTurma 1
select * from escola.turma
go

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

exec deleteInadimplentes 1
select * from secretaria.inadimplentes
go


--PROCEDURES DE UPDATE--
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

exec updateAluno 'alexandre niktin','12345678998','2000-12-12', 1
go

select * from escola.aluno
go

select * from adm.log
go

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

exec updatePagamento '2022-11-12',1, 'pago'
select * from secretaria.pagamentos
go

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

exec updateProfessor 'Lemoss', '542546869574', 1
select * from escola.professor
go

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

exec updateCurso 'TII', 1, 1
select * from escola.curso
go

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

exec updateDisciplina 'BDD', 1, 1
select * from escola.disciplina
go

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

exec updateDisciplinaXCurso 1, 1, 1, 1
select * from escola.disciplinaXcurso
go

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

exec updateTurma 10,10,10,10,10,1,1,1,1,1
select * from escola.turma
go

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

exec updateInadimplentes 1
select * from secretaria.inadimplentes
go

--TRIGGER EXERCICIO 03--
create trigger trg_updateturma
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

create trigger trg_updatedisc
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
			update escola.turma set ativo=@situacao where id_disciplina_curso=@id
		end
	end
end


--EXERCICIO04--

--EXERCICIO05--

--EXERCICIO06--

--EXERCICIO07--

--EXERCICIO08--

--EXERCICIO09--

--EXERCICIO10--
