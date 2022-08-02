using Microsoft.AspNetCore.Mvc;

namespace Server.Controllers;

[ApiController]
[Route("main")]
public class MainController : ControllerBase
{
    [HttpGet("key")]
    public string GetKey([FromServices]CryptoService crypto)
    {
        return crypto.getInternalKey(TimeSpan.FromSeconds(1), 24);
    }
}