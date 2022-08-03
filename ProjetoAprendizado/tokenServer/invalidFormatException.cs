public class JwtInvalidFormatExeptio : Exception
{
    public override string Message => "O token não está no formato x.y.z requerido";
}