using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SalaoDeBeleza.classes
{
    class Class1
    {
        //VARIAVEIS GET E SET
        public DateTime agendamento { get; set; }
        public DateTime novadataagendamento { get; set; }
        public string cliente { get; set; }

        //FUNÇÃO QUE VERIFICA AS DATAS DE NOVO AGENDAMENTO
        public void novaData()
        {
            //SE CLIENTE FOR IGUAL A NULL ELE ENTRA AQUI
            if (cliente == null)
            {
                throw new Class2("Realize o agendamento antes de tentar marcar uma nova data");
            }
            //SE AGENDAMENTO FOR MAIOR QU EA NOVA DATA ELE ENTRA QUI
            if (agendamento > novadataagendamento)
            {
                throw new Class2("A nova data de agendamento é menor que a anterior");
            }
            //SE TUDO DER CERTO ELE ENTRA AQUI
            agendamento = novadataagendamento;
            throw new Class2("Alterado com sucesso");
        }
    }
}