using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
    /// Логика взаимодействия для AddEdit.xaml
    /// </summary>
    public partial class AddEdit : Page
    {
        public int? partberID = null;
        public Partner data = new Partner();
        public AddEdit(Partner Selected)
        {
            InitializeComponent();
            /*
            var db = new DB_Class();
            //var data = db.LoadData();
            AddEdit windows = new AddEdit(null);

            if (Selected != null)
            {
                DataContext = Selected;
            }
            else
            {
                DataContext = data;
            }*/
        }
    }
}
