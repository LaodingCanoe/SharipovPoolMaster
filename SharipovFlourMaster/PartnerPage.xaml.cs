using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using static SharipovFlourMaster.DB_Class;

namespace SharipovFlourMaster
{
    /// <summary>
    /// Логика взаимодействия для PartnerPage.xaml
    /// </summary>
    public partial class PartnerPage : Page
    {
        DB_Class db = new DB_Class();

        public string connectionString = "Data Source=localhost;Database=SharipovPolMaster;User Id=Inventory_Admin;Password=Admin007;";
        public PartnerPage()
        {
            InitializeComponent();
            PartnerLV.ItemsSource = db.LoadData();
            
        }

        

        private void PartnerLV_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void EditBT_Click(object sender, RoutedEventArgs e)
        {
            
            var selected = PartnerLV.SelectedItem as Partner;
            if (selected != null)
            {
                MainClass.MainFrame.Navigate(new AddEditPage(selected));
            }
            else
            {
                MessageBox.Show("Выберите партнёра для редактирования");
            }
        }

        private void DeleteBT_Click(object sender, RoutedEventArgs e)
        {
            var selectedPartner = PartnerLV.SelectedItem as Partner;
            if (selectedPartner != null)
            {
                if (MessageBox.Show("Вы точно хотите выполнить удаление?", "Внимание!",
                       MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
                {
                    try
                    {
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            connection.Open();
                            string deleteQuery = "DELETE FROM Партнеры WHERE ИД = @ID";
                            SqlCommand command = new SqlCommand(deleteQuery, connection);
                            command.Parameters.AddWithValue("@ID", selectedPartner.ID);
                            command.ExecuteNonQuery();
                        }
                        MessageBox.Show("Партнёр успешно удалён");
                        PartnerLV.ItemsSource = db.LoadData();
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"Ошибка при удалении данных: {ex.Message}");
                    }
                }
            }

        }
        public void Update()
        {
            PartnerLV.ItemsSource = db.LoadData();
        }
        public int PartnerSales(int count)
        {
            if (count < 10000)
            {
                return 0;
            }
            if (count < 50000 && count > 10000)
            {
                return 5;
            }
            if (count < 300000 && count > 50000)
            {
                return 10;
            }
            else
            {
                return 15;
            }
        }

        private void AddBT_Click(object sender, RoutedEventArgs e)
        {
            MainClass.MainFrame.Navigate(new AddEditPage(null));

        }

    }



    public class PartnerSale
    {
        public int ID { get; set; }
        public int Count { get; set; }
    }
}
