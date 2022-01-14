using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//RETORNA ERROS
namespace SalaoDeBeleza.classes
{
    class Class2 : ApplicationException
    {
        public Class2(string mensage) : base(mensage)
        {

        }
    }
}
