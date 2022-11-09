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

create procedure insereAluno
@nome varchar(max), @cpf varchar(max), @data_nascimento date
as
begin
	declare @data datetime
	declare @idade int
	declare @temp bit
	set @idade = floor(datediff(day, @data_nascimento, getdate()) / 365.25)
	
	exec @temp = verificaIdade @idade
	
	if (@temp = 1)
		insert into escola.aluno(nome, cpf, data_nascimento, ativo) values (@nome, @cpf, @data_nascimento, 1)
	else
		print 'Aluno menor de idade'
end

exec insereAluno 'alexandre','12345678998','2000-12-12'