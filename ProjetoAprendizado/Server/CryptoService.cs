using static System.Convert;

public class CryptoService
{
    private string getRandomString(int seed, int size)
    {
        int base64BitCount = size * 6;
        int bytesCount = Math.Ceiling(base64BitCount / 8.0);
        byte[] randData = new byte[bytesCount];

        Ramdom rand = new Ramdom(seed);
        rand.NextBytes(randData);

        var randString = ToBase64String(randData);

        return randString;
    }

}