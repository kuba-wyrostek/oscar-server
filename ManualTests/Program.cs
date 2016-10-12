using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OscarServer.Helpers;
using OscarServer.Models;

namespace ManualTests
{
    class Program
    {
        static void Main(string[] args)
        {
            DataContext.CreateContext("Data Source=SQL2014;Initial Catalog=OscarDB;Integrated Security=True");
            MemberCollection members = new MemberCollection(new MemberQuery { MemberID = 7 });

            for (int i = 0; i < members.Count; i++)
            {
                Console.WriteLine(members[i].FirstName);
            }

            IList<System.Reflection.PropertyInfo> all = members[0].GetFields(Entity.FieldInclude.All, true);
            IList<System.Reflection.PropertyInfo> keys = members[0].GetFields(Entity.FieldInclude.Keys, true);
            IList<System.Reflection.PropertyInfo> nonkeys = members[0].GetFields(Entity.FieldInclude.NonKeys, true);

            Member member = members.Find(m => m.MemberID == 7);
            member.Notes = "Always leaves mess.";
            member.Save();

            new Member() {
                FirstName = "Jack",
                LastName = "Appleseed",
                RegistrationDate = DateTime.Now,
                Notes = ""
            }.Save();

            Console.ReadLine();
        }
    }
}
