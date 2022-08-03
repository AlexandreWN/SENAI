public class JwtInvalidSignatureExeption : Exception
{
    public override string Message => "Token é invalido ou ja expirou.";
}