using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Reflection;
using System.Data.SqlClient;
using OscarServer.Helpers;

namespace OscarServer.Models
{
    public class EntityQuery
    {
        public override string ToString()
        {
            return "";
        }
    }

    public class EntityCollection<T> : IEnumerable<T>
        where T : Entity
    {
        protected List<T> items = new List<T>();
        protected EntityQuery query = new EntityQuery();

        public EntityCollection(EntityQuery query = null)
        {
            this.query = query;
            this.LoadCollection();
            DataContext.Context.RegisterCollection(this.GetEntityName(), this);
        }

        public T this[int index]
        {
            get
            {
                return this.items[index];
            }
        }

        public T Find(Predicate<T> predicate)
        {
            return this.items.Find(predicate);
        }

        public int Count
        {
            get
            {
                return this.items.Count;
            }
        }

        private void LoadCollection()
        {
            using (SqlConnection connection = DataContext.Context.GetConnection())
            {
                SqlCommand command = new SqlCommand(this.GetSelectCommand(), connection);
                SqlDataReader reader = command.ExecuteReader();
                object[] values = null;
                string[] columnNames = null;

                while (reader.Read())
                {
                    if (columnNames == null)
                    {
                        columnNames = this.GetColumnNames(reader);
                        values = new object[reader.FieldCount];
                    }

                    reader.GetValues(values);
                    T item = Activator.CreateInstance<T>();
                    item.Populate(values, this.GetEntityName(), columnNames);
                    this.items.Add(item);
                }

                reader.Close();
            }
        }

        protected virtual string GetSelectCommand()
        {
            return String.Format("select {0} from {1}{2}",
                String.Join(", ", typeof(T).GetProperties().ToList().FindAll(info => info.GetCustomAttribute<IgnoreAttribute>() == null).ConvertAll<string>(info => info.Name)),
                this.GetEntityName(),
                this.query != null ? " where " + this.query.ToString() : "");
        }

        protected string GetEntityName()
        {
            return typeof(T).GetField("EntityName", BindingFlags.Static | BindingFlags.Public).GetValue(null).ToString();
        }

        private string[] GetColumnNames(SqlDataReader reader)
        {
            string[] names = new string[reader.FieldCount];
            for (int i = 0; i < reader.FieldCount; i++)
                names[i] = reader.GetName(i);
            return names;
        }

        public IEnumerator<T> GetEnumerator()
        {
            return this.items.GetEnumerator();
        }

        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator()
        {
            return this.GetEnumerator();
        }
    }

    public class Entity
    {
        public enum FieldInclude { All, Keys, NonKeys };

        public void Populate(object[] row, string entityName, string[] columnName)
        {
            for (int i = 0; i < row.Length && i < columnName.Length; i++)
            {
                PropertyInfo info = this.GetType().GetProperty(columnName[i]);
                object value = row[i];

                if (value == DBNull.Value)
                    info.SetValue(this, null);
                else
                {
                    Type propertyType = Nullable.GetUnderlyingType(info.PropertyType) ?? info.PropertyType;
                    if (propertyType.IsEnum)
                        value = Enum.ToObject(propertyType, value);
                    info.SetValue(this, Convert.ChangeType(value, propertyType));
                }
            }
        }

        // this is VERY temporary solution: only works for single, integer key;
        // has no transaction scope; never use in production
        public void GenerateKey()
        {
            PropertyInfo keyField = this.GetFields(FieldInclude.Keys, false).First();
            if ((int)keyField.GetValue(this) == 0)
                keyField.SetValue(this, DataContext.Context.Scalar<int>(
                    String.Format("select isnull(max({0}), 0) + 1 from {1}",
                        keyField.Name,
                        this.GetEntityName()),
                    0));
        }

        public void Save()
        {
            using (SqlConnection connection = DataContext.Context.GetConnection())
            {
                SqlCommand command = new SqlCommand(this.GetMergeCommand(), connection);
                command.ExecuteNonQuery();
            }
        }

        public void CopyFrom(Entity source)
        {
            List<PropertyInfo> fields =
                this.GetType().IsSubclassOf(source.GetType())
                ? source.GetFields(FieldInclude.NonKeys, false)
                : this.GetFields(FieldInclude.NonKeys, false);

            fields.ForEach(info =>
                info.SetValue(this, info.GetValue(source)));
        }

        public List<PropertyInfo> GetFields(FieldInclude include, bool includeComputed)
        {
            return this.GetType().GetProperties().ToList().FindAll(info => info.GetCustomAttribute<IgnoreAttribute>() == null
                && (include != FieldInclude.Keys || info.GetCustomAttribute<IsKeyAttribute>() != null)
                && (include != FieldInclude.NonKeys || info.GetCustomAttribute<IsKeyAttribute>() == null)
                && (includeComputed || info.GetCustomAttribute<ComputedAttribute>() == null)); 
        }

        protected string GetEntityName()
        {
            return this.GetType().GetField("EntityName", BindingFlags.Static | BindingFlags.Public).GetValue(null).ToString();
        }

        protected virtual string GetMergeCommand()
        {
            string tableName = this.GetEntityName();

            return String.Format(@"merge {0} using (select {1}) as UpdateSource
                                       on {5}
                                   when matched then
                                       update set {2}
                                   when not matched then
                                       insert ({3}) values ({4});",
                tableName,
                String.Join(", ", this.GetFields(FieldInclude.All, false).ConvertAll<string>(info => this.SqlFormat(info.GetValue(this)) + " as " + info.Name)),
                String.Join(", ", this.GetFields(FieldInclude.NonKeys, false).ConvertAll<string>(info => tableName + "." + info.Name + " = UpdateSource." + info.Name)),
                String.Join(", ", this.GetFields(FieldInclude.All, false).ConvertAll<string>(info => info.Name)),
                String.Join(", ", this.GetFields(FieldInclude.All, false).ConvertAll<string>(info => this.SqlFormat(info.GetValue(this)))),
                String.Join(" and ", this.GetFields(FieldInclude.Keys, false).ConvertAll<string>(info => tableName + "." + info.Name + " = UpdateSource. " + info.Name)));
        }

        private string SqlFormat(object source)
        {
            if (source == null)
                return "null";
            else if (source is decimal || source is decimal?)
                return ((decimal)source).ToString("0.0#######").Replace(",", ".");
            else if (source is DateTime || source is DateTime?)
                return "'" + ((DateTime)source).ToString("yyyy-MM-dd HH\\:mm\\:ss") + "'";
            else if (source is int || source is int?)
                return ((int)source).ToString();
            else if (source is byte || source is byte? || (source.GetType().IsEnum && Enum.GetUnderlyingType(source.GetType()) == typeof(byte)))
                return ((byte)source).ToString();
            else if (source is string)
                return "'" + (source as string).Replace("'", "''") + "'";
            else if (source is bool || source is bool?)
                return (bool)source ? "1" : "0";
            else
                throw new FormatException();
        }
    }
}