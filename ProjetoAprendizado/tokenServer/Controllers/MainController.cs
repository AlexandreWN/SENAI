using Microsoft.AspNetCore.Mvc;

namespace tokenServer.Controllers;

[ApiController]
[Route("main")]
public class MainController : ControllerBase
{
    [HttpGet("key")]
    public string GetKey([FromServices]CryptoService crypto)
    {
        User user = new User();
        user.Id = 4;
        user.Name = "Alexandre Wilian Nikitin";
        user.IsAdm = true;

        var token = crypto.GetToken(user);
        return token;
    }

    [HttpPost("Conect")]
    public object Conect([FromServices]CryptoService crypto, [FromBody]User user)
    {
        var token = crypto.GetToken(user);
        try{
            return new {
                Message = "Success",
                Token = token
            };
        }
        catch{
            return new {
                Message = "Fail"
            };
        }
    }

    [HttpPost("changename")]
    public object Changename([FromServices]CryptoService crypto, [FromBody]ChangenameParameters parameters)
    {
        User user = null;
        try{
            var token = parameters.Token;
            user = crypto.Validate<User>(token);
        }
        catch{
            return new{
                Message = "Invalid Token",
            };
        }

        if(!user.IsAdm){
            return new{
                Message = "Invalid Access Level"
            };
        }

        user.Name = parameters.NewName;
        var newToken = crypto.GetToken(user);
        return new{
            Message = "Success",
            Token = newToken
        };
    }
}
