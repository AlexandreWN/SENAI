CREATE DATABASE AULA1509

GO

USE AULA1509

GO


CREATE SEQUENCE STESTE AS SMALLINT 
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 1000

GO

ALTER SEQUENCE STESTE
RESTART WITH 1
INCREMENT BY 1

GO

SELECT NEXT VALUE FOR STESTE

GO

CREATE TABLE TESTE (ID INT, NOME VARCHAR(MAX))

GO

INSERT INTO TESTE VALUES(NEXT VALUE FOR STESTE, 'Alexandre Nikitin')

GO

SELECT * FROM TESTE
