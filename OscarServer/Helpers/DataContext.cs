using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using OscarServer.Models;
using System.Configuration;

namespace OscarServer.Helpers
{
    public class DataContext
    {
        [ThreadStatic] // this is fine for demonstration purposes only!
        private static DataContext _context;
        public static DataContext Context { get { return _context; } }

        Dictionary<string, object> collection = new Dictionary<string,object>();
        Dictionary<string, Type> typeReference = new Dictionary<string,Type>();

        private string customConnectionString = null;

        public static void CreateContext(string customConnectionString = null)
        {
            _context = new DataContext(customConnectionString);
        }

        private DataContext(string customConnectionString)
        {
            this.customConnectionString = customConnectionString;
        }

        public SqlConnection GetConnection()
        {
            SqlConnection connection = new SqlConnection(this.customConnectionString ?? ConfigurationManager.ConnectionStrings["Database"].ConnectionString);
            connection.Open();
            return connection;
        }

        public T Scalar<T>(string query, T defaultValue)
        {
            using (SqlConnection connection = this.GetConnection())
            {
                SqlCommand command = new SqlCommand(query, connection);
                object value = command.ExecuteScalar();
                return value == null ? defaultValue : (T)Convert.ChangeType(value, typeof(T));
            }
        }

        public void RegisterCollection<T>(string collectionName, EntityCollection<T> collection)
            where T : Entity
        {
            this.collection[collectionName] = collection;
            this.typeReference[collectionName] = typeof(T);
        }

        public EntityCollection<T> GetCollection<T>(string collectionName)
            where T : Entity
        {
            if (typeof(T) != this.typeReference[collectionName])
                throw new InvalidCastException();

            return (EntityCollection<T>)this.collection[collectionName];
        }
    }
}