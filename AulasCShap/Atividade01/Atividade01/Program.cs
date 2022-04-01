using System;
using System.Reflection;
using static System.Console;
using System.Data.SqlClient;
using System.Data;


var assembly = Assembly.GetExecutingAssembly();

string tabela = "", colunas = "", tipos = "",codigo= "", nome;
string conexao;
SqlConnection con;
conexao = ("Server=SNCCH01LABF114\\TEW_SQLEXPRESS;Database=teste;Trusted_Connection=True;");
con = new SqlConnection(conexao);

foreach (var type in assembly.GetTypes())
{
    var talbeatt = type.GetCustomAttribute<TableAttribute>();
    if (talbeatt != null){
        tabela = type.Name;
        codigo = $"CREATE TABLE {tabela}(";
        foreach(var atributo in type.GetProperties())
        {
            colunas = atributo.Name;
            var valorint = atributo.GetCustomAttribute<IntAttribute>();
            if (valorint != null) 
            { 
                tipos += "int ";
            }
            
            var valorstring = atributo.GetCustomAttribute<VarcharAttribute>();
            if (valorstring != null)
            {
                tipos += "varchar" + "(" + valorstring.Size + "" + ")";
            }

            var identityatt = atributo.GetCustomAttribute<IdentityAttribute>();
            if (identityatt != null)
            {
                tipos += "IDENTITY(1,1) ";
            }

            var primarykey = atributo.GetCustomAttribute<PrimaryKeyAttribute>();
            if(primarykey != null)
            {
                tipos += "PRIMARY KEY" + "";
            }

            var notnull = atributo.GetCustomAttribute<NotNullAttribute>();
            if(notnull != null)
            {
                tipos += " NOT NULL" + "";
            }

            codigo += colunas + " ";
            codigo += tipos;
            codigo += ", ";
            tipos = "";

        }
      
        codigo += "\b\b";
        codigo += ");";
    }
}



Console.WriteLine(codigo);

SqlCommand cmd = new SqlCommand(codigo, con);
con.Open();
cmd.ExecuteNonQuery();
con.Close();

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
            var query = "select * from " + typeof(T).Name;
            //var query = "select * from " + typeof(T).GetProperties;
            //DataTable dt = new DataTable();
            //dt.Load(SqlCommand.ExecuteQuery());
        }
    }

    public T FindById(object i)
    {
        var query = "select * from " + typeof(T).Name + "where";
    }

    public void Insert(T obj)
    {

    }
}