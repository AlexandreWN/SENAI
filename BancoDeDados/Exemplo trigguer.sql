create database teste
go
use teste
go
create table tabela1(nome varchar(100))
create table tabela2(texto varchar(100))

go
create trigger trg_teste
on tabela1 after insert as 
begin
	insert into tabela2(texto) values ('Fiz uma inserção')
end


insert into tabela1 values('Alexandre')
select * from tabela1
select * from tabela2
