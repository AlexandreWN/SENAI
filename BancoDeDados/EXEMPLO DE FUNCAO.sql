CREATE FUNCTION funcaoteste (@a INT,@b INT)
RETURNS INT
AS
BEGIN
	DECLARE @res INT
	SET @res = @a+@b
	RETURN @res
END

SELECT dbo.funcaoteste(1,3)
