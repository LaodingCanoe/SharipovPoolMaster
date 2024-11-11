using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharipovFlourMaster
{

    internal class DB_Class
    {
        public string connectionString = "Data Source=localhost;Database=SharipovPolMaster;User Id=Inventory_Admin;Password=Admin007;";



        public List<Partner> LoadData()
        {
            var data = new List<Partner>();
            var saleData = CountProd(); // Get sale data once
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = @"
            SELECT p.[ИД], f.[Тип партнера], [Наименование], [Фамилия], [Имя], [Отчество], [Электронная почта],
                   [Телефон], [Индекс], [Область], [Город], [Улица], [Дом], [ИНН], [Рейтинг], 
                   [Форма организации] as form
            FROM [Партнеры] as p
            JOIN [Форма организации] as f on f.ИД = p.[Форма организации]";

                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    var partnerId = Convert.ToInt32(reader["ИД"]);
                    var partnerSale = saleData.FirstOrDefault(s => s.ID == partnerId); // Find the sale data for the current partner

                    var componentItem = new Partner
                    {
                        Name = reader["Наименование"].ToString(),
                        ID = partnerId,
                        Type = reader["Тип партнера"].ToString(),
                        Director = $"{reader["Фамилия"]} {reader["Имя"]} {reader["Отчество"]}",
                        Rating = Convert.ToInt32(reader["Рейтинг"]),
                        Phone = Convert.ToInt64(reader["Телефон"]),
                        Email = reader["Электронная почта"].ToString(),
                        ProdCount = partnerSale?.Count ?? 0, // If no sale data found, set to 0
                        Sale = PartnerSales(partnerSale?.Count ?? 0), // Same here, use count from saleData
                        Index = Convert.ToInt32(reader["Индекс"]),
                        Oblost = reader["Область"].ToString(),
                        City = reader["Город"].ToString(),
                        Street = reader["Улица"].ToString(),
                        House = reader["Дом"].ToString(),
                        INN = reader["ИНН"].ToString(),
                        TypeID = Convert.ToInt32(reader["form"])
                    };

                    data.Add(componentItem);
                }
            }
            return data;
        }

        public void InsertPartner(Partner partner)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = @"
                INSERT INTO [Партнеры] 
                ([Наименование], [Фамилия], [Имя], [Отчество], [Электронная почта], [Телефон], [Индекс], [Область], 
                [Город], [Улица], [Дом], [ИНН], [Рейтинг], [Форма организации])
                VALUES 
                (@Name, @DirectorLastName, @DirectorFirstName, @DirectorMiddleName, @Email, @Phone, @Index, @Region, 
                @City, @Street, @House, @INN, @Rating, @FormTypeID)";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Name", partner.Name);
                command.Parameters.AddWithValue("@DirectorLastName", partner.Director.Split(' ')[0]);
                command.Parameters.AddWithValue("@DirectorFirstName", partner.Director.Split(' ')[1]);
                command.Parameters.AddWithValue("@DirectorMiddleName", partner.Director.Split(' ').Length > 2 ? partner.Director.Split(' ')[2] : (object)DBNull.Value);
                command.Parameters.AddWithValue("@Email", partner.Email);
                command.Parameters.AddWithValue("@Phone", partner.Phone);
                command.Parameters.AddWithValue("@Index", partner.Index);
                command.Parameters.AddWithValue("@Region", partner.Oblost);
                command.Parameters.AddWithValue("@City", partner.City);
                command.Parameters.AddWithValue("@Street", partner.Street);
                command.Parameters.AddWithValue("@House", partner.House);
                command.Parameters.AddWithValue("@INN", partner.INN);
                command.Parameters.AddWithValue("@Rating", partner.Rating);
                command.Parameters.AddWithValue("@FormTypeID", partner.TypeID);

                command.ExecuteNonQuery();
            }
        }

        // Method to update an existing partner
        public void UpdatePartner(Partner partner)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = @"
                UPDATE [Партнеры]
                SET [Наименование] = @Name,
                    [Фамилия] = @DirectorLastName,
                    [Имя] = @DirectorFirstName,
                    [Отчество] = @DirectorMiddleName,
                    [Электронная почта] = @Email,
                    [Телефон] = @Phone,
                    [Индекс] = @Index,
                    [Область] = @Region,
                    [Город] = @City,
                    [Улица] = @Street,
                    [Дом] = @House,
                    [ИНН] = @INN,
                    [Рейтинг] = @Rating,
                    [Форма организации] = @FormTypeID
                WHERE [ИД] = @ID";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@ID", partner.ID);
                command.Parameters.AddWithValue("@Name", partner.Name);
                command.Parameters.AddWithValue("@DirectorLastName", partner.Director.Split(' ')[0]);
                command.Parameters.AddWithValue("@DirectorFirstName", partner.Director.Split(' ')[1]);
                command.Parameters.AddWithValue("@DirectorMiddleName", partner.Director.Split(' ').Length > 2 ? partner.Director.Split(' ')[2] : (object)DBNull.Value);
                command.Parameters.AddWithValue("@Email", partner.Email);
                command.Parameters.AddWithValue("@Phone", partner.Phone);
                command.Parameters.AddWithValue("@Index", partner.Index);
                command.Parameters.AddWithValue("@Region", partner.Oblost);
                command.Parameters.AddWithValue("@City", partner.City);
                command.Parameters.AddWithValue("@Street", partner.Street);
                command.Parameters.AddWithValue("@House", partner.House);
                command.Parameters.AddWithValue("@INN", partner.INN);
                command.Parameters.AddWithValue("@Rating", partner.Rating);
                command.Parameters.AddWithValue("@FormTypeID", partner.TypeID);

                command.ExecuteNonQuery();
            }
        }
        public List<OrganizationType> LoadType()
        {
            var data = new List<OrganizationType>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = @"
                    SELECT * FROM [Форма организации] ";

                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();
                var SaleData = CountProd();

                while (reader.Read())
                {
                    var componentItem = new OrganizationType
                    {
                        Name = reader["Тип партнера"].ToString(),
                        ID = Convert.ToInt32(reader["ИД"]),
                        
                    };
                    data.Add(componentItem);
                }
            }
            return data;
        }

        

        public List<PartnerSale> CountProd()
        {
            var data = new List<PartnerSale>();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = @"
                    SELECT Партнер, SUM([Количество продукции]) AS c FROM Заявки GROUP BY Партнер";

                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    var componentItem = new PartnerSale
                    {
                        ID = Convert.ToInt32(reader["Партнер"]),
                        Count = Convert.ToInt32(reader["c"]),

                    };
                    data.Add(componentItem);
                }
            }
            return data;
        }



        public class PartnerSale
        {
            public int ID { get; set; }
            public int Count { get; set; }
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
    }
    public class Partner
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
        public string Director { get; set; }
        public string Email { get; set; }
        public long Phone { get; set; }
        public int Rating { get; set; }
        public int ProdCount { get; set; }
        public int Sale { get; set; }
        public int Index { get; set; }
        public string Oblost { get; set; }
        public string City { get; set; }
        public string Street { get; set; }
        public string House { get; set; }
        public string INN { get; set; }
        public int TypeID { get; set; }

    }

    public class OrganizationType
    {
        public int ID { get; set; }
        public string Name { get; set; }
    }

}
