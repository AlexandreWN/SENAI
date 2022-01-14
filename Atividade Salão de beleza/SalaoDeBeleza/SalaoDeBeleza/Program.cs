using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SalaoDeBeleza.classes;
using System.Threading.Tasks;

namespace Banco
{

    class Program
    {
        static void Main(string[] args)
        {
            //VARIAVEIS
            int op;
            bool x = true;
            DateTime agendamento;
            DateTime novadataagendamento;
            DateTime Now;
            string cliente;

            //INSTANCIA OBJETO CLASSE Conta
            Class1 ALEATORIA = new Class1();
            while (x)
            {
                try
                {
                    //MENU
                    Console.WriteLine("-----------------------\nDigite a opção desejada");
                    Console.WriteLine("-----------------------\nDigite 1 para agendar atendimento");
                    Console.WriteLine("-----------------------\nDigite 2 para marcar uma nova data");
                    Console.WriteLine("-----------------------\nDigite 3 para consultar agendamento");
                    Console.WriteLine("-----------------------\nDigite 4 para sair byee\n");
                    op = int.Parse(Console.ReadLine());
                    Console.Clear();

                    //SWITCH DE OPÇÕES
                    switch (op)
                    {
                        //RECEBE O NOME DO CLIENTE E A DATA DE AGENDAMENTO
                        case 1:
                            Console.WriteLine("Digite o nome do cliente: ");
                            cliente = Console.ReadLine();
                            Console.WriteLine("Digite a data de agendamento dd/mm/aaaa: ");
                            agendamento = DateTime.Parse(Console.ReadLine());
                            ALEATORIA.cliente = cliente;
                            ALEATORIA.agendamento = agendamento;
                            break;
                        //RECEBE A NOVA DATA DE AGENDAMENTO
                        case 2:
                            Console.WriteLine("Digite a nova data de agendamento dd/mm/aaaa: ");
                            novadataagendamento = DateTime.Parse(Console.ReadLine());
                            ALEATORIA.novadataagendamento = novadataagendamento;
                            ALEATORIA.novaData();
                            break;
                        //MOSTRA OS DADOS DO CLIENTE
                        case 3:
                            Console.WriteLine("Nome do cliente: {0}",ALEATORIA.cliente);
                            Console.WriteLine("Data de agendamento: {0}",ALEATORIA.agendamento);
                            break;
                        //SAI DO PROGRAMA
                        case 4:
                            x = false;
                            break;
                    }
                }

                //CRIADOR DE ERROS
                catch (Exception e)
                {
                    Console.WriteLine($"\n{e.GetType()}: {e.Message}");
                    Console.WriteLine("Precione qualquer tecla para continuar");
                    Console.ReadKey();
                    Console.Clear();
                    continue;
                }

            }
        }
    }
}

