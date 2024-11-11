using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace SharipovFlourMaster
{
    /// <summary>
    /// Логика взаимодействия для AddEditPage.xaml
    /// </summary>

    public partial class AddEditPage : Page
    {
        public List<OrganizationType> ComboData { get; set; }

        public Partner _current = new Partner();

        public AddEditPage(Partner Selected)
        {
            InitializeComponent();

            var db = new DB_Class();
            ComboData = db.LoadType();  // Load full OrganizationType objects (ID and Name)
            TypeCB.ItemsSource = ComboData.Select(x => x.Name);

            if (Selected != null)
            {
                _current = Selected;
                TypeCB.SelectedIndex = Selected.TypeID - 1;
            }
            DataContext = _current;


        }

        private void SaveBT_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            List<string> fio = DirectorTB.Text.Split(' ').ToList();

            if (string.IsNullOrWhiteSpace(_current.Name))
                errors.AppendLine("Укажите наименование Партнёра");
            if (!Regex.IsMatch(_current.Index.ToString(), @"^\d{6}$"))
                errors.AppendLine("Укажите корректный индекс (6 цифр)");

            if (string.IsNullOrWhiteSpace(_current.Oblost))
                errors.AppendLine("Укажите регион");
            if (string.IsNullOrWhiteSpace(_current.City))
                errors.AppendLine("Укажите город");
            if (string.IsNullOrWhiteSpace(_current.Street))
                errors.AppendLine("Укажите улицу");
            if (string.IsNullOrWhiteSpace(_current.House))
                errors.AppendLine("Укажите дом");
            if (string.IsNullOrWhiteSpace(_current.INN) ||
       !(_current.INN.Length == 10 || _current.INN.Length == 12) ||
       !_current.INN.All(char.IsDigit)) 
            {
                errors.AppendLine("Укажите корректный ИНН (10 или 12 цифр)");
            }

            if (fio.Count != 2 && fio.Count != 3)
                errors.AppendLine("Укажите ФИО директора");
            if (!Regex.IsMatch(_current.Phone.ToString(), @"^\d{10}$"))
                errors.AppendLine("Укажите корректный телефон (10 цифр)");

            if (string.IsNullOrWhiteSpace(_current.Email) || !IsValidEmail(_current.Email))
            {
                errors.AppendLine("Укажите корректный Email");
            }
            if (_current.Rating < 0 || _current.Rating.GetType() != typeof(int))
                errors.AppendLine("Неверный рейтинг партнера");
            if (TypeCB.SelectedItem == null)
                errors.AppendLine("Укажите форму организации");


            var db = new DB_Class();
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            var selectedType = ComboData.FirstOrDefault(x => x.Name == TypeCB.SelectedItem.ToString());
            if (selectedType != null)
            {
                _current.TypeID = selectedType.ID;  // Use the ID of the selected type, not the index
            }
            if (_current.ID == 0)
            {
                db.InsertPartner(_current);
            }
            else 
            {
                db.UpdatePartner(_current);
            }
            MessageBox.Show("Партнёр сохранён успешно!");
            MainClass.MainFrame.GoBack();
        }
        private bool IsValidEmail(string email)
        {
            // Regex for basic email validation: contains '@' and '.' with characters in between
            var emailRegex = new System.Text.RegularExpressions.Regex(@"^[^@]+@[^@]+\.[^@]+$");
            return emailRegex.IsMatch(email);
        }
    }

}
