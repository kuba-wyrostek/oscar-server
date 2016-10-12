using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OscarServer.Helpers;

namespace OscarServer.Models
{
    public class MemberQuery : EntityQuery
    {
        public int? MemberID { get; set; }

        public override string ToString()
        {
            return "(0 = 0) " +
                (this.MemberID.HasValue ? " and MemberID = " + this.MemberID.ToString() : "");
        }
    }

    public class MemberCollection : EntityCollection<Member>
    {
        public MemberCollection(MemberQuery query = null)
            : base(query) { }
    }

    public class BaseMember : Entity
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Notes { get; set; }
    }

    public class Member : BaseMember
    {
        public const string EntityName = "Members";

        [IsKey]
        public int MemberID { get; private set; }

        public DateTime RegistrationDate { get; set; }        
    }
}