using System;
using System.Reflection;
using static System.Console;
using System.Data.SqlClient;
using System.Data;

var assembly = Assembly.GetExecutingAssembly();

string tabela = "", colunas = "", tipos = "",codigo= "";

foreach(var type in assembly.GetTypes())
{
    if (type.Name.EndsWith("Table")){
        tabela = type.Name;
        codigo = $"CREATE TABLE {tabela}(";
        foreach(var atributo in type.GetProperties())
        {
            colunas = atributo.Name;
            if (atributo.PropertyType == typeof(string))
            {
                tipos = "varchar(60)";
            }
            else if (atributo.PropertyType == typeof(int))
            {
                tipos = "int";
            }
            else if (atributo.PropertyType == typeof(char))
            {
                tipos = "varchar(1)";
            }
            else if (atributo.PropertyType == typeof(double))
            {
                tipos = "decimal(9,2)";
            }
            else if (atributo.PropertyType == typeof(decimal))
            {
                tipos = "decimal(9,2)";
            }
            codigo += colunas + " ";
            codigo += tipos + ", ";
        }
        codigo += "\b\b";
        codigo += ");";
    }
}
Console.WriteLine(codigo);

public class ClientTable
{
    public int id { get; set; }
    public string name { get; set; }
    public decimal price { get; set; }
    public char sexo { get; set; }
}
