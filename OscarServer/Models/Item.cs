using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OscarServer.Helpers;
using OscarServer.Models;

namespace OscarServer.Models
{
    public class ItemQuery : EntityQuery
    {
        public int? ItemID { get; set; }
        public int? MovieID { get; set; }
        public bool? Withdrawn { get; set; }

        public override string ToString()
        {
            return "(0 = 0)"
                + (this.MovieID.HasValue ? " and MovieID = " + this.MovieID.ToString() : "")
                + (this.ItemID.HasValue ? " and ItemID = " + this.ItemID.ToString() : "")
                + (this.Withdrawn.HasValue ? " and Withdrawn = " + (this.Withdrawn.Value ? "1" : "0") : "");
        }
    }

    public class ItemCollection : EntityCollection<Item>
    {
        public ItemCollection(ItemQuery query = null)
            : base(query) { }
    }

    public class Item : Entity
    {
        public const string EntityName = "Items";

        [IsKey]
        public int ItemID { get; private set; }

        public int MovieID { get; set; }
        public DateTime PurchaseDate { get; set; }
        public string BarCode { get; set; }
        public bool Withdrawn { get; set; }
    }
}