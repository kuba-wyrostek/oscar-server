using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OscarServer.Helpers;
using OscarServer.Models;

namespace OscarServer.Models
{
    public class RentalQuery : EntityQuery
    {
        public int? MemberID { get; set; }
        public int? ItemID { get; set; }
        public int? RentalID { get; set; }

        public override string ToString()
        {
            return "(0 = 0)"
                + (this.MemberID.HasValue ? " and MemberID = " + this.MemberID.ToString() : "")
                + (this.ItemID.HasValue ? " and ItemID = " + this.ItemID.ToString() : "")
                + (this.RentalID.HasValue ? " and RentalID = " + this.RentalID.ToString() : "");
        }
    }

    public class RentalCollection : EntityCollection<Rental>
    {
        public RentalCollection(RentalQuery query = null)
            : base(query) { }

        protected override string GetSelectCommand()
        {
            return @"select
	            Rentals.*,
	            OverdueDays,
	            RentalPrice + OverdueDays * OverduePrice as TotalPrice
            from
              Rentals
	            inner join RentalModes
	            on Rentals.RentalModeID = RentalModes.RentalModeID
		            cross apply
		            (
			            select * from dbo.EffectivePricing(RentalDate) as EffectivePricing
			            where EffectivePricing.RentalModeID = Rentals.RentalModeID
		            ) as RentalPrice
			            cross apply
			            (
				            select max(R) as OverdueDays
				            from (values (0), (datediff(day, RentalDate, convert(date, getdate())) - MaximumDays)) as _X(R)
			            ) as _Y" +
                (this.query != null
                ? " where " + this.query.ToString()
                : "");
        }
    }

    public class BaseRental : Entity
    {
        public int ItemID { get; set; }
        public int MemberID { get; set; }
        public Rental.State RentalState { get; set; }
        public Rental.State? ReturnState { get; set; }
    }

    public class Rental : BaseRental
    {
        public const string EntityName = "Rentals";

        public enum State : byte {
            S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5
        }

        [IsKey]
        public int RentalID { get; private set; }

        public int? RentalModeID { get; set; }
        public DateTime RentalDate { get; set; }
        public DateTime? ReturnDate { get; set; }

        [Computed] 
        public int OverdueDays { get; private set; }
        [Computed] 
        public decimal TotalPrice { get; private set; }
    }
}