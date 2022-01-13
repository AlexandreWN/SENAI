using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace FormulariosDeCadastro
{
    public partial class Form1 : Form
    {
        MySqlConnection Conexao;
        public Form1()
        {
            InitializeComponent();
        }

        private void Salvar1_Click(object sender, EventArgs e)
        {
            try
            {
                //configurar qual banco sera acessado com usuario e senha
                string data_source = "datasource=localhost;username=root;password=usbw;database=db_agenda;";

                //criar conexao com o banco de dados
                Conexao = new MySqlConnection(data_source);

                string sql = "INSERT INTO cliente (PrecoCompra, PrecoVenda, Estoque,Descricao) VALUES ('" + Compra.Text + "', '" + Venda.Text + "','" + Estoque.Text + "','" + Descricao.Text + "')";

                //Executrar comando mysql
                MySqlCommand comando = new MySqlCommand(sql, Conexao);

                Conexao.Open();

                comando.ExecuteReader();

                MessageBox.Show("Inserido com sucesso");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                Conexao.Close();
            }
        }
    }
}