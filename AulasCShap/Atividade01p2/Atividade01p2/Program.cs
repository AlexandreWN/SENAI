//bibliotecas
using System;
using System.Reflection;
using static System.Console;
using System.Data.SqlClient;
using System.Data;

//Pega execussão do Assembly
var assembly = Assembly.GetExecutingAssembly();

//Variaveis de montagem do create table
string tabela = "", colunas = "", tipos = "", codigo = "", nome;
//variavel de conexão
string conexao;
SqlConnection con;
//realiza a conexao com o banco
conexao = ("Server=JVLPC0565\\SQLEXPRESS;Database=teste;Trusted_Connection=True;");
con = new SqlConnection(conexao);

//varre todas as classes presentes no programa
foreach (var type in assembly.GetTypes())
{
    //seleciona as classes que tem um identificador do tipo tabela
    var talbeatt = type.GetCustomAttribute<TableAttribute>();
    //Se a classe não estiver vasia ele executa
    if (talbeatt != null)
    {
        //pega o nome da classe e joga como nome da tabela
        tabela = type.Name;
        codigo = $"CREATE TABLE {tabela}(";

        //varre todas as propriedade dos atributos da classe
        foreach (var atributo in type.GetProperties())
        {
            //coloca na variavel colunas o nome do atributo
            colunas = atributo.Name;
            
            //joga na variavel o tipo determinado de atributo
            var valorint = atributo.GetCustomAttribute<IntAttribute>();
            //compara os valores e determina se verdadeiro o valor de tipos
            if (valorint != null)
            {
                tipos += "int ";
            }

            //joga na variavel o tipo determinado de atributo
            var valorstring = atributo.GetCustomAttribute<VarcharAttribute>();
            //compara os valores e determina se verdadeiro o valor de tipos
            if (valorstring != null)
            {
                tipos += "varchar" + "(" + valorstring.Size + "" + ")";
            }

            //joga na variavel o tipo determinado de atributo
            var identityatt = atributo.GetCustomAttribute<IdentityAttribute>();
            //compara os valores e determina se verdadeiro o valor de tipos
            if (identityatt != null)
            {
                tipos += "IDENTITY(1,1) ";
            }

            //joga na variavel o tipo determinado de atributo
            var primarykey = atributo.GetCustomAttribute<PrimaryKeyAttribute>();
            //compara os valores e determina se verdadeiro o valor de tipos
            if (primarykey != null)
            {
                tipos += "PRIMARY KEY" + "";
            }

            //joga na variavel o tipo determinado de atributo
            var notnull = atributo.GetCustomAttribute<NotNullAttribute>();
            //compara os valores e determina se verdadeiro o valor de tipos
            if (notnull != null)
            {
                tipos += " NOT NULL" + "";
            }

            //Concatena as strings para formar o comando
            codigo += colunas + " ";
            codigo += tipos;
            codigo += ", ";
            tipos = "";

        }

        codigo += "\b\b";
        codigo += ");";
    }
}

//escreve o comando no console
Console.WriteLine(codigo);

//cria o sqlcommand e insere no banco
SqlCommand cmd = new SqlCommand(codigo, con);
con.Open();
cmd.ExecuteNonQuery();
con.Close(); // fecha a conexão com o banco sql
//dropa tabelas para 
/*
SqlCommand cmdd = new SqlCommand("drop table ClientTable", con);
con.Open();
cmdd.ExecuteNonQuery();
con.Close();
*/
public class TableAttribute : Attribute
{

}

public class PrimaryKeyAttribute : Attribute
{

}

public class IdentityAttribute : Attribute
{
    public int Initial { get; set; }
    public int Increment { get; set; }

    public IdentityAttribute(int initial, int increment)
    {
        this.Initial = initial;
        this.Increment = increment;
    }
}

public class VarcharAttribute : Attribute
{
    public int Size { get; set; }
    public VarcharAttribute(int size)
    {
        this.Size = size;
    }
}

public class IntAttribute : Attribute
{

}

public class NotNullAttribute : Attribute
{

}


[Table]
public class ClientTable
{
    [Int]
    [Identity(1, 1)]
    [PrimaryKey]
    [NotNull]
    public int id { get; set; }

    [Varchar(60)]
    [NotNull]
    public string name { get; set; }
}

public class Access<T>
    where T : new()
{
    public List<T> All
    {
        get
        {
            string conexao;
            SqlConnection con;
            conexao = ("Server=JVLPC0565\\SQLEXPRESS;Database=teste;Trusted_Connection=True;");
            con = new SqlConnection(conexao);
            List<T> list = new List<T>();  

            var query = "select * from " + typeof(T).Name;
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            T obj = new T();

            foreach(var prop in typeof(T).GetProperties())
            {
                prop.SetValue(obj, null);
            }

            list.Add(obj);

            return list;
        }
    }

    /*
    public Table FindById(object i)
    {
        var query = "select * from " + typeof(Table).Name + "where";
    }

    public void Insert(Table obj)
    {

    }
    */
}

