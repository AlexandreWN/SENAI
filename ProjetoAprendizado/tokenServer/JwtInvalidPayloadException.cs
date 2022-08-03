public class JwtInvalidPayloadException : Exception
{
    public override string Message => "Payload invalido";
}